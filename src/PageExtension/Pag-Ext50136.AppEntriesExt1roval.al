pageextension 50136 AppEntriesExt1roval extends "Approval Entries"
{
    layout
    {
        addbefore("Amount (LCY)")
        {
            field(Amount; Rec.Amount)
            {
                ApplicationArea = All;
            }

        }
    }
}
