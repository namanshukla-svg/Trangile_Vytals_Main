PageExtension 50001 "SSD Avg. Cost Calc. Overview" extends "Average Cost Calc. Overview"
{
    layout
    {
        addafter(Type)
        {
            field("SSDEntry No."; Rec."Entry No.")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Entry No. field.';
            }
        }
    }
    var UserSetup: Record "User Setup";
    trigger OnOpenPage()
    begin
        UserSetup.Get(UserId);
        if not UserSetup."Avg. Cost Calc." then Error('You dont have permission to open this page for Avg. Cost Calc');
    end;
}
