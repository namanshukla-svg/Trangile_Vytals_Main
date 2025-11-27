report 50504 "SPO Creation"
{
    Caption = 'SPO Creation';
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = Word;
    WordLayout = './Layouts/SPOCreation.docx';
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
            column(CreatedByUserId; CreationUserName)
            {
            }
            column(Valid_From; Format("Valid From"))
            {
            }
            column(Valid_To; Format("Valid To"))
            {
            }
            trigger OnAfterGetRecord()
            begin
                ApprovalEntry.Reset();
                ApprovalEntry.SetRange("Record ID to Approve", PurchaseHeader.RecordId);
                ApprovalEntry.SetRange(Status, ApprovalEntry.Status::Open);
                ApprovalEntry.SetRange("Related to Change", false);
                if ApprovalEntry.FindLast()then begin
                    if UserSetup.Get(ApprovalEntry."Approver ID")then AssignedUserName:=UserSetup.Name;
                    if UserSetup.Get(ApprovalEntry."Sender ID")then CreationUserName:=UserSetup.Name;
                end;
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
    ApprovalEntry: Record "Approval Entry";
    UserSetup: Record "User Setup";
    AssignedUserName: Text[50];
    CreationUserName: Text[50];
}
