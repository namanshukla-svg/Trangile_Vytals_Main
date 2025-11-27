Page 50034 "Sales Desp. Order Subform"
{
    // //vipin to get correct tax group code in case of spares
    // ALLE 3.15....ARE3
    // ALLE 3.16....ARE3
    // ALLE 3.08....Freight Zone
    AutoSplitKey = true;
    Caption = 'Sales Despatch Order Subform';
    DelayedInsert = true;
    InsertAllowed = false;
    MultipleNewLines = true;
    PageType = ListPart;
    SourceTable = "Sales Line";
    SourceTableView = sorting("Document Type", "Document No.", "Line No.") order(descending) where("Document Type" = filter(Order));
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                Editable = true;

                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    Caption = 'Item No.';
                    Editable = false;

                    trigger OnValidate()
                    begin
                        Rec.ShowShortcutDimCode(ShortcutDimCode);
                        NoOnAfterValidate;
                    end;
                }
                field("No.2"; Rec."No.2")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    Editable = true;
                }
                field("Description 2"; Rec."Description 2")
                {
                    ApplicationArea = All;
                }
                field("Document Type"; Rec."Document Type")
                {
                    ApplicationArea = All;
                }
                field("Cross-Reference Desc."; Rec."Cross-Reference Desc.")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Variant Code"; Rec."Variant Code")
                {
                    ApplicationArea = All;
                    Visible = true;
                    Editable = false;
                }
                field("Location Code"; Rec."Location Code")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Bin Code"; Rec."Bin Code")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field(Reserve; Rec.Reserve)
                {
                    ApplicationArea = All;
                    Visible = false;

                    trigger OnValidate()
                    begin
                        ReserveOnAfterValidate;
                    end;
                }
                field("Total Schedule Quantity"; Rec."Total Schedule Quantity")
                {
                    ApplicationArea = All;
                    Caption = 'Total Order Qty.';
                    Editable = false;
                }
                field("No of Pack"; Rec."No of Pack")
                {
                    ApplicationArea = All;
                    Caption = 'No of Box/Bin/Trolley';
                    Editable = false;

                    trigger OnValidate()
                    begin
                        //CF001 St
                        if ((Rec."No of Pack") * (Rec."Qty Per Pack")) > Rec."Total Schedule Quantity" then Error(Text001);
                        Rec.Validate(Quantity, ((Rec."No of Pack") * (Rec."Qty Per Pack")));
                        Rec.InitQtyToShip;
                        //CF001 En
                    end;
                }
                field(Quantity; Rec.Quantity)
                {
                    ApplicationArea = All;
                    BlankZero = true;
                    Caption = 'Total Quantity';
                    Editable = false;

                    trigger OnLookup(var Text: Text): Boolean
                    var
                        SalesScheduleBufferLocal: Record "SSD Sales Schedule Buffer";
                        SalesPacketDetailsForm: Page "Sales Packet Details";
                    begin
                        //CF002 St
                        if Rec.Type = Rec.Type::Item then begin
                            SalesScheduleBufferLocal.Reset;
                            SalesScheduleBufferLocal.SetRange("Document Type", Rec."Document Type");
                            SalesScheduleBufferLocal.SetRange("Document No.", Rec."Document No.");
                            SalesScheduleBufferLocal.SetRange("Sell-to Customer No.", Rec."Sell-to Customer No.");
                            SalesScheduleBufferLocal.SetRange("Item No.", Rec."No.");
                            SalesScheduleBufferLocal.SetRange("Order Line No.", Rec."Line No.");
                            SalesScheduleBufferLocal.SetFilter("No. of Box", '<>0', 0);
                            Clear(SalesPacketDetailsForm);
                            SalesPacketDetailsForm.SetRecord(SalesScheduleBufferLocal);
                            SalesPacketDetailsForm.SetTableview(SalesScheduleBufferLocal);
                            SalesPacketDetailsForm.LookupMode := true;
                            SalesPacketDetailsForm.Editable := false;
                            SalesPacketDetailsForm.RunModal;
                        end;
                        //CF002 En
                    end;

                    trigger OnValidate()
                    begin
                        if Rec.Quantity > Rec."Total Schedule Quantity" then Error(Text001);
                        Rec.InitQtyToShip;
                        QuantityOnAfterValidate;
                        //CORP::PK 181019 >>>
                        if Rec.Quantity = 0 then begin
                            ItemPhyBinDetails.Reset;
                            ItemPhyBinDetails.SetRange("Document No.", Rec."Document No.");
                            ItemPhyBinDetails.SetRange("Item No.", Rec."No.");
                            ItemPhyBinDetails.SetRange("Document Line No.", Rec."Line No.");
                            ItemPhyBinDetails.SetRange("Posted Document No.", '');
                            if ItemPhyBinDetails.FindSet then ItemPhyBinDetails.DeleteAll;
                        end;
                        //CORP::PK 181019 <<<
                    end;
                }
                field("Actual Wt"; Rec."Actual Wt")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Gross Wt"; Rec."Gross Wt")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Unit of Measure Code"; Rec."Unit of Measure Code")
                {
                    ApplicationArea = All;
                    Editable = false;

                    trigger OnValidate()
                    begin
                        UnitofMeasureCodeOnAfterValida;
                    end;
                }
                field("Unit of Measure"; Rec."Unit of Measure")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Quantity Shipped"; Rec."Quantity Shipped")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Quantity Invoiced"; Rec."Quantity Invoiced")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
            }
            group(ItemPanel)
            {
                Caption = 'Item Information';

                field("STRSUBSTNO('(%1)',SalesInfoPaneMgt.CalcAvailability(Rec))"; StrSubstNo('(%1)', SalesInfoPaneMgt.CalcAvailability(Rec)))
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("STRSUBSTNO('(%1)',SalesInfoPaneMgt.CalcNoOfSubstitutions(Rec))"; StrSubstNo('(%1)', SalesInfoPaneMgt.CalcNoOfSubstitutions(Rec)))
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("STRSUBSTNO('(%1)',SalesInfoPaneMgt.CalcNoOfSalesPrices(Rec))"; StrSubstNo('(%1)', SalesInfoPaneMgt.CalcNoOfSalesPrices(Rec)))
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("STRSUBSTNO('(%1)',SalesInfoPaneMgt.CalcNoOfSalesLineDisc(Rec))"; StrSubstNo('(%1)', SalesInfoPaneMgt.CalcNoOfSalesLineDisc(Rec)))
                {
                    ApplicationArea = All;
                    Editable = false;
                }
            }
        }
    }
    actions
    {
        area(processing)
        {
            group("&Line")
            {
                Caption = '&Line';

                group("Item Availability by")
                {
                    Caption = 'Item Availability by';

                    action(Period)
                    {
                        ApplicationArea = All;
                        Caption = 'Period';

                        trigger OnAction()
                        begin
                            //This functionality was copied from page #50033. Unsupported part was commented. Please check it.
                            /*CurrPage.SalesLines.PAGE.*/
                            _ItemAvailability(0);
                        end;
                    }
                    action(Variant)
                    {
                        ApplicationArea = All;
                        Caption = 'Variant';

                        trigger OnAction()
                        begin
                            //This functionality was copied from page #50033. Unsupported part was commented. Please check it.
                            /*CurrPage.SalesLines.PAGE.*/
                            _ItemAvailability(1);
                        end;
                    }
                    action(Location)
                    {
                        ApplicationArea = All;
                        Caption = 'Location';

                        trigger OnAction()
                        begin
                            //This functionality was copied from page #50033. Unsupported part was commented. Please check it.
                            /*CurrPage.SalesLines.PAGE.*/
                            _ItemAvailability(2);
                        end;
                    }
                }
                action("Reservation Entries")
                {
                    ApplicationArea = All;
                    Caption = 'Reservation Entries';
                    Image = ReservationLedger;
                    Visible = false;

                    trigger OnAction()
                    begin
                        //This functionality was copied from page #50033. Unsupported part was commented. Please check it.
                        /*CurrPage.SalesLines.PAGE.*/
                        _ShowReservationEntries;
                    end;
                }
                action("Item &Tracking Lines")
                {
                    ApplicationArea = All;
                    Caption = 'Item &Tracking Lines';
                    Image = ItemTrackingLines;

                    trigger OnAction()
                    begin
                        //This functionality was copied from page #50033. Unsupported part was commented. Please check it.
                        /*CurrPage.SalesLines.PAGE.*/
                        _OpenItemTrackingLines;
                    end;
                }
                action("Select Item Substitution")
                {
                    ApplicationArea = All;
                    Caption = 'Select Item Substitution';
                    Image = SelectItemSubstitution;
                    Visible = false;

                    trigger OnAction()
                    begin
                        //This functionality was copied from page #50033. Unsupported part was commented. Please check it.
                        /*CurrPage.SalesLines.PAGE.*/
                        _ShowItemSub;
                    end;
                }
                action(Dimensions)
                {
                    ApplicationArea = All;
                    Caption = 'Dimensions';
                    Image = Dimensions;
                    ShortCutKey = 'Shift+Ctrl+D';
                    Visible = false;

                    trigger OnAction()
                    begin
                        //This functionality was copied from page #50033. Unsupported part was commented. Please check it.
                        /*CurrPage.SalesLines.PAGE.*/
                        _ShowDimensions;
                    end;
                }
                action("Item Charge &Assignment")
                {
                    ApplicationArea = All;
                    Caption = 'Item Charge &Assignment';
                    Visible = false;

                    trigger OnAction()
                    begin
                        //This functionality was copied from page #50033. Unsupported part was commented. Please check it.
                        /*CurrPage.SalesLines.PAGE.*/
                        ItemChargeAssgnt;
                    end;
                }
                action("Item Phy. Bin Details")
                {
                    ApplicationArea = All;
                    Caption = 'Item Phy. Bin Details';
                    Image = BinJournal;
                    ShortCutKey = 'Shift+Ctrl+P';

                    trigger OnAction()
                    var
                        ReservationEntry: Record "Reservation Entry";
                        EntryNo: Integer;
                        LotNo: Code[20];
                        Item: Record Item;
                        LineNo: Integer;
                    begin
                        //CORP::PK 050719 >>>
                        if Rec.Type <> Rec.Type::" " then begin
                            if Location.Get(Rec."Location Code") then;
                            if Item.Get(Rec."No.") then;
                            if (Location."Phy. Bin Required") and (Item."Phy. Bin Required") then begin
                                LotNo := '';
                                ReservationEntry.Reset;
                                ReservationEntry.SetRange("Source ID", Rec."Document No.");
                                ReservationEntry.SetRange("Source Ref. No.", Rec."Line No.");
                                ReservationEntry.SetRange("Item No.", Rec."No.");
                                ReservationEntry.SetRange("Item Ledger Entry No.", 0);
                                if ReservationEntry.FindFirst then LotNo := ReservationEntry."Lot No.";
                                ItemPhyBinDetails.Reset;
                                ItemPhyBinDetails.SetRange("Document No.", Rec."Document No.");
                                ItemPhyBinDetails.SetRange("Document Line No.", Rec."Line No.");
                                ItemPhyBinDetails.SetRange("Posted Document No.", '');
                                if not ItemPhyBinDetails.FindFirst then begin
                                    ReservationEntry.Reset;
                                    ReservationEntry.SetRange("Source ID", Rec."Document No.");
                                    ReservationEntry.SetRange("Source Ref. No.", Rec."Line No.");
                                    ReservationEntry.SetRange("Item No.", Rec."No.");
                                    ReservationEntry.SetRange("Item Ledger Entry No.", 0);
                                    if ReservationEntry.FindSet then
                                        repeat
                                            ItemPhyBinDetails.Reset;
                                            ItemPhyBinDetails.SetRange("Document No.", Rec."Document No.");
                                            if ItemPhyBinDetails.FindLast then
                                                LineNo := ItemPhyBinDetails."Line No." + 10000
                                            else
                                                LineNo := 10000;
                                            ItemPhyBinDetails.Init;
                                            ItemPhyBinDetails.Validate("Line No.", LineNo);
                                            ItemPhyBinDetails.Validate("Document No.", Rec."Document No.");
                                            ItemPhyBinDetails.Validate("Document Line No.", Rec."Line No.");
                                            ItemPhyBinDetails.Validate("Item No.", Rec."No.");
                                            ItemPhyBinDetails.Validate("Unit Of Measure", Rec."Unit of Measure Code");
                                            ItemPhyBinDetails.Validate("Qty. Per Unit Of Measure", Rec."Qty. per Unit of Measure");
                                            ItemPhyBinDetails.Validate("Location Code", Rec."Location Code");
                                            ItemPhyBinDetails.Validate("Bin Code", Rec."Bin Code");
                                            ItemPhyBinDetails.Validate("Lot No.", ReservationEntry."Lot No.");
                                            ItemPhyBinDetails.Validate("Document Type", ItemPhyBinDetails."document type"::"Sales Invoice");
                                            ItemPhyBinDetails.Validate("Posting Date", Rec."Posting Date");
                                            ItemPhyBinDetails.Validate("Variant Code", Rec."Variant Code"); //Alle 26052021
                                            ItemPhyBinDetails.Insert;
                                        until ReservationEntry.Next = 0;
                                end;
                                Commit;
                                ItemPhyBinDetails.Reset;
                                ItemPhyBinDetails.SetRange("Document No.", Rec."Document No.");
                                ItemPhyBinDetails.SetRange("Document Line No.", Rec."Line No.");
                                ItemPhyBinDetails.SetRange("Posted Document No.", '');
                                Page.RunModal(50238, ItemPhyBinDetails);
                            end;
                        end;
                        //CORP::PK 050719 <<<
                    end;
                }
                action("Packet Details")
                {
                    ApplicationArea = All;
                    Caption = 'Packet Details';

                    trigger OnAction()
                    begin
                        //CF001 St
                        //CheckOrderStatus(Rec);
                        //This functionality was copied from page #50033. Unsupported part was commented. Please check it.
                        /*CurrPage.SalesLines.PAGE.*/
                        PacketQuantity;
                        //CF001 En
                    end;
                }
            }
            group("F&unctions")
            {
                Caption = 'F&unctions';

                action("E&xplode BOM")
                {
                    ApplicationArea = All;
                    Caption = 'E&xplode BOM';
                    Image = ExplodeBOM;
                    Visible = false;

                    trigger OnAction()
                    begin
                        //This functionality was copied from page #50033. Unsupported part was commented. Please check it.
                        /*CurrPage.SalesLines.PAGE.*/
                        ExplodeBOM;
                    end;
                }
                action("Insert &Ext. Texts")
                {
                    ApplicationArea = All;
                    Caption = 'Insert &Ext. Texts';
                    Visible = false;

                    trigger OnAction()
                    begin
                        //This functionality was copied from page #50033. Unsupported part was commented. Please check it.
                        /*CurrPage.SalesLines.PAGE.*/
                        _InsertExtendedText(true);
                    end;
                }
                action("&Reserve")
                {
                    ApplicationArea = All;
                    Caption = '&Reserve';
                    Ellipsis = true;
                    Visible = false;

                    trigger OnAction()
                    begin
                        //This functionality was copied from page #50033. Unsupported part was commented. Please check it.
                        /*CurrPage.SalesLines.PAGE.*/
                        _ShowReservation;
                    end;
                }
                action("Order &Tracking")
                {
                    ApplicationArea = All;
                    Caption = 'Order &Tracking';
                    Visible = false;

                    trigger OnAction()
                    begin
                        //This functionality was copied from page #50033. Unsupported part was commented. Please check it.
                        /*CurrPage.SalesLines.PAGE.*/
                        ShowTracking;
                    end;
                }
            }
            group("O&rder")
            {
                Caption = 'O&rder';

                group("Dr&op Shipment")
                {
                    Caption = 'Dr&op Shipment';
                    Visible = false;

                    action("Purchase &Order")
                    {
                        ApplicationArea = All;
                        Caption = 'Purchase &Order';
                        Image = Document;
                        Visible = false;

                        trigger OnAction()
                        begin
                            //This functionality was copied from page #50033. Unsupported part was commented. Please check it.
                            /*CurrPage.SalesLines.PAGE.*/
                            OpenPurchOrderForm;
                        end;
                    }
                }
                group("Speci&al Order")
                {
                    Caption = 'Speci&al Order';
                    Visible = false;

                    action(Action1903192904)
                    {
                        ApplicationArea = All;
                        Caption = 'Purchase &Order';
                        Image = Document;
                        Visible = false;

                        trigger OnAction()
                        begin
                            //This functionality was copied from page #50033. Unsupported part was commented. Please check it.
                            /*CurrPage.SalesLines.PAGE.*/
                            OpenSpecialPurchOrderForm;
                        end;
                    }
                }
            }
            action("Sales Line &Discounts")
            {
                ApplicationArea = All;
                Caption = 'Sales Line &Discounts';
                Image = SalesLineDisc;

                trigger OnAction()
                begin
                    ShowLineDisc;
                    CurrPage.Update;
                end;
            }
            action("&Sales Prices")
            {
                ApplicationArea = All;
                Caption = '&Sales Prices';
                Image = SalesPrices;

                trigger OnAction()
                begin
                    ShowPrices;
                    CurrPage.Update;
                end;
            }
            action("Substitutio&ns")
            {
                ApplicationArea = All;
                Caption = 'Substitutio&ns';

                trigger OnAction()
                begin
                    Rec.ShowItemSub;
                    CurrPage.Update;
                end;
            }
            action("Availa&bility")
            {
                ApplicationArea = All;
                Caption = 'Availa&bility';

                trigger OnAction()
                begin
                    ItemAvailability(0);
                end;
            }
            action("Ite&m Card")
            {
                ApplicationArea = All;
                Caption = 'Ite&m Card';

                trigger OnAction()
                begin
                    SalesInfoPaneMgt.LookupItem(Rec);
                end;
            }
            action("Remove Item Tracking")
            {
                ApplicationArea = All;
                Caption = 'Remove Item Tracking';
                Image = RemoveLine;
                RunObject = Report "Remove Reservation Dispatch";
            }
        }
    }
    trigger OnAfterGetRecord()
    begin
        Rec.ShowShortcutDimCode(ShortcutDimCode);
    end;

    trigger OnDeleteRecord(): Boolean
    begin
        CheckOrderStatus(Rec);
        //CORP::PK 181019 >>>
        ItemPhyBinDetails.Reset;
        ItemPhyBinDetails.SetRange("Document No.", Rec."Document No.");
        ItemPhyBinDetails.SetRange("Item No.", Rec."No.");
        ItemPhyBinDetails.SetRange("Document Line No.", Rec."Line No.");
        ItemPhyBinDetails.SetRange("Posted Document No.", '');
        if ItemPhyBinDetails.FindSet then ItemPhyBinDetails.DeleteAll;
        //CORP::PK 181019 <<<
    end;

    trigger OnModifyRecord(): Boolean
    begin
        CheckOrderStatus(Rec);
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec.Type := Rec.Type::Item;
        Clear(ShortcutDimCode);
    end;

    var
        SalesHeader: Record "Sales Header";
        SalesPriceCalcMgt: Codeunit "Sales Price Calc. Mgt.";
        TransferExtendedText: Codeunit "Transfer Extended Text";
        SalesInfoPaneMgt: Codeunit "Sales Info-Pane Management";
        ShortcutDimCode: array[8] of Code[20];
        ItemCheckAvail: Codeunit "Item-Check Avail.";
        Text001: label 'Total Despatch Quantity cann''t be more than Total Order Quantity';
        Text002: label 'Modification can''t be done\\ Already Invoice done in Despatch Slip No. %1,  Line No %2, Item No. %3 ';
        Item: Record Item;
        Location: Record Location;
        ItemPhyBinDetails: Record "SSD Item Phy. Bin Details";

    procedure ApproveCalcInvDisc()
    begin
        Codeunit.Run(Codeunit::"Sales-Disc. (Yes/No)", Rec);
    end;

    procedure CalcInvDisc()
    begin
        Codeunit.Run(Codeunit::"Sales-Calc. Discount", Rec);
    end;

    procedure ExplodeBOM()
    begin
        Codeunit.Run(Codeunit::"Sales-Explode BOM", Rec);
    end;

    procedure OpenPurchOrderForm()
    var
        PurchHeader: Record "Purchase Header";
        PurchOrder: Page "Purchase Order";
    begin
        PurchHeader.SetRange("No.", Rec."Purchase Order No.");
        PurchOrder.SetTableview(PurchHeader);
        PurchOrder.Editable := false;
        PurchOrder.Run;
    end;

    procedure OpenSpecialPurchOrderForm()
    var
        PurchHeader: Record "Purchase Header";
        PurchOrder: Page "Purchase Order";
    begin
        PurchHeader.SetRange("No.", Rec."Special Order Purchase No.");
        PurchOrder.SetTableview(PurchHeader);
        PurchOrder.Editable := false;
        PurchOrder.Run;
    end;

    procedure _InsertExtendedText(Unconditionally: Boolean)
    begin
        if TransferExtendedText.SalesCheckIfAnyExtText(Rec, Unconditionally) then begin
            CurrPage.SaveRecord;
            TransferExtendedText.InsertSalesExtText(Rec);
        end;
        if TransferExtendedText.MakeUpdate then UpdateForm(true);
    end;

    procedure InsertExtendedText(Unconditionally: Boolean)
    begin
        if TransferExtendedText.SalesCheckIfAnyExtText(Rec, Unconditionally) then begin
            CurrPage.SaveRecord;
            TransferExtendedText.InsertSalesExtText(Rec);
        end;
        if TransferExtendedText.MakeUpdate then UpdateForm(true);
    end;

    procedure _ShowReservation()
    begin
        Rec.Find;
        Rec.ShowReservation;
    end;

    procedure _ItemAvailability(AvailabilityType: Option Date,Variant,Location,Bin)
    begin
        //Rec.ItemAvailability(AvailabilityType); // BIS 1145
    end;

    procedure ItemAvailability(AvailabilityType: Option Date,Variant,Location,Bin)
    begin
        //Rec.ItemAvailability(AvailabilityType); // BIS 1145
    end;

    procedure _ShowReservationEntries()
    begin
        Rec.ShowReservationEntries(true);
    end;

    procedure ShowReservationEntries()
    begin
        Rec.ShowReservationEntries(true);
    end;

    procedure _ShowDimensions()
    begin
        Rec.ShowDimensions;
    end;

    procedure _ShowItemSub()
    begin
        Rec.ShowItemSub;
    end;

    procedure ShowNonstockItems()
    begin
        Rec.ShowNonstock;
    end;

    procedure _OpenItemTrackingLines()
    begin
        Rec.OpenItemTrackingLines;
    end;

    procedure ShowTracking()
    var
        TrackingForm: Page "Order Tracking";
    begin
        TrackingForm.SetSalesLine(Rec);
        TrackingForm.RunModal;
    end;

    procedure ItemChargeAssgnt()
    begin
        Rec.ShowItemChargeAssgnt;
    end;

    procedure UpdateForm(SetSaveRecord: Boolean)
    begin
        CurrPage.Update(SetSaveRecord);
    end;

    procedure ShowPrices()
    begin
        SalesHeader.Get(Rec."Document Type", Rec."Document No.");
        Clear(SalesPriceCalcMgt);
        SalesPriceCalcMgt.GetSalesLinePrice(SalesHeader, Rec);
    end;

    procedure ShowLineDisc()
    begin
        SalesHeader.Get(Rec."Document Type", Rec."Document No.");
        Clear(SalesPriceCalcMgt);
        SalesPriceCalcMgt.GetSalesLineLineDisc(SalesHeader, Rec);
    end;

    procedure OrderPromisingLine()
    var
        OrderPromisingLine: Record "Order Promising Line" temporary;
    begin
        OrderPromisingLine.SetRange("Source Type", Rec."Document Type");
        OrderPromisingLine.SetRange("Source ID", Rec."Document No.");
        OrderPromisingLine.SetRange("Source Line No.", Rec."Line No.");
        Page.RunModal(Page::"Order Promising Lines", OrderPromisingLine);
    end;

    procedure DeleteDespatchLines(var RecToSalesHeader: Record "Sales Header")
    var
        SalesLineLocal: Record "Sales Line";
        SalesPacketBufferLocal: Record "SSD Sales Schedule Buffer";
    begin
        //CF001 St
        SalesLineLocal.Reset;
        SalesLineLocal.SetRange("Document Type", RecToSalesHeader."Document Type");
        SalesLineLocal.SetRange("Document No.", RecToSalesHeader."No.");
        SalesLineLocal.SetRange("Document Subtype", SalesLineLocal."document subtype"::Despatch);
        if SalesLineLocal.FindSet then
            repeat
                SalesLineLocal.Delete;
                SalesPacketBufferLocal.Reset;
                SalesPacketBufferLocal.SetRange("Document Type", SalesLineLocal."Document Type");
                SalesPacketBufferLocal.SetRange("Document No.", SalesLineLocal."Document No.");
                SalesPacketBufferLocal.SetRange("Sell-to Customer No.", SalesLineLocal."Sell-to Customer No.");
                SalesPacketBufferLocal.SetRange("Item No.", SalesLineLocal."No.");
                SalesPacketBufferLocal.SetRange("Order Line No.", SalesLineLocal."Line No.");
                if SalesPacketBufferLocal.FindSet then SalesPacketBufferLocal.DeleteAll;
            until SalesLineLocal.Next = 0;
        //CF001 En
    end;

    procedure CopySalesDoc(FromDocType: Option; FromDocNo: Code[20]; var ToSalesHeader: Record "Sales Header")
    var
        ToSalesLine: Record "Sales Line";
        OldSalesHeader: Record "Sales Header";
        FromSalesHeader: Record "Sales Header";
        FromSalesLine: Record "Sales Line";
        NextLineNo: Integer;
        LinesNotCopied: Integer;
        TransferOldExtLines: Codeunit "Transfer Old Ext. Text Lines";
        SalesLineLocal: Record "Sales Line";
    begin
        //CF001 St
        TransferOldExtLines.ClearLineNumbers;
        case FromDocType of
            SalesHeader."document type"::Order:
                begin
                    FromSalesHeader.Get(SalesHeaderDocType(FromDocType), FromDocNo);
                    if ToSalesHeader."Document Type" in [ToSalesHeader."document type"::Order] then begin
                        FromSalesLine.SetCurrentkey("Document Type", "Document No.", Type, "No.");
                        FromSalesLine.SetRange("Document Type", FromSalesHeader."Document Type");
                        FromSalesLine.SetRange("Document No.", FromSalesHeader."No.");
                        // FromSalesLine.SETRANGE(Type,FromSalesLine.Type::Item);
                        FromSalesLine.SetFilter("No.", '<>%1', '');
                        //Alle VPB FromSalesLine.SETFILTER("Shipment Date",'<=%1',ToSalesHeader."Order Date");
                        FromSalesLine.SetFilter("Qty. to Ship", '>%1', 0);
                        if FromSalesLine.FindSet then
                            repeat
                                if FromSalesLine."Qty. to Ship" > 0 then begin
                                    ToSalesLine."No." := FromSalesLine."No.";
                                    ToSalesLine."Variant Code" := FromSalesLine."Variant Code";
                                    ToSalesLine."Location Code" := FromSalesLine."Location Code";
                                    ToSalesLine."Bin Code" := FromSalesLine."Bin Code";
                                    ToSalesLine."Unit of Measure Code" := FromSalesLine."Unit of Measure Code";
                                    ToSalesLine."Qty. per Unit of Measure" := FromSalesLine."Qty. per Unit of Measure";
                                    ToSalesLine."Outstanding Quantity" := FromSalesLine."Qty. to Ship";
                                    ToSalesLine."Drop Shipment" := FromSalesLine."Drop Shipment";
                                    CheckItemAvailable1(ToSalesHeader, ToSalesLine);
                                    //vipin to get correct tax group code in case of spares
                                    ToSalesLine."Tax Group Code" := FromSalesLine."Tax Group Code";
                                    //vipin to get correct tax group code in case of spares end;
                                    ToSalesLine."Description 2" := FromSalesLine."Description 2";
                                end;
                            until FromSalesLine.Next = 0;
                    end;
                end;
        end;
        //DocDim.LOCKTABLE; // BIS 1145
        ToSalesLine.LockTable;
        if ToSalesLine.Find('+') then
            NextLineNo := ToSalesLine."Line No."
        else
            NextLineNo := 0;
        if not ToSalesHeader.RECORDLEVELLOCKING then ToSalesHeader.LockTable(true, true);
        LinesNotCopied := 0;
        case FromDocType of
            SalesHeader."document type"::Order:
                begin
                    FromSalesLine.Reset;
                    FromSalesLine.SetCurrentkey("Document Type", "Document No.", Type, "No.");
                    FromSalesLine.SetRange("Document Type", FromSalesHeader."Document Type");
                    FromSalesLine.SetRange("Document No.", FromSalesHeader."No.");
                    // FromSalesLine.SETRANGE(Type,FromSalesLine.Type::Item);
                    FromSalesLine.SetFilter("No.", '<>%1', '');
                    //Alle VPB FromSalesLine.SETFILTER("Shipment Date",'<=%1',ToSalesHeader."Order Date");
                    FromSalesLine.SetFilter("Qty. to Ship", '>%1', 0);
                    if FromSalesLine.FindSet then
                        repeat /* Alle VPB Commented this is not required feature
                        SalesLineLocal.RESET;
                        SalesLineLocal.SETCURRENTKEY("Document Type","Document No.",Type,"No.");
                        SalesLineLocal.SETRANGE("Document Type",ToSalesHeader."Document Type");
                        SalesLineLocal.SETRANGE("Document No.",ToSalesHeader."No.");
                        SalesLineLocal.SETRANGE(Type,SalesLineLocal.Type::Item);
                        SalesLineLocal.SETRANGE("No.",FromSalesLine."No.");
                        IF SalesLineLocal.FINDSET THEN
                          BEGIN
                              SalesLineLocal."Total Schedule Quantity":=SalesLineLocal."Total Schedule Quantity" +FromSalesLine."Qty. to Ship"
          ;
                            SalesLineLocal.MODIFY;
                          END
                        ELSE
                         Alle VPB Commented this is not required feature */
                        begin
                            CopySalesLine(ToSalesHeader, ToSalesLine, FromSalesHeader, FromSalesLine, NextLineNo, LinesNotCopied, 0);
                            CopyFromSalesDocDimToLine(ToSalesLine, FromSalesLine);
                        end;
                        until FromSalesLine.Next = 0;
                end;
        end;
        //CF001 En
    end;

    procedure SalesHeaderDocType(DocType: Option): Integer
    var
        SalesHeader: Record "Sales Header";
    begin
        //CF001 St
        case DocType of
            SalesHeader."document type"::Quote:
                exit(SalesHeader."document type"::Quote);
            SalesHeader."document type"::"Blanket Order":
                exit(SalesHeader."document type"::"Blanket Order");
            SalesHeader."document type"::Order:
                exit(SalesHeader."document type"::Order);
            SalesHeader."document type"::Invoice:
                exit(SalesHeader."document type"::Invoice);
            SalesHeader."document type"::"Return Order":
                exit(SalesHeader."document type"::"Return Order");
            SalesHeader."document type"::"Credit Memo":
                exit(SalesHeader."document type"::"Credit Memo");
        end;
        //CF001 En
    end;

    local procedure CheckItemAvailable1(var ToSalesHeader: Record "Sales Header"; var ToSalesLine: Record "Sales Line")
    begin
        //CF001 St
        ToSalesLine."Document Type" := ToSalesHeader."Document Type";
        ToSalesLine."Document No." := ToSalesHeader."No.";
        ToSalesLine."Line No." := 0;
        ToSalesLine.Type := ToSalesLine.Type::Item;
        ToSalesLine."Purchase Order No." := '';
        ToSalesLine."Purch. Order Line No." := 0;
        if ToSalesHeader."Order Date" <> 0D then
            ToSalesLine.Validate("Shipment Date", ToSalesHeader."Order Date")
        else
            ToSalesLine.Validate("Shipment Date", WorkDate);
        //ItemCheckAvail.SalesLineCheck(ToSalesLine);
        //CF001 En
    end;

    local procedure CopySalesLine(var ToSalesHeader: Record "Sales Header"; var ToSalesLine: Record "Sales Line"; var FromSalesHeader: Record "Sales Header"; var FromSalesLine: Record "Sales Line"; var NextLineNo: Integer; var LinesNotCopied: Integer; ApplFromItemEntry: Integer)
    var
        ToSalesLine2: Record "Sales Line";
        CopyThisLine: Boolean;
    begin
        //SS
        OnBeforeInsertDispatchLine(ToSalesHeader, ToSalesLine, FromSalesHeader, FromSalesLine);
        //CF001 St
        CopyThisLine := true;
        if (ToSalesHeader."Language Code" <> FromSalesHeader."Language Code") and (FromSalesLine."Attached to Line No." <> 0) then exit;
        ToSalesLine.Init;
        NextLineNo := NextLineNo + 10000;
        ToSalesLine."Document Type" := ToSalesHeader."Document Type";
        ToSalesLine."Document No." := ToSalesHeader."No.";
        ToSalesLine."Document Subtype" := ToSalesHeader."Document Subtype";
        ToSalesLine."Line No." := NextLineNo;
        ToSalesLine.Validate("Currency Code", FromSalesHeader."Currency Code");
        ToSalesLine.Validate(Type, FromSalesLine.Type);
        IF ToSalesLine.Type <> ToSalesLine.Type::Item then begin
            ToSalesLine.Validate(Description, FromSalesLine.Description);
            ToSalesLine.Validate("Description 2", FromSalesLine."Description 2");
        end;
        ToSalesLine."MRP No." := FromSalesLine."MRP No."; //ALLE-NM 05072019
        ToSalesLine."Sales Line No." := FromSalesLine."Sales Line No."; //ALLE-NM 05072019
        if (FromSalesLine.Type <> 0) and (FromSalesLine."No." <> '') then begin
            ToSalesLine.Validate("No.", FromSalesLine."No.");
            ToSalesLine.Validate(Description, FromSalesLine.Description);
            ToSalesLine.Validate("Description 2", FromSalesLine."Description 2");
            ToSalesLine.Validate("Variant Code", FromSalesLine."Variant Code");
            ToSalesLine.Validate("Location Code", FromSalesLine."Location Code");
            ToSalesLine.Validate("Unit of Measure", FromSalesLine."Unit of Measure");
            ToSalesLine.Validate("Unit of Measure Code", FromSalesLine."Unit of Measure Code");
            ToSalesLine.Validate(Quantity, 0);
            ToSalesLine."Total Schedule Quantity" := FromSalesLine."Qty. to Ship";
            ToSalesLine.Validate("Total Schedule Quantity"); //5.51
            ToSalesLine.Validate("Work Type Code", FromSalesLine."Work Type Code");
            if (ToSalesLine."Document Type" = ToSalesLine."document type"::Order) and (FromSalesLine."Purchasing Code" <> '') then ToSalesLine.Validate("Purchasing Code", FromSalesLine."Purchasing Code");
        end;
        if (FromSalesLine.Type = FromSalesLine.Type::" ") and (FromSalesLine."No." <> '') then ToSalesLine.Validate("No.", FromSalesLine."No.");
        ToSalesLine.Validate("Description 2", FromSalesLine."Description 2");
        //ToSalesLine."Service Contract No." := FromSalesLine."Service Contract No.";
        //ToSalesLine."Service Order No." := FromSalesLine."Service Order No.";
        //ToSalesLine."Service Item No." := FromSalesLine."Service Item No.";
        //ToSalesLine."Appl.-to Service Entry" := FromSalesLine."Appl.-to Service Entry";
        //ToSalesLine."Service Item Line No." := FromSalesLine."Service Item Line No.";
        //ToSalesLine."Serv. Price Adjmt. Gr. Code" := FromSalesLine."Serv. Price Adjmt. Gr. Code";
        ToSalesLine."Order No." := ToSalesHeader."Order/Scd. No.";
        ToSalesLine."Order Line No." := FromSalesLine."Line No.";
        ToSalesLine."Blanket Order No." := FromSalesLine."Blanket Order No.";
        ToSalesLine."Blanket Order Line No." := FromSalesLine."Blanket Order Line No.";
        ToSalesLine."Quatation No." := FromSalesLine."Quatation No.";
        ToSalesLine."Quotation Line No." := FromSalesLine."Quotation Line No.";
        ToSalesLine."Quotation Date" := FromSalesLine."Quotation Date";
        ToSalesLine."MRP No." := FromSalesLine."MRP No."; //ALLE-NM 05072019
        ToSalesLine."Sales Line No." := FromSalesLine."Sales Line No."; //ALLE-NM 05072019
        //ALLE 3.15>>
        ToSalesLine."Customer Document No." := FromSalesLine."Customer Document No.";
        ToSalesLine."Customer Document Date" := FromSalesLine."Customer Document Date";
        ToSalesLine."CT2 Form" := FromSalesLine."CT2 Form";
        ToSalesLine."CT2 Form Line No." := FromSalesLine."CT2 Form Line No.";
        //ALLE 3.15 <<
        //ALLE 3.16
        ToSalesLine."CT3 Form" := FromSalesLine."CT3 Form";
        ToSalesLine."CT3 Form Line No." := FromSalesLine."CT3 Form Line No.";
        //ALLE 3.16
        /*
        IF ToSalesHeader."Order Date"<>0D THEN
          ToSalesLine.VALIDATE("Shipment Date",ToSalesHeader."Order Date")
        ELSE
          ToSalesLine.VALIDATE("Shipment Date",WORKDATE);
        */
        ToSalesLine."Planned Delivery Date" := FromSalesLine."Planned Delivery Date";
        ToSalesLine."Planned Shipment Date" := FromSalesLine."Planned Shipment Date";
        ToSalesLine.Validate("Shipment Date", FromSalesLine."Shipment Date");
        ToSalesLine."Bin Code" := FromSalesLine."Bin Code";
        //vipin to get correct tax group code in case of spares
        ToSalesLine."Tax Group Code" := FromSalesLine."Tax Group Code";
        //vipin to get correct tax group code in case of spares
        if (ToSalesHeader."Language Code" <> FromSalesHeader."Language Code") then begin
            if TransferExtendedText.SalesCheckIfAnyExtText(ToSalesLine, false) then begin
                TransferExtendedText.InsertSalesExtText(ToSalesLine);
                ToSalesLine2.SetRange("Document Type", ToSalesLine."Document Type");
                ToSalesLine2.SetRange("Document No.", ToSalesLine."Document No.");
                ToSalesLine2.Find('+');
                NextLineNo := ToSalesLine2."Line No.";
            end;
        end;
        if CopyThisLine then
            ToSalesLine.Insert
        else
            LinesNotCopied := LinesNotCopied + 1;
        //CF001 En
    end;

    local procedure CopyFromSalesDocDimToLine(var ToSalesLine: Record "Sales Line"; var FromSalesLine: Record "Sales Line")
    begin
        //CF001 St
        /* // BIS 1145
            DocDim.SETRANGE("Table ID",DATABASE::"Sales Line");
            DocDim.SETRANGE("Document Type",ToSalesLine."Document Type");
            DocDim.SETRANGE("Document No.",ToSalesLine."Document No.");
            DocDim.SETRANGE("Line No.",ToSalesLine."Line No.");
            DocDim.DELETEALL;
            ToSalesLine."Shortcut Dimension 1 Code" := FromSalesLine."Shortcut Dimension 1 Code";
            ToSalesLine."Shortcut Dimension 2 Code" := FromSalesLine."Shortcut Dimension 2 Code";
            FromDocDim.SETRANGE("Table ID",DATABASE::"Sales Line");
            FromDocDim.SETRANGE("Document Type",FromSalesLine."Document Type");
            FromDocDim.SETRANGE("Document No.",FromSalesLine."Document No.");
            FromDocDim.SETRANGE("Line No.",FromSalesLine."Line No.");
            IF FromDocDim.FINDSET THEN
              BEGIN
                REPEAT
                  DocDim.INIT;
                  DocDim."Table ID" := DATABASE::"Sales Line";
                  DocDim."Document Type" := ToSalesLine."Document Type";
                  DocDim."Document No." := ToSalesLine."Document No.";
                  DocDim."Line No." := ToSalesLine."Line No.";
                  DocDim."Dimension Code" := FromDocDim."Dimension Code";
                  DocDim."Dimension Value Code" := FromDocDim."Dimension Value Code";
                  DocDim.INSERT;
                UNTIL FromDocDim.NEXT = 0;
              END;
            */
        // BIS 1145
        //CF001 En
    end;

    procedure PacketQuantity()
    var
        SalesPacketBufferLocal: Record "SSD Sales Schedule Buffer";
        SalesPacketDetailsForm: Page "Sales Packet Details";
        TmpSalesPacketBufferLocal: Record "SSD Sales Schedule Buffer";
    begin
        //CF001 St
        if Rec.Type = Rec.Type::Item then begin
            CheckOrderStatus(Rec);
            //ALLE 3.08
            if Item.Get(Rec."No.") then begin
                Item.TestField("Gross Weight");
                Item.TestField("Net Weight");
            end;
            //ALLE 3.08
            SalesPacketBufferLocal.Reset;
            SalesPacketBufferLocal.SetRange("Document Type", Rec."Document Type");
            SalesPacketBufferLocal.SetRange("Document No.", Rec."Document No.");
            SalesPacketBufferLocal.SetRange("Sell-to Customer No.", Rec."Sell-to Customer No.");
            SalesPacketBufferLocal.SetRange("Item No.", Rec."No.");
            SalesPacketBufferLocal.SetRange("Order Line No.", Rec."Line No.");
            Clear(SalesPacketDetailsForm);
            SalesPacketDetailsForm.InitialValues2(Rec."Document Type", Rec."Document No.", Rec."Sell-to Customer No.", Rec."Line No.", Rec."No.", Rec."Total Schedule Quantity", Item."Gross Weight", Item."Net Weight", Rec."Unit of Measure Code", Rec."Variant Code"); //MSI
            SalesPacketDetailsForm.SetRecord(SalesPacketBufferLocal);
            SalesPacketDetailsForm.SetTableview(SalesPacketBufferLocal);
            if SalesPacketDetailsForm.RunModal = Action::OK then begin
                TmpSalesPacketBufferLocal.Reset;
                TmpSalesPacketBufferLocal.SetRange("Document Type", Rec."Document Type");
                TmpSalesPacketBufferLocal.SetRange("Document No.", Rec."Document No.");
                TmpSalesPacketBufferLocal.SetRange("Sell-to Customer No.", Rec."Sell-to Customer No.");
                TmpSalesPacketBufferLocal.SetRange("Item No.", Rec."No.");
                TmpSalesPacketBufferLocal.SetRange("Order Line No.", Rec."Line No.");
                TmpSalesPacketBufferLocal.CalcSums(TmpSalesPacketBufferLocal."Total Qty");
                Rec.Validate(Quantity, TmpSalesPacketBufferLocal."Total Qty");
                Rec.Validate("Qty. to Ship", TmpSalesPacketBufferLocal."Total Qty");
            end;
        end;
        //CF001 En
    end;

    procedure CheckOrderStatus(RecSalesLine: Record "Sales Line")
    var
        SalesHeaderLocal: Record "Sales Header";
    begin
        SalesHeaderLocal.Get(RecSalesLine."Document Type", RecSalesLine."Document No.");
        SalesHeaderLocal.TestField(Status, SalesHeaderLocal.Status::Open);
        if RecSalesLine."Quantity Shipped" > 0 then Error(Text002, RecSalesLine."Document No.", RecSalesLine."Line No.", RecSalesLine."No.");
    end;

    local procedure NoOnAfterValidate()
    begin
        InsertExtendedText(false);
        if (Rec.Type = Rec.Type::"Charge (Item)") and (Rec."No." <> xRec."No.") and (xRec."No." <> '') then CurrPage.SaveRecord;
    end;

    local procedure CrossReferenceNoOnAfterValidat()
    begin
        InsertExtendedText(false);
    end;

    local procedure ReserveOnAfterValidate()
    begin
        if (Rec.Reserve = Rec.Reserve::Always) and (Rec."Outstanding Qty. (Base)" <> 0) then begin
            CurrPage.SaveRecord;
            Rec.AutoReserve;
            CurrPage.Update(false);
        end;
    end;

    local procedure QuantityOnAfterValidate()
    var
        UpdateIsDone: Boolean;
    begin
        if Rec.Type = Rec.Type::Item then
            case Rec.Reserve of
                Rec.Reserve::Always:
                    begin
                        CurrPage.SaveRecord;
                        Rec.AutoReserve;
                        CurrPage.Update(false);
                        UpdateIsDone := true;
                    end;
                Rec.Reserve::Optional:
                    if (Rec.Quantity < xRec.Quantity) and (xRec.Quantity > 0) then begin
                        CurrPage.SaveRecord;
                        CurrPage.Update(false);
                        UpdateIsDone := true;
                    end;
            end;
        if (Rec.Type = Rec.Type::Item) and (Rec.Quantity <> xRec.Quantity) and not UpdateIsDone then CurrPage.Update(true);
    end;

    local procedure UnitofMeasureCodeOnAfterValida()
    begin
        if Rec.Reserve = Rec.Reserve::Always then begin
            CurrPage.SaveRecord;
            Rec.AutoReserve;
            CurrPage.Update(false);
        end;
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeInsertDispatchLine(ToSalesHeader: Record "Sales Header"; ToSalesLine: Record "Sales Line"; FromSalesHeader: Record "Sales Header"; FromSalesLine: Record "Sales Line")
    begin
    end;
}
