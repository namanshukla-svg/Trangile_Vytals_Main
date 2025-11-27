pageextension 50015 "SSD Sales Return Order List" extends "Sales Return Order List"
{
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
