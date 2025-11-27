table 50090 "SSD BS Budget"
{
    DataClassification = CustomerContent;

    fields
    {
        field(1; "BS Code"; Code[50])
        {
            Caption = 'BS Code';
            DataClassification = CustomerContent;
        }
        field(2; Description; Text[100])
        {
            Caption = 'Description';
            DataClassification = CustomerContent;
        }
    }
    keys
    {
        key(Key1; "BS Code")
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
    }
}
