Codeunit 50013 "Web Service Mobile PC"
{
    // 
    // //Alle 19032021 -- block code LR No.
    // //ALle 22032021 -- add code LR no. Condtion
    Permissions = TableData "Item Ledger Entry" = rim,
        TableData "Sales Invoice Header" = rim;

    trigger OnRun()
    begin
    end;

    var
        Date_gDate: Date;
        Time_gTime: Time;
        Day: Integer;
        Month: Integer;
        YEar: Integer;
        Location: Record Location;
        Location1: Record Location;
        CopyofPacking: Record "SSD Copy of Packing";
        LRRRDate1: Date;

    procedure CreateItemReclass(ItemCode: Code[20]; LocationCode: Code[20]; Qty: Decimal; BinCode: Code[20]; NewLocation: Code[20]; NewBin: Code[20]; PhysicalBin: Code[20]; NewPhysicalBin: Code[20]; Lot: Code[20]): Boolean
    var
        ItemJournalLine: Record "Item Journal Line";
        LineNo: Integer;
        Flag1: Boolean;
        NoSeriesMgt: Codeunit "No. Series";//IG_DSNoSeriesManagement;
        EntryNo: Integer;
        LotNo: Code[20];
        Item: Record Item;
        ReservationEntry: Record "Reservation Entry";
        ReservationEntry2: Record "Reservation Entry";
        ItemPhyBinDetails: Record "SSD Item Phy. Bin Details";
        PhyBinQty: Decimal;
        DimMgt: Codeunit DimensionManagement;
        DimSetID: Integer;
        DimensionSetEntry: Record "Dimension Set Entry" temporary;
        ItemLedgerEntry: Record "Item Ledger Entry";
        NewExpDate: Date;
        Flag2: Boolean;
        Flag3: Boolean;
        Qty1: Decimal;
    begin
        ItemPhyBinDetails.Reset;
        ItemPhyBinDetails.SetRange("Item No.", ItemCode);
        ItemPhyBinDetails.SetRange("Location Code", LocationCode);
        ItemPhyBinDetails.SetRange("Bin Code", BinCode);
        ItemPhyBinDetails.SetRange("Lot No.", Lot);
        ItemPhyBinDetails.SetRange("Phy. Bin Code", PhysicalBin);
        ItemPhyBinDetails.SetFilter("Whse. Entry  No.", '<>%1', 0);
        if ItemPhyBinDetails.FindSet then
            repeat
                Qty1 += ItemPhyBinDetails."ILE Quantity";
            until ItemPhyBinDetails.Next = 0;
        if Abs(Qty1) < Abs(Qty) then Error('Insufficient Quantity in Phy. Bin %1', PhysicalBin);
        Flag1 := false;
        Flag2 := false;
        Flag3 := false;
        LineNo += 10000;
        ItemJournalLine.Reset;
        ItemJournalLine.SetRange("Journal Template Name", 'TRANSFER');
        ItemJournalLine.SetRange("Journal Batch Name", 'DEFAULT');
        if ItemJournalLine.FindLast then LineNo += ItemJournalLine."Line No.";
        ItemJournalLine.Init;
        ItemJournalLine.Validate("Journal Template Name", 'TRANSFER');
        ItemJournalLine.Validate("Journal Batch Name", 'DEFAULT');
        ItemJournalLine."Document No." := NoSeriesMgt.GetNextNo('WBRCLS', Today, false);
        ItemJournalLine.Validate("Line No.", LineNo);
        ItemJournalLine.Validate("Entry Type", ItemJournalLine."entry type"::Transfer);
        ItemJournalLine.Validate("Posting Date", Today);
        ItemJournalLine.Validate("Item No.", ItemCode);
        ItemJournalLine.Validate("Location Code", LocationCode);
        ItemJournalLine.Validate(Quantity, Qty);
        ItemJournalLine.Validate("New Location Code", NewLocation);
        ItemJournalLine.Validate("Bin Code", BinCode);
        ItemJournalLine.Validate("New Bin Code", NewBin);
        ItemJournalLine.Validate("Phy. Bin Code", PhysicalBin);
        ItemJournalLine.Validate("New Phy. Bin Code", NewPhysicalBin);
        ItemJournalLine.Validate("New Shortcut Dimension 1 Code", '21000');
        Flag1 := true;
        ItemJournalLine.Insert;
        //Insert Dimensions
        DimensionSetEntry.Init;
        DimensionSetEntry.Validate("Dimension Code", 'COSTCEN');
        DimensionSetEntry.Validate("Dimension Value Code", '21000');
        DimensionSetEntry.Insert;
        DimSetID := DimMgt.GetDimensionSetID(DimensionSetEntry);
        ItemJournalLine."Dimension Set ID" := DimSetID;
        ItemJournalLine.Modify;
        NewExpDate := 0D;
        ItemLedgerEntry.Reset;
        ItemLedgerEntry.SetRange("Item No.", ItemCode);
        ItemLedgerEntry.SetRange("Location Code", LocationCode);
        ItemLedgerEntry.SetRange("Lot No.", Lot);
        ItemLedgerEntry.SetFilter("Remaining Quantity", '<>%1', 0);
        if ItemLedgerEntry.FindFirst then NewExpDate := ItemLedgerEntry."Expiration Date";
        ItemJournalLine.Reset;
        ItemJournalLine.SetCurrentkey("Journal Template Name", "Journal Batch Name", "Line No.");
        ItemJournalLine.SetRange("Journal Template Name", 'TRANSFER');
        ItemJournalLine.SetRange("Journal Batch Name", 'DEFAULT');
        ItemJournalLine.SetRange("Line No.", LineNo);
        ItemJournalLine.SetFilter(Quantity, '<>%1', 0);
        if ItemJournalLine.FindFirst then begin
            EntryNo := 0;
            if Item.Get(ItemJournalLine."Item No.") then;
            if (Item."Item Tracking Code" <> '') and (Item."Lot Nos." <> '') then begin
                ReservationEntry.Reset;
                if ReservationEntry.FindLast then EntryNo := ReservationEntry."Entry No." + 1;
                ReservationEntry2.Init;
                ReservationEntry2."Entry No." := EntryNo;
                ReservationEntry2."Item No." := ItemJournalLine."Item No.";
                ReservationEntry2."Location Code" := ItemJournalLine."Location Code";
                ReservationEntry2."Reservation Status" := ReservationEntry2."reservation status"::Prospect;
                ReservationEntry2."Creation Date" := Today;
                ReservationEntry2."Source Type" := Database::"Item Journal Line";
                ReservationEntry2."Source Subtype" := 4;
                ReservationEntry2."Source ID" := 'TRANSFER';
                ReservationEntry2."Source Batch Name" := 'DEFAULT';
                ReservationEntry2."Source Ref. No." := ItemJournalLine."Line No.";
                ReservationEntry2."Quantity (Base)" := -ItemJournalLine.Quantity;
                ReservationEntry2."Expected Receipt Date" := Today;
                ReservationEntry2.Positive := false;
                ReservationEntry2.Quantity := -ItemJournalLine.Quantity;
                ReservationEntry2."Qty. to Handle (Base)" := -ItemJournalLine.Quantity;
                ReservationEntry2."Qty. to Invoice (Base)" := -ItemJournalLine.Quantity;
                ReservationEntry2."Created By" := UserId;
                ReservationEntry2."Qty. per Unit of Measure" := ItemJournalLine."Qty. per Unit of Measure";
                ReservationEntry2."Lot No." := Lot;
                ReservationEntry2."New Lot No." := Lot;
                ReservationEntry2."Item Tracking" := ReservationEntry2."item tracking"::"Lot No.";
                ReservationEntry2."New Expiration Date" := NewExpDate;
                ReservationEntry2.Insert;
            end;
        end;
        //CORP::PK 070819 >>>
        if Location.Get(ItemJournalLine."Location Code") then;
        if Location1.Get(ItemJournalLine."New Location Code") then;
        if Item.Get(ItemJournalLine."Item No.") then;
        if (((Location."Phy. Bin Required") or (Location1."Phy. Bin Required")) and (Item."Phy. Bin Required")) then begin
            ItemPhyBinDetails.Reset;
            ItemPhyBinDetails.SetRange("Document No.", ItemJournalLine."Document No.");
            ItemPhyBinDetails.SetRange("Document Line No.", ItemJournalLine."Line No.");
            ItemPhyBinDetails.SetRange("Posted Document No.", '');
            if not ItemPhyBinDetails.FindFirst then begin
                ReservationEntry.Reset;
                ReservationEntry.SetRange("Source ID", ItemJournalLine."Journal Template Name");
                ReservationEntry.SetRange("Source Batch Name", ItemJournalLine."Journal Batch Name");
                ReservationEntry.SetRange("Item No.", ItemJournalLine."Item No.");
                if ReservationEntry.FindSet then
                    repeat
                        ItemPhyBinDetails.Reset;
                        ItemPhyBinDetails.SetRange("Document No.", ItemJournalLine."Document No.");
                        if ItemPhyBinDetails.FindLast then
                            LineNo := ItemPhyBinDetails."Line No." + 10000
                        else
                            LineNo := 10000;
                        if Location."Phy. Bin Required" then begin
                            ItemPhyBinDetails.Init;
                            ItemPhyBinDetails.Validate("Line No.", LineNo);
                            ItemPhyBinDetails.Validate("Document No.", ItemJournalLine."Document No.");
                            ItemPhyBinDetails.Validate("Document Line No.", ItemJournalLine."Line No.");
                            ItemPhyBinDetails.Validate("Item No.", ItemJournalLine."Item No.");
                            ItemPhyBinDetails.Validate("Unit Of Measure", ItemJournalLine."Unit of Measure Code");
                            ItemPhyBinDetails.Validate("Location Code", ItemJournalLine."New Location Code");
                            ItemPhyBinDetails.Validate(Quantity, Qty);
                            ItemPhyBinDetails.Validate("ILE Quantity", Qty);
                            ItemPhyBinDetails.Validate("Bin Code", ItemJournalLine."New Bin Code");
                            ItemPhyBinDetails.Validate("Lot No.", ReservationEntry."Lot No.");
                            ItemPhyBinDetails.Validate("Journal Batch Name", ItemJournalLine."Journal Batch Name");
                            ItemPhyBinDetails.Validate("Posting Date", ItemJournalLine."Posting Date");
                            ItemPhyBinDetails.Validate("Qty. Per Unit Of Measure", ItemJournalLine."Qty. per Unit of Measure");
                            ItemPhyBinDetails.Validate("Journal Template Name", ItemJournalLine."Journal Template Name");
                            ItemPhyBinDetails.Validate("Phy. Bin Code", NewPhysicalBin);
                            if ItemJournalLine."Entry Type" = ItemJournalLine."entry type"::Transfer then ItemPhyBinDetails.Validate("Document Type", ItemPhyBinDetails."document type"::Transfer);
                            ItemPhyBinDetails.Insert;
                        end;
                        if Location1."Phy. Bin Required" then begin
                            ItemPhyBinDetails.Init;
                            ItemPhyBinDetails.Validate("Line No.", LineNo + 10000);
                            ItemPhyBinDetails.Validate("Document No.", ItemJournalLine."Document No.");
                            ItemPhyBinDetails.Validate("Document Line No.", ItemJournalLine."Line No.");
                            ItemPhyBinDetails.Validate("Item No.", ItemJournalLine."Item No.");
                            ItemPhyBinDetails.Validate("Unit Of Measure", ItemJournalLine."Unit of Measure Code");
                            ItemPhyBinDetails.Validate("Location Code", ItemJournalLine."Location Code");
                            ItemPhyBinDetails.Validate("Bin Code", ItemJournalLine."Bin Code");
                            ItemPhyBinDetails.Validate("Posting Date", ItemJournalLine."Posting Date");
                            ItemPhyBinDetails.Validate(Quantity, ReservationEntry."Quantity (Base)");
                            ItemPhyBinDetails.Validate("ILE Quantity", ReservationEntry."Quantity (Base)");
                            ItemPhyBinDetails.Validate("Lot No.", ReservationEntry."Lot No.");
                            ItemPhyBinDetails.Validate("Journal Batch Name", ItemJournalLine."Journal Batch Name");
                            ItemPhyBinDetails.Validate("Journal Template Name", ItemJournalLine."Journal Template Name");
                            ItemPhyBinDetails.Validate("Phy. Bin Code", PhysicalBin);
                            ItemPhyBinDetails.Validate("Qty. Per Unit Of Measure", ItemJournalLine."Qty. per Unit of Measure");
                            if ItemJournalLine."Entry Type" = ItemJournalLine."entry type"::Transfer then ItemPhyBinDetails.Validate("Document Type", ItemPhyBinDetails."document type"::Transfer);
                            Flag2 := true;
                            ItemPhyBinDetails.Insert;
                        end;
                    until ReservationEntry.Next = 0;
            end;
            Commit;
        end;
        if Flag1 and Flag2 then begin
            Codeunit.Run(Codeunit::"Item Jnl.-Post", ItemJournalLine);
            Flag3 := true;
        end;
        //CORP::PK 070819 <<<
        if Flag1 and Flag3 then
            exit(true)
        else
            exit(false);
    end;

    procedure CheckRPOConsump(RPONo: Code[20]; ItemNo: Code[20]; LotNo: Code[20]; Location: Code[20]): Text
    var
        ReservationEntry: Record "Reservation Entry";
    begin
        ReservationEntry.Reset;
        ReservationEntry.SetRange("Source ID", RPONo);
        ReservationEntry.SetRange("Item No.", ItemNo);
        ReservationEntry.SetRange("Location Code", Location);
        ReservationEntry.SetRange("Lot No.", LotNo);
        if ReservationEntry.FindFirst then begin
            if ReservationEntry."QR Scanned" then
                exit('Lot already scanned!')
            else begin
                ReservationEntry."QR Scanned" := true;
                ReservationEntry.Modify;
                exit('Lot Scanned Successfully.');
            end;
        end
        else
            exit('Lot Does Not Exist!');
    end;

    procedure CheckSalesInvoice(GatePassNo: Code[20]; InvoiceNo: Code[20]; ItemNo: Code[20]; LotNo: Code[20]; Qty: Decimal): Text
    var
        ItemLedgerEntry: Record "Item Ledger Entry";
        ValueEntry: Record "Value Entry";
        ILEDocNo: Code[20];
        ItemLedgerEntry1: Record "Item Ledger Entry";
        ItemLedgerEntry2: Record "Item Ledger Entry";
        ILEAllLotScanned: Boolean;
        GatePassLine: Record "SSD Gate Pass Line";
    begin
        //Gate Pass For Posted sales invoice and Posted Puurchase credit memo
        ILEDocNo := '';
        ValueEntry.Reset;
        ValueEntry.SetRange("Document No.", InvoiceNo);
        ValueEntry.SetRange("Item No.", ItemNo);
        if ValueEntry.FindFirst then;
        if ItemLedgerEntry.Get(ValueEntry."Item Ledger Entry No.") then ILEDocNo := ItemLedgerEntry."Document No.";
        ItemLedgerEntry1.Reset;
        ItemLedgerEntry1.SetRange("Document No.", ILEDocNo);
        ItemLedgerEntry1.SetRange("Item No.", ItemNo);
        ItemLedgerEntry1.SetRange("Lot No.", LotNo);
        if ItemLedgerEntry1.FindFirst then begin
            if ItemLedgerEntry1."Inv. Lot Scanned" then
                exit('Lot already scanned!')
            else begin
                ItemLedgerEntry1."Inv. Lot Scanned" := true;
                ItemLedgerEntry1.Modify;
                ILEAllLotScanned := true;
                ItemLedgerEntry2.Reset;
                ItemLedgerEntry2.SetRange("Document No.", ILEDocNo);
                ItemLedgerEntry2.SetRange("Inv. Lot Scanned", false);
                if ItemLedgerEntry2.FindFirst then ILEAllLotScanned := false;
                if ILEAllLotScanned then begin
                    GatePassLine.Reset;
                    GatePassLine.SetRange("No.", GatePassNo);
                    GatePassLine.SetRange("Invoice No.", InvoiceNo);
                    if GatePassLine.FindFirst then begin
                        GatePassLine."ILE Lot Scanned" := true;
                        GatePassLine.Modify;
                    end;
                end;
                exit('Lot Scanned Successfully.');
            end;
        end
        else
            exit('Lot Does Not Exist!');
    end;

    procedure CheckCreditMemo(DocNo: Code[20]; ItemNo: Code[20]; LotNo: Code[20]; Location: Code[20]): Text
    var
        ReservationEntry: Record "Reservation Entry";
    begin
        ReservationEntry.Reset;
        ReservationEntry.SetRange("Source ID", DocNo);
        ReservationEntry.SetRange("Item No.", ItemNo);
        ReservationEntry.SetRange("Location Code", Location);
        ReservationEntry.SetRange("Lot No.", LotNo);
        if ReservationEntry.FindFirst then begin
            if ReservationEntry."QR Scanned" then
                exit('Lot already scanned!')
            else begin
                ReservationEntry."QR Scanned" := true;
                ReservationEntry.Modify;
                exit('Lot Scanned Successfully.');
            end;
        end
        else
            exit('Lot Does Not Exist!');
    end;

    procedure CheckSubconOrder(GatePassNo: Code[20]; InvoiceNo: Code[20]; ItemNo: Code[20]; LotNo: Code[20]; Qty: Decimal): Text
    var
        ItemLedgerEntry: Record "Item Ledger Entry";
        ValueEntry: Record "Value Entry";
        ILEDocNo: Code[20];
        ItemLedgerEntry1: Record "Item Ledger Entry";
        ItemLedgerEntry2: Record "Item Ledger Entry";
        ILEAllLotScanned: Boolean;
        GatePassLine: Record "SSD Gate Pass Line";
    begin
        ItemLedgerEntry1.Reset;
        ItemLedgerEntry1.SetRange("External Document No.", InvoiceNo);
        ItemLedgerEntry1.SetRange("Item No.", ItemNo);
        ItemLedgerEntry1.SetRange("Lot No.", LotNo);
        ItemLedgerEntry1.SetRange(Positive, false);
        if ItemLedgerEntry1.FindFirst then begin
            if ItemLedgerEntry1."Inv. Lot Scanned" then
                exit('Lot already scanned!')
            else begin
                ItemLedgerEntry1."Inv. Lot Scanned" := true;
                ItemLedgerEntry1.Modify;
                ILEAllLotScanned := true;
                ItemLedgerEntry.Reset;
                ItemLedgerEntry.SetRange("External Document No.", InvoiceNo);
                ItemLedgerEntry.SetRange("Inv. Lot Scanned", false);
                ItemLedgerEntry.SetRange(Positive, false);
                if ItemLedgerEntry.FindFirst then ILEAllLotScanned := false;
                if ILEAllLotScanned then begin
                    GatePassLine.Reset;
                    GatePassLine.SetRange("No.", GatePassNo);
                    GatePassLine.SetRange("Invoice No.", InvoiceNo);
                    if GatePassLine.FindFirst then begin
                        GatePassLine."ILE Lot Scanned" := true;
                        GatePassLine.Modify;
                    end;
                end;
                exit('Lot Scanned Successfully.');
            end;
        end
        else
            exit('Lot Does Not Exist!');
    end;

    procedure CreateGatePass(DocType: Text): Code[20]
    var
        NoSeriesManagement: Codeunit "No. Series";//IG_DS NoSeriesManagement;
        GatePassHeader: Record "SSD Gate Pass Header";
        NoGenerated: Boolean;
    begin
        NoGenerated := false;
        GatePassHeader.Init;
        GatePassHeader."No." := NoSeriesManagement.GetNextNo('I-GT-OUT', Today, true);
        NoGenerated := true;
        Evaluate(GatePassHeader."Document Type", DocType);
        GatePassHeader.Insert;
        if NoGenerated then exit(GatePassHeader."No.");
    end;

    procedure UpdateGatePassSubconOrder(GatePassNo: Code[20]; Date: Text; Time: Text; VechicleNo: Code[20]; DriverName: Code[20]; TransporterCode: Code[20]; BiltyNo: Code[20]; MobNo: Code[20]; InvoiceNo: Code[20]): Boolean
    var
        GatePassLine: Record "SSD Gate Pass Line";
        GatePassHeader: Record "SSD Gate Pass Header";
        //IG_DS NoSeriesManagement: Codeunit NoSeriesManagement;
        DeliveryChallanHeader: Record "Delivery Challan Header";
        LineNo: Integer;
        GatePassLine1: Record "SSD Gate Pass Line";
        DeliveryChallanLine: Record "Delivery Challan Line";
        ItemRec: Record Item;
        NetWt: Decimal;
        GrossWt: Decimal;
        UserSetup: Record "User Setup";
    begin
        Day := 0;
        Month := 0;
        YEar := 0;
        Evaluate(Day, CopyStr(Date, 1, 2));
        Evaluate(Month, CopyStr(Date, 3, 2));
        Evaluate(YEar, CopyStr(Date, 5, 4));
        Date_gDate := 0D;
        Date_gDate := Dmy2date(Day, Month, YEar);
        Time_gTime := 0T;
        Evaluate(Time_gTime, Time);
        if UserSetup.Get(UserId) then;
        GatePassHeader.Reset;
        GatePassHeader.SetRange("No.", GatePassNo);
        if GatePassHeader.FindFirst then begin
            GatePassHeader.Validate(Date, Date_gDate);
            GatePassHeader.Validate("Gate Pass Time", Time_gTime);
            GatePassHeader.Validate("Vehicle No.", VechicleNo);
            GatePassHeader.Validate("Driver Name", DriverName);
            GatePassHeader.Validate("Transporter Code", TransporterCode);
            GatePassHeader.Validate("Bilty No.", BiltyNo);
            GatePassHeader.Validate("Mobile No.", MobNo);
            GatePassHeader.Validate("Responsibility Center", UserSetup."Responsibility Center");
            GatePassHeader.Modify;
        end;
        DeliveryChallanHeader.Reset;
        DeliveryChallanHeader.SetRange("No.", InvoiceNo);
        DeliveryChallanHeader.SetRange("Gate Pass", false);
        if DeliveryChallanHeader.FindFirst then begin
            GatePassLine1.Reset;
            GatePassLine1.SetRange("No.", GatePassHeader."No.");
            if GatePassLine1.FindLast then
                LineNo := GatePassLine1."Line No." + 10000
            else
                LineNo := 10000;
            NetWt := 0;
            GrossWt := 0;
            DeliveryChallanLine.Reset;
            DeliveryChallanLine.SetRange("Delivery Challan No.", DeliveryChallanHeader."No.");
            if DeliveryChallanLine.FindSet then
                repeat
                    if ItemRec.Get(DeliveryChallanLine."Item No.") then;
                    NetWt += (ItemRec."Net Weight" * DeliveryChallanLine.Quantity);
                    GrossWt += (ItemRec."Gross Weight" * DeliveryChallanLine.Quantity);
                until DeliveryChallanLine.Next = 0;
            GatePassLine.Init;
            GatePassLine.Validate("No.", GatePassHeader."No.");
            GatePassLine.Validate("Invoice No.", DeliveryChallanHeader."No.");
            GatePassLine.Validate("Line No.", LineNo);
            GatePassLine.Validate("Invoice Date", DeliveryChallanHeader."Posting Date");
            GatePassLine."Customer No." := DeliveryChallanHeader."Vendor No.";
            GatePassLine.Validate("Customer Name", DeliveryChallanHeader."Vendor Name");
            //GatePassLine.VALIDATE("Invoice Amount",DeliveryChallanHeader."Amount to Customer");
            GatePassLine.Validate("Net Wt.", NetWt);
            GatePassLine.Validate("Gross Wt.", GrossWt);
            //GatePassLine.VALIDATE("No. Of Cartons",DeliveryChallanHeader."No of Pack");
            GatePassLine.Insert;
        end;
        exit(true);
    end;

    procedure CheckTransferOrder(GatePassNo: Code[20]; InvoiceNo: Code[20]; ItemNo: Code[20]; LotNo: Code[20]; Qty: Decimal): Text
    var
        ItemLedgerEntry: Record "Item Ledger Entry";
        ValueEntry: Record "Value Entry";
        ILEDocNo: Code[20];
        ItemLedgerEntry1: Record "Item Ledger Entry";
        ItemLedgerEntry2: Record "Item Ledger Entry";
        ILEAllLotScanned: Boolean;
        GatePassLine: Record "SSD Gate Pass Line";
    begin
        ItemLedgerEntry1.Reset;
        ItemLedgerEntry1.SetRange("Document No.", InvoiceNo);
        ItemLedgerEntry1.SetRange("Item No.", ItemNo);
        ItemLedgerEntry1.SetRange("Lot No.", LotNo);
        ItemLedgerEntry1.SetRange(Positive, false);
        if ItemLedgerEntry1.FindFirst then begin
            if ItemLedgerEntry1."Inv. Lot Scanned" then
                exit('Lot already scanned!')
            else begin
                ItemLedgerEntry1."Inv. Lot Scanned" := true;
                ItemLedgerEntry1.Modify;
                ILEAllLotScanned := true;
                ItemLedgerEntry.Reset;
                ItemLedgerEntry.SetRange("Document No.", InvoiceNo);
                ItemLedgerEntry.SetRange("Inv. Lot Scanned", false);
                ItemLedgerEntry.SetRange(Positive, false);
                if ItemLedgerEntry.FindFirst then ILEAllLotScanned := false;
                if ILEAllLotScanned then begin
                    GatePassLine.Reset;
                    GatePassLine.SetRange("No.", GatePassNo);
                    GatePassLine.SetRange("Invoice No.", InvoiceNo);
                    if GatePassLine.FindFirst then begin
                        GatePassLine."ILE Lot Scanned" := true;
                        GatePassLine.Modify;
                    end;
                end;
                exit('Lot Scanned Successfully.');
            end;
        end
        else
            exit('Lot Does Not Exist!');
    end;

    procedure UpdateGatePassTransOrder(GatePassNo: Code[20]; Date: Text; Time: Text; VechicleNo: Code[20]; DriverName: Code[20]; TransporterCode: Code[20]; BiltyNo: Code[20]; MobNo: Code[20]; InvoiceNo: Code[20]): Boolean
    var
        GatePassLine: Record "SSD Gate Pass Line";
        GatePassHeader: Record "SSD Gate Pass Header";
        //IG_DS  NoSeriesManagement: Codeunit NoSeriesManagement;
        TransferShipmentHeader: Record "Transfer Shipment Header";
        LineNo: Integer;
        TransferShipmentLine: Record "Transfer Shipment Line";
        GatePassLine1: Record "SSD Gate Pass Line";
        NetWt: Decimal;
        GrossWt: Decimal;
        InvAmt: Decimal;
        Item: Record Item;
        RecDate: Date;
        Day: Integer;
        Month: Integer;
        Year: Integer;
        UserSetup: Record "User Setup";
    begin
        Day := 0;
        Month := 0;
        Year := 0;
        Evaluate(Day, CopyStr(Date, 1, 2));
        Evaluate(Month, CopyStr(Date, 3, 2));
        Evaluate(Year, CopyStr(Date, 5, 4));
        Date_gDate := 0D;
        Date_gDate := Dmy2date(Day, Month, Year);
        Time_gTime := 0T;
        Evaluate(Time_gTime, Time);
        if UserSetup.Get(UserId) then;
        GatePassHeader.Reset;
        GatePassHeader.SetRange("No.", GatePassNo);
        if GatePassHeader.FindFirst then begin
            GatePassHeader.Validate(Date, Date_gDate);
            GatePassHeader.Validate("Gate Pass Time", Time_gTime);
            GatePassHeader.Validate("Vehicle No.", VechicleNo);
            GatePassHeader.Validate("Driver Name", DriverName);
            GatePassHeader.Validate("Transporter Code", TransporterCode);
            GatePassHeader.Validate("Bilty No.", BiltyNo);
            GatePassHeader.Validate("Mobile No.", MobNo);
            GatePassHeader.Validate("Responsibility Center", UserSetup."Responsibility Center");
            GatePassHeader.Modify;
        end;
        NetWt := 0;
        GrossWt := 0;
        InvAmt := 0;
        TransferShipmentHeader.Reset;
        TransferShipmentHeader.SetRange("No.", InvoiceNo);
        TransferShipmentHeader.SetRange("Gate Pass", false);
        if TransferShipmentHeader.FindFirst then begin
            TransferShipmentLine.Reset;
            TransferShipmentLine.SetRange("Document No.", TransferShipmentHeader."No.");
            if TransferShipmentLine.FindSet then
                repeat
                    if Item.Get(TransferShipmentLine."Item No.") then;
                    NetWt += (Item."Net Weight" * TransferShipmentLine.Quantity);
                    GrossWt += (Item."Gross Weight" * TransferShipmentLine.Quantity);
                    InvAmt += TransferShipmentLine.Amount;
                until TransferShipmentLine.Next = 0;
            GatePassLine1.Reset;
            GatePassLine1.SetRange("No.", GatePassHeader."No.");
            if GatePassLine1.FindLast then
                LineNo := GatePassLine1."Line No." + 10000
            else
                LineNo := 10000;
            GatePassLine.Init;
            GatePassLine.Validate("No.", GatePassHeader."No.");
            GatePassLine.Validate("Invoice No.", TransferShipmentHeader."No.");
            GatePassLine.Validate("Line No.", LineNo);
            GatePassLine.Validate("Invoice Date", TransferShipmentHeader."Posting Date");
            GatePassLine."Customer No." := TransferShipmentHeader."Transfer-to Code";
            GatePassLine.Validate("Customer Name", TransferShipmentHeader."Transfer-to Name");
            GatePassLine.Validate("Invoice Amount", InvAmt);
            GatePassLine.Validate("Net Wt.", NetWt);
            GatePassLine.Validate("Gross Wt.", GrossWt);
            //GatePassLine.VALIDATE("No. Of Cartons",TransferShipmentLine."No of Pack");
            GatePassLine.Insert;
        end;
        exit(true);
    end;

    procedure UpdateGatePassPurCreditMemo(GatePassNo: Code[20]; Date: Text; Time: Text; VechicleNo: Code[20]; DriverName: Code[20]; TransporterCode: Code[20]; BiltyNo: Code[20]; MobNo: Code[20]; InvoiceNo: Code[20]): Boolean
    var
        GatePassLine: Record "SSD Gate Pass Line";
        GatePassHeader: Record "SSD Gate Pass Header";
        //IG_DS NoSeriesManagement: Codeunit NoSeriesManagement;
        PurchCrMemoHdr: Record "Purch. Cr. Memo Hdr.";
        LineNo: Integer;
        PurchCrMemoLine: Record "Purch. Cr. Memo Line";
        GatePassLine1: Record "SSD Gate Pass Line";
        UserSetup: Record "User Setup";
        ItemPurCredit: Record Item;
        NetWeight: Decimal;
        GrossWeight: Decimal;
    begin
        Day := 0;
        Month := 0;
        YEar := 0;
        Evaluate(Day, CopyStr(Date, 1, 2));
        Evaluate(Month, CopyStr(Date, 3, 2));
        Evaluate(YEar, CopyStr(Date, 5, 4));
        Date_gDate := 0D;
        Date_gDate := Dmy2date(Day, Month, YEar);
        Time_gTime := 0T;
        Evaluate(Time_gTime, Time);
        if UserSetup.Get(UserId) then;
        GatePassHeader.Reset;
        GatePassHeader.SetRange("No.", GatePassNo);
        if GatePassHeader.FindFirst then begin
            GatePassHeader.Validate(Date, Date_gDate);
            GatePassHeader.Validate("Gate Pass Time", Time_gTime);
            GatePassHeader.Validate("Vehicle No.", VechicleNo);
            GatePassHeader.Validate("Driver Name", DriverName);
            GatePassHeader.Validate("Transporter Code", TransporterCode);
            GatePassHeader.Validate("Bilty No.", BiltyNo);
            GatePassHeader.Validate("Mobile No.", MobNo);
            GatePassHeader.Validate("Responsibility Center", UserSetup."Responsibility Center");
            GatePassHeader.Modify;
        end;
        if UserSetup.Get(UserId) then;
        PurchCrMemoHdr.Reset;
        PurchCrMemoHdr.SetRange("No.", InvoiceNo);
        PurchCrMemoHdr.SetRange("Gate Pass", false);
        //PurchCrMemoHdr.SETRANGE("Responsibility Center",UserSetup."Responsibility Center");
        if PurchCrMemoHdr.FindFirst then begin
            //SSD PurchCrMemoHdr.CalcFields("Amount to Vendor");
            PurchCrMemoLine.Reset;
            PurchCrMemoLine.SetRange("Document No.", PurchCrMemoHdr."No.");
            PurchCrMemoLine.SetFilter(Type, '<>%1', PurchCrMemoLine.Type::" ");
            if PurchCrMemoLine.FindSet then
                repeat
                    if ItemPurCredit.Get(PurchCrMemoLine."No.") then;
                    NetWeight += (ItemPurCredit."Net Weight" * PurchCrMemoLine.Quantity);
                    GrossWeight += (ItemPurCredit."Gross Weight" * PurchCrMemoLine.Quantity);
                until PurchCrMemoLine.Next = 0;
            GatePassLine1.Reset;
            GatePassLine1.SetRange("No.", GatePassHeader."No.");
            if GatePassLine1.FindLast then
                LineNo := GatePassLine1."Line No." + 10000
            else
                LineNo := 10000;
            GatePassLine.Init;
            GatePassLine.Validate("No.", GatePassHeader."No.");
            GatePassLine.Validate("Invoice No.", PurchCrMemoHdr."No.");
            GatePassLine.Validate("Line No.", LineNo);
            GatePassLine.Validate("Invoice Date", PurchCrMemoHdr."Posting Date");
            GatePassLine."Customer No." := PurchCrMemoHdr."Pay-to Vendor No.";
            GatePassLine.Validate("Customer Name", PurchCrMemoHdr."Pay-to Name");
            //SSD GatePassLine.Validate("Invoice Amount", PurchCrMemoHdr."Amount to Vendor");
            GatePassLine.Validate("Net Wt.", NetWeight);
            GatePassLine.Validate("Gross Wt.", GrossWeight);
            //GatePassLine.VALIDATE("No. Of Cartons",PurchCrMemoLine."No of Pack");
            GatePassLine.Insert;
        end;
        exit(true);
    end;

    procedure UpdateGatePassRGP(GatePassNo: Code[20]; Date: Text; Time: Text; VechicleNo: Code[20]; DriverName: Code[20]; TransporterCode: Code[20]; BiltyNo: Code[20]; MobNo: Code[20]; InvoiceNo: Code[20]): Boolean
    var
        GatePassLine: Record "SSD Gate Pass Line";
        GatePassHeader: Record "SSD Gate Pass Header";
        //IG_DS  NoSeriesManagement: Codeunit NoSeriesManagement;
        RGPShipmentHeader: Record "SSD RGP Shipment Header";
        LineNo: Integer;
        RGPShipmentLine: Record "SSD RGP Shipment Line";
        GatePassLine1: Record "SSD Gate Pass Line";
        UserSetup: Record "User Setup";
        ItemRGP: Record Item;
        NetWht: Decimal;
        GrossWht: Decimal;
        InvAmt: Decimal;
    begin
        Day := 0;
        Month := 0;
        YEar := 0;
        Evaluate(Day, CopyStr(Date, 1, 2));
        Evaluate(Month, CopyStr(Date, 3, 2));
        Evaluate(YEar, CopyStr(Date, 5, 4));
        Date_gDate := 0D;
        Date_gDate := Dmy2date(Day, Month, YEar);
        Time_gTime := 0T;
        Evaluate(Time_gTime, Time);
        if UserSetup.Get(UserId) then;
        GatePassHeader.Reset;
        GatePassHeader.SetRange("No.", GatePassNo);
        if GatePassHeader.FindFirst then begin
            GatePassHeader.Validate(Date, Date_gDate);
            GatePassHeader.Validate("Gate Pass Time", Time_gTime);
            GatePassHeader.Validate("Vehicle No.", VechicleNo);
            GatePassHeader.Validate("Driver Name", DriverName);
            GatePassHeader.Validate("Transporter Code", TransporterCode);
            GatePassHeader.Validate("Bilty No.", BiltyNo);
            GatePassHeader.Validate("Mobile No.", MobNo);
            GatePassHeader.Validate("Responsibility Center", UserSetup."Responsibility Center");
            GatePassHeader.Modify;
        end;
        if UserSetup.Get(UserId) then;
        RGPShipmentHeader.Reset;
        RGPShipmentHeader.SetRange("No.", InvoiceNo);
        RGPShipmentHeader.SetRange("Gate Pass", false);
        RGPShipmentHeader.SetRange(NRGP, false);
        //RGPShipmentHeader.SETRANGE("Responsibility Center",UserSetup."Responsibility Center");
        if RGPShipmentHeader.FindFirst then begin
            RGPShipmentLine.Reset;
            RGPShipmentLine.SetRange("Document No.", RGPShipmentHeader."No.");
            RGPShipmentLine.SetFilter(Type, '<>%1', RGPShipmentLine.Type::" ");
            if RGPShipmentLine.FindSet then
                repeat
                    if ItemRGP.Get(RGPShipmentLine."No.") then;
                    NetWht += (ItemRGP."Net Weight" * RGPShipmentLine.Quantity);
                    GrossWht += (ItemRGP."Gross Weight" * RGPShipmentLine.Quantity);
                    InvAmt += RGPShipmentLine."Line Amount";
                until RGPShipmentLine.Next = 0;
            GatePassLine1.Reset;
            GatePassLine1.SetRange("No.", GatePassHeader."No.");
            if GatePassLine1.FindLast then
                LineNo := GatePassLine1."Line No." + 10000
            else
                LineNo := 10000;
            GatePassLine.Init;
            GatePassLine.Validate("No.", GatePassHeader."No.");
            GatePassLine.Validate("Invoice No.", RGPShipmentHeader."No.");
            GatePassLine.Validate("Line No.", LineNo);
            GatePassLine.Validate("Invoice Date", RGPShipmentHeader."Posting Date");
            GatePassLine."Customer No." := RGPShipmentHeader."Party No.";
            GatePassLine.Validate("Customer Name", RGPShipmentHeader."Party Name");
            GatePassLine.Validate("Invoice Amount", InvAmt);
            GatePassLine.Validate("Net Wt.", NetWht);
            GatePassLine.Validate("Gross Wt.", GrossWht);
            GatePassLine.Validate("ILE Lot Scanned", true);
            //GatePassLine.VALIDATE("No. Of Cartons",RGPShipmentLine."No of Pack");
            GatePassLine.Insert;
        end;
        exit(true);
    end;

    procedure UpdateGatePassNRGP(GatePassNo: Code[20]; Date: Text; Time: Text; VechicleNo: Code[20]; DriverName: Code[20]; TransporterCode: Code[20]; BiltyNo: Code[20]; MobNo: Code[20]; InvoiceNo: Code[20]): Boolean
    var
        GatePassLine: Record "SSD Gate Pass Line";
        GatePassHeader: Record "SSD Gate Pass Header";
        //IG_DS NoSeriesManagement: Codeunit NoSeriesManagement;
        RGPShipmentHeader: Record "SSD RGP Shipment Header";
        LineNo: Integer;
        RGPShipmentLine: Record "SSD RGP Shipment Line";
        GatePassLine1: Record "SSD Gate Pass Line";
        UserSetup: Record "User Setup";
        ItemRGP: Record Item;
        NetWht: Decimal;
        GrossWht: Decimal;
        InvAmt: Decimal;
    begin
        Day := 0;
        Month := 0;
        YEar := 0;
        Evaluate(Day, CopyStr(Date, 1, 2));
        Evaluate(Month, CopyStr(Date, 3, 2));
        Evaluate(YEar, CopyStr(Date, 5, 4));
        Date_gDate := 0D;
        Date_gDate := Dmy2date(Day, Month, YEar);
        Time_gTime := 0T;
        Evaluate(Time_gTime, Time);
        if UserSetup.Get(UserId) then;
        GatePassHeader.Reset;
        GatePassHeader.SetRange("No.", GatePassNo);
        if GatePassHeader.FindFirst then begin
            GatePassHeader.Validate(Date, Date_gDate);
            GatePassHeader.Validate("Gate Pass Time", Time_gTime);
            GatePassHeader.Validate("Vehicle No.", VechicleNo);
            GatePassHeader.Validate("Driver Name", DriverName);
            GatePassHeader.Validate("Transporter Code", TransporterCode);
            GatePassHeader.Validate("Bilty No.", BiltyNo);
            GatePassHeader.Validate("Mobile No.", MobNo);
            GatePassHeader.Validate("Responsibility Center", UserSetup."Responsibility Center");
            GatePassHeader.Modify;
        end;
        if UserSetup.Get(UserId) then;
        RGPShipmentHeader.Reset;
        RGPShipmentHeader.SetRange("No.", InvoiceNo);
        RGPShipmentHeader.SetRange("Gate Pass", false);
        RGPShipmentHeader.SetRange(NRGP, true);
        //RGPShipmentHeader.SETRANGE("Responsibility Center",UserSetup."Responsibility Center");
        if RGPShipmentHeader.FindFirst then begin
            RGPShipmentLine.Reset;
            RGPShipmentLine.SetRange("Document No.", RGPShipmentHeader."No.");
            RGPShipmentLine.SetFilter(Type, '<>%1', RGPShipmentLine.Type::" ");
            if RGPShipmentLine.FindSet then
                repeat
                    if ItemRGP.Get(RGPShipmentLine."No.") then;
                    NetWht += (ItemRGP."Net Weight" * RGPShipmentLine.Quantity);
                    GrossWht += (ItemRGP."Gross Weight" * RGPShipmentLine.Quantity);
                    InvAmt += RGPShipmentLine."Line Amount";
                until RGPShipmentLine.Next = 0;
            GatePassLine1.Reset;
            GatePassLine1.SetRange("No.", GatePassHeader."No.");
            if GatePassLine1.FindLast then
                LineNo := GatePassLine1."Line No." + 10000
            else
                LineNo := 10000;
            GatePassLine.Init;
            GatePassLine.Validate("No.", GatePassHeader."No.");
            GatePassLine.Validate("Invoice No.", RGPShipmentHeader."No.");
            GatePassLine.Validate("Line No.", LineNo);
            GatePassLine.Validate("Invoice Date", RGPShipmentHeader."Posting Date");
            GatePassLine."Customer No." := RGPShipmentHeader."Party No.";
            GatePassLine.Validate("Customer Name", RGPShipmentHeader."Party Name");
            GatePassLine.Validate("Invoice Amount", InvAmt);
            GatePassLine.Validate("Net Wt.", NetWht);
            GatePassLine.Validate("Gross Wt.", GrossWht);
            GatePassLine.Validate("ILE Lot Scanned", true);
            //GatePassLine.VALIDATE("No. Of Cartons",RGPShipmentLine."No of Pack");
            GatePassLine.Insert;
        end;
        exit(true);
    end;

    procedure CheckPhyBinQty(ItemNo: Code[20]; LotNo: Code[20]; BinCode: Code[20]; LocationCode: Code[20]; PhyBinCode: Code[20]): Decimal
    var
        Qty: Decimal;
        ItemPhyBinDetails: Record "SSD Item Phy. Bin Details";
        Flag: Boolean;
    begin
        Qty := 0;
        Flag := false;
        ItemPhyBinDetails.Reset;
        ItemPhyBinDetails.SetCurrentkey("Item No.", "Location Code", "Bin Code");
        ItemPhyBinDetails.SetRange("Item No.", ItemNo);
        ItemPhyBinDetails.SetRange("Location Code", LocationCode);
        ItemPhyBinDetails.SetRange("Bin Code", BinCode);
        ItemPhyBinDetails.SetRange("Phy. Bin Code", PhyBinCode);
        ItemPhyBinDetails.SetRange("Lot No.", LotNo);
        ItemPhyBinDetails.SetFilter("Whse. Entry  No.", '<>%1', 0);
        if ItemPhyBinDetails.FindSet then
            repeat
                Qty += ItemPhyBinDetails."ILE Quantity";
                Flag := true;
            until ItemPhyBinDetails.Next = 0;
        if Flag then
            exit(Qty)
        else
            exit(0);
    end;

    procedure CheckPackingForSalesInvoice(GatePassNo: Code[20]; InvoiceNo: Code[20]; ItemNo: Code[20]; LotNo: Code[20]; Qty: Decimal): Text
    var
        ItemLedgerEntry: Record "Item Ledger Entry";
        ValueEntry: Record "Value Entry";
        ILEDocNo: Code[20];
        CopyofPacking: Record "SSD Copy of Packing";
        CopyofPacking1: Record "SSD Copy of Packing";
        ILEAllLotScanned: Boolean;
        GatePassLine: Record "SSD Gate Pass Line";
        SalesInvoiceLine: Record "Sales Invoice Line";
        DispatchNo: Code[20];
        RemainingCount: Integer;
        TotalCount: Integer;
    begin
        //Gate Pass For Posted sales invoice
        DispatchNo := '';
        SalesInvoiceLine.Reset;
        SalesInvoiceLine.SetRange("Document No.", InvoiceNo);
        SalesInvoiceLine.SetRange(Type, SalesInvoiceLine.Type::Item);
        SalesInvoiceLine.SetRange("No.", ItemNo);
        if SalesInvoiceLine.FindFirst then DispatchNo := SalesInvoiceLine."Despatch Slip No.";
        CopyofPacking.Reset;
        CopyofPacking.SetRange("Document No.", DispatchNo);
        //CopyofPacking.SETRANGE("Item No.",ItemNo);
        TotalCount := CopyofPacking.Count;
        CopyofPacking.SetRange(Scanned, false);
        RemainingCount := CopyofPacking.Count;
        CopyofPacking.SetRange("Lot No.", LotNo);
        CopyofPacking.SetRange(Quantity, Qty);
        if CopyofPacking.FindFirst then begin
            CopyofPacking.Scanned := true;
            CopyofPacking.Modify;
            ILEAllLotScanned := false;
            /*
            CopyofPacking1.RESET;
            CopyofPacking1.SETRANGE("Document No.",DispatchNo);
            CopyofPacking1.SETRANGE("Item No.",ItemNo);
            CopyofPacking1.SETRANGE(Quantity,Qty);
            CopyofPacking1.SETRANGE(Scanned,FALSE);
            IF CopyofPacking1.FINDFIRST THEN
            */
            if RemainingCount = 1 then ILEAllLotScanned := true;
            if ILEAllLotScanned then begin
                GatePassLine.Reset;
                GatePassLine.SetRange("No.", GatePassNo);
                GatePassLine.SetRange("Invoice No.", InvoiceNo);
                if GatePassLine.FindFirst then begin
                    GatePassLine."ILE Lot Scanned" := true;
                    GatePassLine.Modify;
                end;
            end;
            exit('Lot Scanned Successfully. Remaining ' + Format(RemainingCount - 1) + '/' + Format(TotalCount));
        end
        else
            exit('Lot already scanned or data is wrong!');
    end;

    procedure DeleteInvoiceLine(GatePassNo: Code[20]; InvoiceNo: Code[20]): Text[30]
    var
        GatePassLine: Record "SSD Gate Pass Line";
        Deleted: Boolean;
    begin
        Deleted := false;
        GatePassLine.Reset;
        GatePassLine.SetRange("No.", GatePassNo);
        GatePassLine.SetRange("Invoice No.", InvoiceNo);
        if GatePassLine.FindFirst then begin
            GatePassLine.Delete;
            Deleted := true;
        end;
        if Deleted then exit('Invoice Deleted !');
    end;

    procedure PostGatePass(GatePassNo: Code[20]): Boolean
    var
        GatePassLine1: Record "SSD Gate Pass Line";
        GatePassScanned: Boolean;
        GatePassHeader: Record "SSD Gate Pass Header";
        SalesInvoiceLine: Record "Sales Invoice Line";
        DespatchNo: Code[20];
        CopyofPacking: Record "SSD Copy of Packing";
        SalesInvoiceHeader: Record "Sales Invoice Header";
        PostedSalesInvoice: Page "Posted Sales Invoice";
    begin
        GatePassScanned := true;
        GatePassHeader.Reset;
        GatePassHeader.SetRange("No.", GatePassNo);
        GatePassHeader.SetRange("Document Type", GatePassHeader."document type"::"Sales Invoice");
        if GatePassHeader.FindFirst then begin
            GatePassLine1.Reset;
            GatePassLine1.SetRange("No.", GatePassHeader."No.");
            if GatePassLine1.FindSet then
                repeat
                    DespatchNo := '';
                    SalesInvoiceLine.Reset;
                    SalesInvoiceLine.SetRange("Document No.", GatePassLine1."Invoice No.");
                    SalesInvoiceLine.SetRange(Type, SalesInvoiceLine.Type::Item);
                    if SalesInvoiceLine.FindFirst then DespatchNo := SalesInvoiceLine."Despatch Slip No.";
                    CopyofPacking.Reset;
                    CopyofPacking.SetRange("Document No.", DespatchNo);
                    CopyofPacking.SetRange(Scanned, false);
                    if not CopyofPacking.FindFirst then begin
                        GatePassLine1."ILE Lot Scanned" := true;
                        GatePassLine1.Modify;
                    end;
                until GatePassLine1.Next = 0;
        end;
        GatePassLine1.Reset;
        GatePassLine1.SetRange("No.", GatePassNo);
        GatePassLine1.SetRange("ILE Lot Scanned", false);
        if GatePassLine1.FindFirst then GatePassScanned := false;
        GatePassLine1.Reset;
        GatePassLine1.SetRange("No.", GatePassNo);
        if GatePassLine1.IsEmpty then GatePassScanned := false;
        if GatePassScanned then begin
            GatePassHeader.Reset;
            GatePassHeader.SetRange("No.", GatePassNo);
            GatePassHeader.SetRange("Document Type", GatePassHeader."document type"::"Sales Invoice");
            if GatePassHeader.FindFirst then begin
                GatePassLine1.Reset;
                GatePassLine1.SetRange("No.", GatePassHeader."No.");
                if GatePassLine1.FindSet then
                    repeat
                        SalesInvoiceHeader.Reset; //Alle 19032021
                        SalesInvoiceHeader.SetRange("No.", GatePassLine1."Invoice No.");
                        if SalesInvoiceHeader.FindFirst then begin
                            if GatePassLine1."LR/RR No." <> '' then //ALle 22032021
                                SalesInvoiceHeader."LR/RR No." := GatePassLine1."LR/RR No.";
                            SalesInvoiceHeader."LR/RR Date" := GatePassLine1."LR/RR Date";
                            SalesInvoiceHeader.Modify;
                        end;
                    // PostedSalesInvoice.SendSMS1(SalesInvoiceHeader); //CORP::PK 220520
                    until GatePassLine1.Next = 0;
            end; //CORP::PK 160120
            GatePassHeader.Reset;
            GatePassHeader.SetRange("No.", GatePassNo);
            if GatePassHeader.FindFirst then begin
                GatePassHeader.Posted := true;
                //GatePassHeader."User Details" := UserDetail;
                GatePassHeader.Modify;
            end;
            exit(true);
        end
        else
            exit(false);
    end;

    procedure UpdateGatePassSalesInv(GatePassNo: Code[20]; Date: Text; Time: Text; VechicleNo: Code[20]; DriverName: Code[20]; TransporterCode: Code[20]; BiltyNo: Code[20]; MobNo: Code[20]; InvoiceNo: Code[20]; LRRRNo: Code[20]; LRRRDate: Text): Boolean
    var
        GatePassLine: Record "SSD Gate Pass Line";
        GatePassHeader: Record "SSD Gate Pass Header";
        //IG_DS  NoSeriesManagement: Codeunit NoSeriesManagement;
        SalesInvoiceHeader: Record "Sales Invoice Header";
        LineNo: Integer;
        SalesInvoiceLine: Record "Sales Invoice Line";
        GatePassLine1: Record "SSD Gate Pass Line";
        UserSetup: Record "User Setup";
        TotalBox: Integer;
        TotalGrossWT: Decimal;
        TotalNetWT: Decimal;
        SalesInvoiceLine1: Record "Sales Invoice Line";
        DespLine: Record "Sales Line";
        GatePassLine2: Record "SSD Gate Pass Line";
    begin
        Day := 0;
        Month := 0;
        YEar := 0;
        Evaluate(Day, CopyStr(Date, 1, 2));
        Evaluate(Month, CopyStr(Date, 3, 2));
        Evaluate(YEar, CopyStr(Date, 5, 4));
        Date_gDate := 0D;
        Date_gDate := Dmy2date(Day, Month, YEar);
        Time_gTime := 0T;
        Evaluate(Time_gTime, Time);
        if LRRRDate <> '' then begin
            Day := 0;
            Month := 0;
            YEar := 0;
            Evaluate(Day, CopyStr(LRRRDate, 1, 2));
            Evaluate(Month, CopyStr(LRRRDate, 3, 2));
            Evaluate(YEar, CopyStr(LRRRDate, 5, 4));
            LRRRDate1 := 0D;
            LRRRDate1 := Dmy2date(Day, Month, YEar);
        end
        else
            LRRRDate1 := 0D;
        if UserSetup.Get(UserId) then;
        GatePassHeader.Reset;
        GatePassHeader.SetRange("No.", GatePassNo);
        if GatePassHeader.FindFirst then begin
            GatePassHeader.Validate(Date, Date_gDate);
            GatePassHeader.Validate("Gate Pass Time", Time_gTime);
            GatePassHeader.Validate("Vehicle No.", VechicleNo);
            GatePassHeader.Validate("Driver Name", DriverName);
            GatePassHeader.Validate("Transporter Code", TransporterCode);
            GatePassHeader.Validate("Bilty No.", BiltyNo);
            GatePassHeader.Validate("Mobile No.", MobNo);
            GatePassHeader.Validate("Responsibility Center", UserSetup."Responsibility Center");
            GatePassHeader.Modify;
            GatePassLine2.Reset;
            GatePassLine2.SetRange("No.", GatePassHeader."No.");
            GatePassLine2.SetRange("Invoice No.", InvoiceNo);
            if GatePassLine2.FindFirst then begin
                GatePassLine2."LR/RR No." := LRRRNo;
                GatePassLine2."LR/RR Date" := LRRRDate1;
                GatePassLine2.Modify;
            end;
        end;
        SalesInvoiceHeader.Reset;
        SalesInvoiceHeader.SetRange("No.", InvoiceNo);
        SalesInvoiceHeader.SetRange("Gate Pass", false);
        SalesInvoiceHeader.SetRange("Responsibility Center", UserSetup."Responsibility Center");
        if SalesInvoiceHeader.FindFirst then begin
            //SSD SalesInvoiceHeader.CalcFields("Amount to Customer");
            SalesInvoiceLine.Reset;
            SalesInvoiceLine.SetRange("Document No.", SalesInvoiceHeader."No.");
            SalesInvoiceLine.SetFilter(Type, '<>%1', SalesInvoiceLine.Type::" ");
            if SalesInvoiceLine.FindFirst then;
            GatePassLine1.Reset;
            GatePassLine1.SetRange("No.", GatePassHeader."No.");
            if GatePassLine1.FindLast then
                LineNo := GatePassLine1."Line No." + 10000
            else
                LineNo := 10000;
            TotalBox := 0;
            TotalGrossWT := 0;
            TotalNetWT := 0;
            SalesInvoiceLine1.Reset;
            SalesInvoiceLine1.SetRange("Document No.", SalesInvoiceHeader."No.");
            if SalesInvoiceLine1.FindSet then
                repeat //TotalNetWT+= SalesInvoiceLine."Net Weight";
                    TotalNetWT += SalesInvoiceLine1."Actual Wt";
                    if DespLine.Get(DespLine."document type"::Order, SalesInvoiceLine1."Despatch Slip No.", SalesInvoiceLine1."Despatch Slip Line No.") then begin
                        DespLine.CalcFields("No of Pack");
                        DespLine.CalcFields("Gross Wt");
                        TotalBox += DespLine."No of Pack";
                        TotalGrossWT += DespLine."Gross Wt";
                    end;
                until SalesInvoiceLine1.Next = 0;
            GatePassLine.Init;
            GatePassLine.Validate("No.", GatePassHeader."No.");
            GatePassLine.Validate("Invoice No.", SalesInvoiceHeader."No.");
            GatePassLine.Validate("Line No.", LineNo);
            GatePassLine.Validate("Invoice Date", SalesInvoiceHeader."Posting Date");
            GatePassLine."Customer No." := SalesInvoiceHeader."Sell-to Customer No.";
            GatePassLine.Validate("Customer Name", SalesInvoiceHeader."Sell-to Customer Name");
            //SSD GatePassLine.Validate("Invoice Amount", SalesInvoiceHeader."Amount to Customer");
            GatePassLine.Validate("Net Wt.", TotalNetWT);
            GatePassLine.Validate("Gross Wt.", TotalGrossWT);
            GatePassLine.Validate("No. Of Cartons", TotalBox);
            GatePassLine.Validate("LR/RR No.", LRRRNo); //CORP::PK 160120
            GatePassLine.Validate("LR/RR Date", LRRRDate1); //CORP::PK 160120
            GatePassLine.Insert;
        end;
        exit(true);
    end;
}
