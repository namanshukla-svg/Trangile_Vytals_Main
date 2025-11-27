Report 50000 "Item Block"
{
    DefaultLayout = RDLC;
    // RDLCLayout = './Layouts/Item Block.rdl';
    ProcessingOnly = true;
    Permissions = TableData "Item Ledger Entry"=m;
    ApplicationArea = all;
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem("Item Ledger Entry"; "Item Ledger Entry")
        {
            DataItemTableView = sorting("Entry No.")where(Open=filter(true), Positive=filter(true));
            RequestFilterFields = "Item No.";

            column(ReportForNavId_1000000000;1000000000)
            {
            }
            trigger OnAfterGetRecord()
            begin
                if "Item Ledger Entry"."Unblock Date" = 0D then begin
                    if Today - "Item Ledger Entry"."Posting Date" > 90 then begin
                        "Item Ledger Entry"."Lot Blocked":=true;
                        Modify;
                    end;
                end
                else
                begin
                    if Today - "Item Ledger Entry"."Unblock Date" > 90 then begin
                        "Item Ledger Entry"."Lot Blocked":=true;
                        Modify;
                    end;
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
}
