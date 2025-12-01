Report 50253 "Update Remain Qty for Sclose"
{
    ProcessingOnly = true;
    ApplicationArea = All;

    dataset
    {
        dataitem("Sales Line"; "Sales Line")
        {
            DataItemTableView = where("Short Close" = const(true), "Outstanding Quantity" = filter(<> 0));

            column(ReportForNavId_1000000000; 1000000000)
            {
            }
            trigger OnAfterGetRecord()
            begin
                if "Sales Line"."Short Close" then begin
                    "Sales Line"."Outstanding Quantity" := 0;
                    "Sales Line"."Outstanding Qty. (Base)" := 0;
                    "Sales Line".Modify;
                end;
            end;

            trigger OnPostDataItem()
            begin
                Message('Updated');
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
