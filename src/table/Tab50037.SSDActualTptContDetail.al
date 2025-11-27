table 50037 "SSD Actual Tpt Cont Detail"
{
    DataClassification = CustomerContent;

    fields
    {
        field(1; ATCDCode; Integer)
        {
            AutoIncrement = true;
            Caption = 'ATCDCode';
            DataClassification = CustomerContent;
        }
        field(2; "Shipping Agent Code"; Code[20])
        {
            TableRelation = "Shipping Agent".Code;
            Caption = 'Shipping Agent Code';
            DataClassification = CustomerContent;
        }
        field(3; "Contact1 Name"; Text[50])
        {
            Caption = 'Contact1 Name';
            DataClassification = CustomerContent;
        }
        field(4; "Contact1 Mob"; Code[30])
        {
            Caption = 'Contact1 Mob';
            DataClassification = CustomerContent;
        }
        field(5; "Contact1 Email"; Text[40])
        {
            Caption = 'Contact1 Email';
            DataClassification = CustomerContent;
        }
        field(6; "Contact2 Name"; Text[50])
        {
            Caption = 'Contact2 Name';
            DataClassification = CustomerContent;
        }
        field(7; "Contact2 Mob"; Code[30])
        {
            Caption = 'Contact2 Mob';
            DataClassification = CustomerContent;
        }
        field(8; "Contact2 Email"; Text[40])
        {
            Caption = 'Contact2 Email';
            DataClassification = CustomerContent;
        }
        field(9; State; Code[20])
        {
            Caption = 'State';
            DataClassification = CustomerContent;
        }
        field(10; City; Text[30])
        {
            Caption = 'City';
            DataClassification = CustomerContent;
        }
        field(11; "Post Code"; Code[20])
        {
            Caption = 'Post Code';
            DataClassification = CustomerContent;
        }
    }
    keys
    {
        key(Key1; ATCDCode, "Shipping Agent Code")
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
    }
}
