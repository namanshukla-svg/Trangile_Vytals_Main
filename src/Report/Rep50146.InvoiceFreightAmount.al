Report 50146 "Invoice Freight Amount"
{
    Permissions = TableData "Sales Invoice Header"=rm;
    ProcessingOnly = true;
    UsageCategory = ReportsandAnalysis;
    ApplicationArea = All;

    dataset
    {
        dataitem("Invoice Frieght Amount"; "SSD Invoice Frieght Amount")
        {
            DataItemTableView = sorting("Invoice No.")order(ascending)where(Validate=filter(true), "Freight Amount Volume Mark"=filter(true));
            RequestFilterFields = "Invoice No.";

            column(ReportForNavId_1000000000;1000000000)
            {
            }
            trigger OnAfterGetRecord()
            begin
                if SalesInvoiceHeader.Get("Invoice No.")then begin
                    if SalesInvoiceHeader."Firm Freight" then exit;
                    SalesInvoiceHeader.Validate("Freight Amount", "Frieght Amount");
                    SalesInvoiceHeader.Modify;
                    Validate:=false;
                    Modify;
                end;
            end;
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
    trigger OnPostReport()
    begin
        Message('Updated Successfully');
    end;
    var SalesInvoiceHeader: Record "Sales Invoice Header";
}
