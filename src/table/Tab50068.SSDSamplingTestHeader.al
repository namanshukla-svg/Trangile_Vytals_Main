Table 50068 "SSD Sampling Test Header"
{
    Caption = 'Sampling Test Header';
    DataCaptionFields = "No.", Description;
    DrillDownPageID = "Sample Test List";
    LookupPageID = "Sample Test List";
    DataClassification = CustomerContent;

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
            Description = 'ALLE[551] date-19-6-12';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                if "No." <> xRec."No." then begin
                    //SSD if "Responsibility Center" = '' then
                    //SSD "Responsibility Center" := UserMgt.GetRespCenterFilter;
                    SetupQuality.Get("Responsibility Center");
                    //SSD NoSeriesManagement.TestManual(SetupQuality."Sample Test Nos.");
                    "Series No.":='';
                end;
            end;
        }
        field(2; Description; Text[50])
        {
            Caption = 'Description';
            DataClassification = CustomerContent;
        }
        field(3; Status; Option)
        {
            Caption = 'Status';
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
        field(4; "Last Date Modified"; Date)
        {
            Caption = 'Last Date Modified';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(5; "Approved by"; Code[20])
        {
            Caption = 'Approved by';
            TableRelation = User;
            DataClassification = CustomerContent;
        }
        field(6; "Approved Date"; Date)
        {
            Caption = 'Approved Date';
            DataClassification = CustomerContent;
        }
        field(7; Edition; Code[10])
        {
            Caption = 'Edition';
            DataClassification = CustomerContent;
        }
        field(8; Review; Code[10])
        {
            Caption = 'Review';
            DataClassification = CustomerContent;
        }
        field(9; "Entry User"; Code[20])
        {
            Caption = 'Entry User';
            DataClassification = CustomerContent;
        }
        field(10; "Series No."; Code[10])
        {
            Caption = 'Series No.';
            TableRelation = "No. Series";
            DataClassification = CustomerContent;
        }
        field(23; Comments; Boolean)
        {
            CalcFormula = exist("SSD Quality Comments" where(TableId=const(62850), "Doc. No."=field("No.")));
            Caption = 'Comments';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50001; "Responsibility Center"; Code[10])
        {
            Caption = 'Responsibility Center';
            TableRelation = "Responsibility Center";
            DataClassification = CustomerContent;
        }
        field(50002; Remarks; Text[200])
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
    // rQualityComent.SETRANGE( rQualityComent.TableId,DATABASE::"Sampling Test Header");
    // rQualityComent.SETRANGE( rQualityComent."Doc. No.", "No.");
    // rQualityComent.SETRANGE( rQualityComent."Line No.", 0);
    // IF rQualityComent.FIND('-') THEN
    //  rQualityComent.DELETEALL;
    //Alle Event End
    end;
    trigger OnInsert()
    begin
        "Entry User":=UserId;
        "Last Date Modified":=WorkDate;
    //SSD Comment Start
    // if "Responsibility Center" = '' then
    //     "Responsibility Center" := UserMgt.GetRespCenterFilter;
    // if "No." = '' then begin
    //     SetupQuality.Get("Responsibility Center");
    //     SetupQuality.TestField("Sample Test Nos.");
    //     "Series No." := SetupQuality."Sample Test Nos.";
    //     NoSeriesManagement.InitSeries("Series No.", xRec."Series No.", WorkDate, "No.", "Series No.");
    // end;
    //SSD Comment End
    end;
    trigger OnModify()
    begin
        StatusChecking(Rec);
        "Entry User":=UserId;
        "Last Date Modified":=WorkDate;
    end;
    var SetupQuality: Record "SSD Quality Setup";
    //NoSeriesManagement: Codeunit NoSeriesManagement;
    //UserMgt: Codeunit "SSD User Setup Management";
    Text0001: label 'Modification/Deletion cannot be possible\  when %1 is %2';
    procedure Print(MostrarFormSoli: Boolean)
    var
        SelectReportsQuality: Record "Report Selections";
        QualitySamplingHead: Record "SSD Sampling Test Header";
    begin
        QualitySamplingHead.Copy(Rec);
        QualitySamplingHead.SetRecfilter;
        SelectReportsQuality.SetRange(Usage, SelectReportsQuality.Usage::"S.Work Order");
        SelectReportsQuality.SetFilter("Report ID", '<>0');
        SelectReportsQuality.Find('-');
        repeat Report.RunModal(SelectReportsQuality."Report ID", MostrarFormSoli, false, QualitySamplingHead);
        until SelectReportsQuality.Next = 0;
    end;
    procedure AsistEdic(RecQualitySampHead: Record "SSD Sampling Test Header"): Boolean var
        QualitySampHeadLocal: Record "SSD Sampling Test Header";
    begin
        QualitySampHeadLocal:=Rec;
    //SSD Comment Start
    // if "Responsibility Center" = '' then
    //     "Responsibility Center" := UserMgt.GetRespCenterFilter;
    // SetupQuality.Get("Responsibility Center");
    // if NoSeriesManagement.SelectSeries(SetupQuality."Sample Test Nos.", RecQualitySampHead."Series No.", "Series No.") then begin
    //     SetupQuality.Ge "SSD Quality Comments" Center ");
    //     NoSeriesManagement.SetSeries("No.");
    //     Rec := QualitySampHeadLocal;
    //     exit(true);
    // end;
    //SSD Comment End
    end;
    procedure ShowComent()
    var
        rQualityComent: Record "SSD Quality Comments";
        fQualityComent: Page "Quality Comments";
    begin
        rQualityComent.Reset;
        rQualityComent.FilterGroup(2);
        rQualityComent.SetRange(rQualityComent.TableId, Database::"SSD Sampling Test Header");
        rQualityComent.SetRange(rQualityComent."Doc. No.", "No.");
        rQualityComent.SetRange(rQualityComent."Line No.", 0);
        rQualityComent.FilterGroup(0);
        fQualityComent.SetTableview(rQualityComent);
        fQualityComent.Run;
    end;
    procedure StatusChecking(RecSamplingTestHeader: Record "SSD Sampling Test Header")
    begin
        if RecSamplingTestHeader.Status = RecSamplingTestHeader.Status::Certified then Error(Text0001, RecSamplingTestHeader.FieldCaption(Status), Format(RecSamplingTestHeader.Status));
        if RecSamplingTestHeader.Status = RecSamplingTestHeader.Status::Blocked then Error(Text0001, RecSamplingTestHeader.FieldCaption(Status), Format(RecSamplingTestHeader.Status));
    end;
}
