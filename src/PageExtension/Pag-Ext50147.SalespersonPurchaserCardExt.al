pageextension 50147 "Salesperson/Purchaser Card Ext" extends "Salesperson/Purchaser Card"
{
    layout
    {
        addafter("Privacy Blocked")
        {
            field(Category; Rec.Category)
            {
                ApplicationArea = All;
            }
            field("Sales Region"; Rec."Sales Region")
            {
                ApplicationArea = All;
            }
        }
    }
}
