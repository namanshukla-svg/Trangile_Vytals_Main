Table 50107 "SSD NAGARE"
{
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Vendor Code"; Code[20])
        {
            Editable = false;
            Caption = 'Vendor Code';
            DataClassification = CustomerContent;
        }
        field(2; "Vendor Name"; Text[250])
        {
            Editable = false;
            Caption = 'Vendor Name';
            DataClassification = CustomerContent;
        }
        field(20; "Part code"; Code[20])
        {
            Editable = false;
            Caption = 'Part code';
            DataClassification = CustomerContent;
        }
        field(30; "Date"; Date)
        {
            Editable = true;
            Caption = 'Date';
            DataClassification = CustomerContent;
        }
        field(40; "Time"; Time)
        {
            Editable = false;
            Caption = 'Time';
            DataClassification = CustomerContent;
        }
        field(50; Quantity; Decimal)
        {
            Caption = 'Actual Quantity';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                if Quantity > "Remaining Quantity" then Error('You can not enter the quanttity greater than Remaining quantity');
                if Quantity <> xRec.Quantity then "Request For Despatch":=true;
                if Quantity = 0 then "Request For Despatch":=false;
            end;
        }
        field(60; "UN Loc"; Code[20])
        {
            Editable = false;
            Caption = 'UN Loc';
            DataClassification = CustomerContent;
        }
        field(70; "US Loc"; Code[20])
        {
            Editable = false;
            Caption = 'US Loc';
            DataClassification = CustomerContent;
        }
        field(80; "NAGARE No."; Text[50])
        {
            Editable = false;
            Caption = 'NAGARE No.';
            DataClassification = CustomerContent;
        }
        field(90; Uploaded; Boolean)
        {
            Editable = true;
            Caption = 'Uploaded';
            DataClassification = CustomerContent;
        }
        field(91; "Item Name"; Text[50])
        {
            Editable = false;
            Caption = 'Item Name';
            DataClassification = CustomerContent;
        }
        field(95; SL; Integer)
        {
            Editable = false;
            Caption = 'SL';
            DataClassification = CustomerContent;
        }
        field(96; "Document Type"; Option)
        {
            OptionCaption = ' ,DI SPARES,ENAGARE';
            OptionMembers = " ", "DI SPARES", ENAGARE;
            Caption = 'Document Type';
            DataClassification = CustomerContent;
        }
        field(97; "Item No."; Code[20])
        {
            Editable = true;
            Caption = 'Item No.';
            DataClassification = CustomerContent;
        }
        field(98; "Engare Qty."; Decimal)
        {
            Editable = true;
            Caption = 'Engare Qty.';
            DataClassification = CustomerContent;
        }
        field(99; "Order No."; Code[20])
        {
            Editable = true;
            Caption = 'Order No.';
            DataClassification = CustomerContent;
        }
        field(100; "Order Line No."; Integer)
        {
            Editable = true;
            Caption = 'Order Line No.';
            DataClassification = CustomerContent;
        }
        field(101; "Despatch Slip No."; Code[20])
        {
            Editable = false;
            Caption = 'Despatch Slip No.';
            DataClassification = CustomerContent;
        }
        field(102; "Despatch Slip Line N0."; Integer)
        {
            Editable = false;
            Caption = 'Despatch Slip Line N0.';
            DataClassification = CustomerContent;
        }
        field(103; "Invoice No."; Code[20])
        {
            Editable = false;
            Caption = 'Invoice No.';
            DataClassification = CustomerContent;
        }
        field(104; "Invoice Line No."; Integer)
        {
            Editable = false;
            Caption = 'Invoice Line No.';
            DataClassification = CustomerContent;
        }
        field(200; "Request For Despatch"; Boolean)
        {
            Editable = false;
            Caption = 'Request For Despatch';
            DataClassification = CustomerContent;
        }
        field(205; "Remaining Quantity"; Decimal)
        {
            Caption = 'Remaining Quantity';
            DataClassification = CustomerContent;
        }
        field(210; "Uploaded Quantity"; Decimal)
        {
            Caption = 'Uploaded Quantity';
            DataClassification = CustomerContent;
        }
        field(211; "Cusomer Code"; Code[20])
        {
            Editable = false;
            Caption = 'Cusomer Code';
            DataClassification = CustomerContent;
        }
        field(212; "Nagare Uploaded Date"; Date)
        {
            Caption = 'Nagare Uploaded Date';
            DataClassification = CustomerContent;
        }
        field(213; "Nagare Uploaded Time"; Time)
        {
            Caption = 'Nagare Uploaded Time';
            DataClassification = CustomerContent;
        }
        field(214; "Nagare Uploaded User"; Code[20])
        {
            Caption = 'Nagare Uploaded User';
            DataClassification = CustomerContent;
        }
        field(215; "Despatch Created User"; Code[20])
        {
            Caption = 'Despatch Created User';
            DataClassification = CustomerContent;
        }
        field(216; "Invoice Created User"; Code[20])
        {
            Caption = 'Invoice Created User';
            DataClassification = CustomerContent;
        }
        field(217; "Despatch Created Date"; Date)
        {
            Caption = 'Despatch Created Date';
            DataClassification = CustomerContent;
        }
        field(218; "Invoice Created Date"; Date)
        {
            Caption = 'Invoice Created Date';
            DataClassification = CustomerContent;
        }
        field(219; "Despatch Created time"; Time)
        {
            Caption = 'Despatch Created time';
            DataClassification = CustomerContent;
        }
        field(220; "Invoice Created time"; Time)
        {
            Caption = 'Invoice Created time';
            DataClassification = CustomerContent;
        }
        field(221; "Deleted User"; Code[20])
        {
            Caption = 'Deleted User';
            DataClassification = CustomerContent;
        }
        field(222; Deleted; Boolean)
        {
            Caption = 'Deleted';
            DataClassification = CustomerContent;
        }
        field(223; "Deleted Date"; Date)
        {
            Caption = 'Deleted Date';
            DataClassification = CustomerContent;
        }
        field(224; "Deleted time"; Time)
        {
            Caption = 'Deleted time';
            DataClassification = CustomerContent;
        }
        field(225; "JBM Position"; Decimal)
        {
            Caption = 'JBM Position';
            DataClassification = CustomerContent;
        }
        field(226; "JBM Contract"; Text[30])
        {
            Caption = 'JBM Contract';
            DataClassification = CustomerContent;
        }
        field(227; "Inventory Posting Group"; Code[20])
        {
            Caption = 'Inventory Posting Group';
            DataClassification = CustomerContent;
        }
        field(228; "Manual Despatch"; Boolean)
        {
            Caption = 'Manual Despatch';
            DataClassification = CustomerContent;
        }
        field(229; "Receipt Qty"; Decimal)
        {
            Caption = 'Receipt Qty';
            DataClassification = CustomerContent;
        }
        field(230; "Rejection Qty"; Decimal)
        {
            Caption = 'Rejection Qty';
            DataClassification = CustomerContent;
        }
        field(231; Type; Text[30])
        {
            Caption = 'Type';
            DataClassification = CustomerContent;
        }
        field(232; "Description 2"; Text[30])
        {
            CalcFormula = lookup(Item."Description 2" where("No."=field("Item No.")));
            Editable = false;
            FieldClass = FlowField;
            Caption = 'Description 2';
        }
        field(233; "Item No. 2"; Code[20])
        {
            CalcFormula = lookup(Item."No. 2" where("No."=field("Item No.")));
            FieldClass = FlowField;
            Caption = 'Item No. 2';
        }
    }
    keys
    {
        key(Key1; "Vendor Code", Date, Time, "Part code", "UN Loc", "US Loc", "NAGARE No.")
        {
            Clustered = true;
        }
        key(Key2; Date, Time)
        {
        }
        key(Key3; "NAGARE No.")
        {
        }
        key(Key4; Date, Time, "US Loc", "NAGARE No.", "Cusomer Code")
        {
        }
        key(Key5; "Vendor Code", "Part code", Date, "UN Loc", "US Loc", "NAGARE No.", Time)
        {
        }
        key(Key6; Uploaded, "Request For Despatch")
        {
        }
        key(Key7; Date, Time, "US Loc", "NAGARE No.", "Item No.", "UN Loc")
        {
        }
        key(Key8; "Item No.")
        {
        }
    }
    fieldgroups
    {
    }
    var RecNagare: Record "SSD NAGARE";
}
