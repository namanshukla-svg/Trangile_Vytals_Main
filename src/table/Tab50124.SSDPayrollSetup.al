Table 50124 "SSD Payroll Setup"
{
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Pay Element"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Pay Element';
        }
        field(2; "Shortcut Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,2,1';
            Caption = 'Shortcut Dimension 1 Code';
            DataClassification = CustomerContent;
            TableRelation = "Dimension Value".Code where("Global Dimension No."=const(1));
        }
        field(3; "G/L Account No"; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = "G/L Account"."No.";
            Caption = 'G/L Account No';
        }
        field(4; Type; Option)
        {
            DataClassification = CustomerContent;
            OptionCaption = ' ,Payroll,Claim';
            OptionMembers = " ", Payroll, Claim;
            Caption = 'Type';
        }
        field(5; "Debit/Credit"; Option)
        {
            OptionCaption = ' ,Debit,Credit';
            OptionMembers = " ", Debit, Credit;
            Caption = 'Debit/Credit';
            DataClassification = CustomerContent;
        }
        field(6; "Emp Location"; Option)
        {
            OptionCaption = ' ,Corporate,Plant';
            OptionMembers = " ", Corporate, Plant;
            Caption = 'Emp Location';
            DataClassification = CustomerContent;
        }
        field(7; "Emp Contribution"; Code[20])
        {
            Caption = 'Emp Contribution';
            DataClassification = CustomerContent;
        }
    }
    keys
    {
        key(Key1; "Pay Element", "Emp Location")
        {
            Clustered = true;
        }
        key(Key2; "Shortcut Dimension 1 Code")
        {
        }
    }
    fieldgroups
    {
    }
    var DimMgt: Codeunit DimensionManagement;
    procedure ValidateShortcutDimCode(FieldNumber: Integer; var ShortcutDimCode: Code[20])
    begin
        DimMgt.ValidateDimValueCode(FieldNumber, ShortcutDimCode);
    end;
}
