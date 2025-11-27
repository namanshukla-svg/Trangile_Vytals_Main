Table 50072 "SSD Vendor Eval. Template Line"
{
    Caption = 'Vendor Eval. Template Line';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Eval. Template No."; Code[10])
        {
            Caption = 'Template Eval. No.';
            TableRelation = "SSD Vendor Eval. Template";
            DataClassification = CustomerContent;
        }
        field(2; "Line No."; Integer)
        {
            Caption = 'Line No.';
            DataClassification = CustomerContent;
        }
        field(3; "Code"; Code[10])
        {
            Caption = 'Code';
            TableRelation = "SSD Vendor Eval. Code";
            DataClassification = CustomerContent;
        //SSD Comment Start
        // trigger OnValidate()
        // begin
        //     if not VendorEvalCode.Get(Code) then
        //         exit;
        //     Concept := VendorEvalCode.Concept;
        //     "1-3" := VendorEvalCode."Value 1";
        //     "4-7" := VendorEvalCode."Value 2";
        //     "8-10" := VendorEvalCode."Value 3";
        //     "Rating Weight" := VendorEvalCode."Rating Weight";
        // end;
        //SSD Comment End
        }
        field(4; Concept; Text[50])
        {
            Caption = 'Concept';
            DataClassification = CustomerContent;
        }
        field(5; "1-3"; Text[30])
        {
            Caption = '1-3';
            DataClassification = CustomerContent;
        }
        field(6; "4-7"; Text[30])
        {
            Caption = '4-7';
            DataClassification = CustomerContent;
        }
        field(7; "8-10"; Text[30])
        {
            Caption = '8-10';
            DataClassification = CustomerContent;
        }
        field(8; "Rating Weight"; Decimal)
        {
            Caption = 'Rating Weight';
            DataClassification = CustomerContent;
        }
        field(9; "Internal Eval."; Boolean)
        {
            Caption = 'Internal Eval.';
            DataClassification = CustomerContent;
        }
        field(12; Comment; Boolean)
        {
            CalcFormula = exist("SSD Quality Comments" where(TableId=const(62861), "Doc. No."=field("Eval. Template No."), "Line No."=field("Line No.")));
            Caption = 'Comment';
            Editable = false;
            FieldClass = FlowField;
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
        key(Key1; "Eval. Template No.", "Line No.")
        {
            Clustered = true;
            SumIndexFields = "Rating Weight";
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
    //ALLE Event Start
    // rQualityComent.RESET;
    // rQualityComent.SETRANGE( rQualityComent.TableId, DATABASE::"Vendor Eval. Template Line");
    // rQualityComent.SETRANGE( rQualityComent."Doc. No.", "Eval. Template No.");
    // rQualityComent.SETRANGE( rQualityComent."Line No.", "Line No.");
    // IF rQualityComent.FIND('-') THEN
    //  rQualityComent.DELETEALL;
    //ALLE Event End
    end;
    trigger OnInsert()
    begin
        StatusTest;
    end;
    trigger OnModify()
    begin
        StatusTest;
    end;
    trigger OnRename()
    begin
        StatusTest;
    end;
    var VendorEvalCode: Record "SSD Vendor Eval. Code";
    procedure StatusTest()
    var
        txt00001: label '%1 must not be as %2 in %3';
        VendEvalTempHeadLocal: Record "SSD Vendor Eval. Template";
    begin
        if VendEvalTempHeadLocal."No." <> "Eval. Template No." then VendEvalTempHeadLocal.Get("Eval. Template No.");
        IF VendEvalTempHeadLocal.Status = VendEvalTempHeadLocal.Status::Certified THEN ERROR(txt00001, VendEvalTempHeadLocal.FIELDCAPTION(VendEvalTempHeadLocal.Status), FORMAT(VendEvalTempHeadLocal.Status), VendEvalTempHeadLocal.TABLECAPTION);
    end;
    procedure ShowComent()
    var
        rQualityComent: Record "SSD Quality Comments";
        fQualityComent: Page "Quality Comments";
    begin
        rQualityComent.Reset;
        rQualityComent.FilterGroup(2);
        rQualityComent.SetRange(rQualityComent.TableId, Database::"SSD Vendor Eval. Template Line");
        rQualityComent.SetRange(rQualityComent."Doc. No.", "Eval. Template No.");
        rQualityComent.SetRange(rQualityComent."Line No.", "Line No.");
        rQualityComent.FilterGroup(0);
        fQualityComent.SetTableview(rQualityComent);
        fQualityComent.Run;
    end;
}
