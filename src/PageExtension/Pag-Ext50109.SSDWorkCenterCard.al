PageExtension 50109 "SSD Work Center Card" extends "Work Center Card"
{
    layout
    {
        addafter("Alternate Work Center")
        {
            field("Process / Operation"; Rec."Process / Operation")
            {
                ApplicationArea = All;
            }
        }
    }
}
