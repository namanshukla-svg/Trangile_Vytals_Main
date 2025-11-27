Report 50287 "Firm Freight Update"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Firm Freight Update.rdl';
    Permissions = TableData "Sales Invoice Header"=rm;
    UsageCategory = ReportsandAnalysis;
    ApplicationArea = all;

    dataset
    {
        dataitem("Sales Invoice Header"; "Sales Invoice Header")
        {
            RequestFilterFields = "No.";

            column(ReportForNavId_1000000000;1000000000)
            {
            }
            trigger OnAfterGetRecord()
            begin
                "Firm Freight":=true;
                Modify;
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
    trigger OnPreReport()
    begin
        if "Sales Invoice Header".GetFilter("No.") = '' then Error('Please select the Document No. for firm freight Update');
    end;
}
