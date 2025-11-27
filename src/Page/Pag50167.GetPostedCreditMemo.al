Page 50167 "Get Posted Credit Memo"
{
    PageType = List;
    SourceTable = "Sales Cr.Memo Header";
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
                field("Sell-to Customer No."; Rec."Sell-to Customer No.")
                {
                    ApplicationArea = All;
                }
                field("Sell-to Customer Name"; Rec."Sell-to Customer Name")
                {
                    ApplicationArea = All;
                }
                field("Ship-to City"; Rec."Ship-to City")
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
        LSalesCrMemoLine: Record "Sales Cr.Memo Line";
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
                LSalesCrMemoLine.Reset;
                LSalesCrMemoLine.SetRange("Document No.", Rec."No.");
                if LSalesCrMemoLine.FindSet then repeat if LItem.Get(LSalesCrMemoLine."No.")then begin
                            TotNetWT+=(LItem."Net Weight") * (LSalesCrMemoLine.Quantity);
                            TotGrossWT+=(LItem."Gross Weight") * (LSalesCrMemoLine.Quantity);
                        end;
                    until LSalesCrMemoLine.Next = 0;
                //Alle-HB-15oct15 STOP
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
                //GatePassLine.Remark := Remarks;
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
