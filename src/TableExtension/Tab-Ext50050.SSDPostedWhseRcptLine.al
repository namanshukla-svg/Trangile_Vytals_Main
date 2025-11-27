TableExtension 50050 "SSD Posted Whse. Rcpt Line" extends "Posted Whse. Receipt Line"
{
    fields
    {
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
            Editable = true;
            DataClassification = CustomerContent;
            Caption = 'Gate Line No.';
        }
        field(50004; "Posted Source Line No."; Integer)
        {
            Description = 'CF001';
            DataClassification = CustomerContent;
            Caption = 'Posted Source Line No.';
        }
        field(50005; "Quality Required"; Boolean)
        {
            Description = 'QLT -> Coming from Item card';
            Editable = false;
            DataClassification = CustomerContent;
            Caption = 'Quality Required';
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
        field(50008; "Shortage Qty."; Decimal)
        {
            Description = 'QLT -> Diff between (Challan Qty - Actual Qty) during Gate Entry';
            Editable = false;
            DataClassification = CustomerContent;
            Caption = 'Shortage Qty.';
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
        field(50014; "Send For Quality"; Boolean)
        {
            Description = 'QLT';
            Editable = false;
            DataClassification = CustomerContent;
            Caption = 'Send For Quality';
        }
        field(50015; "Quality Done"; Boolean)
        {
            Description = 'QLT';
            Editable = false;
            DataClassification = CustomerContent;
            Caption = 'Quality Done';
        }
        field(50017; "Posted Quality Order No."; Code[20])
        {
            Description = 'QLT';
            DataClassification = CustomerContent;
            Caption = 'Posted Quality Order No.';
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
        field(50053; "Party Name"; Text[100])
        {
            CalcFormula = lookup(Vendor.Name where("No."=field("Party No.")));
            Description = 'CEN004.06';
            FieldClass = FlowField;
            Caption = 'Party Name';
        }
        field(50056; "Subcontracting Transfer Order"; Boolean)
        {
            Description = 'ALLEAA CML-033 080508';
            DataClassification = CustomerContent;
            Caption = 'Subcontracting Transfer Order';
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
        field(60008; Trading; Boolean)
        {
            Description = 'ALLE-AA_CML/Purch 19.11.07';
            DataClassification = CustomerContent;
            Caption = 'Trading';
        }
        field(60009; "Purchase Price"; Decimal)
        {
            Editable = false;
            DataClassification = CustomerContent;
            Caption = 'Purchase Price';
        }
        field(60011; "Vendor Item Description"; Text[100])
        {
            Description = 'Vendor Item Description';
            Editable = false;
            DataClassification = CustomerContent;
            Caption = 'Vendor Item Description';
        }
        field(60012; "Direct Unit Cost"; Decimal)
        {
            Description = 'Direct Unit Cost';
            Editable = false;
            DataClassification = CustomerContent;
            Caption = 'Direct Unit Cost';
        }
    }
}
