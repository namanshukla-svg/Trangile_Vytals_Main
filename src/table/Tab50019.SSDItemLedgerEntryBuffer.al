Table 50019 "SSD Item Ledger Entry Buffer"
{
    // ALLEAA CML-033 280408
    //   - Added New Table
    // 
    // ALLEAA CML-033 180408 -
    // Delete code on Lookup of "BOM Quantity".
    Caption = 'Item Ledger Entry Buffer';
    //SSD DrillDownPageID = "Distributor Subform";
    //SSD LookupPageID = "Distributor Subform";
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
            DataClassification = CustomerContent;
        }
        field(2; "Item No."; Code[20])
        {
            Caption = 'Item No.';
            TableRelation = Item;
            DataClassification = CustomerContent;
        }
        field(3; "Posting Date"; Date)
        {
            Caption = 'Posting Date';
            DataClassification = CustomerContent;
        }
        field(4; "Entry Type"; Option)
        {
            Caption = 'Entry Type';
            OptionCaption = 'Purchase,Sale,Positive Adjmt.,Negative Adjmt.,Transfer,Consumption,Output';
            OptionMembers = Purchase, Sale, "Positive Adjmt.", "Negative Adjmt.", Transfer, Consumption, Output;
            DataClassification = CustomerContent;
        }
        field(5; "Source No."; Code[20])
        {
            Caption = 'Source No.';
            TableRelation = if("Source Type"=const(Customer))Customer
            else if("Source Type"=const(Vendor))Vendor
            else if("Source Type"=const(Item))Item;
            DataClassification = CustomerContent;
        }
        field(6; "Document No."; Code[20])
        {
            Caption = 'Document No.';
            DataClassification = CustomerContent;
        }
        field(7; Description; Text[50])
        {
            Caption = 'Description';
            DataClassification = CustomerContent;
        }
        field(8; "Location Code"; Code[10])
        {
            Caption = 'Location Code';
            TableRelation = Location;
            DataClassification = CustomerContent;
        }
        field(12; Quantity; Decimal)
        {
            Caption = 'Quantity';
            DecimalPlaces = 0: 5;
            DataClassification = CustomerContent;
        }
        field(13; "Remaining Quantity"; Decimal)
        {
            Caption = 'Remaining Quantity';
            DecimalPlaces = 0: 5;
            DataClassification = CustomerContent;
        }
        field(14; "Invoiced Quantity"; Decimal)
        {
            Caption = 'Invoiced Quantity';
            DecimalPlaces = 0: 5;
            DataClassification = CustomerContent;
        }
        field(28; "Applies-to Entry"; Integer)
        {
            Caption = 'Applies-to Entry';
            DataClassification = CustomerContent;
        }
        field(29; Open; Boolean)
        {
            Caption = 'Open';
            DataClassification = CustomerContent;
        }
        field(33; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            TableRelation = "Dimension Value".Code where("Global Dimension No."=const(1));
            DataClassification = CustomerContent;
        }
        field(34; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            TableRelation = "Dimension Value".Code where("Global Dimension No."=const(2));
            DataClassification = CustomerContent;
        }
        field(36; Positive; Boolean)
        {
            Caption = 'Positive';
            DataClassification = CustomerContent;
        }
        field(41; "Source Type"; Option)
        {
            Caption = 'Source Type';
            OptionCaption = ' ,Customer,Vendor,Item';
            OptionMembers = " ", Customer, Vendor, Item;
            DataClassification = CustomerContent;
        }
        field(47; "Drop Shipment"; Boolean)
        {
            Caption = 'Drop Shipment';
            DataClassification = CustomerContent;
        }
        field(50; "Transaction Type"; Code[10])
        {
            Caption = 'Transaction Type';
            TableRelation = "Transaction Type";
            DataClassification = CustomerContent;
        }
        field(51; "Transport Method"; Code[10])
        {
            Caption = 'Transport Method';
            TableRelation = "Transport Method";
            DataClassification = CustomerContent;
        }
        field(52; "Country Code"; Code[10])
        {
            Caption = 'Country Code';
            TableRelation = "Country/Region";
            DataClassification = CustomerContent;
        }
        field(59; "Entry/Exit Point"; Code[10])
        {
            Caption = 'Entry/Exit Point';
            TableRelation = "Entry/Exit Point";
            DataClassification = CustomerContent;
        }
        field(60; "Document Date"; Date)
        {
            Caption = 'Document Date';
            DataClassification = CustomerContent;
        }
        field(61; "External Document No."; Code[20])
        {
            Caption = 'External Document No.';
            DataClassification = CustomerContent;
        }
        field(62; "Area"; Code[10])
        {
            Caption = 'Area';
            TableRelation = Area;
            DataClassification = CustomerContent;
        }
        field(63; "Transaction Specification"; Code[10])
        {
            Caption = 'Transaction Specification';
            TableRelation = "Transaction Specification";
            DataClassification = CustomerContent;
        }
        field(64; "No. Series"; Code[10])
        {
            Caption = 'No. Series';
            TableRelation = "No. Series";
            DataClassification = CustomerContent;
        }
        field(70; "Reserved Quantity"; Decimal)
        {
            CalcFormula = sum("Reservation Entry"."Quantity (Base)" where("Source ID"=const(''), "Source Ref. No."=field("Entry No."), "Source Type"=const(32), "Source Subtype"=const(0), "Source Batch Name"=const(''), "Source Prod. Order Line"=const(0), "Reservation Status"=const(Reservation)));
            Caption = 'Reserved Quantity';
            DecimalPlaces = 0: 5;
            Editable = false;
            FieldClass = FlowField;
        }
        field(5401; "Prod. Order No."; Code[20])
        {
            Caption = 'Prod. Order No.';
            DataClassification = CustomerContent;
        }
        field(5402; "Variant Code"; Code[10])
        {
            Caption = 'Variant Code';
            TableRelation = "Item Variant".Code where("Item No."=field("Item No."));
            DataClassification = CustomerContent;
        }
        field(5404; "Qty. per Unit of Measure"; Decimal)
        {
            Caption = 'Qty. per Unit of Measure';
            DecimalPlaces = 0: 5;
            DataClassification = CustomerContent;
        }
        field(5407; "Unit of Measure Code"; Code[10])
        {
            Caption = 'Unit of Measure Code';
            TableRelation = "Item Unit of Measure".Code where("Item No."=field("Item No."));
            DataClassification = CustomerContent;
        }
        field(5408; "Derived from Blanket Order"; Boolean)
        {
            Caption = 'Derived from Blanket Order';
            DataClassification = CustomerContent;
        }
        field(5700; "Cross-Reference No."; Code[20])
        {
            Caption = 'Cross-Reference No.';
            DataClassification = CustomerContent;
        }
        field(5701; "Originally Ordered No."; Code[20])
        {
            Caption = 'Originally Ordered No.';
            TableRelation = Item;
            DataClassification = CustomerContent;
        }
        field(5702; "Originally Ordered Var. Code"; Code[10])
        {
            Caption = 'Originally Ordered Var. Code';
            TableRelation = "Item Variant".Code where("Item No."=field("Originally Ordered No."));
            DataClassification = CustomerContent;
        }
        field(5703; "Out-of-Stock Substitution"; Boolean)
        {
            Caption = 'Out-of-Stock Substitution';
            DataClassification = CustomerContent;
        }
        field(5704; "Item Category Code"; Code[20])
        {
            Caption = 'Item Category Code';
            TableRelation = "Item Category";
            DataClassification = CustomerContent;
        }
        field(5705; Nonstock; Boolean)
        {
            Caption = 'Nonstock';
            DataClassification = CustomerContent;
        }
        field(5706; "Purchasing Code"; Code[10])
        {
            Caption = 'Purchasing Code';
            TableRelation = Purchasing;
            DataClassification = CustomerContent;
        }
        field(5707; "Product Group Code"; Code[10])
        {
            Caption = 'Product Group Code';
            TableRelation = "Item Category".Code where(Code=field("Item Category Code"));
            DataClassification = CustomerContent;
        }
        field(5740; "Transfer Order No."; Code[20])
        {
            Caption = 'Transfer Order No.';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(5800; "Completely Invoiced"; Boolean)
        {
            Caption = 'Completely Invoiced';
            DataClassification = CustomerContent;
        }
        field(5801; "Last Invoice Date"; Date)
        {
            Caption = 'Last Invoice Date';
            DataClassification = CustomerContent;
        }
        field(5802; "Applied Entry to Adjust"; Boolean)
        {
            Caption = 'Applied Entry to Adjust';
            DataClassification = CustomerContent;
        }
        field(5804; "Cost Amount"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Cost Amount (Actual)';
            Editable = false;
            FieldClass = Normal;
            DataClassification = CustomerContent;
        }
        field(5817; Correction; Boolean)
        {
            Caption = 'Correction';
            DataClassification = CustomerContent;
        }
        field(5832; "Prod. Order Line No."; Integer)
        {
            Caption = 'Prod. Order Line No.';
            DataClassification = CustomerContent;
        }
        field(5833; "Prod. Order Comp. Line No."; Integer)
        {
            Caption = 'Prod. Order Comp. Line No.';
            DataClassification = CustomerContent;
        }
        field(5900; "Service Order No."; Code[20])
        {
            Caption = 'Service Order No.';
            DataClassification = CustomerContent;
        }
        field(50015; "Bin Code"; Code[20])
        {
            Caption = 'Bin Code';
            TableRelation = Bin.Code where("Location Code"=field("Location Code"));
            DataClassification = CustomerContent;
        }
        field(50022; "Consumption Qty."; Decimal)
        {
            Description = 'CML-034';
            Caption = 'Consumption Qty.';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                //CML-034 ALLEAG 220408 Start
                if not Apply then Error('Apply must be checked');
                TotalConsumptionQty:=0;
                ItemLedgerBuffer.Reset;
                ItemLedgerBuffer.SetRange(ItemLedgerBuffer."Consumption Template Name", "Consumption Template Name");
                ItemLedgerBuffer.SetRange(ItemLedgerBuffer."Consumption Batch Name", "Consumption Batch Name");
                ItemLedgerBuffer.SetRange(ItemLedgerBuffer."Consumption Line No.", "Consumption Line No.");
                if ItemLedgerBuffer.FindFirst then repeat TotalConsumptionQty+=ItemLedgerBuffer."Consumption Qty.";
                    until ItemLedgerBuffer.Next = 0;
                ConJnlLine.Reset;
                if ConJnlLine.Get("Consumption Template Name", "Consumption Batch Name", "Consumption Line No.")then begin
                    if TotalConsumptionQty + "Consumption Qty." - xRec."Consumption Qty." > ConJnlLine.Quantity then Error('Total Consumption Qty. can not be greater than %1', ConJnlLine.Quantity);
                end;
            //CML-034 ALLEAG 220408 Finish
            end;
        }
        field(50023; "Consumption Template Name"; Code[20])
        {
            Description = 'CML-034';
            Caption = 'Consumption Template Name';
            DataClassification = CustomerContent;
        }
        field(50024; "Consumption Batch Name"; Code[20])
        {
            Description = 'CML-034';
            Caption = 'Consumption Batch Name';
            DataClassification = CustomerContent;
        }
        field(50025; "Consumption Line No."; Integer)
        {
            Description = 'CML-034';
            Caption = 'Consumption Line No.';
            DataClassification = CustomerContent;
        }
        field(60002; "Subcon Order No."; Code[20])
        {
            Caption = 'Subcon Order No.';
            DataClassification = CustomerContent;
        }
        field(60003; "Subcon Order Line No."; Integer)
        {
            Caption = 'Subcon Order Line No.';
            DataClassification = CustomerContent;
        }
        field(60004; "Line No."; Integer)
        {
            Caption = 'Line No.';
            DataClassification = CustomerContent;
        }
        field(60005; Apply; Boolean)
        {
            Caption = 'Apply';
            DataClassification = CustomerContent;
        }
        field(60006; "OutPut Item Unit Of Measure"; Decimal)
        {
            Description = 'Subcontracting';
            Editable = false;
            Caption = 'OutPut Item Unit Of Measure';
            DataClassification = CustomerContent;
        }
        field(60007; "Output Item Code"; Code[20])
        {
            Description = 'Subcontracting';
            Editable = false;
            TableRelation = Item;
            Caption = 'Output Item Code';
            DataClassification = CustomerContent;
        }
        field(60008; "BOM Quantity"; Decimal)
        {
            Description = 'Subcontracting';
            Editable = false;
            MinValue = 0;
            Caption = 'BOM Quantity';
            DataClassification = CustomerContent;
        }
        field(60009; "Scrap Generated"; Decimal)
        {
            Description = 'Subcontracting';
            Caption = 'Scrap Generated';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                if("BOM Quantity" + "Scrap Generated") > "Remaining Quantity" then Error('You cannot exceed the limit %1', "Remaining Quantity");
            end;
        }
        field(60010; "Prod. BOM No."; Code[20])
        {
            Description = 'Subcontracting';
            Editable = false;
            Caption = 'Prod. BOM No.';
            DataClassification = CustomerContent;
        }
        field(60011; "Production BOM Quantity"; Decimal)
        {
            Description = 'Subcontracting';
            Editable = false;
            Caption = 'Production BOM Quantity';
            DataClassification = CustomerContent;
        }
        field(60012; "Parent Document No."; Code[20])
        {
            Description = 'Subcontracting';
            Editable = false;
            Caption = 'Parent Document No.';
            DataClassification = CustomerContent;
        }
        field(60013; "Party No."; Code[20])
        {
            Description = 'Subcontracting';
            TableRelation = Vendor;
            Caption = 'Party No.';
            DataClassification = CustomerContent;
        }
        field(60014; "Party Location"; Code[20])
        {
            Description = 'Subcontracting';
            TableRelation = Location;
            Caption = 'Party Location';
            DataClassification = CustomerContent;
        }
        field(60015; "Template Name"; Code[20])
        {
            Description = 'Subcontracting';
            Caption = 'Template Name';
            DataClassification = CustomerContent;
        }
        field(60016; "Batch Name"; Code[20])
        {
            Description = 'Subcontracting';
            Caption = 'Batch Name';
            DataClassification = CustomerContent;
        }
        field(60017; "OutPut Item UOM"; Code[20])
        {
            Description = 'Subcontracting';
            Editable = false;
            TableRelation = "Unit of Measure";
            Caption = 'OutPut Item UOM';
            DataClassification = CustomerContent;
        }
        field(60018; "OutPut Item Quantity"; Decimal)
        {
            Description = 'Subcontracting';
            MinValue = 0;
            Caption = 'OutPut Item Quantity';
            DataClassification = CustomerContent;

            trigger OnValidate()
            var
                "---Mes": Integer;
                ItemUOM: Record "Item Unit of Measure";
                RGPLine: Record "SSD RGP Line";
            begin
                //Mes_Start
                Validate("BOM Quantity", "OutPut Item Quantity" * ("OutPut Item Unit Of Measure"));
                ItemUOM.Get("Item No.", "Unit of Measure Code");
                //VALIDATE("Scrap Generated" , ("OutPut Item Quantity"*"Production BOM Quantity")-"BOM Quantity"); //ALLEAA CML-033 220408
                //Mes_End
                //ALLEAA CML-033 190408 Start >>
                ItemVendor.SetRange(ItemVendor."Vendor No.", "Party No.");
                ItemVendor.SetRange(ItemVendor."Item No.", "Output Item Code");
                if ItemVendor.FindFirst then "Scrap Generated":=ItemVendor."Scrap Qty. Per Unit" * "OutPut Item Quantity";
                "Scrap Generated":=0; //ALLEAA CML-033 230408
                "BOM Quantity":="OutPut Item Quantity" * "Production BOM Quantity";
                CheckOutputQuantity("Prod. BOM No.");
                if("BOM Quantity" + "Scrap Generated") > "Remaining Quantity" then Error('You cannot exceed the limit %1', "Remaining Quantity");
            //ALLEAA CML-033 190408 End <<
            end;
        }
        field(60019; "Parent Document Line No."; Integer)
        {
            Description = 'Subcontracting';
            Editable = false;
            Caption = 'Parent Document Line No.';
            DataClassification = CustomerContent;
        }
        field(60020; "Scrap Received"; Boolean)
        {
            Description = 'Subcontracting';
            Caption = 'Scrap Received';
            DataClassification = CustomerContent;
        }
        field(60021; "Output Qty."; Decimal)
        {
            Description = 'ALLEAA CML-033 190408';
            Caption = 'Output Qty.';
            DataClassification = CustomerContent;
        }
        field(60022; "Max. Rec. Qty"; Decimal)
        {
            Description = 'ssd';
            Caption = 'Max. Rec. Qty';
            DataClassification = CustomerContent;
        }
    }
    keys
    {
        key(Key1; "Entry No.")
        {
            Clustered = true;
        }
        key(Key2; "Item No.", Open, "Variant Code", Positive, "Location Code", "Posting Date")
        {
            SumIndexFields = Quantity, "Remaining Quantity";
        }
        key(Key3; "Item No.", Positive, "Location Code", "Variant Code")
        {
        }
        key(Key4; "Posting Date", "Item No.")
        {
        }
        key(Key5; "Subcon Order No.", "Subcon Order Line No.", "Line No.", "Entry Type", "Location Code")
        {
        }
        key(Key6; "Item No.", "Location Code")
        {
        }
        key(Key7; "Location Code")
        {
        }
        key(Key8; "Consumption Template Name", "Consumption Batch Name", "Consumption Line No.", Apply)
        {
            SumIndexFields = "Consumption Qty.";
        }
    }
    fieldgroups
    {
    }
    var ItemVendor: Record "Item Vendor";
    ConJnlLine: Record "Item Journal Line";
    ItemLedgerBuffer: Record "SSD Item Ledger Entry Buffer";
    TotalConsumptionQty: Decimal;
    local procedure CalcBaseQty(Qty: Decimal): Decimal begin
        TestField("Qty. per Unit of Measure");
        exit(ROUND(Qty * "Qty. per Unit of Measure", 0.00001));
    end;
    procedure "---Mes---"()
    begin
    end;
    procedure CheckOutputQuantity(ProductionNo: Code[20])
    var
        ItemLedgEntry: Record "SSD Item Ledger Entry Buffer";
        RGPLine: Record "SSD RGP Line";
        CompQty: Decimal;
        ProductionBomLine: Record "Production BOM Line";
        ItemCode: Code[20];
    begin
        //ALLEAA CML-033 180408 Start >>
        ProductionBomLine.Reset;
        ProductionBomLine.SetRange(ProductionBomLine."Production BOM No.", ProductionNo);
        if ProductionBomLine.FindFirst then repeat //ALLEAA CML-033 180408 End <<
                CompQty:=0;
                ItemLedgEntry.Reset;
                ItemLedgEntry.SetCurrentkey("Location Code");
                ItemLedgEntry.SetRange("Location Code", "Location Code");
                ItemLedgEntry.SetFilter("Remaining Quantity", '>%1', 0);
                ItemLedgEntry.SetRange("Output Item Code", "Output Item Code");
                ItemLedgEntry.SetRange("Party Location", "Party Location");
                ItemLedgEntry.SetFilter("Entry No.", '<>%1', "Entry No.");
                ItemLedgEntry.SetRange("Item No.", ProductionBomLine."No.");
                if ItemLedgEntry.Find('-')then repeat CompQty+=ItemLedgEntry."OutPut Item Quantity";
                        ItemCode:=ItemLedgEntry."Item No."; //ALLEAA CML-033 180408
                    until ItemLedgEntry.Next = 0;
                RGPLine.Get(RGPLine."document type"::"RGP Inbound", "Parent Document No.", "Parent Document Line No.");
                if ItemCode = "Item No." then //ALLEAA CML-033 180408
 //ALLEAA CML-033 190408 Start >>
                    //IF (RGPLine.Quantity - RGPLine."Qty. Consumed") < (CompQty+"OutPut Item Quantity") THEN
                    if(RGPLine.Quantity - RGPLine."Output Qty.") < (CompQty + "OutPut Item Quantity")then;
            // ERROR('You are exceeding the limit %1.',RGPLine.Quantity - RGPLine."Output Qty.");  //ssd
            //ERROR('You are exceeding the limit %1.',RGPLine.Quantity - RGPLine."Qty. Consumed");
            //ALLEAA CML-033 190408 End <<
            until ProductionBomLine.Next = 0; //ALLEAA CML-033 180408
    end;
    procedure CheckOutputQtyForCompItm(ProductionNo: Code[20])
    var
        ItemLedgEntry: Record "SSD Item Ledger Entry Buffer";
        RGPLine: Record "SSD RGP Line";
        CompQty: Decimal;
        ProductionBomLine: Record "Production BOM Line";
        ItemCode: Code[20];
    begin
        //ALLEAA CML-033 180408 Start >>
        CompQty:=0;
        ItemLedgEntry.Reset;
        ItemLedgEntry.SetCurrentkey("Location Code");
        ItemLedgEntry.SetFilter("OutPut Item Quantity", '<>%1', 0);
        if ItemLedgEntry.Find('-')then repeat CompQty+=ItemLedgEntry."OutPut Item Quantity";
                ItemCode:=ItemLedgEntry."Item No.";
            until ItemLedgEntry.Next = 0;
        RGPLine.Get(RGPLine."document type"::"RGP Inbound", "Parent Document No.", "Parent Document Line No.");
        if ItemCode = "Item No." then if(RGPLine.Quantity - RGPLine."Output Qty.") < (CompQty + "OutPut Item Quantity")then Error('You are exceeding the limit %1.', RGPLine.Quantity - RGPLine."Qty. Consumed");
    //ALLEAA CML-033 180408 End <<
    end;
}
