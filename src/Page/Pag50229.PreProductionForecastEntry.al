Page 50229 "Pre. Production Forecast Entry"
{
    PageType = List;
    SourceTable = "SSD Pre. Prod. Forecast Entry";
    SourceTableView = sorting("Month Date", "Item Code")order(ascending);
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Customer No."; Rec."Customer No.")
                {
                    ApplicationArea = All;
                }
                field("Item Code"; Rec."Item Code")
                {
                    ApplicationArea = All;
                }
                field("Minimum Stock Level"; Rec."Minimum Stock Level")
                {
                    ApplicationArea = All;
                }
                field("Item Description"; Rec."Item Description")
                {
                    ApplicationArea = All;
                }
                field("Item Description 2"; Rec."Item Description 2")
                {
                    ApplicationArea = All;
                }
                field("Item Description 3"; Rec."Item Description 3")
                {
                    ApplicationArea = All;
                }
                field("Customer Name"; Rec."Customer Name")
                {
                    ApplicationArea = All;
                }
                field("Month Date"; Rec."Month Date")
                {
                    ApplicationArea = All;
                }
                field("Forecast Qty"; Rec."Forecast Qty")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
    actions
    {
    }
}
