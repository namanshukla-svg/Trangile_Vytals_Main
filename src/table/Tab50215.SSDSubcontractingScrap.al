Table 50215 "SSD Subcontracting Scrap"
{
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Document No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Document No.';
        }
        field(2; "Line No."; Integer)
        {
            Caption = 'Line No.';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(3; "Source Type"; Integer)
        {
            Caption = 'Source Type';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(4; "Source Subtype"; Option)
        {
            Caption = 'Source Subtype';
            Editable = false;
            OptionCaption = '0,1,2,3,4,5,6,7,8,9,10';
            OptionMembers = "0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "10";
            DataClassification = CustomerContent;
        }
        field(6; "Source No."; Code[20])
        {
            Caption = 'Source No.';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(7; "Source Line No."; Integer)
        {
            Caption = 'Source Line No.';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(9; "Source Document"; Option)
        {
            Caption = 'Source Document';
            Editable = false;
            OptionCaption = ',Sales Order,,,Sales Return Order,Purchase Order,,,Purchase Return Order,Inbound Transfer';
            OptionMembers = , "Sales Order", , , "Sales Return Order", "Purchase Order", , , "Purchase Return Order", "Inbound Transfer";
            DataClassification = CustomerContent;
        }
        field(10; "Location Code"; Code[10])
        {
            Caption = 'Location Code';
            Editable = false;
            TableRelation = Location;
            DataClassification = CustomerContent;
        }
        field(12; "Bin Code"; Code[20])
        {
            Caption = 'Bin Code';
            TableRelation = if("Zone Code"=filter(''))Bin.Code where("Location Code"=field("Location Code"))
            else if("Zone Code"=filter(<>''))Bin.Code where("Location Code"=field("Location Code"), "Zone Code"=field("Zone Code"));
            DataClassification = CustomerContent;
        }
        field(13; "Zone Code"; Code[10])
        {
            Caption = 'Zone Code';
            TableRelation = Zone.Code where("Location Code"=field("Location Code"));
            DataClassification = CustomerContent;
        }
        field(14; "Item No."; Code[20])
        {
            Caption = 'Item No.';
            Editable = true;
            TableRelation = Item;
            DataClassification = CustomerContent;
        }
        field(15; Quantity; Decimal)
        {
            Caption = 'Quantity';
            DecimalPlaces = 0: 5;
            Editable = true;
            DataClassification = CustomerContent;
        }
        field(16; "Qty. (Base)"; Decimal)
        {
            Caption = 'Qty. (Base)';
            DecimalPlaces = 0: 5;
            Editable = true;
            DataClassification = CustomerContent;
        }
        field(29; "Unit of Measure Code"; Code[10])
        {
            Caption = 'Unit of Measure Code';
            Editable = false;
            TableRelation = "Item Unit of Measure".Code where("Item No."=field("Item No."));
            DataClassification = CustomerContent;
        }
        field(30; "Qty. per Unit of Measure"; Decimal)
        {
            Caption = 'Qty. per Unit of Measure';
            DecimalPlaces = 0: 5;
            Editable = false;
            InitValue = 1;
            DataClassification = CustomerContent;
        }
        field(32; Description; Text[50])
        {
            Caption = 'Description';
            Editable = true;
            DataClassification = CustomerContent;
        }
        field(33; "Description 2"; Text[50])
        {
            Caption = 'Description 2';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(60; "Posted Source Document"; Option)
        {
            Caption = 'Posted Source Document';
            OptionCaption = ' ,Posted Receipt,,Posted Return Receipt,,Posted Shipment,,Posted Return Shipment,,Posted Transfer Receipt';
            OptionMembers = " ", "Posted Receipt", , "Posted Return Receipt", , "Posted Shipment", , "Posted Return Shipment", , "Posted Transfer Receipt";
            DataClassification = CustomerContent;
        }
        field(61; "Posted Source No."; Code[20])
        {
            Caption = 'Posted Source No.';
            DataClassification = CustomerContent;
        }
        field(62; "Posting Date"; Date)
        {
            Caption = 'Posting Date';
            DataClassification = CustomerContent;
        }
        field(63; "Vendor Shipment No."; Code[20])
        {
            Caption = 'Vendor Shipment No.';
            DataClassification = CustomerContent;
        }
        field(64; "Whse. Receipt No."; Code[20])
        {
            Caption = 'Whse. Receipt No.';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(65; "Whse Receipt Line No."; Integer)
        {
            Caption = 'Whse Receipt Line No.';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(50001; "Gate Entry no."; Code[20])
        {
            Description = 'CF001';
            Editable = true;
            DataClassification = CustomerContent;
            Caption = 'Gate Entry no.';
        }
        field(50003; "Gate Line No."; Integer)
        {
            Description = 'CF001';
            Editable = false;
            DataClassification = CustomerContent;
            Caption = 'Gate Line No.';
        }
        field(50004; "Posted Source Line No."; Integer)
        {
            Description = 'CF001';
            DataClassification = CustomerContent;
            Caption = 'Posted Source Line No.';
        }
        field(50006; "Qty. On Purch. Order"; Decimal)
        {
            Description = 'QLT -> Total PO Quatity';
            Editable = false;
            DataClassification = CustomerContent;
            Caption = 'Qty. On Purch. Order';
        }
        field(50007; "Qty. On Invoice"; Decimal)
        {
            Description = 'QLT -> Total Challan Qty at Gate Entry';
            Editable = true;
            DataClassification = CustomerContent;
            Caption = 'Qty. On Invoice';
        }
        field(50009; "Actual Qty. to Receive"; Decimal)
        {
            Description = 'QLT -> Actual Qty to be receive';
            Editable = true;
            DataClassification = CustomerContent;
            Caption = 'Actual Qty. to Receive';
        }
        field(50010; "Accepted Qty."; Decimal)
        {
            Description = 'QLT -> Accepted Qty by Quality dep.';
            Editable = true;
            DataClassification = CustomerContent;
            Caption = 'Accepted Qty.';
        }
        field(50011; "Rejected Qty."; Decimal)
        {
            Description = 'QLT -> Rejected Qty by Quality dep.';
            Editable = true;
            DataClassification = CustomerContent;
            Caption = 'Rejected Qty.';
        }
        field(50012; "Party Type"; Option)
        {
            Description = 'QLT';
            OptionCaption = ' ,Vendor,Customer';
            OptionMembers = " ", Vendor, Customer;
            DataClassification = CustomerContent;
            Caption = 'Party Type';
        }
        field(50013; "Party No."; Code[20])
        {
            Description = 'QLT';
            TableRelation = if("Party Type"=const(Vendor))Vendor."No."
            else if("Party Type"=const(Customer))Customer."No.";
            DataClassification = CustomerContent;
            Caption = 'Party No.';
        }
        field(50018; "Reject Location Code"; Code[10])
        {
            Description = 'QLT';
            TableRelation = Location where("Quality Rejects"=const(true));
            DataClassification = CustomerContent;
            Caption = 'Reject Location Code';
        }
        field(50019; "Reject Bin Code"; Code[20])
        {
            Description = 'QLT';
            TableRelation = if("Zone Code"=filter(''))Bin.Code where("Location Code"=field("Reject Location Code"))
            else if("Zone Code"=filter(<>''))Bin.Code where("Location Code"=field("Reject Location Code"), "Zone Code"=field("Zone Code"));
            DataClassification = CustomerContent;
            Caption = 'Reject Bin Code';
        }
        field(50050; "Responsibility Center"; Code[10])
        {
            Caption = 'Responsibility Center';
            Description = 'CF001';
            TableRelation = "Responsibility Center";
            DataClassification = CustomerContent;
        }
        field(50051; "Shortcut Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,2,1';
            Caption = 'Shortcut Dimension 1 Code';
            Description = 'CF001';
            TableRelation = "Dimension Value".Code where("Global Dimension No."=const(1));
            DataClassification = CustomerContent;
        }
        field(50052; "Shortcut Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,2,2';
            Caption = 'Shortcut Dimension 2 Code';
            Description = 'CF001';
            TableRelation = "Dimension Value".Code where("Global Dimension No."=const(2));
            DataClassification = CustomerContent;
        }
        field(50053; "Party Name"; Text[50])
        {
            CalcFormula = lookup(Vendor.Name where("No."=field("Party No.")));
            Description = 'CEN004.06';
            FieldClass = FlowField;
            Caption = 'Party Name';
        }
        field(54025; "Delivery Challan"; Code[20])
        {
            Description = 'CEN004.07';
            DataClassification = CustomerContent;
            Caption = 'Delivery Challan';
        }
        field(54026; "Delivery Challan Sent Item"; Code[20])
        {
            Description = 'CEN004.07';
            DataClassification = CustomerContent;
            Caption = 'Delivery Challan Sent Item';
        }
        field(54027; "Scrap Item"; Code[20])
        {
            Description = 'CEN_AA001';
            TableRelation = Item;
            DataClassification = CustomerContent;
            Caption = 'Scrap Item';
        }
        field(54028; "Scrap Qty."; Decimal)
        {
            Description = 'CEN_AA001';
            DataClassification = CustomerContent;
            Caption = 'Scrap Qty.';
        }
        field(54029; "Scrap Updated"; Boolean)
        {
            Description = 'CEN_AA001';
            DataClassification = CustomerContent;
            Caption = 'Scrap Updated';
        }
        field(54030; "Scrap Location"; Code[20])
        {
            Description = 'CEN_AA001';
            TableRelation = Location;
            DataClassification = CustomerContent;
            Caption = 'Scrap Location';
        }
        field(54031; "Scrap Bin"; Code[20])
        {
            Description = 'CEN_AA001';
            TableRelation = Bin.Code where("Location Code"=field("Scrap Location"));
            DataClassification = CustomerContent;
            Caption = 'Scrap Bin';
        }
    }
    keys
    {
        key(Key1; "Document No.", "Line No.")
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
    }
}
