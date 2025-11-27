Table 50074 "SSD Vendor Eval. Header"
{
    Caption = 'Vendor Eval. Header';
    DrillDownPageID = "Vendor Eval. Header";
    LookupPageID = "Vendor Eval. Header";
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
                    //SSD if "Responsibility Center" = '' then
                    //SSD "Responsibility Center" := UserMgt.GetRespCenterFilter;
                    SetupQuality.Get("Responsibility Center");
                    //SSD NoSeriesManagement.TestManual(SetupQuality."Vendor Eval. Nos.");
                    "Series No.":='';
                end;
            end;
        }
        field(2; "Eval. Template No."; Code[10])
        {
            Caption = 'Template Eval. No.';
            Editable = false;
            NotBlank = true;
            TableRelation = "SSD Vendor Eval. Template";
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                if not VendEvalTempHead.Get("Eval. Template No.")then VendEvalTempHead.Init;
                "Template Name":=VendEvalTempHead.Description;
                VendEvalTempHead.TestField(Status, VendEvalTempHead.Status::Certified);
                Status:=VendEvalTempHead.Status;
                "Approved by":=VendEvalTempHead."Approved by";
                "Approved Date":=VendEvalTempHead."Approved Date";
                Edition:=VendEvalTempHead.Edition;
                Review:=VendEvalTempHead.Review;
                VendEvalTempCard.Reset;
                VendEvalTempCard.SetRange("Eval. Template No.", "Eval. Template No.");
                if VendEvalTempCard.Find('-')then repeat VendEvalLin.Init;
                        VendEvalLin."Document No.":="No.";
                        VendEvalLin."Line No.":=VendEvalTempCard."Line No.";
                        VendEvalLin."Eval. Template No.":="Eval. Template No.";
                        VendEvalLin."Template Lin. No.":=VendEvalTempCard."Line No.";
                        VendEvalLin.Code:=VendEvalTempCard.Code;
                        VendEvalLin.Concept:=VendEvalTempCard.Concept;
                        VendEvalLin."1-3":=VendEvalTempCard."1-3";
                        VendEvalLin."4-7":=VendEvalTempCard."4-7";
                        VendEvalLin."8-10":=VendEvalTempCard."8-10";
                        VendEvalLin."Rating Weight":=VendEvalTempCard."Rating Weight";
                        //SSD VendEvalLin."Internal Eval." := VendEvalTempCard."Internal Eval.";
                        VendEvalLin.Insert;
                    until VendEvalTempCard.Next = 0;
            end;
        }
        field(3; "Template Name"; Text[30])
        {
            Caption = 'Template Name';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(4; Status; Option)
        {
            Caption = 'Status';
            Editable = false;
            OptionCaption = 'Blanked,Locked,Canceled';
            OptionMembers = Blanked, Locked, Canceled;
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                "Entry User":=UserId;
                "Last Date Modified":=WorkDate;
                Modify;
            end;
        }
        field(5; "Last Date Modified"; Date)
        {
            Caption = 'Last Date Modified';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(6; "Approved by"; Code[20])
        {
            Caption = 'Approved by';
            Editable = false;
            TableRelation = User;
            DataClassification = CustomerContent;
        }
        field(7; "Approved Date"; Date)
        {
            Caption = 'Approved Date';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(8; Edition; Code[10])
        {
            Caption = 'Edition';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(9; Review; Code[10])
        {
            Caption = 'Review';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(10; "Total Weight"; Decimal)
        {
            CalcFormula = sum("SSD Vendor Eval. Line"."Rating Weight" where("Document No."=field("No.")));
            Caption = 'Total Weight';
            FieldClass = FlowField;
        }
        field(11; "Series No."; Code[10])
        {
            Caption = 'Series No.';
            DataClassification = CustomerContent;
        }
        field(12; Comment; Boolean)
        {
            CalcFormula = exist("SSD Quality Comments" where(TableId=const(62865), "Doc. No."=field("No."), "Line No."=const(0)));
            Caption = 'Comment';
            Editable = false;
            FieldClass = FlowField;
        }
        field(20; "Vendor No."; Code[20])
        {
            Caption = 'Vendor No.';
            TableRelation = Vendor;
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                if not Vendor.Get("Vendor No.")then Vendor.Init;
                Name:=Vendor.Name;
                "Name 2":=Vendor."Name 2";
                Address:=Vendor.Address;
                "Address 2":=Vendor."Address 2";
                "Post Code":=Vendor."Post Code";
                City:=Vendor.City;
                County:=Vendor.County;
            end;
        }
        field(21; Name; Text[30])
        {
            Caption = 'Name';
            DataClassification = CustomerContent;
        }
        field(22; "Name 2"; Text[30])
        {
            Caption = 'Name 2';
            DataClassification = CustomerContent;
        }
        field(23; Address; Text[30])
        {
            Caption = 'Address';
            DataClassification = CustomerContent;
        }
        field(24; "Address 2"; Text[30])
        {
            Caption = 'Address 2';
            DataClassification = CustomerContent;
        }
        field(25; "Post Code"; Code[20])
        {
            Caption = 'Post Code';
            TableRelation = "Post Code";
            DataClassification = CustomerContent;
        }
        field(26; City; Text[30])
        {
            Caption = 'City';
            DataClassification = CustomerContent;
        }
        field(27; County; Text[30])
        {
            Caption = 'County';
            DataClassification = CustomerContent;
        }
        field(28; "Entry User"; Code[20])
        {
            Caption = 'Entry User';
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
        key(Key2; Status)
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
    //Alle Event Start
    // IF Status <> Status::Blanked THEN
    // ERROR( Txt00001, FIELDCAPTION( Status), FORMAT( Status), TABLECAPTION);
    //
    // rQualityComent.RESET;
    // rQualityComent.SETRANGE( rQualityComent.TableId,DATABASE::"Vendor Eval. Header");
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
        if "No." = '' then begin
            //SSD if "Responsibility Center" = '' then
            //SSD "Responsibility Center" := UserMgt.GetRespCenterFilter;
            SetupQuality.Get("Responsibility Center");
            SetupQuality.TestField("Vendor Eval. Nos.");
            "Series No.":=SetupQuality."Vendor Eval. Nos.";
        //SSD NoSeriesManagement.InitSeries("Series No.", xRec."Series No.", WorkDate, "No.", "Series No.");
        end;
    end;
    trigger OnModify()
    begin
        "Entry User":=UserId;
        "Last Date Modified":=WorkDate;
        if Status <> Status::Blanked then Error(Txt00001, FieldCaption(Status), Format(Status));
    end;
    var Txt00001: label '%1 must be %2 in order to delete %3';
    SetupQuality: Record "SSD Quality Setup";
    //SSD NoSeriesManagement: Codeunit NoSeriesManagement;
    Vendor: Record Vendor;
    VendEvalTempHead: Record "SSD Vendor Eval. Template";
    VendEvalTempCard: Record "SSD Vendor Eval. Template Line";
    VendEvalLin: Record "SSD Vendor Eval. Line";
    Txt00002: label 'Change %1 to %2?';
    //SSD UserMgt: Codeunit "SSD User Setup Management";
    procedure Print(MostrarFormSoli: Boolean)
    var
        SelectReportsQuality: Record "Report Selections";
        VendEvalHeader: Record "SSD Vendor Eval. Header";
    begin
        VendEvalHeader.Copy(Rec);
        VendEvalHeader.SetRecfilter;
        //SSD SelectReportsQuality.SetRange(Usage, SelectReportsQuality.Usage::"P. Arch. Return Order");
        SelectReportsQuality.SetFilter("Report ID", '<>0');
        SelectReportsQuality.Find('-');
        repeat //SSD Report.RunModal(SelectReportsQuality."Report ID", MostrarFormSoli, false, VendEvalHeader);
        until SelectReportsQuality.Next = 0;
    end;
    procedure AsistEdic(RecVendEvalHeader: Record "SSD Vendor Eval. Header"): Boolean var
        VendEvalHeader: Record "SSD Vendor Eval. Header";
    begin
        VendEvalHeader:=Rec;
        //SSD if "Responsibility Center" = '' then
        //SSD "Responsibility Center" := UserMgt.GetRespCenterFilter;
        SetupQuality.Get(VendEvalHeader."Responsibility Center");
    //SSD Comment Start
    // if NoSeriesManagement.SelectSeries(SetupQuality."Vendor Eval. Nos.", RecVendEvalHeader."Series No.", "Series No.") then begin
    //     SetupQuality.Get("Responsibility Center");
    //     NoSeriesManagement.SetSeries("No.");
    //     Rec := VendEvalHeader;
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
        rQualityComent.SetRange(rQualityComent.TableId, Database::"SSD Vendor Eval. Header");
        rQualityComent.SetRange(rQualityComent."Doc. No.", "No.");
        rQualityComent.SetRange(rQualityComent."Line No.", 0);
        rQualityComent.FilterGroup(0);
        fQualityComent.SetTableview(rQualityComent);
        fQualityComent.Run;
    end;
    procedure ChangeStatus(vNewStatus: Integer)
    var
        VendEvalHeaderLocal: Record "SSD Vendor Eval. Header";
    begin
        VendEvalHeaderLocal.Init;
        VendEvalHeaderLocal.Status:=vNewStatus;
        if not Confirm(Txt00002, false, FieldCaption(Status), VendEvalHeaderLocal.Status)then exit;
        "Entry User":=UserId;
        "Last Date Modified":=WorkDate;
        Status:=VendEvalHeaderLocal.Status;
        Modify;
    end;
}
