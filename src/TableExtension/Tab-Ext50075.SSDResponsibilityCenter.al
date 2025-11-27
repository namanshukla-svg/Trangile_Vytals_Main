tableextension 50075 "SSD Responsibility Center" extends "Responsibility Center"
{
    fields
    {
        field(50000; "Address 3"; Text[30])
        {
            Description = 'CF001';
            DataClassification = CustomerContent;
            Caption = 'Address 3';
        }
        field(50001; "E.C.C. No."; Code[30])
        {
            Description = 'CF001';
            DataClassification = CustomerContent;
            Caption = 'E.C.C. No.';
        }
        field(50002; Range; Text[30])
        {
            Description = 'CF001';
            DataClassification = CustomerContent;
            Caption = 'Range';
        }
        field(50003; Division; Text[30])
        {
            Description = 'CF001';
            DataClassification = CustomerContent;
            Caption = 'Division';
        }
        field(50004; "C.S.T. No."; Code[30])
        {
            Description = 'CF001';
            DataClassification = CustomerContent;
            Caption = 'C.S.T. No.';
        }
        field(50005; "L.S.T. No."; Code[30])
        {
            Description = 'CF001';
            DataClassification = CustomerContent;
            Caption = 'L.S.T. No.';
        }
        field(50006; "T.A.N. No."; Code[30])
        {
            Description = 'CF001';
            DataClassification = CustomerContent;
            Caption = 'T.A.N. No.';
        }
        field(50007; "ER Format"; Option)
        {
            Description = 'CF001';
            OptionMembers = BOSTON, CHENNAI, GURGAON, HARIDWAR, HO, KORIN, NASHIK, SURAJPUR;
            DataClassification = CustomerContent;
            Caption = 'ER Format';
        }
        field(50012; "Giro No."; Text[20])
        {
            Caption = 'Giro No.';
            Description = 'CF001';
            DataClassification = CustomerContent;
        }
        field(50013; "Bank Name"; Text[30])
        {
            Caption = 'Bank Name';
            Description = 'CF001';
            DataClassification = CustomerContent;
        }
        field(50014; "Bank Branch No."; Text[20])
        {
            Caption = 'Bank Branch No.';
            Description = 'CF001';
            DataClassification = CustomerContent;
        }
        field(50015; "Bank Account No."; Text[20])
        {
            Caption = 'Bank Account No.';
            Description = 'CF001';
            DataClassification = CustomerContent;
        }
        field(50016; "Payment Routing No."; Text[20])
        {
            Caption = 'Payment Routing No.';
            Description = 'CF001';
            DataClassification = CustomerContent;
        }
        field(50017; "Customs Permit No."; Text[10])
        {
            Caption = 'Customs Permit No.';
            Description = 'CF001';
            DataClassification = CustomerContent;
        }
        field(50018; "Customs Permit Date"; Date)
        {
            Caption = 'Customs Permit Date';
            Description = 'CF001';
            DataClassification = CustomerContent;
        }
        field(50019; "VAT Registration No."; Text[20])
        {
            Caption = 'VAT Registration No.';
            Description = 'CF001';
            DataClassification = CustomerContent;

            trigger OnValidate()
            var
                VATRegNoFormat: Record "VAT Registration No. Format";
            begin
                VATRegNoFormat.Test("VAT Registration No.", "Country/Region Code", '', Database::"Company Information");
            end;
        }
        field(50020; "Registration No."; Text[20])
        {
            Caption = 'Registration No.';
            Description = 'CF001';
            DataClassification = CustomerContent;
        }
        field(50021; "Telex Answer Back"; Text[20])
        {
            Caption = 'Telex Answer Back';
            Description = 'CF001';
            DataClassification = CustomerContent;
        }
        field(50022; "Ship-to Name"; Text[30])
        {
            Caption = 'Ship-to Name';
            Description = 'CF001';
            DataClassification = CustomerContent;
        }
        field(50023; "Ship-to Name 2"; Text[30])
        {
            Caption = 'Ship-to Name 2';
            Description = 'CF001';
            DataClassification = CustomerContent;
        }
        field(50024; "Ship-to Address"; Text[30])
        {
            Caption = 'Ship-to Address';
            Description = 'CF001';
            DataClassification = CustomerContent;
        }
        field(50025; "Ship-to Address 2"; Text[30])
        {
            Caption = 'Ship-to Address 2';
            Description = 'CF001';
            DataClassification = CustomerContent;
        }
        field(50026; "Ship-to City"; Text[30])
        {
            Caption = 'Ship-to City';
            Description = 'CF001';
            DataClassification = CustomerContent;
        }
        field(50027; "Ship-to Contact"; Text[30])
        {
            Caption = 'Ship-to Contact';
            Description = 'CF001';
            DataClassification = CustomerContent;
        }
        field(50028; "Ship-to Post Code"; Code[20])
        {
            Caption = 'Ship-to Post Code';
            Description = 'CF001';
            TableRelation = "Post Code";
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
            DataClassification = CustomerContent;
        }
        field(50030; "Ship-to Country Code"; Code[10])
        {
            Caption = 'Ship-to Country Code';
            Description = 'CF001';
            TableRelation = "Country/Region";
            DataClassification = CustomerContent;
        }
        field(50031; Iban; Code[30])
        {
            Caption = 'IBAN';
            Description = 'CF001';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                CheckIBAN(Iban);
            end;
        }
        field(50032; "SWIFT Code"; Code[20])
        {
            Caption = 'SWIFT Code';
            Description = 'CF001';
            DataClassification = CustomerContent;
        }
        field(50033; "Industrial Classification"; Text[30])
        {
            Caption = 'Industrial Classification';
            Description = 'CF001';
            DataClassification = CustomerContent;
        }
        field(50034; "Check-Avail. Period Calc."; DateFormula)
        {
            Caption = 'Check-Avail. Period Calc.';
            Description = 'CF001';
            DataClassification = CustomerContent;
        }
        field(50035; "Check-Avail. Time Bucket"; Option)
        {
            Caption = 'Check-Avail. Time Bucket';
            Description = 'CF001';
            OptionCaption = 'Day,Week,Month,Quarter,Year';
            OptionMembers = Day, Week, Month, Quarter, Year;
            DataClassification = CustomerContent;
        }
        field(50036; "Base Calendar Code"; Code[10])
        {
            Caption = 'Base Calendar Code';
            Description = 'CF001';
            TableRelation = "Base Calendar";
            DataClassification = CustomerContent;
        }
        field(50037; "Cal. Convergence Time Frame"; DateFormula)
        {
            Caption = 'Cal. Convergence Time Frame';
            Description = 'CF001';
            InitValue = '1Y';
            DataClassification = CustomerContent;
        }
        field(50038; "T.I.N. No."; Code[11])
        {
            Caption = 'T.I.N. No.';
            Description = 'CF001';
            DataClassification = CustomerContent;
        }
        field(50039; "Excise Registration No."; Text[20])
        {
            Description = 'CF001';
            DataClassification = CustomerContent;
            Caption = 'Excise Registration No.';
        }
        field(50040; "Courier Shipper ID"; Text[15])
        {
            Description = 'CF001';
            DataClassification = CustomerContent;
            Caption = 'Courier Shipper ID';
        }
        field(50041; "P.A.N. No."; Code[20])
        {
            Caption = 'P.A.N. No.';
            Description = 'CF001';
            DataClassification = CustomerContent;
        }
        field(50042; "L.T.E.G. No"; Code[20])
        {
            Description = 'CF001';
            DataClassification = CustomerContent;
            Caption = 'L.T.E.G. No';
        }
        field(50043; "Ship-to Courier Zone"; Code[2])
        {
            Description = 'CF001';
            DataClassification = CustomerContent;
            Caption = 'Ship-to Courier Zone';
        }
        field(50044; "C.E. Registration No."; Code[20])
        {
            Caption = 'C.E. Registration No.';
            Description = 'CF001';
            DataClassification = CustomerContent;
        }
        field(50045; "C.E. Range"; Code[20])
        {
            Caption = 'C.E. Range';
            Description = 'CF001';
            DataClassification = CustomerContent;
        }
        field(50046; "C.E. Commissionerate"; Code[20])
        {
            Caption = 'C.E. Commissionerate';
            Description = 'CF001';
            DataClassification = CustomerContent;
        }
        field(50047; State; Code[10])
        {
            Caption = 'State';
            Description = 'CF001';
            TableRelation = State.Code;
            DataClassification = CustomerContent;
        }
        field(50048; "RBI CODE"; Code[20])
        {
            Description = 'CF001';
            DataClassification = CustomerContent;
            Caption = 'RBI CODE';
        }
        field(50049; "I.E.C. Code"; Code[20])
        {
            Description = 'CF001';
            DataClassification = CustomerContent;
            Caption = 'I.E.C. Code';
        }
        field(50050; "Factories Act. Regd. No."; Code[20])
        {
            Caption = 'Factories Act. Regd. No.';
            Description = 'CF001';
            DataClassification = CustomerContent;
        }
        field(50051; "E.S.I"; Code[20])
        {
            Description = 'CF001';
            DataClassification = CustomerContent;
            Caption = 'E.S.I';
        }
        field(50052; "E. Provident Fund"; Code[20])
        {
            Description = 'CF001';
            DataClassification = CustomerContent;
            Caption = 'E. Provident Fund';
        }
        field(50053; "C.E. Division"; Code[20])
        {
            Caption = 'C.E. Division';
            Description = 'CF001';
            DataClassification = CustomerContent;
        }
        field(50054; "L.S.T. Regn No."; Code[30])
        {
            Description = 'CF001';
            DataClassification = CustomerContent;
            Caption = 'L.S.T. Regn No.';
        }
        field(50055; "C.S.T Regn No."; Code[30])
        {
            Description = 'CF001';
            DataClassification = CustomerContent;
            Caption = 'C.S.T Regn No.';
        }
        field(50056; "Company Registration  No."; Code[20])
        {
            Caption = 'Company Registration  No.';
            Description = 'CF001';
            DataClassification = CustomerContent;
        }
        field(50057; "RCMC No."; Code[20])
        {
            Description = 'CF001';
            DataClassification = CustomerContent;
            Caption = 'RCMC No.';
        }
        field(50058; "P.A.N Circle No."; Text[30])
        {
            Description = 'CF001';
            DataClassification = CustomerContent;
            Caption = 'P.A.N Circle No.';
        }
        field(50059; "P.A.N Ward No."; Text[30])
        {
            Description = 'CF001';
            DataClassification = CustomerContent;
            Caption = 'P.A.N Ward No.';
        }
        field(50060; "P.A.N Assessing Officer"; Text[30])
        {
            Description = 'CF001';
            DataClassification = CustomerContent;
            Caption = 'P.A.N Assessing Officer';
        }
        field(50061; "T.A.N. Circle No."; Text[30])
        {
            Caption = 'T.A.N. Circle No.';
            Description = 'CF001';
            DataClassification = CustomerContent;
        }
        field(50062; "T.A.N. Ward No."; Text[30])
        {
            Caption = 'T.A.N. Ward No.';
            Description = 'CF001';
            DataClassification = CustomerContent;
        }
        field(50063; "T.A.N. Assessing Officer"; Text[30])
        {
            Caption = 'T.A.N. Assessing Officer';
            Description = 'CF001';
            DataClassification = CustomerContent;
        }
        field(50064; "Ward No."; Text[30])
        {
            Description = 'CF001';
            DataClassification = CustomerContent;
            Caption = 'Ward No.';
        }
        field(50065; "Cash Account No."; Code[10])
        {
            Caption = 'Cash Account No.';
            Description = 'CF001';
            TableRelation = "G/L Account";
            DataClassification = CustomerContent;
        }
        field(50066; "Mail Required"; Boolean)
        {
            Caption = 'Mail Required';
            Description = 'CF001';
            DataClassification = CustomerContent;
        }
        field(50067; "WorkFlow Manager"; Code[20])
        {
            Caption = 'WorkFlow Manager';
            Description = 'CF001';
            TableRelation = User;
            DataClassification = CustomerContent;
        }
        field(50068; "DGFT Address2"; Text[30])
        {
            Description = 'CF001';
            DataClassification = CustomerContent;
            Caption = 'DGFT Address2';
        }
        field(50069; "DGFT Phone"; Text[20])
        {
            Description = 'CF001';
            DataClassification = CustomerContent;
            Caption = 'DGFT Phone';
        }
        field(50070; "DGFT Phone2"; Text[20])
        {
            Description = 'CF001';
            DataClassification = CustomerContent;
            Caption = 'DGFT Phone2';
        }
        field(50071; "DGFT City"; Text[30])
        {
            Description = 'CF001';
            TableRelation = "Post Code".City;
            DataClassification = CustomerContent;
            Caption = 'DGFT City';
        }
        field(50072; "DGFT State"; Text[20])
        {
            Description = 'CF001';
            TableRelation = State;
            DataClassification = CustomerContent;
            Caption = 'DGFT State';
        }
        field(50073; "DGF Post Code"; Code[20])
        {
            Caption = 'DGF Post Code';
            Description = 'CF001';
            TableRelation = "Post Code".Code;
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
            DataClassification = CustomerContent;
        }
        field(50074; "DGFT Country"; Text[30])
        {
            Description = 'CF001';
            TableRelation = "Country/Region";
            DataClassification = CustomerContent;
            Caption = 'DGFT Country';
        }
        field(50075; "Drawback Ledger Account No."; Code[30])
        {
            Description = 'CF001';
            DataClassification = CustomerContent;
            Caption = 'Drawback Ledger Account No.';
        }
        field(50076; "DGFT Address"; Text[20])
        {
            Description = 'CF001-50-20->5.51';
            DataClassification = CustomerContent;
            Caption = 'DGFT Address';
        }
        field(50077; "DGFT Name"; Text[20])
        {
            Description = 'CF001-45-20->5.51';
            DataClassification = CustomerContent;
            Caption = 'DGFT Name';
        }
        field(50078; "Workflow Timer Activate"; Boolean)
        {
            Caption = 'Workflow Timer Activate';
            Description = 'CF001';
            DataClassification = CustomerContent;
        }
        field(50079; "Service Tax Registration No."; Code[20])
        {
            Caption = 'Service Tax Registration No.';
            Description = 'CF001';
            DataClassification = CustomerContent;
        }
        field(50080; "Work Center Nos."; Code[10])
        {
            Caption = 'Work Center Nos.';
            Description = 'CF001';
            TableRelation = "No. Series";
            DataClassification = CustomerContent;
        }
        field(50081; "Machine Center Nos."; Code[10])
        {
            Caption = 'Machine Center Nos.';
            Description = 'CF001';
            TableRelation = "No. Series";
            DataClassification = CustomerContent;
        }
        field(50082; "Routing Nos."; Code[10])
        {
            Caption = 'Routing Nos.';
            Description = 'CF001';
            TableRelation = "No. Series";
            DataClassification = CustomerContent;
        }
        field(50083; "Sales Reminder Nos."; Code[10])
        {
            Caption = 'Sales Reminder Nos.';
            Description = 'CF001';
            TableRelation = "No. Series";
            DataClassification = CustomerContent;
        }
        field(50084; "Issued Sales Reminder Nos."; Code[10])
        {
            Caption = 'Issued Sales Reminder Nos.';
            Description = 'CF001';
            TableRelation = "No. Series";
            DataClassification = CustomerContent;
        }
        field(50085; "Sales Fin. Chrg. Memo Nos."; Code[10])
        {
            Caption = 'Sales Fin. Chrg. Memo Nos.';
            Description = 'CF001';
            TableRelation = "No. Series";
            DataClassification = CustomerContent;
        }
        field(50086; "Issued SalesFin. Chrg. M. Nos."; Code[10])
        {
            Caption = 'Issued SalesFin. Chrg. M. Nos.';
            Description = 'CF001';
            TableRelation = "No. Series";
            DataClassification = CustomerContent;
        }
        field(50089; "Inv. Transfer Order Nos."; Code[10])
        {
            Caption = 'Inv. Transfer Order Nos.';
            TableRelation = "No. Series";
            DataClassification = CustomerContent;
        }
        field(50090; "Posted Inv Transfer Shpt. Nos."; Code[10])
        {
            Caption = 'Posted Inv. Transfer Shpt. Nos.';
            TableRelation = "No. Series";
            DataClassification = CustomerContent;
        }
        field(50091; "Posted Inv Transfer Rcpt. Nos."; Code[10])
        {
            Caption = 'Posted Inv. Transfer Rcpt. Nos.';
            TableRelation = "No. Series";
            DataClassification = CustomerContent;
        }
        field(50092; "Inventory Put-away Nos."; Code[10])
        {
            Caption = 'Inventory Put-away Nos.';
            TableRelation = "No. Series";
            DataClassification = CustomerContent;
        }
        field(50093; "Inventory Pick Nos."; Code[10])
        {
            Caption = 'Inventory Pick Nos.';
            TableRelation = "No. Series";
            DataClassification = CustomerContent;
        }
        field(50094; "Posted Invt. Put-away Nos."; Code[10])
        {
            Caption = 'Posted Invt. Put-away Nos.';
            TableRelation = "No. Series";
            DataClassification = CustomerContent;
        }
        field(50095; "Posted Invt. Pick Nos."; Code[10])
        {
            Caption = 'Posted Invt. Pick Nos.';
            TableRelation = "No. Series";
            DataClassification = CustomerContent;
        }
        field(50096; "Inv. Third Party Nos."; Code[10])
        {
            Caption = 'Inv. Third Party Nos.';
            TableRelation = "No. Series";
            DataClassification = CustomerContent;
        }
        field(50097; "Whse. Receipt Nos."; Code[10])
        {
            Caption = 'Whse. Receipt Nos.';
            Description = 'CF001';
            TableRelation = "No. Series";
            DataClassification = CustomerContent;
        }
        field(50098; "Whse. Put-away Nos."; Code[10])
        {
            Caption = 'Whse. Put-away Nos.';
            Description = 'CF001';
            TableRelation = "No. Series";
            DataClassification = CustomerContent;
        }
        field(50099; "Whse. Pick Nos."; Code[10])
        {
            Caption = 'Whse. Pick Nos.';
            Description = 'CF001';
            TableRelation = "No. Series";
            DataClassification = CustomerContent;
        }
        field(50100; "Whse. Ship Nos."; Code[10])
        {
            Caption = 'Whse. Ship Nos.';
            Description = 'CF001';
            TableRelation = "No. Series";
            DataClassification = CustomerContent;
        }
        field(50101; "Registered Whse. Pick Nos."; Code[10])
        {
            Caption = 'Registered Whse. Pick Nos.';
            Description = 'CF001';
            TableRelation = "No. Series";
            DataClassification = CustomerContent;
        }
        field(50102; "Registered Whse. Put-away Nos."; Code[10])
        {
            Caption = 'Registered Whse. Put-away Nos.';
            Description = 'CF001';
            TableRelation = "No. Series";
            DataClassification = CustomerContent;
        }
        field(50103; "Posted Whse. Receipt Nos."; Code[10])
        {
            Caption = 'Posted Whse. Receipt Nos.';
            Description = 'CF001';
            TableRelation = "No. Series";
            DataClassification = CustomerContent;
        }
        field(50104; "Posted Whse. Shipment Nos."; Code[10])
        {
            Caption = 'Posted Whse. Shipment Nos.';
            Description = 'CF001';
            TableRelation = "No. Series";
            DataClassification = CustomerContent;
        }
        field(50105; "Whse. Internal Put-away Nos."; Code[10])
        {
            Caption = 'Whse. Internal Put-away Nos.';
            Description = 'CF001';
            TableRelation = "No. Series";
            DataClassification = CustomerContent;
        }
        field(50106; "Whse. Internal Pick Nos."; Code[10])
        {
            Caption = 'Whse. Internal Pick Nos.';
            Description = 'CF001';
            TableRelation = "No. Series";
            DataClassification = CustomerContent;
        }
        field(50107; "Whse. Movement Nos."; Code[10])
        {
            Caption = 'Whse. Movement Nos.';
            Description = 'CF001';
            TableRelation = "No. Series";
            DataClassification = CustomerContent;
        }
        field(50108; "Registered Whse. Movement Nos."; Code[10])
        {
            Caption = 'Registered Whse. Movement Nos.';
            Description = 'CF001';
            TableRelation = "No. Series";
            DataClassification = CustomerContent;
        }
        field(50109; "Customer Nos."; Code[10])
        {
            Caption = 'Customer Nos.';
            Description = 'CF001';
            TableRelation = "No. Series";
            DataClassification = CustomerContent;
        }
        field(50110; "Vendor Nos."; Code[10])
        {
            Caption = 'Vendor Nos.';
            Description = 'CF001';
            TableRelation = "No. Series";
            DataClassification = CustomerContent;
        }
        field(50111; "Item Nos."; Code[10])
        {
            Caption = 'Item Nos.';
            Description = 'CF001';
            TableRelation = "No. Series";
            DataClassification = CustomerContent;
        }
        field(50112; "Sales Sch. Order Nos."; Code[10])
        {
            Caption = 'Sales Sch. Order Nos.';
            Description = 'CF001';
            TableRelation = "No. Series";
            DataClassification = CustomerContent;
        }
        field(50113; "Sales Despatch Slip Nos."; Code[10])
        {
            Caption = 'Sales Despatch Slip Nos.';
            Description = 'CF001';
            TableRelation = "No. Series";
            DataClassification = CustomerContent;
        }
        field(50114; "Free Sample Invoice Nos."; Code[10])
        {
            Caption = 'Free Sample Invoice Nos.';
            Description = 'EXIM';
            TableRelation = "No. Series";
            DataClassification = CustomerContent;
        }
        field(50115; "VAT Invoice Nos."; Code[10])
        {
            Caption = 'VAT Invoice Nos.';
            Description = 'EXIM';
            TableRelation = "No. Series";
            DataClassification = CustomerContent;
        }
        field(50116; "F Form Invoice Nos."; Code[10])
        {
            Caption = 'F Form Invoice Nos.';
            Description = 'EXIM';
            TableRelation = "No. Series";
            DataClassification = CustomerContent;
        }
        field(50117; IEDate; Date)
        {
            Description = 'Akash';
            DataClassification = CustomerContent;
            Caption = 'IEDate';
        }
        field(50200; "Excise Undertaking No."; Code[40])
        {
            Description = 'EXIM\\Added On 200706 for A.R.E';
            DataClassification = CustomerContent;
            Caption = 'Excise Undertaking No.';
        }
        field(50201; "Excise Undertaking Date"; Date)
        {
            Description = 'EXIM\\Added On 200706 for A.R.E';
            DataClassification = CustomerContent;
            Caption = 'Excise Undertaking Date';
        }
        field(50202; "Job Work Location"; Code[10])
        {
            Description = 'Alle VPB';
            TableRelation = Location;
            DataClassification = CustomerContent;
            Caption = 'Job Work Location';
        }
        field(52000; "Posted PurchInvoice Nos."; Code[10])
        {
            Caption = 'Posted PurchInvoice Nos.';
            Description = 'CF001';
            TableRelation = "No. Series";
            DataClassification = CustomerContent;
        }
        field(52001; "Posted PurchCredit Memo Nos."; Code[10])
        {
            Caption = 'Posted PurchCredit Memo Nos.';
            Description = 'CF001';
            TableRelation = "No. Series";
            DataClassification = CustomerContent;
        }
        field(52002; "Posted Receipt Nos."; Code[10])
        {
            Caption = 'Posted Receipt Nos.';
            Description = 'CF001';
            TableRelation = "No. Series";
            DataClassification = CustomerContent;
        }
        field(52003; "Posted Return Shpt. Nos."; Code[10])
        {
            Caption = 'Posted Return Shpt. Nos.';
            Description = 'CF001';
            TableRelation = "No. Series";
            DataClassification = CustomerContent;
        }
        field(52004; "Purchase Quote Nos."; Code[10])
        {
            Caption = 'Purchase Quote Nos.';
            Description = 'CF001';
            TableRelation = "No. Series";
            DataClassification = CustomerContent;
        }
        field(52005; "Purchase Order Nos."; Code[10])
        {
            Caption = 'Purchase Order Nos.';
            Description = 'CF001';
            TableRelation = "No. Series";
            DataClassification = CustomerContent;
        }
        field(52006; "Purchase Invoice Nos."; Code[10])
        {
            Caption = 'PurchaseInvoice Nos.';
            Description = 'CF001';
            TableRelation = "No. Series";
            DataClassification = CustomerContent;
        }
        field(52007; "Purchase Credit Memo Nos."; Code[10])
        {
            Caption = 'Purchase Credit Memo Nos.';
            Description = 'CF001';
            TableRelation = "No. Series";
            DataClassification = CustomerContent;
        }
        field(52008; "Purchase Blanket Order Nos."; Code[10])
        {
            Caption = 'Purchase Blanket Order Nos.';
            Description = 'CF001';
            TableRelation = "No. Series";
            DataClassification = CustomerContent;
        }
        field(52009; "Purchase Return Order Nos."; Code[10])
        {
            Caption = 'Purchase Return Order Nos.';
            Description = 'CF001';
            TableRelation = "No. Series";
            DataClassification = CustomerContent;
        }
        field(52010; "Posted Delivery Challan No."; Code[10])
        {
            Description = 'CF001';
            TableRelation = "No. Series";
            DataClassification = CustomerContent;
            Caption = 'Posted Delivery Challan No.';
        }
        field(52011; "Subcontracting Order No."; Code[10])
        {
            Description = 'CF001';
            TableRelation = "No. Series";
            DataClassification = CustomerContent;
            Caption = 'Subcontracting Order No.';
        }
        field(52012; "Posted SubCon. Comp. Recpt. No"; Code[10])
        {
            Description = 'CF001';
            TableRelation = "No. Series";
            DataClassification = CustomerContent;
            Caption = 'Posted SubCon. Comp. Recpt. No';
        }
        field(52013; "Delivery Challan No."; Code[10])
        {
            Description = 'CF001';
            TableRelation = "No. Series";
            DataClassification = CustomerContent;
            Caption = 'Delivery Challan No.';
        }
        field(53000; "Posted SalesInvoice Nos."; Code[10])
        {
            Caption = 'Posted SalesInvoice Nos.';
            Description = 'CF001';
            TableRelation = "No. Series";
            DataClassification = CustomerContent;
        }
        field(53001; "Posted SalesCredit Memo Nos."; Code[10])
        {
            Caption = 'Posted SalesCredit Memo Nos.';
            Description = 'CF001';
            TableRelation = "No. Series";
            DataClassification = CustomerContent;
        }
        field(53002; "Posted Shipment Nos."; Code[10])
        {
            Caption = 'Posted Shipment Nos.';
            Description = 'CF001';
            TableRelation = "No. Series";
            DataClassification = CustomerContent;
        }
        field(53003; "Posted Return Receipt Nos."; Code[10])
        {
            Caption = 'Posted Return Receipt Nos.';
            Description = 'CF001';
            TableRelation = "No. Series";
            DataClassification = CustomerContent;
        }
        field(53004; "Sales Quote Nos."; Code[10])
        {
            Caption = 'Sales Quote Nos.';
            Description = 'CF001';
            TableRelation = "No. Series";
            DataClassification = CustomerContent;
        }
        field(53005; "Sales Order Nos."; Code[10])
        {
            Caption = 'Sales Order Nos.';
            Description = 'CF001';
            TableRelation = "No. Series";
            DataClassification = CustomerContent;
        }
        field(53006; "Sales Invoice Nos."; Code[10])
        {
            Caption = 'Sales Invoice Nos.';
            Description = 'CF001';
            TableRelation = "No. Series";
            DataClassification = CustomerContent;
        }
        field(53007; "Sales Credit Memo Nos."; Code[10])
        {
            Caption = 'Sales Credit Memo Nos.';
            Description = 'CF001';
            TableRelation = "No. Series";
            DataClassification = CustomerContent;
        }
        field(53008; "Sales Blanket Order Nos."; Code[10])
        {
            Caption = 'Sales Blanket Order Nos.';
            Description = 'CF001';
            TableRelation = "No. Series";
            DataClassification = CustomerContent;
        }
        field(53009; "Sales Return Order Nos."; Code[10])
        {
            Caption = 'Sales Return Order Nos.';
            Description = 'CF001';
            TableRelation = "No. Series";
            DataClassification = CustomerContent;
        }
        field(54000; "Indent No. Series"; Code[20])
        {
            Description = 'CF001';
            TableRelation = "No. Series";
            DataClassification = CustomerContent;
            Caption = 'Indent No. Series';
        }
        field(54001; "Indent Template Name"; Code[10])
        {
            Description = 'CF001';
            TableRelation = "Req. Wksh. Template" where("Page ID"=const(291), Recurring=const(false), Type=const("Req."));
            DataClassification = CustomerContent;
            Caption = 'Indent Template Name';
        }
        field(54002; "Indent Batch Name"; Code[10])
        {
            Description = 'CF001';
            TableRelation = "Requisition Wksh. Name".Name where("Worksheet Template Name"=field("Indent Template Name"));
            DataClassification = CustomerContent;
            Caption = 'Indent Batch Name';
        }
        field(54010; "RGP Out Nos"; Code[20])
        {
            Description = 'CF001';
            TableRelation = "No. Series";
            DataClassification = CustomerContent;
            Caption = 'RGP Out Nos';
        }
        field(54011; "RGP In Nos"; Code[20])
        {
            Description = 'CF001';
            TableRelation = "No. Series";
            DataClassification = CustomerContent;
            Caption = 'RGP In Nos';
        }
        field(54012; "Posted RGP IN Shipment Nos"; Code[20])
        {
            Description = 'CF001';
            TableRelation = "No. Series";
            DataClassification = CustomerContent;
            Caption = 'Posted RGP IN Shipment Nos';
        }
        field(54013; "Posted RGP IN Receipt Nos"; Code[20])
        {
            Description = 'CF001';
            TableRelation = "No. Series";
            DataClassification = CustomerContent;
            Caption = 'Posted RGP IN Receipt Nos';
        }
        field(54014; "NRGP Out Nos"; Code[20])
        {
            Description = 'CF001';
            TableRelation = "No. Series";
            DataClassification = CustomerContent;
            Caption = 'NRGP Out Nos';
        }
        field(54015; "NRGP In Nos"; Code[20])
        {
            Description = 'CF001';
            TableRelation = "No. Series";
            DataClassification = CustomerContent;
            Caption = 'NRGP In Nos';
        }
        field(54016; "Gate In Nos"; Code[20])
        {
            Description = 'CF001';
            TableRelation = "No. Series";
            DataClassification = CustomerContent;
            Caption = 'Gate In Nos';
        }
        field(54017; "Gate Out Nos"; Code[20])
        {
            Description = 'CF001';
            TableRelation = "No. Series";
            DataClassification = CustomerContent;
            Caption = 'Gate Out Nos';
        }
        field(54018; "Posted RGP OUT Shipment Nos"; Code[20])
        {
            Description = 'CF001';
            TableRelation = "No. Series";
            DataClassification = CustomerContent;
            Caption = 'Posted RGP OUT Shipment Nos';
        }
        field(54019; "Posted RGP OUT Receipt Nos"; Code[20])
        {
            Description = 'CF001';
            TableRelation = "No. Series";
            DataClassification = CustomerContent;
            Caption = 'Posted RGP OUT Receipt Nos';
        }
        field(54500; "GST Registration No."; Code[15])
        {
            Caption = 'GST Registration No.';
            TableRelation = "GST Registration Nos." where("State Code"=field(State));
            DataClassification = CustomerContent;

            trigger OnValidate()
            var
                GSTRegistrationNos: Record "GST Registration Nos.";
            begin
            end;
        }
        field(55000; "Simulated Order Nos."; Code[10])
        {
            Caption = 'Simulated Order Nos.';
            Description = 'CF001';
            TableRelation = "No. Series";
            DataClassification = CustomerContent;
        }
        field(55001; "Planned Order Nos."; Code[10])
        {
            Caption = 'Planned Order Nos.';
            Description = 'CF001';
            TableRelation = "No. Series";
            DataClassification = CustomerContent;
        }
        field(55002; "Firm Planned Order Nos."; Code[10])
        {
            Caption = 'Firm Planned Order Nos.';
            Description = 'CF001';
            TableRelation = "No. Series";
            DataClassification = CustomerContent;
        }
        field(55003; "Released Order Nos."; Code[10])
        {
            Caption = 'Released Order Nos.';
            Description = 'CF001';
            TableRelation = "No. Series";
            DataClassification = CustomerContent;
        }
        field(55006; "Production BOM Nos."; Code[10])
        {
            Caption = 'Production BOM Nos.';
            Description = 'CF001';
            TableRelation = "No. Series";
            DataClassification = CustomerContent;
        }
        field(55007; "Purch. Enquiry Nos."; Code[20])
        {
            Description = 'CF001';
            TableRelation = "No. Series";
            DataClassification = CustomerContent;
            Caption = 'Purch. Enquiry Nos.';
        }
        field(55008; "Sales Enquiry Nos."; Code[20])
        {
            Description = 'CF001';
            TableRelation = "No. Series";
            DataClassification = CustomerContent;
            Caption = 'Sales Enquiry Nos.';
        }
        field(55009; "Tool Planned Order Nos."; Code[10])
        {
            Caption = 'Tool Planned Order Nos.';
            Description = 'TR';
            TableRelation = "No. Series";
            DataClassification = CustomerContent;
        }
        field(55010; "Tool Firm Planned Order Nos."; Code[10])
        {
            Caption = 'Tool Firm Planned Order Nos.';
            Description = 'TR';
            TableRelation = "No. Series";
            DataClassification = CustomerContent;
        }
        field(55011; "Tool Released Order Nos."; Code[10])
        {
            Caption = 'Tool Released Order Nos.';
            Description = 'TR';
            TableRelation = "No. Series";
            DataClassification = CustomerContent;
        }
        field(55012; "Prod. Line Reject Location"; Code[20])
        {
            Description = 'CF001';
            TableRelation = Location.Code;
            DataClassification = CustomerContent;
            Caption = 'Prod. Line Reject Location';
        }
        field(55013; "Prod. Line Reject Bin Code"; Code[20])
        {
            Description = 'CF001';
            TableRelation = Bin.Code where("Location Code"=field("Prod. Line Reject Location"));
            DataClassification = CustomerContent;
            Caption = 'Prod. Line Reject Bin Code';
        }
        field(55017; "Gate Pass Nos"; Code[10])
        {
            Description = 'ALLE-GP001';
            TableRelation = "No. Series";
            DataClassification = CustomerContent;
            Caption = 'Gate Pass Nos';
        }
        field(60000; "Purchase Order Document No."; Code[20])
        {
            Description = 'CF001';
            DataClassification = CustomerContent;
            Caption = 'Purchase Order Document No.';
        }
        field(60001; "Excise Invoice Nos."; Code[20])
        {
            Description = 'SM_MUA09';
            TableRelation = "No. Series";
            DataClassification = CustomerContent;
            Caption = 'Excise Invoice Nos.';
        }
        field(60054; "RFQ/Enquiry Nos."; Code[20])
        {
            Description = 'CF001';
            Enabled = false;
            TableRelation = "No. Series";
            DataClassification = CustomerContent;
            Caption = 'RFQ/Enquiry Nos.';
        }
        field(75000; "Maximum Cash Receipt Limit"; Decimal)
        {
            Description = 'ALLE 2.17';
            DataClassification = CustomerContent;
            Caption = 'Maximum Cash Receipt Limit';
        }
        field(75001; "Maximum Cash Payment Limit"; Decimal)
        {
            Description = 'ALLE 2.18';
            DataClassification = CustomerContent;
            Caption = 'Maximum Cash Payment Limit';
        }
        field(75002; "Block Negative Cash"; Boolean)
        {
            Description = 'ALLE 2.18';
            DataClassification = CustomerContent;
            Caption = 'Block Negative Cash';
        }
        field(75003; "Cash Account"; Code[10])
        {
            Description = 'ALLE 2.18';
            TableRelation = "G/L Account";
            DataClassification = CustomerContent;
            Caption = 'Cash Account';
        }
        field(75004; "Freight Zone No. Series"; Code[10])
        {
            Description = 'ALLE 3.08';
            TableRelation = "No. Series";
            DataClassification = CustomerContent;
            Caption = 'Freight Zone No. Series';
        }
        field(75005; "Freight Zone Account"; Code[10])
        {
            Description = 'ALLE 3.08';
            TableRelation = "G/L Account";
            DataClassification = CustomerContent;
            Caption = 'Freight Zone Account';
        }
        field(75006; "Third Party Code"; Code[10])
        {
            Description = 'ALLE 3.08';
            TableRelation = "G/L Account";
            DataClassification = CustomerContent;
            Caption = 'Third Party Code';
        }
        field(75007; "Include Lead Time Despatch"; Boolean)
        {
            Description = 'ALLE 3.11';
            DataClassification = CustomerContent;
            Caption = 'Include Lead Time Despatch';
        }
        field(75008; "57F4 Nos"; Code[10])
        {
            Description = 'ALLE 6.12';
            TableRelation = "No. Series";
            DataClassification = CustomerContent;
            Caption = '57F4 Nos';
        }
        field(75009; "57F4 Shpt Nos"; Code[10])
        {
            Description = 'ALLE 6.12';
            TableRelation = "No. Series";
            DataClassification = CustomerContent;
            Caption = '57F4 Shpt Nos';
        }
        field(75010; "57F4 Rcpt Nos"; Code[10])
        {
            Description = 'ALLE 6.12';
            TableRelation = "No. Series";
            DataClassification = CustomerContent;
            Caption = '57F4 Rcpt Nos';
        }
        field(75011; "Purchase Invoice Direct No."; Code[10])
        {
            Description = 'ALLE 2.21';
            TableRelation = "No. Series";
            DataClassification = CustomerContent;
            Caption = 'Purchase Invoice Direct No.';
        }
        field(75012; "Posted Purch Inv Direct No."; Code[10])
        {
            Description = 'ALLE 2.21';
            TableRelation = "No. Series";
            DataClassification = CustomerContent;
            Caption = 'Posted Purch Inv Direct No.';
        }
        field(75013; "ARE1 No. Series"; Code[10])
        {
            Description = 'ALLE 3.14';
            TableRelation = "No. Series";
            DataClassification = CustomerContent;
            Caption = 'ARE1 No. Series';
        }
        field(75014; "CT2 No. Series"; Code[10])
        {
            Description = 'ALLE 3.15';
            TableRelation = "No. Series";
            DataClassification = CustomerContent;
            Caption = 'CT2 No. Series';
        }
        field(75015; "ARE3 No. Series"; Code[10])
        {
            Description = 'ALLE 3.15';
            TableRelation = "No. Series";
            DataClassification = CustomerContent;
            Caption = 'ARE3 No. Series';
        }
        field(75016; "CT3 No. Series"; Code[10])
        {
            Description = 'ALLE 3.16';
            TableRelation = "No. Series";
            DataClassification = CustomerContent;
            Caption = 'CT3 No. Series';
        }
        field(75017; "FA No. Series"; Code[10])
        {
            Description = 'MSI.RC';
            TableRelation = "No. Series";
            DataClassification = CustomerContent;
            Caption = 'FA No. Series';
        }
        field(75018; "FA Insurance No. Series"; Code[10])
        {
            Description = 'MSI.RC';
            TableRelation = "No. Series";
            DataClassification = CustomerContent;
            Caption = 'FA Insurance No. Series';
        }
        field(75019; "Purch. Sch. Order Nos."; Code[20])
        {
            Description = 'CF001';
            TableRelation = "No. Series";
            DataClassification = CustomerContent;
            Caption = 'Purch. Sch. Order Nos.';
        }
        field(75020; "Req. Slip No. Series"; Code[10])
        {
            Description = 'ALLE-5.51-3.26';
            TableRelation = "No. Series";
            DataClassification = CustomerContent;
            Caption = 'Req. Slip No. Series';
        }
        field(75021; "Req. Slip Return No. Series"; Code[10])
        {
            Description = 'ALLE-5.51-3.26';
            TableRelation = "No. Series";
            DataClassification = CustomerContent;
            Caption = 'Req. Slip Return No. Series';
        }
        field(75022; "Req. Issue Slip No. Series"; Code[10])
        {
            Description = 'ALLE-5.51-3.26';
            TableRelation = "No. Series";
            DataClassification = CustomerContent;
            Caption = 'Req. Issue Slip No. Series';
        }
        field(75023; "Intransit Location"; Code[10])
        {
            TableRelation = Location where("Use As In-Transit"=filter(true));
            DataClassification = CustomerContent;
            Caption = 'Intransit Location';
        }
        field(75024; "I.E.C. Date"; Date)
        {
            Description = 'ALLE-NM';
            DataClassification = CustomerContent;
            Caption = 'I.E.C. Date';
        }
        field(75025; "Posted Comm. Inv. No. Series"; Code[20])
        {
            TableRelation = "No. Series";
            DataClassification = CustomerContent;
            Caption = 'Posted Comm. Inv. No. Series';
        }
    }
    procedure CheckIBAN(IBANCode: Code[100])
    var
        Modulus97: Integer;
        I: Integer;
    begin
        if IBANCode = '' then exit;
        IBANCode:=DelChr(IBANCode);
        Modulus97:=97;
        if(StrLen(IBANCode) <= 5) or (StrLen(IBANCode) > 34)then IBANError;
        ConvertIBAN(IBANCode);
        while StrLen(IBANCode) > 6 do IBANCode:=CalcModulus(CopyStr(IBANCode, 1, 6), Modulus97) + CopyStr(IBANCode, 7);
        Evaluate(I, IBANCode);
        if(I mod Modulus97) <> 1 then IBANError;
    end;
    local procedure IBANError()
    begin
        Error(Text000);
    end;
    local procedure ConvertIBAN(var IBANCode: Code[100])
    var
        I: Integer;
    begin
        IBANCode:=CopyStr(IBANCode, 5) + CopyStr(IBANCode, 1, 4);
        I:=0;
        while I < StrLen(IBANCode)do begin
            I:=I + 1;
            if ConvertLetter(IBANCode, CopyStr(IBANCode, I, 1), I)then I:=0;
        end;
    end;
    local procedure CalcModulus(Number: Code[10]; Modulus97: Integer): Code[10]var
        I: Integer;
    begin
        Evaluate(I, Number);
        I:=I mod Modulus97;
        if I = 0 then exit('');
        exit(Format(I));
    end;
    local procedure ConvertLetter(var IBANCode: Code[100]; Letter: Code[1]; LetterPlace: Integer): Boolean var
        Letter2: Code[2];
    begin
        if(Letter >= 'A') and (Letter <= 'Z')then begin
            case Letter of 'A': Letter2:='10';
            'B': Letter2:='11';
            'C': Letter2:='12';
            'D': Letter2:='13';
            'E': Letter2:='14';
            'F': Letter2:='15';
            'G': Letter2:='16';
            'H': Letter2:='17';
            'I': Letter2:='18';
            'J': Letter2:='19';
            'K': Letter2:='20';
            'L': Letter2:='21';
            'M': Letter2:='22';
            'N': Letter2:='23';
            'O': Letter2:='24';
            'P': Letter2:='25';
            'Q': Letter2:='26';
            'R': Letter2:='27';
            'S': Letter2:='28';
            'T': Letter2:='29';
            'U': Letter2:='30';
            'V': Letter2:='31';
            'W': Letter2:='32';
            'X': Letter2:='33';
            'Y': Letter2:='34';
            'Z': Letter2:='35';
            end;
            if LetterPlace = 1 then IBANCode:=Letter2 + CopyStr(IBANCode, 2)
            else
            begin
                if LetterPlace = StrLen(IBANCode)then IBANCode:=CopyStr(IBANCode, 1, LetterPlace - 1) + Letter2
                else
                    IBANCode:=CopyStr(IBANCode, 1, LetterPlace - 1) + Letter2 + CopyStr(IBANCode, LetterPlace + 1);
            end;
            exit(true);
        end;
        if(Letter >= '0') and (Letter <= '9')then exit(false);
        IBANError;
    end;
    var Text000: label 'The number you entered is not a valid IBAN.';
    Text001: label 'File Location for IC files';
}
