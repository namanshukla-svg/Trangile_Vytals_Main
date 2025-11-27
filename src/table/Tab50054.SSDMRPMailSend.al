Table 50054 "SSD MRP Mail Send"
{
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Worksheet Template Name"; Code[10])
        {
            Caption = 'Worksheet Template Name';
            DataClassification = CustomerContent;
        }
        field(2; "Journal Batch Name"; Code[10])
        {
            Caption = 'Journal Batch Name';
            DataClassification = CustomerContent;
        }
        field(3; "Line No."; Integer)
        {
            Caption = 'Line No.';
            DataClassification = CustomerContent;
        }
        field(4; Type; Option)
        {
            Caption = 'Type';
            OptionCaption = ' ,G/L Account,Item,Resource';
            OptionMembers = " ","G/L Account",Item,Resource;
            DataClassification = CustomerContent;
        }
        field(5; "No."; Code[20])
        {
            Caption = 'No.';
            TableRelation = if (Type = const("G/L Account")) "G/L Account"
            else if (Type = const(Item)) Item where(Type = const(Inventory))
            else if (Type = const(Resource)) Resource;
            DataClassification = CustomerContent;
        }
        field(6; Description; Text[50])
        {
            Caption = 'Description';
            DataClassification = CustomerContent;
        }
        field(7; "Description 2"; Text[50])
        {
            Caption = 'Description 2';
            DataClassification = CustomerContent;
        }
        field(8; Quantity; Decimal)
        {
            Caption = 'Quantity';
            DecimalPlaces = 0 : 5;
            DataClassification = CustomerContent;

            trigger OnValidate()
            var
                lrec_PostedIndentLine: Record "SSD Posted Indent Line";
                lText50000: label 'Qunatity cannot be greater than %1 from Indent No. %2';
                lText50001: label 'Do You want to delete the Line ';
            begin
            end;
        }
        field(9; "Vendor No."; Code[20])
        {
            Caption = 'Vendor No.';
            TableRelation = Vendor;
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
            DataClassification = CustomerContent;
        }
        field(10; "Direct Unit Cost"; Decimal)
        {
            AutoFormatType = 2;
            Caption = 'Direct Unit Cost';
            DataClassification = CustomerContent;
        }
        field(12; "Due Date"; Date)
        {
            Caption = 'Due Date';
            DataClassification = CustomerContent;
        }
        field(13; "Requester ID"; Code[50])
        {
            Caption = 'Requester ID';
            TableRelation = User."User Name";
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
            DataClassification = CustomerContent;

            trigger OnLookup()
            var
                UserMgt: Codeunit "User Management";
            begin
            end;

            trigger OnValidate()
            var
                UserMgt: Codeunit "User Management";
            begin
            end;
        }
        field(14; Confirmed; Boolean)
        {
            Caption = 'Confirmed';
            DataClassification = CustomerContent;
        }
        field(15; "Shortcut Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,2,1';
            Caption = 'Shortcut Dimension 1 Code';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1));
            DataClassification = CustomerContent;
        }
        field(16; "Shortcut Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,2,2';
            Caption = 'Shortcut Dimension 2 Code';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2));
            DataClassification = CustomerContent;
        }
        field(17; "Location Code"; Code[10])
        {
            Caption = 'Location Code';
            TableRelation = Location where("Use As In-Transit" = const(false));
            DataClassification = CustomerContent;
        }
        field(18; "Recurring Method"; Option)
        {
            BlankZero = true;
            Caption = 'Recurring Method';
            OptionCaption = ',Fixed,Variable';
            OptionMembers = ,"Fixed",Variable;
            DataClassification = CustomerContent;
        }
        field(19; "Expiration Date"; Date)
        {
            Caption = 'Expiration Date';
            DataClassification = CustomerContent;
        }
        field(20; "Recurring Frequency"; DateFormula)
        {
            Caption = 'Recurring Frequency';
            DataClassification = CustomerContent;
        }
        field(21; "Order Date"; Date)
        {
            Caption = 'Order Date';
            DataClassification = CustomerContent;
        }
        field(22; "Vendor Item No."; Text[20])
        {
            Caption = 'Vendor Item No.';
            DataClassification = CustomerContent;
        }
        field(23; "Sales Order No."; Code[20])
        {
            Caption = 'Sales Order No.';
            Editable = false;
            TableRelation = "Sales Header"."No." where("Document Type" = const(Order));
            DataClassification = CustomerContent;
        }
        field(24; "Sales Order Line No."; Integer)
        {
            Caption = 'Sales Order Line No.';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(25; "Sell-to Customer No."; Code[20])
        {
            Caption = 'Sell-to Customer No.';
            Editable = false;
            TableRelation = Customer;
            DataClassification = CustomerContent;
        }
        field(26; "Ship-to Code"; Code[10])
        {
            Caption = 'Ship-to Code';
            Editable = false;
            TableRelation = "Ship-to Address".Code where("Customer No." = field("Sell-to Customer No."));
            DataClassification = CustomerContent;
        }
        field(28; "Order Address Code"; Code[10])
        {
            Caption = 'Order Address Code';
            TableRelation = "Order Address".Code where("Vendor No." = field("Vendor No."));
            DataClassification = CustomerContent;
        }
        field(29; "Currency Code"; Code[10])
        {
            Caption = 'Currency Code';
            TableRelation = Currency;
            DataClassification = CustomerContent;
        }
        field(30; "Currency Factor"; Decimal)
        {
            Caption = 'Currency Factor';
            DecimalPlaces = 0 : 15;
            MinValue = 0;
            DataClassification = CustomerContent;
        }
        field(31; "Reserved Quantity"; Decimal)
        {
            CalcFormula = sum("Reservation Entry".Quantity where("Source ID" = field("Worksheet Template Name"), "Source Ref. No." = field("Line No."), "Source Type" = const(246), "Source Subtype" = const(0), "Source Batch Name" = field("Journal Batch Name"), "Source Prod. Order Line" = const(0), "Reservation Status" = const(Reservation)));
            Caption = 'Reserved Quantity';
            DecimalPlaces = 0 : 5;
            Editable = false;
            FieldClass = FlowField;
        }
        field(480; "Dimension Set ID"; Integer)
        {
            Caption = 'Dimension Set ID';
            Editable = false;
            TableRelation = "Dimension Set Entry";
            DataClassification = CustomerContent;
        }
        field(5401; "Prod. Order No."; Code[20])
        {
            Caption = 'Prod. Order No.';
            Editable = false;
            TableRelation = "Production Order"."No." where(Status = const(Released));
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
            DataClassification = CustomerContent;
        }
        field(5402; "Variant Code"; Code[10])
        {
            Caption = 'Variant Code';
            TableRelation = if (Type = const(Item)) "Item Variant".Code where("Item No." = field("No."));
            DataClassification = CustomerContent;
        }
        field(5403; "Bin Code"; Code[20])
        {
            Caption = 'Bin Code';
            TableRelation = Bin.Code where("Location Code" = field("Location Code"), "Item Filter" = field("No."), "Variant Filter" = field("Variant Code"));
            DataClassification = CustomerContent;
        }
        field(5404; "Qty. per Unit of Measure"; Decimal)
        {
            Caption = 'Qty. per Unit of Measure';
            DecimalPlaces = 0 : 5;
            Editable = true;
            InitValue = 1;
            DataClassification = CustomerContent;
        }
        field(5407; "Unit of Measure Code"; Code[10])
        {
            Caption = 'Unit of Measure Code';
            TableRelation = if (Type = const(Item)) "Item Unit of Measure".Code where("Item No." = field("No."))
            else
            "Unit of Measure";
            DataClassification = CustomerContent;
        }
        field(5408; "Quantity (Base)"; Decimal)
        {
            Caption = 'Quantity (Base)';
            DecimalPlaces = 0 : 5;
            DataClassification = CustomerContent;
        }
        field(5431; "Reserved Qty. (Base)"; Decimal)
        {
            CalcFormula = sum("Reservation Entry"."Quantity (Base)" where("Source ID" = field("Worksheet Template Name"), "Source Ref. No." = field("Line No."), "Source Type" = const(246), "Source Subtype" = const(0), "Source Batch Name" = field("Journal Batch Name"), "Source Prod. Order Line" = const(0), "Reservation Status" = const(Reservation)));
            Caption = 'Reserved Qty. (Base)';
            DecimalPlaces = 0 : 5;
            Editable = false;
            FieldClass = FlowField;
        }
        field(5520; "Demand Type"; Integer)
        {
            Caption = 'Demand Type';
            Editable = false;
            DataClassification = CustomerContent;
            //SSD TableRelation = Object.ID where(Type = const(Table));
        }
        field(5521; "Demand Subtype"; Option)
        {
            Caption = 'Demand Subtype';
            Editable = false;
            OptionCaption = '0,1,2,3,4,5,6,7,8,9';
            OptionMembers = "0","1","2","3","4","5","6","7","8","9";
            DataClassification = CustomerContent;
        }
        field(5522; "Demand Order No."; Code[20])
        {
            Caption = 'Demand Order No.';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(5525; "Demand Line No."; Integer)
        {
            Caption = 'Demand Line No.';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(5526; "Demand Ref. No."; Integer)
        {
            Caption = 'Demand Ref. No.';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(5527; Status; Option)
        {
            Caption = 'Status';
            Editable = false;
            OptionCaption = '0,1,2,3,4,5,6,7,8,9,10';
            OptionMembers = "0","1","2","3","4","5","6","7","8","9","10";
            DataClassification = CustomerContent;
        }
        field(5530; "Demand Date"; Date)
        {
            Caption = 'Demand Date';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(5532; "Demand Quantity"; Decimal)
        {
            Caption = 'Demand Quantity';
            DecimalPlaces = 0 : 5;
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(5533; "Demand Quantity (Base)"; Decimal)
        {
            Caption = 'Demand Quantity (Base)';
            DecimalPlaces = 0 : 5;
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(5538; "Needed Quantity"; Decimal)
        {
            BlankZero = true;
            Caption = 'Needed Quantity';
            DecimalPlaces = 0 : 5;
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(5539; "Needed Quantity (Base)"; Decimal)
        {
            BlankZero = true;
            Caption = 'Needed Quantity (Base)';
            DecimalPlaces = 0 : 5;
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(5540; Reserve; Boolean)
        {
            Caption = 'Reserve';
            DataClassification = CustomerContent;
        }
        field(5541; "Qty. per UOM (Demand)"; Decimal)
        {
            Caption = 'Qty. per UOM (Demand)';
            DecimalPlaces = 0 : 5;
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(5542; "Unit Of Measure Code (Demand)"; Code[10])
        {
            Caption = 'Unit Of Measure Code (Demand)';
            Editable = false;
            TableRelation = if (Type = const(Item)) "Item Unit of Measure".Code where("Item No." = field("No."));
            DataClassification = CustomerContent;
        }
        field(5552; "Supply From"; Code[20])
        {
            Caption = 'Supply From';
            TableRelation = if ("Replenishment System" = const(Purchase)) Vendor
            else if ("Replenishment System" = const(Transfer)) Location where("Use As In-Transit" = const(false));
            DataClassification = CustomerContent;
        }
        field(5553; "Original Item No."; Code[20])
        {
            Caption = 'Original Item No.';
            Editable = false;
            TableRelation = Item;
            DataClassification = CustomerContent;
        }
        field(5554; "Original Variant Code"; Code[10])
        {
            Caption = 'Original Variant Code';
            Editable = false;
            TableRelation = "Item Variant".Code where("Item No." = field("Original Item No."));
            DataClassification = CustomerContent;
        }
        field(5560; Level; Integer)
        {
            Caption = 'Level';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(5563; "Demand Qty. Available"; Decimal)
        {
            Caption = 'Demand Qty. Available';
            DecimalPlaces = 0 : 5;
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(5590; "User ID"; Code[50])
        {
            Caption = 'User ID';
            Editable = false;
            TableRelation = User."User Name";
            DataClassification = CustomerContent;

            //This property is currently not supported
            //TestTableRelation = false;
            trigger OnLookup()
            var
                UserMgt: Codeunit "User Management";
            begin
            end;
        }
        field(5701; "Item Category Code"; Code[20])
        {
            Caption = 'Item Category Code';
            TableRelation = if (Type = const(Item)) "Item Category";
            DataClassification = CustomerContent;
        }
        field(5702; Nonstock; Boolean)
        {
            Caption = 'Nonstock';
            DataClassification = CustomerContent;
        }
        field(5703; "Purchasing Code"; Code[10])
        {
            Caption = 'Purchasing Code';
            TableRelation = Purchasing;
            DataClassification = CustomerContent;
        }
        field(5705; "Product Group Code"; Code[10])
        {
            Caption = 'Product Group Code';
            TableRelation = "Item Category".Code where(Code = field("Item Category Code"));
            DataClassification = CustomerContent;
        }
        field(5706; "Transfer-from Code"; Code[10])
        {
            Caption = 'Transfer-from Code';
            Editable = false;
            TableRelation = Location where("Use As In-Transit" = const(false));
            DataClassification = CustomerContent;
        }
        field(5707; "Transfer Shipment Date"; Date)
        {
            Caption = 'Transfer Shipment Date';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(7002; "Line Discount %"; Decimal)
        {
            Caption = 'Line Discount %';
            MaxValue = 100;
            MinValue = 0;
            DataClassification = CustomerContent;
        }
        field(50001; "Responsibility Center"; Code[20])
        {
            //SSD CalcFormula = lookup("Req. Wksh. Template".Field4 where(Name = field("Worksheet Template Name")));
            Description = 'CF001';
            Editable = false;
            FieldClass = FlowField;
            Caption = 'Responsibility Center';
        }
        field(50002; "Created PO Doc. type"; Option)
        {
            Description = 'IND for Purchase(New) -> Euote/Order/Sch. Order';
            Editable = true;
            OptionCaption = ' ,Quote,Order,Sch. Order';
            OptionMembers = " ",Quote,"Order","Sch. Order";
            Caption = 'Created PO Doc. type';
            DataClassification = CustomerContent;
        }
        field(50003; "Created PO No. Series"; Code[10])
        {
            Description = 'IND For selection of Particular No series';
            TableRelation = "No. Series".Code;
            Caption = 'Created PO No. Series';
            DataClassification = CustomerContent;

            trigger OnLookup()
            var
                PurchSetup: Record "Purchases & Payables Setup";
                ResponsibilityCenterLocal: Record "Responsibility Center";
            begin
            end;

            trigger OnValidate()
            var
                NoSeriesLocal: Record "No. Series";
            begin
            end;
        }
        field(50004; Posted; Boolean)
        {
            Description = 'IND';
            Editable = true;
            Caption = 'Posted';
            DataClassification = CustomerContent;
        }
        field(50005; "Pending PO"; Boolean)
        {
            Description = 'IND';
            Editable = true;
            Caption = 'Pending PO';
            DataClassification = CustomerContent;
        }
        field(50006; "Pending PO Qty"; Decimal)
        {
            Description = 'IND';
            Editable = true;
            Caption = 'Pending PO Qty';
            DataClassification = CustomerContent;
        }
        field(50007; "Requested PO Qty"; Decimal)
        {
            Description = 'IND required at the time of Po creation';
            Caption = 'Requested PO Qty';
            DataClassification = CustomerContent;
        }
        field(50008; "For Tool Room"; Boolean)
        {
            Description = 'TR coming from Item';
            Caption = 'For Tool Room';
            DataClassification = CustomerContent;
        }
        field(50010; "Create SOB"; Boolean)
        {
            Description = 'SOB';
            Caption = 'Create SOB';
            DataClassification = CustomerContent;
        }
        field(50011; "SOB Entry"; Boolean)
        {
            Description = 'SOB';
            Caption = 'SOB Entry';
            DataClassification = CustomerContent;
        }
        field(50012; "Vendor Name"; Text[30])
        {
            Description = 'SOB';
            Caption = 'Vendor Name';
            DataClassification = CustomerContent;
        }
        field(50017; "No. of Archived Versions"; Integer)
        {
            CalcFormula = max("SSD Requisition Line Archive"."Version No." where("Worksheet Template Name" = field("Worksheet Template Name"), "Journal Batch Name" = field("Journal Batch Name"), "Line No." = field("Line No.")));
            Description = 'ALLE NV';
            FieldClass = FlowField;
            Caption = 'No. of Archived Versions';
        }
        field(54001; "Shelf No."; Code[20])
        {
            Description = 'CF001';
            Caption = 'Shelf No.';
            DataClassification = CustomerContent;
            //SSD TableRelation = Table0;
        }
        field(54002; "Indent No."; Code[20])
        {
            Description = 'CF001';
            Caption = 'Indent No.';
            DataClassification = CustomerContent;
        }
        field(54003; "Indent Line No."; Integer)
        {
            Description = 'CF001';
            Caption = 'Indent Line No.';
            DataClassification = CustomerContent;
        }
        field(54004; Remarks; Text[200])
        {
            Description = 'CF001';
            Caption = 'Remarks';
            DataClassification = CustomerContent;
        }
        field(54005; "Expected Cost"; Decimal)
        {
            CalcFormula = lookup("SSD Posted Indent Line"."Expected Cost" where("Document No." = field("Indent No."), Type = field(Type), "No." = field("No.")));
            FieldClass = FlowField;
            Caption = 'Expected Cost';
        }
        field(54006; "No. 2"; Code[20])
        {
            CalcFormula = lookup(Item."No. 2" where("No." = field("No.")));
            Description = 'CE001- Edit no. 2 field from item master';
            FieldClass = FlowField;
            Caption = 'No. 2';
        }
        field(54007; "MRP Qty."; Decimal)
        {
            Caption = 'MRP Qty.';
            DataClassification = CustomerContent;
        }
        field(54008; "MRP Remark"; Text[30])
        {
            Caption = 'MRP Remark';
            DataClassification = CustomerContent;
        }
        field(99000750; "Routing No."; Code[20])
        {
            Caption = 'Routing No.';
            TableRelation = "Routing Header";
            DataClassification = CustomerContent;

            trigger OnValidate()
            var
                RtngDate: Date;
            begin
            end;
        }
        field(99000751; "Operation No."; Code[10])
        {
            Caption = 'Operation No.';
            TableRelation = "Prod. Order Routing Line"."Operation No." where(Status = const(Released), "Prod. Order No." = field("Prod. Order No."), "Routing No." = field("Routing No."));
            DataClassification = CustomerContent;

            trigger OnValidate()
            var
                ProdOrderRtngLine: Record "Prod. Order Routing Line";
            begin
            end;
        }
        field(99000752; "Work Center No."; Code[20])
        {
            Caption = 'Work Center No.';
            TableRelation = "Work Center";
            DataClassification = CustomerContent;
        }
        field(99000754; "Prod. Order Line No."; Integer)
        {
            Caption = 'Prod. Order Line No.';
            Editable = false;
            TableRelation = "Prod. Order Line"."Line No." where(Status = const(Finished), "Prod. Order No." = field("Prod. Order No."));
            DataClassification = CustomerContent;
        }
        field(99000755; "MPS Order"; Boolean)
        {
            Caption = 'MPS Order';
            DataClassification = CustomerContent;
        }
        field(99000756; "Planning Flexibility"; Option)
        {
            Caption = 'Planning Flexibility';
            OptionCaption = 'Unlimited,None';
            OptionMembers = Unlimited,"None";
            DataClassification = CustomerContent;
        }
        field(99000757; "Routing Reference No."; Integer)
        {
            Caption = 'Routing Reference No.';
            DataClassification = CustomerContent;
        }
        field(99000882; "Gen. Prod. Posting Group"; Code[10])
        {
            Caption = 'Gen. Prod. Posting Group';
            TableRelation = "Gen. Product Posting Group";
            DataClassification = CustomerContent;
        }
        field(99000883; "Gen. Business Posting Group"; Code[10])
        {
            Caption = 'Gen. Business Posting Group';
            TableRelation = "Gen. Business Posting Group";
            DataClassification = CustomerContent;
        }
        field(99000884; "Low-Level Code"; Integer)
        {
            Caption = 'Low-Level Code';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(99000885; "Production BOM Version Code"; Code[10])
        {
            Caption = 'Production BOM Version Code';
            TableRelation = "Production BOM Version"."Version Code" where("Production BOM No." = field("Production BOM No."));
            DataClassification = CustomerContent;
        }
        field(99000886; "Routing Version Code"; Code[10])
        {
            Caption = 'Routing Version Code';
            TableRelation = "Routing Version"."Version Code" where("Routing No." = field("Routing No."));
            DataClassification = CustomerContent;
        }
        field(99000887; "Routing Type"; Option)
        {
            Caption = 'Routing Type';
            OptionCaption = 'Serial,Parallel';
            OptionMembers = Serial,Parallel;
            DataClassification = CustomerContent;
        }
        field(99000888; "Original Quantity"; Decimal)
        {
            BlankZero = true;
            Caption = 'Original Quantity';
            DecimalPlaces = 0 : 5;
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(99000889; "Finished Quantity"; Decimal)
        {
            Caption = 'Finished Quantity';
            DecimalPlaces = 0 : 5;
            Editable = false;
            MinValue = 0;
            DataClassification = CustomerContent;
        }
        field(99000890; "Remaining Quantity"; Decimal)
        {
            Caption = 'Remaining Quantity';
            DecimalPlaces = 0 : 5;
            Editable = false;
            MinValue = 0;
            DataClassification = CustomerContent;
        }
        field(99000891; "Original Due Date"; Date)
        {
            Caption = 'Original Due Date';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(99000892; "Scrap %"; Decimal)
        {
            Caption = 'Scrap %';
            DecimalPlaces = 0 : 5;
            DataClassification = CustomerContent;
        }
        field(99000894; "Starting Date"; Date)
        {
            Caption = 'Starting Date';
            DataClassification = CustomerContent;
        }
        field(99000895; "Starting Time"; Time)
        {
            Caption = 'Starting Time';
            DataClassification = CustomerContent;
        }
        field(99000896; "Ending Date"; Date)
        {
            Caption = 'Ending Date';
            DataClassification = CustomerContent;
        }
        field(99000897; "Ending Time"; Time)
        {
            Caption = 'Ending Time';
            DataClassification = CustomerContent;
        }
        field(99000898; "Production BOM No."; Code[20])
        {
            Caption = 'Production BOM No.';
            TableRelation = "Production BOM Header"."No.";
            DataClassification = CustomerContent;

            trigger OnValidate()
            var
                BOMDate: Date;
            begin
            end;
        }
        field(99000899; "Indirect Cost %"; Decimal)
        {
            Caption = 'Indirect Cost %';
            DecimalPlaces = 0 : 5;
            DataClassification = CustomerContent;
        }
        field(99000900; "Overhead Rate"; Decimal)
        {
            Caption = 'Overhead Rate';
            DecimalPlaces = 0 : 5;
            DataClassification = CustomerContent;
        }
        field(99000901; "Unit Cost"; Decimal)
        {
            AutoFormatType = 2;
            Caption = 'Unit Cost';
            MinValue = 0;
            DataClassification = CustomerContent;
        }
        field(99000902; "Cost Amount"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Cost Amount';
            Editable = false;
            MinValue = 0;
            DataClassification = CustomerContent;
        }
        field(99000903; "Replenishment System"; Option)
        {
            Caption = 'Replenishment System';
            OptionCaption = 'Purchase,Prod. Order,Transfer,Assembly, ';
            OptionMembers = Purchase,"Prod. Order",Transfer,Assembly," ";
            DataClassification = CustomerContent;

            trigger OnValidate()
            var
                AsmHeader: Record "Assembly Header";
            //  NoSeriesMgt: Codeunit NoSeriesManagement;
            begin
            end;
        }
        field(99000904; "Ref. Order No."; Code[20])
        {
            Caption = 'Ref. Order No.';
            Editable = false;
            TableRelation = if ("Ref. Order Type" = const("Prod. Order")) "Production Order"."No." where(Status = field("Ref. Order Status"))
            else if ("Ref. Order Type" = const(Purchase)) "Purchase Header"."No." where("Document Type" = const(Order))
            else if ("Ref. Order Type" = const(Transfer)) "Transfer Header"."No." where("No." = field("Ref. Order No."))
            else if ("Ref. Order Type" = const(Assembly)) "Assembly Header"."No." where("Document Type" = const(Order));
            ValidateTableRelation = false;
            DataClassification = CustomerContent;

            trigger OnLookup()
            var
                PurchHeader: Record "Purchase Header";
                ProdOrder: Record "Production Order";
                TransHeader: Record "Transfer Header";
                AsmHeader: Record "Assembly Header";
            begin
            end;
        }
        field(99000905; "Ref. Order Type"; Option)
        {
            Caption = 'Ref. Order Type';
            Editable = false;
            OptionCaption = ' ,Purchase,Prod. Order,Transfer,Assembly';
            OptionMembers = " ",Purchase,"Prod. Order",Transfer,Assembly;
            DataClassification = CustomerContent;
        }
        field(99000906; "Ref. Order Status"; Option)
        {
            BlankZero = true;
            Caption = 'Ref. Order Status';
            Editable = false;
            OptionCaption = ',Planned,Firm Planned,Released';
            OptionMembers = ,Planned,"Firm Planned",Released;
            DataClassification = CustomerContent;
        }
        field(99000907; "Ref. Line No."; Integer)
        {
            BlankZero = true;
            Caption = 'Ref. Line No.';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(99000908; "No. Series"; Code[10])
        {
            Caption = 'No. Series';
            Editable = false;
            TableRelation = "No. Series";
            DataClassification = CustomerContent;
        }
        field(99000909; "Expected Operation Cost Amt."; Decimal)
        {
            AutoFormatType = 1;
            CalcFormula = sum("Planning Routing Line"."Expected Operation Cost Amt." where("Worksheet Template Name" = field("Worksheet Template Name"), "Worksheet Batch Name" = field("Journal Batch Name"), "Worksheet Line No." = field("Line No.")));
            Caption = 'Expected Operation Cost Amt.';
            Editable = false;
            FieldClass = FlowField;
        }
        field(99000910; "Expected Component Cost Amt."; Decimal)
        {
            AutoFormatType = 1;
            CalcFormula = sum("Planning Component"."Cost Amount" where("Worksheet Template Name" = field("Worksheet Template Name"), "Worksheet Batch Name" = field("Journal Batch Name"), "Worksheet Line No." = field("Line No.")));
            Caption = 'Expected Component Cost Amt.';
            Editable = false;
            FieldClass = FlowField;
        }
        field(99000911; "Finished Qty. (Base)"; Decimal)
        {
            Caption = 'Finished Qty. (Base)';
            DecimalPlaces = 0 : 5;
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(99000912; "Remaining Qty. (Base)"; Decimal)
        {
            Caption = 'Remaining Qty. (Base)';
            DecimalPlaces = 0 : 5;
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(99000913; "Related to Planning Line"; Integer)
        {
            Caption = 'Related to Planning Line';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(99000914; "Planning Level"; Integer)
        {
            Caption = 'Planning Level';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(99000915; "Planning Line Origin"; Option)
        {
            Caption = 'Planning Line Origin';
            Editable = false;
            OptionCaption = ' ,Action Message,Planning,Order Planning';
            OptionMembers = " ","Action Message",Planning,"Order Planning";
            DataClassification = CustomerContent;
        }
        field(99000916; "Action Message"; Option)
        {
            Caption = 'Action Message';
            OptionCaption = ' ,New,Change Qty.,Reschedule,Resched. & Chg. Qty.,Cancel';
            OptionMembers = " ",New,"Change Qty.",Reschedule,"Resched. & Chg. Qty.",Cancel;
            DataClassification = CustomerContent;
        }
        field(99000917; "Accept Action Message"; Boolean)
        {
            Caption = 'Accept Action Message';
            DataClassification = CustomerContent;
        }
        field(99000918; "Net Quantity (Base)"; Decimal)
        {
            Caption = 'Net Quantity (Base)';
            DecimalPlaces = 0 : 5;
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(99000919; "Starting Date-Time"; DateTime)
        {
            Caption = 'Starting Date-Time';
            DataClassification = CustomerContent;
        }
        field(99000920; "Ending Date-Time"; DateTime)
        {
            Caption = 'Ending Date-Time';
            DataClassification = CustomerContent;
        }
        field(99000921; "Order Promising ID"; Code[20])
        {
            Caption = 'Order Promising ID';
            DataClassification = CustomerContent;
        }
        field(99000922; "Order Promising Line No."; Integer)
        {
            Caption = 'Order Promising Line No.';
            DataClassification = CustomerContent;
        }
        field(99000923; "Order Promising Line ID"; Integer)
        {
            Caption = 'Order Promising Line ID';
            DataClassification = CustomerContent;
        }
    }
    keys
    {
        key(Key1; "Worksheet Template Name", "Journal Batch Name", "Line No.")
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
    }
}
