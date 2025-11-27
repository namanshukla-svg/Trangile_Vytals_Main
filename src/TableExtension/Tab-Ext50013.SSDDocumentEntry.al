TableExtension 50013 "SSD Document Entry" extends "Document Entry"
{
    fields
    {
        field(50000; "Line No."; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Line No.';
        }
        field(50001; "Dimension Code"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Dimension Code';
        }
        field(50002; "Dimension Value Code"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Dimension Value Code';
        }
    }
}
