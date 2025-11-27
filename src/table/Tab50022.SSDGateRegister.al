Table 50022 "SSD Gate Register"
{
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
            DataClassification = CustomerContent;
        }
        field(2; "Gate Entry Type"; Option)
        {
            OptionMembers = Inbound, Outbound;
            Caption = 'Gate Entry Type';
            DataClassification = CustomerContent;
        }
        field(3; "Gate Entry No."; Code[20])
        {
            Caption = 'Gate Entry No.';
            DataClassification = CustomerContent;
        }
        field(4; "Gate Entry Date"; Date)
        {
            Caption = 'Gate Entry Date';
            DataClassification = CustomerContent;
        }
        field(5; "Gate Entry Time"; Time)
        {
            Caption = 'Gate Entry Time';
            DataClassification = CustomerContent;
        }
        field(10; "Document Type"; Option)
        {
            OptionCaption = 'Purchase Order,Sales Return,RGP Outbound,RGP Inbound,Sales Invoice,Purchase Return,Delivery Challan,Cash Purchase,Purchase Schedule,Other,Subcontracting';
            OptionMembers = "Purchase Order", "Sales Return", "RGP Outbound", "RGP Inbound", "Sales Invoice", "Purchase Return", "Delivery Challan", "Cash Purchase", "Purchase Schedule", Other, Subcontracting;
            Caption = 'Document Type';
            DataClassification = CustomerContent;
        }
        field(11; "Document No."; Code[20])
        {
            Caption = 'Document No.';
            DataClassification = CustomerContent;
        }
        field(12; NRGP; Boolean)
        {
            Caption = 'NRGP';
            DataClassification = CustomerContent;
        }
        field(13; "Document Line No."; Integer)
        {
            Caption = 'Document Line No.';
            DataClassification = CustomerContent;
        }
        field(20; "Party Type"; Option)
        {
            OptionCaption = 'Vendor,Customer,Employee';
            OptionMembers = Vendor, Customer, Employee;
            Caption = 'Party Type';
            DataClassification = CustomerContent;
        }
        field(21; "Party No."; Code[20])
        {
            TableRelation = if("Party Type"=const(Vendor))Vendor
            else if("Party Type"=const(Customer))Customer;
            Caption = 'Party No.';
            DataClassification = CustomerContent;
        }
        field(22; "Party Name"; Text[100])
        {
            Description = 'SM_ML007 80->100';
            Caption = 'Party Name';
            DataClassification = CustomerContent;
        }
        field(23; "Challan/Bill No."; Code[20])
        {
            Caption = 'Challan/Bill No.';
            DataClassification = CustomerContent;
        }
        field(24; "Challan/Bill Date"; Date)
        {
            Caption = 'Challan/Bill Date';
            DataClassification = CustomerContent;
        }
        field(25; "User ID"; Code[20])
        {
            Caption = 'User ID';
            DataClassification = CustomerContent;
        }
        field(26; Remarks; Text[100])
        {
            Caption = 'Remarks';
            DataClassification = CustomerContent;
        }
        field(28; "Responsibility Center"; Code[20])
        {
            Description = 'SM_MUA01';
            TableRelation = "Responsibility Center".Code;
            Caption = 'Responsibility Center';
            DataClassification = CustomerContent;
        }
        field(40; Type; Option)
        {
            OptionCaption = ' ,Item,Item Description,Fixed Asset';
            OptionMembers = " ", Item, "Item Description", "Fixed Asset";
            Caption = 'Type';
            DataClassification = CustomerContent;
        }
        field(41; "No."; Code[20])
        {
            Caption = 'No.';
            DataClassification = CustomerContent;
        }
        field(42; Quantity; Decimal)
        {
            Caption = 'Quantity';
            DataClassification = CustomerContent;
        }
        field(50; "Delivery Mode"; Option)
        {
            OptionCaption = 'Own Vehical,By Hand Party,Transporter';
            OptionMembers = "Own Vehical", "By Hand Party", Transporter;
            Caption = 'Delivery Mode';
            DataClassification = CustomerContent;
        }
        field(51; "Transporter No."; Code[20])
        {
            Caption = 'Transporter No.';
            DataClassification = CustomerContent;
        }
        field(52; "Transporter Name"; Text[80])
        {
            Caption = 'Transporter Name';
            DataClassification = CustomerContent;
        }
        field(53; "Vechile No."; Code[20])
        {
            Caption = 'Vechile No.';
            DataClassification = CustomerContent;
        }
        field(54; Description; Text[100])
        {
            Description = 'SM_ML007 80->100';
            Caption = 'Description';
            DataClassification = CustomerContent;
        }
        field(55; "Unit of Measure Code"; Code[20])
        {
            Caption = 'Unit of Measure Code';
            DataClassification = CustomerContent;
        }
        field(50050; "MRN No."; Code[20])
        {
            Description = 'SM_MUA54';
            Caption = 'MRN No.';
            DataClassification = CustomerContent;
        }
        field(50052; "Register No."; Text[250])
        {
            Description = 'CEN005.06';
            Caption = 'Register No.';
            DataClassification = CustomerContent;
        }
        field(50053; "Register Entry Date"; Date)
        {
            Description = 'CEN005.06';
            Caption = 'Register Entry Date';
            DataClassification = CustomerContent;
        }
        field(50054; "No.2"; Code[20])
        {
            CalcFormula = lookup(Item."No. 2" where("No."=field("No.")));
            FieldClass = FlowField;
            Caption = 'No.2';
        }
        field(60003; Trading; Boolean)
        {
            Caption = 'Trading';
            Description = 'CE_AA004';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
            //PurchSetup.GET;
            //InitRecord;
            end;
        }
    }
    keys
    {
        key(Key1; "Entry No.")
        {
            Clustered = true;
        }
        key(Key2; "Gate Entry No.")
        {
        }
        key(Key3; "No.")
        {
        }
        key(Key4; "Gate Entry Time", "No.")
        {
        }
        key(Key5; "Gate Entry Date", "Gate Entry Time", "No.")
        {
        }
    }
    fieldgroups
    {
    }
}
