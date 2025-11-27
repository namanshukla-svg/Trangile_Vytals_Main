Table 50060 "SSD QR Printing"
{
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
        field(3; "QR Description"; Text[250])
        {
            DataClassification = CustomerContent;
            Caption = 'QR Description';
        }
        field(4; "QR Images"; Blob)
        {
            SubType = Bitmap;
            DataClassification = CustomerContent;
            Caption = 'QR Images';
        }
        field(5; "Add Item QR Print"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Add Item QR Print';
        }
    }
    keys
    {
        key(Key1; "QR Printing Type", "QR Printing Code")
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
    }
}
