Page 50144 "Setup Quality Sub-Template"
{
    AutoSplitKey = true;
    DelayedInsert = true;
    Editable = true;
    PageType = ListPart;
    SourceTable = "SSD Setup Quality Sub-Template";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Control1000000000)
            {
                field("Process / Operation No."; Rec."Process / Operation No.")
                {
                    ApplicationArea = All;
                }
                field("Process / Operation"; Rec."Process / Operation")
                {
                    ApplicationArea = All;
                }
                field("Sampling Template No."; Rec."Sampling Template No.")
                {
                    ApplicationArea = All;
                }
                field("Type Of Inspection"; Rec."Type Of Inspection")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
    actions
    {
    }
    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec."Responsibility Center":=UserMgt.GetRespCenterFilter;
        Rec."Template Type":=Rec."Template Type";
    end;
    trigger OnOpenPage()
    begin
        // if UserMgt.GetRespCenterFilter() <> '' then begin
        //     Rec.FilterGroup(2);
        //     Rec.SetRange("Responsibility Center", UserMgt.GetRespCenterFilter);
        //     Rec.FilterGroup(0);
        // end;
        Rec.FilterGroup(2);
        if Rec.GetFilter("Template Type") <> '' then CurrPage.Caption:=Rec.GetFilter("Template Type") + '-' + CurrPage.Caption;
        Rec.FilterGroup(0);
    end;
    var UserMgt: Codeunit "SSD User Setup Management";
}
