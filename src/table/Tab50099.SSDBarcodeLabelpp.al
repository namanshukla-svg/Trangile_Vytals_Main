table 50099 "SSD Barcode Labelpp"
{
    DataClassification = CustomerContent;

    fields
    {
        field(1; SrNo; Integer)
        {
            Caption = 'SrNo';
            DataClassification = CustomerContent;
        }
        field(2; Quantity; Decimal)
        {
            Caption = 'Quantity';
            DataClassification = CustomerContent;
        }
        field(3; "Net Weight"; Decimal)
        {
            Caption = 'Net Weight';
            DataClassification = CustomerContent;
        }
        field(4; "Gross Weight"; Decimal)
        {
            Caption = 'Gross Weight';
            DataClassification = CustomerContent;
        }
        field(5; "User Id"; Code[30])
        {
            Caption = 'User Id';
            DataClassification = CustomerContent;
        }
        field(6; Barcode; Boolean)
        {
            Caption = 'Barcode';
            DataClassification = CustomerContent;
        }
    }
    keys
    {
        key(Key1; SrNo)
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
    }
}
