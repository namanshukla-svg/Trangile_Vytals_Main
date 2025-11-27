TableExtension 50029 "SSD G/L Entry" extends "G/L Entry"
{
    fields
    {
        field(50001; "Responsibility Center"; Code[20])
        {
            Description = 'MSI.RC';
            TableRelation = "Responsibility Center";
            DataClassification = CustomerContent;
            Caption = 'Responsibility Center';
        }
        field(50003; "User ID (Voucher)"; Code[20])
        {
            Description = 'Alle VPB';
            DataClassification = CustomerContent;
            Caption = 'User ID (Voucher)';
        }
        field(70003; "Delivery Challan No."; Code[20])
        {
            Description = 'CML-009';
            DataClassification = CustomerContent;
            Caption = 'Delivery Challan No.';
        }
        field(75001; "Transfer Type"; Option)
        {
            Description = 'ALLE 2.15';
            OptionMembers = " ",NEFT,RTGS;
            DataClassification = CustomerContent;
            Caption = 'Transfer Type';
        }
        field(75002; "Vendor Bank Account"; Code[20])
        {
            Description = 'ALLE 2.15';
            TableRelation = "Bank Account"."No.";
            DataClassification = CustomerContent;
            Caption = 'Vendor Bank Account';
        }
        field(75003; "NEFT / RTGS Code"; Code[20])
        {
            Description = 'ALLE 2.15';
            DataClassification = CustomerContent;
            Caption = 'NEFT / RTGS Code';
        }
        field(90000; Ignored; Boolean)
        {
            Caption = 'Ignored';
            FieldClass = FlowField;
            CalcFormula = exist("G/L Account" where("No." = field("G/L Account No."), "Ignore Budget" = const(true)));
        }
    }
}
