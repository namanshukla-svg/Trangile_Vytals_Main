Table 50066 "SSD Sampling Test Line"
{
    Caption = 'Sampling Test Line';
    LookupPageID = "Sampling Test Lines";
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Test Code"; Code[20])
        {
            Description = 'ALLE[551] date-19-6-12';
            NotBlank = true;
            TableRelation = "SSD Sampling Test Header";
            DataClassification = CustomerContent;
            Caption = 'Test Code';
        }
        field(2; "Line No."; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Line No.';
        }
        field(9; "Meas. Code"; Code[10])
        {
            Caption = 'Measurement Code';
            TableRelation = "SSD Quality Measurements";
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                if "Meas. Code" = '' then exit;
                QualityMeas.Get("Meas. Code");
                Description:=QualityMeas.Description;
                "Meas. Tool Code":=QualityMeas."Measurement Tool Code";
                "Meas. Tool Descr.":=QualityMeas."Measurement Tool Descr.";
                "Meas. Value Type":=QualityMeas."Measure Value Type";
                "Unit of Measure Code":=QualityMeas."Unit of Measure Code";
                Discipline:=QualityMeas.Discipline;
                Group:=QualityMeas.Group;
            end;
        }
        field(10; Description; Text[150])
        {
            DataClassification = CustomerContent;
            Caption = 'Description';
        }
        field(11; "Minimum Value"; Decimal)
        {
            DecimalPlaces = 0: 5;
            DataClassification = CustomerContent;
            Caption = 'Minimum Value';
        }
        field(12; "Maximum Value"; Decimal)
        {
            DecimalPlaces = 0: 5;
            DataClassification = CustomerContent;
            Caption = 'Maximum Value';
        }
        field(13; "Medium Tolerance"; Decimal)
        {
            DecimalPlaces = 0: 5;
            DataClassification = CustomerContent;
            Caption = 'Medium Tolerance';
        }
        field(23; Comments; Boolean)
        {
            CalcFormula = exist("SSD Quality Comments" where(TableId=const(62851), "Doc. No."=field("Test Code"), "Line No."=field("Line No.")));
            Editable = false;
            FieldClass = FlowField;
            Caption = 'Comments';
        }
        field(50001; "Responsibility Center"; Code[10])
        {
            Caption = 'Responsibility Center';
            TableRelation = "Responsibility Center";
            DataClassification = CustomerContent;
        }
        field(50020; Discipline; Option)
        {
            Description = 'ALLE-NM';
            OptionCaption = ' ,MT#,CT#';
            OptionMembers = " ", "MT#", "CT#";
            DataClassification = CustomerContent;
            Caption = 'Discipline';
        }
        field(50021; Group; Option)
        {
            Description = 'ALLE-NM';
            OptionCaption = ' ,Plastic,Paper,Lubricants,Petroleum,Misc,Plastic & PP+';
            OptionMembers = " ", Plastic, Paper, Lubricants, Petroleum, Misc, "Plastic & PP+";
            DataClassification = CustomerContent;
            Caption = 'Group';
        }
        field(50022; UCL; Decimal)
        {
            Description = 'ALLE-NM';
            DataClassification = CustomerContent;
            Caption = 'UCL';
        }
        field(50023; LCL; Decimal)
        {
            Description = 'ALLE-NM';
            DataClassification = CustomerContent;
            Caption = 'LCL';
        }
        field(7034750; "Meas. Tool Code"; Code[10])
        {
            Caption = 'Measurement Tool Code';
            TableRelation = "SSD Measurement Tools";
            DataClassification = CustomerContent;
        }
        field(7034751; "Meas. Tool Descr."; Text[30])
        {
            Caption = 'Measurement Tool Description';
            DataClassification = CustomerContent;
        }
        field(7034752; "Meas. Value Type"; Option)
        {
            Caption = 'Measurement Value Type';
            OptionCaption = ' ,Value,Flag';
            OptionMembers = " ", Value, Flag;
            DataClassification = CustomerContent;
        }
        field(7034753; "Unit of Measure Code"; Code[10])
        {
            TableRelation = "Unit of Measure";
            DataClassification = CustomerContent;
            Caption = 'Unit of Measure Code';
        }
        field(7034755; "Normal Value"; Text[150])
        {
            DataClassification = CustomerContent;
            Caption = 'Normal Value';
        }
    }
    keys
    {
        key(Key1; "Test Code", "Meas. Code", "Line No.")
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
    }
    trigger OnDelete()
    var
        rQualityComent: Record "SSD Quality Comments";
    begin
        StatusChecking(Rec);
    //Alle Event Start
    // rQualityComent.RESET;
    // rQualityComent.SETRANGE( rQualityComent.TableId, DATABASE::"Sampling Test Line");
    // rQualityComent.SETRANGE( rQualityComent."Doc. No.", "Test Code");
    // rQualityComent.SETRANGE( rQualityComent."Line No.", "Line No.");
    // IF rQualityComent.FIND('-') THEN
    //  rQualityComent.DELETEALL;
    //Alle Event End;
    end;
    trigger OnInsert()
    begin
        StatusChecking(Rec);
    end;
    trigger OnModify()
    begin
        StatusChecking(Rec);
    end;
    var QualityMeas: Record "SSD Quality Measurements";
    Text0001: label 'Modification/Deletion cannot be possible\  when %1 is %2';
    procedure ShowComent()
    var
        rQualityComent: Record "SSD Quality Comments";
        fQualityComent: Page "Quality Comments";
    begin
        rQualityComent.Reset;
        rQualityComent.FilterGroup(2);
        rQualityComent.SetRange(rQualityComent.TableId, Database::"SSD Sampling Test Line");
        rQualityComent.SetRange(rQualityComent."Doc. No.", "Test Code");
        rQualityComent.SetRange(rQualityComent."Line No.", "Line No.");
        rQualityComent.FilterGroup(0);
        fQualityComent.SetTableview(rQualityComent);
        fQualityComent.Run;
    end;
    procedure StatusChecking(RecSamplingTestLine: Record "SSD Sampling Test Line")
    var
        SamplingTestHeaderLocal: Record "SSD Sampling Test Header";
    begin
        SamplingTestHeaderLocal.Get(RecSamplingTestLine."Test Code");
        if SamplingTestHeaderLocal.Status = SamplingTestHeaderLocal.Status::Certified then Error(Text0001, SamplingTestHeaderLocal.FieldCaption(Status), Format(SamplingTestHeaderLocal.Status));
        if SamplingTestHeaderLocal.Status = SamplingTestHeaderLocal.Status::Blocked then Error(Text0001, SamplingTestHeaderLocal.FieldCaption(Status), Format(SamplingTestHeaderLocal.Status));
    end;
}
