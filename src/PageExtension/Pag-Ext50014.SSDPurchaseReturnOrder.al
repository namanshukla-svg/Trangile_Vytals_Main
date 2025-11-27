pageextension 50014 "SSD Purchase Return Order" extends "Purchase Return Order"
{
    layout
    {
        addbefore(Status)
        {
            field("Invoice Type Old"; Rec."Invoice Type Old")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Type of Invoice field.';
            }
        }
    }
    actions
    {
        modify(Post)
        {
            Visible = false;
        }
        modify(Post_Promoted)
        {
            Visible = false;
        }
    }
}
