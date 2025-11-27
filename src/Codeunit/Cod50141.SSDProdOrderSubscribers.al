codeunit 50141 "SSD Prod. Order Subscribers"
{
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Calculate Prod. Order", 'OnAfterTransferRoutingLine', '', false, false)]
    local procedure SSDOnAfterGetTransHeader(var ProdOrderLine: Record "Prod. Order Line"; var RoutingLine: Record "Routing Line"; var ProdOrderRoutingLine: Record "Prod. Order Routing Line")
    begin
        ProdOrderRoutingLine."Quality Template Master" := RoutingLine."Quality Sampling No.";
        ProdOrderRoutingLine."Quality Required" := RoutingLine."Quality Required";
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Calculate Prod. Order", 'OnTransferBOMProcessItemOnBeforeGetPlanningParameters', '', false, false)]
    local procedure SSDOnTransferBOMProcessItemOnBeforeGetPlanningParameters(var ProdOrderComponent: Record "Prod. Order Component"; ProductionBOMLine: Record "Production BOM Line"; StockkeepingUnit: Record "Stockkeeping Unit")
    begin
        if ProductionBOMLine."Location Code" <> '' then ProdOrderComponent."Location Code" := ProductionBOMLine."Location Code";
    end;
    //OnTransferBOMProcessItemOnBeforeGetPlanningParameters
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Create Prod. Order from Sale", 'OnCreateProductionOrderOnBeforeItemOrder', '', false, false)]
    local procedure SSDOnCreateProductionOrderOnBeforeItemOrder(var ProdOrder: Record "Production Order"; var SalesLine: Record "Sales Line")
    var
        SalesHeader: Record "Sales Header";
    begin
        if SalesHeader.Get(SalesLine."Document Type", SalesLine."Document No.") then ProdOrder."Sales Order No." := SalesHeader."No.";
    end;

    [EventSubscriber(ObjectType::Page, Page::"Production Journal", 'OnBeforeActionEvent', 'ItemTrackingLines', false, false)]
    local procedure SSDOnClickItemTracking(var Rec: Record "Item Journal Line")
    begin
        Error('Please assign Lot No. on Released Production Order (RPO) line');
    end;

    [EventSubscriber(ObjectType::Page, Page::"Production Journal", 'OnBeforeActionEvent', 'Post', false, false)]
    local procedure SSDOnClickPost(var Rec: Record "Item Journal Line")
    var
        ProdOrderHeaderL: Record "Production Order";
        ProdOrderLineL: Record "Prod. Order Line";
        ItemJournalLine3: Record "Item Journal Line";
        ReservationEntry: Record "Reservation Entry";
        Location: Record Location;
        Item: Record Item;
        Text003: Label 'Create Quality Order for the Template Name = %1,  Batch Name = %2, Line No = %3';
        Text0000123: Label 'ENU=Lot not scnned  for %1';
        ILE: Record "Item Ledger Entry";
        ItemJournalLine4: Record "Item Journal Line";
        ProdOrderLineRec: Record "Prod. Order Line";
    begin
        IF ProdOrderHeaderL.GET(ProdOrderHeaderL.Status::Released, Rec."Document No.") THEN ProdOrderHeaderL.TESTFIELD(ProdOrderHeaderL.Quantity);
        //IF ProdOrderLineL.GET(ProdOrderLineL.Status::Released, Rec."Document No.", Rec."Order Line No.") THEN
        //ProdOrderLineL.TESTFIELD(ProdOrderLineL."Remaining Quantity");
        ItemJournalLine3.RESET;
        ItemJournalLine3.SETRANGE("Journal Template Name", Rec."Journal Template Name");
        ItemJournalLine3.SETRANGE("Journal Batch Name", Rec."Journal Batch Name");
        ItemJournalLine3.SETRANGE(ItemJournalLine3."Document No.", Rec."Document No.");
        IF ItemJournalLine3.FINDFIRST THEN
            REPEAT
                IF ItemJournalLine3."Entry Type" = ItemJournalLine3."Entry Type"::Output THEN BEGIN
                    ItemJournalLine3.TESTFIELD(ItemJournalLine3."Starting Time");
                    ItemJournalLine3.TESTFIELD(ItemJournalLine3."Ending Time");
                    ItemJournalLine3.TESTFIELD(ItemJournalLine3."Output Quantity");
                END;
            UNTIL ItemJournalLine3.NEXT = 0;
        //SSD_171123
        // IF ProdOrderLineRec.GET(ProdOrderLineRec.Status::Released, Rec."Document No.", Rec."Order Line No.") THEN
        //     ILE.Reset();
        // ILE.SetRange("Document No.", Rec."Order No.");
        // ILE.SetRange("Order Line No.", Rec."Order Line No.");
        // ILE.SetRange("Item No.", Rec."Item No.");
        // ILE.SetRange("Entry Type", ILE."Entry Type"::Output);
        // if ILE.FindSet() then begin
        //     ILE.CalcSums(Quantity);
        //     ItemJournalLine4.RESET;
        //     ItemJournalLine4.SETRANGE("Journal Template Name", Rec."Journal Template Name");
        //     ItemJournalLine4.SETRANGE("Journal Batch Name", Rec."Journal Batch Name");
        //     ItemJournalLine4.SETRANGE(ItemJournalLine4."Document No.", Rec."Document No.");
        //     ItemJournalLine4.SetRange("Entry Type", ItemJournalLine4."Entry Type"::Output);
        //     IF ItemJournalLine4.FindSet() THEN begin
        //         if (ProdOrderLineRec.Quantity - ILE.Quantity) > (ItemJournalLine4."Output Quantity") then
        //             Error('You can not post.');
        //     end;
        // end;
        //SSD_171123
        IF Rec.FINDSET THEN
            REPEAT
                IF Rec."Entry Type" = Rec."Entry Type"::Consumption THEN BEGIN
                    IF Rec.Quantity <> 0 THEN BEGIN
                        ReservationEntry.RESET;
                        ReservationEntry.SETRANGE("Item No.", Rec."Item No.");
                        ReservationEntry.SETRANGE("Source ID", Rec."Document No.");
                        ReservationEntry.SETRANGE("Location Code", Rec."Location Code");
                        ReservationEntry.SETRANGE(Positive, FALSE);
                        IF ReservationEntry.FINDFIRST THEN BEGIN
                            IF Location.GET(Rec."Location Code") THEN;
                            IF Item.GET(Rec."Item No.") THEN;
                            IF (Location."Phy. Bin Required") AND (Item."Phy. Bin Required") THEN BEGIN
                                IF ReservationEntry."QR Scanned" = FALSE THEN IF (Item."Item Category Code" <> 'STATIONARY') OR (Item."Item Category Code" <> 'PACKAGING') OR (Item."Item Category Code" <> 'CONSUMABLE') THEN ERROR(Text0000123, ReservationEntry."Item No.");
                            END;
                        END;
                    END;
                END;
            UNTIL Rec.NEXT = 0;
        ItemJournalLine3.RESET;
        ItemJournalLine3.SETRANGE("Journal Template Name", Rec."Journal Template Name");
        ItemJournalLine3.SETRANGE("Journal Batch Name", Rec."Journal Batch Name");
        ItemJournalLine3.SETRANGE(ItemJournalLine3."Document No.", Rec."Document No.");
        IF ItemJournalLine3.FINDFIRST THEN BEGIN
            IF Rec."Quality Required" THEN IF NOT Rec."Quality Done" THEN ERROR(STRSUBSTNO(Text003), Rec."Journal Template Name", Rec."Journal Batch Name", ItemJournalLine3."Line No.");  //IG_DS_Before
                                                                                                                                                                                           //  IF Rec."Quality Required" THEN IF NOT Rec."Sent for Quality" THEN ERROR(STRSUBSTNO(Text003), Rec."Journal Template Name", Rec."Journal Batch Name", ItemJournalLine3."Line No.");  //IG_DS_After
                                                                                                                                                                                           //CODEUNIT.RUN(CODEUNIT::"Item Jnl.-Post", ItemJournalLine3);
        END;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Production Journal Mgt", 'OnBeforeInsertConsumptionJnlLine', '', false, false)]
    local procedure SSDOnBeforeInsertConsumptionJnlLine(var ItemJournalLine: Record "Item Journal Line"; ProdOrderComp: Record "Prod. Order Component"; ProdOrderLine: Record "Prod. Order Line"; Level: Integer)
    var
        RecProdOrder: Record "Production Order";
        ProdBomLine: Record "Production BOM Line";
    begin
        if RecProdOrder.Get(ProdOrderComp.Status, ProdOrderComp."Prod. Order No.") then ItemJournalLine."Manufacturing Date New" := RecProdOrder."Manufacturing Date";
        ProdBomLine.RESET;
        ProdBomLine.SETRANGE(ProdBomLine."Production BOM No.", ProdOrderLine."Production BOM No.");
        ProdBomLine.SETRANGE(ProdBomLine."No.", ProdOrderComp."Item No.");
        IF ProdBomLine.FINDFIRST THEN BEGIN
            ItemJournalLine.VALIDATE("Location Code", ProdBomLine."Location Code");
            ItemJournalLine.VALIDATE("Bin Code", ProdBomLine."Bin Code");
        END;
        ItemJournalLine.VALIDATE(Quantity, ProdOrderComp."Qty. To Consume");
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Production Journal Mgt", 'OnBeforeInsertOutputJnlLine', '', false, false)]
    local procedure SSDOnBeforeInsertOutputJnlLine(var ItemJournalLine: Record "Item Journal Line"; ProdOrderRtngLine: Record "Prod. Order Routing Line"; ProdOrderLine: Record "Prod. Order Line")
    var
        RecProdOrder: Record "Production Order";
        ProdBomLine: Record "Production BOM Line";
        TotalTime: Decimal;
    begin
        if RecProdOrder.Get(ProdOrderRtngLine.Status, ProdOrderRtngLine."Prod. Order No.") then ItemJournalLine."Manufacturing Date New" := RecProdOrder."Manufacturing Date";
        ItemJournalLine.VALIDATE("Starting Time", ProdOrderLine."Starting Time");
        ItemJournalLine.VALIDATE("Ending Time", ProdOrderLine."Ending Time");
        TotalTime := ProdOrderRtngLine."Expected Capacity Need"; //"Ending Date-Time" - "Starting Date-Time";  //Alle 03012021
        ItemJournalLine."Run Time" := TotalTime / 60000;
        ItemJournalLine.VALIDATE(ItemJournalLine."Run Time");
        ItemJournalLine."Quality Template Master" := ProdOrderRtngLine."Quality Template Master";
        ItemJournalLine."Quality Required" := ProdOrderRtngLine."Quality Required";
        ItemJournalLine."Sent for Quality" := ProdOrderRtngLine."Sent for Quality";
        ItemJournalLine."Quality Done" := ProdOrderRtngLine."Quality Done";
        ItemJournalLine."Posted Quantity" := ProdOrderLine.Quantity - ItemJournalLine."Output Quantity";
        ItemJournalLine."Sample Qty. Sent to QC" := ProdOrderRtngLine."Sample Quantity";
    end;

    [EventSubscriber(ObjectType::Table, Database::"Tracking Specification", 'OnAfterInitFromProdOrderComp', '', false, false)]
    local procedure SSDOnAfterInitFromProdOrderComp(var TrackingSpecification: Record "Tracking Specification"; ProdOrderComponent: Record "Prod. Order Component")
    begin
        TrackingSpecification."Quantity (Base)" := ProdOrderComponent."Qty. To Consume";
        TrackingSpecification."Qty. to Handle" := ProdOrderComponent."Qty. To Consume";
        TrackingSpecification."Qty. to Handle (Base)" := ProdOrderComponent."Qty. To Consume";
        TrackingSpecification."Qty. to Invoice" := ProdOrderComponent."Qty. To Consume";
        TrackingSpecification."Qty. to Invoice (Base)" := ProdOrderComponent."Qty. To Consume";
        //TrackingSpecification."Quantity Handled (Base)" := ProdOrderComponent."Expected Qty. (Base)" - ProdOrderComponent."Remaining Qty. (Base)";
        //TrackingSpecification."Quantity Invoiced (Base)" := ProdOrderComponent."Expected Qty. (Base)" - ProdOrderComponent."Remaining Qty. (Base)";
    end;

    var
        C: Codeunit "Prod. Order Status Management";
}
