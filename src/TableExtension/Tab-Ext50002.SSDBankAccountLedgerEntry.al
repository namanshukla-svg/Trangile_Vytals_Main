TableExtension 50002 "SSD Bank Account Ledger Entry" extends "Bank Account Ledger Entry"
{
    fields
    {
        field(50001; "SSD Responsibility Center"; Code[20])
        {
            TableRelation = "Responsibility Center";
            DataClassification = CustomerContent;
            Caption = 'Responsibility Center';
        }
        field(75002; "SSD Vendor Bank Account"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Vendor Bank Account';
        }
    }
}
