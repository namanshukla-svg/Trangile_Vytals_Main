codeunit 50147 "SSD User Setup Management"
{
    /// <summary>
    /// GetRespCenterFilter.
    /// </summary>
    /// <returns>Return value of type Code[10].</returns>
    var CompanyInfomation: Record "Company Information";
    UserSetup: Record "User Setup";
    UserRespCenter: Code[10];
    procedure GetRespCenterFilter(): Code[10]begin
        CompanyInfomation.Get();
        UserRespCenter:=CompanyInfomation."Responsibility Center";
        IF(UserSetup.GET(UserId))THEN IF UserSetup."Responsibility Center" <> '' THEN UserRespCenter:=UserSetup."Responsibility Center";
        EXIT(UserRespCenter);
    end;
}
