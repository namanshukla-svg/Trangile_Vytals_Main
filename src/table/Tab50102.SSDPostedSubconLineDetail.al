Table 50102 "SSD Posted Subcon. Line Detail"
{
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Document No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Document No.';
        }
        field(2; "Item No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Item No.';
        }
        field(3; "Line No."; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Line No.';
        }
        field(4; "Pre Assigned No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Pre Assigned No.';
        }
        field(5; "Subcontracting Item"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Subcontracting Item';
        }
        field(6; "Quantity Required"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Quantity Required';
        }
    }
    keys
    {
        key(Key1; "Document No.", "Item No.", "Line No.", "Subcontracting Item")
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
    }
}
