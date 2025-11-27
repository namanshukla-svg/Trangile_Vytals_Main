Table 50041 "SSD E-Inv Integration Setup"
{
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Primary Key"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Primary Key';
        }
        field(2; "User Name"; Text[30])
        {
            DataClassification = CustomerContent;
            Caption = 'User Name';
        }
        field(3; Password; Text[30])
        {
            DataClassification = CustomerContent;
            Caption = 'Password';
        }
        field(4; "Client ID"; Text[30])
        {
            DataClassification = CustomerContent;
            Caption = 'Client ID';
        }
        field(5; "Client Secret"; Text[30])
        {
            DataClassification = CustomerContent;
            Caption = 'Client Secret';
        }
        field(6; "Access Token"; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Access Token';
        }
        field(7; "Access Token Validity"; DateTime)
        {
            DataClassification = CustomerContent;
            Caption = 'Access Token Validity';
        }
        field(8; "B2C E-Invoicing"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'B2C E-Invoicing';
        }
        field(9; "Mode of E-Invoice - Sales"; Option)
        {
            DataClassification = CustomerContent;
            OptionCaption = 'On Post,BackGround Posting';
            OptionMembers = "On Post", "BackGround Posting";
            Caption = 'Mode of E-Invoice - Sales';
        }
        field(10; "Mode of E-Invoice - Purchase"; Option)
        {
            DataClassification = CustomerContent;
            OptionCaption = 'On Post,BackGround Posting';
            OptionMembers = "On Post", "BackGround Posting";
            Caption = 'Mode of E-Invoice - Purchase';
        }
        field(11; "Mode of E-Invoice - Transfer"; Option)
        {
            DataClassification = CustomerContent;
            OptionCaption = 'On Post,BackGround Posting';
            OptionMembers = "On Post", "BackGround Posting";
            Caption = 'Mode of E-Invoice - Transfer';
        }
        field(12; "Access Token URL"; Text[250])
        {
            DataClassification = CustomerContent;
            Caption = 'Access Token URL';
        }
        field(13; "Generate E-Invoice URL"; Text[250])
        {
            DataClassification = CustomerContent;
            Caption = 'Generate E-Invoice URL';
        }
        field(14; "Cancel E-Invoice URL"; Text[250])
        {
            DataClassification = CustomerContent;
            Caption = 'Cancel E-Invoice URL';
        }
    }
    keys
    {
        key(Key1; "Primary Key")
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
    }
}
