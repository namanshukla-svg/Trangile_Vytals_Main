table 50006 "SSD Posted Indent Line"
{
    // SSD-0001 Field Cancelled Quantity Added to track cancellation of Indent Line wise.
    DrillDownPageID = "Posted Indent Lines";
    LookupPageID = "Posted Indent Lines";
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Document No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Document No.';
        }
        field(3; "Line No."; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Line No.';
        }
        field(4; Type; Option)
        {
            OptionCaption = ' ,Item,Fixed Asset,G/L Account,Charge (Item)';
            OptionMembers = " ",Item,"Fixed Asset","G/L Account","Charge (Item)";
            DataClassification = CustomerContent;
            Caption = 'Type';
        }
        field(5; "No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'No.';
        }
        field(6; Description; Text[80])
        {
            DataClassification = CustomerContent;
            Caption = 'Description';
        }
        field(7; "Description 2"; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Description 2';
        }
        field(8; Quantity; Decimal)
        {
            DecimalPlaces = 0 : 5;
            DataClassification = CustomerContent;
            Caption = 'Quantity';
        }
        field(9; Remarks; Text[200])
        {
            DataClassification = CustomerContent;
            Caption = 'Remarks';
        }
        field(10; "Direct Unit Cost"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Direct Unit Cost';
        }
        field(12; "Due Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Due Date';
        }
        field(13; "Requester ID"; Code[20])
        {
            TableRelation = Employee;
            DataClassification = CustomerContent;
            Caption = 'Requester ID';
        }
        field(15; "Shortcut Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,2,1';
            Caption = 'Shortcut Dimension 1 Code';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1));
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                //ValidateShortcutDimCode(1,"Shortcut Dimension 1 Code");
            end;
        }
        field(16; "Shortcut Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,2,2';
            Caption = 'Shortcut Dimension 2 Code';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2));
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                //ValidateShortcutDimCode(2,"Shortcut Dimension 2 Code");
            end;
        }
        field(17; "Responsibility Center"; Code[20])
        {
            TableRelation = "Responsibility Center".Code;
            DataClassification = CustomerContent;
            Caption = 'Responsibility Center';
        }
        field(50; "Location Code"; Code[20])
        {
            Caption = 'Location Code';
            TableRelation = Location;
        }
        field(5402; "Variant Code"; Code[10])
        {
            TableRelation = "Item Variant";
            DataClassification = CustomerContent;
            Caption = 'Variant Code';
        }
        field(5404; "Qty. per Unit Of Measure"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Qty. per Unit Of Measure';
        }
        field(5407; "Unit Of Measure Code"; Code[10])
        {
            TableRelation = "Unit of Measure";
            DataClassification = CustomerContent;
            Caption = 'Unit Of Measure Code';
        }
        field(5408; "Quantity (Base)"; Decimal)
        {
            DecimalPlaces = 0 : 5;
            DataClassification = CustomerContent;
            Caption = 'Quantity (Base)';
        }
        field(5701; "Item Category Code"; Code[20])
        {
            TableRelation = "Item Category";
            DataClassification = CustomerContent;
            Caption = 'Item Category Code';
        }
        field(5705; "Product Group Code"; Code[10])
        {
            //SSD TableRelation = "Product Group";
            DataClassification = CustomerContent;
            Caption = 'Product Group Code';
        }
        field(50001; "Indent Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Indent Date';
        }
        field(50002; "Expected Cost"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Expected Cost';
        }
        field(50003; "Inventory Main Store"; Decimal)
        {
            DecimalPlaces = 0 : 5;
            DataClassification = CustomerContent;
            Caption = 'Inventory Main Store';
        }
        field(50004; "Capital Item"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Capital Item';
        }
        field(50005; "PO Qty"; Decimal)
        {
            CalcFormula = sum("SSD Posted Req. Purch. Line"."Requisition Qty" where("Posted Indent Document No." = field("Document No."), "Posted Indent Line No." = field("Line No."), "Purch. Document Type" = const(Order)));
            FieldClass = FlowField;
            Caption = 'PO Qty';
        }
        field(50006; "Qty. on Req. Line"; Decimal)
        {
            CalcFormula = sum("Requisition Line"."Remaining Quantity" where("Worksheet Template Name" = field("Template Name"), "Journal Batch Name" = field("Batch Name"), Type = field(Type), "No." = field("No."), Posted = const(false)));
            FieldClass = FlowField;
            Caption = 'Qty. on Req. Line';
        }
        field(50007; "Replenishment System"; Option)
        {
            Caption = 'Replenishment System';
            Description = 'For diff -> Purchase/Transfer/Prod';
            Editable = false;
            OptionCaption = 'Purchase,Prod. Order,Transfer, ';
            OptionMembers = Purchase,"Prod. Order",Transfer," ";
            DataClassification = CustomerContent;
        }
        field(50008; "Action Message"; Option)
        {
            Caption = 'Action Message';
            OptionCaption = ' ,New,Change Qty.,Reschedule,Resched. & Chg. Qty.,Cancel';
            OptionMembers = " ",New,"Change Qty.",Reschedule,"Resched. & Chg. Qty.",Cancel;
            DataClassification = CustomerContent;
        }
        field(50009; "Created Doc. SubType"; Option)
        {
            Description = 'for New Purchase->Quot/Order/Sch.Order';
            Editable = false;
            OptionCaption = ' ,P.Quote,P.Order,P.SchOrder';
            OptionMembers = " ","P.Quote","P.Order","P.SchOrder";
            DataClassification = CustomerContent;
            Caption = 'Created Doc. SubType';
        }
        field(50010; "Created Doc. No."; Code[20])
        {
            Description = 'for New Purchase->doc. No';
            Editable = false;
            DataClassification = CustomerContent;
            Caption = 'Created Doc. No.';
        }
        field(50011; "Pending PO"; Boolean)
        {
            Description = 'for New Purchase->PO  is created or not';
            Editable = false;
            DataClassification = CustomerContent;
            Caption = 'Pending PO';
        }
        field(50012; "Quotation Qty"; Decimal)
        {
            CalcFormula = sum("SSD Posted Req. Purch. Line"."Requisition Qty" where("Posted Indent Document No." = field("Document No."), "Posted Indent Line No." = field("Line No."), "Purch. Document Type" = const(Quote)));
            FieldClass = FlowField;
            Caption = 'Quotation Qty';
        }
        field(50013; "Template Name"; Code[10])
        {
            TableRelation = "Req. Wksh. Template" where("Page ID" = const(291), Recurring = const(false), Type = const("Req."));
            DataClassification = CustomerContent;
            Caption = 'Template Name';
        }
        field(50014; "Batch Name"; Code[10])
        {
            TableRelation = "Requisition Wksh. Name".Name where("Worksheet Template Name" = field("Template Name"));
            DataClassification = CustomerContent;
            Caption = 'Batch Name';
        }
        field(50015; "Receipt qty"; Decimal)
        {
            CalcFormula = sum("SSD Posted Req. Purch. Line"."Requisition Qty" where("Posted Indent Document No." = field("Document No."), "Posted Indent Line No." = field("Line No."), "Purch. Document Type" = const(Receipt)));
            FieldClass = FlowField;
            Caption = 'Receipt qty';
        }
        field(50016; "Created Doc. Line No."; Integer)
        {
            Description = 'for New Purchase->doc. Line No';
            Editable = false;
            DataClassification = CustomerContent;
            Caption = 'Created Doc. Line No.';
        }
        field(50017; "Schedule Qty"; Decimal)
        {
            CalcFormula = sum("SSD Posted Req. Purch. Line"."Requisition Qty" where("Posted Indent Document No." = field("Document No."), "Posted Indent Line No." = field("Line No."), "Purch. Document Type" = const("Blanket Order")));
            FieldClass = FlowField;
            Caption = 'Schedule Qty';
        }
        field(50019; "Pending PO Qty"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Pending PO Qty';
        }
        field(50020; "Qty. On Released Orders"; Decimal)
        {
            CalcFormula = sum("Purchase Line".Quantity where("Posted Indent No." = field("Document No."), "Posted Indent Line No." = field("Line No."), Type = field(Type), "No." = field("No."), "Document Type" = filter(Order), "P.O Status" = filter(Released)));
            FieldClass = FlowField;
            Caption = 'Qty. On Released Orders';
        }
        field(50021; "Qty Received"; Decimal)
        {
            CalcFormula = sum("Purch. Rcpt. Line".Quantity where("Posted Indent No." = field("Document No."), "Posted Indent Line No." = field("Line No."), Type = field(Type), "No." = field("No.")));
            FieldClass = FlowField;
            Caption = 'Qty Received';
        }
        field(50350; "SSD PO Line Type"; Enum "Purchase Line Type")
        {
            Caption = 'PO Line Type';
            Editable = false;
        }
        field(50351; "SSD Req Line Type"; Enum "Requisition Line Type")
        {
            Caption = 'Req Line Type';
            Editable = false;
        }
        field(55000; "Cancelled Quantity"; Decimal)
        {
            Description = 'SSD';
            Editable = false;
            DataClassification = CustomerContent;
            Caption = 'Cancelled Quantity';
        }
        field(55001; "Description 3"; Text[300])
        {
            DataClassification = CustomerContent;
            Caption = 'Description 3';
        }
        field(55002; "Indent Order Type"; Option)
        {
            OptionMembers = " ",Inventory,"Fixed Assets",Services;
            DataClassification = CustomerContent;
        }
        field(99000882; "Gen.Prod.Posting Group"; Code[20])
        {
            TableRelation = "Gen. Product Posting Group";
            DataClassification = CustomerContent;
            Caption = 'Gen.Prod.Posting Group';
        }
    }
    keys
    {
        key(Key1; "Document No.", "Line No.", Type, "No.")
        {
            Clustered = true;
        }
        key(Key2; "No.")
        {
        }
        key(Key3; "Replenishment System", "Action Message", "Created Doc. SubType", "Pending PO", "Created Doc. No.", Type, "No.")
        {
        }
        key(Key4; "Replenishment System", "Action Message", "Document No.", "Line No.")
        {
        }
    }
    fieldgroups
    {
    }
    trigger OnDelete()
    begin
        /* // BIS 1145
            PostedDocDim.RESET;
            PostedDocDim.SETRANGE("Table ID",DATABASE::"Posted Indent Line");
            PostedDocDim.SETRANGE("Document No.","Document No.");
            PostedDocDim.SETRANGE("Line No.","Line No.");
            PostedDocDim.DELETEALL;
            */
    end;
}
