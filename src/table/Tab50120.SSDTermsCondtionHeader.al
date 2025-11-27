Table 50120 "SSD Terms Condtion Header"
{
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Document No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Document No.';
        }
        field(3; Description; Text[250])
        {
            DataClassification = CustomerContent;
            Caption = 'Description';
        }
        field(4; Status; Option)
        {
            OptionCaption = 'Open,Release';
            OptionMembers = Open, Release;
            DataClassification = CustomerContent;
            Caption = 'Status';
        }
        field(5; "Header Value"; Option)
        {
            OptionMembers = " ", "Scope of Services / Work", "Special Instructions", "Payment Terms";
            DataClassification = CustomerContent;
            Caption = 'Header Value';
        }
        field(6; "Line No."; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Line No.';
        }
        field(7; "Description 2"; Text[250])
        {
            DataClassification = CustomerContent;
            Caption = 'Description 2';
        }
    }
    keys
    {
        key(Key1; "Document No.", "Line No.")
        {
            Clustered = true;
        }
        key(Key2; "Line No.")
        {
        }
    }
    fieldgroups
    {
    }
}
