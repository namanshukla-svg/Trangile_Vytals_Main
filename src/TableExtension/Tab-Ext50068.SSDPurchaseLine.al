tableextension 50068 "SSD Purchase Line" extends "Purchase Line"
{
    fields
    {
        modify(Type)
        {
            trigger OnAfterValidate()
            var
                PurchaseHeader: Record "Purchase Header";
            begin
                PurchaseHeader := GetPurchHeader();
                if "No." <> '' then PurchaseHeader.TestField(Status, PurchaseHeader.Status::Open);
                //SSDU
                //CheckTypeofInvoice();
                //SSDU
            end;
        }
        modify("No.")
        {
            trigger OnAfterValidate()
            var
                PurchaseHeader: Record "Purchase Header";
                PurchaseHeader3: Record "Purchase Header";
                // PurchasePrice: Record "Purchase Price"; //IG_DS_Before
                PurchasePrice: Record "Price List Line"; //IG_DS_After
                Item: Record Item;
                GLSetup: Record "General Ledger Setup";
                ItemVendor: Record "Item Vendor";
                ItemVendor2: Record "Item Vendor";
                Item2: Record Item;
                PurchaseHeader4: Record "Purchase Header";
                SSDValidation: Codeunit Validation;
            begin
                PurchaseHeader := GetPurchHeader();
                if not "System-Created Entry" then
                    if PurchaseHeader."Invoice Type Old" = PurchaseHeader."Invoice Type Old"::"Purchase Voucher" then
                        TESTFIELD(Type, Type::Item)
                    else if PurchaseHeader."Invoice Type Old" = PurchaseHeader."Invoice Type Old"::"Expense Voucher" then if Type in [Type::Item] then Error('You cannot select Type %1', Type);
                "Posting Date" := PurchaseHeader."Posting Date";
                if Type = Type::Item then begin
                    IF PurchaseHeader3.GET("Document Type"::Order, "Document No.") THEN begin
                        //SSD_Item Vendor
                        GLSetup.Get();
                        if GLSetup."SSD Activate Item Vendor" then begin
                            Item2.Reset();
                            Item2.Get("No.");
                            if Item2."Quality Required" then begin
                                ItemVendor.Reset();
                                IF not ItemVendor.Get(PurchaseHeader3."Buy-from Vendor No.", "No.", "Variant Code") then Error('Item is not approved for this Vendor');
                                "Vendor Item Description" := ItemVendor."Item Description";
                                if (PurchaseHeader3."Order Date" < ItemVendor."Validity Period Start Date") or (PurchaseHeader3."Order Date" > ItemVendor."Validity Period End Date") then Error('Validity period has been expired for this vendor item.');
                            end;
                        end;
                        //SSD_Item Vendor
                        PurchasePrice.RESET;
                        PurchasePrice.SETRANGE("Source No.", PurchaseHeader3."Buy-from Vendor No.");
                        PurchasePrice.SETFILTER("Starting Date", '<=%1', PurchaseHeader3."Posting Date");
                        PurchasePrice.SETFILTER("Ending Date", '>=%1', PurchaseHeader3."Posting Date");
                        PurchasePrice.SETRANGE("Asset No.", Rec."No.");
                        IF PurchasePrice.FINDLAST THEN
                            IF (PurchasePrice."Direct Unit Cost" = "Direct Unit Cost") THEN
                                "Price Match/Mismatch" := TRUE
                            ELSE
                                "Price Match/Mismatch" := FALSE
                        ELSE
                            "Price Match/Mismatch" := FALSE;
                    end;
                    "Last PO Price" := LastPOPrice("No.", "Variant Code");
                    "Last Landed Cost" := POLandedPrice("No.", "Variant Code");
                end;
                if Item.Get("No.") then begin
                    IF "Unit of Measure Code" <> Item."Base Unit of Measure" THEN MESSAGE('Purchase UOM is Different from item UOM');
                end;
                if "Document Type" = "Document Type"::Order then "Document Subtype" := "Document Subtype"::Order;
                if "Document Type" = "Document Type"::Invoice then SSDValidation.GetAccountDetails(Rec);
                if ("GST Vendor Type" = "GST Vendor Type"::Import) then "GST Reverse Charge" := true;
            end;
        }
        //IG_DS_23-06-2025>>>
        modify("Direct Unit Cost")
        {
            trigger OnAfterValidate()
            var
                // PurchasePrice: Record "Purchase Price"; //IG_DS_Before
                PurchasePrice: Record "Price List Line"; //IG_DS_After
                PurchaseHeader3: Record "Purchase Header";
            begin
                if Type = Type::Item then begin
                    IF PurchaseHeader3.GET("Document Type"::Order, Rec."Document No.") THEN begin
                        PurchasePrice.RESET;
                        PurchasePrice.SETRANGE("Source No.", PurchaseHeader3."Buy-from Vendor No.");
                        PurchasePrice.SETFILTER("Starting Date", '<=%1', PurchaseHeader3."Posting Date");
                        PurchasePrice.SETFILTER("Ending Date", '>=%1', PurchaseHeader3."Posting Date");
                        PurchasePrice.SETRANGE("Asset No.", Rec."No.");
                        IF PurchasePrice.FINDLAST THEN
                            IF (PurchasePrice."Direct Unit Cost" = Rec."Direct Unit Cost") THEN
                                Rec."Price Match/Mismatch" := TRUE
                            ELSE
                                Rec."Price Match/Mismatch" := FALSE
                        ELSE
                            Rec."Price Match/Mismatch" := FALSE;
                    end;
                end;
            end;

        }
        //IG_DS_23-06-2025<<<
        modify("HSN/SAC Code")
        {
            trigger OnAfterValidate()
            var
                PurchaseHeader: Record "Purchase Header";
                GSTGroup: Record "GST Group";
            begin
                PurchaseHeader := GetPurchHeader();
                if (PurchaseHeader."GST Vendor Type" = PurchaseHeader."GST Vendor Type"::Import) and (Type = Type::Item) then begin
                    "GST Reverse Charge" := true;
                end;
            end;
        }
        modify("Variant Code")
        {
            trigger OnAfterValidate()
            begin
                "Last PO Price" := LastPOPrice("No.", "Variant Code");
                "Last Landed Cost" := POLandedPrice("No.", "Variant Code");
            end;
        }
        modify(Quantity)
        {
            trigger OnAfterValidate()
            begin
                Difference := ("Budgeted Cost Amount" - "Unit Cost (LCY)") * Quantity;
            end;
        }
        modify("Unit Cost")
        {
            trigger OnAfterValidate()
            begin
                Difference := ("Budgeted Cost Amount" - "Unit Cost (LCY)") * Quantity;
            end;
        }
        field(50001; "Document Subtype"; Option)
        {
            Description = 'CF002';
            OptionCaption = ' ,Order,Contract,Service Contract,Schedule';
            OptionMembers = " ","Order",Contract,"Service Contract",Schedule;
            DataClassification = CustomerContent;
            Caption = 'Document Subtype';
        }
        field(50007; "Hold Payment"; Boolean)
        {
            Description = 'HP1.0';
            Editable = false;
            DataClassification = CustomerContent;
            Caption = 'Hold Payment';
        }
        field(50011; "Posted Quality Order No."; Code[20])
        {
            Description = 'QLT';
            DataClassification = CustomerContent;
            Caption = 'Posted Quality Order No.';
        }
        field(50012; "Concerted Quality"; Boolean)
        {
            Caption = 'Concerted Quality';
            Description = 'QLT';
            DataClassification = CustomerContent;
        }
        field(50013; "Vendor Claim Code"; Code[10])
        {
            Caption = 'Vendor Claim Code';
            Description = 'QLT';
            DataClassification = CustomerContent;
        }
        field(50014; "Quality Defect Code"; Code[10])
        {
            Caption = 'Quality Defect Code';
            Description = 'QLT';
            DataClassification = CustomerContent;
        }
        field(50015; "Accepted Qty."; Decimal)
        {
            Description = 'QLT';
            Editable = true;
            DataClassification = CustomerContent;
            Caption = 'Accepted Qty.';

            trigger OnValidate()
            begin
                //SSD-0002
                if Confirm('Do you want update Posted Req. Purch. Lines') then updatePostedReqPurchLines();
                //SSD-0002
            end;
        }
        field(50016; "Rejected Qty."; Decimal)
        {
            Description = 'QLT';
            Editable = false;
            DataClassification = CustomerContent;
            Caption = 'Rejected Qty.';
        }
        field(50017; "Reject Location Code"; Code[10])
        {
            Description = 'QLT';
            TableRelation = Location where("Quality Rejects" = const(true));
            DataClassification = CustomerContent;
            Caption = 'Reject Location Code';
        }
        field(50018; "Reject Bin Code"; Code[20])
        {
            Description = 'QLT';
            TableRelation = Bin.Code where("Location Code" = field("Location Code"));
            DataClassification = CustomerContent;
            Caption = 'Reject Bin Code';
        }
        field(50019; "Total Indent Qty"; Decimal)
        {
            CalcFormula = sum("SSD Posted Req. Purch. Line"."Requisition Qty" where("Purch. Document Type" = field("Document Type"), "Purch. Document No." = field("Document No."), "Purch. Document Line No." = field("Line No.")));
            Description = 'IND';
            FieldClass = FlowField;
            Caption = 'Total Indent Qty';
        }
        field(50020; "Short Closed"; Boolean)
        {
            Description = 'Alle VPB';
            Editable = false;
            DataClassification = CustomerContent;
            Caption = 'Short Closed';
        }
        field(50021; "Short Closed Qty"; Decimal)
        {
            Description = 'Alle VPB';
            Editable = false;
            DataClassification = CustomerContent;
            Caption = 'Short Closed Qty';
        }
        field(50050; "MRP Qty."; Decimal)
        {
            Description = 'Alle 290916';
            Editable = false;
            DataClassification = CustomerContent;
            Caption = 'MRP Qty.';
        }
        field(50090; "Assessable Value GST"; Decimal)
        {
            Description = 'ALLE ANSH GST';
            DataClassification = CustomerContent;
            Caption = 'Assessable Value GST';
        }
        field(50091; "Assessable Value GST LCY"; Decimal)
        {
            Description = 'ALLE ANSH GST';
            DataClassification = CustomerContent;
            Caption = 'Assessable Value GST LCY';

            //SSD Sunil
            trigger OnValidate()
            var
                PurchaseHeader: Record "Purchase Header";
                CurrExchRate: Record "Currency Exchange Rate";
                Dt: Date;
                GSTAssessableValue: Decimal;
            begin
                IF PurchaseHeader.get(Rec."Document Type", Rec."Document No.") then begin
                    IF PurchaseHeader."GST Vendor Type" = PurchaseHeader."GST Vendor Type"::Import THEN begin
                        Clear(Dt);
                        if PurchaseHeader."Posting Date" <> 0D then
                            Dt := PurchaseHeader."Posting Date"
                        else
                            Dt := WorkDate();
                        "Assessable Value GST" := CurrExchRate.ExchangeAmtLCYToFCY(GetDate, "Currency Code", "Assessable Value GST LCY", PurchaseHeader."Currency Factor");
                        "GST Assessable Value" := 0;
                        validate("GST Assessable Value", ("Assessable Value GST"));
                    end;
                end;
            end;
            //SSD Sunil
        }
        field(50092; "Custom Duty Amount LCY"; Decimal)
        {
            Description = 'ALLE ANSH GST';
            DataClassification = CustomerContent;
            Caption = 'Custom Duty Amount LCY';

            //SSD Sunil
            trigger OnValidate()
            var
                PurchaseHeader: Record "Purchase Header";
                CurrExchRate: Record "Currency Exchange Rate";
                Dt: Date;
            begin
                IF PurchaseHeader.get(Rec."Document Type", Rec."Document No.") then begin
                    IF PurchaseHeader."GST Vendor Type" = PurchaseHeader."GST Vendor Type"::Import THEN begin
                        Clear(Dt);
                        if PurchaseHeader."Posting Date" <> 0D then
                            Dt := PurchaseHeader."Posting Date"
                        else
                            Dt := WorkDate();
                        "Custom Duty Amount" := CurrExchRate.ExchangeAmtLCYToFCY(Dt, "Currency Code", "Custom Duty Amount LCY", PurchaseHeader."Currency Factor");
                        "GST Assessable Value" := 0;
                        validate("GST Assessable Value", ("Assessable Value GST"));
                    end;
                end;
            end;
            //SSD Sunil
        }
        field(50093; "Price Match/Mismatch"; Boolean)
        {
            Description = 'ALLE';
            DataClassification = CustomerContent;
            Caption = 'Price Match/Mismatch';
        }
        field(50094; "Description 3"; Text[300])
        {
            Description = 'ALLE-060121';
            DataClassification = CustomerContent;
            Caption = 'Description 3';

            trigger OnValidate()
            begin
                TestStatusOpen();
            end;
        }
        field(50350; "SSD Receipt Remarks"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Receipt Remarks';
        }
        field(50351; "SSD Deduction Amount"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Deduction Amount with GST';
            DecimalPlaces = 2 : 2;

            trigger OnValidate()
            begin
                if "SSD Deduction Amount" = 0 then "SSD Deduction Remarks" := '';
            end;
        }
        field(50352; "SSD Deduction Remarks"; Text[200])
        {
            DataClassification = CustomerContent;
            Caption = 'Deduction Remarks';

            trigger OnValidate()
            begin
                TestField("SSD Deduction Amount");
            end;
        }
        field(50353; "SSD Posting Account"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Posting Account';
            Editable = false;
        }
        field(50354; "SSD Posting Acc Name"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Posting Account Name';
            Editable = false;
        }
        field(52011; "Challan Quantity"; Decimal)
        {
            BlankZero = true;
            DecimalPlaces = 0 : 5;
            Description = 'CF001';
            DataClassification = CustomerContent;
            Caption = 'Challan Quantity';

            trigger OnValidate()
            begin
                if "Challan Quantity" <= "Outstanding Quantity" then Validate("Qty. to Receive", "Challan Quantity");
            end;
        }
        field(52012; "Applies to Delivery Challan"; Code[20])
        {
            TableRelation = "Delivery Challan Line" where("Production Order No." = field("Prod. Order No."), "Production Order Line No." = field("Prod. Order Line No."), "Remaining Quantity" = filter(> 0));
            DataClassification = CustomerContent;
            Caption = 'Applies to Delivery Challan';
        }
        field(53044; "Auto Approval"; Boolean)
        {
            Description = 'Alle_190417';
            DataClassification = CustomerContent;
            Caption = 'Auto Approval';
        }
        field(53045; Difference; Decimal)
        {
            Description = 'Alle_Auto_Appove_PO_190417';
            DataClassification = CustomerContent;
            Caption = 'Difference';
        }
        field(54002; "Indent No."; Code[20])
        {
            CalcFormula = lookup("SSD Posted Req. Purch. Line"."Posted Indent Document No." where("Purch. Document Type" = field("Document Type"), "Purch. Document No." = field("Document No."), "Purch. Document Line No." = field("Line No.")));
            Description = 'IND';
            FieldClass = FlowField;
            Caption = 'Indent No.';
        }
        field(54003; "Indent Line No."; Integer)
        {
            CalcFormula = lookup("SSD Posted Req. Purch. Line"."Posted Indent Line No." where("Purch. Document Type" = field("Document Type"), "Purch. Document No." = field("Document No."), "Purch. Document Line No." = field("Line No.")));
            Description = 'IND';
            FieldClass = FlowField;
            Caption = 'Indent Line No.';
        }
        field(54004; Remarks; Text[30])
        {
            Description = 'CF001-5-51=>100-->10';
            DataClassification = CustomerContent;
            Caption = 'Remarks';
        }
        field(54005; "Gate Entry no."; Code[20])
        {
            Description = 'CF001';
            DataClassification = CustomerContent;
            Caption = 'Gate Entry no.';
        }
        field(54006; "Gate Entry Date"; Date)
        {
            Description = 'CF001';
            DataClassification = CustomerContent;
            Caption = 'Gate Entry Date';
        }
        field(54009; "Gate Line No."; Integer)
        {
            Description = 'CF001';
            DataClassification = CustomerContent;
            Caption = 'Gate Line No.';
        }
        field(54010; "Total Posted Gate Challan Qty"; Decimal)
        {
            CalcFormula = sum("SSD Posted Gate Line"."Challan Quantity" where("Party Type" = const(Vendor), "Party No." = field("Buy-from Vendor No."), "Ref. Document Type" = filter("Purchase Order" | "Purchase Schedule"), "Ref. Document No." = field("Document No."), Type = field(Type), "No." = field("No."), "Ref. Document Line No." = field("Line No.")));
            Description = 'CF001';
            Editable = false;
            FieldClass = FlowField;
            Caption = 'Total Posted Gate Challan Qty';
        }
        field(54016; "Total Delivery Challan Qty"; Decimal)
        {
            CalcFormula = sum("Delivery Challan Line".Quantity where("Document No." = field("Document No."), "Document Line No." = field("Line No.")));
            Description = 'CF003';
            Editable = false;
            FieldClass = FlowField;
            Caption = 'Total Delivery Challan Qty';
        }
        field(54017; "Total Gate Challan Qty"; Decimal)
        {
            CalcFormula = sum("SSD Gate Line"."Challan Quantity" where("Party Type" = const(Vendor), "Party No." = field("Buy-from Vendor No."), "Ref. Document Type" = filter("Purchase Order" | "Purchase Schedule"), "Ref. Document No." = field("Document No."), Type = field(Type), "No." = field("No."), "Ref. Document Line No." = field("Line No.")));
            Description = 'CF003';
            Editable = true;
            FieldClass = FlowField;
            Caption = 'Total Gate Challan Qty';
        }
        field(54018; "No. Of Purch. Rcvd"; Integer)
        {
            CalcFormula = count("Purch. Rcpt. Header" where("Order No." = field("Document No.")));
            Caption = 'No. Of Purchase Received';
            Description = 'CF003';
            Editable = false;
            FieldClass = FlowField;
        }
        field(54019; "P.O Status"; Option)
        {
            Description = 'CF_SC_001';
            OptionCaption = 'Open,Released';
            OptionMembers = Open,Released;
            DataClassification = CustomerContent;
            Caption = 'P.O Status';
        }
        field(54021; "Posted Indent No."; Code[20])
        {
            Description = 'CF_SC_001';
            DataClassification = CustomerContent;
            Caption = 'Posted Indent No.';
        }
        field(54022; "Posted Indent Line No."; Integer)
        {
            Description = 'CF_SC_001';
            DataClassification = CustomerContent;
            Caption = 'Posted Indent Line No.';
        }
        field(54023; Grade; Text[30])
        {
            CalcFormula = lookup(Item.Grade where("No." = field("No.")));
            Description = 'CF001 Grade req. for raw material';
            FieldClass = FlowField;
            Caption = 'Grade';
        }
        field(54024; "Bill No."; Code[20])
        {
            CalcFormula = lookup("SSD Posted Gate Header"."Bill No." where("No." = field("Gate Entry no."), "Party No." = field("Buy-from Vendor No.")));
            FieldClass = FlowField;
            Caption = 'Bill No.';
        }
        field(54025; "Customer No."; Code[20])
        {
            Description = 'ALLE-TRA1.0';
            TableRelation = Customer."No.";
            DataClassification = CustomerContent;
            Caption = 'Customer No.';

            trigger OnValidate()
            var
                Customer: Record Customer;
            begin
                Customer.Get("Customer No.");
                "SalesPerson Code" := Customer."Salesperson Code";
            end;
        }
        field(54026; "SalesPerson Code"; Code[10])
        {
            Description = 'ALLE-TRA1.0';
            Editable = false;
            TableRelation = "Salesperson/Purchaser".Code;
            DataClassification = CustomerContent;
            Caption = 'SalesPerson Code';
        }
        field(54050; "Budgeted Cost Amount"; Decimal)
        {
            Description = 'ALLE-BUDG';
            DataClassification = CustomerContent;
            Caption = 'Budgeted Cost Amount';

            trigger OnValidate()
            begin
                Difference := ("Budgeted Cost Amount" - "Unit Cost (LCY)") * Quantity; //Alle_190417
            end;
        }
        field(60054; "RG Entry Created"; Boolean)
        {
            Description = 'CML-038';
            DataClassification = CustomerContent;
            Caption = 'RG Entry Created';
        }
        field(60500; "RG Entry No"; Code[20])
        {
            Description = 'SSD';
            DataClassification = CustomerContent;
            Caption = 'RG Entry No';
        }
        field(60501; "Excise Picked"; Boolean)
        {
            Description = 'Alle VPB';
            DataClassification = CustomerContent;
            Caption = 'Excise Picked';
        }
        field(75006; "BCD %"; Decimal)
        {
            Description = 'Alle VPB Import 280610';
            DataClassification = CustomerContent;
            Caption = 'BCD %';
        }
        field(75007; "CIF Amount (LCY)"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            DecimalPlaces = 0 : 5;
            Description = 'Alle VPB Import 280610';
            DataClassification = CustomerContent;
            Caption = 'CIF Amount (LCY)';
        }
        field(75008; "BCD Amount (LCY)"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Description = 'Alle VPB Import 280610';
            Editable = true;
            DataClassification = CustomerContent;
            Caption = 'BCD Amount (LCY)';
        }
        field(75009; "BED Amount (LCY)"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            DecimalPlaces = 0 : 5;
            Description = 'Alle VPB Import 280610';
            DataClassification = CustomerContent;
            Caption = 'BED Amount (LCY)';
        }
        field(75010; "eCess Amount (LCY)"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Description = 'Alle VPB Import 280610';
            Editable = true;
            DataClassification = CustomerContent;
            Caption = 'eCess Amount (LCY)';
        }
        field(75011; "SHE Cess Amount (LCY)"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Description = 'Alle VPB Import 280610';
            Editable = true;
            DataClassification = CustomerContent;
            Caption = 'SHE Cess Amount (LCY)';
        }
        field(75012; "Custom eCess Amount (LCY)"; Decimal)
        {
            Description = 'Alle VPB Import 280610';
            DataClassification = CustomerContent;
            Caption = 'Custom eCess Amount (LCY)';
        }
        field(75013; "Custom SHECess Amount (LCY)"; Decimal)
        {
            Description = 'Alle VPB Import 280610';
            DataClassification = CustomerContent;
            Caption = 'Custom SHECess Amount (LCY)';
        }
        field(75014; "ADC VAT Amount (LCY)"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Description = 'Alle VPB Import 280610';
            Editable = true;
            DataClassification = CustomerContent;
            Caption = 'ADC VAT Amount (LCY)';
        }
        field(75015; "Quality Required"; Boolean)
        {
            Description = 'ALLE ZEV-5.51';
            DataClassification = CustomerContent;
            Caption = 'Quality Required';
        }
        field(75016; "Quality Rcpt Template"; Code[20])
        {
            Description = 'ALLE ZEV-5.51';
            DataClassification = CustomerContent;
            Caption = 'Quality Rcpt Template';
        }
        field(75017; "Quality Done"; Boolean)
        {
            Description = 'ALLE ZEV-5.51';
            DataClassification = CustomerContent;
            Caption = 'Quality Done';
        }
        field(75018; "Quality Send"; Boolean)
        {
            Description = 'ALLE ZEV-5.51';
            DataClassification = CustomerContent;
            Caption = 'Quality Send';
        }
        field(75019; "Service Order No."; Code[20])
        {
            Description = 'Alle 24052021';
            Editable = false;
            DataClassification = CustomerContent;
            Caption = 'Service Order No.';
        }
        field(75020; "Service Outstanding Amount"; Decimal)
        {
            Description = 'Alle 24052021 //Service Order Outstanding Amount';
            Editable = true;
            DataClassification = CustomerContent;
            Caption = 'Service Outstanding Amount';
        }
        //SSD Sunil
        field(75021; "Last Landed Cost"; Decimal)
        {
            Description = 'Last Landed Cost';
            Editable = false;
            DataClassification = CustomerContent;
            Caption = 'Last Landed Cost';
        }
        field(75022; "Last PO Price"; Decimal)
        {
            Description = 'Last PO Price';
            Editable = false;
            DataClassification = CustomerContent;
            Caption = 'Last PO Price';
        }
        //SSD Sunil
        field(75023; "Vendor Item Description"; Text[100])
        {
            Description = 'Vendor Item Description';
            Editable = false;
            DataClassification = CustomerContent;
            Caption = 'Vendor Item Description';
        }
    }
    trigger OnDelete()
    var
        RequisitionLine: Record "Requisition Line";
        PostedIndentLine: Record "SSD Posted Indent Line";
        PostedReqPurchLinesLocal: Record "SSD Posted Req. Purch. Line";
    begin
        if "Posted Indent No." <> '' then begin
            RequisitionLine.Reset();
            RequisitionLine.SetRange("Indent No.", "Posted Indent No.");
            RequisitionLine.SetRange("Indent Line No.", "Posted Indent Line No.");
            if RequisitionLine.FindFirst() then begin
                RequisitionLine."Pending PO Qty" += "Total Indent Qty";
                if not RequisitionLine."Pending PO" then RequisitionLine."Pending PO" := true;
                RequisitionLine.Modify();
            end;
            PostedIndentLine.Reset();
            PostedIndentLine.SetRange("Document No.", "Posted Indent No.");
            PostedIndentLine.SetRange("Line No.", "Posted Indent Line No.");
            if PostedIndentLine.FindFirst() then begin
                PostedIndentLine."Pending PO Qty" += "Total Indent Qty";
                if not PostedIndentLine."Pending PO" then PostedIndentLine."Pending PO" := true;
                PostedIndentLine.Modify();
            end;
            PostedReqPurchLinesLocal.Reset();
            PostedReqPurchLinesLocal.SetRange("Posted Indent Document No.", "Posted Indent No.");
            PostedReqPurchLinesLocal.SetRange("Posted Indent Line No.", "Posted Indent Line No.");
            PostedReqPurchLinesLocal.SetRange("Requisition Qty", "Total Indent Qty");
            if PostedReqPurchLinesLocal.FindLast() then PostedReqPurchLinesLocal.Delete();
        end;
    end;

    procedure ShowDeliveryChallan()
    var
        FrmPostedDeliveryChallan: Page "Delivery Challan";
        DeliveryChallanHeaderLocal: Record "Delivery Challan Header";
        FrmDeliveryChallanList: Page "Delivery Challan List";
    begin
        //CF001.02 St
        TestField("Document No.");
        TestField("Line No.");
        DeliveryChallanHeaderLocal.Reset();
        DeliveryChallanHeaderLocal.SetCurrentkey("Sub. order No.", "Sub. Order Line No.");
        DeliveryChallanHeaderLocal.FilterGroup(2);
        DeliveryChallanHeaderLocal.SetRange("Sub. order No.", "Document No.");
        DeliveryChallanHeaderLocal.SetRange("Sub. Order Line No.", "Line No.");
        DeliveryChallanHeaderLocal.FilterGroup(0);
        FrmDeliveryChallanList.SetTableview(DeliveryChallanHeaderLocal);
        //SSDU FrmDeliveryChallanList.SetControls();
        FrmDeliveryChallanList.LookupMode := false;
        FrmDeliveryChallanList.RunModal();
        //CF001.02 En
    end;

    procedure ShowPostedGateEntry()
    var
        PostedGateHdrLocal: Record "SSD Posted Gate Header";
        PostedGateLineLocal: Record "SSD Posted Gate Line";
        FrmPostedGateInList: Page "Posted Gate In List";
    begin
        //CF001.02 St
        TestField("Document No.");
        TestField("Line No.");
        PostedGateLineLocal.Reset();
        PostedGateHdrLocal.Reset();
        PostedGateHdrLocal.FilterGroup(2);
        PostedGateLineLocal.SetCurrentkey("Party Type", "Party No.", "Ref. Document Type", "Ref. Document No.", Type, "No.", "Ref. Document Line No.");
        PostedGateLineLocal.SetRange("Party Type", PostedGateLineLocal."party type"::Vendor);
        PostedGateLineLocal.SetRange("Party No.", "Buy-from Vendor No.");
        PostedGateLineLocal.SetFilter("Ref. Document Type", '%1|%2', PostedGateLineLocal."ref. document type"::"Purchase Order", PostedGateLineLocal."ref. document type"::"Purchase Schedule");
        PostedGateLineLocal.SetRange("Ref. Document No.", "Document No.");
        PostedGateLineLocal.SetRange(Type, Type);
        PostedGateLineLocal.SetRange("No.", "No.");
        PostedGateLineLocal.SetRange("Ref. Document Line No.", "Line No.");
        if PostedGateLineLocal.FindSet() then
            repeat
                PostedGateHdrLocal.Get(PostedGateLineLocal."Document No.");
                PostedGateHdrLocal.Mark(true);
            until PostedGateLineLocal.Next() = 0;
        PostedGateHdrLocal.MarkedOnly(true);
        PostedGateHdrLocal.FilterGroup(0);
        Clear(FrmPostedGateInList);
        FrmPostedGateInList.SetTableview(PostedGateHdrLocal);
        FrmPostedGateInList.LookupMode := true;
        FrmPostedGateInList.RunModal();
        //CF001.02 En
    end;

    procedure updatePostedReqPurchLines()
    var
        PostedReqPurchLinesLocal: Record "SSD Posted Req. Purch. Line";
        PurchHeader: Record "Purchase Header";
        Lineno: Integer;
    begin
        PurchHeader := GetPurchHeader();
        PostedReqPurchLinesLocal.Reset();
        PostedReqPurchLinesLocal.SetRange("Posted Indent Document No.", '');
        PostedReqPurchLinesLocal.SetRange("Posted Indent Line No.", 0);
        if PostedReqPurchLinesLocal.FindLast() then Lineno := PostedReqPurchLinesLocal."Line No." + 10000;
        PostedReqPurchLinesLocal.SetCurrentkey("Purch. Document Type", "Purch. Document No.", "Purch. Document Line No.", "Due Date");
        PostedReqPurchLinesLocal.FilterGroup(2);
        PostedReqPurchLinesLocal.SetRange("Purch. Document Type", "Document Type");
        PostedReqPurchLinesLocal.SetRange("Purch. Document No.", "Document No.");
        PostedReqPurchLinesLocal.SetRange("Purch. Document Line No.", "Line No.");
        if PostedReqPurchLinesLocal.FindLast() then begin
            PostedReqPurchLinesLocal.Init();
            PostedReqPurchLinesLocal."Posted Indent Document No." := PostedReqPurchLinesLocal."Posted Indent Document No.";
            PostedReqPurchLinesLocal."Posted Indent Line No." := PostedReqPurchLinesLocal."Posted Indent Line No.";
            PostedReqPurchLinesLocal."Line No." := Lineno;
            PostedReqPurchLinesLocal."Purch. Document Type" := "Document Type";
            PostedReqPurchLinesLocal."Purch. Document No." := "Document No.";
            PostedReqPurchLinesLocal."Purch. Document Line No." := "Line No.";
            PostedReqPurchLinesLocal."Requisition Qty" := "Accepted Qty.";
            PostedReqPurchLinesLocal."Due Date" := PurchHeader."Due Date";
            PostedReqPurchLinesLocal."Responsibility Center" := "Responsibility Center";
            PostedReqPurchLinesLocal.Insert();
        end;
        //SSD-0002
    end;
    //SSDU
    procedure CheckTypeofInvoice()
    var
        PurchaseHeader: Record "Purchase Header";
        PIInv: Label 'You can select only Item and Fixed Asset on type field in Purchase line.';
        PDIError: Label 'You can select only Charge (item) and G/L Account on type field in sales line.';
    begin
        PurchaseHeader.get("Document Type", "Document No.");
        if (PurchaseHeader."Type of Invoice" = PurchaseHeader."Type of Invoice"::PI) then begin
            if Type in [Type::"Charge (Item)", Type::"G/L Account", Type::Resource] then Error(PIInv);
        end
        else if (PurchaseHeader."Type of Invoice" = PurchaseHeader."Type of Invoice"::PDI) then begin
            if Type in [Type::"Fixed Asset", Type::Item, Type::Resource] then Error(PDIError);
        end;
    end;
    //SSDU
    procedure POLandedPrice(ItemNo: Code[20]; VariantCode: Code[20]) LandedCost: Decimal;
    var
        ItemLedgerEntry: Record "Item Ledger Entry";
    begin
        ItemLedgerEntry.SetRange("Item No.", ItemNo);
        if VariantCode <> '' then ItemLedgerEntry.SetRange("Variant Code", VariantCode);
        ItemLedgerEntry.SetAscending("Entry No.", false);
        ItemLedgerEntry.SetRange("Entry Type", ItemLedgerEntry."Entry Type"::Purchase);
        if ItemLedgerEntry.FindFirst() then begin
            ItemLedgerEntry.CalcFields("Cost Amount (Actual)", "Cost Amount (Expected)");
            LandedCost := (ItemLedgerEntry."Cost Amount (Actual)" + ItemLedgerEntry."Cost Amount (Expected)") / ItemLedgerEntry.Quantity;
        end;
    end;

    procedure LastPOPrice(ItemNo: Code[20]; VariantCode: Code[20]) POPrice: Decimal;
    var
        ItemLedgerEntry: Record "Item Ledger Entry";
        PurchRcptLine: Record "Purch. Rcpt. Line";
    begin
        ItemLedgerEntry.SetRange("Item No.", ItemNo);
        if VariantCode <> '' then ItemLedgerEntry.SetRange("Variant Code", VariantCode);
        ItemLedgerEntry.SetAscending("Entry No.", false);
        ItemLedgerEntry.SetRange("Entry Type", ItemLedgerEntry."Entry Type"::Purchase);
        if ItemLedgerEntry.FindFirst() then begin
            PurchRcptLine.SetRange("Document No.", ItemLedgerEntry."Document No.");
            PurchRcptLine.SetRange("No.", ItemLedgerEntry."Item No.");
            if VariantCode <> '' then PurchRcptLine.SetRange("Variant Code", ItemLedgerEntry."Variant Code");
            if PurchRcptLine.FindFirst() then begin
                POPrice := PurchRcptLine."Direct Unit Cost";
            end;
        end;
    end;
}
