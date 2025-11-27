Page 50070 "Get Posted Sales Invoices"
{
    PageType = List;
    SourceTable = "Sales Invoice Header";
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
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = All;
                }
                field("Sell-to Customer No."; Rec."Sell-to Customer No.")
                {
                    ApplicationArea = All;
                }
                field("Sell-to Customer Name"; Rec."Sell-to Customer Name")
                {
                    ApplicationArea = All;
                }
                field("Sell-to City"; Rec."Sell-to City")
                {
                    ApplicationArea = All;
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = All;
                }
            }
        }
    }
    actions
    {
    }
    trigger OnOpenPage()
    begin
        if UserMgt.GetSalesFilter() <> '' then begin
            Rec.FilterGroup(2);
            Rec.SetRange("Responsibility Center", UserMgt.GetSalesFilter());
            Rec.FilterGroup(0);
        end;
    end;
    trigger OnQueryClosePage(CloseAction: action): Boolean begin
        if CloseAction in[Action::OK, Action::LookupOK]then SelectLines;
    end;
    var "GatePassNo.": Code[20];
    GatePassLine: Record "SSD Gate Pass Line";
    "LineNo.": Integer;
    UserMgt: Codeunit "User Setup Management";
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
        SalesInvoiceLine: Record "Sales Invoice Line";
        TotalBox: Integer;
        TotalGrossWT: Decimal;
        TotalNetWT: Decimal;
        DespLine: Record "Sales Line";
    begin
        GatePassLine.SetRange("No.", "GatePassNo.");
        if GatePassLine.FindLast then "LineNo.":=GatePassLine."Line No."
        else
            "LineNo.":=0;
        CurrPage.SetSelectionFilter(Rec);
        if Rec.Find('-')then repeat //Alle-HB-14OCT15 START
                TotalBox:=0;
                TotalGrossWT:=0;
                TotalNetWT:=0;
                SalesInvoiceLine.Reset;
                SalesInvoiceLine.SetRange("Document No.", Rec."No.");
                if SalesInvoiceLine.FindSet then repeat //TotalNetWT+= SalesInvoiceLine."Net Weight";
                        TotalNetWT+=SalesInvoiceLine."Actual Wt";
                        if DespLine.Get(DespLine."document type"::Order, SalesInvoiceLine."Despatch Slip No.", SalesInvoiceLine."Despatch Slip Line No.")then begin
                            DespLine.CalcFields("No of Pack");
                            DespLine.CalcFields("Gross Wt");
                            TotalBox+=DespLine."No of Pack";
                            TotalGrossWT+=DespLine."Gross Wt";
                        end;
                    until SalesInvoiceLine.Next = 0;
                //Alle-HB-14OCT15 END
                //SSDU Rec.CalcFields("Amount to Customer");
                "LineNo."+=10000;
                GatePassLine.Init;
                GatePassLine."No.":="GatePassNo.";
                GatePassLine."Line No.":="LineNo.";
                GatePassLine."Invoice No.":=Rec."No.";
                GatePassLine."Invoice Date":=Rec."Posting Date";
                GatePassLine."Customer No.":=Rec."Sell-to Customer No.";
                GatePassLine."Customer Name":=Rec."Sell-to Customer Name";
                //SSDU GatePassLine."Invoice Amount" := "Amount to Customer"; 
                GatePassLine.Remark:=Rec.Remarks;
                NoofCarton:=0;
                TotalNetWeight:=0;
                TotalGrossWeight:=0;
                //Alle-MA030913<<
                DispatchPackingLine.Reset;
                DispatchPackingLine.SetRange("Document No.", Rec."Pre-Assigned No.");
                if DispatchPackingLine.Find('-')then repeat NoofCarton+=1;
                        TotalGrossWeight+=DispatchPackingLine."Carton Gross Weight";
                        TotalNetWeight+=DispatchPackingLine."Carton Net Weight";
                    until DispatchPackingLine.Next = 0;
                //Alle-MA030913>>
                GatePassLine."Net Wt.":=TotalNetWT; //Alle-MA030913 TotalNetWeight       //Alle-HB13oct15
                GatePassLine."Gross Wt.":=TotalGrossWT; //Alle-MA030913 TotalGrossWeight //Alle-HB13oct15
                GatePassLine."No. Of Cartons":=TotalBox; //Alle-MA030913  NoofCarton    //Alle-HB13oct15
                GatePassLine.Insert;
            until Rec.Next = 0;
    end;
}
