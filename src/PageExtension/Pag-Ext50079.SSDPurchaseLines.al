PageExtension 50079 "SSD Purchase Lines" extends "Purchase Lines"
{
    layout
    {
        addafter("Document No.")
        {
            field("Outstanding Qty. (Base)"; Rec."Outstanding Qty. (Base)")
            {
                ApplicationArea = All;
            }
        }
        addafter(Quantity)
        {
            field("Quantity Received"; Rec."Quantity Received")
            {
                ApplicationArea = All;
            }
        }
        addafter("Amt. Rcd. Not Invoiced (LCY)")
        {
            field("Indent No."; Rec."Indent No.")
            {
                ApplicationArea = All;
                Visible = false;
            }
        }
    }
}
