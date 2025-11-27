Table 50132 "SSD ModifySalesInvADD"
{
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Sales Inv. No."; Code[20])
        {
            Caption = 'Sales Inv. No.';
            DataClassification = CustomerContent;
        }
        field(2; "Actual Delivery Date"; Date)
        {
            Caption = 'Actual Delivery Date';
            DataClassification = CustomerContent;
        }
    }
    keys
    {
        key(Key1; "Sales Inv. No.")
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
    }
}
