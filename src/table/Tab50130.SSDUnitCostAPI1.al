Table 50130 "SSD Unit Cost API-1"
{
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Item No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Item No.';
        }
        field(2; "Creation Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Creation Date';
        }
        field(3; Description; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Description';
        }
        field(4; "Landed Cost"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Landed Cost';
        }
        field(5; "ILE Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'ILE Date';
        }
        field(6; "Unit Cost"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Unit Cost';
        }
        field(7; "First PO Price"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'First PO Price';
        }
        field(8; "Second PO Price"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Second PO Price';
        }
        field(9; "Third PO Price"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Third PO Price';
        }
    }
    keys
    {
        key(Key1; "Item No.", "Creation Date")
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
    }
}
