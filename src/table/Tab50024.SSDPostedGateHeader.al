Table 50024 "SSD Posted Gate Header"
{
    DataClassification = CustomerContent;

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
            DataClassification = CustomerContent;
        }
        field(3; "Party Type"; Option)
        {
            OptionMembers = Vendor,Customer,Employee;
            Caption = 'Party Type';
            DataClassification = CustomerContent;
        }
        field(4; "Party No."; Code[20])
        {
            NotBlank = true;
            TableRelation = if ("Party Type" = const(Vendor)) Vendor."No."
            else if ("Party Type" = const(Customer)) Customer."No."
            else if ("Party Type" = const(Employee)) "Dimension Value".Code where("Dimension Code" = const('EMPLOYEE'), "Dimension Value Type" = const(Standard));
            Caption = 'Party No.';
            DataClassification = CustomerContent;
        }
        field(5; Name; Text[100])
        {
            Caption = 'Name';
            DataClassification = CustomerContent;
        }
        field(6; Address; Text[80])
        {
            Caption = 'Address';
            DataClassification = CustomerContent;
        }
        field(7; Address2; Text[80])
        {
            Caption = 'Address2';
            DataClassification = CustomerContent;
        }
        field(8; City; Text[30])
        {
            Caption = 'City';
            DataClassification = CustomerContent;
        }
        field(9; Phone; Text[75])
        {
            Caption = 'Phone';
            DataClassification = CustomerContent;
        }
        field(10; Telex; Text[20])
        {
            Caption = 'Telex';
            DataClassification = CustomerContent;
        }
        field(11; "Ref. Document Type"; Option)
        {
            OptionCaption = 'Purchase Order,Sales Returns,RGP Outbound,RGP Inbound,Cash Purchase,Purchase Schedule,Other,Posted Delivery Challan,Subcontracting';
            OptionMembers = "Purchase Order","Sales Returns","RGP Outbound","RGP Inbound","Cash Purchase","Purchase Schedule",Other,"Posted Delivery Challan",Subcontracting;
            Caption = 'Ref. Document Type';
            DataClassification = CustomerContent;
        }
        field(12; "Ref. Document No."; Code[20])
        {
            TableRelation = if ("Party Type" = const(Vendor), "Ref. Document Type" = const("Purchase Order")) "Purchase Header"."No." where("Document Type" = const(Order), "Buy-from Vendor No." = field("Party No."), "Document Subtype" = const(Order), Status = const(Released))
            else if ("Party Type" = const(Vendor), "Ref. Document Type" = const("Purchase Schedule")) "Purchase Header"."No." where("Document Type" = const(Order), "Buy-from Vendor No." = field("Party No."), "Document Subtype" = const(Schedule), Status = const(Released))
            else if ("Ref. Document Type" = const("RGP Outbound")) "SSD RGP Header"."No." where("Document Type" = const("RGP Outbound"), "Party No." = field("Party No."));
            Caption = 'Ref. Document No.';
            DataClassification = CustomerContent;

            trigger OnValidate()
            var
                "Gate Entry IN Line": Record "SSD Gate Line";
            begin
            end;
        }
        field(13; "Posting Date"; Date)
        {
            NotBlank = true;
            Caption = 'Posting Date';
            DataClassification = CustomerContent;
        }
        field(14; "ST38 No."; Text[30])
        {
            Caption = 'ST38 No.';
            DataClassification = CustomerContent;
        }
        field(15; Purpose; Text[75])
        {
            Caption = 'Purpose';
            DataClassification = CustomerContent;
        }
        field(17; "No. Series In"; Code[10])
        {
            TableRelation = "No. Series";
            Caption = 'No. Series In';
            DataClassification = CustomerContent;
        }
        field(18; "No. Series Out"; Code[10])
        {
            TableRelation = "No. Series";
            Caption = 'No. Series Out';
            DataClassification = CustomerContent;
        }
        field(19; "MRN No."; Code[20])
        {
            //SSD TableRelation = "Purch. Rcpt. Header"."No." where(Field50046 = field("No."));
            Caption = 'MRN No.';
            DataClassification = CustomerContent;
        }
        field(20; D3; Boolean)
        {
            Caption = 'D3';
            DataClassification = CustomerContent;
        }
        field(21; "Purchase Invoice No."; Code[20])
        {
            //SSD TableRelation = "Purch. Inv. Header"."No." where(Field50046 = field("No."));
            Caption = 'Purchase Invoice No.';
            DataClassification = CustomerContent;
        }
        field(22; "Sales Invoice No."; Code[20])
        {
            Caption = 'Sales Invoice No.';
            DataClassification = CustomerContent;
        }
        field(23; "Bill No."; Code[20])
        {
            Caption = 'Bill No.';
            DataClassification = CustomerContent;
        }
        field(24; "Bill Date"; Date)
        {
            Caption = 'Bill Date';
            DataClassification = CustomerContent;
        }
        field(25; "Bill Amount"; Decimal)
        {
            Caption = 'Bill Amount';
            DataClassification = CustomerContent;
        }
        field(26; "Vehicle No."; Code[20])
        {
            Caption = 'Vehicle No.';
            DataClassification = CustomerContent;
        }
        field(27; "In Time"; Time)
        {
            NotBlank = true;
            Caption = 'In Time';
            DataClassification = CustomerContent;
        }
        field(28; "Responsibility Center"; Code[20])
        {
            TableRelation = "Responsibility Center".Code;
            Caption = 'Responsibility Center';
            DataClassification = CustomerContent;
        }
        field(50004; Subcontracting; Boolean)
        {
            Description = 'CF001.02';
            Editable = false;
            Caption = 'Subcontracting';
            DataClassification = CustomerContent;
        }
        field(50025; Remarks; Text[200])
        {
            Caption = 'Remarks';
            DataClassification = CustomerContent;
        }
        field(50026; "Excise Amount"; Decimal)
        {
            Caption = 'Excise Amount';
            DataClassification = CustomerContent;
        }
        field(50027; "Sales Tax Amount"; Decimal)
        {
            Caption = 'Sales Tax Amount';
            DataClassification = CustomerContent;
        }
        field(50028; "User ID"; Code[20])
        {
            Editable = false;
            Caption = 'User ID';
            DataClassification = CustomerContent;
        }
        field(50030; "Vechile Type"; Option)
        {
            OptionMembers = Lorry,Container,Van," ";
            Caption = 'Vechile Type';
            DataClassification = CustomerContent;
        }
        field(50031; "Mode of Transport"; Code[20])
        {
            Caption = 'Mode of Transport';
            DataClassification = CustomerContent;
        }
        field(50032; "Transporter Name"; Text[30])
        {
            Caption = 'Transporter Name';
            DataClassification = CustomerContent;
        }
        field(50033; "Transporter Bill No."; Code[20])
        {
            Caption = 'Transporter Bill No.';
            DataClassification = CustomerContent;
        }
        field(50034; "Transporter Bill Date"; Date)
        {
            Caption = 'Transporter Bill Date';
            DataClassification = CustomerContent;
        }
        field(50035; "Delivery Challan No."; Code[20])
        {
            Caption = 'Delivery Challan No.';
            DataClassification = CustomerContent;
        }
        field(50036; "Delivery Challan Date"; Date)
        {
            Caption = 'Delivery Challan Date';
            DataClassification = CustomerContent;
        }
        field(50037; "Bill Entry No."; Code[30])
        {
            Caption = 'Bill Entry No.';
            DataClassification = CustomerContent;
        }
        field(50038; "Bill Entry Date"; Date)
        {
            Caption = 'Bill Entry Date';
            DataClassification = CustomerContent;
        }
        field(50050; "MRN Created"; Boolean)
        {
            Caption = 'MRN Created';
            DataClassification = CustomerContent;
        }
        field(50051; Blocked; Boolean)
        {
            Description = 'CEN001';
            Caption = 'Blocked';
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
        field(60003; Trading; Boolean)
        {
            Caption = 'Trading';
            Description = 'CE_AA004';
            Editable = false;
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                //PurchSetup.GET;
                //InitRecord;
            end;
        }
        field(60004; "MRN/Subnon MRN No."; Code[20])
        {
            Caption = 'MRN/Subnon MRN No.';
            DataClassification = CustomerContent;
        }
        field(60060; "RGP Posted"; Boolean)
        {
            Description = 'ALLE GI 291015';
            Caption = 'RGP Posted';
            DataClassification = CustomerContent;
        }
    }
    keys
    {
        key(Key1; "No.")
        {
            Clustered = true;
        }
        key(Key2; "Ref. Document Type", "Ref. Document No.", "MRN Created")
        {
        }
        key(Key3; "Party Type", "Party No.", "Bill No.", Blocked)
        {
        }
    }
    fieldgroups
    {
    }
    var
        cust: Record Customer;
        vend: Record Vendor;
        msg1: label 'hello';
        SalesShipmentHeader: Record "Sales Shipment Header";
        SalesShipmentLine: Record "Sales Shipment Line";
        GateEntryLine: Record "SSD Gate Line";
        ReturnReceiptLine: Record "Return Receipt Line";
        ReturnShipmentLine: Record "Return Shipment Line";
        // NoSeriesMgt: Codeunit NoSeriesManagement;
        InvtSetup: Record "Inventory Setup";
        HasInvtSetup: Boolean;
        PurchLine: Record "Purchase Line";
        GateEntryHeader: Record "SSD Gate Header";
        SalesInvoiceHeader: Record "Sales Invoice Header";
        SalesInvoiceLine: Record "Sales Invoice Line";
        CommentLine: Record "Comment Line";
        PurchCreditMemoHeader: Record "Purch. Cr. Memo Hdr.";
        PurchCreditMemoLine: Record "Purch. Cr. Memo Line";
        txt001: label 'This is not a valid option.';

    procedure GetInvtSetup()
    begin
    end;

    procedure AssistEdit(GateEntryHeader: Record "SSD Gate Header"): Boolean
    begin
    end;

    procedure ValidateRefDocumentType()
    begin
    end;

    procedure VenCustValidateDefaultRefDocTy()
    begin
    end;
}
