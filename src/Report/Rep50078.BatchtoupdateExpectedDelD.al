Report 50078 "Batch to update Expected Del D"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Batch to update Expected Del D.rdl';
    Permissions = TableData "Sales Invoice Header"=rm;
    UsageCategory = ReportsandAnalysis;
    ApplicationArea = all;

    dataset
    {
        dataitem("Sales Invoice Header"; "Sales Invoice Header")
        {
            DataItemTableView = sorting("Posting Date");
            RequestFilterFields = "Posting Date", "No.";

            column(ReportForNavId_5581;5581)
            {
            }
            trigger OnAfterGetRecord()
            begin
                Cust.Reset;
                Cust.Get("Sales Invoice Header"."Sell-to Customer No.");
                if Format(Cust."Shipping Time") <> '' then begin
                    "Sales Invoice Header"."Expected Delivery Date":=CalcDate(Cust."Shipping Time", "Sales Invoice Header"."Posting Date");
                    "Sales Invoice Header".Modify;
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
    var Cust: Record Customer;
}
