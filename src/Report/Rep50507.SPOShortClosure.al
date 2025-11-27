report 50507 "SPO Short Closure"
{
    Caption = 'SPO Short Closure';
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = Word;
    WordLayout = './Layouts/SPOShortClosure.docx';
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
            column(AssignedUserID; "Assigned User ID")
            {
            }
            column(CreatedByUserId; "Created By User Id")
            {
            }
            column(Valid_From; "Valid From")
            {
            }
            column(Valid_To; "Valid To")
            {
            }
        }
    }
    requestpage
    {
        layout
        {
            area(content)
            {
                group(GroupName)
                {
                }
            }
        }
        actions
        {
            area(processing)
            {
            }
        }
    }
    trigger OnPreReport()
    begin
        CompInfo.Get;
        CompInfo.CalcFields(Picture);
        CompInfo.CalcFields("New Logo1");
    end;
    var CompInfo: Record "Company Information";
}
