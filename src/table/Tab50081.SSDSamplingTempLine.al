Table 50081 "SSD Sampling Temp. Line"
{
    Caption = 'Sampling Temp. Line';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Document No."; Code[20])
        {
            Caption = 'Document No.';
            TableRelation = "SSD Sampling Temp. Header";
            DataClassification = CustomerContent;
        }
        field(2; "Line No."; Integer)
        {
            Caption = 'Line No.';
            DataClassification = CustomerContent;
        }
        field(3; "Test No."; Code[20])
        {
            Caption = 'Test No.';
            Description = 'ALLE[551] date-19-6-12';
            TableRelation = "SSD Sampling Test Header"."No." where(Status=const(Certified));
            DataClassification = CustomerContent;
        }
        field(4; Description; Text[150])
        {
            Caption = 'Description';
            DataClassification = CustomerContent;
        }
        field(5; "Template Type"; Option)
        {
            Editable = false;
            OptionCaption = 'Receipt,Manufacturing,Routing';
            OptionMembers = Receipt, Manufacturing, Routing;
            DataClassification = CustomerContent;
            Caption = 'Template Type';
        }
        field(9; "Meas. Code"; Code[10])
        {
            Caption = 'Measure Code';
            TableRelation = "SSD Sampling Test Line"."Meas. Code" where("Test Code"=field("Test No."));
            //This property is currently not supported
            //TestTableRelation = true;
            ValidateTableRelation = true;
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                if("Meas. Code" = '') or ("Test No." = '')then exit;
                SamplingTestLine.Reset;
                SamplingTestLine.SetRange("Test Code", "Test No.");
                SamplingTestLine.SetRange("Meas. Code", "Meas. Code");
                if SamplingTestLine.Find('-')then repeat Description:=SamplingTestLine.Description;
                        "Meas. Tool Code":=SamplingTestLine."Meas. Tool Code";
                        "Meas. Tool Description":=SamplingTestLine."Meas. Tool Descr.";
                        "Meas. Value Type":=SamplingTestLine."Meas. Value Type";
                        "Unit of Measure Code":=SamplingTestLine."Unit of Measure Code";
                        "Normal Value":=SamplingTestLine."Normal Value";
                        "Minimum Value":=SamplingTestLine."Minimum Value";
                        "Maximum Value":=SamplingTestLine."Maximum Value";
                        "Medium Tolerance":=SamplingTestLine."Medium Tolerance";
                        Discipline:=SamplingTestLine.Discipline;
                        Group:=SamplingTestLine.Group;
                        UCL:=SamplingTestLine.UCL;
                        LCL:=SamplingTestLine.LCL;
                    until SamplingTestLine.Next = 0;
            end;
        }
        field(10; "Kind of Sampling"; Code[10])
        {
            Caption = 'Kind of Sampling';
            Editable = false;
            TableRelation = "SSD Kind of Sampling";
            DataClassification = CustomerContent;
        }
        field(11; "Inspection Type"; Code[20])
        {
            Caption = 'Inspection Type';
            TableRelation = "SSD Inspection Type".Code where("Kind of Sampling"=field("Kind of Sampling"));
            DataClassification = CustomerContent;
        }
        field(12; "Sampling Level"; Code[20])
        {
            Caption = 'Sampling Level';
            TableRelation = "SSD Sampling Level".Code where("Inspection Type"=field("Inspection Type"), "Kind of Sampling"=field("Kind of Sampling"));
            DataClassification = CustomerContent;
        }
        field(50; "Meas. Tool Code"; Code[10])
        {
            Caption = 'Measurement Tool Code';
            TableRelation = "SSD Measurement Tools";
            DataClassification = CustomerContent;
        }
        field(51; "Meas. Tool Description"; Text[30])
        {
            Caption = 'Measurement Tool Description';
            DataClassification = CustomerContent;
        }
        field(52; "Meas. Value Type"; Option)
        {
            Caption = 'Measure Value Type';
            OptionCaption = ' ,Value,Flag';
            OptionMembers = " ", Value, Flag;
            DataClassification = CustomerContent;
        }
        field(53; "Unit of Measure Code"; Code[10])
        {
            Caption = 'Unit of Measure Code';
            TableRelation = "Unit of Measure";
            DataClassification = CustomerContent;
        }
        field(55; "Normal Value"; Text[150])
        {
            DataClassification = CustomerContent;
            Caption = 'Normal Value';
        }
        field(56; "Minimum Value"; Decimal)
        {
            AutoFormatType = 2;
            Caption = 'Minimum Value';
            DataClassification = CustomerContent;
        }
        field(57; "Maximum Value"; Decimal)
        {
            AutoFormatType = 2;
            Caption = 'Maximum Value';
            DataClassification = CustomerContent;
        }
        field(59; "Medium Tolerance"; Decimal)
        {
            DecimalPlaces = 0: 5;
            DataClassification = CustomerContent;
            Caption = 'Medium Tolerance';
        }
        field(63; Comments; Boolean)
        {
            CalcFormula = exist("SSD Quality Comments" where(TableId=const(7034751), "Doc. No."=field("Document No."), "Line No."=field("Line No.")));
            Caption = 'Comments';
            Editable = false;
            FieldClass = FlowField;
        }
        field(80; "Test 1"; Text[30])
        {
            DataClassification = CustomerContent;
            Caption = 'Test 1';
        }
        field(81; "Test 2"; Text[30])
        {
            DataClassification = CustomerContent;
            Caption = 'Test 2';
        }
        field(82; "Test 3"; Text[30])
        {
            DataClassification = CustomerContent;
            Caption = 'Test 3';
        }
        field(83; "Test 4"; Text[30])
        {
            DataClassification = CustomerContent;
            Caption = 'Test 4';
        }
        field(84; "Test 5"; Text[30])
        {
            DataClassification = CustomerContent;
            Caption = 'Test 5';
        }
        field(85; "Test 6"; Text[30])
        {
            DataClassification = CustomerContent;
            Caption = 'Test 6';
        }
        field(86; "Test 7"; Text[30])
        {
            DataClassification = CustomerContent;
            Caption = 'Test 7';
        }
        field(87; "Test 8"; Text[30])
        {
            DataClassification = CustomerContent;
            Caption = 'Test 8';
        }
        field(88; "Test 9"; Text[30])
        {
            DataClassification = CustomerContent;
            Caption = 'Test 9';
        }
        field(89; "Test 10"; Text[30])
        {
            DataClassification = CustomerContent;
            Caption = 'Test 10';
        }
        field(50001; "Responsibility Center"; Code[10])
        {
            Caption = 'Responsibility Center';
            Editable = false;
            TableRelation = "Responsibility Center";
            DataClassification = CustomerContent;
        }
        field(50002; "Process / Operation"; Code[20])
        {
            Editable = false;
            TableRelation = "Work Center"."No." where("Responsibility Center"=field("Responsibility Center"));
            DataClassification = CustomerContent;
            Caption = 'Process / Operation';
        }
        field(50011; Description2; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Description2';
        }
        field(50013; "To be Print"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'To be Print';
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
    }
    keys
    {
        key(Key1; "Document No.", "Line No.")
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
        rQualityComent.Reset;
        rQualityComent.SetRange(rQualityComent.TableId, Database::"SSD Sampling Temp. Line");
        rQualityComent.SetRange(rQualityComent."Doc. No.", "Document No.");
        rQualityComent.SetRange(rQualityComent."Line No.", "Line No.");
        if rQualityComent.Find('-')then rQualityComent.DeleteAll;
    end;
    trigger OnInsert()
    begin
        StatusChecking(Rec);
        SamplingHeader.Get("Document No.");
        SamplingLine.Reset;
        SamplingLine.SetRange("Document No.", "Document No.");
        if not SamplingLine.Find('+')then NextEntryNo:=10000
        else
            NextEntryNo:=SamplingLine."Line No." + 10000;
        "Line No.":=NextEntryNo;
        "Kind of Sampling":=SamplingHeader."Kind of Sampling";
        "Responsibility Center":=SamplingHeader."Responsibility Center";
        "Template Type":=SamplingHeader."Template Type";
        "Process / Operation":=SamplingHeader."Process / Operation No.";
    end;
    trigger OnModify()
    begin
        StatusChecking(Rec);
    end;
    var QualityMeasurements: Record "SSD Quality Measurements";
    MeasurementTools: Record "SSD Measurement Tools";
    SamplingTestLine: Record "SSD Sampling Test Line";
    NextEntryNo: Integer;
    SamplingLine: Record "SSD Sampling Temp. Line";
    SamplingHeader: Record "SSD Sampling Temp. Header";
    Text0001: label 'Modification/Deletion cannot be possible\  when %1 is %2';
    Text0002: label 'Process / Operation cannot be blank';
    Text0003: label 'Process / Operation must be blank';
    procedure ShowComent()
    var
        rQualityComent: Record "SSD Quality Comments";
        fQualityComent: Page "Quality Comments";
    begin
        rQualityComent.Reset;
        rQualityComent.FilterGroup(2);
        rQualityComent.SetRange(rQualityComent.TableId, Database::"SSD Sampling Temp. Line");
        rQualityComent.SetRange(rQualityComent."Doc. No.", "Document No.");
        rQualityComent.SetRange(rQualityComent."Line No.", "Line No.");
        rQualityComent.FilterGroup(0);
        fQualityComent.SetTableview(rQualityComent);
        fQualityComent.Run;
    end;
    procedure StatusChecking(RecSamplingLine: Record "SSD Sampling Temp. Line")
    var
        SamplingHeaderLocal: Record "SSD Sampling Temp. Header";
    begin
        SamplingHeaderLocal.Get(RecSamplingLine."Document No.");
        if SamplingHeaderLocal.Status = SamplingHeaderLocal.Status::Certified then Error(Text0001, SamplingHeaderLocal.FieldCaption(Status), Format(SamplingHeaderLocal.Status));
        if SamplingHeaderLocal.Status = SamplingHeaderLocal.Status::Blocked then Error(Text0001, SamplingHeaderLocal.FieldCaption(Status), Format(SamplingHeaderLocal.Status));
    end;
}
