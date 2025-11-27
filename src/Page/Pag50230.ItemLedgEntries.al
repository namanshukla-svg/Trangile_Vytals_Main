Page 50230 "Item Ledg. Entries"
{
    // ALLEAA CML-033 280308
    //   - Added New Form
    // ALLEAA CML-033 180408
    //   Code Added for testing of Scarp Item attached with Subcontracting MRN.
    // ALLEAA CML-033 190408
    //   Update Subcontracting MRN Document
    // ALLEAA CML-033 210408
    //   Flow Subcontracting Boolean True in Journal Line Table.
    InsertAllowed = false;
    PageType = List;
    SourceTable = "SSD Item Ledger Entry Buffer";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Control1000000000)
            {
                field("Parent Document No."; Rec."Parent Document No.")
                {
                    ApplicationArea = All;
                    Caption = 'Subcontracting MRN No.';
                    Editable = false;
                }
                field("External Document No."; Rec."External Document No.")
                {
                    ApplicationArea = All;
                    Caption = 'Delivery Challan No.';
                    Editable = false;
                }
                field("Parent Document Line No."; Rec."Parent Document Line No.")
                {
                    ApplicationArea = All;
                    Caption = 'Pre Assigned Delivery Challan No.';
                    Editable = false;
                    Visible = false;
                }
                field("Party No."; Rec."Party No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Visible = false;
                }
                field("Document No."; Rec."Document No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Prod. BOM No."; Rec."Prod. BOM No.")
                {
                    ApplicationArea = All;
                }
                field("Output Item Code"; Rec."Output Item Code")
                {
                    ApplicationArea = All;
                }
                field("Item No."; Rec."Item No.")
                {
                    ApplicationArea = All;
                    Caption = 'Consumption Item Code';
                    Editable = false;
                }
                field("Entry Type"; Rec."Entry Type")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Visible = false;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    Editable = false;
                    Visible = false;
                }
                field("Unit of Measure Code"; Rec."Unit of Measure Code")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Location Code"; Rec."Location Code")
                {
                    ApplicationArea = All;
                    Caption = 'Consumption Location Code';
                    Editable = false;
                }
                field(Quantity; Rec.Quantity)
                {
                    ApplicationArea = All;
                    Caption = 'Quantity on Vendor Location ';
                    Editable = false;
                }
                field("Remaining Quantity"; Rec."Remaining Quantity")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = All;
                    Editable = true;
                    Visible = false;
                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Visible = false;
                }
                field("OutPut Item Unit Of Measure"; Rec."OutPut Item Unit Of Measure")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Visible = false;
                }
                field("Production BOM Quantity"; Rec."Production BOM Quantity")
                {
                    ApplicationArea = All;
                }
                field("Party Location"; Rec."Party Location")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Template Name"; Rec."Template Name")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Visible = false;
                }
                field("Batch Name"; Rec."Batch Name")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("OutPut Item UOM"; Rec."OutPut Item UOM")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Visible = false;
                }
                field("OutPut Item Quantity"; Rec."OutPut Item Quantity")
                {
                    ApplicationArea = All;
                    Caption = 'Receive Item Quantity';

                    trigger OnValidate()
                    begin
                        OutPutQty:=Rec."OutPut Item Quantity";
                    end;
                }
                field("BOM Quantity"; Rec."BOM Quantity")
                {
                    ApplicationArea = All;
                }
                field("Max. Rec. Qty"; Rec."Max. Rec. Qty")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Entry No."; Rec."Entry No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Visible = false;
                }
            }
        }
    }
    actions
    {
        area(processing)
        {
            action("&Post Consumption")
            {
                ApplicationArea = All;
                Caption = '&Post Consumption';
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                var
                    ItemLedgEntry12: Record "SSD Item Ledger Entry Buffer";
                    ItemLedgEntryILE: Record "SSD Item Ledger Entry Buffer";
                    RgpLine: Record "SSD RGP Line";
                begin
                    RgpLine.Get(RgpLine."document type"::"RGP Inbound", Rec."Parent Document No.", Rec."Parent Document Line No.");
                    if Confirm(Text0001)then begin
                        CheckOutpILEBuffer.SetRange("Parent Document No.", Rec."Parent Document No.");
                        if CheckOutpILEBuffer.FindFirst then begin
                            //CheckOutpILEBuffer.COPY(Rec);
                            ActiveVersionCode:=VersionMgt.GetBOMVersion(RgpLine."No.", WorkDate, true);
                            ProdBOMHead.SetCurrentkey("Source No.");
                            ProdBOMHead.SetRange("Source No.", RgpLine."No.");
                            if ProdBOMHead.Find('-')then begin
                                ProdBOMLine.Reset;
                                ProdBOMLine.SetRange("Production BOM No.", ProdBOMHead."No.");
                                ProdBOMLine.SetRange("Version Code", ActiveVersionCode);
                                if ProdBOMLine.Find('-')then repeat OutputItemQty:=0;
                                        CheckOutpILEBuffer.SetRange("Item No.", ProdBOMLine."No.");
                                        CheckOutpILEBuffer.SetFilter("OutPut Item Quantity", '<>%1', 0);
                                        if CheckOutpILEBuffer.FindFirst then repeat OutputItemQty+=CheckOutpILEBuffer."OutPut Item Quantity";
                                            until CheckOutpILEBuffer.Next = 0;
                                        if OutputItemQty <> RgpLine.Quantity then Error('Please Enter the correct Quantity for all the consumption Items.');
                                    until ProdBOMLine.Next = 0;
                            end;
                        end;
                        //ALLEAA CML-033 240408 Start >>
                        /*
                        //ALLEAA CML-033 180408 Start >>
                        ItemLedgEntry12.COPY(Rec);
                        ItemLedgEntry12.SETFILTER("OutPut Item Quantity",'<>%1',0);
                        IF ItemLedgEntry12.FIND('-') THEN REPEAT
                          IF ItemLedgEntry12."Scrap Generated" <> 0 THEN
                            IF RgpLine.GET(RgpLine."Document Type"::"RGP Inbound","Parent Document No.","Parent Document Line No.") THEN
                              RgpLine.TESTFIELD(RgpLine."Scrap Item");
                        UNTIL ItemLedgEntry12.NEXT = 0;
                        //ALLEAA CML-033 180408 End <<
                        */
                        CreateScrapEntry:=false;
                        if RgpLine.Get(RgpLine."document type"::"RGP Inbound", Rec."Parent Document No.", Rec."Parent Document Line No.")then if RgpLine."Generate Scrap" then begin
                                RgpLine.TestField(RgpLine."Scrap Item");
                                CreateScrapEntry:=true;
                            end;
                        //ALLEAA CML-033 240408 End <<
                        TotalConsumedQty:=0;
                        //TotalValue := 0;
                        ItemLedgEntry12.Copy(Rec);
                        ItemLedgEntry12.SetFilter("OutPut Item Quantity", '<>%1', 0);
                        if ItemLedgEntry12.Find('-')then repeat TotalConsumedQty:=0;
                                //TotalValue := 0;
                                ParentDocNo:=ItemLedgEntry12."Parent Document No.";
                                ParentDocLineNo:=ItemLedgEntry12."Parent Document Line No.";
                                if ParentRGP.Get(ParentRGP."document type"::"RGP Inbound", ParentDocNo)then VendorBillNo:=ParentRGP."External Document No.";
                                //TotalConsumedQty := ItemLedgEntry12."OutPut Item Quantity";
                                ItemLedgEntryILE.Copy(ItemLedgEntry12);
                                ItemLedgEntryILE."Scrap Generated":=RgpLine."Scrap Generated"; // ssd
                                InsertItemJnlLine(ItemLedgEntryILE, ParentDocNo, ParentDocLineNo);
                                //IF ItemLedgEntry12."Scrap Generated" <> 0 THEN //ALLEAA CML-033 240408
                                //  InsertScrapJnlLine(ItemLedgEntry12,ParentDocNo,ParentDocLineNo);//ALLEAA CML-033 240408
                                //    IF PostItemJnlLine(ItemLedgEntry12."BOM Quantity",ItemLedgEntry12."Scrap Generated") THEN //ALLEAA CML-033 250408
                                //      UpdateParentDocument(ItemLedgEntry12,ItemLedgEntry12."OutPut Item Quantity",TotalValue); //ALLEAA CML-033 250408
                                ItemLedgEntry12."OutPut Item Quantity":=0;
                                ItemLedgEntry12."BOM Quantity":=0;
                                ItemLedgEntry12."Scrap Generated":=0;
                                ItemLedgEntry12."Scrap Received":=false;
                                ItemLedgEntry12.Modify;
                            until ItemLedgEntry12.Next = 0;
                        /*//ALLEAA CML-033 230408 Start >>
                        IF CreateScrapEntry THEN BEGIN
                          IF RgpLine.GET(RgpLine."Document Type"::"RGP Inbound","Parent Document No.","Parent Document Line No.") THEN
                            IF RgpLine."Generate Scrap" THEN BEGIN
                              IF RgpLine."Scrap Generated" <> 0 THEN
                                InsertScrapJnlLine(RgpLine,ParentDocNo,ParentDocLineNo);
                            END;
                        END;
                        //ALLEAA CML-033 230408 End <<*/
                        PostItemJnlLineOutput; //(ItemLedgEntry12."BOM Quantity",ItemLedgEntry12."Scrap Generated") THEN //ALLEAA CML-033 250408
                        UpdateParentDocument(ItemLedgEntry12, ItemLedgEntry12."OutPut Item Quantity", TotalValue); //ALLEAA CML-033 250408
                        Message('Posted Successfully');
                    end;
                end;
            }
        }
    }
    var ItemJnlLine: Record "Item Journal Line";
    UnitCost: Decimal;
    TotalValue: Decimal;
    TotalConsumedQty: Decimal;
    LineNo: Integer;
    ScrapItemJnlLine: Record "Item Journal Line";
    ParentDocNo: Code[20];
    ParentDocLineNo: Integer;
    OutPutQty: Decimal;
    CreateScrapEntry: Boolean;
    ProdBOMHead: Record "Production BOM Header";
    ProdBOMLine: Record "Production BOM Line";
    ActiveVersionCode: Code[20];
    VersionMgt: Codeunit VersionManagement;
    CheckOutpILEBuffer: Record "SSD Item Ledger Entry Buffer";
    OutputItemQty: Decimal;
    VendorBillNo: Code[20];
    ParentRGP: Record "SSD RGP Header";
    ConsumedQty: Decimal;
    DimMgt: Codeunit DimensionManagement;
    TempDocDim: Record "Default Dimension";
    Text0001: label 'Do you want post Consumption ?';
    procedure InsertItemJnlLine(ItemLedgEntry: Record "SSD Item Ledger Entry Buffer"; DocNo: Code[20]; DocLineNo: Integer)
    var
        DimItem: Record Item;
    begin
        ItemJnlLine.Reset;
        ItemJnlLine.SetRange("Journal Template Name", 'SUBCON-BOM');
        ItemJnlLine.SetRange("Journal Batch Name", 'SUBCON-BOM');
        if ItemJnlLine.Find('+')then LineNo:=ItemJnlLine."Line No.";
        ItemJnlLine.Init;
        ItemJnlLine."Journal Template Name":='SUBCON-BOM';
        ItemJnlLine."Journal Batch Name":='SUBCON-BOM';
        LineNo+=10000;
        ItemJnlLine.Validate("Line No.", LineNo);
        ItemJnlLine.Validate("Posting Date", WorkDate);
        ItemJnlLine.Validate("Entry Type", ItemJnlLine."entry type"::"Negative Adjmt.");
        ItemJnlLine.Validate("Item No.", ItemLedgEntry."Item No.");
        // VALIDATE("Source Type",ItemJnlLine."Source Type"::Vendor);
        // VALIDATE("Source No.",ItemLedgEntry."Party No.");
        ItemJnlLine.Validate("Document No.", ItemLedgEntry."Parent Document No.");
        ItemJnlLine.Validate("Location Code", ItemLedgEntry."Location Code");
        ItemJnlLine.Validate("Bin Code", ItemLedgEntry."Bin Code");
        //ALLEAA CML-033 230408 Start >>
        ItemJnlLine.Validate(Quantity, ItemLedgEntry."Production BOM Quantity" * ItemLedgEntry."OutPut Item Quantity" + ItemLedgEntry."Scrap Generated");
        //ALLEAA CML-033 230408 End <<
        //ALLEAA CML-033 250408 Start >>
        if ItemLedgEntry.Quantity <> 0 then ItemJnlLine.Validate(ItemJnlLine."Unit Amount", ItemLedgEntry."Cost Amount" / ItemLedgEntry.Quantity);
        //ALLEAA CML-033 250408 End <<
        ItemJnlLine.Validate("OutPut Item Unit Of Measure", ItemLedgEntry."OutPut Item Unit Of Measure");
        ItemJnlLine.Validate("Output Item Code", ItemLedgEntry."Output Item Code");
        ItemJnlLine.Validate("BOM Quantity", ItemLedgEntry."BOM Quantity");
        ItemJnlLine.Validate("Scrap Generated", ItemLedgEntry."Scrap Generated");
        ItemJnlLine.Validate("Prod. BOM No.", ItemLedgEntry."Prod. BOM No.");
        ItemJnlLine.Validate("Production BOM Quantity", ItemLedgEntry."Production BOM Quantity");
        ItemJnlLine.Validate("Parent Document No.", ItemLedgEntry."Parent Document No.");
        ItemJnlLine.Validate("Party No.", ItemLedgEntry."Party No.");
        ItemJnlLine.Validate("Party Location", ItemLedgEntry."Party Location");
        ItemJnlLine.Validate("OutPut Item UOM", ItemJnlLine."OutPut Item UOM");
        ItemJnlLine.Validate("OutPut Item Quantity", ItemLedgEntry."OutPut Item Quantity");
        ItemJnlLine.Validate("Applies-to Entry", ItemLedgEntry."Entry No.");
        DimItem.Get(ItemJnlLine."Item No.");
        ItemJnlLine.Validate("Shortcut Dimension 1 Code", DimItem."Global Dimension 1 Code");
        ItemJnlLine.Validate("Shortcut Dimension 2 Code", DimItem."Global Dimension 2 Code");
        ItemJnlLine."Shortcut Dimension 1 Code":=DimItem."Global Dimension 1 Code";
        ItemJnlLine."Shortcut Dimension 2 Code":=DimItem."Global Dimension 2 Code";
        ItemJnlLine."SUBCON Consumption":=true; //ALLEAA CML-033 210408
        ItemJnlLine."External Document No.":=VendorBillNo; //ALLEAA CML-033 230408
        //TotalConsumedQty += ItemLedgEntry."OutPut Item Quantity";
        TotalValue:=TotalValue + Abs(ItemJnlLine.Amount);
        ItemJnlLine.Insert;
    //TotalValue += TotalValue; //ALLEAA CML-033 250408
    //ConsumedQty := ConsumedQty + ItemJnlLine.Quantity ; //ALLEAA CML-033 250408
    end;
    procedure UpdateParentDocument(ILE: Record "SSD Item Ledger Entry Buffer"; Qty: Decimal; Value: Decimal)
    var
        RGPLine: Record "SSD RGP Line";
    begin
        if RGPLine.Get(RGPLine."document type"::"RGP Inbound", ILE."Parent Document No.", ILE."Parent Document Line No.")then begin
            //    RGPLine.Amount += Value;
            RGPLine."Qty. Consumed"+=Qty;
            RGPLine."Unit Cost":=Value / OutputItemQty; //ALLEAA CML-033 250408
            //RGPLine."Scrap Generated" += ILE."Scrap Generated"; //ALLEAA CML-033 230408
            //RGPLine."Unit Cost" := RGPLine.Amount/RGPLine."Qty. Consumed";
            //    IF ConsumedQty <> 0 THEN
            RGPLine.Amount:=Value; //ALLEAA CML-033 250408
            //RGPLine."Output Qty." := RGPLine."Output Qty." + ILE."OutPut Item Quantity"; //ALLEAA SUBMEN 190408
            RGPLine."Output Qty.":=OutputItemQty;
            RGPLine.Modify;
        end;
        DeleteJnlLine;
    end;
    procedure PostItemJnlLine(BOMQty: Decimal; ScrapQty: Decimal): Boolean var
        ItemJnlPost: Codeunit "Item Jnl.-Post Line";
    begin
        if BOMQty <> 0 then Codeunit.Run(Codeunit::"Item Jnl.-Post", ItemJnlLine);
        if ScrapQty <> 0 then Codeunit.Run(Codeunit::"Item Jnl.-Post", ScrapItemJnlLine);
        Clear(ItemJnlLine);
        Clear(ScrapItemJnlLine);
        //ItemJnlPost.RUN(ItemJnlLine);
        //ItemJnlPost.RUN(ScrapItemJnlLine);
        exit(true);
    end;
    procedure InsertScrapJnlLine(ParentRGPLine: Record "SSD RGP Line"; DocNo: Code[20]; DocLineNo: Integer)
    var
        RGPLine: Record "SSD RGP Line";
    begin
        ScrapItemJnlLine.Init;
        ScrapItemJnlLine."Journal Template Name":='SUBCON-BOM';
        ScrapItemJnlLine."Journal Batch Name":='SUBCON-BOM';
        LineNo+=10000;
        ScrapItemJnlLine.Validate("Line No.", LineNo);
        ScrapItemJnlLine.Validate("Posting Date", WorkDate);
        RGPLine.Get(RGPLine."document type"::"RGP Inbound", DocNo, DocLineNo);
        ScrapItemJnlLine.Validate("Item No.", RGPLine."Scrap Item");
        ScrapItemJnlLine.Validate("Entry Type", ScrapItemJnlLine."entry type"::"Positive Adjmt.");
        ScrapItemJnlLine.Validate("Source Type", ScrapItemJnlLine."source type"::Vendor);
        ScrapItemJnlLine.Validate("Source No.", ParentRGPLine."Party No.");
        ScrapItemJnlLine.Validate("Document No.", ParentRGPLine."Document No.");
        //ALLEAA CML-033 230408 Start >>
        /*
        IF ItemLedgEntry."Scrap Received" THEN BEGIN
        //  ScrapItemJnlLine.VALIDATE("Location Code",RGPLine."Location Code");
          ScrapItemJnlLine."Location Code" := RGPLine."Location Code";
          ScrapItemJnlLine.VALIDATE("Bin Code",RGPLine."Bin Code");
        END ELSE BEGIN
            ScrapItemJnlLine.VALIDATE("Location Code",ItemLedgEntry."Location Code");
            ScrapItemJnlLine.VALIDATE("Bin Code",ItemLedgEntry."Bin Code");
        END;
        ScrapItemJnlLine.VALIDATE(Quantity,ItemLedgEntry."Scrap Generated");
        ScrapItemJnlLine.VALIDATE("Shortcut Dimension 1 Code",ItemLedgEntry."Global Dimension 1 Code");
        ScrapItemJnlLine.VALIDATE("Shortcut Dimension 2 Code",ItemLedgEntry."Global Dimension 2 Code");
        ScrapItemJnlLine.VALIDATE("OutPut Item Unit Of Measure",ItemLedgEntry."OutPut Item Unit Of Measure");
        ScrapItemJnlLine.VALIDATE("Output Item Code",ItemLedgEntry."Output Item Code");
        ScrapItemJnlLine.VALIDATE("BOM Quantity",ItemLedgEntry."BOM Quantity");
        ScrapItemJnlLine.VALIDATE("Scrap Generated",ItemLedgEntry."Scrap Generated");
        ScrapItemJnlLine.VALIDATE("Prod. BOM No.",ItemLedgEntry."Prod. BOM No.");
        ScrapItemJnlLine.VALIDATE("Production BOM Quantity",ItemLedgEntry."OutPut Item Unit Of Measure");
        ScrapItemJnlLine.VALIDATE("Parent Document No.",ItemLedgEntry."Parent Document No.");
        ScrapItemJnlLine.VALIDATE("Party No.",ItemLedgEntry."Party No.");
        ScrapItemJnlLine.VALIDATE("Party Location",ItemLedgEntry."Party Location");
        ScrapItemJnlLine.VALIDATE("OutPut Item UOM",ItemLedgEntry."OutPut Item UOM");
        ScrapItemJnlLine.VALIDATE("OutPut Item Quantity",ItemLedgEntry."OutPut Item Quantity");
        */
        ScrapItemJnlLine.Validate("Location Code", ParentRGPLine."Location Code");
        ScrapItemJnlLine.Validate("Bin Code", ParentRGPLine."Bin Code");
        ScrapItemJnlLine.Validate(Quantity, ParentRGPLine."Scrap Generated");
        ScrapItemJnlLine.Validate("Shortcut Dimension 1 Code", ParentRGPLine."Shortcut Dimension 1 Code");
        ScrapItemJnlLine.Validate("Shortcut Dimension 2 Code", ParentRGPLine."Shortcut Dimension 2 Code");
        ScrapItemJnlLine.Validate("OutPut Item Unit Of Measure", ParentRGPLine."Qty. per Unit of Measure");
        ScrapItemJnlLine.Validate("Output Item Code", ParentRGPLine."No.");
        ScrapItemJnlLine.Validate("BOM Quantity", ParentRGPLine.Quantity);
        ScrapItemJnlLine.Validate("Scrap Generated", ParentRGPLine."Scrap Generated");
        //ScrapItemJnlLine.VALIDATE("Prod. BOM No.",ParentRGPLine."Prod. BOM No.");
        //ScrapItemJnlLine.VALIDATE("Production BOM Quantity",ParentRGPLine."OutPut Item Unit Of Measure");
        ScrapItemJnlLine.Validate("Parent Document No.", ParentRGPLine."Document No.");
        ScrapItemJnlLine.Validate("Party No.", ParentRGPLine."Party No.");
        ScrapItemJnlLine.Validate("Party Location", ParentRGPLine."Location Code");
        ScrapItemJnlLine.Validate("OutPut Item UOM", ParentRGPLine."Unit Of Measure Code");
        ScrapItemJnlLine.Validate("OutPut Item Quantity", ParentRGPLine.Quantity);
        ScrapItemJnlLine."External Document No.":=VendorBillNo; //ALLEAA CML-033 230408
        //ALLEAA CML-033 230408 End <<
        //ScrapItemJnlLineVALIDATE("Applies-to Entry" ,ItemLedgEntry."Entry No.");
        //ScrapItemJnlLine.VALIDATE("Unit Cost",0);
        ScrapItemJnlLine."SUBCON Consumption":=true; //ALLEAA CML-033 210408
        ScrapItemJnlLine."Journal Template Name":='SUBCON-BOM';
        ScrapItemJnlLine."Journal Batch Name":='SUBCON-BOM';
        ScrapItemJnlLine.Insert;
    end;
    procedure CheckOutputQuantity(ItemLedgEntry3: Record "SSD Item Ledger Entry Buffer"; DocNo: Code[20]; DocLineNo: Integer)
    var
        ItemLedgEntry1: Record "SSD Item Ledger Entry Buffer";
        RGPLine: Record "SSD RGP Line";
        CompQty: Decimal;
    begin
        ItemLedgEntry3.SetFilter("Remaining Quantity", '>%1', 0);
        if ItemLedgEntry3.Find('-')then repeat CompQty+=ItemLedgEntry3."OutPut Item Quantity";
            until ItemLedgEntry3.Next = 0;
        RGPLine.Get(RGPLine."document type"::"RGP Inbound", ItemLedgEntry3."Output Item Code", ItemLedgEntry3."Party Location");
        if(RGPLine.Quantity - RGPLine."Qty. Consumed") <> (CompQty)then Error('Enter total Component Quantity. i.e. %1', RGPLine.Quantity - RGPLine."Qty. Consumed");
    end;
    procedure DeleteJnlLine()
    begin
        ItemJnlLine.DeleteAll;
        ScrapItemJnlLine.DeleteAll;
    end;
    procedure PostItemJnlLineOutput()
    var
        ItemJnlPost: Codeunit "Item Jnl.-Post Line";
    begin
        Codeunit.Run(Codeunit::"Item Jnl.-Post", ItemJnlLine);
        Clear(ItemJnlLine);
        Clear(ScrapItemJnlLine);
    //ItemJnlPost.RUN(ItemJnlLine);
    //ItemJnlPost.RUN(ScrapItemJnlLine);
    end;
}
