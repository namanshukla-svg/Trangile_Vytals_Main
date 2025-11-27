Page 50239 "Pending Purch Account Booking"
{
    // //IND 18.02.2006 New Function
    // //CF001.01 15.06.2006 For Showing Quality Order
    AutoSplitKey = true;
    Caption = 'Posted Purchase Rcpt. Subform';
    DeleteAllowed = false;
    Editable = false;
    PageType = ListPart;
    SourceTable = "Purch. Rcpt. Line";
    SourceTableView = where("Qty. Rcd. Not Invoiced"=filter(<>0));
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                field("Buy-from Vendor No."; Rec."Buy-from Vendor No.")
                {
                    ApplicationArea = All;
                }
                field("Vendor Name"; Rec."Vendor Name")
                {
                    ApplicationArea = All;
                }
                field("Pre Assign MRN No."; Rec."Pre Assign MRN No.")
                {
                    ApplicationArea = All;
                }
                field("Receipt Date"; Rec."Receipt Date")
                {
                    ApplicationArea = All;
                }
                field(Type; Rec.Type)
                {
                    ApplicationArea = All;
                }
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                }
                field("Cross-Reference No."; Rec."Item Reference No.")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Bill No."; Rec."Bill No.")
                {
                    ApplicationArea = All;
                }
                field("Variant Code"; Rec."Variant Code")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Gen. Prod. Posting Group"; Rec."Gen. Prod. Posting Group")
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field("Posted Whse. Rcpt Line No."; Rec."Posted Whse. Rcpt Line No.")
                {
                    ApplicationArea = All;
                }
                field("Qty. Rcd. Not Invoiced"; Rec."Qty. Rcd. Not Invoiced")
                {
                    ApplicationArea = All;
                }
                field("Posted Whse. Rcpt No."; Rec."Posted Whse. Rcpt No.")
                {
                    ApplicationArea = All;
                }
                field("Return Reason Code"; Rec."Return Reason Code")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Location Code"; Rec."Location Code")
                {
                    ApplicationArea = All;
                }
                field("Bin Code"; Rec."Bin Code")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field(Quantity; Rec.Quantity)
                {
                    ApplicationArea = All;
                    BlankZero = true;
                    Editable = true;
                }
                field("Unit of Measure Code"; Rec."Unit of Measure Code")
                {
                    ApplicationArea = All;
                }
                field("Unit of Measure"; Rec."Unit of Measure")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Quantity Invoiced"; Rec."Quantity Invoiced")
                {
                    ApplicationArea = All;
                    BlankZero = true;
                }
                field("Requested Receipt Date"; Rec."Requested Receipt Date")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Job No."; Rec."Job No.")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Prod. Order No."; Rec."Prod. Order No.")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Inbound Whse. Handling Time"; Rec."Inbound Whse. Handling Time")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Appl.-to Item Entry"; Rec."Appl.-to Item Entry")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
            }
        }
    }
    actions
    {
    }
    procedure ShowTracking()
    var
        ItemLedgEntry: Record "Item Ledger Entry";
        TempItemLedgEntry: Record "Item Ledger Entry" temporary;
        TrackingForm: Page "Order Tracking";
    begin
        Rec.TestField(Type, Rec.Type::Item);
        if Rec."Item Rcpt. Entry No." <> 0 then begin
            ItemLedgEntry.Get(Rec."Item Rcpt. Entry No.");
            TrackingForm.SetItemLedgEntry(ItemLedgEntry);
        end
        else
            TrackingForm.SetMultipleItemLedgEntries(TempItemLedgEntry, Database::"Purch. Rcpt. Line", 0, Rec."Document No.", '', 0, Rec."Line No.");
        TrackingForm.RunModal;
    end;
    procedure ShowDimensions()
    begin
        Rec.ShowDimensions;
    end;
    procedure ShowItemTrackingLines()
    begin
        Rec.ShowItemTrackingLines;
    end;
    procedure UndoReceiptLine()
    var
        PurchRcptLine: Record "Purch. Rcpt. Line";
        PostedWhseReceiptHeader: Record "Posted Whse. Receipt Header";
        PostedGateHeader: Record "SSD Posted Gate Header";
        PostedGateLine: Record "SSD Posted Gate Line";
        GateEntryNo: Code[20];
        NewPostedGateLine: Record "SSD Posted Gate Line";
        LastEntryN0: Integer;
    begin
        //>>CE_AA006
        if PostedWhseReceiptHeader.Get(Rec."Posted Whse. Rcpt No.")then GateEntryNo:=PostedWhseReceiptHeader."Gate Entry no.";
        PostedGateLine.Reset;
        PostedGateLine.SetRange(PostedGateLine."Document No.", GateEntryNo);
        if PostedGateLine.Find('+')then LastEntryN0:=PostedGateLine."Line No.";
        PostedGateLine.Reset;
        PostedGateLine.SetRange(PostedGateLine."Document No.", GateEntryNo);
        //PostedGateLine.SETRANGE(PostedGateLine."WH Receipt Line No.","Posted Whse. Rcpt Line No.");
        PostedGateLine.SetRange(PostedGateLine."No.", Rec."No.");
        if PostedGateLine.Find('-')then PostedGateLine."Undo Receipt":=true;
        PostedGateLine.Modify;
        Commit;
        NewPostedGateLine.Init;
        NewPostedGateLine.TransferFields(PostedGateLine);
        NewPostedGateLine."Line No.":=LastEntryN0 + 1;
        NewPostedGateLine."Challan Quantity":=-PostedGateLine."Challan Quantity";
        NewPostedGateLine."Actual Quantity":=-PostedGateLine."Actual Quantity";
        NewPostedGateLine."Outstanding Quantity":=PostedGateLine."Outstanding Quantity" + PostedGateLine."Challan Quantity";
        NewPostedGateLine."Undo Receipt":=true;
        NewPostedGateLine.Insert;
        //<<CE_AA006
        PurchRcptLine.Copy(Rec);
        CurrPage.SetSelectionFilter(PurchRcptLine);
        Codeunit.Run(Codeunit::"Undo Purchase Receipt Line", PurchRcptLine);
    end;
    procedure ShowRequisitionLinesForm()
    var
        PostedReqPurchLinesLocal: Record "SSD Posted Req. Purch. Line";
    begin
        //IND St
        PostedReqPurchLinesLocal.Reset;
        PostedReqPurchLinesLocal.SetCurrentkey("Purch. Document Type", "Purch. Document No.", "Purch. Document Line No.", "Due Date");
        PostedReqPurchLinesLocal.FilterGroup(2);
        PostedReqPurchLinesLocal.SetRange("Purch. Document Type", PostedReqPurchLinesLocal."purch. document type"::Receipt);
        PostedReqPurchLinesLocal.SetRange("Purch. Document No.", Rec."Document No.");
        PostedReqPurchLinesLocal.SetRange("Purch. Document Line No.", Rec."Line No.");
        PostedReqPurchLinesLocal.FilterGroup(0);
        if PostedReqPurchLinesLocal.Find('-')then begin
            Page.RunModal(0, PostedReqPurchLinesLocal);
        end;
    //IND En
    end;
    procedure ShowPostedQualityOrder()
    var
        QualityOrdHdrLocal: Record "SSD Posted Quality Order Hdr";
        FrmQltOrderList: Page "Posted Quality Order List";
    begin
        //CF001.01 St
        if Rec."Posted Quality Order No." <> '' then begin
            QualityOrdHdrLocal.Reset;
            QualityOrdHdrLocal.FilterGroup(2);
            QualityOrdHdrLocal.SetRange("No.", Rec."Posted Quality Order No.");
            QualityOrdHdrLocal.FilterGroup(2);
            Clear(FrmQltOrderList);
            FrmQltOrderList.SetTableview(QualityOrdHdrLocal);
            FrmQltOrderList.RunModal;
        end;
    //CF001.01 En
    end;
}
