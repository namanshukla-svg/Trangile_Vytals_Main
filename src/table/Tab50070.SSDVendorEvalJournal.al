Table 50070 "SSD Vendor Eval. Journal"
{
    Caption = 'Vendor Eval. Journal';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
            DataClassification = CustomerContent;
        }
        field(2; "Vendor No."; Code[20])
        {
            Caption = 'Vendor No.';
            NotBlank = true;
            TableRelation = Vendor;
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                if not Vendor.Get("Vendor No.")then Vendor.Init;
                Name:=Vendor.Name;
                Validate("Eval. Template  No.", Vendor."Vendor Eval. Template");
            end;
        }
        field(3; Name; Text[30])
        {
            Caption = 'Name';
            DataClassification = CustomerContent;
        }
        field(4; "Eval. Template  No."; Code[10])
        {
            Caption = 'Template Eval. No.';
            TableRelation = "SSD Vendor Eval. Template";
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                CalcFields("Eval. Template Status");
            end;
        }
        field(5; "Eval. Template Status"; Option)
        {
            CalcFormula = lookup("SSD Vendor Eval. Template".Status where("No."=field("Eval. Template  No.")));
            Caption = 'Template Eval. Status';
            Editable = false;
            FieldClass = FlowField;
            OptionCaption = 'New,Certified,Under Developing,Locked';
            OptionMembers = New, Certified, "Under Developing", Locked;
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
        key(Key1; "Entry No.")
        {
            Clustered = true;
        }
        key(Key2; "Vendor No.")
        {
        }
    }
    fieldgroups
    {
    }
    trigger OnInsert()
    begin
        TestField("Vendor No.");
    end;
    var Vendor: Record Vendor;
}
