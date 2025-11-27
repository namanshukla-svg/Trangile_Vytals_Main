Page 50178 "Item Budget Form"
{
    ApplicationArea = All;
    PageType = Worksheet;
    SourceTable = Item;
    UsageCategory = Tasks;

    layout
    {
        area(content)
        {
            group("Option Filter")
            {
                Caption = 'Option Filter';

                field("Date Filter"; Rec."Date Filter")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
            }
            field("Start Date"; StartDate)
            {
                ApplicationArea = All;
            }
            field("End Date"; EndDate)
            {
                ApplicationArea = All;

                trigger OnValidate()
                begin
                    if((StartDate <> 0D) and (EndDate <> 0D))then begin
                        Rec.SetRange("Date Filter", StartDate, EndDate);
                        CurrPage.Update;
                    end
                    else
                    begin
                        Rec.Reset;
                        CurrPage.Update;
                    end;
                end;
            }
            field(ItemCatFilter; ItemCatFilter)
            {
                ApplicationArea = All;
                Caption = 'Item Filter';

                trigger OnLookup(var Text: Text): Boolean begin
                    ItemCat.Reset;
                    if Page.RunModal(0, ItemCat) = Action::LookupOK then begin
                        Text:=ItemCat.Code;
                        exit(true);
                    end;
                end;
                trigger OnValidate()
                begin
                    CategoryFilter;
                    ItemCatFilterOnAfterValidate;
                end;
            }
            repeater(Control1000000000)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Description 2"; Rec."Description 2")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Procurement Type"; Rec."Procurement Type")
                {
                    ApplicationArea = All;
                }
                field("Base Unit of Measure"; Rec."Base Unit of Measure")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Item Category Code"; Rec."Item Category Code")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("For Tool Room"; Rec."For Tool Room")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Enabled = false;
                    Visible = false;
                }
                field("Total Purchase Volume FY'14-15"; Rec.TotalPurchVolume)
                {
                    ApplicationArea = All;
                    Caption = 'Total Purchase Volume FY''15-16';

                    trigger OnValidate()
                    begin
                        TotalPurchVolumeOnAfterValidat;
                    end;
                }
                field("Monthly Avg Purchase Volume FY 14-15"; MonthlyAvgPurchVolume)
                {
                    ApplicationArea = All;
                    Caption = 'Monthly Avg Purchase Volume FY 15-16';
                }
                field("Total  Purchased  Value FY'14-15"; Rec.TotalPurchValue)
                {
                    ApplicationArea = All;
                    Caption = 'Total  Purchased  Value FY''15-16';

                    trigger OnValidate()
                    begin
                        TotalPurchValueOnAfterValidate;
                    end;
                }
                field("Total Avg Unit Cost FY' 15-16"; Rec.AvgUnitCost13_14)
                {
                    ApplicationArea = All;
                    Caption = 'Target Avg Unit Cost FY'' 16-17';
                }
                field("Total Target Savings FY'15-16"; Rec.TotalTargetSavings)
                {
                    ApplicationArea = All;
                    Caption = 'Total Target Savings FY'' 16-17';

                    trigger OnValidate()
                    begin
                        TotalTargetSavingsOnAfterValid;
                    end;
                }
                field(TotalPurQty; Rec."Purchases (Qty.)")
                {
                    ApplicationArea = All;
                    Caption = 'Total Purchased Qty';
                }
                field(TotPurValue; Rec."Purchases (LCY)")
                {
                    ApplicationArea = All;
                    Caption = 'Total Purchase Value';
                }
                field("<Avg. Unit Cost 14_15>"; Rec."Avg. Unit Cost 14_15")
                {
                    ApplicationArea = All;
                    Caption = 'Avg. Unit Cost 15_16';
                }
                field("Avg.Unit Cost FY' 14-15"; "AvgUnit Cost")
                {
                    ApplicationArea = All;
                    Caption = 'Actual Avg.Unit Cost FY'' 16-17';
                    Visible = false;
                }
                field(DiffAvgCostTargetAvgCost; DiffAvgCostTargetAvgCost)
                {
                    ApplicationArea = All;
                    Caption = 'Difference between Avg Unit Cost vs Target Avg Cost';
                }
                field(Savings; Savings)
                {
                    ApplicationArea = All;
                    Caption = 'Savings ';
                }
                field("Replenishment System"; Rec."Replenishment System")
                {
                    ApplicationArea = All;
                }
                field("Cost Amount Actual"; Rec."Cost Amount Actual")
                {
                    ToolTip = 'Specifies the value of the Cost Amount Actual field.';
                }
            }
        }
    }
    actions
    {
    }
    trigger OnAfterGetRecord()
    begin
        Evaluate(DateFil, Format(Rec."Date Filter"));
        Clear(DiffAvgCostTargetAvgCost);
        Clear(Savings);
        //CLEAR("AvgUnit Cost");
        Clear(MonthlyAvgPurchVolume);
        if Rec.TotalPurchVolume <> 0 then MonthlyAvgPurchVolume:=Rec.TotalPurchVolume / 12;
        //IF TotalTargetSavings <>0 THEN
        //  "AvgUnit Cost" := "Purchases (Qty.)"/TotalTargetSavings;
        DiffAvgCostTargetAvgCost:=Rec.TotalPurchValue - Rec."Purchases (LCY)";
        //Savings := "AvgUnit Cost"*TotalTargetSavings;
        Savings:=Rec.AvgUnitCost13_14 * Rec.TotalTargetSavings;
    end;
    trigger OnOpenPage()
    begin
        CategoryFilter;
    end;
    var MonthlyAvgPurchVolume: Decimal;
    DiffAvgCostTargetAvgCost: Decimal;
    Savings: Decimal;
    "AvgUnit Cost": Decimal;
    ItemCat: Record "Item Category";
    ItemCatFilter: Text[30];
    DateFil: Date;
    StartDate: Date;
    EndDate: Date;
    procedure CategoryFilter()
    begin
        Rec.FilterGroup(2);
        Rec.SetFilter("Item Category Code", ItemCatFilter);
        ItemCatFilter:=Rec.GetFilter("Item Category Code");
        Rec.FilterGroup(0);
    end;
    local procedure TotalPurchVolumeOnAfterValidat()
    begin
        if xRec.TotalPurchVolume <> Rec.TotalPurchVolume then MonthlyAvgPurchVolume:=Rec.TotalPurchVolume / 12;
    end;
    local procedure TotalPurchValueOnAfterValidate()
    begin
        if xRec.TotalPurchValue <> Rec.TotalPurchValue then DiffAvgCostTargetAvgCost:=Rec.TotalPurchValue - Rec."Purchases (LCY)";
    end;
    local procedure TotalTargetSavingsOnAfterValid()
    begin
        if xRec.TotalTargetSavings <> Rec.TotalTargetSavings then if Rec.TotalTargetSavings <> 0 then begin
                //"AvgUnit Cost" := "Purchases (Qty.)"/TotalTargetSavings;
                //Savings := "AvgUnit Cost"*TotalTargetSavings;
                Savings:=Rec.AvgUnitCost13_14 * Rec.TotalTargetSavings;
            end
            else
            begin
                //"AvgUnit Cost" := 0;
                //Savings := "AvgUnit Cost"*TotalTargetSavings;
                Savings:=Rec.AvgUnitCost13_14 * Rec.TotalTargetSavings;
            end;
    end;
    local procedure ItemCatFilterOnAfterValidate()
    begin
    //CurrPage.UPDATE(FALSE);
    end;
}
