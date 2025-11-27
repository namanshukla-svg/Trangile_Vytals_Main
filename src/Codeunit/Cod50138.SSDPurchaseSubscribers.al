codeunit 50138 "SSD Purchase Subscribers"
{
    [EventSubscriber(ObjectType::Table, Database::"Purch. Rcpt. Line", 'OnBeforeInsertInvLineFromRcptLine', '', false, false)]
    local procedure SSDOnBeforeInsertInvLineFromRcptLine(var PurchRcptLine: Record "Purch. Rcpt. Line"; var PurchLine: Record "Purchase Line"; PurchOrderLine: Record "Purchase Line"; var IsHandled: Boolean)
    var
        PurchaseHeader: Record "Purchase Header";
        RecPostedWhseReceiptHeader: Record "Posted Whse. Receipt Header";
        SSDValidations: Codeunit Validation;
    begin
        PurchLine."Order No." := PurchRcptLine."Order No.";
        PurchLine."Order Line No." := PurchRcptLine."Order Line No.";
        PurchaseHeader.GET(PurchLine."Document Type", PurchLine."Document No.");
        PurchLine."Document Subtype" := PurchaseHeader."Document Subtype";
        PurchLine."Blanket Order No." := PurchRcptLine."Blanket Order No.";
        PurchLine."Blanket Order Line No." := PurchRcptLine."Blanket Order Line No.";
        PurchLine."Expected Receipt Date" := PurchRcptLine."Expected Receipt Date";
        PurchLine."Requested Receipt Date" := PurchRcptLine."Requested Receipt Date";
        PurchLine."Promised Receipt Date" := PurchRcptLine."Promised Receipt Date";
        PurchLine."Planned Receipt Date" := PurchRcptLine."Planned Receipt Date";
        PurchLine."Accepted Qty." := PurchRcptLine."Accepted Qty.";
        PurchLine."Rejected Qty." := PurchRcptLine."Rejected Qty.";
        PurchLine."Posted Quality Order No." := PurchRcptLine."Posted Quality Order No.";
        PurchLine."SSD Deduction Amount" := PurchRcptLine."SSD Deduction Amount";
        PurchLine."SSD Deduction Remarks" := PurchRcptLine."SSD Deduction Remarks";
        RecPostedWhseReceiptHeader.Reset();
        RecPostedWhseReceiptHeader.SETRANGE(RecPostedWhseReceiptHeader."No.", PurchRcptLine."Posted Whse. Rcpt No.");
        if RecPostedWhseReceiptHeader.FindFirst() then begin
            PurchLine."Gate Entry no." := RecPostedWhseReceiptHeader."Gate Entry no.";
            PurchLine."Gate Entry Date" := RecPostedWhseReceiptHeader."Gate Entry Date";
            //"GateEntryNO." := RecPostedWhseReceiptHeader."Gate Entry no.";
            //GateEntryDate := RecPostedWhseReceiptHeader."Gate Entry Date";
        end;
        SSDValidations.GetAccountDetails(PurchLine);
    end;

    [EventSubscriber(ObjectType::codeunit, Codeunit::"Purch.-Get Receipt", 'OnAfterInsertLines', '', false, false)]
    local procedure SSDOnAfterInsertLines(var PurchHeader: Record "Purchase Header")
    var
        OrderPurchaseHeader: Record "Purchase Header";
        PurchaseLine: Record "Purchase Line";
        PostedGateHeader: Record "SSD Posted Gate Header";
        PaymentTerms: Record "Payment Terms";
        VendLedgerEntry: Record "Vendor Ledger Entry";
        PurchRcptHeader: Record "Purch. Rcpt. Header";
        ReceiptErrorLbl: Label 'You can select only Order Type %1 GRN/SRN';
        DocumentAttachment: Record "Document Attachment";
        DocumentAttachment2: Record "Document Attachment";
        ReceiptErrorLbl2: Label 'Receipt received by Finance field should be marked true on Posted Purchase Receipt No. %1';
    begin
        Clear(PaymentTerms);
        PurchaseLine.Reset();
        PurchaseLine.SetRange("Document Type", PurchHeader."Document Type");
        PurchaseLine.SetRange("Document No.", PurchHeader."No.");
        PurchaseLine.SetFilter("Receipt No.", '<>%1', '');
        if PurchaseLine.FindFirst() then begin
            if OrderPurchaseHeader.Get(OrderPurchaseHeader."Document Type"::Order, PurchaseLine."Order No.") then;
            PurchRcptHeader.Get(PurchaseLine."Receipt No.");
            IF PurchRcptHeader."Receipt recvd  by Fin" = false then Error(ReceiptErrorLbl2, PurchRcptHeader."No.");
            //SSD_020324
            if PurchHeader."SSD Order Type" <> PurchRcptHeader."SSD Order Type" then Error(ReceiptErrorLbl, PurchHeader."SSD Order Type");
            //SSD_020324
            PurchHeader."SSD Order Type" := PurchRcptHeader."SSD Order Type";
            PostedGateHeader.Reset();
            PostedGateHeader.SetRange("No.", PurchaseLine."Gate Entry no.");
            PostedGateHeader.SetRange("Posting Date", PurchaseLine."Gate Entry Date");
            if PostedGateHeader.FindFirst() then begin
                PurchHeader."Vendor Invoice No." := PostedGateHeader."Bill No.";
                PurchHeader."Vendor Invoice Date" := PostedGateHeader."Bill Date";
                PurchHeader."Invoice Amount" := PostedGateHeader."Bill Amount";
                if OrderPurchaseHeader."Payment Terms Code" <> '' then begin
                    PurchHeader."Payment Terms Code" := OrderPurchaseHeader."Payment Terms Code";
                    PaymentTerms.Get(OrderPurchaseHeader."Payment Terms Code");
                    PurchHeader."Due Date" := CalcDate(PaymentTerms."Due Date Calculation", PurchaseLine."Gate Entry Date");
                    PurchHeader."Pmt. Discount Date" := CalcDate(PaymentTerms."Discount Date Calculation", PurchaseLine."Gate Entry Date");
                    PurchHeader.Validate("Payment Terms Code");
                end;
            end
            else begin
                PurchHeader."Payment Terms Code" := OrderPurchaseHeader."Payment Terms Code";
                PurchHeader.Validate("Payment Terms Code");
                PurchHeader."Vendor Invoice No." := PurchRcptHeader."Vendor Shipment No.";
                PurchHeader."Vendor Invoice Date" := PurchRcptHeader."Vendor Invoice Date";
                PurchHeader."Invoice Amount" := PurchRcptHeader."Invoice Amount";
                PurchHeader."Original Invoice Amount" := PurchRcptHeader."Invoice Amount";
            end;
            PurchHeader."Vendor Order No." := PurchaseLine."Order No.";
            PurchHeader."SSD Deduction Amount" := GetDeductionAmount(PurchHeader);
            PurchHeader."Deduction Reason" := GetDeductionReason(PurchHeader);
            VendLedgerEntry.Reset();
            VendLedgerEntry.SetRange("Vendor No.", PurchHeader."Buy-from Vendor No.");
            VendLedgerEntry.SetRange("PO No.", PurchaseLine."Order No.");
            VendLedgerEntry.SetFilter("Document Type", '%1|%2', VendLedgerEntry."Document Type"::" ", VendLedgerEntry."Document Type"::Payment);
            VendLedgerEntry.SetRange(Open, true);
            if VendLedgerEntry.FindFirst() then begin
                VendLedgerEntry."Applies-to Doc. Type" := VendLedgerEntry."Document Type";
                VendLedgerEntry."Applies-to Doc. No." := VendLedgerEntry."Document No.";
            end;
            PurchHeader."Posting Date" := PurchRcptHeader."Posting Date";
            PurchHeader.Modify();
            //SSD_DocumentAttachment
            DocumentAttachment.Reset();
            DocumentAttachment.SetRange("Table ID", Database::"Purch. Rcpt. Header");
            DocumentAttachment.SetRange("No.", PurchRcptHeader."No.");
            if DocumentAttachment.FindSet() then
                repeat
                    DocumentAttachment2.Init();
                    DocumentAttachment2.TransferFields(DocumentAttachment);
                    DocumentAttachment2."Table ID" := Database::"Purchase Header";
                    DocumentAttachment2."No." := PurchHeader."No.";
                    DocumentAttachment2."Document Type" := PurchHeader."Document Type"::Invoice;
                    DocumentAttachment2.Insert();
                until DocumentAttachment.Next() = 0;
            DocumentAttachment.Reset();
            DocumentAttachment.SetRange("Table ID", Database::"Purchase Header");
            DocumentAttachment.SetRange("No.", PurchHeader."Vendor Order No.");
            if DocumentAttachment.FindSet() then
                repeat
                    DocumentAttachment2.Init();
                    DocumentAttachment2.TransferFields(DocumentAttachment);
                    DocumentAttachment2."Table ID" := Database::"Purchase Header";
                    DocumentAttachment2."No." := PurchHeader."No.";
                    DocumentAttachment2."Document Type" := PurchHeader."Document Type"::Invoice;
                    DocumentAttachment2.Insert();
                until DocumentAttachment.Next() = 0;
            // //SSD_DocumentAttachment
        end;
    end;

    local procedure GetDeductionAmount(PurchaseHeader6: Record "Purchase Header") TotalDeductionAmount: Decimal
    var
        PurchaseLine: Record "Purchase Line";
    begin
        TotalDeductionAmount := 0;
        PurchaseLine.Reset();
        PurchaseLine.SetRange("Document Type", PurchaseHeader6."Document Type");
        PurchaseLine.SetRange("Document No.", PurchaseHeader6."No.");
        PurchaseLine.SetFilter("Receipt No.", '<>%1', '');
        if PurchaseLine.FindSet() then
            repeat
                TotalDeductionAmount += PurchaseLine."SSD Deduction Amount";
            until PurchaseLine.Next() = 0;
    end;

    local procedure GetDeductionReason(PurchaseHeader7: Record "Purchase Header") DeductionReason: Text[200]
    var
        PurchaseLine: Record "Purchase Line";
    begin
        PurchaseLine.Reset();
        PurchaseLine.SetRange("Document Type", PurchaseHeader7."Document Type");
        PurchaseLine.SetRange("Document No.", PurchaseHeader7."No.");
        PurchaseLine.SetFilter("Receipt No.", '<>%1', '');
        PurchaseLine.SetFilter("SSD Deduction Remarks", '<>%1', '');
        if PurchaseLine.Findfirst() then DeductionReason := PurchaseLine."SSD Deduction Remarks";
    end;

    [EventSubscriber(ObjectType::Table, Database::"Purchase Header", 'OnValidatePaymentTermsCodeOnBeforeCalcDueDate', '', false, false)]
    local procedure SSDOnValidatePaymentTermsCodeOnBeforeCalcDueDate(var PurchaseHeader: Record "Purchase Header"; var IsHandled: Boolean)
    var
        Vendor: Record Vendor;
        PurchaseLine: Record "Purchase Line";
        PostedGateHeader: Record "SSD Posted Gate Header";
        PurchRcptHeader: Record "Purch. Rcpt. Header";
        PaymentTerms: Record "Payment Terms";
    begin
        if PurchaseHeader."Document Type" <> PurchaseHeader."Document Type"::Invoice then exit;
        PaymentTerms.Get(PurchaseHeader."Payment Terms Code");
        if Vendor.Get(PurchaseHeader."Buy-from Vendor No.") then begin
            PurchaseLine.SetRange("Document Type", PurchaseHeader."Document Type");
            PurchaseLine.SetRange("Document No.", PurchaseHeader."No.");
            PurchaseLine.SetRange(Type, PurchaseLine.Type::Item);
            if PurchaseLine.FindFirst() then if PostedGateHeader.Get(PurchaseLine."Gate Entry no.") then PurchaseHeader."Document Date" := PostedGateHeader."Bill Date";
            Vendor.TestField("Vendor Due Basis");
            case Vendor."Vendor Due Basis" of
                Vendor."Vendor Due Basis"::"Document date":
                    begin
                        if PurchaseLine.FindFirst() then
                            if PurchRcptHeader.Get(PurchaseLine."Receipt No.") then begin
                                PurchaseHeader."Due Date" := CALCDATE(PaymentTerms."Due Date Calculation", PurchRcptHeader."Posting Date");
                                PurchaseHeader."Pmt. Discount Date" := CALCDATE(PaymentTerms."Discount Date Calculation", PurchRcptHeader."Posting Date");
                            end;
                        if PurchaseHeader."Invoice Type Old" = PurchaseHeader."Invoice Type Old"::"Expense Voucher" then begin
                            if PurchaseHeader."Posting Date" <> 0D then PurchaseHeader."Due Date" := CALCDATE(PaymentTerms."Due Date Calculation", PurchaseHeader."Posting Date");
                            PurchaseHeader."Pmt. Discount Date" := CALCDATE(PaymentTerms."Discount Date Calculation", PurchaseHeader."Posting Date");
                        end;
                    end;
                Vendor."Vendor Due Basis"::"Vendor Invoice Date":
                    begin
                        if PurchaseHeader."Vendor Invoice Date" <> 0D then
                            PurchaseHeader."Due Date" := CALCDATE(PaymentTerms."Due Date Calculation", PurchaseHeader."Vendor Invoice Date")
                        else
                            PurchaseHeader."Due Date" := CALCDATE(PaymentTerms."Due Date Calculation", PurchaseHeader."Document Date");
                        PurchaseHeader."Pmt. Discount Date" := CALCDATE(PaymentTerms."Discount Date Calculation", PurchaseHeader."Document Date");
                    end;
            end;
        end;
        IsHandled := true;
    end;

    [EventSubscriber(ObjectType::Table, Database::"Purchase Header", 'OnUpdatePurchLinesByChangedFieldName', '', false, false)]
    local procedure SSDOnUpdatePurchLinesByChangedFieldName(PurchHeader: Record "Purchase Header"; var PurchLine: Record "Purchase Line"; ChangedFieldName: Text[100]; ChangedFieldNo: Integer)
    var
        PostedGateLine: Record "SSD Posted Gate Line";
    begin
        if ChangedFieldName <> 'Gate Entry No.' then exit;
        if PostedGateLine.GET(PurchHeader."Gate Entry No.", PurchLine."Line No.") then begin
            PurchLine.VALIDATE("Challan Quantity", PostedGateLine."Challan Quantity");
            if PurchLine."No." = PostedGateLine."No." then
                PurchLine.VALIDATE("Qty. to Receive", PostedGateLine."Challan Quantity")
            else
                PurchLine.VALIDATE("Qty. to Receive", 0);
            PurchLine."Gate Entry no." := PurchHeader."Gate Entry No.";
            PurchLine."Gate Entry Date" := PurchHeader."Gate Entry Date";
            PurchLine."Gate Line No." := PostedGateLine."Line No.";
        end;
    end;

    [EventSubscriber(ObjectType::Table, Database::"Purchase Line", 'OnAfterAssignItemValues', '', false, false)]
    local procedure SSDOnAfterAssignItemValues(var PurchLine: Record "Purchase Line"; Item: Record Item; CurrentFieldNo: Integer; PurchHeader: Record "Purchase Header")
    var
        ItemUOM: Record "Item Unit of Measure";
        ItemBudgetName: Record "Item Budget Name";
        ItemBudgetEntry: Record "Item Budget Entry";
        BudgetedCost: Decimal;
        BudgtedQty: Decimal;
    begin
        PurchLine."Description 3" := Item."Description 3";
        PurchLine.Remarks := CopyStr(Item."Description 3", 1, 30);
        if ItemUOM.GET(Item."No.", Item."Purch. Unit of Measure") then
            PurchLine."Unit of Measure Code" := Item."Purch. Unit of Measure"
        else
            ERROR('Conversion for Purchase UOM %1 for Item %2 doesnot exist', Item."Purch. Unit of Measure", Item."No.");
        if PurchLine."Unit of Measure Code" <> Item."Base Unit of Measure" then MESSAGE('Purchase UOM is Different from item UOM');
        BudgetedCost := 0;
        BudgtedQty := 0;
        ItemBudgetName.RESET();
        ItemBudgetName.SETRANGE(Blocked, false);
        ItemBudgetName.SETRANGE("Analysis Area", ItemBudgetName."Analysis Area"::Purchase);
        if ItemBudgetName.FINDFIRST() then;
        ItemBudgetEntry.RESET();
        ItemBudgetEntry.SETRANGE("Analysis Area", ItemBudgetEntry."Analysis Area"::Purchase);
        ItemBudgetEntry.SETRANGE("Item No.", PurchLine."No.");
        ItemBudgetEntry.SETRANGE("Budget Name", ItemBudgetName.Name);
        ItemBudgetEntry.SETRANGE(Date, 0D, PurchHeader."Posting Date");
        ItemBudgetEntry.SETFILTER("Cost Amount", '<>%1', 0);
        if ItemBudgetEntry.FINDLAST() then BudgetedCost := ItemBudgetEntry."Cost Amount";
        ItemBudgetEntry.RESET();
        ItemBudgetEntry.SETRANGE("Analysis Area", ItemBudgetEntry."Analysis Area"::Purchase);
        ItemBudgetEntry.SETRANGE("Item No.", PurchLine."No.");
        ItemBudgetEntry.SETRANGE("Budget Name", ItemBudgetName.Name);
        ItemBudgetEntry.SETRANGE(Date, 0D, PurchHeader."Posting Date");
        ItemBudgetEntry.SETFILTER(Quantity, '<>%1', 0);
        if ItemBudgetEntry.FINDLAST() then BudgtedQty := ItemBudgetEntry.Quantity;
        if BudgtedQty <> 0 then PurchLine."Budgeted Cost Amount" := BudgetedCost / BudgtedQty;
    end;

    [EventSubscriber(ObjectType::Table, Database::"Purchase Line", 'OnAfterAssignItemChargeValues', '', false, false)]
    local procedure SSDOnAfterAssignItemChargeValues(var PurchLine: Record "Purchase Line"; ItemCharge: Record "Item Charge")
    begin
        PurchLine."Description 2" := ItemCharge."Description 2";
        PurchLine."Description 3" := ItemCharge."Description 3";
        PurchLine.Validate("Unit of Measure Code", ItemCharge.UOM);
    end;

    [EventSubscriber(ObjectType::Table, Database::"Purchase Line", 'OnValidateExpectedReceiptDateOnBeforeCheckDateConflict', '', false, false)]
    local procedure SSDOnValidateExpectedReceiptDateOnBeforeCheckDateConflict(var PurchaseLine: Record "Purchase Line"; var IsHandled: Boolean)
    begin
        if PurchaseLine."Document Type" <> PurchaseLine."Document Type"::Order then exit;
        if PurchaseLine."Blanket Order No." <> '' then IsHandled := true;
    end;

    [EventSubscriber(ObjectType::Table, Database::"Purchase Line", 'OnValidateUnitOfMeasureCodeOnBeforeValidateQuantity', '', false, false)]
    local procedure SSDOnValidateUnitOfMeasureCodeOnBeforeValidateQuantity(var PurchaseLine: Record "Purchase Line")
    var
        ItemCharge: Record "Item Charge";
    begin
        if (PurchaseLine."System-Created Entry") then exit;
        if PurchaseLine.Type <> PurchaseLine.Type::"Charge (Item)" then exit;
        if PurchaseLine."No." = '' then exit;
        ItemCharge.Get(PurchaseLine."No.");
        // PurchaseLine.TestField("Unit of Measure Code", ItemCharge.UOM);
    end;
    //OnValidateUnitOfMeasureCodeOnBeforeValidateQuantity
    [EventSubscriber(ObjectType::codeunit, Codeunit::"Blanket Purch. Order to Order", 'OnBeforeInsertPurchOrderLine', '', false, false)]
    local procedure SSDOnBeforeInsertPurchOrderLine(var PurchOrderLine: Record "Purchase Line"; PurchOrderHeader: Record "Purchase Header")
    begin
        PurchOrderLine."Document Subtype" := PurchOrderHeader."Document Subtype";
    end;

    [EventSubscriber(ObjectType::codeunit, Codeunit::"Blanket Purch. Order to Order", 'OnAfterInsertAllPurchOrderLines', '', false, false)]
    local procedure SSDOnAfterInsertAllPurchOrderLines(BlanketOrderPurchHeader: Record "Purchase Header"; OrderPurchHeader: Record "Purchase Header")
    var
        PurchaseHeader: Record "Purchase Header";
    begin
        PurchaseHeader.Get(BlanketOrderPurchHeader."Document Type", BlanketOrderPurchHeader."No.");
        PurchaseHeader."Last Schedule Order No" := OrderPurchHeader."No.";
        PurchaseHeader."Last Schedule No." := OrderPurchHeader."Schedule No.";
        PurchaseHeader.Modify(false);
    end;

    [EventSubscriber(ObjectType::codeunit, Codeunit::"Blanket Purch. Order to Order", 'OnCreatePurchHeaderOnBeforePurchOrderHeaderInitRecord', '', false, false)]
    local procedure SSDOnCreatePurchHeaderOnBeforePurchOrderHeaderInitRecord(var PurchOrderHeader: Record "Purchase Header"; var PurchHeader: Record "Purchase Header")
    begin
        PurchOrderHeader."Document Subtype" := PurchOrderHeader."Document Subtype"::Schedule;
        PurchOrderHeader."Blanket Order No." := PurchHeader."No.";
        PurchOrderHeader."Blanket Order Date" := PurchHeader."Document Date";
        if PurchHeader."Last Schedule No." <> 0 then
            PurchOrderHeader."Schedule No." := PurchHeader."Last Schedule No." + 1
        else
            PurchOrderHeader."Schedule No." := 1;
    end;

    [EventSubscriber(ObjectType::codeunit, Codeunit::"Purch.-Get Receipt", 'OnAfterPurchRcptLineSetFilters', '', false, false)]
    local procedure SSDOnAfterPurchRcptLineSetFilters(var PurchRcptLine: Record "Purch. Rcpt. Line"; PurchaseHeader: Record "Purchase Header")
    begin
        //IG_DS  PurchRcptLine.SetRange("SSD SRN Approval Pending", false); //SRN-IG-20250903-0002
        //Sandeep 23032024
        //PurchRcptLine.SETRANGE("Order Address Code", PurchaseHeader."Order Address Code");
        //PurchRcptLine.SETRANGE(Subcontracting, false);
    end;

    [EventSubscriber(ObjectType::codeunit, Codeunit::"Purch.-Post", 'OnAfterValidatePostingAndDocumentDate', '', false, false)]
    local procedure SSDOnAfterValidatePostingAndDocumentDate(var PurchaseHeader: Record "Purchase Header"; CommitIsSuppressed: Boolean; PreviewMode: Boolean)
    var
        ReceiptEndDate: Date;
        ReceiptEndDateErr: Label 'Service Receipt for SPO %2 can only be posted upto %1', Comment = '%1 = Service Receipt Date %2 Purchase Order No.';
    begin
        if ((PurchaseHeader."Document Type" = PurchaseHeader."Document Type"::Order) or (PurchaseHeader."Document Type" = PurchaseHeader."Document Type"::Invoice)) then if ((PurchaseHeader.Receive = true) or ((PurchaseHeader.Receive = true) and (PurchaseHeader.Invoice = true))) then PurchaseHeader.VALIDATE("Actual Posted Date", CURRENTDATETIME);
        if PurchaseHeader."Document Type" <> PurchaseHeader."Document Type"::Order then exit;
        if PurchaseHeader."SSD Order Type" <> PurchaseHeader."SSD Order Type"::Service then exit;
        //if PurchaseHeader."Confirmation Pending" then
        //Error('Service Purchase Order has not been confirmed. Receipt cannot be posted.');
        //PurchaseHeader.TestField("Posting Date", Today);
        PurchaseHeader.TestField("Valid To");
        ReceiptEndDate := PurchaseHeader."Valid To";
        if format(PurchaseHeader."SSD Service Grace Period") <> '' then ReceiptEndDate := CalcDate(PurchaseHeader."SSD Service Grace Period", PurchaseHeader."Valid To");
        if PurchaseHeader."Posting Date" > ReceiptEndDate then Error(ReceiptEndDateErr, ReceiptEndDate, PurchaseHeader."No.");
    end;

    [EventSubscriber(ObjectType::codeunit, Codeunit::"Purch.-Post", 'OnBeforePurchRcptHeaderInsert', '', false, false)]
    local procedure SSDOnAfterPurchRcptHeaderInsert(var PurchRcptHeader: Record "Purch. Rcpt. Header"; var PurchaseHeader: Record "Purchase Header"; CommitIsSupressed: Boolean)
    var
        UserSetup: Record "User Setup";
    begin
        if CommitIsSupressed then exit;
        if PurchaseHeader."SSD Order Type" = PurchaseHeader."SSD Order Type"::Inventory then exit;
        UserSetup.Get(UserId);
        UserSetup.TestField("SSD SRN Approver");
        PurchRcptHeader."SSD SRN Approval Pending" := true;
        PurchRcptHeader."SSD SRN Approver" := UserSetup."SSD SRN Approver";
    end;

    [EventSubscriber(ObjectType::codeunit, Codeunit::"Purch.-Post", 'OnRunOnBeforePostPurchLine', '', false, false)]
    local procedure SSDOnRunOnBeforePostPurchLine(var PurchLine: Record "Purchase Line"; var PurchHeader: Record "Purchase Header")
    var
        BaseAmount: Decimal;
        GSTAmount: Decimal;
        DeductionAmount: Decimal;
        AmountExceedingErr: Label 'Purchase Amount cannot be more than %1';
        InvoiceAmt: Decimal;
        LineAmt: Decimal;
    begin
        Clear(InvoiceAmt);
        Clear(LineAmt);
        if PurchHeader.Receive then PurchLine.SETFILTER("Qty. to Receive", '<>%1', 0);
        if PurchHeader.Invoice then PurchLine.SETFILTER("Qty. to Invoice", '<>%1', 0);
        //Sandeep 19022024
        if PurchHeader."Document Type" <> PurchHeader."Document Type"::Invoice then exit;
        if PurchHeader."SSD Order Type" = PurchHeader."SSD Order Type"::Inventory then exit;
        GetPurchaseAmounts(PurchHeader, GSTAmount, DeductionAmount, BaseAmount);
        InvoiceAmt := PurchHeader."Original Invoice Amount" - DeductionAmount;
        LineAmt := BaseAmount + GSTAmount;
        if ((LineAmt - InvoiceAmt) > 10) then Error(AmountExceedingErr, LineAmt - InvoiceAmt);
        //SSD_071024 Skipped confirmation by Deepak
        // if ((PurchHeader."Invoice Amount" - DeductionAmount) - (BaseAmount + GSTAmount)) > 10 then
        //     Error(AmountExceedingErr, PurchHeader."Invoice Amount" - DeductionAmount);
        //SSD_071024
    end;

    [EventSubscriber(ObjectType::codeunit, Codeunit::"Purch.-Post", 'OnInsertReceiptLineOnAfterInitPurchRcptLine', '', false, false)]
    local procedure SSDOnInsertReceiptLineOnAfterInitPurchRcptLine(var PurchRcptLine: Record "Purch. Rcpt. Line"; PurchLine: Record "Purchase Line"; var PurchRcptHeader: Record "Purch. Rcpt. Header")
    var
        TmpPostedReqPurchLines: record "SSD Posted Req. Purch. Line";
        PostedReqPurchLinesLocal: Record "SSD Posted Req. Purch. Line";
        TotalRcptQty: Decimal;
        LastLineNo: Integer;
    begin
        if (PurchRcptHeader."SSD SRN Approval Pending") and (PurchRcptLine.Type <> PurchRcptLine.Type::" ") and (PurchRcptLine."No." <> '') and (PurchRcptLine."Order No." <> '') then PurchRcptLine."SSD SRN Approval Pending" := true;
        TotalRcptQty := PurchRcptLine.Quantity;
        TmpPostedReqPurchLines.RESET();
        TmpPostedReqPurchLines.SETCURRENTKEY("Purch. Document Type", "Purch. Document No.", "Purch. Document Line No.", "Due Date");
        TmpPostedReqPurchLines.SETRANGE("Purch. Document Type", PurchLine."Document Type");
        TmpPostedReqPurchLines.SETRANGE("Purch. Document No.", PurchLine."Document No.");
        TmpPostedReqPurchLines.SETRANGE("Purch. Document Line No.", PurchLine."Line No.");
        if TmpPostedReqPurchLines.FINDSET() then
            repeat
                if TotalRcptQty >= TmpPostedReqPurchLines."Requisition Qty" then begin
                    TotalRcptQty := TotalRcptQty - TmpPostedReqPurchLines."Requisition Qty";
                    PostedReqPurchLinesLocal.RESET();
                    PostedReqPurchLinesLocal.SETRANGE("Posted Indent Document No.", TmpPostedReqPurchLines."Posted Indent Document No.");
                    PostedReqPurchLinesLocal.SETRANGE("Posted Indent Line No.", TmpPostedReqPurchLines."Posted Indent Line No.");
                    PostedReqPurchLinesLocal.SETRANGE("Line No.", TmpPostedReqPurchLines."Line No.");
                    if PostedReqPurchLinesLocal.FINDSET() then
                        repeat
                            PostedReqPurchLinesLocal.DELETE();
                        until PostedReqPurchLinesLocal.NEXT() = 0;
                    LastLineNo := 0;
                    PostedReqPurchLinesLocal.RESET();
                    PostedReqPurchLinesLocal.SETRANGE("Posted Indent Document No.", TmpPostedReqPurchLines."Posted Indent Document No.");
                    PostedReqPurchLinesLocal.SETRANGE("Posted Indent Line No.", TmpPostedReqPurchLines."Posted Indent Line No.");
                    if PostedReqPurchLinesLocal.FIND('+') then LastLineNo := PostedReqPurchLinesLocal."Line No.";
                    PostedReqPurchLinesLocal.INIT();
                    PostedReqPurchLinesLocal := TmpPostedReqPurchLines;
                    PostedReqPurchLinesLocal."Line No." := LastLineNo + 1000;
                    PostedReqPurchLinesLocal."Purch. Document Type" := PostedReqPurchLinesLocal."Purch. Document Type"::Receipt;
                    PostedReqPurchLinesLocal."Purch. Document No." := PurchRcptLine."Document No.";
                    PostedReqPurchLinesLocal."Purch. Document Line No." := PurchRcptLine."Line No.";
                    PostedReqPurchLinesLocal.INSERT();
                end
                else begin
                    TmpPostedReqPurchLines."Requisition Qty" := TmpPostedReqPurchLines."Requisition Qty" - TotalRcptQty;
                    TmpPostedReqPurchLines.MODIFY();
                    LastLineNo := 0;
                    PostedReqPurchLinesLocal.RESET();
                    PostedReqPurchLinesLocal.SETRANGE("Posted Indent Document No.", TmpPostedReqPurchLines."Posted Indent Document No.");
                    PostedReqPurchLinesLocal.SETRANGE("Posted Indent Line No.", TmpPostedReqPurchLines."Posted Indent Line No.");
                    if PostedReqPurchLinesLocal.FIND('+') then LastLineNo := PostedReqPurchLinesLocal."Line No.";
                    PostedReqPurchLinesLocal.INIT();
                    PostedReqPurchLinesLocal := TmpPostedReqPurchLines;
                    PostedReqPurchLinesLocal."Line No." := LastLineNo + 1000;
                    PostedReqPurchLinesLocal."Purch. Document Type" := PostedReqPurchLinesLocal."Purch. Document Type"::Receipt;
                    PostedReqPurchLinesLocal."Purch. Document No." := PurchRcptLine."Document No.";
                    PostedReqPurchLinesLocal."Purch. Document Line No." := PurchRcptLine."Line No.";
                    PostedReqPurchLinesLocal."Requisition Qty" := TotalRcptQty;
                    PostedReqPurchLinesLocal.INSERT();
                    TotalRcptQty := 0;
                end;
            until (TmpPostedReqPurchLines.NEXT() = 0) or (TotalRcptQty = 0);
    end;

    [EventSubscriber(ObjectType::codeunit, Codeunit::"Purch.-Post", 'OnBeforePostPurchaseDoc', '', false, false)]
    local procedure SSDOnBeforePostPurchaseDoc(var PurchaseHeader: Record "Purchase Header"; PreviewMode: Boolean)
    begin
        if PurchaseHeader."Document Type" <> PurchaseHeader."Document Type"::"Return Order" then exit;
        if PreviewMode then exit;
        Error('Posting Not Allowed! Use credit memo.');
    end;

    [EventSubscriber(ObjectType::codeunit, Codeunit::"Purch.-Post", 'OnInsertReceiptLineOnBeforeCreatePostedRcptLine', '', false, false)]
    local procedure SSDOnBeforePostPurchaseDoc2(PurchRcptLine: Record "Purch. Rcpt. Line"; WarehouseReceiptLine: Record "Warehouse Receipt Line"; PostedWhseReceiptHeader: Record "Posted Whse. Receipt Header")
    begin
        WarehouseReceiptLine."Posted Source Line No." := PurchRcptLine."Line No.";
    end;

    [EventSubscriber(ObjectType::codeunit, Codeunit::"Purch.-Post", 'OnPostUpdateOrderLineOnPurchHeaderReceive', '', false, false)]
    local procedure SSDOnPostUpdateOrderLineOnPurchHeaderReceive(var TempPurchLine: Record "Purchase Line"; PurchRcptHeader: Record "Purch. Rcpt. Header")
    begin
        TempPurchLine."SSD Receipt Remarks" := '';
        TempPurchLine."SSD Deduction Amount" := 0;
        TempPurchLine."SSD Deduction Remarks" := '';
    end;

    [EventSubscriber(ObjectType::codeunit, Codeunit::"Purch.-Post", 'OnRunOnAfterPostInvoice', '', false, false)]
    local procedure SSDOnRunOnAfterPostInvoice(var PurchaseHeader: Record "Purchase Header"; var PurchRcptHeader: Record "Purch. Rcpt. Header"; var PreviewMode: Boolean)
    var
        PurchaseLine: Record "Purchase Line";
        SendConsumptionMail: Boolean;
        SSDNotificationManagement: Codeunit "SSD Notification Management";
    begin
        if PreviewMode then exit;
        if PurchaseHeader."SSD Order Type" <> PurchaseHeader."SSD Order Type"::Service then exit;
        SendConsumptionMail := false;
        if PurchRcptHeader."No." <> '' then begin
            PurchaseLine.Reset();
            PurchaseLine.SetRange("Document Type", PurchaseHeader."Document Type");
            PurchaseLine.SetRange("Document No.", PurchaseHeader."No.");
            PurchaseLine.SetFilter(Quantity, '<>%1', 0);
            if PurchaseLine.FindSet() then
                repeat
                    if PurchaseLine."Quantity Received" >= round(PurchaseLine.Quantity * 9 / 10, 0.01, '=') then SendConsumptionMail := true;
                until PurchaseLine.Next() = 0;
            if SendConsumptionMail then SSDNotificationManagement.SendPurchaseOrderConsumptionMail(PurchaseHeader);
            SSDNotificationManagement.SendSRNPostMail(PurchaseHeader, PurchRcptHeader."No.");
        end;
    end;

    [EventSubscriber(ObjectType::codeunit, Codeunit::"Purch.-Post", 'OnBeforeFinalizePosting', '', false, false)]
    local procedure SSDOnBeforeFinalizePosting(var PurchaseHeader: Record "Purchase Header")
    begin
        if PurchaseHeader."Document Type" <> PurchaseHeader."Document Type"::Order then exit;
        // if PurchaseHeader."Assigned User ID" <> '' then
        //     PurchaseHeader."Assigned User ID" := '';
        PurchaseHeader."Vendor Invoice No." := '';
        PurchaseHeader."Vendor Invoice Date" := 0D;
        PurchaseHeader."Invoice Amount" := 0;
    end;

    [EventSubscriber(ObjectType::codeunit, Codeunit::"Release Purchase Document", 'OnCodeOnAfterPurchLineSetFilters', '', false, false)]
    local procedure SSDOnCodeOnAfterPurchLineSetFilters(PurchaseHeader: Record "Purchase Header"; var PurchaseLine: Record "Purchase Line")
    var
        Location: Record Location;
        Item: Record Item;
        PurchaseLine2: Record "Purchase Line";
        BinRequired: Boolean;
        LineUOMErr: Label 'Qty. per Unit of measure should not be 0 in Line No. %1 ';
    begin
        PurchaseLine2.SetRange("Document No.", PurchaseLine."Document No.");
        PurchaseLine2.SETRANGE(Type, PurchaseLine2.Type::Item);
        if PurchaseLine2.FindSet() then
            repeat
                PurchaseLine2.TESTFIELD("Location Code");
                if Location.GET(PurchaseLine2."Location Code") then if (Location."Bin Mandatory") and CheckBinRequired(PurchaseLine2) then PurchaseLine2.TESTFIELD("Bin Code");
                if PurchaseLine2."Qty. per Unit of Measure" = 0 then ERROR(LineUOMErr, PurchaseLine2."Line No.");
            until PurchaseLine2.NEXT() = 0;
        PurchaseLine2.SETFILTER(Type, '>0');
    end;

    [EventSubscriber(ObjectType::codeunit, Codeunit::"Release Purchase Document", 'OnCodeOnBeforeModifyHeader', '', false, false)]
    local procedure SSDOnCodeOnBeforeModifyHeader(var PurchaseHeader: Record "Purchase Header")
    var
        PurchaseLine: Record "Purchase Line";
        PurchaseLine2: Record "Purchase Line";
        PostedIndentLine: Record "SSD Posted Indent Line";
        Qty: Decimal;
        QtyReleased: Decimal;
        LineQty: Decimal;
        TotalQty: Decimal;
        Vendor: Record Vendor;
    begin
        PurchaseHeader."Version No. before reopen" := PurchaseHeader."No. of Archived Versions";
        //SSD_020324
        Vendor.Get(PurchaseHeader."Buy-from Vendor No.");
        //SSD_020324
        if (PurchaseHeader."Document Type" = PurchaseHeader."Document Type"::Order) and ((PurchaseHeader."SSD Order Type" = PurchaseHeader."SSD Order Type"::Service) or (PurchaseHeader."SSD Order Type" = PurchaseHeader."SSD Order Type"::"Fixed Assets")) and (PurchaseHeader."Confirmation Received" = false) and (not PurchaseHeader."SSD Exclude SPO Confirmation") then PurchaseHeader."Confirmation Pending" := true;
        PurchaseLine.SETRANGE("Document Type", PurchaseHeader."Document Type"::Order);
        PurchaseLine.SETRANGE("Document No.", PurchaseHeader."No.");
        if PurchaseLine.FINDSET then
            repeat
                if PurchaseLine."Posted Indent No." <> '' then begin
                    Qty := 0;
                    QtyReleased := 0;
                    LineQty := 0;
                    TotalQty := 0;
                    PurchaseLine2.RESET;
                    PurchaseLine2.SETRANGE(PurchaseLine2."Posted Indent No.", PurchaseLine."Posted Indent No.");
                    PurchaseLine2.SETRANGE(PurchaseLine2."Posted Indent Line No.", PurchaseLine."Posted Indent Line No.");
                    PurchaseLine2.SETRANGE(PurchaseLine2."No.", PurchaseLine."No.");
                    PurchaseLine2.SETRANGE(PurchaseLine2."P.O Status", PurchaseLine2."P.O Status"::Released);
                    PurchaseLine2.SETRANGE(PurchaseLine2."Document Type", PurchaseLine2."Document Type"::Order);
                    if PurchaseLine2.FINDSET then
                        repeat
                            QtyReleased := QtyReleased + PurchaseLine2.Quantity;
                        until PurchaseLine2.NEXT = 0;
                    PostedIndentLine.RESET;
                    PostedIndentLine.SETCURRENTKEY(PostedIndentLine."Document No.", PostedIndentLine."Line No.", PostedIndentLine.Type, PostedIndentLine."No.");
                    PostedIndentLine.SETRANGE(PostedIndentLine."Document No.", PurchaseLine."Posted Indent No.");
                    PostedIndentLine.SETRANGE(PostedIndentLine."Line No.", PurchaseLine."Posted Indent Line No.");
                    PostedIndentLine.SETRANGE(PostedIndentLine."No.", PurchaseLine."No.");
                    if PostedIndentLine.FINDFIRST then begin
                        PostedIndentLine.CALCFIELDS(PostedIndentLine."Qty Received");
                        Qty := PostedIndentLine.Quantity - (QtyReleased + PostedIndentLine."Qty Received");
                        LineQty := PurchaseLine.Quantity;
                        TotalQty := QtyReleased + LineQty + PostedIndentLine."Qty Received";
                        //IG_DS     // if(TotalQty > PostedIndentLine.Quantity)then ERROR('You Cannot Release more than %1 Qty. on Document No. %2 and Line No. %3', Qty, PurchaseLine."Document No.", PurchaseLine."Line No.") //code comment by raju and deepak mandal
                        // else
                        // begin
                        PurchaseLine."P.O Status" := PurchaseHeader.Status;
                        PurchaseLine.MODIFY;
                        //end;
                    end;
                end;
            until PurchaseLine.NEXT = 0;
    end;

    [EventSubscriber(ObjectType::codeunit, Codeunit::"Release Purchase Document", 'OnBeforeReleasePurchaseDoc', '', false, false)]
    local procedure SSDOnBeforeReleasePurchaseDoc(var PurchaseHeader: Record "Purchase Header"; PreviewMode: Boolean)
    var
        PurchaseLine: Record "Purchase Line";
    begin
        //SSD_GSTHSN
        if PurchaseHeader."GST Vendor Type" = PurchaseHeader."GST Vendor Type"::Registered then begin
            PurchaseLine.SetRange("Document No.", PurchaseHeader."No.");
            PurchaseLine.SetFilter("No.", '<>%1', '');
            if PurchaseLine.FindSet() then
                repeat
                    PurchaseLine.TestField("GST Group Code");
                    PurchaseLine.TestField("HSN/SAC Code");
                until PurchaseLine.Next() = 0;
        end;
        //SSD_GSTHSN
        if PreviewMode then exit;
        if PurchaseHeader."Document Type" = PurchaseHeader."Document Type"::Order then begin
            // IF (PurchaseHeader."Date Sent" = 0D) and (PurchaseHeader."SSD Order Type" = PurchaseHeader."SSD Order Type"::Inventory) THEN
            //     ERROR('Please Enter Date Send');
            IF PurchaseHeader."Requested Receipt Date" = 0D THEN ERROR('Please Enter Requested Receipt Date');
        end
        else
            //SSDU
            PurchaseHeader.TestField("Invoice Type Old");
        //SSDU
        CheckOrderType(PurchaseHeader);
    end;

    [EventSubscriber(ObjectType::codeunit, Codeunit::"Release Purchase Document", 'OnBeforeReopenPurchaseDoc', '', false, false)]
    local procedure SSDOnBeforeReopenPurchaseDoc(var PurchaseHeader: Record "Purchase Header"; PreviewMode: Boolean; var IsHandled: Boolean)
    var
        ArchiveManagement: Codeunit ArchiveManagement;
    begin
        if PreviewMode then exit;
        if PurchaseHeader."Document Type" <> PurchaseHeader."Document Type"::Order then exit;
        if PurchaseHeader.Status <> PurchaseHeader.Status::Released then exit;
        IF CONFIRM('Purchase %1 %2 will be archive when you reopen the document. Are you want to continue?', TRUE, PurchaseHeader."Document Type", PurchaseHeader."No.") THEN
            ArchiveManagement.StorePurchDocument(PurchaseHeader, FALSE)
        else
            IsHandled := true;
    end;

    [EventSubscriber(ObjectType::codeunit, Codeunit::"Undo Purchase Receipt Line", 'OnBeforeCode', '', false, false)]
    local procedure SSDOnBeforeCode(var PurchRcptLine: Record "Purch. Rcpt. Line")
    var
        PostedWhseReceiptHeader: Record "Posted Whse. Receipt Header";
        PostedGateHeader: Record "SSD Posted Gate Header";
        PostedGateLine: Record "SSD Posted Gate Line";
        NewPostedGateLine: Record "SSD Posted Gate Line";
        GateEntryNo: Code[20];
        LastEntryN0: Integer;
    begin
        IF PostedWhseReceiptHeader.GET(PurchRcptLine."Posted Whse. Rcpt No.") THEN GateEntryNo := PostedWhseReceiptHeader."Gate Entry no.";
        PostedGateLine.RESET;
        PostedGateLine.SETRANGE(PostedGateLine."Document No.", GateEntryNo);
        IF PostedGateLine.FIND('+') THEN LastEntryN0 := PostedGateLine."Line No.";
        PostedGateLine.RESET;
        PostedGateLine.SETRANGE(PostedGateLine."Document No.", GateEntryNo);
        //PostedGateLine.SETRANGE(PostedGateLine."WH Receipt Line No.","Posted Whse. Rcpt Line No.");
        PostedGateLine.SETRANGE(PostedGateLine."No.", PurchRcptLine."No.");
        IF PostedGateLine.FIND('-') THEN begin
            PostedGateLine."Undo Receipt" := TRUE;
            PostedGateLine.MODIFY;
        end;
        COMMIT;
        NewPostedGateLine.INIT;
        NewPostedGateLine.TRANSFERFIELDS(PostedGateLine);
        NewPostedGateLine."Line No." := LastEntryN0 + 1;
        NewPostedGateLine."Challan Quantity" := -PostedGateLine."Challan Quantity";
        NewPostedGateLine."Actual Quantity" := -PostedGateLine."Actual Quantity";
        NewPostedGateLine."Outstanding Quantity" := PostedGateLine."Outstanding Quantity" + PostedGateLine."Challan Quantity";
        NewPostedGateLine."Undo Receipt" := TRUE;
        NewPostedGateLine.INSERT;
    end;

    [EventSubscriber(ObjectType::Page, Page::"Purchase Invoice", 'OnBeforeActionEvent', 'Post', false, false)]
    local procedure SSDOnClickPost(var Rec: Record "Purchase Header")
    begin
        Rec.TestField("Original Invoice Amount");
        Rec.TestField("Deduction Reason");
    end;

    [EventSubscriber(ObjectType::Page, Page::"Purchase Invoice", 'OnBeforeActionEvent', 'SendApprovalRequest', false, false)]
    local procedure SSDOnClickSendApproval(var Rec: Record "Purchase Header")
    begin
        Rec.TestField("Original Invoice Amount");
        Rec.TestField("Deduction Reason");
        Rec.TestField("Doc. recvd  by Fin");
    end;

    [EventSubscriber(ObjectType::Page, Page::"Purchase Order", 'OnBeforeActionEvent', 'SendApprovalRequest', false, false)]
    local procedure SSDOnClickSPOSendApproval(var Rec: Record "Purchase Header")
    var
        DocumentAttachment: Record "Document Attachment";
        DocumentAttachment2: Record "Document Attachment";
        PurchaseLine: Record "Purchase Line";
        PurchasePrice: Record "Purchase Price";
    begin
        PurchaseLine.Reset();
        PurchaseLine.SetRange("Document No.", Rec."No.");
        if PurchaseLine.FindSet() then
            repeat
                PurchasePrice.RESET;
                PurchasePrice.SETRANGE("Vendor No.", Rec."Buy-from Vendor No.");
                PurchasePrice.SETFILTER("Starting Date", '<=%1', Rec."Posting Date");
                PurchasePrice.SETFILTER("Ending Date", '>=%1', Rec."Posting Date");
                PurchasePrice.SETRANGE("Item No.", PurchaseLine."No.");
                IF PurchasePrice.FINDLAST THEN
                    IF (PurchasePrice."Direct Unit Cost" = PurchaseLine."Direct Unit Cost") THEN
                        PurchaseLine."Price Match/Mismatch" := TRUE
                    ELSE
                        PurchaseLine."Price Match/Mismatch" := FALSE
                ELSE
                    PurchaseLine."Price Match/Mismatch" := FALSE;
                PurchaseLine.Modify();
            until PurchaseLine.Next() = 0;
        if Rec."SSD Order Type" = Rec."SSD Order Type"::Inventory then exit;
        CheckPurchaseLinesBeforeSendforApproval(Rec);
        DocumentAttachment.SetRange("Table ID", Database::"Purchase Header");
        DocumentAttachment.SetRange("Document Type", DocumentAttachment."Document Type"::Order);
        DocumentAttachment.SetRange("No.", Rec."No.");
        DocumentAttachment.SetRange("SSD Is Annexure", true);
        if not DocumentAttachment.IsEmpty then begin
            //Sunil_080524
            // DocumentAttachment2.SetRange("Table ID", Database::"Purchase Header");
            // DocumentAttachment2.SetRange("Document Type", DocumentAttachment2."Document Type"::Order);
            // DocumentAttachment2.SetRange("No.", Rec."No.");
            // DocumentAttachment2.SetRange("Merged Attachment", true);
            // if DocumentAttachment2.IsEmpty then
            //     Error('Merge PDF before sending SPO for approval');
            //Sunil_080524
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnSendPurchaseDocForApproval', '', false, false)]
    local procedure OnSendPurchaseDocForApproval(var PurchaseHeader: Record "Purchase Header")
    var
        PurchaseLine: Record "Purchase Line";
        PurchaseLine2: Record "Purchase Line";
        Location: Record Location;
    begin
        //SSD_GSTHSN
        if PurchaseHeader."GST Vendor Type" = PurchaseHeader."GST Vendor Type"::Registered then begin
            PurchaseLine.SetRange("Document No.", PurchaseHeader."No.");
            PurchaseLine.SetFilter("No.", '<>%1', '');
            if PurchaseLine.FindSet() then
                repeat
                    PurchaseLine.TestField("GST Group Code");
                    PurchaseLine.TestField("HSN/SAC Code");
                    if PurchaseLine."Document Type" = PurchaseLine."Document Type"::Order then begin
                        Location.Get(PurchaseLine."Location Code");
                        if Location."Bin Mandatory" and CheckBinRequired(PurchaseLine) then PurchaseLine.TestField("Bin Code");
                    end;
                until PurchaseLine.Next() = 0;
        end;
        PurchaseLine2.SetRange("Document No.", PurchaseHeader."No.");
        PurchaseLine2.SetFilter("No.", '<>%1', '');
        PurchaseLine2.SetRange(Type, PurchaseLine2.Type::Item);
        PurchaseLine2.SetRange("Document Type", PurchaseLine2."Document Type"::Order);
        if PurchaseLine2.FindSet() then
            repeat
                if PurchaseLine2."Document Type" = PurchaseLine2."Document Type"::Order then begin
                    Location.Get(PurchaseLine2."Location Code");
                    if Location."Bin Mandatory" and CheckBinRequired(PurchaseLine2) then PurchaseLine2.TestField("Bin Code");
                end;
            until PurchaseLine2.Next() = 0;
        //SSD_GSTHSN
        CheckOrderType(PurchaseHeader);
    end;

    [EventSubscriber(ObjectType::codeunit, Codeunit::"Approvals Mgmt.", 'OnAfterCheckPurchaseApprovalPossible', '', false, false)]
    local procedure SSDOnBeforeReopenPurchaseDoc2(var PurchaseHeader: Record "Purchase Header")
    var
        PurchaseLine: Record "Purchase Line";
        Item: Record Item;
        FirstLine: Boolean;
        LVar: Boolean;
    begin
        if PurchaseHeader."Document Type" <> PurchaseHeader."Document Type"::Order then exit;
        // IF PurchaseHeader."Date Sent" = 0D THEN
        //     ERROR('Please Enter Date Send');
        IF PurchaseHeader."Requested Receipt Date" = 0D THEN ERROR('Please Eenter Requested Receipt Date');
        if (PurchaseHeader."SSD Order Type" = PurchaseHeader."SSD Order Type"::Inventory) then PurchaseHeader.TestField("Shipment Method Code");
        FirstLine := true;
        PurchaseLine.Reset();
        PurchaseLine.SetRange("Document Type", PurchaseHeader."Document Type");
        PurchaseLine.SetRange("Document No.", PurchaseHeader."No.");
        if PurchaseLine.FindSet() then
            repeat
                if (PurchaseLine.Type = PurchaseLine.Type::Item) and (Item.Get(PurchaseLine."No.")) then begin
                    IF (PurchaseLine."Budgeted Cost Amount" = 0) and (Item.Type <> Item.Type::Service) THEN ERROR('Budget cost amount must have value in Line No. %1', PurchaseLine."Line No.");
                end;
                PurchaseLine.TestField("HSN/SAC Code");
                case PurchaseLine.Type of
                    Type::Item:
                        begin
                            LVar := false;
                            if Item.Get(PurchaseLine."No.") then begin
                                if Item."Inventory Tracking" then begin
                                    if LVar then begin
                                        FirstLine := false;
                                        IF (PurchaseLine."Customer No." = '') OR (PurchaseLine."SalesPerson Code" = '') THEN ERROR('Salesperson Code & Customer code can not be blank for %1 ', PurchaseLine."No.");
                                    end;
                                end;
                            end;
                        end;
                end;
            until PurchaseLine.Next() = 0;
    end;

    [EventSubscriber(ObjectType::codeunit, Codeunit::"Release Purchase Document", 'OnAfterReleasePurchaseDoc', '', false, false)]
    local procedure OnAfterReleasePurchaseDoc(var PurchaseHeader: Record "Purchase Header"; PreviewMode: Boolean; var LinesWereModified: Boolean)
    var
        SSDEmailManagement: Codeunit "SSD Email Management";
        SSDNotificationManagement: Codeunit "SSD Notification Management";
    begin
        if PreviewMode then exit;
        if PurchaseHeader."Document Type" <> PurchaseHeader."Document Type"::Order then exit;
        if PurchaseHeader.Status = PurchaseHeader.Status::Released then begin
            if PurchaseHeader."SSD Order Type" = PurchaseHeader."SSD Order Type"::Inventory then SSDEmailManagement.MailSendPO(PurchaseHeader)// else 
                                                                                                                                              //     SSDNotificationManagement.SendSPOReleaseMail(PurchaseHeader); //SSD_090524
        end;
    end;
    //01062023
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post", 'OnAfterProcessPurchLines', '', true, true)]
    local procedure OnAfterPurchRcptLineInsert(var PurchHeader: Record "Purchase Header"; var PurchRcptHeader: Record "Purch. Rcpt. Header")
    begin
        if (PurchHeader."Document Type" = PurchHeader."Document Type"::Order) and (PurchRcptHeader."No." <> '') THEN BEGIN
            InsertReceiptChallan(PurchRcptHeader);
        end;
    end;
    /// <summary>
    /// InsertReceiptChallan.
    /// </summary>
    /// <param name="VAR PurchRcptHeader ">Record "Purch. Rcpt. Header".</param>
    procedure InsertReceiptChallan(VAR PurchRcptHeader: Record "Purch. Rcpt. Header")
    var
        StockRegister: Record "SSD Stock Register 57F4";
        DocumentNo: Code[20];
        NoSeriesMgt: Codeunit "No. Series - Batch";
        PurchRcptLine: Record "Purch. Rcpt. Line";
        Location: Record Location;
        PurchSetup: Record "Purchases & Payables Setup";
        DuplicateError: Label 'Already Created';
        Item: Record Item;
    begin
        StockRegister.SetRange("Purchase Receipt No.", PurchRcptHeader."No.");
        if StockRegister.FindFirst() then Error(DuplicateError);
        PurchSetup.GET;
        PurchSetup.TESTFIELD("Receipt Challan Nos.");
        IF PurchRcptHeader."Location Code" = '' THEN EXIT;
        Location.GET(PurchRcptHeader."Location Code");
        IF NOT Location."Temp JW Location" THEN EXIT;
        PurchRcptLine.RESET;
        PurchRcptLine.SETRANGE("Document No.", PurchRcptHeader."No.");
        PurchRcptLine.SETRANGE(Type, PurchRcptLine.Type::Item);
        PurchRcptLine.SETFILTER(Quantity, '<>%1', 0);
        IF PurchRcptLine.FINDSET THEN
            REPEAT
                Item.Reset();
                if Item.Get(PurchRcptLine."No.") then if Item.Type = Item.Type::Service then exit;
                DocumentNo := NoSeriesMgt.GetNextNo(PurchSetup."Receipt Challan Nos.", PurchRcptHeader."Posting Date", TRUE);
                StockRegister.INIT;
                StockRegister."Entry No." := GetLastNo();
                StockRegister."Challan Type" := StockRegister."Challan Type"::"Purchase Receipt";
                StockRegister."Challan No." := DocumentNo;
                StockRegister."Purchase Receipt No." := PurchRcptHeader."No.";
                StockRegister."Challan Date" := PurchRcptHeader."Posting Date";
                StockRegister."Source Doc. Line No." := PurchRcptLine."Line No.";
                StockRegister.VALIDATE("Item No.", PurchRcptLine."No.");
                StockRegister."Vendor No." := Location."Subcontractor No.";
                StockRegister."Vendor Name" := Location.Name;
                StockRegister."Vendor GST Registration No." := PurchRcptHeader."Vendor GST Reg. No.";
                StockRegister."Vendor Document No." := PurchRcptHeader."Vendor Shipment No.";
                StockRegister.VALIDATE("Quantity Shipped", PurchRcptLine.Quantity);
                StockRegister.VALIDATE("Unit Cost", PurchRcptLine."Unit Cost");
                StockRegister.Validate("Purchase Vendor No.", PurchRcptHeader."Buy-from Vendor No.");
                StockRegister.Validate("Job Work Location Code", PurchRcptHeader."Location Code");
                StockRegister.INSERT;
            UNTIL PurchRcptLine.NEXT = 0;
    end;

    procedure GetLastNo() LastEntryNo: Integer;
    var
        StockRegister: Record "SSD Stock Register 57F4";
    begin
        if StockRegister.FindLast() then
            LastEntryNo := StockRegister."Entry No." + 1
        else
            LastEntryNo += 1;
    end;

    [EventSubscriber(ObjectType::Table, Database::"Purchase Line", 'OnBeforeValidateGenProdPostingGroup', '', true, true)]
    local procedure OnBeforeValidateGenProdPostingGroup(var PurchaseLine: Record "Purchase Line"; xPurchaseLine: Record "Purchase Line"; CurrentFieldNo: Integer; var InHandled: Boolean);
    begin
        InHandled := true;
    end;

    [EventSubscriber(ObjectType::Table, Database::"Purchase Line", 'OnBeforeTestStatusOpen', '', false, false)]
    local procedure SSDOnBeforeTestStatusOpen(var PurchaseLine: Record "Purchase Line"; var PurchaseHeader: Record "Purchase Header"; xPurchaseLine: Record "Purchase Line"; CallingFieldNo: Integer; var IsHandled: Boolean)
    begin
        if CallingFieldNo <> 15 then exit;
        if PurchaseHeader.Status <> PurchaseHeader.Status::"Pending Approval" then exit;
        IsHandled := true;
    end;
    //OnBeforeTestStatusOpen
    [EventSubscriber(ObjectType::codeunit, Codeunit::"Purch.-Post", 'OnBeforePurchRcptLineInsert', '', false, false)]
    local procedure OnBeforePurchRcptLineInsert(var PurchRcptLine: Record "Purch. Rcpt. Line"; var PurchRcptHeader: Record "Purch. Rcpt. Header"; var PurchLine: Record "Purchase Line"; CommitIsSupressed: Boolean; PostedWhseRcptLine: Record "Posted Whse. Receipt Line"; var IsHandled: Boolean)
    begin
        PostedWhseRcptLine."Posted Source Line No." := PurchRcptLine."Line No.";
        //PostedWhseRcptLine.Modify();
        PurchRcptLine."Posted Whse. Rcpt No." := PostedWhseRcptLine."No.";
        PurchRcptLine."Posted Whse. Rcpt Line No." := PostedWhseRcptLine."Line No.";
    end;

    [EventSubscriber(ObjectType::codeunit, Codeunit::"Copy Document Mgt.", 'OnAfterCopyPurchaseHeader', '', false, false)]
    local procedure SSDOnAfterCopyPurchaseHeader(var ToPurchaseHeader: Record "Purchase Header"; OldPurchaseHeader: Record "Purchase Header"; FromPurchHeader: Record "Purchase Header")
    begin
        if ToPurchaseHeader."SSD TC Code" <> '' then ToPurchaseHeader.Validate("SSD TC Code");
    end;

    [EventSubscriber(ObjectType::codeunit, Codeunit::"Item Charge Assgnt. (Purch.)", 'OnBeforeInsertItemChargeAssgntWithAssignValues', '', false, false)]
    local procedure SSDOnBeforeInsertItemChargeAssgntWithAssignValues(var ItemChargeAssgntPurch: Record "Item Charge Assignment (Purch)"; FromItemChargeAssgntPurch: Record "Item Charge Assignment (Purch)")
    var
        ItemLedgerEntry: Record "Item Ledger Entry";
        ValueEntry: Record "Value Entry";
        ItemChargeAlreadyPostedErr: Label 'Item Charge %1 is already posted with purchase invoice %2', Comment = '%1 Item Charge %2 Purchase Invoice';
    begin
        if ItemChargeAssgntPurch."Applies-to Doc. Type" <> ItemChargeAssgntPurch."Applies-to Doc. Type"::Receipt then exit;
        //Multiple Charge Item
        // ItemLedgerEntry.SetRange("Document Type", ItemLedgerEntry."Document Type"::"Purchase Receipt");
        // ItemLedgerEntry.SetRange("Document No.", ItemChargeAssgntPurch."Applies-to Doc. No.");
        // ItemLedgerEntry.SetRange("Document Line No.", ItemChargeAssgntPurch."Applies-to Doc. Line No.");
        // if ItemLedgerEntry.FindFirst() then begin
        //     ValueEntry.SetRange("Item Ledger Entry No.", ItemLedgerEntry."Entry No.");
        //     ValueEntry.SetRange("Item Charge No.", ItemChargeAssgntPurch."Item Charge No.");
        //     if ValueEntry.FindFirst() then
        //         Error(ItemChargeAlreadyPostedErr, ItemChargeAssgntPurch."Item Charge No.", ValueEntry."Document No.");
        // end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Item Charge Assgnt. (Purch.)", 'OnSuggestAssgntOnAfterItemChargeAssgntPurchSetFilters', '', false, false)]
    local procedure SSDOnSuggestAssgntOnAfterItemChargeAssgntPurchSetFilters(var ItemChargeAssignmentPurch: Record "Item Charge Assignment (Purch)")
    begin
        ItemChargeAssignmentPurch.SetRange("Qty. Assigned", 0);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Item Charge Assgnt. (Purch.)", 'OnBeforeAssignEqually', '', false, false)]
    local procedure SSDOnBeforeAssignEqually(var ItemChargeAssignmentPurch: Record "Item Charge Assignment (Purch)")
    begin
        ItemChargeAssignmentPurch.SetRange("Qty. Assigned", 0);
        ItemChargeAssignmentPurch.FindSet();
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Item Charge Assgnt. (Purch.)", 'OnAssignByAmountOnAfterAssignAppliesToDocLineAmount', '', false, false)]
    local procedure SSDOnAssignByAmountOnAfterAssignAppliesToDocLineAmount(ItemChargeAssignmentPurch: Record "Item Charge Assignment (Purch)"; var TempItemChargeAssignmentPurch: Record "Item Charge Assignment (Purch)" temporary)
    begin
        if ItemChargeAssignmentPurch."Qty. Assigned" <> 0 then TempItemChargeAssignmentPurch."Applies-to Doc. Line Amount" := 0;
    end;
    //OnAssignByWeightOnAfterCalcTotalGrossWeight
    local procedure CheckBinRequired(PurchaseLine5: Record "Purchase Line") BinRequired: Boolean
    var
        Item: Record Item;
    begin
        BinRequired := false;
        if PurchaseLine5.Type = PurchaseLine5.Type::Item then if Item.Get(PurchaseLine5."No.") and (Item.Type = Item.Type::Inventory) then BinRequired := true;
    end;

    local procedure CheckOrderType(PurchaseHeader5: Record "Purchase Header")
    var
        PurchaseLine5: Record "Purchase Line";
        Item: Record Item;
        InventoryAllowed: Boolean;
        ServiceItemAllowed: Boolean;
        GLAccountAllowed: Boolean;
        FixedAssetAllowed: Boolean;
        ShowError: Boolean;
        POTypeError: Label 'PO Type %1 cannot be used with Purchase Line Type %2 No. %3', Comment = '%1 Purchase Order Type %2 Purchase Line Type %3 Purchase Line No.';
    begin
        if PurchaseHeader5."Document Type" <> PurchaseHeader5."Document Type"::Order then exit;
        case PurchaseHeader5."SSD Order Type" of
            "SSD Purchase Order Type"::Inventory:
                begin
                    InventoryAllowed := true;
                    ServiceItemAllowed := false;
                    GLAccountAllowed := false;
                    FixedAssetAllowed := false;
                end;
            "SSD Purchase Order Type"::"Fixed Assets":
                begin
                    InventoryAllowed := false;
                    ServiceItemAllowed := false;
                    GLAccountAllowed := false;
                    FixedAssetAllowed := true;
                end;
            "SSD Purchase Order Type"::Service:
                begin
                    InventoryAllowed := false;
                    ServiceItemAllowed := true;
                    GLAccountAllowed := true;
                    FixedAssetAllowed := false;
                    PurchaseHeader5.TestField("Valid From");
                    PurchaseHeader5.TestField("Valid To");
                end;
        end;
        PurchaseLine5.Reset();
        PurchaseLine5.SetRange("Document Type", PurchaseHeader5."Document Type");
        PurchaseLine5.SetRange("Document No.", PurchaseHeader5."No.");
        PurchaseLine5.SetRange("System-Created Entry", false);
        PurchaseLine5.SetFilter("No.", '<>%1', '');
        if PurchaseLine5.FindSet() then
            repeat
                ShowError := false;
                case PurchaseLine5.Type of
                    "Purchase Line Type"::Item:
                        begin
                            Item.Get(PurchaseLine5."No.");
                            if (Item.Type = Item.Type::Service) and (not ServiceItemAllowed) then ShowError := true;
                            if (Item.Type = Item.Type::Inventory) and (not InventoryAllowed) then ShowError := true;
                        end;
                    "Purchase Line Type"::"Charge (Item)":
                        begin
                            if not ServiceItemAllowed then ShowError := true;
                        end;
                    "Purchase Line Type"::"Fixed Asset":
                        begin
                            if not FixedAssetAllowed then ShowError := true;
                        end;
                end;
                if ShowError then Error(POTypeError, PurchaseHeader5."SSD Order Type", PurchaseLine5.Type, PurchaseLine5."No.");
            until PurchaseLine5.Next() = 0;
    end;

    local procedure GetPurchaseAmounts(PurchaseHeader: Record "Purchase Header"; var GSTAmount: Decimal; var DeductionAmount: Decimal; var LineAmount: Decimal)
    var
        PurchaseLine: Record "Purchase Line";
    begin
        Clear(GSTAmount);
        Clear(DeductionAmount);
        Clear(LineAmount);
        PurchaseLine.SetRange("Document Type", PurchaseHeader."Document Type");
        PurchaseLine.SetRange("Document no.", PurchaseHeader."No.");
        if PurchaseLine.FindSet() then
            repeat
                if not PurchaseLine."GST Reverse Charge" then GSTAmount += GetGSTAmount(PurchaseLine.RecordId());
                LineAmount += PurchaseLine."Line Amount";
                DeductionAmount += PurchaseLine."SSD Deduction Amount";
            until PurchaseLine.Next() = 0;
    end;

    local procedure GetGSTAmount(RecID: RecordID): Decimal
    var
        TaxTransactionValue: Record "Tax Transaction Value";
        GSTSetup: Record "GST Setup";
    begin
        if not GSTSetup.Get() then exit;
        TaxTransactionValue.SetCurrentKey("Tax Record ID", "Value Type", "Tax Type", Percent);
        TaxTransactionValue.SetRange("Tax Record ID", RecID);
        TaxTransactionValue.SetRange("Value Type", TaxTransactionValue."Value Type"::COMPONENT);
        if GSTSetup."Cess Tax Type" <> '' then
            TaxTransactionValue.SetRange("Tax Type", GSTSetup."GST Tax Type", GSTSetup."Cess Tax Type")
        else
            TaxTransactionValue.SetRange("Tax Type", GSTSetup."GST Tax Type");
        TaxTransactionValue.SetFilter(Percent, '<>%1', 0);
        if not TaxTransactionValue.IsEmpty() then TaxTransactionValue.CalcSums(Amount);
        exit(TaxTransactionValue.Amount);
    end;
    /// <summary>
    /// UpdateVendorConfimation.
    /// </summary>
    /// <param name="PurchHeader">VAR Record "Purchase Header".</param>
    procedure UpdateVendorConfimation(var PurchHeader: Record "Purchase Header")
    var
        DocumentAttachment: Record "Document Attachment";
        SSDAttachmentType: Record "SSD Attachment Type";
        UserSetup: Record "User Setup";
    begin
        UserSetup.Get(UserId);
        if not UserSetup."SSD PO Confirmation" then Error('You are not authourized for Vendor Order Confirmation');
        if PurchHeader."Confirmation Received" then exit;
        if not PurchHeader."Confirmation Pending" then exit;
        SSDAttachmentType.SetRange("Is Vendor Confirmation", true);
        if not SSDAttachmentType.FindFirst() then
            Error('Attachment for Vendor Confirmation is not defined. Contact System Administrator')
        else begin
            DocumentAttachment.Reset();
            DocumentAttachment.SetRange("Document Type", PurchHeader."Document Type");
            DocumentAttachment.SetRange("Table ID", Database::"Purchase Header");
            DocumentAttachment.SetRange("No.", PurchHeader."No.");
            DocumentAttachment.SetRange("SSD Attachment Type", SSDAttachmentType.Code);
            if not DocumentAttachment.FindFirst() then
                Error('Vendor Confirmation is not attached')
            else begin
                PurchHeader."Confirmation Received" := true;
                PurchHeader."Confirmation Pending" := false;
                PurchHeader.Modify();
            end;
        end;
    end;

    procedure SendSRNApproval(var PurchaseHeader: Record "Purchase Header")
    var
        UserSetup: Record "User Setup";
        PurchaseLine: Record "Purchase Line";
        SSDNotificationManagement: Codeunit "SSD Notification Management";
        SSDPurchasePost: Codeunit "SSD Purchase Post";
    begin
        SSDPurchasePost.CheckTCValidations(PurchaseHeader);
        UserSetup.Get(UserId);
        UserSetup.TestField("SSD SRN Approver");
        PurchaseHeader."Assigned User ID" := UserSetup."SSD SRN Approver";
        PurchaseHeader.Modify();
        Commit();
        SSDNotificationManagement.SendSRNCreationMail(PurchaseHeader);
        Message('SRN send for approval');
    end;

    local procedure CheckPurchaseLinesBeforeSendforApproval(PurchaseHeader: Record "Purchase Header")
    var
        PurchaseLine: Record "Purchase Line";
    begin
        PurchaseLine.Reset();
        PurchaseLine.SetRange("Document Type", PurchaseHeader."Document Type");
        PurchaseLine.SetRange("Document No.", PurchaseHeader."No.");
        PurchaseLine.SetRange("System-Created Entry", false);
        if PurchaseLine.FindSet() then
            repeat
                if PurchaseLine.Type = PurchaseLine.Type::"Charge (Item)" then PurchaseLine.TestField("Unit of Measure Code");
                if PurchaseLine.Type in [PurchaseLine.Type::Item, PurchaseLine.Type::"G/L Account", PurchaseLine.Type::"Fixed Asset", PurchaseLine.Type::"Charge (Item)"] then begin
                    PurchaseLine.TestField(Quantity);
                    PurchaseLine.TestField("Direct Unit Cost");
                end;
            until PurchaseLine.Next() = 0;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Get Receipt", 'OnBeforeCopyDocumentAttachments', '', true, true)]
    local procedure OnBeforeCopyDocumentAttachments(var OrderNoList: List of [Code[20]]; var PurchaseHeader: Record "Purchase Header"; var IsHandled: Boolean)
    begin
        if PurchaseHeader."SSD Order Type" <> PurchaseHeader."SSD Order Type"::Inventory then IsHandled := true;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnBeforeApprovalEntryInsert', '', false, false)]
    local procedure SSDOnBeforeApprovalEntryInsert(var ApprovalEntry: Record "Approval Entry"; ApprovalEntryArgument: Record "Approval Entry")
    begin
        ApprovalEntry."Order Type" := ApprovalEntryArgument."Order Type";
        ApprovalEntry."Indent Order Type" := ApprovalEntryArgument."Indent Order Type";

    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnAfterPopulateApprovalEntryArgument', '', false, false)]
    local procedure SSDOnAfterPopulateApprovalEntryArgument(WorkflowStepInstance: Record "Workflow Step Instance"; var ApprovalEntryArgument: Record "Approval Entry"; var IsHandled: Boolean; var RecRef: RecordRef)
    var
        PurchaseHeader: Record "Purchase Header";
        IndentHeader: Record "SSD Indent Header";
    begin
        case RecRef.Number of
            Database::"Purchase Header":
                begin
                    RecRef.SetTable(PurchaseHeader);
                    ApprovalEntryArgument."Order Type" := PurchaseHeader."SSD Order Type";
                end;
        end;
        case RecRef.Number of
            Database::"SSD Indent Header":
                begin
                    RecRef.SetTable(IndentHeader);
                    ApprovalEntryArgument."Indent Order Type" := IndentHeader."Indent Order Type";
                    IndentHeader.CalcFields(IndentHeader."Amount");
                    ApprovalEntryArgument.Validate(Amount, IndentHeader."Amount");
                    ApprovalEntryArgument.Validate("Amount (LCY)", IndentHeader.Amount);
                end;
        end;
    end;
}
