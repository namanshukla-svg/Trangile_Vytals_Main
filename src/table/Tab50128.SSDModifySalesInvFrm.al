Table 50128 "SSD ModifySalesInvFrm"
{
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Sales Inv. No."; Code[20])
        {
            Caption = 'Sales Inv. No.';
            DataClassification = CustomerContent;
        }
        field(2; Firm; Boolean)
        {
            Caption = 'Firm';
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
