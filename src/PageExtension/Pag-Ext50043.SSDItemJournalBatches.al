PageExtension 50043 "SSD Item Journal Batches" extends "Item Journal Batches"
{
    layout
    {
        addafter("Reason Code")
        {
            field("Input/Output"; Rec."Input/Output")
            {
                ApplicationArea = All;
            }
        }
    }
}
