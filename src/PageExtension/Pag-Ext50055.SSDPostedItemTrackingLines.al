PageExtension 50055 "SSD Posted Item Tracking Lines" extends "Posted Item Tracking Lines"
{
    layout
    {
        addafter("Serial No.")
        {
            field("Document No."; Rec."Document No.")
            {
                ApplicationArea = All;
            }
        }
    }
}
