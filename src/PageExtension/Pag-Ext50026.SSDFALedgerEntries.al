PageExtension 50026 "SSD FA Ledger Entries" extends "FA Ledger Entries"
{
    layout
    {
        addafter("FA No.")
        {
            field("FA Subclass Code"; Rec."FA Subclass Code")
            {
                ApplicationArea = All;
            }
        }
    }
}
