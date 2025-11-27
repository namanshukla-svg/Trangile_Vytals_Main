pageextension 50013 "SSD Sales Return Order" extends "Sales Return Order"
{
    layout
    {
        addbefore(Status)
        {
            field("External Doc. Date"; Rec."External Doc. Date")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the External Doc. Date field.';
            }
            field("Type of Invoice"; Rec."Type of Invoice")
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
        modify("Post &Batch")
        {
            Visible = false;
        }
        modify("Post &Batch_Promoted")
        {
            Visible = false;
        }
        modify("Post and &Print")
        {
            Visible = false;
        }
        modify("Post and &Print_Promoted")
        {
            Visible = false;
        }
        modify(Post_Promoted)
        {
            Visible = false;
        }
    }
    trigger OnDeleteRecord(): Boolean var
        UserSetup: Record "User Setup";
    begin
        UserSetup.Get(UserId);
        if not UserSetup."SSD Delete Administrator" then Error('You are not authorise to delete this record');
    end;
}
