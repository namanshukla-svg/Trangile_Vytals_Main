Table 50101 "SSD Subcontacting Line Detail"
{
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Document No."; Code[20])
        {
            Editable = false;
            DataClassification = CustomerContent;
            Caption = 'Document No.';
        }
        field(2; "Item No."; Code[20])
        {
            Editable = false;
            DataClassification = CustomerContent;
            Caption = 'Item No.';
        }
        field(3; "Line No."; Integer)
        {
            Editable = false;
            DataClassification = CustomerContent;
            Caption = 'Line No.';
        }
        field(6; "Subcontracting Item No."; Code[20])
        {
            TableRelation = Item."No.";
            DataClassification = CustomerContent;
            Caption = 'Subcontracting Item No.';
        }
        field(7; "Required Quantity"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Required Quantity';
        }
    }
    keys
    {
        key(Key1; "Document No.", "Item No.", "Line No.", "Subcontracting Item No.")
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
    }
    var RecPruchaseLine: Record "Purchase Line";
}
