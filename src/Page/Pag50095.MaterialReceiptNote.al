Page 50095 "Material Receipt Note"
{
    // CF001.01 05.01.2006 added for responsibility center
    // CF001.02 30.05.2006 For Subcontracting
    // ALLEAA CML-033 050508
    //   - Post Rejection in case of Subcontracting Manual MRN.
    // ALLEAA CML-033 080508
    //   - Check Bin Content Exist or not
    // ALLE-HG-field added
    Caption = 'Material Receipt Note';
    PageType = Document;
    Permissions = TableData "SSD Quality Setup"=ri;
    PopulateAllFields = true;
    RefreshOnActivate = true;
    SourceTable = "Warehouse Receipt Header";
    //DeleteAllowed = false;
    InsertAllowed = false;
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                Editable = true;

                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    Editable = false;

                    trigger OnAssistEdit()
                    begin
                        if Rec.AssistEdit(xRec)then CurrPage.Update;
                    end;
                }
                field("Location Code"; Rec."Location Code")
                {
                    ApplicationArea = All;

                    trigger OnLookup(var Text: Text): Boolean begin
                        //CurrForm.SAVERECORD;
                        Rec.LookupLocation(Rec);
                    //CurrForm.UPDATE(TRUE);
                    end;
                }
                field("Bin Code"; Rec."Bin Code")
                {
                    ApplicationArea = All;
                }
                field("Gate Entry no."; Rec."Gate Entry no.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Party name"; Rec."Party name")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Bill No."; Rec."Bill No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Bill Amount"; Rec."Bill Amount")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Subcontracting; Rec.Subcontracting)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = All;
                }
                field("Vendor Shipment No."; Rec."Vendor Shipment No.")
                {
                    ApplicationArea = All;
                }
                field("Document Status"; Rec."Document Status")
                {
                    ApplicationArea = All;
                }
                field("Gate Entry Date"; Rec."Gate Entry Date")
                {
                    ApplicationArea = All;
                }
                field(Blocked; Rec.Blocked)
                {
                    ApplicationArea = All;
                }
                field("Quality Required"; Rec."Quality Required")
                {
                    ApplicationArea = All;
                }
                field("Sorting Method"; Rec."Sorting Method")
                {
                    ApplicationArea = All;
                    Visible = false;

                    trigger OnValidate()
                    begin
                        SortingMethodOnAfterValidate;
                    end;
                }
                field("Send For Quality"; Rec."Send For Quality")
                {
                    ApplicationArea = All;
                }
                field("Quality Done"; Rec."Quality Done")
                {
                    ApplicationArea = All;
                }
                field("Actual Posted Date"; Rec."Actual Posted Date")
                {
                    ApplicationArea = All;
                }
                field("Create DateTime"; Rec."Create DateTime")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Quality Post date Time"; Rec."Quality Post date Time")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
            }
            part(WhseReceiptLines; "Material Receipt Note Subform")
            {
                SubPageLink = "No."=field("No.");
                SubPageView = sorting("No.", "Sorting Sequence No.");
                ApplicationArea = All;
            }
            group(Others)
            {
                Caption = 'Others';
                Editable = true;

                field("QC Report Received"; Rec."QC Report Received")
                {
                    ApplicationArea = All;
                }
                field("Transporter Copy Received"; Rec."Transporter Copy Received")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
    actions
    {
        area(navigation)
        {
            group("&Receipt")
            {
                Caption = '&Receipt';

                action("Co&mments")
                {
                    ApplicationArea = All;
                    Caption = 'Co&mments';
                    Image = ViewComments;
                    RunObject = Page "Warehouse Comment Sheet";
                    RunPageLink = "Table Name"=const("Whse. Receipt"), Type=const(" "), "No."=field("No.");
                }
                separator(Action1000000004)
                {
                }
                action("Posted &Whse. Receipts")
                {
                    ApplicationArea = All;
                    Caption = 'Posted &Whse. Receipts';
                    Image = PostedReceipts;
                    RunObject = Page "Posted Whse. Receipt List";
                    RunPageLink = "Whse. Receipt No."=field("No.");
                    RunPageView = sorting("Whse. Receipt No.");
                }
                action("Posted Gate Entry")
                {
                    ApplicationArea = All;
                    Caption = 'Posted Gate Entry';

                    trigger OnAction()
                    var
                        FrmPostedGateInList: Page "Posted Gate In List";
                        PostedGateHeaderLocal: Record "SSD Posted Gate Header";
                        WHReceiptLineLocal: Record "Warehouse Receipt Line";
                    begin
                        //CF001 St
                        Clear(FrmPostedGateInList);
                        PostedGateHeaderLocal.Reset;
                        WHReceiptLineLocal.Reset;
                        WHReceiptLineLocal.SetRange("No.", Rec."No.");
                        WHReceiptLineLocal.SetRange("Location Code", Rec."Location Code");
                        if WHReceiptLineLocal.Find('-')then repeat PostedGateHeaderLocal.Get(WHReceiptLineLocal."Gate Entry no.");
                                PostedGateHeaderLocal.Mark(true);
                            until WHReceiptLineLocal.Next = 0;
                        PostedGateHeaderLocal.MarkedOnly(true);
                        FrmPostedGateInList.SetTableview(PostedGateHeaderLocal);
                        FrmPostedGateInList.RunModal;
                    //CF001 St
                    end;
                }
            }
        }
        area(processing)
        {
            group("F&unctions")
            {
                Caption = 'F&unctions';

                action("Use Filters to Get Src. Docs.")
                {
                    ApplicationArea = All;
                    Caption = 'Use Filters to Get Src. Docs.';
                    Ellipsis = true;
                    Image = UseFilters;
                    Visible = false;

                    trigger OnAction()
                    var
                        GetSourceDocInbound: Codeunit "Get Source Doc. Inbound";
                    begin
                        GetSourceDocInbound.GetInboundDocs(Rec);
                        Rec."Document Status":=Rec.GetHeaderStatus(0);
                        Rec.Modify;
                    end;
                }
                action("Get Source Documents")
                {
                    ApplicationArea = All;
                    Caption = 'Get Source Documents';
                    Ellipsis = true;
                    Image = GetSourceDoc;
                    ShortCutKey = 'Ctrl+F7';
                    Visible = false;

                    trigger OnAction()
                    var
                        GetSourceDocInbound: Codeunit "Get Source Doc. Inbound";
                    begin
                        GetSourceDocInbound.GetSingleInboundDoc(Rec);
                        Rec."Document Status":=Rec.GetHeaderStatus(0);
                        Rec.Modify;
                    end;
                }
                separator(Action24)
                {
                }
                action("Calculate Cross-Dock")
                {
                    ApplicationArea = All;
                    Caption = 'Calculate Cross-Dock';
                    Image = CalculateCrossDock;

                    trigger OnAction()
                    var
                        CrossDockOpp: Record "Whse. Cross-Dock Opportunity";
                        CrossDockMgt: Codeunit "Whse. Cross-Dock Management";
                    begin
                        CrossDockMgt.CalculateCrossDockLines(CrossDockOpp, '', Rec."No.", Rec."Location Code");
                    end;
                }
                action("Create Quality Order")
                {
                    ApplicationArea = All;
                    Caption = 'Create Quality Order';

                    trigger OnAction()
                    var
                        WHReceiptLineLocal: Record "Warehouse Receipt Line";
                        SourceTypeLocal: Option Purchase, Manufacturing, Routing, MRN;
                        QualityManagement: Codeunit "Quality Management";
                        TemplateTypeLocal: Option Receipt, Manufacturing, Routing;
                        Lines: Integer;
                        SetupQuality: Record "SSD Quality Setup";
                        ItemLocal: Record Item;
                        LotNoInfLocal: Record "Lot No. Information";
                        ReservationEntry: Record "Reservation Entry";
                        ItemTrackingExist: Boolean;
                        DummyReservationEntry: Record "Reservation Entry" temporary;
                        Item: Record Item;
                        IsHandled: Boolean;
                    begin
                        OnBeforeCreateQualityOrder(Rec, IsHandled);
                        if IsHandled then exit;
                        //CORP::PK 290619 >>>
                        if Location.Get(Rec."Location Code")then;
                        WarehouseReceiptLine.Reset;
                        WarehouseReceiptLine.SetRange("No.", Rec."No.");
                        if WarehouseReceiptLine.FindSet then repeat if Item.Get(WarehouseReceiptLine."Item No.")then;
                                if(Location."Phy. Bin Required") and (Item."Phy. Bin Required")then begin
                                    ItemPhyBinDetails.Reset;
                                    ItemPhyBinDetails.SetRange("Document No.", WarehouseReceiptLine."No.");
                                    ItemPhyBinDetails.SetRange("Document Line No.", WarehouseReceiptLine."Line No.");
                                    if not ItemPhyBinDetails.FindFirst then Error('Please fill Item Phy. Bin Details')
                                    else
                                    begin
                                        ItemPhyBinDetails."Posting Date":=Rec."Posting Date";
                                        ItemPhyBinDetails.Modify;
                                    end;
                                end;
                            until WarehouseReceiptLine.Next = 0;
                        //CORP::PK 290619 <<<
                        if Rec.Blocked = true then Error(TXT0006);
                        Lines:=0;
                        if not SetupQuality.Get(UserMgt.GetRespCenterFilter)then begin
                            SetupQuality.Init;
                            SetupQuality."Responsibility Center":=UserMgt.GetRespCenterFilter;
                        end;
                        if not SetupQuality."Activate Quality Control Man." then Error(Text003);
                        WHReceiptLineLocal.Reset;
                        WHReceiptLineLocal.SetRange("No.", Rec."No.");
                        WHReceiptLineLocal.SetRange("Quality Required", true);
                        WHReceiptLineLocal.SetRange("Send For Quality", false);
                        WHReceiptLineLocal.SetFilter("Actual Qty. to Receive", '<>%1', 0);
                        if WHReceiptLineLocal.Find('-')then begin
                            repeat //**** Checking For Lot No ***********************
                                ItemLocal.Get(WHReceiptLineLocal."Item No.");
                                if ItemLocal."Item Tracking Code" <> '' then begin
                                    ReservationEntry.Reset;
                                    ReservationEntry.SETCURRENTKEY("Source ID", "Source Ref. No.", "Source Type", "Source Subtype", "Source Batch Name", "Source Prod. Order Line", "Reservation Status", "Shipment Date", "Expected Receipt Date");
                                    ReservationEntry.SetRange("Source Type", WHReceiptLineLocal."Source Type");
                                    ReservationEntry.SetRange("Source Subtype", WHReceiptLineLocal."Source Subtype");
                                    ReservationEntry.SetRange("Source ID", WHReceiptLineLocal."Source No.");
                                    ReservationEntry.SetRange("Source Ref. No.", WHReceiptLineLocal."Source Line No.");
                                    ReservationEntry.SetFilter("Item Tracking", '%1|%2|%3|%4', ReservationEntry."Item Tracking"::"Lot No.", ReservationEntry."Item Tracking"::"Lot and Package No.", ReservationEntry."Item Tracking"::"Lot and Serial and Package No.", ReservationEntry."Item Tracking"::"Lot and Serial No.");
                                    if not ReservationEntry.FindFirst then begin
                                        ItemTrackingExist:=false;
                                        Error(Text0008, WHReceiptLineLocal."Item No.");
                                    end
                                    else
                                        ItemTrackingExist:=true;
                                end;
                                //ALLE VIJ
                                if Confirm(Text0009, true)then begin
                                    if ItemTrackingExist then QualityManagement.CreateReceiptQualityOrder(Recsourcetype::Purchase, WHReceiptLineLocal, Rectemplatetype::Receipt, Lines);
                                end;
                            until WHReceiptLineLocal.Next = 0;
                            Message(Text002, Lines);
                            Rec."Create DateTime":=CurrentDatetime; //Alle-mk add
                        end
                        else
                            Message(Text001);
                    end;
                }
                action("Print &Barcode Label")
                {
                    ApplicationArea = All;
                    Caption = 'Print &Barcode Label';

                    trigger OnAction()
                    begin
                        // <<<< ALLE[5.51]
                        ReservationEntry1.Reset;
                        ReservationEntry1.SetCurrentkey("MRN No.", "Item No.", "MRN Line No.", "Lot No.");
                        ReservationEntry1.SetRange(ReservationEntry1."MRN No.", Rec."No.");
                        if ReservationEntry1.FindFirst then begin
                            BarcodeReceipt.SetTableview(ReservationEntry1);
                            BarcodeReceipt.RunModal;
                        end;
                    // >>>> ALLE[5.51]
                    end;
                }
            }
            group("P&osting")
            {
                Caption = 'P&osting';

                action("P&ost Receipt")
                {
                    ApplicationArea = All;
                    Caption = 'P&ost Receipt';
                    Image = Post;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ShortCutKey = 'F9';

                    trigger OnAction()
                    var
                        FrmScrap: Page "Scrap Worksheet";
                        CheckYesNo: Boolean;
                        Item: Record Item;
                    begin
                        OnBeforeMaterialReceiptPost(Rec);
                        //CF001.02 St
                        //**********CEN001 Check For Blocked
                        if Rec.Blocked = true then Error(TXT0006);
                        //********CEN001   Ankit **********
                        //CORP::PK 290619 >>>
                        if Location.Get(Rec."Location Code")then;
                        WarehouseReceiptLine.Reset;
                        WarehouseReceiptLine.SetRange("No.", Rec."No.");
                        WarehouseReceiptLine.SetRange("Source Document", WarehouseReceiptLine."Source Document");
                        if WarehouseReceiptLine.FindSet then repeat if Item.Get(WarehouseReceiptLine."Item No.")then;
                                if(Location."Phy. Bin Required") and (Item."Phy. Bin Required")then begin
                                    ItemPhyBinDetails.Reset;
                                    ItemPhyBinDetails.SetRange("Document No.", WarehouseReceiptLine."No.");
                                    ItemPhyBinDetails.SetRange("Document Line No.", WarehouseReceiptLine."Line No.");
                                    if not ItemPhyBinDetails.FindFirst then Error('Please fill Item Phy. Bin Details')
                                    else
                                    begin
                                        ItemPhyBinDetails."Posting Date":=Rec."Posting Date";
                                        ItemPhyBinDetails.Modify;
                                    end;
                                end;
                            until WarehouseReceiptLine.Next = 0;
                        //CORP::PK 290619 <<<
                        ///**** Checking For Quality *******
                        CheckingForQualityComplete(Rec);
                        ///**** Update Subcontracting Related Information *******
                        if Rec.Subcontracting then UpdateSubContracRec(Rec);
                        // CF001.02 En
                        //ALLEAA CML-033 080508 Start >>
                        CheckWhseLines.Reset;
                        CheckWhseLines.SetRange(CheckWhseLines."No.", Rec."No.");
                        if CheckWhseLines.FindFirst then repeat if Location.Get(CheckWhseLines."Location Code")then;
                                if Location."Bin Mandatory" = true then begin
                                    BinContent.SetRange("Item No.", CheckWhseLines."Item No.");
                                    BinContent.SetRange("Location Code", CheckWhseLines."Location Code");
                                    BinContent.SetRange("Bin Code", CheckWhseLines."Bin Code");
                                    if not BinContent.FindFirst then Error(Text50000, CheckWhseLines."Item No.", CheckWhseLines."Location Code", CheckWhseLines."Bin Code");
                                end;
                            until CheckWhseLines.Next = 0;
                        //ALLEAA CML-033 080508 End <<
                        CheckYesNo:=CurrPage.WhseReceiptLines.Page.CheckScrap(Rec);
                        SubconMRN:=Rec."Subcontracting Transfer Order";
                        if SubconMRN then //ALLEAA CML-033 050508
 CopyWhseLines(Rec); //ALLEAA CML-033 050508
                        CurrPage.WhseReceiptLines.Page.WhsePostRcptYesNo;
                        if SubconMRN then //ALLEAA CML-033 050508
 PostSubconRejection; //ALLEAA CML-033 050508
                        //>>CEN_AA001 26.04.07
                        if CheckYesNo then begin
                            if Confirm('Do You want to update Scrap')then begin
                                FrmScrap.CalulateScrap;
                                FrmScrap.UpdateScrap();
                            end;
                        end;
                    //<<CEN_AA001
                    end;
                }
                action("Post and &Print")
                {
                    ApplicationArea = All;
                    Caption = 'Post and &Print';
                    Image = PostPrint;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ShortCutKey = 'Shift+F9';
                    Visible = false;

                    trigger OnAction()
                    var
                        Item: Record Item;
                    begin
                        OnBeforeMaterialReceiptPost(Rec);
                        //CORP::PK 290619 >>>
                        if Location.Get(Rec."Location Code")then;
                        WarehouseReceiptLine.Reset;
                        WarehouseReceiptLine.SetRange("No.", Rec."No.");
                        if WarehouseReceiptLine.FindSet then repeat if Item.Get(WarehouseReceiptLine."Item No.")then;
                                if(Location."Phy. Bin Required") and (Item."Phy. Bin Required")then begin
                                    ItemPhyBinDetails.Reset;
                                    ItemPhyBinDetails.SetRange("Document No.", WarehouseReceiptLine."No.");
                                    ItemPhyBinDetails.SetRange("Document Line No.", WarehouseReceiptLine."Line No.");
                                    if not ItemPhyBinDetails.FindFirst then Error('Please fill Item Phy. Bin Details');
                                end;
                            until WarehouseReceiptLine.Next = 0;
                        //CORP::PK 290619 <<<
                        CheckingForQualityComplete(Rec);
                        CurrPage.WhseReceiptLines.Page.WhsePostRcptPrint;
                    end;
                }
            }
            action("&Print")
            {
                ApplicationArea = All;
                Caption = '&Print';
                Ellipsis = true;
                Image = Print;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    Rec.SetRecfilter;
                    Report.RunModal(Report::"Material Receipt Note", true, false, Rec);
                    Rec.Reset;
                end;
            }
        }
    }
    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        //CF001.01 St
        Rec."Responsibility Center":=UserMgt.GetRespCenterFilter;
    end;
    trigger OnOpenPage()
    begin
        //FindFirstAllowedRec(Rec);
        Rec.OpenWhseRcptHeader(Rec);
    //
    // //CF001.01 St
    // if UserMgt.GetRespCenterFilter <> '' then begin
    //     Rec.FilterGroup(2);
    //     Rec.SetRange("Responsibility Center", UserMgt.GetRespCenterFilter);
    //     Rec.FilterGroup(0);
    // end;
    //CF001.01 En
    end;
    var WhseDocPrint: Codeunit "Warehouse Document-Print";
    UserMgt: Codeunit "SSD User Setup Management";
    Text001: label 'No Lines found for Quality Order Generation';
    Text002: label '%1 nos. of Quality Order Generated ';
    Text003: label 'Activate Quality Control Man. must be TRUE in Quality Setup ';
    Text004: label 'Lot No Information not found for Order No %1 Line No %2';
    Txt0005: label 'Normal Quality Order,Coil Type Quality Order';
    TXT0006: label 'MRN is Blocked.';
    TXT0007: label 'Please Define Posted MRN Series.';
    ItemJnlLine: Record "Item Journal Line";
    WhseLines: Record "Warehouse Receipt Line" temporary;
    SubconMRN: Boolean;
    BinContent: Record "Bin Content";
    CheckWhseLines: Record "Warehouse Receipt Line";
    Text50000: label 'Bin Contents does not exist for Item %1 , Location %2 and Bin %3.';
    Location: Record Location;
    UserSetup: Record "User Setup";
    Text0008: label 'Item tracking lines are not defined for item no. %1.';
    Text0009: label 'Do you want to create Quality Order?';
    RecSourceType: Option Purchase, Manufacturing, , Calibration;
    RecTemplateType: Option Receipt, Manufacturing, , Calibration;
    ReservationEntry1: Record "Reservation Entry";
    BarcodeReceipt: Report "BARCODE LEBEL RECEIPT 4x3";
    ItemPhyBinDetails: Record "SSD Item Phy. Bin Details";
    WarehouseReceiptLine: Record "Warehouse Receipt Line";
    QRCodeDetail: Record "SSD QR Code Detail";
    BarCodeNoInt: Integer;
    I: Integer;
    ReservationEntry: Record "Reservation Entry";
    QRCodeMgt: Codeunit "QR Code Mgt.";
    WarehouseEntry: Record "Warehouse Entry";
    BinCode: Code[20];
    Text0011: label 'QR Create successfully.';
    Desc: Text;
    procedure CheckingForQualityComplete(RecWHRcvdHeader: Record "Warehouse Receipt Header")
    var
        WHRcvdLineLocal: Record "Warehouse Receipt Line";
        LocationLocal: Record Location;
    begin
        WHRcvdLineLocal.Reset;
        WHRcvdLineLocal.SetRange("No.", RecWHRcvdHeader."No.");
        WHRcvdLineLocal.SetRange("Quality Required", true);
        WHRcvdLineLocal.SetFilter(WHRcvdLineLocal."Source Document", '<>%1', WHRcvdLineLocal."source document"::"Inbound Transfer");
        if WHRcvdLineLocal.Find('-')then repeat WHRcvdLineLocal.TestField("Quality Done", true);
            until WHRcvdLineLocal.Next = 0;
        WHRcvdLineLocal.Reset;
        WHRcvdLineLocal.SetRange("No.", RecWHRcvdHeader."No.");
        WHRcvdLineLocal.SetFilter("Rejected Qty.", '<>%1', 0);
        if WHRcvdLineLocal.Find('-')then repeat WHRcvdLineLocal.TestField("Reject Location Code");
                LocationLocal.Get(WHRcvdLineLocal."Reject Location Code");
                if LocationLocal."Bin Mandatory" then WHRcvdLineLocal.TestField("Reject Bin Code");
            until WHRcvdLineLocal.Next = 0;
    end;
    procedure UpdateSubContracRec(RecWHRcvdHeader: Record "Warehouse Receipt Header")
    var
        SubOrderCompListVend: Record "Sub Order Comp. List Vend";
        WHRcvdLineLocal: Record "Warehouse Receipt Line";
    begin
        //CF001.02 St
        ///***If Purchase Order is of Subcontracting Type, then update SubOrder CompList Vendor Table*********
        if not RecWHRcvdHeader.Subcontracting then exit;
        WHRcvdLineLocal.Reset;
        WHRcvdLineLocal.SetRange("No.", RecWHRcvdHeader."No.");
        if WHRcvdLineLocal.Find('-')then repeat SubOrderCompListVend.Reset;
                SubOrderCompListVend.SetFilter("Document No.", WHRcvdLineLocal."Source No.");
                SubOrderCompListVend.SetRange("Document Line No.", WHRcvdLineLocal."Source Line No.");
            //SubOrderCompListVend.UpdateReceiptQtyToRcvd(SubOrderCompListVend,WHRcvdLineLocal."Actual Qty. to Receive");
            //SubOrderCompListVend.UpdateReceiptDetails(SubOrderCompListVend,"Qty. to Reject (C.E.)","Qty. to Reject (V.E.)");
            until WHRcvdLineLocal.Next = 0;
    //CF001.02 En
    end;
    procedure PostSubconRejection()
    var
        WhseReceiptLineLocal: Record "Warehouse Receipt Line";
        ILELocal: Record "Item Ledger Entry";
    begin
        //ALLEAA CML-033 050508 Start >>
        //IF "Subcontracting Transfer Order" THEN BEGIN
        WhseLines.Reset;
        WhseLines.SetRange(WhseLines."No.", Rec."No.");
        WhseLines.SetRange("Quality Done", true);
        WhseLines.SetFilter("Rejected Qty.", '<>%1', 0);
        WhseLines.SetFilter("Reject Location Code", '<>%1', '');
        WhseLines.SetFilter("Reject Bin Code", '<>%1', '');
        if WhseLines.FindFirst then repeat ILELocal.Reset;
                ILELocal.SetRange("Document No.", WhseLines."Source No.");
                ILELocal.SetRange("Item No.", WhseLines."Item No.");
                ILELocal.SetRange("Entry Type", ILELocal."entry type"::Transfer);
                ILELocal.SetFilter(Quantity, '>%1', 0);
                if ILELocal.FindLast then begin
                    InsertItemJnlLine(ILELocal, WhseLines."Source No.", WhseLines);
                end;
            until WhseLines.Next = 0;
    //END;
    //ALLEAA CML-033 050508 End <<
    end;
    procedure InsertItemJnlLine(ItemLedgEntry: Record "Item Ledger Entry"; DocNo: Code[20]; WhseLocalLine: Record "Warehouse Receipt Line")
    var
        DimItem: Record Item;
        LineNo: Integer;
    begin
        //ALLEAA CML-033 050508 Start >>
        ItemJnlLine.Reset;
        ItemJnlLine.SetRange("Journal Template Name", 'SUBCON-BOM');
        ItemJnlLine.SetRange("Journal Batch Name", 'SUBCON-BOM');
        if ItemJnlLine.Find('+')then LineNo:=ItemJnlLine."Line No.";
        ItemJnlLine.Init;
        ItemJnlLine."Journal Template Name":='SUBCON-BOM';
        ItemJnlLine."Journal Batch Name":='SUBCON-BOM';
        LineNo+=10000;
        ItemJnlLine.Validate("Line No.", LineNo);
        ItemJnlLine.Validate("Posting Date", WorkDate);
        ItemJnlLine.Validate("Document No.", DocNo);
        ItemJnlLine.Validate("Entry Type", ItemJnlLine."entry type"::Transfer);
        ItemJnlLine.Validate("Item No.", ItemLedgEntry."Item No.");
        ItemJnlLine.Validate("Location Code", WhseLocalLine."Location Code");
        ItemJnlLine.Validate("Bin Code", WhseLocalLine."Bin Code");
        ItemJnlLine.Validate("New Location Code", WhseLocalLine."Reject Location Code");
        ItemJnlLine.Validate("New Bin Code", WhseLocalLine."Reject Bin Code");
        ItemJnlLine.Validate(Quantity, WhseLocalLine."Rejected Qty.");
        ItemJnlLine.Validate(ItemJnlLine."Unit Amount", ItemLedgEntry."Cost Amount (Actual)" / ItemLedgEntry.Quantity);
        ItemJnlLine.Validate(ItemJnlLine."Applies-to Entry", ItemLedgEntry."Entry No.");
        ItemJnlLine."SUBCON Consumption":=true;
        DimItem.Get(ItemJnlLine."Item No.");
        ItemJnlLine.Validate("Shortcut Dimension 1 Code", DimItem."Global Dimension 1 Code");
        ItemJnlLine.Validate("Shortcut Dimension 2 Code", DimItem."Global Dimension 2 Code");
        ItemJnlLine."Shortcut Dimension 1 Code":=DimItem."Global Dimension 1 Code";
        ItemJnlLine."Shortcut Dimension 2 Code":=DimItem."Global Dimension 2 Code";
        ItemJnlLine.Insert;
        Codeunit.Run(Codeunit::"Item Jnl.-Post", ItemJnlLine);
    //ALLEAA CML-033 050508 End <<
    end;
    procedure CopyWhseLines(WhseHeader: Record "Warehouse Receipt Header")
    var
        WhseRcptLnLocal: Record "Warehouse Receipt Line";
    begin
        WhseLines.DeleteAll;
        if WhseHeader."Subcontracting Transfer Order" then begin
            WhseRcptLnLocal.Reset;
            WhseRcptLnLocal.SetRange("No.", Rec."No.");
            WhseRcptLnLocal.SetRange("Quality Done", true);
            WhseRcptLnLocal.SetFilter("Rejected Qty.", '<>%1', 0);
            WhseRcptLnLocal.SetFilter("Reject Location Code", '<>%1', '');
            WhseRcptLnLocal.SetFilter("Reject Bin Code", '<>%1', '');
            if WhseRcptLnLocal.FindFirst then repeat WhseLines.Init;
                    WhseLines.TransferFields(WhseRcptLnLocal);
                    WhseLines.Insert;
                until WhseRcptLnLocal.Next = 0;
        end;
    end;
    local procedure SortingMethodOnAfterValidate()
    begin
        CurrPage.Update;
    end;
    local procedure OnValidateWorkOrderNo(OrderNo: Code[20])TotalAmt: Decimal var
        PurchLine: Record "Purchase Line";
    begin
        //ALLE-AT >>
        TotalAmt:=0;
        PurchLine.Reset();
        PurchLine.SetRange("Document No.", OrderNo);
        PurchLine.SetRange("Document Type", PurchLine."document type"::Order);
        if PurchLine.FindSet then repeat TotalAmt+=PurchLine.Amount;
            until PurchLine.Next = 0;
        exit(TotalAmt);
    //ALLE-AT <<
    end;
    [IntegrationEvent(false, false)]
    local procedure OnBeforeCreateQualityOrder(var WarehouseReceiptHeader: Record "Warehouse Receipt Header"; var IsHandled: Boolean)
    begin
    end;
    [IntegrationEvent(false, false)]
    local procedure OnBeforeMaterialReceiptPost(var WarehouseReceiptHeader: Record "Warehouse Receipt Header")
    begin
    end;
}
