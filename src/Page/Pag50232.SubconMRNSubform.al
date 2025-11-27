Page 50232 "Subcon MRN Subform"
{
    // 
    // CEN004.06 function Create
    // ALLEAA CML-033 280308
    //   - Added New Form
    AutoSplitKey = true;
    DelayedInsert = true;
    DeleteAllowed = false;
    InsertAllowed = false;
    MultipleNewLines = true;
    PageType = ListPart;
    Permissions = TableData "Purch. Rcpt. Header" = rimd,
        TableData "Purch. Rcpt. Line" = rimd;
    SourceTable = "SSD RGP Line";
    SourceTableView = where("Document Type" = filter("RGP Inbound"));
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Control1000000000)
            {
                field(Type; Rec.Type)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("No. 2"; Rec."No. 2")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Grade; Rec.Grade)
                {
                    ApplicationArea = All;
                    Editable = false;
                    Visible = false;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Visible = false;
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Visible = false;
                }
                field("Quantity to Ship"; Rec."Quantity to Ship")
                {
                    ApplicationArea = All;
                }
                field(Quantity; Rec.Quantity)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Quantity to Receive"; Rec."Quantity to Receive")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Unit Of Measure Code"; Rec."Unit Of Measure Code")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Location Code"; Rec."Location Code")
                {
                    ApplicationArea = All;
                    Caption = 'Subcontracting Location';
                }
                field("Bin Code"; Rec."Bin Code")
                {
                    ApplicationArea = All;
                    Caption = 'Subcontracting Bin';
                }
                field("New Location Code"; Rec."New Location Code")
                {
                    ApplicationArea = All;
                    Caption = 'Company Location';
                }
                field("New Bin Code"; Rec."New Bin Code")
                {
                    ApplicationArea = All;
                    Caption = 'Company Bin';
                }
                field("Unit Cost"; Rec."Unit Cost")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Qty. Consumed"; Rec."Qty. Consumed")
                {
                    ApplicationArea = All;
                }
                field("Generate Scrap"; Rec."Generate Scrap")
                {
                    ApplicationArea = All;
                }
                field("Scrap Item"; Rec."Scrap Item")
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
                field("Scrap Generated"; Rec."Scrap Generated")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Quantity Received"; Rec."Quantity Received")
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

                action("Line Detail")
                {
                    ApplicationArea = All;
                    Caption = 'Line Detail';

                    trigger OnAction()
                    begin
                        //This functionality was copied from page #50231. Unsupported part was commented. Please check it.
                        /*CurrPage.SubRGPHeader.PAGE.*/
                        RGPDetail;
                    end;
                }
                action("Related BOM")
                {
                    ApplicationArea = All;
                    Caption = 'Related BOM';

                    trigger OnAction()
                    begin
                        //This functionality was copied from page #50231. Unsupported part was commented. Please check it.
                        /*CurrPage.SubRGPHeader.PAGE.*/
                        showprodbomfrm;
                    end;
                }
            }
        }
    }
    trigger OnNewRecord(BelowxRec: Boolean)
    var
        UserSetup: Record "User Setup";
    begin
        Rec.Type := xRec.Type;
        //MUA01 Starts
        if UserSetup.Get(UserId) then Rec."Responsibility Center" := UserSetup."Responsibility Center";
        //MUA01 Ends
    end;

    var
        Text001: label 'You can''t Reopen the Document. Document is writeOff.';
        ItemLedgEntry: Record "Item Ledger Entry";
        ItemLedgEntryFrm: Page "Item Ledg. Entries";
        ItemLedgEntryBuff: Record "SSD Item Ledger Entry Buffer";
        ActiveVersionCode: Code[20];
        VersionMgt: Codeunit VersionManagement;
        ScrapItemJnlLine: Record "Item Journal Line";
        LineNo: Integer;
        VendorBillNo: Text[30];
        LNo: Integer;
        ProductionBOM: Page "Production BOM";
        ProductionBOMHeader: Record "Production BOM Header";

    procedure CheckWriteOff()
    begin
        //*********CEN004.06*********
        if Rec."Write Off" = true then Error(Text001);
    end;

    procedure RGPDetail()
    var
        RecRGPDetail: Record "SSD RGP Line Detail";
        FrmRGPdetails: Page "RGP Line Details";
    begin
        //***********CEN006***************
        if Rec."No." <> '' then begin
            RecRGPDetail.Reset;
            RecRGPDetail.SetRange(RecRGPDetail."Document Type", Rec."Document Type");
            RecRGPDetail.SetRange(RecRGPDetail."Document No.", Rec."Document No.");
            RecRGPDetail.SetRange(RecRGPDetail."Item No.", Rec."No.");
            RecRGPDetail.SetRange(RecRGPDetail."Line No.", Rec."Line No.");
            Clear(FrmRGPdetails);
            FrmRGPdetails.InitialValues(Rec."Document Type", Rec."Document No.", Rec."No.", Rec."Line No.");
            FrmRGPdetails.SetRecord(RecRGPDetail);
            FrmRGPdetails.SetTableview(RecRGPDetail);
            FrmRGPdetails.RunModal;
        end;
    end;

    procedure CreateNRGP(var RGPHeader: Record "SSD RGP Header")
    var
        ItemLocal: Record Item;
        NRGPHeader: Record "SSD RGP Header";
        NRGPLine: Record "SSD RGP Line";
        ResponsibilityCenter: Record "Responsibility Center";
        NoSeriesMgt: Codeunit "No. Series";//IG_DS NoSeriesManagement;
        DocNo: Code[20];
        RGPLine: Record "SSD RGP Line";
    begin
        //>>CEN004.06
        NRGPHeader.Init;
        if ResponsibilityCenter.Get(RGPHeader."Responsibility Center") then begin
            NRGPHeader."No." := NoSeriesMgt.GetNextNo(ResponsibilityCenter."NRGP In Nos", NRGPHeader."Posting Date", true);
            DocNo := NRGPHeader."No.";
            NRGPHeader."No. Series" := ResponsibilityCenter."NRGP In Nos";
            NRGPHeader."Posted Shpmt. No Series" := ResponsibilityCenter."Posted RGP IN Shipment Nos";
        end;
        NRGPHeader."Document Type" := Rec."document type"::"RGP Outbound";
        NRGPHeader."Party Type" := RGPHeader."Party Type";
        NRGPHeader."Reference No." := RGPHeader."No.";
        NRGPHeader.Validate(NRGPHeader."Party No.", RGPHeader."Party No.");
        NRGPHeader."Posting Date" := WorkDate;
        NRGPHeader."Document Date" := WorkDate;
        NRGPHeader."Expected Shipment Date" := WorkDate;
        NRGPHeader."Shipment Date" := WorkDate;
        NRGPHeader."Responsibility Center" := RGPHeader."Responsibility Center";
        NRGPHeader."External Document No." := RGPHeader."External Document No.";
        NRGPHeader.NRGP := true;
        NRGPHeader."Location Code" := RGPHeader."Location Code";
        NRGPHeader."Shortcut Dimension 1 Code" := RGPHeader."Shortcut Dimension 1 Code";
        NRGPHeader."Shortcut Dimension 2 Code" := RGPHeader."Shortcut Dimension 2 Code";
        NRGPHeader."Purpose Code" := RGPHeader."Purpose Code";
        NRGPHeader."Purpose Description" := RGPHeader."Purpose Description";
        NRGPHeader."Advising Employee" := RGPHeader."Advising Employee";
        NRGPHeader."Party Shipment/Rect. No." := RGPHeader."Party Shipment/Rect. No.";
        NRGPHeader."Party Shipment/Rect. Date" := RGPHeader."Party Shipment/Rect. Date";
        NRGPHeader."Receipt Date" := RGPHeader."Receipt Date";
        NRGPHeader."Advising Department" := RGPHeader."Advising Department";
        NRGPHeader.Validate("Advising Department");
        NRGPHeader."Advising Employee" := RGPHeader."Advising Employee";
        NRGPHeader."Delivery Mode" := RGPHeader."Delivery Mode";
        NRGPHeader."Vehical No." := RGPHeader."Vehical No.";
        NRGPHeader."Transporter No." := RGPHeader."Transporter No.";
        NRGPHeader."Transporter Name" := RGPHeader."Transporter Name";
        NRGPHeader."LR No." := RGPHeader."LR No.";
        NRGPHeader."GR No." := RGPHeader."GR No.";
        NRGPHeader."Bearer Name" := RGPHeader."Bearer Name";
        NRGPHeader."Bearer Department" := RGPHeader."Bearer Department";
        NRGPHeader."MRR No." := RGPHeader."MRR No.";
        NRGPHeader."Ship Remarks" := RGPHeader."Ship Remarks";
        NRGPHeader."Expected Shipment Date" := RGPHeader."Expected Shipment Date";
        NRGPHeader."Receipt Remarks" := RGPHeader."Receipt Remarks";
        NRGPHeader."Bin Code" := RGPHeader."Bin Code";
        NRGPHeader.Remark2 := RGPHeader.Remark2;
        NRGPHeader.Insert;
        Clear(RGPLine);
        RGPLine.Copy(Rec);
        if RGPLine.Find('-') then begin
            repeat
                NRGPLine.Init;
                NRGPLine."Document No." := NRGPHeader."No.";
                NRGPLine."Document Type" := NRGPLine."document type"::"RGP Outbound";
                NRGPLine.NRGP := true;
                NRGPLine.Type := RGPLine.Type::Item;
                NRGPLine."Line No." := RGPLine."Line No.";
                NRGPLine."Expected Receipt Date" := RGPLine."Expected Receipt Date";
                NRGPLine."Requested Receipt Date" := RGPLine."Requested Receipt Date";
                NRGPLine."Expected Shipment Date" := RGPLine."Expected Shipment Date";
                NRGPLine."Requested Shipment Date" := RGPLine."Expected Shipment Date";
                NRGPLine."In-Transit Code" := RGPLine."In-Transit Code";
                NRGPLine."Bin Code" := RGPLine."Bin Code";
                NRGPLine."Party Type" := RGPLine."Party Type";
                NRGPLine."Party No." := RGPLine."Party No.";
                NRGPLine."Posting Date" := RGPLine."Posting Date";
                NRGPLine."Shortcut Dimension 1 Code" := RGPLine."Shortcut Dimension 1 Code";
                NRGPLine."Shortcut Dimension 2 Code" := RGPLine."Shortcut Dimension 2 Code";
                NRGPLine."Location Code" := RGPLine."Location Code";
                NRGPLine."Responsibility Center" := RGPLine."Responsibility Center";
                if ItemLocal.Get(RGPLine."No.") then begin
                    ItemLocal.TestField(Blocked, false);
                    ItemLocal.TestField("Inventory Posting Group");
                    ItemLocal.TestField("Gen. Prod. Posting Group");
                    NRGPLine."No." := RGPLine."No.";
                    NRGPLine.Validate("No.");
                    NRGPLine.Validate("No.");
                    NRGPLine.Quantity := RGPLine.Quantity;
                    NRGPLine."Direct Unit Cost" := RGPLine."Direct Unit Cost";
                    NRGPLine.Validate(Quantity);
                    NRGPLine.Validate("Direct Unit Cost");
                    NRGPLine.Validate("Quantity to Ship");
                    NRGPLine.Validate("Quantity(Base)");
                    NRGPLine."User ID" := RGPLine."User ID";
                    NRGPLine."Item Category Code" := ItemLocal."Item Category Code";
                    //SSDU NRGPLine."Product Group Code" := ItemLocal."Product Group Code";
                    NRGPLine."Unit Of Measure Code" := ItemLocal."Sales Unit of Measure";
                    NRGPLine."Base Unit Of Measure" := ItemLocal."Base Unit of Measure";
                end;
                NRGPLine.Insert;
            until RGPLine.Next = 0;
            Message('%1 has been created', NRGPHeader."No.");
            RGPHeader."NRGP Created From RGP" := true;
            RGPHeader.Modify;
        end;
        //*********************CEN004.05*****************
        //<<CEN004.06
    end;

    procedure LineWriteOff()
    var
        RGPLine: Record "SSD RGP Line";
    begin
        RGPLine.Copy(Rec);
        RGPLine.SetRange("Document Type", Rec."Document Type");
        RGPLine.SetRange("Document No.", Rec."Document No.");
        RGPLine.SetRange("Write Off", true);
        RGPLine.SetFilter("Qty. to Write Off", '<>%1', 0);
        if RGPLine.FindFirst then begin
            Rec.PostWriteOff(RGPLine);
            Commit;
        end;
    end;

    procedure ShowItemLedgForm()
    var
        ProdBOMLine: Record "Production BOM Line";
        ProdBOMHead: Record "Production BOM Header";
        ItemRec: Record Item;
        TempItem: Record Item temporary;
        ItemUOMRec: Record "Item Unit of Measure";
        VendorRec: Record Vendor;
        RGPHeadRec: Record "SSD RGP Header";
        ItemLedgerEntries: Page "Item Ledg. Entries";
        DeliveryChallanLine: Record "Delivery Challan Line";
        ILEBuffer: Record "SSD Item Ledger Entry Buffer";
    begin
        ItemLedgEntryBuff.LockTable;
        ItemLedgEntryBuff.DeleteAll;
        ActiveVersionCode := VersionMgt.GetBOMVersion(Rec."No.", WorkDate, true);
        ProdBOMHead.Reset;
        Clear(TempItem);
        ProdBOMHead.SetCurrentkey("Source No.");
        ProdBOMHead.SetRange("Source No.", Rec."No.");
        if ProdBOMHead.Find('-') then begin
            ProdBOMLine.Reset;
            ProdBOMLine.SetRange("Production BOM No.", ProdBOMHead."No.");
            ProdBOMLine.SetRange("Version Code", ActiveVersionCode);
            if ProdBOMLine.Find('-') then
                repeat
                    if not TempItem.Get(ProdBOMLine."No.") then begin
                        TempItem.Init;
                        TempItem."No." := ProdBOMLine."No.";
                        TempItem.Insert;
                    end until ProdBOMLine.Next = 0;
        end;
        RGPHeadRec.Get(Rec."Document Type", Rec."Document No.");
        VendorRec.Get(RGPHeadRec."Party No.");
        ItemLedgEntry.Reset;
        ItemLedgEntry.SetCurrentkey("Location Code");
        ItemLedgEntry.SetRange("Location Code", VendorRec."Vendor Location");
        ItemLedgEntry.SetFilter("Remaining Quantity", '>%1', 0);
        if RGPHeadRec."Delivery Challan No." <> '' then //ssd
            ItemLedgEntry.SetFilter("External Document No.", '%1', RGPHeadRec."Delivery Challan No."); //ssd
        if ItemLedgEntry.Find('-') then
            repeat
                if TempItem.Get(ItemLedgEntry."Item No.") then begin
                    //ItemLedgEntry.MARK(TRUE);
                    InsertItemLedgBuff(ItemLedgEntry, ProdBOMHead);
                end until ItemLedgEntry.Next = 0;
        Commit;
        ILEBuffer.Copy(ItemLedgEntryBuff);
        if ILEBuffer.FindFirst then
            repeat
                if ILEBuffer."Max. Rec. Qty" > 1 then //ssd
                    if DeliveryChallanLine.Get(ILEBuffer."External Document No.", 10000) then if (DeliveryChallanLine."Vendor Location" = Rec."Location Code") and (DeliveryChallanLine."Vendor Bin Code" = Rec."Bin Code") and (DeliveryChallanLine."Vendor No." = Rec."Party No.") then ILEBuffer.Mark(true);
            until ILEBuffer.Next = 0;
        ILEBuffer.MarkedOnly(true);
        //ItemLedgerEntries.SETTABLEVIEW(ItemLedgEntryBuff);
        ItemLedgerEntries.SetTableview(ILEBuffer);
        ItemLedgerEntries.RunModal;
    end;

    procedure PostConsumption()
    begin
        /*CLEAR(ItemLedgEntryFrm);
            ItemLedgEntryFrm.PostConsumption(ItemLedgEntry);
            */
    end;

    procedure SelectItemEntry()
    var
        ItemLedgEntry: Record "Item Ledger Entry";
        ItemLedgerEntries: Page "SSD Item Ledger Entries Buffer";
        ItemLedgEntryBuff: Record "SSD Item Ledger Entry Buffer";
        PurchaseLine: Record "Purchase Line";
        SubOrderCompListVend: Record "Sub Order Comp. List Vend";
        VendorRec: Record Vendor;
        ItemRec: Record Item;
        ItemUOMRec: Record "Item Unit of Measure";
        ProdBOMLine: Record "Production BOM Line";
    begin
        /*
            VendorRec.GET("Party No.");
            ItemLedgEntryBuff.RESET;
            ItemLedgEntryBuff.SETCURRENTKEY("Item No.","Location Code");
            ItemLedgEntryBuff.SETRANGE("Item No.","No.");
            ItemLedgEntryBuff.SETRANGE("Location Code",VendorRec."Vendor Location");
            //ItemLedgEntryBuff.SETRANGE("Bin Code",SubOrderCompListVend."Vendor Bin Code");
            IF ItemLedgEntryBuff.FIND('-') THEN
              ItemLedgEntryBuff.DELETEALL;

            ItemLedgEntry.RESET;
            ItemLedgEntry.SETCURRENTKEY("Location Code");
            ItemLedgEntry.SETRANGE("Location Code",VendorRec."Vendor Location");
            ItemLedgEntry.SETFILTER("Remaining Quantity",'>%1',0);
            IF ItemLedgEntry.FIND('-') THEN
              REPEAT
                ItemLedgEntryBuff.INIT;
                ItemLedgEntryBuff.TRANSFERFIELDS(ItemLedgEntry);
                ItemRec.GET("No.");
                ItemUOMRec.GET(ItemRec."No.",ItemLedgEntry."Unit of Measure Code");
                //ItemLedgEntryBuff."Template Name" := "Journal Template Name";
                //ItemLedgEntryBuff."Batch Name" := "Journal Batch Name";
                ItemLedgEntryBuff."Output Item Code" := ItemRec."No.";
                ItemLedgEntryBuff."OutPut Item Unit Of Measure" := ItemUOMRec."Qty. per Unit of Measure";
                ItemLedgEntryBuff."OutPut Item UOM" := ItemRec."Base Unit of Measure";
                ItemLedgEntryBuff."Parent Document No." := "Document No.";
                ItemLedgEntryBuff."Parent Document Line No." := "Line No.";
                ItemLedgEntryBuff."Party No." := VendorRec."No.";
                ItemLedgEntryBuff."Party Location" := VendorRec."Vendor Location";
                ProdBOMLine.RESET;
                ProdBOMLine.SETRANGE("Production BOM No.",ProdBOMHead."No.");
                ProdBOMLine.SETRANGE(ProdBOMLine."No.",ItemLedgEntry."Item No.");
                IF ProdBOMLine.FIND('-') THEN BEGIN
                  ItemLedgEntryBuff."Prod. BOM No." := ProdBOMLine."Production BOM No.";
                  ItemLedgEntryBuff."Production BOM Quantity" := ProdBOMLine."Quantity per";
                END;
                ItemLedgEntryBuff.INSERT;
              UNTIL ItemLedgEntry.NEXT = 0;
            COMMIT;
            ItemLedgerEntries.LOOKUPMODE(TRUE);
            ItemLedgerEntries.SETTABLEVIEW(ItemLedgEntryBuff);
            IF ItemLedgerEntries.RUNMODAL = ACTION::LookupOK THEN BEGIN

            END;
            */
    end;

    procedure InsertItemLedgBuff(ILE: Record "Item Ledger Entry"; PBH: Record "Production BOM Header")
    var
        VendorRec: Record Vendor;
        ItemRec: Record Item;
        ItemUOMRec: Record "Item Unit of Measure";
        ProdBOMLine: Record "Production BOM Line";
        ValueEntry: Record "Value Entry";
    begin
        ItemLedgEntryBuff.Init;
        ItemLedgEntryBuff.TransferFields(ILE);
        ItemRec.Get(Rec."No.");
        if ItemUOMRec.Get(ItemRec."No.", ILE."Unit of Measure Code") then;
        VendorRec.Get(Rec."Party No.");
        ItemLedgEntryBuff."Template Name" := 'SUBCON-BOM';
        ItemLedgEntryBuff."Batch Name" := 'SUBCON-BOM';
        ItemLedgEntryBuff."Output Item Code" := ItemRec."No.";
        ItemLedgEntryBuff."OutPut Item Unit Of Measure" := 1 / ItemUOMRec."Qty. per Unit of Measure";
        ItemLedgEntryBuff."OutPut Item UOM" := ItemRec."Base Unit of Measure";
        ItemLedgEntryBuff."Parent Document No." := Rec."Document No.";
        ItemLedgEntryBuff."Parent Document Line No." := Rec."Line No.";
        ItemLedgEntryBuff."Party No." := VendorRec."No.";
        ItemLedgEntryBuff."Party Location" := VendorRec."Vendor Location";
        ItemLedgEntryBuff."Global Dimension 1 Code" := Rec."Shortcut Dimension 1 Code";
        ItemLedgEntryBuff."Global Dimension 2 Code" := Rec."Shortcut Dimension 2 Code";
        ProdBOMLine.Reset;
        ProdBOMLine.SetRange("Production BOM No.", PBH."No.");
        ProdBOMLine.SetRange(ProdBOMLine."No.", ILE."Item No.");
        if ProdBOMLine.Find('-') then begin
            ItemLedgEntryBuff."Prod. BOM No." := ProdBOMLine."Production BOM No.";
            ItemLedgEntryBuff."Production BOM Quantity" := ProdBOMLine."Quantity per";
            if ProdBOMLine."Quantity per" <> 0 then
                ItemLedgEntryBuff."Max. Rec. Qty" := ILE."Remaining Quantity" / ProdBOMLine."Quantity per"
            else
                ItemLedgEntryBuff."Max. Rec. Qty" := 0;
        end;
        ValueEntry.Reset;
        ValueEntry.SetCurrentkey("Item Ledger Entry No.", "Entry Type");
        ValueEntry.SetRange("Item Ledger Entry No.", ILE."Entry No.");
        if ValueEntry.FindFirst then ItemLedgEntryBuff."Cost Amount" := ValueEntry."Cost Amount (Actual)";
        ItemLedgEntryBuff.Insert;
    end;

    procedure CheckScrapDetail()
    begin
        if Rec."Generate Scrap" then begin
            Rec.TestField("Scrap Item");
            Rec.TestField("Scrap Location");
            Rec.TestField("Scrap Bin");
            Rec.TestField("Scrap Generated");
        end;
    end;

    procedure InsertScrapJnlLine(BillNo: Code[20]; RgpHeader: Record "SSD RGP Header")
    var
        RGPLine: Record "SSD RGP Line";
        EntryCreated: Boolean;
        RGPItem: Record Item;
        GLSetup: Record "General Ledger Setup";
        DefaultDimension: Record "Default Dimension";
    begin
        EntryCreated := false;
        ScrapItemJnlLine.Reset;
        ScrapItemJnlLine.SetRange("Journal Template Name", 'SUBCON-BOM');
        ScrapItemJnlLine.SetRange("Journal Batch Name", 'SUBCON-BOM');
        if ScrapItemJnlLine.FindLast then ScrapItemJnlLine.DeleteAll(true);
        RGPLine.Reset;
        RGPLine.SetRange("Document Type", Rec."document type"::"RGP Inbound");
        RGPLine.SetRange("Document No.", RgpHeader."No.");
        if RGPLine.FindFirst then
            repeat //  IF (NOT RGPLine."Scrap Posted") AND (RGPLine."Generate Scrap") THEN BEGIN
                if (RGPLine."Generate Scrap") then begin
                    ScrapItemJnlLine.Init;
                    ScrapItemJnlLine."Journal Template Name" := 'SUBCON-BOM';
                    ScrapItemJnlLine."Journal Batch Name" := 'SUBCON-BOM';
                    LineNo := LineNo + 10000;
                    ScrapItemJnlLine."Line No." := LineNo;
                    ScrapItemJnlLine."Posting Date" := WorkDate;
                    ScrapItemJnlLine."Document No." := RGPLine."Document No.";
                    ScrapItemJnlLine."Entry Type" := ScrapItemJnlLine."entry type"::"Positive Adjmt.";
                    ScrapItemJnlLine.Validate("Item No.", RGPLine."Scrap Item");
                    ScrapItemJnlLine.Validate("Location Code", RGPLine."Scrap Location");
                    ScrapItemJnlLine.Validate("Bin Code", RGPLine."Scrap Bin");
                    ScrapItemJnlLine.Validate(Quantity, RGPLine."Scrap Generated");
                    ScrapItemJnlLine."External Document No." := BillNo;
                    ScrapItemJnlLine."SUBCON Consumption" := true;
                    RGPLine."Scrap Posted" := true;
                    EntryCreated := true;
                    GLSetup.Get;
                    if DefaultDimension.Get(27, RGPLine."Scrap Item", GLSetup."Global Dimension 1 Code") then ScrapItemJnlLine."Shortcut Dimension 1 Code" := DefaultDimension."Dimension Value Code";
                    if DefaultDimension.Get(27, RGPLine."Scrap Item", GLSetup."Global Dimension 2 Code") then ScrapItemJnlLine."Shortcut Dimension 2 Code" := DefaultDimension."Dimension Value Code";
                    /* // BIS 1145
                    JournalLineDimension.SETRANGE("Table ID" , 83);
                    JournalLineDimension.SETRANGE("Journal Line No." , LineNo);
                    JournalLineDimension.SETRANGE("Journal Template Name" , 'SUBCON-BOM');
                    JournalLineDimension.SETRANGE("Journal Batch Name" , 'SUBCON-BOM');
                    IF JournalLineDimension.FINDFIRST THEN
                      JournalLineDimension.DELETEALL(TRUE);

                    DefaultDimension.SETRANGE("Table ID" , 27);
                    DefaultDimension.SETRANGE("No." , RGPLine."Scrap Item");
                    IF DefaultDimension.FINDFIRST THEN REPEAT
                      WITH JournalLineDimension DO BEGIN
                        JournalLineDimension.INIT;
                        JournalLineDimension."Table ID" := 83;
                        JournalLineDimension."Journal Line No." := LineNo;
                        JournalLineDimension."Journal Template Name" := 'SUBCON-BOM';
                        JournalLineDimension."Journal Batch Name" := 'SUBCON-BOM';
                        JournalLineDimension."Dimension Code" := DefaultDimension."Dimension Code";
                        JournalLineDimension."Dimension Value Code" := DefaultDimension."Dimension Value Code";
                        JournalLineDimension.INSERT;
                      END;
                    UNTIL DefaultDimension.NEXT =0;
                    */
                    // BIS 1145
                    ScrapItemJnlLine.Insert;
                end;
            until RGPLine.Next = 0;
        if EntryCreated then Codeunit.Run(Codeunit::"Item Jnl.-Post", ScrapItemJnlLine);
        RGPLine.Reset;
        RGPLine.SetRange("Document Type", Rec."document type"::"RGP Inbound");
        RGPLine.SetRange("Document No.", RgpHeader."No.");
        if RGPLine.FindFirst then
            repeat
                RGPLine."Scrap Posted" := true;
                RGPLine.Modify;
            until RGPLine.Next = 0;
        //"Scrap Posted" := TRUE;
        //MODIFY;
    end;

    procedure showprodbomfrm()
    begin
        ProductionBOMHeader.Reset;
        ProductionBOMHeader.SetCurrentkey("Source No.");
        ProductionBOMHeader.SetRange(ProductionBOMHeader."Source No.", Rec."No.");
        ProductionBOM.SetTableview(ProductionBOMHeader);
        ProductionBOM.Run;
    end;
}
