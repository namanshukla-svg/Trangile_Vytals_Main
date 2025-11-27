table 50135 "SSD Email Entries"
{
    Caption = 'SSD Email Entries';
    DataClassification = ToBeClassified;

    fields
    {
        field(5; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
            DataClassification = ToBeClassified;
        }
        field(6; "Customer No."; Code[20])
        {
            Caption = 'Customer No.';
            DataClassification = ToBeClassified;
        }
        field(7; "Customer Name"; Text[150])
        {
            Caption = 'Customer Name';
            DataClassification = ToBeClassified;
        }
        field(8; "Sales Order No."; Code[20])
        {
            Caption = 'Sales Order No.';
            DataClassification = ToBeClassified;
        }
        field(9; "TO Mail ID"; Text[500])
        {
            Caption = 'TO Mail ID';
            DataClassification = ToBeClassified;
        }
        field(10; "CC Mail ID"; Text[500])
        {
            Caption = 'CC Mail ID';
            DataClassification = ToBeClassified;
        }
        field(11; "BCC Mail ID"; Text[50])
        {
            Caption = 'BCC Mail ID';
            DataClassification = ToBeClassified;
        }
        field(12; Subject; Text[100])
        {
            Caption = 'Subject';
            DataClassification = ToBeClassified;
        }
        field(13; "LR No"; Text[50])
        {
            Caption = 'LR No';
            DataClassification = ToBeClassified;
        }
        field(14; "Invoice No."; Code[20])
        {
            Caption = 'Invoice No.';
            DataClassification = ToBeClassified;
        }
        field(15; "Technical Email ID"; Text[100])
        {
            Caption = 'Technical Email ID';
            DataClassification = ToBeClassified;
        }
        field(16; "Sales Order Email"; Text[150])
        {
            Caption = 'Sales Order Email';
            DataClassification = ToBeClassified;
        }
        field(17; "Sales Person Email"; Text[100])
        {
            Caption = 'Sales Person Email';
            DataClassification = ToBeClassified;
        }
        field(18; "Resp. CCare Exe. Email Id"; Text[150])
        {
            Caption = 'Resp. CCare Exe. Email Id';
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(PK; "Entry No.")
        {
            Clustered = true;
        }
    }
}
