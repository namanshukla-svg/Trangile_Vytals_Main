report 50222 "Update Outstanding Qty"
{
    // ApplicationArea = All;
    Caption = 'Update Outstanding Qty';
    UsageCategory = ReportsAndAnalysis;
    ProcessingOnly = true;
    ApplicationArea = All;

    dataset
    {
        dataitem(PurchaseLine; "Purchase Line")
        {
            DataItemTableView = WHERE("Document Type" = FILTER(Order), "Short Closed" = FILTER(true));

            trigger OnAfterGetRecord()
            begin
                Validate("Outstanding Quantity", 0);
                Validate("Outstanding Qty. (Base)", 0);
                Modify()
            end;
        }
    }
    requestpage
    {
        layout
        {
            area(content)
            {
                group(GroupName)
                {
                }
            }
        }
        actions
        {
            area(processing)
            {
            }
        }
    }
}
