pageextension 50134 "Posted Whse. Receipt Subform" extends "Posted Whse. Receipt Subform"
{
    layout
    {
        addafter("Unit of Measure Code")
        {
            field("Direct Unit Cost"; Rec."Direct Unit Cost")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Direct Unit Cost field.', Comment = '%';
            }
        }
    }
}
