Table 50004 "SSD Indent Line"
{
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Document No."; Code[20])
        {
            Caption = 'Document No.';
            DataClassification = CustomerContent;
        }
        field(3; "Line No."; Integer)
        {
            Caption = 'Line No.';
            DataClassification = CustomerContent;
        }
        field(4; Type; Option)
        {
            OptionCaption = ' ,Item,Fixed Asset,G/L Account,Charge (Item)';
            OptionMembers = " ",Item,"Fixed Asset","G/L Account","Charge (Item)";
            Caption = 'Type';
            DataClassification = CustomerContent;

            trigger OnValidate()
            var
                TempIndentLine: Record "SSD Indent Line" temporary;
                SSDIndentHeader: Record "SSD Indent Header";
            begin
                TestStatusOpen();
                SSDIndentHeader.Get("Document No.");
                TempIndentLine.Copy(Rec);
                Init;
                "Document No." := TempIndentLine."Document No.";
                "Line No." := TempIndentLine."Line No.";
                Type := TempIndentLine.Type;
                "Indent Order Type" := SSDIndentHeader."Indent Order Type";
                "Due Date" := xRec."Due Date";
                "Responsibility Center" := TempIndentLine."Responsibility Center";
                SetLineType();
            end;
        }
        field(5; "No."; Code[20])
        {
            //SSD Comment Start
            // TableRelation = if (Type = const(" ")) "Standard Text"
            // else if (Type = const(Item)) Item where("Item Type" = const(Indent))
            // else if (Type = const("Fixed Asset")) "Fixed Asset"
            // else if (Type = const("G/L Account")) "G/L Account"
            // else if (Type = const("Charge (Item)")) "Item Charge";
            //SSD Comment End

            TableRelation = if (Type = const(" ")) "Standard Text"
            else if (Type = const(Item), "Indent Order Type" = const(Inventory)) Item where("Item Type" = const(Indent), Type = filter(Inventory | "Non-Inventory"))
            else if (Type = const("Fixed Asset"), "Indent Order Type" = const("Fixed Assets")) "Fixed Asset"
            else if (Type = const("G/L Account"), "Indent Order Type" = const(Services)) "G/L Account"
            else if (Type = const(Item), "Indent Order Type" = const(Services)) Item where("Item Type" = const(Indent), Type = filter(Service))
            else if (Type = const("Charge (Item)")) "Item Charge";

            Caption = 'No.';
            DataClassification = CustomerContent;

            trigger OnValidate()
            var
                ItemCategoryLocal: Record "Item Category";
                FixedAsset: Record "Fixed Asset";
                GLAccount: Record "G/L Account";
                ItemCharge: Record "Item Charge";
                SalesLine: Record "Sales Line";
            begin
                TestStatusOpen();
                if IndentHeader.Get("Document No.") then begin
                    "Due Date" := IndentHeader."Due Date";
                    "Responsibility Center" := IndentHeader."Responsibility Center";
                    "Shortcut Dimension 1 Code" := IndentHeader."Shortcut Dimension 1 Code";
                    "Shortcut Dimension 2 Code" := IndentHeader."Shortcut Dimension 2 Code";
                    Remarks := IndentHeader.Remarks;
                    "Location Code" := IndentHeader."Location Code";
                    "Indent Order Type" := IndentHeader."Indent Order Type";
                end;
                TempIndentLine.Copy(Rec);
                Init;
                Type := TempIndentLine.Type;
                "No." := TempIndentLine."No.";
                "Responsibility Center" := TempIndentLine."Responsibility Center";
                "Shortcut Dimension 1 Code" := TempIndentLine."Shortcut Dimension 1 Code";
                "Shortcut Dimension 2 Code" := TempIndentLine."Shortcut Dimension 2 Code";
                "Indent Order Type" := IndentHeader."Indent Order Type";
                "Indent Date" := WorkDate;
                "Location Code" := IndentHeader."Location Code";
                "Due Date" := IndentHeader."Due Date";
                //Template Name and Batch Name
                "Template Name" := IndentPost.GetIndentTemplate(IndentHeader);
                "Batch Name" := IndentPost.GetIndentBatch(IndentHeader);
                SetLineType();
                case Type of
                    Type::" ":
                        begin
                            StandardText.Get("No.");
                            Description := StandardText.Description
                        end;
                    Type::Item:
                        begin
                            GetItem();
                            Item.TestField(Blocked, false); //ALLE
                            if Item.Type <> Item.Type::Service then Item.TestField("Inventory Posting Group");
                            Item.Get("No.");
                            ItemUnitMeasure.Get("No.", Item."Purch. Unit of Measure"); //MSI
                            Description := Item.Description;
                            "Description 2" := Item."Description 2";
                            Validate("Direct Unit Cost", Item."Unit Cost");
                            "Shelf No." := Item."Shelf No.";
                            "Gen.Prod.Posting Group" := Item."Gen. Prod. Posting Group";
                            "Unit Of Measure Code" := Item."Purch. Unit of Measure"; //MSI
                            "Qty. per Unit Of Measure" := ItemUnitMeasure."Qty. per Unit of Measure";
                            "Item Category Code" := Item."Item Category Code";
                            Validate("Direct Unit Cost", Item."Last Direct Cost");
                            if Item.Type = Item.Type::Inventory then begin
                                Item.CalcFields(Inventory);
                                "Inventory Main Store" := Item.Inventory;
                            end;
                            if (IndentHeader."Due Date") < CalcDate(Item."Lead Time Dispatch", IndentHeader."Indent Date") then Error('Due Date is less then Lead Time of Item');
                        end;
                    Type::"Fixed Asset":
                        begin
                            FixedAsset.Get("No.");
                            FixedAsset.TestField(Inactive, false);
                            FixedAsset.TestField(Blocked, false);
                            Description := FixedAsset.Description;
                            "Description 2" := FixedAsset."Description 2";
                        end;
                    Type::"G/L Account":
                        begin
                            GLAccount.Get("No.");
                            GLAccount.TestField(Blocked, false);
                            Description := GLAccount.Name;
                            "Description 2" := '';
                        end;
                    Type::"Charge (Item)":
                        begin
                            ItemCharge.Get("No.");
                            Description := ItemCharge.Description;
                            "Description 2" := '';
                            "Unit Of Measure Code" := ItemCharge.UOM;
                            "Qty. per Unit Of Measure" := 1;
                        end;
                end;
            end;
        }
        field(6; Description; Text[80])
        {
            Editable = false;
            Caption = 'Description';
            DataClassification = CustomerContent;
        }
        field(7; "Description 2"; Text[50])
        {
            Editable = false;
            Caption = 'Description 2';
            DataClassification = CustomerContent;
        }
        field(8; Quantity; Decimal)
        {
            DecimalPlaces = 0 : 5;
            Caption = 'Quantity';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                TestStatusOpen();
                case Type of
                    Type::Item:
                        "Quantity (Base)" := CalcBaseQty(Quantity);
                    Type::"Fixed Asset":
                        "Quantity (Base)" := Quantity;
                    Type::"G/L Account":
                        "Quantity (Base)" := Quantity;
                    Type::"Charge (Item)":
                        "Quantity (Base)" := Quantity;
                end;
                //shri
                //  Rec."Line Amount" := Rec."Direct Unit Cost" * Rec.Quantity;

            end;
        }
        field(9; Remarks; Text[200])
        {
            Caption = 'Remarks';
            DataClassification = CustomerContent;
        }
        field(10; "Direct Unit Cost"; Decimal)
        {
            Caption = 'Direct Unit Cost';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                TestStatusOpen();
                //shri
                Rec.Validate("Line Amount", Rec."Direct Unit Cost" * Rec.Quantity);
            end;
        }
        field(12; "Due Date"; Date)
        {
            Caption = 'Due Date';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                TestStatusOpen()
            end;
        }
        field(15; "Shortcut Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,2,1';
            Caption = 'Shortcut Dimension 1 Code';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1));
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                TestStatusOpen();
                ValidateShortcutDimCode(1, "Shortcut Dimension 1 Code");
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
                TestStatusOpen();
                ValidateShortcutDimCode(2, "Shortcut Dimension 2 Code");
            end;
        }
        field(17; "Responsibility Center"; Code[20])
        {
            TableRelation = "Responsibility Center".Code;
            Caption = 'Responsibility Center';
            DataClassification = CustomerContent;
        }
        field(50; "Location Code"; Code[20])
        {
            Caption = 'Location Code';
            TableRelation = Location;
        }
        field(5402; "Variant Code"; Code[10])
        {
            TableRelation = "Item Variant".Code;
            Caption = 'Variant Code';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                TestStatusOpen()
            end;
        }
        field(5404; "Qty. per Unit Of Measure"; Decimal)
        {
            Caption = 'Qty. per Unit Of Measure';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                TestStatusOpen()
            end;
        }
        field(5407; "Unit Of Measure Code"; Code[10])
        {
            Editable = false;
            TableRelation = "Unit of Measure";
            Caption = 'Unit Of Measure Code';
            DataClassification = CustomerContent;

            trigger OnValidate()
            var
                ItemCharge: Record "Item Charge";
            begin
                TestStatusOpen();
                if Type = Type::"Charge (Item)" then begin
                    ItemCharge.Get("No.");
                    TestField("Unit of Measure Code", ItemCharge.UOM);
                end;
            end;
        }
        field(5408; "Quantity (Base)"; Decimal)
        {
            DecimalPlaces = 0 : 5;
            Caption = 'Quantity (Base)';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                TestStatusOpen()
            end;
        }
        field(5701; "Item Category Code"; Code[20])
        {
            TableRelation = "Item Category";
            Caption = 'Item Category Code';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                TestStatusOpen()
            end;
        }
        field(5705; "Product Group Code"; Code[10])
        {
            //SSD TableRelation = "Product Group";
            Caption = 'Product Group Code';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                TestStatusOpen()
            end;
        }
        field(50001; "Indent Date"; Date)
        {
            Caption = 'Indent Date';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                TestStatusOpen()
            end;
        }
        field(50002; "Expected Cost"; Decimal)
        {
            Caption = 'Expected Cost';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                TestStatusOpen()
            end;
        }
        field(50003; "Inventory Main Store"; Decimal)
        {
            DecimalPlaces = 0 : 5;
            Caption = 'Inventory Main Store';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                TestStatusOpen()
            end;
        }
        field(50004; "Capital Item"; Boolean)
        {
            Caption = 'Capital Item';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                TestStatusOpen()
            end;
        }
        field(50005; "Qty. on Purchase Order"; Decimal)
        {
            CalcFormula = sum("Purchase Line"."Outstanding Qty. (Base)" where("Document Type" = const(Order), Type = field("SSD PO Line Type"), "No." = field("No.")));
            FieldClass = FlowField;
            Caption = 'Qty. on Purchase Order';
        }
        field(50006; "Qty. on Req. Line"; Decimal)
        {
            CalcFormula = sum("Requisition Line"."Remaining Quantity" where("Worksheet Template Name" = field("Template Name"), "Journal Batch Name" = field("Batch Name"), Type = field("SSD Req Line Type"), "No." = field("No.")));
            FieldClass = FlowField;
            Caption = 'Qty. on Req. Line';
        }
        field(50007; "No.2"; Code[20])
        {
            CalcFormula = lookup(Item."No. 2" where("No." = field("No.")));
            FieldClass = FlowField;
            Caption = 'No.2';
        }
        field(50013; "Template Name"; Code[10])
        {
            TableRelation = "Req. Wksh. Template" where("Page ID" = const(291), Recurring = const(false), Type = const("Req."));
            Caption = 'Template Name';
            DataClassification = CustomerContent;
        }
        field(50014; "Batch Name"; Code[10])
        {
            TableRelation = "Requisition Wksh. Name".Name where("Worksheet Template Name" = field("Template Name"));
            Caption = 'Batch Name';
            DataClassification = CustomerContent;
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
        field(54001; "Shelf No."; Code[20])
        {
            TableRelation = "SSD Item Ledger Entry Buffer";
            Caption = 'Shelf No.';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                TestStatusOpen()
            end;
        }
        field(54002; "ROL-Maximum Order Quantity"; Decimal)
        {
            CalcFormula = lookup(Item."Maximum Order Quantity" where("No." = field("No.")));
            Description = 'Alle';
            FieldClass = FlowField;
            Caption = 'ROL-Maximum Order Quantity';
        }
        field(54003; "CL-Minimum Order Quantity"; Decimal)
        {
            CalcFormula = lookup(Item."Minimum Order Quantity" where("No." = field("No.")));
            Description = 'Alle';
            FieldClass = FlowField;
            Caption = 'CL-Minimum Order Quantity';
        }
        field(54004; "MSL-Safety Stock Quantity"; Decimal)
        {
            CalcFormula = lookup(Item."Safety Stock Quantity" where("No." = field("No.")));
            Description = 'Alle';
            FieldClass = FlowField;
            Caption = 'MSL-Safety Stock Quantity';
        }
        field(54005; "Indenter ID"; Code[20])
        {
            CalcFormula = lookup("SSD Indent Header"."Indenter ID" where("No." = field("Document No.")));
            Description = 'ALLE';
            FieldClass = FlowField;
            Caption = 'Indenter ID';
        }
        field(55001; "Description 3"; Text[300])
        {
            DataClassification = CustomerContent;
            Caption = 'Description 3';
        }
        field(99000882; "Gen.Prod.Posting Group"; Code[20])
        {
            TableRelation = "Gen. Product Posting Group";
            Caption = 'Gen.Prod.Posting Group';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                TestStatusOpen()
            end;
        }
        field(55002; "Indent Order Type"; Option)
        {
            OptionMembers = " ",Inventory,"Fixed Assets",Services;
            DataClassification = CustomerContent;
        }
        field(55003; "Line Amount"; Decimal)
        {
            DataClassification = CustomerContent;
            Editable = false;

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
    trigger OnDelete()
    var
        IndentHeaderLocal: Record "SSD Indent Header";
    begin
        IndentHeaderLocal.Get("Document No.");
        /*  // BIS 1145
            //Dimension
            DocDim.RESET;
            DocDim.SETRANGE("Table ID",DATABASE::"Indent Line");
            DocDim.SETRANGE("Document Type",6);
            DocDim.SETRANGE("Document No.","Document No.");
            DocDim.SETRANGE("Line No.","Line No.");
            DocDim.DELETEALL;
            */
    end;

    trigger OnInsert()
    var
        SSDIndentHeader: Record "SSD Indent Header";
    begin
        TestStatusOpen;

    end;


    trigger OnRename()
    begin
        Error(Text002, TableCaption);
    end;

    var
        Item: Record Item;
        ItemUnitMeasure: Record "Item Unit of Measure";
        StandardText: Record "Standard Text";
        Text001: label 'Status must be open for Indent %1';
        DimMgt: Codeunit DimensionManagement;
        IndentHeader: Record "SSD Indent Header";
        TempIndentLine: Record "SSD Indent Line" temporary;
        Text002: label 'You cannot rename a %1.';
        IndentPost: Report "Indent Post";
        GLAcc: Record "G/L Account";
        FA: Record "Fixed Asset";
        IndentLine: Record "SSD Indent Line";
        Item1: Record Item;

    procedure TestStatusOpen()
    var
        IndentHeader: Record "SSD Indent Header";
    begin
        IndentHeader.Get("Document No.");
        if IndentHeader.Status <> IndentHeader.Status::Open then Error(Text001, "Document No.");
    end;

    procedure ValidateShortcutDimCode(FieldNumber: Integer; var ShortcutDimCode: Code[20])
    begin
        DimMgt.ValidateDimValueCode(FieldNumber, ShortcutDimCode);
    end;

    procedure CreateDim(Type1: Integer; No1: Code[20]; Type2: Integer; No2: Code[20]; Type3: Integer; No3: Code[20]; Type4: Integer; No4: Code[20])
    var
        SourceCodeSetup: Record "Source Code Setup";
        TableID: array[10] of Integer;
        No: array[10] of Code[20];
    begin
        SourceCodeSetup.Get;
        TableID[1] := Type1;
        No[1] := No1;
        TableID[2] := Type2;
        No[2] := No2;
        TableID[3] := Type3;
        No[3] := No3;
        TableID[4] := Type4;
        No[4] := No4;
        "Shortcut Dimension 1 Code" := '';
        "Shortcut Dimension 2 Code" := '';
    end;

    local procedure CalcBaseQty(Qty: Decimal): Decimal
    begin
        TestField("Qty. per Unit Of Measure");
        exit(ROUND(Qty * "Qty. per Unit Of Measure", 0.00001));
    end;

    local procedure GetItem()
    begin
        TestField("No.");
        if "No." <> Item."No." then Item.Get("No.");
    end;

    local procedure SetLineType()
    begin
        case Type of
            Type::" ":
                begin
                    "SSD PO Line Type" := "SSD PO Line Type"::" ";
                    "SSD Req Line Type" := "SSD Req Line Type"::" ";
                end;
            Type::Item:
                begin
                    "SSD PO Line Type" := "SSD PO Line Type"::Item;
                    "SSD Req Line Type" := "SSD Req Line Type"::Item
                end;
            Type::"Charge (Item)":
                begin
                    "SSD PO Line Type" := "SSD PO Line Type"::"Charge (Item)";
                    "SSD Req Line Type" := "SSD Req Line Type"::"SSD Charge (Item)"
                end;
            Type::"G/L Account":
                begin
                    "SSD PO Line Type" := "SSD PO Line Type"::"G/L Account";
                    "SSD Req Line Type" := "SSD Req Line Type"::"G/L Account";
                end;
            Type::"Fixed Asset":
                begin
                    "SSD PO Line Type" := "SSD PO Line Type"::"Fixed Asset";
                    "SSD Req Line Type" := "SSD Req Line Type"::"SSD Fixed Asset";
                end;
        end;
    end;

}
