codeunit 50350 "SSD Item Charge Price Mgt"
{
    [EventSubscriber(ObjectType::Table, Database::"Purchase Line", 'OnUpdateDirectUnitCostByFieldOnBeforeUpdateItemReference', '', false, false)]
    local procedure SSDOnAfterFindPurchLinePrice(var PurchaseLine: Record "Purchase Line"; var CalledByFieldNo: Integer)
    var
        PurchaseHeader: Record "Purchase Header";
        ItemChargePrice: Record "SSD Item Charge Price";
    begin
        if PurchaseLine.Type <> PurchaseLine.Type::"Charge (Item)" then exit;
        PurchaseHeader:=PurchaseLine.GetPurchHeader();
        ItemChargePrice.Reset();
        ItemChargePrice.SetRange("Charge No.", PurchaseLine."No.");
        ItemChargePrice.SetRange("Vendor No.", PurchaseHeader."Buy-from Vendor No.");
        ItemChargePrice.SetFilter("Ending Date", '%1|>=%2', 0D, PurchaseHeader."Posting Date");
        ItemChargePrice.SetRange("Starting Date", 0D, PurchaseHeader."Posting Date");
        ItemChargePrice.SetFilter("Currency Code", '%1|%2', PurchaseHeader."Currency Code", '');
        if ItemChargePrice.FindFirst()then PurchaseLine."Direct Unit Cost":=ItemChargePrice."Direct Unit Cost"
        else
            PurchaseLine."Direct Unit Cost":=0;
    end;
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post (Yes/No)", 'OnAfterConfirmPost', '', false, false)]
    local procedure SSDOnAfterConfirmPost(var PurchaseHeader: Record "Purchase Header")
    var
        PurchaseLine: Record "Purchase Line";
    begin
        if PurchaseHeader."Document Type" <> PurchaseHeader."Document Type"::Order then exit;
        if not PurchaseHeader.Receive then exit;
        PurchaseLine.Reset();
        PurchaseLine.SetRange("Document Type", PurchaseHeader."Document Type");
        PurchaseLine.SetRange("Document No.", PurchaseHeader."No.");
        PurchaseLine.SetRange(Type, PurchaseLine.Type::"Charge (Item)");
        PurchaseLine.SetFilter("Qty. to Receive", '<>%1', 0);
        if not PurchaseLine.FindSet()then exit
        else
        begin
            PurchaseLine.CalcFields("Qty. to Assign");
            if PurchaseLine."Qty. to Assign" <> PurchaseLine."Qty. to Receive" then Error('Complete receipt quantity is not assigned. ');
        end;
    end;
}
