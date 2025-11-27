Report 50159 "Sales Line -- Batch Report"
{
    ProcessingOnly = true;
    ApplicationArea = All;

    dataset
    {
        dataitem("Sales Line"; "Sales Line")
        {
            DataItemTableView = sorting("Document Type", "Document No.", "Line No.")order(ascending)where("Outstanding Quantity"=filter(=0));

            column(ReportForNavId_1170000000;1170000000)
            {
            }
            trigger OnAfterGetRecord()
            begin
                if "Outstanding Qty. (Base)" <> 0 then begin
                    if "Qty. per Unit of Measure" = 1 then begin
                        "Outstanding Qty. (Base)":="Outstanding Quantity";
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
