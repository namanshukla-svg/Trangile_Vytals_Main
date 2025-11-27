Table 50017 "SSD RGP Receipt Line"
{
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Document No."; Code[20])
        {
            TableRelation = "SSD RGP Receipt Header" where("Document Type"=field("Document Type"));
            DataClassification = CustomerContent;
            Caption = 'Document No.';
        }
        field(2; "Line No."; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Line No.';
        }
        field(3; Type; Option)
        {
            OptionMembers = " ", Item, "Item Description", "Fixed Asset";
            DataClassification = CustomerContent;
            Caption = 'Type';
        }
        field(4; "No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'No.';
        }
        field(5; Description; Text[200])
        {
            DataClassification = CustomerContent;
            Caption = 'Description';
        }
        field(6; "Unit Of Measure Code"; Code[10])
        {
            TableRelation = "Unit of Measure";
            DataClassification = CustomerContent;
            Caption = 'Unit Of Measure Code';
        }
        field(8; "Direct Unit Cost"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Direct Unit Cost';
        }
        field(9; "Line Amount"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Line Amount';
        }
        field(12; Quantity; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Quantity';
        }
        field(14; "Document Type"; Option)
        {
            OptionMembers = "RGP Inbound", "RGP Outbound";
            DataClassification = CustomerContent;
            Caption = 'Document Type';
        }
        field(15; "Base Unit Of Measure"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Base Unit Of Measure';
        }
        field(16; "Quantity(Base)"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Quantity(Base)';
        }
        field(19; "Party Type"; Option)
        {
            OptionMembers = Vendor, Customer, Employee;
            DataClassification = CustomerContent;
            Caption = 'Party Type';
        }
        field(20; "Party No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Party No.';
        }
        field(23; "In-Transit Code"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'In-Transit Code';
        }
        field(25; "Write Off"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Write Off';
        }
        field(26; "Item Category Code"; Code[20])
        {
            TableRelation = "Item Category";
            DataClassification = CustomerContent;
            Caption = 'Item Category Code';
        }
        field(27; "Product Group Code"; Code[20])
        {
            //SSD TableRelation = "Product Group" where("Item Category Code" = field("Item Category Code"));
            DataClassification = CustomerContent;
            Caption = 'Product Group Code';
        }
        field(28; "Variant Code"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Variant Code';
        }
        field(35; "Qty. per Unit of Measure"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Qty. per Unit of Measure';
        }
        field(37; "Receipt Time"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Receipt Time';
        }
        field(38; "Posting Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Posting Date';
        }
        field(50; "User ID"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'User ID';
        }
        field(60; "Pre-Assigned No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Pre-Assigned No.';
        }
        field(61; "Pre-Assigned Line No."; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Pre-Assigned Line No.';
        }
        field(100; NRGP; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'NRGP';
        }
        field(102; "Shortcut Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,2,1';
            TableRelation = "Dimension Value".Code where("Global Dimension No."=const(1));
            DataClassification = CustomerContent;
            Caption = 'Shortcut Dimension 1 Code';
        }
        field(103; "Shortcut Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,2,2';
            TableRelation = "Dimension Value".Code where("Global Dimension No."=const(2));
            DataClassification = CustomerContent;
            Caption = 'Shortcut Dimension 2 Code';
        }
        field(150; "Responsibility Center"; Code[20])
        {
            TableRelation = "Responsibility Center".Code;
            DataClassification = CustomerContent;
            Caption = 'Responsibility Center';
        }
        field(50010; "Gate Entry No."; Code[20])
        {
            Description = 'CEN004.05';
            DataClassification = CustomerContent;
            Caption = 'Gate Entry No.';
        }
        field(50011; "Gate Entry Line No."; Integer)
        {
            Description = 'CEN004.05';
            DataClassification = CustomerContent;
            Caption = 'Gate Entry Line No.';
        }
        field(60013; "Document SubType"; Option)
        {
            Description = 'ALLE 6.12';
            OptionCaption = ' ,57F4';
            OptionMembers = " ", "57F4";
            DataClassification = CustomerContent;
            Caption = 'Document SubType';
        }
    }
    keys
    {
        key(Key1; "Document No.", "Line No.")
        {
            Clustered = true;
        }
        key(Key2; "Document Type", "Document No.")
        {
        }
        key(Key3; "Party No.", "Document No.", "Document Type", "No.")
        {
        }
    }
    fieldgroups
    {
    }
    procedure ShowLedgerEntries(RGPRcptLine: Record "SSD RGP Receipt Line")
    var
        RGPLedgerEntry: Record "SSD RGP Ledger Entry";
    begin
        RGPLedgerEntry.SetCurrentkey("Document Type", "Document No.");
        RGPLedgerEntry.SetRange("Document Type", RGPRcptLine."Document Type");
        RGPLedgerEntry.SetRange("Document No.", RGPRcptLine."Document No.");
        RGPLedgerEntry.SetRange("RGP Line No.", RGPRcptLine."Line No.");
        Page.Run(Page::"RGP Ledger Entries", RGPLedgerEntry);
    end;
}
