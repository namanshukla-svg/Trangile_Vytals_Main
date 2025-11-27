PageExtension 50100 "SSD Stockkeeping Unit List" extends "Stockkeeping Unit List"
{
    layout
    {
        addafter("Replenishment System")
        {
            field("Components at Location"; Rec."Components at Location")
            {
                ApplicationArea = All;
            }
        }
        addafter("Maximum Inventory")
        {
            field("Safety Lead Time"; Rec."Safety Lead Time")
            {
                ApplicationArea = All;
            }
            field("Safety Stock Quantity"; Rec."Safety Stock Quantity")
            {
                ApplicationArea = All;
            }
        }
    }
}
