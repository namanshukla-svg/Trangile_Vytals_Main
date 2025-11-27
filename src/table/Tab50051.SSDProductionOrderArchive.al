Table 50051 "SSD Production Order Archive"
{
    Caption = 'Production Order';
    DataCaptionFields = "No.", Description;
    DrillDownPageID = "Prod. Order Archives";
    LookupPageID = "Prod. Order Archives";
    DataClassification = CustomerContent;

    fields
    {
        field(1; Status; Enum "Production Order Status")
        {
            Caption = 'Status';
            DataClassification = CustomerContent;
        }
        field(2; "No."; Code[20])
        {
            Caption = 'No.';
            TableRelation = "Production Order"."No." where(Status = field(Status));
            ValidateTableRelation = false;
            DataClassification = CustomerContent;
        }
        field(3; Description; Text[50])
        {
            Caption = 'Description';
            DataClassification = CustomerContent;
        }
        field(4; "Search Description"; Code[50])
        {
            Caption = 'Search Description';
            DataClassification = CustomerContent;
        }
        field(5; "Description 2"; Text[50])
        {
            Caption = 'Description 2';
            DataClassification = CustomerContent;
        }
        field(6; "Creation Date"; Date)
        {
            Caption = 'Creation Date';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(7; "Last Date Modified"; Date)
        {
            Caption = 'Last Date Modified';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(9; "Source Type"; Option)
        {
            Caption = 'Source Type';
            OptionCaption = 'Item,Family,Sales Header';
            OptionMembers = Item,Family,"Sales Header";
            DataClassification = CustomerContent;
        }
        field(10; "Source No."; Code[20])
        {
            Caption = 'Source No.';
            TableRelation = if ("Source Type" = const(Item)) Item where(Type = const(Inventory))
            else if ("Source Type" = const(Family)) Family
            else if (Status = const(Simulated), "Source Type" = const("Sales Header")) "Sales Header"."No." where("Document Type" = const(Quote))
            else if (Status = filter(Planned ..), "Source Type" = const("Sales Header")) "Sales Header"."No." where("Document Type" = const(Order));
            DataClassification = CustomerContent;

            trigger OnValidate()
            var
                Item: Record Item;
                Family: Record Family;
                SalesHeader: Record "Sales Header";
            begin
            end;
        }
        field(11; "Routing No."; Code[20])
        {
            Caption = 'Routing No.';
            TableRelation = "Routing Header";
            DataClassification = CustomerContent;
        }
        field(15; "Inventory Posting Group"; Code[10])
        {
            Caption = 'Inventory Posting Group';
            TableRelation = "Inventory Posting Group";
            DataClassification = CustomerContent;
        }
        field(16; "Gen. Prod. Posting Group"; Code[10])
        {
            Caption = 'Gen. Prod. Posting Group';
            TableRelation = "Gen. Product Posting Group";
            DataClassification = CustomerContent;
        }
        field(17; "Gen. Bus. Posting Group"; Code[10])
        {
            Caption = 'Gen. Bus. Posting Group';
            TableRelation = "Gen. Business Posting Group";
            DataClassification = CustomerContent;
        }
        field(19; Comment; Boolean)
        {
            CalcFormula = exist("Prod. Order Comment Line" where(Status = field(Status), "Prod. Order No." = field("No.")));
            Caption = 'Comment';
            Editable = false;
            FieldClass = FlowField;
        }
        field(20; "Starting Time"; Time)
        {
            Caption = 'Starting Time';
            DataClassification = CustomerContent;
        }
        field(21; "Starting Date"; Date)
        {
            Caption = 'Starting Date';
            DataClassification = CustomerContent;
        }
        field(22; "Ending Time"; Time)
        {
            Caption = 'Ending Time';
            DataClassification = CustomerContent;
        }
        field(23; "Ending Date"; Date)
        {
            Caption = 'Ending Date';
            DataClassification = CustomerContent;
        }
        field(24; "Due Date"; Date)
        {
            Caption = 'Due Date';
            DataClassification = CustomerContent;
        }
        field(25; "Finished Date"; Date)
        {
            Caption = 'Finished Date';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(28; Blocked; Boolean)
        {
            Caption = 'Blocked';
            DataClassification = CustomerContent;
        }
        field(30; "Shortcut Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,2,1';
            Caption = 'Shortcut Dimension 1 Code';
            Editable = false;
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1));
            DataClassification = CustomerContent;
        }
        field(31; "Shortcut Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,2,2';
            Caption = 'Shortcut Dimension 2 Code';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2));
            DataClassification = CustomerContent;
        }
        field(32; "Location Code"; Code[10])
        {
            Caption = 'Location Code';
            TableRelation = Location where("Use As In-Transit" = const(false));
            DataClassification = CustomerContent;
        }
        field(33; "Bin Code"; Code[20])
        {
            Caption = 'Bin Code';
            TableRelation = if ("Source Type" = const(Item)) Bin.Code where("Location Code" = field("Location Code"), "Item Filter" = field("Source No."))
            else if ("Source Type" = filter(<> Item)) Bin.Code where("Location Code" = field("Location Code"));
            DataClassification = CustomerContent;

            trigger OnValidate()
            var
                WhseIntegrationMgt: Codeunit "Whse. Integration Management";
            begin
            end;
        }
        field(34; "Replan Ref. No."; Code[20])
        {
            Caption = 'Replan Ref. No.';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(35; "Replan Ref. Status"; Option)
        {
            Caption = 'Replan Ref. Status';
            Editable = false;
            OptionCaption = 'Simulated,Planned,Firm Planned,Released,Finished';
            OptionMembers = Simulated,Planned,"Firm Planned",Released,Finished;
            DataClassification = CustomerContent;
        }
        field(38; "Low-Level Code"; Integer)
        {
            Caption = 'Low-Level Code';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(40; Quantity; Decimal)
        {
            Caption = 'Quantity';
            DecimalPlaces = 0 : 5;
            MinValue = 0;
            DataClassification = CustomerContent;
        }
        field(41; "Unit Cost"; Decimal)
        {
            Caption = 'Unit Cost';
            DecimalPlaces = 2 : 5;
            DataClassification = CustomerContent;
        }
        field(42; "Cost Amount"; Decimal)
        {
            Caption = 'Cost Amount';
            DecimalPlaces = 2 : 2;
            DataClassification = CustomerContent;
        }
        field(47; "Work Center Filter"; Code[20])
        {
            Caption = 'Work Center Filter';
            FieldClass = FlowFilter;
            TableRelation = "Work Center";
        }
        field(48; "Capacity Type Filter"; Option)
        {
            Caption = 'Capacity Type Filter';
            FieldClass = FlowFilter;
            OptionCaption = 'Work Center,Machine Center';
            OptionMembers = "Work Center","Machine Center";
        }
        field(49; "Capacity No. Filter"; Code[20])
        {
            Caption = 'Capacity No. Filter';
            FieldClass = FlowFilter;
            TableRelation = if ("Capacity Type Filter" = const("Work Center")) "Machine Center"
            else if ("Capacity Type Filter" = const("Machine Center")) "Work Center";
        }
        field(50; "Date Filter"; Date)
        {
            Caption = 'Date Filter';
            FieldClass = FlowFilter;
        }
        field(51; "Expected Operation Cost Amt."; Decimal)
        {
            AutoFormatType = 1;
            CalcFormula = sum("Prod. Order Routing Line"."Expected Operation Cost Amt." where(Status = field(Status), "Prod. Order No." = field("No.")));
            Caption = 'Expected Operation Cost Amt.';
            Editable = false;
            FieldClass = FlowField;
        }
        field(52; "Expected Component Cost Amt."; Decimal)
        {
            AutoFormatType = 1;
            CalcFormula = sum("Prod. Order Component"."Cost Amount" where(Status = field(Status), "Prod. Order No." = field("No."), "Due Date" = field("Date Filter")));
            Caption = 'Expected Component Cost Amt.';
            Editable = false;
            FieldClass = FlowField;
        }
        field(55; "Actual Time Used"; Decimal)
        {
            CalcFormula = sum("Capacity Ledger Entry".Quantity where("Order Type" = const(Production), "Order No." = field("No."), Type = field("Capacity Type Filter"), "No." = field("Capacity No. Filter"), "Posting Date" = field("Date Filter")));
            Caption = 'Actual Time Used';
            DecimalPlaces = 0 : 5;
            Editable = false;
            FieldClass = FlowField;
        }
        field(56; "Allocated Capacity Need"; Decimal)
        {
            CalcFormula = sum("Prod. Order Capacity Need"."Needed Time" where(Status = field(Status), "Prod. Order No." = field("No."), Type = field("Capacity Type Filter"), "No." = field("Capacity No. Filter"), "Work Center No." = field("Work Center Filter"), Date = field("Date Filter"), "Requested Only" = const(false)));
            Caption = 'Allocated Capacity Need';
            DecimalPlaces = 0 : 5;
            Editable = false;
            FieldClass = FlowField;
        }
        field(57; "Expected Capacity Need"; Decimal)
        {
            CalcFormula = sum("Prod. Order Capacity Need"."Needed Time" where(Status = field(Status), "Prod. Order No." = field("No."), Type = field("Capacity Type Filter"), "No." = field("Capacity No. Filter"), "Work Center No." = field("Work Center Filter"), Date = field("Date Filter"), "Requested Only" = const(false)));
            Caption = 'Expected Capacity Need';
            DecimalPlaces = 0 : 5;
            Editable = false;
            FieldClass = FlowField;
        }
        field(80; "No. Series"; Code[10])
        {
            Caption = 'No. Series';
            Editable = false;
            TableRelation = "No. Series";
            DataClassification = CustomerContent;
        }
        field(82; "Planned Order No."; Code[20])
        {
            Caption = 'Planned Order No.';
            DataClassification = CustomerContent;
        }
        field(83; "Firm Planned Order No."; Code[20])
        {
            Caption = 'Firm Planned Order No.';
            DataClassification = CustomerContent;
        }
        field(85; "Simulated Order No."; Code[20])
        {
            Caption = 'Simulated Order No.';
            DataClassification = CustomerContent;
        }
        field(92; "Expected Material Ovhd. Cost"; Decimal)
        {
            CalcFormula = sum("Prod. Order Component"."Overhead Amount" where(Status = field(Status), "Prod. Order No." = field("No.")));
            Caption = 'Expected Material Ovhd. Cost';
            DecimalPlaces = 2 : 2;
            Editable = false;
            FieldClass = FlowField;
        }
        field(94; "Expected Capacity Ovhd. Cost"; Decimal)
        {
            AutoFormatType = 1;
            CalcFormula = sum("Prod. Order Routing Line"."Expected Capacity Ovhd. Cost" where(Status = field(Status), "Prod. Order No." = field("No.")));
            Caption = 'Expected Capacity Ovhd. Cost';
            Editable = false;
            FieldClass = FlowField;
        }
        field(98; "Starting Date-Time"; DateTime)
        {
            Caption = 'Starting Date-Time';
            DataClassification = CustomerContent;
        }
        field(99; "Ending Date-Time"; DateTime)
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
        field(7300; "Completely Picked"; Boolean)
        {
            CalcFormula = min("Prod. Order Component"."Completely Picked" where(Status = field(Status), "Prod. Order No." = field("No.")));
            Caption = 'Completely Picked';
            FieldClass = FlowField;
        }
        field(9000; "Assigned User ID"; Code[20])
        {
            Caption = 'Assigned User ID';
            Editable = false;
            TableRelation = "User Setup";
            DataClassification = CustomerContent;
        }
        field(50010; Reprocess; Boolean)
        {
            Description = 'QLT';
            Editable = false;
            DataClassification = CustomerContent;
            Caption = 'Reprocess';
        }
        field(50011; "Source Doc. No."; Code[20])
        {
            Description = 'QLT';
            Editable = false;
            DataClassification = CustomerContent;
            Caption = 'Source Doc. No.';
        }
        field(50012; "Item Entry Source No."; Integer)
        {
            Description = 'QLT';
            Editable = false;
            TableRelation = "Item Ledger Entry";
            DataClassification = CustomerContent;
            Caption = 'Item Entry Source No.';
        }
        field(50056; "Req Generated"; Boolean)
        {
            Description = 'ALLE3.26';
            DataClassification = CustomerContent;
            Caption = 'Req Generated';
        }
        field(50057; "Finished Qty."; Decimal)
        {
            CalcFormula = lookup("Prod. Order Line"."Finished Quantity" where(Status = field(Status), "Prod. Order No." = field("No."), "Item No." = field("Source No.")));
            Description = 'ALLE[5.51]';
            FieldClass = FlowField;
            Caption = 'Finished Qty.';
        }
        field(50058; Closed; Boolean)
        {
            Description = 'ALLE[5.51] dated-27-6-13';
            DataClassification = CustomerContent;
            Caption = 'Closed';
        }
        field(50059; "Sales Order No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Sales Order No.';
        }
        field(50061; "Archived by"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Archived by';
        }
        field(50062; "Date Archived"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Date Archived';
        }
        field(50063; "Time Archived"; Time)
        {
            DataClassification = CustomerContent;
            Caption = 'Time Archived';
        }
        field(50064; "Version No."; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Version No.';
        }
    }
    keys
    {
        key(Key1; Status, "No.", "Version No.")
        {
            Clustered = true;
        }
        key(Key2; "No.", Status)
        {
        }
        key(Key3; "Search Description")
        {
        }
        key(Key4; "Low-Level Code", "Replan Ref. No.", "Replan Ref. Status")
        {
        }
        key(Key5; "Source Type", "Source No.")
        {
            Enabled = false;
        }
        key(Key6; Description)
        {
        }
        key(Key7; "Source No.")
        {
        }
    }
    fieldgroups
    {
        fieldgroup(DropDown; "No.", Description, "Source No.", "Source Type")
        {
        }
    }
    var
        Text000: label 'You cannot delete %1 %2 %3 because there is at least one %4 associated with it.', Comment = '%1 = Document status; %2 = Table caption; %3 = Field value; %4 = Table Caption';
        Text001: label 'You cannot rename a %1.';
        Text002: label 'You cannot change %1 on %2 %3 %4 because there is at least one %5 associated with it.', Comment = '%1 = Field caption; %2 = Document status; %3 = Table caption; %4 = Field value; %5 = Table Caption';
        Text003: label 'The production order contains lines connected in a multi-level structure and the production order lines have not been automatically rescheduled.\';
        Text005: label 'Use Refresh if you want to reschedule the lines.';
        MfgSetup: Record "Manufacturing Setup";
        ProdOrder: Record "Production Order";
        ProdOrderLine: Record "Prod. Order Line";
        InvtAdjmtEntryOrder: Record "Inventory Adjmt. Entry (Order)";
        CapLedgEntry: Record "Capacity Ledger Entry";
        ItemLedgEntry: Record "Item Ledger Entry";
        Location: Record Location;
        PurchLine: Record "Purchase Line";
        //IG_DS    NoSeriesMgt: Codeunit NoSeriesManagement;
        CalcProdOrder: Codeunit "Calculate Prod. Order";
        LeadTimeMgt: Codeunit "Lead-Time Management";
        DimMgt: Codeunit DimensionManagement;
        Text006: label 'A Finished Production Order cannot be modified.';
        Text007: label '%1 %2 %3 cannot be created, because a %4 %2 %3 already exists.';
        ItemTrackingMgt: Codeunit "Item Tracking Management";
        HideValidationDialog: Boolean;
        Text008: label 'Nothing to handle.';
        Text009: label 'The %1 %2 %3 has item tracking. Do you want to delete it anyway?';
        UpdateEndDate: Boolean;
        Text010: label 'You may have changed a dimension.\\Do you want to update the lines?';
        Text011: label 'You cannot change Finished Production Order dimensions.';
}
