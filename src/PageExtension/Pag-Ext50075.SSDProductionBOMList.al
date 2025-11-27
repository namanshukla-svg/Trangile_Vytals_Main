PageExtension 50075 "SSD Production BOM List" extends "Production BOM List"
{
    var UserSetup: Record "User Setup";
    trigger OnOpenPage()
    begin
        UserSetup.GET(USERID);
        IF not UserSetup."Bom & Routing" THEN ERROR('You dont have permission to open this page for Bom & Routing');
    end;
    trigger OnDeleteRecord(): Boolean var
        UserSetup: Record "User Setup";
    begin
        UserSetup.Get(UserId);
        if not UserSetup."SSD Delete Administrator" then Error('You are not authorise to delete this record');
    end;
}
