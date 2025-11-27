table 50357 "SSD Purchase Attachment"
{
    Caption = 'SSD Purchase Attachment';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Document Type";Enum "Purchase Document Type")
        {
            Caption = 'Document Type';
        }
        field(3; "No."; Code[20])
        {
            Caption = 'No.';
        }
    }
    keys
    {
        key(PK; "Document Type", "No.")
        {
            Clustered = true;
        }
    }
}
