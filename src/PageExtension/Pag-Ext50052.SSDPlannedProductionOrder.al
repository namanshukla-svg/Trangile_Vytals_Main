PageExtension 50052 "SSD Planned Production Order" extends "Planned Production Order"
{
    layout
    {
        addafter("Last Date Modified")
        {
            field("No. of Archived Version"; Rec."No. of Archived Version")
            {
                ApplicationArea = All;
                Editable = false;
            }
            field("Order Created from MRP"; Rec."Order Created from MRP")
            {
                ApplicationArea = All;
                Editable = false;
            }
        }
    }
}
