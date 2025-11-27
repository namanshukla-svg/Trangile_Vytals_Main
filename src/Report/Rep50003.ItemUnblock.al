Report 50003 "Item Unblock"
{
    DefaultLayout = RDLC;
    ProcessingOnly = true;
    // RDLCLayout = './Layouts/Item Unblock.rdl';
    Permissions = TableData "Item Ledger Entry"=m;
    UsageCategory = ReportsandAnalysis;
    ApplicationArea = all;

    dataset
    {
        dataitem("Item Ledger Entry"; "Item Ledger Entry")
        {
            DataItemTableView = sorting("Entry No.")where(Open=filter(true), Positive=filter(true));
            RequestFilterFields = "Lot No.";

            column(ReportForNavId_1000000000;1000000000)
            {
            }
            trigger OnAfterGetRecord()
            begin
                "Item Ledger Entry"."Lot Blocked":=false;
                "Item Ledger Entry"."Unblock Date":=Today;
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
}
