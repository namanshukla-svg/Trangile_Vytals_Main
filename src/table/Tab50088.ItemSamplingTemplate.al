Table 50088 "Item Sampling Template"
{
    Caption = 'Item Sampling Templates';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Item Code"; Code[20])
        {
            TableRelation = Item."No.";
            Caption = 'Item Code';
            DataClassification = CustomerContent;
        }
        field(2; "Sampling Temp. No."; Code[20])
        {
            TableRelation = "SSD Sampling Temp. Header"."No." where("Template Type"=field("Template Type"), Status=const(Certified));
            Caption = 'Sampling Temp. No.';
            DataClassification = CustomerContent;
        }
        field(3; "Template Type"; Option)
        {
            Editable = false;
            OptionCaption = 'Receipt,Manufacturing';
            OptionMembers = Receipt, Manufacturing;
            Caption = 'Template Type';
            DataClassification = CustomerContent;

            trigger OnValidate()
            var
                SamplingTempHeaderLocal: Record "SSD Sampling Temp. Header";
            begin
                SamplingTempHeaderLocal.Get("Sampling Temp. No.");
                "Template Type":=SamplingTempHeaderLocal."Template Type";
            end;
        }
        field(4; Active; Boolean)
        {
            Caption = 'Active';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                "Modification Date":=WorkDate;
                "Modified By":=UserId;
            end;
        }
        field(5; "Creation Date"; Date)
        {
            Editable = false;
            Caption = 'Creation Date';
            DataClassification = CustomerContent;
        }
        field(6; "Modification Date"; Date)
        {
            Editable = false;
            Caption = 'Modification Date';
            DataClassification = CustomerContent;
        }
        field(7; "Created By"; Code[20])
        {
            Editable = false;
            Caption = 'Created By';
            DataClassification = CustomerContent;
        }
        field(8; "Modified By"; Code[20])
        {
            Editable = false;
            Caption = 'Modified By';
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
        key(Key1; "Item Code", "Sampling Temp. No.")
        {
            Clustered = true;
        }
        key(Key2; "Item Code", "Template Type", Active)
        {
        }
        key(Key3; "Item Code", Active, "Template Type")
        {
        }
    }
    fieldgroups
    {
    }
    trigger OnDelete()
    begin
    /*IF "Sampling Temp. No."<>'' THEN
          ERROR(Text001);
         */
    end;
    trigger OnInsert()
    begin
        Active:=true;
        "Creation Date":=WorkDate;
        "Created By":=UserId;
    //SSD if "Responsibility Center" = '' then
    //SSD "Responsibility Center" := UserMgt.GetRespCenterFilter;
    end;
    trigger OnModify()
    begin
        "Modification Date":=WorkDate;
        "Modified By":=UserId;
    end;
    trigger OnRename()
    begin
        Error(Text002);
    end;
    var Text001: label 'Deletion is not allowed';
    //SSD UserMgt: Codeunit "SSD User Setup Management";
    Text002: label 'Rename is not allowed';
}
