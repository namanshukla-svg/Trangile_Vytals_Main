report 50501 "SRN Creation"
{
    Caption = 'SRN Creation';
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = Word;
    WordLayout = './Layouts/SRNCreation.docx';
    ApplicationArea = All;

    dataset
    {
        dataitem(PurchaseHeader; "Purchase Header")
        {
            column(CompInfo_NewLogo1; CompInfo."New Logo1")
            {
            }
            column(CompInfo_Picture; CompInfo.Picture)
            {
            }
            column(No_PurchaseHeader; "No.")
            {
            }
            column(BuyfromVendorNo_PurchaseHeader; "Buy-from Vendor No.")
            {
            }
            column(BuyfromVendorName_PurchaseHeader; "Buy-from Vendor Name")
            {
            }
            column(AssignedUserID; AssignedUserName)
            {
            }
            column(CreatedByUserId; CreatorUserName)
            {
            }
            trigger OnAfterGetRecord()
            begin
                AssignedUserName:='';
                CreatorUserName:='';
                UserSetup.Get("Assigned User ID");
                AssignedUserName:=UserSetup.Name;
                UserSetup.Get(UserId);
                CreatorUserName:=UserSetup.Name;
            end;
        }
    }
    trigger OnPreReport()
    begin
        CompInfo.Get;
        CompInfo.CalcFields(Picture);
        CompInfo.CalcFields("New Logo1");
    end;
    var CompInfo: Record "Company Information";
    UserSetup: Record "User Setup";
    AssignedUserName: Text[50];
    CreatorUserName: Text[50];
}
