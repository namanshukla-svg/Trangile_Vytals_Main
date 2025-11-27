PageExtension 50080 "SSD Purchase List" extends "Purchase List"
{
    layout
    {
        addafter("Buy-from Vendor No.")
        {
            field("Completely Received"; Rec."Completely Received")
            {
                ApplicationArea = All;
            }
            field("Promised Receipt Date"; Rec."Promised Receipt Date")
            {
                ApplicationArea = All;
            }
            field(Status; Rec.Status)
            {
                ApplicationArea = All;
            }
        }
        addafter("Order Address Code")
        {
            field("Expected Receipt Date"; Rec."Expected Receipt Date")
            {
                ApplicationArea = All;
            }
        }
        addafter("Currency Code")
        {
            field("Order Created from MRP"; Rec."Order Created from MRP")
            {
                ApplicationArea = All;
            }
        }
    }
}
