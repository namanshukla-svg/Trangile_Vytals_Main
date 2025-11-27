Table 50115 "SSD Posted Requision Slip Line"
{
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Req. Slip Document No."; Code[20])
        {
            Editable = true;
            DataClassification = CustomerContent;
            Caption = 'Req. Slip Document No.';
        }
        field(2; "Prod. Order No."; Code[20])
        {
            Editable = false;
            DataClassification = CustomerContent;
            Caption = 'Prod. Order No.';
        }
        field(3; "Prod. Order Line No."; Integer)
        {
            Editable = false;
            DataClassification = CustomerContent;
            Caption = 'Prod. Order Line No.';
        }
        field(4; "Line No."; Integer)
        {
            Editable = false;
            DataClassification = CustomerContent;
            Caption = 'Line No.';
        }
        field(5; "Item No."; Code[20])
        {
            Editable = false;
            TableRelation = Item;
            DataClassification = CustomerContent;
            Caption = 'Item No.';
        }
        field(6; Description; Text[100])
        {
            Editable = false;
            DataClassification = CustomerContent;
            Caption = 'Description';
        }
        field(7; "Unit of Measure Code"; Code[10])
        {
            Editable = false;
            TableRelation = "Item Unit of Measure".Code where("Item No."=field("Item No."));
            DataClassification = CustomerContent;
            Caption = 'Unit of Measure Code';
        }
        field(8; Quantity; Decimal)
        {
            DecimalPlaces = 5: 5;
            Editable = false;
            DataClassification = CustomerContent;
            Caption = 'Quantity';
        }
        field(9; "Routing Link Code"; Code[20])
        {
            Editable = false;
            TableRelation = "Routing Link";
            DataClassification = CustomerContent;
            Caption = 'Routing Link Code';
        }
        field(10; "Due Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Due Date';
        }
        field(11; "Due Time"; Time)
        {
            DataClassification = CustomerContent;
            Caption = 'Due Time';
        }
        field(12; "Due Date-Time"; DateTime)
        {
            DataClassification = CustomerContent;
            Caption = 'Due Date-Time';
        }
        field(13; "Location Code"; Code[10])
        {
            TableRelation = Location where("Use As In-Transit"=const(false));
            DataClassification = CustomerContent;
            Caption = 'Location Code';
        }
        field(14; "Remaining Qty"; Decimal)
        {
            Editable = false;
            DataClassification = CustomerContent;
            Caption = 'Remaining Qty';
        }
        field(15; "Issued Qty"; Decimal)
        {
            CalcFormula = sum("Transfer Shipment Line".Quantity where("Item No."=field("Item No."), "Slip No."=field("Req. Slip Document No.")));
            Editable = true;
            FieldClass = FlowField;
            Caption = 'Issued Qty';
        }
        field(16; "Qty. to Issue"; Decimal)
        {
            FieldClass = Normal;
            DataClassification = CustomerContent;
            Caption = 'Qty. to Issue';
        }
        field(17; "From-Location Code"; Code[10])
        {
            Editable = false;
            TableRelation = Location where("Use As In-Transit"=const(false));
            DataClassification = CustomerContent;
            Caption = 'From-Location Code';
        }
        field(18; "Responsibility Center"; Code[20])
        {
            Editable = false;
            TableRelation = "Responsibility Center";
            DataClassification = CustomerContent;
            Caption = 'Responsibility Center';
        }
        field(19; "Shortcut Dimension 1 Code"; Code[20])
        {
            Editable = false;
            TableRelation = "Dimension Value".Code where("Global Dimension No."=const(1));
            DataClassification = CustomerContent;
            Caption = 'Shortcut Dimension 1 Code';
        }
        field(20; "Shortcut Dimension 2 Code"; Code[20])
        {
            Editable = false;
            TableRelation = "Dimension Value".Code where("Global Dimension No."=const(2));
            DataClassification = CustomerContent;
            Caption = 'Shortcut Dimension 2 Code';
        }
        field(21; "Quantity Per"; Decimal)
        {
            Editable = false;
            DataClassification = CustomerContent;
            Caption = 'Quantity Per';
        }
        field(22; "Document Type"; Option)
        {
            OptionCaption = ' ,Material Issue,Material Return,Line Rejection,Floor Rejection,Offer,ReOffer';
            OptionMembers = " ", "Material Issue", "Material Return", "Line Rejection", "Floor Rejection", Offer, ReOffer;
            DataClassification = CustomerContent;
            Caption = 'Document Type';
        }
        field(23; "Document Sub Type"; Option)
        {
            OptionCaption = ' ,Requisition,Indent,Mannual,Material Offer,PDI';
            OptionMembers = " ", Requisition, Indent, Mannual, "Material Offer", PDI;
            DataClassification = CustomerContent;
            Caption = 'Document Sub Type';
        }
        field(24; "Document No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Document No.';
        }
        field(65006; Departments; Option)
        {
            OptionCaption = ' ,PPC,AWP,WIP,Conveyor,ED,Store';
            OptionMembers = " ", PPC, AWP, WIP, Conveyor, ED, Store;
            DataClassification = CustomerContent;
            Caption = 'Departments';
        }
        field(65007; "Prod.Order Source No."; Code[20])
        {
            Description = 'HSI-100310';
            DataClassification = CustomerContent;
            Caption = 'Prod.Order Source No.';
        }
    }
    keys
    {
        key(Key1; "Document Type", "Req. Slip Document No.", "Line No.")
        {
            Clustered = true;
        }
        key(Key2; "Prod. Order No.", "Prod.Order Source No.")
        {
        }
    }
    fieldgroups
    {
    }
}
