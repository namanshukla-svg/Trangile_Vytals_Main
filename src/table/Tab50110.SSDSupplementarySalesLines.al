Table 50110 "SSD Supplementary Sales Lines"
{
    // CF001 01.03.2006 New fields are added 50050..54065
    Caption = 'Sales Line Archive';
    //SSD DrillDownPageID = UnknownPage65094;
    //SSD LookupPageID = UnknownPage65094;
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Document Type"; Option)
        {
            Caption = 'Document Type';
            OptionCaption = 'Quote,Order,Invoice,Credit Memo,Blanket Order,Return Order';
            OptionMembers = Quote, "Order", Invoice, "Credit Memo", "Blanket Order", "Return Order";
            DataClassification = CustomerContent;
        }
        field(2; "Sell-to Customer No."; Code[20])
        {
            Caption = 'Sell-to Customer No.';
            TableRelation = Customer;
            DataClassification = CustomerContent;
        }
        field(3; "Document No."; Code[20])
        {
            Caption = 'Document No.';
            TableRelation = "Sales Header Archive"."No." where("Document Type"=field("Document Type"), "Version No."=field("Version No."));
            DataClassification = CustomerContent;
        }
        field(4; "Line No."; Integer)
        {
            Caption = 'Line No.';
            DataClassification = CustomerContent;
        }
        field(5; Type; Option)
        {
            Caption = 'Type';
            OptionCaption = ' ,G/L Account,Item,Resource,Fixed Asset,Charge (Item)';
            OptionMembers = " ", "G/L Account", Item, Resource, "Fixed Asset", "Charge (Item)";
            DataClassification = CustomerContent;
        }
        field(6; "No."; Code[20])
        {
            Caption = 'No.';
            TableRelation = if(Type=const(" "))"Standard Text"
            else if(Type=const("G/L Account"))"G/L Account"
            else if(Type=const(Item))Item
            else if(Type=const(Resource))Resource
            else if(Type=const("Fixed Asset"))"Fixed Asset"
            else if(Type=const("Charge (Item)"))"Item Charge";
            DataClassification = CustomerContent;
        }
        field(7; "Location Code"; Code[10])
        {
            Caption = 'Location Code';
            TableRelation = Location where("Use As In-Transit"=const(false));
            DataClassification = CustomerContent;
        }
        field(8; "Posting Group"; Code[10])
        {
            Caption = 'Posting Group';
            TableRelation = if(Type=const(Item))"Inventory Posting Group"
            else if(Type=const("Fixed Asset"))"FA Posting Group";
            DataClassification = CustomerContent;
        }
        field(9; "Quantity Disc. Code"; Code[20])
        {
            Caption = 'Quantity Disc. Code';
            DataClassification = CustomerContent;
        }
        field(10; "Shipment Date"; Date)
        {
            Caption = 'Shipment Date';
            DataClassification = CustomerContent;
        }
        field(11; Description; Text[50])
        {
            Caption = 'Description';
            DataClassification = CustomerContent;
        }
        field(12; "Description 2"; Text[50])
        {
            Caption = 'Description 2';
            DataClassification = CustomerContent;
        }
        field(13; "Unit of Measure"; Text[10])
        {
            Caption = 'Unit of Measure';
            DataClassification = CustomerContent;
        }
        field(15; Quantity; Decimal)
        {
            Caption = 'Quantity';
            DecimalPlaces = 0: 5;
            DataClassification = CustomerContent;
        }
        field(16; "Outstanding Quantity"; Decimal)
        {
            Caption = 'Outstanding Quantity';
            DecimalPlaces = 0: 5;
            DataClassification = CustomerContent;
        }
        field(17; "Qty. to Invoice"; Decimal)
        {
            Caption = 'Qty. to Invoice';
            DecimalPlaces = 0: 5;
            DataClassification = CustomerContent;
        }
        field(18; "Qty. to Ship"; Decimal)
        {
            Caption = 'Qty. to Ship';
            DecimalPlaces = 0: 5;
            DataClassification = CustomerContent;
        }
        field(22; "Unit Price"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 2;
            CaptionClass = GetCaptionClass(FIELDNO("Unit Price"));
            Caption = 'Unit Price';
            DataClassification = CustomerContent;
        }
        field(23; "Unit Cost (LCY)"; Decimal)
        {
            AutoFormatType = 2;
            Caption = 'Unit Cost (LCY)';
            DataClassification = CustomerContent;
        }
        field(25; "VAT %"; Decimal)
        {
            Caption = 'VAT %';
            DecimalPlaces = 0: 5;
            DataClassification = CustomerContent;
        }
        field(26; "Quantity Disc. %"; Decimal)
        {
            Caption = 'Quantity Disc. %';
            DecimalPlaces = 0: 5;
            MaxValue = 100;
            MinValue = 0;
            DataClassification = CustomerContent;
        }
        field(27; "Line Discount %"; Decimal)
        {
            Caption = 'Line Discount %';
            DecimalPlaces = 0: 5;
            MaxValue = 100;
            MinValue = 0;
            DataClassification = CustomerContent;
        }
        field(28; "Line Discount Amount"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'Line Discount Amount';
            DataClassification = CustomerContent;
        }
        field(29; Amount; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'Amount';
            DataClassification = CustomerContent;
        }
        field(30; "Amount Including VAT"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'Amount Including VAT';
            DataClassification = CustomerContent;
        }
        field(32; "Allow Invoice Disc."; Boolean)
        {
            Caption = 'Allow Invoice Disc.';
            InitValue = true;
            DataClassification = CustomerContent;
        }
        field(34; "Gross Weight"; Decimal)
        {
            Caption = 'Gross Weight';
            DecimalPlaces = 0: 5;
            DataClassification = CustomerContent;
        }
        field(35; "Net Weight"; Decimal)
        {
            Caption = 'Net Weight';
            DecimalPlaces = 0: 5;
            DataClassification = CustomerContent;
        }
        field(36; "Units per Parcel"; Decimal)
        {
            Caption = 'Units per Parcel';
            DecimalPlaces = 0: 5;
            DataClassification = CustomerContent;
        }
        field(37; "Unit Volume"; Decimal)
        {
            Caption = 'Unit Volume';
            DecimalPlaces = 0: 5;
            DataClassification = CustomerContent;
        }
        field(38; "Appl.-to Item Entry"; Integer)
        {
            Caption = 'Appl.-to Item Entry';
            DataClassification = CustomerContent;
        }
        field(40; "Shortcut Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,2,1';
            Caption = 'Shortcut Dimension 1 Code';
            TableRelation = "Dimension Value".Code where("Global Dimension No."=const(1));
            DataClassification = CustomerContent;
        }
        field(41; "Shortcut Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,2,2';
            Caption = 'Shortcut Dimension 2 Code';
            TableRelation = "Dimension Value".Code where("Global Dimension No."=const(2));
            DataClassification = CustomerContent;
        }
        field(42; "Price Group Code"; Code[10])
        {
            Caption = 'Price Group Code';
            TableRelation = "Customer Price Group";
            DataClassification = CustomerContent;
        }
        field(43; "Allow Quantity Disc."; Boolean)
        {
            Caption = 'Allow Quantity Disc.';
            InitValue = true;
            DataClassification = CustomerContent;
        }
        field(45; "Job No."; Code[20])
        {
            Caption = 'Job No.';
            TableRelation = Job;
            DataClassification = CustomerContent;
        }
        field(46; "Appl.-to Job Entry"; Integer)
        {
            Caption = 'Appl.-to Job Entry';
            DataClassification = CustomerContent;
        }
        field(47; "Phase Code"; Code[10])
        {
            Caption = 'Phase Code';
            DataClassification = CustomerContent;
        }
        field(48; "Task Code"; Code[10])
        {
            Caption = 'Task Code';
            DataClassification = CustomerContent;
        }
        field(49; "Step Code"; Code[10])
        {
            Caption = 'Step Code';
            DataClassification = CustomerContent;
        }
        field(50; "Job Applies-to ID"; Code[20])
        {
            Caption = 'Job Applies-to ID';
            DataClassification = CustomerContent;
        }
        field(51; "Apply and Close (Job)"; Boolean)
        {
            Caption = 'Apply and Close (Job)';
            DataClassification = CustomerContent;
        }
        field(52; "Work Type Code"; Code[10])
        {
            Caption = 'Work Type Code';
            TableRelation = "Work Type";
            DataClassification = CustomerContent;
        }
        field(55; "Cust./Item Disc. %"; Decimal)
        {
            Caption = 'Cust./Item Disc. %';
            DecimalPlaces = 0: 5;
            MaxValue = 100;
            MinValue = 0;
            DataClassification = CustomerContent;
        }
        field(57; "Outstanding Amount"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'Outstanding Amount';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(58; "Qty. Shipped Not Invoiced"; Decimal)
        {
            Caption = 'Qty. Shipped Not Invoiced';
            DecimalPlaces = 0: 5;
            DataClassification = CustomerContent;
        }
        field(59; "Shipped Not Invoiced"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'Shipped Not Invoiced';
            DataClassification = CustomerContent;
        }
        field(60; "Quantity Shipped"; Decimal)
        {
            Caption = 'Quantity Shipped';
            DecimalPlaces = 0: 5;
            DataClassification = CustomerContent;
        }
        field(61; "Quantity Invoiced"; Decimal)
        {
            Caption = 'Quantity Invoiced';
            DecimalPlaces = 0: 5;
            DataClassification = CustomerContent;
        }
        field(63; "Shipment No."; Code[20])
        {
            Caption = 'Shipment No.';
            DataClassification = CustomerContent;
        }
        field(64; "Shipment Line No."; Integer)
        {
            Caption = 'Shipment Line No.';
            DataClassification = CustomerContent;
        }
        field(67; "Profit %"; Decimal)
        {
            Caption = 'Profit %';
            DecimalPlaces = 0: 5;
            DataClassification = CustomerContent;
        }
        field(68; "Bill-to Customer No."; Code[20])
        {
            Caption = 'Bill-to Customer No.';
            TableRelation = Customer;
            DataClassification = CustomerContent;
        }
        field(69; "Inv. Discount Amount"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'Inv. Discount Amount';
            DataClassification = CustomerContent;
        }
        field(71; "Purchase Order No."; Code[20])
        {
            Caption = 'Purchase Order No.';
            TableRelation = if("Drop Shipment"=const(true))"Purchase Header"."No." where("Document Type"=const(Order));
            DataClassification = CustomerContent;
        }
        field(72; "Purch. Order Line No."; Integer)
        {
            Caption = 'Purch. Order Line No.';
            TableRelation = if("Drop Shipment"=const(true))"Purchase Line"."Line No." where("Document Type"=const(Order), "Document No."=field("Purchase Order No."));
            DataClassification = CustomerContent;
        }
        field(73; "Drop Shipment"; Boolean)
        {
            Caption = 'Drop Shipment';
            DataClassification = CustomerContent;
        }
        field(74; "Gen. Bus. Posting Group"; Code[10])
        {
            Caption = 'Gen. Bus. Posting Group';
            TableRelation = "Gen. Business Posting Group";
            DataClassification = CustomerContent;
        }
        field(75; "Gen. Prod. Posting Group"; Code[10])
        {
            Caption = 'Gen. Prod. Posting Group';
            TableRelation = "Gen. Product Posting Group";
            DataClassification = CustomerContent;
        }
        field(77; "VAT Calculation Type"; Option)
        {
            Caption = 'VAT Calculation Type';
            OptionCaption = 'Normal VAT,Reverse Charge VAT,Full VAT,Sales Tax';
            OptionMembers = "Normal VAT", "Reverse Charge VAT", "Full VAT", "Sales Tax";
            DataClassification = CustomerContent;
        }
        field(78; "Transaction Type"; Code[10])
        {
            Caption = 'Transaction Type';
            TableRelation = "Transaction Type";
            DataClassification = CustomerContent;
        }
        field(79; "Transport Method"; Code[10])
        {
            Caption = 'Transport Method';
            TableRelation = "Transport Method";
            DataClassification = CustomerContent;
        }
        field(80; "Attached to Line No."; Integer)
        {
            Caption = 'Attached to Line No.';
            TableRelation = "Sales Line Archive"."Line No." where("Document Type"=field("Document Type"), "Document No."=field("Document No."), "Doc. No. Occurrence"=field("Doc. No. Occurrence"), "Version No."=field("Version No."));
            DataClassification = CustomerContent;
        }
        field(81; "Exit Point"; Code[10])
        {
            Caption = 'Exit Point';
            TableRelation = "Entry/Exit Point";
            DataClassification = CustomerContent;
        }
        field(82; "Area"; Code[10])
        {
            Caption = 'Area';
            TableRelation = Area;
            DataClassification = CustomerContent;
        }
        field(83; "Transaction Specification"; Code[10])
        {
            Caption = 'Transaction Specification';
            TableRelation = "Transaction Specification";
            DataClassification = CustomerContent;
        }
        field(85; "Tax Area Code"; Code[20])
        {
            Caption = 'Tax Area Code';
            TableRelation = "Tax Area";
            DataClassification = CustomerContent;
        }
        field(86; "Tax Liable"; Boolean)
        {
            Caption = 'Tax Liable';
            DataClassification = CustomerContent;
        }
        field(87; "Tax Group Code"; Code[10])
        {
            Caption = 'Tax Group Code';
            TableRelation = "Tax Group";
            DataClassification = CustomerContent;
        }
        field(89; "VAT Bus. Posting Group"; Code[10])
        {
            Caption = 'VAT Bus. Posting Group';
            TableRelation = "VAT Business Posting Group";
            DataClassification = CustomerContent;
        }
        field(90; "VAT Prod. Posting Group"; Code[10])
        {
            Caption = 'VAT Prod. Posting Group';
            TableRelation = "VAT Product Posting Group";
            DataClassification = CustomerContent;
        }
        field(91; "Currency Code"; Code[10])
        {
            Caption = 'Currency Code';
            TableRelation = Currency;
            DataClassification = CustomerContent;
        }
        field(92; "Outstanding Amount (LCY)"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Outstanding Amount (LCY)';
            DataClassification = CustomerContent;
        }
        field(93; "Shipped Not Invoiced (LCY)"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Shipped Not Invoiced (LCY)';
            DataClassification = CustomerContent;
        }
        field(96; Reserve; Option)
        {
            Caption = 'Reserve';
            OptionCaption = 'Never,Optional,Always';
            OptionMembers = Never, Optional, Always;
            DataClassification = CustomerContent;
        }
        field(97; "Blanket Order No."; Code[20])
        {
            Caption = 'Blanket Order No.';
            TableRelation = "Sales Header"."No." where("Document Type"=const("Blanket Order"));
            DataClassification = CustomerContent;
        //This property is currently not supported
        //TestTableRelation = false;
        }
        field(98; "Blanket Order Line No."; Integer)
        {
            Caption = 'Blanket Order Line No.';
            TableRelation = "Sales Line"."Line No." where("Document Type"=const("Blanket Order"), "Document No."=field("Blanket Order No."));
            DataClassification = CustomerContent;
        //This property is currently not supported
        //TestTableRelation = false;
        }
        field(99; "VAT Base Amount"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'VAT Base Amount';
            DataClassification = CustomerContent;
        }
        field(100; "Unit Cost"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 2;
            Caption = 'Unit Cost';
            DataClassification = CustomerContent;
        }
        field(101; "System-Created Entry"; Boolean)
        {
            Caption = 'System-Created Entry';
            DataClassification = CustomerContent;
        }
        field(103; "Line Amount"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            CaptionClass = GetCaptionClass(FIELDNO("Line Amount"));
            Caption = 'Line Amount';
            DataClassification = CustomerContent;
        }
        field(104; "VAT Difference"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'VAT Difference';
            DataClassification = CustomerContent;
        }
        field(105; "Inv. Disc. Amount to Invoice"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'Inv. Disc. Amount to Invoice';
            DataClassification = CustomerContent;
        }
        field(106; "VAT Identifier"; Code[10])
        {
            Caption = 'VAT Identifier';
            DataClassification = CustomerContent;
        }
        field(5047; "Version No."; Integer)
        {
            Caption = 'Version No.';
            DataClassification = CustomerContent;
        }
        field(5048; "Doc. No. Occurrence"; Integer)
        {
            Caption = 'Doc. No. Occurrence';
            DataClassification = CustomerContent;
        }
        field(5402; "Variant Code"; Code[10])
        {
            Caption = 'Variant Code';
            TableRelation = if(Type=const(Item))"Item Variant".Code where("Item No."=field("No."));
            DataClassification = CustomerContent;
        }
        field(5403; "Bin Code"; Code[20])
        {
            Caption = 'Bin Code';
            TableRelation = Bin.Code where("Location Code"=field("Location Code"));
            DataClassification = CustomerContent;
        }
        field(5404; "Qty. per Unit of Measure"; Decimal)
        {
            Caption = 'Qty. per Unit of Measure';
            DecimalPlaces = 0: 5;
            InitValue = 1;
            DataClassification = CustomerContent;
        }
        field(5405; Planned; Boolean)
        {
            Caption = 'Planned';
            DataClassification = CustomerContent;
        }
        field(5407; "Unit of Measure Code"; Code[10])
        {
            Caption = 'Unit of Measure Code';
            TableRelation = if(Type=const(Item))"Item Unit of Measure".Code where("Item No."=field("No."))
            else
            "Unit of Measure";
            DataClassification = CustomerContent;
        }
        field(5415; "Quantity (Base)"; Decimal)
        {
            Caption = 'Quantity (Base)';
            DecimalPlaces = 0: 5;
            DataClassification = CustomerContent;
        }
        field(5416; "Outstanding Qty. (Base)"; Decimal)
        {
            Caption = 'Outstanding Qty. (Base)';
            DecimalPlaces = 0: 5;
            DataClassification = CustomerContent;
        }
        field(5417; "Qty. to Invoice (Base)"; Decimal)
        {
            Caption = 'Qty. to Invoice (Base)';
            DecimalPlaces = 0: 5;
            DataClassification = CustomerContent;
        }
        field(5418; "Qty. to Ship (Base)"; Decimal)
        {
            Caption = 'Qty. to Ship (Base)';
            DecimalPlaces = 0: 5;
            DataClassification = CustomerContent;
        }
        field(5458; "Qty. Shipped Not Invd. (Base)"; Decimal)
        {
            Caption = 'Qty. Shipped Not Invd. (Base)';
            DecimalPlaces = 0: 5;
            DataClassification = CustomerContent;
        }
        field(5460; "Qty. Shipped (Base)"; Decimal)
        {
            Caption = 'Qty. Shipped (Base)';
            DecimalPlaces = 0: 5;
            DataClassification = CustomerContent;
        }
        field(5461; "Qty. Invoiced (Base)"; Decimal)
        {
            Caption = 'Qty. Invoiced (Base)';
            DecimalPlaces = 0: 5;
            DataClassification = CustomerContent;
        }
        field(5600; "FA Posting Date"; Date)
        {
            Caption = 'FA Posting Date';
            DataClassification = CustomerContent;
        }
        field(5602; "Depreciation Book Code"; Code[10])
        {
            Caption = 'Depreciation Book Code';
            TableRelation = "Depreciation Book";
            DataClassification = CustomerContent;
        }
        field(5605; "Depr. until FA Posting Date"; Boolean)
        {
            Caption = 'Depr. until FA Posting Date';
            DataClassification = CustomerContent;
        }
        field(5612; "Duplicate in Depreciation Book"; Code[10])
        {
            Caption = 'Duplicate in Depreciation Book';
            TableRelation = "Depreciation Book";
            DataClassification = CustomerContent;
        }
        field(5613; "Use Duplication List"; Boolean)
        {
            Caption = 'Use Duplication List';
            DataClassification = CustomerContent;
        }
        field(5700; "Responsibility Center"; Code[10])
        {
            Caption = 'Responsibility Center';
            TableRelation = "Responsibility Center";
            DataClassification = CustomerContent;
        }
        field(5701; "Out-of-Stock Substitution"; Boolean)
        {
            Caption = 'Out-of-Stock Substitution';
            DataClassification = CustomerContent;
        }
        field(5702; "Substitution Available"; Boolean)
        {
            CalcFormula = exist("Item Substitution" where(Type=const(Item), "No."=field("No."), "Substitute Type"=const(Item)));
            Caption = 'Substitution Available';
            Editable = false;
            FieldClass = FlowField;
        }
        field(5703; "Originally Ordered No."; Code[20])
        {
            Caption = 'Originally Ordered No.';
            TableRelation = if(Type=const(Item))Item;
            DataClassification = CustomerContent;
        }
        field(5704; "Originally Ordered Var. Code"; Code[10])
        {
            Caption = 'Originally Ordered Var. Code';
            TableRelation = if(Type=const(Item))"Item Variant".Code where("Item No."=field("Originally Ordered No."));
            DataClassification = CustomerContent;
        }
        field(5705; "Cross-Reference No."; Code[20])
        {
            Caption = 'Cross-Reference No.';
            DataClassification = CustomerContent;
        }
        field(5706; "Unit of Measure (Cross Ref.)"; Code[10])
        {
            Caption = 'Unit of Measure (Cross Ref.)';
            TableRelation = if(Type=const(Item))"Item Unit of Measure".Code where("Item No."=field("No."));
            DataClassification = CustomerContent;
        }
        field(5707; "Cross-Reference Type"; Option)
        {
            Caption = 'Cross-Reference Type';
            OptionCaption = ' ,Customer,Vendor,Bar Code';
            OptionMembers = " ", Customer, Vendor, "Bar Code";
            DataClassification = CustomerContent;
        }
        field(5708; "Cross-Reference Type No."; Code[30])
        {
            Caption = 'Cross-Reference Type No.';
            DataClassification = CustomerContent;
        }
        field(5709; "Item Category Code"; Code[20])
        {
            Caption = 'Item Category Code';
            TableRelation = "Item Category";
            DataClassification = CustomerContent;
        }
        field(5710; Nonstock; Boolean)
        {
            Caption = 'Nonstock';
            DataClassification = CustomerContent;
        }
        field(5711; "Purchasing Code"; Code[10])
        {
            Caption = 'Purchasing Code';
            TableRelation = Purchasing;
            DataClassification = CustomerContent;
        }
        field(5712; "Product Group Code"; Code[10])
        {
            Caption = 'Product Group Code';
            TableRelation = "Item Category".Code where(Code=field("Item Category Code"));
            DataClassification = CustomerContent;
        }
        field(5713; "Special Order"; Boolean)
        {
            Caption = 'Special Order';
            DataClassification = CustomerContent;
        }
        field(5714; "Special Order Purchase No."; Code[20])
        {
            Caption = 'Special Order Purchase No.';
            TableRelation = if("Special Order"=const(true))"Purchase Header"."No." where("Document Type"=const(Order));
            DataClassification = CustomerContent;
        }
        field(5715; "Special Order Purch. Line No."; Integer)
        {
            Caption = 'Special Order Purch. Line No.';
            TableRelation = if("Special Order"=const(true))"Purchase Line"."Line No." where("Document Type"=const(Order), "Document No."=field("Special Order Purchase No."));
            DataClassification = CustomerContent;
        }
        field(5752; "Completely Shipped"; Boolean)
        {
            Caption = 'Completely Shipped';
            DataClassification = CustomerContent;
        }
        field(5790; "Requested Delivery Date"; Date)
        {
            Caption = 'Requested Delivery Date';
            DataClassification = CustomerContent;
        }
        field(5791; "Promised Delivery Date"; Date)
        {
            Caption = 'Promised Delivery Date';
            DataClassification = CustomerContent;
        }
        field(5792; "Shipping Time"; DateFormula)
        {
            Caption = 'Shipping Time';
            DataClassification = CustomerContent;
        }
        field(5793; "Outbound Whse. Handling Time"; DateFormula)
        {
            Caption = 'Outbound Whse. Handling Time';
            DataClassification = CustomerContent;
        }
        field(5794; "Planned Delivery Date"; Date)
        {
            Caption = 'Planned Delivery Date';
            DataClassification = CustomerContent;
        }
        field(5795; "Planned Shipment Date"; Date)
        {
            Caption = 'Planned Shipment Date';
            DataClassification = CustomerContent;
        }
        field(5796; "Shipping Agent Code"; Code[10])
        {
            Caption = 'Shipping Agent Code';
            TableRelation = "Shipping Agent";
            DataClassification = CustomerContent;
        }
        field(5797; "Shipping Agent Service Code"; Code[10])
        {
            Caption = 'Shipping Agent Service Code';
            TableRelation = "Shipping Agent Services".Code where("Shipping Agent Code"=field("Shipping Agent Code"));
            DataClassification = CustomerContent;
        }
        field(5800; "Allow Item Charge Assignment"; Boolean)
        {
            Caption = 'Allow Item Charge Assignment';
            InitValue = true;
            DataClassification = CustomerContent;
        }
        field(5803; "Return Qty. to Receive"; Decimal)
        {
            Caption = 'Return Qty. to Receive';
            DecimalPlaces = 0: 5;
            DataClassification = CustomerContent;
        }
        field(5804; "Return Qty. to Receive (Base)"; Decimal)
        {
            Caption = 'Return Qty. to Receive (Base)';
            DecimalPlaces = 0: 5;
            DataClassification = CustomerContent;
        }
        field(5805; "Return Qty. Rcd. Not Invd."; Decimal)
        {
            Caption = 'Return Qty. Rcd. Not Invd.';
            DecimalPlaces = 0: 5;
            DataClassification = CustomerContent;
        }
        field(5806; "Ret. Qty. Rcd. Not Invd.(Base)"; Decimal)
        {
            Caption = 'Ret. Qty. Rcd. Not Invd.(Base)';
            DecimalPlaces = 0: 5;
            DataClassification = CustomerContent;
        }
        field(5807; "Return Amt. Rcd. Not Invd."; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'Return Amt. Rcd. Not Invd.';
            DataClassification = CustomerContent;
        }
        field(5808; "Ret. Amt. Rcd. Not Invd. (LCY)"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Ret. Amt. Rcd. Not Invd. (LCY)';
            DataClassification = CustomerContent;
        }
        field(5809; "Return Qty. Received"; Decimal)
        {
            Caption = 'Return Qty. Received';
            DecimalPlaces = 0: 5;
            DataClassification = CustomerContent;
        }
        field(5810; "Return Qty. Received (Base)"; Decimal)
        {
            Caption = 'Return Qty. Received (Base)';
            DecimalPlaces = 0: 5;
            DataClassification = CustomerContent;
        }
        field(5811; "Appl.-from Item Entry"; Integer)
        {
            Caption = 'Appl.-from Item Entry';
            MinValue = 0;
            DataClassification = CustomerContent;
        }
        field(5900; "Service Contract No."; Code[20])
        {
            Caption = 'Service Contract No.';
            TableRelation = "Service Contract Header"."Contract No." where("Contract Type"=const(Contract), "Customer No."=field("Sell-to Customer No."), "Bill-to Customer No."=field("Bill-to Customer No."));
            DataClassification = CustomerContent;
        }
        field(5901; "Service Order No."; Code[20])
        {
            Caption = 'Service Order No.';
            DataClassification = CustomerContent;
        }
        field(5902; "Service Item No."; Code[20])
        {
            Caption = 'Service Item No.';
            TableRelation = "Service Item"."No." where("Customer No."=field("Sell-to Customer No."));
            DataClassification = CustomerContent;
        }
        field(5903; "Appl.-to Service Entry"; Integer)
        {
            Caption = 'Appl.-to Service Entry';
            DataClassification = CustomerContent;
        }
        field(5904; "Service Item Line No."; Integer)
        {
            Caption = 'Service Item Line No.';
            DataClassification = CustomerContent;
        }
        field(5907; "Serv. Price Adjmt. Gr. Code"; Code[10])
        {
            Caption = 'Serv. Price Adjmt. Gr. Code';
            TableRelation = "Service Price Adjustment Group";
            DataClassification = CustomerContent;
        }
        field(5909; "BOM Item No."; Code[20])
        {
            Caption = 'BOM Item No.';
            TableRelation = Item;
            DataClassification = CustomerContent;
        }
        field(6600; "Return Receipt No."; Code[20])
        {
            Caption = 'Return Receipt No.';
            DataClassification = CustomerContent;
        }
        field(6601; "Return Receipt Line No."; Integer)
        {
            Caption = 'Return Receipt Line No.';
            DataClassification = CustomerContent;
        }
        field(6608; "Return Reason Code"; Code[10])
        {
            Caption = 'Return Reason Code';
            TableRelation = "Return Reason";
            DataClassification = CustomerContent;
        }
        field(7001; "Allow Line Disc."; Boolean)
        {
            Caption = 'Allow Line Disc.';
            InitValue = true;
            DataClassification = CustomerContent;
        }
        field(7002; "Customer Disc. Group"; Code[10])
        {
            Caption = 'Customer Disc. Group';
            TableRelation = "Customer Discount Group";
            DataClassification = CustomerContent;
        }
        field(13701; "Tax Amount"; Decimal)
        {
            Caption = 'Tax Amount';
            DecimalPlaces = 0: 4;
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(13702; "Excise Bus. Posting Group"; Code[10])
        {
            Caption = 'Excise Bus. Posting Group';
            DataClassification = CustomerContent;
        }
        field(13703; "Excise Prod. Posting Group"; Code[10])
        {
            Caption = 'Excise Prod. Posting Group';
            DataClassification = CustomerContent;
        }
        field(13708; "Excise Amount"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'Excise Amount';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(13709; "BED %"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'BED %';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(13710; "BED Calculation Type"; Option)
        {
            Caption = 'BED Calculation Type';
            OptionCaption = 'Excise %,Amount/Unit,% of Accessable Value,Excise %+Amount/Unit';
            OptionMembers = "Excise %", "Amount/Unit", "% of Accessable Value", "Excise %+Amount/Unit";
            DataClassification = CustomerContent;
        }
        field(13711; "Amount Including Excise"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'Amount Including Excise';
            DataClassification = CustomerContent;
        }
        field(13712; "Excise Base Amount"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'Excise Base Amount';
            DataClassification = CustomerContent;
        }
        field(13715; "Excise Accounting Type"; Option)
        {
            Caption = 'Excise Accounting Type';
            OptionCaption = 'With CENVAT,Without CENVAT';
            OptionMembers = "With CENVAT", "Without CENVAT";
            DataClassification = CustomerContent;
        }
        field(13719; "Excise Base Quantity"; Decimal)
        {
            Caption = 'Excise Base Quantity';
            DataClassification = CustomerContent;
        }
        field(13721; "Tax %"; Decimal)
        {
            Caption = 'Tax %';
            DecimalPlaces = 0: 2;
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(13722; "Amount Including Tax"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'Amount Including Tax';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(13724; "Amount Added to Excise Base"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'Amount Added to Excise Base';
            DataClassification = CustomerContent;
        }
        field(13725; "Amount Added to Tax Base"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'Amount Added to Tax Base';
            DataClassification = CustomerContent;
        }
        field(13727; "Tax Base Amount"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'Tax Base Amount';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(13730; "Work Tax Base Amount"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'Work Tax Base Amount';
            DataClassification = CustomerContent;
        }
        field(13731; "Work Tax %"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'Work Tax %';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(13732; "Work Tax Amount"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'Work Tax Amount';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(13733; "TDS Category"; Option)
        {
            Caption = 'TDS Category';
            OptionCaption = ' ,A,C,S';
            OptionMembers = " ", A, C, S;
            DataClassification = CustomerContent;
        }
        field(13734; "Surcharge %"; Decimal)
        {
            Caption = 'Surcharge %';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(13735; "Surcharge Amount"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'Surcharge Amount';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(13736; "Concessional Code"; Code[10])
        {
            Caption = 'Concessional Code';
            DataClassification = CustomerContent;
        }
        field(13741; "TDS Nature of Deduction"; Code[10])
        {
            Caption = 'TDS Nature of Deduction';
            DataClassification = CustomerContent;
        }
        field(13742; "TDS Assessee Code"; Code[10])
        {
            Caption = 'TDS Assessee Code';
            Editable = false;
            TableRelation = "Assessee Code";
            DataClassification = CustomerContent;
        }
        field(13743; "TDS %"; Decimal)
        {
            Caption = 'TDS %';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(13744; "TDS Amount Including Surcharge"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'TDS Amount Including Surcharge';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(13746; "Bal. TDS Including eCESS"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'Bal. TDS Including eCESS';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(13749; "Claim Deferred Excise"; Boolean)
        {
            Caption = 'Claim Deferred Excise';
            DataClassification = CustomerContent;
        }
        field(13750; "Capital Item"; Boolean)
        {
            Caption = 'Capital Item';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(13751; "AED(GSI) Calculation Type"; Option)
        {
            Caption = 'AED(GSI) Calculation Type';
            OptionCaption = 'Excise %,Amount/Unit,% of Accessable Value,Excise %+Amount/Unit';
            OptionMembers = "Excise %", "Amount/Unit", "% of Accessable Value", "Excise %+Amount/Unit";
            DataClassification = CustomerContent;
        }
        field(13752; "AED(GSI) %"; Decimal)
        {
            Caption = 'AED(GSI) %';
            DataClassification = CustomerContent;
        }
        field(13753; "SED Calculation Type"; Option)
        {
            Caption = 'SED Calculation Type';
            OptionCaption = 'Excise %,Amount/Unit,% of Accessable Value,Excise %+Amount/Unit';
            OptionMembers = "Excise %", "Amount/Unit", "% of Accessable Value", "Excise %+Amount/Unit";
            DataClassification = CustomerContent;
        }
        field(13754; "SED %"; Decimal)
        {
            Caption = 'SED %';
            DataClassification = CustomerContent;
        }
        field(13755; "BED Amount"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'BED Amount';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(13758; "AED(GSI) Amount"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'AED(GSI) Amount';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(13759; "SED Amount"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'SED Amount';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(13761; "SAED Calculation Type"; Option)
        {
            Caption = 'SAED Calculation Type';
            Editable = false;
            OptionCaption = 'Excise %,Amount/Unit,% of Accessable Value,Excise %+Amount/Unit';
            OptionMembers = "Excise %", "Amount/Unit", "% of Accessable Value", "Excise %+Amount/Unit";
            DataClassification = CustomerContent;
        }
        field(13762; "SAED %"; Decimal)
        {
            Caption = 'SAED %';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(13763; "CESS Calculation Type"; Option)
        {
            Caption = 'CESS Calculation Type';
            OptionCaption = 'Excise %,Amount/Unit,% of Accessable Value,Excise %+Amount/Unit';
            OptionMembers = "Excise %", "Amount/Unit", "% of Accessable Value", "Excise %+Amount/Unit";
            DataClassification = CustomerContent;
        }
        field(13764; "CESS %"; Decimal)
        {
            Caption = 'CESS %';
            DataClassification = CustomerContent;
        }
        field(13765; "NCCD Calculation Type"; Option)
        {
            Caption = 'NCCD Calculation Type';
            OptionCaption = 'Excise %,Amount/Unit,% of Accessable Value,Excise %+Amount/Unit';
            OptionMembers = "Excise %", "Amount/Unit", "% of Accessable Value", "Excise %+Amount/Unit";
            DataClassification = CustomerContent;
        }
        field(13766; "NCCD %"; Decimal)
        {
            Caption = 'NCCD %';
            DataClassification = CustomerContent;
        }
        field(13767; "eCess Calculation Type"; Option)
        {
            Caption = 'eCess Calculation Type';
            OptionCaption = 'Excise %,Amount/Unit,% of Accessable Value,Excise %+Amount/Unit';
            OptionMembers = "Excise %", "Amount/Unit", "% of Accessable Value", "Excise %+Amount/Unit";
            DataClassification = CustomerContent;
        }
        field(13768; "eCess %"; Decimal)
        {
            Caption = 'eCess %';
            DataClassification = CustomerContent;
        }
        field(13769; "SAED Amount"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'SAED Amount';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(13770; "CESS Amount"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'CESS Amount';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(13771; "NCCD Amount"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'NCCD Amount';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(13772; "eCess Amount"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'eCess Amount';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(13796; "Form Code"; Code[10])
        {
            Caption = 'Form Code';
            DataClassification = CustomerContent;
        }
        field(13797; "Form No."; Code[10])
        {
            Caption = 'Form No.';
            DataClassification = CustomerContent;
        }
        field(13798; State; Code[10])
        {
            Caption = 'State';
            TableRelation = State;
            DataClassification = CustomerContent;
        }
        field(13799; "TDS Amount"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'TDS Amount';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(16340; "Amount To Customer"; Decimal)
        {
            Caption = 'Amount To Customer';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(16341; "Balance Work Tax Amount"; Decimal)
        {
            Caption = 'Balance Work Tax Amount';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(16342; "Charges To Customer"; Decimal)
        {
            Caption = 'Charges To Customer';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(16343; "TDS Base Amount"; Decimal)
        {
            Caption = 'TDS Base Amount';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(16354; "VAT Amount"; Decimal)
        {
            Caption = 'VAT Amount';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(16355; "Zero Duty Good"; Boolean)
        {
            Caption = 'Zero Duty Good';
            DataClassification = CustomerContent;

            trigger OnValidate()
            var
                Text13700: label 'The value cannot be changed.';
            begin
            end;
        }
        field(16356; "Reverse VAT"; Boolean)
        {
            Caption = 'Reverse VAT';
            DataClassification = CustomerContent;
        }
        field(16360; "Balance Surcharge Amount"; Decimal)
        {
            Caption = 'Balance Surcharge Amount';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(16363; "Surcharge Base Amount"; Decimal)
        {
            Caption = 'Surcharge Base Amount';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(16364; "TDS Group"; Option)
        {
            Caption = 'TDS Group';
            Editable = false;
            OptionCaption = ' ,Contractor,Commission,Professional,Interest,Rent,Dividend,Interest on Securities,Lotteries,Insurance Commission,NSS,Mutual fund,Brokerage,Income from Units,Capital Assets,Horse Races,Sports Association,Payable to Non Residents,Income of Mutual Funds,Units,Foreign Currency Bonds,FII from Securities,Others';
            OptionMembers = " ", Contractor, Commission, Professional, Interest, Rent, Dividend, "Interest on Securities", Lotteries, "Insurance Commission", NSS, "Mutual fund", Brokerage, "Income from Units", "Capital Assets", "Horse Races", "Sports Association", "Payable to Non Residents", "Income of Mutual Funds", Units, "Foreign Currency Bonds", "FII from Securities", Others;
            DataClassification = CustomerContent;
        }
        field(16365; "Work Tax Nature Of Deduction"; Code[10])
        {
            Caption = 'Work Tax Nature Of Deduction';
            DataClassification = CustomerContent;
        }
        field(16366; "Work Tax Group"; Option)
        {
            Caption = 'Work Tax Group';
            Editable = false;
            OptionCaption = ' ,Contractor,Commission,Professional,Interest,Rent,Dividend,Interest on Securities,Lotteries,Insurance Commission,NSS,Mutual fund,Brokerage,Income from Units,Capital Assets,Horse Races,Sports Association,Payable to Non Residents,Income of Mutual Funds,Units,Foreign Currency Bonds,FII from Securities,Others';
            OptionMembers = " ", Contractor, Commission, Professional, Interest, Rent, Dividend, "Interest on Securities", Lotteries, "Insurance Commission", NSS, "Mutual fund", Brokerage, "Income from Units", "Capital Assets", "Horse Races", "Sports Association", "Payable to Non Residents", "Income of Mutual Funds", Units, "Foreign Currency Bonds", "FII from Securities", Others;
            DataClassification = CustomerContent;
        }
        field(16367; "Temp TDS Base"; Decimal)
        {
            Caption = 'Temp TDS Base';
            DataClassification = CustomerContent;
        }
        field(16377; "Service Tax Group"; Code[20])
        {
            Caption = 'Service Tax Group';
            DataClassification = CustomerContent;

            trigger OnValidate()
            var
                CompanyInfo: Record "Company Information";
            begin
            end;
        }
        field(16378; "Service Tax %"; Decimal)
        {
            Caption = 'Service Tax %';
            DataClassification = CustomerContent;
        }
        field(16379; "Service Tax Base"; Decimal)
        {
            Caption = 'Service Tax Base';
            DataClassification = CustomerContent;
        }
        field(16380; "Service Tax Amount"; Decimal)
        {
            Caption = 'Service Tax Amount';
            DataClassification = CustomerContent;
        }
        field(16381; "Service Tax Registration No."; Code[20])
        {
            Caption = 'Service Tax Registration No.';
            DataClassification = CustomerContent;
        }
        field(16382; "Service Tax Abatement"; Decimal)
        {
            Caption = 'Service Tax Abatement';
            DataClassification = CustomerContent;
        }
        field(16383; "eCESS % on TDS"; Decimal)
        {
            Caption = 'eCESS % on TDS';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(16384; "eCESS on TDS Amount"; Decimal)
        {
            Caption = 'eCESS on TDS Amount';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(16385; "Total TDS Including eCESS"; Decimal)
        {
            Caption = 'Total TDS Including eCESS';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(16386; "Per Contract"; Boolean)
        {
            Caption = 'Per Contract';
            DataClassification = CustomerContent;
        }
        field(16390; "Service Tax eCess %"; Decimal)
        {
            Caption = 'Service Tax eCess %';
            DataClassification = CustomerContent;
        }
        field(16391; "Service Tax eCess Amount"; Decimal)
        {
            Caption = 'Service Tax eCess Amount';
            DataClassification = CustomerContent;
        }
        field(16450; "ADET Calculation Type"; Option)
        {
            Caption = 'ADET Calculation Type';
            OptionCaption = 'Excise %,Amount/Unit,% of Accessable Value,Excise %+Amount/Unit';
            OptionMembers = "Excise %", "Amount/Unit", "% of Accessable Value", "Excise %+Amount/Unit";
            DataClassification = CustomerContent;
        }
        field(16451; "ADET %"; Decimal)
        {
            Caption = 'ADET %';
            DataClassification = CustomerContent;
        }
        field(16452; "ADET Amount"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'ADET Amount';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(16453; "AED(TTA) Calculation Type"; Option)
        {
            Caption = 'AED(TTA) Calculation Type';
            OptionCaption = 'Excise %,Amount/Unit,% of Accessable Value,Excise %+Amount/Unit';
            OptionMembers = "Excise %", "Amount/Unit", "% of Accessable Value", "Excise %+Amount/Unit";
            DataClassification = CustomerContent;
        }
        field(16454; "AED(TTA) %"; Decimal)
        {
            Caption = 'AED(TTA) %';
            DataClassification = CustomerContent;
        }
        field(16455; "AED(TTA) Amount"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'AED(TTA) Amount';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(16456; "Free Supply"; Boolean)
        {
            Caption = 'Free Supply';
            DataClassification = CustomerContent;
        }
        field(16457; "ADE Calculation Type"; Option)
        {
            Caption = 'ADE Calculation Type';
            OptionCaption = 'Excise %,Amount/Unit,% of Accessable Value,Excise %+Amount/Unit';
            OptionMembers = "Excise %", "Amount/Unit", "% of Accessable Value", "Excise %+Amount/Unit";
            DataClassification = CustomerContent;
        }
        field(16458; "ADE %"; Decimal)
        {
            Caption = 'ADE %';
            DataClassification = CustomerContent;
        }
        field(16459; "ADE Amount"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'ADE Amount';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(16485; "Total TDS Incl. eCESS (LCY)"; Decimal)
        {
            Caption = 'Total TDS Incl. eCESS (LCY)';
            DataClassification = CustomerContent;
        }
        field(16486; "TDS Amount (LCY)"; Decimal)
        {
            Caption = 'TDS Amount (LCY)';
            DataClassification = CustomerContent;
        }
        field(16487; "Surcharge Amount (LCY)"; Decimal)
        {
            Caption = 'Surcharge Amount (LCY)';
            DataClassification = CustomerContent;
        }
        field(16488; "TDS Including Surcharge (LCY)"; Decimal)
        {
            Caption = 'TDS Including Surcharge (LCY)';
            DataClassification = CustomerContent;
        }
        field(16489; "eCESS on TDS Amount (LCY)"; Decimal)
        {
            Caption = 'eCESS on TDS Amount (LCY)';
            DataClassification = CustomerContent;
        }
        field(16490; "Assessable Value"; Decimal)
        {
            Caption = 'Assessable Value';
            DataClassification = CustomerContent;
        }
        field(50067; "Change After Archieve"; Boolean)
        {
            Description = 'CF003 TRUE -> change after Archieve FALSE -> initial and after Archive';
            Editable = false;
            DataClassification = CustomerContent;
            Caption = 'Change After Archieve';
        }
        field(52006; "Document Subtype"; Option)
        {
            Description = 'CF001';
            OptionCaption = ' ,Sales,Contract,Service Contract,Order,Schedule,Invoice,Despatch';
            OptionMembers = " ", Sales, Contract, "Service Contract", "Order", Schedule, Invoice, Despatch;
            DataClassification = CustomerContent;
            Caption = 'Document Subtype';
        }
        field(53011; "Order No."; Code[20])
        {
            Description = 'CF001';
            Editable = false;
            DataClassification = CustomerContent;
            Caption = 'Order No.';
        }
        field(53012; "Order Line No."; Integer)
        {
            Description = 'CF001';
            DataClassification = CustomerContent;
            Caption = 'Order Line No.';
        }
        field(54060; "Schedule Quantity"; Decimal)
        {
            CalcFormula = sum("SSD Sales Schedule Buffer"."Schedule Quantity" where("Document Type"=field("Document Type"), "Document No."=field("Document No."), "Sell-to Customer No."=field("Sell-to Customer No."), "Item No."=field("No."), "Order Line No."=field("Line No.")));
            Description = 'CF001';
            FieldClass = FlowField;
            Caption = 'Schedule Quantity';

            trigger OnLookup()
            var
                SalesScheduleBufferLocal: Record "SSD Sales Schedule Buffer";
                BlanketScheduleBufferForm: Page "Blanket Schedule Buffer";
            begin
            end;
        }
        field(54061; "No of Pack"; Decimal)
        {
            CalcFormula = sum("SSD Sales Schedule Buffer"."No. of Box" where("Document Type"=field("Document Type"), "Document No."=field("Document No."), "Sell-to Customer No."=field("Sell-to Customer No."), "Item No."=field("No."), "Order Line No."=field("Line No.")));
            Description = 'CF001';
            FieldClass = FlowField;
            Caption = 'No of Pack';

            trigger OnLookup()
            var
                SalesScheduleBufferLocal: Record "SSD Sales Schedule Buffer";
                SalesPacketDetailsForm: Page "Sales Packet Details";
            begin
            end;
        }
        field(54062; "Qty Per Pack"; Decimal)
        {
            Description = 'CF001';
            DataClassification = CustomerContent;
            Caption = 'Qty Per Pack';
        }
        field(54063; "Total Schedule Quantity"; Decimal)
        {
            Description = 'CF001';
            DataClassification = CustomerContent;
            Caption = 'Total Schedule Quantity';
        }
        field(54064; "Despatch Slip No."; Code[20])
        {
            Description = 'CF001';
            Editable = false;
            DataClassification = CustomerContent;
            Caption = 'Despatch Slip No.';
        }
        field(54065; "Despatch Slip Line No."; Integer)
        {
            Description = 'CF001';
            Editable = false;
            DataClassification = CustomerContent;
            Caption = 'Despatch Slip Line No.';
        }
        field(60049; "Effective Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Effective Date';
        }
        field(60050; "Expiry Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Expiry Date';
        }
        field(70013; "Supplementary Rate"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Supplementary Rate';
        }
    }
    keys
    {
        key(Key1; "Document Type", "Document No.", "Doc. No. Occurrence", "Version No.", "Line No.")
        {
            Clustered = true;
            SumIndexFields = Amount, "Amount Including VAT", "Outstanding Amount", "Shipped Not Invoiced", "Outstanding Amount (LCY)", "Shipped Not Invoiced (LCY)";
        }
    }
    fieldgroups
    {
    }
    local procedure GetCaptionClass(FieldNumber: Integer): Text[80]var
        SalesHeaderArchive: Record "Sales Header Archive";
    begin
        if not SalesHeaderArchive.Get("Document Type", "Document No.", "Doc. No. Occurrence", "Version No.")then begin
            SalesHeaderArchive."No.":='';
            SalesHeaderArchive.Init;
        end;
        if SalesHeaderArchive."Prices Including VAT" then exit('2,1,' + GetFieldCaption(FieldNumber))
        else
            exit('2,0,' + GetFieldCaption(FieldNumber));
    end;
    local procedure GetFieldCaption(FieldNumber: Integer): Text[100]var
        "Field": Record "Field";
    begin
        Field.Get(Database::"Sales Line", FieldNumber);
        exit(Field."Field Caption");
    end;
    procedure ShowDimensions()
    begin
        TestField("Document No.");
        TestField("Line No.");
    /* // BIS 1145
        DocDimArchive.SETRANGE("Table ID",DATABASE::"Sales Line Archive");
        DocDimArchive.SETRANGE("Document Type","Document Type");
        DocDimArchive.SETRANGE("Document No.","Document No.");
        DocDimArchive.SETRANGE("Line No.","Line No.");
        DocDimArchive.SETRANGE("Version No.","Version No.");
        DocDimensionsArchive.SETTABLEVIEW(DocDimArchive);
        DocDimensionsArchive.RUNMODAL;
        */
    end;
}
