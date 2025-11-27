codeunit 50142 "SSD Req. Line Subscribers"
{
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Carry Out Action", 'OnPurchOrderChgAndResheduleOnBeforePurchLineModify', '', false, false)]
    local procedure SSDOnPurchOrderChgAndResheduleOnBeforePurchLineModify(var ReqLine: Record "Requisition Line"; var PurchLine: Record "Purchase Line")
    begin
        PurchLine.VALIDATE("MRP Qty.", ReqLine.Quantity);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Carry Out Action", 'OnInsertProdOrderWithReqLine', '', false, false)]
    local procedure SSDOnInsertProdOrderWithReqLine(var ProductionOrder: Record "Production Order"; var RequisitionLine: Record "Requisition Line")
    begin
        ProductionOrder."Order Created from MRP" := TRUE;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Carry Out Action", 'OnAfterInsertProdOrder', '', false, false)]
    local procedure SSDOnAfterInsertProdOrder(var ProductionOrder: Record "Production Order"; ProdOrderChoice: Integer; var RequisitionLine: Record "Requisition Line")
    begin
        RequisitionLine.ArchivePlannedProdOrder(ProductionOrder);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Carry Out Action", 'OnInsertTransHeaderOnBeforeTransHeaderModify', '', false, false)]
    local procedure SSDOnInsertTransHeaderOnBeforeTransHeaderModify(var TransHeader: Record "Transfer Header"; ReqLine: Record "Requisition Line")
    begin
        TransHeader."Order Created from MRP" := true;
    end;

    [EventSubscriber(ObjectType::Table, Database::"Requisition Line", 'OnAfterCopyFromItem', '', false, false)]
    local procedure SSDOnAfterCopyFromItem(var RequisitionLine: Record "Requisition Line"; Item: Record Item; CurrentFieldNo: Integer)
    begin
        RequisitionLine."Vendor No." := Item."Vendor No.";
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Req. Wksh.-Make Order", 'OnBeforePurchOrderHeaderInsert', '', false, false)]
    local procedure SSDOnBeforePurchOrderHeaderInsert(var PurchaseHeader: Record "Purchase Header"; RequisitionLine: Record "Requisition Line")
    var
        PurchasesPayablesSetup: Record "Purchases & Payables Setup";
        Item: Record Item;
        NoSeriesMgt: Codeunit "No. Series";//IG_DS NoSeriesManagement;
    begin
        PurchasesPayablesSetup.GET;
        IF (RequisitionLine."Action Message" = RequisitionLine."Action Message"::New) AND (RequisitionLine."Ref. Order Type" = RequisitionLine."Ref. Order Type"::Purchase) THEN BEGIN
            Item.GET(RequisitionLine."No.");
            IF Item."Procurement Type" = Item."Procurement Type"::Import THEN BEGIN
                PurchaseHeader."No." := NoSeriesMgt.GetNextNo(PurchasesPayablesSetup."Import PO", RequisitionLine."Due Date", TRUE);
                PurchaseHeader."No. Series" := PurchasesPayablesSetup."Import PO";
            END
            ELSE BEGIN
                PurchaseHeader."No." := NoSeriesMgt.GetNextNo(PurchasesPayablesSetup."Order Nos.", RequisitionLine."Due Date", TRUE);
                PurchaseHeader."No. Series" := PurchasesPayablesSetup."Order Nos.";
            END;
        END;
        PurchaseHeader."Order Created from MRP" := TRUE; //ALLE SS 
    end;
}
