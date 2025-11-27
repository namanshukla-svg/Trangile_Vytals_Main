Report 50296 "Export Bank Transection Detail"
{
    ProcessingOnly = true;
    ApplicationArea = All;

    dataset
    {
        dataitem("Bank Account Ledger Entry"; "Bank Account Ledger Entry")
        {
            DataItemTableView = where("Bal. Account Type"=filter(Vendor));
            RequestFilterFields = "Posting Date", "Bank Account No.";

            column(ReportForNavId_1170000000;1170000000)
            {
            }
        }
    }
    requestpage
    {
        layout
        {
        }
        actions
        {
        }
    }
    labels
    {
    }
    var ExportToExcel: Boolean;
    ExcelBuf: Record "Excel Buffer" temporary;
    TempExcelBuffer: Record "Excel Buffer" temporary;
    RowNo: Integer;
    PostedNarration: Record "Posted Narration";
    VendorBankAccount: Record "Vendor Bank Account";
    BankAccount: Record "Bank Account";
    RecVendor: Record Vendor;
// PostedNarration.RESET;
// PostedNarration.SETRANGE("Transaction No.","Bank Account Ledger Entry"."Transaction No.");
// IF PostedNarration.FINDFIRST THEN
//  ExcelBuf.AddColumn(PostedNarration.Narration,FALSE,'',FALSE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Number);
}
