TableExtension 50086 "SSD Sales Invoice Header" extends "Sales Invoice Header"
{
    fields
    {
        modify("Shipping Agent Code")
        {
            trigger OnAfterValidate()
            begin
                "Actual Shipping Agent code" := "Shipping Agent Code";
            end;
        }
        modify("LR/RR No.")
        {
            trigger OnBeforeValidate()
            begin
                IF xRec."LR/RR No." <> '' THEN BEGIN
                    UserSetup.GET("User ID");
                    UserSetup.TESTFIELD("ALLow LR No.");
                    IF "LR/RR No." = '' THEN "LR/RR No." := xRec."LR/RR No.";
                END;
            end;
        }
        modify("LR/RR Date")
        {
            trigger OnBeforeValidate()
            begin
                IF xRec."LR/RR Date" <> 0D THEN BEGIN
                    UserSetup.GET("User ID");
                    UserSetup.TESTFIELD("ALLow LR No.");
                    IF "LR/RR Date" = 0D THEN ERROR('LR No. can not be blank');
                END;
                IF NOT ("LR/RR Date" >= "Document Date") THEN ERROR('LR/RR date always Greater than or equal to document date');
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
            //Atul::01122025
            Caption = 'Insert Status';
            //Atul::01122025;
        }
        field(50007; crmupdateflag; Boolean)
        {
            Description = 'TRI';
            DataClassification = CustomerContent;
            //Atul::01122025
            Caption = 'Update Status';
            //Atul::01122025
        }
        field(50008; isCRMexception; Boolean)
        {
            Description = 'TRI';
            DataClassification = CustomerContent;
            //Atul::01122025
            Caption = 'Exception Occurred';
            //Atul::01122025
        }
        field(50009; "exception detail"; Text[190])
        {
            Description = 'TRI';
            DataClassification = CustomerContent;
            Caption = 'exception detail';
        }
        field(50010; crmRelease; Boolean)
        {
            Description = 'TRI';
            DataClassification = CustomerContent;
            Caption = 'crmRelease';
        }
        field(50070; "Vendor Code"; Code[20])
        {
            Description = 'CF001';
            DataClassification = CustomerContent;
            Caption = 'Vendor Code';
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
        }
        field(50079; "Actual Delivery Date"; Date)
        {
            Description = 'Alle-MS';
            DataClassification = CustomerContent;
            Caption = 'Actual Delivery Date';
            Editable = true;

            trigger OnValidate()
            begin
                if not ("Actual Delivery Date" >= "LR/RR Date") then Error('Actual Delivery date always greater than LR/RR date');
            end;
        }
        field(50093; "Total Packed Wt."; Decimal)
        {
            Description = 'CF001';
            DataClassification = CustomerContent;
            Caption = 'Total Packed Wt.';
        }
        field(50099; "Remarks"; Text[100])
        {
            Caption = 'Remarks';
            DataClassification = SystemMetadata;
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
            DataClassification = CustomerContent;
            Caption = 'Part No.';
        }
        field(50200; "Dispatch Mail Send"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Dispatch Mail Send';
        }
        field(52000; "Amendment No."; Code[20])
        {
            Description = 'CF001';
            DataClassification = CustomerContent;
            Caption = 'Amendment No.';
        }
        field(52001; "Amendment Date"; Date)
        {
            Description = 'CF001';
            DataClassification = CustomerContent;
            Caption = 'Amendment Date';
        }
        field(52006; "Document Subtype"; Option)
        {
            Description = 'CF001';
            OptionCaption = ' ,Sales,Contract,Service Contract,Order,Schedule,Invoice,Despatch,Suplementary Invoice';
            OptionMembers = " ",Sales,Contract,"Service Contract","Order",Schedule,Invoice,Despatch,"Suplementary Invoice";
            DataClassification = CustomerContent;
            Caption = 'Document Subtype';
        }
        field(52009; "E-Way Bill Validity"; Text[30])
        {
            Description = 'Alle-[E-Way API]';
            DataClassification = CustomerContent;
            Caption = 'E-Way Bill Validity';
        }
        field(52010; "E-Way-to generate"; Boolean)
        {
            Description = 'Alle-[E-Way API]';
            DataClassification = CustomerContent;
            Caption = 'E-Way-to generate';
        }
        field(52011; "E-Way Generated"; Boolean)
        {
            Description = 'Alle-[E-Way API]';
            DataClassification = CustomerContent;
            Caption = 'E-Way Generated';
        }
        field(52012; "New Vechile No."; Code[10])
        {
            Description = 'Alle-[E-Way API]';
            DataClassification = CustomerContent;
            Caption = 'New Vechile No.';
        }
        field(52013; "Vechile No. Update Remark"; Text[9])
        {
            Description = 'Alle-[E-Way API]';
            DataClassification = CustomerContent;
            Caption = 'Vechile No. Update Remark';
        }
        field(52014; "E-Way Canceled"; Boolean)
        {
            Description = 'Alle-[E-Way API]';
            DataClassification = CustomerContent;
            Caption = 'E-Way Canceled';
        }
        field(52015; "Transportation Distance"; Integer)
        {
            Description = 'Alle-[E-Way API]';
            DataClassification = CustomerContent;
            Caption = 'Transportation Distance';
        }
        field(53001; "Insurance By"; Option)
        {
            Description = 'CF001';
            OptionMembers = " ",You,Us;
            DataClassification = CustomerContent;
            Caption = 'Insurance By';
        }
        field(53002; "Date Of Issue"; Date)
        {
            Description = 'CF001';
            DataClassification = CustomerContent;
            Caption = 'Date Of Issue';
        }
        field(53003; "Time Of Issue"; Time)
        {
            Description = 'CF001';
            DataClassification = CustomerContent;
            Caption = 'Time Of Issue';
        }
        field(53004; "Date Of Removal"; Date)
        {
            Description = 'CF001';
            DataClassification = CustomerContent;
            Caption = 'Date Of Removal';
        }
        field(53005; "Time Of Removals"; Time)
        {
            Description = 'CF001';
            DataClassification = CustomerContent;
            Caption = 'Time Of Removals';
        }
        field(53006; "Vehicle No1"; Code[25])
        {
            Description = 'CF001';
            Enabled = false;
            DataClassification = CustomerContent;
            Caption = 'Vehicle No1';
        }
        field(53007; "Freight (MAC)"; Decimal)
        {
            Description = 'CF001';
            DataClassification = CustomerContent;
            Caption = 'Freight (MAC)';
        }
        field(53008; "No. Of Packages"; Decimal)
        {
            Description = 'CF001';
            DataClassification = CustomerContent;
            Caption = 'No. Of Packages';
        }
        field(53009; "External Doc. Date"; Date)
        {
            Description = 'CF001';
            DataClassification = CustomerContent;
            Caption = 'External Doc. Date';
        }
        field(53050; "Excise Invoice No."; Code[20])
        {
            Description = 'CF001';
            SQLDataType = Varchar;
            DataClassification = CustomerContent;
            Caption = 'Excise Invoice No.';
        }
        field(53051; "Excise Invoice Date"; Date)
        {
            Description = 'CF001';
            Enabled = false;
            DataClassification = CustomerContent;
            Caption = 'Excise Invoice Date';
        }
        field(53052; "VAT Form"; Code[10])
        {
            Description = 'CF001';
            Enabled = false;
            DataClassification = CustomerContent;
            Caption = 'VAT Form';
        }
        field(53060; "Shop Code"; Code[2])
        {
            Description = 'CF001';
            DataClassification = CustomerContent;
            Caption = 'Shop Code';
        }
        field(53061; "Customer Location"; Code[20])
        {
            Description = 'CF001';
            DataClassification = CustomerContent;
            Caption = 'Customer Location';
        }
        field(53062; "Customer Gate No."; Code[3])
        {
            Description = 'CF001';
            DataClassification = CustomerContent;
            Caption = 'Customer Gate No.';
        }
        field(53063; Container; Integer)
        {
            Description = 'CF001';
            DataClassification = CustomerContent;
            Caption = 'Container';
        }
        field(53064; "Stuffing Quantity"; Integer)
        {
            Description = 'CF001';
            DataClassification = CustomerContent;
            Caption = 'Stuffing Quantity';
        }
        field(53065; "Order/Scd. No."; Code[20])
        {
            Description = 'CF002 Sales Order No.';
            DataClassification = CustomerContent;
            Caption = 'Order/Scd. No.';
        }
        field(53066; "MRIR No."; Code[10])
        {
            Description = 'CF001';
            DataClassification = CustomerContent;
            Caption = 'MRIR No.';
        }
        field(53067; "Description of Packages"; Code[50])
        {
            Description = 'CF001';
            DataClassification = CustomerContent;
            Caption = 'Description of Packages';
        }
        field(53068; "Get Despatch Used"; Boolean)
        {
            Caption = 'Get Despatch Used';
            Description = 'CF002';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(53080; "Stock Transfer"; Boolean)
        {
            Description = 'CF001';
            DataClassification = CustomerContent;
            Caption = 'Stock Transfer';
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
            Enabled = false;
            DataClassification = CustomerContent;
            Caption = 'GR Date';
        }
        field(53087; "Exemption Notification"; Text[50])
        {
            Description = 'CF001-ALLE[551]=>80=>50 -more than 4000 bytse/Alle-[Amazon-HG]-Deactivated';
            Enabled = false;
            DataClassification = CustomerContent;
            Caption = 'Exemption Notification';
        }
        field(53088; Insurance1; Option)
        {
            Caption = 'Insurance';
            Description = 'CF001';
            OptionMembers = ,"Insurance By You","Insurance By Us";
            DataClassification = CustomerContent;
        }
        field(53089; "RFQ/Enquiry No"; Code[20])
        {
            Enabled = false;
            DataClassification = CustomerContent;
            Caption = 'RFQ/Enquiry No';
        }
        field(53090; Barcode; Blob)
        {
            Description = 'CF001';
            DataClassification = CustomerContent;
            Caption = 'Barcode';
        }
        field(53091; "Authorised By"; Text[50])
        {
            Description = 'CF001';
            Enabled = false;
            DataClassification = CustomerContent;
            Caption = 'Authorised By';
        }
        field(53092; "Authenticated By"; Text[50])
        {
            Description = 'CF001';
            Enabled = false;
            DataClassification = CustomerContent;
            Caption = 'Authenticated By';
        }
        field(53105; Remarks1; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Remarks';
        }
        field(55000; "Gate Out Date"; Date)
        {
            Description = 'CF001';
            DataClassification = CustomerContent;
            Caption = 'Gate Out Date';
        }
        field(55001; "Gate Out Time"; Time)
        {
            Description = 'CF001';
            DataClassification = CustomerContent;
            Caption = 'Gate Out Time';
        }
        field(55002; "Gate Out Remarks"; Text[30])
        {
            Description = 'CF001';
            DataClassification = CustomerContent;
            Caption = 'Gate Out Remarks';
        }
        field(55003; "Gate Out User ID"; Code[20])
        {
            Description = 'CF001';
            DataClassification = CustomerContent;
            Caption = 'Gate Out User ID';
        }
        field(55004; "Gate Out No."; Code[20])
        {
            Description = 'CF001';
            DataClassification = CustomerContent;
            Caption = 'Gate Out No.';
        }
        field(55005; "Gate Out Posted"; Boolean)
        {
            Description = 'CF001';
            DataClassification = CustomerContent;
            Caption = 'Gate Out Posted';
        }
        field(55006; "RGP Receipt No."; Code[20])
        {
            Description = 'CEN004.05';
            Enabled = false;
            TableRelation = "SSD RGP Receipt Header"."No.";
            DataClassification = CustomerContent;
            Caption = 'RGP Receipt No.';
        }
        field(60002; "Excise Invoice No. Series"; Code[20])
        {
            Description = 'CF001';
            Enabled = false;
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
            Enabled = false;
            DataClassification = CustomerContent;
            Caption = 'DI No.';
        }
        field(60007; "DI Date"; Date)
        {
            Enabled = false;
            DataClassification = CustomerContent;
            Caption = 'DI Date';
        }
        field(60008; "Delivery Location"; Code[20])
        {
            Enabled = false;
            DataClassification = CustomerContent;
            Caption = 'Delivery Location';
        }
        field(60009; "Delivery Time"; Time)
        {
            Enabled = false;
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
            Enabled = false;
            OptionCaption = ' ,DI SPARES,ENAGARE';
            OptionMembers = " ","DI SPARES",ENAGARE;
            DataClassification = CustomerContent;
            Caption = 'Nagare Item Type';
        }
        field(60043; Supplementary; Boolean)
        {
            CalcFormula = exist("Sales Invoice Line" where("Document No." = field("No."), Type = filter(Item), "No." = filter('11-FGS-01008')));
            Description = 'Supplementary';
            FieldClass = FlowField;
            Caption = 'Supplementary';
        }
        field(60044; "Supplementary Rate"; Decimal)
        {
            Description = 'Supplementary';
            DataClassification = CustomerContent;
            Caption = 'Supplementary Rate';
        }
        field(60045; "Supplementary Item"; Code[20])
        {
            Description = 'Supplementary';
            TableRelation = Item;
            DataClassification = CustomerContent;
            Caption = 'Supplementary Item';
        }
        field(60046; "Supplementary Start Date"; Date)
        {
            Description = 'Supplementary';
            DataClassification = CustomerContent;
            Caption = 'Supplementary Start Date';
        }
        field(60047; "Supplementary End Date"; Date)
        {
            Description = 'Supplementary';
            DataClassification = CustomerContent;
            Caption = 'Supplementary End Date';
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
            end;
        }
        field(60080; "Comm. Inv. No. Series"; Code[10])
        {
            TableRelation = "No. Series";
            DataClassification = CustomerContent;
            Caption = 'Comm. Inv. No. Series';
        }
        field(60081; "ARE1 No. Series"; Code[10])
        {
            TableRelation = "No. Series";
            DataClassification = CustomerContent;
            Caption = 'ARE1 No. Series';
        }
        field(60082; "Commercial Invoice No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Commercial Invoice No.';
        }
        field(60083; "ARE 1 No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'ARE 1 No.';
        }
        field(70000; "Schedule Month"; Option)
        {
            OptionCaption = ', ,JAN,FEB,MAR,APR,MAY,JUN,JUL,AUG,SEP,OCT,NOV,DEC';
            OptionMembers = ,JAN,FEB,MAR,APR,MAY,JUN,JUL,AUG,SEP,OCT,NOV,DEC;
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
            Enabled = false;
            DataClassification = CustomerContent;
            Caption = 'Structure Calculated';
        }
        field(70201; "Statistics Checked"; Boolean)
        {
            Enabled = false;
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
            Enabled = false;
            DataClassification = CustomerContent;
            Caption = 'Weightment Bill No.';
        }
        field(70204; "Weightment Bill Date"; Date)
        {
            Description = 'PT - Deepika.V - 26/12/08';
            Enabled = false;
            DataClassification = CustomerContent;
            Caption = 'Weightment Bill Date';
        }
        field(71000; "GSTR 1 Exported"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'GSTR 1 Exported';
        }
        field(75000; "Applied to Insurance Policy"; Code[30])
        {
            Description = 'ALLE 2.09';
            Editable = false;
            TableRelation = "SSD Insurance Setup";
            DataClassification = CustomerContent;
            Caption = 'Applied to Insurance Policy';
        }
        field(75001; "Freight Zone"; Code[20])
        {
            Description = 'ALLE 3.08';
            Editable = false;
            TableRelation = "SSD Freight Zone";
            DataClassification = CustomerContent;
            Caption = 'Freight Zone';
        }
        field(75002; "SRV No."; Text[15])
        {
            Description = 'ALLE 3.24';
            DataClassification = CustomerContent;
            Caption = 'SRV No.';
        }
        field(75003; "Freight Amount"; Decimal)
        {
            Description = 'ALLE 3.24';
            DataClassification = CustomerContent;
            Caption = 'Freight Amount';
            /* SSD Sunil
                trigger OnValidate()
                var
                    SalesInvLine: Record "Sales Invoice Line";
                    TotalWaight: Decimal;
                begin
                    SalesInvLine.Reset;
                    SalesInvLine.SetRange("Document No.", "No.");
                    TotalWaight := 0;
                    if SalesInvLine.Find('-') then
                        repeat
                            TotalWaight += SalesInvLine."Gross Wt";
                        until SalesInvLine.Next = 0;


                    SalesInvLine.Reset;
                    SalesInvLine.SetRange("Document No.", "No.");
                    if SalesInvLine.Find('-') then
                        repeat
                            if TotalWaight <> 0 then
                                SalesInvLine."Freight Amount" := ROUND("Freight Amount" * SalesInvLine."Gross Wt" / TotalWaight)
                            else
                                SalesInvLine."Freight Amount" := 0;
                            SalesInvLine.Modify;
                        until SalesInvLine.Next = 0;
                end;
                */
        }
        field(75004; "Customer Transit Form No."; Text[30])
        {
            Description = 'ALLE 3.24';
            DataClassification = CustomerContent;
            Caption = 'Customer Transit Form No.';
        }
        field(75005; "ZDI Transit Form No"; Text[30])
        {
            Description = 'ALLE 3.24';
            DataClassification = CustomerContent;
            Caption = 'ZDI Transit Form No';
        }
        field(75555; "ARE1 Received Date"; Date)
        {
            Description = 'ALLE 3.14';
            DataClassification = CustomerContent;
            Caption = 'ARE1 Received Date';
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
            Enabled = false;
            DataClassification = CustomerContent;
            Caption = 'Job Work Invoice';
        }
        field(85000; "Completely Closed"; Boolean)
        {
            Description = 'ALLE 3.29';
            Enabled = false;
            DataClassification = CustomerContent;
            Caption = 'Completely Closed';
        }
        field(85001; ARE1; Boolean)
        {
            Description = 'ALLE 3.14';
            DataClassification = CustomerContent;
            Caption = 'ARE1';
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
            TableRelation = "SSD CT2 Header"."CT2 No." where("CT2 No." = field("CT2 Form"));
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
            TableRelation = "SSD CT3 Header"."CT3 No." where("Customer No." = field("Sell-to Customer No."));
            DataClassification = CustomerContent;
            Caption = 'CT3 Form';
        }
        field(85008; "Firm Freight"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Firm Freight';
        }
        field(85009; "ARE Invoice"; Boolean)
        {
            Description = 'ALLE';
            DataClassification = CustomerContent;
            Caption = 'ARE Invoice';
        }
        field(85010; "Form No.2"; Code[10])
        {
            Description = 'ALLE[551]-27-3-12';
            DataClassification = CustomerContent;
            Caption = 'Form No.2';
        }
        field(85011; "Supplementary Invoice"; Boolean)
        {
            Description = 'ALLE[551]';
            DataClassification = CustomerContent;
            Caption = 'Supplementary Invoice';
        }
        field(85014; "Customer Quote No."; Code[100])
        {
            Description = 'BIS 1145/Alle-[Amazon-HG]-EndCustaddres';
            DataClassification = CustomerContent;
            Caption = 'Customer Quote No.';
        }
        field(85015; "Calculated Freight Amount"; Decimal)
        {
            Description = 'ALLE[Z]-for qry report purpose';
            DataClassification = CustomerContent;
            Caption = 'Calculated Freight Amount';
            /*
                trigger OnValidate()
                begin
                    //AlleRavik/ZDD/001 Begin
                    Validate("Freight Amount", "Calculated Freight Amount");
                    //Modify;
                    //AlleRavik/ZDD/001 End
                end;
                */
        }
        field(85016; "Actual Shipping Agent code"; Code[10])
        {
            TableRelation = "Shipping Agent";
            DataClassification = CustomerContent;
            Caption = 'Actual Shipping Agent code';
        }
        field(85018; "Freight Amount Volume Mark"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Freight Amount Volume Mark';
        }
        field(85019; "Gate Pass"; Boolean)
        {
            CalcFormula = exist("SSD Gate Pass Line" where("Invoice No." = field("No.")));
            Description = 'ALLE-GP001';
            Editable = false;
            FieldClass = FlowField;
            Caption = 'Gate Pass';
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
        field(85023; "ADD Remark"; Text[10])
        {
            Description = 'Alle 240717';
            DataClassification = CustomerContent;
            Caption = 'ADD Remark';
        }
        field(85024; "Mail Send Dispatch Detail"; Boolean)
        {
            CalcFormula = exist("SSD Dispatch Mail Send" where("No." = field("No.")));
            Description = 'ALLE 101117';
            FieldClass = FlowField;
            Caption = 'Mail Send Dispatch Detail';
        }
        field(85025; "E-Way Bill Date"; Date)
        {
            Description = 'ALLE310118';
            DataClassification = CustomerContent;
            Caption = 'E-Way Bill Date';
        }
        field(85026; "Actual Delivery Capture Date"; Date)
        {
            Description = 'Alle 1.0 110918';
            DataClassification = CustomerContent;
            Caption = 'Actual Delivery Capture Date';
        }
        field(85027; "Capture Time"; Time)
        {
            Description = 'Alle 1.0 110918';
            DataClassification = CustomerContent;
            Caption = 'Capture Time';
        }
        field(85028; "LR/RR No. Capture Date"; Date)
        {
            Description = 'Alle 1.0 110918';
            DataClassification = CustomerContent;
            Caption = 'LR/RR No. Capture Date';
        }
        field(85029; "LR/RR No. Capture Time"; Time)
        {
            Description = 'Alle 1.0 110918';
            DataClassification = CustomerContent;
            Caption = 'LR/RR No. Capture Time';
        }
        field(85030; "Send Mail Capture Date"; Date)
        {
            Caption = 'Send Mail Capture Date With COA';
            Description = 'Alle 1.0 110918 Send Mail With COA';
            DataClassification = CustomerContent;
        }
        field(85031; "Send Mail Capture Time"; Time)
        {
            Caption = 'Send Mail Capture Time With COA';
            Description = 'Alle 1.0 110918 Send Mail With COA';
            DataClassification = CustomerContent;
        }
        field(85032; "Send Mail With COA"; Boolean)
        {
            Description = 'ALLE-NM 25112019';
            DataClassification = CustomerContent;
            Caption = 'Send Mail With COA';
        }
        field(85033; "Send Mail Without COA"; Boolean)
        {
            Description = 'ALLE-NM 25112019';
            DataClassification = CustomerContent;
            Caption = 'Send Mail Without COA';
        }
        field(85034; "Amazon Invoice/Credit Memo"; Boolean)
        {
            Description = 'Alle-[Amazon-HG]';
            Editable = false;
            DataClassification = CustomerContent;
            Caption = 'Amazon Invoice/Credit Memo';
        }
        field(85036; "Last Modified Date"; DateTime)
        {
            Description = 'ALLe 19032021';
            DataClassification = CustomerContent;
            Caption = 'Last Modified Date';
        }
        field(85037; "Send Mail Again With COA"; Boolean)
        {
            Description = 'ALLE-NM 25112019';
            DataClassification = CustomerContent;
            Caption = 'Send Mail Again With COA';
        }
        field(85038; "Send Mail Capture Date W/O COA"; Date)
        {
            Description = 'Alle 09122021';
            DataClassification = CustomerContent;
            Caption = 'Send Mail Capture Date W/O COA';
        }
        field(85039; "Send Mail Again With COA Date"; Date)
        {
            Description = 'Alle 10122021';
            DataClassification = CustomerContent;
            Caption = 'Send Mail Again With COA Date';
        }
        field(85040; "Send Mail Capture Time W/O COA"; Time)
        {
            Description = 'Alle 10122021';
            DataClassification = CustomerContent;
            Caption = 'Send Mail Capture Time W/O COA';
        }
        field(85041; "Send Mail Again With COA Time"; Time)
        {
            Description = 'Alle 10122021';
            DataClassification = CustomerContent;
            Caption = 'Send Mail Again With COA Time';
        }
        field(85035; "Type of Invoice"; Enum "Type Of Invoice Sales")
        {
            Caption = 'Type of Invoice';
        }
    }
    trigger OnAfterInsert()
    begin
        crmRelease := true;
    end;

    trigger OnAfterModify()
    begin
        IF crminsertflag = TRUE THEN crmupdateflag := TRUE;
        crmRelease := TRUE;
    end;

    procedure ModifyDispatch(SalesInvoiceHeader: Record "Sales Invoice Header")
    var
        SalesInvoiceHeader2: Record "Sales Invoice Header";
    begin
        if SalesInvoiceHeader2.Get(SalesInvoiceHeader."No.") then begin
            SalesInvoiceHeader2."Dispatch Mail Send" := true;
            SalesInvoiceHeader2.Modify;
        end;
    end;

    var
        UserSetup: Record "User Setup";
}
