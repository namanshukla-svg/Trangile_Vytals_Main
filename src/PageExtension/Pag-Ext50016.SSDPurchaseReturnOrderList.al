pageextension 50016 "SSD Purchase Return Order List" extends "Purchase Return Order List"
{
    layout
    {
        addfirst(Control1)
        {
            field("SSD Order Type"; Rec."SSD Order Type")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Order Type field.';
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
