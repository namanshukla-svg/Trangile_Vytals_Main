Table 50036 "SSD Dispatch Packing Line"
{
    DataClassification = CustomerContent;

    fields
    {
        field(10; "Document Type"; Option)
        {
            Caption = 'Document Type';
            OptionCaption = 'Quote,Order,Invoice,Credit Memo,Blanket Order,Return Order,,Branch Transfer';
            OptionMembers = Quote, "Order", Invoice, "Credit Memo", "Blanket Order", "Return Order", , "Branch Transfer";
            DataClassification = CustomerContent;
        }
        field(20; "Document No."; Code[20])
        {
            Caption = 'Document No.';
            DataClassification = CustomerContent;
        }
        field(30; "Line No."; Integer)
        {
            Caption = 'Line No.';
            DataClassification = CustomerContent;
        }
        field(40; "Dispatch Packing Line No."; Integer)
        {
            Caption = 'Dispatch Packing Line No.';
            DataClassification = CustomerContent;
        }
        field(50; "Carton No."; Code[20])
        {
            Editable = false;
            Caption = 'Carton No.';
            DataClassification = CustomerContent;
        }
        field(55; "ALP Carton No."; Code[20])
        {
            Caption = 'ALP Carton No.';
            DataClassification = CustomerContent;
        }
        field(56; "Item No."; Code[20])
        {
            Caption = 'Item No.';
            Editable = false;
            TableRelation = Item;
            DataClassification = CustomerContent;
        }
        field(57; "Variant Code"; Code[10])
        {
            Caption = 'Variant Code';
            Editable = false;
            TableRelation = "Item Variant".Code where("Item No."=field("Item No."), Code=field("Variant Code"));
            DataClassification = CustomerContent;
        }
        field(58; "Unit of Measure"; Code[10])
        {
            Editable = false;
            Caption = 'Unit of Measure';
            DataClassification = CustomerContent;
        }
        field(60; "Carton Item Quantity"; Decimal)
        {
            BlankZero = true;
            DecimalPlaces = 0: 5;
            Editable = true;
            Caption = 'Carton Item Quantity';
            DataClassification = CustomerContent;
        }
        field(70; "Carton Gross Weight"; Decimal)
        {
            BlankZero = true;
            DecimalPlaces = 0: 3;
            Editable = false;
            Caption = 'Carton Gross Weight';
            DataClassification = CustomerContent;
        }
        field(80; "Carton Net Weight"; Decimal)
        {
            BlankZero = true;
            DecimalPlaces = 0: 3;
            Editable = false;
            Caption = 'Carton Net Weight';
            DataClassification = CustomerContent;
        }
        field(90; "ALP Pallet No."; Code[20])
        {
            Caption = 'ALP Pallet No.';
            DataClassification = CustomerContent;
        }
        field(93; "Customer No."; Code[20])
        {
            Editable = false;
            TableRelation = Customer;
            Caption = 'Customer No.';
            DataClassification = CustomerContent;
        }
        field(95; Remark; Text[50])
        {
            Caption = 'Remark';
            DataClassification = CustomerContent;
        }
        field(100; "Packing Size"; Text[20])
        {
            Editable = false;
            Caption = 'Packing Size';
            DataClassification = CustomerContent;
        }
        field(110; "Pallet Group No."; Code[20])
        {
            Caption = 'Pallet Group No.';
            DataClassification = CustomerContent;
        }
        field(5702; "Item Category Code"; Code[20])
        {
            Caption = 'Item Category Code';
            Editable = false;
            TableRelation = "Item Category";
            DataClassification = CustomerContent;
        }
        field(5704; "Product Group Code"; Code[10])
        {
            Caption = 'Product Group Code';
            Editable = false;
            TableRelation = "Item Category".Code where(Code=field("Item Category Code"));
            DataClassification = CustomerContent;
        }
        field(5705; "Product Group Name"; Text[50])
        {
            Editable = false;
            Caption = 'Product Group Name';
            DataClassification = CustomerContent;
        }
        field(50001; "No.2"; Code[20])
        {
            CalcFormula = lookup(Item."No. 2" where("No."=field("Item No.")));
            Editable = false;
            FieldClass = FlowField;
            Caption = 'No.2';
        }
        field(50002; "Description 3"; Text[300])
        {
            //SSD CalcFormula = lookup(Item."Description 3" where("No." = field("Item No.")));
            Editable = false;
            FieldClass = FlowField;
            Caption = 'Description 3';
        }
    }
    keys
    {
        key(Key1; "Document Type")
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
    }
}
