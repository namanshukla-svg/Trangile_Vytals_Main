table 50073 "SSD Vendor Eval. Code"
{
    Caption = 'Vendor Eval. Code';
    DrillDownPageID = "Vendor Eval. Code";
    LookupPageID = "Vendor Eval. Code";
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Code"; Code[10])
        {
            Caption = 'Code';
            DataClassification = CustomerContent;
        }
        field(2; Concept; Text[50])
        {
            Caption = 'Concept';
            DataClassification = CustomerContent;
        }
        field(3; "Value 1"; Text[30])
        {
            Caption = 'Value 1';
            DataClassification = CustomerContent;
        }
        field(4; "Value 2"; Text[30])
        {
            Caption = 'Value 2';
            DataClassification = CustomerContent;
        }
        field(5; "Value 3"; Text[30])
        {
            Caption = 'Value 3';
            DataClassification = CustomerContent;
        }
        field(6; "Rating Weight"; Decimal)
        {
            Caption = 'Rating Weight';
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
        key(Key1; "Code")
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
    }
}
