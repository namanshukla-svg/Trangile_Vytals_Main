table 50100 "SSD Sales Peak2"
{
    DataClassification = CustomerContent;

    fields
    {
        field(1; "No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'No.';
        }
        field(2; Month; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Month';
        }
        field(3; Amt; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Amt';
        }
        field(4; Qty; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Qty';
        }
    }
    keys
    {
        key(Key1; "No.", Month)
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
    }
}
