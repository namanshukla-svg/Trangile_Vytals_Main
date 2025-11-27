PageExtension 50053 "SSD Planned Production Orders" extends "Planned Production Orders"
{
    layout
    {
        addafter("Bin Code")
        {
            field("Order Created from MRP"; Rec."Order Created from MRP")
            {
                ApplicationArea = All;
            }
        }
    }
}
