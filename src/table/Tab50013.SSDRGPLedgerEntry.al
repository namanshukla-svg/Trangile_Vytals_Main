Table 50013 "SSD RGP Ledger Entry"
{
    // ALLE 6.12.....57F4 Customisation
    DataCaptionFields = "No.", Description;
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Entry No."; Integer)
        {
            AutoIncrement = true;
            DataClassification = CustomerContent;
            Caption = 'Entry No.';
        }
        field(2; "Posting Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Posting Date';
        }
        field(3; "Document Type"; Option)
        {
            OptionMembers = "RGP Inbound", "RGP Outbound";
            DataClassification = CustomerContent;
            Caption = 'Document Type';
        }
        field(4; "Document No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Document No.';
        }
        field(5; Type; Option)
        {
            OptionMembers = , Item, "Item Description", "Fixed Asset";
            DataClassification = CustomerContent;
            Caption = 'Type';
        }
        field(6; "No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'No.';
        }
        field(7; Description; Text[200])
        {
            DataClassification = CustomerContent;
            Caption = 'Description';
        }
        field(8; Quantity; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Quantity';
        }
        field(9; "Remaining Quantity"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Remaining Quantity';
        }
        field(10; Location; Code[20])
        {
            Enabled = false;
            TableRelation = Location;
            DataClassification = CustomerContent;
            Caption = 'Location';
        }
        field(11; "Applies-To Entry"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Applies-To Entry';
        }
        field(12; Open; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Open';
        }
        field(13; "External Document No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'External Document No.';
        }
        field(14; "Item Category Code"; Code[20])
        {
            TableRelation = "Item Category";
            DataClassification = CustomerContent;
            Caption = 'Item Category Code';
        }
        field(15; "Product Group Code"; Code[20])
        {
            //SSD TableRelation = "Product Group" where("Item Category Code" = field("Item Category Code"));
            DataClassification = CustomerContent;
            Caption = 'Product Group Code';
        }
        field(16; "No. Series"; Code[20])
        {
            TableRelation = "No. Series";
            DataClassification = CustomerContent;
            Caption = 'No. Series';
        }
        field(17; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            TableRelation = "Dimension Value".Code where("Global Dimension No."=const(1));
            DataClassification = CustomerContent;
        }
        field(18; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            TableRelation = "Dimension Value".Code where("Global Dimension No."=const(2));
            DataClassification = CustomerContent;
        }
        field(19; "User ID"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'User ID';
        }
        field(50; "RGP Document No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'RGP Document No.';
        }
        field(51; "RGP Line No."; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'RGP Line No.';
        }
        field(52; Writeoff; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Writeoff';
        }
        field(100; NRGP; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'NRGP';
        }
        field(101; "MRR No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'MRR No.';
        }
        field(102; Remarks; Text[200])
        {
            DataClassification = CustomerContent;
            Caption = 'Remarks';
        }
        field(150; "Responsibility Center"; Code[20])
        {
            TableRelation = "Responsibility Center".Code;
            DataClassification = CustomerContent;
            Caption = 'Responsibility Center';
        }
        field(60013; "Document SubType"; Option)
        {
            Description = 'ALLE 6.12';
            OptionCaption = ' ,57F4';
            OptionMembers = " ", "57F4";
            DataClassification = CustomerContent;
            Caption = 'Document SubType';
        }
        field(60014; "Description 2"; Text[30])
        {
            DataClassification = CustomerContent;
            Caption = 'Description 2';
        }
    }
    keys
    {
        key(Key1; "Entry No.")
        {
            Clustered = true;
        }
        key(Key2; "Document Type", "Document No.")
        {
        }
        key(Key3; "Document Type", "RGP Document No.", "RGP Line No.")
        {
        }
    }
    fieldgroups
    {
    }
}
