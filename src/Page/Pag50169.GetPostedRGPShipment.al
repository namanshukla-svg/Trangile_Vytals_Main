Page 50169 "Get Posted RGP Shipment"
{
    PageType = List;
    SourceTable = "SSD RGP Shipment Header";
    SourceTableView = where(NRGP=filter(false));
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
                field("Party No."; Rec."Party No.")
                {
                    ApplicationArea = All;
                }
                field("Party Name"; Rec."Party Name")
                {
                    ApplicationArea = All;
                }
                field("Party City"; Rec."Party City")
                {
                    ApplicationArea = All;
                }
                field("Freight Amount"; Rec."Freight Amount")
                {
                    ApplicationArea = All;
                }
                field("Pre-Assigned No."; Rec."Pre-Assigned No.")
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
    DispatchPackingLine: Record "SSD Dispatch Packing Line";
    RGPHeader: Record "SSD RGP Header";
    LineAmt: Decimal;
    procedure SetValue("GPassNo.": Code[20])
    begin
        "GatePassNo.":="GPassNo.";
    end;
    procedure SelectLines()
    var
        LRGPShipLine: Record "SSD RGP Shipment Line";
        LItem: Record Item;
        TotNetWT: Decimal;
        TotGrossWT: Decimal;
    begin
        RGPHeader.Get(Rec."Document Type", Rec."Pre-Assigned No.");
        GatePassLine.SetRange("No.", "GatePassNo.");
        if GatePassLine.FindLast then "LineNo.":=GatePassLine."Line No."
        else
            "LineNo.":=0;
        CurrPage.SetSelectionFilter(Rec);
        if Rec.Find('-')then repeat //Alle-HB-15oct15 START
                TotNetWT:=0;
                TotGrossWT:=0;
                LRGPShipLine.Reset;
                LRGPShipLine.SetRange("Document No.", Rec."No.");
                if LRGPShipLine.FindSet then repeat if LRGPShipLine.Type = LRGPShipLine.Type::Item then begin
                            if LItem.Get(LRGPShipLine."No.")then begin
                                TotNetWT+=((LItem."Net Weight") * (LRGPShipLine.Quantity));
                                TotGrossWT+=((LItem."Gross Weight") * (LRGPShipLine.Quantity));
                            end;
                        end;
                        LineAmt+=LRGPShipLine."Line Amount";
                    until LRGPShipLine.Next = 0;
                //Alle-HB-15oct15 STOP
                "LineNo."+=10000;
                GatePassLine.Init;
                GatePassLine."No.":="GatePassNo.";
                GatePassLine."Line No.":="LineNo.";
                GatePassLine."Invoice No.":=Rec."Pre-Assigned No.";
                GatePassLine."Invoice Date":=Rec."Posting Date";
                GatePassLine."Customer No.":=Rec."Party No.";
                GatePassLine."Customer Name":=Rec."Party Name";
                if LRGPShipLine.Type = LRGPShipLine.Type::Item then GatePassLine."Invoice Amount":=Rec."Freight Amount";
                if LRGPShipLine.Type = LRGPShipLine.Type::"Item Description" then GatePassLine."Invoice Amount":=LineAmt;
                GatePassLine.Remark:=RGPHeader."Receipt Remarks";
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
                GatePassLine."Net Wt.":=TotNetWT; //Alle-MA030913  TotalNetWeight
                GatePassLine."Gross Wt.":=TotGrossWT; //Alle-MA030913  TotalGrossWeight
                GatePassLine."No. Of Cartons":=NoofCarton; //Alle-MA030913
                GatePassLine.Insert;
            until Rec.Next = 0;
    end;
}
