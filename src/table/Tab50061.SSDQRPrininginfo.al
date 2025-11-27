Table 50061 "SSD QR Prining info"
{
    DrillDownPageID = "QR Printing Item Info.";
    LookupPageID = "QR Printing Item Info.";
    DataClassification = CustomerContent;

    fields
    {
        field(1; "QR Printing Type"; Option)
        {
            OptionCaption = ' ,PICTOGRAMS,PRECAUTIONARY STATEMENTS,CLASSIFICATIONS,UN NUMBER,PRODUCT TYPE,SINGLE WORD,HAZARD STATEMENTS';
            OptionMembers = " ", PICTOGRAMS, "PRECAUTIONARY STATEMENTS", CLASSIFICATIONS, "UN NUMBER", "PRODUCT TYPE", "SINGLE WORD", "HAZARD STATEMENTS";
            DataClassification = CustomerContent;
            Caption = 'QR Printing Type';
        }
        field(2; "QR Printing Code"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'QR Printing Code';
        }
        field(3; "Item No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Item No.';
        }
        field(4; "QR Description"; Text[250])
        {
            DataClassification = CustomerContent;
            Caption = 'QR Description';
        }
        field(6; "QR Print Index"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'QR Print Index';
        }
        field(7; "Print Labels"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Print Labels';
        }
    }
    keys
    {
        key(Key1; "QR Printing Type", "QR Printing Code", "Item No.")
        {
            Clustered = true;
        }
        key(Key2; "Item No.", "QR Printing Type")
        {
        }
        key(Key3; "QR Printing Code")
        {
        }
    }
    fieldgroups
    {
    }
}
