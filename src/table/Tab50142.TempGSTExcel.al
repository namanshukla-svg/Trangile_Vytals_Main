table 50142 "Temp GST Excel"
{
    Caption = 'Temp GST Excel';
    DataClassification = ToBeClassified;
    TableType = Temporary;

    fields
    {
        field(5; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
        }
        field(6; "G/L Account No."; Code[20])
        {
            Caption = 'G/L Account No.';
        }
        field(7; "G/L Account Name"; Text[100])
        {
            Caption = 'G/L Account Name';
        }
        field(8; "Posting Date"; Date)
        {
            Caption = 'Posting Date';
        }
        field(9; "Document Date"; Date)
        {
            Caption = 'Document Date';
        }
        field(10; "Document No."; Code[20])
        {
            Caption = 'Document Date';
        }
        field(11; "External Document No."; code[50])
        {
            Caption = 'External Document No.';
        }
        field(12; "Name"; Text[100])
        {
            Caption = 'Name';
        }
        field(13; "No."; Code[20])
        {
            Caption = 'No.';
        }
        field(15; "Posting Group"; Code[20])
        {
            Caption = 'Posting Group';
        }
        field(17; "Amount"; Decimal)
        {
            Caption = 'Amount';
        }
        field(18; "Narration"; Text[1024])
        {
            Caption = 'Naration';
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
