Report 50251 PurchaseLine
{
    Permissions = TableData "Purchase Line"=rim;
    ProcessingOnly = true;
    UsageCategory = ReportsandAnalysis;
    ApplicationArea = all;

    dataset
    {
        dataitem("Purchase Line"; "Purchase Line")
        {
            DataItemTableView = where("Short Closed"=filter(true));

            column(ReportForNavId_1000000000;1000000000)
            {
            }
            trigger OnAfterGetRecord()
            begin
                "Purchase Line"."Outstanding Quantity":=0;
                //"Purchase Line"."Short Closed" := FALSE;
                "Purchase Line".Modify;
            end;
            trigger OnPostDataItem()
            begin
                Message('Done');
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
