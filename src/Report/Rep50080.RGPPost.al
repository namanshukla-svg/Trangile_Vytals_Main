Report 50080 "RGP Post"
{
    // ALLEAA CML-033 280308
    //   - Added New Function For post Transfer Order in case of Subcontracting MRN.
    // ALLE CML-033 190408
    //   - Flow External Document No. in Transfer Order from Subcontracting MRN
    //   - Flow "Responsibility Center" in Transfer Oder.
    // CML-034 ALLEAG 210408 :
    //   - Written Code to check the mandatory fields "Location code" and "Bin Code".
    // CML-034 ALLEAG 220408 :
    //   - Written code to Pass the -ive adjst against the same RGP Inbound document no.
    // ALLEAA CML-033 220408
    //   - Check Subcon MRN is already posted or not.
    //   - Flow Subcontrating Boolean in purchase receipt line.
    // ALLEAA CML-033 290408
    //   - Remove message in case of Subcon Outword
    // ALLEAA CML-033 080508
    //   - Skip No. Series Increment in case of Subcon MRN.
    // CML-034 ALLEAA 200608
    //   - Add Filters for non subcontracting RGP outbound.
    // ALLE 6.12.....57F4 Customisation
    // ALLE GI Added Code to insert data in Posted Gate Header.
    Permissions = TableData "Purch. Rcpt. Header" = rimd,
        TableData "Purch. Rcpt. Line" = rimd;
    ProcessingOnly = true;
    UseRequestPage = false;
    ApplicationArea = All;

    dataset
    {
    }
    requestpage
    {
        layout
        {
        }
        actions
        {
        }
    }
    labels
    {
    }
    var
        Selection: Integer;
        Ship: Boolean;
        Receipt: Boolean;
        Text000: label '&Ship,&Receive';
        Text001: label '&Receive,&Ship';
        Text002: label 'There is nothing to post';
        RGPLine: Record "SSD RGP Line";
        RGPLedgerEntry: Record "SSD RGP Ledger Entry";
        LastEntryNo: Integer;
        RGPAppEntry: Record "SSD RGP Application Entry";
        RGPHeader: Record "SSD RGP Header";
        LastAppEntryNo: Integer;
        RGPSetup: Record "SSD AddOn Setup";
        ShipNo: Code[20];
        RecvNo: Code[20];
        NoSeriesMgt: Codeunit "No. Series";//IG_DS NoSeriesManagement;
        RcptRemQty: Decimal;
        RGPLedgerEntry2: Record "SSD RGP Ledger Entry";
        Text004: label 'You can''t change Description because quantity already shipped.';
        AllowPostingFrom: Date;
        AllowPostingTo: Date;
        UserSetup: Record "User Setup";
        GLSetup: Record "General Ledger Setup";
        Text005: label 'is not within your range of allowed posting dates';
        ResponsibilityCenter: Record "Responsibility Center";
        ItemJournalLine: Record "Item Journal Line";
        gvlineno: Integer;
        "ItemJnl.Post1": Codeunit "Item Jnl.-Post";
        PostDocNo: Code[20];
        ItemJnlPostLine: Codeunit "Item Jnl.-Post Line";
        TempTrackingSpecificationInv: Record "Tracking Specification" temporary;
        TempHandlingSpecification: Record "Tracking Specification" temporary;
        ItemEntryRelation: Record "Item Entry Relation";
        ItemLedgShptEntryNo: Integer;
        ItemReClassJournalLine: Record "Item Journal Line";
        TransferDocNo: Code[20];
        InransitCode: Code[20];
        TransferPostShipment: Codeunit "TransferOrder-Post Shipment";
        TransferPostReceipt: Codeunit "TransferOrder-Post Receipt";
        ReleaseTransferDocument: Codeunit "Release Transfer Document";
        TransferOrderLines: Record "Transfer Line";
        CreateTransferHeader: Record "Transfer Header";
        CreateTransferLine: Record "Transfer Line";
        "ItemJnl.Post": Codeunit "Item Jnl.-Post";
        ResCen: Record "Responsibility Center";
        UserMgt: Codeunit "SSD User Setup Management";
        Text006: label 'Ship Qty can not be greater than %1';
        Text007: label 'No Item Ledger Entry found against the document no. %1';
        MessageText: Text[100];
        TrasferOrderCreated: Boolean;
        SubconRgp: Boolean;
        SubcontractingMRN: Record "SSD RGP Header";
        ShipTransferOrder: Record "Transfer Header";
        "ReceiptTransferOrderNo.": Code[20];
        ReceiptTransferOrder: Record "Transfer Header";
        RGPInboundDoc: Boolean;
        PostingConfirm: Boolean;
        GetSourceDocInbound: Codeunit "Get Source Doc. Inbound";
        RgpOutBnd: Boolean;

    procedure PostRGP(var RGPHead: Record "SSD RGP Header")
    begin
        RGPHeader.Copy(RGPHead);
        RGPHeader.TestField(Status, RGPHeader.Status::Released);
        if DateNotAllowed(RGPHeader."Posting Date") then RGPHeader.FieldError("Posting Date", Text005);
        RGPSetup.Get;
        case RGPHeader."Document Type" of
            RGPHeader."document type"::"RGP Outbound":
                begin
                    if RGPHeader.NRGP then begin
                        if Confirm('Do you want to Ship the NRGP') then begin
                            Ship := true;
                            Receipt := false;
                            PostRGPOutbound();
                        end
                        else
                            exit;
                    end
                    else begin
                        if not (RGPHeader."Batch Receipt") then //ALLEAA SUBCONMRN 310308
                            Selection := StrMenu(Text000, 1)
                        else
                            Selection := 2; //ALLEAA SUBCONMRN 310308
                        if Selection = 0 then exit;
                        Ship := Selection in [1, 1];
                        Receipt := Selection in [2, 2];
                        PostRGPOutbound();
                    end;
                end;
            RGPHeader."document type"::"RGP Inbound":
                begin
                    //ALLEAA SUBCONMRN 310308 Start >>
                    if RGPHeader.NRGP then begin
                        //ALLEAA CML-033 230408 Start >>
                        //ALLEAA CML-033 290408 Start >>
                        if RGPHeader.Subcontracting then PostingConfirm := true;
                        if not RGPHeader.Subcontracting then if Confirm('Do you want to Receive the NRGP.') then PostingConfirm := true;
                        if PostingConfirm then begin
                            Ship := false;
                            Receipt := true;
                            PostRGPInbound();
                        end
                        else
                            exit;
                    end
                    else begin
                        //ALLEAA SUBCONMRN 310308 End <<
                        Selection := StrMenu(Text001, 1);
                        if Selection = 0 then exit;
                        Ship := Selection in [2, 2];
                        Receipt := Selection in [1, 1];
                        PostRGPInbound();
                    end;
                end;
        end;
        //COMMIT;
    end;

    procedure PostRGPOutbound()
    begin
        if Ship then begin
            CheckRGPOutShipment();
            PostRGPOutShipment();
            UpdateHeaderForShipment(); //devinder
        end;
        if Receipt then begin
            CheckRGPOutReceipt();
            PostRGPOutReceipt();
        end;
    end;

    procedure PostRGPInbound()
    var
        PostedGateHeader: Record "SSD Posted Gate Header";
    begin
        if Ship then begin
            CheckRGPInShipment();
            PostRGPInShipment();
            //  UpdateHeaderForShipment();//devinder
        end;
        if Receipt then begin
            CheckRGPInReceipt();
            PostRGPInReceipt();
            //ankit 1.0
            PostRGPReceiptLineDetail(RGPHeader);
            if RGPHeader.Subcontracting then //ALLEAA SUBCONMRN 020408
                UpdateRGPHeader(RGPHeader); //ALLEAA SUBCONMRN 020408
        end;
    end;

    procedure CheckRGPOutShipment()
    begin
        //CF001 St
        if RGPHeader."Posted Shipment No." <> '' then begin
            if RGPHeader."Responsibility Center" <> '' then begin
                ResponsibilityCenter.Get(RGPHeader."Responsibility Center");
                ResponsibilityCenter.TestField("Posted RGP IN Shipment Nos");
                ResponsibilityCenter.TestField("Job Work Location");
            end
            else
                RGPSetup.TestField("Posted RGP Shipment Nos");
        end;
        //CF001 En
        RGPHeader.TestField("Posting Date");
        RGPHeader.TestField("Party No.");
        RGPLine.SetRange("Document Type", RGPHeader."Document Type");
        RGPLine.SetRange("Document No.", RGPHeader."No.");
        RGPLine.SetFilter("Quantity to Ship", '<>%1', 0);
        if RGPLine.Find('-') then begin
            repeat
                RGPLine.TestField(Quantity);
                RGPLine.TestField("Unit Of Measure Code");
                RGPLine.TestField("Write Off", false);
                RGPLine.TestField("Qty. to Write Off", 0);
                if not RGPLine.NRGP then begin
                    RGPLine.TestField("Expected Receipt Date");
                    //Alle VPB Temporary Commented     IF RGPLine."Expected Receipt Date" < TODAY THEN
                    //Alle VPB Temporary Commented       RGPLine.FIELDERROR("Expected Receipt Date")
                end;
            until RGPLine.Next = 0;
        end
        else
            Error(Text002);
    end;

    procedure PostRGPOutShipment()
    var
        RGPShipmentHeader: Record "SSD RGP Shipment Header";
        RGPShipmentLine: Record "SSD RGP Shipment Line";
    begin
        if RGPHeader."Posted Shipment No." <> '' then
            ShipNo := RGPHeader."Posted Shipment No."
        else begin
            //IG_DS_Before NoSeriesMgt.InitSeries(RGPHeader."Posted Shpmt. No Series", RGPHeader."Posted Shpmt. No Series", RGPHeader."Posting Date", ShipNo, RGPHeader."Posted Shpmt. No Series");
            // if NoSeriesMgt.AreRelated(RGPHeader."Posted Shpmt. No Series", RGPHeader."Posted Shpmt. No Series") then
            //   RGPHeader."Posted Shpmt. No Series" := RGPHeader."Posted Shpmt. No Series";
            //  ShipNo := NoSeriesMgt.GetNextNo(RGPHeader."Posted Shpmt. No Series", RGPHeader."Posting Date");
            RGPHeader.TestField("Posted Shpmt. No Series");
            RGPHeader."No. Series" := RGPHeader."Posted Shpmt. No Series";
            ShipNo := NoSeriesMgt.GetNextNo(RGPHeader."No. Series", RGPHeader."Posting Date");
        end;
        if ShipNo = '' then //IG_DS
            Error('Unable to generate Posted Shipment No.');
        RGPShipmentHeader.Init;
        RGPShipmentHeader.TransferFields(RGPHeader);
        RGPShipmentHeader."No." := ShipNo;
        RGPShipmentHeader."User ID" := UserId;
        RGPShipmentHeader."Pre-Assigned No." := RGPHeader."No.";
        //IG_DS RGPShipmentHeader."Gate Out" := RGPHeader."Gate Out";
        RGPShipmentHeader.Insert;
        RGPLedgerEntry.LockTable;
        if RGPLedgerEntry.Find('+') then
            LastEntryNo := RGPLedgerEntry."Entry No."
        else
            LastEntryNo := 0;
        RGPAppEntry.LockTable;
        if RGPAppEntry.Find('+') then
            LastAppEntryNo := RGPAppEntry."Entry No."
        else
            LastAppEntryNo := 0;
        RGPLine.Reset;
        RGPLine.SetRange("Document No.", RGPHeader."No.");
        RGPLine.SetFilter(RGPLine."Quantity to Ship", '>%1', 0); //CMLTEST-026 AA 180208
        if RGPLine.Find('-') then begin
            repeat
                RGPShipmentLine.Init;
                RGPShipmentLine.TransferFields(RGPLine);
                RGPShipmentLine."Document No." := ShipNo;
                RGPShipmentLine."User ID" := UserId;
                RGPShipmentLine."Pre-Assigned No." := RGPLine."Document No.";
                RGPShipmentLine."Pre-Assigned Line No." := RGPLine."Line No.";
                RGPShipmentLine.Insert;
                InsertRGPLedgEntry();
                InsertRGPAppEntry();
                if RGPLine.Type = RGPLine.Type::Item then insertjnlline(); //ashish
                UpdateRGPLines(true);
            until RGPLine.Next = 0;
        end;
    end;

    procedure UpdateRGPLines(ShiporReceive: Boolean)
    begin
        if Ship then begin
            RGPLine."Quantity Shipped" := RGPLine."Quantity Shipped" + RGPLine."Quantity to Ship";
            RGPLine."Outstanding Ship Quantity" := RGPLine.Quantity - RGPLine."Quantity Shipped";
            RGPLine."Quantity to Ship" := 0;
            RGPLine."Shortcut Dimension 1 Code" := RGPHeader."Shortcut Dimension 1 Code";
            RGPLine."Shortcut Dimension 2 Code" := RGPHeader."Shortcut Dimension 2 Code";
            if RGPLine.NRGP then
                RGPLine."Outstanding Rcpt. Quantity" := 0
            else begin
                RGPLine."Outstanding Rcpt. Quantity" := RGPLine."Quantity Shipped" - RGPLine."Quantity Received" - RGPLine."Quantity Write Off";
            end;
        end;
        if Receipt then begin
            RGPLine."Quantity Received" := RGPLine."Quantity Received" + RGPLine."Quantity to Receive";
            RGPLine."Outstanding Rcpt. Quantity" := RGPLine.Quantity - RGPLine."Quantity Received" - RGPLine."Quantity Write Off";
            RGPLine."Quantity to Receive" := 0;
        end;
        RGPLine.Modify;
    end;

    procedure PostRGPOutReceipt()
    var
        RGPRcptHeader: Record "SSD RGP Receipt Header";
        RGPRcptLine: Record "SSD RGP Receipt Line";
    begin
        if RGPHeader."Posted Receipt No." <> '' then
            RecvNo := RGPHeader."Posted Receipt No."
        else begin
            //IG_DS_Before  NoSeriesMgt.InitSeries(RGPHeader."Posted Rect. No Series", RGPHeader."Posted Rect. No Series", RGPHeader."Posting Date", RecvNo, RGPHeader."Posted Rect. No Series");
            // if NoSeriesMgt.AreRelated(RGPHeader."Posted Rect. No Series", RGPHeader."Posted Rect. No Series") then
            //   RGPHeader."Posted Rect. No Series" := RGPHeader."Posted Rect. No Series";
            //  RecvNo := NoSeriesMgt.GetNextNo(RGPHeader."Posted Rect. No Series", RGPHeader."Posting Date");
            RGPHeader.TestField("Posted Rect. No Series");
            RGPHeader."No. Series" := RGPHeader."Posted Rect. No Series";
            RecvNo := NoSeriesMgt.GetNextNo(RGPHeader."No. Series", RGPHeader."Posting Date");
        end;
        if RecvNo = '' then //IG_DS
            Error('Unable to generate Posted Receipt No.');
        RGPRcptHeader.Init;
        RGPRcptHeader.TransferFields(RGPHeader);
        RGPRcptHeader."No." := RecvNo;
        RGPRcptHeader."User ID" := UserId;
        RGPRcptHeader."Pre-Assigned No." := RGPHeader."No.";
        RGPRcptHeader.Remarks := RGPHeader."Receipt Remarks";
        RGPRcptHeader.Insert;
        RGPLedgerEntry.LockTable;
        if RGPLedgerEntry.Find('+') then
            LastEntryNo := RGPLedgerEntry."Entry No."
        else
            LastEntryNo := 0;
        RGPAppEntry.LockTable;
        if RGPAppEntry.Find('+') then
            LastAppEntryNo := RGPAppEntry."Entry No."
        else
            LastAppEntryNo := 0;
        RGPLine.Reset;
        RGPLine.SetRange("Document No.", RGPHeader."No.");
        RGPLine.SetFilter(RGPLine."Quantity to Receive", '>%1', 0); //CMLTEST-026 AA 180208
        if RGPLine.Find('-') then begin
            repeat
                RGPRcptLine.Init;
                RGPRcptLine.TransferFields(RGPLine);
                RGPRcptLine."Document No." := RecvNo;
                RGPRcptLine."User ID" := UserId;
                RGPRcptLine."Pre-Assigned No." := RGPLine."Document No.";
                RGPRcptLine."Pre-Assigned Line No." := RGPLine."Line No.";
                RGPRcptLine.Insert;
                InsertRGPLedgEntry();
                UpdateLedgerEntries();
                if RGPLine.Type = RGPLine.Type::Item then insertjnlline(); //ashish
                UpdateRGPLines(true);
            until RGPLine.Next = 0;
        end;
    end;

    procedure CheckRGPOutReceipt()
    begin
        //CF001 St
        if RGPHeader."Posted Receipt No." <> '' then begin
            if RGPHeader."Responsibility Center" <> '' then begin
                ResponsibilityCenter.Get(RGPHeader."Responsibility Center");
                ResponsibilityCenter.TestField("Posted RGP IN Receipt Nos");
            end
            else
                RGPSetup.TestField("Posted RGP Receipt Nos");
        end;
        //CF001 En
        RGPHeader.TestField(RGPHeader."Posting Date");
        RGPHeader.TestField(RGPHeader."Party No.");
        RGPLine.SetRange("Document Type", RGPHeader."Document Type");
        RGPLine.SetRange("Document No.", RGPHeader."No.");
        RGPLine.SetFilter("Quantity to Receive", '<>%1', 0);
        if RGPLine.Find('-') then begin
            repeat
                RGPLine.TestField(RGPLine.Quantity);
                RGPLine.TestField(RGPLine."Unit Of Measure Code");
                RGPLine.TestField(RGPLine."Write Off", false);
                RGPLine.TestField(RGPLine."Qty. to Write Off", 0);
            until RGPLine.Next = 0;
        end
        else
            Error(Text002);
    end;

    procedure InsertRGPLedgEntry()
    begin
        LastEntryNo += 1;
        RGPLedgerEntry.Init;
        RGPLedgerEntry."Entry No." := LastEntryNo;
        RGPLedgerEntry."Posting Date" := RGPHeader."Posting Date";
        RGPLedgerEntry."Document Type" := RGPLine."Document Type";
        RGPLedgerEntry."Document SubType" := RGPHeader."Document SubType"; //Alle 6.12
        if Ship then begin
            RGPLedgerEntry."Document No." := ShipNo;
            RGPLedgerEntry.Remarks := RGPHeader."Ship Remarks";
        end;
        if Receipt then begin
            RGPLedgerEntry."Document No." := RecvNo;
            RGPLedgerEntry.Remarks := RGPHeader."Receipt Remarks";
        end;
        RGPLedgerEntry."RGP Document No." := RGPLine."Document No.";
        RGPLedgerEntry."RGP Line No." := RGPLine."Line No.";
        RGPLedgerEntry.Type := RGPLine.Type;
        RGPLedgerEntry."No." := RGPLine."No.";
        RGPLedgerEntry.NRGP := RGPLine.NRGP;
        RGPLedgerEntry."MRR No." := RGPLine."MRR No.";
        RGPLedgerEntry.Description := RGPLine.Description;
        if Ship then begin
            if RGPLine.NRGP then begin
                RGPLedgerEntry.Quantity := -RGPLine."Quantity to Ship";
                RGPLedgerEntry."Remaining Quantity" := 0;
                RGPLedgerEntry.Open := false;
            end
            else begin
                RGPLedgerEntry.Quantity := -RGPLine."Quantity to Ship";
                RGPLedgerEntry."Remaining Quantity" := -RGPLine."Quantity to Ship";
                RGPLedgerEntry.Open := true;
            end;
            RGPLedgerEntry."Responsibility Center" := RGPHeader."Responsibility Center";
        end;
        if Receipt then begin
            RGPLedgerEntry.Quantity := RGPLine."Quantity to Receive";
            RcptRemQty := RGPLine."Quantity to Receive";
            RGPLedgerEntry."Remaining Quantity" := 0;
            RGPLedgerEntry.Open := false;
        end;
        RGPLedgerEntry."External Document No." := RGPHeader."External Document No.";
        RGPLedgerEntry."Item Category Code" := RGPLine."Item Category Code";
        RGPLedgerEntry."Product Group Code" := RGPLine."Product Group Code";
        RGPLedgerEntry."Global Dimension 1 Code" := RGPHeader."Shortcut Dimension 1 Code";
        RGPLedgerEntry."Global Dimension 2 Code" := RGPHeader."Shortcut Dimension 2 Code";
        if Ship then
            RGPLedgerEntry."No. Series" := RGPHeader."Posted Shpmt. No Series"
        else if Receipt then RGPLedgerEntry."No. Series" := RGPHeader."Posted Rect. No Series";
        RGPLedgerEntry."User ID" := UserId;
        RGPLedgerEntry.Insert;
    end;

    procedure InsertRGPAppEntry()
    begin
        LastAppEntryNo += 1;
        RGPAppEntry.Init;
        RGPAppEntry."Entry No." := LastAppEntryNo;
        RGPAppEntry."RGP Entry No." := RGPLedgerEntry."Entry No.";
        if RGPHeader."Document Type" = RGPHeader."document type"::"RGP Outbound" then begin
            if Ship then begin
                RGPAppEntry."Inbound RGP Entry No." := RGPLedgerEntry."Entry No.";
                RGPAppEntry.Quantity := RGPLedgerEntry.Quantity;
            end
            else if Receipt then begin
                RGPAppEntry."Inbound RGP Entry No." := RGPLedgerEntry2."Entry No.";
                RGPAppEntry.Quantity := RGPLedgerEntry.Quantity;
            end;
        end;
        RGPAppEntry.Insert;
    end;

    procedure UpdateLedgerEntries()
    var
        AppQty: Decimal;
    begin
        RGPLedgerEntry2.SetCurrentkey("Document Type", "RGP Document No.", "RGP Line No.");
        RGPLedgerEntry2.SetRange("Document Type", RGPLine."Document Type");
        RGPLedgerEntry2.SetRange("RGP Document No.", RGPLine."Document No.");
        RGPLedgerEntry2.SetRange("RGP Line No.", RGPLine."Line No.");
        RGPLedgerEntry2.SetRange("No.", RGPLedgerEntry."No.");
        RGPLedgerEntry2.SetFilter(Open, '=%1', true);
        RGPLedgerEntry2.Find('-');
        repeat
            LastAppEntryNo += 1;
            RGPAppEntry.Init;
            RGPAppEntry."Entry No." := LastAppEntryNo;
            RGPAppEntry."RGP Entry No." := RGPLedgerEntry."Entry No.";
            if RcptRemQty > -RGPLedgerEntry2."Remaining Quantity" then begin
                RcptRemQty := RcptRemQty + RGPLedgerEntry2."Remaining Quantity";
                if RGPLedgerEntry2."Remaining Quantity" = 0 then //5.51
                    RcptRemQty := 0; //5,51
                AppQty := RGPLedgerEntry2."Remaining Quantity";
                RGPLedgerEntry2."Remaining Quantity" := 0;
            end
            else begin
                RGPLedgerEntry2."Remaining Quantity" := RGPLedgerEntry2."Remaining Quantity" + RcptRemQty;
                AppQty := -RcptRemQty;
                RcptRemQty := 0;
            end;
            if RGPLedgerEntry2."Remaining Quantity" = 0 then
                RGPLedgerEntry2.Open := false
            else
                RGPLedgerEntry2.Open := true;
            RGPLedgerEntry2.Modify;
            RGPAppEntry."Inbound RGP Entry No." := RGPLedgerEntry2."Entry No.";
            RGPAppEntry.Quantity := AppQty;
            RGPAppEntry.Insert;
            RGPLedgerEntry2.Next;
        until RcptRemQty = 0;
    end;

    procedure UpdateHeaderForShipment()
    begin
        RGPHeader.Shipped := true;
        RGPHeader.Modify;
    end;

    procedure DateNotAllowed(PostingDate: Date): Boolean
    begin
        if (AllowPostingFrom = 0D) and (AllowPostingTo = 0D) then begin
            if UserId <> '' then
                if UserSetup.Get(UserId) then begin
                    AllowPostingFrom := UserSetup."Allow Posting From";
                    AllowPostingTo := UserSetup."Allow Posting To";
                end;
            if (AllowPostingFrom = 0D) and (AllowPostingTo = 0D) then begin
                GLSetup.Get;
                AllowPostingFrom := GLSetup."Allow Posting From";
                AllowPostingTo := GLSetup."Allow Posting To";
            end;
            if AllowPostingTo = 0D then AllowPostingTo := 99991231D;
        end;
        exit((PostingDate < AllowPostingFrom) or (PostingDate > AllowPostingTo));
    end;

    procedure "//ashish for ile"()
    begin
    end;

    procedure "//ash"()
    begin
    end;

    procedure ILEPOST()
    begin
    end;

    procedure insertjnlline()
    var
        ILE: Record "Item Ledger Entry";
        DimMgt: Codeunit DimensionManagement;
        ItemJnlPostLineC: Codeunit "Item Jnl.-Post Line";
        OriginalQuantity: Decimal;
        OriginalQuantityBase: Decimal;
        Item: Record Item;
    begin
        //<<< ALLE[551]
        ItemJournalLine.Reset;
        ItemJournalLine.SetRange(ItemJournalLine."Journal Template Name", 'ITEM');
        ItemJournalLine.SetRange(ItemJournalLine."Journal Batch Name", 'JOBWORK');
        ItemJournalLine.SetRange(ItemJournalLine."Document No.", RGPLine."Document No.");
        ItemJournalLine.SetRange(ItemJournalLine."Item No.", RGPLine."No.");
        if not ItemJournalLine.FindFirst then begin
            //>>> ALLE[551]
            //CML-034 ALLEAG 250408 Start
            RGPInboundDoc := false;
            if (RGPLine."Document Type" = RGPLine."document type"::"RGP Inbound") and (not RGPLine.Subcontracting) then RGPInboundDoc := true;
            //CML-034 ALLEAG 250408 Start
            //CML-034 ALLEAA 200608 Start
            RgpOutBnd := false;
            if (RGPLine."Document Type" = RGPLine."document type"::"RGP Outbound") and (not RGPLine.Subcontracting) then RgpOutBnd := true;
            //CML-034 ALLEAA 200608 Finish
            //ashish
            ItemJournalLine.Reset;
            ItemJournalLine.SetRange(ItemJournalLine."Journal Template Name", 'ITEM');
            ItemJournalLine.SetRange(ItemJournalLine."Journal Batch Name", 'JOBWORK');
            if ItemJournalLine.Find('+') then gvlineno := ItemJournalLine."Line No.";
            gvlineno := gvlineno + 10000;
            ItemJournalLine.Init;
            ItemJournalLine."Journal Template Name" := 'ITEM';
            ItemJournalLine."Journal Batch Name" := 'JOBWORK';
            ItemJournalLine."Line No." := gvlineno;
            ItemJournalLine."Item No." := RGPLine."No.";
            ItemJournalLine.Validate(ItemJournalLine."Item No.");
            ItemJournalLine.Validate("Unit of Measure Code", RGPLine."Unit Of Measure Code");
            ItemJournalLine."Posting Date" := RGPHeader."Posting Date";
            ItemJournalLine."Document No." := RGPLine."Document No.";
            ItemJournalLine."External Document No." := RGPHeader."External Document No.";
            ItemJournalLine."Responsibility Center" := RGPLine."Responsibility Center";
            ItemJournalLine.Validate("Shortcut Dimension 1 Code", RGPLine."Shortcut Dimension 1 Code"); //neeraj
            ItemJournalLine."Shortcut Dimension 2 Code" := RGPLine."Shortcut Dimension 2 Code"; //neeraj
            ItemJournalLine."Bin Code" := RGPLine."Bin Code"; //Ankit CEN003
            ItemJournalLine."Source Code" := 'ITEMJNL';
            ItemJournalLine."Location Code" := RGPLine."Location Code";
            ItemJournalLine."SUBCON Consumption" := RGPHeader.Subcontracting; //ALLEAA CML-033 220408
            ItemJournalLine.Validate(ItemJournalLine."Location Code");
            ItemJournalLine."Source No." := RGPHeader."Party No."; //CML-034
            if Ship then begin
                ItemJournalLine."Entry Type" := ItemJournalLine."entry type"::"Negative Adjmt.";
                if RGPLine."Quantity to Ship" > 0 then ItemJournalLine.Quantity := RGPLine."Quantity to Ship";
                if Item.Get(RGPLine."No.") then ItemJournalLine.Validate("Gen. Prod. Posting Group", Item."Gen. Prod. Posting Group");
                //CML-034 ALLEAG 220408 Start
                if not RgpOutBnd then begin //CML-034 ALLEAA 200608
                    ILE.Reset;
                    ILE.SetRange(ILE."Document No.", ItemJournalLine."Document No.");
                    ILE.SetRange(ILE."Entry Type", ILE."entry type"::"Positive Adjmt.");
                    ILE.SetRange(ILE."Item No.", ItemJournalLine."Item No.");
                    ILE.SetRange(ILE."Location Code", ItemJournalLine."Location Code");
                    ILE.SetRange(ILE."Bin Code", ItemJournalLine."Bin Code");
                    if ILE.FindFirst then begin
                        if ILE."Remaining Quantity" >= ItemJournalLine.Quantity then
                            ItemJournalLine."Applies-to Entry" := ILE."Entry No."
                        else
                            Error(Text006, ILE."Remaining Quantity");
                    end
                    else
                        Error(Text007, ItemJournalLine."Document No.");
                end;
                //CML-034 ALLEAG 220408 End
                //>>VPB Alle
                if RGPLine."Document SubType" = RGPLine."document subtype"::"57F4" then begin
                    ResponsibilityCenter.Get(RGPLine."Responsibility Center");
                    ItemJournalLine."Entry Type" := ItemJournalLine."entry type"::Transfer;
                    ItemJournalLine."New Location Code" := ResponsibilityCenter."Job Work Location";
                    ItemJournalLine.Validate("New Shortcut Dimension 1 Code", RGPLine."Shortcut Dimension 1 Code");
                end;
                //<<VPb Alle
                //>>Alle VPB 27-Aug-10 Add Start
                if RGPHeader."Inter Unit Transfer" then begin
                    ItemJournalLine."Entry Type" := ItemJournalLine."entry type"::Transfer;
                    ItemJournalLine."New Location Code" := RGPHeader."Inter Unit Transfer Location";
                end;
                //<<Alle VPB 27-Aug-10 Add Stop
            end;
            if Receipt then begin
                ItemJournalLine."Entry Type" := ItemJournalLine."entry type"::"Positive Adjmt.";
                if RGPLine."Quantity to Receive" > 0 then ItemJournalLine.Quantity := RGPLine."Quantity to Receive";
                //>>VPB Alle
                if RGPLine."Document SubType" = RGPLine."document subtype"::"57F4" then begin
                    ResponsibilityCenter.Get(RGPLine."Responsibility Center");
                    ItemJournalLine."Location Code" := ResponsibilityCenter."Job Work Location";
                    ItemJournalLine."Entry Type" := ItemJournalLine."entry type"::Transfer;
                    ItemJournalLine."New Location Code" := RGPLine."Location Code";
                    ItemJournalLine."New Bin Code" := RGPLine."Bin Code";
                    ItemJournalLine.Validate("New Shortcut Dimension 1 Code", RGPLine."Shortcut Dimension 1 Code");
                end;
                //<<VPb Alle
                //>>Alle VPB 27-Aug-10 Add Start
                if RGPHeader."Inter Unit Transfer" then begin
                    ItemJournalLine."Location Code" := RGPHeader."Inter Unit Transfer Location";
                    ItemJournalLine."Entry Type" := ItemJournalLine."entry type"::Transfer;
                    ItemJournalLine."New Location Code" := RGPLine."Location Code";
                    ItemJournalLine."New Bin Code" := RGPLine."Bin Code";
                    ItemJournalLine.Validate("New Shortcut Dimension 1 Code", RGPLine."Shortcut Dimension 1 Code");
                end;
                //<<Alle VPB 27-Aug-10 Add Stop
            end;
            ItemJournalLine.Validate(ItemJournalLine.Quantity);
            if RGPLine.Subcontracting then begin
                ItemJournalLine.Validate(Amount, RGPLine.Amount);
                ItemJournalLine."Unit Cost" := RGPLine."Unit Cost";
            end;
            ItemJournalLine.Validate("Shortcut Dimension 1 Code", RGPLine."Shortcut Dimension 1 Code"); //neeraj
            if Item.Get(RGPLine."No.") then ItemJournalLine.Validate("Gen. Prod. Posting Group", Item."Gen. Prod. Posting Group");
            ItemJournalLine.Insert;
        end;
        //**************** ALLE[551] code should run after this line..
        //>>Alle VPB
        /* // BIS 1145
        GLSetup.GET;
        ItemJournalLine.VALIDATE("Item No."); //To fetch Item Default Dimensions
        IF RGPHeader."Shortcut Dimension 1 Code" <> '' THEN BEGIN
          ItemJournalLine.VALIDATE("Shortcut Dimension 1 Code", RGPHeader."Shortcut Dimension 1 Code");
          JnlLineDim."Table ID" := 83;
          JnlLineDim."Journal Template Name" := ItemJournalLine."Journal Template Name";
          JnlLineDim."Journal Batch Name"    := ItemJournalLine."Journal Batch Name";
          JnlLineDim."Journal Line No."      := ItemJournalLine."Line No.";
          JnlLineDim.VALIDATE("Dimension Code", GLSetup."Global Dimension 1 Code");
          JnlLineDim.VALIDATE("Dimension Value Code", RGPHeader."Shortcut Dimension 1 Code");
          JnlLineDim.VALIDATE("New Dimension Value Code", RGPHeader."Shortcut Dimension 1 Code");
          IF NOT JnlLineDim.INSERT THEN
            JnlLineDim.MODIFY;
        END;
        IF RGPHeader."Shortcut Dimension 2 Code" <> '' THEN BEGIN
          ItemJournalLine.VALIDATE("Shortcut Dimension 2 Code", RGPHeader."Shortcut Dimension 2 Code");
          JnlLineDim."Table ID" := 83;
          JnlLineDim."Journal Template Name" := ItemJournalLine."Journal Template Name";
          JnlLineDim."Journal Batch Name"    := ItemJournalLine."Journal Batch Name";
          JnlLineDim."Journal Line No."      := ItemJournalLine."Line No.";
          JnlLineDim.VALIDATE("Dimension Code", GLSetup."Global Dimension 2 Code");
          JnlLineDim.VALIDATE("Dimension Value Code", RGPHeader."Shortcut Dimension 2 Code");
          JnlLineDim.VALIDATE("New Dimension Value Code", RGPHeader."Shortcut Dimension 2 Code");
          IF NOT JnlLineDim.INSERT THEN
            JnlLineDim.MODIFY;
        END;
        //ItemJournalLine.MODIFY;
        
        //<<Alle VPB
        JnlLineDim.RESET;
        JnlLineDim.SETRANGE("Table ID",DATABASE::"Item Journal Line");
        JnlLineDim.SETRANGE("Journal Template Name",ItemJournalLine."Journal Template Name");
        JnlLineDim.SETRANGE("Journal Batch Name",ItemJournalLine."Journal Batch Name");
        JnlLineDim.SETRANGE("Journal Line No.",ItemJournalLine."Line No.");
        JnlLineDim.SETRANGE("Allocation Line No.",0);
        TempJnlLineDim.DELETEALL;
        DimMgt.CopyJnlLineDimToJnlLineDim(JnlLineDim,TempJnlLineDim);
        */
        // BIS 1145
        //<<Alle VPB
        if (not SubconRgp) and (not RGPInboundDoc) then //ALLEAA CML-033 250408
 begin
            ItemJournalLine.SetFilter(ItemJournalLine."Document No.", '%1', RGPLine."Document No.");
            //"ItemJnl.Post".RUN(ItemJournalLine);
            //ItemJnlPostLineC.RunWithCheck(ItemJournalLine, TempJnlLineDim);
            OriginalQuantity := ItemJournalLine.Quantity;
            OriginalQuantityBase := ItemJournalLine."Quantity (Base)";
            ItemJnlPostLine.RunWithCheck(ItemJournalLine);
            //SSDU Start
            // if not ItemJnlPostLine.GetPostItemJnlLine then
            //     ItemJnlPostLine.CheckItemTracking;
            //SSDU End
            if ItemJournalLine."Value Entry Type" <> ItemJournalLine."value entry type"::Revaluation then begin
                ItemJnlPostLine.CollectTrackingSpecification(TempHandlingSpecification);
                PostWhseJnlLine(ItemJournalLine, OriginalQuantity, OriginalQuantityBase, TempHandlingSpecification);
            end;
            ItemJournalLine.Delete(true);
        end;
    end;

    procedure PostNRGPInbound()
    begin
    end;

    procedure "//inbound"()
    begin
    end;

    procedure CheckRGPInReceipt()
    begin
        if RGPHeader."Posted Receipt No." <> '' then begin
            if RGPHeader."Responsibility Center" <> '' then begin
                ResponsibilityCenter.Get(RGPHeader."Responsibility Center");
                ResponsibilityCenter.TestField("Posted RGP IN Receipt Nos");
            end
            else
                RGPSetup.TestField("Posted RGP Receipt Nos");
        end;
        RGPHeader.TestField(RGPHeader."Posting Date");
        RGPHeader.TestField(RGPHeader."Party No.");
        RGPLine.SetRange("Document Type", RGPHeader."Document Type");
        RGPLine.SetRange("Document No.", RGPHeader."No.");
        //RGPLine.SETFILTER("Quantity to Receive", '<>%1', 0);//ssd
        if RGPLine.Find('-') then begin
            repeat
                RGPLine.TestField(RGPLine.Quantity);
                RGPLine.TestField(RGPLine."Unit Of Measure Code");
                RGPLine.TestField(RGPLine."Write Off", false);
                RGPLine.TestField(RGPLine."Qty. to Write Off", 0);
                //CML-034 ALLEAG 210408
                RGPLine.TestField(RGPLine."Location Code");
            //if RGPLine.Type = RGPLine.Type::Item then
            //   RGPLine.TestField(RGPLine."Bin Code");
            //CML-034 ALLEAG 210408
            until RGPLine.Next = 0;
        end
        else
            Error(Text002);
    end;

    procedure PostRGPInReceipt()
    var
        RGPRcptHeader: Record "SSD RGP Receipt Header";
        RGPRcptLine: Record "SSD RGP Receipt Line";
    begin
        if RGPHeader."Posted Receipt No." <> '' then
            RecvNo := RGPHeader."Posted Receipt No."
        else begin
            if not RGPHeader.Subcontracting then begin //ALLEAA CML-033 080508
                                                       //ELSE BEGIN //ALLEAA CML-033 080508
                                                       //IG_DS_Before    NoSeriesMgt.InitSeries(RGPHeader."Posted Rect. No Series", RGPHeader."Posted Rect. No Series", RGPHeader."Posting Date", RecvNo, RGPHeader."Posted Rect. No Series");
                                                       //  if NoSeriesMgt.AreRelated(RGPHeader."Posted Rect. No Series", RGPHeader."Posted Rect. No Series") then
                                                       //   RGPHeader."Posted Rect. No Series" := RGPHeader."Posted Rect. No Series";
                                                       //   RecvNo := NoSeriesMgt.GetNextNo(RGPHeader."Posted Rect. No Series", RGPHeader."Posting Date");
                RGPHeader.TestField("Posted Rect. No Series");
                RGPHeader."No. Series" := RGPHeader."Posted Rect. No Series";
                RecvNo := NoSeriesMgt.GetNextNo(RGPHeader."No. Series", RGPHeader."Posting Date");
            end;
        end;
        if RecvNo = '' then //IG_DS
            Error('Unable to generate Posted Receipt No.');
        RGPRcptHeader.Init;
        RGPRcptHeader.TransferFields(RGPHeader);
        //ALLEAA CML-033 080508 Start >>
        if not RGPHeader.Subcontracting then
            RGPRcptHeader."No." := RecvNo
        else
            RGPRcptHeader."No." := RGPHeader."No.";
        //RGPRcptHeader."No." := RecvNo
        //ALLEAA CML-033 080508 End <<
        RGPRcptHeader."User ID" := UserId;
        RGPRcptHeader."Pre-Assigned No." := RGPHeader."No.";
        RGPRcptHeader.Remarks := RGPHeader."Receipt Remarks";
        //IG_DS RGPRcptHeader."Gate IN IG" := RGPHeader."Gate IN IG";
        if RGPLine.Subcontracting = true then //ALLEAA SUBCONMRN 020408
            CreatePurchRcptHeader(RGPHeader, RGPHeader."No."); //ALLEAA SUBCONMRN 020408
        RGPRcptHeader.Insert;
        RGPLedgerEntry.LockTable;
        if RGPLedgerEntry.Find('+') then
            LastEntryNo := RGPLedgerEntry."Entry No."
        else
            LastEntryNo := 0;
        RGPAppEntry.LockTable;
        if RGPAppEntry.Find('+') then
            LastAppEntryNo := RGPAppEntry."Entry No."
        else
            LastAppEntryNo := 0;
        RGPLine.Reset;
        RGPLine.SetRange("Document No.", RGPHeader."No.");
        RGPLine.SetFilter(RGPLine."Quantity to Receive", '>%1', 0); //CMLTEST-026 AA 180208
        if RGPLine.Find('-') then begin
            repeat
                RGPRcptLine.Init;
                RGPRcptLine.TransferFields(RGPLine);
                //ALLEAA CML-033 080508 Start >>
                if not RGPHeader.Subcontracting then
                    RGPRcptLine."Document No." := RecvNo
                else
                    RGPRcptLine."Document No." := RGPHeader."No.";
                //RGPRcptLine."document No." := RecvNo
                //ALLEAA CML-033 080508 End <<
                RGPRcptLine."User ID" := UserId;
                RGPRcptLine."Pre-Assigned No." := RGPLine."Document No.";
                RGPRcptLine."Pre-Assigned Line No." := RGPLine."Line No.";
                RGPRcptLine.Insert;
                InsertRGPLedgEntry();
                //**********CEN006**********
                PostDocNo := RecvNo;
                //**********CEN006**********
                //UpdateLedgerEntries();
                if RGPLine.Subcontracting = true then begin
                    if not TrasferOrderCreated then CreateAndPostReclassJnl(RGPLine, RGPHeader); //ALLEAA CML-033 280308
                    CreatePurchRcptLine(RGPLine, RGPLine."Document No."); //Subcontracting
                    InitDocumentDimension(RGPLine);
                    RGPLine.Completed := true;
                    RGPLine.Modify;
                end;
                if RGPLine.Subcontracting then //ALLEAA CML-033 250408
                    SubconRgp := true; //ALLEAA CML-033 250408
                if RGPLine.Type = RGPLine.Type::Item then insertjnlline(); //ashish
                //IF RGPLine.Subcontracting THEN  //ALLEAA CML-033 280308
                //  PostTrasferOrder;             //ALLEAA CML-033 280308
                UpdateRGPLines(true);
            until RGPLine.Next = 0;
            if SubconRgp then //ALLEAA CML-033 250408
                "ItemJnl.Post".Run(ItemJournalLine);
            if RGPInboundDoc then begin
                ItemJournalLine.SetRange("Journal Template Name", '%1', 'ITEM'); //SSD
                ItemJournalLine.SetRange("Journal Batch Name", 'JOBWORK'); //SSD
                "ItemJnl.Post".Run(ItemJournalLine);
            end;
            if RGPLine.Subcontracting then //ALLEAA CML-033 280308
                PostTrasferOrder; //ALLEAA CML-033 280308
        end;
    end;

    procedure CheckRGPInShipment()
    begin
        if RGPHeader."Posted Shipment No." <> '' then begin
            if RGPHeader."Responsibility Center" <> '' then begin
                ResponsibilityCenter.Get(RGPHeader."Responsibility Center");
                ResponsibilityCenter.TestField("Posted RGP IN Shipment Nos");
            end
            else
                RGPSetup.TestField("Posted RGP Shipment Nos");
        end;
        RGPHeader.TestField("Posting Date");
        RGPHeader.TestField("Party No.");
    end;

    procedure PostRGPInShipment()
    var
        RGPShipmentHeader: Record "SSD RGP Shipment Header";
        RGPShipmentLine: Record "SSD RGP Shipment Line";
        PostedGateHeader: Record "SSD Posted Gate Header";
    begin
        if RGPHeader."Posted Shipment No." <> '' then
            ShipNo := RGPHeader."Posted Shipment No."
        else begin
            //IG_DS_Before  NoSeriesMgt.InitSeries(RGPHeader."Posted Shpmt. No Series", RGPHeader."Posted Shpmt. No Series", RGPHeader."Posting Date", ShipNo, RGPHeader."Posted Shpmt. No Series");
            // if NoSeriesMgt.AreRelated(RGPHeader."Posted Shpmt. No Series", RGPHeader."Posted Shpmt. No Series") then
            //   RGPHeader."Posted Shpmt. No Series" := RGPHeader."Posted Shpmt. No Series";
            //   ShipNo := NoSeriesMgt.GetNextNo(RGPHeader."Posted Shpmt. No Series", RGPHeader."Posting Date");
            RGPHeader.TestField("Posted Shpmt. No Series");
            RGPHeader."No. Series" := RGPHeader."Posted Shpmt. No Series";
            ShipNo := NoSeriesMgt.GetNextNo(RGPHeader."No. Series", RGPHeader."Posting Date");
        end;
        RGPShipmentHeader.Init;
        RGPShipmentHeader.TransferFields(RGPHeader);
        RGPShipmentHeader."No." := ShipNo;
        RGPShipmentHeader."User ID" := UserId;
        RGPShipmentHeader."Pre-Assigned No." := RGPHeader."No.";
        RGPShipmentHeader.Insert;
        RGPLedgerEntry.LockTable;
        if RGPLedgerEntry.Find('+') then
            LastEntryNo := RGPLedgerEntry."Entry No."
        else
            LastEntryNo := 0;
        RGPAppEntry.LockTable;
        if RGPAppEntry.Find('+') then
            LastAppEntryNo := RGPAppEntry."Entry No."
        else
            LastAppEntryNo := 0;
        RGPLine.Reset;
        RGPLine.SetRange("Document No.", RGPHeader."No.");
        RGPLine.SetFilter(RGPLine."Quantity to Ship", '>%1', 0); //CMLTEST-026 AA 180208
        if RGPLine.Find('-') then begin
            repeat
                RGPShipmentLine.Init;
                RGPShipmentLine.TransferFields(RGPLine);
                RGPShipmentLine."Document No." := ShipNo;
                RGPShipmentLine."User ID" := UserId;
                RGPShipmentLine."Pre-Assigned No." := RGPLine."Document No.";
                RGPShipmentLine."Pre-Assigned Line No." := RGPLine."Line No.";
                RGPShipmentLine.Insert;
                InsertRGPLedgEntry();
                InsertRGPAppEntry();
                UpdateNRGPLine(RGPLine); //ALLEAA SUBCONMRN 020408
                if not RGPLine."Gate Out" then //ALLEAA SUBCONMRN 020408
                    if RGPLine.Type = RGPLine.Type::Item then insertjnlline(); //ashish
                UpdateRGPLines(true);
            until RGPLine.Next = 0;
            //CML-034 ALLEAG 250408 Start
            if RGPInboundDoc then "ItemJnl.Post".Run(ItemJournalLine);
            //CML-034 ALLEAG 250408 Finish
        end;
        //ALLE GI 291015 Start
        PostedGateHeader.Reset;
        PostedGateHeader.SetRange("No.", RGPHeader."Gate In");
        if PostedGateHeader.FindFirst then begin
            PostedGateHeader."RGP Posted" := true;
            PostedGateHeader.Modify;
        end;
        //ALLE GI 291015 End
    end;

    procedure "--Ankit Agarwal"()
    begin
    end;

    procedure PostRGPReceiptLineDetail(RGPHeader: Record "SSD RGP Header")
    var
        PostedRGPLineDetail: Record "SSD Posted RGP Line Detail";
        RGPLineDetail: Record "SSD RGP Line Detail";
    begin
        //**********************CEN006*************************
        PostedRGPLineDetail.Init;
        RGPLineDetail.SetRange(RGPLineDetail."Document No.", RGPHeader."No.");
        if RGPLineDetail.Find('-') then
            repeat
                PostedRGPLineDetail."Document No." := PostDocNo;
                PostedRGPLineDetail."Item No." := RGPLineDetail."Item No.";
                PostedRGPLineDetail."Line No." := RGPLineDetail."Line No.";
                PostedRGPLineDetail."Pre Assigned No." := RGPLineDetail."Document No.";
                PostedRGPLineDetail."Required Item" := RGPLineDetail."Required Item";
                PostedRGPLineDetail."Required Quantity" := RGPLineDetail."Required Quantity";
                PostedRGPLineDetail.Insert;
            until RGPLineDetail.Next = 0;
        RGPLineDetail.SetRange(RGPLineDetail."Document No.", RGPHeader."No.");
        if RGPLineDetail.Find('-') then RGPLineDetail.DeleteAll;
        //**********************CEN006*************************
    end;

    procedure CreateAndPostReclassJnl(RGPLineRec: Record "SSD RGP Line"; RGPHeaderRec: Record "SSD RGP Header")
    var
        ResponsibilityCenter: Record "Responsibility Center";
        NoSeriesMgt: Codeunit "No. Series";//IG_DS NoSeriesManagement;
        InLocation: Record Location;
        RGpLines: Record "SSD RGP Line";
    begin
        //ALLEAA CML-033 280308 Start
        CreateTransferHeader.Init;
        ResponsibilityCenter.Get(RGPHeaderRec."Responsibility Center");
        TransferDocNo := RGPHeaderRec."No.";
        CreateTransferHeader.Validate("No.", TransferDocNo);
        CreateTransferHeader."Transfer-from Code" := RGPHeaderRec."Location Code";
        CreateTransferHeader."Transfer-to Code" := RGPHeaderRec."To Location";
        InLocation.SetRange(InLocation."Use As In-Transit", true);
        if InLocation.Find('-') then begin
            CreateTransferHeader.Validate("In-Transit Code", InLocation.Code);
            InransitCode := InLocation.Code;
        end;
        CreateTransferHeader.Validate("Posting Date", RGPHeaderRec."Posting Date");
        CreateTransferHeader."Shortcut Dimension 1 Code" := RGPHeaderRec."Shortcut Dimension 1 Code";
        CreateTransferHeader."Shortcut Dimension 2 Code" := RGPHeaderRec."Shortcut Dimension 2 Code";
        ResCen.Get(UserMgt.GetRespCenterFilter);
        CreateTransferHeader."Responsibility Center" := ResCen.Code;
        CreateTransferHeader."External Document No." := RGPHeaderRec."External Document No."; //ALLE CML-033 190408
        //"Subcontracting Transfer Order" := TRUE; //ALLEAA CML-033 230408
        CreateTransferHeader.Insert(true);
        RGpLines.Reset;
        RGpLines.SetRange("Document Type", RGPHeaderRec."Document Type");
        RGpLines.SetRange("Document No.", RGPHeaderRec."No.");
        if RGpLines.FindFirst then
            repeat
                with CreateTransferLine do begin
                    CreateTransferLine.Init;
                    CreateTransferLine.Validate("Document No.", TransferDocNo);
                    CreateTransferLine.Validate("Line No.", RGpLines."Line No.");
                    CreateTransferLine.Validate("Item No.", RGpLines."No.");
                    CreateTransferLine.Validate("Responsibility Center", RGpLines."Responsibility Center");
                    CreateTransferLine."Shortcut Dimension 1 Code" := RGPHeaderRec."Shortcut Dimension 1 Code";
                    CreateTransferLine."Shortcut Dimension 2 Code" := RGPHeaderRec."Shortcut Dimension 2 Code";
                    CreateTransferLine.Validate("In-Transit Code", InransitCode);
                    CreateTransferLine.Validate("Transfer-from Code", RGpLines."Location Code");
                    CreateTransferLine.Validate("Transfer-to Code", RGpLines."New Location Code");
                    CreateTransferLine.Validate("Shipment Date", RGPHeaderRec."Posting Date");
                    CreateTransferLine.Validate(CreateTransferLine."Receipt Date", RGPHeaderRec."Posting Date");
                    CreateTransferLine.Validate("Transfer-from Bin Code", RGpLines."Bin Code");
                    CreateTransferLine.Validate("Transfer-To Bin Code", RGpLines."New Bin Code");
                    CreateTransferLine.Validate(Quantity, RGpLines.Quantity);
                    /*  CreateTransferLine.VALIDATE("Qty. to Ship" , RGpLines.Quantity);
                      CreateTransferLine.VALIDATE("Qty. in Transit" , RGpLines.Quantity);*/
                    //  CreateTransferLine."Qty. to Receive" := RGpLines.Quantity;
                    //CreateTransferLine.VALIDATE("Unit Cost" , RGpLines."Unit Cost"); // BIS 1145
                    // CreateTransferLine."Qty. to Receive (Base)" := RGpLines.Quantity;
                    CreateTransferLine."Responsibility Center" := ResCen.Code; //ALLEAA CML-033 190408
                    //CreateTransferLine."Subcontracting Transfer Order" := TRUE; //ALLEAA CML-033 230408
                    CreateTransferLine.Insert;
                end;
            until RGpLines.Next = 0;
        TrasferOrderCreated := true;
        //ALLEAA CML-033 280308 Finish
    end;

    procedure CreatePurchRcptLine(RGPLineRec: Record "SSD RGP Line"; RecvNumber: Code[20])
    var
        PurchRcptLine: Record "Purch. Rcpt. Line";
    begin
        // Insert receipt line
        PurchRcptLine.Init;
        PurchRcptLine."Document No." := RecvNumber;
        PurchRcptLine."Line No." := RGPLineRec."Line No.";
        PurchRcptLine."Buy-from Vendor No." := RGPLineRec."Party No.";
        PurchRcptLine."Pay-to Vendor No." := RGPLineRec."Party No.";
        PurchRcptLine."Posting Date" := RGPLineRec."Posting Date";
        PurchRcptLine.Type := PurchRcptLine.Type::Item;
        PurchRcptLine."No." := RGPLineRec."No.";
        PurchRcptLine."Scrap Item" := RGPLineRec."Scrap Item";
        PurchRcptLine.Description := RGPLineRec.Description;
        PurchRcptLine."Location Code" := RGPLineRec."Location Code";
        PurchRcptLine."Unit of Measure" := RGPLineRec."Base Unit Of Measure";
        PurchRcptLine."Shortcut Dimension 1 Code" := RGPLineRec."Shortcut Dimension 1 Code";
        PurchRcptLine."Shortcut Dimension 2 Code" := RGPLineRec."Shortcut Dimension 2 Code";
        PurchRcptLine."Qty. per Unit of Measure" := RGPLineRec."Qty. per Unit of Measure";
        PurchRcptLine."Unit of Measure Code" := RGPLineRec."Unit Of Measure Code";
        PurchRcptLine."Responsibility Center" := RGPLineRec."Responsibility Center";
        PurchRcptLine."Item Category Code" := RGPLineRec."Item Category Code";
        PurchRcptLine."Gate Entry no." := RGPLineRec."Gate Entry No.";
        PurchRcptLine."Gate Line No." := RGPLineRec."Gate Entry Line No.";
        PurchRcptLine.Quantity := RGPLineRec."Quantity to Receive";
        PurchRcptLine."Quantity (Base)" := RGPLineRec."Quantity to Receive";
        PurchRcptLine."Qty. Rcd. Not Invoiced" := PurchRcptLine.Quantity;
        PurchRcptLine."Order No." := RGPLineRec."Document No.";
        PurchRcptLine."Order Line No." := RGPLineRec."Line No.";
        PurchRcptLine."Scrap Generated" := RGPLineRec."Scrap Generated";
        PurchRcptLine.Subcontracting := RGPLineRec.Subcontracting; //ALLEAA CML-033 220408
        //Anil 26.07.07
        PurchRcptLine."Unit Cost" := RGPLineRec."Unit Cost";
        PurchRcptLine."No.2" := RGPLineRec."No. 2";
        PurchRcptLine.Grade := RGPLineRec.Grade;
        PurchRcptLine."Bin Code" := RGPLineRec."Bin Code";
        //Anil 26.07.07
        PurchRcptLine."Item Rcpt. Entry No." := InsertRcptEntryRelation(PurchRcptLine);
        PurchRcptLine.Insert;
    end;

    procedure CreatePurchRcptHeader(RGPHeaderRec: Record "SSD RGP Header"; RecvNumber: Code[20])
    var
        PurchRcptHeader: Record "Purch. Rcpt. Header";
    begin
        PurchRcptHeader.Init;
        if PurchRcptHeader.Get(RecvNumber) then //ALLEAA CML-033 220408
            Error('Document is already Posted'); //ALLEAA CML-033 220408
        PurchRcptHeader."No." := RecvNumber;
        PurchRcptHeader."Buy-from Vendor No." := RGPHeaderRec."Party No.";
        //Anil
        PurchRcptHeader."Buy-from Vendor Name" := RGPHeaderRec."Party Name";
        PurchRcptHeader."Buy-from Address" := RGPHeaderRec."Party Address";
        PurchRcptHeader."Buy-from Address 2" := RGPHeaderRec."Party Address 2";
        PurchRcptHeader."Buy-from Post Code" := RGPHeaderRec."Party PostCode";
        PurchRcptHeader."Buy-from City" := RGPHeaderRec."Party City";
        PurchRcptHeader."Bill No." := RGPHeaderRec."Bill No.";
        PurchRcptHeader."Bill Date" := RGPHeaderRec."Bill Date";
        PurchRcptHeader."Posting Date" := RGPHeaderRec."Posting Date";
        PurchRcptHeader."Gate Entry No." := RGPHeaderRec."Gate Entry No.";
        PurchRcptHeader."Document Date" := RGPHeaderRec."Document Date";
        //Anil
        PurchRcptHeader."Pay-to Vendor No." := RGPHeaderRec."Party No.";
        //PurchRcptHeader."Posting Date" := RGPHeaderRec."Receipt Date";
        PurchRcptHeader."Location Code" := RGPHeaderRec."Location Code";
        PurchRcptHeader."Shortcut Dimension 1 Code" := RGPHeaderRec."Shortcut Dimension 1 Code";
        PurchRcptHeader."Shortcut Dimension 2 Code" := RGPHeaderRec."Shortcut Dimension 2 Code";
        PurchRcptHeader."Source Code" := 'SUBCON';
        PurchRcptHeader."Responsibility Center" := RGPHeaderRec."Responsibility Center";
        PurchRcptHeader."User ID" := UserId;
        PurchRcptHeader.Subcontracting := true;
        PurchRcptHeader.Insert;
    end;

    local procedure InsertRcptEntryRelation(var PurchRcptLine: Record "Purch. Rcpt. Line"): Integer
    var
        ItemEntryRelation: Record "Item Entry Relation";
        ILE: Record "Item Ledger Entry";
    begin
        ILE.Reset;
        ILE.SetCurrentkey("Document No.");
        ILE.SetRange("Document No.", RecvNo);
        ILE.SetRange("Item No.", PurchRcptLine."No.");
        if ILE.Find('-') then ItemLedgShptEntryNo := ILE."Entry No.";
        exit(ItemLedgShptEntryNo);
        ItemEntryRelation.Init;
        ItemEntryRelation."Item Entry No." := ItemLedgShptEntryNo;
        ItemEntryRelation.TransferFieldsPurchRcptLine(PurchRcptLine);
        ItemEntryRelation.Insert;
    end;

    procedure UpdateRGPHeader(RGPHead: Record "SSD RGP Header")
    begin
        RGPHead.CalcFields(RGPHead."Completely Received");
        if RGPHead."Completely Received" = true then RGPHead.Posted := true;
        //RGPHead.MODIFY; 250408
    end;

    procedure InitDocumentDimension(RGPLine1: Record "SSD RGP Line")
    begin
        /* // BIS 1145
            WITH RGPLine1 DO BEGIN
              ToPostedDocDim.INIT;
              ToPostedDocDim."Table ID" := 121;
              ToPostedDocDim."Document No." := RGPLine1."Document No.";
              ToPostedDocDim."Line No." := RGPLine1."Line No.";
              ToPostedDocDim."Dimension Code" := RGPLine1."Shortcut Dimension 1 Code";
              ToPostedDocDim."Dimension Value Code" := RGPLine1."Shortcut Dimension 2 Code";
              ToPostedDocDim.INSERT;
            END;
            */
        // BIS 1145
    end;

    procedure UpdateNRGPLine(RGPLineRec: Record "SSD RGP Line")
    var
        RGPLine1: Record "SSD RGP Line";
    begin
        RGPLine1.Reset;
        RGPLine1.SetRange("Document Type", RGPLine1."document type"::"RGP Outbound");
        RGPLine1.SetRange("Document No.", RGPLineRec."NRGP Doc. No.");
        RGPLine1.SetRange("Line No.", RGPLineRec."NRGP Doc. Line No.");
        if RGPLine1.Find('-') then begin
            RGPLine1."NRGP Out Quantity" += RGPLineRec."Quantity to Ship";
            RGPLine1.Modify;
        end;
    end;

    procedure PostTrasferOrder()
    var
        RgpHeader: Record "SSD RGP Header";
        WhseRecptHeader: Record "Warehouse Receipt Header";
        WhseReceiptLines: Record "Warehouse Receipt Line";
        "WhsePostReceiptYes/No": Codeunit "Whse.-Post Receipt (Yes/No)";
        RecWhseReceiptLines: Record "Warehouse Receipt Line";
    begin
        //ALLEAA CML-033 250408 Start >>
        if SubcontractingMRN.Get(SubcontractingMRN."document type"::"RGP Inbound", TransferDocNo) then begin
            SubcontractingMRN."OutPut Post" := true;
            SubcontractingMRN.Modify;
        end;
        "ReceiptTransferOrderNo." := TransferDocNo;
        //ALLEAA CML-033 250408 End <<
        ReleaseTransferDocument.Run(CreateTransferHeader);
        TransferPostShipment.Run(CreateTransferHeader);
        ReleaseTransferDocument.Reopen(CreateTransferHeader);
        TransferOrderLines.SetRange("Document No.", TransferDocNo);
        if TransferOrderLines.FindFirst then
            repeat
                TransferOrderLines.Validate("Qty. to Receive", TransferOrderLines."Quantity Shipped");
                //  TransferOrderLines.VALIDATE("Qty. to Receive (Base)" , 0);
                TransferOrderLines.Modify;
            until TransferOrderLines.Next = 0;
        ReleaseTransferDocument.Run(CreateTransferHeader);
        GetSourceDocInbound.CreateFromInbndTransferOrder(CreateTransferHeader);
        //TransferPostReceipt.RUN(CreateTransferHeader);
        /*WhseReceiptLines.RESET;
        WhseReceiptLines.SETCURRENTKEY("Source Type","Source Subtype","Source No.","Source Line No.");
        WhseReceiptLines.SETRANGE("Source Type" , 5741);
        WhseReceiptLines.SETRANGE("Source Subtype" , 1);
        WhseReceiptLines.SETRANGE("Source No." , TransferDocNo);
        IF WhseReceiptLines.FINDFIRST THEN
          RecWhseReceiptLines.COPY(WhseReceiptLines);
        "WhsePostReceiptYes/No".RUN(RecWhseReceiptLines);
        */
        if RgpHeader.Get(RgpHeader."document type"::"RGP Inbound", TransferDocNo) then begin
            RgpHeader."Subcon Posted" := true;
            RgpHeader.Modify;
        end;
    end;

    local procedure PostWhseJnlLine(ItemJnlLine: Record "Item Journal Line"; OriginalQuantity: Decimal; OriginalQuantityBase: Decimal; var TempHandlingSpecification: Record "Tracking Specification" temporary)
    var
        WhseJnlLine: Record "Warehouse Journal Line";
        TempWhseJnlLine2: Record "Warehouse Journal Line" temporary;
        ItemTrackingMgt: Codeunit "Item Tracking Management";
        Location: Record Location;
        WMSMgmt: Codeunit "WMS Management";
        WhseJnlPostLine: Codeunit "Whse. Jnl.-Register Line";
    begin
        ItemJnlLine.Quantity := OriginalQuantity;
        ItemJnlLine."Quantity (Base)" := OriginalQuantityBase;
        Location.Get(ItemJnlLine."Location Code");
        if not (ItemJnlLine."Entry Type" in [ItemJnlLine."entry type"::Consumption, ItemJnlLine."entry type"::Output]) then
            if Location."Bin Mandatory" then
                if WMSMgmt.CreateWhseJnlLine(ItemJnlLine, 1, WhseJnlLine, false) then begin
                    ItemTrackingMgt.SplitWhseJnlLine(WhseJnlLine, TempWhseJnlLine2, TempHandlingSpecification, false);
                    if TempWhseJnlLine2.FindSet then
                        repeat
                            WMSMgmt.CheckWhseJnlLine(TempWhseJnlLine2, 1, 0, false);
                            WhseJnlPostLine.Run(TempWhseJnlLine2);
                        until TempWhseJnlLine2.Next = 0;
                end;
        if ItemJnlLine."Entry Type" = ItemJnlLine."entry type"::Transfer then begin
            Location.Get(ItemJnlLine."New Location Code");
            if Location."Bin Mandatory" then
                if WMSMgmt.CreateWhseJnlLine(ItemJnlLine, 1, WhseJnlLine, true) then begin
                    ItemTrackingMgt.SplitWhseJnlLine(WhseJnlLine, TempWhseJnlLine2, TempHandlingSpecification, true);
                    if TempWhseJnlLine2.FindSet then
                        repeat
                            WMSMgmt.CheckWhseJnlLine(TempWhseJnlLine2, 1, 0, true);
                            WhseJnlPostLine.Run(TempWhseJnlLine2);
                        until TempWhseJnlLine2.Next = 0;
                end;
        end;
    end;
}
