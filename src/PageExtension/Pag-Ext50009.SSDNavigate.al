pageextension 50009 "SSD Navigate" extends Navigate
{
    trigger OnOpenPage()
    var
        UserSetup: Record "User Setup";
    begin
        UserSetup.Get(UserId);
        if not UserSetup."HO Drilldown Permission" then error('You are not authourized to open this page.');
    end;
}
