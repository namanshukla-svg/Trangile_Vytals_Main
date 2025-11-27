Table 50018 "SSD RGP Application Entry"
{
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Entry No."; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Entry No.';
        }
        field(2; "RGP Entry No."; Integer)
        {
            TableRelation = "SSD RGP Ledger Entry";
            DataClassification = CustomerContent;
            Caption = 'RGP Entry No.';
        }
        field(3; "Inbound RGP Entry No."; Integer)
        {
            TableRelation = "SSD RGP Ledger Entry";
            DataClassification = CustomerContent;
            Caption = 'Inbound RGP Entry No.';
        }
        field(4; Quantity; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Quantity';
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
