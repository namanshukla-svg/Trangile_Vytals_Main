Table 50125 "SSD Claim Setup"
{
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Expense Type"; Code[30])
        {
            DataClassification = CustomerContent;
            Caption = 'Expense Type';
        }
        field(2; "Expense Category"; Code[30])
        {
            Caption = 'Expense Category';
            DataClassification = CustomerContent;
        }
        field(3; "Shortcut Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,2,1';
            Caption = 'Shortcut Dimension 1 Code';
            DataClassification = CustomerContent;
            TableRelation = "Dimension Value".Code where("Global Dimension No."=const(1));
        }
        field(4; "G/L Account No"; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = "G/L Account"."No.";
            Caption = 'G/L Account No';
        }
        field(5; "Debit/Credit"; Option)
        {
            OptionCaption = ' ,Debit,Credit';
            OptionMembers = " ", Debit, Credit;
            Caption = 'Debit/Credit';
            DataClassification = CustomerContent;
        }
    }
    keys
    {
        key(Key1; "Expense Type", "Expense Category")
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
    }
}
