Report 50189 "Clear Remaining Amount"
{
    Permissions = TableData "Item Ledger Entry"=rimd;
    ProcessingOnly = true;
    ApplicationArea = All;

    dataset
    {
        dataitem("Item Ledger Entry"; "Item Ledger Entry")
        {
            DataItemTableView = sorting("Entry No.")order(ascending);

            column(ReportForNavId_1000000000;1000000000)
            {
            }
            trigger OnAfterGetRecord()
            begin
                if Confirm(ConfirmUpdate, false, "Entry No.", "Lot No.")then begin
                    Open:=false;
                    "Remaining Quantity":=0;
                    Modify;
                end
                else
                    Message('Not modified')end;
            trigger OnPreDataItem()
            begin
                SetFilter("Entry No.", '488108')end;
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
        Message('Process Completed');
    end;
    trigger OnPreReport()
    begin
        if UserId <> 'LMOHAN' then Error('You are not authorized to run the report');
    end;
    var ConfirmUpdate: label 'Are You really wants to modify the Entry number %1 with Lot Number %2.';
}
