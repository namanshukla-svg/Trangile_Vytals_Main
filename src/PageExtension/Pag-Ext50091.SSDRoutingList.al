PageExtension 50091 "SSD Routing List" extends "Routing List"
{
    layout
    {
        addafter(Description)
        {
            field("Source No."; Rec."Source No.")
            {
                ApplicationArea = All;
            }
            field("Work Center"; Rec."Work Center")
            {
                ApplicationArea = All;
            }
        }
    }
}
