TableExtension 50066 "SSD Purchase Header" extends "Purchase Header"
{
    fields
    {
        modify("Buy-from Vendor No.")
        {
            trigger OnAfterValidate()
            var
                Vend: Record Vendor;
            begin
                if Vend.Get("Buy-from Vendor No.") then begin
                    IF Vend."GST Vendor Type" <> Vend."GST Vendor Type"::Import THEN Vend.TESTFIELD("State Code");
                    Validate("Responsibility Center");
                    if vend."Location Code" <> '' then
                        Validate("Location Code", Vend."Location Code")
                    else
                        Validate("Location Code");
                    if ("Document Type" = "Document Type"::Invoice) and (Vend."Calculate TDS/TCS") then Message(Text50002);
                    if "Document Type" = "Document Type"::Invoice then "Subcontracting Invoice" := Vend.Subcontractor;
                    "SSD Skip Mail" := Vend."SSD Skip Mail";
                    "SSD Exclude Mail" := Vend."SSD Exclude Mail";
                    "SSD Exclude SPO Confirmation" := Vend."SSD Exclude SPO Confirmation";
                end;
            end;
        }
        modify("Payment Terms Code")
        {
            trigger OnBeforeValidate()
            var
                Vendor: Record Vendor;
                PurchRcptHeaderLocal: Record "Purch. Rcpt. Header";
                PurchLineLocal: Record "Purchase Line";
                PostedGateHeaderLocal: Record "SSD Posted Gate Header";
                PaymentTerms: Record "Payment Terms";
                VendTabl: Record Vendor;
                UpdateDocumentDate: Boolean;
            begin
                if Vendor.Get("Buy-from Vendor No.") then if Vendor."Payment Terms Code" <> "Payment Terms Code" then if not confirm(Text50000, true, "Buy-from Vendor No.") then Error(Text50001);
                IF ("Payment Terms Code" <> '') AND ("Document Date" <> 0D) THEN BEGIN
                    PaymentTerms.GET("Payment Terms Code");
                    IF (("Document Type" IN ["Document Type"::"Return Order", "Document Type"::"Credit Memo"]) AND NOT PaymentTerms."Calc. Pmt. Disc. on Cr. Memos") THEN BEGIN
                        VALIDATE("Due Date", "Document Date");
                        VALIDATE("Pmt. Discount Date", 0D);
                        VALIDATE("Payment Discount %", 0);
                    END
                    ELSE BEGIN
                        //ALLE 2.10 >>
                        IF ("Document Type" = "Document Type"::Invoice) THEN BEGIN
                            IF VendTabl.GET("Buy-from Vendor No.") THEN BEGIN
                                //<<<<<<<<<ALLE[551]
                                PurchLineLocal.RESET;
                                PurchLineLocal.SETRANGE(PurchLineLocal."Document No.", "No.");
                                PurchLineLocal.SETRANGE(PurchLineLocal.Type, PurchLineLocal.Type::Item);
                                IF PurchLineLocal.FINDFIRST THEN BEGIN
                                    PostedGateHeaderLocal.RESET;
                                    IF PostedGateHeaderLocal.GET(PurchLineLocal."Gate Entry no.") THEN "Document Date" := PostedGateHeaderLocal."Bill Date";
                                END;
                                //>>>>>>>>>ALLE[551]
                                VendTabl.TESTFIELD("Vendor Due Basis");
                                CASE VendTabl."Vendor Due Basis" OF
                                    VendTabl."Vendor Due Basis"::"Document date":
                                        BEGIN
                                            //"Due Date" := CALCDATE(PaymentTerms."Due Date Calculation","Document Date");
                                            //<<<<ALLE[551]
                                            PurchLineLocal.RESET;
                                            PurchLineLocal.SETRANGE(PurchLineLocal."Document No.", "No.");
                                            PurchLineLocal.SETRANGE(PurchLineLocal.Type, PurchLineLocal.Type::Item);
                                            IF PurchLineLocal.FINDFIRST THEN BEGIN
                                                PurchRcptHeaderLocal.RESET;
                                                IF PurchRcptHeaderLocal.GET(PurchLineLocal."Receipt No.") THEN BEGIN
                                                    "Due Date" := CALCDATE(PaymentTerms."Due Date Calculation", PurchRcptHeaderLocal."Posting Date");
                                                    "Pmt. Discount Date" := CALCDATE(PaymentTerms."Discount Date Calculation", PurchRcptHeaderLocal."Posting Date");
                                                END
                                            END;
                                            IF "Invoice Type Old" = "Invoice Type Old"::"Expense Voucher" THEN IF "Posting Date" <> 0D THEN "Due Date" := CALCDATE(PaymentTerms."Due Date Calculation", "Posting Date");
                                            IF "Invoice Type Old" = "Invoice Type Old"::"Expense Voucher" THEN "Pmt. Discount Date" := CALCDATE(PaymentTerms."Discount Date Calculation", "Posting Date"); //ALLE[551]
                                                                                                                                                                                                           //>>>>ALLE[551]
                                        END;
                                    VendTabl."Vendor Due Basis"::"Vendor Invoice Date":
                                        BEGIN
                                            IF "Vendor Invoice Date" <> 0D THEN
                                                "Due Date" := CALCDATE(PaymentTerms."Due Date Calculation", "Vendor Invoice Date")
                                            ELSE
                                                "Due Date" := CALCDATE(PaymentTerms."Due Date Calculation", "Document Date");
                                            "Pmt. Discount Date" := CALCDATE(PaymentTerms."Discount Date Calculation", "Document Date"); //ALLE[551]
                                        END;
                                END;
                            END;
                        END
                        ELSE
                            //ALLE 2.10
                            "Due Date" := CALCDATE(PaymentTerms."Due Date Calculation", "Document Date");
                        //"Pmt. Discount Date" := CALCDATE(PaymentTerms."Discount Date Calculation","Document Date");
                        IF NOT UpdateDocumentDate THEN VALIDATE("Payment Discount %", PaymentTerms."Discount %")
                    END;
                END
                ELSE BEGIN
                    VALIDATE("Due Date", "Document Date");
                    IF NOT UpdateDocumentDate THEN BEGIN
                        VALIDATE("Pmt. Discount Date", 0D);
                        VALIDATE("Payment Discount %", 0);
                    END;
                END;
            end;
        }
        modify("Vendor Invoice No.")
        {
            trigger OnAfterValidate()
            begin
                "Vendor Shipment No." := "Vendor Invoice No.";
                //SSD "Vendor Shipment Date" := "Vendor Invoice Date";
            end;
        }
        modify("Posting Date")
        {
            trigger OnAfterValidate()
            begin
                if "Vendor Invoice Date" <> 0D then Validate("Vendor Invoice Date");
            end;
        }
        field(50000; Archived; Boolean)
        {
            Description = 'STD002-->Checkmark shows document is arcihved and ready for Reopen';
            DataClassification = CustomerContent;
            Caption = 'Archived';
        }
        field(50001; "Document Subtype"; Option)
        {
            Description = 'CF002';
            OptionCaption = ' ,Order,Contract,Service Contract,Schedule';
            OptionMembers = " ","Order",Contract,"Service Contract",Schedule;
            DataClassification = CustomerContent;
            Caption = 'Document Subtype';
        }
        field(50002; "Last Schedule Order No"; Code[20])
        {
            Description = 'CF002 for Last Sch. Order No Generated from the same Rate Contract No.';
            Editable = false;
            DataClassification = CustomerContent;
            Caption = 'Last Schedule Order No';
        }
        field(50003; "Amendment Required"; Boolean)
        {
            Description = 'CF002';
            Enabled = false;
            DataClassification = CustomerContent;
            Caption = 'Amendment Required';
        }
        field(50004; "Enquiry No."; Code[20])
        {
            Description = 'CF002';
            Enabled = false;
            DataClassification = CustomerContent;
            Caption = 'Enquiry No.';
        }
        field(50005; "Schedule No."; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Schedule No.';
        }
        field(50006; "Last Schedule No."; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Last Schedule No.';
        }
        field(50007; "Hold Payment"; Boolean)
        {
            Description = 'HP1.0';
            Editable = false;
            DataClassification = CustomerContent;
            Caption = 'Hold Payment';
        }
        field(50008; "PO Mail Send"; Boolean)
        {
            Description = 'Alle SANK';
            DataClassification = CustomerContent;
            Editable = false;
            Caption = 'PO Mail Send';
        }
        field(50030; "Vechile Type"; Option)
        {
            Description = 'CF001';
            OptionCaption = 'Lorry,Container,Van';
            OptionMembers = Lorry,Container,Van;
            DataClassification = CustomerContent;
            Caption = 'Vechile Type';
        }
        field(50031; "Mode of Transport"; Code[20])
        {
            Description = 'CF001';
            DataClassification = CustomerContent;
            Caption = 'Mode of Transport';
        }
        field(50032; "Transporter Name"; Text[30])
        {
            Description = 'CF001';
            DataClassification = CustomerContent;
            Caption = 'Transporter Name';
        }
        field(50033; "Transporter Bill No."; Code[20])
        {
            Description = 'CF001';
            DataClassification = CustomerContent;
            Caption = 'Transporter Bill No.';
        }
        field(50034; "Transporter Bill Date"; Date)
        {
            Description = 'CF001';
            DataClassification = CustomerContent;
            Caption = 'Transporter Bill Date';
        }
        field(50037; "Bill Entry No."; Code[30])
        {
            Description = 'CF001';
            DataClassification = CustomerContent;
            Caption = 'Bill Entry No.';
        }
        field(50038; "Bill Entry Date"; Date)
        {
            Description = 'CF001';
            DataClassification = CustomerContent;
            Caption = 'Bill Entry Date';
        }
        field(50066; "PO Type"; Option)
        {
            Description = 'CF001,CEN003';
            Enabled = false;
            OptionCaption = ' ,Job Work/Service,Capex,Consumables,Raw Material,Tooling,BOP,Spares,General,Trading';
            OptionMembers = " ","Job Work/Service",Capex,Consumables,"Raw Material",Tooling,BOP,Spares,General,Trading;
            DataClassification = CustomerContent;
            Caption = 'PO Type';

            trigger OnValidate()
            begin
                TestField(Status, Status::Open);
            end;
        }
        field(50067; "PO Category"; Option)
        {
            Description = 'CF001';
            Enabled = false;
            OptionCaption = 'JobWork/Service,Capex,Consumables';
            OptionMembers = "JobWork/Service",Capex,Consumables;
            DataClassification = CustomerContent;
            Caption = 'PO Category';
        }
        field(50088; Freight; Option)
        {
            Description = 'CF001,SSD';
            Enabled = false;
            OptionCaption = ' ,Free on Rail,Free on Board,Ex Works,C & F,C I F,Inclusive in Price,Exclusive at Actuals,Refer to Annexure,NIL,Extra as Actual,To Pay';
            OptionMembers = " ","Free on Rail","Free on Board","Ex Works","C & F","C I F","Inclusive in Price","Exclusive at Actuals","Refer to Annexure",NIL,"Extra as Actual","To Pay";
            DataClassification = CustomerContent;
            Caption = 'Freight';

            trigger OnValidate()
            begin
                TestField(Status, Status::Open);
            end;
        }
        field(50090; "Charge Item 1"; Option)
        {
            Caption = '''''';
            Description = 'ALLE-AT';
            OptionCaption = ' ,Shipping Line,Freight Forwarder,CHA,Local Logistic,Others,Transportation Charges';
            OptionMembers = " ","Shipping Line","Freight Forwarder",CHA,"Local Logistic",Others,"Transportation Charges";
            DataClassification = CustomerContent;
        }
        field(50091; "Charge Item 2"; Option)
        {
            Description = 'ALLE-AT';
            OptionCaption = ' ,Shipping Line,Freight Forwarder,CHA,Local Logistic,Others,Transportation Charges';
            OptionMembers = " ","Shipping Line","Freight Forwarder",CHA,"Local Logistic",Others,"Transportation Charges";
            DataClassification = CustomerContent;
            Caption = 'Charge Item 2';
        }
        field(50092; "Charge Item 3"; Option)
        {
            Description = 'ALLE-AT';
            OptionCaption = ' ,Shipping Line,Freight Forwarder,CHA,Local Logistic,Others,Transportation Charges';
            OptionMembers = " ","Shipping Line","Freight Forwarder",CHA,"Local Logistic",Others,"Transportation Charges";
            DataClassification = CustomerContent;
            Caption = 'Charge Item 3';
        }
        field(50093; "Charge Item 4"; Option)
        {
            Description = 'ALLE-AT';
            OptionCaption = ' ,Shipping Line,Freight Forwarder,CHA,Local Logistic,Others,Transportation Charges';
            OptionMembers = " ","Shipping Line","Freight Forwarder",CHA,"Local Logistic",Others,"Transportation Charges";
            DataClassification = CustomerContent;
            Caption = 'Charge Item 4';
        }
        field(50094; "Charge Item 5"; Option)
        {
            Description = 'ALLE-AT';
            OptionCaption = ' ,Shipping Line,Freight Forwarder,CHA,Local Logistic,Others,Transportation Charges';
            OptionMembers = " ","Shipping Line","Freight Forwarder",CHA,"Local Logistic",Others,"Transportation Charges";
            DataClassification = CustomerContent;
            Caption = 'Charge Item 5';
        }
        field(50095; "Charge Item 6"; Option)
        {
            Description = 'ALLE-AT';
            OptionCaption = ' ,Shipping Line,Freight Forwarder,CHA,Local Logistic,Others,Transportation Charges';
            OptionMembers = " ","Shipping Line","Freight Forwarder",CHA,"Local Logistic",Others,"Transportation Charges";
            DataClassification = CustomerContent;
            Caption = 'Charge Item 6';
        }
        field(50096; "Approval Required 1"; Boolean)
        {
            Description = 'ALLE-AT';
            DataClassification = CustomerContent;
            Caption = 'Approval Required 1';
        }
        field(50097; "Approval Required 2"; Boolean)
        {
            Description = 'ALLE-AT';
            DataClassification = CustomerContent;
            Caption = 'Approval Required 2';
        }
        field(50098; "Approval Required 3"; Boolean)
        {
            Description = 'ALLE-AT';
            DataClassification = CustomerContent;
            Caption = 'Approval Required 3';
        }
        field(50099; "Approval Required 4"; Boolean)
        {
            Description = 'ALLE-AT';
            DataClassification = CustomerContent;
            Caption = 'Approval Required 4';
        }
        field(50350; "SSD TC Code"; Code[20])
        {
            Caption = 'TC Code';
            DataClassification = CustomerContent;
            TableRelation = "SSD Terms";

            trigger OnValidate()
            begin
                TestStatusOpen();
                if "SSD TC Code" = '' then
                    if CheckTCLineExists(Rec, false) then
                        if not confirm(TCLineDeleteQst) then
                            Error('')
                        else
                            DeleteTCLines(Rec);
                if "SSD TC Code" <> '' then
                    if CheckTCLineExists(Rec, false) then begin
                        if not confirm(TCLineDeleteQst) then
                            Error('')
                        else begin
                            DeleteTCLines(Rec);
                            InsertTCLines(Rec);
                        end;
                    end
                    else
                        InsertTCLines(Rec);
            end;
        }
        field(50351; "SSD Order Type"; Enum "SSD Purchase Order Type")
        {
            Caption = 'Order Type';

            trigger OnValidate()
            begin
                TestField(Status, Status::Open);
                if "SSD Order Type" = "SSD Order Type"::Inventory then begin
                    "Valid From" := 0D;
                    "Valid To" := 0D;
                end;
                if "SSD Order Type" = "SSD Order Type"::Service then
                    UpdateGracePeriod()
                else
                    Clear("SSD Service Grace Period");
            end;
        }
        field(50352; "SSD Deduction Amount"; Decimal)
        {
            Caption = 'Deduction Amount';
            DecimalPlaces = 2 : 2;
            DataClassification = CustomerContent;
        }
        field(50353; "SSD SPO Subject"; Text[300])
        {
            Caption = 'SPO Subject';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                TestField(Status, Status::Open);
            end;
        }
        field(50398; "SSD Exclude Mail"; Boolean)
        {
            Caption = 'Exclude from Mail Alert';
            DataClassification = CustomerContent;
        }
        field(50399; "Confirmation Pending"; Boolean)
        {
            Caption = 'Confirmation Pending';
            DataClassification = CustomerContent;
            Editable = true;
        }
        field(50400; "Confirmation Received"; Boolean)
        {
            Caption = 'Confimation Received';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(50401; "SSD Exclude SPO Confirmation"; Boolean)
        {
            Caption = 'Exclude SPO Confirmation';
            DataClassification = CustomerContent;
        }
        field(50402; "SSD SRN User"; Code[50])
        {
            Caption = 'SRN User';
            DataClassification = CustomerContent;
            TableRelation = "User Setup";
            Editable = false;
        }
        field(52001; "Effective Date"; Date)
        {
            Description = 'CF001';
            DataClassification = CustomerContent;
            Caption = 'Effective Date';
        }
        field(52002; "Expiry Date"; Date)
        {
            Description = 'CF001';
            DataClassification = CustomerContent;
            Caption = 'Expiry Date';
        }
        field(52003; "Next Review Date"; Date)
        {
            Description = 'CF001';
            Enabled = false;
            DataClassification = CustomerContent;
            Caption = 'Next Review Date';
        }
        field(52008; "Contract Information"; Text[20])
        {
            Description = 'CF001';
            Enabled = false;
            DataClassification = CustomerContent;
            Caption = 'Contract Information';
        }
        field(52013; "Gate Entry No."; Code[20])
        {
            Description = 'CF001';
            TableRelation = "SSD Posted Gate Header"."No." where("Ref. Document Type" = const("Purchase Order"), "Party No." = field("Buy-from Vendor No."), "MRN Created" = filter(false));
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
            DataClassification = CustomerContent;
            Caption = 'Gate Entry No.';

            trigger OnValidate()
            var
                PostedGateHeader: Record "SSD Posted Gate Header";
            begin
                if PostedGateHeader.Get("Gate Entry No.") then begin
                    "Gate Entry Date" := PostedGateHeader."Posting Date";
                    "Vendor Shipment No." := PostedGateHeader."Bill No.";
                    "Vechile Type" := PostedGateHeader."Vechile Type";
                    "Mode of Transport" := PostedGateHeader."Mode of Transport";
                    "Transporter Name" := PostedGateHeader."Transporter Name";
                    "Transporter Bill No." := PostedGateHeader."Transporter Bill No.";
                    "Transporter Bill Date" := PostedGateHeader."Transporter Bill Date";
                    "Vendor Challan Date" := PostedGateHeader."Delivery Challan Date";
                    "Delivery Challan No." := PostedGateHeader."Delivery Challan No.";
                    "Bill Entry No." := PostedGateHeader."Bill Entry No.";
                    "Bill Entry Date" := PostedGateHeader."Bill Entry Date";
                    UpdatePurchLines(FieldCaption("Gate Entry No."), CurrFieldNo <> 0);
                end;
            end;
        }
        field(52014; "Gate Entry Date"; Date)
        {
            Description = 'CF001';
            DataClassification = CustomerContent;
            Caption = 'Gate Entry Date';
        }
        field(52015; "MRR Remark"; Text[50])
        {
            Description = 'CF001';
            Enabled = false;
            DataClassification = CustomerContent;
            Caption = 'MRR Remark';
        }
        field(52016; "Vendor Challan Date"; Date)
        {
            Description = 'CF001';
            DataClassification = CustomerContent;
            Caption = 'Vendor Challan Date';
        }
        field(52017; "Vendor Invoice Date"; Date)
        {
            Description = 'CF001';
            DataClassification = CustomerContent;
            Caption = 'Vendor Invoice Date';

            trigger OnValidate()
            begin
                if "Vendor Invoice Date" > Today then Error('Vendor Invoice date cannot be greater than today');
                if "Vendor Invoice Date" > "Posting Date" then Error('Vendor Invoice date cannot be greater than Posting Date');
            end;
        }
        field(52018; "Delivery Challan No."; Code[20])
        {
            Description = 'CF001';
            DataClassification = CustomerContent;
            Caption = 'Delivery Challan No.';
        }
        field(52040; "Free Supply"; Boolean)
        {
            Description = 'CF001';
            DataClassification = CustomerContent;
            Caption = 'Free Supply';
        }
        field(52050; "Subcontracting Order Line No"; Integer)
        {
            Description = 'CF001-->Subcontracting Error --> Internal Purpose Only-Corrected By Navision India';
            DataClassification = CustomerContent;
            Caption = 'Subcontracting Order Line No';
        }
        field(52061; "Date Of Issue"; Date)
        {
            Description = 'CF001';
            DataClassification = CustomerContent;
            Caption = 'Date Of Issue';
        }
        field(52062; "Time Of Issue"; Time)
        {
            Description = 'CF001-->Subcontracting Error --> Internal Purpose Only-Corrected By Navision India';
            DataClassification = CustomerContent;
            Caption = 'Time Of Issue';
        }
        field(52063; "Date Of Removal"; Date)
        {
            Description = 'CF001';
            DataClassification = CustomerContent;
            Caption = 'Date Of Removal';
        }
        field(52064; "Time Of Removals"; Time)
        {
            Description = 'CF001';
            DataClassification = CustomerContent;
            Caption = 'Time Of Removals';
        }
        field(52065; "Excise Invoice No."; Code[10])
        {
            Description = 'CF001';
            DataClassification = CustomerContent;
            Caption = 'Excise Invoice No.';
        }
        field(52066; "Excise Invoice Date"; Date)
        {
            Description = 'CF001';
            DataClassification = CustomerContent;
            Caption = 'Excise Invoice Date';
        }
        field(52067; "ST Form"; Code[20])
        {
            Description = 'CF001';
            DataClassification = CustomerContent;
            Caption = 'ST Form';
        }
        field(52068; "Plant MRN No."; Code[20])
        {
            Description = 'CF001';
            DataClassification = CustomerContent;
            Caption = 'Plant MRN No.';
        }
        field(52069; "Special Instruction"; Text[80])
        {
            Description = 'CF001';
            Enabled = false;
            DataClassification = CustomerContent;
            Caption = 'Special Instruction';
        }
        field(52080; "Plant Order No."; Code[20])
        {
            Description = 'CF001';
            Enabled = false;
            DataClassification = CustomerContent;
            Caption = 'Plant Order No.';
        }
        field(52090; "Vendor Quotation No."; Code[20])
        {
            Description = 'CF001';
            DataClassification = CustomerContent;
            Caption = 'Vendor Quotation No.';
        }
        field(52091; "Vendor Quotation Date"; Date)
        {
            Description = 'CF001';
            DataClassification = CustomerContent;
            Caption = 'Vendor Quotation Date';
        }
        field(52095; "Modified By"; Code[20])
        {
            Description = 'CF001';
            DataClassification = CustomerContent;
            Caption = 'Modified By';
        }
        field(52100; Attachment; Blob)
        {
            Description = 'CF001';
            Enabled = false;
            DataClassification = CustomerContent;
            Caption = 'Attachment';
        }
        field(52101; "Attachment No."; Integer)
        {
            Description = 'CF001';
            Enabled = false;
            DataClassification = CustomerContent;
            Caption = 'Attachment No.';
        }
        field(52102; "Read Only"; Boolean)
        {
            Description = 'CF001';
            DataClassification = CustomerContent;
            Caption = 'Read Only';
        }
        field(52103; "Blanket Order No."; Code[20])
        {
            Description = 'CF001';
            DataClassification = CustomerContent;
            Caption = 'Blanket Order No.';
        }
        field(52104; "Blanket Order Date"; Date)
        {
            Description = 'CF001';
            DataClassification = CustomerContent;
            Caption = 'Blanket Order Date';
        }
        field(53044; "Auto Approval"; Boolean)
        {
            Description = 'Alle_190417';
            DataClassification = CustomerContent;
            Caption = 'Auto Approval';
        }
        field(53055; "Excise Invoice No. Series"; Code[20])
        {
            Description = 'CF001';
            TableRelation = "No. Series";
            DataClassification = CustomerContent;
            Caption = 'Excise Invoice No. Series';

            trigger OnValidate()
            begin
                "Excise Invoice Date" := WorkDate();
            end;
        }
        field(53056; "Tax Registration No."; Text[20])
        {
            Description = 'CF001';
            DataClassification = CustomerContent;
            Caption = 'Tax Registration No.';
        }
        field(53057; Remarks; Text[30])
        {
            Description = 'CF001';
            DataClassification = CustomerContent;
            Caption = 'Remarks';

            trigger OnValidate()
            begin
                TestField(Status, Status::Open);
            end;
        }
        field(53058; Insurance; Option)
        {
            Description = 'CGN 005 added "Not Applicable" on 180407';
            OptionCaption = ' ,Insurance By Seller,Insurance By Buyer,Not Applicable';
            OptionMembers = " ","Insurance By Seller","Insurance By Buyer","Not Applicable";
            DataClassification = CustomerContent;
            Caption = 'Insurance';

            trigger OnValidate()
            begin
                TestField(Status, Status::Open);
            end;
        }
        field(53059; "P&F Charges"; Option)
        {
            Enabled = false;
            OptionCaption = ' ,Inclusive in Price,Not Inclusive in Price,Refer to Annexure,NIL';
            OptionMembers = " ","Inclusive in Price","Not Inclusive in Price","Refer to Annexure",NIL;
            DataClassification = CustomerContent;
            Caption = 'P&F Charges';

            trigger OnValidate()
            begin
                TestField(Status, Status::Open);
            end;
        }
        field(53060; Excise; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Excise';
        }
        field(53061; "Version No. before reopen"; Integer)
        {
            Description = 'Field added to force Archive before reopen..code added in release code unit for the same';
            DataClassification = CustomerContent;
            Caption = 'Version No. before reopen';
        }
        field(53062; "Excise Gate Pass"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Excise Gate Pass';
        }
        field(53063; "Price Basis"; Option)
        {
            Enabled = false;
            OptionCaption = ' ,Free on Rail,Free on Board,CIF,C&F,Ex your works,Ex our works, Door Delivery, CIF Chennai Sea port';
            OptionMembers = " ","Free on Rail","Free on Board",CIF,"C&F","Ex your works","Ex our works"," Door Delivery"," CIF Chennai Sea port";
            DataClassification = CustomerContent;
            Caption = 'Price Basis';
        }
        field(53064; "Date Sent"; Date)
        {
            Description = 'ALLE RaK 1.0';
            DataClassification = CustomerContent;
            Caption = 'Date Sent';
        }
        field(53500; "SSD Service Grace Period"; DateFormula)
        {
            Caption = 'Service Grace Period';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                UserSetup.Get(UserId);
                if not UserSetup."SSD PO Grace Period" then Error('You are not authourized to update Grace Period');
            end;
        }
        field(53501; "SSD Skip Mail"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Skip PO Mail';
        }
        field(54040; "Order Created from MRP"; Boolean)
        {
            Description = 'ALLE';
            DataClassification = CustomerContent;
            Caption = 'Order Created from MRP';
        }
        field(54041; "Order Created from Indent"; Boolean)
        {
            Description = 'ALLE';
            Editable = false;
            DataClassification = CustomerContent;
            Caption = 'Order Created from Indent';
        }
        field(54042; "Created By User Id"; Code[20])
        {
            Description = 'Alle';
            TableRelation = "User Setup"."User ID";
            DataClassification = CustomerContent;
            Caption = 'Created By User Id';
        }
        field(54043; "Created  Date"; DateTime)
        {
            Description = 'Alle';
            DataClassification = CustomerContent;
            Caption = 'Created  Date';
        }
        field(60043; Supplementary; Boolean)
        {
            Description = 'Supplementary';
            Enabled = false;
            DataClassification = CustomerContent;
            Caption = 'Supplementary';
        }
        field(60044; "Supplementary Rate"; Decimal)
        {
            Description = 'Supplementary';
            Enabled = false;
            DataClassification = CustomerContent;
            Caption = 'Supplementary Rate';
        }
        field(60045; "Supplementary Item"; Code[20])
        {
            Description = 'Supplementary';
            Enabled = false;
            TableRelation = Item;
            DataClassification = CustomerContent;
            Caption = 'Supplementary Item';
        }
        field(60046; "Supplementary Start Date"; Date)
        {
            Description = 'Supplementary';
            Enabled = false;
            DataClassification = CustomerContent;
            Caption = 'Supplementary Start Date';
        }
        field(60047; "Supplementary End Date"; Date)
        {
            Description = 'Supplementary';
            Enabled = false;
            DataClassification = CustomerContent;
            Caption = 'Supplementary End Date';
        }
        field(60048; "Supplementary PO Item"; Code[20])
        {
            Description = 'Supplementary';
            Enabled = false;
            DataClassification = CustomerContent;
            Caption = 'Supplementary PO Item';
        }
        field(60049; "Subcontracting Invoice"; Boolean)
        {
            Description = 'ALLEAA CML-033 220408';
            DataClassification = CustomerContent;
            Caption = 'Subcontracting Invoice';
        }
        field(60200; "Invoice Amount"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Invoice Amount';
        }
        field(65000; "Invoice Value(Import)"; Decimal)
        {
            Description = 'Alle VPB Import 280610';
            DataClassification = CustomerContent;
            Caption = 'Invoice Value(Import)';
        }
        field(65001; "Freight Value(Import)"; Decimal)
        {
            DecimalPlaces = 0 : 5;
            Description = 'Alle VPB Import 280610';
            DataClassification = CustomerContent;
            Caption = 'Freight Value(Import)';

            trigger OnValidate()
            begin
                if ("Invoice Value(Import)" > 0) and ("Freight Value(Import)" > 0) then if ("Invoice Value(Import)" * 20 / 100) < ("Freight Value(Import)") then Error('Frieght value(import) must be less then 20 Percent of the Invoice Value(Import)');
            end;
        }
        field(65002; "Insurance Value(Import)"; Decimal)
        {
            DecimalPlaces = 0 : 5;
            Description = 'Alle VPB Import 280610';
            DataClassification = CustomerContent;
            Caption = 'Insurance Value(Import)';
        }
        field(65003; "Misc Charges(Import)"; Decimal)
        {
            DecimalPlaces = 0 : 5;
            Description = 'Alle VPB Import 280610';
            DataClassification = CustomerContent;
            Caption = 'Misc Charges(Import)';
        }
        field(65004; "Landing Charges(Import)"; Decimal)
        {
            DecimalPlaces = 0 : 5;
            Description = 'Alle VPB Import 280610';
            DataClassification = CustomerContent;
            Caption = 'Landing Charges(Import)';
        }
        field(65005; "Insurance Value(Import) Type"; Option)
        {
            Description = 'Alle VPB Import 280610';
            OptionMembers = Percentage,Amount;
            DataClassification = CustomerContent;
            Caption = 'Insurance Value(Import) Type';
        }
        field(75000; "Invoice Type Old"; Option)
        {
            Description = 'ALLE 2.21';
            OptionCaption = ' ,Purchase Voucher,Expense Voucher';
            OptionMembers = " ","Purchase Voucher","Expense Voucher";
            DataClassification = CustomerContent;
            Caption = 'Invoice Type Old';

            trigger OnValidate()
            begin
                if "Document Type" = "Document Type"::Invoice then begin
                    if "Invoice Type Old" = "Invoice Type Old"::"Purchase Voucher" then
                        "Posting No. Series" := 'F-PPI+'
                    else if "Invoice Type Old" = "Invoice Type Old"::"Expense Voucher" then "Posting No. Series" := 'F-PDPI';
                end;
            end;
        }
        field(75555; "Advance Payment Amount"; Decimal)
        {
            CalcFormula = sum("Detailed Vendor Ledg. Entry".Amount where("Vendor No." = field("Buy-from Vendor No."), "PO No." = field("No.")));
            Description = 'ALLE 2.16';
            Editable = false;
            FieldClass = FlowField;
            Caption = 'Advance Payment Amount';
        }
        field(75556; "Deduction Reason"; Text[200])
        {
            DataClassification = CustomerContent;
            Caption = 'Deduction Reason';
        }
        field(75557; "Original Invoice Amount"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Original Invoice Amount';
        }
        field(75558; "Local GSTIN No."; Code[20])
        {
            Description = 'Alle 1.0 290818';
            DataClassification = CustomerContent;
            Caption = 'Local GSTIN No.';
        }
        field(75559; "Finance Received"; Boolean)
        {
            Description = 'ALLE-NM';
            DataClassification = CustomerContent;
            Caption = 'Finance Received';
        }
        field(75560; "Finance Received Date Time"; DateTime)
        {
            Description = 'ALLE-NM';
            DataClassification = CustomerContent;
            Caption = 'Finance Received Date Time';
        }
        field(75561; "Outstanding Amount LCY"; Decimal)
        {
            CalcFormula = sum("Purchase Line"."Outstanding Amount (LCY)" where("Document Type" = field("Document Type"), "Document No." = field("No.")));
            FieldClass = FlowField;
            Caption = 'Outstanding Amount LCY';
        }
        field(80001; "Actual Posted Date"; DateTime)
        {
            Description = 'ALLE-HG-16.09.20';
            DataClassification = CustomerContent;
            Caption = 'Actual Posted Date';
        }
        field(80002; "Doc. send by Store"; Boolean)
        {
            Description = 'ALLE-MK08-09020';
            DataClassification = CustomerContent;
            Caption = 'Doc. send by Store';

            trigger OnValidate()
            begin
                UserSetup.Reset();
                if UserSetup.Get(UserId) then begin
                    if UserSetup."Receipt sendbyStore Permis" = true then
                        Validate("Doc. send by Store DateTime", CurrentDatetime)
                    else
                        Error('You do not have the required Permission')
                end;
                if "Doc. recd by Fin DateTime" <> 0DT then if "Doc. send by Store" = false then Error('Since Document has been received by Finanace-Modify not allowed');
            end;
        }
        field(80003; "Doc. send by Store DateTime"; DateTime)
        {
            Description = 'ALLE-MK08-09020';
            Editable = true;
            DataClassification = CustomerContent;
            Caption = 'Doc. send by Store DateTime';
        }
        field(80004; "Doc. recvd  by Fin"; Boolean)
        {
            Description = 'ALLE-MK08-09020';
            DataClassification = CustomerContent;
            Caption = 'Doc. recvd  by Fin';

            trigger OnValidate()
            begin
                UserSetup.Reset();
                if UserSetup.Get(UserId) then begin
                    if UserSetup."Receipt receivedby Fin Permis" = true then begin
                        //if "Doc. send by Store" = true then
                        Validate("Doc. recd by Fin DateTime", CurrentDatetime)//else
                                                                              //  Error('Document send by Store is still pending')
                    end
                    else
                        Error('You do not have the required Permission');
                end;
                if "Doc. recd by Fin DateTime" <> 0DT then if "Doc. recvd  by Fin" = false then if UserSetup."Receipt receivedby Fin Admin" <> true then Error('Since it has been received by Finanace-Modify not allowed, Kindly Contact Admin');
            end;
        }
        field(80005; "Doc. recd by Fin DateTime"; DateTime)
        {
            Description = 'ALLE-MK08-09020';
            Editable = true;
            DataClassification = CustomerContent;
            Caption = 'Doc. recd by Fin DateTime';
        }
        field(80006; "Approval Required 5"; Boolean)
        {
            Description = 'ALLE-AT';
            DataClassification = CustomerContent;
            Caption = 'Approval Required 5';
        }
        field(80007; "Approval Required 6"; Boolean)
        {
            Description = 'ALLE-AT';
            DataClassification = CustomerContent;
            Caption = 'Approval Required 6';
        }
        field(80008; "No. Series 1"; Code[20])
        {
            Description = 'ALLE-AT';
            TableRelation = "Purchase Header"."No.";
            DataClassification = CustomerContent;
            Caption = 'No. Series 1';
        }
        field(80009; "No. Series 2"; Code[20])
        {
            Description = 'ALLE-AT';
            TableRelation = "Purchase Header"."No.";
            DataClassification = CustomerContent;
            Caption = 'No. Series 2';
        }
        field(80010; "No. Series 3"; Code[20])
        {
            Description = 'ALLE-AT';
            TableRelation = "Purchase Header"."No.";
            DataClassification = CustomerContent;
            Caption = 'No. Series 3';
        }
        field(80011; "No. Series 4"; Code[20])
        {
            Description = 'ALLE-AT';
            TableRelation = "Purchase Header"."No.";
            DataClassification = CustomerContent;
            Caption = 'No. Series 4';
        }
        field(80012; "No. Series 5"; Code[20])
        {
            Description = 'ALLE-AT';
            TableRelation = "Purchase Header"."No.";
            DataClassification = CustomerContent;
            Caption = 'No. Series 5';
        }
        field(80013; "No. Series 6"; Code[20])
        {
            Description = 'ALLE-AT';
            TableRelation = "Purchase Header"."No.";
            DataClassification = CustomerContent;
            Caption = 'No. Series 6';
        }
        field(80014; "Rem. Order Amount1"; Decimal)
        {
            Description = 'ALLE-AT';
            DataClassification = CustomerContent;
            Caption = 'Rem. Order Amount1';
        }
        field(80015; "Rem. Order Amount2"; Decimal)
        {
            Description = 'ALLE-AT';
            DataClassification = CustomerContent;
            Caption = 'Rem. Order Amount2';
        }
        field(80016; "Rem. Order Amount3"; Decimal)
        {
            Description = 'ALLE-AT';
            DataClassification = CustomerContent;
            Caption = 'Rem. Order Amount3';
        }
        field(80017; "Rem. Order Amount4"; Decimal)
        {
            Description = 'ALLE-AT';
            DataClassification = CustomerContent;
            Caption = 'Rem. Order Amount4';
        }
        field(80018; "Rem. Order Amount5"; Decimal)
        {
            Description = 'ALLE-AT';
            DataClassification = CustomerContent;
            Caption = 'Rem. Order Amount5';
        }
        field(80019; "Rem. Order Amount6"; Decimal)
        {
            Description = 'ALLE-AT';
            DataClassification = CustomerContent;
            Caption = 'Rem. Order Amount6';
        }
        field(80020; "Invoice Posted1"; Boolean)
        {
            Description = 'ALLE-AT';
            DataClassification = CustomerContent;
            Caption = 'Invoice Posted1';

            trigger OnValidate()
            begin
                CheckRecItemChargeModification() //ALLE-AT
            end;
        }
        field(80021; "Invoice Posted2"; Boolean)
        {
            Description = 'ALLE-AT';
            DataClassification = CustomerContent;
            Caption = 'Invoice Posted2';

            trigger OnValidate()
            begin
                CheckRecItemChargeModification() //ALLE-AT
            end;
        }
        field(80022; "Invoice Posted3"; Boolean)
        {
            Description = 'ALLE-AT';
            DataClassification = CustomerContent;
            Caption = 'Invoice Posted3';

            trigger OnValidate()
            begin
                CheckRecItemChargeModification() //ALLE-AT
            end;
        }
        field(80023; "Invoice Posted4"; Boolean)
        {
            Description = 'ALLE-AT';
            DataClassification = CustomerContent;
            Caption = 'Invoice Posted4';

            trigger OnValidate()
            begin
                CheckRecItemChargeModification() //ALLE-AT
            end;
        }
        field(80024; "Invoice Posted5"; Boolean)
        {
            Description = 'ALLE-AT';
            DataClassification = CustomerContent;
            Caption = 'Invoice Posted5';

            trigger OnValidate()
            begin
                CheckRecItemChargeModification() //ALLE-AT
            end;
        }
        field(80025; "Invoice Posted6"; Boolean)
        {
            Description = 'ALLE-AT';
            DataClassification = CustomerContent;
            Caption = 'Invoice Posted6';

            trigger OnValidate()
            begin
                CheckRecItemChargeModification() //ALLE-AT
            end;
        }
        field(80026; "Send By Purch1"; Boolean)
        {
            Description = 'ALLE-AT';
            DataClassification = CustomerContent;
            Caption = 'Send By Purch1';

            trigger OnValidate()
            begin
                CheckItemChargeModification() //ALLE-AT
            end;
        }
        field(80027; "Send By Purch2"; Boolean)
        {
            Description = 'ALLE-AT';
            DataClassification = CustomerContent;
            Caption = 'Send By Purch2';

            trigger OnValidate()
            begin
                CheckItemChargeModification() //ALLE-AT
            end;
        }
        field(80028; "Send By Purch3"; Boolean)
        {
            Description = 'ALLE-AT';
            DataClassification = CustomerContent;
            Caption = 'Send By Purch3';

            trigger OnValidate()
            begin
                CheckItemChargeModification() //ALLE-AT
            end;
        }
        field(80029; "Send By Purch4"; Boolean)
        {
            Description = 'ALLE-AT';
            DataClassification = CustomerContent;
            Caption = 'Send By Purch4';

            trigger OnValidate()
            begin
                CheckItemChargeModification() //ALLE-AT
            end;
        }
        field(80030; "Send By Purch5"; Boolean)
        {
            Description = 'ALLE-AT';
            DataClassification = CustomerContent;
            Caption = 'Send By Purch5';

            trigger OnValidate()
            begin
                CheckItemChargeModification() //ALLE-AT
            end;
        }
        field(80031; "Send By Purch6"; Boolean)
        {
            Description = 'ALLE-AT';
            DataClassification = CustomerContent;
            Caption = 'Send By Purch6';

            trigger OnValidate()
            begin
                CheckItemChargeModification() //ALLE-AT
            end;
        }
        field(80032; "Rec. By Fin1"; Boolean)
        {
            Description = 'ALLE-AT';
            DataClassification = CustomerContent;
            Caption = 'Rec. By Fin1';

            trigger OnValidate()
            begin
                CheckRecItemChargeModification() //ALLE-AT
            end;
        }
        field(80033; "Rec. By Fin2"; Boolean)
        {
            Description = 'ALLE-AT';
            DataClassification = CustomerContent;
            Caption = 'Rec. By Fin2';

            trigger OnValidate()
            begin
                CheckRecItemChargeModification() //ALLE-AT
            end;
        }
        field(80034; "Rec. By Fin3"; Boolean)
        {
            Description = 'ALLE-AT';
            DataClassification = CustomerContent;
            Caption = 'Rec. By Fin3';

            trigger OnValidate()
            begin
                CheckRecItemChargeModification() //ALLE-AT
            end;
        }
        field(80035; "Rec. By Fin4"; Boolean)
        {
            Description = 'ALLE-AT';
            DataClassification = CustomerContent;
            Caption = 'Rec. By Fin4';

            trigger OnValidate()
            begin
                CheckRecItemChargeModification() //ALLE-AT
            end;
        }
        field(80036; "Rec. By Fin5"; Boolean)
        {
            Description = 'ALLE-AT';
            DataClassification = CustomerContent;
            Caption = 'Rec. By Fin5';

            trigger OnValidate()
            begin
                CheckRecItemChargeModification() //ALLE-AT
            end;
        }
        field(80037; "Rec. By Fin6"; Boolean)
        {
            Description = 'ALLE-AT';
            DataClassification = CustomerContent;
            Caption = 'Rec. By Fin6';

            trigger OnValidate()
            begin
                CheckRecItemChargeModification() //ALLE-AT
            end;
        }
        field(80038; "Tentative Value1"; Decimal)
        {
            Description = 'ALLE-AT';
            DataClassification = CustomerContent;
            Caption = 'Tentative Value1';
        }
        field(80039; "Tentative Value2"; Decimal)
        {
            Description = 'ALLE-AT';
            DataClassification = CustomerContent;
            Caption = 'Tentative Value2';
        }
        field(80040; "Tentative Value3"; Decimal)
        {
            Description = 'ALLE-AT';
            DataClassification = CustomerContent;
            Caption = 'Tentative Value3';
        }
        field(80041; "Tentative Value4"; Decimal)
        {
            Description = 'ALLE-AT';
            DataClassification = CustomerContent;
            Caption = 'Tentative Value4';
        }
        field(80042; "Tentative Value5"; Decimal)
        {
            Description = 'ALLE-AT';
            DataClassification = CustomerContent;
            Caption = 'Tentative Value5';
        }
        field(80043; "Tentative Value6"; Decimal)
        {
            Description = 'ALLE-AT';
            DataClassification = CustomerContent;
            Caption = 'Tentative Value6';
        }
        field(80044; "Valid From"; Date)
        {
            Description = 'ALLE-AT';
            DataClassification = CustomerContent;
            Caption = 'Valid From';

            trigger OnValidate()
            begin
                if "Valid From" <> 0D then if ("SSD Order Type" = "SSD Order Type"::"Fixed Assets") or ("SSD Order Type" = "SSD Order Type"::Inventory) then Error(POTypeErr);
            end;
        }
        field(80045; "Valid To"; Date)
        {
            Description = 'ALLE-AT';
            DataClassification = CustomerContent;
            Caption = 'Valid To';

            trigger OnValidate()
            begin
                if "Valid To" <> 0D then if ("SSD Order Type" = "SSD Order Type"::"Fixed Assets") or ("SSD Order Type" = "SSD Order Type"::Inventory) then Error(POTypeErr);
            end;
        }
        field(80046; "Service Order No."; Code[16])
        {
            Description = 'Alle 28042021';
            DataClassification = CustomerContent;
            Caption = 'Service Order No.';

            trigger OnLookup()
            var
                PurchaseHeader2: Record "Purchase Header";
            begin
                PurchaseHeader2.Reset();
                PurchaseHeader2.SetCurrentkey("Document Type", "No.");
                PurchaseHeader2.SetRange("Document Type", PurchaseHeader2."document type"::Order);
                PurchaseHeader2.SetFilter("No.", '%1', 'BWO*');
                PurchaseHeader2.SetRange("Buy-from Vendor No.", "Buy-from Vendor No.");
                PurchaseHeader2.SetRange(Subcontracting, false);
                if PurchaseHeader2.FindFirst() then begin
                    if Page.RunModal(0, PurchaseHeader2) = Action::LookupOK then begin
                        Validate("Service Order No.", PurchaseHeader2."No.");
                    end;
                end;
            end;
        }
        field(80047; "Service Order"; Boolean)
        {
            Description = 'Alle 28042021';
            Editable = false;
            DataClassification = CustomerContent;
            Caption = 'Service Order';
        }
        field(80048; "Close PO"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Close PO';

            trigger OnValidate()
            begin
                PL.Reset();
                PL.SetRange("Document No.", "No.");
                if PL.FindFirst() then
                    repeat
                        PL.Validate("Outstanding Quantity", 0);
                        PL.Validate(Quantity, 0);
                        PL.Modify();
                    until PL.Next() = 0;
            end;
        }
        field(80049; "Type of Invoice"; Enum "Type of Invoice Purchase")
        {
            Caption = 'Type of Invoice';
        }
        field(80050; "PO Email"; Boolean)
        {
            Caption = 'Send Item PO to Vendor';
        }
        field(80051; "Price Match/Mismatch"; Boolean)
        {
            Caption = 'Price Match/Mismatch';
            CalcFormula = - exist("Purchase Line" where("Document Type" = field("Document Type"), "Document No." = field("No."), "Price Match/Mismatch" = filter(false)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(80052; "Approval Required"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(80053; "SRN Approval Status"; Enum "SRN Approval")
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(80054; "SRN Approval Pending UserID"; Code[100])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
    }
    trigger OnInsert()
    begin
        "Created By User Id" := UserId;
        "Created  Date" := CurrentDateTime;
        if "SSD Order Type" = "SSD Order Type"::Service then UpdateGracePeriod();
    end;

    trigger OnAfterInsert()
    var
        SSDPurchaseAttachment: Record "SSD Purchase Attachment";
    begin
        if not SSDPurchaseAttachment.Get("Document Type", "No.") then begin
            SSDPurchaseAttachment.Init();
            SSDPurchaseAttachment.TransferFields(Rec);
            SSDPurchaseAttachment.Insert(true);
        end;
    end;

    local procedure CheckItemChargeModification()
    var
        RecUser: Record "User Setup";
    begin
        RecUser.Get(UserId);
        RecUser.TestField("Allow to Rec. Item Charge");
    end;

    local procedure CheckRecItemChargeModification()
    var
        RecUser: Record "User Setup";
    begin
        RecUser.Get(UserId);
        RecUser.TestField("Allow to Rec. Item Charge");
    end;
    /// <summary>
    /// InsertTCLines.
    /// </summary>
    /// <param name="PurchaseHeader">Record "Purchase Header".</param>
    procedure InsertTCLines(PurchaseHeader: Record "Purchase Header")
    var
        SSDPOTerms: Record "SSD PO Terms";
        SSDTermsLine: Record "SSD Terms Line";
    begin
        SSDTermsLine.SetRange("Terms Code", PurchaseHeader."SSD TC Code");
        //SSDTermsLine.SetRange("Print on PO", true);
        if SSDTermsLine.FindSet() then
            repeat
                SSDPOTerms.Init();
                SSDPOTerms."Document Type" := PurchaseHeader."Document Type";
                SSDPOTerms."Document No." := PurchaseHeader."No.";
                SSDPOTerms."TC Code" := PurchaseHeader."SSD TC Code";
                SSDPOTerms."Line No." := SSDTermsLine."Line No.";
                SSDPOTerms."Sequence No." := SSDTermsLine."Sequence No.";
                SSDPOTerms."Sub Sequence No." := SSDTermsLine."Sub Sequence No.";
                SSDPOTerms.Description := SSDTermsLine.Description;
                SSDPOTerms."Is Header" := SSDTermsLine."Is Header";
                SSDPOTerms."Print on PO" := SSDTermsLine."Print on PO";
                SSDPOTerms."Check List" := SSDTermsLine."Check List";
                SSDPOTerms."Attachment Required" := SSDTermsLine."Attachment Required";
                SSDPOTerms."SSD Attachment Type" := SSDTermsLine."SSD Attachment Type";
                SSDPOTerms.Insert(true);
            until SSDTermsLine.Next() = 0;
    end;
    /// <summary>
    /// CheckTCLineExists.
    /// </summary>
    /// <param name="PurchaseHeader">Record "Purchase Header".</param>
    /// <param name="WithCode">Boolean.</param>
    /// <returns>Return value of type Boolean.</returns>
    procedure CheckTCLineExists(PurchaseHeader: Record "Purchase Header"; WithCode: Boolean): Boolean
    var
        SSDPOTerms: Record "SSD PO Terms";
    begin
        SSDPOTerms.Reset();
        SSDPOTerms.SetRange("Document Type", PurchaseHeader."Document Type");
        SSDPOTerms.SetRange("Document No.", PurchaseHeader."No.");
        if WithCode then SSDPOTerms.SetRange("TC Code", PurchaseHeader."SSD TC Code");
        if SSDPOTerms.IsEmpty then
            exit(false)
        else
            exit(true);
    end;
    /// <summary>
    /// DeleteTCLines.
    /// </summary>
    /// <param name="PurchaseHeader">Record "Purchase Header".</param>
    procedure DeleteTCLines(PurchaseHeader: Record "Purchase Header")
    var
        SSDPOTerms: Record "SSD PO Terms";
    begin
        SSDPOTerms.Reset();
        SSDPOTerms.SetRange("Document Type", PurchaseHeader."Document Type");
        SSDPOTerms.SetRange("Document No.", PurchaseHeader."No.");
        if SSDPOTerms.FindSet() then SSDPOTerms.DeleteAll(true);
    end;

    local procedure UpdateGracePeriod()
    begin
        PurchSetup.Get();
        if format(PurchSetup."SSD Service Grace Period") <> '' then Rec."SSD Service Grace Period" := PurchSetup."SSD Service Grace Period";
    end;

    var
        UserSetup: Record "User Setup";
        PL: Record "Purchase Line";
        Text50000: label 'The Payment terms code is different from the Code attached on Vendor %1.\ Do you want to continue?';
        Text50001: label 'Payment Terms have not been modified';
        Text50002: label 'TDS/TCS needs to be calculated.';
        TCLineDeleteQst: Label 'Terms & Conditions Lines exists. If you proceed, existing lines will be deleted. Do you want to continue?';
        POTypeErr: Label 'Validity can be defined for Service Order';
}
