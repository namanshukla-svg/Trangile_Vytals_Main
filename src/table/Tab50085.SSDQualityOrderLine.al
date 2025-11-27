table 50085 "SSD Quality Order Line"
{
    Caption = 'Quality Order Line';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Document No."; Code[20])
        {
            Caption = 'Document No.';
            TableRelation = "SSD Quality Order Header";
            DataClassification = CustomerContent;
        }
        field(2; "Line No."; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Line No.';
        }
        field(3; "Test No."; Code[20])
        {
            Caption = 'Test No.';
            Description = 'ALLE[551] date-19-6-12';
            Editable = false;
            TableRelation = "SSD Sampling Test Header"."No.";
            DataClassification = CustomerContent;
        }
        field(4; Description; Text[150])
        {
            Editable = false;
            DataClassification = CustomerContent;
            Caption = 'Description';
        }
        field(5; "Template Type"; Option)
        {
            Editable = false;
            OptionCaption = 'Receipt,Manufacturing,Routing,RcvdCoil';
            OptionMembers = Receipt, Manufacturing, Routing, RcvdCoil;
            DataClassification = CustomerContent;
            Caption = 'Template Type';
        }
        field(9; "Meas. Code"; Code[10])
        {
            Caption = 'Measurement Code';
            TableRelation = "SSD Quality Measurements";
            DataClassification = CustomerContent;
        }
        field(10; "Kind of Sampling"; Code[10])
        {
            Editable = false;
            TableRelation = "SSD Kind of Sampling";
            DataClassification = CustomerContent;
            Caption = 'Kind of Sampling';
        }
        field(11; "Inspection Type"; Code[20])
        {
            Editable = false;
            TableRelation = "SSD Inspection Type".Code where("Kind of Sampling"=field("Kind of Sampling"));
            DataClassification = CustomerContent;
            Caption = 'Inspection Type';
        }
        field(12; "Sampling Level"; Code[20])
        {
            Editable = false;
            TableRelation = "SSD Sampling Level".Code where("Inspection Type"=field("Inspection Type"), "Kind of Sampling"=field("Kind of Sampling"));
            DataClassification = CustomerContent;
            Caption = 'Sampling Level';
        }
        field(13; "Sampling Template No."; Code[20])
        {
            Editable = false;
            TableRelation = "SSD Sampling Temp. Header" where("Template Type"=field("Template Type"));
            DataClassification = CustomerContent;
            Caption = 'Sampling Template No.';
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
            Caption = 'Measurement Value Type';
            Editable = true;
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
        field(54; Observations; Text[50])
        {
            Caption = 'Observations';
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
            BlankZero = true;
            DecimalPlaces = 2: 2;
            DataClassification = CustomerContent;
            Caption = 'Minimum Value';
        }
        field(57; "Maximum Value"; Decimal)
        {
            AutoFormatType = 2;
            DataClassification = CustomerContent;
            Caption = 'Maximum Value';
        }
        field(58; "Defect Code"; Code[10])
        {
            Caption = 'Defect Code';
            TableRelation = "SSD Quality Defects";
            DataClassification = CustomerContent;
        }
        field(59; "Medium Tolerance"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Medium Tolerance';
        }
        field(60; "Qty. to be Inspected"; Decimal)
        {
            MinValue = 0;
            DataClassification = CustomerContent;
            Caption = 'Qty. to be Inspected';

            trigger OnValidate()
            var
                QOrderHeaderLocal: Record "SSD Quality Order Header";
            begin
                QOrderHeaderLocal.Get("Document No.");
                if "Qty. to be Inspected" > QOrderHeaderLocal."Sample Size" then Error(Text001, QOrderHeaderLocal."Sample Size");
                "Accepted Qty.":="Qty. to be Inspected";
                "Rejected Qty.":=0;
            end;
        }
        field(61; "Accepted Qty."; Decimal)
        {
            MinValue = 0;
            DataClassification = CustomerContent;
            Caption = 'Accepted Qty.';

            trigger OnValidate()
            begin
                if "Accepted Qty." > "Qty. to be Inspected" then Error(Text001, "Qty. to be Inspected");
                "Rejected Qty.":="Qty. to be Inspected" - "Accepted Qty.";
            end;
        }
        field(62; "Rejected Qty."; Decimal)
        {
            Editable = false;
            MinValue = 0;
            DataClassification = CustomerContent;
            Caption = 'Rejected Qty.';
        }
        field(70; "Initial Sample Value1"; Decimal)
        {
            AutoFormatType = 2;
            DataClassification = CustomerContent;
            Caption = 'Initial Sample Value1';

            trigger OnValidate()
            begin
                /*
                IF "Template Type" <>"Template Type"::Manufacturing THEN
                  ERROR('');
                */
                //Alle[5.51]
                if("Initial Sample Value1" + "Initial Sample Value2" + "Initial Sample Value3" + "Initial Sample Value4" + "Initial Sample Value5" + "Inspection Value1") > 0 then "Inspection Value2":=("Initial Sample Value1" + "Initial Sample Value2" + "Initial Sample Value3" + "Initial Sample Value4" + "Initial Sample Value5" + "Inspection Value1") / 1;
                "Actual Test Results Data":="Inspection Value2"; // Alle 010816
            //ALLE[5.51]
            end;
        }
        field(71; "Initial Sample Value2"; Decimal)
        {
            AutoFormatType = 2;
            DataClassification = CustomerContent;
            Caption = 'Initial Sample Value2';

            trigger OnValidate()
            begin
                /*
                IF "Template Type" <>"Template Type"::Manufacturing THEN
                  ERROR('');
                */
                //Alle[5.51]
                if("Initial Sample Value1" + "Initial Sample Value2" + "Initial Sample Value3" + "Initial Sample Value4" + "Initial Sample Value5" + "Inspection Value1") > 0 then "Inspection Value2":=("Initial Sample Value1" + "Initial Sample Value2" + "Initial Sample Value3" + "Initial Sample Value4" + "Initial Sample Value5" + "Inspection Value1") / 2;
                "Actual Test Results Data":="Inspection Value2"; // Alle 010816
            //ALLE[5.51]
            end;
        }
        field(72; "Initial Sample Value3"; Decimal)
        {
            AutoFormatType = 2;
            DataClassification = CustomerContent;
            Caption = 'Initial Sample Value3';

            trigger OnValidate()
            begin
                /*
                IF "Template Type" <>"Template Type"::Manufacturing THEN
                  ERROR('');
                */
                //Alle[5.51]
                if("Initial Sample Value1" + "Initial Sample Value2" + "Initial Sample Value3" + "Initial Sample Value4" + "Initial Sample Value5" + "Inspection Value1") > 0 then "Inspection Value2":=("Initial Sample Value1" + "Initial Sample Value2" + "Initial Sample Value3" + "Initial Sample Value4" + "Initial Sample Value5" + "Inspection Value1") / 3;
                "Actual Test Results Data":="Inspection Value2"; // Alle 010816
            //ALLE[5.51]
            end;
        }
        field(73; "Initial Sample Value4"; Decimal)
        {
            AutoFormatType = 2;
            DataClassification = CustomerContent;
            Caption = 'Initial Sample Value4';

            trigger OnValidate()
            begin
                /*
                IF "Template Type" <>"Template Type"::Manufacturing THEN
                  ERROR('');
                */
                //Alle[5.51]
                if("Initial Sample Value1" + "Initial Sample Value2" + "Initial Sample Value3" + "Initial Sample Value4" + "Initial Sample Value5" + "Inspection Value1") > 0 then "Inspection Value2":=("Initial Sample Value1" + "Initial Sample Value2" + "Initial Sample Value3" + "Initial Sample Value4" + "Initial Sample Value5" + "Inspection Value1") / 4;
                "Actual Test Results Data":="Inspection Value2"; // Alle 010816
            //ALLE[5.51]
            end;
        }
        field(74; "Initial Sample Value5"; Decimal)
        {
            AutoFormatType = 2;
            DataClassification = CustomerContent;
            Caption = 'Initial Sample Value5';

            trigger OnValidate()
            begin
                /*IF "Template Type" <>"Template Type"::Manufacturing THEN
                  ERROR('');
                */
                //Alle[5.51]
                if("Initial Sample Value1" + "Initial Sample Value2" + "Initial Sample Value3" + "Initial Sample Value4" + "Initial Sample Value5" + "Inspection Value1") > 0 then "Inspection Value2":=("Initial Sample Value1" + "Initial Sample Value2" + "Initial Sample Value3" + "Initial Sample Value4" + "Initial Sample Value5" + "Inspection Value1") / 5;
                "Actual Test Results Data":="Inspection Value2"; // Alle 010816
            //ALLE[5.51]
            end;
        }
        field(75; "Ref. Order No."; Code[20])
        {
            CalcFormula = lookup("SSD Quality Order Header"."Order No." where("No."=field("Document No.")));
            Editable = false;
            FieldClass = FlowField;
            Caption = 'Ref. Order No.';
        }
        field(80; "Test 1"; Text[30])
        {
            DataClassification = CustomerContent;
            Caption = 'Test 1';

            trigger OnValidate()
            begin
                //Alle
                Remark:="Test 1";
            //Alle VK 5.51
            end;
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
        field(90; "Test 11"; Text[30])
        {
            DataClassification = CustomerContent;
            Caption = 'Test 11';
        }
        field(91; "Test 12"; Text[30])
        {
            DataClassification = CustomerContent;
            Caption = 'Test 12';
        }
        field(92; "Test 13"; Text[30])
        {
            DataClassification = CustomerContent;
            Caption = 'Test 13';
        }
        field(93; "Test 14"; Text[30])
        {
            DataClassification = CustomerContent;
            Caption = 'Test 14';
        }
        field(94; "Test 15"; Text[30])
        {
            DataClassification = CustomerContent;
            Caption = 'Test 15';
        }
        field(95; "Test 16"; Text[30])
        {
            DataClassification = CustomerContent;
            Caption = 'Test 16';
        }
        field(96; "Test 17"; Text[30])
        {
            DataClassification = CustomerContent;
            Caption = 'Test 17';
        }
        field(97; "Test 18"; Text[30])
        {
            DataClassification = CustomerContent;
            Caption = 'Test 18';
        }
        field(98; "Test 19"; Text[30])
        {
            DataClassification = CustomerContent;
            Caption = 'Test 19';
        }
        field(99; "Test 20"; Text[30])
        {
            DataClassification = CustomerContent;
            Caption = 'Test 20';
        }
        field(100; "Test 21"; Text[30])
        {
            DataClassification = CustomerContent;
            Caption = 'Test 21';
        }
        field(101; "Test 22"; Text[30])
        {
            DataClassification = CustomerContent;
            Caption = 'Test 22';
        }
        field(102; "Test 23"; Text[30])
        {
            DataClassification = CustomerContent;
            Caption = 'Test 23';
        }
        field(103; "Test 24"; Text[30])
        {
            DataClassification = CustomerContent;
            Caption = 'Test 24';
        }
        field(104; "Test 25"; Text[30])
        {
            DataClassification = CustomerContent;
            Caption = 'Test 25';
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
            TableRelation = "Work Center"."No." where("Responsibility Center"=field("Responsibility Center"));
            DataClassification = CustomerContent;
            Caption = 'Process / Operation';
        }
        field(50003; "Inspection Value1"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Inspection Value1';

            trigger OnValidate()
            begin
                /*
                IF "Template Type" <>"Template Type"::Routing THEN
                  ERROR('');
                */
                //Alle[5.51]
                if("Initial Sample Value1" + "Initial Sample Value2" + "Initial Sample Value3" + "Initial Sample Value4" + "Initial Sample Value5" + "Inspection Value1") > 0 then "Inspection Value2":=("Initial Sample Value1" + "Initial Sample Value2" + "Initial Sample Value3" + "Initial Sample Value4" + "Initial Sample Value5" + "Inspection Value1") / 6;
                "Actual Test Results Data":="Inspection Value2"; // Alle 010816
            //ALLE[5.51]
            end;
        }
        field(50004; "Inspection Value2"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Inspection Value2';

            trigger OnValidate()
            begin
            /*
                IF "Template Type" <>"Template Type"::Routing THEN
                  ERROR('');
                */
            //.................Code Written By Umang For Actual Test Results Data field.............
            //"Actual Test Results Data" := "Inspection Value2";
            end;
        }
        field(50005; "Inspection Value3"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Inspection Value3';

            trigger OnValidate()
            begin
            /*
                IF "Template Type" <>"Template Type"::Routing THEN
                  ERROR('');
                */
            end;
        }
        field(50006; "Inspection Value4"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Inspection Value4';

            trigger OnValidate()
            begin
            /*
                IF "Template Type" <>"Template Type"::Routing THEN
                  ERROR('');
                */
            end;
        }
        field(50007; "Inspection Value5"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Inspection Value5';

            trigger OnValidate()
            begin
            /*
                IF "Template Type" <>"Template Type"::Routing THEN
                  ERROR('');
                */
            end;
        }
        field(50008; "Inspection Value6"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Inspection Value6';

            trigger OnValidate()
            begin
            /*
                IF "Template Type" <>"Template Type"::Routing THEN
                  ERROR('');
                */
            end;
        }
        field(50009; "Inspection Value7"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Inspection Value7';

            trigger OnValidate()
            begin
                if "Template Type" <> "template type"::Routing then Error('');
            end;
        }
        field(50010; "Inspection Value8"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Inspection Value8';

            trigger OnValidate()
            begin
                if "Template Type" <> "template type"::Routing then Error('');
            end;
        }
        field(50012; Remark; Text[50])
        {
            Description = 'Alle vk5.51';
            DataClassification = CustomerContent;
            Caption = 'Remark';
        }
        field(50013; "Value to be Print"; Boolean)
        {
            Description = 'Alle vk5.51';
            DataClassification = CustomerContent;
            Caption = 'Value to be Print';
        }
        field(50014; "Quality Pass"; Boolean)
        {
            Description = 'Alle ALLE[5.51]';
            DataClassification = CustomerContent;
            Caption = 'Quality Pass';
        }
        field(50015; "Actual Test Results Data"; Decimal)
        {
            Description = 'alle us';
            DataClassification = CustomerContent;
            Caption = 'Actual Test Results Data';
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
            Description = 'ALLE-AU';
            OptionCaption = ' ,Plastic,Paper,Lubricants,Petroleum,Misc,Plastic & PP+';
            OptionMembers = " ", Plastic, Paper, Lubricants, Petroleum, Misc, "Plastic & PP+";
            DataClassification = CustomerContent;
            Caption = 'Group';
        }
        field(50022; UCL; Decimal)
        {
            Description = 'ALLE-AU';
            DataClassification = CustomerContent;
            Caption = 'UCL';
        }
        field(50023; LCL; Decimal)
        {
            Description = 'ALLE-NM';
            DataClassification = CustomerContent;
            Caption = 'LCL';
        }
        field(50024; "Description 3"; Text[300])
        {
            Description = 'ALLE-AT';
            DataClassification = CustomerContent;
            Caption = 'Description 3';
        }
    }
    keys
    {
        key(Key1; "Document No.", "Line No.")
        {
            Clustered = true;
        }
        key(Key2; "Test No.", "Document No.", "Sampling Template No.")
        {
        }
    }
    fieldgroups
    {
    }
    trigger OnDelete()
    var
        rQualityComent: Record "SSD Quality Comments";
    begin
        StatusTest;
        rQualityComent.Reset;
        rQualityComent.SetRange(rQualityComent.TableId, Database::"SSD Quality Order Line");
        rQualityComent.SetRange(rQualityComent."Doc. No.", "Document No.");
        rQualityComent.SetRange(rQualityComent."Line No.", "Line No.");
        if rQualityComent.Find('-')then rQualityComent.DeleteAll;
    end;
    trigger OnInsert()
    begin
        StatusTest;
    end;
    trigger OnModify()
    var
        bol1: Boolean;
        bol2: Boolean;
    begin
        StatusTest;
        //<<< ALLE[5.51]
        if "Meas. Value Type" = "meas. value type"::Flag then begin
            if not "Quality Pass" then if Confirm('Quality Pass not cheked.Do you want to continue', false, bol1)then exit;
        end
        else
        begin
            //ALLE-AU
            if(LCL <> 0) and (UCL <> 0)then begin
                if(("Inspection Value2" < LCL)) and (("Inspection Value2" > "Minimum Value") and ("Inspection Value2" < "Maximum Value"))then begin
                    Message('Average Value is less than LCL. Seek approval before proceeding.');
                end
                else if(("Inspection Value2" > UCL)) and (("Inspection Value2" > "Minimum Value") and ("Inspection Value2" < "Maximum Value"))then begin
                        Message('Average Value is more than UCL. Seek approval before proceeding.');
                        exit;
                    end;
                if("Inspection Value2" < "Minimum Value") or ("Inspection Value2" > "Maximum Value")then begin
                    Message('Average Value is less/ More than Min/ Max. Feed Approver name to proceed.');
                    exit;
                end;
            end;
        end;
    //>>> ALLE[5.51]
    end;
    trigger OnRename()
    begin
        StatusTest;
    end;
    var QualityMeasurements: Record "SSD Quality Measurements";
    QualitySamplingHead: Record "SSD Sampling Test Header";
    SamplingTestLine: Record "SSD Sampling Test Line";
    NextEntryNo: Integer;
    SamplingDocLin: Record "SSD Quality Order Line";
    Text001: label 'Quantity cannot be more than %1';
    QualityOrderHeader: Record "SSD Quality Order Header";
    SamplingTestHeader: Record "SSD Sampling Test Header";
    procedure StatusTest()
    var
        txt00001: label '%1 must not be as %2 in %3';
        SamplingDocHeaderLocal: Record "SSD Quality Order Header";
    begin
        if SamplingDocHeaderLocal.Get("Document No.")then begin
            SamplingDocHeaderLocal.TestField(Status, SamplingDocHeaderLocal.Status::Open);
            SamplingDocHeaderLocal.TestField(Finished, false);
        end;
    end;
    procedure ShowComent()
    var
        rQualityComent: Record "SSD Quality Comments";
        fQualityComent: Page "Quality Comments";
    begin
        rQualityComent.Reset;
        rQualityComent.FilterGroup(2);
        rQualityComent.SetRange(rQualityComent.TableId, Database::"SSD Quality Order Line");
        rQualityComent.SetRange(rQualityComent."Doc. No.", "Document No.");
        rQualityComent.SetRange(rQualityComent."Line No.", "Line No.");
        rQualityComent.FilterGroup(0);
        fQualityComent.SetTableview(rQualityComent);
        fQualityComent.Run;
    end;
    local procedure SumaNoBuenas()
    begin
    //"No-good Units" := "Units to Wrongs" + "Units to Scrapping" + "Units to Reclass." + "Units to Reprocess";
    end;
}
