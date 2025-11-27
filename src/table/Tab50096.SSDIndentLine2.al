Table 50096 "SSD Indent Line2"
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
            OptionCaption = ' ,Item,Fixed Asset';
            OptionMembers = " ", Item, "Fixed Asset";
            Caption = 'Type';
            DataClassification = CustomerContent;

            trigger OnValidate()
            var
                TempIndentLine: Record "SSD Indent Line2" temporary;
            begin
                TestStatusOpen();
                TempIndentLine.Copy(Rec);
                Init;
                "Document No.":=TempIndentLine."Document No.";
                "Line No.":=TempIndentLine."Line No.";
                Type:=TempIndentLine.Type;
                "Due Date":=xRec."Due Date";
                "Responsibility Center":=TempIndentLine."Responsibility Center";
            end;
        }
        field(5; "No."; Code[20])
        {
            //SSDU 
            TableRelation = if(Type=const(" "))"Standard Text"
            else if(Type=const(Item))Item where("Item Type"=const(Indent))
            else if(Type=const("Fixed Asset"))"Fixed Asset";
            //SSDU
            Caption = 'No.';
            DataClassification = CustomerContent;

            trigger OnValidate()
            var
                ItemCategoryLocal: Record "Item Category";
                FixedAsset: Record "Fixed Asset";
            begin
                TestStatusOpen();
                //  pk cn004
                /*
                IndentLine.RESET;
                IndentLine.SETFILTER(IndentLine."Document No.","Document No.");
                IndentLine.SETFILTER(IndentLine."No.","No.");
                 IF IndentLine.FINDFIRST THEN
                   BEGIN
                   IF "No."=IndentLine."No." THEN
                      ERROR('This item already exists');
                   END;
                 */
                //  pk cn004
                if IndentHeader.Get("Document No.")then begin
                    if xRec."Due Date" = 0D then "Due Date":=IndentHeader."Due Date"
                    else
                        "Due Date":=xRec."Due Date";
                    IndentHeader.TestField("Shortcut Dimension 1 Code");
                    "Responsibility Center":=IndentHeader."Responsibility Center";
                    "Shortcut Dimension 1 Code":=IndentHeader."Shortcut Dimension 1 Code";
                    "Shortcut Dimension 2 Code":=IndentHeader."Shortcut Dimension 2 Code";
                end;
                TempIndentLine.Copy(Rec);
                Init;
                Type:=TempIndentLine.Type;
                "No.":=TempIndentLine."No.";
                "Due Date":=TempIndentLine."Due Date";
                "Responsibility Center":=TempIndentLine."Responsibility Center";
                "Shortcut Dimension 1 Code":=TempIndentLine."Shortcut Dimension 1 Code";
                "Shortcut Dimension 2 Code":=TempIndentLine."Shortcut Dimension 2 Code";
                //Template Name and Batch Name
                "Template Name":=IndentPost.GetIndentTemplate2(IndentHeader); //dp
                "Batch Name":=IndentPost.GetIndentBatch2(IndentHeader); //dp
                case Type of Type::" ": begin
                    StandardText.Get("No.");
                    Description:=StandardText.Description end;
                Type::Item: begin
                    //Sandeep Singla start
                    GetItem();
                    Item.TestField(Blocked, false); //ALLE
                    Item.TestField("Inventory Posting Group");
                    //SSD Item.TestField("Excise Prod. Posting Group");
                    //Item.TestField("Tax Group Code");//SSDU
                    //SSD if Item."Inventory Posting Group" = 'CAP' then
                    //SSD Item.TestField("Capital Item");
                    //Sandeep Singla end
                    Item.Get("No.");
                    ItemUnitMeasure.Get("No.", Item."Purch. Unit of Measure"); //MSI
                    Description:=Item.Description;
                    "Description 2":=Item."Description 2";
                    "Direct Unit Cost":=Item."Unit Cost";
                    "Shelf No.":=Item."Shelf No.";
                    "Gen.Prod.Posting Group":=Item."Gen. Prod. Posting Group";
                    "Unit Of Measure Code":=Item."Purch. Unit of Measure"; //MSI
                    "Qty. per Unit Of Measure":=ItemUnitMeasure."Qty. per Unit of Measure";
                    "Indent Date":=WorkDate;
                    //SSD "Capital Item" := Item."Capital Item";
                    "Item Category Code":=Item."Item Category Code";
                    //SSD "Product Group Code" := Item."Product Group Code";
                    "Direct Unit Cost":=Item."Last Direct Cost";
                    Item.CalcFields(Inventory);
                    "Inventory Main Store":=Item.Inventory;
                end;
                Type::"Fixed Asset": begin
                    FixedAsset.Get("No.");
                    FixedAsset.TestField(Inactive, false);
                    FixedAsset.TestField(Blocked, false);
                    Description:=FixedAsset.Description;
                    "Description 2":=FixedAsset."Description 2";
                end;
                end;
                //5.51
                if IndentHeader.Get("Document No.")then Remarks:=IndentHeader.Remarks;
                //5.51
                //Dimensions
                /*CreateDim(
                  DimMgt.TypeToTableID3(Type),"No.",
                  DATABASE::Job,'',
                  DATABASE::"Responsibility Center",'',
                  DATABASE::"Work Center",'');
                */
                //ALLE 171017
                IndentHeader.Get("Document No.");
                "Due Date":=IndentHeader."Due Date";
            //SSD Comment Start
            // if Type = Type::Item then begin
            //     if Item1.Get("No.") then
            //         if (IndentHeader."Due Date") < CalcDate(Item1."Lead Time Dispatch", IndentHeader."Indent Date") then
            //             Error('Due Date is less then Lead Time of Item');
            // end;
            //SSD Comment End
            //ALLE 171017
            end;
        }
        field(6; Description; Text[80])
        {
            Editable = true;
            Caption = 'Description';
            DataClassification = CustomerContent;
        }
        field(7; "Description 2"; Text[50])
        {
            Editable = true;
            Caption = 'Description 2';
            DataClassification = CustomerContent;
        }
        field(8; Quantity; Decimal)
        {
            DecimalPlaces = 0: 5;
            Caption = 'Quantity';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                TestStatusOpen();
                if Type = Type::Item then "Quantity (Base)":=CalcBaseQty(Quantity);
                if Type = Type::"Fixed Asset" then "Quantity (Base)":=Quantity;
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
                TestStatusOpen()end;
        }
        field(12; "Due Date"; Date)
        {
            Caption = 'Due Date';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                TestStatusOpen()end;
        }
        field(15; "Shortcut Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,2,1';
            Caption = 'Shortcut Dimension 1 Code';
            TableRelation = "Dimension Value".Code where("Global Dimension No."=const(1));
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
            TableRelation = "Dimension Value".Code where("Global Dimension No."=const(2));
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
        field(5402; "Variant Code"; Code[10])
        {
            TableRelation = "Item Variant".Code;
            Caption = 'Variant Code';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                TestStatusOpen()end;
        }
        field(5404; "Qty. per Unit Of Measure"; Decimal)
        {
            Caption = 'Qty. per Unit Of Measure';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                TestStatusOpen()end;
        }
        field(5407; "Unit Of Measure Code"; Code[10])
        {
            Editable = false;
            TableRelation = "Unit of Measure";
            Caption = 'Unit Of Measure Code';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                TestStatusOpen()end;
        }
        field(5408; "Quantity (Base)"; Decimal)
        {
            DecimalPlaces = 0: 5;
            Caption = 'Quantity (Base)';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                TestStatusOpen()end;
        }
        field(5701; "Item Category Code"; Code[20])
        {
            TableRelation = "Item Category";
            Caption = 'Item Category Code';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                TestStatusOpen()end;
        }
        field(5705; "Product Group Code"; Code[10])
        {
            //SSD TableRelation = "Product Group";
            Caption = 'Product Group Code';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                TestStatusOpen()end;
        }
        field(50001; "Indent Date"; Date)
        {
            Caption = 'Indent Date';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                TestStatusOpen()end;
        }
        field(50002; "Expected Cost"; Decimal)
        {
            Caption = 'Expected Cost';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                TestStatusOpen()end;
        }
        field(50003; "Inventory Main Store"; Decimal)
        {
            DecimalPlaces = 0: 5;
            Caption = 'Inventory Main Store';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                TestStatusOpen()end;
        }
        field(50004; "Capital Item"; Boolean)
        {
            Caption = 'Capital Item';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                TestStatusOpen()end;
        }
        field(50005; "Qty. on Purchase Order"; Decimal)
        {
            CalcFormula = sum("Purchase Line"."Outstanding Qty. (Base)" where("Document Type"=const(Order), Type=const(Item), "No."=field("No.")));
            FieldClass = FlowField;
            Caption = 'Qty. on Purchase Order';
        }
        field(50006; "Qty. on Req. Line"; Decimal)
        {
            CalcFormula = sum("Requisition Line"."Remaining Quantity" where("Worksheet Template Name"=field("Template Name"), "Journal Batch Name"=field("Batch Name"), Type=field(Type), "No."=field("No.")));
            FieldClass = FlowField;
            Caption = 'Qty. on Req. Line';
        }
        field(50007; "No.2"; Code[20])
        {
            CalcFormula = lookup(Item."No. 2" where("No."=field("No.")));
            FieldClass = FlowField;
            Caption = 'No.2';
        }
        field(50008; Inventory; Decimal)
        {
            CalcFormula = sum("Item Ledger Entry".Quantity where("Item No."=field("No.")));
            Description = 'Alle AU';
            FieldClass = FlowField;
            Caption = 'Inventory';
        }
        field(50013; "Template Name"; Code[10])
        {
            TableRelation = "Req. Wksh. Template" where("Page ID"=const(291), Recurring=const(false), Type=const("Req."));
            Caption = 'Template Name';
            DataClassification = CustomerContent;
        }
        field(50014; "Batch Name"; Code[10])
        {
            TableRelation = "Requisition Wksh. Name".Name where("Worksheet Template Name"=field("Template Name"));
            Caption = 'Batch Name';
            DataClassification = CustomerContent;
        }
        field(50022; "Location Code"; Code[10])
        {
            TableRelation = Location.Code;
            Caption = 'Location Code';
            DataClassification = CustomerContent;

            trigger OnValidate()
            var
                IndentHeader: Record "SSD Indent Header2";
            begin
                IndentHeader.Get("Document No.");
                if IndentHeader.Status = IndentHeader.Status::Released then Error('status must be open');
                if "Location Code" = '' then "Issued Qty":=0;
            end;
        }
        field(50023; "Issued Qty"; Decimal)
        {
            Caption = 'Issue Qty.';
            Description = 'Alle AU';
            DataClassification = CustomerContent;

            trigger OnValidate()
            var
                UserSetup: Record "User Setup";
                IndentLine2: Record "SSD Indent Line2";
                TotalissuedQty: Decimal;
            begin
                TestStatusReleased;
                TestField("Location Code");
                UserSetup.Get(UserId);
                UserSetup.TestField("Allow Requisition Issue Qty");
                if Quantity < "Issued Qty" then Error('Issue Quantity cannot be greater then Quantity');
                // IF "Inventory Main Store" < "Issued Qty" THEN//Old
                //  ERROR('Issued Quantity cannot be greater then Inventory');
                if Inventory < "Issued Qty" then //New
 Error('Issued Quantity cannot be greater then Inventory');
                TotalissuedQty:=0;
                IndentLine2.Reset;
                IndentLine2.SetRange("No.", "No.");
                IndentLine2.SetFilter("Issued Qty", '<>%1', 0);
                if IndentLine2.FindSet then repeat TotalissuedQty+=IndentLine2."Issued Qty";
                    until IndentLine2.Next = 0;
                // IF "Issued Qty" > (TotalissuedQty + "Inventory Main Store") THEN
                //  ERROR('Issued Qty. not more than Inventory and total issue slip qty.');
                if "Issued Qty" > (TotalissuedQty + Inventory)then Error('Issued Qty. not more than Inventory and total issue slip qty.');
                "Balance Qty":=Quantity - "Issued Qty";
            end;
        }
        field(50024; "Balance Qty"; Decimal)
        {
            Description = 'Alle AU';
            Caption = 'Balance Qty';
            DataClassification = CustomerContent;
        }
        field(54001; "Shelf No."; Code[20])
        {
            TableRelation = "SSD Item Ledger Entry Buffer";
            Caption = 'Shelf No.';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                TestStatusOpen()end;
        }
        field(54002; "ROL-Maximum Order Quantity"; Decimal)
        {
            CalcFormula = lookup(Item."Maximum Order Quantity" where("No."=field("No.")));
            Description = 'Alle';
            FieldClass = FlowField;
            Caption = 'ROL-Maximum Order Quantity';
        }
        field(54003; "CL-Minimum Order Quantity"; Decimal)
        {
            CalcFormula = lookup(Item."Minimum Order Quantity" where("No."=field("No.")));
            Description = 'Alle';
            FieldClass = FlowField;
            Caption = 'CL-Minimum Order Quantity';
        }
        field(54004; "MSL-Safety Stock Quantity"; Decimal)
        {
            CalcFormula = lookup(Item."Safety Stock Quantity" where("No."=field("No.")));
            Description = 'Alle';
            FieldClass = FlowField;
            Caption = 'MSL-Safety Stock Quantity';
        }
        field(54005; "Indenter ID"; Code[20])
        {
            CalcFormula = lookup("SSD Indent Header"."Indenter ID" where("No."=field("Document No.")));
            Description = 'ALLE';
            FieldClass = FlowField;
            Caption = 'Indenter ID';
        }
        field(54006; "Indent Issued Qty."; Decimal)
        {
            Caption = 'Indent Issued Qty.';
            DataClassification = CustomerContent;
        }
        field(99000882; "Gen.Prod.Posting Group"; Code[20])
        {
            TableRelation = "Gen. Product Posting Group";
            Caption = 'Gen.Prod.Posting Group';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                TestStatusOpen()end;
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
        IndentHeaderLocal: Record "SSD Indent Header2";
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
    begin
        TestStatusOpen;
        //DocDim.LOCKTABLE; // BIS 1145
        LockTable;
    //DimMgt.InsertDocDim(     // BIS 1145
    // DATABASE::"Indent Line",6{"Document Type"},"Document No.","Line No.",// BIS 1145
    //"Shortcut Dimension 1 Code","Shortcut Dimension 2 Code"); // BIS 1145
    end;
    trigger OnRename()
    begin
        Error(Text002, TableCaption);
    end;
    var Item: Record Item;
    ItemUnitMeasure: Record "Item Unit of Measure";
    StandardText: Record "Standard Text";
    Text001: label 'Status must be release for Indent %1';
    DimMgt: Codeunit DimensionManagement;
    IndentHeader: Record "SSD Indent Header2";
    TempIndentLine: Record "SSD Indent Line2" temporary;
    Text002: label 'You cannot rename a %1.';
    IndentPost: Report "Indent Post";
    GLAcc: Record "G/L Account";
    FA: Record "Fixed Asset";
    IndentLine: Record "SSD Indent Line2";
    Item1: Record Item;
    procedure TestStatusOpen()
    var
        IndentHeader: Record "SSD Indent Header2";
    begin
        IndentHeader.Get("Document No.");
        if IndentHeader.Status <> IndentHeader.Status::Open then Error(Text001, "Document No.");
    end;
    procedure TestStatusReleased()
    var
        IndentHeader: Record "SSD Indent Header2";
    begin
        IndentHeader.Get("Document No.");
        if IndentHeader.Status <> IndentHeader.Status::Released then Error(Text001, "Document No.");
    end;
    procedure ValidateShortcutDimCode(FieldNumber: Integer; var ShortcutDimCode: Code[20])
    begin
        DimMgt.ValidateDimValueCode(FieldNumber, ShortcutDimCode);
    /* // BIS 1145 <<
        IF "Line No." <> 0 THEN
          DimMgt.SaveDocDim(
            DATABASE::"Indent Line", 6 {"Document Type"},"Document No.",
            "Line No.",FieldNumber,ShortcutDimCode)
        ELSE
          DimMgt.SaveTempDim(FieldNumber,ShortcutDimCode);
        */
    // BIS 1145 >>
    end;
    procedure CreateDim(Type1: Integer; No1: Code[20]; Type2: Integer; No2: Code[20]; Type3: Integer; No3: Code[20]; Type4: Integer; No4: Code[20])
    var
        SourceCodeSetup: Record "Source Code Setup";
        TableID: array[10]of Integer;
        No: array[10]of Code[20];
    begin
        SourceCodeSetup.Get;
        TableID[1]:=Type1;
        No[1]:=No1;
        TableID[2]:=Type2;
        No[2]:=No2;
        TableID[3]:=Type3;
        No[3]:=No3;
        TableID[4]:=Type4;
        No[4]:=No4;
        "Shortcut Dimension 1 Code":='';
        "Shortcut Dimension 2 Code":='';
    /* // BIS 1145 <<
        DimMgt.GetPreviousDocDefaultDim(
          DATABASE::"Indent Header",6{"Document Type"},"Document No.",0,
          DATABASE::Vendor,"Shortcut Dimension 1 Code","Shortcut Dimension 2 Code");
        DimMgt.GetDefaultDim(
          TableID,No,SourceCodeSetup.Purchases,
          "Shortcut Dimension 1 Code","Shortcut Dimension 2 Code");
        IF "Line No." <> 0 THEN
          DimMgt.UpdateDocDefaultDim(
            DATABASE::"Indent Line",6{"Document Type"},"Document No.","Line No.",
            "Shortcut Dimension 1 Code","Shortcut Dimension 2 Code");
        */
    // BIS 1145 >>
    end;
    local procedure CalcBaseQty(Qty: Decimal): Decimal begin
        TestField("Qty. per Unit Of Measure");
        exit(ROUND(Qty * "Qty. per Unit Of Measure", 0.00001));
    end;
    local procedure GetItem()
    begin
        //Sandeep Singla start
        TestField("No.");
        if "No." <> Item."No." then Item.Get("No.");
    //Sandeep Singla end
    end;
}
