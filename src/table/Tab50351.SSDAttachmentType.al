table 50351 "SSD Attachment Type"
{
    Caption = 'Attachment Type';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Code"; Code[20])
        {
            Caption = 'Code';
            NotBlank = true;
        }
        field(2; Description; Text[100])
        {
            Caption = 'Description';
        }
        field(10; "Is Annexure"; Boolean)
        {
            Caption = 'Annexure';
        }
        field(20; "Is Vendor Confirmation"; Boolean)
        {
            Caption = 'Vendor Confirmation';
        }
    }
    keys
    {
        key(PK; "Code")
        {
            Clustered = true;
        }
    }
}
