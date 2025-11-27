Table 50094 "SSD Sample Size"
{
    Caption = 'Sample Size';
    DrillDownPageID = "Item Sampling Templates";
    LookupPageID = "Item Sampling Templates";
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Sample Size"; Decimal)
        {
            Caption = 'Sample Size (Percentage)';
            DecimalPlaces = 0: 0;
            MaxValue = 100;
            MinValue = 0;
            DataClassification = CustomerContent;
        }
        field(10; "Kind of Sampling"; Code[20])
        {
            Caption = 'Kind of Sampling';
            NotBlank = true;
            TableRelation = "SSD Kind of Sampling";
            DataClassification = CustomerContent;
        }
        field(50001; "Responsibility Center"; Code[10])
        {
            Caption = 'Responsibility Center';
            Editable = false;
            TableRelation = "Responsibility Center";
            DataClassification = CustomerContent;
        }
    }
    keys
    {
        key(Key1; "Kind of Sampling", "Sample Size")
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
    }
}
