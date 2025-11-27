Page 50096 "Material Receipt Note Subform"
{
    // //CF001.01 14.06.2006 For Quality Order
    AutoSplitKey = true;
    Caption = 'Material Receipt Note Subform';
    DelayedInsert = true;
    DeleteAllowed = false;
    Editable = true;
    InsertAllowed = false;
    MultipleNewLines = true;
    PageType = ListPart;
    SourceTable = "Warehouse Receipt Line";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                field("Source Document"; Rec."Source Document")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Source No."; Rec."Source No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("NO.2"; Rec."NO.2")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Item No."; Rec."Item No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                    ApplicationArea = All;
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                    ApplicationArea = All;
                }
                field("Description 2"; Rec."Description 2")
                {
                    ApplicationArea = All;
                }
                field("Vendor Item Description"; Rec."Vendor Item Description")
                {
                    ToolTip = 'Specifies the value of the Vendor Item Description field.';
                    Editable = false;
                }
                field("Supplier Batch No."; Rec."Supplier Batch No.")
                {
                    ApplicationArea = All;
                }
                field(Grade; Rec.Grade)
                {
                    ApplicationArea = All;
                    Editable = false;
                    Visible = false;
                }
                field("Location Code"; Rec."Location Code")
                {
                    ApplicationArea = All;
                    Editable = true;
                }
                field("Bin Code"; Rec."Bin Code")
                {
                    ApplicationArea = All;
                    Editable = true;

                    trigger OnValidate()
                    begin
                        BinCodeOnAfterValidate;
                    end;
                }
                field("Qty. On Purch. Order"; Rec."Qty. On Purch. Order")
                {
                    ApplicationArea = All;
                    Caption = 'Qty. On Purch. Order';
                    Editable = false;
                }
                field("Unit of Measure Code"; Rec."Unit of Measure Code")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Purchase Price"; Rec."Purchase Price")
                {
                    ApplicationArea = All;
                }
                field("Qty. On Invoice"; Rec."Qty. On Invoice")
                {
                    ApplicationArea = All;
                    Editable = true;
                }
                field("Actual Qty. to Receive"; Rec."Actual Qty. to Receive")
                {
                    ApplicationArea = All;
                }
                field("Shortage Qty."; Rec."Shortage Qty.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Quality Required"; Rec."Quality Required")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Send For Quality"; Rec."Send For Quality")
                {
                    ApplicationArea = All;
                }
                field("Quality Done"; Rec."Quality Done")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Accepted Qty."; Rec."Accepted Qty.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Rejected Qty."; Rec."Rejected Qty.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Reject Bin Code"; Rec."Reject Bin Code")
                {
                    ApplicationArea = All;
                }
                field("Reject Location Code"; Rec."Reject Location Code")
                {
                    ApplicationArea = All;
                }
                field("Delivery Challan"; Rec."Delivery Challan")
                {
                    ApplicationArea = All;

                    trigger OnLookup(var Text: Text): Boolean var
                        DeliveryChallanHeader: Record "Delivery Challan Header";
                    begin
                        DeliveryChallanHeader.Reset;
                        DeliveryChallanHeader.SetRange(DeliveryChallanHeader."Vendor No.", Rec."Party No.");
                        if Page.RunModal(0, DeliveryChallanHeader) = Action::LookupOK then begin
                            Rec."Delivery Challan":=DeliveryChallanHeader."No.";
                        end
                        else
                        begin
                            exit(false);
                        end;
                    end;
                }
                field("Delivery Challan Sent Item"; Rec."Delivery Challan Sent Item")
                {
                    ApplicationArea = All;

                    trigger OnLookup(var Text: Text): Boolean var
                        DeliveryChallanLine: Record "Delivery Challan Line";
                    begin
                        DeliveryChallanLine.Reset;
                        DeliveryChallanLine.SetRange("Delivery Challan No.", Rec."Delivery Challan");
                        if Page.RunModal(0, DeliveryChallanLine) = Action::LookupOK then begin
                            Rec."Delivery Challan Sent Item":=DeliveryChallanLine."Item No.";
                        end
                        else
                        begin
                            exit(false);
                        end;
                    end;
                }
                field(Quantity; Rec.Quantity)
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        //CORP::PK 220719 >>>
                        if Rec.Quantity = 0 then begin
                            ItemPhyBinDetails.Reset;
                            ItemPhyBinDetails.SetRange("Document No.", Rec."No.");
                            ItemPhyBinDetails.SetRange("Document Line No.", Rec."Line No.");
                            ItemPhyBinDetails.SetRange("Whse. Entry  No.", 0);
                            if ItemPhyBinDetails.FindSet then ItemPhyBinDetails.DeleteAll;
                        end;
                    //CORP::PK 220719 <<<
                    end;
                }
                field("Qty. to Receive"; Rec."Qty. to Receive")
                {
                    ApplicationArea = All;
                }
                field("Scrap Item"; Rec."Scrap Item")
                {
                    ApplicationArea = All;
                }
                field("Scrap Qty."; Rec."Scrap Qty.")
                {
                    ApplicationArea = All;
                }
                field("Scrap Location"; Rec."Scrap Location")
                {
                    ApplicationArea = All;
                }
                field("Scrap Bin"; Rec."Scrap Bin")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
    actions
    {
        area(processing)
        {
            group("F&unctions")
            {
                Caption = 'F&unctions';

                action("Autofill Qty. to Receive")
                {
                    ApplicationArea = All;
                    Caption = 'Autofill Qty. to Receive';
                    Image = AutofillQtyToHandle;
                    Visible = false;

                    trigger OnAction()
                    begin
                        //This functionality was copied from page #50095. Unsupported part was commented. Please check it.
                        /*CurrPage.WhseReceiptLines.PAGE.*/
                        _AutofillQtyToReceive;
                    end;
                }
                action("Delete Qty. to Receive")
                {
                    ApplicationArea = All;
                    Caption = 'Delete Qty. to Receive';
                    Image = DeleteQtyToHandle;
                    Visible = false;

                    trigger OnAction()
                    begin
                        //This functionality was copied from page #50095. Unsupported part was commented. Please check it.
                        /*CurrPage.WhseReceiptLines.PAGE.*/
                        _DeleteQtyToReceive;
                    end;
                }
            }
            group("&Line")
            {
                Caption = '&Line';

                action("Source &Document Line")
                {
                    ApplicationArea = All;
                    Caption = 'Source &Document Line';
                    Image = SourceDocLine;

                    trigger OnAction()
                    begin
                        //This functionality was copied from page #50095. Unsupported part was commented. Please check it.
                        /*CurrPage.WhseReceiptLines.PAGE.*/
                        ShowSourceLine;
                    end;
                }
                action("&Bin Contents List")
                {
                    ApplicationArea = All;
                    Caption = '&Bin Contents List';

                    trigger OnAction()
                    begin
                        //This functionality was copied from page #50095. Unsupported part was commented. Please check it.
                        /*CurrPage.WhseReceiptLines.PAGE.*/
                        ShowBinContents;
                    end;
                }
                group("Item Availability by")
                {
                    Caption = 'Item Availability by';

                    action(Period)
                    {
                        ApplicationArea = All;
                        Caption = 'Period';

                        trigger OnAction()
                        begin
                            //This functionality was copied from page #50095. Unsupported part was commented. Please check it.
                            /*CurrPage.WhseReceiptLines.PAGE.*/
                            ItemAvailability(0);
                        end;
                    }
                    action(Variant)
                    {
                        ApplicationArea = All;
                        Caption = 'Variant';

                        trigger OnAction()
                        begin
                            //This functionality was copied from page #50095. Unsupported part was commented. Please check it.
                            /*CurrPage.WhseReceiptLines.PAGE.*/
                            ItemAvailability(1);
                        end;
                    }
                    action(Location)
                    {
                        ApplicationArea = All;
                        Caption = 'Location';

                        trigger OnAction()
                        begin
                            //This functionality was copied from page #50095. Unsupported part was commented. Please check it.
                            /*CurrPage.WhseReceiptLines.PAGE.*/
                            ItemAvailability(2);
                        end;
                    }
                }
                action("Item &Tracking Lines")
                {
                    ApplicationArea = All;
                    Caption = 'Item &Tracking Lines';
                    Image = ItemTrackingLines;
                    ShortCutKey = 'Shift+Ctrl+I';

                    trigger OnAction()
                    begin
                        //This functionality was copied from page #50095. Unsupported part was commented. Please check it.
                        /*CurrPage.WhseReceiptLines.PAGE.*/
                        Rec.OpenItemTrackingLines;
                    end;
                }
                action("Quality Order")
                {
                    ApplicationArea = All;
                    Caption = 'Quality Order';

                    trigger OnAction()
                    begin
                        //This functionality was copied from page #50095. Unsupported part was commented. Please check it.
                        /*CurrPage.WhseReceiptLines.PAGE.*/
                        ShowQualityOrder;
                    end;
                }
                action("Posted Quality Order")
                {
                    ApplicationArea = All;
                    Caption = 'Posted Quality Order';

                    trigger OnAction()
                    begin
                        //This functionality was copied from page #50095. Unsupported part was commented. Please check it.
                        /*CurrPage.WhseReceiptLines.PAGE.*/
                        ShowPostedQualityOrder;
                    end;
                }
                action("Application Entries")
                {
                    ApplicationArea = All;
                    Caption = 'Application Entries';

                    trigger OnAction()
                    begin
                        //This functionality was copied from page #50095. Unsupported part was commented. Please check it.
                        /*CurrPage.WhseReceiptLines.PAGE.*/
                        SelectItemEntry;
                    end;
                }
                action("Applied Entries")
                {
                    ApplicationArea = All;
                    Caption = 'Applied Entries';

                    trigger OnAction()
                    begin
                        //This functionality was copied from page #50095. Unsupported part was commented. Please check it.
                        /*CurrPage.WhseReceiptLines.PAGE.*/
                        ShowItemEntry;
                    end;
                }
                action("Show Form")
                {
                    ApplicationArea = All;
                    Caption = 'Show Form';

                    trigger OnAction()
                    begin
                        //This functionality was copied from page #50095. Unsupported part was commented. Please check it.
                        /*CurrPage.WhseReceiptLines.PAGE.*/
                        ShowSubOrderDetailsForm end;
                }
                action("Consumption Item")
                {
                    ApplicationArea = All;
                    Caption = 'Consumption Item';

                    trigger OnAction()
                    begin
                        //This functionality was copied from page #50095. Unsupported part was commented. Please check it.
                        /*CurrPage.WhseReceiptLines.PAGE.*/
                        ShowConsumption;
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
                        //CORP::PK 280819 >>>
                        /*
                        ReservationEntry.RESET;
                        ReservationEntry.SETRANGE("Source ID","Source No.");
                        ReservationEntry.SETRANGE("Item No.","Item No.");
                        ReservationEntry.SETRANGE("Location Code","Location Code");
                        ReservationEntry.SETRANGE(Quantity,Rec.Quantity);//CS:Navdeep
                        ReservationEntry.SETRANGE(Positive,TRUE);//CS:Navdeep
                        ReservationEntry.SETRANGE("Source Ref. No.",Rec."Gate Line No.");//CS:Navdeep
                        IF ReservationEntry.FINDSET THEN
                          REPEAT
                            ReservationEntry."MRN No." := "No.";
                            ReservationEntry."MRN Line No." := "Line No.";
                            ReservationEntry.MODIFY;
                          UNTIL ReservationEntry.NEXT = 0;
                        */
                        //CORP::PK 050919
                        if Rec."Source Document" <> Rec."source document"::"Inbound Transfer" then begin
                            if Location.Get(Rec."Location Code")then;
                            if Item.Get(Rec."Item No.")then;
                            if(Location."Phy. Bin Required") and (Item."Phy. Bin Required")then begin
                                LotNo:='';
                                ReservationEntry.Reset;
                                ReservationEntry.SetRange("MRN No.", Rec."No.");
                                ReservationEntry.SetRange("MRN Line No.", Rec."Line No.");
                                ReservationEntry.SetRange("Item No.", Rec."Item No.");
                                ReservationEntry.SetRange("Item Ledger Entry No.", 0);
                                if ReservationEntry.FindFirst then LotNo:=ReservationEntry."Lot No.";
                                ItemPhyBinDetails.Reset;
                                ItemPhyBinDetails.SetRange("Document No.", Rec."No.");
                                ItemPhyBinDetails.SetRange("Document Line No.", Rec."Line No.");
                                ItemPhyBinDetails.SetRange("Posted Document No.", '');
                                if not ItemPhyBinDetails.FindFirst then begin
                                    ReservationEntry.Reset;
                                    ReservationEntry.SetRange("MRN No.", Rec."No.");
                                    ReservationEntry.SetRange("MRN Line No.", Rec."Line No.");
                                    ReservationEntry.SetRange("Item No.", Rec."Item No.");
                                    ReservationEntry.SetRange("Item Ledger Entry No.", 0);
                                    //ReservationEntry.SETRANGE("Source Ref. No.",Rec."Gate Line No.");//CS:Navdeep //CORP::PK blocked on 050919
                                    if ReservationEntry.FindSet then repeat ItemPhyBinDetails.Reset;
                                            ItemPhyBinDetails.SetRange("Document No.", Rec."No.");
                                            if ItemPhyBinDetails.FindLast then LineNo:=ItemPhyBinDetails."Line No." + 10000
                                            else
                                                LineNo:=10000;
                                            ItemPhyBinDetails.Init;
                                            ItemPhyBinDetails.Validate("Line No.", LineNo);
                                            ItemPhyBinDetails.Validate("Document No.", Rec."No.");
                                            ItemPhyBinDetails.Validate("Document Line No.", Rec."Line No.");
                                            ItemPhyBinDetails.Validate("Item No.", Rec."Item No.");
                                            ItemPhyBinDetails.Validate("Qty. Per Unit Of Measure", Rec."Qty. per Unit of Measure");
                                            ItemPhyBinDetails.Validate("Unit Of Measure", Rec."Unit of Measure Code");
                                            ItemPhyBinDetails.Validate("Location Code", Rec."Location Code");
                                            ItemPhyBinDetails.Validate("Bin Code", Rec."Bin Code");
                                            ItemPhyBinDetails.Validate("Lot No.", ReservationEntry."Lot No.");
                                            ItemPhyBinDetails.Validate("Posting Date", Today);
                                            ItemPhyBinDetails.Validate("Document Type", ItemPhyBinDetails."document type"::"Whse. Receipt");
                                            ItemPhyBinDetails.Insert;
                                        until ReservationEntry.Next = 0;
                                end;
                                Commit;
                                ItemPhyBinDetails.Reset;
                                ItemPhyBinDetails.SetRange("Document No.", Rec."No.");
                                ItemPhyBinDetails.SetRange("Document Line No.", Rec."Line No.");
                                ItemPhyBinDetails.SetRange("Posted Document No.", '');
                                Page.RunModal(50238, ItemPhyBinDetails);
                            end;
                        end;
                    //CORP::PK
                    end;
                }
            }
        }
    }
    trigger OnDeleteRecord(): Boolean begin
        //CORP::PK 220719 >>>
        ItemPhyBinDetails.Reset;
        ItemPhyBinDetails.SetRange("Document No.", Rec."No.");
        ItemPhyBinDetails.SetRange("Document Line No.", Rec."Line No.");
        ItemPhyBinDetails.SetRange("Whse. Entry  No.", 0);
        if ItemPhyBinDetails.FindSet then ItemPhyBinDetails.DeleteAll;
    //CORP::PK 220719 <<<
    end;
    var CrossDockOpp2: Record "Whse. Cross-Dock Opportunity";
    Text001: label 'Cross-Docking has been disabled for %1 %3 and/or %2 %4.';
    ItemPhyBinDetails: Record "SSD Item Phy. Bin Details";
    Location: Record Location;
    Text0001: label 'Do you want to delete Phy. Bin Details too?';
    procedure ShowSourceLine()
    var
        WMSMgt: Codeunit "WMS Management";
    begin
        WMSMgt.ShowSourceDocLine(Rec."Source Type", Rec."Source Subtype", Rec."Source No.", Rec."Source Line No.", 0);
    end;
    procedure ShowBinContents()
    var
        BinContent: Record "Bin Content";
    begin
        BinContent.ShowBinContents(Rec."Location Code", Rec."Item No.", Rec."Variant Code", Rec."Bin Code");
    end;
    procedure _ItemAvailability(AvailabilityType: Option Date, Variant, Location)
    begin
    //Rec.ItemAvailability(AvailabilityType); // BIS 1145
    end;
    procedure ItemAvailability(AvailabilityType: Option Date, Variant, Location)
    begin
    // Rec.ItemAvailability(AvailabilityType); // BIS 1145
    end;
    procedure WhsePostRcptYesNo()
    var
        WhseRcptLine: Record "Warehouse Receipt Line";
        WhsePostReceiptYesNo: Codeunit "Whse.-Post Receipt (Yes/No)";
    begin
        WhseRcptLine.Copy(Rec);
        WhsePostReceiptYesNo.Run(WhseRcptLine);
        Rec.Reset;
        Rec.SetCurrentkey("No.", "Sorting Sequence No.");
        CurrPage.Update(false);
    end;
    procedure WhsePostRcptPrint()
    var
        WhseRcptLine: Record "Warehouse Receipt Line";
        WhsePostReceiptPrint: Codeunit "Whse.-Post Receipt + Print";
    begin
        WhseRcptLine.Copy(Rec);
        WhsePostReceiptPrint.Run(WhseRcptLine);
        Rec.Reset;
        Rec.SetCurrentkey("No.", "Sorting Sequence No.");
        CurrPage.Update(false);
    end;
    procedure _AutofillQtyToReceive()
    var
        WhseRcptLine: Record "Warehouse Receipt Line";
    begin
        WhseRcptLine.Copy(Rec);
        Rec.AutofillQtyToReceive(WhseRcptLine);
    end;
    procedure AutofillQtyToReceive()
    var
        WhseRcptLine: Record "Warehouse Receipt Line";
    begin
        WhseRcptLine.Copy(Rec);
        Rec.AutofillQtyToReceive(WhseRcptLine);
    end;
    procedure _DeleteQtyToReceive()
    var
        WhseRcptLine: Record "Warehouse Receipt Line";
    begin
        WhseRcptLine.Copy(Rec);
        Rec.DeleteQtyToReceive(WhseRcptLine);
    end;
    procedure DeleteQtyToReceive()
    var
        WhseRcptLine: Record "Warehouse Receipt Line";
    begin
        WhseRcptLine.Copy(Rec);
        Rec.DeleteQtyToReceive(WhseRcptLine);
    end;
    procedure _OpenItemTrackingLines()
    begin
        Rec.OpenItemTrackingLines;
    end;
    procedure OpenItemTrackingLines()
    begin
        Rec.OpenItemTrackingLines;
    end;
    procedure ShowCrossDockOpp(var CrossDockOpp: Record "Whse. Cross-Dock Opportunity" temporary)
    var
        Item: Record Item;
        Location: Record Location;
        CrossDockMgt: Codeunit "Whse. Cross-Dock Management";
        UseCrossDock: Boolean;
    begin
        CrossDockMgt.GetUseCrossDock(UseCrossDock, Rec."Location Code", Rec."Item No.");
        if not UseCrossDock then Error(Text001, Item.TableCaption, Location.TableCaption, Rec."Item No.", Rec."Location Code");
        CrossDockMgt.ShowCrossDock(CrossDockOpp, '', Rec."No.", Rec."Line No.", Rec."Location Code", Rec."Item No.", Rec."Variant Code");
    end;
    procedure ShowQualityOrder()
    var
        QualityOrdHdrLocal: Record "SSD Quality Order Header";
        FrmQltOrderList: Page "Quality Order List";
    begin
        //CF001.01 St
        Rec.TestField("Quality Required", true);
        QualityOrdHdrLocal.Reset;
        QualityOrdHdrLocal.FilterGroup(2);
        QualityOrdHdrLocal.SetRange("Template Type", QualityOrdHdrLocal."template type"::Receipt);
        QualityOrdHdrLocal.SetRange("Entry Source Type", QualityOrdHdrLocal."entry source type"::MRN);
        QualityOrdHdrLocal.SetRange("Source Document No.", Rec."No.");
        QualityOrdHdrLocal.SetRange("Source Doc. Line No.", Rec."Line No.");
        QualityOrdHdrLocal.FilterGroup(2);
        if QualityOrdHdrLocal.Find('-')then begin
            Clear(FrmQltOrderList);
            FrmQltOrderList.SetTableview(QualityOrdHdrLocal);
            FrmQltOrderList.RunModal;
        end;
    //CF001.01 En
    end;
    procedure ShowPostedQualityOrder()
    var
        QualityOrdHdrLocal: Record "SSD Posted Quality Order Hdr";
        FrmQltOrderList: Page "Posted Quality Order List";
    begin
        //CF001.01 St
        Rec.TestField("Quality Required", true);
        Rec.TestField("Quality Done", true);
        if Rec."Posted Quality Order No." <> '' then begin
            QualityOrdHdrLocal.Reset;
            QualityOrdHdrLocal.FilterGroup(2);
            // SR_PQA003.begin
            //QualityOrdHdrLocal.SETRANGE("No.","Posted Quality Order No.");
            QualityOrdHdrLocal.SetRange("Source Document No.", Rec."No.");
            QualityOrdHdrLocal.SetRange("Source Doc. Line No.", Rec."Line No.");
            // SR_PQA003.end
            QualityOrdHdrLocal.FilterGroup(2);
            Clear(FrmQltOrderList);
            FrmQltOrderList.SetTableview(QualityOrdHdrLocal);
            FrmQltOrderList.RunModal;
        end;
    //CF001.01 En
    end;
    procedure CheckScrap(var WarehouseHouseHeader: Record "Warehouse Receipt Header")Scrap: Boolean begin
        //>>CEN_AA001
        Rec.SetRange("No.", WarehouseHouseHeader."No.");
        if Rec.Find('-')then repeat if Rec."Scrap Item" <> '' then begin
                    Scrap:=true;
                    exit;
                end
                else
                begin
                    Scrap:=false;
                end;
            until Rec.Next = 0;
    //<<CEN_AA001
    end;
    procedure "--MeS--"()
    begin
    end;
    procedure SelectItemEntry()
    var
        ItemLedgEntry: Record "Item Ledger Entry";
        ItemLedgerEntries: Page "Item Ledg. Entries";
        ItemLedgEntryBuff: Record "SSD Item Ledger Entry Buffer";
        PurchaseLine: Record "Purchase Line";
        SubOrderCompListVend: Record "Sub Order Comp. List Vend";
    begin
        SubOrderCompListVend.Reset;
        SubOrderCompListVend.SetRange("Document No.", Rec."Source No.");
        SubOrderCompListVend.SetRange("Document Line No.", Rec."Source Line No.");
        SubOrderCompListVend.SetRange("Parent Item No.", Rec."Item No.");
        if SubOrderCompListVend.FindFirst then begin
            ItemLedgEntryBuff.Reset;
            ItemLedgEntryBuff.SetCurrentkey("Item No.", "Location Code");
            ItemLedgEntryBuff.SetRange("Item No.", SubOrderCompListVend."Item No.");
            ItemLedgEntryBuff.SetRange("Location Code", SubOrderCompListVend."Vendor Location");
            //    ItemLedgEntryBuff.SETRANGE("Bin Code",SubOrderCompListVend."Vendor Bin Code");
            if ItemLedgEntryBuff.Find('-')then ItemLedgEntryBuff.DeleteAll;
            ItemLedgEntry.Reset;
            ItemLedgEntry.SetCurrentkey("Item No.", "Location Code", Open);
            ItemLedgEntry.SetRange("Item No.", SubOrderCompListVend."Item No.");
            ItemLedgEntry.SetRange("Location Code", SubOrderCompListVend."Vendor Location");
            //ItemLedgEntry.SETRANGE("Bin Code",SubOrderCompListVend."Vendor Bin Code");
            ItemLedgEntry.SetRange(Open, true);
            ItemLedgEntry.SetRange(Positive, true);
            ItemLedgEntry.SetRange("Entry Type", ItemLedgEntry."entry type"::Transfer);
            ItemLedgEntry.SetRange(Correction, false);
            if ItemLedgEntry.Find('-')then repeat ItemLedgEntryBuff.Init;
                    ItemLedgEntryBuff.TransferFields(ItemLedgEntry);
                    ItemLedgEntryBuff."Subcon Order No.":=SubOrderCompListVend."Document No.";
                    ItemLedgEntryBuff."Subcon Order Line No.":=SubOrderCompListVend."Document Line No.";
                    ItemLedgEntryBuff."Line No.":=SubOrderCompListVend."Line No.";
                    ItemLedgEntryBuff."Qty. per Unit of Measure":=SubOrderCompListVend."Qty. per Unit of Measure";
                    ItemLedgEntryBuff.Insert;
                until ItemLedgEntry.Next = 0;
            Commit;
            ItemLedgerEntries.LookupMode(true);
            ItemLedgerEntries.SetTableview(ItemLedgEntryBuff);
            if ItemLedgerEntries.RunModal = Action::LookupOK then;
        end;
    end;
    procedure ShowItemEntry()
    var
        ItemLedgEntry: Record "Item Ledger Entry";
        ItemLedgerEntries: Page "Item Ledg. Entries";
        ItemLedgEntryBuff: Record "SSD Item Ledger Entry Buffer";
        PurchaseLine: Record "Purchase Line";
        ProdOrderComponent: Record "Prod. Order Component";
        SubOrderCompListVend: Record "Sub Order Comp. List Vend";
    begin
        SubOrderCompListVend.Reset;
        SubOrderCompListVend.SetRange("Document No.", Rec."Source No.");
        SubOrderCompListVend.SetRange("Document Line No.", Rec."Source Line No.");
        SubOrderCompListVend.SetRange("Parent Item No.", Rec."Item No.");
        if SubOrderCompListVend.FindFirst then begin
            ItemLedgEntryBuff.Reset;
            ItemLedgEntryBuff.SetCurrentkey("Subcon Order No.", "Subcon Order Line No.", "Line No.");
            ItemLedgEntryBuff.SetRange("Subcon Order No.", SubOrderCompListVend."Document No.");
            ItemLedgEntryBuff.SetRange("Subcon Order Line No.", SubOrderCompListVend."Document Line No.");
            ItemLedgEntryBuff.SetRange("Line No.", SubOrderCompListVend."Line No.");
            ItemLedgEntryBuff.SetRange(Apply, true);
            ItemLedgerEntries.LookupMode(true);
            ItemLedgerEntries.SetTableview(ItemLedgEntryBuff);
            if ItemLedgerEntries.RunModal = Action::LookupOK then;
        end;
    end;
    procedure ShowSubOrderDetailsForm()
    var
        PurchaseLine: Record "Purchase Line";
        SubOrderDetails: Page "Order Subcon. Details Delivery";
    begin
        PurchaseLine.Reset;
        PurchaseLine.SetRange("Document Type", PurchaseLine."document type"::Order);
        PurchaseLine.SetRange("No.", Rec."Item No.");
        PurchaseLine.SetRange("Document No.", Rec."Source No.");
        PurchaseLine.SetRange("Line No.", Rec."Source Line No.");
        SubOrderDetails.SetTableview(PurchaseLine);
        SubOrderDetails.RunModal;
    end;
    procedure ShowConsumption()
    var
        PurchaseLine: Record "Purchase Line";
        ProductionOrder: Record "Production Order";
        ProdOrderLine: Record "Prod. Order Line";
        ProdOrderComp: Record "Prod. Order Component";
        BOMHeader: Record "Production BOM Header";
        BOMLine: Record "Production BOM Line";
        VersionMgt: Codeunit VersionManagement;
        ActiveVersionCode: Code[20];
        SubOrderCompListVend: Record "Sub Order Comp. List Vend";
    begin
    /*SubOrderCompListVend.RESET;
        SubOrderCompListVend.SETRANGE("Document No.","Source No.");
        SubOrderCompListVend.SETRANGE("Document Line No.","Source Line No.");
        SubOrderCompListVend.SETRANGE("Parent Item No.","Item No.");
        IF SubOrderCompListVend.FINDFIRST THEN
        BEGIN
          BOMHeader.RESET;
          BOMHeader.SETRANGE(BOMHeader."No.","Item No.");
          BOMHeader.SETRANGE(BOMHeader.Status,BOMHeader.Status::Certified);
          IF BOMHeader.FINDFIRST THEN BEGIN
            ActiveVersionCode := VersionMgt.GetBOMVersion(BOMHeader."No.",WORKDATE,TRUE);
            BOMLine.RESET;
            BOMLine.SETRANGE(BOMLine."Production BOM No.",BOMHeader."No.");
            BOMLine.SETFILTER(BOMLine."Version Code",'%1',ActiveVersionCode);
            IF BOMLine.FINDFIRST THEN
            REPEAT
              IF ConsumptionItem.GET(BOMLine."Production BOM No.",BOMLine."Version Code",BOMLine."Line No.") THEN
              BEGIN
                ConsumptionItem.INIT;
                ConsumptionItem.TRANSFERFIELDS(BOMLine);
                ConsumptionItem."Required Quantity" := "Actual Qty. to Receive" * ConsumptionItem."Quantity per";
                ConsumptionItem."Item No." := "Item No.";
                ConsumptionItem."Location Code" := SubOrderCompListVend."Vendor Location";
                ConsumptionItem."Bin Code" := SubOrderCompListVend."Vendor Bin Code";
                ConsumptionItem."Source No." := "Source No.";
                ConsumptionItem."Source Line No." := "Source Line No.";
                ConsumptionItem."MRN No." := "No.";
                ConsumptionItem."MRN Line No." := "Line No.";
                ConsumptionItem.MODIFY;
              END ELSE BEGIN
                ConsumptionItem.INIT;
                ConsumptionItem.TRANSFERFIELDS(BOMLine);
                ConsumptionItem."Required Quantity" := "Actual Qty. to Receive" * ConsumptionItem."Quantity per";
                ConsumptionItem."Item No." := "Item No.";
                ConsumptionItem."Location Code" := SubOrderCompListVend."Vendor Location";
                ConsumptionItem."Bin Code" := SubOrderCompListVend."Vendor Bin Code";
                ConsumptionItem."Source No." := "Source No.";
                ConsumptionItem."Source Line No." := "Source Line No.";
                ConsumptionItem."MRN No." := "No.";
                ConsumptionItem."MRN Line No." := "Line No.";
                ConsumptionItem.INSERT;
              END;
            UNTIL BOMLine.NEXT = 0;
            ConsumptionItem.RESET;
            ConsumptionItem.SETRANGE(ConsumptionItem."MRN No.","No.");
            ConsumptionItem.SETRANGE(ConsumptionItem."MRN Line No.","Line No.");
            PAGE.RUN(PAGE::Page50228,ConsumptionItem);
          END;
        END;
         */
    end;
    local procedure BinCodeOnAfterValidate()
    begin
        CurrPage.Update;
    end;
}
