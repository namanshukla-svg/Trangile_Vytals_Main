codeunit 50137 "SSD Item Subscribers"
{
    [EventSubscriber(ObjectType::Table, Database::"Item Journal Line", 'OnAfterSetupNewLine', '', false, false)]
    local procedure SSDOnAfterSetupNewLine(var ItemJournalLine: Record "Item Journal Line"; var LastItemJournalLine: Record "Item Journal Line"; ItemJournalTemplate: Record "Item Journal Template"; ItemJnlBatch: Record "Item Journal Batch")
    begin
        ItemJournalLine.UpdateRespCenter();
    end;
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Item Jnl.-Check Line", 'OnBeforeCheckLocation', '', false, false)]
    local procedure SSDOnBeforeCheckLocation(var ItemJournalLine: Record "Item Journal Line")
    var
        ItemJournalBatch: Record "Item Journal Batch";
    begin
        if ItemJournalBatch.Get(ItemJournalLine."Journal Template Name", ItemJournalLine."Journal Batch Name")then if ItemJournalBatch."Input/Output" then begin
                ItemJournalLine.TestField("Production Doc. No.");
                ItemJournalLine.TestField("Production Doc. Type");
            end;
    end;
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Item Jnl.-Post Line", 'OnPostOutputOnBeforeProdOrderRtngLineModify', '', false, false)]
    local procedure SSDOnPostOutputOnAfterProdOrderRtngLineSetFilters(var ProdOrderRoutingLine: Record "Prod. Order Routing Line")
    begin
        ProdOrderRoutingLine."Quality Done":=false;
        ProdOrderRoutingLine."Sent for Quality":=false;
    //ProdOrderRoutingLine.Modify(false);
    end;
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Item Jnl.-Post Line", 'OnCheckExpirationDateOnBeforeTestFieldExpirationDate', '', false, false)]
    local procedure SSDOnCheckExpirationDateOnBeforeTestFieldExpirationDate(var TempTrackingSpecification: Record "Tracking Specification" temporary; var EntriesExist: Boolean; var ExistingExpirationDate: Date)
    begin
        //SSD_Expiration Date
        if not TempTrackingSpecification.Positive then if ExistingExpirationDate = 0D then TempTrackingSpecification."Expiration Date":=0D;
    end;
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Item Jnl.-Post Line", 'OnBeforeInsertCapLedgEntry', '', false, false)]
    local procedure SSDOnBeforeInsertCapLedgEntry(var CapLedgEntry: Record "Capacity Ledger Entry"; ItemJournalLine: Record "Item Journal Line")
    begin
        CapLedgEntry."SSD Rework Qty":=ItemJournalLine."Rework Qty";
        CapLedgEntry."Rejected Qty":=ItemJournalLine."Rejected Qty";
    end;
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Item Jnl.-Post Line", 'OnBeforeInsertCapValueEntry', '', false, false)]
    local procedure SSDOnBeforeInsertCapValueEntry(var ValueEntry: Record "Value Entry"; ItemJnlLine: Record "Item Journal Line")
    begin
        ValueEntry."Rework Qty":=ItemJnlLine."Rework Qty";
        ValueEntry."Rejected Qty":=ItemJnlLine."Rejected Qty";
    end;
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Item Jnl.-Post Line", 'OnInsertTransferEntryOnTransferValues', '', false, false)]
    local procedure SSDOnInsertTransferEntryOnTransferValues(var NewItemLedgerEntry: Record "Item Ledger Entry"; ItemJournalLine: Record "Item Journal Line")
    begin
        NewItemLedgerEntry."Rework Qty":=ItemJournalLine."Rework Qty";
        NewItemLedgerEntry."Rejected Qty":=ItemJournalLine."Rejected Qty";
        NewItemLedgerEntry."Bin Code":=ItemJournalLine."New Bin Code";
    end;
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Item Jnl.-Post Line", 'OnAfterInitItemLedgEntry', '', false, false)]
    local procedure SSDOnAfterInitItemLedgEntry(var NewItemLedgEntry: Record "Item Ledger Entry"; var ItemJournalLine: Record "Item Journal Line"; var ItemLedgEntryNo: Integer)
    begin
        NewItemLedgEntry."Responsibility Center":=ItemJournalLine."Responsibility Center";
        NewItemLedgEntry."Manufacturing Date New":=ItemJournalLine."Manufacturing Date New";
        NewItemLedgEntry."Production Doc. No.":=ItemJournalLine."Production Doc. No.";
        NewItemLedgEntry."Production Doc. Type":=ItemJournalLine."Production Doc. Type";
        NewItemLedgEntry."Rework Qty":=ItemJournalLine."Rework Qty";
        NewItemLedgEntry."Rejected Qty":=ItemJournalLine."Rejected Qty";
        NewItemLedgEntry."Bin Code":=ItemJournalLine."New Bin Code";
        NewItemLedgEntry."Rejected Qty.":=ItemJournalLine."Rejected Qty.";
        NewItemLedgEntry.Sample:=ItemJournalLine.Sample;
        NewItemLedgEntry."Sample Quantity":=ItemJournalLine."Sample Quantity";
        NewItemLedgEntry."MRN No.":=ItemJournalLine."MRN No.";
        NewItemLedgEntry."No. of Container":=ItemJournalLine."No. of Container";
        NewItemLedgEntry."Pack Quantity":=ItemJournalLine."Pack Quantity";
        NewItemLedgEntry."Manufacturing date":=ItemJournalLine."Manufacturing date";
        NewItemLedgEntry."Sampling Date":=ItemJournalLine."Sampling Date";
        NewItemLedgEntry."Sampled By":=ItemJournalLine."Sampled By";
        NewItemLedgEntry."MRN Line No.":=ItemJournalLine."MRN Line No.";
        NewItemLedgEntry."RGP Customer No.":=ItemJournalLine."RGP Customer No.";
    end;
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Item Jnl.-Post Line", 'OnBeforeInsertItemLedgEntry', '', false, false)]
    local procedure SSDOnBeforeInsertItemLedgEntry(var ItemLedgerEntry: Record "Item Ledger Entry"; ItemJournalLine: Record "Item Journal Line"; TransferItem: Boolean; OldItemLedgEntry: Record "Item Ledger Entry"; ItemJournalLineOrigin: Record "Item Journal Line")
    var
        ProdOrderComponent: Record "Prod. Order Component";
    begin
        IF(ItemLedgerEntry."Entry Type" = ItemLedgerEntry."Entry Type"::Output)THEN BEGIN
            ProdOrderComponent.RESET;
            ProdOrderComponent.SETRANGE("Prod. Order No.", ItemLedgerEntry."Document No.");
            ProdOrderComponent.SETRANGE("Item No.", ItemLedgerEntry."Source No.");
            IF ProdOrderComponent.FINDFIRST THEN REPEAT ProdOrderComponent.VALIDATE("Quantity per", ItemLedgerEntry.Quantity);
                    ProdOrderComponent.MODIFY;
                UNTIL ProdOrderComponent.NEXT = 0;
        END;
    end;
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Item Jnl.-Post Line", 'OnSetupSplitJnlLineOnAfterSetupTempSplitItemJnlLine', '', false, false)]
    local procedure SSDOnSetupSplitJnlLineOnAfterSetupTempSplitItemJnlLine(var ItemJournalLine: Record "Item Journal Line"; var TempSplitItemJournalLine: Record "Item Journal Line" temporary; TempTrackingSpecification: Record "Tracking Specification" temporary)
    begin
        TempSplitItemJournalLine."Rejected Qty.":=TempTrackingSpecification."Rejected Qty.";
        TempSplitItemJournalLine.Sample:=TempTrackingSpecification.Sample;
        TempSplitItemJournalLine."Sample Quantity":=TempTrackingSpecification."Sample Quantity";
        TempSplitItemJournalLine."No. of Container":=TempTrackingSpecification."No. of Container";
        TempSplitItemJournalLine."MRN No.":=TempTrackingSpecification."MRN No.";
        TempSplitItemJournalLine."Pack Quantity":=TempTrackingSpecification."Pack Quantity";
        TempSplitItemJournalLine."Manufacturing date":=TempTrackingSpecification."Manufacturing date";
        TempSplitItemJournalLine."Sampling Date":=TempTrackingSpecification."Sampling Date";
        TempSplitItemJournalLine."Sampled By":=TempTrackingSpecification."Sampled By";
        TempSplitItemJournalLine."MRN Line No.":=TempTrackingSpecification."MRN Line No.";
    end;
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Item Jnl.-Post Line", 'OnSplitItemJnlLineOnBeforeTracking', '', false, false)]
    local procedure SSDOnSplitItemJnlLineOnBeforeTracking(var ItemJnlLine2: Record "Item Journal Line"; var IsHandled: Boolean)
    begin
        if not ItemJnlLine2.Rejected then exit
        else
            IsHandled:=true;
    end;
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Item Jnl.-Post Line", 'OnSetupTempSplitItemJnlLineOnBeforeCalcPostItemJnlLine', '', false, false)]
    local procedure SSDOnSetupTempSplitItemJnlLineOnBeforeCalcPostItemJnlLine(var TempSplitItemJnlLine: Record "Item Journal Line"; TempTrackingSpecification: Record "Tracking Specification")
    begin
        TempSplitItemJnlLine."Rejected Qty.":=TempTrackingSpecification."Rejected Qty.";
        TempSplitItemJnlLine.Sample:=TempTrackingSpecification.Sample;
        TempSplitItemJnlLine."Sample Quantity":=TempTrackingSpecification."Sample Quantity";
        TempSplitItemJnlLine."No. of Container":=TempTrackingSpecification."No. of Container";
        TempSplitItemJnlLine."MRN No.":=TempTrackingSpecification."MRN No.";
        TempSplitItemJnlLine."Pack Quantity":=TempTrackingSpecification."Pack Quantity";
        TempSplitItemJnlLine."Manufacturing date":=TempTrackingSpecification."Manufacturing date";
        TempSplitItemJnlLine."Sampling Date":=TempTrackingSpecification."Sampling Date";
        TempSplitItemJnlLine."Sampled By":=TempTrackingSpecification."Sampled By";
        TempSplitItemJnlLine."MRN Line No.":=TempTrackingSpecification."MRN Line No.";
    end;
    //OnSetupTempSplitItemJnlLineOnBeforeCalcPostItemJnlLine
    [EventSubscriber(ObjectType::Page, Page::"Item Journal", 'OnBeforeActionEvent', 'Post', false, false)]
    local procedure SSDOnPost(var Rec: Record "Item Journal Line")
    var
        Location: Record Location;
        Item: Record Item;
        ItemPhyBinDetails: Record "SSD Item Phy. Bin Details";
    begin
        IF Rec.FindSet()then repeat IF Location.GET(Rec."Location Code")THEN;
                IF Item.GET(Rec."Item No.")THEN;
                IF(Location."Phy. Bin Required") AND (Item."Phy. Bin Required")THEN BEGIN
                    ItemPhyBinDetails.RESET;
                    ItemPhyBinDetails.SETRANGE("Document No.", Rec."Document No.");
                    ItemPhyBinDetails.SETRANGE("Document Line No.", Rec."Line No.");
                    ItemPhyBinDetails.SETRANGE("Posted Document No.", '');
                    IF NOT ItemPhyBinDetails.FINDFIRST THEN ERROR('Please fill the Item Phy. Details in Line No. %1', Rec."Line No.")
                    ELSE
                    BEGIN
                        ItemPhyBinDetails."Posting Date":=TODAY;
                        ItemPhyBinDetails.MODIFY;
                    END;
                END;
            UNTIL Rec.NEXT = 0;
    end;
    [EventSubscriber(ObjectType::Page, Page::"Item Journal", 'OnBeforeActionEvent', 'Post and &Print', false, false)]
    local procedure SSDOnPostPrint(var Rec: Record "Item Journal Line")
    var
        Location: Record Location;
        Item: Record Item;
        ItemPhyBinDetails: Record "SSD Item Phy. Bin Details";
    begin
        IF Rec.FindSet()then repeat IF Location.GET(Rec."Location Code")THEN;
                IF Item.GET(Rec."Item No.")THEN;
                IF(Location."Phy. Bin Required") AND (Item."Phy. Bin Required")THEN BEGIN
                    ItemPhyBinDetails.RESET;
                    ItemPhyBinDetails.SETRANGE("Document No.", Rec."Document No.");
                    ItemPhyBinDetails.SETRANGE("Document Line No.", Rec."Line No.");
                    ItemPhyBinDetails.SETRANGE("Posted Document No.", '');
                    IF NOT ItemPhyBinDetails.FINDFIRST THEN ERROR('Please fill the Item Phy. Details in Line No. %1', Rec."Line No.")
                    ELSE
                    BEGIN
                        ItemPhyBinDetails."Posting Date":=TODAY;
                        ItemPhyBinDetails.MODIFY;
                    END;
                END;
            UNTIL Rec.NEXT = 0;
    end;
    [EventSubscriber(ObjectType::Page, Page::"Item Reclass. Journal", 'OnBeforeActionEvent', 'Post', false, false)]
    local procedure SSDOnPostReclass(var Rec: Record "Item Journal Line")
    var
        Item: Record Item;
        ItemPhyBinDetails1: Record "SSD Item Phy. Bin Details";
        ItemPhyBinDetails: Record "SSD Item Phy. Bin Details";
        ReservationEntry: Record "Reservation Entry";
        Location: Record Location;
        Location1: Record Location;
        Qty: Decimal;
        Qty1: Decimal;
    begin
        Qty:=0;
        Qty1:=0;
        ItemPhyBinDetails1.RESET;
        ItemPhyBinDetails1.SETRANGE("Document No.", Rec."Document No.");
        ItemPhyBinDetails1.SETRANGE("Document Line No.", Rec."Line No.");
        ItemPhyBinDetails1.SETFILTER("ILE Quantity", '<%1', 0);
        IF ItemPhyBinDetails1.FINDSET THEN REPEAT IF(ItemPhyBinDetails1."Document Type" = ItemPhyBinDetails1."Document Type"::Transfer)THEN BEGIN
                    ItemPhyBinDetails.RESET;
                    ItemPhyBinDetails.SETFILTER("ILE Quantity", '<%1', 0);
                    ItemPhyBinDetails.SETRANGE("Item No.", ItemPhyBinDetails1."Item No.");
                    ItemPhyBinDetails.SETRANGE("Location Code", ItemPhyBinDetails1."Location Code");
                    ItemPhyBinDetails.SETRANGE("Bin Code", ItemPhyBinDetails1."Bin Code");
                    ItemPhyBinDetails.SETRANGE("Phy. Bin Code", ItemPhyBinDetails1."Phy. Bin Code");
                    ItemPhyBinDetails.SETRANGE("Lot No.", ItemPhyBinDetails1."Lot No.");
                    ItemPhyBinDetails.SETRANGE("Whse. Entry  No.", 0);
                    IF ItemPhyBinDetails.FINDSET THEN REPEAT Qty+=ItemPhyBinDetails."ILE Quantity";
                        UNTIL ItemPhyBinDetails.NEXT = 0;
                    ItemPhyBinDetails.RESET;
                    ItemPhyBinDetails.SETRANGE("Item No.", ItemPhyBinDetails1."Item No.");
                    ItemPhyBinDetails.SETRANGE("Location Code", ItemPhyBinDetails1."Location Code");
                    ItemPhyBinDetails.SETRANGE("Bin Code", ItemPhyBinDetails1."Bin Code");
                    ItemPhyBinDetails.SETRANGE("Phy. Bin Code", ItemPhyBinDetails1."Phy. Bin Code");
                    ItemPhyBinDetails.SETRANGE("Lot No.", ItemPhyBinDetails1."Lot No.");
                    ItemPhyBinDetails.SETFILTER("Whse. Entry  No.", '<>%1', 0);
                    IF ItemPhyBinDetails.FINDSET THEN REPEAT Qty1+=ItemPhyBinDetails."ILE Quantity";
                        UNTIL ItemPhyBinDetails.NEXT = 0;
                    IF ABS(Qty1) < ABS(Qty)THEN ERROR('Insufficient Quantity in Phy. Bin %1', ItemPhyBinDetails1."Phy. Bin Code");
                END;
            UNTIL ItemPhyBinDetails1.NEXT = 0;
        ItemPhyBinDetails1.RESET;
        ItemPhyBinDetails1.SETRANGE("Document No.", Rec."Document No.");
        ItemPhyBinDetails1.SETRANGE("Document Line No.", Rec."Line No.");
        ItemPhyBinDetails1.SETRANGE("Posted Document No.", ''); // Alle 23032021
        IF ItemPhyBinDetails1.FINDSET THEN REPEAT ReservationEntry.RESET;
                ReservationEntry.SETRANGE("Item No.", ItemPhyBinDetails1."Item No.");
                ReservationEntry.SETRANGE("Source ID", Rec."Journal Template Name");
                ReservationEntry.SETRANGE("Source Type", 83);
                ReservationEntry.SETRANGE("Source Subtype", 4);
                ReservationEntry.SETFILTER("Source Batch Name", '<>%1', 'DEFAULT');
                ReservationEntry.SETRANGE("Location Code", ItemPhyBinDetails1."Location Code");
                ReservationEntry.SETRANGE("Source Ref. No.", Rec."Line No.");
                IF ReservationEntry.FINDFIRST THEN BEGIN
                    IF ReservationEntry."Lot No." <> ItemPhyBinDetails1."Lot No." THEN ERROR('Lot must be same');
                END;
            UNTIL ItemPhyBinDetails1.NEXT = 0;
        //CORP::PK check for Phy. Bin Code >>>
        IF Rec.FINDSET THEN REPEAT //    ReservationEntry.RESET;
                //    ReservationEntry.SETRANGE("Item No.","Item No.");
                //    ReservationEntry.SETRANGE("Source ID","Journal Template Name");
                //    ReservationEntry.SETFILTER("Source Batch Name",'<>%1','DEFAULT');
                //    ReservationEntry.SETRANGE("Location Code","Location Code");
                //    ReservationEntry.SETRANGE("Source Ref. No.","Line No.");
                //    IF ReservationEntry.FINDFIRST THEN
                //      IF NOT ReservationEntry."QR Scanned" THEN
                //        ERROR('Lot not scnned !');
                IF Location.GET(Rec."Location Code")THEN;
                IF Location1.GET(Rec."New Location Code")THEN;
                IF Item.GET(Rec."Item No.")THEN;
                IF(((Location."Phy. Bin Required") OR (Location1."Phy. Bin Required")) AND (Item."Phy. Bin Required"))THEN BEGIN
                    ItemPhyBinDetails.RESET;
                    ItemPhyBinDetails.SETRANGE("Document No.", Rec."Document No.");
                    ItemPhyBinDetails.SETRANGE("Document Line No.", Rec."Line No.");
                    ItemPhyBinDetails.SETRANGE("Whse. Entry  No.", 0);
                    IF NOT ItemPhyBinDetails.FINDFIRST THEN ERROR('Please fill the Item Phy. Details in Line No. %1', Rec."Line No.")
                    ELSE
                    BEGIN
                        ItemPhyBinDetails."Posting Date":=Rec."Posting Date";
                        ItemPhyBinDetails.MODIFY;
                    END;
                END;
            UNTIL Rec.NEXT = 0;
    end;
    [EventSubscriber(ObjectType::Page, Page::"Item Reclass. Journal", 'OnBeforeActionEvent', 'Post and &Print', false, false)]
    local procedure SSDOnPostPrintReclass(var Rec: Record "Item Journal Line")
    var
        Item: Record Item;
        ItemPhyBinDetails: Record "SSD Item Phy. Bin Details";
        ReservationEntry: Record "Reservation Entry";
        Location: Record Location;
        Location1: Record Location;
    begin
        IF Rec.FINDSET THEN REPEAT //    ReservationEntry.RESET;
                //    ReservationEntry.SETRANGE("Item No.","Item No.");
                //    ReservationEntry.SETRANGE("Source ID","Journal Template Name");
                //    ReservationEntry.SETFILTER("Source Batch Name",'<>%1','DEFAULT');
                //    ReservationEntry.SETRANGE("Location Code","Location Code");
                //    ReservationEntry.SETRANGE("Source Ref. No.","Line No.");
                //    IF ReservationEntry.FINDFIRST THEN
                //      IF NOT ReservationEntry."QR Scanned" THEN
                //        ERROR('Lot not scnned !');
                IF Location.GET(Rec."Location Code")THEN;
                IF Location1.GET(Rec."New Location Code")THEN;
                IF Item.GET(Rec."Item No.")THEN;
                IF(((Location."Phy. Bin Required") OR (Location1."Phy. Bin Required")) AND (Item."Phy. Bin Required"))THEN BEGIN
                    ItemPhyBinDetails.RESET;
                    ItemPhyBinDetails.SETRANGE("Document No.", Rec."Document No.");
                    ItemPhyBinDetails.SETRANGE("Document Line No.", Rec."Line No.");
                    IF NOT ItemPhyBinDetails.FINDFIRST THEN ERROR('Please fill the Item Phy. Details in Line No. %1', Rec."Line No.")
                    ELSE
                    BEGIN
                        ItemPhyBinDetails."Posting Date":=Rec."Posting Date";
                        ItemPhyBinDetails.MODIFY;
                    END;
                END;
            UNTIL Rec.NEXT = 0;
    end;
}
