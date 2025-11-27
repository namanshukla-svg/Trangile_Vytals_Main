table 50350 "SSD Item Charge Price"
{
    Caption = 'Item Charge Price';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Charge No."; Code[20])
        {
            Caption = 'Charge No.';
            NotBlank = true;
            TableRelation = "Item Charge";
        }
        field(2; "Vendor No."; Code[20])
        {
            Caption = 'Vendor No.';
            NotBlank = true;
            TableRelation = Vendor;

            trigger OnValidate()
            begin
                if Vendor.Get("Vendor No.")then "Currency Code":=Vendor."Currency Code";
            end;
        }
        field(3; "Currency Code"; Code[10])
        {
            Caption = 'Currency Code';
            TableRelation = Currency;
        }
        field(4; "Starting Date"; Date)
        {
            Caption = 'Starting Date';

            trigger OnValidate()
            begin
                if("Starting Date" > "Ending Date") and ("Ending Date" <> 0D)then Error(DateErr, FieldCaption("Starting Date"), FieldCaption("Ending Date"));
            end;
        }
        field(5; "Direct Unit Cost"; Decimal)
        {
            AutoFormatExpression = Rec."Currency Code";
            AutoFormatType = 2;
            Caption = 'Direct Unit Cost';
            MinValue = 0;
        }
        field(15; "Ending Date"; Date)
        {
            Caption = 'Ending Date';

            trigger OnValidate()
            begin
                Validate("Starting Date");
            end;
        }
    }
    keys
    {
        key(PK; "Charge No.", "Vendor No.", "Starting Date", "Currency Code")
        {
            Clustered = true;
        }
        key(Key1; "Vendor No.", "Charge No.", "Starting Date", "Currency Code")
        {
        }
    }
    fieldgroups
    {
        fieldgroup(DropDown; "Charge No.", "Vendor No.", "Starting Date", "Currency Code")
        {
        }
    }
    trigger OnInsert()
    begin
        TestField("Vendor No.");
        TestField("Charge No.");
    end;
    trigger OnRename()
    begin
        TestField("Vendor No.");
        TestField("Charge No.");
    end;
    var Vendor: Record Vendor;
    DateErr: Label '%1 cannot be after %2', Comment = '%1 Starting Date %2 Ending Date ';
}
