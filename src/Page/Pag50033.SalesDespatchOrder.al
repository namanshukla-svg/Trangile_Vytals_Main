Page 50033 "Sales Despatch Order"
{
    Caption = 'Sales Despatch Slip';
    PageType = Document;
    RefreshOnActivate = true;
    SourceTable = "Sales Header";
    SourceTableView = where("Document Type" = filter(Order), "Document Subtype" = const(Despatch));
    ApplicationArea = All;
    DeleteAllowed = true;

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';

                field("No."; Rec."No.")
                {
                    ApplicationArea = All;

                    trigger OnAssistEdit()
                    begin
                        if Rec.AssistEdit(xRec) then CurrPage.Update;
                    end;
                }
                field("Sell-to Customer No."; Rec."Sell-to Customer No.")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        if (Rec."Sell-to Customer No." <> xRec."Sell-to Customer No.") and (xRec."Sell-to Customer No." = '') then begin
                            Rec."Ref. Doc. Subtype" := Rec."ref. doc. subtype"::"Sales Order";
                            Rec.Validate("Order/Scd. No.", '');
                        end;
                        SelltoCustomerNoOnAfterValidat;
                    end;
                }
                field("Sell-to Contact No."; Rec."Sell-to Contact No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Sell-to Customer Name"; Rec."Sell-to Customer Name")
                {
                    ApplicationArea = All;
                }
                field("Sell-to Address"; Rec."Sell-to Address")
                {
                    ApplicationArea = All;
                }
                field("Sell-to Address 2"; Rec."Sell-to Address 2")
                {
                    ApplicationArea = All;
                }
                field("Sell-to Post Code"; Rec."Sell-to Post Code")
                {
                    ApplicationArea = All;
                    Caption = 'Sell-to Post Code/City';
                    Editable = false;
                }
                field("Sell-to City"; Rec."Sell-to City")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Ref. Doc. Subtype"; Rec."Ref. Doc. Subtype")
                {
                    ApplicationArea = All;
                    Caption = 'Ref. Doc. Subtype';
                }
                field("Order/Scd. No."; Rec."Order/Scd. No.")
                {
                    ApplicationArea = All;
                    Caption = 'Ref. Doc. No.';

                    //Editable = false;//SSDU
                    trigger OnLookup(var Text: Text): Boolean
                    var
                        SalesHeaderLocal: Record "Sales Header";
                        SalesLineLocal: Record "Sales Line";
                    begin
                        case Rec."Ref. Doc. Subtype" of
                            Rec."ref. doc. subtype"::" ":
                                begin
                                    CheckOrderLineStatus(Rec);
                                    Rec."Order/Scd. No." := '';
                                    UpdateDespatchLine(Rec);
                                end;
                            Rec."ref. doc. subtype"::"Sales Order":
                                begin
                                    SalesHeaderLocal.Reset;
                                    SalesLineLocal.Reset;
                                    SalesLineLocal.SetCurrentkey("Sell-to Customer No.", "No.", "Document Type", "Document Subtype");
                                    SalesLineLocal.SetRange("Document Type", SalesLineLocal."document type"::Order);
                                    SalesLineLocal.SetRange("Sell-to Customer No.", Rec."Sell-to Customer No.");
                                    SalesLineLocal.SetRange("Document Subtype", SalesLineLocal."document subtype"::Order);
                                    /*
                                            SalesLineLocal.SETRANGE("Planned Shipment Date",
                                                         DMY2DATE(1,DATE2DMY("Order Date",2),DATE2DMY("Order Date",3)),
                                                         CALCDATE('1M-1D',DMY2DATE(1,DATE2DMY("Order Date",2),DATE2DMY("Order Date",3))));
                                            */
                                    SalesLineLocal.SetFilter("Qty. to Ship", '>%1', 0);
                                    if SalesLineLocal.Find('-') then begin
                                        repeat
                                            SalesHeaderLocal.Get(SalesLineLocal."Document Type", SalesLineLocal."Document No.");
                                            SalesHeaderLocal.Mark(true);
                                        until SalesLineLocal.Next = 0;
                                        SalesHeaderLocal.MarkedOnly(true);
                                        SalesHeaderLocal.SetRange(Status, SalesHeaderLocal.Status::Released);
                                        if Page.RunModal(45, SalesHeaderLocal, SalesHeaderLocal."No.") = Action::LookupOK then begin
                                            CheckOrderLineStatus(Rec);
                                            Rec."Order/Scd. No." := SalesHeaderLocal."No.";
                                            Rec.Subcontracting := SalesHeaderLocal.Subcontracting; //CML-034 ALLEAG 240408
                                            UpdateDespatchLine(Rec);
                                        end;
                                    end
                                end;
                            Rec."ref. doc. subtype"::"Sales Schedule":
                                begin
                                    SalesHeaderLocal.Reset;
                                    SalesLineLocal.Reset;
                                    SalesLineLocal.SetCurrentkey("Sell-to Customer No.", "No.", "Document Type", "Document Subtype");
                                    SalesLineLocal.SetRange("Document Type", SalesLineLocal."document type"::Order);
                                    SalesLineLocal.SetRange("Sell-to Customer No.", Rec."Sell-to Customer No.");
                                    SalesLineLocal.SetRange("Document Subtype", SalesLineLocal."document subtype"::Schedule);
                                    /*
                                            SalesLineLocal.SETRANGE("Planned Shipment Date",
                                                         DMY2DATE(1,DATE2DMY("Order Date",2),DATE2DMY("Order Date",3)),
                                                         CALCDATE('1M-1D',DMY2DATE(1,DATE2DMY("Order Date",2),DATE2DMY("Order Date",3))));
                                            */
                                    SalesLineLocal.SetFilter("Qty. to Ship", '>%1', 0);
                                    if SalesLineLocal.Find('-') then begin
                                        repeat
                                            SalesHeaderLocal.Get(SalesLineLocal."Document Type", SalesLineLocal."Document No.");
                                            SalesHeaderLocal.Mark(true);
                                        until SalesLineLocal.Next = 0;
                                        SalesHeaderLocal.MarkedOnly(true);
                                        SalesHeaderLocal.SetRange(Status, SalesHeaderLocal.Status::Released);
                                        if Page.RunModal(45, SalesHeaderLocal, SalesHeaderLocal."No.") = Action::LookupOK then begin
                                            CheckOrderLineStatus(Rec);
                                            Rec."Order/Scd. No." := SalesHeaderLocal."No.";
                                            UpdateDespatchLine(Rec);
                                        end;
                                    end
                                end;
                        end;
                    end;

                    trigger OnValidate()
                    begin
                        CheckOrderStatus(Rec);
                        CheckOrderLineStatus(Rec);
                        case Rec."Ref. Doc. Subtype" of
                            Rec."ref. doc. subtype"::" ":
                                Rec."Order/Scd. No." := '';
                        end;
                        UpdateDespatchLine(Rec);
                    end;
                }
                field(Subcontracting; Rec.Subcontracting)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        CheckOrderStatus(Rec);
                    end;
                }
                field("Order Date"; Rec."Order Date")
                {
                    ApplicationArea = All;
                    Caption = 'Despatch Date';

                    trigger OnValidate()
                    begin
                        CheckOrderStatus(Rec);
                    end;
                }
                field("Responsibility Center"; Rec."Responsibility Center")
                {
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("External Document No."; Rec."External Document No.")
                {
                    ApplicationArea = All;
                    Caption = 'Customer Order No.';
                    Editable = false;
                }
                field("External Doc. Date"; Rec."External Doc. Date")
                {
                    ApplicationArea = All;
                    Caption = 'Customer Order Date';
                    Editable = false;
                }
                field("Total Packed Wt."; Rec."Total Packed Wt.")
                {
                    ApplicationArea = All;
                }
                field("Shipment Method Code"; Rec."Shipment Method Code")
                {
                    ApplicationArea = All;
                    Caption = 'Way of Despatch';
                }
                field("Type of Invoice"; Rec."Type of Invoice")
                {
                    ToolTip = 'Specifies the value of the Type of Invoice field.';
                }
            }
            part(SalesLines; "Sales Desp. Order Subform")
            {
                SubPageLink = "Document No." = field("No.");
                ApplicationArea = all;
            }
            group(Shipping)
            {
                Caption = 'Shipping';

                field("Ship-to Code"; Rec."Ship-to Code")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Ship-to Name"; Rec."Ship-to Name")
                {
                    ApplicationArea = All;
                }
                field("Ship-to Address"; Rec."Ship-to Address")
                {
                    ApplicationArea = All;
                }
                field("Ship-to Address 2"; Rec."Ship-to Address 2")
                {
                    ApplicationArea = All;
                }
                field("Ship-to Post Code"; Rec."Ship-to Post Code")
                {
                    ApplicationArea = All;
                    Caption = 'Ship-to Post Code/City';
                    Editable = false;
                }
                field("Ship-to City"; Rec."Ship-to City")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Ship-to Contact"; Rec."Ship-to Contact")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Insurance; Rec.Insurance)
                {
                    ApplicationArea = All;
                }
                field(Freight; Rec.Freight)
                {
                    ApplicationArea = All;
                }
                field("PF Charges"; Rec."PF Charges")
                {
                    ApplicationArea = All;
                }
                field("Location Code"; Rec."Location Code")
                {
                    ApplicationArea = All;
                }
                field("DI No."; Rec."DI No.")
                {
                    ApplicationArea = All;
                    Editable = "DI No.Editable";
                }
                field("DI Date"; Rec."DI Date")
                {
                    ApplicationArea = All;
                    Editable = "DI DateEditable";
                }
                field("Delivery Location"; Rec."Delivery Location")
                {
                    ApplicationArea = All;
                    Editable = true;
                }
                field("Delivery Time"; Rec."Delivery Time")
                {
                    ApplicationArea = All;
                    Editable = true;
                }
                field("Usage Location"; Rec."Usage Location")
                {
                    ApplicationArea = All;
                    Editable = true;
                }
                field("Bill-to Customer No."; Rec."Bill-to Customer No.")
                {
                    ApplicationArea = All;
                }
                field("Pre Carriage By"; Rec."GR No.")
                {
                    ApplicationArea = All;
                }
                field("Place of Receipt by Pre-carr"; Rec."Place of Receipt by Pre-carr")
                {
                    ApplicationArea = All;
                }
                field("<Port of Loading>"; Rec."Port of Lading")
                {
                    ApplicationArea = All;
                    Caption = 'Port of Loading';
                }
                field("Port of Discharge"; Rec."Port of Discharge")
                {
                    ApplicationArea = All;
                }
                field("Final Destination"; Rec."Final Destination")
                {
                    ApplicationArea = All;
                }
                field("Vessel/Flight No."; Rec."Vessel/Flight No.")
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
            group("O&rder")
            {
                Caption = 'O&rder';

                action(Card)
                {
                    ApplicationArea = All;
                    Caption = 'Card';
                    Image = EditLines;
                    RunObject = Page "Customer Card";
                    RunPageLink = "No." = field("Sell-to Customer No.");
                    ShortCutKey = 'Shift+F7';
                }
                action("Co&mments")
                {
                    ApplicationArea = All;
                    Caption = 'Co&mments';
                    Image = ViewComments;
                    RunObject = Page "Sales Comment Sheet";
                    RunPageLink = "Document Type" = field("Document Type"), "No." = field("No.");
                }
                action(Dimensions)
                {
                    ApplicationArea = All;
                    Caption = 'Dimensions';
                    Image = Dimensions;

                    trigger OnAction()
                    begin
                        Rec.ShowDocDim;
                    end;
                }
            }
        }
        area(processing)
        {
            group("F&unctions")
            {
                Caption = 'F&unctions';

                separator(Action176)
                {
                }
                action("Get St&d. Cust. Sales Codes")
                {
                    ApplicationArea = All;
                    Caption = 'Get St&d. Cust. Sales Codes';
                    Ellipsis = true;
                    Visible = false;

                    trigger OnAction()
                    var
                        StdCustSalesCode: Record "Standard Customer Sales Code";
                    begin
                        StdCustSalesCode.InsertSalesLines(Rec);
                    end;
                }
                separator(Action171)
                {
                }
                action("Nonstoc&k Items")
                {
                    ApplicationArea = All;
                    Caption = 'Nonstoc&k Items';

                    trigger OnAction()
                    begin
                        if not UpdateAllowed then exit;
                        CurrPage.SalesLines.Page.ShowNonstockItems;
                    end;
                }
                separator(Action192)
                {
                }
                action("Copy Document")
                {
                    ApplicationArea = All;
                    Caption = 'Copy Document';
                    Ellipsis = true;
                    Image = CopyDocument;
                    Visible = false;

                    trigger OnAction()
                    begin
                        CopySalesDoc.SetSalesHeader(Rec);
                        CopySalesDoc.RunModal;
                        Clear(CopySalesDoc);
                    end;
                }
                action("Archi&ve Document")
                {
                    ApplicationArea = All;
                    Caption = 'Archi&ve Document';
                    Visible = false;

                    trigger OnAction()
                    begin
                        ArchiveManagement.ArchiveSalesDocument(Rec);
                        CurrPage.Update(false);
                    end;
                }
                action("Move Negative Lines")
                {
                    ApplicationArea = All;
                    Caption = 'Move Negative Lines';
                    Ellipsis = true;
                    Visible = false;

                    trigger OnAction()
                    begin
                        Clear(MoveNegSalesLines);
                        MoveNegSalesLines.SetSalesHeader(Rec);
                        MoveNegSalesLines.RunModal;
                        MoveNegSalesLines.ShowDocument;
                    end;
                }
                separator(Action195)
                {
                }
                action("Re&lease")
                {
                    ApplicationArea = All;
                    Caption = 'Re&lease';
                    Image = ReleaseDoc;
                    ShortCutKey = 'Ctrl+F9';

                    trigger OnAction()
                    var
                        ItemLocal: Record Item;
                    begin
                        //CORP::PK 040719 >>>
                        SalesLine.Reset;
                        SalesLine.SetRange("Document No.", Rec."No.");
                        SalesLine.SetRange(Type, SalesLine.Type::Item);
                        if SalesLine.FindSet then
                            repeat
                                if Location.Get(Rec."Location Code") then;
                                if Item.Get(SalesLine."No.") then;
                                if (Location."Phy. Bin Required") and (Item."Phy. Bin Required") then begin
                                    ItemPhyBinDetails.Reset;
                                    ItemPhyBinDetails.SetRange("Document No.", SalesLine."Document No.");
                                    ItemPhyBinDetails.SetRange("Document Line No.", SalesLine."Line No.");
                                    if not ItemPhyBinDetails.FindFirst then
                                        Error('Please fill the Item Phy. Details in Line No. %1', SalesLine."Line No.")
                                    else begin
                                        ItemPhyBinDetails."Posting Date" := Rec."Posting Date";
                                        ItemPhyBinDetails.Modify;
                                    end;
                                end;
                            until SalesLine.Next = 0;
                        //CORP::PK 040719 <<<
                        //ALLE.MSI
                        SLineRec.Reset;
                        SLineRec.SetCurrentkey("Document Type", "Document No.", "Line No.");
                        SLineRec.SetRange("Document Type", Rec."Document Type");
                        SLineRec.SetRange("Document No.", Rec."No.");
                        if SLineRec.FindFirst then
                            repeat //>>Alle VPB 03-Sep-10 Add Start
                                SalesLine2.Get(SalesLine2."document type"::Order, SLineRec."Order No.", SLineRec."Order Line No.");
                                SalesOrderQty := SalesLine2.Quantity;
                                DispLineQty := 0;
                                SalesLine3.Reset;
                                SalesLine3.SetRange("Document Type", SalesLine3."document type"::Order);
                                SalesLine3.SetRange("Order No.", SLineRec."Order No.");
                                SalesLine3.SetRange("Order Line No.", SLineRec."Order Line No.");
                                SalesLine3.CalcSums(Quantity);
                                DispLineQty := SalesLine3.Quantity;
                                // //Alle OPt
                                //  IF SalesLine2.FIND('-') THEN REPEAT
                                //    DispLineQty += SalesLine2.Quantity;
                                //  UNTIL SalesLine2.NEXT = 0;
                                if DispLineQty > SalesOrderQty then Error('Disaptch Slip(s) for %1 Qty already created for Order No. %2. You can only create Dispatch Slip for %3 Qty for Item %4.', DispLineQty - SLineRec.Quantity, SLineRec."Order No.", SalesOrderQty - (DispLineQty - SLineRec.Quantity), SLineRec."No.");
                                //<<Alle VPB 03-Sep-10 Add Stop
                                AvailQty := 0;
                                ILE.Reset;
                                ILE.SetCurrentkey("Item No.", "Posting Date", "Location Code", "Bin Code");
                                ILE.SetRange("Item No.", SLineRec."No.");
                                ILE.SetRange("Posting Date", 0D, Rec."Posting Date");
                                ILE.SetRange("Location Code", SLineRec."Location Code");
                                //ILE.SetRange("Bin Code", SLineRec."Bin Code");
                                if ILE.FindSet then
                                    repeat
                                        if ItemRec.Get(SLineRec."No.") then begin
                                            if ItemUOM.Get(ItemRec."No.", ItemRec."Base Unit of Measure") then;
                                        end;
                                        if ILE."Unit of Measure Code" = ItemRec."Base Unit of Measure" then
                                            AvailQty += (ILE.Quantity * ROUND((ItemUOM."Qty. per Unit of Measure") / (SLineRec."Qty. per Unit of Measure"), 1))
                                        else
                                            AvailQty += ILE.Quantity;
                                    until ILE.Next = 0;
                                //<<<<< ALLE[551]
                                SLineRec.CalcFields(SLineRec."Gross Wt");
                                ItemLocal.Reset;
                                if (ItemLocal.Get(SLineRec."No.")) and (SLineRec."Gross Wt" < (ItemLocal."Net Weight" * SLineRec.Quantity)) then //IF SLineRec."Gross Wt"  < (ItemLocal."Net Weight"*SLineRec.Quantity) THEN   ALLE Opt
                                    Error('Gross Wt. can not be less than Net Wt. Check Data of Item No. %1', SLineRec."No.");
                                //>>>>> ALLE[551]
                                if SLineRec.Type <> SLineRec.Type::"G/L Account" then begin
                                    if AvailQty < SLineRec.Quantity then Error('Available Inventory for Item %1 is %2', SLineRec."No.", AvailQty);
                                end;
                            until SLineRec.Next = 0;
                        //SSDU_Sunil
                        SalesBuffer.SetSalesBuffer(Rec."No.");
                        Codeunit.Run(Codeunit::"Release Sales Document", Rec);
                        //SSD_Sunil
                        //ALLE.MSI
                    end;
                }
                action("Re&open")
                {
                    ApplicationArea = All;
                    Caption = 'Re&open';
                    Image = ReOpen;

                    trigger OnAction()
                    var
                        ReleaseSalesDoc: Codeunit "Release Sales Document";
                    begin
                        ReleaseSalesDoc.Reopen(Rec);
                    end;
                }
                separator(Action175)
                {
                }
            }
            group("P&osting")
            {
                Caption = 'P&osting';

                action("Test Report")
                {
                    ApplicationArea = All;
                    Caption = 'Test Report';
                    Ellipsis = true;
                    Image = TestReport;

                    trigger OnAction()
                    begin
                        ReportPrint.PrintSalesHeader(Rec);
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
                    Report.Run(Report::"Dispatch Slip", true, false, Rec);
                    Rec.Reset;
                end;
            }
            action(SalesHistoryBtn)
            {
                ApplicationArea = All;
                Caption = 'Sales H&istory';
                Promoted = true;
                PromotedCategory = Process;
                Visible = SalesHistoryBtnVisible;

                trigger OnAction()
                begin
                    //SalesInfoPaneMgt.LookupCustSalesHistory(Rec,"Bill-to Customer No.",TRUE); // BIS 1145
                end;
            }
            action(SalesHistoryStn)
            {
                ApplicationArea = All;
                Caption = 'Sales Histor&y';
                Promoted = true;
                PromotedCategory = Process;
                Visible = SalesHistoryStnVisible;

                trigger OnAction()
                begin
                    //SalesInfoPaneMgt.LookupCustSalesHistory(Rec,"Sell-to Customer No.",TRUE); // BIS 1145
                end;
            }
        }
    }
    trigger OnAfterGetRecord()
    begin
        // ssd
        if Rec."DI No." <> '' then begin
            "DI No.Editable" := false;
            "DI DateEditable" := false;
        end
        else begin
            "DI No.Editable" := true;
            "DI DateEditable" := true;
        end;
        // ssd
        OnAfterGetCurrRecord;
    end;

    trigger OnDeleteRecord(): Boolean
    begin
        CheckOrderStatus(Rec);
        CurrPage.SaveRecord;
        exit(Rec.ConfirmDeletion);
    end;

    trigger OnInit()
    begin
        SalesHistoryStnVisible := true;
        BillToCommentBtnVisible := true;
        BillToCommentPictVisible := true;
        SalesHistoryBtnVisible := true;
        "DI DateEditable" := true;
        "DI No.Editable" := true;
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        Rec.CheckCreditMaxBeforeInsert;
    end;

    trigger OnModifyRecord(): Boolean
    begin
        if Rec."Document Subtype" <> Rec."Document Subtype"::Despatch then CheckOrderStatus(Rec);
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec."Responsibility Center" := UserMgt.GetSalesFilter();
        Rec."Document Subtype" := Rec."document subtype"::Despatch;
        Rec."Ref. Doc. Subtype" := Rec."ref. doc. subtype"::"Sales Order";
        OnAfterGetCurrRecord;
    end;

    trigger OnOpenPage()
    begin
        if UserMgt.GetSalesFilter() <> '' then begin
            Rec.FilterGroup(2);
            Rec.SetRange("Responsibility Center", UserMgt.GetSalesFilter());
            Rec.FilterGroup(0);
        end;
        Rec.SetRange("Date Filter", 0D, WorkDate - 1);
    end;

    var
        Text000: label 'Unable to execute this function while in view only mode.';
        CopySalesDoc: Report "Copy Sales Document";
        MoveNegSalesLines: Report "Move Negative Sales Lines";
        ReportPrint: Codeunit "Test Report-Print";
        DocPrint: Codeunit "Document-Print";
        ArchiveManagement: Codeunit ArchiveManagement;
        SalesInfoPaneMgt: Codeunit "Sales Info-Pane Management";
        SalesSetup: Record "Sales & Receivables Setup";
        ChangeExchangeRate: Page "Change Exchange Rate";
        UserMgt: Codeunit "User Setup Management";
        "--NAVIN": Integer;
        SalesLine: Record "Sales Line";
        MLTransactionType: Option Purchase,Sale;
        Text002: label 'Despatch already done in Despatch Slip No. %1  ';
        ReleaseSale: Codeunit "Release Sales Document";
        SalesBuffer: Record "SSD Sales Schedule Buffer";
        SLineRec: Record "Sales Line";
        ILE: Record "Item Ledger Entry";
        AvailQty: Decimal;
        ItemRec: Record Item;
        ItemUOM: Record "Item Unit of Measure";
        SalesLine2: Record "Sales Line";
        SalesOrderQty: Decimal;
        DispLineQty: Decimal;
        "DI No.Editable": Boolean;
        "DI DateEditable": Boolean;
        SalesHistoryBtnVisible: Boolean;
        BillToCommentPictVisible: Boolean;
        BillToCommentBtnVisible: Boolean;
        SalesHistoryStnVisible: Boolean;
        Text19030125: label '( Kg )';
        Text19070588: label 'Sell-to Customer';
        Text19069283: label 'Bill-to Customer';
        DimensionManagement: Codeunit DimensionManagement;
        Location: Record Location;
        Item: Record Item;
        ItemPhyBinDetails: Record "SSD Item Phy. Bin Details";
        SalesLine3: Record "Sales Line";

    procedure UpdateAllowed(): Boolean
    begin
        if CurrPage.Editable = false then Error(Text000);
        exit(true);
    end;

    procedure UpdateDespatchLine(var RecSalesHeader: Record "Sales Header")
    var
        SalesHeaderLocal: Record "Sales Header";
    begin
        //CF001 St
        UpdateDespatchHeader(RecSalesHeader);
        CheckOrderLineStatus(RecSalesHeader);
        CurrPage.SalesLines.Page.DeleteDespatchLines(RecSalesHeader);
        if Rec."Order/Scd. No." <> '' then begin
            CurrPage.SalesLines.Page.CopySalesDoc(RecSalesHeader."Document Type", RecSalesHeader."Order/Scd. No.", RecSalesHeader);
            CurrPage.Update(true);
        end;
        //CF001 En
    end;

    procedure CheckOrderStatus(RecSalesHeader: Record "Sales Header")
    begin
        RecSalesHeader.TestField(Status, Rec.Status::Open);
        if RecSalesHeader."Get Despatch Used" = true then Error(Text002, RecSalesHeader."No.");
    end;

    procedure CheckOrderLineStatus(RecSalesHeader: Record "Sales Header")
    var
        SalesLineLocal: Record "Sales Line";
    begin
        SalesLineLocal.Reset;
        SalesLineLocal.SetCurrentkey("Document Type", "Document No.", Type, "No.");
        SalesLineLocal.SetRange("Document Type", RecSalesHeader."Document Type");
        SalesLineLocal.SetRange("Document No.", RecSalesHeader."No.");
        SalesLineLocal.SetRange(Type, SalesLineLocal.Type::Item);
        if SalesLineLocal.Find('-') then
            repeat
                CurrPage.SalesLines.Page.CheckOrderStatus(SalesLineLocal);
            until SalesLineLocal.Next = 0;
    end;

    procedure UpdateDespatchHeader(var RecSalesHeader: Record "Sales Header")
    var
        SalesHeaderLocal: Record "Sales Header";
    begin
        //CF001 St
        if RecSalesHeader."Order/Scd. No." <> '' then begin
            SalesHeaderLocal.Get(SalesHeaderLocal."document type"::Order, RecSalesHeader."Order/Scd. No.");
            OnAfterGetSalesHeaderOnDispatchSlip(SalesHeaderLocal);
            RecSalesHeader."External Document No." := SalesHeaderLocal."External Document No.";
            RecSalesHeader."External Doc. Date" := SalesHeaderLocal."External Doc. Date";
            RecSalesHeader."Total Packed Wt." := SalesHeaderLocal."Total Packed Wt.";
            //ALLE 3.14 >>
            RecSalesHeader.ARE1 := SalesHeaderLocal.ARE1;
            //ALLE 3.14 <<
            //ALLE 3.15 >>
            RecSalesHeader."Customer Order No." := SalesHeaderLocal."Customer Order No.";
            RecSalesHeader."Customer Order Date" := SalesHeaderLocal."Customer Order Date";
            RecSalesHeader.CT2 := SalesHeaderLocal.CT2;
            RecSalesHeader."CT2 Form" := SalesHeaderLocal."CT2 Form";
            //ALLE 3.16
            RecSalesHeader.CT3 := SalesHeaderLocal.CT3;
            RecSalesHeader."CT3 Form" := SalesHeaderLocal."CT3 Form";
            //ALLE 3.16
            //ALLE 3.03 v1.11
            //ALLE 3.03 v1.11
            RecSalesHeader."Excise Bus Posting Group(ADE)" := SalesHeaderLocal."Excise Bus Posting Group(ADE)";
            // kapil
            RecSalesHeader."Schedule Month" := SalesHeaderLocal."Schedule Month";
            RecSalesHeader.Insurance := SalesHeaderLocal.Insurance;
            RecSalesHeader.Freight := SalesHeaderLocal.Freight;
            RecSalesHeader."PF Charges" := SalesHeaderLocal."PF Charges";
            RecSalesHeader."RGP Receipt No." := SalesHeaderLocal."RGP Receipt No."; //CEN004.06
            // kapil
            //ALLE-NM >>
            RecSalesHeader."Shortcut Dimension 1 Code" := SalesHeaderLocal."Shortcut Dimension 1 Code";
            RecSalesHeader."Shortcut Dimension 2 Code" := SalesHeaderLocal."Shortcut Dimension 2 Code";
            RecSalesHeader."Dimension Set ID" := SalesHeaderLocal."Dimension Set ID";
            //DimensionManagement.ValidateShortcutDimValues(
            //ALLE-NM <<
            //>>Alle VPB
            RecSalesHeader."Ship-to Code" := SalesHeaderLocal."Ship-to Code";
            RecSalesHeader."Ship-to Name" := SalesHeaderLocal."Ship-to Name";
            RecSalesHeader."Ship-to Name 2" := SalesHeaderLocal."Ship-to Name 2";
            RecSalesHeader."Ship-to Address" := SalesHeaderLocal."Ship-to Address";
            RecSalesHeader."Ship-to Address 2" := SalesHeaderLocal."Ship-to Address 2";
            RecSalesHeader."Ship-to City" := SalesHeaderLocal."Ship-to City";
            RecSalesHeader."Ship-to Contact" := SalesHeaderLocal."Ship-to Contact";
            RecSalesHeader."Ship-to Post Code" := SalesHeaderLocal."Ship-to Post Code";
            RecSalesHeader."Ship-to County" := SalesHeaderLocal."Ship-to County";
            RecSalesHeader."Ship-to Country/Region Code" := SalesHeaderLocal."Ship-to Country/Region Code";
            RecSalesHeader."Shipment Method Code" := SalesHeaderLocal."Shipment Method Code"; //Alle VPB 130910
            //<<Alle VPB
            RecSalesHeader."Type of Invoice" := SalesHeaderLocal."Type of Invoice";
            RecSalesHeader.Modify;
        end;
        //CF001 En
    end;

    local procedure SelltoCustomerNoOnAfterValidat()
    begin
        CurrPage.Update;
    end;

    local procedure OnAfterGetCurrRecord()
    begin
        xRec := Rec;
        Rec.SetRange("Date Filter", 0D, WorkDate - 1);
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterGetSalesHeaderOnDispatchSlip(SalesHeader: Record "Sales Header")
    begin
    end;
}
