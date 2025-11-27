codeunit 50148 "SSD Warehouse Subscribers"
{
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales Warehouse Mgt.", OnBeforeCreateShptLineFromSalesLine, '', false, false)]
    local procedure "Sales Warehouse Mgt._OnBeforeCreateShptLineFromSalesLine"(var WarehouseShipmentLine: Record "Warehouse Shipment Line"; WarehouseShipmentHeader: Record "Warehouse Shipment Header"; SalesLine: Record "Sales Line"; SalesHeader: Record "Sales Header")
    // begin
    // end;

    //     [EventSubscriber(ObjectType::Codeunit, Codeunit::"Whse.-Create Source Document", 'OnBeforeCreateShptLineFromSalesLine', '', false, false)] //IG_DS_before
    //     local procedure SSDOnBeforeCreateShptLineFromSalesLine(var WarehouseShipmentLine: Record "Warehouse Shipment Line"; SalesLine: Record "Sales Line")
    var
    begin
        WarehouseShipmentLine."Shortcut Dimension 1 Code" := SalesLine."Shortcut Dimension 1 Code";
        WarehouseShipmentLine."Shortcut Dimension 2 Code" := SalesLine."Shortcut Dimension 2 Code";
        WarehouseShipmentLine."Responsibility Center" := SalesLine."Responsibility Center";
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales Warehouse Mgt.", OnSalesLine2ReceiptLineOnBeforeUpdateReceiptLine, '', false, false)]
    local procedure "Sales Warehouse Mgt._OnSalesLine2ReceiptLineOnBeforeUpdateReceiptLine"(var WarehouseReceiptLine: Record "Warehouse Receipt Line"; SalesLine: Record "Sales Line")
    // begin
    // end;

    // [EventSubscriber(ObjectType::Codeunit, Codeunit::"Whse.-Create Source Document", 'OnSalesLine2ReceiptLineOnBeforeUpdateReceiptLine', '', false, false)]  //IG_DS_before
    // local procedure SSDOnSalesLine2ReceiptLineOnBeforeUpdateReceiptLine(var WarehouseReceiptLine: Record "Warehouse Receipt Line"; SalesLine: Record "Sales Line")
    begin
        WarehouseReceiptLine.VALIDATE("Qty. On Invoice", ABS(SalesLine.Quantity));
        WarehouseReceiptLine.VALIDATE("Actual Qty. to Receive", ABS(SalesLine.Quantity));
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales Warehouse Mgt.", OnAfterCreateRcptLineFromSalesLine, '', false, false)]
    local procedure "Sales Warehouse Mgt._OnAfterCreateRcptLineFromSalesLine"(var WarehouseReceiptLine: Record "Warehouse Receipt Line"; WarehouseReceiptHeader: Record "Warehouse Receipt Header"; SalesLine: Record "Sales Line")
    // begin
    // end;

    // [EventSubscriber(ObjectType::Codeunit, Codeunit::"Whse.-Create Source Document", 'OnAfterCreateRcptLineFromSalesLine', '', false, false)]  //IG_DS_before
    // local procedure SSDOnAfterCreateRcptLineFromSalesLine(var WarehouseReceiptLine: Record "Warehouse Receipt Line"; SalesLine: Record "Sales Line")
    var
        Item: Record Item;
    begin
        IF Item.GET(WarehouseReceiptLine."Item No.") THEN WarehouseReceiptLine."Quality Required" := Item."Quality Required";
        WarehouseReceiptLine."Party Type" := "Party Type"::Customer;
        WarehouseReceiptLine."Party No." := SalesLine."Sell-to Customer No.";
        WarehouseReceiptLine."Qty. On Purch. Order" := SalesLine.Quantity;
        WarehouseReceiptLine."Shortcut Dimension 1 Code" := SalesLine."Shortcut Dimension 1 Code";
        WarehouseReceiptLine."Shortcut Dimension 2 Code" := SalesLine."Shortcut Dimension 2 Code";
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purchases Warehouse Mgt.", OnFromPurchLine2ShptLineOnBeforeCreateShptLine, '', false, false)]
    local procedure "Purchases Warehouse Mgt._OnFromPurchLine2ShptLineOnBeforeCreateShptLine"(var WarehouseShipmentLine: Record "Warehouse Shipment Line"; WarehouseShipmentHeader: Record "Warehouse Shipment Header"; PurchaseLine: Record "Purchase Line")
    // begin
    // end;

    // [EventSubscriber(ObjectType::Codeunit, Codeunit::"Whse.-Create Source Document", 'OnFromPurchLine2ShptLineOnBeforeCreateShptLine', '', false, false)]  //IG_DS_before
    // local procedure SSDOnFromPurchLine2ShptLineOnBeforeCreateShptLine(var WarehouseShipmentLine: Record "Warehouse Shipment Line"; WarehouseShipmentHeader: Record "Warehouse Shipment Header"; PurchaseLine: Record "Purchase Line")
    begin
        WarehouseShipmentLine."Shortcut Dimension 1 Code" := PurchaseLine."Shortcut Dimension 1 Code";
        WarehouseShipmentLine."Shortcut Dimension 2 Code" := PurchaseLine."Shortcut Dimension 2 Code";
    end;

    [IntegrationEvent(false, false)]
    local procedure OnWarehouseReceiptLineQtyUpdate(var WhseReceiptLine: Record "Warehouse Receipt Line"; PurchaseLine: Record "Purchase Line"; var ExtensionIsHandled: Boolean)
    begin
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purchases Warehouse Mgt.", OnPurchLine2ReceiptLineOnAfterInitNewLine, '', false, false)]
    local procedure "Purchases Warehouse Mgt._OnPurchLine2ReceiptLineOnAfterInitNewLine"(var WarehouseReceiptLine: Record "Warehouse Receipt Line"; WarehouseReceiptHeader: Record "Warehouse Receipt Header"; PurchaseLine: Record "Purchase Line"; var IsHandled: Boolean)
    // begin
    // end;

    // [EventSubscriber(ObjectType::Codeunit, Codeunit::"Whse.-Create Source Document", 'OnPurchLine2ReceiptLineOnAfterInitNewLine', '', false, false)]  //IG_DS_before
    // local procedure SSDOnPurchLine2ReceiptLineOnAfterInitNewLine(var WhseReceiptLine: Record "Warehouse Receipt Line"; PurchaseLine: Record "Purchase Line"; var IsHandled: Boolean)
    var
        Item: Record Item;
        PostedGateLineLocal: Record "SSD Posted Gate Line";
        WhseReceiptHeader2: Record "Warehouse Receipt Header";
        WhseReceiptHeader3: Record "Warehouse Receipt Header";
        ExtensionIsHandled: Boolean;
    begin
        if PurchaseLine."Document Type" <> PurchaseLine."Document Type"::Order then exit;
        IF Item.GET(WarehouseReceiptLine."Item No.") THEN WarehouseReceiptLine."Quality Required" := Item."Quality Required";
        WarehouseReceiptLine."Party Type" := "Party Type"::Vendor;
        WarehouseReceiptLine."Party No." := PurchaseLine."Buy-from Vendor No.";
        WarehouseReceiptLine."Qty. On Purch. Order" := PurchaseLine.Quantity;
        WarehouseReceiptLine."Shortcut Dimension 1 Code" := PurchaseLine."Shortcut Dimension 1 Code";
        WarehouseReceiptLine."Shortcut Dimension 2 Code" := PurchaseLine."Shortcut Dimension 2 Code";
        WarehouseReceiptLine."Description 3" := PurchaseLine."Description 3";
        WarehouseReceiptLine."Customer No." := PurchaseLine."Customer No."; //ALLE-TRA1.0
        WarehouseReceiptLine."SalesPerson Code" := PurchaseLine."SalesPerson Code"; //ALLE-TRA1.0
        WarehouseReceiptLine."Vendor Item Description" := PurchaseLine."Vendor Item Description"; //Sunil
        WarehouseReceiptLine."Direct Unit Cost" := PurchaseLine."Direct Unit Cost";
        OnWarehouseReceiptLineQtyUpdate(WarehouseReceiptLine, PurchaseLine, ExtensionIsHandled);
        if ExtensionIsHandled then exit;
        IF GateEntryLineFound(PurchaseLine) THEN begin
            IF PostedGateLineLocal.GET(PurchaseLine."Gate Entry no.", PurchaseLine."Gate Line No.") THEN BEGIN
                WarehouseReceiptLine.Validate("Qty. Received", ABS(PurchaseLine."Quantity Received"));
                WarehouseReceiptLine."Qty. On Invoice" := ABS(PostedGateLineLocal."Challan Quantity");
                WarehouseReceiptLine.VALIDATE("Actual Qty. to Receive", ABS(PostedGateLineLocal."Challan Quantity"));
                WarehouseReceiptLine."Gate Entry no." := PurchaseLine."Gate Entry no.";
                WarehouseReceiptLine."Gate Line No." := PurchaseLine."Gate Line No.";
                WarehouseReceiptLine."Purchase Price" := PurchaseLine."Direct Unit Cost"; // Alle VPB
                WhseReceiptHeader2.Get(WarehouseReceiptLine."No.");
                WhseReceiptHeader2."Gate Entry no." := PurchaseLine."Gate Entry no.";
                WhseReceiptHeader2."Gate Entry Date" := PurchaseLine."Gate Entry Date";
                WhseReceiptHeader2.MODIFY;
                PostedGateLineLocal."WH Receipt No." := WarehouseReceiptLine."No.";
                PostedGateLineLocal."WH Receipt Line No." := WarehouseReceiptLine."Line No.";
                PostedGateLineLocal.MODIFY;
            END;
        end
        else
            WarehouseReceiptLine.Validate("Qty. Received", 0);
        IsHandled := true;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Transfer Warehouse Mgt.", OnFromTransLine2ShptLineOnAfterInitNewLine, '', false, false)]
    local procedure "Transfer Warehouse Mgt._OnFromTransLine2ShptLineOnAfterInitNewLine"(var WarehouseShipmentLine: Record "Warehouse Shipment Line"; WarehouseShipmentHeader: Record "Warehouse Shipment Header"; TransferLine: Record "Transfer Line"; var IsHandled: Boolean)
    // begin
    // end;

    // [EventSubscriber(ObjectType::Codeunit, Codeunit::"Whse.-Create Source Document", 'OnFromTransLine2ShptLineOnAfterInitNewLine', '', false, false)]  //IG_DS_before
    // local procedure SSDOnFromTransLine2ShptLineOnAfterInitNewLine(var WhseShptLine: Record "Warehouse Shipment Line"; WhseShptHeader: Record "Warehouse Shipment Header"; TransferLine: Record "Transfer Line")
    begin
        WarehouseShipmentLine."Shortcut Dimension 1 Code" := TransferLine."Shortcut Dimension 1 Code";
        WarehouseShipmentLine."Shortcut Dimension 2 Code" := TransferLine."Shortcut Dimension 2 Code";
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Transfer Warehouse Mgt.", OnBeforeUpdateRcptLineFromTransLine, '', false, false)]
    local procedure "Transfer Warehouse Mgt._OnBeforeUpdateRcptLineFromTransLine"(var WarehouseReceiptLine: Record "Warehouse Receipt Line"; TransferLine: Record "Transfer Line")
    // begin
    // end;

    // [EventSubscriber(ObjectType::Codeunit, Codeunit::"Whse.-Create Source Document", 'OnBeforeUpdateRcptLineFromTransLine', '', false, false)]  //IG_DS_before
    // local procedure SSDOnBeforeUpdateRcptLineFromTransLine(var WarehouseReceiptLine: Record "Warehouse Receipt Line"; TransferLine: Record "Transfer Line")
    var
        Item: Record Item;
    begin
        WarehouseReceiptLine.VALIDATE("Qty. On Invoice", TransferLine."Quantity Received" + TransferLine."Qty. in Transit");
        WarehouseReceiptLine.VALIDATE("Actual Qty. to Receive", TransferLine."Quantity Received" + TransferLine."Qty. in Transit");
        IF Item.GET(WarehouseReceiptLine."Item No.") THEN WarehouseReceiptLine."Quality Required" := Item."Quality Required";
        WarehouseReceiptLine."Shortcut Dimension 1 Code" := TransferLine."Shortcut Dimension 1 Code";
        WarehouseReceiptLine."Shortcut Dimension 2 Code" := TransferLine."Shortcut Dimension 2 Code";
    end;
    //OnBeforeUpdateRcptLineFromTransLine
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Whse.-Post Receipt", 'OnCodeOnAfterGetWhseRcptHeader', '', false, false)]
    local procedure SSDOnCodeOnAfterGetWhseRcptHeader(var WarehouseReceiptHeader: Record "Warehouse Receipt Header")
    begin
        WarehouseReceiptHeader."Actual Posted Date" := CurrentDateTime;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Whse.-Post Receipt", 'OnInitSourceDocumentHeaderOnBeforePurchHeaderModify', '', false, false)]
    local procedure SSDOnInitSourceDocumentHeaderOnBeforePurchHeaderModify(var PurchaseHeader: Record "Purchase Header"; var WarehouseReceiptHeader: Record "Warehouse Receipt Header")
    begin
        PurchaseHeader.Validate("Actual Posted Date", WarehouseReceiptHeader."Actual Posted Date");
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Whse.-Post Receipt", 'OnBeforePostedWhseRcptLineInsert', '', false, false)]
    local procedure SSDOnBeforePostedWhseRcptLineInsert(var PostedWhseReceiptLine: Record "Posted Whse. Receipt Line"; WarehouseReceiptLine: Record "Warehouse Receipt Line")
    var
        PostedWhseReceiptHdr: Record "Posted Whse. Receipt Header";
    begin
        PostedWhseReceiptLine."Posted Source Line No." := WarehouseReceiptLine."Posted Source Line No.";
        PostedWhseReceiptLine."Vendor Item Description" := WarehouseReceiptLine."Vendor Item Description";
        PostedWhseReceiptLine."Direct Unit Cost" := WarehouseReceiptLine."Direct Unit Cost";
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Whse.-Post Receipt", 'OnInitSourceDocumentLinesOnAfterSourcePurchLineFound', '', false, false)]
    local procedure SSDOnInitSourceDocumentLinesOnAfterSourcePurchLineFound(var PurchaseLine: Record "Purchase Line"; WhseRcptLine: Record "Warehouse Receipt Line"; var ModifyLine: Boolean; WhseRcptHeader: Record "Warehouse Receipt Header")
    var
        PostedQOrdHdrLocal: Record "SSD Posted Quality Order Hdr";
    begin
        if WhseRcptLine."Source Document" <> WhseRcptLine."Source Document"::"Purchase Order" then exit;
        if ModifyLine then begin
            PurchaseLine."Posted Quality Order No." := WhseRcptLine."Posted Quality Order No.";
            IF PostedQOrdHdrLocal.GET(WhseRcptLine."Posted Quality Order No.") THEN BEGIN
                PurchaseLine."Quality Defect Code" := PostedQOrdHdrLocal."Defect Code";
                PurchaseLine."Concerted Quality" := PostedQOrdHdrLocal."Concerted Quality";
                PurchaseLine."Vendor Claim Code" := PostedQOrdHdrLocal."Vendor Claim Code";
            END;
            PurchaseLine."Accepted Qty." := WhseRcptLine."Accepted Qty.";
            PurchaseLine."Rejected Qty." := WhseRcptLine."Rejected Qty.";
            PurchaseLine."Reject Location Code" := WhseRcptLine."Reject Location Code";
            PurchaseLine."Reject Bin Code" := WhseRcptLine."Reject Bin Code";
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Whse.-Post Receipt", 'OnBeforePostUpdateWhseRcptLine', '', false, false)]
    local procedure SSDOnBeforePostUpdateWhseRcptLine(var DeleteWhseRcptLine: Boolean)
    begin
        DeleteWhseRcptLine := true;
    end;
    //OnBeforePostUpdateWhseRcptLine
    local procedure GateEntryLineFound(PurchaseLine: Record "Purchase Line"): Boolean
    var
        PostedGateLine: Record "SSD Posted Gate Line";
    begin
        IF (PurchaseLine."Gate Entry no." = '') OR (PurchaseLine."Gate Line No." = 0) THEN EXIT(FALSE);
        IF PostedGateLine.GET(PurchaseLine."Gate Entry no.", PurchaseLine."Gate Line No.") THEN BEGIN
            IF PostedGateLine."WH Receipt No." = '' THEN
                EXIT(TRUE)
            ELSE
                EXIT(FALSE)
        END
        ELSE
            EXIT(FALSE);
    end;
}
