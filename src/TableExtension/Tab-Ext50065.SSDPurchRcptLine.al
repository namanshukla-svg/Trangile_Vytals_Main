TableExtension 50065 "SSD Purch. Rcpt. Line" extends "Purch. Rcpt. Line"
{
    fields
    {
        field(50001; "Document Subtype"; Option)
        {
            Description = 'CF002';
            OptionCaption = ' ,Order,Contract,Service Contract,Schedule';
            OptionMembers = , "Order", Contract, "Service Contract", Schedule;
            DataClassification = CustomerContent;
            Caption = 'Document Subtype';
        }
        field(50004; "Enquiry No."; Code[20])
        {
            Description = 'CF002';
            DataClassification = CustomerContent;
            Caption = 'Enquiry No.';
        }
        field(50005; "Enquiry Line No."; Integer)
        {
            Description = 'CF002';
            DataClassification = CustomerContent;
            Caption = 'Enquiry Line No.';
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
            DataClassification = CustomerContent;
            Caption = 'Accepted Qty.';
        }
        field(50016; "Rejected Qty."; Decimal)
        {
            Description = 'QLT';
            DataClassification = CustomerContent;
            Caption = 'Rejected Qty.';
        }
        field(50017; "Reject Location Code"; Code[10])
        {
            Description = 'QLT';
            TableRelation = Location where("Quality Rejects"=const(true));
            DataClassification = CustomerContent;
            Caption = 'Reject Location Code';
        }
        field(50018; "Reject Bin Code"; Code[20])
        {
            Description = 'QLT';
            TableRelation = Bin.Code where("Location Code"=field("Location Code"));
            DataClassification = CustomerContent;
            Caption = 'Reject Bin Code';
        }
        field(50050; "MRP Qty."; Decimal)
        {
            Description = 'Alle 290916';
            Editable = false;
            DataClassification = CustomerContent;
            Caption = 'MRP Qty.';
        }
        field(50100; "Manual Excise"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Manual Excise';
        }
        field(50102; "RG Entry Created"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'RG Entry Created';
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
            DecimalPlaces = 2: 2;
        }
        field(50352; "SSD Deduction Remarks"; Text[200])
        {
            DataClassification = CustomerContent;
            Caption = 'Deduction Remarks';
        }
        field(50600; "SSD SRN Approval Pending"; Boolean)
        {
            Caption = 'SRN Approval Pending';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(52011; "Challan Quantity"; Decimal)
        {
            BlankZero = true;
            DecimalPlaces = 0: 5;
            Description = 'CF001';
            DataClassification = CustomerContent;
            Caption = 'Challan Quantity';
        }
        field(52040; "Free Supply"; Boolean)
        {
            Description = 'CF001';
            DataClassification = CustomerContent;
            Caption = 'Free Supply';
        }
        field(52041; "FOC Entry No."; Integer)
        {
            Description = 'CF001';
            DataClassification = CustomerContent;
            Caption = 'FOC Entry No.';
        }
        field(52074; "Excise Value"; Decimal)
        {
            Description = 'CF001';
            DataClassification = CustomerContent;
            Caption = 'Excise Value';
        }
        field(52075; "Manual Excise 1"; Boolean)
        {
            Description = 'CF001';
            DataClassification = CustomerContent;
            Caption = 'Manual Excise 1';
        }
        field(54001; "Shelf No."; Code[20])
        {
            Description = 'CF001';
            DataClassification = CustomerContent;
            Caption = 'Shelf No.';
        }
        field(54002; "Indent No."; Code[20])
        {
            CalcFormula = lookup("SSD Posted Req. Purch. Line"."Posted Indent Document No." where("Purch. Document No."=field("Order No."), "Purch. Document Line No."=field("Order Line No.")));
            Description = 'CF001';
            FieldClass = FlowField;
            Caption = 'Indent No.';
        //The property 'ValidateTableRelation' can only be set if the property 'TableRelation' is set
        //ValidateTableRelation = false;
        }
        field(54003; "Indent Line No."; Integer)
        {
            CalcFormula = lookup("SSD Posted Req. Purch. Line"."Posted Indent Line No." where("Purch. Document No."=field("Order No."), "Purch. Document Line No."=field("Order Line No.")));
            Description = 'CF001';
            FieldClass = FlowField;
            Caption = 'Indent Line No.';
        }
        field(54004; Remarks; Text[100])
        {
            Description = 'CF001';
            DataClassification = CustomerContent;
            Caption = 'Remarks';
        }
        field(54005; "Gate Entry no."; Code[20])
        {
            CalcFormula = lookup("Posted Whse. Receipt Header"."Gate Entry no." where("No."=field("Posted Whse. Rcpt No.")));
            Description = 'CF001*Flow field created by Ankit*CE001';
            FieldClass = FlowField;
            Caption = 'Gate Entry no.';
        }
        field(54006; "Gate Entry Date"; Date)
        {
            Description = 'CF001';
            DataClassification = CustomerContent;
            Caption = 'Gate Entry Date';
        }
        field(54008; "Heat No."; Code[20])
        {
            Description = 'CF001';
            DataClassification = CustomerContent;
            Caption = 'Heat No.';
        }
        field(54009; "Gate Line No."; Integer)
        {
            Description = 'CF001';
            DataClassification = CustomerContent;
            Caption = 'Gate Line No.';
        }
        field(54010; "QC Transfer"; Boolean)
        {
            CalcFormula = exist("Warehouse Entry" where("Source No."=field("Document No."), "Item No."=field("No."), "Bin Code"=const('QC'), "Entry Type"=const(Movement)));
            Description = 'CF001';
            FieldClass = FlowField;
            Caption = 'QC Transfer';
        }
        field(54011; "Posted Whse. Rcpt No."; Code[20])
        {
            Description = 'CF001';
            DataClassification = CustomerContent;
            Caption = 'Posted Whse. Rcpt No.';
        }
        field(54012; "Posted Whse. Rcpt Line No."; Integer)
        {
            Description = 'CF001';
            DataClassification = CustomerContent;
            Caption = 'Posted Whse. Rcpt Line No.';
        }
        field(54013; "Quatation No."; Code[20])
        {
            Description = 'CF002';
            Editable = false;
            DataClassification = CustomerContent;
            Caption = 'Quatation No.';
        }
        field(54014; "Quotation Line No."; Integer)
        {
            Description = 'CF002';
            DataClassification = CustomerContent;
            Caption = 'Quotation Line No.';
        }
        field(54015; "Quotation Date"; Date)
        {
            Description = 'CF002';
            DataClassification = CustomerContent;
            Caption = 'Quotation Date';
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
        field(54023; "Bill No."; Code[20])
        {
            Description = 'CEN001 To flow Bill No. On receipt Line at the time of Purchase Invoicing';
            FieldClass = Normal;
            DataClassification = CustomerContent;
            Caption = 'Bill No.';
        }
        field(54024; "Pre Assign MRN No."; Code[20])
        {
            CalcFormula = lookup("Posted Whse. Receipt Header"."Whse. Receipt No." where("No."=field("Posted Whse. Rcpt No.")));
            Description = 'CEN004.05';
            FieldClass = FlowField;
            Caption = 'Pre Assign MRN No.';
        }
        field(54025; "Customer No."; Code[20])
        {
            Description = 'ALLE-TRA1.0';
            TableRelation = Customer."No.";
            DataClassification = CustomerContent;
            Caption = 'Customer No.';
        }
        field(54026; "SalesPerson Code"; Code[10])
        {
            Description = 'ALLE-TRA1.0';
            TableRelation = "Salesperson/Purchaser".Code;
            DataClassification = CustomerContent;
            Caption = 'SalesPerson Code';
        }
        field(60006; "Scrap Generated"; Decimal)
        {
            Description = 'ALLEAA CML-033 190408';
            DataClassification = CustomerContent;
            Caption = 'Scrap Generated';
        }
        field(60007; "Scrap Item"; Code[20])
        {
            Description = 'ALLEAA CML-033 190408';
            DataClassification = CustomerContent;
            Caption = 'Scrap Item';
        }
        field(60008; Trading; Boolean)
        {
            Description = 'ALLE-AA_CML/Purch 19.11.07';
            DataClassification = CustomerContent;
            Caption = 'Trading';
        }
        field(60009; Grade; Code[20])
        {
            Description = 'ALLEAA CML-033 280308';
            DataClassification = CustomerContent;
            Caption = 'Grade';
        }
        field(60010; "No.2"; Code[20])
        {
            CalcFormula = lookup(Item."No. 2" where("No."=field("No.")));
            Description = 'ALLEAA CML-033 280308';
            FieldClass = FlowField;
            Caption = 'No.2';
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
        field(60048; "Last Updated Cost"; Decimal)
        {
            Description = 'Supplementary';
            DataClassification = CustomerContent;
            Caption = 'Last Updated Cost';
        }
        field(60050; "Vendor Name"; Text[100])
        {
            CalcFormula = lookup(Vendor.Name where("No."=field("Buy-from Vendor No.")));
            FieldClass = FlowField;
            Caption = 'Vendor Name';
        }
        field(60051; "Receipt Date"; Date)
        {
            CalcFormula = lookup("Purch. Rcpt. Header"."Posting Date" where("No."=field("Document No.")));
            FieldClass = FlowField;
            Caption = 'Receipt Date';
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
            DecimalPlaces = 0: 5;
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
            DecimalPlaces = 0: 5;
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
}
