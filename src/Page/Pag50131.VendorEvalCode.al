Page 50131 "Vendor Eval. Code"
{
    Caption = 'Vendor Eval. Code';
    PageType = List;
    SourceTable = "SSD Vendor Eval. Code";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                field("Code"; Rec.Code)
                {
                    ApplicationArea = All;
                }
                field(Concept; Rec.Concept)
                {
                    ApplicationArea = All;
                }
                field("Value 1"; Rec."Value 1")
                {
                    ApplicationArea = All;
                }
                field("Value 2"; Rec."Value 2")
                {
                    ApplicationArea = All;
                }
                field("Value 3"; Rec."Value 3")
                {
                    ApplicationArea = All;
                }
                field("Rating Weight"; Rec."Rating Weight")
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
    end;
    trigger OnOpenPage()
    begin
    // if UserMgt.GetRespCenterFilter() <> '' then begin
    //     Rec.FilterGroup(2);
    //     Rec.SetRange("Responsibility Center", UserMgt.GetRespCenterFilter);
    //     Rec.FilterGroup(0);
    // end;
    end;
    var UserMgt: Codeunit "SSD User Setup Management";
}
