Table 50092 "SSD Inspection Type"
{
    Caption = 'Inspection Type';
    DrillDownPageID = "Inspection Type";
    LookupPageID = "Inspection Type";
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Code"; Code[10])
        {
            Caption = 'Code';
            NotBlank = true;
            DataClassification = CustomerContent;
        }
        field(2; Description; Text[50])
        {
            Caption = 'Description';
            DataClassification = CustomerContent;
        }
        field(3; "Kind of Sampling"; Code[10])
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
        key(Key1; "Kind of Sampling", "Code")
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
    }
}
