Report 50097 "Item Updation-planing&Manufact"
{
    ProcessingOnly = true;
    ApplicationArea = All;

    dataset
    {
        dataitem(Item; Item)
        {
            DataItemTableView = sorting("No.");

            column(ReportForNavId_8129;8129)
            {
            }
            trigger OnAfterGetRecord()
            begin
                Item."Reordering Policy":=Item."reordering policy"::"Lot-for-Lot";
                Item."Include Inventory":=true;
                if CopyStr(Item."No.", 1, 2) = 'FG' then Item."Replenishment System":=Item."replenishment system"::"Prod. Order"
                else
                    Item."Replenishment System":=Item."replenishment system"::Purchase;
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
