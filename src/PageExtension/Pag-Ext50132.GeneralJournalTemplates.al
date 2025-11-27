pageextension 50132 "General Journal Templates" extends "General Journal Templates"
{
    layout
    {
        addafter("Copy to Posted Jnl. Lines")
        {
            field("Attachment Mandatory"; Rec."Attachment Mandatory")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Attachment Mandatory field.', Comment = '%';
            }
        }
    }
}
