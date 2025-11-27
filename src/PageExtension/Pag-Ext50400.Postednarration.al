pageextension 50400 Postednarration extends "Posted Narration"
{
    Editable = true;
    layout
    {
        // Add changes to page layout here
    }

    actions
    {
        // Add changes to page actions here
    }

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        UserSetup.Get(UserId);
        if UserSetup."SSD Insert Allowed Narration" then
            Rec.Access := true
        else
            Error('You are not Authorized to insert record.');
    end;

    trigger OnModifyRecord(): Boolean
    begin
        UserSetup.Get(UserId);
        if (Rec.Access = false) or (UserSetup."SSD Insert Allowed Narration" = false) then
            Error('You are not Authorized to modify record.');
    end;

    trigger OnDeleteRecord(): Boolean
    begin
        Error('You are not Authorized to delete record');
    end;

    var
        UserSetup: Record "User Setup";
}