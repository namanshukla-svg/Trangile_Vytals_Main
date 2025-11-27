TableExtension 50067 "SSD Purchase Header Archive" extends "Purchase Header Archive"
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
            OptionMembers = " ", "Order", Contract, "Service Contract", Schedule;
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
        field(50030; "Vechile Type"; Option)
        {
            Description = 'CF001';
            OptionCaption = 'Lorry,Container,Van';
            OptionMembers = Lorry, Container, Van;
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
            OptionMembers = " ", "Job Work/Service", Capex, Consumables, "Raw Material", Tooling, BOP, Spares, General, Trading;
            DataClassification = CustomerContent;
            Caption = 'PO Type';
        }
        field(50067; "PO Category"; Option)
        {
            Description = 'CF001';
            Enabled = false;
            OptionCaption = 'JobWork/Service,Capex,Consumables';
            OptionMembers = "JobWork/Service", Capex, Consumables;
            DataClassification = CustomerContent;
            Caption = 'PO Category';
        }
        field(50088; Freight; Option)
        {
            Description = 'CF001,SSD';
            Enabled = false;
            OptionCaption = ' ,Free on Rail,Free on Board,Ex Works,C & F,C I F,Inclusive in Price,Exclusive at Actuals,Refer to Annexure,NIL,Extra as Actual,To Pay';
            OptionMembers = " ", "Free on Rail", "Free on Board", "Ex Works", "C & F", "C I F", "Inclusive in Price", "Exclusive at Actuals", "Refer to Annexure", NIL, "Extra as Actual", "To Pay";
            DataClassification = CustomerContent;
            Caption = 'Freight';
        }
        field(50350; "SSD TC Code"; Code[20])
        {
            Caption = 'TC Code';
            DataClassification = CustomerContent;
            TableRelation = "SSD Terms";
        }
        field(50351; "SSD Order Type";Enum "SSD Purchase Order Type")
        {
            Caption = 'Order Type';
            DataClassification = CustomerContent;
        }
        field(50352; "SSD Deduction Amount"; Decimal)
        {
            Caption = 'Deduction Amount';
            DecimalPlaces = 2: 2;
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
        field(50354; "SSD SPO Remarks"; Text[150])
        {
            Caption = 'SPO Remarks';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                TestField(Status, Status::Open);
            end;
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
            TableRelation = "SSD Posted Gate Header"."No." where("Ref. Document Type"=const("Purchase Order"), "Party No."=field("Buy-from Vendor No."), "MRN Created"=filter(false));
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
            DataClassification = CustomerContent;
            Caption = 'Gate Entry No.';
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
            OptionMembers = " ", "Insurance By Seller", "Insurance By Buyer", "Not Applicable";
            DataClassification = CustomerContent;
            Caption = 'Insurance';
        }
        field(53059; "P&F Charges"; Option)
        {
            Enabled = false;
            OptionCaption = ' ,Inclusive in Price,Not Inclusive in Price,Refer to Annexure,NIL';
            OptionMembers = " ", "Inclusive in Price", "Not Inclusive in Price", "Refer to Annexure", NIL;
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
            OptionMembers = " ", "Free on Rail", "Free on Board", CIF, "C&F", "Ex your works", "Ex our works", " Door Delivery", " CIF Chennai Sea port";
            DataClassification = CustomerContent;
            Caption = 'Price Basis';
        }
        field(53500; "SSD Service Grace Period"; DateFormula)
        {
            Caption = 'Service Grace Period';
            DataClassification = CustomerContent;
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
            DecimalPlaces = 0: 4;
            Description = 'Alle VPB Import 280610';
            DataClassification = CustomerContent;
            Caption = 'Freight Value(Import)';
        }
        field(65002; "Insurance Value(Import)"; Decimal)
        {
            DecimalPlaces = 0: 5;
            Description = 'Alle VPB Import 280610';
            DataClassification = CustomerContent;
            Caption = 'Insurance Value(Import)';
        }
        field(65003; "Misc Charges(Import)"; Decimal)
        {
            DecimalPlaces = 5: 5;
            Description = 'Alle VPB Import 280610';
            DataClassification = CustomerContent;
            Caption = 'Misc Charges(Import)';
        }
        field(65004; "Landing Charges(Import)"; Decimal)
        {
            DecimalPlaces = 5: 5;
            Description = 'Alle VPB Import 280610';
            DataClassification = CustomerContent;
            Caption = 'Landing Charges(Import)';
        }
        field(65005; "Insurance Value(Import) Type"; Option)
        {
            Description = 'Alle VPB Import 280610';
            OptionMembers = Percentage, Amount;
            DataClassification = CustomerContent;
            Caption = 'Insurance Value(Import) Type';
        }
        field(75000; "Invoice Type Old"; Option)
        {
            Description = 'ALLE 2.21';
            OptionCaption = ' ,Purchase Voucher,Expense Voucher';
            OptionMembers = " ", "Purchase Voucher", "Expense Voucher";
            DataClassification = CustomerContent;
            Caption = 'Invoice Type Old';
        }
        field(75555; "Advance Payment Amount"; Decimal)
        {
            CalcFormula = sum("Detailed Vendor Ledg. Entry".Amount where("Vendor No."=field("Buy-from Vendor No."), "PO No."=field("No.")));
            Description = 'ALLE 2.16';
            Editable = false;
            FieldClass = FlowField;
            Caption = 'Advance Payment Amount';
        }
        field(80049; "Type of Invoice";Enum "Type of Invoice Purchase")
        {
            Caption = 'Type of Invoice';
        }
        field(80051; "Price Match/Mismatch"; Boolean)
        {
            Caption = 'Price Match/Mismatch';
        }
    }
}
