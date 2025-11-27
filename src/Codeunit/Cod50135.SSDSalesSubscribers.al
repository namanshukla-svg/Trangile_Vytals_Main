codeunit 50135 "SSD Sales Subscribers"
{
    [EventSubscriber(ObjectType::Table, Database::"Customer", 'OnBeforeTestNoSeries', '', false, false)]
    local procedure SSDOnBeforeTestNoSeries(var Customer: Record Customer; xCustomer: Record Customer; var IsHandled: Boolean)
    var
        UserSetup: Record "User Setup";
        ResponsibilityCenter: Record "Responsibility Center";
        NoSeriesManagement: Codeunit "No. Series";//IG_DS NoSeriesManagement;
    begin
        IsHandled := true;
        if Customer."No." <> xCustomer."No." then
            if UserSetup.Get(UserId) then
                if ResponsibilityCenter.Get(UserSetup."Responsibility Center") then begin
                    NoSeriesManagement.TestManual(ResponsibilityCenter."Customer Nos.");
                    Customer."No. Series" := '';
                end;
    end;

    [EventSubscriber(ObjectType::Table, Database::"Customer", 'OnAfterOnInsert', '', false, false)]
    local procedure SSDOnAfterOnInsert(var Customer: Record Customer)
    begin
        Customer.Blocked := Customer.Blocked::All;
    end;

    [EventSubscriber(ObjectType::Table, Database::"Customer", 'OnBeforeCheckBlockedCust', '', false, false)]
    local procedure SSDOnBeforeCheckBlockedCust(Customer: Record Customer; DocType: Option; var IsHandled: Boolean)
    begin
        if DocType = 1 then IsHandled := true;
    end;

    [EventSubscriber(ObjectType::Table, Database::"Sales Header", 'OnValidateSellToCustomerNoOnBeforeCheckBlockedCustOnDocs', '', false, false)]
    local procedure SSDOnValidateSellToCustomerNoOnBeforeCheckBlockedCustOnDocs(var SalesHeader: Record "Sales Header"; var Cust: Record Customer; var IsHandled: Boolean)
    begin
        if SalesHeader."Document Subtype" <> SalesHeader."Document Subtype"::Despatch then exit;
        Cust.CheckBlockedCustOnDocsForDisOrd(Cust, SalesHeader."Document Type", false, false);
        IsHandled := true;
    end;

    [EventSubscriber(ObjectType::Table, Database::"Sales Line", 'OnAfterCopyFromItem', '', false, false)]
    local procedure SSDOnAfterCopyFromItem(var SalesLine: Record "Sales Line"; Item: Record Item; CurrentFieldNo: Integer; xSalesLine: Record "Sales Line")
    var
        SalesHeader: Record "Sales Header";
        ItemBudgetName: Record "Item Budget Name";
        ItemBudgetEntry: Record "Item Budget Entry";
        ItemUOM: Record "Item Unit of Measure";
        BudgetedCost: Decimal;
        BudgtedQty: Decimal;
        // SalesPrice1: Record "Sales Price"; //IG_DS_Before
        SalesPrice1: Record "Price List Line"; //IG_DS_after
        SalesHeader3: Record "Sales Header";
        SalesLine3: Record "Sales Line";
        Customer2: Record Customer;
        Salescode: Code[20];
    begin
        SalesHeader := SalesLine.GetSalesHeader();
        BudgetedCost := 0;
        BudgtedQty := 0;
        ItemBudgetName.RESET();
        ItemBudgetName.SETRANGE(Blocked, false);
        ItemBudgetName.SETRANGE("Analysis Area", ItemBudgetName."Analysis Area"::Sales);
        if ItemBudgetName.FINDFIRST() then;
        ItemBudgetEntry.RESET();
        ItemBudgetEntry.SETRANGE("Analysis Area", ItemBudgetEntry."Analysis Area"::Sales);
        ItemBudgetEntry.SETRANGE("Item No.", SalesLine."No.");
        ItemBudgetEntry.SETRANGE("Budget Name", ItemBudgetName.Name);
        ItemBudgetEntry.SETRANGE(Date, 0D, SalesHeader."Posting Date");
        ItemBudgetEntry.SETFILTER("Cost Amount", '<>%1', 0);
        if ItemBudgetEntry.FINDLAST() then BudgetedCost := ItemBudgetEntry."Cost Amount";
        ItemBudgetEntry.RESET();
        ItemBudgetEntry.SETRANGE("Analysis Area", ItemBudgetEntry."Analysis Area"::Sales);
        ItemBudgetEntry.SETRANGE("Item No.", SalesLine."No.");
        ItemBudgetEntry.SETRANGE("Budget Name", ItemBudgetName.Name);
        ItemBudgetEntry.SETRANGE(Date, 0D, SalesHeader."Posting Date");
        ItemBudgetEntry.SETFILTER(Quantity, '<>%1', 0);
        if ItemBudgetEntry.FINDLAST() then BudgtedQty := ItemBudgetEntry.Quantity;
        if BudgtedQty <> 0 then SalesLine."Budgeted Cost Amount" := BudgetedCost / BudgtedQty;
        SalesLine."Part No." := Item."No. 2";
        if ((SalesLine."Document Type" = SalesLine."Document Type"::Order) and (SalesLine.Type = SalesLine.Type::Item)) then SalesLine.VALIDATE("Planned Shipment Date", SalesHeader."Shipment Date");
        if ItemUOM.GET(Item."No.", Item."Sales Unit of Measure") then
            SalesLine."Unit of Measure Code" := Item."Sales Unit of Measure"
        else
            ERROR('Conversion for Sales UOM %1 for Item %2 doesnot exist', Item."Sales Unit of Measure", Item."No.");
        //SSD Sunil
        SalesHeader3.get(SalesLine."Document Type", SalesLine."Document No.");
        SalesPrice1.RESET;
        SalesPrice1.SETRANGE("Assign-to No.", SalesHeader3."Sell-to Customer No.");
        SalesPrice1.SETRANGE("Source Group", SalesPrice1."Source Group"::Customer);
        SalesPrice1.SETFILTER("Starting Date", '<=%1', TODAY);
        SalesPrice1.SETFILTER("Ending Date", '>=%1', TODAY);
        SalesPrice1.SETRANGE("Product No.", SalesLine."No.");
        IF SalesPrice1.FINDFIRST THEN
            SalesLine."Unit Price" := SalesPrice1."Unit Price"
        ELSE BEGIN
            Customer2.GET(SalesHeader3."Sell-to Customer No.");
            IF Customer2."Customer Price Group" = 'SP-PL' THEN
                Salescode := 'SP-PL'
            ELSE IF Customer2."Customer Price Group" = 'IP-PL' THEN Salescode := 'IP-PL';
            SalesPrice1.RESET;
            SalesPrice1.SETRANGE("Assign-to No.", Salescode);
            SalesPrice1.SETFILTER("Starting Date", '<=%1', TODAY);
            SalesPrice1.SETFILTER("Ending Date", '>=%1', TODAY);
            SalesPrice1.SETRANGE("Product No.", SalesLine."No.");
            IF SalesPrice1.FINDFIRST THEN SalesLine."Unit Price" := SalesPrice1."Unit Price";
        END;
        SalesLine."Unit Price Dup." := SalesLine."Unit Price";
        IF SalesLine."Unit Price" = SalesLine."Unit Price Dup." THEN
            SalesLine."Price Match/Mismatch" := TRUE
        ELSE
            SalesLine."Price Match/Mismatch" := FALSE;
        IF SalesLine.Type = SalesLine.Type::"G/L Account" THEN SalesLine."Price Match/Mismatch" := TRUE;
        //SSD Sunil
    end;

    [EventSubscriber(ObjectType::Table, Database::"Sales Line", 'OnValidateNoOnBeforeCalcShipmentDateForLocation', '', false, false)]
    local procedure SSDOnValidateNoOnBeforeCalcShipmentDateForLocation(var IsHandled: Boolean; var SalesLine: Record "Sales Line")
    var
        SalesHeader: Record "Sales Header";
        Item: Record Item;
        CalChange: Record "Customized Calendar Change";
        BaseCalendar: Record "Base Calendar";
        CalendarManagement: Codeunit "Calendar Management";
        CustomCalendarChange: array[2] of Record "Customized Calendar Change";
    begin
        if SalesLine."Document Type" <> SalesLine."Document Type"::Order then exit;
        if SalesLine.Type <> SalesLine.Type::Item then exit;
        if SalesLine."No." = '' then exit;
        if not SalesHeader.Get(SalesLine."Document Type", SalesLine."Document No.") then exit;
        SalesHeader.Get(SalesLine."Document Type", SalesLine."Document No.");
        if SalesHeader."Document Subtype" <> SalesHeader."Document Subtype"::Order then exit;
        Item.Get(SalesLine."No.");
        if Format(item."Lead Time Dispatch") = '' then exit;
        if BaseCalendar.FindLast() then;
        CustomCalendarChange[1].SetSource(CalChange."Source Type"::Location, SalesHeader."Location Code", '', BaseCalendar.Code);
        SalesLine."Shipment Date" := CalendarManagement.CalcDateBOC(format(Item."Lead Time Dispatch"), SalesHeader."Order Date", CustomCalendarChange, false);
        IsHandled := true;
    end;
    //OnValidateNoOnBeforeCalcShipmentDateForLocation
    [EventSubscriber(ObjectType::Table, Database::"Sales Shipment Line", 'OnAfterClearSalesLineValues', '', false, false)]
    local procedure SSDOnAfterClearSalesLineValues(var SalesShipmentLine: Record "Sales Shipment Line"; var SalesLine: Record "Sales Line")
    var
        SalesHeader: Record "Sales Header";
    begin
        SalesLine."Order No." := SalesShipmentLine."Order No.";
        SalesLine."Order Line No." := SalesShipmentLine."Order Line No.";
        SalesHeader.GET(SalesLine."Document Type", SalesLine."Document No.");
        SalesLine."Document Subtype" := SalesHeader."Document Subtype";
        SalesLine."Blanket Order No." := SalesShipmentLine."Blanket Order No.";
        SalesLine."Blanket Order Line No." := SalesShipmentLine."Blanket Order Line No.";
        SalesLine."Planned Delivery Date" := SalesShipmentLine."Planned Shipment Date";
        SalesLine."Planned Shipment Date" := SalesShipmentLine."Planned Shipment Date";
    end;
    //Blanket Sales Order Functions
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Blanket Sales Order to Order", 'OnBeforeRun', '', false, false)]
    local procedure SSDOnBeforeRun(var SalesHeader: Record "Sales Header"; var HideValidationDialog: Boolean)
    var
        SalesLine: Record "Sales Line";
        LineCount: Integer;
    begin
        SalesLine.Reset();
        SalesLine.SetRange("Document Type", SalesHeader."Document Type");
        SalesLine.SetRange("Document No.", SalesHeader."No.");
        SalesLine.SetRange(Type, SalesLine.Type::Item);
        SalesLine.SetFilter("No.", '<>%1', '');
        SalesLine.SetFilter("Qty. to Ship", '<>%1', 0);
        if SalesLine.FindSet() then begin
            LineCount := SalesLine.Count;
            if LineCount > 4 then Error('Sales Order with Type Item Can only be created for maximum of 4 Lines');
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Blanket Sales Order to Order", 'OnRunOnAfterBlanketOrderSalesLineSetFilters', '', false, false)]
    local procedure SSDOnRunOnAfterBlanketOrderSalesLineSetFilters(var BlanketOrderSalesLine: Record "Sales Line")
    begin
        BlanketOrderSalesLine.SETFILTER("Qty. to Ship", '>%1', 0);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Blanket Sales Order to Order", 'OnBeforeInsertSalesOrderHeader', '', false, false)]
    local procedure SSDOnBeforeInsertSalesOrderHeader(var SalesOrderHeader: Record "Sales Header"; var BlanketOrderSalesHeader: Record "Sales Header")
    begin
        SalesOrderHeader."Order/Scd. No." := BlanketOrderSalesHeader."No.";
        SalesOrderHeader."Document Subtype" := SalesOrderHeader."Document Subtype"::Schedule;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Blanket Sales Order to Order", 'OnRunOnBeforeValidateBlanketOrderSalesLineQtytoShip', '', false, false)]
    local procedure SSDOnRunOnBeforeValidateBlanketOrderSalesLineQtytoShip(var BlanketOrderSalesLine: Record "Sales Line"; SalesOrderLine: Record "Sales Line"; SalesOrderHeader: Record "Sales Header"; BlanketOrderSalesHeader: Record "Sales Header"; var IsHandled: Boolean)
    begin
        SalesOrderLine."Document Subtype" := SalesOrderHeader."Document Subtype";
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Format Address", 'OnBeforeSalesInvBillTo', '', false, false)]
    local procedure SSDOnBeforeSalesInvBillTo(var AddrArray: array[8] of Text[100]; var SalesInvHeader: Record "Sales Invoice Header"; var Handled: Boolean)
    var
        FormatAddress: Codeunit "Format Address";
    begin
        FormatAddress.FormatAddr(AddrArray, SalesInvHeader."Bill-to Name", SalesInvHeader."Bill-to Name 2", '', SalesInvHeader."Bill-to Address", SalesInvHeader."Bill-to Address 2", SalesInvHeader."Bill-to City", SalesInvHeader."Bill-to Post Code", SalesInvHeader."Bill-to County", SalesInvHeader."Bill-to Country/Region Code");
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Release Sales Document", 'OnBeforeReleaseSalesDoc', '', false, false)]
    local procedure SSDOnBeforeReleaseSalesDoc(var SalesHeader: Record "Sales Header")
    var
        SSDSMSManagement: Codeunit "SSD SMS Management";
        UserSetup: Record "User Setup";
        SalesLine: Record "Sales Line";
        SalesLine2: Record "Sales Line";
        ItemCategory: Record "Item Category";
        Item: Record Item;
        ConfirmText: Label 'Order Quantity is less than MOQ Quantity. Do you still want to proceed further?';
    begin
        //SSD_GSTHSN
        IF SalesHeader."GST Customer Type" = SalesHeader."GST Customer Type"::Registered then begin
            SalesLine.SetRange("Document No.", SalesHeader."No.");
            SalesLine.SetFilter("No.", '<>%1', '');
            if SalesLine.FindSet() then
                repeat
                    SalesLine.TestField("GST Group Code");
                    SalesLine.TestField("HSN/SAC Code");
                until SalesLine.Next() = 0;
        end;
        //SSD_GSTHSN
        if SalesHeader."Document Type" = SalesHeader."Document Type"::Order then SalesHeader.TestField("Type of Invoice");
        if (SalesHeader."Document Type" <> SalesHeader."Document Type"::Order) and (SalesHeader."Document Type" <> SalesHeader."Document Type"::Invoice) then exit;
        case SalesHeader."Document Type" of
            SalesHeader."Document Type"::Invoice:
                begin
                    SalesHeader.TESTFIELD("Applied to Insurance Policy");
                    //SSDU_Sunil
                    SalesHeader.TestField("Type of Invoice");
                    UserSetup.Get(UserId);
                    // SalesHeader.TestField("Type of Invoice", UserSetup."Type of Invoice");//IG_AS 18-07-2025
                end;
            SalesHeader."Document Type"::Order:
                SSDSMSManagement.SendOrderBookingSMS(SalesHeader);
        end;
        SalesLine2.Reset();
        SalesLine2.SetRange("Document No.", SalesHeader."No.");
        SalesLine2.SetRange("Document Type", SalesLine2."Document Type"::Order);
        if SalesLine2.FindSet() then
            repeat
                if Item.Get() then begin
                    ItemCategory.Reset();
                    ItemCategory.SetRange(Code, Item."Item Category Code");
                    if ItemCategory.FindFirst() then begin
                        if (ItemCategory."Parent Category" = 'VCI FILM') and (SalesLine2.Quantity < Item.MOQ) then if not Confirm(ConfirmText, false) then Error('Order Quantity is less than MOQ Quantity');
                    end;
                end;
            until SalesLine2.Next() = 0;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnSendSalesDocForApproval', '', false, false)]
    local procedure OnSendSalesDocForApproval(var SalesHeader: Record "Sales Header")
    var
        SalesLine: Record "Sales Line";
        SalesLine2: Record "Sales Line";
        ItemCategory: Record "Item Category";
        Item: Record Item;
        ConfirmText: Label 'Order Quantity is less than MOQ Quantity. Do you still want to proceed further?';
    begin
        //SSD_GSTHSN
        if SalesHeader."GST Customer Type" = SalesHeader."GST Customer Type"::Registered then begin
            SalesLine.SetRange("Document No.", SalesHeader."No.");
            SalesLine.SetFilter("No.", '<>%1', '');
            if SalesLine.FindSet() then
                repeat
                    SalesLine.TestField("GST Group Code");
                    SalesLine.TestField("HSN/SAC Code");
                    if SalesLine."Sell-to Customer No." = 'C0137' then
                        SalesLine.FOC := true
                    else
                        SalesLine.FOC := false;
                until SalesLine.Next() = 0;
            SalesLine2.SetRange("Document No.", SalesHeader."No.");
            SalesLine2.SetFilter("No.", '<>%1', '');
            if SalesLine2.FindSet() then
                repeat
                    if SalesLine2."Sell-to Customer No." = 'C0137' then
                        SalesLine2.FOC := true
                    else
                        SalesLine2.FOC := false;
                until SalesLine2.Next() = 0;
        end;
        //SSD_GSTHSN
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Release Sales Document", 'OnAfterUpdateSalesDocLines', '', false, false)]
    local procedure SSDOnAfterUpdateSalesDocLines(var SalesHeader: Record "Sales Header")
    var
        SalesLine: Record "Sales Line";
    begin
        SalesLine.Reset();
        SalesLine.SETRANGE("Document Type", SalesHeader."Document Type");
        SalesLine.SETRANGE("Document No.", SalesHeader."No.");
        if SalesLine.FINDSET() then
            repeat
                SalesLine."Released DateTime" := CURRENTDATETIME;
                SalesLine.MODIFY until SalesLine.NEXT() = 0;
        SalesHeader.crmrelease := true;
    end;

    [EventSubscriber(ObjectType::Table, Database::"Sales Invoice Line", 'OnAfterInitFromSalesLine', '', false, false)]
    local procedure SSDOnAfterInitFromSalesLine(var SalesInvLine: Record "Sales Invoice Line"; SalesInvHeader: Record "Sales Invoice Header"; SalesLine: Record "Sales Line")
    begin
        SalesInvLine.crminsertflag := false;
        SalesInvLine.crmupdateflag := false;
        SalesInvLine.isCRMexception := false;
        SalesInvLine.exceptiondetail := '';
        SalesLine.CALCFIELDS("Gross Wt", "Actual Wt");
        SalesInvLine."Gross Wt" := SalesLine."Gross Wt";
        SalesInvLine."Actual Wt" := SalesLine."Actual Wt";
        SalesInvLine."Planned Delivery DT" := SalesLine."Planned Delivery Date";
        SalesInvLine."Quantity (Base)" := SalesLine."Qty. to Invoice (Base)";
    end;

    [EventSubscriber(ObjectType::Table, Database::"Sales Cr.Memo Line", 'OnAfterInitFromSalesLine', '', false, false)]
    local procedure SSDOnAfterInitFromSalesLineCrMemo(var SalesCrMemoLine: Record "Sales Cr.Memo Line"; SalesCrMemoHeader: Record "Sales Cr.Memo Header"; SalesLine: Record "Sales Line")
    begin
        SalesCrMemoLine.crminsertflag := false;
        SalesCrMemoLine.isCRMexception := false;
        SalesCrMemoLine."exception detail" := '';
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnPostItemJnlLineOnAfterPrepareItemJnlLine', '', false, false)]
    local procedure SSDOnPostItemJnlLineOnAfterPrepareItemJnlLine(var ItemJournalLine: Record "Item Journal Line"; SalesLine: Record "Sales Line"; SalesHeader: Record "Sales Header"; WhseShip: Boolean; var ItemJnlPostLine: Codeunit "Item Jnl.-Post Line"; QtyToBeShipped: Decimal; TrackingSpecification: Record "Tracking Specification")
    begin
        ItemJournalLine."Responsibility Center" := SalesHeader."Responsibility Center";
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnAfterPostSalesLine', '', false, false)]
    local procedure SSDOnAfterPostSalesLine(var SalesHeader: Record "Sales Header"; var SalesLine: Record "Sales Line"; CommitIsSuppressed: Boolean; var SalesInvLine: Record "Sales Invoice Line"; var SalesCrMemoLine: Record "Sales Cr.Memo Line"; var xSalesLine: Record "Sales Line")
    var
        SOLineRec: Record "Sales Line";
        SOLineRec1: Record "Sales Line";
        TrackingSpecification: Record "Tracking Specification";
        SalesLine2: Record "Sales Line";
        SalesLineReserve: Codeunit "Sales Line-Reserve";
        ReservMgt: Codeunit "Reservation Management";
    begin
        if SalesInvLine."Document No." <> '' then begin
            SalesInvLine."Order No." := SalesLine."Order No.";
            SalesInvLine."Order Line No." := SalesLine."Order Line No.";
            //Find and Update Order Lines
            SOLineRec.RESET;
            SOLineRec.SETCURRENTKEY("Document Type", "Document No.", "Line No.");
            SOLineRec.SETRANGE("Document Type", SOLineRec."Document Type"::Order);
            SOLineRec.SETRANGE("Document No.", SalesLine."Order No.");
            SOLineRec.SETRANGE("Line No.", SalesLine."Order Line No.");
            IF SOLineRec.FindSet() THEN
                REPEAT
                    SOLineRec.VALIDATE("Quantity Shipped", (SOLineRec."Quantity Shipped" + SalesLine.Quantity));
                    SOLineRec.VALIDATE("Quantity Invoiced", (SOLineRec."Quantity Invoiced" + SalesLine.Quantity));
                    SOLineRec.VALIDATE("Outstanding Quantity", (SOLineRec."Outstanding Quantity" - SalesLine.Quantity));
                    SOLineRec.VALIDATE("Outstanding Qty. (Base)", (SOLineRec."Outstanding Qty. (Base)" - SalesLine."Quantity (Base)"));
                    //SOLineRec.VALIDATE("Qty. to Ship" , (SOLineRec."Qty. to Ship"-TempSalesLine.Quantity));
                    //SOLineRec.VALIDATE("Qty. to Invoice" , (SOLineRec."Qty. to Invoice"-TempSalesLine.Quantity));
                    SOLineRec."Qty. to Ship" -= SalesLine.Quantity;
                    SOLineRec."Qty. to Invoice" -= SalesLine.Quantity;
                    SOLineRec."Dispatch Date Time" := CURRENTDATETIME; //ALLE-NM 02122019
                    SOLineRec.MODIFY(TRUE); //ALLE-NM 28062019
                UNTIL SOLineRec.NEXT = 0;
            //Find and Update Dispatch Lines
            SOLineRec1.RESET;
            SOLineRec1.SETCURRENTKEY("Document Type", "Document No.", "Line No.");
            SOLineRec1.SETRANGE("Document Type", SOLineRec1."Document Type"::Order);
            SOLineRec1.SETRANGE("Document No.", SalesLine."Despatch Slip No.");
            SOLineRec1.SETRANGE("Line No.", SalesLine."Despatch Slip Line No.");
            IF SOLineRec1.FindSet() THEN
                REPEAT
                    SOLineRec1.VALIDATE("Quantity Shipped", (SOLineRec1."Quantity Shipped" + SalesLine.Quantity));
                    SOLineRec1.VALIDATE("Quantity Invoiced", (SOLineRec1."Quantity Invoiced" + SalesLine.Quantity));
                    SOLineRec1.VALIDATE("Outstanding Quantity", (SOLineRec1."Outstanding Quantity" - SalesLine.Quantity));
                    SOLineRec1.VALIDATE("Outstanding Qty. (Base)", (SOLineRec1."Outstanding Qty. (Base)" - SalesLine."Quantity (Base)"));
                    //SOLineRec1.VALIDATE("Qty. to Ship" , (SOLineRec1."Qty. to Ship"-TempSalesLine.Quantity));
                    //SOLineRec1.VALIDATE("Qty. to Invoice" , (SOLineRec1."Qty. to Invoice"-TempSalesLine.Quantity));
                    //SOLineRec1."Qty. to Ship" := SOLineRec1."Outstanding Quantity";
                    //SOLineRec1."Qty. to Invoice" := SOLineRec1."Outstanding Quantity";
                    SOLineRec1."Qty. to Ship" -= SalesLine.Quantity;
                    SOLineRec1."Qty. to Invoice" -= SalesLine.Quantity;
                    Clear(ReservMgt);
                    ReservMgt.SetReservSource(SOLineRec1);
                    ReservMgt.SetItemTrackingHandling(1);
                    ReservMgt.DeleteReservEntries(true, 0);
                    DeleteInvoiceSpecFromLine(SOLineRec1);
                    RemoveitemTracking(SOLineRec1);
                    SOLineRec1.MODIFY(TRUE); //ALLE-NM 28062019
                UNTIL SOLineRec1.NEXT = 0;
        end;
        // //SSD Sunil Remove Tracking
        // SalesLine2.Reset();
        // SalesLine2.SetRange("Document No.", SalesLine."Document No.");
        // SalesLine2.SetRange("Document Type", SalesLine."Document Type"::Invoice);
        // SalesLine2.SetFilter("Despatch Slip No.", '<>%1', '');
        // if SalesLine2.FindSet() then
        //     repeat
        //         RemoveitemTracking(SalesLine2);
        //     until SalesLine2.Next() = 0;
        // //SSD Sunil Remove Tracking
    end;

    procedure RemoveitemTracking(var SalesLine: Record "Sales Line")
    Var
        ReservationEntry: Record "Reservation Entry";
    begin
        ReservationEntry.Reset();
        ReservationEntry.SetRange("Source Type", Database::"Sales Line");
        ReservationEntry.SetRange("Source ID", SalesLine."Document No.");
        ReservationEntry.SetRange("Source Ref. No.", SalesLine."Line No.");
        ReservationEntry.SetFilter("Item Tracking", '<>%1', ReservationEntry."Item Tracking"::None);
        //ReservationEntry.SetRange("Location Code", SalesLine."Location Code");
        //ReservationEntry.SetRange("Item No.", SalesLine."No.");
        //ReservationEntry.SetFilter("Lot No.", '<>%1', '');
        if ReservationEntry.FindSet() then
            repeat
                ReservationEntry.Delete();
            until ReservationEntry.Next() = 0;
    end;

    local procedure DeleteInvoiceSpecFromLine(var SalesLine: Record "Sales Line")
    var
        ItemTrackingMgt: Codeunit "Item Tracking Management";
    begin
        ItemTrackingMgt.DeleteInvoiceSpecFromLine(DATABASE::"Sales Line", SalesLine."Document Type".AsInteger(), SalesLine."Document No.", SalesLine."Line No.");
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnAfterInitAssocItemJnlLine', '', false, false)]
    local procedure SSDOnAfterInitAssocItemJnlLine(var ItemJournalLine: Record "Item Journal Line"; SalesLine: Record "Sales Line"; SalesHeader: Record "Sales Header")
    begin
        ItemJournalLine."Responsibility Center" := SalesHeader."Responsibility Center";
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnInsertShipmentHeaderOnBeforeTransferfieldsToSalesShptHeader', '', false, false)]
    local procedure SSDOnInsertShipmentHeaderOnBeforeTransferfieldsToSalesShptHeader(var SalesHeader: Record "Sales Header")
    var
        SalesReceivableSetup: Record "Sales & Receivables Setup";
    begin
        SalesReceivableSetup.Get();
        if SalesHeader."Document Type" <> SalesHeader."Document Type"::Order then exit;
        if SalesReceivableSetup."Ext. Doc. No. Mandatory" then SalesHeader.TestField("External Doc. Date");
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnBeforeInsertReturnReceiptHeader', '', false, false)]
    local procedure SSDOnBeforeInsertReturnReceiptHeader(SalesHeader: Record "Sales Header")
    var
        SalesReceivableSetup: Record "Sales & Receivables Setup";
    begin
        if SalesHeader."Document Type" <> SalesHeader."Document Type"::"Return Order" then exit;
        SalesReceivableSetup.Get();
        if SalesReceivableSetup."Ext. Doc. No. Mandatory" then SalesHeader.TestField("External Doc. Date");
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnInsertInvoiceHeaderOnAfterSalesInvHeaderTransferFields', '', false, false)]
    local procedure SSDOnInsertInvoiceHeaderOnAfterSalesInvHeaderTransferFields(var SalesHeader: Record "Sales Header"; var SalesInvoiceHeader: Record "Sales Invoice Header")
    var
        Customer: Record Customer;
        SalesLine: Record "Sales Line";
        ItemPhyBinDetails: Record "SSD Item Phy. Bin Details";
        SSDInsuranceSetup: Record "SSD Insurance Setup";
        AmtToCust: Decimal;
        TenDaysbeforeExpiryDateCalc: Date;
        MailList: List of [Text];
        CCMailList: List of [Text];
        BCCMailList: List of [Text];
    begin
        if SalesHeader."Document Type" = SalesHeader."Document Type"::Order then begin
            SalesInvoiceHeader.crminsertflag := false;
            SalesInvoiceHeader.crmupdateflag := false;
            SalesInvoiceHeader.isCRMexception := false;
            SalesInvoiceHeader."exception detail" := '';
            SalesInvoiceHeader.crmRelease := false;
            SalesInvoiceHeader."Actual Shipping Agent code" := SalesHeader."Shipping Agent Code";
            if Customer.GET(SalesHeader."Sell-to Customer No.") then if FORMAT(Customer."Shipping Time") <> '' then SalesInvoiceHeader."Expected Delivery Date" := CALCDATE(Customer."Shipping Time", SalesInvoiceHeader."Posting Date");
        end
        else begin
            SalesLine.RESET();
            SalesLine.SETRANGE("Document Type", SalesHeader."Document Type");
            SalesLine.SETRANGE("Document No.", SalesHeader."No.");
            SalesLine.SETFILTER(Type, '<>%1', SalesLine.Type::" ");
            if SalesLine.FINDFIRST() then;
            ItemPhyBinDetails.RESET();
            ItemPhyBinDetails.SETRANGE("Document No.", SalesLine."Despatch Slip No.");
            if ItemPhyBinDetails.FINDSET() then
                repeat
                    ItemPhyBinDetails."Posted Document No." := SalesHeader."Posting No.";
                    ItemPhyBinDetails.MODIFY();
                until ItemPhyBinDetails.NEXT() = 0;
        end;
        if SSDInsuranceSetup.GET(SalesHeader."Applied to Insurance Policy") then begin
            AmtToCust := 0;
            SalesLine.RESET();
            SalesLine.SETRANGE("Document No.", SalesHeader."No.");
            SalesLine.SETFILTER("No.", '<>%1', '');
            if SalesLine.FindSet() then
                repeat
                    AmtToCust += SalesLine."Amount"; //SSDU Amount to customer to be handled
                until SalesLine.NEXT() = 0;
            SSDInsuranceSetup."Balance Amount" := SSDInsuranceSetup."Insurance Amount" - SSDInsuranceSetup."Applied Amount" - AmtToCust;
            SSDInsuranceSetup."Applied Amount" += AmtToCust;
            SSDInsuranceSetup.MODIFY();

            //IG_AS 18-07-2025
            TenDaysbeforeExpiryDateCalc := CalcDate('-10D', SSDInsuranceSetup."Insurance Expiry Date");
            if (SSDInsuranceSetup."Balance Amount" < 500000000) or (TenDaysbeforeExpiryDateCalc = Today) then begin
                Clear(MailList);
                Clear(CCMailList);
                Clear(BCCMailList);
                MailList.Add('saggarwal@zavenir.com');
                MailList.Add('accounts2@zavenir.com');
                CCMailList.Add('sbajaj@zavenir.com');
                CCMailList.Add('zdit@zavenir.com');
                CCMailList.Add('lmohan@zavenir.com');
                EmailMsg.Create(MailList, 'Intimation about insurance policy renewal', '', true, CCMailList, BCCMailList);
                EmailMsg.AppendToBody('Dear Team,');
                EmailMsg.AppendToBody('<br><br>');
                EmailMsg.AppendToBody('Insurance policy Amount is going below specified amount please do the needfull changes.');
                EmailMsg.AppendToBody('<br><br>');
                EmailMsg.AppendToBody('Thanks and Regards');
                EmailMsg.AppendToBody('<br>');
                EmailMsg.AppendToBody('<b>' + CompanyName + '</b>');
                if Email.Send(EmailMsg) then
                    Message('Mail Sent')
                Else
                    Message('Mail Not Sent');
            end;
            //IG_AS 18-07-2025
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnInsertCrMemoHeaderOnAfterSalesCrMemoHeaderTransferFields', '', false, false)]
    local procedure SSDOnInsertCrMemoHeaderOnAfterSalesCrMemoHeaderTransferFields(var SalesHeader: Record "Sales Header"; var SalesCrMemoHeader: Record "Sales Cr.Memo Header")
    var
        SalesReceivableSetup: Record "Sales & Receivables Setup";
    begin
        if SalesHeader."Document Type" <> SalesHeader."Document Type"::"Return Order" then exit;
        SalesCrMemoHeader.crminsertflag := false;
        SalesCrMemoHeader.isCRMexception := false;
        SalesCrMemoHeader."exception detail" := '';
        SalesReceivableSetup.Get();
        if SalesReceivableSetup."Ext. Doc. No. Mandatory" then SalesHeader.TestField("External Doc. Date");
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post (Yes/No)", 'OnAfterConfirmPost', '', false, false)]
    local procedure SSDOnAfterConfirmPost(var SalesHeader: Record "Sales Header")
    var
        Slinerec: Record "Sales Line";
        SSDInsuranceSetup: Record "SSD Insurance Setup";
        AmtToCust: Decimal;
        Text50001: Label 'Unit Price cannot be 0';
    begin
        Slinerec.RESET();
        Slinerec.SETRANGE("Document No.", SalesHeader."No.");
        Slinerec.SETFILTER("No.", '<>%1', '');
        Slinerec.SetRange("Unit Price", 0);
        if Slinerec.FindSet() then Error(Text50001);
        if SalesHeader."Document Type" = SalesHeader."Document Type"::Invoice then //SSDU_Sunil
            if (SalesHeader."Type of Invoice") in [SalesHeader."Type of Invoice"::Normal, SalesHeader."Type of Invoice"::Commercial, SalesHeader."Type of Invoice"::Amazon] then SalesHeader.TESTFIELD("Expected Delivery Date");
        IF (SalesHeader."GST Customer Type" = SalesHeader."GST Customer Type"::Export) OR (SalesHeader."GST Customer Type" = SalesHeader."GST Customer Type"::"SEZ Unit") THEN BEGIN
            SalesHeader.TESTFIELD("GST Without Payment of Duty", TRUE);
        END;
        //SSDU_Sunil
        if SSDInsuranceSetup.GET(SalesHeader."Applied to Insurance Policy") then begin
            Slinerec.RESET();
            Slinerec.SETRANGE("Document No.", SalesHeader."No.");
            Slinerec.SETFILTER("No.", '<>%1', '');
            if Slinerec.FindSet() then
                repeat
                    AmtToCust += Slinerec."Amount"; //SSDU Amount to customer needs to be handled
                until Slinerec.NEXT() = 0;
            if AmtToCust > SSDInsuranceSetup."Balance Amount" then ERROR('Available Amount In Insurance Policy %1 is %2', SSDInsuranceSetup."Insurance Policy No.", SSDInsuranceSetup."Balance Amount");
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Reference Invoice No. Mgt.", 'OnBeforeCheckRefInvoiceNoSalesHeader', '', false, false)]
    local procedure SSDOnBeforeCheckRefInvoiceNoSalesHeader(var SalesHeader: Record "Sales Header"; var IsHandled: Boolean)
    begin
        IsHandled := true;
    end;
    //Posted Sales Invoice Update
    [EventSubscriber(ObjectType::Page, Page::"Posted Sales Inv. - Update", 'OnAfterRecordChanged', '', false, false)]
    local procedure SSDOnAfterRecordChanged(var SalesInvoiceHeader: Record "Sales Invoice Header"; xSalesInvoiceHeader: Record "Sales Invoice Header"; var IsChanged: Boolean)
    begin
        IsChanged := (SalesInvoiceHeader."LR/RR No." <> xSalesInvoiceHeader."LR/RR No.") or (SalesInvoiceHeader."LR/RR Date" <> xSalesInvoiceHeader."LR/RR Date") or (SalesInvoiceHeader."LR/RR No. Capture Date" <> xSalesInvoiceHeader."LR/RR No. Capture Date") or (SalesInvoiceHeader."LR/RR No. Capture Time" <> xSalesInvoiceHeader."LR/RR No. Capture Time") or (SalesInvoiceHeader."Actual Delivery Date" <> xSalesInvoiceHeader."Actual Delivery Date") or (SalesInvoiceHeader."Calculated Freight Amount" <> xSalesInvoiceHeader."Calculated Freight Amount") or (SalesInvoiceHeader."Shipping Agent Code" <> xSalesInvoiceHeader."Shipping Agent Code") or (SalesInvoiceHeader."Actual Shipping Agent code" <> xSalesInvoiceHeader."Actual Shipping Agent code") or (SalesInvoiceHeader."Transport Method" <> xSalesInvoiceHeader."Transport Method") or (SalesInvoiceHeader."Firm Freight" <> xSalesInvoiceHeader."Firm Freight") or (SalesInvoiceHeader."Freight Amount" <> xSalesInvoiceHeader."Freight Amount") or (SalesInvoiceHeader."Transportation Distance" <> xSalesInvoiceHeader."Transportation Distance") or (SalesInvoiceHeader."External Document No." <> xSalesInvoiceHeader."External Document No.") or (SalesInvoiceHeader.Remarks1 <> xSalesInvoiceHeader.Remarks1);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales Inv. Header - Edit", 'OnOnRunOnBeforeTestFieldNo', '', false, false)]
    local procedure KMIOnBeforeSalesShptHeaderModify(var SalesInvoiceHeader: Record "Sales Invoice Header"; SalesInvoiceHeaderRec: Record "Sales Invoice Header")
    begin
        SalesInvoiceHeader."LR/RR No." := SalesInvoiceHeaderRec."LR/RR No.";
        SalesInvoiceHeader."LR/RR Date" := SalesInvoiceHeaderRec."LR/RR Date";
        SalesInvoiceHeader."LR/RR No. Capture Date" := SalesInvoiceHeaderRec."LR/RR No. Capture Date";
        SalesInvoiceHeader."LR/RR No. Capture Time" := SalesInvoiceHeaderRec."LR/RR No. Capture Time";
        SalesInvoiceHeader."Actual Delivery Date" := SalesInvoiceHeaderRec."Actual Delivery Date";
        SalesInvoiceHeader."Calculated Freight Amount" := SalesInvoiceHeaderRec."Calculated Freight Amount";
        SalesInvoiceHeader."Shipping Agent Code" := SalesInvoiceHeaderRec."Shipping Agent Code";
        SalesInvoiceHeader."Actual Shipping Agent code" := SalesInvoiceHeaderRec."Actual Shipping Agent code";
        SalesInvoiceHeader."Transport Method" := SalesInvoiceHeaderRec."Transport Method";
        SalesInvoiceHeader."Firm Freight" := SalesInvoiceHeaderRec."Firm Freight";
        SalesInvoiceHeader."Freight Amount" := SalesInvoiceHeaderRec."Freight Amount";
        SalesInvoiceHeader."Transportation Distance" := SalesInvoiceHeaderRec."Transportation Distance";
        SalesInvoiceHeader."External Document No." := SalesInvoiceHeaderRec."External Document No.";
        SalesInvoiceHeader.Remarks1 := SalesInvoiceHeaderRec.Remarks1;
    end;

    [EventSubscriber(ObjectType::Table, Database::"Sales Header", 'OnAfterInitRecord', '', false, false)]
    procedure UpdateafterInit(var SalesHeader: Record "Sales Header")
    var
        UserSetup: Record "User Setup";
    begin
        case SalesHeader."Document Type" of
            SalesHeader."Document Type"::Invoice:
                begin
                    UserSetup.Get(UserId);
                    SalesHeader."Type of Invoice" := UserSetup."Type of Invoice";
                end;
            SalesHeader."Document Type"::"Credit Memo":
                begin
                    UserSetup.Get(UserId);
                    SalesHeader."Type of Invoice" := UserSetup."Type of Invoice";
                end;
        end;
    end;
    //OnBeforeCheckRefInvoiceNoSalesHeader
    [EventSubscriber(ObjectType::Page, Page::"Sales Order", 'OnBeforeActionEvent', 'SendApprovalRequest', false, false)]
    local procedure SSDOnClickSendApproval(var Rec: Record "Sales Header")
    var
        SalesLine2: Record "Sales Line";
        Item: Record Item;
        ItemCategory: Record "Item Category";
        ConfirmText: Label 'Order Quantity is less than MOQ Quantity. Do you still want to proceed further?';
    begin
        SalesLine2.Reset();
        SalesLine2.SetRange("Document No.", Rec."No.");
        SalesLine2.SetRange("Document Type", SalesLine2."Document Type"::Order);
        if SalesLine2.FindSet() then
            repeat
                if Item.Get(SalesLine2."No.") then begin
                    ItemCategory.Reset();
                    ItemCategory.SetRange(Code, Item."Item Category Code");
                    if ItemCategory.FindFirst() then begin
                        if (ItemCategory."Parent Category" = 'VCI FILM') and (SalesLine2.Quantity < Item.MOQ) then begin
                            if not Confirm(ConfirmText, false) then Error('Order Quantity is less than MOQ Quantity');
                        end;
                    end;
                end;
                if SalesLine2."Unit Price" = SalesLine2."Unit Price Dup." then
                    SalesLine2."Price Match/Mismatch" := true
                else
                    SalesLine2."Price Match/Mismatch" := false;
                SalesLine2.Modify();
            until SalesLine2.Next() = 0;
    end;

    [EventSubscriber(ObjectType::Table, Database::"Sales Header", 'OnAfterGetNoSeriesCode', '', true, true)]
    local procedure OnAfterGetNoSeriesCode(var SalesHeader: Record "Sales Header"; SalesReceivablesSetup: Record "Sales & Receivables Setup"; var NoSeriesCode: Code[20])
    begin
        case SalesHeader."Document Type" of
            SalesHeader."Document Type"::Order:
                begin
                    case SalesHeader."Document Subtype" of
                        SalesHeader."Document Subtype"::Order:
                            begin
                                SalesReceivablesSetup.TestField("Order Nos.");
                                NoSeriesCode := SalesReceivablesSetup."Order Nos.";
                            end;
                        SalesHeader."Document Subtype"::Despatch:
                            begin
                                SalesReceivablesSetup.TestField("Sales Dispatch No.");
                                NoSeriesCode := SalesReceivablesSetup."Sales Dispatch No.";
                            end;
                    end;
                end;
        end;
    end;

    var
        EmailMsg: Codeunit "Email Message";
        Email: Codeunit Email;
}
