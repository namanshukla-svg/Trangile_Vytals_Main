Table 50027 "SSD Posted Quality Ord Hdr Ar"
{
    Caption = 'Posted Quality Order Header Ar';
    DrillDownPageID = "Archived P. Quality Order";
    LookupPageID = "Archived P. Quality Order";
    DataClassification = CustomerContent;

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(2; "No. Series"; Code[10])
        {
            Editable = false;
            TableRelation = "No. Series";
            DataClassification = CustomerContent;
            Caption = 'No. Series';
        }
        field(3; Description; Text[30])
        {
            CalcFormula = lookup(Item.Description where("No."=field("Item No.")));
            Caption = 'Description';
            Editable = false;
            FieldClass = FlowField;
        }
        field(4; "Description 2"; Text[50])
        {
            CalcFormula = lookup(Item."Description 2" where("No."=field("Item No.")));
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
        field(9; "Entry User"; Code[20])
        {
            Editable = false;
            DataClassification = CustomerContent;
            Caption = 'Entry User';
        }
        field(10; "Template Type"; Option)
        {
            Editable = false;
            OptionCaption = 'Receipt,Manufacturing,Routing,RcvdCoil';
            OptionMembers = Receipt, Manufacturing, Routing, RcvdCoil;
            DataClassification = CustomerContent;
            Caption = 'Template Type';
        }
        field(11; "Approved by"; Code[20])
        {
            Editable = false;
            TableRelation = User;
            DataClassification = CustomerContent;
            Caption = 'Approved by';
        }
        field(12; "Approved Date"; Date)
        {
            Editable = false;
            DataClassification = CustomerContent;
            Caption = 'Approved Date';
        }
        field(13; "Posted By"; Code[20])
        {
            TableRelation = User;
            DataClassification = CustomerContent;
            Caption = 'Posted By';
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
            Editable = false;
            OptionCaption = 'Open,Released';
            OptionMembers = Open, Released;
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
            CalcFormula = exist("SSD Quality Comments" where(TableId=const(62810), "Doc. No."=field("No.")));
            Editable = false;
            FieldClass = FlowField;
            Caption = 'Comments';
        }
        field(25; "Sampling Method"; Option)
        {
            OptionCaption = 'Percentage,Fixed Quantity,Complete Quantity';
            OptionMembers = Percentage, "Fixed Quantity", "Complete Quantity";
            DataClassification = CustomerContent;
            Caption = 'Sampling Method';
        }
        field(26; "Percentage / Fixed Quantity"; Decimal)
        {
            Caption = 'Percentage / Fixed Quantity';
            DataClassification = CustomerContent;
        }
        field(29; "Order No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Order No.';
        }
        field(30; "Entry Source Type"; Option)
        {
            Caption = 'Entry Source Type';
            Editable = false;
            OptionCaption = 'Purchase,Manufac.,Routing,MRN';
            OptionMembers = Purchase, "Manufac.", Routing, MRN;
            DataClassification = CustomerContent;
        }
        field(31; "Source Code"; Code[20])
        {
            Caption = 'Source Code';
            Description = 'For Receipt-> "Vendor Code";  For Other -> "Prod. Order No."';
            Editable = false;
            TableRelation = if("Entry Source Type"=filter(Purchase|MRN))Vendor
            else if("Entry Source Type"=filter("Manufac."|Routing))"Prod. Order Line"."Prod. Order No." where(Status=filter(Released..Finished), "Line No."=field("Source Doc. Line No."));
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
            TableRelation = if("Entry Source Type"=const(Routing))"Prod. Order Routing Line"."Operation No." where(Status=filter(Released..Finished), "Prod. Order No."=field("Source Code"), "Routing Reference No."=field("Source Doc. Line No."), "Routing No."=field("Routing No."), "Operation No."=field("Process/Operation No."));
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
                PostedQOrderLineLocal: Record "SSD Posted Quality Order Line";
            begin
                case "Template Type" of "template type"::Receipt: begin
                    Clear(FrmItemSamplingTemp);
                    ItemSamplingTempocal.Reset;
                    ItemSamplingTempocal.FilterGroup(2);
                    ItemSamplingTempocal.SetRange("Item Code", "Item No.");
                    ItemSamplingTempocal.SetRange("Template Type", "Template Type");
                    ItemSamplingTempocal.FilterGroup(0);
                    if ItemSamplingTempocal.Find('-')then begin
                        FrmItemSamplingTemp.SetTableview(ItemSamplingTempocal);
                        FrmItemSamplingTemp.LookupMode(true);
                        FrmItemSamplingTemp.Editable(false);
                        FrmItemSamplingTemp.RunModal;
                    end;
                end;
                else
                begin
                    if SamplingTempHeaderLocal.Get("Sampling Temp. No.")then if SamplingTempHeaderLocal."Template Type" <> SamplingTempHeaderLocal."template type"::Receipt then Page.RunModal(0, SamplingTempHeaderLocal);
                end;
                end;
            end;
            trigger OnValidate()
            var
                SamplingHeaderLocal: Record "SSD Sampling Temp. Header";
                ItemSamplingTempocal: Record "Item Sampling Template";
                PostedQOrderLineLocal: Record "SSD Posted Quality Order Line";
            begin
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
            Editable = false;
            MinValue = 0;
            DataClassification = CustomerContent;
            Caption = 'Lot Size';
        }
        field(45; "Sample Size"; Decimal)
        {
            MinValue = 0;
            DataClassification = CustomerContent;
            Caption = 'Sample Size';
        }
        field(46; "Posting Date"; Date)
        {
            Editable = false;
            DataClassification = CustomerContent;
            Caption = 'Posting Date';
        }
        field(47; "Suggest For Quality Pass"; Option)
        {
            Editable = false;
            OptionCaption = ' ,Acceptable,Rejectable';
            OptionMembers = " ", Acceptable, Rejectable;
            DataClassification = CustomerContent;
            Caption = 'Suggest For Quality Pass';
        }
        field(48; "Decision For Quality Pass"; Option)
        {
            OptionCaption = ' ,Accepted ,Rejected';
            OptionMembers = " ", Accepted, Rejected;
            DataClassification = CustomerContent;
            Caption = 'Decision For Quality Pass';
        }
        field(50; "Source Doc Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Source Doc Date';
        }
        field(51; "Lot No."; Code[20])
        {
            Editable = true;
            TableRelation = "Lot No. Information"."Lot No." where("Item No."=field("Item No."), "Variant Code"=field("Variant Code"));
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
            TableRelation = if("Entry Source Type"=const(Purchase))"Purchase Header"."No."
            else if("Entry Source Type"=const(MRN))"Warehouse Receipt Header"."No."
            else if("Entry Source Type"=const("Manufac."))"Production Order"."No.";
            DataClassification = CustomerContent;
            Caption = 'Source Document No.';

            trigger OnLookup()
            var
                PurchaseHeaderLocal: Record "Purchase Header";
                WRHeaderLocal: Record "Warehouse Receipt Header";
                ProductionOrderLocal: Record "Production Order";
            begin
                if "Source Document No." <> '' then begin
                    case "Entry Source Type" of "entry source type"::Purchase: begin
                        if PurchaseHeaderLocal.Get(PurchaseHeaderLocal."document type"::Order, "Source Document No.")then Page.RunModal(0, PurchaseHeaderLocal);
                    end;
                    "entry source type"::MRN: begin
                        if WRHeaderLocal.Get("Source Document No.")then Page.RunModal(0, WRHeaderLocal);
                    end;
                    else
                    begin
                        if ProductionOrderLocal.Get(ProductionOrderLocal.Status::Finished, "Source Document No.")then Page.RunModal(0, ProductionOrderLocal);
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
            TableRelation = Bin.Code where("Location Code"=field("Location Code"));
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
        }
        field(101; "Rejected Qty."; Decimal)
        {
            Caption = 'Rejected Qty.';
            Editable = true;
            MinValue = 0;
            DataClassification = CustomerContent;
        }
        field(102; "Qty. to Scrapping"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Qty. to Scrapping';
        }
        field(103; "Qty. to Reclassif."; Decimal)
        {
            Caption = 'Qty. to Reclassification';
            DataClassification = CustomerContent;
        }
        field(104; "Qty. to Reprocess"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Qty. to Reprocess';
        }
        field(105; "Wrong Quantity"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Wrong Quantity';
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
            TableRelation = Bin.Code where("Location Code"=field("Scraps Location Code"));
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
            TableRelation = Bin.Code where("Location Code"=field("Reclass. Location Code"));
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
            TableRelation = Bin.Code where("Location Code"=field("Reprocess Location Code"));
            DataClassification = CustomerContent;
        }
        field(200; "Process/Operation Type"; Option)
        {
            Description = 'Coming From Prod. Order Routing Line ->"Type"';
            OptionCaption = 'Work Center,Machine Center';
            OptionMembers = "Work Center", "Machine Center";
            DataClassification = CustomerContent;
            Caption = 'Process/Operation Type';
        }
        field(201; "W.C. / M.C. No."; Code[20])
        {
            Caption = 'Work Center/Machune Center No.';
            Description = 'Coming From Prod. Order Routing Line ->"No."';
            TableRelation = if("Process/Operation Type"=const("Work Center"))"Work Center"
            else if("Process/Operation Type"=const("Machine Center"))"Machine Center";
            DataClassification = CustomerContent;
        }
        field(202; "Run Time"; Decimal)
        {
            DecimalPlaces = 0: 5;
            DataClassification = CustomerContent;
            Caption = 'Run Time';
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
        }
        field(206; "Ending Time"; Time)
        {
            DataClassification = CustomerContent;
            Caption = 'Ending Time';
        }
        field(207; "Concurrent Capacities"; Decimal)
        {
            DecimalPlaces = 0: 5;
            DataClassification = CustomerContent;
            Caption = 'Concurrent Capacities';
        }
        field(209; "Variant Code"; Code[10])
        {
            TableRelation = "Item Variant".Code where("Item No."=field("Item No."), Code=field("Variant Code"));
            DataClassification = CustomerContent;
            Caption = 'Variant Code';
        }
        field(210; "Scrap Code"; Code[10])
        {
            TableRelation = Scrap;
            DataClassification = CustomerContent;
            Caption = 'Scrap Code';
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
            TableRelation = "Dimension Value".Code where("Global Dimension No."=const(1));
            DataClassification = CustomerContent;
        }
        field(213; "Shortcut Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,2,2';
            Caption = 'Shortcut Dimension 2 Code';
            TableRelation = "Dimension Value".Code where("Global Dimension No."=const(2));
            DataClassification = CustomerContent;
        }
        field(214; Finished; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Finished';
        }
        field(215; "Setup Time"; Decimal)
        {
            DecimalPlaces = 0: 5;
            DataClassification = CustomerContent;
            Caption = 'Setup Time';
        }
        field(216; "Output Quantity"; Decimal)
        {
            DecimalPlaces = 0: 5;
            DataClassification = CustomerContent;
            Caption = 'Output Quantity';
        }
        field(217; "Scrap Quantity"; Decimal)
        {
            Caption = 'Scrapped Quantity';
            DecimalPlaces = 0: 5;
            DataClassification = CustomerContent;
        }
        field(218; "Output Quantity (Base)"; Decimal)
        {
            DecimalPlaces = 0: 5;
            DataClassification = CustomerContent;
            Caption = 'Output Quantity (Base)';
        }
        field(219; "Scrap Quantity (Base)"; Decimal)
        {
            DecimalPlaces = 0: 5;
            DataClassification = CustomerContent;
            Caption = 'Scrap Quantity (Base)';
        }
        field(220; "Unit of Measure Code (Item)"; Code[10])
        {
            Editable = false;
            TableRelation = "Item Unit of Measure".Code where("Item No."=field("Item No."));
            DataClassification = CustomerContent;
            Caption = 'Unit of Measure Code (Item)';
        }
        field(221; "Run Time (Base)"; Decimal)
        {
            DecimalPlaces = 0: 5;
            DataClassification = CustomerContent;
            Caption = 'Run Time (Base)';
        }
        field(222; "Set. Time (Base)"; Decimal)
        {
            DecimalPlaces = 0: 5;
            DataClassification = CustomerContent;
            Caption = 'Set. Time (Base)';
        }
        field(223; "Unit of Measure Code"; Code[10])
        {
            Editable = false;
            TableRelation = "Capacity Unit of Measure";
            DataClassification = CustomerContent;
            Caption = 'Unit of Measure Code';
        }
        field(224; "Qty. per Unit of Measure"; Decimal)
        {
            DecimalPlaces = 0: 5;
            Editable = false;
            DataClassification = CustomerContent;
            Caption = 'Qty. per Unit of Measure';
        }
        field(225; "Qty. per Unit of Meas. (Item)"; Decimal)
        {
            DecimalPlaces = 0: 5;
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
            //SSD TableRelation = "SSD Sampling Temp. Header"."Process / Operation No." where("Template Type" = field("Template Type"),
            //SSD                                                                          "No." = field("Sampling Temp. No."));
            DataClassification = CustomerContent;
            Caption = 'Process / Operation Code';
        }
        field(50003; "Process / Operation"; Text[30])
        {
            CalcFormula = lookup("Work Center"."Process / Operation" where("No."=field("Process / Operation Code")));
            Editable = false;
            FieldClass = FlowField;
            Caption = 'Process / Operation';
        }
        field(50007; "Inspection Report Generated"; Boolean)
        {
            Editable = false;
            DataClassification = CustomerContent;
            Caption = 'Inspection Report Generated';
        }
        field(50009; "Total Qty. Sent For Inspection"; Decimal)
        {
            //SSD Comment Start
            // CalcFormula = sum("SSD Posted Quality Order Header"."Lot Size" where("Template Type" = filter(Routing | RcvdCoil),
            //                                                                   "Entry Source Type" = field("Entry Source Type"),
            //                                                                   "Source Document No." = field("Source Document No."),
            //                                                                   "Order No." = field("No.")));
            //SSD Comment End
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
            Editable = false;
            DataClassification = CustomerContent;
            Caption = 'Is Coil Type';
        }
        field(50089; "Accepted Under Deviation"; Option)
        {
            OptionCaption = ' ,Accepted Under Deviation,Accepted after Rework,Aceepted after Segragation';
            OptionMembers = " ", "Accepted Under Deviation", "Accepted after Rework", "Aceepted after Segragation";
            DataClassification = CustomerContent;
            Caption = 'Accepted Under Deviation';
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
            Caption = 'Qty Nos';
        }
        field(50103; "Source Name"; Text[50])
        {
            CalcFormula = lookup(Vendor.Name where("No."=field("Source Code")));
            FieldClass = FlowField;
            Caption = 'Source Name';
        }
        field(50105; Subcontracting; Boolean)
        {
            Description = 'ZEV-5.51';
            DataClassification = CustomerContent;
            Caption = 'Subcontracting';
        }
        field(50106; Remarks; Text[50])
        {
            Description = 'ZEV-5-51';
            DataClassification = CustomerContent;
            Caption = 'Remarks';
        }
        field(50107; "Version No."; Integer)
        {
            Description = 'QLT[A]';
            DataClassification = CustomerContent;
            Caption = 'Version No.';
        }
        field(50112; "Archived By"; Code[20])
        {
            Description = 'QLT[A]';
            DataClassification = CustomerContent;
            Caption = 'Archived By';
        }
        field(50113; "Archived Date"; Date)
        {
            Description = 'QLT[A]';
            DataClassification = CustomerContent;
            Caption = 'Archived Date';
        }
        field(50114; "Time of Creation"; Time)
        {
            Description = 'Alle[Z]';
            Editable = true;
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
    }
    keys
    {
        key(Key1; "No.", "Version No.")
        {
            Clustered = true;
        }
        key(Key2; "Template Type")
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
        key(Key7; "Source Document No.", "Item No.")
        {
            SumIndexFields = "Accepted Qty.", "Rejected Qty.";
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
    end;
    var Txt00003: label 'Sampling Template No %1  not attached with Item Code %2';
    Txt00004: label 'No Line Present';
    Txt00007: label 'Rejected Qty must be more than 0';
    procedure ShowComent()
    var
        rQualityComent: Record "SSD Quality Comments";
        fQualityComent: Page "Quality Comments";
    begin
        rQualityComent.Reset;
        rQualityComent.FilterGroup(2);
        rQualityComent.SetRange(rQualityComent.TableId, Database::"SSD Posted Quality Order Hdr");
        rQualityComent.SetRange(rQualityComent."Doc. No.", "No.");
        rQualityComent.SetRange(rQualityComent."Line No.", 0);
        rQualityComent.FilterGroup(0);
        fQualityComent.SetTableview(rQualityComent);
        fQualityComent.Run;
    end;
    procedure Navigate()
    var
        FNavigate: Page Navigate;
    begin
        FNavigate.SetDoc("Creation Date", "Source Document No.");
        FNavigate.Run;
    end;
    procedure CreateQualityOrderLine(RecQualityOrdHeader: Record "SSD Posted Quality Order Hdr"; var RecQualityOrdLine: Record "SSD Posted Quality Order Line")
    var
        SamplingHeaderLocal: Record "SSD Sampling Temp. Header";
        LineNo: Integer;
        SamplingLineLocal: Record "SSD Sampling Temp. Line";
    begin
        RecQualityOrdHeader.TestField("Sampling Temp. No.");
        if SamplingHeaderLocal.Get(RecQualityOrdHeader."Sampling Temp. No.")then begin
            SamplingHeaderLocal.TestField(Status, SamplingHeaderLocal.Status::Certified);
            ///************** Delete Sampling Doc Line if any present*************
            RecQualityOrdLine.Reset;
            RecQualityOrdLine.SetRange("Document No.", RecQualityOrdHeader."No.");
            if RecQualityOrdLine.Find('-')then RecQualityOrdLine.DeleteAll(true);
            ///************** Insert Sampling Doc Line as per Sampling Template Line*****
            LineNo:=0;
            SamplingLineLocal.Reset;
            SamplingLineLocal.SetRange("Document No.", SamplingHeaderLocal."No.");
            if SamplingLineLocal.Find('-')then repeat RecQualityOrdLine.Init;
                    RecQualityOrdLine."Document No.":=RecQualityOrdHeader."No.";
                    RecQualityOrdLine."Template Type":=RecQualityOrdHeader."Template Type";
                    LineNo:=LineNo + 10000;
                    RecQualityOrdLine."Line No.":=LineNo;
                    RecQualityOrdLine."Responsibility Center":=RecQualityOrdHeader."Responsibility Center";
                    RecQualityOrdLine."Sampling Template No.":=RecQualityOrdHeader."Sampling Temp. No.";
                    RecQualityOrdLine."Test No.":=SamplingLineLocal."Test No.";
                    RecQualityOrdLine."Meas. Code":=SamplingLineLocal."Meas. Code";
                    RecQualityOrdLine.Description:=SamplingLineLocal.Description;
                    RecQualityOrdLine."Meas. Tool Code":=SamplingLineLocal."Meas. Tool Code";
                    RecQualityOrdLine."Meas. Tool Description":=SamplingLineLocal."Meas. Tool Description";
                    RecQualityOrdLine."Meas. Value Type":=SamplingLineLocal."Meas. Value Type";
                    RecQualityOrdLine."Unit of Measure Code":=SamplingLineLocal."Unit of Measure Code";
                    RecQualityOrdLine."Normal Value":=SamplingLineLocal."Normal Value";
                    RecQualityOrdLine."Minimum Value":=SamplingLineLocal."Minimum Value";
                    RecQualityOrdLine."Maximum Value":=SamplingLineLocal."Maximum Value";
                    RecQualityOrdLine."Medium Tolerance":=SamplingLineLocal."Medium Tolerance";
                    RecQualityOrdLine."Kind of Sampling":=SamplingLineLocal."Kind of Sampling";
                    RecQualityOrdLine."Inspection Type":=SamplingLineLocal."Inspection Type";
                    RecQualityOrdLine."Sampling Level":=SamplingLineLocal."Sampling Level";
                    RecQualityOrdLine."Qty. to be Inspected":=RecQualityOrdHeader."Sample Size";
                    RecQualityOrdLine."Accepted Qty.":=RecQualityOrdHeader."Sample Size";
                    RecQualityOrdLine.Insert(true);
                until SamplingLineLocal.Next = 0 end;
    end;
    procedure ShowPostedPurchRcptLines(var RecPostedQltOrdHdr: Record "SSD Posted Quality Order Hdr")
    var
        PurchRcptHdrLocal: Record "Purch. Rcpt. Header";
        PurchRcptLineLocal: Record "Purch. Rcpt. Line";
        FrmPostedPurchRcpt: Page "Posted Purchase Receipts";
    begin
        RecPostedQltOrdHdr.TestField("Template Type", RecPostedQltOrdHdr."template type"::Receipt);
        PurchRcptHdrLocal.Reset;
        PurchRcptHdrLocal.FilterGroup(2);
        PurchRcptLineLocal.Reset;
        PurchRcptLineLocal.SetCurrentkey("Posted Quality Order No.", "Order No.", Type, "No.");
        PurchRcptLineLocal.SetRange("Posted Quality Order No.", RecPostedQltOrdHdr."No.");
        PurchRcptLineLocal.SetRange("Order No.", RecPostedQltOrdHdr."Order No.");
        PurchRcptLineLocal.SetRange(Type, PurchRcptLineLocal.Type::Item);
        PurchRcptLineLocal.SetRange("No.", RecPostedQltOrdHdr."Item No.");
        if PurchRcptLineLocal.Find('-')then repeat if PurchRcptHdrLocal.Get(PurchRcptLineLocal."Document No.")then PurchRcptHdrLocal.Mark(true);
            until PurchRcptLineLocal.Next = 0;
        PurchRcptHdrLocal.MarkedOnly(true);
        PurchRcptHdrLocal.FilterGroup(0);
        Clear(FrmPostedPurchRcpt);
        FrmPostedPurchRcpt.SetTableview(PurchRcptHdrLocal);
        FrmPostedPurchRcpt.LookupMode:=true;
        FrmPostedPurchRcpt.RunModal;
    end;
    procedure ShowPostedWhseRcptLines(var RecPostedQltOrdHdr: Record "SSD Posted Quality Order Hdr")
    var
        PostedWhseRcptHdrLocal: Record "Posted Whse. Receipt Header";
        PostedWhseRcptLineLocal: Record "Posted Whse. Receipt Line";
        FrmPostedWhseRcpt: Page "Posted Whse. Receipt List";
    begin
        RecPostedQltOrdHdr.TestField("Template Type", RecPostedQltOrdHdr."template type"::Receipt);
        PostedWhseRcptHdrLocal.Reset;
        PostedWhseRcptHdrLocal.FilterGroup(2);
        PostedWhseRcptLineLocal.Reset;
        PostedWhseRcptLineLocal.SetCurrentkey("Posted Quality Order No.", "Source No.", "Item No.");
        PostedWhseRcptLineLocal.SetRange("Posted Quality Order No.", RecPostedQltOrdHdr."No.");
        PostedWhseRcptLineLocal.SetRange("Source No.", RecPostedQltOrdHdr."Order No.");
        PostedWhseRcptLineLocal.SetRange("Item No.", RecPostedQltOrdHdr."Item No.");
        if PostedWhseRcptLineLocal.Find('-')then repeat if PostedWhseRcptHdrLocal.Get(PostedWhseRcptLineLocal."No.")then PostedWhseRcptHdrLocal.Mark(true);
            until PostedWhseRcptLineLocal.Next = 0;
        PostedWhseRcptHdrLocal.MarkedOnly(true);
        PostedWhseRcptHdrLocal.FilterGroup(0);
        Clear(FrmPostedWhseRcpt);
        FrmPostedWhseRcpt.SetTableview(PostedWhseRcptHdrLocal);
        FrmPostedWhseRcpt.LookupMode:=true;
        FrmPostedWhseRcpt.RunModal;
    end;
    procedure RejectLotInform(var RecQOrderHeader: Record "SSD Posted Quality Order Hdr")
    var
        ItemLocal: Record Item;
        RejectLotNoInfLocal: Record "SSD Reject Lot No Information";
        FrmpostedRejectLotNoInf: Page "Posted Reject Lot No Inf";
    begin
        ItemLocal.Get(RecQOrderHeader."Item No.");
        ItemLocal.TestField("Item Tracking Code");
        if RecQOrderHeader."Rejected Qty." <= 0 then Error(Txt00007);
        case RecQOrderHeader."Template Type" of RecQOrderHeader."template type"::Receipt: begin
            RejectLotNoInfLocal.Reset;
            RejectLotNoInfLocal.SetCurrentkey("Template Type", "Quality Order No.");
            RejectLotNoInfLocal.SetRange("Template Type", RejectLotNoInfLocal."template type"::Receipt);
            RejectLotNoInfLocal.SetRange("Quality Order No.", RecQOrderHeader."No.");
            Clear(FrmpostedRejectLotNoInf);
            FrmpostedRejectLotNoInf.SetTableview(RejectLotNoInfLocal);
            FrmpostedRejectLotNoInf.Editable:=false;
            FrmpostedRejectLotNoInf.RunModal;
        end;
        RecQOrderHeader."template type"::RcvdCoil: begin
            RejectLotNoInfLocal.Reset;
            RejectLotNoInfLocal.SetCurrentkey("Template Type", "Quality Order No.");
            RejectLotNoInfLocal.SetRange("Template Type", RejectLotNoInfLocal."template type"::Receipt);
            RejectLotNoInfLocal.SetRange("Quality Order No.", RecQOrderHeader."Order No.");
            RejectLotNoInfLocal.SetRange("Sub Template Type", RejectLotNoInfLocal."sub template type"::RcvdCoil);
            RejectLotNoInfLocal.SetRange("Sub Quality Order No.", RecQOrderHeader."No.");
            Clear(FrmpostedRejectLotNoInf);
            FrmpostedRejectLotNoInf.SetTableview(RejectLotNoInfLocal);
            FrmpostedRejectLotNoInf.Editable:=false;
            FrmpostedRejectLotNoInf.RunModal;
        end end;
    end;
}
