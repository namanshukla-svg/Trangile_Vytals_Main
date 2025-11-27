Table 50075 "SSD Vendor Eval. Line"
{
    Caption = 'Vendor Eval. Line';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Document No."; Code[20])
        {
            Caption = 'Document No.';
            DataClassification = CustomerContent;
        }
        field(2; "Line No."; Integer)
        {
            Caption = 'Line No.';
            DataClassification = CustomerContent;
        }
        field(3; "Eval. Template No."; Code[10])
        {
            Caption = 'Template Eval. No.';
            TableRelation = "SSD Vendor Eval. Template";
            DataClassification = CustomerContent;
        }
        field(4; "Template Lin. No."; Integer)
        {
            Caption = 'Template Lin. No.';
            DataClassification = CustomerContent;
        }
        field(5; "Code"; Code[10])
        {
            Caption = 'Code';
            TableRelation = "SSD Vendor Eval. Code";
            DataClassification = CustomerContent;
        }
        field(6; Concept; Text[50])
        {
            Caption = 'Concept';
            DataClassification = CustomerContent;
        }
        field(7; "1-3"; Text[30])
        {
            Caption = '1-3';
            DataClassification = CustomerContent;
        }
        field(8; "4-7"; Text[30])
        {
            Caption = '4-7';
            DataClassification = CustomerContent;
        }
        field(9; "8-10"; Text[30])
        {
            Caption = '8-10';
            DataClassification = CustomerContent;
        }
        field(10; "Rating Weight"; Decimal)
        {
            Caption = 'Rating Weight';
            DataClassification = CustomerContent;
        }
        field(11; Rating; Decimal)
        {
            Caption = 'Rating';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                if "Rating Weight" <> 0 then "Weighed Value":=ROUND(Rating * "Rating Weight", 0.0001)
                else
                    "Weighed Value":=Rating;
            end;
        }
        field(12; "Weighed Value"; Decimal)
        {
            Caption = 'Weighed Value';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(13; "Internal Eval."; Boolean)
        {
            Caption = 'Internal Eval.';
            DataClassification = CustomerContent;
        }
        field(14; Comment; Boolean)
        {
            CalcFormula = exist("SSD Quality Comments" where(TableId=const(62866), "Doc. No."=field("Document No."), "Line No."=field("Line No.")));
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
        key(Key1; "Document No.", "Line No.")
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
    // rQualityComent.RESET;
    // rQualityComent.SETRANGE( rQualityComent.TableId, DATABASE::"Vendor Eval. Line");
    // rQualityComent.SETRANGE( rQualityComent."Doc. No.", "Document No.");
    // rQualityComent.SETRANGE( rQualityComent."Line No.", "Line No.");
    // IF rQualityComent.FIND('-') THEN
    //  rQualityComent.DELETEALL;
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
    var txt00001: label '%1 must be as %2 in %3';
    procedure StatusTest()
    var
        VendEvalHeaderLocal: Record "SSD Vendor Eval. Header";
    begin
        if VendEvalHeaderLocal."No." <> "Document No." then VendEvalHeaderLocal.Get("Document No.");
        if VendEvalHeaderLocal.Status <> VendEvalHeaderLocal.Status::Blanked then Error(txt00001, VendEvalHeaderLocal.FieldCaption(VendEvalHeaderLocal.Status), Format(VendEvalHeaderLocal.Status), VendEvalHeaderLocal.TableCaption);
    end;
    procedure ShowComent()
    var
        rQualityComent: Record "SSD Quality Comments";
        fQualityComent: Page "Quality Comments";
    begin
        rQualityComent.Reset;
        rQualityComent.FilterGroup(2);
        rQualityComent.SetRange(rQualityComent.TableId, Database::"SSD Vendor Eval. Line");
        rQualityComent.SetRange(rQualityComent."Doc. No.", "Document No.");
        rQualityComent.SetRange(rQualityComent."Line No.", "Line No.");
        rQualityComent.FilterGroup(0);
        fQualityComent.SetTableview(rQualityComent);
        fQualityComent.Run;
    end;
}
