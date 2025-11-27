PageExtension 50047 "SSD Item Tracking Lines" extends "Item Tracking Lines"
{
    layout
    {
        addafter("Serial No.")
        {
            field("Qty. per Unit of Measure"; Rec."Qty. per Unit of Measure")
            {
                ApplicationArea = All;
            }
        }
        modify("New Lot No.")
        {
            Visible = true;
        }
        modify("New Expiration Date")
        {
            Visible = true;
        }
        moveafter("Qty. per Unit of Measure"; "New Expiration Date")
        moveafter("New Expiration Date"; "New Lot No.")
        addafter("Lot No.")
        {
            //IG_DS>>
            field("From Package"; Rec."From Package")
            {
                ApplicationArea = all;
                Visible = false;
                trigger OnAssistEdit()
                var
                    PackageRec: Record "Package Tracking";
                    IsHandled: Boolean;
                begin
                    IsHandled := false;
                    // Optional: Custom assist edit logic
                    if not IsHandled then begin
                        PackageRec.Reset();
                        PackageRec.SetRange("Lot No.", Rec."Lot No.");
                        PackageRec.SetRange(Utilized, false);
                        PackageRec.SetFilter(Quantity, '>%1', 0);
                        PackageRec.SetFilter("User ID", '%1|%2', UserId, '');
                        if Page.RunModal(Page::"Package Tracking", PackageRec) = Action::LookupOK then
                            Rec."From Package" := PackageRec."Package No.";
                    end;
                end;

            }
            field("To Package"; Rec."To Package")
            {
                ApplicationArea = all;
                Visible = false;
                trigger OnAssistEdit()
                var
                    PackageRec: Record "Package Tracking";
                    IsHandled: Boolean;
                begin
                    IsHandled := false;
                    // Optional: Custom assist edit logic
                    if not IsHandled then begin
                        PackageRec.Reset();
                        PackageRec.SetRange("Lot No.", Rec."Lot No.");
                        PackageRec.SetRange(Utilized, false);
                        PackageRec.SetFilter(Quantity, '>%1', 0);
                        PackageRec.SetFilter("User ID", '%1|%2', UserId, '');
                        if Page.RunModal(Page::"Package Tracking", PackageRec) = Action::LookupOK then
                            Rec."To Package" := PackageRec."Package No.";
                    end;
                end;
            }
            //IG_DS<<
            field("Pack Quantity"; Rec."Pack Quantity")
            {
                ApplicationArea = All;
            }
            field("No. of Container"; Rec."No. of Container")
            {
                ApplicationArea = All;
            }
            field("Rejected Qty."; Rec."Rejected Qty.")
            {
                ApplicationArea = All;
            }
        }
        addafter("Appl.-from Item Entry")
        {
            field("MRN No."; Rec."MRN No.")
            {
                ApplicationArea = All;
            }
            field("MRN Line No."; Rec."MRN Line No.")
            {
                ApplicationArea = All;
            }
        }
        modify("Appl.-from Item Entry")
        {
            Visible = true;
        }
    }
    actions
    {
        addafter("Line_LotNoInfoCard")
        {
            action("Generate Line No. for Sales Dispatch Slip")
            {
                ApplicationArea = All;
                Caption = 'Generate Line No. for Sales Dispatch Slip';

                trigger OnAction()
                begin
                    //<<<<< ALLE[5.51]
                    Rec."MRN Line No." := Rec."Entry No." * 10000;
                    CurrPage.SaveRecord;
                    Message('Generated Successfully');
                    //>>>>> ALLE[5.51]
                end;
            }
            action("New Expiry Date")
            {
                ApplicationArea = All;
                Caption = 'New Expiry Date';

                trigger OnAction()
                begin
                    Rec."New Expiration Date" := Rec."Expiration Date";
                    CurrPage.SaveRecord;
                end;
            }
        }
        addafter("Refresh Availability")
        {
            action("Assign copied Lot No.")
            {
                ApplicationArea = All;
                Caption = 'Assign copied Lot No.';
                Image = Lot;

                trigger OnAction()
                begin
                    TempItemTrackLineInsert.TransferFields(Rec);
                    TempItemTrackLineInsert.Insert;
                    //SSDU Start
                    // ItemTrackingDataCollection.UpdateLotSNDataSetWithChange(
                    // TempItemTrackLineInsert, CurrentSignFactor * SourceQuantityArray[1] < 0, CurrentSignFactor, 0);
                    //SSDU End
                    CalculateSums;
                end;
            }
            action("Assign Package No")
            {
                ApplicationArea = All;
                Caption = 'Assign Package No';
                Image = Lot;
                Visible = false;
                trigger OnAction()
                var
                    PackageTracking: Record "Package Tracking";
                    PackageTrackingOld: Record "Package Tracking";
                    PackageTrackingNew: Record "Package Tracking";
                    Item: Record Item;
                    PackSize: Decimal;
                    PackSizeA: Decimal;
                    PackSizeB: Decimal;
                    i: Integer;
                    PackSizeText: Text;
                    DotPos: Integer;
                    BeforeDecimalStr: Text;
                    AfterDecimalStr: Text;
                    LastLineQty: Decimal;
                    EntryNo: Integer;
                    InventorySetup: Record "Inventory Setup";
                    //IG_DS  NoSeriesManagement: Codeunit NoSeriesManagement;
                    NoSeries: Record "No. Series";
                begin
                    Rec.TestField("Quantity (Base)");

                    if (Rec."Source Type" = 83) and (Rec."Source Subtype" = Rec."Source Subtype"::"2") then
                        InsertPackageNoFromItemJournal();
                    if (Rec."Source Type" = 5406) and (Rec."Source Subtype" = Rec."Source Subtype"::"3") then
                        InsertPackageNoFromRPO();
                    if (Rec."Source Type" = 39) and (Rec."Source Subtype" = Rec."Source Subtype"::"1") then
                        InsertPackageNoFromWarehouseRcpt();

                end;
            }
            action("Track Package")
            {
                ApplicationArea = all;
                Image = ViewPage;
                Visible = false;
                trigger OnAction()
                var
                    PackageTracking: Record "Package Tracking";
                begin
                    PackageTracking.RESET;
                    PackageTracking.SETRANGE("Lot No.", Rec."Lot No.");
                    IF PackageTracking.FINDFIRST THEN
                        PAGE.RUN(Page::"Package Tracking", PackageTracking);
                end;
            }
        }
    }
    var
        ItemLedgerEntry: Record "Item Ledger Entry";
        WarRLineRec: Record "Warehouse Receipt Line";
        PostedQualityOrder1: Record "SSD Posted Quality Order Hdr";
        QualityOrderHeader1: Record "SSD Quality Order Header";
        P: page "Item Tracking Lines";

    var
        ReservationEntry: Record "Reservation Entry";
        GAcceptedQty: Decimal;
        RejectQtyArray: array[3] of Decimal;
        GRejectedQty: Decimal;
        RejQtyIsValid: Boolean;
        GSample: Boolean;
        GSampleQty: Decimal;
        GFreeSample: Boolean;
        GMRNNo: Code[20];
        GNoOfContainer: Integer;
        GPackQty: Decimal;
        GManufacturingDate: Date;
        GSamplingDate: Date;
        GSampledBy: Code[20];
        GMRNLineNo: Integer;
        GUNUSED1: Code[1];
        GUNUSED2: Code[1];
        GUNUSED3: Code[1];
        GUNUSED4: Code[1];
        GUNUSED5: Code[1];
        CrossReferenceNo: Code[20];
        Text021: label 'There are availability warnings on one or more lines.\Change the Lot or Quantity (Base)';
        Text022: label 'Available Quantity is %1';
        Text023: label 'You cannot modify the Lot ';
        ChangeType2: Boolean;
        TransLine: Record "Transfer Line";
        SalesLine: Record "Sales Line";
        InsertTrue: Boolean;
        ModifyTrue: Boolean;
        NoOfPack: Decimal;
        Item2: Record Item;
        SkipSplit: Boolean;

    var
        ColorOfQuantityArray: array[3] of Integer;

    var
        ItemPhyBinDetails: Record "SSD Item Phy. Bin Details";

    local procedure InsertPackageNoFromWarehouseRcpt()
    var
        PackageTracking: Record "Package Tracking";
        PackageTrackingOld: Record "Package Tracking";
        PackageTrackingNew: Record "Package Tracking";
        Item: Record Item;
        PackSize: Decimal;
        PackSizeA: Decimal;
        PackSizeB: Decimal;
        i: Integer;
        PackSizeText: Text;
        DotPos: Integer;
        BeforeDecimalStr: Text;
        AfterDecimalStr: Text;
        LastLineQty: Decimal;
        EntryNo: Integer;
        InventorySetup: Record "Inventory Setup";
        NoSeriesManagement: Codeunit "No. Series";//IG_DS NoSeriesManagement;
        NoSeries: Record "No. Series";
        WarehouseRcptLine: Record "Warehouse Receipt Line";
    begin
        if Confirm('Do you want to generate package no.') then begin
            if (Rec."Source Type" = 39) and (Rec."Source Subtype" = Rec."Source Subtype"::"1") then begin
                Clear(PackSize);
                Clear(PackSizeA);
                Clear(PackSizeB);
                Clear(LastLineQty);

                PackageTrackingOld.Reset();
                //PackageTrackingOld.SetRange("Source ID", Rec."Source ID");
                PackageTrackingOld.SetRange("Lot No.", Rec."Lot No.");
                if PackageTrackingOld.FindFirst() then
                    Error('Already generated');

                if Item.Get(Rec."Item No.") then;
                PackSize := Rec."Quantity (Base)" / Item."Pack Size";

                // For qty split >>>
                PackSizeText := Format(PackSize); // Convert to text
                DotPos := StrPos(PackSizeText, '.'); // Or ',' if using comma as decimal separator
                if DotPos = 0 then begin
                    BeforeDecimalStr := PackSizeText;
                    AfterDecimalStr := '0';
                end else begin
                    BeforeDecimalStr := CopyStr(PackSizeText, 1, DotPos - 1);
                    AfterDecimalStr := CopyStr(PackSizeText, DotPos + 1, StrLen(PackSizeText) - DotPos);
                end;

                if BeforeDecimalStr <> '' then
                    Evaluate(PackSizeA, BeforeDecimalStr);
                // if AfterDecimalStr <> '' then
                //     Evaluate(PackSizeB, AfterDecimalStr);
                // For qty split <<<

                EntryNo := 0;

                if PackSizeA <> 0 then begin
                    for i := 1 to PackSizeA do begin
                        PackageTracking.Init();
                        PackageTrackingOld.Reset();
                        PackageTrackingOld.SetCurrentKey("Entry No.");
                        if PackageTrackingOld.FindLast() then
                            EntryNo := PackageTrackingOld."Entry No." + 1
                        else
                            EntryNo := 1;
                        PackageTracking."Entry No." := EntryNo;
                        PackageTracking."Entry Type" := PackageTracking."Entry Type"::Purchase;
                        PackageTracking."Source ID" := Rec."Source ID";
                        // Get document no.
                        WarehouseRcptLine.Reset();
                        WarehouseRcptLine.SetRange("Source Type", 39);
                        WarehouseRcptLine.SetRange("Source No.", Rec."Source ID");
                        WarehouseRcptLine.SetRange("Item No.", Rec."Item No.");
                        WarehouseRcptLine.SetRange("Line No.", Rec."Source Ref. No.");
                        WarehouseRcptLine.SetRange("Location Code", Rec."Location Code");
                        if WarehouseRcptLine.FindFirst() then
                            PackageTracking."Document No." := WarehouseRcptLine."No.";

                        PackageTracking."Source Subtype" := Rec."Source Subtype";
                        PackageTracking."Source Type" := Rec."Source Type";
                        PackageTracking."Source Ref. No." := Rec."Source Ref. No.";
                        PackageTracking."Expiration Date" := Rec."Expiration Date";
                        // PackageTracking."Gross Weight" := Rec."SSD Gross Weight";
                        PackageTracking."Item No." := Rec."Item No.";
                        PackageTracking."Lot No." := Rec."Lot No.";
                        PackageTracking."Location Code" := Rec."Location Code";
                        PackageTracking."Pack Quantity" := Item."Pack Size";// Rec."Pack Quantity";
                        InventorySetup.Get;
                        InventorySetup.TestField("Package Nos.");
                        //IG_DS_Before  NoSeriesManagement.InitSeries(InventorySetup."Package Nos.", '', 0D, PackageTracking."Package No.", NoSeries.Code);
                        if NoSeriesManagement.AreRelated(InventorySetup."Package Nos.", '') then
                            // NoSeries.Code := xRec."No. Series";
                            PackageTracking."Package No." := NoSeriesManagement.GetNextNo(NoSeries.Code);
                        PackageTracking."Posting Date" := Today;
                        PackageTracking.Quantity := Item."Pack Size";
                        PackageTracking.Insert();
                    end;
                end;
                if AfterDecimalStr <> '' then begin
                    PackageTracking.Init();
                    PackageTrackingOld.Reset();
                    PackageTrackingOld.SetCurrentKey("Entry No.");
                    if PackageTrackingOld.FindLast() then
                        EntryNo := PackageTrackingOld."Entry No." + 1
                    else
                        EntryNo := 1;
                    PackageTracking."Entry No." := EntryNo;
                    PackageTracking."Entry Type" := PackageTracking."Entry Type"::Purchase;
                    PackageTracking."Source ID" := Rec."Source ID";
                    // Get document no.
                    WarehouseRcptLine.Reset();
                    WarehouseRcptLine.SetRange("Source Type", 39);
                    WarehouseRcptLine.SetRange("Source No.", Rec."Source ID");
                    WarehouseRcptLine.SetRange("Item No.", Rec."Item No.");
                    WarehouseRcptLine.SetRange("Line No.", Rec."Source Ref. No.");
                    WarehouseRcptLine.SetRange("Location Code", Rec."Location Code");
                    if WarehouseRcptLine.FindFirst() then
                        PackageTracking."Document No." := WarehouseRcptLine."No.";

                    PackageTracking."Source Subtype" := Rec."Source Subtype";
                    PackageTracking."Source Type" := Rec."Source Type";
                    PackageTracking."Source Ref. No." := Rec."Source Ref. No.";
                    PackageTracking."Expiration Date" := Rec."Expiration Date";
                    // PackageTracking."Gross Weight" := Rec."SSD Gross Weight";
                    PackageTracking."Item No." := Rec."Item No.";
                    PackageTracking."Lot No." := Rec."Lot No.";
                    PackageTracking."Location Code" := Rec."Location Code";
                    PackageTracking."Pack Quantity" := Item."Pack Size";// Rec."Pack Quantity";
                    InventorySetup.Get;
                    InventorySetup.TestField("Package Nos.");
                    //IG_DS_Before  NoSeriesManagement.InitSeries(InventorySetup."Package Nos.", '', 0D, PackageTracking."Package No.", NoSeries.Code);
                    if NoSeriesManagement.AreRelated(InventorySetup."Package Nos.", '') then
                        // NoSeries.Code := xRec."No. Series";
                        PackageTracking."Package No." := NoSeriesManagement.GetNextNo(NoSeries.Code);

                    PackageTracking."Posting Date" := Today;
                    LastLineQty := PackSizeA * Item."Pack Size";
                    PackageTracking.Quantity := Rec."Quantity (Base)" - LastLineQty;
                    PackageTracking.Insert();
                end;
                PackageTrackingNew.Reset();
                PackageTrackingNew.SetCurrentKey("Entry No.");
                PackageTrackingNew.SetRange("Source ID", Rec."Source ID");
                if PackageTrackingNew.FindFirst() then
                    Rec."Package No." := PackageTrackingNew."Package No.";
            end;
        end;
    end;

    local procedure InsertPackageNoFromItemJournal()
    var
        PackageTracking: Record "Package Tracking";
        PackageTrackingOld: Record "Package Tracking";
        PackageTrackingNew: Record "Package Tracking";
        Item: Record Item;
        PackSize: Decimal;
        PackSizeA: Decimal;
        PackSizeB: Decimal;
        i: Integer;
        PackSizeText: Text;
        DotPos: Integer;
        BeforeDecimalStr: Text;
        AfterDecimalStr: Text;
        LastLineQty: Decimal;
        EntryNo: Integer;
        InventorySetup: Record "Inventory Setup";
        NoSeriesManagement: Codeunit "No. Series";//IG_DS NoSeriesManagement;
        NoSeries: Record "No. Series";
        ItemJnlLine: Record 83;
    begin
        if Confirm('Do you want to generate package no.') then begin
            if (Rec."Source Type" = 83) and (Rec."Source Subtype" = Rec."Source Subtype"::"2") then begin
                Clear(PackSize);
                Clear(PackSizeA);
                Clear(PackSizeB);
                Clear(LastLineQty);

                PackageTrackingOld.Reset();
                //  PackageTrackingOld.SetRange("Source ID", Rec."Source ID");
                PackageTrackingOld.SetRange("Lot No.", Rec."Lot No.");
                if PackageTrackingOld.FindFirst() then
                    Error('Already generated');

                if Item.Get(Rec."Item No.") then;
                PackSize := Rec."Quantity (Base)" / Item."Pack Size";

                // For qty split >>>
                PackSizeText := Format(PackSize); // Convert to text
                DotPos := StrPos(PackSizeText, '.'); // Or ',' if using comma as decimal separator
                if DotPos = 0 then begin
                    BeforeDecimalStr := PackSizeText;
                    AfterDecimalStr := '0';
                end else begin
                    BeforeDecimalStr := CopyStr(PackSizeText, 1, DotPos - 1);
                    AfterDecimalStr := CopyStr(PackSizeText, DotPos + 1, StrLen(PackSizeText) - DotPos);
                end;

                if BeforeDecimalStr <> '' then
                    Evaluate(PackSizeA, BeforeDecimalStr);
                // if AfterDecimalStr <> '' then
                //     Evaluate(PackSizeB, AfterDecimalStr);
                // For qty split <<<

                EntryNo := 0;

                if PackSizeA <> 0 then begin
                    for i := 1 to PackSizeA do begin
                        PackageTracking.Init();
                        PackageTrackingOld.Reset();
                        PackageTrackingOld.SetCurrentKey("Entry No.");
                        if PackageTrackingOld.FindLast() then
                            EntryNo := PackageTrackingOld."Entry No." + 1
                        else
                            EntryNo := 1;
                        PackageTracking."Entry No." := EntryNo;
                        PackageTracking."Entry Type" := PackageTracking."Entry Type"::"Positive Adjmt.";
                        // Get document no.
                        // Get document no.
                        ItemJnlLine.Reset();
                        ItemJnlLine.SetFilter("Journal Template Name", '%1', 'ISSUE');
                        ItemJnlLine.SetRange("Item No.", Rec."Item No.");
                        ItemJnlLine.SetRange("Line No.", Rec."Source Ref. No.");
                        ItemJnlLine.SetRange("Location Code", Rec."Location Code");
                        if ItemJnlLine.FindFirst() then
                            PackageTracking."Document No." := ItemJnlLine."Document No.";

                        PackageTracking."Source ID" := Rec."Source ID";
                        PackageTracking."Source Subtype" := Rec."Source Subtype";
                        PackageTracking."Source Type" := Rec."Source Type";
                        PackageTracking."Source Ref. No." := Rec."Source Ref. No.";
                        PackageTracking."Expiration Date" := Rec."Expiration Date";
                        // PackageTracking."Gross Weight" := Rec."SSD Gross Weight";
                        PackageTracking."Item No." := Rec."Item No.";
                        PackageTracking."Lot No." := Rec."Lot No.";
                        PackageTracking."Location Code" := Rec."Location Code";
                        PackageTracking."Pack Quantity" := Item."Pack Size";// Rec."Pack Quantity";
                        InventorySetup.Get;
                        InventorySetup.TestField("Package Nos.");
                        //IG_DS_Before  NoSeriesManagement.InitSeries(InventorySetup."Package Nos.", '', 0D, PackageTracking."Package No.", NoSeries.Code);
                        if NoSeriesManagement.AreRelated(InventorySetup."Package Nos.", '') then
                            // NoSeries.Code := xRec."No. Series";
                            PackageTracking."Package No." := NoSeriesManagement.GetNextNo(NoSeries.Code);
                        PackageTracking."Posting Date" := Today;
                        PackageTracking.Quantity := Item."Pack Size";
                        PackageTracking.Insert();
                    end;
                end;
                if AfterDecimalStr <> '' then begin
                    PackageTracking.Init();
                    PackageTrackingOld.Reset();
                    PackageTrackingOld.SetCurrentKey("Entry No.");
                    if PackageTrackingOld.FindLast() then
                        EntryNo := PackageTrackingOld."Entry No." + 1
                    else
                        EntryNo := 1;
                    PackageTracking."Entry No." := EntryNo;
                    PackageTracking."Entry Type" := PackageTracking."Entry Type"::"Positive Adjmt.";
                    // Get document no.
                    ItemJnlLine.Reset();
                    ItemJnlLine.SetFilter("Journal Template Name", '%1', 'ISSUE');
                    ItemJnlLine.SetRange("Item No.", Rec."Item No.");
                    ItemJnlLine.SetRange("Line No.", Rec."Source Ref. No.");
                    ItemJnlLine.SetRange("Location Code", Rec."Location Code");
                    if ItemJnlLine.FindFirst() then
                        PackageTracking."Document No." := ItemJnlLine."Document No.";

                    PackageTracking."Source ID" := Rec."Source ID";
                    PackageTracking."Source Subtype" := Rec."Source Subtype";
                    PackageTracking."Source Type" := Rec."Source Type";
                    PackageTracking."Source Ref. No." := Rec."Source Ref. No.";
                    PackageTracking."Expiration Date" := Rec."Expiration Date";
                    // PackageTracking."Gross Weight" := Rec."SSD Gross Weight";
                    PackageTracking."Item No." := Rec."Item No.";
                    PackageTracking."Lot No." := Rec."Lot No.";
                    PackageTracking."Location Code" := Rec."Location Code";
                    PackageTracking."Pack Quantity" := Item."Pack Size";// Rec."Pack Quantity";
                    InventorySetup.Get;
                    InventorySetup.TestField("Package Nos.");
                    //IG_DS_Before  NoSeriesManagement.InitSeries(InventorySetup."Package Nos.", '', 0D, PackageTracking."Package No.", NoSeries.Code);
                    if NoSeriesManagement.AreRelated(InventorySetup."Package Nos.", '') then
                        // NoSeries.Code := xRec."No. Series";
                        PackageTracking."Package No." := NoSeriesManagement.GetNextNo(NoSeries.Code);
                    PackageTracking."Posting Date" := Today;
                    LastLineQty := PackSizeA * Item."Pack Size";
                    PackageTracking.Quantity := Rec."Quantity (Base)" - LastLineQty;
                    PackageTracking.Insert();
                end;
                PackageTrackingNew.Reset();
                PackageTrackingNew.SetCurrentKey("Entry No.");
                PackageTrackingNew.SetRange("Source ID", Rec."Source ID");
                if PackageTrackingNew.FindFirst() then
                    Rec."Package No." := PackageTrackingNew."Package No.";
            end;
        end;
    end;

    local procedure InsertPackageNoFromRPO()
    var
        PackageTracking: Record "Package Tracking";
        PackageTrackingOld: Record "Package Tracking";
        PackageTrackingNew: Record "Package Tracking";
        Item: Record Item;
        PackSize: Decimal;
        PackSizeA: Decimal;
        PackSizeB: Decimal;
        i: Integer;
        PackSizeText: Text;
        DotPos: Integer;
        BeforeDecimalStr: Text;
        AfterDecimalStr: Text;
        LastLineQty: Decimal;
        EntryNo: Integer;
        InventorySetup: Record "Inventory Setup";
        NoSeriesManagement: Codeunit "No. Series";//IG_DS NoSeriesManagement;
        NoSeries: Record "No. Series";
    begin
        if Confirm('Do you want to generate package no.') then begin
            if (Rec."Source Type" = 5406) and (Rec."Source Subtype" = Rec."Source Subtype"::"3") then begin
                Clear(PackSize);
                Clear(PackSizeA);
                Clear(PackSizeB);
                Clear(LastLineQty);

                PackageTrackingOld.Reset();
                // PackageTrackingOld.SetRange("Source ID", Rec."Source ID");
                PackageTrackingOld.SetRange("Lot No.", Rec."Lot No.");
                if PackageTrackingOld.FindFirst() then
                    Error('Already generated');

                if Item.Get(Rec."Item No.") then;
                PackSize := Rec."Quantity (Base)" / Item."Pack Size";

                // For qty split >>>
                PackSizeText := Format(PackSize); // Convert to text
                DotPos := StrPos(PackSizeText, '.'); // Or ',' if using comma as decimal separator
                if DotPos = 0 then begin
                    BeforeDecimalStr := PackSizeText;
                    AfterDecimalStr := '0';
                end else begin
                    BeforeDecimalStr := CopyStr(PackSizeText, 1, DotPos - 1);
                    AfterDecimalStr := CopyStr(PackSizeText, DotPos + 1, StrLen(PackSizeText) - DotPos);
                end;

                if BeforeDecimalStr <> '' then
                    Evaluate(PackSizeA, BeforeDecimalStr);
                // if AfterDecimalStr <> '' then
                //     Evaluate(PackSizeB, AfterDecimalStr);
                // For qty split <<<

                EntryNo := 0;

                if PackSizeA <> 0 then begin
                    for i := 1 to PackSizeA do begin
                        PackageTracking.Init();
                        PackageTrackingOld.Reset();
                        PackageTrackingOld.SetCurrentKey("Entry No.");
                        if PackageTrackingOld.FindLast() then
                            EntryNo := PackageTrackingOld."Entry No." + 1
                        else
                            EntryNo := 1;
                        PackageTracking."Entry No." := EntryNo;
                        PackageTracking."Entry Type" := PackageTracking."Entry Type"::Output;
                        PackageTracking."Document No." := Rec."Source ID";
                        PackageTracking."Source ID" := Rec."Source ID";
                        PackageTracking."Document No." := Rec."Source ID";
                        PackageTracking."Source Subtype" := Rec."Source Subtype";
                        PackageTracking."Source Type" := Rec."Source Type";
                        PackageTracking."Source Ref. No." := Rec."Source Ref. No.";
                        PackageTracking."Expiration Date" := Rec."Expiration Date";
                        // PackageTracking."Gross Weight" := Rec."SSD Gross Weight";
                        PackageTracking."Item No." := Rec."Item No.";
                        PackageTracking."Lot No." := Rec."Lot No.";
                        PackageTracking."Location Code" := Rec."Location Code";
                        PackageTracking."Pack Quantity" := Item."Pack Size";// Rec."Pack Quantity";
                        InventorySetup.Get;
                        InventorySetup.TestField("Package Nos.");
                        //IG_DS NoSeriesManagement.InitSeries(InventorySetup."Package Nos.", '', 0D, PackageTracking."Package No.", NoSeries.Code);
                        if NoSeriesManagement.AreRelated(InventorySetup."Package Nos.", '') then
                            //  NoSeries.Code := xRec."No. Series";
                            PackageTracking."Package No." := NoSeriesManagement.GetNextNo(NoSeries.Code);
                        PackageTracking."Posting Date" := Today;
                        PackageTracking.Quantity := Item."Pack Size";
                        PackageTracking.Insert();
                    end;
                end;
                if AfterDecimalStr <> '' then begin
                    PackageTracking.Init();
                    PackageTrackingOld.Reset();
                    PackageTrackingOld.SetCurrentKey("Entry No.");
                    if PackageTrackingOld.FindLast() then
                        EntryNo := PackageTrackingOld."Entry No." + 1
                    else
                        EntryNo := 1;
                    PackageTracking."Entry No." := EntryNo;
                    PackageTracking."Entry Type" := PackageTracking."Entry Type"::Output;
                    PackageTracking."Document No." := Rec."Source ID";
                    PackageTracking."Source ID" := Rec."Source ID";
                    PackageTracking."Document No." := Rec."Source ID";
                    PackageTracking."Source Subtype" := Rec."Source Subtype";
                    PackageTracking."Source Type" := Rec."Source Type";
                    PackageTracking."Source Ref. No." := Rec."Source Ref. No.";
                    PackageTracking."Expiration Date" := Rec."Expiration Date";
                    // PackageTracking."Gross Weight" := Rec."SSD Gross Weight";
                    PackageTracking."Item No." := Rec."Item No.";
                    PackageTracking."Lot No." := Rec."Lot No.";
                    PackageTracking."Location Code" := Rec."Location Code";
                    PackageTracking."Pack Quantity" := Item."Pack Size";// Rec."Pack Quantity";
                    InventorySetup.Get;
                    InventorySetup.TestField("Package Nos.");
                    //  NoSeriesManagement.InitSeries(InventorySetup."Package Nos.", '', 0D, PackageTracking."Package No.", NoSeries.Code);
                    if NoSeriesManagement.AreRelated(InventorySetup."Package Nos.", '') then
                        // NoSeries.Code := xRec."No. Series";
                        PackageTracking."Package No." := NoSeriesManagement.GetNextNo(NoSeries.Code);
                    PackageTracking."Posting Date" := Today;
                    LastLineQty := PackSizeA * Item."Pack Size";
                    PackageTracking.Quantity := Rec."Quantity (Base)" - LastLineQty;
                    PackageTracking.Insert();
                end;
                PackageTrackingNew.Reset();
                PackageTrackingNew.SetCurrentKey("Entry No.");
                PackageTrackingNew.SetRange("Source ID", Rec."Source ID");
                if PackageTrackingNew.FindFirst() then
                    Rec."Package No." := PackageTrackingNew."Package No.";
            end;
        end;
    end;

    trigger OnAfterGetRecord()
    begin
        // if Rec."Lot No." = '' then exit; //IG_DS
        // //AlleZav1.03/070815 Begin
        // ItemLedgerEntry.RESET;
        // ItemLedgerEntry.SETRANGE("Lot No.", Rec."Lot No.");
        // ItemLedgerEntry.SETRANGE("Item No.", Rec."Item No.");
        // ItemLedgerEntry.SetLoadFields("Lot No.", "Item No.");
        // IF ItemLedgerEntry.FINDSET THEN
        //     REPEAT
        //         IF ItemLedgerEntry."Lot Blocked" = TRUE THEN ERROR('%1 Lot is Blocked', Rec."Lot No.");
        //     UNTIL ItemLedgerEntry.NEXT = 0;
        // //AlleZav1.03/070815 End
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        Rec."Qty. per Unit of Measure" := QtyPerUOM;
    end;

    trigger OnModifyRecord(): Boolean
    begin
        //ALLE[5.51]
        PostedQualityOrder1.RESET;
        PostedQualityOrder1.SETRANGE(PostedQualityOrder1."Lot No.", Rec."Lot No.");
        IF PostedQualityOrder1.FINDFIRST THEN
            IF Rec."MRN No." <> '' THEN //ERROR('Quality Order Posted for this Lot');
                QualityOrderHeader1.RESET;
        QualityOrderHeader1.SETRANGE(QualityOrderHeader1."Lot No.", Rec."Lot No.");
        IF QualityOrderHeader1.FINDFIRST THEN IF Rec."MRN No." <> '' THEN ERROR('Quality Order Created for this Lot');
        //ALLE[5.51]
        TempItemTrackLineModify.Sample := Rec.Sample;
        TempItemTrackLineModify."Sample Quantity" := Rec."Sample Quantity";
        TempItemTrackLineModify."Rejected Qty." := Rec."Rejected Qty.";
        TempItemTrackLineModify."MRN No." := GMRNNo;
        TempItemTrackLineModify."No. of Container" := Rec."No. of Container";
        TempItemTrackLineModify."Pack Quantity" := Rec."Pack Quantity";
        TempItemTrackLineModify."Manufacturing date" := Rec."Manufacturing date";
        TempItemTrackLineModify."Sampling Date" := Rec."Sampling Date";
        TempItemTrackLineModify."Sampled By" := Rec."Sampled By";
        IF GMRNNo <> '' THEN //ALLE[5.51]
            TempItemTrackLineModify."MRN Line No." := GMRNLineNo;
        TempItemTrackLineModify."Unused Field 1" := Rec."Unused Field 1";
        TempItemTrackLineModify."Unused Field 2" := Rec."Unused Field 2";
        TempItemTrackLineModify."Unused Field 3" := Rec."Unused Field 3";
        TempItemTrackLineModify."Unused Field 4" := Rec."Unused Field 4";
        TempItemTrackLineModify."Unused Field 5" := Rec."Unused Field 5";
        // PQA-003.end
    end;

    trigger OnOpenPage()
    var
    begin
        UpdateUndefinedQty; //BIS 1145 01042015
    end;
    //Unsupported feature: Code Modification on "SetSource(PROCEDURE 1)".
    //procedure SetSource();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    GetItem(TrackingSpecification."Item No.");
    ForBinCode := TrackingSpecification."Bin Code";
    SetFilters(TrackingSpecification);
    #4..69
    ReservEntry.SETRANGE("Source Batch Name",TrackingSpecification."Source Batch Name");
    ReservEntry.SETRANGE("Source Prod. Order Line",TrackingSpecification."Source Prod. Order Line");

    // Transfer Receipt gets special treatment:
    IF (TrackingSpecification."Source Type" = DATABASE::"Transfer Line") AND
       (FormRunMode <> FormRunMode::Transfer) AND
    #76..97
    TrackingSpecification.SETRANGE("Source Batch Name",TrackingSpecification."Source Batch Name");
    TrackingSpecification.SETRANGE("Source Prod. Order Line",TrackingSpecification."Source Prod. Order Line");
    TrackingSpecification.SETRANGE("Source Ref. No.",TrackingSpecification."Source Ref. No.");

    IF TrackingSpecification.FINDSET THEN
      REPEAT
    #104..169

    FunctionsDemandVisible := CurrentSignFactor * SourceQuantityArray[1] < 0;
    FunctionsSupplyVisible := NOT FunctionsDemandVisible;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..72
    ReservEntry.SETRANGE("Item No.",TrackingSpecification."Item No.");//ALLE[US]
    ReservEntry.SETRANGE("Location Code",TrackingSpecification."Location Code"); //ALLE[US]

    // PQA-003.begin
    IF GMRNNo <> '' THEN BEGIN
      ReservEntry.SETRANGE("MRN No.",GMRNNo);
      ReservEntry.SETRANGE("MRN Line No.",GMRNLineNo);
    END;
    // PQA-003.end

    #73..100
    //New
    //TrackingSpecification.SETRANGE("Item No." , TrackingSpecification."Item No.");
    //TrackingSpecification.SETRANGE("lOCATION CODE" , TrackingSpecification."LOCATION CODE");

    //New
    // PQA-003.begin
    IF GMRNNo <> '' THEN BEGIN
      TrackingSpecification.SETRANGE("MRN No.",GMRNNo);
      TrackingSpecification.SETRANGE("MRN Line No.",GMRNLineNo);
    END;
    // PQA-003.end
    #101..172
    */
    //end;
    //Unsupported feature: Code Modification on "AddToGlobalRecordSet(PROCEDURE 17)".
    //procedure AddToGlobalRecordSet();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    TempTrackingSpecification.SETCURRENTKEY("Lot No.","Serial No.");
    IF TempTrackingSpecification.FIND('-') THEN
      REPEAT
        TempTrackingSpecification.SETRANGE("Lot No.",TempTrackingSpecification."Lot No.");
        TempTrackingSpecification.SETRANGE("Serial No.",TempTrackingSpecification."Serial No.");
        TempTrackingSpecification.CALCSUMS("Quantity (Base)","Qty. to Handle (Base)",
          "Qty. to Invoice (Base)","Quantity Handled (Base)","Quantity Invoiced (Base)");
        IF TempTrackingSpecification."Quantity (Base)" <> 0 THEN BEGIN
    #9..38
        TempTrackingSpecification.SETRANGE("Lot No.");
        TempTrackingSpecification.SETRANGE("Serial No.");
      UNTIL TempTrackingSpecification.NEXT = 0;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..5
        // PQA-003.begin
        IF GMRNNo <> '' THEN BEGIN
          TempTrackingSpecification.SETRANGE("MRN No.",GMRNNo);
          TempTrackingSpecification.SETRANGE("MRN Line No.",GMRNLineNo);
        END;
        // PQA-003.end
    #6..41
    */
    //end;
    //Unsupported feature: Code Modification on "SetFilters(PROCEDURE 12)".
    //procedure SetFilters();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    FILTERGROUP := 2;
    SETCURRENTKEY("Source ID","Source Type","Source Subtype","Source Batch Name","Source Prod. Order Line","Source Ref. No.");
    SETRANGE("Source ID",TrackingSpecification."Source ID");
    #4..15
    SETRANGE("Item No.",TrackingSpecification."Item No.");
    SETRANGE("Location Code",TrackingSpecification."Location Code");
    SETRANGE("Variant Code",TrackingSpecification."Variant Code");
    FILTERGROUP := 0;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..18
    // PQA-003
    IF GMRNNo <> '' THEN BEGIN
      SETRANGE("MRN No.",GMRNNo);
      SETRANGE("MRN Line No.",GMRNLineNo);
    END;
    // PQA-003
    FILTERGROUP := 0;
    */
    //end;
    //Unsupported feature: Code Modification on "CalculateSums(PROCEDURE 2)".
    //procedure CalculateSums();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    xTrackingSpec.COPY(Rec);
    RESET;
    CALCSUMS("Quantity (Base)",
      "Qty. to Handle (Base)",
      "Qty. to Invoice (Base)");
    TotalItemTrackingLine := Rec;
    COPY(xTrackingSpec);

    UpdateUndefinedQtyArray;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    xTrackingSpec.COPY(Rec);
    RESET;

    // PQA-003
    //CALCSUMS("Quantity (Base)",
    //  "Qty. to Handle (Base)",
    //  "Qty. to Invoice (Base)");

    CALCSUMS("Quantity (Base)",
      "Qty. to Handle (Base)",
      "Qty. to Invoice (Base)",
      "Rejected Qty.");
    #6..8
    UpdateUndefinedQty;
    UpdateUndefinedQtyArray;
    */
    //end;
    //Unsupported feature: Property Insertion (Name) on "UpdateUndefinedQty(PROCEDURE 5).ReturnValue".
    //Unsupported feature: Code Modification on "UpdateUndefinedQty(PROCEDURE 5)".
    //procedure UpdateUndefinedQty();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    UpdateUndefinedQtyArray;
    IF ProdOrderLineHandling THEN // Avoid check for prod.journal lines
      EXIT(TRUE);
    EXIT(ABS(SourceQuantityArray[1]) >= ABS(TotalItemTrackingLine."Quantity (Base)"));
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..4

    IF GAcceptedQty = 0 THEN BEGIN //PQA-003
    IF ABS(SourceQuantityArray[1]) < ABS(TotalItemTrackingLine."Quantity (Base)") THEN BEGIN
      QtyIsValid := FALSE;
    END ELSE BEGIN
      QtyIsValid := TRUE;
    END;
    END ELSE BEGIN
      RejectQtyArray[1] := GRejectedQty;
      RejectQtyArray[2] := GRejectedQty;
      RejectQtyArray[3] := GRejectedQty;
      IF ABS(GRejectedQty) <> ABS(TotalItemTrackingLine."Rejected Qty.") THEN
        RejQtyIsValid := FALSE
      ELSE
        RejQtyIsValid := TRUE;
      IF ABS(SourceQuantityArray[1]) < ABS(TotalItemTrackingLine."Quantity (Base)") THEN BEGIN
        ColorOfQuantityArray[1] := 255;
        QtyIsValid := FALSE;
      END ELSE BEGIN
        ColorOfQuantityArray[1] := 0;
        QtyIsValid := TRUE;
      END;
      IF QtyIsValid AND RejQtyIsValid THEN
        QtyIsValid := TRUE
      ELSE
        QtyIsValid := FALSE;
    END;
    // PQA-003 02042015
          IF ABS(SourceQuantityArray[2]) < ABS(TotalItemTrackingLine."Qty. to Handle (Base)") THEN
            ColorOfQuantityArray[2] := 255
          ELSE
            ColorOfQuantityArray[2] := 0;

          IF ABS(SourceQuantityArray[3]) < ABS(TotalItemTrackingLine."Qty. to Invoice (Base)") THEN
            ColorOfQuantityArray[3] := 255
          ELSE
            ColorOfQuantityArray[3] := 0;


    // PQA-003
    */
    //end;
    //Unsupported feature: Code Modification on "EntriesAreIdentical(PROCEDURE 8)".
    //procedure EntriesAreIdentical();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    IdenticalArray[1] := (
                          (ReservEntry1."Entry No." = ReservEntry2."Entry No.") AND
                          (ReservEntry1."Item No." = ReservEntry2."Item No.") AND
    #4..25
                          (ReservEntry1."Planning Flexibility" = ReservEntry2."Planning Flexibility") AND
                          (ReservEntry1."Lot No." = ReservEntry2."Lot No.") AND
                          (ReservEntry1."Variant Code" = ReservEntry2."Variant Code") AND
                          (ReservEntry1."Quantity Invoiced (Base)" = ReservEntry2."Quantity Invoiced (Base)"));

    IdenticalArray[2] := (
                          (ReservEntry1.Description = ReservEntry2.Description) AND
                          (ReservEntry1."New Serial No." = ReservEntry2."New Serial No.") AND
                          (ReservEntry1."New Lot No." = ReservEntry2."New Lot No.") AND
                          (ReservEntry1."Expiration Date" = ReservEntry2."Expiration Date") AND
                          (ReservEntry1."Warranty Date" = ReservEntry2."Warranty Date") AND
                          (ReservEntry1."New Expiration Date" = ReservEntry2."New Expiration Date"));

    EXIT(IdenticalArray[1] AND IdenticalArray[2]);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..28
      // PQA-003
      (ReservEntry1.Sample = ReservEntry2.Sample) AND
      (ReservEntry1."Sample Quantity" = ReservEntry2."Sample Quantity") AND
      (ReservEntry1."Rejected Qty." = ReservEntry2."Rejected Qty.") AND
      (ReservEntry1."MRN No." = ReservEntry2."MRN No.") AND
      (ReservEntry1."No. of Container" = ReservEntry2."No. of Container") AND
      (ReservEntry1."Pack Quantity" = ReservEntry2."Pack Quantity") AND
      (ReservEntry1."Manufacturing date" = ReservEntry2."Manufacturing date") AND
      (ReservEntry1."Sampling Date" = ReservEntry2."Sampling Date") AND
      (ReservEntry1."Sampled By" = ReservEntry2."Sampled By") AND
      (ReservEntry1."MRN Line No." = ReservEntry2."MRN Line No.") AND
      (ReservEntry1."Unused Field 1" = ReservEntry2."Unused Field 1") AND
      (ReservEntry1."Unused Field 2" = ReservEntry2."Unused Field 2") AND
      (ReservEntry1."Unused Field 3" = ReservEntry2."Unused Field 3") AND
      (ReservEntry1."Unused Field 4" = ReservEntry2."Unused Field 4") AND
      (ReservEntry1."Unused Field 5" = ReservEntry2."Unused Field 5") AND
      // PQA-003

    #29..36
      // PQA-003
      (ReservEntry1.Sample = ReservEntry2.Sample) AND
      (ReservEntry1."Sample Quantity" = ReservEntry2."Sample Quantity") AND
      (ReservEntry1."Rejected Qty." = ReservEntry2."Rejected Qty.") AND
      (ReservEntry1."MRN No." = ReservEntry2."MRN No.") AND
      (ReservEntry1."No. of Container" = ReservEntry2."No. of Container") AND
      (ReservEntry1."Pack Quantity" = ReservEntry2."Pack Quantity") AND
      (ReservEntry1."Manufacturing date" = ReservEntry2."Manufacturing date") AND
      (ReservEntry1."Sampling Date" = ReservEntry2."Sampling Date") AND
      (ReservEntry1."Sampled By" = ReservEntry2."Sampled By") AND
      (ReservEntry1."MRN Line No." = ReservEntry2."MRN Line No.") AND
      (ReservEntry1."Unused Field 1" = ReservEntry2."Unused Field 1") AND
      (ReservEntry1."Unused Field 2" = ReservEntry2."Unused Field 2") AND
      (ReservEntry1."Unused Field 3" = ReservEntry2."Unused Field 3") AND
      (ReservEntry1."Unused Field 4" = ReservEntry2."Unused Field 4") AND
      (ReservEntry1."Unused Field 5" = ReservEntry2."Unused Field 5") AND
      // PQA-003

    #37..39
    */
    //end;
    //Unsupported feature: Code Modification on "RegisterChange(PROCEDURE 11)".
    //procedure RegisterChange();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    OK := FALSE;

    IF ((CurrentSignFactor * NewTrackingSpecification."Qty. to Handle") < 0) AND
    #4..37
              OldTrackingSpecification."New Serial No.",OldTrackingSpecification."New Lot No.");
            CreateReservEntry.SetNewExpirationDate(OldTrackingSpecification."New Expiration Date");
          END;
          CreateReservEntry.SetDates(
            NewTrackingSpecification."Warranty Date",NewTrackingSpecification."Expiration Date");
          CreateReservEntry.SetApplyFromEntryNo(NewTrackingSpecification."Appl.-from Item Entry");
    #44..77
        BEGIN
          ReservEntry1.TRANSFERFIELDS(OldTrackingSpecification);
          ReservEntry2.TRANSFERFIELDS(NewTrackingSpecification);

          ReservEntry1."Entry No." := ReservEntry2."Entry No."; // If only entry no. has changed it should not trigger
          IF EntriesAreIdentical(ReservEntry1,ReservEntry2,IdenticalArray) THEN
            EXIT(QtyToHandleAndInvoiceChanged(ReservEntry1,ReservEntry2));
    #85..108
            OldTrackingSpecification."Warranty Date" := NewTrackingSpecification."Warranty Date";
            OldTrackingSpecification."Expiration Date" := NewTrackingSpecification."Expiration Date";
            OldTrackingSpecification.Description := NewTrackingSpecification.Description;
            RegisterChange(OldTrackingSpecification,OldTrackingSpecification,
              ChangeType::Insert,NOT IdenticalArray[2]);
          END ELSE BEGIN
            TempReservEntry.SETRANGE("Serial No.",OldTrackingSpecification."Serial No.");
            TempReservEntry.SETRANGE("Lot No.",OldTrackingSpecification."Lot No.");
            OldTrackingSpecification."Serial No." := '';
            OldTrackingSpecification."Lot No." := '';
            OldTrackingSpecification."Warranty Date" := 0D;
            OldTrackingSpecification."Expiration Date" := 0D;
            QtyToAdd :=
    #122..166
        END;
    END;
    SetQtyToHandleAndInvoice(NewTrackingSpecification);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..40
          //PQA-003.begin
          CreateReservEntry.SetRejection(
            OldTrackingSpecification."Rejected Qty.",
            OldTrackingSpecification.Sample,
            OldTrackingSpecification."Sample Quantity",
            OldTrackingSpecification."MRN No.",
            OldTrackingSpecification."No. of Container",
            OldTrackingSpecification."Pack Quantity",
            OldTrackingSpecification."Manufacturing date",
            OldTrackingSpecification."Sampling Date",
            OldTrackingSpecification."Sampled By",
            OldTrackingSpecification."MRN Line No.",
            OldTrackingSpecification."Unused Field 1",
            OldTrackingSpecification."Unused Field 2",
            OldTrackingSpecification."Unused Field 3",
            OldTrackingSpecification."Unused Field 4",
            OldTrackingSpecification."Unused Field 5");
          //PQA-003.end
          CreateReservEntry.FlowMRNDetails(OldTrackingSpecification."MRN No.",OldTrackingSpecification."MRN Line No."); //CORP::PK
    #41..80
          ReservEntry2."MRN No." := NewTrackingSpecification."MRN No."; //CORP::PK
          ReservEntry2."MRN Line No." := NewTrackingSpecification."MRN Line No."; //CORP::PK
          ReservEntry1."MRN No." := ReservEntry2."MRN No."; //CORP::PK 100220
          ReservEntry1."MRN Line No." := ReservEntry2."MRN Line No."; //CORP::PK 100220
          //ReservEntry2.MODIFY; //CORP::PK
    #82..111
            OldTrackingSpecification."MRN No." := NewTrackingSpecification."MRN No."; //CORP::PK
            OldTrackingSpecification."MRN Line No." := NewTrackingSpecification."MRN Line No."; //CORP::PK
    #112..118
            OldTrackingSpecification."MRN No." := ''; //CORP::PK
            OldTrackingSpecification."MRN Line No." := 0; //CORP::PK
    #119..169
    */
    //end;
    //Unsupported feature: Code Modification on "ModifyFieldsWithinFilter(PROCEDURE 25)".
    //procedure ModifyFieldsWithinFilter();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    // Used to ensure that field values that are common to a SN/Lot are copied to all entries.
    IF ReservEntry1.FIND('-') THEN
      REPEAT
        ReservEntry1.Description := TrackingSpecification.Description;
        ReservEntry1."Warranty Date" := TrackingSpecification."Warranty Date";
        ReservEntry1."Expiration Date" := TrackingSpecification."Expiration Date";
        ReservEntry1."New Serial No." := TrackingSpecification."New Serial No.";
        ReservEntry1."New Lot No." := TrackingSpecification."New Lot No.";
        ReservEntry1."New Expiration Date" := TrackingSpecification."New Expiration Date";
        ReservEntry1.MODIFY;
      UNTIL ReservEntry1.NEXT = 0;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..6
        // PQA-003
        ReservEntry1.Sample := TrackingSpecification.Sample;
        ReservEntry1."Sample Quantity" := TrackingSpecification."Sample Quantity";
        ReservEntry1."Rejected Qty." := TrackingSpecification."Rejected Qty.";
        ReservEntry1."MRN No." := TrackingSpecification."MRN No.";   //CORP::PK
        ReservEntry1."No. of Container" := TrackingSpecification."No. of Container";
        ReservEntry1."Pack Quantity" := TrackingSpecification."Pack Quantity";
        ReservEntry1."Manufacturing date" := TrackingSpecification."Manufacturing date";
        ReservEntry1."Sampling Date" := TrackingSpecification."Sampling Date";
        ReservEntry1."Sampled By" := TrackingSpecification."Sampled By";
        ReservEntry1."MRN Line No." := TrackingSpecification."MRN Line No."; //CORP::PK
        ReservEntry1."Unused Field 1" := TrackingSpecification."Unused Field 1";
        ReservEntry1."Unused Field 2" := TrackingSpecification."Unused Field 2";
        ReservEntry1."Unused Field 3" := TrackingSpecification."Unused Field 3";
        ReservEntry1."Unused Field 4" := TrackingSpecification."Unused Field 4";
        ReservEntry1."Unused Field 5" := TrackingSpecification."Unused Field 5";
        // PQA-003
    #7..11
    */
    //end;
    //Unsupported feature: Code Modification on "SetQtyToHandleAndInvoice(PROCEDURE 7)".
    //procedure SetQtyToHandleAndInvoice();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    IF IsCorrection THEN
      EXIT;

    TotalQtyToHandle := TrackingSpecification."Qty. to Handle (Base)" * CurrentSignFactor;
    TotalQtyToInvoice := TrackingSpecification."Qty. to Invoice (Base)" * CurrentSignFactor;

    ReservEntry1.TRANSFERFIELDS(TrackingSpecification);
    ReservationMgt.SetPointerFilter(ReservEntry1);
    ReservEntry1.SETRANGE("Lot No.",ReservEntry1."Lot No.");
    ReservEntry1.SETRANGE("Serial No.",ReservEntry1."Serial No.");
    #11..67
          ReservEntry1."Qty. to Invoice (Base)" := TotalQtyToInvoice;
          ReservEntry1.MODIFY;
        END;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..7
    ReservEntry1."MRN No." := TrackingSpecification."MRN No."; //BIS 1145
    ReservEntry1."MRN Line No." := TrackingSpecification."MRN Line No."; // BIS 1145
    #8..70
    */
    //end;
    //Unsupported feature: Code Modification on "RegisterItemTrackingLines(PROCEDURE 27)".
    //procedure RegisterItemTrackingLines();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    SourceSpecification.TESTFIELD("Source Type"); // Check if source has been set.
    IF NOT CalledFromSynchWhseItemTrkg THEN
      TempSpecification.RESET;
    #4..36
          "New Expiration Date" := TempSpecification."New Expiration Date"
        END;
        VALIDATE("Quantity (Base)",TempSpecification."Quantity (Base)");
        "Entry No." := NextEntryNo;
        INSERT;
      END;
    #43..59
    // Copy to inbound part of transfer
    IF (FormRunMode = FormRunMode::Transfer) OR IsOrderToOrderBindingToTransfer THEN
      SynchronizeLinkedSources('');
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..39
        // PQA-003
        Sample := TempSpecification.Sample;
        "Sample Quantity" := TempSpecification."Sample Quantity";
        "Rejected Qty." := TempSpecification."Rejected Qty.";
        "MRN No." := TempSpecification."MRN No.";  //CORP::PK
        "No. of Container" := TempSpecification."No. of Container";
        "Pack Quantity" := TempSpecification."Pack Quantity";
        "Manufacturing date" := TempSpecification."Manufacturing date";
        "Sampling Date" := TempSpecification."Sampling Date";
        "Sampled By" := TempSpecification."Sampled By";
        "MRN Line No." := TempSpecification."MRN Line No.";
        "Unused Field 1" := TempSpecification."Unused Field 1";
        "Unused Field 2" := TempSpecification."Unused Field 2";
        "Unused Field 3" := TempSpecification."Unused Field 3";
        "Unused Field 4" := TempSpecification."Unused Field 4";
        "Unused Field 5" := TempSpecification."Unused Field 5";
        // PQA-003
    #40..62
    */
    //end;
    //Unsupported feature: Variable Insertion (Variable: ILE) (VariableCollection) on "SelectEntries(PROCEDURE 36)".
    //Unsupported feature: Code Modification on "ExpirationDateOnFormat(PROCEDURE 19045111)".
    //procedure ExpirationDateOnFormat();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    UpdateExpDateColor;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    UpdateExpDateColor;
    CheckExpDate;//ALLE[551]
    */
    //end;
    procedure SetGRNQty(GRNQty: Decimal; RejectedQty: Decimal; Sample: Boolean; SampleQty: Decimal; MRNNo: Code[20]; NoOfContainer: Integer; PackQty: Decimal; ManufacturingDate: Date; SamplingDate: Date; SampledBy: Code[20]; MRNLineNo: Integer; UNUSED1: Code[1]; UNUSED2: Code[1]; UNUSED3: Code[1]; UNUSED4: Code[1]; UNUSED5: Code[1])
    begin
        // PQA-003.begin
        GAcceptedQty := GRNQty;
        GRejectedQty := RejectedQty;
        GSample := Sample;
        GSampleQty := SampleQty;
        GMRNNo := MRNNo;
        GNoOfContainer := NoOfContainer;
        GPackQty := PackQty;
        GManufacturingDate := ManufacturingDate;
        GSamplingDate := SamplingDate;
        GSampledBy := SampledBy;
        GMRNLineNo := MRNLineNo;
        GUNUSED1 := UNUSED1;
        GUNUSED2 := UNUSED2;
        GUNUSED3 := UNUSED3;
        GUNUSED4 := UNUSED4;
        GUNUSED5 := UNUSED5;
        // PQA-003.end
    end;

    procedure SetFreeSampleInfo(MRNNo: Code[20]; MRNLineNo: Integer)
    begin
        GMRNNo := MRNNo;
        GMRNLineNo := MRNLineNo; // PQA-003
    end;

    local procedure CheckExpDate()
    var
        TextL50001: label 'Lot will be expired within 2 month';
    begin
        //<<<< ALLE[551]
        if (Rec."Expiration Date" <> 0D) and (CopyStr(Rec."Item No.", 1, 2) = 'FG') then begin
            if Rec."Source Type" = 37 then if (Rec."Expiration Date" - WorkDate) <= 60 then Message(TextL50001);
        end;
        if (Rec."Expiration Date" <> 0D) and (CopyStr(Rec."Item No.", 1, 2) <> 'FG') then begin
            if (Rec."Expiration Date" - WorkDate) <= 90 then;
        end;
        //CurrForm."Expiration Date".UPDATEFORECOLOR(0);
        //>>>> ALLE[551]
    end;
    //Unsupported feature: Property Modification (Length) on "SetFromAppDelChallan(PROCEDURE 1500000).DeliveryChallanNoFrom(Parameter 1500001)".
}
