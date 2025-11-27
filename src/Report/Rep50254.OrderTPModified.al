Report 50254 "OrderTP Modified"
{
    ProcessingOnly = true;
    ApplicationArea = All;

    dataset
    {
        dataitem(Item; Item)
        {
            DataItemTableView = sorting("No.");
            RequestFilterFields = "No.";

            column(ReportForNavId_1000000000;1000000000)
            {
            }
            trigger OnAfterGetRecord()
            begin
                Item.Validate("Order Tracking Policy", Item."order tracking policy"::None);
                Item.Modify;
            end;
            trigger OnPostDataItem()
            begin
                Message('Updated Successfully');
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
