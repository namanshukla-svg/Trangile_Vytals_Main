Table 50065 "SSD Setup Quality Sub-Template"
{
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Template Type"; Option)
        {
            Editable = false;
            OptionCaption = 'Receipt,Manufacturing,Routing';
            OptionMembers = Receipt, Manufacturing, Routing;
            DataClassification = CustomerContent;
            Caption = 'Template Type';
        }
        field(2; "Responsibility Center"; Code[10])
        {
            Caption = 'Responsibility Center';
            Editable = false;
            TableRelation = "Responsibility Center";
            DataClassification = CustomerContent;
        }
        field(3; "Process / Operation No."; Code[20])
        {
            TableRelation = "Work Center"."No." where("Responsibility Center"=field("Responsibility Center"));
            DataClassification = CustomerContent;
            Caption = 'Process / Operation No.';

            trigger OnValidate()
            var
                SetupQltSubTmpLocal: Record "SSD Setup Quality Sub-Template";
            begin
                CalcFields("Process / Operation");
                SetupQltSubTmpLocal.Reset;
                SetupQltSubTmpLocal.SetRange("Template Type", "Template Type");
                SetupQltSubTmpLocal.SetRange("Responsibility Center", "Responsibility Center");
                SetupQltSubTmpLocal.SetRange("Process / Operation No.", "Process / Operation No.");
                if SetupQltSubTmpLocal.Find('-')then Error(Text001, FieldCaption("Process / Operation No."), "Process / Operation No.");
            end;
        }
        field(4; "Line No."; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Line No.';
        }
        field(5; "Sampling Template No."; Code[20])
        {
            TableRelation = "SSD Sampling Temp. Header"."No." where("Template Type"=field("Template Type"), "Responsibility Center"=field("Responsibility Center"), "Process / Operation No."=field("Process / Operation No."));
            DataClassification = CustomerContent;
            Caption = 'Sampling Template No.';
        }
        field(6; "Process / Operation"; Text[30])
        {
            CalcFormula = lookup("Work Center"."Process / Operation" where("No."=field("Process / Operation No.")));
            Description = 'Coming from Work center "Process/Operation"';
            Editable = false;
            FieldClass = FlowField;
            Caption = 'Process / Operation';
        }
        field(7; "Type Of Inspection"; Option)
        {
            Description = 'LineInspection,FinalInspection';
            OptionCaption = 'LineInspection,FinalInspection';
            OptionMembers = LineInsp, FinalInsp;
            DataClassification = CustomerContent;
            Caption = 'Type Of Inspection';
        }
    }
    keys
    {
        key(Key1; "Template Type", "Responsibility Center", "Process / Operation No.", "Line No.")
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
    }
    var Text001: label '%1 - %2 Already Exist';
}
