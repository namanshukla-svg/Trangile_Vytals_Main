Table 50040 "SSD E-Invoicing Requests"
{
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Entry No."; Guid)
        {
            DataClassification = CustomerContent;
            Caption = 'Entry No.';
        }
        field(2; "Document Type"; Option)
        {
            DataClassification = CustomerContent;
            OptionCaption = ' ,Sale Invoice,Sale Cr. Memo,Transfer,Purchase,Purchase Cr. Memo';
            OptionMembers = " ", "Sale Invoice", "Sale Cr. Memo", Transfer, Purchase, "Purchase Cr. Memo";
            Caption = 'Document Type';
        }
        field(3; "Document No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Document No.';
        }
        field(4; "Acknowledgement No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Acknowledgement No.';
        }
        field(5; "Acknowledgement Date"; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Acknowledgement Date';
        }
        field(6; "IRN No."; Text[250])
        {
            DataClassification = CustomerContent;
            Caption = 'IRN No.';
        }
        field(7; "Signed QR Code"; Text[250])
        {
            DataClassification = CustomerContent;
            Caption = 'Signed QR Code';
        }
        field(8; Status; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Status';
        }
        field(9; "Error Message"; Text[250])
        {
            DataClassification = CustomerContent;
            Caption = 'Error Message';
        }
        field(10; "Request ID"; Text[250])
        {
            DataClassification = CustomerContent;
            Caption = 'Request ID';
        }
        field(11; "Request Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Request Date';
        }
        field(12; "Request Time"; Time)
        {
            DataClassification = CustomerContent;
            Caption = 'Request Time';
        }
        field(13; "Signed Invoice"; Text[250])
        {
            DataClassification = CustomerContent;
            Caption = 'Signed Invoice';
        }
        field(14; "Signed QR Code2"; Text[250])
        {
            DataClassification = CustomerContent;
            Caption = 'Signed QR Code2';
        }
        field(15; "Signed QR Code3"; Text[250])
        {
            DataClassification = CustomerContent;
            Caption = 'Signed QR Code3';
        }
        field(16; "QR Image"; Blob)
        {
            DataClassification = CustomerContent;
            Caption = 'QR Image';
        }
        field(17; "Document Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Document Date';
        }
        field(18; "E-Invoice Generated"; Boolean)
        {
            DataClassification = CustomerContent;
            Editable = false;
            Caption = 'E-Invoice Generated';
        }
        field(19; "User Id"; Code[50])
        {
            DataClassification = CustomerContent;
            Caption = 'User Id';
        }
        field(20; "E-Invoice Canceled"; Boolean)
        {
            DataClassification = CustomerContent;
            Editable = false;
            Caption = 'E-Invoice Canceled';
        }
        field(21; "Cancel Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Cancel Date';
        }
        field(22; "Cancel Time"; Time)
        {
            DataClassification = CustomerContent;
            Caption = 'Cancel Time';
        }
        field(23; "Cancel User Id"; Code[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Cancel User Id';
        }
        field(24; "Signed QR Code4"; Text[250])
        {
            DataClassification = CustomerContent;
            Caption = 'Signed QR Code4';
        }
        field(25; "Error Message2"; Text[250])
        {
            DataClassification = CustomerContent;
            Caption = 'Error Message2';
        }
        field(26; "Error Message3"; Text[250])
        {
            DataClassification = CustomerContent;
            Caption = 'Error Message3';
        }
        field(27; "QR Code URL"; Text[250])
        {
            Caption = 'QR Code URL';
            DataClassification = CustomerContent;
        }
        field(30; "E Invoice PDF URL"; Text[250])
        {
            DataClassification = CustomerContent;
            Caption = 'E Invoice PDF URL';
        }
        field(31; "Info Details"; Text[250])
        {
            Caption = 'Info Details';
            DataClassification = CustomerContent;
        }
        field(32; "Info Details2"; Text[250])
        {
            Caption = 'Info Details2';
            DataClassification = CustomerContent;
        }
    }
    keys
    {
        key(Key1; "Entry No.")
        {
            Clustered = true;
        }
        key(Key2; "Document Type", "Document No.", "E-Invoice Generated")
        {
        }
        key(Key3; "Document No.")
        {
        }
    }
    fieldgroups
    {
    }
}
