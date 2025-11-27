report 50503 "SPO to Vendor"
{
    Caption = 'SPO to Vendor';
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = Word;
    WordLayout = './Layouts/SPOtoVendor.docx';
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
            column(CompInfo_Name; CompInfo.Name)
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
            column(Purchaser_Name; Purchaser.Name)
            {
            }
            column(Purchaser_EMail; Purchaser."E-Mail")
            {
            }
            column(Purchaser_PhoneNo; Purchaser."Phone No.")
            {
            }
            trigger OnAfterGetRecord()
            begin
                Purchaser.Get("Purchaser Code");
            end;
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
    Purchaser: Record "Salesperson/Purchaser";
}
