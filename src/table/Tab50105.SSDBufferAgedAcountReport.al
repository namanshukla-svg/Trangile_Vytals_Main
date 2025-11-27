table 50105 "SSD Buffer Aged Acount Report"
{
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Cust No."; Code[20])
        {
            Caption = 'Cust No.';
            DataClassification = CustomerContent;
        }
        field(2; DDC; Date)
        {
            Caption = 'DDC';
            DataClassification = CustomerContent;
        }
        field(3; Num; Integer)
        {
            Caption = 'Num';
            DataClassification = CustomerContent;
        }
    }
    keys
    {
        key(Key1; "Cust No.", DDC)
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
    }
}
