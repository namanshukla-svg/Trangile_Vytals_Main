table 50084 "SSD Quality Order Header"
{
    // // SR_PQA003 070710: Added code to restrict release of Quality Order in case of Rejected Quantity is not zero.
    // // SR2_PQA003 070710: Added code to resolve error comes at the time of Posting of Quality Order regarding Lot No. Information.
    Caption = 'Quality Order Header';
    DrillDownPageID = "Quality Order List";
    LookupPageID = "Quality Order List";
    DataClassification = CustomerContent;

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
            Editable = true;
            TableRelation = "Warehouse Receipt Header" where(Blocked = filter(false));
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                if "No." <> xRec."No." then begin
                    //SSD NoSeriesManagement.TestManual(GetNoSeries(false));
                    "No. Series" := '';
                end;
                "No.2" := Item."No. 2";
            end;
        }
        field(2; "No. Series"; Code[10])
        {
            Editable = false;
            TableRelation = "No. Series";
            DataClassification = CustomerContent;
            Caption = 'No. Series';
        }
        field(3; Description; Text[50])
        {
            CalcFormula = lookup(Item.Description where("No." = field("Item No.")));
            Caption = 'Description';
            Editable = false;
            FieldClass = FlowField;
        }
        field(4; "Description 2"; Text[50])
        {
            CalcFormula = lookup(Item."Description 2" where("No." = field("Item No.")));
            Caption = 'Description 2';
            Editable = false;
            FieldClass = FlowField;
        }
        field(8; "Last Date Modified"; Date)
        {
            Editable = false;
            DataClassification = CustomerContent;
            Caption = 'Last Date Modified';
        }
        field(9; "Entry User"; Code[50])
        {
            Editable = false;
            DataClassification = CustomerContent;
            Caption = 'Entry User';
        }
        field(10; "Template Type"; Option)
        {
            Editable = true;
            OptionCaption = 'Receipt,Manufacturing,Routing,RcvdCoil';
            OptionMembers = Receipt,Manufacturing,Routing,RcvdCoil;
            DataClassification = CustomerContent;
            Caption = 'Template Type';
        }
        field(11; "Approved by"; Code[50])
        {
            TableRelation = User;
            DataClassification = CustomerContent;
            Caption = 'Approved by';
        }
        field(12; "Approved Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Approved Date';
        }
        field(15; "Kind of Sampling"; Code[10])
        {
            Caption = 'Kind of Sampling';
            Editable = false;
            TableRelation = "SSD Kind of Sampling";
            DataClassification = CustomerContent;
        }
        field(20; Status; Option)
        {
            Editable = true;
            OptionCaption = 'Open,Released';
            OptionMembers = Open,Released;
            DataClassification = CustomerContent;
            Caption = 'Status';
        }
        field(21; Edition; Code[10])
        {
            Editable = false;
            DataClassification = CustomerContent;
            Caption = 'Edition';
        }
        field(22; Review; Code[10])
        {
            Editable = false;
            DataClassification = CustomerContent;
            Caption = 'Review';
        }
        field(23; Comments; Boolean)
        {
            CalcFormula = exist("SSD Quality Comments" where(TableId = const(62810), "Doc. No." = field("No.")));
            Editable = false;
            FieldClass = FlowField;
            Caption = 'Comments';
        }
        field(25; "Sampling Method"; Option)
        {
            OptionCaption = 'Percentage,Fixed Quantity,Complete Quantity';
            OptionMembers = Percentage,"Fixed Quantity","Complete Quantity";
            DataClassification = CustomerContent;
            Caption = 'Sampling Method';

            trigger OnValidate()
            begin
                TestField(Status, Status::Open);
                if "Sampling Method" <> xRec."Sampling Method" then begin
                    Validate("Percentage / Fixed Quantity", 0);
                    "Suggest For Quality Pass" := "suggest for quality pass"::" ";
                    "Decision For Quality Pass" := "decision for quality pass"::" ";
                end;
            end;
        }
        field(26; "Percentage / Fixed Quantity"; Decimal)
        {
            Caption = 'Percentage / Fixed Quantity';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                TestField(Status, Status::Open);
                if "Is Coil Type" = false then Validate("Sample Size", CalculateSampleSize);
            end;
        }
        field(29; "Order No."; Code[20])
        {
            Description = 'For Manf-> Prod. Order No; For Routing -> Manf. Quality Order No.';
            Editable = false;
            DataClassification = CustomerContent;
            Caption = 'Order No.';
        }
        field(30; "Entry Source Type"; Option)
        {
            Caption = 'Entry Source Type';
            Editable = false;
            OptionCaption = 'Purchase,Manufac.,Routing,MRN';
            OptionMembers = Purchase,"Manufac.",Routing,MRN;
            DataClassification = CustomerContent;
        }
        field(31; "Source Code"; Code[20])
        {
            Caption = 'Source Code';
            Description = 'For Receipt-> "Vendor Code";  For Other -> "Prod. Order No."';
            Editable = false;
            TableRelation = if ("Entry Source Type" = filter(Purchase | MRN)) Vendor
            else if ("Entry Source Type" = filter("Manufac." | Routing)) "Prod. Order Line"."Prod. Order No." where(Status = filter(Released .. Finished), "Line No." = field("Source Doc. Line No."));
            DataClassification = CustomerContent;
        }
        field(32; "Source Doc. Line No."; Integer)
        {
            Editable = false;
            DataClassification = CustomerContent;
            Caption = 'Source Doc. Line No.';
        }
        field(33; "Reclassif. Code"; Code[20])
        {
            Caption = 'Reclassification Code';
            TableRelation = Item;
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                if ItemsReclassification.Get("Item No.", "Reclassif. Code") then "Reclassif. Factor" := ItemsReclassification."Reclassif. Factor";
            end;
        }
        field(34; "Reclassif. Factor"; Decimal)
        {
            Caption = 'Reclassification Factor';
            DataClassification = CustomerContent;
        }
        field(40; "Routing No."; Code[20])
        {
            Editable = false;
            TableRelation = "Routing Header";
            DataClassification = CustomerContent;
            Caption = 'Routing No.';
        }
        field(41; "Process/Operation No."; Code[10])
        {
            Description = 'Coming From Prod. Order Routing Line ->"Operaion No."';
            Editable = false;
            TableRelation = if ("Entry Source Type" = const(Routing)) "Prod. Order Routing Line"."Operation No." where(Status = filter(Released .. Finished), "Prod. Order No." = field("Source Code"), "Routing Reference No." = field("Source Doc. Line No."), "Routing No." = field("Routing No."), "Operation No." = field("Process/Operation No."));
            DataClassification = CustomerContent;
            Caption = 'Process/Operation No.';
        }
        field(42; "Sampling Temp. No."; Code[20])
        {
            Caption = 'Sampling Template No.';
            Description = 'For Receipt-> "Item Sampling Template"; For Manufacturing -> "Sampling Template Header"';
            DataClassification = CustomerContent;

            trigger OnLookup()
            var
                FrmItemSamplingTemp: Page "Item Sampling Templates";
                ItemSamplingTempocal: Record "Item Sampling Template";
                SamplingTempHeaderLocal: Record "SSD Sampling Temp. Header";
            begin
                case "Template Type" of
                    "template type"::Receipt:
                        begin
                            Clear(FrmItemSamplingTemp);
                            ItemSamplingTempocal.Reset;
                            ItemSamplingTempocal.FilterGroup(2);
                            ItemSamplingTempocal.SetRange("Item Code", "Item No.");
                            ItemSamplingTempocal.SetRange("Template Type", "Template Type");
                            ItemSamplingTempocal.SetRange(Active, true);
                            ItemSamplingTempocal.FilterGroup(0);
                            if ItemSamplingTempocal.Find('-') then begin
                                FrmItemSamplingTemp.SetTableview(ItemSamplingTempocal);
                                FrmItemSamplingTemp.LookupMode(true);
                                FrmItemSamplingTemp.Editable(false);
                                if FrmItemSamplingTemp.RunModal = Action::LookupOK then begin
                                    FrmItemSamplingTemp.GetRecord(ItemSamplingTempocal);
                                    Validate("Sampling Temp. No.", ItemSamplingTempocal."Sampling Temp. No.");
                                end;
                            end;
                        end;
                    else begin
                        if SamplingTempHeaderLocal.Get("Sampling Temp. No.") then if SamplingTempHeaderLocal."Template Type" <> SamplingTempHeaderLocal."template type"::Receipt then Page.RunModal(0, SamplingTempHeaderLocal);
                    end;
                end;
            end;

            trigger OnValidate()
            var
                SamplingHeaderLocal: Record "SSD Sampling Temp. Header";
                QualityOrderLineLocal: Record "SSD Quality Order Line";
                ItemSamplingTempocal: Record "Item Sampling Template";
            begin
                TestField(Status, Status::Open);
                TestField("Sampling Temp. No.");
                SamplingHeaderLocal.Get("Sampling Temp. No.");
                //**** Checking Of Item sampling Template Record ********
                ItemSamplingTempocal.Reset;
                ItemSamplingTempocal.SetCurrentkey("Item Code", "Template Type", Active);
                ItemSamplingTempocal.SetRange("Item Code", "Item No.");
                ItemSamplingTempocal.SetRange("Template Type", "Template Type");
                ItemSamplingTempocal.SetRange(Active, true);
                if not ItemSamplingTempocal.Find('-') then Error(Txt00003, "Sampling Temp. No.", "Item No.");
                if SamplingHeaderLocal.Get("Sampling Temp. No.") then begin
                    SamplingHeaderLocal.TestField(Status, SamplingHeaderLocal.Status::Certified);
                    "Kind of Sampling" := SamplingHeaderLocal."Kind of Sampling";
                    Validate("Sampling Method", SamplingHeaderLocal."Sampling Method");
                    Validate("Percentage / Fixed Quantity", SamplingHeaderLocal."Percentage / Fixed Quantity");
                    Modify;
                end;
            end;
        }
        field(43; "Item No."; Code[20])
        {
            Editable = false;
            TableRelation = Item;
            DataClassification = CustomerContent;
            Caption = 'Item No.';
        }
        field(44; "Lot Size"; Decimal)
        {
            Editable = true;
            MinValue = 0;
            DataClassification = CustomerContent;
            Caption = 'Lot Size';
        }
        field(45; "Sample Size"; Decimal)
        {
            MinValue = 0;
            DataClassification = CustomerContent;
            Caption = 'Sample Size';

            trigger OnValidate()
            begin
                TestField(Status, Status::Open);
                if "Sample Size" > "Lot Size" then Error(Txt00002, FieldCaption("Sample Size"), "Lot Size");
                if ("Template Type" = "template type"::Receipt) and ("Is Coil Type" = false) then begin
                    "Accepted Qty." := "Sample Size";
                    "Rejected Qty." := 0;
                    ModifyQOrderLineForSampleSize(Rec);
                end;
            end;
        }
        field(46; "Posting Date"; Date)
        {
            Editable = true;
            DataClassification = CustomerContent;
            Caption = 'Posting Date';

            trigger OnValidate()
            begin
                TestField(Status, Status::Open);
            end;
        }
        field(47; "Suggest For Quality Pass"; Option)
        {
            Editable = false;
            OptionCaption = ' ,Acceptable,Rejectable';
            OptionMembers = " ",Acceptable,Rejectable;
            DataClassification = CustomerContent;
            Caption = 'Suggest For Quality Pass';
        }
        field(48; "Decision For Quality Pass"; Option)
        {
            OptionCaption = ' ,Accepted,Rejected';
            OptionMembers = " ",Accepted,Rejected;
            DataClassification = CustomerContent;
            Caption = 'Decision For Quality Pass';
        }
        field(50; "Source Doc Date"; Date)
        {
            Editable = false;
            DataClassification = CustomerContent;
            Caption = 'Source Doc Date';
        }
        field(51; "Lot No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Lot No.';
        }
        field(52; "Creation Date"; Date)
        {
            Editable = false;
            DataClassification = CustomerContent;
            Caption = 'Creation Date';
        }
        field(53; "Source Document No."; Code[20])
        {
            Description = 'For Receipt-> "PO";  For MRN -> "Warehouse Receipt Order";  For Other -> "Prod. Order No."';
            Editable = false;
            TableRelation = if ("Entry Source Type" = const(Purchase)) "Purchase Header"."No."
            else if ("Entry Source Type" = const(MRN)) "Warehouse Receipt Header"."No."
            else if ("Entry Source Type" = const("Manufac.")) "Production Order"."No.";
            //This property is currently not supported
            //TestTableRelation = true;
            ValidateTableRelation = true;
            DataClassification = CustomerContent;
            Caption = 'Source Document No.';

            trigger OnLookup()
            var
                PurchaseHeaderLocal: Record "Purchase Header";
                WRHeaderLocal: Record "Warehouse Receipt Header";
                ProductionOrderLocal: Record "Production Order";
            begin
                if "Source Document No." <> '' then begin
                    case "Entry Source Type" of
                        "entry source type"::Purchase:
                            begin
                                if PurchaseHeaderLocal.Get(PurchaseHeaderLocal."document type"::Order, "Source Document No.") then Page.RunModal(0, PurchaseHeaderLocal);
                            end;
                        "entry source type"::MRN:
                            begin
                                if WRHeaderLocal.Get("Source Document No.") then Page.RunModal(0, WRHeaderLocal);
                            end;
                        else begin
                            if ProductionOrderLocal.Get(ProductionOrderLocal.Status::Released, "Source Document No.") then Page.RunModal(0, ProductionOrderLocal);
                        end;
                    end;
                end;
            end;
        }
        field(54; "Location Code"; Code[10])
        {
            Editable = false;
            TableRelation = Location;
            DataClassification = CustomerContent;
            Caption = 'Location Code';
        }
        field(55; "Bin Code"; Code[20])
        {
            Editable = false;
            TableRelation = Bin.Code where("Location Code" = field("Location Code"));
            DataClassification = CustomerContent;
            Caption = 'Bin Code';
        }
        field(57; "Capacity Entry No."; Integer)
        {
            Editable = false;
            TableRelation = "Res. Capacity Entry";
            DataClassification = CustomerContent;
            Caption = 'Capacity Entry No.';
        }
        field(58; "External Document No."; Code[20])
        {
            Editable = false;
            DataClassification = CustomerContent;
            Caption = 'External Document No.';
        }
        field(59; "Defect Code"; Code[10])
        {
            Caption = 'Defect Code';
            TableRelation = "SSD Quality Defects";
            DataClassification = CustomerContent;
        }
        field(60; "Concerted Quality"; Boolean)
        {
            Caption = 'Concerted Quality';
            Description = 'QLT';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(61; "Vendor Claim Code"; Code[10])
        {
            Description = 'QLT';
            TableRelation = "SSD Amazon Staging"."Entry No.";
            DataClassification = CustomerContent;
            Caption = 'Vendor Claim Code';
        }
        field(100; "Accepted Qty."; Decimal)
        {
            Caption = 'Accepted Qty.';
            MinValue = 0;
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                CheckAcceptedQty;
                ModifyQOrderLineForAcceptedQty(Rec);
            end;
        }
        field(101; "Rejected Qty."; Decimal)
        {
            Caption = 'Rejected Qty.';
            Editable = false;
            MinValue = 0;
            DataClassification = CustomerContent;
        }
        field(102; "Qty. to Scrapping"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Qty. to Scrapping';

            trigger OnValidate()
            begin
                CheckAcceptedQty;
            end;
        }
        field(103; "Qty. to Reclassif."; Decimal)
        {
            Caption = 'Qty. to Reclassification';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                CheckAcceptedQty;
            end;
        }
        field(104; "Qty. to Reprocess"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Qty. to Reprocess';

            trigger OnValidate()
            begin
                CheckAcceptedQty;
            end;
        }
        field(105; "Wrong Quantity"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Wrong Quantity';

            trigger OnValidate()
            begin
                CheckAcceptedQty;
            end;
        }
        field(110; "Scraps Location Code"; Code[10])
        {
            TableRelation = Location;
            DataClassification = CustomerContent;
            Caption = 'Scraps Location Code';
        }
        field(111; "Scrap Bin Code"; Code[20])
        {
            Caption = 'Scrap Bin Code';
            TableRelation = Bin.Code where("Location Code" = field("Scraps Location Code"));
            DataClassification = CustomerContent;
        }
        field(112; "Reclass. Location Code"; Code[10])
        {
            TableRelation = Location;
            DataClassification = CustomerContent;
            Caption = 'Reclass. Location Code';
        }
        field(113; "Reclass. Bin Code"; Code[20])
        {
            Caption = 'Reclass. Bin Code';
            TableRelation = Bin.Code where("Location Code" = field("Reclass. Location Code"));
            DataClassification = CustomerContent;
        }
        field(114; "Reprocess Location Code"; Code[10])
        {
            TableRelation = Location;
            DataClassification = CustomerContent;
            Caption = 'Reprocess Location Code';
        }
        field(115; "Reprocess Bin Code"; Code[20])
        {
            Caption = 'Reprocess Bin Code';
            TableRelation = Bin.Code where("Location Code" = field("Reprocess Location Code"));
            DataClassification = CustomerContent;
        }
        field(200; "Process/Operation Type"; Option)
        {
            Description = 'Coming From Prod. Order Routing Line ->"Type"';
            OptionCaption = 'Work Center,Machine Center';
            OptionMembers = "Work Center","Machine Center";
            DataClassification = CustomerContent;
            Caption = 'Process/Operation Type';
        }
        field(201; "W.C. / M.C. No."; Code[20])
        {
            Caption = 'Work Center/Machune Center No.';
            Description = 'Coming From Prod. Order Routing Line ->"No."';
            TableRelation = if ("Process/Operation Type" = const("Work Center")) "Work Center"
            else if ("Process/Operation Type" = const("Machine Center")) "Machine Center";
            DataClassification = CustomerContent;
        }
        field(202; "Run Time"; Decimal)
        {
            DecimalPlaces = 0 : 5;
            DataClassification = CustomerContent;
            Caption = 'Run Time';

            trigger OnValidate()
            begin
                "Run Time (Base)" := "Run Time" * "Qty. per Unit of Measure";
            end;
        }
        field(203; "Work Center No."; Code[20])
        {
            Editable = false;
            TableRelation = "Work Center";
            DataClassification = CustomerContent;
            Caption = 'Work Center No.';
        }
        field(204; "Work Center Group Code"; Code[10])
        {
            Editable = false;
            TableRelation = "Work Center Group";
            DataClassification = CustomerContent;
            Caption = 'Work Center Group Code';
        }
        field(205; "Starting Time"; Time)
        {
            DataClassification = CustomerContent;
            Caption = 'Starting Time';

            trigger OnValidate()
            begin
                if "Ending Time" < "Starting Time" then "Ending Time" := "Starting Time";
                Validate("Concurrent Capacities");
            end;
        }
        field(206; "Ending Time"; Time)
        {
            DataClassification = CustomerContent;
            Caption = 'Ending Time';

            trigger OnValidate()
            begin
                if "Ending Time" < "Starting Time" then Error('Txt00002', FieldName("Ending Time"), FieldName("Starting Time"));
                Validate("Concurrent Capacities");
            end;
        }
        field(207; "Concurrent Capacities"; Decimal)
        {
            DecimalPlaces = 0 : 5;
            DataClassification = CustomerContent;
            Caption = 'Concurrent Capacities';

            trigger OnValidate()
            begin
                if "Concurrent Capacities" = 0 then exit;
                TestField("Starting Time");
                TestField("Ending Time");
                TestField("Work Center No.");
                WorkCenter.Get("Work Center No.");
                Validate("Setup Time", 0);
                Validate("Run Time", ROUND(("Ending Time" - "Starting Time") / CalendarManagement.TimeFactor("Unit of Measure Code") * "Concurrent Capacities", WorkCenter."Calendar Rounding Precision"));
            end;
        }
        field(209; "Variant Code"; Code[10])
        {
            TableRelation = "Item Variant".Code where("Item No." = field("Item No."), Code = field("Variant Code"));
            DataClassification = CustomerContent;
            Caption = 'Variant Code';

            trigger OnValidate()
            begin
                if "Variant Code" = '' then Validate("Item No.");
            end;
        }
        field(210; "Scrap Code"; Code[10])
        {
            TableRelation = Scrap;
            DataClassification = CustomerContent;
            Caption = 'Scrap Code';

            trigger OnValidate()
            begin
                TestField("Process/Operation Type", "process/operation type"::"Machine Center");
            end;
        }
        field(211; "Work Shift Code"; Code[10])
        {
            TableRelation = "Work Shift";
            DataClassification = CustomerContent;
            Caption = 'Work Shift Code';
        }
        field(212; "Shortcut Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,2,1';
            Caption = 'Shortcut Dimension 1 Code';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1));
            DataClassification = CustomerContent;
        }
        field(213; "Shortcut Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,2,2';
            Caption = 'Shortcut Dimension 2 Code';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2));
            DataClassification = CustomerContent;
        }
        field(214; Finished; Boolean)
        {
            Editable = true;
            DataClassification = CustomerContent;
            Caption = 'Finished';
        }
        field(215; "Setup Time"; Decimal)
        {
            DecimalPlaces = 0 : 5;
            DataClassification = CustomerContent;
            Caption = 'Setup Time';

            trigger OnValidate()
            begin
                "Set. Time (Base)" := "Setup Time" * "Qty. per Unit of Measure";
                Validate("Run Time");
            end;
        }
        field(216; "Output Quantity"; Decimal)
        {
            DecimalPlaces = 0 : 5;
            DataClassification = CustomerContent;
            Caption = 'Output Quantity';

            trigger OnValidate()
            begin
                "Output Quantity (Base)" := "Output Quantity" * "Qty. per Unit of Meas. (Item)";
                "Lot Size" := "Output Quantity (Base)";
                "Sample Size" := CalculateSampleSize;
            end;
        }
        field(217; "Scrap Quantity"; Decimal)
        {
            Caption = 'Scrapped Quantity';
            DecimalPlaces = 0 : 5;
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                "Scrap Quantity (Base)" := "Scrap Quantity" * "Qty. per Unit of Meas. (Item)";
            end;
        }
        field(218; "Output Quantity (Base)"; Decimal)
        {
            DecimalPlaces = 0 : 5;
            DataClassification = CustomerContent;
            Caption = 'Output Quantity (Base)';

            trigger OnValidate()
            begin
                TestField("Qty. per Unit of Meas. (Item)", 1);
                Validate("Output Quantity", "Output Quantity (Base)");
            end;
        }
        field(219; "Scrap Quantity (Base)"; Decimal)
        {
            DecimalPlaces = 0 : 5;
            DataClassification = CustomerContent;
            Caption = 'Scrap Quantity (Base)';

            trigger OnValidate()
            begin
                TestField("Qty. per Unit of Meas. (Item)", 1);
                Validate("Scrap Quantity", "Scrap Quantity (Base)");
            end;
        }
        field(220; "Unit of Measure Code (Item)"; Code[10])
        {
            Editable = false;
            TableRelation = "Item Unit of Measure".Code where("Item No." = field("Item No."));
            DataClassification = CustomerContent;
            Caption = 'Unit of Measure Code (Item)';

            trigger OnValidate()
            begin
                Item.Get("Item No.");
                "Qty. per Unit of Meas. (Item)" := UOMManagement.GetQtyPerUnitOfMeasure(Item, "Unit of Measure Code (Item)");
                Validate("Output Quantity");
                Validate("Scrap Quantity");
            end;
        }
        field(221; "Run Time (Base)"; Decimal)
        {
            DecimalPlaces = 0 : 5;
            DataClassification = CustomerContent;
            Caption = 'Run Time (Base)';

            trigger OnValidate()
            begin
                TestField("Qty. per Unit of Measure", 1);
                Validate("Run Time", "Run Time (Base)");
            end;
        }
        field(222; "Set. Time (Base)"; Decimal)
        {
            DecimalPlaces = 0 : 5;
            DataClassification = CustomerContent;
            Caption = 'Set. Time (Base)';

            trigger OnValidate()
            begin
                TestField("Qty. per Unit of Measure", 1);
                Validate("Run Time", "Run Time (Base)");
            end;
        }
        field(223; "Unit of Measure Code"; Code[10])
        {
            Editable = false;
            TableRelation = "Capacity Unit of Measure";
            DataClassification = CustomerContent;
            Caption = 'Unit of Measure Code';

            trigger OnValidate()
            begin
                "Qty. per Unit of Measure" := CalendarManagement.QtyperTimeUnitofMeasure("Work Center No.", "Unit of Measure Code");
                Validate("Setup Time");
            end;
        }
        field(224; "Qty. per Unit of Measure"; Decimal)
        {
            DecimalPlaces = 0 : 5;
            Editable = false;
            DataClassification = CustomerContent;
            Caption = 'Qty. per Unit of Measure';
        }
        field(225; "Qty. per Unit of Meas. (Item)"; Decimal)
        {
            DecimalPlaces = 0 : 5;
            Editable = false;
            InitValue = 1;
            DataClassification = CustomerContent;
            Caption = 'Qty. per Unit of Meas. (Item)';
        }
        field(6060; "Reprocess Routing No."; Code[20])
        {
            TableRelation = "Routing Header";
            DataClassification = CustomerContent;
            Caption = 'Reprocess Routing No.';
        }
        field(6061; "Reprocess BOM No."; Code[20])
        {
            TableRelation = "Production BOM Header";
            DataClassification = CustomerContent;
            Caption = 'Reprocess BOM No.';
        }
        field(6500; "Item Tracking No."; Integer)
        {
            Editable = false;
            DataClassification = CustomerContent;
            Caption = 'Item Tracking No.';
        }
        field(6501; "Serial No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Serial No.';
        }
        field(6502; "Sample Remark"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Sample Remark';
        }
        field(6503; "Qty. Sent For Inspection"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Qty. Sent For Inspection';
        }
        field(50001; "Responsibility Center"; Code[10])
        {
            Caption = 'Responsibility Center';
            Editable = false;
            TableRelation = "Responsibility Center";
            DataClassification = CustomerContent;
        }
        field(50002; "Process / Operation Code"; Code[20])
        {
            Description = 'Coming From Sampling Template Header ->"Process/Operation No."';
            //SSD Comment Start
            //TableRelation = "Sampling Temp. Header"."Process / Operation No." where("Template Type" = field("Template Type"),
            //                                                                         "No." = field("Sampling Temp. No."));
            //SSD Comment End
            DataClassification = CustomerContent;
            Caption = 'Process / Operation Code';
        }
        field(50003; "Process / Operation"; Text[30])
        {
            CalcFormula = lookup("Work Center"."Process / Operation" where("No." = field("Process / Operation Code")));
            Description = 'Coming from Work center -> "Process/Operation"';
            Editable = false;
            FieldClass = FlowField;
            Caption = 'Process / Operation';
        }
        field(50004; "Type Of Inspection"; Option)
        {
            CalcFormula = lookup("SSD Setup Quality Sub-Template"."Type Of Inspection" where("Template Type" = filter(Manufacturing | Routing), "Responsibility Center" = field("Responsibility Center"), "Process / Operation No." = field("Process / Operation Code"), "Sampling Template No." = field("Sampling Temp. No.")));
            Description = 'LineInspection,FinalInspection';
            Editable = false;
            FieldClass = FlowField;
            OptionCaption = 'LineInspection,FinalInspection';
            OptionMembers = LineInsp,FinalInsp;
            Caption = 'Type Of Inspection';
        }
        field(50005; "PPC Dev. Req. Ref. No."; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'PPC Dev. Req. Ref. No.';
        }
        field(50006; "Rejected Coil Nos."; Text[30])
        {
            DataClassification = CustomerContent;
            Caption = 'Rejected Coil Nos.';
        }
        field(50007; "Inspection Report Generated"; Boolean)
        {
            Editable = true;
            DataClassification = CustomerContent;
            Caption = 'Inspection Report Generated';
        }
        field(50009; "Total Qty. Sent For Inspection"; Decimal)
        {
            CalcFormula = sum("SSD Quality Order Header"."Lot Size" where("Template Type" = filter(Routing | RcvdCoil), "Entry Source Type" = field("Entry Source Type"), "Source Document No." = field("Source Document No."), "Order No." = field("No.")));
            Editable = false;
            FieldClass = FlowField;
            Caption = 'Total Qty. Sent For Inspection';
        }
        field(50010; "No. Of Coil"; Integer)
        {
            Description = 'Coming From MRN';
            Editable = false;
            DataClassification = CustomerContent;
            Caption = 'No. Of Coil';
        }
        field(50011; "Is Coil Type"; Boolean)
        {
            Editable = true;
            DataClassification = CustomerContent;
            Caption = 'Is Coil Type';
        }
        field(50012; Customer; Code[50])
        {
            TableRelation = Customer."No.";
            DataClassification = CustomerContent;
            Caption = 'Customer';
        }
        field(50013; "Supplier Coil No."; Code[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Supplier Coil No.';
        }
        field(50014; "R.M Dia"; Code[50])
        {
            DataClassification = CustomerContent;
            Caption = 'R.M Dia';
        }
        field(50015; "Coil Dia"; Code[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Coil Dia';
        }
        field(50016; "MTR No."; Code[50])
        {
            DataClassification = CustomerContent;
            Caption = 'MTR No.';
        }
        field(50017; "Sample ID"; Code[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Sample ID';
        }
        field(50018; "Material Condition"; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Material Condition';
        }
        field(50089; "Accepted Under Deviation"; Option)
        {
            OptionCaption = ' ,Accepted Under Deviation,Accepted after Rework,Aceepted after Segragation';
            OptionMembers = " ","Accepted Under Deviation","Accepted after Rework","Aceepted after Segragation";
            DataClassification = CustomerContent;
            Caption = 'Accepted Under Deviation';
        }
        field(50090; "HT Batch No."; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'HT Batch No.';
        }
        field(50091; "LIR No."; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'LIR No.';
        }
        field(50092; "FIR No"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'FIR No';
        }
        field(50093; "FIR Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'FIR Date';
        }
        field(50094; "Drg. Rev No."; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Drg. Rev No.';
        }
        field(50095; "Hardening Temperature"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Hardening Temperature';
        }
        field(50096; "Hardening Travel Time"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Hardening Travel Time';
        }
        field(50097; "Tempering Temperature"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Tempering Temperature';
        }
        field(50098; "Tempering Travel Time"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Tempering Travel Time';
        }
        field(50099; "C.P.1 Set"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'C.P.1 Set';
        }
        field(50100; "C.P.2 Set"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'C.P.2 Set';
        }
        field(50101; "Qty Kg"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Qty Kg';
        }
        field(50102; "Qty No's"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Qty No''s';
        }
        field(50103; "No.2"; Code[20])
        {
            CalcFormula = lookup(Item."No. 2" where("No." = field("Item No.")));
            Enabled = true;
            FieldClass = FlowField;
            Caption = 'No.2';
        }
        field(50104; "IJL Line No"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'IJL Line No';
        }
        field(50105; Subcontracting; Boolean)
        {
            Description = 'ZEV-5-51';
            InitValue = false;
            DataClassification = CustomerContent;
            Caption = 'Subcontracting';
        }
        field(50106; Remarks; Text[50])
        {
            Description = 'ZEV-5-51';
            DataClassification = CustomerContent;
            Caption = 'Remarks';
        }
        field(50114; "Time of Creation"; Time)
        {
            Description = 'Alle[Z]';
            Editable = false;
            DataClassification = CustomerContent;
            Caption = 'Time of Creation';
        }
        field(50115; "Time Of Posting"; Time)
        {
            Description = 'Alle[Z]';
            Editable = false;
            DataClassification = CustomerContent;
            Caption = 'Time Of Posting';
        }
        field(50116; "Total Qty. Sent For Inspet(K)"; Decimal)
        {
            CalcFormula = sum("SSD Quality Order Header"."Lot Size" where("Template Type" = filter(Receipt), "Entry Source Type" = field("Entry Source Type"), "Source Document No." = field("Source Document No."), "No." = field("No.")));
            Editable = false;
            FieldClass = FlowField;
            Caption = 'Total Qty. Sent For Inspet(K)';
        }
        field(50117; "Manufacturing Date As Label"; Date)
        {
            Description = 'Alle SANK';
            DataClassification = CustomerContent;
            Caption = 'Manufacturing Date As Label';
        }
        field(50118; "Is NABL Accredited"; Boolean)
        {
            Description = 'Alle[V]';
            DataClassification = CustomerContent;
            Caption = 'Is NABL Accredited';
        }
        field(50119; "Parameter Type"; Option)
        {
            Description = 'Alle 1.0 290818';
            OptionCaption = ',F,P';
            OptionMembers = ,F,P;
            DataClassification = CustomerContent;
            Caption = 'Parameter Type';
        }
        field(50120; "ULR No."; Code[20])
        {
            Description = 'Alle 1.0 290818';
            DataClassification = CustomerContent;
            Caption = 'ULR No.';
        }
        field(50121; "Description 3"; Text[300])
        {
            Description = 'Alle 1.0 210119';
            DataClassification = CustomerContent;
            Caption = 'Description 3';
        }
        field(50124; "Supplier Batch No."; Code[20])
        {
            Description = 'ALLE-NM';
            DataClassification = CustomerContent;
            Caption = 'Supplier Batch No.';
        }
        //SSD Sunil
        field(50125; "Vendor Item Description"; Text[100])
        {
            Description = 'Vendor Item Description';
            Editable = false;
            DataClassification = CustomerContent;
            Caption = 'Vendor Item Description';
        }
    }
    keys
    {
        key(Key1; "No.")
        {
            Clustered = true;
        }
        key(Key2; "Template Type", "Source Code")
        {
        }
        key(Key3; "Template Type", "Entry Source Type", "Order No.")
        {
        }
        key(Key4; "Capacity Entry No.")
        {
        }
        key(Key5; "Template Type", "Source Code", "Source Doc. Line No.", "Item No.")
        {
        }
        key(Key6; "Template Type", "Entry Source Type", "Source Document No.", "Order No.", "No.")
        {
            SumIndexFields = "Lot Size", "Sample Size";
        }
        key(Key7; "Lot No.", "Source Document No.", "Source Doc. Line No.")
        {
        }
    }
    fieldgroups
    {
    }
    trigger OnDelete()
    var
        rQualityComent: Record "SSD Quality Comments";
        QualityOrderLineLocal: Record "SSD Quality Order Line";
    begin
        //ALLE Event start
        // TESTFIELD(Status,Status::Open);
        // TESTFIELD(Finished,FALSE);
        //
        // QualityOrderLineLocal.RESET;
        // QualityOrderLineLocal.SETRANGE("Document No.","No.");
        // IF QualityOrderLineLocal.FIND('-') THEN
        //  QualityOrderLineLocal.DELETEALL(TRUE);
        //
        // rQualityComent.RESET;
        // rQualityComent.SETRANGE( rQualityComent.TableId,DATABASE::"Quality Order Header");
        // rQualityComent.SETRANGE( rQualityComent."Doc. No.", "No.");
        // rQualityComent.SETRANGE( rQualityComent."Line No.", 0);
        // IF rQualityComent.FIND('-') THEN
        //  rQualityComent.DELETEALL;
        //Alle Event End
    end;

    trigger OnInsert()
    begin
        //SSD if "Responsibility Center" = '' then
        //SSD "Responsibility Center" := UserMgt.GetRespCenterFilter;
        SetupQuality.Get("Responsibility Center");
        if "No." = '' then begin
            "No. Series" := GetNoSeries(true);
            //  NoSeriesMgt.InitSeries("No. Series", xRec."No. Series", WorkDate, "No.", "No. Series");
            if NoSeriesMgt.AreRelated("No. Series", xRec."No. Series") then
                "No. Series" := xRec."No. Series";
            "No." := NoSeriesMgt.GetNextNo("No. Series", WorkDate);
        end;
        "Scraps Location Code" := SetupQuality."Return Location Code";
        if SetupQuality."Reclass. Location Code" <> '' then
            "Reclass. Location Code" := SetupQuality."Reclass. Location Code"
        else
            "Reclass. Location Code" := "Location Code";
        "Reprocess Location Code" := "Location Code";
    end;

    trigger OnModify()
    begin
        TestField(Status, Status::Open);
        TestField(Finished, false);
        "Entry User" := UserId;
        "Last Date Modified" := WorkDate;
    end;

    var
        NoSeriesMgt: Codeunit "No. Series";//IG_DS NoSeriesManagement;
        SetupQuality: Record "SSD Quality Setup";
        WorkCenter: Record "Work Center";
        UOMManagement: Codeunit "Unit of Measure Management";
        CalendarManagement: Codeunit "Shop Calendar Management";
        Item: Record Item;
        ProdOrderRoutingLine: Record "Prod. Order Routing Line";
        InspectionLetterCode: Record "SSD Indent Line2";
        ItemsReclassification: Record "SSD Items Reclassification";
        ItemTrackingMgt: Codeunit "Item Tracking Management";
        Txt00001: label '%1 Can''t be less than %2';
        Txt00002: label '%1 can''t be more than %2';
        //SSD UserMgt: Codeunit "SSD User Setup Management";
        QualityMgt: Codeunit "Quality Management";
        Txt00003: label 'Sampling Template No %1  not attached with Item Code %2';
        Txt00004: label 'No Line Present';
        Txt00005: label '%1 must be equal to %2';
        Txt00006: label '%1 must be Acceptable or Rejectable';
        Txt00007: label 'Rejected Qty must be more than 0';
        "No.2": Code[20];
        ItemTrackingCode: Record "Item Tracking Code";

    procedure AsistEdic(RecSamplingDocHeader: Record "SSD Quality Order Header"): Boolean
    var
        SamplingDocHeaderLocal: Record "SSD Quality Order Header";
        SamplingDocHeaderLocal2: Record "SSD Quality Order Header";
        Text012: Label 'The No. %1 %2 already exists.';
    begin
        SamplingDocHeaderLocal := Rec;
        //SSD if "Responsibility Center" = '' then
        //SSD "Responsibility Center" := UserMgt.GetRespCenterFilter;
        SetupQuality.Get(SamplingDocHeaderLocal."Responsibility Center");
        //IG_DS_Before if NoSeriesMgt.SelectSeries(SamplingDocHeaderLocal.GetNoSeries(true), RecSamplingDocHeader."No. Series", SamplingDocHeaderLocal."No. Series") then begin
        //     SetupQuality.Get(SamplingDocHeaderLocal."Responsibility Center");
        //     NoSeriesMgt.SetSeries(SamplingDocHeaderLocal."No.");
        //     Rec := SamplingDocHeaderLocal;
        //     exit(true);
        // end;

        if NoSeriesMgt.LookupRelatedNoSeries(SamplingDocHeaderLocal.GetNoSeries(true), RecSamplingDocHeader."No. Series", SamplingDocHeaderLocal."No. Series") then begin
            SetupQuality.Get(SamplingDocHeaderLocal."Responsibility Center");
            SamplingDocHeaderLocal."No." := NoSeriesMgt.GetNextNo(SamplingDocHeaderLocal."No. Series");
            if SamplingDocHeaderLocal2.Get(SamplingDocHeaderLocal."No.") then
                Error(Text012, SamplingDocHeaderLocal."No.");
            Rec := SamplingDocHeaderLocal;
            exit(true);
        end;
    end;

    procedure Print(MostrarFormSoli: Boolean)
    var
        SelectReportsQuality: Record "Report Selections";
        SamplingDocHeaderLocal: Record "SSD Quality Order Header";
    begin
        SamplingDocHeaderLocal.Copy(Rec);
        SamplingDocHeaderLocal.SetRecfilter;
        case SamplingDocHeaderLocal."Template Type" of //SSD "template type"::Receipt:
                                                       //SSD SelectReportsQuality.SetRange(Usage, SelectReportsQuality.Usage::"S.Arch. Quote");
            SamplingDocHeaderLocal."template type"::Manufacturing:
                SelectReportsQuality.SetRange(Usage, SelectReportsQuality.Usage::"P.Test Prepmt.");
        //SSD "template type"::Routing:
        //SSD SelectReportsQuality.SetRange(Usage, SelectReportsQuality.Usage::"S.Arch. Quote");
        end;
        SelectReportsQuality.SetFilter("Report ID", '<>0');
        SelectReportsQuality.Find('-');
        repeat
            Report.RunModal(SelectReportsQuality."Report ID", MostrarFormSoli, false, SamplingDocHeaderLocal);
        until SelectReportsQuality.Next = 0;
    end;

    procedure GetNoSeries(Verificar: Boolean): Code[10]
    begin
        //SSD if "Responsibility Center" = '' then
        //SSD "Responsibility Center" := UserMgt.GetRespCenterFilter;
        SetupQuality.Get("Responsibility Center");
        case "Template Type" of
            "template type"::Receipt:
                begin
                    SetupQuality.TestField("Rcvd. Quality Ord No.");
                    exit(SetupQuality."Rcvd. Quality Ord No.");
                end;
            "template type"::Manufacturing:
                begin
                    SetupQuality.TestField("Manf. Quality Ord. No.");
                    exit(SetupQuality."Manf. Quality Ord. No.");
                end;
            "template type"::Routing:
                begin
                    SetupQuality.TestField("Manf. Sub Quality Ord No.");
                    exit(SetupQuality."Manf. Sub Quality Ord No.");
                end;
            "template type"::RcvdCoil:
                begin
                    SetupQuality.TestField("Rcvd. Sub Quality Ord No.");
                    exit(SetupQuality."Rcvd. Sub Quality Ord No.");
                end;
        end;
    end;

    procedure ShowComent()
    var
        rQualityComent: Record "SSD Quality Comments";
        fQualityComent: Page "Quality Comments";
    begin
        rQualityComent.Reset;
        rQualityComent.FilterGroup(2);
        rQualityComent.SetRange(rQualityComent.TableId, Database::"SSD Quality Order Header");
        rQualityComent.SetRange(rQualityComent."Doc. No.", "No.");
        rQualityComent.SetRange(rQualityComent."Line No.", 0);
        rQualityComent.FilterGroup(0);
        fQualityComent.SetTableview(rQualityComent);
        fQualityComent.Run;
    end;

    procedure CalculateSampleSize(): Decimal
    begin
        case "Sampling Method" of
            "sampling method"::Percentage:
                begin
                    Validate("Sample Size", "Lot Size" * "Percentage / Fixed Quantity" / 100);
                    exit("Sample Size");
                end;
            "sampling method"::"Fixed Quantity":
                if "Percentage / Fixed Quantity" > "Lot Size" then begin
                    Validate("Sample Size", "Lot Size");
                    exit("Sample Size");
                end
                else begin
                    Validate("Sample Size", "Percentage / Fixed Quantity");
                    exit("Sample Size");
                end;
            "sampling method"::"Complete Quantity":
                begin
                    Validate("Sample Size", "Lot Size");
                    exit("Sample Size");
                end;
        end;
    end;

    procedure CheckAcceptedQty()
    begin
        //"Rejected Qty." := "Qty. to Scrapping" + "Qty. to Reclassif." + "Qty. to Reprocess" + "Wrong Quantity";
        TestField(Status, Status::Open);
        if "Entry Source Type" in ["entry source type"::"Manufac."] then begin
            if "Accepted Qty." > "Qty. Sent For Inspection" then Error(Txt00002, FieldCaption("Accepted Qty."), "Sample Size");
            "Rejected Qty." := "Qty. Sent For Inspection" - "Accepted Qty.";
        end;
        if "Entry Source Type" in ["entry source type"::Purchase, "entry source type"::MRN] then begin
            if "Accepted Qty." > "Sample Size" then Error(Txt00002, FieldCaption("Accepted Qty."), "Sample Size");
            "Rejected Qty." := "Sample Size" - "Accepted Qty.";
        end;
    end;
    /// <summary>
    /// Navigate.
    /// </summary>
    procedure Navigate()
    var
        FNavigate: Page Navigate;
    begin
        FNavigate.SetDoc("Creation Date", "Source Document No.");
        FNavigate.Run;
    end;
    /// <summary>
    /// ModifyQOrderLineForSampleSize.
    /// </summary>
    /// <param name="RecQOrderHeader">Record "SSD Quality Order Header".</param>
    procedure ModifyQOrderLineForSampleSize(RecQOrderHeader: Record "SSD Quality Order Header")
    var
        QualityOrderLineLocal: Record "SSD Quality Order Line";
    begin
        QualityOrderLineLocal.Reset;
        QualityOrderLineLocal.SetRange("Document No.", RecQOrderHeader."No.");
        if QualityOrderLineLocal.Find('-') then
            repeat
                QualityOrderLineLocal."Qty. to be Inspected" := RecQOrderHeader."Sample Size";
                QualityOrderLineLocal.Validate("Accepted Qty.", QualityOrderLineLocal."Qty. to be Inspected");
                QualityOrderLineLocal.Modify;
            until QualityOrderLineLocal.Next = 0;
    end;
    /// <summary>
    /// ModifyQOrderLineForAcceptedQty.
    /// </summary>
    /// <param name="RecQOrderHeader">Record "SSD Quality Order Header".</param>
    procedure ModifyQOrderLineForAcceptedQty(RecQOrderHeader: Record "SSD Quality Order Header")
    var
        QualityOrderLineLocal: Record "SSD Quality Order Line";
    begin
        QualityOrderLineLocal.Reset;
        QualityOrderLineLocal.SetRange("Document No.", RecQOrderHeader."No.");
        if QualityOrderLineLocal.Find('-') then
            repeat
                QualityOrderLineLocal.Validate("Accepted Qty.", RecQOrderHeader."Accepted Qty.");
                QualityOrderLineLocal.Modify;
            until QualityOrderLineLocal.Next = 0;
    end;
    /// <summary>
    /// CheckingOfQualityOrder.
    /// </summary>
    /// <param name="RecQOrderHeader">VAR Record "SSD Quality Order Header".</param>
    procedure CheckingOfQualityOrder(var RecQOrderHeader: Record "SSD Quality Order Header")
    var
        QualityOrdLineLocal: Record "SSD Quality Order Line";
        ItemSamplingTempocal: Record "Item Sampling Template";
        ItemLocal: Record Item;
    begin
        if not (RecQOrderHeader."Template Type" in [RecQOrderHeader."template type"::Receipt, RecQOrderHeader."template type"::RcvdCoil]) then exit;
        RecQOrderHeader.TestField("Sampling Temp. No.");
        RecQOrderHeader.TestField(Finished, false);
        //**** Checking Of Item sampling Template Record ********
        if RecQOrderHeader."Template Type" <> RecQOrderHeader."template type"::RcvdCoil then begin
            ItemSamplingTempocal.Reset;
            ItemSamplingTempocal.SetCurrentkey("Item Code", "Template Type", Active);
            ItemSamplingTempocal.SetRange("Item Code", RecQOrderHeader."Item No.");
            ItemSamplingTempocal.SetRange("Template Type", RecQOrderHeader."Template Type");
            ItemSamplingTempocal.SetRange(Active, true);
            if not ItemSamplingTempocal.Find('-') then Error(Txt00003, RecQOrderHeader."Sampling Temp. No.", RecQOrderHeader."Item No.");
        end;
        if RecQOrderHeader."Sampling Method" = RecQOrderHeader."sampling method"::"Complete Quantity" then begin
            RecQOrderHeader.TestField("Decision For Quality Pass", RecQOrderHeader."decision for quality pass"::" ");
            if RecQOrderHeader."Rejected Qty." <> 0 then begin
                RecQOrderHeader.TestField("Defect Code");
                if RecQOrderHeader."Concerted Quality" then RecQOrderHeader.TestField("Vendor Claim Code");
                ItemLocal.Get(RecQOrderHeader."Item No.");
                if ItemLocal."Item Tracking Code" <> '' then CheckingForRejectLotInf(RecQOrderHeader);
            end;
        end
        else begin
            if RecQOrderHeader."Decision For Quality Pass" = RecQOrderHeader."decision for quality pass"::" " then Error(Txt00006, RecQOrderHeader.FieldCaption("Decision For Quality Pass"));
            // SR_PQA003.begin
            //IF RecQOrderHeader."Decision For Quality Pass"=RecQOrderHeader."Decision For Quality Pass"::Rejected THEN
            if RecQOrderHeader."Rejected Qty." <> 0 then // SR_PQA003.end
            begin
                RecQOrderHeader.TestField("Defect Code");
                if RecQOrderHeader."Concerted Quality" then RecQOrderHeader.TestField("Vendor Claim Code");
                ItemLocal.Get(RecQOrderHeader."Item No.");
                if ItemLocal."Item Tracking Code" <> '' then CheckingForRejectLotInf(RecQOrderHeader);
            end;
        end;
        ///*************Check For Atn Line present or not **************************
        QualityOrdLineLocal.Reset;
        QualityOrdLineLocal.SetRange("Document No.", RecQOrderHeader."No.");
        QualityOrdLineLocal.SetFilter("Template Type", '%1|%2', QualityOrdLineLocal."template type"::Receipt, QualityOrdLineLocal."template type"::RcvdCoil);
        if not QualityOrdLineLocal.Find('-') then Error(Txt00004);
    end;

    procedure CheckingForRejectLotInf(var RecQOrderHeader: Record "SSD Quality Order Header")
    var
        RejectLotNoInfLocal: Record "SSD Reject Lot No Information";
        TotalRejectQty: Decimal;
        ItemLocal: Record Item;
    begin
        ItemLocal.Get(RecQOrderHeader."Item No.");
        if ItemLocal."Item Tracking Code" = '' then exit;
        TotalRejectQty := 0;
        // SR2_PQA003.begin 070710
        if ItemTrackingCode.Get(ItemLocal."Item Tracking Code") then
            if ItemTrackingCode."Lot Info. Inbound Must Exist" then begin
                // SR2_PQA003.end 070710
                case RecQOrderHeader."Template Type" of
                    RecQOrderHeader."template type"::Receipt:
                        begin
                            RejectLotNoInfLocal.Reset;
                            RejectLotNoInfLocal.SetCurrentkey("Template Type", "Quality Order No.");
                            RejectLotNoInfLocal.SetRange("Template Type", RejectLotNoInfLocal."template type"::Receipt);
                            RejectLotNoInfLocal.SetRange("Quality Order No.", RecQOrderHeader."No.");
                            if RejectLotNoInfLocal.Find('-') then
                                repeat
                                    TotalRejectQty += RejectLotNoInfLocal."Rejected Qty";
                                until RejectLotNoInfLocal.Next = 0;
                            if TotalRejectQty <> RecQOrderHeader."Rejected Qty." then Error('For Rejected Qty, Lot No Information should be defined')
                        end;
                    RecQOrderHeader."template type"::RcvdCoil:
                        begin
                            RejectLotNoInfLocal.Reset;
                            RejectLotNoInfLocal.SetCurrentkey("Template Type", "Quality Order No.");
                            RejectLotNoInfLocal.SetRange("Template Type", RejectLotNoInfLocal."template type"::Receipt);
                            RejectLotNoInfLocal.SetRange("Quality Order No.", RecQOrderHeader."Order No.");
                            RejectLotNoInfLocal.SetRange("Sub Template Type", RejectLotNoInfLocal."sub template type"::RcvdCoil);
                            RejectLotNoInfLocal.SetRange("Sub Quality Order No.", RecQOrderHeader."No.");
                            if RejectLotNoInfLocal.Find('-') then
                                repeat
                                    TotalRejectQty += RejectLotNoInfLocal."Rejected Qty";
                                until RejectLotNoInfLocal.Next = 0;
                            if TotalRejectQty <> RecQOrderHeader."Rejected Qty." then Error('For Rejected Qty, Lot No Information should be defined')
                        end
                end;
            end; // SR 070710
    end;
    /// <summary>
    /// RejectLotInform.
    /// </summary>
    /// <param name="RecQOrderHeader">VAR Record "SSD Quality Order Header".</param>
    procedure RejectLotInform(var RecQOrderHeader: Record "SSD Quality Order Header")
    var
        ItemLocal: Record Item;
        RejectLotNoInfLocal: Record "SSD Reject Lot No Information";
        FrmRejectLotNoInf: Page "Reject Lot No Information";
    begin
        ItemLocal.Get(RecQOrderHeader."Item No.");
        ItemLocal.TestField("Item Tracking Code");
        if RecQOrderHeader."Rejected Qty." <= 0 then Error(Txt00007);
        case RecQOrderHeader."Template Type" of
            RecQOrderHeader."template type"::Receipt:
                begin
                    RejectLotNoInfLocal.Reset;
                    RejectLotNoInfLocal.SetCurrentkey("Template Type", "Quality Order No.");
                    RejectLotNoInfLocal.SetRange("Template Type", RejectLotNoInfLocal."template type"::Receipt);
                    RejectLotNoInfLocal.SetRange("Quality Order No.", RecQOrderHeader."No.");
                    Clear(FrmRejectLotNoInf);
                    FrmRejectLotNoInf.InitialValues(RecQOrderHeader);
                    FrmRejectLotNoInf.SetTableview(RejectLotNoInfLocal);
                    if RecQOrderHeader."Is Coil Type" then
                        FrmRejectLotNoInf.Editable := false
                    else if Status = Status::Released then
                        FrmRejectLotNoInf.Editable := false
                    else
                        FrmRejectLotNoInf.Editable := true;
                    FrmRejectLotNoInf.RunModal;
                end;
            RecQOrderHeader."template type"::RcvdCoil:
                begin
                    RejectLotNoInfLocal.Reset;
                    RejectLotNoInfLocal.SetCurrentkey("Template Type", "Quality Order No.");
                    RejectLotNoInfLocal.SetRange("Template Type", RejectLotNoInfLocal."template type"::Receipt);
                    RejectLotNoInfLocal.SetRange("Quality Order No.", RecQOrderHeader."Order No.");
                    RejectLotNoInfLocal.SetRange("Sub Template Type", RejectLotNoInfLocal."sub template type"::RcvdCoil);
                    RejectLotNoInfLocal.SetRange("Sub Quality Order No.", RecQOrderHeader."No.");
                    Clear(FrmRejectLotNoInf);
                    FrmRejectLotNoInf.InitialValues(RecQOrderHeader);
                    FrmRejectLotNoInf.SetTableview(RejectLotNoInfLocal);
                    if RecQOrderHeader."Inspection Report Generated" then
                        FrmRejectLotNoInf.Editable := false
                    else if Status = Status::Released then
                        FrmRejectLotNoInf.Editable := false
                    else
                        FrmRejectLotNoInf.Editable := true;
                    FrmRejectLotNoInf.RunModal;
                end
        end;
    end;
}
