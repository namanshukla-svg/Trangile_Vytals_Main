Table 50093 "SSD Sampling Level"
{
    Caption = 'Sampling Level';
    DrillDownPageID = "E-Invoice Integration Setup";
    LookupPageID = "E-Invoice Integration Setup";
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Inspection Type"; Code[10])
        {
            Caption = 'Inspection Type';
            NotBlank = true;
            TableRelation = "SSD Inspection Type".Code where("Kind of Sampling"=field("Kind of Sampling"));
            DataClassification = CustomerContent;
        }
        field(2; "Code"; Code[10])
        {
            Caption = 'Code';
            NotBlank = true;
            DataClassification = CustomerContent;
        }
        field(3; Description; Text[50])
        {
            Caption = 'Description';
            DataClassification = CustomerContent;
        }
        field(4; "Kind of Sampling"; Code[10])
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
        key(Key1; "Kind of Sampling", "Inspection Type", "Code")
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
    }
}
