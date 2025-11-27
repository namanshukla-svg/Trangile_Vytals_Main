Table 50076 "SSD Quality Comments"
{
    Caption = 'Quality Comments';
    DrillDownPageID = "Quality Comments";
    LookupPageID = "Quality Comments";
    DataClassification = CustomerContent;

    fields
    {
        field(1; TableId; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'TableId';
        }
        field(2; "Doc. No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Doc. No.';
        }
        field(3; "Line No."; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Line No.';
        }
        field(4; "Entry No."; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Entry No.';
        }
        field(5; Comment; Text[80])
        {
            DataClassification = CustomerContent;
            Caption = 'Comment';
        }
    }
    keys
    {
        key(Key1; TableId, "Doc. No.", "Line No.", "Entry No.")
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
    }
}
