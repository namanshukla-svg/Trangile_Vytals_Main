TableExtension 50064 "SSD Purch. Rcpt. Header" extends "Purch. Rcpt. Header"
{
    fields
    {
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
            OptionMembers = ,"Order",Contract,"Service Contract",Schedule;
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
        field(50030; "Vechile Type"; Option)
        {
            Description = 'CF001';
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
        field(50035; "Bill No."; Code[20])
        {
            CalcFormula = lookup("SSD Posted Gate Header"."Bill No." where("No." = field("Gate Entry No.")));
            FieldClass = FlowField;
            Caption = 'Bill No.';
        }
        field(50036; "Bill Date"; Date)
        {
            Description = 'ALLEAA CML-033 280308';
            DataClassification = CustomerContent;
            Caption = 'Bill Date';
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
            Description = 'CF001';
            OptionCaption = ' ,Job Work/Service,Capex,Consumables,Raw Material,Tooling,BOP,Spares,General,Trading';
            OptionMembers = " ","Job Work/Service",Capex,Consumables,"Raw Material",Tooling,BOP,Spares,General,Trading;
            DataClassification = CustomerContent;
            Caption = 'PO Type';
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
        }
        field(50089; "Posted Whse. Rcpt No."; Code[20])
        {
            CalcFormula = lookup("Purch. Rcpt. Line"."Posted Whse. Rcpt No." where("Document No." = field("No.")));
            Description = 'Alle-011118';
            FieldClass = FlowField;
            Caption = 'Posted Whse. Rcpt No.';
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
        field(50600; "SSD SRN Approval Pending"; Boolean)
        {
            Caption = 'SRN Approval Pending';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(50601; "SSD SRN Approver"; Code[50])
        {
            Caption = 'SRN Approver';
            DataClassification = CustomerContent;
            Editable = false;
            TableRelation = "User Setup";
        }
        field(50350; "SSD TC Code"; Code[20])
        {
            Caption = 'TC Code';
            DataClassification = CustomerContent;
            TableRelation = "SSD Terms";
        }
        field(50351; "SSD Order Type"; Enum "SSD Purchase Order Type")
        {
            Caption = 'Order Type';
            DataClassification = CustomerContent;
        }
        field(50352; "SSD Deduction Amount"; Decimal)
        {
            Caption = 'Deduction Amount';
            DecimalPlaces = 2 : 2;
            DataClassification = CustomerContent;
        }
        field(52001; "Effective Date"; Date)
        {
            Description = 'CF001';
            DataClassification = CustomerContent;
            Caption = 'Effective Date';

            trigger OnValidate()
            var
                PurchaseLine: Record "Purchase Line";
            begin
            end;
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
        field(52004; Currency; Code[10])
        {
            Description = 'CF001';
            DataClassification = CustomerContent;
            Caption = 'Currency';
        }
        field(52005; "Exchange Rate"; Decimal)
        {
            Description = 'CF001';
            DataClassification = CustomerContent;
            Caption = 'Exchange Rate';
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
            DataClassification = CustomerContent;
            Caption = 'Gate Entry No.';
        }
        field(52014; "Gate Entry Date"; Date)
        {
            Description = 'CF001';
            DataClassification = CustomerContent;
            Caption = 'Gate Entry Date';
        }
        field(52015; "MRR Remark"; Text[80])
        {
            Description = 'CF001';
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
            CalcFormula = lookup("Posted Whse. Receipt Line"."Whse. Receipt No." where("Posted Source No." = field("No.")));
            Description = 'CF001';
            FieldClass = FlowField;
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
        field(52105; "Gate Entry No. 1"; Code[30])
        {
            CalcFormula = lookup("Posted Whse. Receipt Header"."Gate Entry no." where("No." = field("Posted Whse. Rcpt No.")));
            Description = 'sandeep';
            FieldClass = FlowField;
            Caption = 'Gate Entry No. 1';
        }
        field(52106; "Vendor Bill Date"; Date)
        {
            CalcFormula = lookup("SSD Posted Gate Header"."Bill Date" where("No." = field("Gate Entry No. 1")));
            Description = 'sandeep';
            FieldClass = FlowField;
            Caption = 'Vendor Bill Date';
        }
        field(52107; "Vendor Invoice No."; Code[20])
        {
            Description = 'CML-038';
            DataClassification = CustomerContent;
            Caption = 'Vendor Invoice No.';
        }
        field(53055; "Excise Invoice No. Series"; Code[20])
        {
            Description = 'CF001';
            TableRelation = "No. Series";
            DataClassification = CustomerContent;
            Caption = 'Excise Invoice No. Series';
        }
        field(53056; "Tax Registration No."; Text[20])
        {
            Description = 'CF001';
            DataClassification = CustomerContent;
            Caption = 'Tax Registration No.';
        }
        field(53057; Remarks; Text[50])
        {
            Description = 'CF001';
            DataClassification = CustomerContent;
            Caption = 'Remarks';
        }
        field(53058; Insurance; Option)
        {
            Description = 'CGN 005 added "Not Applicable" on 180407';
            OptionCaption = ' ,Insurance By Seller,Insurance By Buyer,Not Applicable';
            OptionMembers = " ","Insurance By Seller","Insurance By Buyer","Not Applicable";
            DataClassification = CustomerContent;
            Caption = 'Insurance';
        }
        field(53059; "P&F Charges"; Option)
        {
            Enabled = false;
            OptionCaption = ' ,Inclusive in Price,Not Inclusive in Price,Refer to Annexure,NIL';
            OptionMembers = " ","Inclusive in Price","Not Inclusive in Price","Refer to Annexure",NIL;
            DataClassification = CustomerContent;
            Caption = 'P&F Charges';
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
        field(53500; "SSD Service Grace Period"; DateFormula)
        {
            Caption = 'Service Grace Period';
            DataClassification = CustomerContent;
        }
        field(60001; "Qty. Pending to Invoice"; Decimal)
        {
            CalcFormula = sum("Purch. Rcpt. Line"."Qty. Rcd. Not Invoiced" where("Document No." = field("No.")));
            Caption = 'Qty. Pending to Invoice';
            Description = 'Alle VPB';
            Editable = false;
            FieldClass = FlowField;
        }
        field(60043; Supplementary; Boolean)
        {
            Description = 'Supplementary';
            DataClassification = CustomerContent;
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
            DataClassification = CustomerContent;
            Caption = 'Supplementary PO Item';
        }
        field(60049; "Subcontracting Invoice"; Boolean)
        {
            Description = 'ALLEAA CML-033 220408';
            DataClassification = CustomerContent;
            Caption = 'Subcontracting Invoice';
        }
        field(60050; "RG Entry Created"; Boolean)
        {
            Description = 'CML-038';
            DataClassification = CustomerContent;
            Caption = 'RG Entry Created';
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

            trigger OnValidate()
            begin
                UpdateImportExciseAmount;
            end;
        }
        field(65001; "Freight Value(Import)"; Decimal)
        {
            DecimalPlaces = 0 : 4;
            Description = 'Alle VPB Import 280610';
            DataClassification = CustomerContent;
            Caption = 'Freight Value(Import)';

            trigger OnValidate()
            begin
                if ("Invoice Value(Import)" > 0) and ("Freight Value(Import)" > 0) then if ("Invoice Value(Import)" * 20 / 100) < ("Freight Value(Import)") then Error('Frieght value(import) must be less then 20 Percent of the Invoice Value(Import)');
                UpdateImportExciseAmount;
            end;
        }
        field(65002; "Insurance Value(Import)"; Decimal)
        {
            DecimalPlaces = 0 : 5;
            Description = 'Alle VPB Import 280610';
            DataClassification = CustomerContent;
            Caption = 'Insurance Value(Import)';

            trigger OnValidate()
            begin
                UpdateImportExciseAmount;
            end;
        }
        field(65003; "Misc Charges(Import)"; Decimal)
        {
            DecimalPlaces = 5 : 5;
            Description = 'Alle VPB Import 280610';
            DataClassification = CustomerContent;
            Caption = 'Misc Charges(Import)';

            trigger OnValidate()
            begin
                UpdateImportExciseAmount;
            end;
        }
        field(65004; "Landing Charges(Import)"; Decimal)
        {
            DecimalPlaces = 5 : 5;
            Description = 'Alle VPB Import 280610';
            DataClassification = CustomerContent;
            Caption = 'Landing Charges(Import)';

            trigger OnValidate()
            begin
                UpdateImportExciseAmount;
            end;
        }
        field(65005; "Insurance Value(Import) Type"; Option)
        {
            Description = 'Alle VPB Import 280610';
            OptionMembers = Percentage,Amount;
            DataClassification = CustomerContent;
            Caption = 'Insurance Value(Import) Type';

            trigger OnValidate()
            begin
                UpdateImportExciseAmount;
            end;
        }
        field(75000; "Invoice Type Old"; Option)
        {
            Description = 'ALLE 2.21';
            OptionCaption = ' ,Purchase Voucher,Expense Voucher';
            OptionMembers = " ","Purchase Voucher","Expense Voucher";
            DataClassification = CustomerContent;
            Caption = 'Invoice Type Old';
        }
        field(75555; "Advance Payment Amount"; Decimal)
        {
            CalcFormula = sum("Detailed Vendor Ledg. Entry".Amount where("Vendor No." = field("Buy-from Vendor No."), "PO No." = field("No.")));
            Description = 'ALLE 2.16';
            Editable = false;
            FieldClass = FlowField;
            Caption = 'Advance Payment Amount';
        }
        field(80000; "Invoice Received by Finance"; Boolean)
        {
            Editable = false;
            DataClassification = CustomerContent;
            Caption = 'Invoice Received by Finance';
        }
        field(80001; "Actual Posted Date"; DateTime)
        {
            Description = 'ALLE-HG-16.09.20';
            DataClassification = CustomerContent;
            Caption = 'Actual Posted Date';
        }
        field(80002; "Receipt send by Store"; Boolean)
        {
            Description = 'ALLE-HG-16.09.20';
            DataClassification = CustomerContent;
            Caption = 'Receipt send by Store';

            trigger OnValidate()
            begin
                UserSetup.Reset;
                if UserSetup.Get(UserId) then begin
                    if UserSetup."Receipt sendbyStore Permis" = true then
                        Validate("Receipt send by Store DateTime", CurrentDatetime)
                    else
                        Error('You do not have the required Permission')
                end;
                if "Receipt recd by Fin DateTime" <> 0DT then if "Receipt send by Store" = false then Error('Since Receipt has been received by Finanace-Modify not allowed');
            end;
        }
        field(80003; "Receipt send by Store DateTime"; DateTime)
        {
            Description = 'ALLE-HG-16.09.20';
            Editable = true;
            DataClassification = CustomerContent;
            Caption = 'Receipt send by Store DateTime';
        }
        field(80004; "Receipt recvd  by Fin"; Boolean)
        {
            Description = 'ALLE-HG-16.09.20';
            DataClassification = CustomerContent;
            Caption = 'Receipt recvd  by Fin';

            trigger OnValidate()
            begin
                UserSetup.Reset;
                if UserSetup.Get(UserId) then begin
                    if UserSetup."Receipt receivedby Fin Permis" = true then begin
                        //SSD220125
                        If "SSD Order Type" = "SSD Order Type"::Inventory then begin
                            if "Receipt send by Store" = true then
                                Validate("Receipt recd by Fin DateTime", CurrentDatetime)
                            else
                                Error('Receipt send by Store is still pending')
                        end
                        else
                            Validate("Receipt recd by Fin DateTime", CurrentDatetime);
                    end
                    else
                        Error('You do not have the required Permission');
                end;
                if "Receipt recd by Fin DateTime" <> 0DT then if "Receipt recvd  by Fin" = false then if UserSetup."Receipt receivedby Fin Admin" <> true then Error('Since it has been received by Finanace-Modify not allowed, Kindly Contact Admin');
            end;
        }
        field(80005; "Receipt recd by Fin DateTime"; DateTime)
        {
            Description = 'ALLE-HG-16.09.20';
            Editable = true;
            DataClassification = CustomerContent;
            Caption = 'Receipt recd by Fin DateTime';
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
            TableRelation = "Purchase Header"."No." where("No." = filter('BWO*'));
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
        }
        field(80045; "Valid To"; Date)
        {
            Description = 'ALLE-AT';
            DataClassification = CustomerContent;
            Caption = 'Valid To';
        }
        field(80049; "Type of Invoice"; Enum "Type of Invoice Purchase")
        {
            Caption = 'Type of Invoice';
        }
        field(80051; "Price Match/Mismatch"; Boolean)
        {
            Caption = 'Price Match/Mismatch';
        }
        field(80054; "SRN Approval Pending UserID"; Code[100])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
    }
    /// <summary>
    /// UpdateImportExciseAmount.
    /// </summary>
    procedure UpdateImportExciseAmount()
    var
        PurchRcptLineLocal: Record "Purch. Rcpt. Line";
        LineAmount: Decimal;
        "Line Invoice Value(Import)": Decimal;
        "Line Freight Value(Import)": Decimal;
        "Line Insurance Value(Import)": Decimal;
        "Line Misc Charges(Import)": Decimal;
        "Line Landing Charges(Import)": Decimal;
    begin
        //Alle VPB Created
        PurchRcptLineLocal.Reset;
        PurchRcptLineLocal.SetRange("Document No.", "No.");
        if PurchRcptLineLocal.FindSet then
            repeat
                "Line Invoice Value(Import)" := 0;
                "Line Freight Value(Import)" := 0;
                "Line Insurance Value(Import)" := 0;
                "Line Misc Charges(Import)" := 0;
                "Line Landing Charges(Import)" := 0;
                LineAmount := PurchRcptLineLocal.Quantity * PurchRcptLineLocal."Direct Unit Cost";
                "Line Invoice Value(Import)" := "Invoice Value(Import)";
                if ("Invoice Value(Import)" > 0) and ("Freight Value(Import)" > 0) then
                    "Line Freight Value(Import)" := ("Freight Value(Import)" / "Invoice Value(Import)" * (LineAmount))
                else
                    "Line Freight Value(Import)" := 0;
                if (LineAmount > 0) and ("Insurance Value(Import)" > 0) then begin
                    if ("Insurance Value(Import) Type" = "insurance value(import) type"::Percentage) then
                        "Line Insurance Value(Import)" := ROUND((LineAmount * "Insurance Value(Import)") / 100, 0.00001)
                    else
                        "Line Insurance Value(Import)" := ROUND(("Insurance Value(Import)" / "Invoice Value(Import)" * LineAmount), 0.00001);
                end
                else
                    "Line Insurance Value(Import)" := 0;
                if ("Invoice Value(Import)" * LineAmount) <> 0 then begin
                    "Line Misc Charges(Import)" := ROUND(("Misc Charges(Import)" / "Invoice Value(Import)" * LineAmount), 0.00001)
                end
                else
                    "Line Misc Charges(Import)" := 0;
                if (LineAmount + "Line Insurance Value(Import)" + "Line Freight Value(Import)" <> 0) and ("Landing Charges(Import)" <> 0) then
                    "Line Landing Charges(Import)" := ROUND(((LineAmount) + "Line Insurance Value(Import)" + "Line Freight Value(Import)") * "Landing Charges(Import)" / 100, 0.00001)
                else
                    "Line Landing Charges(Import)" := 0;
                //SSD Comment Start
                // if PurchRcptLineLocal.Quantity <> 0 then
                //     PurchRcptLineLocal.Validate("CIF Amount", ((LineAmount)
                //                                + "Line Misc Charges(Import)"
                //                                + "Line Freight Value(Import)" + "Line Insurance Value(Import)"
                //                                + "Line Landing Charges(Import)") / PurchRcptLineLocal.Quantity)
                // else
                //     PurchRcptLineLocal.Validate("CIF Amount", 0);
                // if "Invoice Value(Import)" = 0 then begin
                //     PurchRcptLineLocal."CIF Amount" := 0;
                //     "Line Freight Value(Import)" := 0;
                //     "Line Insurance Value(Import)" := 0;
                //     "Line Landing Charges(Import)" := 0;
                // end;
                //SSD Comment End
                PurchRcptLineLocal.Modify;
            until PurchRcptLineLocal.Next = 0;
    end;

    procedure ModifyInvoiceReceivedFinance()
    begin
        "Invoice Received by Finance" := true;
    end;

    local procedure CheckItemChargeModification()
    var
        RecUser: Record "User Setup";
    begin
        //ALLE-AT >>
        RecUser.Get(UserId);
        RecUser.TestField("Allow to Rec. Item Charge");
        //ALLE-AT <<
    end;

    local procedure CheckRecItemChargeModification()
    var
        RecUser: Record "User Setup";
    begin
        //ALLE-AT >>
        RecUser.Get(UserId);
        RecUser.TestField("Allow to Rec. Item Charge");
        //ALLE-AT <<
    end;

    var
        UserSetup: Record "User Setup";
}
