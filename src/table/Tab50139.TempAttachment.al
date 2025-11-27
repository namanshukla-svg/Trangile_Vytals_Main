table 50139 "Temp Attachment"
{
    Caption = 'Temp Attachment';
    DataClassification = ToBeClassified;

    fields
    {
        field(3; "Journal Template Name"; Code[10])
        {
            Caption = 'Journal Template Name';
        }
        field(4; "Journal Batch Name"; Code[20])
        {
            Caption = 'Journal Batch Name';
        }
        field(5; "Document No."; Code[20])
        {
            Caption = 'Document No.';
        }
    }
    keys
    {
        key(PK; "Journal Template Name", "Journal Batch Name", "Document No.")
        {
            Clustered = true;
        }
    }
}
