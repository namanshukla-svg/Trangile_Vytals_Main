tableextension 50084 "SSD Sales Header" extends "Sales Header"
{
    fields
    {
        modify("Sell-to Customer No.")
        {
            trigger OnAfterValidate()
            var
                Cust: record Customer;
            begin
                Cust := GetCust("Sell-to Customer No.");
                Cust.TESTFIELD("Freight Zone");
                if "Document Type" = "Document Type"::Order then begin
                    "Delivery Resp. Name" := Cust."Delivery Resp. Name";
                    "Delivery Resp. Contact No." := copystr(Cust."Delivery Resp. Contact No.", 1, 35);
                    "SPD/Sample Order" := Cust."SSD Sample Customer";
                end;
                "Cust EMail" := Cust."E-Mail";
                "Freight Zone" := Cust."Freight Zone";
                VALIDATE("Customer Road Permit No.", 'NA');
                //"Applied to Insurance Policy" := '272102/21/2009/5'; //SSDU
                VALIDATE("Responsibility Center");
                VALIDATE("Location Code", Cust."Location Code");
                if FORMAT(Cust."Shipping Time") <> '' then "Expected Delivery Date" := CALCDATE(Cust."Shipping Time", "Posting Date");
            end;
        }
        //SSD_Sunil
        modify("No.")
        {
            trigger OnAfterValidate()
            begin
                IF "No." <> xRec."No." THEN BEGIN
                    SalesSetup.GET;
                    NoSeriesMgt.TestManual(GetNoSeriesCode);
                    "No. Series" := '';
                END;
            end;
        }
        modify("Posting Date")
        {
            trigger OnAfterValidate()
            var
                Cust: record Customer;
            begin
                Cust := GetCust("Sell-to Customer No.");
                if FORMAT(Cust."Shipping Time") <> '' then "Expected Delivery Date" := CALCDATE(Cust."Shipping Time", "Posting Date");
            end;
        }
        modify("Applies-to Doc. No.")
        {
            trigger OnAfterValidate()
            begin
                IF (Rec."Amazon Invoice/Credit Memo" <> TRUE) THEN IF "Applies-to Doc. No." <> '' THEN "Applies-to ID" := '';
            end;
        }
        field(50001; "Ref. Doc. Subtype"; Option)
        {
            Description = 'CF002';
            OptionCaption = ' ,Sales Order,Sales Schedule';
            OptionMembers = " ","Sales Order","Sales Schedule";
            DataClassification = CustomerContent;
            Caption = 'Ref. Doc. Subtype';
        }
        field(50002; "Amendment Required"; Boolean)
        {
            Description = 'CF002';
            DataClassification = CustomerContent;
            Caption = 'Amendment Required';
        }
        field(50003; "Enquiry No."; Code[20])
        {
            Description = 'CF002';
            DataClassification = CustomerContent;
            Caption = 'Enquiry No.';
        }
        field(50004; "ST38 No"; Code[20])
        {
            Description = 'Alle VPB';
            DataClassification = CustomerContent;
            Caption = 'ST38 No';
        }
        field(50005; "Customer Road Permit No."; Code[20])
        {
            Description = 'Alle VPB';
            DataClassification = CustomerContent;
            Caption = 'Customer Road Permit No.';
        }
        field(50006; crminsertflag; Boolean)
        {
            Description = 'TRI';
            DataClassification = CustomerContent;
            Caption = 'crminsertflag';
        }
        field(50007; crmupdateflag; Boolean)
        {
            Description = 'TRI';
            DataClassification = CustomerContent;
            Caption = 'crmupdateflag';
        }
        field(50008; isCRMexception; Boolean)
        {
            Description = 'TRI';
            DataClassification = CustomerContent;
            Caption = 'isCRMexception';
        }
        field(50009; exceptiondetail; Text[190])
        {
            Description = 'TRI';
            DataClassification = CustomerContent;
            Caption = 'exceptiondetail';
        }
        field(50010; crmRelease; Boolean)
        {
            Description = 'TRI';
            DataClassification = CustomerContent;
            Caption = 'crmRelease';
        }
        field(50011; "Price Match/Mismatch"; Boolean)
        {
            CalcFormula = - exist("Sales Line" where("Document Type" = field("Document Type"), "Document No." = field("No."), "Price Match/Mismatch" = filter(false)));
            Description = 'Alle';
            Editable = false;
            FieldClass = FlowField;
            Caption = 'Price Match/Mismatch';
        }
        field(50013; "Serial No."; Code[30])
        {
            Description = 'Alle_240119';
            DataClassification = CustomerContent;
            Caption = 'Serial No.';
        }
        field(50014; "MRP No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'MRP No.';
        }
        field(50077; "Vessel/Flight No."; Code[20])
        {
            Description = 'CE001(Change Lenght 10 to 20)';
            DataClassification = CustomerContent;
            Caption = 'Vessel/Flight No.';
        }
        field(50078; "Expected Delivery Date"; Date)
        {
            Description = 'Alle-MS';
            DataClassification = CustomerContent;
            Caption = 'Expected Delivery Date';

            trigger OnValidate()
            begin
                if "Document Type" = "document type"::Invoice then if "Expected Delivery Date" < "Posting Date" then Error('Expected Delivery Date can not be less than posting date');
            end;
        }
        field(50079; "Actual Delivery Date"; Date)
        {
            Description = 'Alle-MS';
            DataClassification = CustomerContent;
            Caption = 'Actual Delivery Date';
        }
        field(50093; "Total Packed Wt."; Decimal)
        {
            CalcFormula = sum("SSD Sales Schedule Buffer"."Actual Weight" where("Document Type" = field("Document Type"), "Document No." = field("No."), "Sell-to Customer No." = field("Sell-to Customer No.")));
            Description = 'CF001';
            Editable = false;
            FieldClass = FlowField;
            Caption = 'Total Packed Wt.';
        }
        field(50100; Subcontracting; Boolean)
        {
            Description = 'CML-034';
            DataClassification = CustomerContent;
            Caption = 'Subcontracting';
        }
        field(50101; "Part No."; Code[25])
        {
            Description = 'ssd/Alle-[Amazon-HG]-EndCustName';
            Editable = false;
            FieldClass = Normal;
            DataClassification = CustomerContent;
            Caption = 'Part No.';
        }
        field(50300; "Created Date Time"; Text[20])
        {
            Description = 'ALLE-NM 04072019';
            DataClassification = CustomerContent;
            Caption = 'Created Date Time';
        }
        field(52006; "Document Subtype"; Option)
        {
            Description = 'CF001';
            OptionCaption = ' ,Sales,Contract,Service Contract,Order,Schedule,Invoice,Despatch,Suplementary Invoice';
            OptionMembers = " ",Sales,Contract,"Service Contract","Order",Schedule,Invoice,Despatch,"Suplementary Invoice";
            DataClassification = CustomerContent;
            Caption = 'Document Subtype';
        }
        field(53009; "External Doc. Date"; Date)
        {
            Description = 'CF001';
            DataClassification = CustomerContent;
            Caption = 'External Doc. Date';
        }
        field(53065; "Order/Scd. No."; Code[20])
        {
            Description = 'CF002 Ref. Doc No.';
            DataClassification = CustomerContent;
            Caption = 'Order/Scd. No.';
        }
        field(53068; "Get Despatch Used"; Boolean)
        {
            Caption = 'Get Despatch Used';
            Description = 'CF002';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(53085; "GR No."; Code[10])
        {
            Description = 'CF001';
            DataClassification = CustomerContent;
            Caption = 'GR No.';
        }
        field(53086; "GR Date"; Date)
        {
            Description = 'CF001';
            DataClassification = CustomerContent;
            Caption = 'GR Date';
        }
        field(53088; Insurance; Option)
        {
            Description = 'CF001';
            OptionCaption = ',Insurance Prepaid, Insurance Buyer''s Account, Insurance Seller''s Account';
            OptionMembers = ,"Insurance Prepaid"," Insurance Buyer's Account"," Insurance Seller's Account";
            DataClassification = CustomerContent;
            Caption = 'Insurance';
        }
        field(53089; "RFQ/Enquiry No"; Code[20])
        {
            Enabled = false;
            DataClassification = CustomerContent;
            Caption = 'RFQ/Enquiry No';
        }
        field(55006; "RGP Receipt No."; Code[20])
        {
            Description = 'CEN004.05';
            TableRelation = "SSD RGP Receipt Header"."No." where("Party No." = field("Sell-to Customer No."));
            DataClassification = CustomerContent;
            Caption = 'RGP Receipt No.';
        }
        field(60000; "Excise Invoice No."; Code[10])
        {
            Description = 'CF001';
            DataClassification = CustomerContent;
            Caption = 'Excise Invoice No.';

            trigger OnValidate()
            begin
                "Excise Invoice Date" := WorkDate;
            end;
        }
        field(60001; "Excise Invoice Date"; Date)
        {
            Description = 'CF001';
            DataClassification = CustomerContent;
            Caption = 'Excise Invoice Date';
        }
        field(60002; "Excise Invoice No. Series"; Code[20])
        {
            Description = 'CF001';
            TableRelation = "No. Series";
            DataClassification = CustomerContent;
            Caption = 'Excise Invoice No. Series';

            trigger OnValidate()
            begin
                "Excise Invoice Date" := WorkDate;
                //"VAT Form" := 'VAT-D1';
            end;
        }
        field(60006; "DI No."; Code[20])
        {
            Description = 'CE_AA002';
            TableRelation = "SSD NAGARE"."NAGARE No." where("Cusomer Code" = field("Sell-to Customer No."));
            ValidateTableRelation = false;
            DataClassification = CustomerContent;
            Caption = 'DI No.';

            trigger OnValidate()
            begin
                RecNagare.Reset;
                RecNagare.SetCurrentkey("NAGARE No.");
                RecNagare.SetRange(RecNagare."NAGARE No.", "DI No.");
                RecNagare.SetRange(RecNagare."Manual Despatch", true);
                if RecNagare.FindFirst then begin
                    "DI Date" := RecNagare.Date;
                    "Delivery Location" := RecNagare."US Loc";
                    "Delivery Time" := RecNagare.Time;
                    "Ref. Doc. Subtype" := 1;
                    "Order/Scd. No." := RecNagare."Order No.";
                    //ItemEnagare:=RecNagare."Item No.";
                    //DespatchSLip(ItemEnagare);
                    DespatchSLip(RecNagare);
                    Modify;
                end;
                if "DI No." = '' then begin
                    "DI Date" := 0D;
                    "Delivery Location" := '';
                    "Delivery Time" := 0T;
                    Validate("Ref. Doc. Subtype", 0);
                    Validate("Order/Scd. No.", '');
                end;
            end;
        }
        field(60007; "DI Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'DI Date';
        }
        field(60008; "Delivery Location"; Code[20])
        {
            Description = 'Alle-[Amazon-HG]-Deactivate';
            Enabled = false;
            DataClassification = CustomerContent;
            Caption = 'Delivery Location';
        }
        field(60009; "Delivery Time"; Time)
        {
            DataClassification = CustomerContent;
            Caption = 'Delivery Time';
        }
        field(60010; "Usage Location"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Usage Location';
        }
        field(60011; "Nagare Item Type"; Option)
        {
            OptionCaption = ' ,DI SPARES,ENAGARE';
            OptionMembers = " ","DI SPARES",ENAGARE;
            DataClassification = CustomerContent;
            Caption = 'Nagare Item Type';
        }
        field(60043; Supplementary; Boolean)
        {
            Description = 'Supplementary';
            DataClassification = CustomerContent;
            Caption = 'Supplementary';

            trigger OnValidate()
            var
                SalesLineRec: Record "Sales Line";
                ItemRec: Record Item;
            begin
                //Supplementary_Start
                if not Supplementary then begin
                    SalesLineRec.Reset;
                    SalesLineRec.SetRange("Document Type", "Document Type");
                    SalesLineRec.SetRange("Document No.", "No.");
                    SalesLineRec.SetRange(Type, SalesLineRec.Type::"Charge (Item)");
                    if SalesLineRec.FindFirst then begin
                        SalesLineRec."Tax Group Code" := '';
                        SalesLineRec."VAT Prod. Posting Group" := '';
                        SalesLineRec."Gen. Prod. Posting Group" := '';
                        SalesLineRec.Modify;
                    end;
                    "Supplementary Rate" := 0;
                    "Supplementary Item" := '';
                    "Supplementary Start Date" := 0D;
                    "Supplementary End Date" := 0D;
                end;
                //Supplementary_End
            end;
        }
        field(60044; "Supplementary Rate"; Decimal)
        {
            Description = 'Supplementary';
            DataClassification = CustomerContent;
            Caption = 'Supplementary Rate';

            trigger OnValidate()
            begin
                //Supplementary_Start
                if not Supplementary then Error('It is not a Supplementary Invoice');
                //Supplementary_End
            end;
        }
        field(60045; "Supplementary Item"; Code[20])
        {
            Description = 'Supplementary';
            TableRelation = Item."No.";
            DataClassification = CustomerContent;
            Caption = 'Supplementary Item';

            trigger OnValidate()
            var
                SalesLineRec: Record "Sales Line";
                ItemRec: Record Item;
            begin
                //Supplementary_Start
                "Supplementary Start Date" := 0D;
                "Supplementary End Date" := 0D;
                "Supplementary PO Item" := '';
                "Supplementary Rate" := 0;
                if Supplementary then begin
                    SalesLineRec.Reset;
                    SalesLineRec.SetRange("Document Type", "Document Type");
                    SalesLineRec.SetRange("Document No.", "No.");
                    SalesLineRec.SetRange(Type, SalesLineRec.Type::"Charge (Item)");
                    if SalesLineRec.FindFirst then
                        if ItemRec.Get("Supplementary Item") then begin
                            SalesLineRec.Validate("Tax Group Code", ItemRec."Tax Group Code");
                            SalesLineRec.Validate("VAT Prod. Posting Group", ItemRec."VAT Prod. Posting Group");
                            SalesLineRec.Validate("Gen. Prod. Posting Group", ItemRec."Gen. Prod. Posting Group");
                            SalesLineRec.Modify;
                        end;
                end
                else
                    Error('It is not a Supplementary Invoice');
                //Supplementary_End
                POLine.SetCurrentkey("No.", "Document Type", "Sell-to Customer No.", "Posting Date");
                POLine.SetRange(POLine."No.", "Supplementary Item");
                POLine.SetFilter(POLine."Document Type", '<>%1', POLine."document type"::Invoice);
                POLine.SetFilter(POLine."Document Subtype", '<>%1', POLine."document subtype"::Despatch);
                POLine.SetRange(POLine."Sell-to Customer No.", "Sell-to Customer No.");
                if POLine.FindSet then
                    repeat
                        SuppPOLine.Init;
                        SuppPOLine.TransferFields(POLine);
                        SuppPOLine.Insert;
                    until POLine.Next = 0;
                AcrchivePOLine.SetCurrentkey("Document Type", "Sell-to Customer No.", Type, "No.");
                AcrchivePOLine.SetFilter(AcrchivePOLine."Document Type", '<>%1', AcrchivePOLine."document type"::Invoice);
                AcrchivePOLine.SetFilter(AcrchivePOLine."Document Subtype", '<>%1', AcrchivePOLine."document subtype"::Despatch);
                AcrchivePOLine.SetRange(AcrchivePOLine."Sell-to Customer No.", "Sell-to Customer No.");
                AcrchivePOLine.SetRange(AcrchivePOLine.Type, AcrchivePOLine.Type::Item);
                AcrchivePOLine.SetRange(AcrchivePOLine."No.", "Supplementary Item");
                if AcrchivePOLine.FindSet then
                    repeat
                        SuppPOLine.Init;
                        SuppPOLine.TransferFields(AcrchivePOLine);
                        SuppPOLine.Insert;
                    until AcrchivePOLine.Next = 0;
            end;
        }
        field(60046; "Supplementary Start Date"; Date)
        {
            Description = 'Supplementary';
            DataClassification = CustomerContent;
            Caption = 'Supplementary Start Date';

            trigger OnValidate()
            begin
                //Supplementary_Start
                if not Supplementary then Error('It is not a Supplementary Invoice');
                //Supplementary_End
            end;
        }
        field(60047; "Supplementary End Date"; Date)
        {
            Description = 'Supplementary';
            DataClassification = CustomerContent;
            Caption = 'Supplementary End Date';

            trigger OnValidate()
            begin
                //Supplementary_Start
                if not Supplementary then Error('It is not a Supplementary Invoice');
                //Supplementary_End
            end;
        }
        field(60048; "Supplementary PO Item"; Code[20])
        {
            Description = 'Supplementary';
            Enabled = false;
            TableRelation = "SSD Supplementary Sales Lines"."Document No.";
            DataClassification = CustomerContent;
            Caption = 'Supplementary PO Item';

            trigger OnValidate()
            var
                SuppSalesHeader: Record "Sales Header";
            begin
                SuppPO.SetRange(SuppPO."Supplementary Rate", true);
                if SuppPO.FindFirst then begin
                    "Supplementary Rate" := SuppPO."Unit Price";
                    if SuppSalesHeader.Get(SuppPO."Document Type", SuppPO."Document No.") then "Supplementary Start Date" := SuppPO."Effective Date";
                    "Supplementary End Date" := SuppPO."Expiry Date";
                end;
                Modify;
                if POSupplmentary.FindFirst then POSupplmentary.DeleteAll(true);
            end;
        }
        field(60049; "Effective Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Effective Date';

            trigger OnValidate()
            var
                LocalSalesLine: Record "Sales Line";
            begin
                //>>All_AA_Supp
                LocalSalesLine.Reset;
                LocalSalesLine.SetCurrentkey("Document Type", "Sell-to Customer No.", "No.");
                LocalSalesLine.SetRange(LocalSalesLine."Document Type", "Document Type");
                LocalSalesLine.SetRange(LocalSalesLine."Sell-to Customer No.", "Sell-to Customer No.");
                LocalSalesLine.SetRange(LocalSalesLine."Document No.", "No.");
                if LocalSalesLine.FindSet then
                    repeat
                        LocalSalesLine."Effective Date" := "Effective Date";
                        LocalSalesLine.Modify;
                    until LocalSalesLine.Next = 0;
                //Alle_AA_Supp
            end;
        }
        field(60050; "Expiry Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Expiry Date';

            trigger OnValidate()
            var
                LocalSalesLine: Record "Sales Line";
            begin
                //>>All_AA_Supp
                LocalSalesLine.Reset;
                LocalSalesLine.SetCurrentkey("Document Type", "Sell-to Customer No.", "No.");
                LocalSalesLine.SetRange(LocalSalesLine."Document Type", "Document Type");
                LocalSalesLine.SetRange(LocalSalesLine."Sell-to Customer No.", "Sell-to Customer No.");
                LocalSalesLine.SetRange(LocalSalesLine."Document No.", "No.");
                if LocalSalesLine.FindSet then
                    repeat
                        LocalSalesLine."Expiry Date" := "Expiry Date";
                        LocalSalesLine.Modify;
                    until LocalSalesLine.Next = 0;
                //Alle_AA_Supp
            end;
        }
        field(60080; "Comm. Inv. No. Series"; Code[10])
        {
            Editable = false;
            TableRelation = "No. Series";
            DataClassification = CustomerContent;
            Caption = 'Comm. Inv. No. Series';
        }
        field(60081; "ARE1 No. Series"; Code[10])
        {
            Editable = false;
            TableRelation = "No. Series";
            DataClassification = CustomerContent;
            Caption = 'ARE1 No. Series';
        }
        field(60082; "Commercial Invoice No."; Code[20])
        {
            Editable = true;
            DataClassification = CustomerContent;
            Caption = 'Commercial Invoice No.';
        }
        field(60083; "ARE 1 No."; Code[20])
        {
            Editable = false;
            DataClassification = CustomerContent;
            Caption = 'ARE 1 No.';
        }
        field(70000; "Schedule Month"; Option)
        {
            OptionCaption = ', ,JAN,FEB,MAR,APR,MAY,JUN,JUL,AUG,SEP,OCT,NOV,DEC';
            OptionMembers = ," ",JAN,FEB,MAR,APR,MAY,JUN,JUL,AUG,SEP,OCT,NOV,DEC;
            DataClassification = CustomerContent;
            Caption = 'Schedule Month';
        }
        field(70010; Freight; Option)
        {
            OptionCaption = ',Freight Prepaid, Freight Buyer''s Account, Freight Seller''s Account, Freight to be Paid';
            OptionMembers = ,"Freight Prepaid"," Freight Buyer's Account"," Freight Seller's Account"," Freight to be Paid";
            DataClassification = CustomerContent;
            Caption = 'Freight';
        }
        field(70011; "PF Charges"; Option)
        {
            OptionMembers = " ","Inclusive in Price","Not Inclusive in Price";
            DataClassification = CustomerContent;
            Caption = 'PF Charges';
        }
        field(70012; "Time Schedule"; Time)
        {
            CalcFormula = lookup("Sales Line"."Despatch Time" where("Document Type" = field("Document Type"), "Document No." = field("No."), "Sell-to Customer No." = field("Sell-to Customer No.")));
            Description = 'CE_AA001';
            FieldClass = FlowField;
            Caption = 'Time Schedule';
        }
        field(70013; "JBM Position"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'JBM Position';
        }
        field(70014; "JBM Contract"; Text[30])
        {
            DataClassification = CustomerContent;
            Caption = 'JBM Contract';
        }
        field(70200; "Structure Calculated"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Structure Calculated';
        }
        field(70201; "Statistics Checked"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Statistics Checked';
        }
        field(70202; Sapres; Boolean)
        {
            Description = 'CE_AA007.05';
            DataClassification = CustomerContent;
            Caption = 'Sapres';
        }
        field(70203; "Weightment Bill No."; Code[20])
        {
            Description = 'PT - Deepika.V - 26/12/08';
            DataClassification = CustomerContent;
            Caption = 'Weightment Bill No.';
        }
        field(70204; "Weightment Bill Date"; Date)
        {
            Description = 'PT - Deepika.V - 26/12/08';
            DataClassification = CustomerContent;
            Caption = 'Weightment Bill Date';
        }
        field(75000; "Applied to Insurance Policy"; Code[30])
        {
            Description = 'ALLE 2.09';
            //InitValue = '272102/21/2009/5'; //SSDU
            DataClassification = CustomerContent;
            Caption = 'Applied to Insurance Policy';

            trigger OnLookup()
            begin
                //ALLE 2.09 >>
                InsuranceRec.Reset;
                InsuranceRec.SetCurrentkey("Policy Status", "Insurance Starting Date", "Insurance Expiry Date");
                InsuranceRec.SetRange("Policy Status", InsuranceRec."policy status"::Active);
                InsuranceRec.SetFilter(InsuranceRec."Insurance Starting Date", '<=%1', "Posting Date");
                InsuranceRec.SetFilter(InsuranceRec."Insurance Expiry Date", '>=%1', "Posting Date");
                if InsuranceRec.FindFirst then begin
                    if Page.RunModal(Page::"SSD Insurance Card Form", InsuranceRec, InsuranceRec."Insurance Policy No.") = Action::LookupOK then Validate("Applied to Insurance Policy", InsuranceRec."Insurance Policy No.");
                end;
                //ALLE 2.09 >>
            end;

            trigger OnValidate()
            begin
                //ALLE 2.09 >>
                if InsuranceRec.Get("Applied to Insurance Policy") then begin
                    Slinerec.Reset;
                    Slinerec.SetRange("Document No.", "No.");
                    Slinerec.SetFilter("No.", '<>%1', '');
                    if Slinerec.FindFirst then AmtToCust := 0;
                    repeat
                        AmtToCust += Slinerec."Amount"; //SSD to check "Amount to Customer"
                    until Slinerec.Next = 0;
                    //MESSAGE('%1',AmtToCust);
                    if AmtToCust > InsuranceRec."Balance Amount" then Error('Available Amount In Insurance Policy %1 is %2', InsuranceRec."Insurance Policy No.", InsuranceRec."Balance Amount");
                end;
            end;
        }
        field(75001; "Freight Zone"; Code[20])
        {
            Description = 'ALLE 3.08';
            Editable = false;
            TableRelation = "SSD Freight Zone";
            DataClassification = CustomerContent;
            Caption = 'Freight Zone';
        }
        field(80000; "Place of Receipt by Pre-carr"; Text[30])
        {
            DataClassification = CustomerContent;
            Caption = 'Place of Receipt by Pre-carr';
        }
        field(80001; "Port of Lading"; Text[30])
        {
            DataClassification = CustomerContent;
            Caption = 'Port of Lading';
        }
        field(80002; "Port of Discharge"; Text[30])
        {
            DataClassification = CustomerContent;
            Caption = 'Port of Discharge';
        }
        field(80003; "Final Destination"; Text[30])
        {
            DataClassification = CustomerContent;
            Caption = 'Final Destination';
        }
        field(80004; "57F4 No."; Code[20])
        {
            Description = 'ssd';
            DataClassification = CustomerContent;
            Caption = '57F4 No.';
        }
        field(80005; "57F4 Date"; Date)
        {
            Description = 'ssd';
            DataClassification = CustomerContent;
            Caption = '57F4 Date';
        }
        field(80006; "Job Work Invoice"; Boolean)
        {
            Description = 'ssd';
            DataClassification = CustomerContent;
            Caption = 'Job Work Invoice';
        }
        field(85000; "Completely Closed"; Boolean)
        {
            Description = 'ALLE 3.29';
            DataClassification = CustomerContent;
            Caption = 'Completely Closed';
        }
        field(85001; ARE1; Boolean)
        {
            Description = 'ALLE 3.14';
            DataClassification = CustomerContent;
            Caption = 'ARE1';
        }
        field(85002; "Excise Bus Posting Group(ADE)"; Code[10])
        {
            Description = 'ALLE 3.14';
            DataClassification = CustomerContent;
            Caption = 'Excise Bus Posting Group(ADE)';
        }
        field(85003; CT2; Boolean)
        {
            Description = 'ALLE 3.15';
            DataClassification = CustomerContent;
            Caption = 'CT2';
        }
        field(85004; "CT2 Form"; Code[20])
        {
            Description = 'ALLE 3.15';
            DataClassification = CustomerContent;
            Caption = 'CT2 Form';
        }
        field(85005; "Customer Order Date"; Date)
        {
            Description = 'ALLE 3.15';
            DataClassification = CustomerContent;
            Caption = 'Customer Order Date';
        }
        field(85006; CT3; Boolean)
        {
            Description = 'ALLE 3.16';
            DataClassification = CustomerContent;
            Caption = 'CT3';
        }
        field(85007; "CT3 Form"; Code[20])
        {
            Description = 'ALLE 3.16';
            DataClassification = CustomerContent;
            Caption = 'CT3 Form';
        }
        field(85011; "Supplementary Invoice"; Boolean)
        {
            Description = 'ALLE[551]';
            DataClassification = CustomerContent;
            Caption = 'Supplementary Invoice';
        }
        field(85012; "Commercial Invoice"; Boolean)
        {
            Description = 'ALLE[551]';
            DataClassification = CustomerContent;
            Caption = 'Commercial Invoice';
        }
        field(85013; "Customer Order No."; Code[20])
        {
            Description = 'BIS 1145';
            DataClassification = CustomerContent;
            Caption = 'Customer Order No.';
        }
        field(85014; "Customer Quote No."; Code[100])
        {
            Description = 'BIS 1145/Alle-[Amazon-HG]-EndCustaddres';
            DataClassification = CustomerContent;
            Caption = 'Customer Quote No.';
        }
        field(85017; "Cust EMail"; Text[80])
        {
            DataClassification = CustomerContent;
            Caption = 'Cust EMail';
        }
        field(85018; "Order Confirmation Mail Send"; Boolean)
        {
            Description = 'OC1.0';
            Editable = true;
            DataClassification = CustomerContent;
            Caption = 'Order Confirmation Mail Send';
        }
        field(85020; "Delivery Resp. Name"; Text[30])
        {
            Description = 'BS20122016';
            DataClassification = CustomerContent;
            Caption = 'Delivery Resp. Name';
        }
        field(85021; "Delivery Resp. Contact No."; Text[35])
        {
            Description = 'BS20122016';
            DataClassification = CustomerContent;
            Caption = 'Delivery Resp. Contact No.';
        }
        field(85022; "SPD/Sample Order"; Boolean)
        {
            Description = 'BS20122016';
            DataClassification = CustomerContent;
            Caption = 'SPD/Sample Order';
        }
        field(85034; "Amazon Invoice/Credit Memo"; Boolean)
        {
            Description = 'Alle-[Amazon-HG]';
            Editable = false;
            DataClassification = CustomerContent;
            Caption = 'Amazon Invoice/Credit Memo';
        }
        //SSDU
        field(85035; "Type of Invoice"; Enum "Type Of Invoice Sales")
        {
            Caption = 'Type of Invoice';

            trigger OnValidate()
            begin
                if ("Type of Invoice" <> "Type of Invoice"::" ") then
                    case "Type of Invoice" of
                        "Type of Invoice"::Supplementary:
                            Validate("Supplementary Invoice", true);
                        "Type of Invoice"::Commercial:
                            Validate("Commercial Invoice", true);
                        "Type of Invoice"::Amazon:
                            Validate("Amazon Invoice/Credit Memo");
                    end;
            end;
        }
        //IG_DS
        field(85042; "Count Reopen"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(85043; "Count Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(85044; "Hold-Dispatch"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(85045; "Released Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        //IG_DS
    }
    trigger OnBeforeDelete()
    var
        UserSetup: Record "User Setup";
        SalesLine: Record "Sales Line";
    begin
        UserSetup.GET(USERID);
        IF UserSetup."Sales Order Delete" THEN BEGIN
            SalesLine.RESET;
            SalesLine.SETRANGE("Document Type", RecSalesLine."Document Type"::Order);
            SalesLine.SETRANGE("Document No.", "No.");
            SalesLine.SETRANGE(Type, SalesLine.Type::Item);
            SalesLine.SetFilter("Quantity Shipped", '<>%1', 0);
            IF SalesLine.FindFirst() THEN Error('Sales Order can not be delete');
        END
        ELSE
            Error('you are not authorized delete sales order');
    end;

    trigger OnInsert()
    begin
        "Transport Method" := 'SURFACE';
        "Created Date Time" := Format(CurrentDateTime);
    end;

    procedure DespatchSLip(var Enagare: Record "SSD NAGARE")
    var
        SalesHeader: Record "Sales Header";
        SalesLine: Record "Sales Line";
        NoSeries: Codeunit "No. Series";//IG_DSNoSeriesManagement;
        NextNo: Code[20];
        ResponsibityCenter: Record "Responsibility Center";
        DespatchSlipNo: Code[20];
        SalesScheduleBuffer: Record "SSD Sales Schedule Buffer";
        ReleaseSalesDocument: Codeunit "Release Sales Document";
    begin
        SalesLine.SetRange(SalesLine."Document No.", "No.");
        SalesLine.SetRange(SalesLine."Document Type", "Document Type");
        SalesLine.SetRange(SalesLine."Sell-to Customer No.", "Sell-to Customer No.");
        if SalesLine.FindFirst then SalesLine.DeleteAll;
        Commit;
        SalesScheduleBuffer.SetRange(SalesScheduleBuffer."Document Type", "Document Type");
        SalesScheduleBuffer.SetRange(SalesScheduleBuffer."Document No.", "No.");
        SalesScheduleBuffer.SetRange(SalesScheduleBuffer."Sell-to Customer No.", "Sell-to Customer No.");
        SalesScheduleBuffer.SetRange(SalesScheduleBuffer."Item No.", Enagare."Item No.");
        SalesScheduleBuffer.SetRange(SalesScheduleBuffer."Line No.", 10000);
        if SalesScheduleBuffer.FindFirst then SalesScheduleBuffer.DeleteAll;
        Commit;
        Enagare.SetRange(Enagare."NAGARE No.", "DI No.");
        Enagare.SetRange(Enagare.Date, "DI Date");
        Enagare.SetRange(Enagare.Time, "Delivery Time");
        if Enagare.FindFirst then begin
            RecSalesLine.SetRange(RecSalesLine."Sell-to Customer No.", "Sell-to Customer No.");
            RecSalesLine.SetRange(RecSalesLine."Document Type", 1);
            RecSalesLine.SetRange(RecSalesLine."Document Subtype", 4);
            RecSalesLine.SetRange(RecSalesLine."No.", Enagare."Item No.");
            //RecSalesLine.SETRANGE(RecSalesLine."No.",Enagare."NAGARE No.");
            if RecSalesLine.FindFirst then begin
                SalesOrder.SetRange(SalesOrder."Document Type", RecSalesLine."Document Type");
                SalesOrder.SetRange(SalesOrder."No.", RecSalesLine."Document No.");
                if SalesOrder.FindFirst then begin
                    Status := 0;
                    "Ref. Doc. Subtype" := 1;
                    "Order/Scd. No." := RecSalesLine."Document No.";
                    Modify;
                end;
                SalesLine.Init;
                SalesLine.TransferFields(RecSalesLine);
                // SalesLine."Total Schedule Quantity":=RecSalesLine."Schedule Quantity";
                //  SalesLine."Outstanding Quantity":=0;
                SalesLine."Qty. to Invoice" := 0;
                SalesLine."Quantity Shipped" := 0;
                SalesLine."Quantity Invoiced" := 0;
                SalesLine."Qty. to Invoice" := 0;
                SalesLine."Qty. to Ship" := 0;
                SalesLine."Total Schedule Quantity" := RecSalesLine."Qty. to Ship";
                SalesLine.Quantity := 0;
                SalesLine."Outstanding Quantity" := 0;
                SalesLine."Quantity (Base)" := 0;
                SalesLine."Outstanding Qty. (Base)" := 0;
                SalesLine."Qty. to Invoice (Base)" := 0;
                SalesLine."Qty. to Ship (Base)" := 0;
                SalesLine."Qty. Shipped Not Invd. (Base)" := 0;
                SalesLine."Qty. Shipped (Base)" := 0;
                SalesLine."Qty. Invoiced (Base)" := 0;
                SalesLine."Order No." := RecSalesLine."Document No.";
                SalesLine."Order Line No." := RecSalesLine."Line No.";
                //SalesLine."Total Schedule Quantity":=0;
                SalesLine."Document No." := "No.";
                SalesLine."Document Type" := "Document Type";
                SalesLine."Document Subtype" := 7;
                SalesLine."Line No." := 10000;
                SalesLine."Despatch Time" := Enagare.Time;
                SalesLine.Validate(SalesLine.Quantity, Enagare.Quantity);
                SalesLine.Validate(SalesLine."Qty. to Ship", Enagare.Quantity);
                SalesLine.Validate(SalesLine."Shortcut Dimension 1 Code", RecSalesLine."Shortcut Dimension 1 Code");
                SalesLine.Validate(SalesLine."Shortcut Dimension 2 Code", RecSalesLine."Shortcut Dimension 2 Code");
                SalesLine.Validate(SalesLine."Planned Delivery Date", Enagare.Date);
                SalesLine.Validate(SalesLine."Planned Shipment Date", Enagare.Date);
                SalesLine.Validate(SalesLine."Shipment Date", Enagare.Date);
                SalesLine.Insert;
                Commit;
            end;
        end;
    end;

    procedure CreateSalesLineCust()
    begin
        //ALLE 3.15
        CT2Line.Reset;
        CT2Line.SetRange("CT2 Document No.", CT2Header."CT2 No.");
        CT2Line.SetFilter("Balance Quantity", '<>%1', 0);
        if CT2Line.FindFirst then SalesLRec.Init;
        repeat
            SalesLRec1.Reset;
            SalesLRec1.SetCurrentkey("Document Type", "Document No.", "Line No.");
            SalesLRec1.SetRange("Document Type", "Document Type");
            SalesLRec1.SetRange("Document No.", "No.");
            if SalesLRec1.FindLast then
                LineNo := SalesLRec1."Line No."
            else
                LineNo := 0;
            LineNo += 10000;
            SalesLRec.Validate("Document Type", "Document Type");
            SalesLRec.Validate("Document No.", "No.");
            SalesLRec.Validate("Line No.", LineNo);
            SalesLRec.Validate(Type, SalesLRec.Type::Item);
            SalesLRec.Validate("No.", CT2Line."Item No.");
            SalesLRec.Validate("Location Code", "Location Code");
            SalesLRec.Validate("Unit of Measure Code", CT2Line.UOM);
            SalesLRec.Validate(Quantity, CT2Line."Balance Quantity");
            SalesLRec."Customer Document No." := "Customer Order No.";
            SalesLRec."Customer Document Date" := "Customer Order Date";
            SalesLRec."CT2 Form" := CT2Line."CT2 Document No.";
            SalesLRec."CT2 Form Line No." := CT2Line."CT2 Line No.";
            SalesLRec.Insert(true);
        until CT2Line.Next = 0;
    end;

    var
        RecSalesLine: Record "Sales Line";
        SalesOrder: Record "Sales Header";
        RecNagare: Record "SSD NAGARE";
        POLine: Record "Sales Line";
        SuppPOLine: Record "SSD Supplementary Sales Lines";
        SuppPO: Record "SSD Supplementary Sales Lines";
        POSupplmentary: Record "SSD Supplementary Sales Lines";
        AcrchivePOLine: Record "Sales Line Archive";
        InsuranceRec: Record "SSD Insurance Setup";
        Slinerec: Record "Sales Line";
        CT2Header: Record "SSD CT2 Header";
        CT2Line: Record "SSD CT2 Line";
        SalesLRec: Record "Sales Line";
        SalesLRec1: Record "Sales Line";
        AmtToCust: Decimal;
        LineNo: Integer;
        SPDCnt: Integer;
        NoSeriesMgt: Codeunit "No. Series";//IG_DSNoSeriesManagement;
}
