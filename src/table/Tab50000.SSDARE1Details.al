table 50000 "SSD ARE1 Details"
{
    DataClassification = CustomerContent;

    fields
    {
        field(1; "ARE1 No."; Code[20])
        {
            Caption = 'ARE1 No.';
            DataClassification = CustomerContent;
        }
        field(2; "ARE1 Line No."; Integer)
        {
            Caption = 'ARE1 Line No.';
            DataClassification = CustomerContent;
        }
        field(3; "Sales Inv No."; Code[20])
        {
            Caption = 'Sales Inv No.';
            DataClassification = CustomerContent;
        }
        field(4; "Sales Inv Date"; Date)
        {
            Caption = 'Sales Inv Date';
            DataClassification = CustomerContent;
        }
        field(5; "Customer No."; Code[20])
        {
            TableRelation = Customer;
            Caption = 'Customer No.';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                if Cust.Get("Customer No.")then "Customer Name":=Cust.Name;
            end;
        }
        field(6; "Customer Name"; Text[100])
        {
            Caption = 'Customer Name';
            DataClassification = CustomerContent;
        }
        field(7; "Item No."; Code[20])
        {
            TableRelation = Item;
            Caption = 'Item No.';
            DataClassification = CustomerContent;
        }
        field(8; Description; Text[100])
        {
            Caption = 'Description';
            DataClassification = CustomerContent;
        }
        field(9; Quantity; Decimal)
        {
            Caption = 'Quantity';
            DataClassification = CustomerContent;
        }
        field(10; "Unit of Measure Code"; Code[10])
        {
            TableRelation = "Unit of Measure";
            Caption = 'Unit of Measure Code';
            DataClassification = CustomerContent;
        }
        field(11; "Unit Cost"; Decimal)
        {
            Caption = 'Unit Cost';
            DataClassification = CustomerContent;
        }
        field(12; "Line Amount"; Decimal)
        {
            Caption = 'Line Amount';
            DataClassification = CustomerContent;
        }
        field(13; "BED Amount"; Decimal)
        {
            Caption = 'BED Amount';
            DataClassification = CustomerContent;
        }
        field(14; "Ecess Amount"; Decimal)
        {
            Caption = 'Ecess Amount';
            DataClassification = CustomerContent;
        }
        field(15; "SHE Cess Amount"; Decimal)
        {
            Caption = 'SHE Cess Amount';
            DataClassification = CustomerContent;
        }
        field(16; "Tax Amount"; Decimal)
        {
            Caption = 'Tax Amount';
            DataClassification = CustomerContent;
        }
        field(17; "Tax %"; Decimal)
        {
            Caption = 'Tax %';
            DataClassification = CustomerContent;
        }
        field(18; "Amount to Customer"; Decimal)
        {
            Caption = 'Amount to Customer';
            DataClassification = CustomerContent;
        }
        field(19; "Sales Order No."; Code[20])
        {
            Caption = 'Sales Order No.';
            DataClassification = CustomerContent;
        }
        field(20; "Sales Inv Line No."; Integer)
        {
            Caption = 'Sales Inv Line No.';
            DataClassification = CustomerContent;
        }
        field(21; "ARE1 Type"; Option)
        {
            OptionMembers = " ", ARE1, ARE2, ARE3;
            Caption = 'ARE1 Type';
            DataClassification = CustomerContent;
        }
        field(22; "Despatch Slip No."; Code[20])
        {
            Caption = 'Despatch Slip No.';
            DataClassification = CustomerContent;
        }
        field(23; "Despatch Slip Line No."; Integer)
        {
            Caption = 'Despatch Slip Line No.';
            DataClassification = CustomerContent;
        }
        field(85002; "Excise Bus Posting Group(ARE)"; Code[10])
        {
            Caption = 'Excise Bus Posting Group(ARE)';
            DataClassification = CustomerContent;
        }
        field(85003; "Excise Amount(ARE)"; Decimal)
        {
            Description = 'ALLE 3.14';
            Caption = 'Excise Amount(ARE)';
            DataClassification = CustomerContent;
        }
        field(85004; "BED Amount(ARE)"; Decimal)
        {
            Description = 'ALLE 3.14';
            Caption = 'BED Amount(ARE)';
            DataClassification = CustomerContent;
        }
        field(85005; "AED(GSI) Amount(ARE)"; Decimal)
        {
            Description = 'ALLE 3.14';
            Caption = 'AED(GSI) Amount(ARE)';
            DataClassification = CustomerContent;
        }
        field(85006; "AED(TTA) Amount(ARE)"; Decimal)
        {
            Description = 'ALLE 3.14';
            Caption = 'AED(TTA) Amount(ARE)';
            DataClassification = CustomerContent;
        }
        field(85007; "SED Amount(ARE)"; Decimal)
        {
            Description = 'ALLE 3.14';
            Caption = 'SED Amount(ARE)';
            DataClassification = CustomerContent;
        }
        field(85008; "SAED Amount(ARE)"; Decimal)
        {
            Description = 'ALLE 3.14';
            Caption = 'SAED Amount(ARE)';
            DataClassification = CustomerContent;
        }
        field(85009; "Cess Amount(ARE)"; Decimal)
        {
            Description = 'ALLE 3.14';
            Caption = 'Cess Amount(ARE)';
            DataClassification = CustomerContent;
        }
        field(85010; "NCCD Amount(ARE)"; Decimal)
        {
            Description = 'ALLE 3.14';
            Caption = 'NCCD Amount(ARE)';
            DataClassification = CustomerContent;
        }
        field(85011; "eCess Amount(ARE)"; Decimal)
        {
            Description = 'ALLE 3.14';
            Caption = 'eCess Amount(ARE)';
            DataClassification = CustomerContent;
        }
        field(85012; "ADET Amount(ARE)"; Decimal)
        {
            Description = 'ALLE 3.14';
            Caption = 'ADET Amount(ARE)';
            DataClassification = CustomerContent;
        }
        field(85013; "ADE Amount(ARE)"; Decimal)
        {
            Description = 'ALLE 3.14';
            Caption = 'ADE Amount(ARE)';
            DataClassification = CustomerContent;
        }
        field(85014; "SHE Cess Amount(ARE)"; Decimal)
        {
            Description = 'ALLE 3.14';
            Caption = 'SHE Cess Amount(ARE)';
            DataClassification = CustomerContent;
        }
        field(85015; "Custom eCess Amount(ARE)"; Decimal)
        {
            Description = 'ALLE 3.14';
            Caption = 'Custom eCess Amount(ARE)';
            DataClassification = CustomerContent;
        }
        field(85016; "Custom SHECess Amount(ARE)"; Decimal)
        {
            Description = 'ALLE 3.14';
            Caption = 'Custom SHECess Amount(ARE)';
            DataClassification = CustomerContent;
        }
        field(85017; "ADC VAT Amount(ARE)"; Decimal)
        {
            Description = 'ALLE 3.14';
            Caption = 'ADC VAT Amount(ARE)';
            DataClassification = CustomerContent;
        }
        field(85018; "Excise Effective Rate(ARE)"; Decimal)
        {
            Description = 'ALLE 3.14';
            Caption = 'Excise Effective Rate(ARE)';
            DataClassification = CustomerContent;
        }
        field(85019; "Amount Including Excise(ARE)"; Decimal)
        {
            Description = 'ALLE 3.14';
            Caption = 'Amount Including Excise(ARE)';
            DataClassification = CustomerContent;
        }
        field(85020; "CT2 Form"; Code[20])
        {
            Description = 'ALLE 3.15';
            Caption = 'CT2 Form';
            DataClassification = CustomerContent;
        }
        field(85021; "CT2 Line No."; Integer)
        {
            Description = 'ALLE 3.15';
            Caption = 'CT2 Line No.';
            DataClassification = CustomerContent;
        }
        field(85022; "CT3 Form"; Code[20])
        {
            Description = 'ALLE 3.16';
            Caption = 'CT3 Form';
            DataClassification = CustomerContent;
        }
        field(85023; "CT3 Line No."; Integer)
        {
            Description = 'ALLE 3.16';
            Caption = 'CT3 Line No.';
            DataClassification = CustomerContent;
        }
    }
    keys
    {
        key(Key1; "ARE1 Type", "ARE1 No.", "ARE1 Line No.")
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
    }
    var Cust: Record Customer;
}
