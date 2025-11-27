Report 50161 "Sales Line Batch-Outstanding"
{
    ProcessingOnly = true;
    ApplicationArea = All;

    dataset
    {
        dataitem("Sales Line"; "Sales Line")
        {
            DataItemTableView = sorting("Document Type", "Document No.", "Line No.")order(ascending);

            column(ReportForNavId_1170000000;1170000000)
            {
            }
            trigger OnAfterGetRecord()
            begin
                if "Outstanding Qty. (Base)" <> "Outstanding Quantity" then begin
                    if "Qty. per Unit of Measure" = 1 then begin
                        "Outstanding Qty. (Base)":="Outstanding Quantity";
                        Modify;
                    end;
                end
                else
                    CurrReport.Skip;
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
