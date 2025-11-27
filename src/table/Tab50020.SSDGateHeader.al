Table 50020 "SSD Gate Header"
{
    // SM_MUA34 2005.07.29 New option  added on Ref Doc Type
    // SM_ML007 2005.10.20 Field Length Modified
    // // CF001.01 07.01.2006 added for responsibility center
    // //CF001.02  30.05.2006 For Subcontracting
    // //CEN003 For Gate Inbound
    // CE_AA001 For Barcode Sacnning
    // CML-023 ALLEAG 220208 :
    //   - Added one more option in Ref. Document type as "Posted Delivery Challan".
    //   - Added one more lookup in Ref. Document No. when Ref. Document type is as "Posted Delivery Challan"
    // ALLEAA CML-033 280308
    //   - New Option Added in Ref. Document Type
    // CML-034 ALLEAG 210408 :
    //   - Added one field "Customer RGP No.".
    DrillDownPageID = "Gate In List";
    LookupPageID = "Gate In List";
    DataClassification = CustomerContent;

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                "User ID" := UserId;
                NoSeriesMgt.TestManual(GetNoSeriesCode);
                "No. Series" := '';
            end;
        }
        field(3; "Party Type"; Option)
        {
            OptionMembers = Vendor,Customer,Employee;
            Caption = 'Party Type';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                if "Ref. Document No." <> '' then if not Confirm(Text003) then exit;
                "Party No." := '';
                Name := '';
                Address := '';
                Address2 := '';
                City := '';
                Phone := '';
                Telex := '';
                "Ref. Document No." := '';
                case "Party Type" of
                    "party type"::Customer:
                        Validate("Ref. Document Type", "ref. document type"::"Sales Returns");
                    "party type"::Vendor:
                        Validate("Ref. Document Type", "ref. document type"::"Purchase Order");
                    "party type"::Employee:
                        Validate("Ref. Document Type", "ref. document type"::"RGP Outbound");
                end;
            end;
        }
        field(4; "Party No."; Code[20])
        {
            Description = 'dev 10 --> 20';
            NotBlank = true;
            TableRelation = if ("Party Type" = const(Vendor)) Vendor."No."
            else if ("Party Type" = const(Customer)) Customer."No."
            else if ("Party Type" = const(Employee)) "Dimension Value".Code where("Dimension Code" = const('EMPLOYEE'), "Dimension Value Type" = const(Standard));
            Caption = 'Party No.';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                if "Ref. Document No." <> '' then if not Confirm('Lines exist against this Gate Entry, do you still want to continue') then exit;
                "Posting Date" := Today;
                "In Time" := Time;
                case "Party Type" of
                    "party type"::Customer:
                        begin
                            Cust.Get("Party No.");
                            Name := Cust.Name;
                            Address := Cust.Address;
                            Address2 := Cust."Address 2";
                            City := Cust.City;
                            Phone := Cust."Phone No.";
                            Telex := Cust."Telex No.";
                            Validate("Ref. Document Type", "ref. document type"::"Sales Returns");
                            "GST Party Type" := Cust."GST Customer Type";
                            "GST Registration No." := Cust."GST Registration No.";
                        end;
                    "party type"::Vendor:
                        begin
                            Vend.Get("Party No.");
                            Name := Vend.Name;
                            Address := Vend.Address;
                            Address2 := Vend."Address 2";
                            City := Vend.City;
                            Phone := Vend."Phone No.";
                            Telex := Vend."Telex No.";
                            //VALIDATE("Ref. Document Type", "Ref. Document Type"::"Purchase Order") //CE_AA001
                            "GST Party Type" := Vend."GST Vendor Type";
                            "GST Registration No." := Vend."GST Registration No.";
                        end;
                    "party type"::Employee:
                        begin
                            DimensionValue.Get('EMPLOYEE', "Party No.");
                            Name := DimensionValue.Name;
                            Address := '';
                            Address2 := '';
                            City := '';
                            Phone := '';
                            Telex := '';
                            "Ref. Document No." := '';
                            "GST Party Type" := "gst party type"::" ";
                            "GST Registration No." := '';
                            //VALIDATE("Ref. Document Type", "Ref. Document Type"::"RGP Outbound")
                        end;
                end;
            end;
        }
        field(5; Name; Text[100])
        {
            Editable = false;
            Caption = 'Name';
            DataClassification = CustomerContent;
        }
        field(6; Address; Text[80])
        {
            Editable = false;
            Caption = 'Address';
            DataClassification = CustomerContent;
        }
        field(7; Address2; Text[80])
        {
            Description = 'dev 75 --> 80';
            Editable = false;
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
            Description = 'dev 10 --> 75';
            Caption = 'Phone';
            DataClassification = CustomerContent;
        }
        field(10; Telex; Text[20])
        {
            Description = 'dev 10 --> 20';
            Caption = 'Telex';
            DataClassification = CustomerContent;
        }
        field(11; "Ref. Document Type"; Option)
        {
            Description = 'CML-023 ALLEAG 220208';
            OptionCaption = 'Purchase Order,Sales Returns,RGP Outbound,RGP Inbound,Cash Purchase,Purchase Schedule,Other,Posted Delivery Challan,Subcontracting,Transfer Order';
            OptionMembers = "Purchase Order","Sales Returns","RGP Outbound","RGP Inbound","Cash Purchase","Purchase Schedule",Other,"Posted Delivery Challan",Subcontracting,"Transfer Order";
            Caption = 'Ref. Document Type';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                case "Party Type" of
                    "party type"::Vendor:
                        if "Ref. Document Type" = "ref. document type"::"Sales Returns" then
                            Error(Text001);
                    "party type"::Customer:
                        if "Ref. Document Type" = "ref. document type"::"Purchase Order" then
                            Error(Text001);
                    "party type"::Employee:
                        if ("Ref. Document Type" = "ref. document type"::"Purchase Order") or ("Ref. Document Type" = "ref. document type"::"Sales Returns") then
                            Error(Text001);
                end;
                //********************** Commented By Ankit CEN003***************
                //IF "Ref. Document Type" = "Ref. Document Type"::"RGP Inbound" THEN ERROR(Text001);
                //VALIDATE("Ref. Document No.",'');
                //********************** Commented By Ankit CEN003***************
            end;
        }
        field(12; "Ref. Document No."; Code[20])
        {
            Description = 'CML-023 ALLEAG 220208';
            TableRelation = if ("Party Type" = const(Vendor), "Ref. Document Type" = const("Purchase Order")) "Purchase Header"."No." where("Document Type" = const(Order), "Buy-from Vendor No." = field("Party No."), "Document Subtype" = const(Order), Status = const(Released), "Read Only" = const(false))
            else if ("Party Type" = const(Vendor), "Ref. Document Type" = const("Purchase Schedule")) "Purchase Header"."No." where("Document Type" = const(Order), "Buy-from Vendor No." = field("Party No."), "Document Subtype" = const(Schedule), Status = const(Released), "Read Only" = const(false))
            else if ("Ref. Document Type" = const("RGP Outbound")) "SSD RGP Header"."No." where("Document Type" = const("RGP Outbound"), "Party No." = field("Party No."))
            else if ("Ref. Document Type" = const("Sales Returns"), "Party Type" = const(Customer)) "Sales Header"."No." where("Document Type" = const("Return Order"), "Sell-to Customer No." = field("Party No."), Status = filter(Released))
            else if ("Party Type" = const(Vendor), "Ref. Document Type" = filter(<> "RGP Inbound"), "Ref. Document Type" = filter(<> "Transfer Order"), "Ref. Document Type" = filter(<> "RGP Outbound")) "Delivery Challan Header"."No." where("Vendor No." = field("Party No."), "Remaining Quantity" = filter(true))
            else if ("Ref. Document Type" = const("RGP Inbound")) "SSD RGP Header"."No." where("Document Type" = const("RGP Inbound"), "Party No." = field("Party No."))
            else if ("Ref. Document Type" = const("Transfer Order")) "Transfer Header"."No.";
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
        field(17; "No. Series"; Code[10])
        {
            TableRelation = "No. Series";
            Caption = 'No. Series';
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
            Description = 'Lookup Field to Posted Receipts';
            //SSD TableRelation = "Purch. Rcpt. Header"."No." where(Field50046 = field("No."));
            Caption = 'MRN No.';
            DataClassification = CustomerContent;
        }
        field(20; D3; Boolean)
        {
            Description = 'Dev - For Sale Return';
            Caption = 'D3';
            DataClassification = CustomerContent;
        }
        field(21; "Purchase Invoice No."; Code[20])
        {
            Description = 'Dev - For Sale Return';
            TableRelation = "Purch. Inv. Header"."No.";
            Caption = 'Purchase Invoice No.';
            DataClassification = CustomerContent;
        }
        field(22; "Sales Invoice No."; Code[20])
        {
            Description = 'Dev - For Sale Out';
            Caption = 'Sales Invoice No.';
            DataClassification = CustomerContent;
        }
        field(23; "Bill No."; Code[20])
        {
            Caption = 'Bill No.';
            DataClassification = CustomerContent;

            trigger OnValidate()
            var
                GateHeader: Record "SSD Gate Header";
                TEXT50000: label 'Bill No. %1 already exist against other Gate Entry';
                PostedGateHeader: Record "SSD Posted Gate Header";
                TEXT50001: label 'Bill No. %1 already exist against other Posted Gate Entry';
            begin
                GateHeader.SetFilter("No.", '<>%1', "No.");
                GateHeader.SetRange("Bill No.", "Bill No.");
                if GateHeader.FindFirst then Error(TEXT50000, Rec."Bill No.");
                PostedGateHeader.SetRange("Bill No.", "Bill No.");
                if PostedGateHeader.FindFirst then Error(TEXT50001, Rec."Bill No.");
            end;
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
        field(50001; "Work Order No1"; Code[20])
        {
            Caption = 'Work Order No1';
            DataClassification = CustomerContent;
        }
        field(50002; "Work Order No2"; Code[20])
        {
            Caption = 'Work Order No2';
            DataClassification = CustomerContent;
        }
        field(50004; Subcontracting; Boolean)
        {
            Description = 'CF001.02';
            Editable = false;
            Caption = 'Subcontracting';
            DataClassification = CustomerContent;
        }
        field(50005; "Work Order No5"; Code[20])
        {
            Caption = 'Work Order No5';
            DataClassification = CustomerContent;
        }
        field(50006; "Work Order No6"; Code[20])
        {
            Caption = 'Work Order No6';
            DataClassification = CustomerContent;
        }
        field(50007; "Work Order No4"; Code[20])
        {
            Caption = 'Work Order No4';
            DataClassification = CustomerContent;
        }
        field(50008; "Work Order No3"; Code[20])
        {
            Caption = 'Work Order No3';
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
        field(50054; Scan; Text[250])
        {
            Description = 'ALLE-NM';
            Caption = 'Scan';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                if (Scan <> '') and ("Party No." = '') then begin
                    BarcodeStr := Scan;
                    Validate("Party No.", SelectStr(1, BarcodeStr));
                    Validate("Ref. Document No.", SelectStr(5, BarcodeStr));
                    "Bill No." := SelectStr(2, BarcodeStr);
                    Modify;
                    Evaluate("Bill Amount", SelectStr(7, BarcodeStr));
                    Evaluate("Bill Date", SelectStr(3, BarcodeStr));
                    Evaluate("Excise Amount", SelectStr(8, BarcodeStr));
                    Evaluate("Sales Tax Amount", SelectStr(9, BarcodeStr));
                    FrmGateLine.InsertGateLines(Rec);
                    GateLine.Reset;
                    GateLine.SetRange(GateLine."Document No.", "No.");
                    GateLine.SetRange(GateLine."Party Type", "Party Type");
                    GateLine.SetRange(GateLine."Party No.", "Party No.");
                    GateLine.SetRange(GateLine."Ref. Document Type", "Ref. Document Type");
                    GateLine.SetRange(GateLine."Ref. Document No.", "Ref. Document No.");
                    GateLine.SetRange(GateLine."No.", SelectStr(4, BarcodeStr));
                    if GateLine.Find('-') then Evaluate(GateLine."Challan Quantity", SelectStr(6, BarcodeStr));
                    GateLine.Modify;
                end;
            end;
        }
        field(50055; "GST Registration No."; Code[15])
        {
            Caption = 'GST Registration No.';
            Description = 'ALLE-NM';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(50056; "GST Party Type"; Option)
        {
            Caption = 'GST Party Type';
            Editable = false;
            OptionCaption = ' ,Registered,Composite,Unregistered,Import,Exempted,SEZ';
            OptionMembers = " ",Registered,Composite,Unregistered,Import,Exempted,SEZ;
            DataClassification = CustomerContent;
        }
        field(50057; "GST Registration No. Manual"; Code[15])
        {
            Caption = 'GST Registration No. Manual';
            Description = 'ALLE-NM';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                if CopyStr("GST Registration No.", 12, 4) <> "GST Registration No. Manual" then Error('GST Registration No. must be same');
                //ALLE-NM
            end;
        }
        field(50060; "Customer RGP No."; Code[20])
        {
            Description = 'CML-034';
            Caption = 'Customer RGP No.';
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
    }
    keys
    {
        key(Key1; "No.")
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
    }
    trigger OnDelete()
    begin
        GateLine.SetRange("Document No.", "No.");
        GateLine.DeleteAll;
    end;

    trigger OnInsert()
    begin
        if "No." = '' then begin
            //IG_DS_Before  NoSeriesMgt.InitSeries(GetNoSeriesCode, xRec."No. Series", WorkDate, "No.", "No. Series");
            if NoSeriesMgt.AreRelated(GetNoSeriesCode, xRec."No. Series") then
                "No. Series" := xRec."No. Series"
            else
                "No. Series" := GetNoSeriesCode;
            "No." := NoSeriesMgt.GetNextNo("No. Series", WorkDate);
            "Posting Date" := WorkDate;
        end;
        "User ID" := UserId;
    end;

    trigger OnRename()
    begin
        Error(Text002);
    end;

    var
        Cust: Record Customer;
        Vend: Record Vendor;
        GateLine: Record "SSD Gate Line";
        NoSeriesMgt: Codeunit "No. Series";//IG_DS NoSeriesManagement;
        GateSetup: Record "SSD AddOn Setup";
        HasGateSetup: Boolean;
        Text001: label 'This is not a valid option.';
        DimensionValue: Record "Dimension Value";
        ResponcibilityCenter: Record "Responsibility Center";
        //SSD UserMgt: Codeunit "SSD User Setup Management";
        Text002: label 'You cann''''t rename the Gate Entry';
        Text003: label 'Lines exist against this Gate Entry, do you still want to continue';
        BarcodeStr: Text[250];
        GateLines: Record "SSD Gate Line";
        FrmGateLine: Page "Gate In Subform";
        Test: Code[20];

    procedure GetGateSetup()
    begin
        if not HasGateSetup then begin
            GateSetup.Get;
            HasGateSetup := true;
        end;
    end;

    procedure AssistEdit(GateHeader: Record "SSD Gate Header"): Boolean
    var
        SSDGateEntryHeader: Record "SSD Gate Header";
        Text012: Label 'The No. %1 %2 already exists.';
    begin
        //IG_DS_Before if NoSeriesMgt.SelectSeries(GetNoSeriesCode, xRec."No. Series", "No. Series") then begin
        //     NoSeriesMgt.SetSeries("No.");
        //     exit(true);

        if NoSeriesMgt.LookupRelatedNoSeries(GetNoSeriesCode, xRec."No. Series", "No. Series") then begin
            "No." := NoSeriesMgt.GetNextNo("No. Series");
            if SSDGateEntryHeader.Get(Rec."No.") then
                Error(Text012, Rec."No.");
            exit(true);
        end;
        // end;
    end;

    local procedure GetNoSeriesCode(): Code[10]
    begin
        //CF001.01 St
        //SSD "Responsibility Center" := UserMgt.GetRespCenterFilter;
        //CF001.01 En
        if "Responsibility Center" <> '' then begin
            ResponcibilityCenter.Get("Responsibility Center");
            if ResponcibilityCenter."Gate In Nos" <> '' then exit(ResponcibilityCenter."Gate In Nos")
        end;
        GetGateSetup;
        exit(GateSetup."Gate In Nos");
    end;
}
