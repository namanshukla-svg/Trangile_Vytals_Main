TableExtension 50063 "SSD Purch. Inv. Line" extends "Purch. Inv. Line"
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
        field(50050; "MRP Qty."; Decimal)
        {
            Description = 'Alle 290916';
            Editable = false;
            DataClassification = CustomerContent;
            Caption = 'MRP Qty.';
        }
        field(50094; "Description 3"; Text[300])
        {
            Description = 'ALLE-060121';
            DataClassification = CustomerContent;
            Caption = 'Description 3';
            Editable = false;
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
        field(53011; "SSD Order No."; Code[20])
        {
            Description = 'CF002';
            Editable = false;
            DataClassification = CustomerContent;
            Caption = 'Order No.';
        }
        field(53012; "SSD Order Line No."; Integer)
        {
            Description = 'CF002';
            DataClassification = CustomerContent;
            Caption = 'Order Line No.';
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
        field(75006; "BCD %"; Decimal)
        {
            Description = 'Alle VPB Import 280610';
            DataClassification = CustomerContent;
            Caption = 'BCD %';
        }
        field(75007; "CIF Amount (LCY)"; Decimal)
        {
            DecimalPlaces = 0: 5;
            Description = 'Alle VPB Import 280610';
            DataClassification = CustomerContent;
            Caption = 'CIF Amount (LCY)';
        }
        field(75008; "BCD Amount (LCY)"; Decimal)
        {
            AutoFormatType = 1;
            Description = 'Alle VPB Import 280610';
            Editable = true;
            DataClassification = CustomerContent;
            Caption = 'BCD Amount (LCY)';
        }
        field(75009; "BED Amount (LCY)"; Decimal)
        {
            DecimalPlaces = 0: 5;
            Description = 'Alle VPB Import 280610';
            DataClassification = CustomerContent;
            Caption = 'BED Amount (LCY)';
        }
        field(75010; "eCess Amount (LCY)"; Decimal)
        {
            AutoFormatType = 1;
            Description = 'Alle VPB Import 280610';
            Editable = true;
            DataClassification = CustomerContent;
            Caption = 'eCess Amount (LCY)';
        }
        field(75011; "SHE Cess Amount (LCY)"; Decimal)
        {
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
