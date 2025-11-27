Table 50042 "SSD Distributor Header"
{
    DataClassification = CustomerContent;

    fields
    {
        field(1; "MRP No."; Code[30])
        {
            Caption = 'MRP No.';
            DataClassification = CustomerContent;
        }
        field(2; "Serial No."; Code[30])
        {
            Caption = 'Serial No.';
            DataClassification = CustomerContent;
        }
        field(3; "Customer Code"; Code[30])
        {
            Caption = 'Customer Code';
            DataClassification = CustomerContent;
        }
        field(4; Updated; Boolean)
        {
            Caption = 'Updated';
            DataClassification = CustomerContent;
        }
        field(5; "Error Text"; Text[250])
        {
            Caption = 'Error Text';
            DataClassification = CustomerContent;
        }
    }
    keys
    {
        key(Key1; "MRP No.")
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
    }
}
