PageExtension 50004 "SSD Blanket Purchase Order" extends "Blanket Purchase Order"
{
    layout
    {
        addafter("Pay-to Contact")
        {
            field(Insurance; Rec.Insurance)
            {
                ApplicationArea = All;
            }
            field("Last Schedule Order No"; Rec."Last Schedule Order No")
            {
                ApplicationArea = All;
                Editable = false;
            }
            field("Last Schedule No."; Rec."Last Schedule No.")
            {
                ApplicationArea = All;
                Editable = false;
            }
        }
    }
}
