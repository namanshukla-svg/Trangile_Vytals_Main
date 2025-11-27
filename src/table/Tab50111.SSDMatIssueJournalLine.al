Table 50111 "SSD Mat. Issue Journal Line"
{
    Caption = 'Material Issue Journal Line';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Document No."; Code[20])
        {
            Caption = 'Document No.';
            DataClassification = CustomerContent;
        }
        field(2; "Line No."; Integer)
        {
            Caption = 'Line No.';
            DataClassification = CustomerContent;
        }
        field(3; "Item No."; Code[20])
        {
            Caption = 'Item No.';
            TableRelation = Item;
            DataClassification = CustomerContent;
        }
        field(4; "Posting Date"; Date)
        {
            Caption = 'Posting Date';
            DataClassification = CustomerContent;

            trigger OnValidate()
            var
                CheckDateConflict: Codeunit "Reservation-Check Date Confl.";
            begin
            end;
        }
        field(5; "Entry Type"; Option)
        {
            Caption = 'Entry Type';
            OptionCaption = 'Purchase,Sale,Positive Adjmt.,Negative Adjmt.,Transfer,Consumption,Output';
            OptionMembers = Purchase,Sale,"Positive Adjmt.","Negative Adjmt.",Transfer,Consumption,Output;
            DataClassification = CustomerContent;
        }
        field(6; "Source No."; Code[20])
        {
            Caption = 'Source No.';
            Editable = false;
            TableRelation = if ("Source Type" = const(Customer)) Customer
            else if ("Source Type" = const(Vendor)) Vendor
            else if ("Source Type" = const(Item)) Item;
            DataClassification = CustomerContent;
        }
        field(7; "Posted Document No."; Code[20])
        {
            Caption = 'Posted Document No.';
            DataClassification = CustomerContent;
        }
        field(8; Description; Text[50])
        {
            Caption = 'Description';
            DataClassification = CustomerContent;
        }
        field(9; "Location Code"; Code[10])
        {
            Caption = 'Location Code';
            TableRelation = Location;
            DataClassification = CustomerContent;
        }
        field(10; "Inventory Posting Group"; Code[10])
        {
            Caption = 'Inventory Posting Group';
            Editable = false;
            TableRelation = "Inventory Posting Group";
            DataClassification = CustomerContent;
        }
        field(11; "Source Posting Group"; Code[10])
        {
            Caption = 'Source Posting Group';
            Editable = false;
            TableRelation = if ("Source Type" = const(Customer)) "Customer Posting Group"
            else if ("Source Type" = const(Vendor)) "Vendor Posting Group"
            else if ("Source Type" = const(Item)) "Inventory Posting Group";
            DataClassification = CustomerContent;
        }
        field(12; Quantity; Decimal)
        {
            Caption = 'Quantity';
            DecimalPlaces = 0 : 5;
            DataClassification = CustomerContent;
        }
        field(13; "Source Code"; Code[10])
        {
            Caption = 'Source Code';
            Editable = false;
            TableRelation = "Source Code";
            DataClassification = CustomerContent;
        }
        field(14; "Shortcut Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,2,1';
            Caption = 'Shortcut Dimension 1 Code';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1));
            DataClassification = CustomerContent;
        }
        field(15; "Shortcut Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,2,2';
            Caption = 'Shortcut Dimension 2 Code';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2));
            DataClassification = CustomerContent;
        }
        field(16; "Source Type"; Option)
        {
            Caption = 'Source Type';
            Editable = false;
            OptionCaption = ' ,Customer,Vendor,Item';
            OptionMembers = " ",Customer,Vendor,Item;
            DataClassification = CustomerContent;
        }
        field(18; "Reason Code"; Code[10])
        {
            Caption = 'Reason Code';
            TableRelation = "Reason Code";
            DataClassification = CustomerContent;
        }
        field(19; "Expiration Date"; Date)
        {
            Caption = 'Expiration Date';
            DataClassification = CustomerContent;
        }
        field(20; "External Document No."; Code[20])
        {
            Caption = 'External Document No.';
            DataClassification = CustomerContent;
        }
        field(21; "Posting No. Series"; Code[10])
        {
            Caption = 'Posting No. Series';
            TableRelation = "No. Series";
            DataClassification = CustomerContent;
        }
        field(22; "Bin Code"; Code[20])
        {
            Caption = 'Bin Code';
            DataClassification = CustomerContent;
        }
        field(23; "Qty. per Unit of Measure"; Decimal)
        {
            Caption = 'Qty. per Unit of Measure';
            DecimalPlaces = 0 : 5;
            Editable = false;
            InitValue = 1;
            DataClassification = CustomerContent;
        }
        field(24; "Unit of Measure Code"; Code[10])
        {
            Caption = 'Unit of Measure Code';
            TableRelation = "Item Unit of Measure".Code where("Item No." = field("Item No."));
            DataClassification = CustomerContent;
        }
        field(25; "Item Category Code"; Code[20])
        {
            Caption = 'Item Category Code';
            TableRelation = "Item Category";
            DataClassification = CustomerContent;
        }
        field(26; "Product Group Code"; Code[10])
        {
            Caption = 'Product Group Code';
            TableRelation = "Item Category".Code where(Code = field("Item Category Code"));
            DataClassification = CustomerContent;
        }
        field(27; "Part No."; Code[20])
        {
            CalcFormula = lookup(Item."No. 2" where("No." = field("Item No.")));
            FieldClass = FlowField;
            Caption = 'Part No.';
        }
        field(28; "Responsibility Center"; Code[20])
        {
            Description = 'CF001';
            Editable = false;
            Caption = 'Responsibility Center';
            DataClassification = CustomerContent;
        }
        field(29; "Qty Main Store"; Decimal)
        {
            Editable = false;
            Caption = 'Qty Main Store';
            DataClassification = CustomerContent;
        }
    }
    keys
    {
        key(Key1; "Document No.", "Line No.")
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
    }
    trigger OnInsert()
    var
        ItemJnlLineLocal: Record "Item Journal Line";
    begin
    end;

    var
        Text001: label '%1 must be reduced.';
        Text002: label 'You cannot change %1 when %2 is %3.';
        Text003: label 'You cannot change %3 when %2 is %1.';
        Text005: label 'Change %1 from %2 to %3?';
        Text006: label 'You must not enter %1 in a revaluation sum line.';
        ItemJnlTemplate: Record "Item Journal Template";
        ItemJournalBatch: Record "Item Journal Batch";
        ItemJnlBatch: Record "Item Journal Batch";
        ItemJnlLine: Record "Item Journal Line";
        Item: Record Item;
        ItemVariant: Record "Item Variant";
        GLSetup: Record "General Ledger Setup";
        SKU: Record "Stockkeeping Unit";
        MfgSetup: Record "Manufacturing Setup";
        ProdOrder: Record "Production Order";
        ProdOrderLine: Record "Prod. Order Line";
        ProdOrderComp: Record "Prod. Order Component";
        ProdOrderRtngLine: Record "Prod. Order Routing Line";
        WorkCenter: Record "Work Center";
        MachineCenter: Record "Machine Center";
        Location: Record Location;
        Bin: Record Bin;
        Reservation: Page Reservation;
        ItemAvailByDate: Page "Item Availability by Periods";
        ItemAvailByVar: Page "Item Availability by Variant";
        ItemAvailByLoc: Page "Item Availability by Location";
        ItemCheckAvail: Codeunit "Item-Check Avail.";
        ReserveItemJnlLine: Codeunit "Item Jnl. Line-Reserve";
        // NoSeriesMgt: Codeunit NoSeriesManagement;
        UOMMgt: Codeunit "Unit of Measure Management";
        DimMgt: Codeunit DimensionManagement;
        //SSD UserMgt: Codeunit "SSD User Setup Management";
        CalendarMgt: Codeunit "Shop Calendar Management";
        CostCalcMgt: Codeunit "Cost Calculation Management";
        PurchPriceCalcMgt: Codeunit "Purch. Price Calc. Mgt.";
        SalesPriceCalcMgt: Codeunit "Sales Price Calc. Mgt.";
        WMSManagement: Codeunit "WMS Management";
        WhseValidateSourceLine: Codeunit "Whse. Validate Source Line";
        PhysInvtEntered: Boolean;
        GLSetupRead: Boolean;
        MfgSetupRead: Boolean;
        UnitCost: Decimal;
        Text007: label 'New ';
        Text011: label 'The unit cost cannot be changed to %1. Do you want to change it to %2 instead?';
        Text012: label 'The update has been interrupted to respect the warning.';
        Text020: label 'The entered %1 %2 is different from the %1 %3 in %4 %5.\\Do you really want to post the output to %1 %2?';
        Text029: label 'must be positive';
        Text030: label 'must be negative';
        Text031: label 'You can not insert item number %1 because it is not produced on released production order %2.';
        Text16500: label 'Quantity must not be greater than Applies-to Entry Quantity.';
        Text16501: label 'You must select Test Location.';
        Error001: label '%1 must be <= %2';
        ItemLedgEntry2: Record "Item Ledger Entry";
        ILE: Record "Item Ledger Entry";
        Text032: label 'Sorry! You Cannot enter this as a Rework Quantity';
        ProductiOrderList: Page "Production Order List";
        MaterialIssueJournal: Record "SSD Mat. Issue Journal Line";

    procedure UpdatePostedDocNo(var ItemJnlLine: Record "Item Journal Line"; DocNo: Code[20])
    begin
        MaterialIssueJournal.Reset;
        MaterialIssueJournal.SetRange("Document No.", DocNo);
        MaterialIssueJournal.SetRange("Item No.", ItemJnlLine."Item No.");
        MaterialIssueJournal.SetFilter("Posted Document No.", '%1', '');
        if MaterialIssueJournal.FindFirst then begin
            MaterialIssueJournal."Posted Document No." := ItemJnlLine."Document No.";
            MaterialIssueJournal.Modify;
        end;
    end;

    procedure CheckIssueQty(ItemJournalLine: Record "Item Journal Line"): Boolean
    begin
        MaterialIssueJournal.Reset;
        MaterialIssueJournal.SetRange("Document No.", ItemJournalLine."Document No.");
        MaterialIssueJournal.SetRange("Item No.", ItemJournalLine."Item No.");
        if MaterialIssueJournal.FindFirst and (MaterialIssueJournal.Quantity < ItemJournalLine.Quantity) then
            exit(false)
        else
            exit(true);
    end;
}
