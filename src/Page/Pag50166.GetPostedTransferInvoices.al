Page 50166 "Get Posted Transfer Invoices"
{
    PageType = List;
    SourceTable = "Transfer Shipment Header";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                }
                field("Transfer-from Code"; Rec."Transfer-from Code")
                {
                    ApplicationArea = All;
                }
                field("Transfer-to Code"; Rec."Transfer-to Code")
                {
                    ApplicationArea = All;
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = All;
                }
                field("Transfer Order No."; Rec."Transfer Order No.")
                {
                    ApplicationArea = All;
                }
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                    ApplicationArea = All;
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
    actions
    {
    }
    trigger OnQueryClosePage(CloseAction: action): Boolean begin
        if CloseAction in[Action::OK, Action::LookupOK]then SelectLines;
    end;
    var "GatePassNo.": Code[20];
    GatePassLine: Record "SSD Gate Pass Line";
    "LineNo.": Integer;
    UserMgt: Codeunit "SSD User Setup Management";
    NoofCarton: Integer;
    TotalNetWeight: Decimal;
    TotalGrossWeight: Decimal;
    TransferShipmentLine: Record "Transfer Shipment Line";
    InvoiceAmnt: Decimal;
    DispatchPackingLine: Record "SSD Dispatch Packing Line";
    procedure SetValue("GPassNo.": Code[20])
    begin
        "GatePassNo.":="GPassNo.";
    end;
    procedure SelectLines()
    var
        LItem: Record Item;
        LTransferShipLine: Record "Transfer Shipment Line";
        TotNetWT: Decimal;
        TotGrossWT: Decimal;
    begin
        GatePassLine.SetRange("No.", "GatePassNo.");
        if GatePassLine.FindLast then "LineNo.":=GatePassLine."Line No."
        else
            "LineNo.":=0;
        CurrPage.SetSelectionFilter(Rec);
        if Rec.Find('-')then repeat TotNetWT:=0;
                TotGrossWT:=0;
                "LineNo."+=10000;
                GatePassLine.Init;
                GatePassLine."No.":="GatePassNo.";
                GatePassLine."Line No.":="LineNo.";
                GatePassLine."Invoice No.":=Rec."No.";
                GatePassLine."Invoice Date":=Rec."Posting Date";
                GatePassLine."Customer No.":=Rec."Transfer-to Code";
                GatePassLine."Customer Name":=Rec."Transfer-to Name";
                Clear(InvoiceAmnt);
                TransferShipmentLine.Reset;
                TransferShipmentLine.SetRange("Document No.", Rec."No.");
                if TransferShipmentLine.FindFirst then repeat InvoiceAmnt+=TransferShipmentLine.Amount;
                        //Alle-HB-15oct15 START
                        if LItem.Get(TransferShipmentLine."Item No.")then begin
                            TotNetWT+=(LItem."Net Weight") * (TransferShipmentLine.Quantity);
                            TotGrossWT+=(LItem."Gross Weight") * (TransferShipmentLine.Quantity);
                        end;
                    //Alle-HB-15oct15 STOP
                    until TransferShipmentLine.Next = 0;
                GatePassLine."Invoice Amount":=InvoiceAmnt;
                NoofCarton:=0;
                TotalNetWeight:=0;
                TotalGrossWeight:=0;
                //Alle-MA030913<<
                DispatchPackingLine.Reset;
                DispatchPackingLine.SetRange("Document No.", Rec."No.");
                if DispatchPackingLine.Find('-')then repeat NoofCarton+=1;
                        TotalGrossWeight+=DispatchPackingLine."Carton Gross Weight";
                        TotalNetWeight+=DispatchPackingLine."Carton Net Weight";
                    until DispatchPackingLine.Next = 0;
                //Alle-MA030913>>
                GatePassLine."Net Wt.":=TotNetWT; //Alle-MA030913 TotalNetWeight
                GatePassLine."Gross Wt.":=TotGrossWT; //Alle-MA030913 TotalGrossWeight
                GatePassLine."No. Of Cartons":=NoofCarton; //Alle-MA030913
                GatePassLine.Insert;
            until Rec.Next = 0;
    end;
}
