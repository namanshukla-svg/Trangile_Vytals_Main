table 55003 SSDPoolUpdateTableN
{
    Caption = 'SSDPoolUpdateTableN';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Code"; Code[20])
        {
            Caption = 'Code';
            DataClassification = CustomerContent;
        }
        field(2; "Sales Region"; Enum "Sales Region")
        {
            Caption = 'Category';
            DataClassification = CustomerContent;
        }
        field(3; "Billing(MTD)"; Decimal)
        {
            Caption = 'Billing(MTD)';
            DataClassification = CustomerContent;
        }
        field(4; Pending; Decimal)
        {
            Caption = 'Pending';
            DataClassification = CustomerContent;
        }
        field(5; "Sales Return(MTD)"; Decimal)
        {
            Caption = 'Sales Return(MTD)';
            DataClassification = CustomerContent;
        }
        field(6; "Group No."; Text[10])
        {
            Caption = 'Group';
            DataClassification = CustomerContent;
        }
        field(7; "Billing(YTD)"; Decimal)
        {
            Caption = 'Billing(YTD)';
            DataClassification = CustomerContent;
        }
        field(8; "Sales Return(YTD)"; Decimal)
        {
            Caption = 'Sales Return(YTD)';
            DataClassification = CustomerContent;
        }
        field(9; "Total Pending Pool"; Decimal)
        {
            Caption = 'Total Pending Pool';
            DataClassification = CustomerContent;
        }
    }
    keys
    {
        key(PK; "Code", "Sales Region")
        {
            Clustered = true;
        }
    }
}
