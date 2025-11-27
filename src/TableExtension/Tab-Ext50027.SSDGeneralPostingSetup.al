TableExtension 50027 "SSD General Posting Setup" extends "General Posting Setup"
{
    fields
    {
    }
    trigger OnBeforeModify()
    begin
        IF UserSetupL.GET(USERID)THEN IF NOT UserSetupL."Master Editing Permission" THEN ERROR(TextLocal50001);
    end;
    var UserSetupL: Record "User Setup";
    TextLocal50001: Label 'You don''t have editing permission to modify this. Contact System Administrator.';
}
