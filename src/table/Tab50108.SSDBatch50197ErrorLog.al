table 50108 "SSD Batch 50197 Error Log"
{
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Entry No."; Guid)
        {
            Caption = 'Entry No.';
            DataClassification = CustomerContent;
        }
        field(2; "MRP No."; Code[20])
        {
            Caption = 'MRP No.';
            DataClassification = CustomerContent;
        }
        field(3; "Customer Code"; Code[20])
        {
            Caption = 'Customer Code';
            DataClassification = CustomerContent;
        }
        field(4; "Error Date"; Date)
        {
            Caption = 'Error Date';
            DataClassification = CustomerContent;
        }
        field(5; "Error Time"; Time)
        {
            Caption = 'Error Time';
            DataClassification = CustomerContent;
        }
        field(6; "Error Text"; Text[250])
        {
            Caption = 'Error Text';
            DataClassification = CustomerContent;
        }
    }
    keys
    {
        key(Key1; "Entry No.")
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
    }
}
