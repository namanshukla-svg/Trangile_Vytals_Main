Table 50025 "SSD Posted Gate Line"
{
    // SM_MUA34 2005.07.29 New option  added on Ref Doc Type
    // SM_ML007 2005.10.20 Field Length Modified
    // ALLE-AA_CML/Purch 19.11.07 : A New Filed Added Trading(Boolean)
    // CML-023 ALLEAG 220208 :
    //   - Added one more option in Ref. Document type as "Posted Delivery Challan".
    DrillDownPageID = "Posted Gate In SubForm";
    LookupPageID = "Posted Gate In SubForm";
    DataClassification = CustomerContent;

    fields
    {
        field(2; "Document No."; Code[20])
        {
            TableRelation = "SSD Gate Header"."No.";
            Caption = 'Document No.';
            DataClassification = CustomerContent;
        }
        field(3; "Line No."; Integer)
        {
            Caption = 'Line No.';
            DataClassification = CustomerContent;
        }
        field(4; "Date"; Date)
        {
            Caption = 'Date';
            DataClassification = CustomerContent;
        }
        field(5; "Party Type"; Option)
        {
            OptionMembers = Vendor, Customer, Employee;
            Caption = 'Party Type';
            DataClassification = CustomerContent;
        }
        field(6; "Party No."; Code[20])
        {
            TableRelation = if("Party Type"=const(Vendor))Vendor."No."
            else if("Party Type"=const(Customer))Customer."No."
            else if("Party Type"=const(Employee))"Dimension Value".Code where("Dimension Code"=const('EMPLOYEE'), "Dimension Value Type"=const(Standard));
            Caption = 'Party No.';
            DataClassification = CustomerContent;
        }
        field(7; "Ref. Document Type"; Option)
        {
            OptionCaption = 'Purchase Order,Sales Returns,RGP Outbound,RGP Inbound,Cash Purchase,Purchase Schedule,Other,Posted Delivery Challan,Subcontracting,Transfer Order';
            OptionMembers = "Purchase Order", "Sales Returns", "RGP Outbound", "RGP Inbound", "Cash Purchase", "Purchase Schedule", Other, "Posted Delivery Challan", Subcontracting, "Transfer Order";
            Caption = 'Ref. Document Type';
            DataClassification = CustomerContent;
        }
        field(8; "Ref. Document No."; Code[20])
        {
            TableRelation = if("Party Type"=const(Vendor), "Ref. Document Type"=const("Purchase Order"))"Purchase Header"."No." where("Document Type"=const(Order), "Buy-from Vendor No."=field("Party No."), "Document Subtype"=const(Order), Status=const(Released))
            else if("Party Type"=const(Vendor), "Ref. Document Type"=const("Purchase Schedule"))"Purchase Header"."No." where("Document Type"=const(Order), "Buy-from Vendor No."=field("Party No."), "Document Subtype"=const(Schedule), Status=const(Released))
            else if("Ref. Document Type"=const("RGP Outbound"))"SSD RGP Header"."No." where("Document Type"=const("RGP Outbound"), "Party No."=field("Party No."));
            Caption = 'Ref. Document No.';
            DataClassification = CustomerContent;

            trigger OnValidate()
            var
                "Gate Entry IN Line": Record "SSD Gate Line";
            begin
            end;
        }
        field(9; "Max Line No."; Integer)
        {
            CalcFormula = max("SSD Gate Line"."Line No." where("Document No."=field("Document No.")));
            FieldClass = FlowField;
            Caption = 'Max Line No.';
        }
        field(10; Type; Option)
        {
            Editable = true;
            OptionMembers = " ", "Account (G/L)", Item, Resource, "Fixed Asset", "Charge (Item)";
            Caption = 'Type';
            DataClassification = CustomerContent;
        }
        field(11; "No."; Code[20])
        {
            Editable = true;
            NotBlank = true;
            TableRelation = if(Type=filter(Item))Item."No."
            else if(Type=filter("Fixed Asset"))"Fixed Asset"."No.";
            Caption = 'No.';
            DataClassification = CustomerContent;
        }
        field(12; Description; Text[100])
        {
            Description = 'Editable=No';
            Caption = 'Description';
            DataClassification = CustomerContent;
        }
        field(13; "Outstanding Quantity"; Decimal)
        {
            Editable = true;
            NotBlank = true;
            Caption = 'Outstanding Quantity';
            DataClassification = CustomerContent;
        }
        field(14; "Unit of Measure Code"; Code[10])
        {
            Editable = true;
            TableRelation = if(Type=const(Item))"Item Unit of Measure".Code where("Item No."=field("No."))
            else
            "Unit of Measure";
            Caption = 'Unit of Measure Code';
            DataClassification = CustomerContent;
        }
        field(15; "Challan Quantity"; Decimal)
        {
            Caption = 'Challan Quantity';
            DataClassification = CustomerContent;

            trigger OnValidate()
            var
                PurchRcptHeader: Record "Purch. Rcpt. Header";
                PurchRcptLine: Record "Purch. Rcpt. Line";
                ShortageQty: Decimal;
            begin
            end;
        }
        field(17; "Total Quantity"; Decimal)
        {
            Caption = 'Total Quantity';
            DataClassification = CustomerContent;
        }
        field(18; "Expected Receipt Date"; Date)
        {
            Caption = 'Expected Receipt Date';
            DataClassification = CustomerContent;
        }
        field(28; "Responsibility Center"; Code[20])
        {
            Description = 'SM_MUA01';
            TableRelation = "Responsibility Center".Code;
            Caption = 'Responsibility Center';
            DataClassification = CustomerContent;
        }
        field(50001; "WH Receipt No."; Code[20])
        {
            Description = 'CF001';
            Caption = 'WH Receipt No.';
            DataClassification = CustomerContent;
        }
        field(50002; "WH Receipt Line No."; Integer)
        {
            Description = 'CF001';
            Caption = 'WH Receipt Line No.';
            DataClassification = CustomerContent;
        }
        field(50003; "Ref. Document Line No."; Integer)
        {
            Description = 'CF001';
            Caption = 'Ref. Document Line No.';
            DataClassification = CustomerContent;
        }
        field(50050; "Receipt No."; Code[20])
        {
            Caption = 'Receipt No.';
            DataClassification = CustomerContent;
        }
        field(50051; "Receipt Line No."; Integer)
        {
            Caption = 'Receipt Line No.';
            DataClassification = CustomerContent;
        }
        field(50052; "Actual Quantity"; Decimal)
        {
            Caption = 'Actual Quantity';
            DataClassification = CustomerContent;
        }
        field(50053; "Shortage Quantity"; Decimal)
        {
            Caption = 'Shortage Quantity';
            DataClassification = CustomerContent;
        }
        field(50054; "No. 2"; Code[20])
        {
            CalcFormula = lookup(Item."No. 2" where("No."=field("No.")));
            Description = 'CE001';
            FieldClass = FlowField;
            Caption = 'No. 2';
        }
        field(54025; "Customer No."; Code[20])
        {
            Description = 'ALLE-TRA1.0';
            TableRelation = Customer."No.";
            Caption = 'Customer No.';
            DataClassification = CustomerContent;
        }
        field(54026; "SalesPerson Code"; Code[10])
        {
            Description = 'ALLE-TRA1.0';
            TableRelation = "Salesperson/Purchaser".Code;
            Caption = 'SalesPerson Code';
            DataClassification = CustomerContent;
        }
        field(60004; "Undo Receipt"; Boolean)
        {
            Description = 'CE_AA006';
            Caption = 'Undo Receipt';
            DataClassification = CustomerContent;
        }
        field(60008; Trading; Boolean)
        {
            Description = 'ALLE-AA_CML/Purch 19.11.07';
            Caption = 'Trading';
            DataClassification = CustomerContent;
        }
        //SSD Sunil
        field(60009; "Vendor Item Description"; Text[100])
        {
            Description = 'Vendor Item Description';
            Editable = false;
            DataClassification = CustomerContent;
            Caption = 'Vendor Item Description';
        }
    }
    keys
    {
        key(Key1; "Document No.", "Line No.")
        {
            Clustered = true;
        }
        key(Key2; "Party Type", "Party No.", "Ref. Document Type", "Ref. Document No.", Type, "No.", "Line No.")
        {
            SumIndexFields = "Challan Quantity", "Actual Quantity";
        }
        key(Key3; "Ref. Document Type", "Ref. Document No.", "No.")
        {
            SumIndexFields = "Challan Quantity", "Actual Quantity";
        }
        key(Key4; "Party Type", "Party No.", "Ref. Document Type", "Ref. Document No.", Type, "No.", "Ref. Document Line No.")
        {
            SumIndexFields = "Challan Quantity", "Actual Quantity";
        }
    }
    fieldgroups
    {
    }
    var Item: Record Item;
    FA: Record "Fixed Asset";
    grheader: Record "SSD Gate Header";
    Text0001: label '"Quantity Invoiced" must be less than or equal to "Outstanding Gate Entry Qty."';
}
