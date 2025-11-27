Table 50114 "SSD Posted Req. Slip Header"
{
    // //ALLE-MSI
    LookupPageID = "Posted Requision List Form";
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Req. Slip No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Req. Slip No.';
        }
        field(2; "Req. Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Req. Date';
        }
        field(3; "Req. Time"; Time)
        {
            DataClassification = CustomerContent;
            Caption = 'Req. Time';
        }
        field(4; "Shortcut Dimension 1 Code"; Code[20])
        {
            TableRelation = "Dimension Value".Code where("Global Dimension No."=const(1));
            DataClassification = CustomerContent;
            Caption = 'Shortcut Dimension 1 Code';
        }
        field(5; "Shortcut Dimension 2 Code"; Code[20])
        {
            TableRelation = "Dimension Value".Code where("Global Dimension No."=const(2));
            DataClassification = CustomerContent;
            Caption = 'Shortcut Dimension 2 Code';
        }
        field(6; "Responsibility Center"; Code[20])
        {
            TableRelation = "Responsibility Center";
            DataClassification = CustomerContent;
            Caption = 'Responsibility Center';
        }
        field(7; "No. Series"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'No. Series';
        }
        field(8; "Transfer-From Location"; Code[10])
        {
            TableRelation = Location where("Use As In-Transit"=const(false));
            DataClassification = CustomerContent;
            Caption = 'Transfer-From Location';
        }
        field(9; "User ID"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'User ID';
        }
        field(10; "Document Type"; Option)
        {
            OptionCaption = ' ,Material Issue,Material Return,Line Rejection,Floor Rejection,Offer,ReOffer';
            OptionMembers = " ", "Material Issue", "Material Return", "Line Rejection", "Floor Rejection", Offer, ReOffer;
            DataClassification = CustomerContent;
            Caption = 'Document Type';
        }
        field(11; "Document Sub Type"; Option)
        {
            OptionCaption = ' ,Requisition,Indent,Mannual,Material Offer,PDI';
            OptionMembers = " ", Requisition, Indent, Mannual, "Material Offer", PDI;
            DataClassification = CustomerContent;
            Caption = 'Document Sub Type';
        }
        field(12; "No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'No.';
        }
        field(65006; Departments; Option)
        {
            OptionCaption = ' ,PPC,AWP,WIP,Conveyor,ED,Store';
            OptionMembers = " ", PPC, AWP, WIP, Conveyor, ED, Store;
            DataClassification = CustomerContent;
            Caption = 'Departments';
        }
        field(85002; "Prod. Order No."; Code[20])
        {
            TableRelation = "Production Order"."No.";
            DataClassification = CustomerContent;
            Caption = 'Prod. Order No.';
        }
        field(85003; "Source No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Source No.';
        }
        field(85004; "Source Description"; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Source Description';
        }
    }
    keys
    {
        key(Key1; "Document Type", "No.")
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
    }
}
