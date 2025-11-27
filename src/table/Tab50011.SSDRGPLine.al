Table 50011 "SSD RGP Line"
{
    // ALLEAA CML-033 280308
    //   - Some Fields Added
    //   - Some code commented OnValidate of "Quantity to ship"
    // ALLEAA CML-033 190408
    //   New field added "Output Qty."
    // ALLEAA CML-033 290408
    //   - Check Bin Code
    //   - Check Status Open or not.
    // ALLEAA CML-033 010508
    //   - Validate Scrap Item from Item Vendor Catelog
    // ALLE 6.12.....57F4 Customisation
    // ALLE 6.01....UOM Calculation
    Permissions = TableData "Purch. Rcpt. Header"=rimd,
        TableData "Purch. Rcpt. Line"=rimd;
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Document No."; Code[20])
        {
            TableRelation = "SSD RGP Header"."No." where("Document Type"=field("Document Type"));
            DataClassification = CustomerContent;
            Caption = 'Document No.';
        }
        field(2; "Line No."; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Line No.';
        }
        field(3; Type; Option)
        {
            OptionMembers = " ", Item, "Item Description", "Fixed Asset";
            DataClassification = CustomerContent;
            Caption = 'Type';

            trigger OnValidate()
            begin
                TestStatusOpen;
                if("Quantity Shipped" <> 0) or ("Quantity Received" <> 0)then Error('Ledger entries exist against this line');
            end;
        }
        field(4; "No."; Code[20])
        {
            Description = 'CEN004.05';
            TableRelation = if(Type=const("Item Description"))"Standard Text"
            else if(Type=const(Item))Item
            else if(Type=const("Fixed Asset"))"Fixed Asset";
            DataClassification = CustomerContent;
            Caption = 'No.';

            trigger OnValidate()
            begin
                TestStatusOpen;
                if("Quantity Shipped" <> 0) or ("Quantity Received" <> 0)then Error('Ledger entries exist against this line');
                RGPheader.Get("Document Type", "Document No.");
                RGPheader.TestField(RGPheader."Party No.");
                //RGPheader.TESTFIELD(RGPheader."Shortcut Dimension 1 Code");
                //RGPheader.TESTFIELD(RGPheader."Shortcut Dimension 2 Code");
                //RGPheader.TESTFIELD(RGPheader."Location Code");//CEN004.05
                // RGPheader.TestField(RGPheader."Responsibility Center");//SSD_Sunil Remove
                "Expected Receipt Date":=RGPheader."Receipt Date";
                "Requested Receipt Date":=RGPheader."Receipt Date";
                "Expected Shipment Date":=RGPheader."Expected Shipment Date";
                "Requested Shipment Date":=RGPheader."Expected Shipment Date";
                "Party Type":=RGPheader."Party Type";
                "Party No.":=RGPheader."Party No.";
                "Posting Date":=RGPheader."Posting Date";
                "Shortcut Dimension 1 Code":=RGPheader."Shortcut Dimension 1 Code";
                "Shortcut Dimension 2 Code":=RGPheader."Shortcut Dimension 2 Code";
                "Location Code":=RGPheader."Location Code";
                //CF001 St
                "Responsibility Center":=RGPheader."Responsibility Center";
                //CF001 En
                if("Quantity Shipped" > 0) or ("Quantity Received" > 0)then begin
                    Error('The quantity is already Shipped');
                    exit;
                end;
                case Type of Type::Item: begin
                    GetItem;
                    Item.TestField(Blocked, false);
                    Item.TestField("Inventory Posting Group");
                    Item.TestField("Gen. Prod. Posting Group");
                    Description:=Item.Description;
                    "Description 2":=Item."Description 2";
                    GetUnitCost;
                    "Item Category Code":=Item."Item Category Code";
                    //SSD "Product Group Code" := Item."Product Group Code";
                    "Unit Of Measure Code":=Item."Sales Unit of Measure";
                    "Base Unit Of Measure":=Item."Base Unit of Measure";
                    Validate("Unit Of Measure Code", Item."Base Unit of Measure");
                end;
                Type::"Fixed Asset": begin
                    FA.Get("No.");
                    FA.TestField(Inactive, false);
                    FA.TestField(Blocked, false);
                    Description:=FA.Description;
                    "Description 2":=FA."Description 2";
                end;
                Type::"Item Description": begin
                end;
                end;
            end;
        }
        field(5; Description; Text[200])
        {
            DataClassification = CustomerContent;
            Caption = 'Description';

            trigger OnValidate()
            begin
                TestStatusOpen;
                if("Quantity Shipped" > 0)then Error('You can not change Description Because document is already shipped.');
            end;
        }
        field(6; "Unit Of Measure Code"; Code[10])
        {
            TableRelation = if(Type=const(Item))"Item Unit of Measure".Code where("Item No."=field("No."))
            else
            "Unit of Measure";
            DataClassification = CustomerContent;
            Caption = 'Unit Of Measure Code';

            trigger OnValidate()
            begin
                TestStatusOpen;
                if("Quantity Shipped" <> 0)then Error('Ledger entries Already exist');
                if Type <> Type::"Item Description" then begin
                    TestField("Quantity Shipped", 0);
                    if("Line No." <> 0)then begin
                        Confirmsg:=StrSubstNo(Text002, FieldCaption("Unit Of Measure Code"));
                        if Confirm(Confirmsg)then begin
                            ItemUnitofMeasure.SetRange("Item No.", "No.");
                            ItemUnitofMeasure.SetRange(Code, "Unit Of Measure Code");
                            if not(ItemUnitofMeasure.Find('-'))then Error(Text001);
                        end;
                    end;
                end;
            end;
        }
        field(7; Quantity; Decimal)
        {
            BlankZero = true;
            DecimalPlaces = 0: 2;
            DataClassification = CustomerContent;
            Caption = 'Quantity';

            trigger OnValidate()
            begin
                TestStatusOpen;
                /*Alle VPB Commented Temporary as per Zavenir Request
                //ALLE 6.01
                IF (Quantity MOD "Qty. per Unit of Measure") <> 0 THEN
                  ERROR('Quantity Entered need to be the multiple of %1',"Qty. per Unit of Measure");
                //ALLE 6.01
                Alle VPB Commented Temporary as per Zavenir Request*/
                if Quantity < 0 then Error('Quantity cannot be less than 0');
                if("Quantity Shipped" <> 0)then Error('Ledger entries Already exist');
                if "Document Type" = "document type"::"RGP Outbound" then begin
                    if(Quantity * "Quantity Shipped" < 0) or ((Abs(Quantity) < Abs("Quantity Shipped")))then FieldError(Quantity, StrSubstNo(Text003, FieldCaption("Quantity Shipped")))end;
                //CP001
                if "Document Type" = "document type"::"RGP Inbound" then begin
                    if(Quantity * "Quantity Received" < 0) or ((Abs(Quantity) < Abs("Quantity Received")))then FieldError(Quantity, StrSubstNo(Text003, FieldCaption("Quantity Received")))end;
                //CP001
                UpdateAmounts;
                if "Document Type" = "document type"::"RGP Outbound" then InitOutstandingShip;
                "Quantity(Base)":=Quantity;
                //CP001
                if "Document Type" = "document type"::"RGP Inbound" then InitOutstandingRcpt;
            //CP001
            end;
        }
        field(8; "Direct Unit Cost"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Direct Unit Cost';

            trigger OnValidate()
            begin
                TestStatusOpen;
                UpdateAmounts;
            end;
        }
        field(9; "Line Amount"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Line Amount';

            trigger OnValidate()
            begin
                TestStatusOpen;
            end;
        }
        field(10; "Quantity to Ship"; Decimal)
        {
            BlankZero = true;
            DecimalPlaces = 0: 2;
            Editable = false;
            DataClassification = CustomerContent;
            Caption = 'Quantity to Ship';

            trigger OnValidate()
            begin
                if "Quantity to Ship" < 0 then Error('Quantity to Ship cannot be less than 0');
                //ALLEAA CML-033 280308 Start >>
                /*
                IF "Document Type" = "Document Type"::"RGP Inbound" THEN
                 BEGIN
                  IF ("Quantity to Ship" > ("Quantity Received"-"Quantity Shipped")) THEN
                    ERROR(Text007,("Quantity Received"-"Quantity Shipped"));
                 END;
                */
                //ALLEAA CML-033 280308 End <<
                if "Document Type" = "document type"::"RGP Outbound" then begin
                    if("Quantity to Ship" > (Quantity - "Quantity Shipped"))then Error(Text007, ("Quantity Received" - "Quantity Shipped"));
                    if "Quantity to Ship" = "Outstanding Ship Quantity" then InitQtyToShip;
                    if("Quantity to Ship" * Quantity < 0) or (Abs("Quantity to Ship") > Abs("Outstanding Ship Quantity")) or (Quantity * "Outstanding Ship Quantity" < 0)then Error(Text007, "Outstanding Ship Quantity");
                end;
            end;
        }
        field(11; "Quantity Shipped"; Decimal)
        {
            BlankZero = true;
            DecimalPlaces = 0: 2;
            DataClassification = CustomerContent;
            Caption = 'Quantity Shipped';

            trigger OnValidate()
            begin
                TestStatusOpen;
            end;
        }
        field(12; "Quantity to Receive"; Decimal)
        {
            BlankZero = true;
            DecimalPlaces = 0: 2;
            DataClassification = CustomerContent;
            Caption = 'Quantity to Receive';

            trigger OnValidate()
            begin
                "Qty. to Write Off":=0;
                "Write Off":=false;
                if "Quantity to Receive" < 0 then Error('Quantity to Receive cannot be less than 0');
                if("Quantity to Receive" > (Quantity - "Quantity Received" - "Quantity Write Off"))then Error(Text008, (Quantity - "Quantity Received" - "Quantity Write Off"));
                if("Quantity to Receive" + "Quantity Received" + "Quantity Write Off") > Quantity then Error(Text008, ("Quantity Shipped" - "Quantity Received" - "Quantity Write Off"));
            end;
        }
        field(13; "Quantity Received"; Decimal)
        {
            BlankZero = true;
            DecimalPlaces = 0: 2;
            DataClassification = CustomerContent;
            Caption = 'Quantity Received';

            trigger OnValidate()
            begin
                TestStatusOpen;
            end;
        }
        field(14; "Document Type"; Option)
        {
            OptionMembers = "RGP Inbound", "RGP Outbound";
            DataClassification = CustomerContent;
            Caption = 'Document Type';
        }
        field(15; "Base Unit Of Measure"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Base Unit Of Measure';
        }
        field(16; "Quantity(Base)"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Quantity(Base)';
        }
        field(17; "Quantity Shipped(Base)"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Quantity Shipped(Base)';
        }
        field(18; "Quantity Received(Base)"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Quantity Received(Base)';
        }
        field(19; "Party Type"; Option)
        {
            OptionMembers = Vendor, Customer, Employee;
            DataClassification = CustomerContent;
            Caption = 'Party Type';
        }
        field(20; "Party No."; Code[20])
        {
            TableRelation = if("Party Type"=const(Vendor))Vendor
            else if("Party Type"=const(Customer))Customer
            else if("Party Type"=const(Employee))"Dimension Value".Code where("Dimension Code"=const('EMPLOYEE'), Code=const('ES*|ET*'), "Global Dimension No."=const(0));
            DataClassification = CustomerContent;
            Caption = 'Party No.';
        }
        field(23; "In-Transit Code"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'In-Transit Code';
        }
        field(24; "Outstanding Ship Quantity"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Outstanding Ship Quantity';
        }
        field(25; "Write Off"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Write Off';

            trigger OnValidate()
            begin
                "Qty. to Write Off":=0;
                "Quantity to Receive":=0;
            end;
        }
        field(26; "Item Category Code"; Code[20])
        {
            TableRelation = "Item Category";
            DataClassification = CustomerContent;
            Caption = 'Item Category Code';
        }
        field(27; "Product Group Code"; Code[20])
        {
            //SSD TableRelation = "Product Group";
            DataClassification = CustomerContent;
            Caption = 'Product Group Code';
        }
        field(28; "Variant Code"; Code[20])
        {
            TableRelation = if(Type=const(Item))"Item Variant".Code where("Item No."=field("No."));
            DataClassification = CustomerContent;
            Caption = 'Variant Code';

            trigger OnValidate()
            begin
                TestStatusOpen;
            end;
        }
        field(29; "Expected Receipt Date"; Date)
        {
            NotBlank = true;
            DataClassification = CustomerContent;
            Caption = 'Expected Receipt Date';

            trigger OnValidate()
            begin
                TestStatusOpen;
            end;
        }
        field(30; "Requested Receipt Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Requested Receipt Date';
        }
        field(31; "Expected Shipment Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Expected Shipment Date';
        }
        field(32; "Requested Shipment Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Requested Shipment Date';
        }
        field(33; "Completely Shipped"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Completely Shipped';
        }
        field(34; "Completely Received"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Completely Received';
        }
        field(35; "Qty. per Unit of Measure"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Qty. per Unit of Measure';
        }
        field(36; "Shipping Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Shipping Date';
        }
        field(37; "Receipt Time"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Receipt Time';
        }
        field(39; "Outstanding Rcpt. Quantity"; Decimal)
        {
            Editable = false;
            DataClassification = CustomerContent;
            Caption = 'Outstanding Rcpt. Quantity';
        }
        field(40; "User ID"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'User ID';
        }
        field(45; "Qty. to Write Off"; Decimal)
        {
            BlankZero = true;
            DecimalPlaces = 0: 2;
            DataClassification = CustomerContent;
            Caption = 'Qty. to Write Off';

            trigger OnValidate()
            begin
                "Quantity to Receive":=0;
                if not "Write Off" then FieldError("Write Off");
                if "Outstanding Rcpt. Quantity" < "Qty. to Write Off" then Error('Qty. to Write Off must be less than or equal to the OutStandingRcpt. Quantity');
            end;
        }
        field(46; "Quantity Write Off"; Decimal)
        {
            BlankZero = true;
            DecimalPlaces = 0: 2;
            Editable = false;
            DataClassification = CustomerContent;
            Caption = 'Quantity Write Off';
        }
        field(100; NRGP; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'NRGP';
        }
        field(101; "MRR No."; Code[20])
        {
            TableRelation = if("Party Type"=const(Vendor))"Purch. Rcpt. Line"."Document No." where("Buy-from Vendor No."=field("Party No."), Type=const(Item), "No."=field("No."));
            DataClassification = CustomerContent;
            Caption = 'MRR No.';
        }
        field(102; "Shortcut Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,2,1';
            TableRelation = "Dimension Value".Code where("Global Dimension No."=const(1));
            DataClassification = CustomerContent;
            Caption = 'Shortcut Dimension 1 Code';
        }
        field(103; "Shortcut Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,2,2';
            TableRelation = "Dimension Value".Code where("Global Dimension No."=const(2));
            DataClassification = CustomerContent;
            Caption = 'Shortcut Dimension 2 Code';
        }
        field(104; "Location Code"; Code[10])
        {
            Editable = false;
            TableRelation = Location;
            DataClassification = CustomerContent;
            Caption = 'Location Code';

            trigger OnValidate()
            begin
                TestStatusOpen; //ALLEAA CML-033 290408
            end;
        }
        field(105; "Nrgp Inbound"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Nrgp Inbound';
        }
        field(150; "Responsibility Center"; Code[20])
        {
            TableRelation = "Responsibility Center".Code;
            DataClassification = CustomerContent;
            Caption = 'Responsibility Center';
        }
        field(50007; "Posting Date"; Date)
        {
            Description = 'Aditya';
            DataClassification = CustomerContent;
            Caption = 'Posting Date';

            trigger OnValidate()
            begin
                TestStatusOpen; //ALLEAA CML-033 290408
            end;
        }
        field(50008; "Bin Code"; Code[20])
        {
            Description = 'CEN004';
            TableRelation = Bin.Code where("Location Code"=field("Location Code"));
            DataClassification = CustomerContent;
            Caption = 'Bin Code';

            trigger OnValidate()
            begin
                //ALLEAA CML-033 290408 Start >>
                TestStatusOpen;
                if Subcontracting and ("Bin Code" = "New Bin Code")then Error(Text50000);
                //ALLEAA CML-033 290408 End <<
                if(Type = Type::Item)then WMSManagement.FindBinContent("Location Code", "Bin Code", "No.", "Variant Code", '');
            end;
        }
        field(50009; "No. 2"; Code[20])
        {
            CalcFormula = lookup(Item."No. 2" where("No."=field("No.")));
            Description = 'CEN004';
            FieldClass = FlowField;
            Caption = 'No. 2';
        }
        field(50010; "Gate Entry No."; Code[20])
        {
            Description = 'CEN004.05';
            DataClassification = CustomerContent;
            Caption = 'Gate Entry No.';
        }
        field(50011; "Gate Entry Line No."; Integer)
        {
            Description = 'CEN004.05';
            DataClassification = CustomerContent;
            Caption = 'Gate Entry Line No.';
        }
        field(60000; Subcontracting; Boolean)
        {
            Description = 'ALLEAA CML-033 280408';
            DataClassification = CustomerContent;
            Caption = 'Subcontracting';
        }
        field(60001; "Unit Cost"; Decimal)
        {
            Description = 'ALLEAA CML-033 280408';
            DataClassification = CustomerContent;
            Caption = 'Unit Cost';
        }
        field(60002; Amount; Decimal)
        {
            Description = 'ALLEAA CML-033 280408';
            DataClassification = CustomerContent;
            Caption = 'Amount';
        }
        field(60003; "Qty. Consumed"; Decimal)
        {
            Description = 'ALLEAA CML-033 280408';
            Editable = true;
            DataClassification = CustomerContent;
            Caption = 'Qty. Consumed';
        }
        field(60004; "Scrap Item"; Code[20])
        {
            Description = 'ALLEAA CML-033 280408';
            Editable = false;
            //SSD TableRelation = Item."No." where("Scrap Item" = filter(true),
            //SSD                                  Blocked = filter(false));
            DataClassification = CustomerContent;
            Caption = 'Scrap Item';

            trigger OnValidate()
            begin
            //ALLEAA CML-033 010508 Start >>
            /*
                TestStatusOpen; //ALLEAA CML-033 290408
                
                //ALLEAA CML-033 230408 Start >>
                ItemVendor.SETRANGE(ItemVendor."Vendor No." , "Party No.");
                ItemVendor.SETRANGE(ItemVendor."Item No." , "No.");
                IF ItemVendor.FINDFIRST THEN
                  "Scrap Generated" := ItemVendor."Scrap Qty. Per Unit" * Quantity;
                //ALLEAA CML-033 230408 End <<
                */
            //ALLEAA CML-033 010508 End <<
            end;
        }
        field(60005; Completed; Boolean)
        {
            Description = 'ALLEAA CML-033 280408';
            DataClassification = CustomerContent;
            Caption = 'Completed';
        }
        field(60006; "Scrap Generated"; Decimal)
        {
            Description = 'ALLEAA CML-033 280408';
            DataClassification = CustomerContent;
            Caption = 'Scrap Generated';

            trigger OnValidate()
            begin
                TestStatusOpen; //ALLEAA CML-033 290408
            end;
        }
        field(60007; Grade; Code[20])
        {
            Description = 'ALLEAA CML-033 280408';
            DataClassification = CustomerContent;
            Caption = 'Grade';
        }
        field(60013; "Document SubType"; Option)
        {
            Description = 'ALLE 6.12';
            OptionCaption = ' ,57F4';
            OptionMembers = " ", "57F4";
            DataClassification = CustomerContent;
            Caption = 'Document SubType';
        }
        field(70000; "Gate Out Quantity"; Decimal)
        {
            Description = 'ALLEAA CML-033 280408';
            MinValue = 0;
            DataClassification = CustomerContent;
            Caption = 'Gate Out Quantity';

            trigger OnValidate()
            begin
                "Gate Out":="Gate Out Quantity" <> 0;
                Validate("Quantity to Ship", "Gate Out Quantity");
            end;
        }
        field(70001; "Gate Out"; Boolean)
        {
            Description = 'ALLEAA CML-033 280408';
            Editable = false;
            DataClassification = CustomerContent;
            Caption = 'Gate Out';
        }
        field(70002; "NRGP Doc. No."; Code[20])
        {
            Description = 'ALLEAA CML-033 280408';
            DataClassification = CustomerContent;
            Caption = 'NRGP Doc. No.';
        }
        field(70003; "NRGP Doc. Line No."; Integer)
        {
            Description = 'ALLEAA CML-033 280408';
            DataClassification = CustomerContent;
            Caption = 'NRGP Doc. Line No.';
        }
        field(70004; "NRGP Out Quantity"; Decimal)
        {
            Description = 'ALLEAA CML-033 280408';
            MinValue = 0;
            DataClassification = CustomerContent;
            Caption = 'NRGP Out Quantity';
        }
        field(70005; "RGP Out Quantity"; Decimal)
        {
            CalcFormula = sum("SSD RGP Shipment Line".Quantity where("Pre-Assigned No."=field("Document No."), "Pre-Assigned Line No."=field("Line No.")));
            Description = 'ALLEAA CML-033 280408';
            Editable = false;
            FieldClass = FlowField;
            Caption = 'RGP Out Quantity';
        }
        field(70020; "New Location Code"; Code[20])
        {
            Description = 'ALLEAA CML-033 280408';
            Editable = false;
            TableRelation = Location;
            DataClassification = CustomerContent;
            Caption = 'New Location Code';

            trigger OnValidate()
            begin
                TestStatusOpen; //ALLEAA CML-033 290408
            end;
        }
        field(70021; "New Bin Code"; Code[20])
        {
            Description = 'ALLEAA CML-033 280408';
            TableRelation = Bin.Code where("Location Code"=field("New Location Code"));
            DataClassification = CustomerContent;
            Caption = 'New Bin Code';

            trigger OnValidate()
            begin
                //ALLEAA CML-033 290408 Start >>
                TestStatusOpen;
                if Subcontracting and ("Bin Code" = "New Bin Code")then Error(Text50000);
                //ALLEAA CML-033 290408 End <<
                if(Type = Type::Item)then WMSManagement.FindBinContent("New Location Code", "New Bin Code", "No.", "Variant Code", '');
            end;
        }
        field(70022; "Output Qty."; Decimal)
        {
            Description = 'ALLEAA CML-033 280408';
            DataClassification = CustomerContent;
            Caption = 'Output Qty.';
        }
        field(70023; "Scrap Location"; Code[20])
        {
            Description = 'ALLEAA CML-033 230408';
            TableRelation = Location.Code;
            DataClassification = CustomerContent;
            Caption = 'Scrap Location';

            trigger OnValidate()
            begin
                TestStatusOpen; //ALLEAA CML-033 290408
            end;
        }
        field(70024; "Scrap Bin"; Code[20])
        {
            Description = 'ALLEAA CML-033 230408';
            TableRelation = Bin.Code where("Location Code"=field("Scrap Location"));
            DataClassification = CustomerContent;
            Caption = 'Scrap Bin';

            trigger OnValidate()
            begin
                TestStatusOpen; //ALLEAA CML-033 290408
            end;
        }
        field(70025; "Generate Scrap"; Boolean)
        {
            Description = 'ALLEAA CML-033 230408';
            DataClassification = CustomerContent;
            Caption = 'Generate Scrap';

            trigger OnValidate()
            begin
                TestStatusOpen; //ALLEAA CML-033 290408
                //ALLEAA CML-033 010508 Start >>
                if "Generate Scrap" then begin
                    ItemVendor.Reset;
                    ItemVendor.SetRange(ItemVendor."Vendor No.", "Party No.");
                    ItemVendor.SetRange(ItemVendor."Item No.", "No.");
                    if ItemVendor.FindFirst then begin
                        "Scrap Generated":=ItemVendor."Scrap Qty. Per Unit" * Quantity;
                        "Scrap Item":=ItemVendor."Scrap Item";
                        Quantity:=Quantity - "Scrap Generated"; // ssd
                    end;
                end
                else
                begin
                    if "Scrap Generated" <> 0 then // ssd
 Quantity:=Quantity + "Scrap Generated"; // ssd
                    "Scrap Generated":=0;
                    "Scrap Item":='';
                    "Scrap Location":='';
                    "Scrap Bin":='';
                end;
            //ALLEAA CML-033 010508 End <<
            end;
        }
        field(70026; "Scrap Posted"; Boolean)
        {
            Description = 'ALLEAA CML-033 230408';
            DataClassification = CustomerContent;
            Caption = 'Scrap Posted';
        }
        field(70027; "Description 2"; Text[50])
        {
            Description = 'Alle VPB';
            DataClassification = CustomerContent;
            Caption = 'Description 2';

            trigger OnValidate()
            begin
                TestStatusOpen;
                if("Quantity Shipped" > 0)then Error('You can not change Description Because document is already shipped.');
            end;
        }
    }
    keys
    {
        key(Key1; "Document Type", "Document No.", "Line No.")
        {
            Clustered = true;
        }
        key(Key2; NRGP)
        {
        }
        key(Key3; "Shortcut Dimension 1 Code", Type, "Document No.")
        {
        }
        key(Key4; "Party No.", "Document No.", "Document Type", "No.")
        {
        }
        key(Key5; "No.", "Line No.")
        {
        }
    }
    fieldgroups
    {
    }
    trigger OnDelete()
    begin
        TestStatusOpen;
        if("Quantity Shipped" <> 0) or ("Quantity Received" <> 0)then Error('Ledger entries exist against this line');
    end;
    trigger OnInsert()
    begin
        RGPheader.Get("Document Type", "Document No.");
        RGPheader.TestField(RGPheader."Party No.");
        //RGPheader.TESTFIELD(RGPheader."Shortcut Dimension 1 Code");//CEN004.05
        //RGPheader.TESTFIELD(RGPheader."Shortcut Dimension 2 Code");
        //RGPheader.TESTFIELD(RGPheader."Location Code");
        //RGPheader.TestField(RGPheader."Responsibility Center");
        "Expected Receipt Date":=RGPheader."Receipt Date";
        "Requested Receipt Date":=RGPheader."Receipt Date";
        "Expected Shipment Date":=RGPheader."Expected Shipment Date";
        "Requested Shipment Date":=RGPheader."Expected Shipment Date";
        "Party Type":=RGPheader."Party Type";
        "Party No.":=RGPheader."Party No.";
        "Posting Date":=RGPheader."Posting Date";
        "Shortcut Dimension 1 Code":=RGPheader."Shortcut Dimension 1 Code";
        "Shortcut Dimension 2 Code":=RGPheader."Shortcut Dimension 2 Code";
        "Location Code":=RGPheader."Location Code";
        "Responsibility Center":=RGPheader."Responsibility Center";
        //ALLE 6.12
        "Document SubType":=RGPheader."Document SubType";
    //NRGP:=TRUE;
    end;
    var Item: Record Item;
    FA: Record "Fixed Asset";
    UOMMgt: Codeunit "Unit of Measure Management";
    SKU: Record "Stockkeeping Unit";
    Text001: label 'The unit of measure is not defined for this item.';
    Text002: label 'Do you want to  change %1.';
    Text003: label 'must not then %1';
    Currency: Record Currency;
    Text007: label 'You cannot ship more than %1 units.';
    RGPheader: Record "SSD RGP Header";
    Confirmsg: Text[80];
    ItemUnitofMeasure: Record "Item Unit of Measure";
    Text008: label 'You cannot receive more than %1 units.';
    Text004: label 'You can''t change Description because quantity already shipped.';
    ItemVendor: Record "Item Vendor";
    Text50000: label 'Company Bin and Vendor Bin must not be same.';
    WMSManagement: Codeunit "WMS Management";
    ReserveItemJnlLine: Codeunit "Item Jnl. Line-Reserve";
    local procedure GetItem()
    begin
        TestField("No.");
        if Item."No." <> "No." then Item.Get("No.");
    end;
    local procedure GetUnitCost()
    begin
        TestField(Type, Type::Item);
        TestField("No.");
        GetItem;
        "Qty. per Unit of Measure":=UOMMgt.GetQtyPerUnitOfMeasure(Item, "Unit Of Measure Code");
        Validate("Direct Unit Cost", Item."Unit Cost" * "Qty. per Unit of Measure");
    end;
    procedure InitOutstandingShip()
    begin
        if "Document Type" = "document type"::"RGP Outbound" then begin
            "Outstanding Ship Quantity":=Quantity - "Quantity Shipped";
        end;
        "Completely Shipped":=(Quantity <> 0) and ("Outstanding Ship Quantity" = 0);
        InitQtyToShip;
    end;
    procedure InitQtyToShip()
    begin
        "Quantity to Ship":="Outstanding Ship Quantity";
    end;
    procedure InitQtyToReceive()
    begin
        "Quantity to Receive":="Outstanding Rcpt. Quantity";
    end;
    procedure UpdateAmounts()
    begin
        "Line Amount":=ROUND(Quantity * "Direct Unit Cost", Currency."Amount Rounding Precision");
    end;
    procedure InitOutstandingRcpt()
    begin
        if "Document Type" = "document type"::"RGP Inbound" then begin
            "Outstanding Rcpt. Quantity":=Quantity - "Quantity Received";
        end;
        "Completely Received":=(Quantity <> 0) and ("Outstanding Rcpt. Quantity" = 0);
        InitQtyToReceive;
    end;
    local procedure TestStatusOpen()
    begin
        TestField("Document No.");
        RGPheader.Get("Document Type", "Document No.");
        RGPheader.TestField(RGPheader.Status, RGPheader.Status::Open);
    end;
    procedure Release()
    begin
        RGPheader.Status:=RGPheader.Status::Released;
        RGPheader.Modify;
    end;
    procedure Reopen()
    begin
        RGPheader.Status:=RGPheader.Status::Open;
        RGPheader.Modify;
    end;
    procedure PostWriteOff(var RGPLine: Record "SSD RGP Line")
    var
        RGPLine2: Record "SSD RGP Line";
        LastEntryNo: Integer;
        LastAppEntryNo: Integer;
        RGPLedgerEntry: Record "SSD RGP Ledger Entry";
        RGPHeader: Record "SSD RGP Header";
        RGPAppEntry: Record "SSD RGP Application Entry";
        RGPLedgerEntry2: Record "SSD RGP Ledger Entry";
        WriteOffQty: Decimal;
        AppQty: Decimal;
    begin
        RGPLine2.Copy(RGPLine);
        if not RGPLine2.Find('-')then Error('There is nothing to writeoff')
        else
        begin
            RGPHeader.Get(RGPLine2."Document Type", RGPLine2."Document No.");
            RGPLedgerEntry.LockTable;
            RGPLedgerEntry.Find('+');
            LastEntryNo:=RGPLedgerEntry."Entry No.";
            RGPAppEntry.LockTable;
            RGPAppEntry.Find('+');
            LastAppEntryNo:=RGPAppEntry."Entry No.";
            repeat //------------------------------
                LastEntryNo+=1;
                RGPLedgerEntry.Init;
                RGPLedgerEntry."Entry No.":=LastEntryNo;
                RGPLedgerEntry."Posting Date":=RGPHeader."Posting Date";
                RGPLedgerEntry."Document Type":=RGPLine2."Document Type";
                RGPLedgerEntry."Document No.":=RGPLine2."Document No.";
                RGPLedgerEntry."RGP Document No.":=RGPLine2."Document No.";
                RGPLedgerEntry."RGP Line No.":=RGPLine2."Line No.";
                RGPLedgerEntry.Type:=RGPLine2.Type;
                RGPLedgerEntry."No.":=RGPLine2."No.";
                RGPLedgerEntry.Description:=RGPLine2.Description;
                RGPLedgerEntry."Description 2":=RGPLine2."Description 2";
                RGPLedgerEntry.Quantity:=RGPLine2."Qty. to Write Off";
                WriteOffQty:=RGPLine2."Qty. to Write Off";
                RGPLedgerEntry."Remaining Quantity":=0;
                RGPLedgerEntry.Open:=false;
                RGPLedgerEntry."External Document No.":=RGPHeader."External Document No.";
                RGPLedgerEntry."Item Category Code":=RGPLine2."Item Category Code";
                RGPLedgerEntry."Product Group Code":=RGPLine2."Product Group Code";
                RGPLedgerEntry."Global Dimension 1 Code":=RGPHeader."Shortcut Dimension 1 Code";
                RGPLedgerEntry."Global Dimension 2 Code":=RGPHeader."Shortcut Dimension 2 Code";
                RGPLedgerEntry."No. Series":=RGPHeader."No. Series";
                RGPLedgerEntry."User ID":=UserId;
                RGPLedgerEntry.Writeoff:=true;
                RGPLedgerEntry.Insert;
                //-----------------------------
                RGPLedgerEntry2.SetCurrentkey("Document Type", "RGP Document No.", "RGP Line No.");
                RGPLedgerEntry2.SetRange("Document Type", RGPLine."Document Type");
                RGPLedgerEntry2.SetRange("RGP Document No.", RGPLine."Document No.");
                RGPLedgerEntry2.SetRange("RGP Line No.", RGPLine."Line No.");
                RGPLedgerEntry2.SetRange(RGPLedgerEntry2."No.", RGPLedgerEntry."No.");
                RGPLedgerEntry2.SetFilter(RGPLedgerEntry2.Open, '=%1', true);
                RGPLedgerEntry2.Find('-');
                repeat LastAppEntryNo+=1;
                    RGPAppEntry.Init;
                    RGPAppEntry."Entry No.":=LastAppEntryNo;
                    RGPAppEntry."RGP Entry No.":=RGPLedgerEntry."Entry No.";
                    if WriteOffQty > -RGPLedgerEntry2."Remaining Quantity" then begin
                        WriteOffQty:=WriteOffQty + RGPLedgerEntry2."Remaining Quantity";
                        AppQty:=RGPLedgerEntry2."Remaining Quantity";
                        RGPLedgerEntry2."Remaining Quantity":=0;
                    end
                    else
                    begin
                        RGPLedgerEntry2."Remaining Quantity":=RGPLedgerEntry2."Remaining Quantity" + WriteOffQty;
                        AppQty:=-WriteOffQty;
                        WriteOffQty:=0;
                    end;
                    if RGPLedgerEntry2."Remaining Quantity" = 0 then RGPLedgerEntry2.Open:=false
                    else
                        RGPLedgerEntry2.Open:=true;
                    RGPLedgerEntry2.Modify;
                    RGPAppEntry."Inbound RGP Entry No.":=RGPLedgerEntry2."Entry No.";
                    RGPAppEntry.Quantity:=AppQty;
                    RGPAppEntry.Insert;
                    RGPLedgerEntry2.Next;
                until WriteOffQty = 0;
                //------------------------------
                LastAppEntryNo+=1;
                RGPAppEntry.Init;
                RGPAppEntry."Entry No.":=LastAppEntryNo;
                RGPAppEntry."RGP Entry No.":=RGPLedgerEntry."Entry No.";
                if RGPHeader."Document Type" = RGPHeader."document type"::"RGP Outbound" then begin
                    RGPAppEntry."Inbound RGP Entry No.":=RGPLedgerEntry2."Entry No.";
                    RGPAppEntry.Quantity:=RGPLedgerEntry.Quantity;
                end;
                RGPAppEntry.Insert;
                //-----------------------------
                RGPLine2."Outstanding Rcpt. Quantity":=RGPLine2."Outstanding Rcpt. Quantity" - RGPLine2."Qty. to Write Off";
                RGPLine2."Quantity to Receive":=0;
                RGPLine2."Quantity Write Off"+=RGPLine2."Qty. to Write Off";
                RGPLine2."Qty. to Write Off":=0;
                RGPLine2."Write Off":=false;
                RGPLine2.Modify;
            until RGPLine2.Next = 0;
        end;
        RGPLine:=RGPLine2;
    end;
    procedure ShowLedgerEntries(RGPLine: Record "SSD RGP Line")
    var
        RGPLedgerEntry: Record "SSD RGP Ledger Entry";
    begin
        RGPLedgerEntry.SetCurrentkey("Document Type", "RGP Document No.", "RGP Line No.");
        RGPLedgerEntry.SetRange("Document Type", RGPLine."Document Type");
        RGPLedgerEntry.SetRange("RGP Document No.", RGPLine."Document No.");
        RGPLedgerEntry.SetRange("RGP Line No.", RGPLine."Line No.");
        Page.Run(Page::"RGP Ledger Entries", RGPLedgerEntry);
    end;
    procedure OpenItemTrackingLines(Direction: Option Outbound, Inbound)
    var
        ItemJnlLineLocal1: Record "Item Journal Line";
        gvlineno: Integer;
        RGPHeaderLocal: Record "SSD RGP Header";
        RGPInboundDoc: Boolean;
        RgpOutBnd: Boolean;
        ILE: Record "Item Ledger Entry";
        Text006: label 'Ship Qty can not be greater than %1';
        Text007: label 'No Item Ledger Entry found against the document no. %1';
        ResponsibilityCenter: Record "Responsibility Center";
        ItemLocal: Record Item;
    begin
        //ALLE[551]
        TestField("No.");
        TestField("Quantity(Base)");
        ItemLocal.Reset;
        if ItemLocal.Get("No.")then ItemLocal.TestField(ItemLocal."Item Tracking Code");
        //Show tracking if exist
        ItemJnlLineLocal1.Reset;
        ItemJnlLineLocal1.SetRange(ItemJnlLineLocal1."Journal Template Name", 'ITEM');
        ItemJnlLineLocal1.SetRange(ItemJnlLineLocal1."Journal Batch Name", 'JOBWORK');
        ItemJnlLineLocal1.SetRange(ItemJnlLineLocal1."Document No.", "Document No.");
        ItemJnlLineLocal1.SetRange(ItemJnlLineLocal1."Item No.", "No.");
        if ItemJnlLineLocal1.FindFirst then begin
            if ItemJnlLineLocal1."Entry Type" = ItemJnlLineLocal1."entry type"::Transfer then ReserveItemJnlLine.CallItemTracking(ItemJnlLineLocal1, true)
            else
                ReserveItemJnlLine.CallItemTracking(ItemJnlLineLocal1, false);
            exit;
        end;
        //end
        //*************** Carried ***************
        //**** ALLE[551]
        RGPHeaderLocal.Reset;
        RGPHeaderLocal.SetRange(RGPHeaderLocal."Document Type", "Document Type");
        RGPHeaderLocal.SetRange(RGPHeaderLocal."No.", "Document No.");
        if RGPHeaderLocal.FindFirst then;
        //CML-034 ALLEAG 250408 Start
        RGPInboundDoc:=false;
        if("Document Type" = "document type"::"RGP Inbound") and (not Subcontracting)then RGPInboundDoc:=true;
        //CML-034 ALLEAG 250408 Start
        //CML-034 ALLEAA 200608 Start
        RgpOutBnd:=false;
        if("Document Type" = "document type"::"RGP Outbound") and (not Subcontracting)then RgpOutBnd:=true;
        //CML-034 ALLEAA 200608 Finish
        //ashish
        ItemJnlLineLocal1.Reset;
        ItemJnlLineLocal1.SetRange(ItemJnlLineLocal1."Journal Template Name", 'ITEM');
        ItemJnlLineLocal1.SetRange(ItemJnlLineLocal1."Journal Batch Name", 'JOBWORK');
        if ItemJnlLineLocal1.Find('+')then gvlineno:=ItemJnlLineLocal1."Line No.";
        gvlineno:=gvlineno + 10000;
        ItemJnlLineLocal1.Init;
        ItemJnlLineLocal1."Journal Template Name":='ITEM';
        ItemJnlLineLocal1."Journal Batch Name":='JOBWORK';
        ItemJnlLineLocal1."Line No.":=gvlineno;
        ItemJnlLineLocal1."Item No.":="No.";
        ItemJnlLineLocal1.Validate(ItemJnlLineLocal1."Item No.");
        ItemJnlLineLocal1.Validate("Unit of Measure Code", "Unit Of Measure Code");
        ItemJnlLineLocal1."Posting Date":=RGPHeaderLocal."Posting Date";
        ItemJnlLineLocal1."Document Date":=RGPHeaderLocal."Posting Date";
        ItemJnlLineLocal1."Document No.":="Document No.";
        ItemJnlLineLocal1."External Document No.":=RGPHeaderLocal."External Document No.";
        ItemJnlLineLocal1."Responsibility Center":="Responsibility Center";
        ItemJnlLineLocal1."Shortcut Dimension 1 Code":="Shortcut Dimension 1 Code"; //neeraj
        ItemJnlLineLocal1."Shortcut Dimension 2 Code":="Shortcut Dimension 2 Code"; //neeraj
        ItemJnlLineLocal1."Bin Code":="Bin Code"; //Ankit CEN003
        ItemJnlLineLocal1."Source Code":='ITEMJNL';
        ItemJnlLineLocal1."Location Code":="Location Code";
        ItemJnlLineLocal1."SUBCON Consumption":=RGPHeaderLocal.Subcontracting; //ALLEAA CML-033 220408
        ItemJnlLineLocal1.Validate(ItemJnlLineLocal1."Location Code");
        ItemJnlLineLocal1."Source No.":=RGPHeaderLocal."Party No."; //CML-034
        //*************** Carried ****************
        if Direction = 0 then begin
            ItemJnlLineLocal1."Entry Type":=ItemJnlLineLocal1."entry type"::"Negative Adjmt.";
            if "Quantity to Ship" > 0 then ItemJnlLineLocal1.Quantity:="Quantity to Ship";
            //CML-034 ALLEAG 220408 Start
            if not RgpOutBnd then begin //CML-034 ALLEAA 200608
                ILE.Reset;
                ILE.SetRange(ILE."Document No.", ItemJnlLineLocal1."Document No.");
                ILE.SetRange(ILE."Entry Type", ILE."entry type"::"Positive Adjmt.");
                ILE.SetRange(ILE."Item No.", ItemJnlLineLocal1."Item No.");
                ILE.SetRange(ILE."Location Code", ItemJnlLineLocal1."Location Code");
                //SSD ILE.SetRange(ILE."Bin Code", ItemJnlLineLocal1."Bin Code");
                if ILE.FindFirst then begin
                    if ILE."Remaining Quantity" >= ItemJnlLineLocal1.Quantity then ItemJnlLineLocal1."Applies-to Entry":=ILE."Entry No."
                    else
                        Error(Text006, ILE."Remaining Quantity");
                end
                else
                    Error(Text007, ItemJnlLineLocal1."Document No.");
            end;
            //CML-034 ALLEAG 220408 End
            //>>VPB Alle
            if "Document SubType" = "document subtype"::"57F4" then begin
                ResponsibilityCenter.Get("Responsibility Center");
                ItemJnlLineLocal1."Entry Type":=ItemJnlLineLocal1."entry type"::Transfer;
                ItemJnlLineLocal1."New Location Code":=ResponsibilityCenter."Job Work Location";
            end;
            //<<VPb Alle
            //>>Alle VPB 27-Aug-10 Add Start
            if RGPHeaderLocal."Inter Unit Transfer" then begin
                ItemJnlLineLocal1."Entry Type":=ItemJnlLineLocal1."entry type"::Transfer;
                ItemJnlLineLocal1."New Location Code":=RGPHeaderLocal."Inter Unit Transfer Location";
            end;
        //<<Alle VPB 27-Aug-10 Add Stop
        end
        else
        begin
            ItemJnlLineLocal1."Entry Type":=ItemJnlLineLocal1."entry type"::"Positive Adjmt.";
            if "Quantity to Receive" > 0 then ItemJnlLineLocal1.Quantity:="Quantity to Receive";
            //>>VPB Alle
            if "Document SubType" = "document subtype"::"57F4" then begin
                ResponsibilityCenter.Get("Responsibility Center");
                ItemJnlLineLocal1."Location Code":=ResponsibilityCenter."Job Work Location";
                ItemJnlLineLocal1."Entry Type":=ItemJnlLineLocal1."entry type"::Transfer;
                ItemJnlLineLocal1."New Location Code":="Location Code";
                ItemJnlLineLocal1."New Bin Code":="Bin Code";
            end;
            //<<VPb Alle
            //>>Alle VPB 27-Aug-10 Add Start
            if RGPHeaderLocal."Inter Unit Transfer" then begin
                ItemJnlLineLocal1."Location Code":=RGPHeaderLocal."Inter Unit Transfer Location";
                ItemJnlLineLocal1."Entry Type":=ItemJnlLineLocal1."entry type"::Transfer;
                ItemJnlLineLocal1."New Location Code":="Location Code";
                ItemJnlLineLocal1."New Bin Code":="Bin Code";
            end;
        //<<Alle VPB 27-Aug-10 Add Stop
        end;
        //********** Condition ended **********
        ItemJnlLineLocal1.Validate(ItemJnlLineLocal1.Quantity);
        if Subcontracting then begin
            ItemJnlLineLocal1.Validate(Amount, Amount);
            ItemJnlLineLocal1."Unit Cost":="Unit Cost";
        end;
        ItemJnlLineLocal1.Insert;
        Commit();
        //********* carry end**************
        ReserveItemJnlLine.CallItemTracking(ItemJnlLineLocal1, false);
    //ALLE[551]
    end;
}
