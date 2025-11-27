PageExtension 50061 "SSD Posted Purchase Invoices" extends "Posted Purchase Invoices"
{
    layout
    {
        addafter("No.")
        {
            field("Vendor Order No."; Rec."Vendor Order No.")
            {
                ApplicationArea = All;
            }
        }
        addafter("Order Address Code")
        {
            field("Gate Entry No."; Rec."Gate Entry No.")
            {
                ApplicationArea = All;
            }
            field("Gate Entry Date"; Rec."Gate Entry Date")
            {
                ApplicationArea = All;
            }
            field("Applies-to Doc. No."; Rec."Applies-to Doc. No.")
            {
                ApplicationArea = All;
            }
        }
        addafter("Shipment Method Code")
        {
            field("Service Order No."; Rec."Service Order No.")
            {
                ApplicationArea = All;
            }
            field("Deduction Reason"; Rec."Deduction Reason")
            {
                ApplicationArea = All;
            }
        }
    }
}
