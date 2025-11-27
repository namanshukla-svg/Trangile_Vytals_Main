TableExtension 50031 "SSD Ins. Coverage Ledger Entry" extends "Ins. Coverage Ledger Entry"
{
    fields
    {
        field(50000; "Responsibility Center"; Code[20])
        {
            Description = 'MSI.RC';
            TableRelation = "Responsibility Center";
            DataClassification = CustomerContent;
            Caption = 'Responsibility Center';
        }
    }
}
