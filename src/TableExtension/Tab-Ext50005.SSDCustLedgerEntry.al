TableExtension 50005 "SSD Cust. Ledger Entry" extends "Cust. Ledger Entry"
{
    fields
    {
        field(50001; "Responsibility Center"; Code[20])
        {
            TableRelation = "Responsibility Center";
            DataClassification = CustomerContent;
            Caption = 'Responsibility Center';
        }
        field(50002; Remarks; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Remarks';
        }
        field(50003; "Check For Email"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Check For Email';
        }
        field(50004; "Invoice Basic Amount"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Invoice Basic Amount';
        }
    }
    keys
    {
        key(KeySSD1; "Posting Date", "Document No.")
        {
        }
        key(KeySSD2; "Customer No.", "Posting Date", "Document Date")
        {
        }
    }
}
