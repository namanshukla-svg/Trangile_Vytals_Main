table 50356 "SSD Posted PO CheckList"
{
    Caption = 'SSD Posted Receipt CheckList';
    DataClassification = CustomerContent;

    fields
    {
        field(3; "Document No."; Code[20])
        {
            Caption = 'Document No.';
            Editable = false;
        }
        field(10; "TC Code"; Code[20])
        {
            Caption = 'TC Code';
            Editable = false;
        }
        field(11; "Line No."; Integer)
        {
            Caption = 'Line No.';
            Editable = false;
        }
        field(20; "Sequence No."; Integer)
        {
            Caption = 'Sequence No.';
            Blankzero = true;
            Editable = false;
        }
        field(25; "Sub Sequence No."; Text[5])
        {
            Caption = 'Sub Sequence No.';
            Editable = false;
        }
        field(30; Description; Text[2000])
        {
            Caption = 'Description';
            Editable = false;
        }
        field(35; "Is Header"; Boolean)
        {
            Caption = 'Is Header';
            Editable = false;
        }
        field(40; "Print on PO"; Boolean)
        {
            Caption = 'Print on PO';
            Editable = false;
        }
        field(50; "Check List"; Boolean)
        {
            Caption = 'SRN Check List';
            Editable = false;
        }
        field(60; "Attachment Required"; Boolean)
        {
            Caption = 'Attachment Required';
            Editable = false;
        }
        field(70; "SSD Attachment Type"; Code[20])
        {
            Caption = 'Attachment Type';
            DataClassification = CustomerContent;
            TableRelation = "SSD Attachment Type";
            Editable = false;
        }
        field(100; Completed; Boolean)
        {
            Caption = 'Completed';
        }
    }
    keys
    {
        key(PK; "Document No.", "TC Code", "Line No.")
        {
            Clustered = true;
        }
    }
}
