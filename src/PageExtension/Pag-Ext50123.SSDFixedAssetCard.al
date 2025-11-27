pageextension 50123 "SSD Fixed Asset Card" extends "Fixed Asset Card"
{
    layout
    {
        addafter("Gen. Prod. Posting Group")
        {
            field("VAT Product Posting Group"; Rec."VAT Product Posting Group")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the VAT Product Posting Group field.';
                Visible = false;
            }

        }
        addafter(Description)
        {
            field("Description 2"; Rec."Description 2")
            {
                ApplicationArea = all;
            }
        }
    }
}
