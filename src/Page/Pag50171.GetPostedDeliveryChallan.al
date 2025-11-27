Page 50171 "Get Posted Delivery Challan"
{
    PageType = List;
    SourceTable = "Delivery Challan Header";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Vendor Name"; Rec."Vendor Name")
                {
                    ApplicationArea = All;
                }
                field("Vehical No."; Rec."Vehical No.")
                {
                    ApplicationArea = All;
                }
                field("No."; Rec."No.")
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
    procedure SetValue("GPassNo.": Code[20])
    begin
        "GatePassNo.":="GPassNo.";
    end;
    procedure SelectLines()
    var
        LDeliveryChallanLine: Record "Delivery Challan Line";
        LItem: Record Item;
        TotNetWT: Decimal;
        TotGrossWT: Decimal;
    begin
        GatePassLine.SetRange("No.", "GatePassNo.");
        if GatePassLine.FindLast then "LineNo.":=GatePassLine."Line No."
        else
            "LineNo.":=0;
        CurrPage.SetSelectionFilter(Rec);
        if Rec.Find('-')then repeat //Alle-HB-15oct15 START
                TotNetWT:=0;
                TotGrossWT:=0;
                LDeliveryChallanLine.Reset;
                LDeliveryChallanLine.SetRange("Delivery Challan No.", Rec."No.");
                if LDeliveryChallanLine.FindSet then repeat if LItem.Get(LDeliveryChallanLine."Item No.")then begin
                            TotNetWT+=((LItem."Net Weight") * (LDeliveryChallanLine.Quantity));
                            TotGrossWT+=((LItem."Gross Weight") * (LDeliveryChallanLine.Quantity));
                        end;
                    until LDeliveryChallanLine.Next = 0;
                //Alle-HB-15oct15 STOP
                "LineNo."+=10000;
                GatePassLine.Init;
                GatePassLine."No.":="GatePassNo.";
                GatePassLine."Line No.":="LineNo.";
                GatePassLine."Invoice No.":=Rec."No.";
                GatePassLine."Invoice Date":=Rec."Posting Date";
                GatePassLine."Customer No.":=Rec."Vendor No.";
                GatePassLine."Customer Name":=Rec."Vendor Name";
                //    GatePassLine."Invoice Amount":="Freight Amount";
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
