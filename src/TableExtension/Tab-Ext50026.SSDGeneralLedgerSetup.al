TableExtension 50026 "SSD General Ledger Setup" extends "General Ledger Setup"
{
    fields
    {
        field(50000; CustBlock; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'CustBlock';
        }
        field(50001; "Amazon Freight GL"; Code[20])
        {
            Description = 'Alle-[Amazon-HG]';
            TableRelation = "G/L Account"."No.";
            DataClassification = CustomerContent;
            Caption = 'Amazon Freight GL';
        }
        field(75000; "Maximum Cash Receipt Limit"; Decimal)
        {
            Description = 'ALLE 2.17';
            DataClassification = CustomerContent;
            Caption = 'Maximum Cash Receipt Limit';
        }
        field(75001; "Maximum Cash Payment Limit"; Decimal)
        {
            Description = 'ALLE 2.18';
            DataClassification = CustomerContent;
            Caption = 'Maximum Cash Payment Limit';
        }
        field(50002; "Sandbox Mobile No."; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Sandbox Mobile No.';
        }
        field(50003; "Sandbox Email Id"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Sandbox Email Id';
        }
        field(50004; "SSD GSP App Id"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'SSD GSP App Id';
        }
        field(50005; "SSD GSP App Pwd"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'SSD GSP App Pwd';
        }
        field(50006; "SSD Request ID"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'SSD Request ID';
        }
        field(50007; "SSD Activate Item Vendor"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Activate Item Vendor';
        }
    }
}
