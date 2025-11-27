Table 50067 "SSD Quality Measurements"
{
    Caption = 'Quality: Measurements';
    DrillDownPageID = "Quality: Measurements";
    LookupPageID = "Quality: Measurements";
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Code"; Code[10])
        {
            Caption = 'Code';
            NotBlank = true;
            DataClassification = CustomerContent;
        }
        field(2; Description; Text[150])
        {
            Caption = 'Description';
            DataClassification = CustomerContent;
        }
        field(50000; "3D Para"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = '3D Para';
        }
        field(50001; "Responsibility Center"; Code[10])
        {
            Caption = 'Responsibility Center';
            Editable = false;
            TableRelation = "Responsibility Center";
            DataClassification = CustomerContent;
        }
        field(50002; Discipline; Option)
        {
            Description = 'ALLE-NM';
            OptionCaption = ' ,MT#,CT#';
            OptionMembers = " ", "MT#", "CT#";
            DataClassification = CustomerContent;
            Caption = 'Discipline';
        }
        field(50003; Group; Option)
        {
            Description = 'ALLE-NM';
            OptionCaption = ' ,Plastic,Paper,Lubricants,Petroleum,Misc,Plastic & PP+';
            OptionMembers = " ", Plastic, Paper, Lubricants, Petroleum, Misc, "Plastic & PP+";
            DataClassification = CustomerContent;
            Caption = 'Group';
        }
        field(50004; "0D Para"; Boolean)
        {
            Description = 'ALLE-NM';
            DataClassification = CustomerContent;
            Caption = '0D Para';
        }
        field(50005; "1D Para"; Boolean)
        {
            Description = 'ALLE-NM';
            DataClassification = CustomerContent;
            Caption = '1D Para';
        }
        field(50006; "2D Para"; Boolean)
        {
            Description = 'ALLE-NM';
            DataClassification = CustomerContent;
            Caption = '2D Para';
        }
        field(50007; "Under NABL Scope"; Boolean)
        {
            Description = 'ALLE-18102022';
            DataClassification = CustomerContent;
            Caption = 'Under NABL Scope';
        }
        field(7034750; "Measurement Tool Code"; Code[10])
        {
            Caption = 'Measurement Tool Code';
            TableRelation = "SSD Measurement Tools".Code;
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                if MeasurementTools.Get("Measurement Tool Code")then begin
                    "Measurement Tool Descr.":=MeasurementTools.Description;
                    "Measure Value Type":=MeasurementTools."Measure Value Type";
                    "Unit of Measure Code":=MeasurementTools."Unit of Measure Code";
                end;
            end;
        }
        field(7034751; "Measurement Tool Descr."; Text[30])
        {
            Caption = 'Measurement Tool Descr.';
            DataClassification = CustomerContent;
        }
        field(7034752; "Measure Value Type"; Option)
        {
            Caption = 'Measure Value Type';
            OptionCaption = ' ,Value,Flag';
            OptionMembers = " ", Value, Flag;
            DataClassification = CustomerContent;
        }
        field(7034753; "Unit of Measure Code"; Code[10])
        {
            Caption = 'Unit of Measure Code';
            TableRelation = "Unit of Measure".Code;
            DataClassification = CustomerContent;
        }
        field(7034754; Observations; Text[50])
        {
            Caption = 'Observations';
            DataClassification = CustomerContent;
        }
        field(7034755; Protocol; Text[50])
        {
            Description = 'ALLE[5.51]';
            DataClassification = CustomerContent;
            Caption = 'Protocol';
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
    var MeasurementTools: Record "SSD Measurement Tools";
}
