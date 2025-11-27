Table 50104 "SSD Posted RGP Line Detail"
{
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Document Type"; Option)
        {
            Editable = false;
            OptionMembers = "RGP Inbound", "RGP Outbound";
            DataClassification = CustomerContent;
            Caption = 'Document Type';
        }
        field(2; "Document No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Document No.';
        }
        field(3; "Item No."; Code[20])
        {
            Editable = false;
            DataClassification = CustomerContent;
            Caption = 'Item No.';
        }
        field(4; "Line No."; Integer)
        {
            Editable = false;
            DataClassification = CustomerContent;
            Caption = 'Line No.';
        }
        field(5; "Required Item"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Required Item';
        }
        field(6; "Required Quantity"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Required Quantity';
        }
        field(7; "Pre Assigned No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Pre Assigned No.';
        }
    }
    keys
    {
        key(Key1; "Document Type", "Document No.", "Item No.", "Line No.", "Required Item")
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
    }
}
