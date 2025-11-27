PageExtension 50069 "SSD Posted Sales Shipment" extends "Posted Sales Shipment"
{
    layout
    {
        addafter("Responsibility Center")
        {
            field("Expected Delivery Date"; Rec."Expected Delivery Date")
            {
                ApplicationArea = All;
                Editable = false;
            }
            field("Actual Delivery Date"; Rec."Actual Delivery Date")
            {
                ApplicationArea = All;
                Editable = false;
            }
        }
    }
}
