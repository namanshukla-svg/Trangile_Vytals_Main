Report 50234 "Dispatch Mail Send"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Dispatch Mail Send.rdl';
    Permissions = TableData "Sales Invoice Header"=rm;
    UsageCategory = ReportsandAnalysis;
    ApplicationArea = all;

    dataset
    {
        dataitem("Integer"; "Integer")
        {
            DataItemTableView = where(Number=filter(1));

            column(ReportForNavId_1000000000;1000000000)
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
    var SalesInvoiceHeader: Record "Sales Invoice Header";
    procedure SendMail(SIH: Record "Sales Invoice Header")
    begin
        SalesInvoiceHeader.Get(SIH."No.");
        SalesInvoiceHeader.ModifyDispatch(SalesInvoiceHeader);
    end;
}
