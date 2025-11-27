Table 50052 "SSD Prod. Ord Line Archive"
{
    Caption = 'Prod. Order Line';
    DataCaptionFields = "Prod. Order No.";
    DrillDownPageID = "Prod. Order Line List";
    LookupPageID = "Prod. Order Line List";
    PasteIsValid = false;
    DataClassification = CustomerContent;

    fields
    {
        field(1; Status; Option)
        {
            Caption = 'Status';
            OptionCaption = 'Simulated,Planned,Firm Planned,Released,Finished';
            OptionMembers = Simulated, Planned, "Firm Planned", Released, Finished;
            DataClassification = CustomerContent;
        }
        field(2; "Prod. Order No."; Code[20])
        {
            Caption = 'Prod. Order No.';
            TableRelation = "Production Order"."No." where(Status=field(Status));
            DataClassification = CustomerContent;
        }
        field(3; "Line No."; Integer)
        {
            Caption = 'Line No.';
            DataClassification = CustomerContent;
        }
        field(11; "Item No."; Code[20])
        {
            Caption = 'Item No.';
            TableRelation = Item where(Type=const(Inventory));
            DataClassification = CustomerContent;
        }
        field(12; "Variant Code"; Code[10])
        {
            Caption = 'Variant Code';
            TableRelation = "Item Variant".Code where("Item No."=field("Item No."), Code=field("Variant Code"));
            DataClassification = CustomerContent;
        }
        field(13; Description; Text[50])
        {
            Caption = 'Description';
            DataClassification = CustomerContent;
        }
        field(14; "Description 2"; Text[50])
        {
            Caption = 'Description 2';
            DataClassification = CustomerContent;
        }
        field(20; "Location Code"; Code[10])
        {
            Caption = 'Location Code';
            TableRelation = Location where("Use As In-Transit"=const(false));
            DataClassification = CustomerContent;
        }
        field(21; "Shortcut Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,2,1';
            Caption = 'Shortcut Dimension 1 Code';
            TableRelation = "Dimension Value".Code where("Global Dimension No."=const(1));
            DataClassification = CustomerContent;
        }
        field(22; "Shortcut Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,2,2';
            Caption = 'Shortcut Dimension 2 Code';
            TableRelation = "Dimension Value".Code where("Global Dimension No."=const(2));
            DataClassification = CustomerContent;
        }
        field(23; "Bin Code"; Code[20])
        {
            Caption = 'Bin Code';
            TableRelation = if(Quantity=filter(<0))"Bin Content"."Bin Code" where("Location Code"=field("Location Code"), "Item No."=field("Item No."), "Variant Code"=field("Variant Code"))
            else
            Bin.Code where("Location Code"=field("Location Code"));
            DataClassification = CustomerContent;

            trigger OnLookup()
            var
                WMSManagement: Codeunit "WMS Management";
                BinCode: Code[20];
            begin
            end;
            trigger OnValidate()
            var
                WMSManagement: Codeunit "WMS Management";
                WhseIntegrationMgt: Codeunit "Whse. Integration Management";
            begin
            end;
        }
        field(40; Quantity; Decimal)
        {
            Caption = 'Quantity';
            DecimalPlaces = 0: 5;
            MinValue = 0;
            DataClassification = CustomerContent;
        }
        field(41; "Finished Quantity"; Decimal)
        {
            Caption = 'Finished Quantity';
            DecimalPlaces = 0: 5;
            Editable = false;
            MinValue = 0;
            DataClassification = CustomerContent;
        }
        field(42; "Remaining Quantity"; Decimal)
        {
            Caption = 'Remaining Quantity';
            DecimalPlaces = 0: 5;
            Editable = false;
            MinValue = 0;
            DataClassification = CustomerContent;
        }
        field(45; "Scrap %"; Decimal)
        {
            Caption = 'Scrap %';
            DecimalPlaces = 0: 5;
            MinValue = 0;
            DataClassification = CustomerContent;
        }
        field(47; "Due Date"; Date)
        {
            Caption = 'Due Date';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(48; "Starting Date"; Date)
        {
            Caption = 'Starting Date';
            DataClassification = CustomerContent;
        }
        field(49; "Starting Time"; Time)
        {
            Caption = 'Starting Time';
            DataClassification = CustomerContent;
        }
        field(50; "Ending Date"; Date)
        {
            Caption = 'Ending Date';
            DataClassification = CustomerContent;
        }
        field(51; "Ending Time"; Time)
        {
            Caption = 'Ending Time';
            DataClassification = CustomerContent;
        }
        field(52; "Planning Level Code"; Integer)
        {
            Caption = 'Planning Level Code';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(53; Priority; Integer)
        {
            Caption = 'Priority';
            DataClassification = CustomerContent;
        }
        field(60; "Production BOM No."; Code[20])
        {
            Caption = 'Production BOM No.';
            TableRelation = "Production BOM Header"."No.";
            DataClassification = CustomerContent;
        }
        field(61; "Routing No."; Code[20])
        {
            Caption = 'Routing No.';
            TableRelation = "Routing Header"."No.";
            DataClassification = CustomerContent;

            trigger OnValidate()
            var
                CapLedgEntry: Record "Capacity Ledger Entry";
                PurchLine: Record "Purchase Line";
            begin
            end;
        }
        field(62; "Inventory Posting Group"; Code[10])
        {
            Caption = 'Inventory Posting Group';
            TableRelation = "Inventory Posting Group";
            DataClassification = CustomerContent;
        }
        field(63; "Routing Reference No."; Integer)
        {
            Caption = 'Routing Reference No.';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(65; "Unit Cost"; Decimal)
        {
            AutoFormatType = 2;
            Caption = 'Unit Cost';
            DataClassification = CustomerContent;
        }
        field(67; "Cost Amount"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Cost Amount';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(68; "Reserved Quantity"; Decimal)
        {
            CalcFormula = sum("Reservation Entry".Quantity where("Source ID"=field("Prod. Order No."), "Source Ref. No."=const(0), "Source Type"=const(5406), "Source Subtype"=field(Status), "Source Batch Name"=const(''), "Source Prod. Order Line"=field("Line No."), "Reservation Status"=const(Reservation)));
            Caption = 'Reserved Quantity';
            DecimalPlaces = 0: 5;
            Editable = false;
            FieldClass = FlowField;
        }
        field(70; "Capacity Type Filter"; Option)
        {
            Caption = 'Capacity Type Filter';
            FieldClass = FlowFilter;
            OptionCaption = 'Work Center,Machine Center';
            OptionMembers = "Work Center", "Machine Center";
        }
        field(71; "Capacity No. Filter"; Code[20])
        {
            Caption = 'Capacity No. Filter';
            FieldClass = FlowFilter;
            TableRelation = if("Capacity Type Filter"=const("Work Center"))"Work Center"
            else if("Capacity Type Filter"=const("Machine Center"))"Machine Center";
        }
        field(72; "Date Filter"; Date)
        {
            Caption = 'Date Filter';
            FieldClass = FlowFilter;
        }
        field(80; "Unit of Measure Code"; Code[10])
        {
            Caption = 'Unit of Measure Code';
            TableRelation = "Item Unit of Measure".Code where("Item No."=field("Item No."));
            DataClassification = CustomerContent;
        }
        field(81; "Quantity (Base)"; Decimal)
        {
            Caption = 'Quantity (Base)';
            DecimalPlaces = 0: 5;
            DataClassification = CustomerContent;
        }
        field(82; "Finished Qty. (Base)"; Decimal)
        {
            Caption = 'Finished Qty. (Base)';
            DecimalPlaces = 0: 5;
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(83; "Remaining Qty. (Base)"; Decimal)
        {
            Caption = 'Remaining Qty. (Base)';
            DecimalPlaces = 0: 5;
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(84; "Reserved Qty. (Base)"; Decimal)
        {
            CalcFormula = sum("Reservation Entry"."Quantity (Base)" where("Source ID"=field("Prod. Order No."), "Source Ref. No."=const(0), "Source Type"=const(5406), "Source Subtype"=field(Status), "Source Batch Name"=const(''), "Source Prod. Order Line"=field("Line No."), "Reservation Status"=const(Reservation)));
            Caption = 'Reserved Qty. (Base)';
            DecimalPlaces = 0: 5;
            Editable = false;
            FieldClass = FlowField;
        }
        field(90; "Expected Operation Cost Amt."; Decimal)
        {
            AutoFormatType = 1;
            CalcFormula = sum("Prod. Order Routing Line"."Expected Operation Cost Amt." where(Status=field(Status), "Prod. Order No."=field("Prod. Order No."), "Routing No."=field("Routing No."), "Routing Reference No."=field("Routing Reference No.")));
            Caption = 'Expected Operation Cost Amt.';
            Editable = false;
            FieldClass = FlowField;
        }
        field(91; "Total Exp. Oper. Output (Qty.)"; Decimal)
        {
            CalcFormula = sum("Prod. Order Line".Quantity where(Status=field(Status), "Prod. Order No."=field("Prod. Order No."), "Routing No."=field("Routing No."), "Routing Reference No."=field("Routing Reference No."), "Ending Date"=field("Date Filter")));
            Caption = 'Total Exp. Oper. Output (Qty.)';
            DecimalPlaces = 0: 5;
            Editable = false;
            FieldClass = FlowField;
        }
        field(94; "Expected Component Cost Amt."; Decimal)
        {
            AutoFormatType = 1;
            CalcFormula = sum("Prod. Order Component"."Cost Amount" where(Status=field(Status), "Prod. Order No."=field("Prod. Order No."), "Prod. Order Line No."=field("Line No."), "Due Date"=field("Date Filter")));
            Caption = 'Expected Component Cost Amt.';
            Editable = false;
            FieldClass = FlowField;
        }
        field(198; "Starting Date-Time"; DateTime)
        {
            Caption = 'Starting Date-Time';
            DataClassification = CustomerContent;
        }
        field(199; "Ending Date-Time"; DateTime)
        {
            Caption = 'Ending Date-Time';
            DataClassification = CustomerContent;
        }
        field(480; "Dimension Set ID"; Integer)
        {
            Caption = 'Dimension Set ID';
            Editable = false;
            TableRelation = "Dimension Set Entry";
            DataClassification = CustomerContent;
        }
        field(5831; "Cost Amount (ACY)"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Cost Amount (ACY)';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(5832; "Unit Cost (ACY)"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Unit Cost (ACY)';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(16360; "Subcontracting Order No."; Code[20])
        {
            Caption = 'Subcontracting Order No.';
            Editable = false;
            TableRelation = "Purchase Header"."No." where("Document Type"=const(Order), "No."=field("Subcontracting Order No."), Subcontracting=const(true));
            DataClassification = CustomerContent;
        }
        field(16361; "Subcontractor Code"; Code[20])
        {
            Caption = 'Subcontractor Code';
            Editable = false;
            TableRelation = Vendor."No." where(Subcontractor=const(true));
            DataClassification = CustomerContent;
        }
        field(50000; "Sales Order No."; Code[20])
        {
            Description = '5.51 to flow S order no when created from order planning.';
            DataClassification = CustomerContent;
            Caption = 'Sales Order No.';
        }
        field(50002; "Archived By"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Archived By';
        }
        field(50003; "Date Archived"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Date Archived';
        }
        field(50004; "Time Archived"; Time)
        {
            DataClassification = CustomerContent;
            Caption = 'Time Archived';
        }
        field(50005; "Version No."; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Version No.';
        }
        field(99000750; "Production BOM Version Code"; Code[20])
        {
            Caption = 'Production BOM Version Code';
            TableRelation = "Production BOM Version"."Version Code" where("Production BOM No."=field("Production BOM No."));
            DataClassification = CustomerContent;
        }
        field(99000751; "Routing Version Code"; Code[20])
        {
            Caption = 'Routing Version Code';
            TableRelation = "Routing Version"."Version Code" where("Routing No."=field("Routing No."));
            DataClassification = CustomerContent;
        }
        field(99000752; "Routing Type"; Option)
        {
            Caption = 'Routing Type';
            OptionCaption = 'Serial,Parallel';
            OptionMembers = Serial, Parallel;
            DataClassification = CustomerContent;
        }
        field(99000753; "Qty. per Unit of Measure"; Decimal)
        {
            Caption = 'Qty. per Unit of Measure';
            DecimalPlaces = 0: 5;
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(99000754; "MPS Order"; Boolean)
        {
            Caption = 'MPS Order';
            DataClassification = CustomerContent;
        }
        field(99000755; "Planning Flexibility"; Option)
        {
            Caption = 'Planning Flexibility';
            OptionCaption = 'Unlimited,None';
            OptionMembers = Unlimited, "None";
            DataClassification = CustomerContent;
        }
        field(99000764; "Indirect Cost %"; Decimal)
        {
            Caption = 'Indirect Cost %';
            DecimalPlaces = 0: 5;
            DataClassification = CustomerContent;
        }
        field(99000765; "Overhead Rate"; Decimal)
        {
            AutoFormatType = 2;
            Caption = 'Overhead Rate';
            DataClassification = CustomerContent;
        }
    }
    keys
    {
        key(Key1; Status, "Prod. Order No.", "Version No.", "Line No.")
        {
            Clustered = true;
        }
        key(Key2; "Prod. Order No.", "Line No.", Status)
        {
        }
        key(Key3; Status, "Item No.", "Variant Code", "Location Code", "Ending Date")
        {
            SumIndexFields = "Remaining Qty. (Base)", "Cost Amount";
        }
        key(Key4; Status, "Item No.", "Variant Code", "Location Code", "Starting Date")
        {
            MaintainSIFTIndex = false;
            SumIndexFields = "Remaining Qty. (Base)";
        }
        key(Key5; Status, "Item No.", "Variant Code", "Location Code", "Due Date")
        {
            MaintainSIFTIndex = false;
            SumIndexFields = "Remaining Qty. (Base)";
        }
        key(Key6; Status, "Item No.", "Variant Code", "Shortcut Dimension 1 Code", "Shortcut Dimension 2 Code", "Location Code", "Due Date")
        {
            Enabled = false;
            MaintainSIFTIndex = false;
            SumIndexFields = "Remaining Qty. (Base)";
        }
        key(Key7; Status, "Prod. Order No.", "Item No.")
        {
        }
        key(Key8; Status, "Prod. Order No.", "Routing No.", "Routing Reference No.")
        {
            MaintainSIFTIndex = false;
            SumIndexFields = Quantity, "Finished Quantity";
        }
        key(Key9; Status, "Prod. Order No.", "Planning Level Code")
        {
        }
        key(Key10; "Planning Level Code", Priority)
        {
            Enabled = false;
        }
        key(Key11; "Item No.", "Variant Code", "Location Code", Status, "Ending Date")
        {
            MaintainSIFTIndex = false;
            SumIndexFields = "Remaining Qty. (Base)";
        }
        key(Key12; "Item No.", "Variant Code", "Location Code", Status, "Due Date")
        {
            MaintainSIFTIndex = false;
            SumIndexFields = "Remaining Qty. (Base)";
        }
    }
    fieldgroups
    {
    }
    trigger OnDelete()
    var
        ItemLedgEntry: Record "Item Ledger Entry";
        CapLedgEntry: Record "Capacity Ledger Entry";
        PurchLine: Record "Purchase Line";
    begin
    end;
    var Text000: label 'A %1 %2 cannot be inserted, modified, or deleted.';
    Text99000000: label 'You cannot delete %1 %2 because there is at least one %3 associated with it.', Comment = '%1 = Table Caption; %2 = Field Value; %3 = Table Caption';
    Text99000001: label 'You cannot rename a %1.';
    Text99000002: label 'You cannot change %1 when %2 is %3.';
    Text99000004Err: label 'You cannot modify %1 %2 because there is at least one %3 associated with it.', Comment = '%1 = Field Caption; %2 = Field Value; %3 = Table Caption';
    Item: Record Item;
    SKU: Record "Stockkeeping Unit";
    ItemVariant: Record "Item Variant";
    ReservEntry: Record "Reservation Entry";
    ProdBOMHeader: Record "Production BOM Header";
    ProdBOMVersion: Record "Production BOM Version";
    RtngHeader: Record "Routing Header";
    RtngVersion: Record "Routing Version";
    ProdOrder: Record "Production Order";
    ProdOrderLine: Record "Prod. Order Line";
    ProdOrderComp: Record "Prod. Order Component";
    ProdOrderRtngLine: Record "Prod. Order Routing Line";
    GLSetup: Record "General Ledger Setup";
    Location: Record Location;
    Reservation: Page Reservation;
    ReservEngineMgt: Codeunit "Reservation Engine Mgt.";
    ReserveProdOrderLine: Codeunit "Prod. Order Line-Reserve";
    WhseValidateSourceLine: Codeunit "Whse. Validate Source Line";
    UOMMgt: Codeunit "Unit of Measure Management";
    VersionMgt: Codeunit VersionManagement;
    CalcProdOrder: Codeunit "Calculate Prod. Order";
    DimMgt: Codeunit DimensionManagement;
    Blocked: Boolean;
    GLSetupRead: Boolean;
    IgnoreErrors: Boolean;
    ErrorOccured: Boolean;
    CalledFromComponent: Boolean;
    Text16321: label 'You are not allowed to change the quantity once Subcontracting Order is created.';
}
