TableExtension 50069 "SSD Purchase Line Archive" extends "Purchase Line Archive"
{
    fields
    {
        field(50001; "Document Subtype"; Option)
        {
            Description = 'CF002';
            OptionCaption = ' ,Order,Contract,Service Contract,Schedule';
            OptionMembers = " ", "Order", Contract, "Service Contract", Schedule;
            DataClassification = CustomerContent;
            Caption = 'Document Subtype';
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
        field(50019; "Total Indent Qty"; Decimal)
        {
            CalcFormula = sum("SSD Posted Req. Purch. Line"."Requisition Qty" where("Purch. Document Type"=field("Document Type"), "Purch. Document No."=field("Document No."), "Purch. Document Line No."=field("Line No.")));
            Description = 'IND';
            FieldClass = FlowField;
            Caption = 'Total Indent Qty';
        }
        field(52011; "Challan Quantity"; Decimal)
        {
            BlankZero = true;
            DecimalPlaces = 0: 5;
            Description = 'CF001';
            DataClassification = CustomerContent;
            Caption = 'Challan Quantity';
        }
        field(52012; "Applies to Delivery Challan"; Code[20])
        {
            Description = 'CUST073 --> Applies to Delivery Challan';
            TableRelation = "Delivery Challan Line" where("Production Order No."=field("Prod. Order No."), "Production Order Line No."=field("Prod. Order Line No."), "Remaining Quantity"=filter(>0));
            DataClassification = CustomerContent;
            Caption = 'Applies to Delivery Challan';
        }
        field(53011; "Order No."; Code[20])
        {
            Description = 'CF002';
            Editable = false;
            DataClassification = CustomerContent;
            Caption = 'Order No.';
        }
        field(53012; "Order Line No."; Integer)
        {
            Description = 'CF002';
            DataClassification = CustomerContent;
            Caption = 'Order Line No.';
        }
        field(54002; "Indent No."; Code[20])
        {
            CalcFormula = lookup("SSD Posted Req. Purch. Line"."Posted Indent Document No." where("Purch. Document Type"=field("Document Type"), "Purch. Document No."=field("Document No."), "Purch. Document Line No."=field("Line No.")));
            Description = 'IND';
            FieldClass = FlowField;
            Caption = 'Indent No.';
        }
        field(54003; "Indent Line No."; Integer)
        {
            CalcFormula = lookup("SSD Posted Req. Purch. Line"."Posted Indent Line No." where("Purch. Document Type"=field("Document Type"), "Purch. Document No."=field("Document No."), "Purch. Document Line No."=field("Line No.")));
            Description = 'IND';
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
            CalcFormula = sum("SSD Posted Gate Line"."Challan Quantity" where("Party Type"=const(Vendor), "Party No."=field("Buy-from Vendor No."), "Ref. Document Type"=filter("Purchase Order"|"Purchase Schedule"), "Ref. Document No."=field("Document No."), Type=field(Type), "No."=field("No."), "Ref. Document Line No."=field("Line No.")));
            Description = 'CF001';
            Editable = false;
            FieldClass = FlowField;
            Caption = 'Total Posted Gate Challan Qty';
        }
        field(54016; "Total Delivery Challan Qty"; Decimal)
        {
            CalcFormula = sum("Delivery Challan Line".Quantity where("Document No."=field("Document No."), "Document Line No."=field("Line No.")));
            Description = 'CF003';
            Editable = false;
            FieldClass = FlowField;
            Caption = 'Total Delivery Challan Qty';
        }
        field(54017; "Total Gate Challan Qty"; Decimal)
        {
            CalcFormula = sum("SSD Gate Line"."Challan Quantity" where("Party Type"=const(Vendor), "Party No."=field("Buy-from Vendor No."), "Ref. Document Type"=filter("Purchase Order"|"Purchase Schedule"), "Ref. Document No."=field("Document No."), Type=field(Type), "No."=field("No."), "Ref. Document Line No."=field("Line No.")));
            Description = 'CF003';
            Editable = true;
            FieldClass = FlowField;
            Caption = 'Total Gate Challan Qty';
        }
        field(54018; "No. Of Purch. Rcvd"; Integer)
        {
            CalcFormula = count("Purch. Rcpt. Header" where("Order No."=field("Document No.")));
            Caption = 'No. Of Purchase Received';
            Description = 'CF003';
            Editable = false;
            FieldClass = FlowField;
        }
        field(54019; "P.O Status"; Option)
        {
            Description = 'CF_SC_001';
            OptionCaption = 'Open,Released';
            OptionMembers = Open, Released;
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
            CalcFormula = lookup(Item.Grade where("No."=field("No.")));
            Description = 'CF001 Grade req. for raw material';
            FieldClass = FlowField;
            Caption = 'Grade';
        }
        field(54024; "Bill No."; Code[20])
        {
            CalcFormula = lookup("SSD Posted Gate Header"."Bill No." where("No."=field("Gate Entry no."), "Party No."=field("Buy-from Vendor No.")));
            FieldClass = FlowField;
            Caption = 'Bill No.';
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
