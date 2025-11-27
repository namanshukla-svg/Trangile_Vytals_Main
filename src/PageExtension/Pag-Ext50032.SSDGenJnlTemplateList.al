PageExtension 50032 "SSD GenJnl Template List" extends "General Journal Template List"
{
    Editable = true;

    layout
    {
        addafter(Description)
        {
            field("Responsibility Center"; Rec."Responsibility Center")
            {
                ApplicationArea = All;
            }
        }
    }
}
