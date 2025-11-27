Table 50080 "SSD Sampling Temp. Header"
{
    Caption = 'Sampling Temp. Header';
    DrillDownPageID = "Sampling List";
    LookupPageID = "Sampling List";
    DataClassification = CustomerContent;

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                if "No." <> xRec."No." then begin
                    //SSD NoSeriesManagement.TestManual(GetNoSeries(false));
                    "No. Series":='';
                end;
            end;
        }
        field(2; "No. Series"; Code[10])
        {
            TableRelation = "No. Series";
            DataClassification = CustomerContent;
            Caption = 'No. Series';
        }
        field(3; Description; Text[30])
        {
            Caption = 'Description';
            DataClassification = CustomerContent;
        }
        field(4; "Description 2"; Text[30])
        {
            Caption = 'Description 2';
            DataClassification = CustomerContent;
        }
        field(8; "Last Date Modified"; Date)
        {
            Caption = 'Last Date Modified';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(9; "Entry User"; Code[20])
        {
            Caption = 'Entry User';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(10; "Template Type"; Option)
        {
            OptionCaption = 'Receipt,Manufacturing,Routing';
            OptionMembers = Receipt, Manufacturing, Routing;
            DataClassification = CustomerContent;
            Caption = 'Template Type';
        }
        field(11; "Approved by"; Code[20])
        {
            Caption = 'Approved by';
            TableRelation = User;
            DataClassification = CustomerContent;
        }
        field(12; "Approved Date"; Date)
        {
            Caption = 'Approved Date';
            DataClassification = CustomerContent;
        }
        field(13; "Kind of Sampling"; Code[10])
        {
            Caption = 'Kind of Sampling';
            TableRelation = "SSD Kind of Sampling";
            DataClassification = CustomerContent;
        }
        field(20; Status; Option)
        {
            Caption = 'Status';
            Editable = true;
            OptionCaption = 'New,Certified,Under Developing,Blocked';
            OptionMembers = New, Certified, "Under Developing", Blocked;
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                "Entry User":=UserId;
                "Last Date Modified":=WorkDate;
                Modify;
            end;
        }
        field(21; Edition; Code[10])
        {
            Caption = 'Edition';
            DataClassification = CustomerContent;
        }
        field(22; Review; Code[10])
        {
            Caption = 'Review';
            DataClassification = CustomerContent;
        }
        field(23; Comments; Boolean)
        {
            CalcFormula = exist("SSD Quality Comments" where(TableId=const(62800), "Doc. No."=field("No.")));
            Caption = 'Comments';
            Editable = false;
            FieldClass = FlowField;
        }
        field(25; "Sampling Method"; Option)
        {
            OptionCaption = 'Percentage,Fixed Quantity,Complete Quantity';
            OptionMembers = Percentage, "Fixed Quantity", "Complete Quantity";
            DataClassification = CustomerContent;
            Caption = 'Sampling Method';
        }
        field(26; "Percentage / Fixed Quantity"; Decimal)
        {
            Caption = 'Percentage / Fixed Quantity';
            DataClassification = CustomerContent;
        }
        field(50001; "Responsibility Center"; Code[10])
        {
            Caption = 'Responsibility Center';
            Editable = false;
            TableRelation = "Responsibility Center";
            DataClassification = CustomerContent;
        }
        field(50002; "Process / Operation No."; Code[20])
        {
            TableRelation = "Work Center"."No." where("Responsibility Center"=field("Responsibility Center"));
            DataClassification = CustomerContent;
            Caption = 'Process / Operation No.';

            trigger OnValidate()
            begin
            /*
                CASE "Template Type" OF
                  "Template Type"::Receipt:
                    BEGIN
                      IF "Process / Operation No."<>'' THEN
                        ERROR('');
                    END;
                  "Template Type"::Manufacturing:
                    BEGIN
                      IF "Process / Operation No."='' THEN
                        ERROR(Text0002);
                      CALCFIELDS("Process / Operation");
                    END;
                END;
                */
            end;
        }
        field(50003; "Process / Operation"; Text[30])
        {
            CalcFormula = lookup("Work Center"."Process / Operation" where("No."=field("Process / Operation No.")));
            Description = 'Coming from Work center "Process/Operation"';
            Editable = false;
            FieldClass = FlowField;
            Caption = 'Process / Operation';
        }
        field(50004; Remarks; Text[100])
        {
            Description = 'Alle 1.0 240918';
            DataClassification = CustomerContent;
            Caption = 'Remarks';
        }
    }
    keys
    {
        key(Key1; "No.")
        {
            Clustered = true;
        }
        key(Key2; "Template Type")
        {
        }
    }
    fieldgroups
    {
    }
    trigger OnDelete()
    var
        SamplingTempLineLocal: Record "SSD Sampling Temp. Line";
        rQualityComent: Record "SSD Quality Comments";
    begin
        StatusChecking(Rec);
    //ALLE Event Start
    // SamplingTempLineLocal.RESET;
    // SamplingTempLineLocal.SETRANGE("Document No.","No.");
    // IF SamplingTempLineLocal.FIND('-') THEN
    //  SamplingTempLineLocal.DELETEALL(TRUE);
    //
    // rQualityComent.RESET;
    // rQualityComent.SETRANGE( rQualityComent.TableId,DATABASE::"Sampling Temp. Header");
    // rQualityComent.SETRANGE( rQualityComent."Doc. No.", "No.");
    // rQualityComent.SETRANGE( rQualityComent."Line No.", 0);
    // IF rQualityComent.FIND('-') THEN
    //  rQualityComent.DELETEALL;
    //Alle Event End
    end;
    trigger OnInsert()
    begin
        //SSD if "Responsibility Center" = '' then
        //SSD "Responsibility Center" := UserMgt.GetRespCenterFilter;
        SetupQuality.Get("Responsibility Center");
        if "No." = '' then begin
            "No. Series":=GetNoSeries(true);
        //SSD NoSeriesManagement.InitSeries("No. Series", xRec."No. Series", WorkDate, "No.", "No. Series");
        end;
    end;
    trigger OnModify()
    begin
        StatusChecking(Rec);
        "Entry User":=UserId;
        "Last Date Modified":=WorkDate;
    end;
    var //SSD NoSeriesManagement: Codeunit NoSeriesManagement;
    SetupQuality: Record "SSD Quality Setup";
    SamplingHeader: Record "SSD Sampling Temp. Header";
    //SSD UserMgt: Codeunit "SSD User Setup Management";
    Text0001: label 'Modification/Deletion cannot be possible\  when %1 is %2';
    Text0002: label 'Process / Operation cannot be blank';
    procedure AsistEdic(RecSamplingHeader: Record "SSD Sampling Temp. Header"): Boolean var
        SamplingHeaderLocal: Record "SSD Sampling Temp. Header";
    begin
        SamplingHeaderLocal:=Rec;
        //SSD if "Responsibility Center" = '' then
        //SSD "Responsibility Center" := UserMgt.GetRespCenterFilter;
        SetupQuality.Get(SamplingHeaderLocal."Responsibility Center");
    //SSD Comment Start
    // if NoSeriesManagement.SelectSeries(GetNoSeries(true), RecSamplingHeader."No. Series", "No. Series") then begin
    //     SetupQuality.Get("Responsibility Center");
    //     NoSeriesManagement.SetSeries("No.");
    //     Rec := SamplingHeaderLocal;
    //     exit(true);                
    // end;
    //SSD Comment End
    end;
    procedure Print(MostrarFormSoli: Boolean)
    var
        SelectReportsQuality: Record "Report Selections";
        SamplingHeaderLocal: Record "SSD Sampling Temp. Header";
    begin
        SamplingHeaderLocal.Copy(Rec);
        SamplingHeaderLocal.SetRecfilter;
        case SamplingHeaderLocal."Template Type" of //SSD "template type"::Receipt:
        //SSD SelectReportsQuality.SetRange(Usage, SelectReportsQuality.Usage::"Invt. Period Test");
        SamplingHeaderLocal."template type"::Manufacturing: SelectReportsQuality.SetRange(Usage, SelectReportsQuality.Usage::"SM.Shipment");
        SamplingHeaderLocal."template type"::Routing: SelectReportsQuality.SetRange(Usage, SelectReportsQuality.Usage::"S.Test Prepmt.");
        end;
        SelectReportsQuality.SetFilter("Report ID", '<>0');
        SelectReportsQuality.Find('-');
        repeat Report.RunModal(SelectReportsQuality."Report ID", MostrarFormSoli, false, SamplingHeaderLocal);
        until SelectReportsQuality.Next = 0;
    end;
    procedure GetNoSeries(Verificar: Boolean): Code[10]begin
        //SSD if "Responsibility Center" = '' then
        //SSD "Responsibility Center" := UserMgt.GetRespCenterFilter;
        SetupQuality.Get("Responsibility Center");
        case "Template Type" of "template type"::Receipt: begin
            SetupQuality.TestField("Rcvd. Sampling Temp. No.");
            exit(SetupQuality."Rcvd. Sampling Temp. No.");
        end;
        "template type"::Manufacturing: begin
            SetupQuality.TestField("Manf. Sampling Temp. No.");
            exit(SetupQuality."Manf. Sampling Temp. No.");
        end;
        "template type"::Routing: begin
            SetupQuality.TestField("Routing Sampling Temp. No.");
            exit(SetupQuality."Routing Sampling Temp. No.");
        end;
        end;
    end;
    procedure ShowComent()
    var
        rQualityComent: Record "SSD Quality Comments";
        fQualityComent: Page "Quality Comments";
    begin
        rQualityComent.Reset;
        rQualityComent.FilterGroup(2);
        rQualityComent.SetRange(rQualityComent.TableId, Database::"SSD Sampling Temp. Header");
        rQualityComent.SetRange(rQualityComent."Doc. No.", "No.");
        rQualityComent.SetRange(rQualityComent."Line No.", 0);
        rQualityComent.FilterGroup(0);
        fQualityComent.SetTableview(rQualityComent);
        fQualityComent.Run;
    end;
    procedure StatusChecking(RecSamplingHeader: Record "SSD Sampling Temp. Header")
    begin
        if RecSamplingHeader.Status = RecSamplingHeader.Status::Certified then Error(Text0001, RecSamplingHeader.FieldCaption(Status), Format(RecSamplingHeader.Status));
        if RecSamplingHeader.Status = RecSamplingHeader.Status::Blocked then Error(Text0001, RecSamplingHeader.FieldCaption(Status), Format(RecSamplingHeader.Status));
    end;
}
