Table 50079 "SSD Posted Returns Line"
{
    Caption = 'Posted Returns Line';
    DrillDownPageID = "Item Journal Lines";
    LookupPageID = "Item Journal Lines";
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Item Entry No."; Integer)
        {
            Caption = 'Item Entry No.';
            Editable = false;
            TableRelation = "Item Ledger Entry"."Entry No.";
            DataClassification = CustomerContent;
        }
        field(2; "Posting Date"; Date)
        {
            Caption = 'Posting Date';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(3; "Type of Return"; Option)
        {
            Caption = 'Type of Return';
            Editable = false;
            OptionCaption = 'Type of Return';
            OptionMembers = Subcontracting, Purchase;
            DataClassification = CustomerContent;
        }
        field(4; "Document No."; Code[20])
        {
            Caption = 'Document No.';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(5; "Item No."; Code[20])
        {
            Caption = 'Item No.';
            Editable = false;
            TableRelation = Item;
            DataClassification = CustomerContent;
        }
        field(6; Description; Text[50])
        {
            Caption = 'Description';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(7; "Return Location Code"; Code[10])
        {
            Caption = 'Return Location Code';
            Editable = false;
            TableRelation = Location where("Quality Returns"=const(true));
            DataClassification = CustomerContent;
        }
        field(8; Quantity; Decimal)
        {
            BlankZero = true;
            Caption = 'Quantity';
            DecimalPlaces = 0: 5;
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(9; "Unit of Measure Code"; Code[10])
        {
            Caption = 'Unit of Measure Code';
            Editable = false;
            TableRelation = "Item Unit of Measure".Code where("Item No."=field("Item No."));
            DataClassification = CustomerContent;
        }
        field(10; "Unit Amount"; Decimal)
        {
            AutoFormatType = 2;
            Caption = 'Unit Amount';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(11; Amount; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Amount';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(12; "Lot No."; Code[20])
        {
            Caption = 'Lot No.';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(13; "Line No."; Integer)
        {
            Caption = 'Line No.';
            DataClassification = CustomerContent;
        }
        field(14; "Primary Order No."; Code[20])
        {
            Caption = 'Primary Order No.';
            DataClassification = CustomerContent;
        }
        field(15; "Vendor Order No."; Code[20])
        {
            Caption = 'Vendor Order No.';
            DataClassification = CustomerContent;
        }
        field(16; "Vendor Receipt No."; Code[20])
        {
            Caption = 'Vendor Receipt No.';
            DataClassification = CustomerContent;
        }
        field(17; "Return Bin Code"; Code[20])
        {
            Caption = 'Return Bin Code';
            TableRelation = Bin.Code where("Location Code"=field("Return Location Code"));
            DataClassification = CustomerContent;
        }
        field(20; "Good Qty."; Decimal)
        {
            BlankZero = true;
            Caption = 'Good Qty.';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(21; "Qty. to Reclass."; Decimal)
        {
            BlankZero = true;
            Caption = 'Qty. to Reclass.';
            DataClassification = CustomerContent;
        }
        field(22; "Qty. to Return"; Decimal)
        {
            BlankZero = true;
            Caption = 'Qty. to Return';
            DataClassification = CustomerContent;
        }
        field(23; "Vendor No."; Code[10])
        {
            Caption = 'Vendor No.';
            TableRelation = Vendor."No.";
            DataClassification = CustomerContent;
        }
        field(26; "Create New Order"; Boolean)
        {
            Caption = 'Create New Order';
            DataClassification = CustomerContent;
        }
        field(27; "Vendor Claim Code"; Code[10])
        {
            Caption = 'Vendor Claim Code';
            TableRelation = "SSD Amazon Staging";
            DataClassification = CustomerContent;
        }
        field(28; "Group by"; Code[10])
        {
            Caption = 'Group by';
            DataClassification = CustomerContent;
        }
        field(29; "Quality Defect Code"; Code[10])
        {
            Caption = 'Quality Defect Code';
            TableRelation = "SSD Quality Defects";
            DataClassification = CustomerContent;
        }
        field(31; "New Location Code"; Code[10])
        {
            Caption = 'New Location';
            TableRelation = Location where("Quality Returns"=const(false));
            DataClassification = CustomerContent;
        }
        field(32; "New Bin Code"; Code[10])
        {
            Caption = 'New Bin';
            TableRelation = Bin.Code where("Location Code"=field("New Location Code"));
            DataClassification = CustomerContent;
        }
        field(33; "New Lot"; Code[20])
        {
            Caption = 'New Lot';
            DataClassification = CustomerContent;
        }
        field(34; "Carry Out Action Message"; Boolean)
        {
            Caption = 'Carry Out Action Message';
            DataClassification = CustomerContent;
        }
        field(35; "Reclass. Location Code"; Code[10])
        {
            Caption = 'Reclass. Location';
            TableRelation = Location;
            DataClassification = CustomerContent;
        }
        field(36; "Reclassif. Bin Code"; Code[10])
        {
            Caption = 'Reclassif. Bin No.';
            TableRelation = Bin.Code where("Location Code"=field("Reclass. Location Code"));
            DataClassification = CustomerContent;
        }
        field(37; "Reclassif. Code"; Code[20])
        {
            Caption = 'Reclassif. Code';
            TableRelation = "SSD Items Reclassification"."Reclass. Item No." where("Item No."=field("Item No."));
            ValidateTableRelation = false;
            DataClassification = CustomerContent;
        }
        field(38; "Reclassif. Factor"; Decimal)
        {
            Caption = 'Reclassif. Factor';
            DataClassification = CustomerContent;
        }
        field(40; "User ID"; Code[20])
        {
            Caption = 'User ID';
            TableRelation = User;
            DataClassification = CustomerContent;
        }
        field(41; "Run Date"; Date)
        {
            Caption = 'Run Date';
            DataClassification = CustomerContent;
        }
        field(42; "Running Time"; Time)
        {
            Caption = 'Running Time';
            DataClassification = CustomerContent;
        }
        field(100; "Entry No."; Integer)
        {
            Caption = 'Posted Entry No';
            DataClassification = CustomerContent;
        }
        field(50001; "Responsibility Center"; Code[10])
        {
            Caption = 'Responsibility Center';
            Editable = false;
            TableRelation = "Responsibility Center";
            DataClassification = CustomerContent;
        }
    }
    keys
    {
        key(Key1; "Entry No.")
        {
            Clustered = true;
        }
        key(Key2; "Item No.")
        {
        }
        key(Key3; "Carry Out Action Message", "Vendor No.", "Group by")
        {
        }
    }
    fieldgroups
    {
    }
    trigger OnDelete()
    begin
        Error('Txt00004', TableCaption);
    end;
    trigger OnInsert()
    begin
        Error('Txt00002', TableCaption);
    end;
    trigger OnModify()
    begin
        Error('Txt00003', TableCaption);
    end;
    var Txt00001: label 'Good quantity can not be negative';
    Txt00002: label 'Insert is not allowed in %1 ';
    Txt00003: label 'Modification is not allowed in %1';
    Txt00004: label 'Delete is not allowed in  %1';
    procedure UpdateQuantity()
    begin
    end;
}
