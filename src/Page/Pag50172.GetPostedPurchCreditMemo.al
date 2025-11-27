Page 50172 "Get Posted Purch. Credit Memo"
{
    PageType = List;
    SourceTable = "Purch. Cr. Memo Hdr.";
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
                field("Pay-to Vendor No."; Rec."Pay-to Vendor No.")
                {
                    ApplicationArea = All;
                }
                field("Pay-to Name"; Rec."Pay-to Name")
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
        LPurchCrMemoLine: Record "Purch. Cr. Memo Line";
        LItem: Record Item;
        TotGrossWT: Decimal;
        TotNetWT: Decimal;
    begin
        GatePassLine.SetRange("No.", "GatePassNo.");
        if GatePassLine.FindLast then "LineNo.":=GatePassLine."Line No."
        else
            "LineNo.":=0;
        CurrPage.SetSelectionFilter(Rec);
        if Rec.Find('-')then repeat //Alle-HB-15oct15 START
                LPurchCrMemoLine.Reset;
                LPurchCrMemoLine.SetRange("Document No.", Rec."No.");
                if LPurchCrMemoLine.FindSet then repeat if LItem.Get(LPurchCrMemoLine."No.")then begin
                            TotNetWT+=(LItem."Net Weight") * (LPurchCrMemoLine.Quantity);
                            TotGrossWT+=(LItem."Gross Weight") * (LPurchCrMemoLine.Quantity);
                        end;
                    until LPurchCrMemoLine.Next = 0;
                //Alle-HB-15oct15 STOP
                //SSDU Rec.CalcFields("Amount to Vendor");
                "LineNo."+=10000;
                GatePassLine.Init;
                GatePassLine."No.":="GatePassNo.";
                GatePassLine."Line No.":="LineNo.";
                GatePassLine."Invoice No.":=Rec."No.";
                GatePassLine."Invoice Date":=Rec."Posting Date";
                GatePassLine."Customer No.":=Rec."Pay-to Vendor No.";
                GatePassLine."Customer Name":=Rec."Pay-to Name";
                //SSDU GatePassLine."Invoice Amount" := "Amount to Vendor";
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
                GatePassLine."Net Wt.":=TotNetWT; //Alle-MA030913 TotalNetWeight Alle-HB-15oct15
                GatePassLine."Gross Wt.":=TotGrossWT; //Alle-MA030913 TotalGrossWeight Alle-HB-15oct15
                GatePassLine."No. Of Cartons":=NoofCarton; //Alle-MA030913
                GatePassLine.Insert;
            until Rec.Next = 0;
    end;
}
