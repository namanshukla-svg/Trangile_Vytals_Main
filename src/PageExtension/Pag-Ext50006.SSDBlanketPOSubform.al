PageExtension 50006 "SSD Blanket PO Subform" extends "Blanket Purchase Order Subform"
{
    layout
    {
        addafter("Location Code")
        {
            field("Bin Code"; Rec."Bin Code")
            {
                ApplicationArea = All;
            }
        }
    }
}
