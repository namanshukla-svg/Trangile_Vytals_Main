Table 50071 "SSD Vendor Eval. Template"
{
    Caption = 'Vendor Eval. Template';
    //SSD DrillDownPageID = "Vendor Template List";
    //SSD LookupPageID = "Vendor Template List";
    DataClassification = CustomerContent;

    fields
    {
        field(1; "No."; Code[10])
        {
            Caption = 'No.';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                if "No." <> xRec."No." then begin
                    //SSD Comment Start
                    // if "Responsibility Center" = '' then
                    //     "Responsibility Center" := UserMgt.GetRespCenterFilter;
                    // SetupQuality.Get("Responsibility Center");
                    // NoSeriesManagement.TestManual(SetupQuality."Vendor Eval. Temp. Nos.");
                    //SSD Comment End
                    "Series No." := '';
                end;
            end;
        }
        field(2; Description; Text[30])
        {
            Caption = 'Description';
            DataClassification = CustomerContent;
        }
        field(3; Status; Option)
        {
            Caption = 'Status';
            OptionCaption = 'New,Certified,Under Developing,Locked';
            OptionMembers = New,Certified,"Under Developing",Locked;
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                "Entry User" := UserId;
                "Last Date Modified" := WorkDate;
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
            Editable = false;
            TableRelation = User;
            DataClassification = CustomerContent;
        }
        field(6; "Approved Date"; Date)
        {
            Caption = 'Approved Date';
            Editable = false;
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
        field(9; "Total Weight"; Decimal)
        {
            CalcFormula = sum("SSD Vendor Eval. Template Line"."Rating Weight" where("Eval. Template No." = field("No.")));
            Caption = 'Total Weight';
            FieldClass = FlowField;
        }
        field(10; "Entry User"; Code[20])
        {
            Caption = 'Entry User';
            DataClassification = CustomerContent;
        }
        field(11; "Series No."; Code[10])
        {
            Caption = 'Series No.';
            TableRelation = "No. Series";
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
        //ALLE Event Start
        // IF Status = Status::Certified THEN
        // ERROR( txt00001, FIELDCAPTION( Status), FORMAT( Status));
        //
        // rQualityComent.RESET;
        // rQualityComent.SETRANGE( rQualityComent.TableId, DATABASE::"Vendor Eval. Template");
        // rQualityComent.SETRANGE( rQualityComent."Doc. No.", "No.");
        // rQualityComent.SETRANGE( rQualityComent."Line No.", 0);
        // IF rQualityComent.FIND('-') THEN
        //  rQualityComent.DELETEALL;
        //Alle Event End;
    end;

    trigger OnInsert()
    begin
        "Last Date Modified" := WorkDate;
        //SSD Comment Start
        // if "Responsibility Center" = '' then
        //     "Responsibility Center" := UserMgt.GetRespCenterFilter;
        // if "No." = '' then begin
        //     SetupQuality.Get("Responsibility Center");
        //     SetupQuality.TestField("Vendor Eval. Temp. Nos.");
        //     "Series No." := SetupQuality."Vendor Eval. Temp. Nos.";
        //     NoSeriesManagement.InitSeries("Series No.", xRec."Series No.", WorkDate, "No.", "Series No.");
        // end;
        //SSD Comment End
    end;

    trigger OnModify()
    begin
        "Entry User" := UserId;
        "Last Date Modified" := WorkDate;
        if Status = Status::Certified then Error(txt00001, FieldCaption(Status), Format(Status));
    end;

    var
        txt00001: label '%1 can not be as %2';
        //IG_DS  NoSeriesManagement: Codeunit NoSeriesManagement;
        SetupQuality: Record "SSD Quality Setup";
    //SSD UserMgt: Codeunit "SSD User Setup Management";
    procedure Print(MostrarFormSoli: Boolean)
    var
        SelectReportsQuality: Record "Report Selections";
        VendorEvalTempHead: Record "SSD Vendor Eval. Template";
    begin
        VendorEvalTempHead.Copy(Rec);
        VendorEvalTempHead.SetRecfilter;
        //SSD SelectReportsQuality.SetRange(Usage, SelectReportsQuality.Usage::"S. Arch. Return Order");
        SelectReportsQuality.SetFilter("Report ID", '<>0');
        SelectReportsQuality.Find('-');
        repeat
            Report.RunModal(SelectReportsQuality."Report ID", MostrarFormSoli, false, VendorEvalTempHead);
        until SelectReportsQuality.Next = 0;
    end;

    procedure AsistEdic(RecVenEvalTempHead: Record "SSD Vendor Eval. Template"): Boolean
    var
        VendEvalTempHeadLocal: Record "SSD Vendor Eval. Template";
    begin
        VendEvalTempHeadLocal := Rec;
        //SSD Comment STart
        // if "Responsibility Center" = '' then
        //     "Responsibility Center" := UserMgt.GetRespCenterFilter;
        // SetupQuality.Get("Responsibility Center");
        // if NoSeriesManagement.SelectSeries(SetupQuality."Vendor Eval. Temp. Nos.", RecVenEvalTempHead."Series No.", "Series No.") then begin
        //     SetupQuality.Get("Responsibility Center");
        //     NoSeriesManagement.SetSeries("No.");
        //     Rec := VendEval "SSD Quality Comments"
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
        rQualityComent.SetRange(rQualityComent.TableId, Database::"SSD Vendor Eval. Template");
        rQualityComent.SetRange(rQualityComent."Doc. No.", "No.");
        rQualityComent.SetRange(rQualityComent."Line No.", 0);
        rQualityComent.FilterGroup(0);
        fQualityComent.SetTableview(rQualityComent);
        fQualityComent.Run;
    end;
}
