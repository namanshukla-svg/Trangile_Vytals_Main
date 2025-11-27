codeunit 50026 Validation
{
    Permissions = tabledata "Sales Invoice Line" = rm,
        tabledata "Item Ledger Entry" = rm,
        tabledata "Sales Invoice Header" = rm,
        tabledata "Cust. Ledger Entry" = rm;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnBeforePostSalesDoc', '', false, false)]
    procedure OnBeforePostSalesDoc(var SalesHeader: Record "Sales Header")
    var
        SalesLine: Record "Sales Line";
        HeaderDim: array[8] of code[20];
        UserSetup: Record "User Setup";
    begin
        SalesLine.SetRange("Document Type", SalesHeader."Document Type");
        SalesLine.SetRange("Document No.", SalesHeader."No.");
        SalesLine.SetFilter("No.", '<>%1', '');
        SalesLine.SetRange("System-Created Entry", false);
        if SalesLine.FindSet() then
            repeat
                SalesLine.CheckTypeofInvoice();
            until SalesLine.Next() = 0;
        UserSetup.Get(UserId);
        // SalesHeader.TestField("Type of Invoice", UserSetup."Type of Invoice");//IG_AS 18-07-2025
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post", 'OnAfterPostInvoice', '', false, false)]
    local procedure PostPurchaseNarr(var PurchHeader: Record "Purchase Header"; var VendorLedgerEntry: Record "Vendor Ledger Entry")
    var
        GenJnlNarration: Record "Gen. Journal Narration";
        PostedNarration: Record "Posted Narration";
    begin
        GenJnlNarration.RESET();
        GenJnlNarration.SETRANGE("Journal Template Name", '');
        GenJnlNarration.SETRANGE("Journal Batch Name", '');
        GenJnlNarration.SETRANGE("Document No.", PurchHeader."No.");
        GenJnlNarration.SETFILTER("Line No.", '<>%1', 0);
        GenJnlNarration.SETRANGE("Gen. Journal Line No.", 0);
        if GenJnlNarration.FindSet() then
            repeat
                PostedNarration.INIT();
                PostedNarration."Entry No." := 0;
                PostedNarration."Transaction No." := VendorLedgerEntry."Transaction No.";
                PostedNarration."Line No." := GenJnlNarration."Line No.";
                PostedNarration."Posting Date" := VendorLedgerEntry."Posting Date";
                PostedNarration."Document Type" := VendorLedgerEntry."Document Type";
                PostedNarration."Document No." := VendorLedgerEntry."Document No.";
                PostedNarration.Narration := GenJnlNarration.Narration;
                PostedNarration.INSERT();
                GenJnlNarration.Delete();
            until GenJnlNarration.Next() = 0;
    end;

    procedure SetFreightAmt(var SalesInvHdr: Record "Sales Invoice Header")
    var
        SalesInvLine: Record "Sales Invoice Line";
        TotalWaight: Decimal;
    begin
        SalesInvLine.Reset;
        SalesInvLine.SetRange("Document No.", SalesInvHdr."No.");
        TotalWaight := 0;
        if SalesInvLine.Find('-') then
            repeat
                TotalWaight += SalesInvLine."Gross Wt";
            until SalesInvLine.Next = 0;
        SalesInvLine.Reset;
        SalesInvLine.SetRange("Document No.", SalesInvHdr."No.");
        if SalesInvLine.Find('-') then
            repeat
                if TotalWaight <> 0 then
                    SalesInvLine."Freight Amount" := ROUND(SalesInvHdr."Freight Amount" * SalesInvLine."Gross Wt" / TotalWaight)
                else
                    SalesInvLine."Freight Amount" := 0;
                SalesInvLine.Modify;
            until SalesInvLine.Next = 0;
    end;

    [EventSubscriber(ObjectType::Table, Database::"Approval Entry", 'OnBeforeMarkAllWhereUserisApproverOrSender', '', true, true)]
    local procedure OnBeforeMarkAllWhereUserisApproverOrSender(var ApprovalEntry: Record "Approval Entry"; var IsHandled: Boolean)
    begin
        IsHandled := true;
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterChangeStatusOnProdOrder(var ProdOrder: Record "Production Order"; var ToProdOrder: Record "Production Order"; NewStatus: Enum "Production Order Status"; NewPostingDate: Date; NewUpdateUnitCost: Boolean; var SuppressCommit: Boolean)
    begin
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Prod. Order Status Management", 'OnAfterChangeStatusOnProdOrder', '', false, false)]
    local procedure UpdateCustomValues(var ToProdOrder: Record "Production Order")
    var
        SingleInstance: Codeunit "SSD Single Instance";
        VarI: Enum "SSD Variance Cause";
        RMKS: Text[100];
    begin
        SingleInstance.GetValues(VarI, RMKS);
        ToProdOrder."Variance Cause" := VarI;
        ToProdOrder.Remarks := RMKS;
        ToProdOrder.Modify();
    end;

    procedure UpdateSalesInvoice()
    var
        SalesInvHeader: Record "Sales Invoice Header";
        CustLedgerEntry: Record "Cust. Ledger Entry";
        UpdateSalesInvHeader: Record "SSD Update Sales Invoice Heade";
    begin
        if UpdateSalesInvHeader.FindSet() then
            repeat
                SalesInvHeader.Reset();
                if SalesInvHeader.get(UpdateSalesInvHeader."No.") then begin
                    IF UpdateSalesInvHeader."Firm Freight" <> '' then begin
                        if UpdateSalesInvHeader."Firm Freight" = 'TRUE' then
                            SalesInvHeader."Firm Freight" := true
                        else if UpdateSalesInvHeader."Firm Freight" = 'FALSE' then SalesInvHeader."Firm Freight" := false
                    end;
                    if UpdateSalesInvHeader."Calculated Freight Amount" <> 0 then SalesInvHeader."Calculated Freight Amount" := UpdateSalesInvHeader."Calculated Freight Amount";
                    if UpdateSalesInvHeader."Fright Amount" <> 0 then SalesInvHeader."Freight Amount" := UpdateSalesInvHeader."Fright Amount";
                    if UpdateSalesInvHeader."Shipping Agent Code" <> '' then SalesInvHeader."Shipping Agent Code" := UpdateSalesInvHeader."Shipping Agent Code";
                    if UpdateSalesInvHeader."LR/RR No." <> '' then SalesInvHeader."LR/RR No." := UpdateSalesInvHeader."LR/RR No.";
                    if UpdateSalesInvHeader."LR/RR Date" <> 0D then SalesInvHeader."LR/RR Date" := UpdateSalesInvHeader."LR/RR Date";
                    if UpdateSalesInvHeader."Dispatch Mail Send" <> '' then begin
                        if UpdateSalesInvHeader."Dispatch Mail Send" = 'TRUE' then
                            SalesInvHeader."Dispatch Mail Send" := true
                        else if UpdateSalesInvHeader."Dispatch Mail Send" = 'FALSE' then SalesInvHeader."Dispatch Mail Send" := false
                    end;
                    if UpdateSalesInvHeader."Mail Send Dispatch Detail" <> '' then begin
                        if UpdateSalesInvHeader."Mail Send Dispatch Detail" = 'TRUE' then
                            SalesInvHeader."Mail Send Dispatch Detail" := true
                        else if UpdateSalesInvHeader."Mail Send Dispatch Detail" = 'FALSE' then SalesInvHeader."Mail Send Dispatch Detail" := false
                    end;
                    if UpdateSalesInvHeader."Send Mail with COA" <> '' then begin
                        if UpdateSalesInvHeader."Send Mail with COA" = 'TRUE' then
                            SalesInvHeader."Send Mail with COA" := true
                        else if UpdateSalesInvHeader."Send Mail with COA" = 'FALSE' then SalesInvHeader."Send Mail with COA" := false
                    end;
                    if UpdateSalesInvHeader."Send Mail Again with COA" <> '' then begin
                        if UpdateSalesInvHeader."Send Mail Again with COA" = 'TRUE' then
                            SalesInvHeader."Send Mail Again with COA" := true
                        else if UpdateSalesInvHeader."Send Mail Again with COA" = 'FALSE' then SalesInvHeader."Send Mail Again with COA" := false
                    end;
                    if UpdateSalesInvHeader."Send Mail Again without COA" <> '' then begin
                        if UpdateSalesInvHeader."Send Mail Again without COA" = 'TRUE' then
                            SalesInvHeader."Send Mail Without COA" := true
                        else if UpdateSalesInvHeader."Send Mail Again without COA" = 'FALSE' then SalesInvHeader."Send Mail Without COA" := false
                    end;
                    if UpdateSalesInvHeader."Sales Person Code" <> '' then begin
                        SalesInvHeader."Salesperson Code" := UpdateSalesInvHeader."Sales Person Code";
                        CustLedgerEntry.SetRange("Document No.", UpdateSalesInvHeader."No.");
                        if CustLedgerEntry.FindFirst() then begin
                            CustLedgerEntry."Salesperson Code" := UpdateSalesInvHeader."Sales Person Code";
                            CustLedgerEntry.Modify();
                        end;
                    end;
                    if UpdateSalesInvHeader."Actual Delivery Date" <> 0D then
                        SalesInvHeader.Validate("Actual Delivery Date", UpdateSalesInvHeader."Actual Delivery Date");
                    if UpdateSalesInvHeader.Remarks1 <> '' then
                        SalesInvHeader.Validate(Remarks1, UpdateSalesInvHeader.Remarks1);
                    SalesInvHeader.Modify();
                end;
            until UpdateSalesInvHeader.Next() = 0;
        Message('Invoices have been updated.');
    end;
    /// <summary>
    /// GetAccountDetails.
    /// </summary>
    /// <param name="PurchaseLine">VAR Record "Purchase Line".</param>
    procedure GetAccountDetails(var PurchaseLine: Record "Purchase Line")
    var
        GeneralPostingSetup: Record "General Posting Setup";
        GLAccount: Record "G/L Account";
        FixedAssets: Record "Fixed Asset";
        FADepreciationBook: Record "FA Depreciation Book";
        FASetup: Record "FA Setup";
        FAPostingGroup: Record "FA Posting Group";
    begin
        PurchaseLine."SSD Posting Account" := '';
        PurchaseLine."SSD Posting Acc Name" := '';
        if PurchaseLine."No." = '' then exit;
        case PurchaseLine.Type of
            "Purchase Line Type"::Item:
                begin
                    if GeneralPostingSetup.Get(PurchaseLine."Gen. Bus. Posting Group", PurchaseLine."Gen. Prod. Posting Group") then begin
                        PurchaseLine."SSD Posting Account" := GeneralPostingSetup."Purch. Account";
                        GLAccount.Get(GeneralPostingSetup."Purch. Account");
                        PurchaseLine."SSD Posting Acc Name" := GLAccount.Name;
                    end;
                end;
            "Purchase Line Type"::"Charge (Item)":
                begin
                    if GeneralPostingSetup.Get(PurchaseLine."Gen. Bus. Posting Group", PurchaseLine."Gen. Prod. Posting Group") then begin
                        PurchaseLine."SSD Posting Account" := GeneralPostingSetup."Purch. Account";
                        GLAccount.Get(GeneralPostingSetup."Purch. Account");
                        PurchaseLine."SSD Posting Acc Name" := GLAccount.Name;
                    end;
                end;
            "Purchase Line Type"::"Fixed Asset":
                begin
                    FASetup.Get();
                    FixedAssets.Get(PurchaseLine."No.");
                    FADepreciationBook.SetRange("FA No.", FixedAssets."No.");
                    FADepreciationBook.SetRange("Depreciation Book Code", FASetup."Default Depr. Book");
                    if FADepreciationBook.FindFirst() then begin
                        FAPostingGroup.Get(FADepreciationBook."FA Posting Group");
                        GLAccount.Get(FAPostingGroup."Acquisition Cost Account");
                        PurchaseLine."SSD Posting Account" := GLAccount."No.";
                        PurchaseLine."SSD Posting Acc Name" := GLAccount.Name;
                    end;
                end;
            "Purchase Line Type"::"G/L Account":
                begin
                    GLAccount.Get(PurchaseLine."No.");
                    PurchaseLine."SSD Posting Account" := GLAccount."No.";
                    PurchaseLine."SSD Posting Acc Name" := GLAccount.Name;
                end;
        end;
    end;
    ///////
}
