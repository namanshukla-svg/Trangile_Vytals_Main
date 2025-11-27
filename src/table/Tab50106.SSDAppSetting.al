table 50106 "SSD App Setting"
{
    DataClassification = CustomerContent;

    fields
    {
        field(1; Name; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Name';
        }
        field(2; Version; Text[30])
        {
            DataClassification = CustomerContent;
            Caption = 'Version';
        }
        field(3; Size; Text[30])
        {
            DataClassification = CustomerContent;
            Caption = 'Size';
        }
        field(4; URL; Text[250])
        {
            DataClassification = CustomerContent;
            Caption = 'URL';
        }
    }
    keys
    {
        key(Key1; Name)
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
    }
}
