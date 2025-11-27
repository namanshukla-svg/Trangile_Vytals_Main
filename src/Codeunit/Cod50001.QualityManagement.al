Codeunit 50001 "Quality Management"
{
    // //////GestIntegraAddOnCalidad==>
    // SR_PQA003 05/07/10: Code added to add feature of creating multiple Quality Order as per number of Item tracking lines.
    // 
    // //ALLE-NM 11102019 :-  Code commented and new code added. Because of MRP process multiple reservation entry and multiple quality order creating for manufacturing.
    Permissions = TableData "Item Ledger Entry"=rm;

    trigger OnRun()
    begin
    end;
    var txt00001: label 'Hay líneas de %1 sin %2';
    VendorClaimPostLine: Codeunit "Vendor Claim -Post Line";
    Item: Record Item;
    SetupQuality: Record "SSD Quality Setup";
    UserMgt: Codeunit "SSD User Setup Management";
    Txt00002: label 'Do you want mark selected items with Quality Control?';
    Txt00003: label 'Do you want unmark selected items with Quality Control?';
    Txt00004: label 'Entry Source Type is OutOfRange';
    Txt00005: label '%1 cannot be less than or equal to zero';
    Txt00006: label '%1 cannot be more than %2';
    Txt00007: label 'Quality Order %1 is generated';
    Txt00008: label 'Normal Quality Order,Coil Type Quality Order';
    Txt00009: label 'Please define Sampling Template for Item No. %1.';
    Txt00010: label 'No Tracking Line found.';
    procedure InsertIntoItemJnlForQuality(RecPurchaseLine: Record "Purchase Line"; var RecItemJournalLine: Record "Item Journal Line")
    begin
        ///*************LinCompraALindiaProd***>>InsertIntoItemJnl*******************************
        if RecItemJournalLine."Item Charge No." <> '' then exit;
        RecItemJournalLine."Concerted Quality":=RecPurchaseLine."Concerted Quality";
        if(not RecItemJournalLine."Concerted Quality") and (RecPurchaseLine."Document Type" = RecPurchaseLine."document type"::Order)then begin
            Item.Get(RecPurchaseLine."No.");
            if Item."Quality Required" then begin
                RecPurchaseLine.TestField("Posted Quality Order No.");
                RecItemJournalLine."Posted Quality Order No.":=RecPurchaseLine."Posted Quality Order No.";
                RecItemJournalLine."Quality Status":=RecItemJournalLine."quality status"::Purchase;
            end;
        end
        else
        begin
            RecItemJournalLine."Posted Quality Order No.":='';
            RecItemJournalLine."Quality Status":=RecItemJournalLine."quality status"::" ";
        end;
        RecItemJournalLine."Quality Defect Code":=RecPurchaseLine."Quality Defect Code";
    //RecItemJournalLine."Source Line No." := RecPurchaseLine."Line No.";
    //IF RecPurchaseLine."Document Type" = RecPurchaseLine."Document Type"::Order THEN
    // RecItemJournalLine."Order No." := RecPurchaseLine."Document No.";
    end;
    procedure InsertIntoItemLdgrForQuality(RecItemJnlLine: Record "Item Journal Line"; var RecItemLdgrEntry: Record "Item Ledger Entry")
    begin
        ////*******LinDiaProdAMovProd****>>>>InsertIntoItemLdgrEntry*****************************************
        if RecItemJnlLine."Item Charge No." <> '' then exit;
        RecItemLdgrEntry."Posted Quality Order No.":=RecItemJnlLine."Posted Quality Order No.";
        RecItemLdgrEntry."Concerted Quality":=RecItemJnlLine."Concerted Quality";
        RecItemLdgrEntry."Vendor Claim Code":=RecItemJnlLine."Vendor Claim Code";
        RecItemLdgrEntry."Quality Status":=RecItemJnlLine."Quality Status";
        RecItemLdgrEntry."Reclass. Item Entry Source No.":=RecItemJnlLine."Reclassif. Entry No.";
        RecItemLdgrEntry."Quality Order Status":=RecItemJnlLine."Quality Order Status";
        RecItemLdgrEntry."Quality Defect Code":=RecItemJnlLine."Quality Defect Code";
        //RecItemLdgrEntry."Source Line No." := RecItemJnlLine."Source Line No.";
        //RecItemLdgrEntry."Order No." := RecItemJnlLine."Order No.";
        RecItemLdgrEntry."Reprocess PO":=RecItemJnlLine."Reprocess PO";
        if RecItemLdgrEntry.Quantity < 0 then RecItemLdgrEntry."Quality Status":=RecItemLdgrEntry."quality status"::" ";
        if not SetupQuality."Activate Quality Control Man." then RecItemLdgrEntry."Quality Status":=RecItemLdgrEntry."quality status"::" ";
    end;
    procedure ActivateQualityRequired(var RecItem: Record Item; QualityCheckRequired: Boolean)
    var
        xItem: Record Item;
    begin
        ///*************ActivarControlCalidad****************
        if QualityCheckRequired then begin
            if not Confirm(Txt00002, false)then exit;
        end
        else
        begin
            if not Confirm(Txt00003, false)then exit;
        end;
        if RecItem.Find('-')then repeat xItem:=RecItem;
                xItem."Quality Required":=QualityCheckRequired;
                xItem.Modify;
            until RecItem.Next = 0;
    end;
    procedure CreateQOrdFromMRN(RecSourceType: Option Purchase, Manufacturing, Routing, MRN; var RecWHReceiptLine: Record "Warehouse Receipt Line"; RecTemplateType: Option Receipt, Manufacturing, Routing; CoilType: Boolean; ReservationEntry: Record "Reservation Entry")
    var
        QualityOrderHeaderLocal: Record "SSD Quality Order Header";
        ItemLocal: Record Item;
        ItemVendorLocal: Record "Item Vendor";
        ItemUMLocal: Record "Item Unit of Measure";
    begin
        QualityOrderHeaderLocal.Init;
        QualityOrderHeaderLocal."Template Type":=RecTemplateType;
        QualityOrderHeaderLocal."Entry Source Type":=RecSourceType;
        if RecWHReceiptLine."Party Type" = RecWHReceiptLine."party type"::Vendor then begin
            case QualityOrderHeaderLocal."Entry Source Type" of QualityOrderHeaderLocal."entry source type"::Purchase, QualityOrderHeaderLocal."entry source type"::MRN: QualityOrderHeaderLocal."Source Code":=RecWHReceiptLine."Party No.";
            end;
        end;
        QualityOrderHeaderLocal."Source Document No.":=RecWHReceiptLine."No.";
        QualityOrderHeaderLocal."Creation Date":=WorkDate;
        QualityOrderHeaderLocal."Source Doc. Line No.":=RecWHReceiptLine."Line No.";
        QualityOrderHeaderLocal."Order No.":=RecWHReceiptLine."Source No.";
        QualityOrderHeaderLocal."Sampling Method":=QualityOrderHeaderLocal."sampling method"::"Complete Quantity"; //ssd
        QualityOrderHeaderLocal."Time of Creation":=Time; //Alle[Z];
        QualityOrderHeaderLocal."Item No.":=RecWHReceiptLine."Item No.";
        QualityOrderHeaderLocal."Unit of Measure Code":=RecWHReceiptLine."Unit of Measure Code";
        QualityOrderHeaderLocal."Qty. per Unit of Measure":=RecWHReceiptLine."Qty. per Unit of Measure";
        QualityOrderHeaderLocal.CalcFields(Description, "Description 2");
        QualityOrderHeaderLocal."Variant Code":=RecWHReceiptLine."Variant Code";
        QualityOrderHeaderLocal."Location Code":=RecWHReceiptLine."Location Code";
        QualityOrderHeaderLocal."Bin Code":=RecWHReceiptLine."Bin Code";
        if ReservationEntry."Qty. to Handle (Base)" <> 0 then begin
            QualityOrderHeaderLocal."Lot Size":=ReservationEntry."Qty. to Handle (Base)";
            QualityOrderHeaderLocal."Lot No.":=ReservationEntry."Lot No." end
        else
            QualityOrderHeaderLocal."Lot Size":=RecWHReceiptLine.Quantity;
        QualityOrderHeaderLocal.Reset;
        ItemVendorLocal.SetRange("Vendor No.", QualityOrderHeaderLocal."Source Code");
        ItemVendorLocal.SetRange("Item No.", QualityOrderHeaderLocal."Item No.");
        if ItemVendorLocal.Find('-')then QualityOrderHeaderLocal."Concerted Quality":=ItemVendorLocal."Concerted Quality";
        if ItemLocal.Get(QualityOrderHeaderLocal."Item No.")then begin
            QualityOrderHeaderLocal.Validate("Reclassif. Code", ItemLocal."Reclassif. Code");
            QualityOrderHeaderLocal."Reprocess Routing No.":=ItemLocal."Reprocess Routing No.";
            QualityOrderHeaderLocal."Reprocess BOM No.":=ItemLocal."Reprocess BOM No.";
        end;
        QualityOrderHeaderLocal."No. Series":=QualityOrderHeaderLocal.GetNoSeries(true);
        QualityOrderHeaderLocal."No.":='';
        QualityOrderHeaderLocal."Entry User":=UserId;
        QualityOrderHeaderLocal."Posting Date":=WorkDate;
        QualityOrderHeaderLocal."No. Of Coil":=RecWHReceiptLine."No. Of Coils";
        QualityOrderHeaderLocal."Is Coil Type":=CoilType;
        QualityOrderHeaderLocal.Insert(true);
        RecWHReceiptLine."Send For Quality":=true;
        RecWHReceiptLine.Modify;
    end;
    procedure CreateQualityOrderLine(RecQualityOrdHeader: Record "SSD Quality Order Header"; var RecQualityOrdLine: Record "SSD Quality Order Line")
    var
        SamplingHeaderLocal: Record "SSD Sampling Temp. Header";
        LineNo: Integer;
        SamplingLineLocal: Record "SSD Sampling Temp. Line";
    begin
        RecQualityOrdHeader.TestField("Sampling Temp. No.");
        if SamplingHeaderLocal.Get(RecQualityOrdHeader."Sampling Temp. No.")then begin
            SamplingHeaderLocal.TestField(Status, SamplingHeaderLocal.Status::Certified);
            ///************** Delete Sampling Doc Line if any present*************
            RecQualityOrdLine.Reset;
            RecQualityOrdLine.SetRange("Document No.", RecQualityOrdHeader."No.");
            if RecQualityOrdLine.Find('-')then RecQualityOrdLine.DeleteAll(true);
            ///************** Insert Sampling Doc Line as per Sampling Template Line*****
            LineNo:=0;
            SamplingLineLocal.Reset;
            SamplingLineLocal.SetRange("Document No.", SamplingHeaderLocal."No.");
            if SamplingLineLocal.Find('-')then repeat RecQualityOrdLine.Init;
                    RecQualityOrdLine."Document No.":=RecQualityOrdHeader."No.";
                    RecQualityOrdLine."Template Type":=RecQualityOrdHeader."Template Type";
                    LineNo:=LineNo + 10000;
                    RecQualityOrdLine."Line No.":=LineNo;
                    RecQualityOrdLine."Responsibility Center":=RecQualityOrdHeader."Responsibility Center";
                    RecQualityOrdLine."Sampling Template No.":=RecQualityOrdHeader."Sampling Temp. No.";
                    RecQualityOrdLine."Test No.":=SamplingLineLocal."Test No.";
                    RecQualityOrdLine."Meas. Code":=SamplingLineLocal."Meas. Code";
                    RecQualityOrdLine.Description:=SamplingLineLocal.Description;
                    RecQualityOrdLine."Meas. Tool Code":=SamplingLineLocal."Meas. Tool Code";
                    RecQualityOrdLine."Meas. Tool Description":=SamplingLineLocal."Meas. Tool Description";
                    RecQualityOrdLine."Meas. Value Type":=SamplingLineLocal."Meas. Value Type";
                    RecQualityOrdLine."Unit of Measure Code":=SamplingLineLocal."Unit of Measure Code";
                    RecQualityOrdLine."Normal Value":=SamplingLineLocal."Normal Value";
                    RecQualityOrdLine."Minimum Value":=SamplingLineLocal."Minimum Value";
                    RecQualityOrdLine."Maximum Value":=SamplingLineLocal."Maximum Value";
                    RecQualityOrdLine."Medium Tolerance":=SamplingLineLocal."Medium Tolerance";
                    RecQualityOrdLine."Kind of Sampling":=SamplingLineLocal."Kind of Sampling";
                    RecQualityOrdLine."Inspection Type":=SamplingLineLocal."Inspection Type";
                    RecQualityOrdLine."Sampling Level":=SamplingLineLocal."Sampling Level";
                    RecQualityOrdLine."Qty. to be Inspected":=RecQualityOrdHeader."Sample Size";
                    RecQualityOrdLine."Accepted Qty.":=RecQualityOrdHeader."Sample Size";
                    RecQualityOrdLine."Value to be Print":=SamplingLineLocal."To be Print"; //ALLE-SS 11/10/17
                    RecQualityOrdLine.Discipline:=SamplingLineLocal.Discipline; //ALLE-NM 25072019
                    RecQualityOrdLine.Group:=SamplingLineLocal.Group; //ALLE-NM 25072019
                    RecQualityOrdLine.UCL:=SamplingLineLocal.UCL; //ALLE-NM 17122019
                    RecQualityOrdLine.LCL:=SamplingLineLocal.LCL; //ALLE-NM 17122019
                    RecQualityOrdLine.Insert(true);
                until SamplingLineLocal.Next = 0 end;
    end;
    procedure CreateVendorClaim(var RecPurchaseHeader: Record "Purchase Header"; var RecPurchaseLine: Record "Purchase Line"; AffectedQty: Decimal)
    begin
        SetupQuality.Get(UserMgt.GetRespCenterFilter);
        if not SetupQuality."Activate Quality Control Man." then exit;
        if AffectedQty = 0 then exit;
        RecPurchaseLine.TestField("Concerted Quality", true);
        if RecPurchaseLine."Vendor Claim Code" = '' then Error(StrSubstNo(txt00001, RecPurchaseHeader."Document Type", RecPurchaseLine.FieldCaption(RecPurchaseLine."Vendor Claim Code")));
        VendorClaimPostLine.CreateVendorClaimFromPurchLine(RecPurchaseHeader, RecPurchaseLine, AffectedQty);
    end;
    procedure CreateQOrdFromProd(RecSourceType: Option Purchase, Manufacturing, Routing, MRN; var ItemJournalLine: Record "Item Journal Line"; RecTemplateType: Option Receipt, Manufacturing, Routing)
    var
        QualityOrderHeaderLocal: Record "SSD Quality Order Header";
        ProdOrderLineLocal: Record "Prod. Order Line";
        SamplingTempHdrLocal: Record "SSD Sampling Temp. Header";
        ItemVendorLocal: Record "Item Vendor";
        ItemLocal: Record Item;
        SamplingTempLineLocal: Record "SSD Sampling Temp. Line";
        QualityOrderLineLocal: Record "SSD Quality Order Line";
        ProductionOrderLocal: Record "Production Order";
        LineNo: Integer;
        ReservationEntry: Record "Reservation Entry";
        ProdOrderRoutingLines: Record "Prod. Order Routing Line";
        RecProdOrdRoutingLine: Record "Prod. Order Routing Line";
        Qty: Decimal;
    begin
        SamplingTempHdrLocal.Get(ItemJournalLine."Quality Template Master");
        SamplingTempHdrLocal.TestField(Status, SamplingTempHdrLocal.Status::Certified);
        //ALLE-NM 11102019
        /*
        ReservationEntry.RESET;
        //Blocked
        //ReservationEntry.SETRANGE("Source ID",ItemJournalLine."Prod. Order No.");
        //ReservationEntry.SETRANGE("Source Prod. Order Line",ItemJournalLine."Prod. Order Line No.");
        //inserted.begin
        ReservationEntry.SETRANGE("Source ID",ItemJournalLine."Journal Template Name");
        ReservationEntry.SETRANGE("Source Batch Name",ItemJournalLine."Journal Batch Name");
        ReservationEntry.SETRANGE("Source Ref. No.",ItemJournalLine."Line No.");
        //inserted.end
        ReservationEntry.SETRANGE("Item No.",ItemJournalLine."Item No.");
        IF ReservationEntry.FINDFIRST THEN BEGIN REPEAT
          QualityOrderHeaderLocal.INIT;
          QualityOrderHeaderLocal.TRANSFERFIELDS(SamplingTempHdrLocal);
          QualityOrderHeaderLocal."Entry Source Type" := RecSourceType;
          QualityOrderHeaderLocal."Template Type" := RecSourceType;
          QualityOrderHeaderLocal."Creation Date" :=WORKDATE;
          QualityOrderHeaderLocal.Status:=QualityOrderHeaderLocal.Status::Open;
          QualityOrderHeaderLocal."Source Code" :=  ItemJournalLine."Order No.";
          QualityOrderHeaderLocal."Item No." := ItemJournalLine."Item No.";
          QualityOrderHeaderLocal.Description := ItemJournalLine.Description;
          QualityOrderHeaderLocal."Source Document No." := ItemJournalLine."Order No."; // BIS 1145
          QualityOrderHeaderLocal."Time of Creation":=TIME;//Alle[Z];
          QualityOrderHeaderLocal."Source Doc. Line No." := ProdOrderLineLocal."Line No.";
          ProductionOrderLocal.GET(ProdOrderLineLocal.Status::Released,ItemJournalLine."Order No.");  // BIS 1145
          QualityOrderHeaderLocal."Lot Size" := ReservationEntry.Quantity;//ProductionOrderLocal.Quantity;
          QualityOrderHeaderLocal."Sampling Temp. No." := ItemJournalLine."Quality Template Master";
          QualityOrderHeaderLocal."Qty. Sent For Inspection" := ItemJournalLine."Sample Quantity";
          QualityOrderHeaderLocal."Sample Size":=ItemJournalLine."Sample Quantity";
          QualityOrderHeaderLocal."Accepted Qty." := ReservationEntry.Quantity;//ItemJournalLine."Sample Quantity";
          QualityOrderHeaderLocal."Source Doc. Line No." := ItemJournalLine."Order Line No.";
          QualityOrderHeaderLocal."Location Code" := ItemJournalLine."Location Code";
          QualityOrderHeaderLocal."Source Doc Date":=ProductionOrderLocal."Creation Date";
          QualityOrderHeaderLocal."Order No.":=ItemJournalLine."Order No.";
          QualityOrderHeaderLocal."Routing No." := ItemJournalLine."Routing No.";
          QualityOrderHeaderLocal.VALIDATE("Process/Operation Type",ItemJournalLine.Type);
          QualityOrderHeaderLocal."Process/Operation No." := ItemJournalLine."Operation No.";
          QualityOrderHeaderLocal.VALIDATE("W.C. / M.C. No.", ItemJournalLine."No.");
          QualityOrderHeaderLocal."Work Center No." := ItemJournalLine."Work Center No.";
          QualityOrderHeaderLocal."IJL Line No" := ItemJournalLine."Line No.";
          QualityOrderHeaderLocal."Work Center Group Code" := ItemJournalLine."Work Center Group Code";
          QualityOrderHeaderLocal."Variant Code" := ProdOrderLineLocal."Variant Code";
          QualityOrderHeaderLocal."Unit of Measure Code" := ItemJournalLine."Unit of Measure Code";
          QualityOrderHeaderLocal."Kind of Sampling" := SamplingTempHdrLocal."Kind of Sampling";
          QualityOrderHeaderLocal."Sampling Temp. No.":= SamplingTempHdrLocal."No.";
          QualityOrderHeaderLocal."Sampling Method" := QualityOrderHeaderLocal."Sampling Method"::"Complete Quantity";
          QualityOrderHeaderLocal."Lot No." := ReservationEntry."Lot No.";
          QualityOrderHeaderLocal."Bin Code" := ProdOrderLineLocal."Bin Code";
        
          IF ItemLocal.GET(QualityOrderHeaderLocal."Item No.") THEN BEGIN
            QualityOrderHeaderLocal."Reprocess Routing No." := ItemLocal."Reprocess Routing No.";
            QualityOrderHeaderLocal."Reprocess BOM No." := ItemLocal."Reprocess BOM No.";
          END;
        
          QualityOrderHeaderLocal."No. Series" := QualityOrderHeaderLocal.GetNoSeries(TRUE);
          QualityOrderHeaderLocal."No." := '';
          QualityOrderHeaderLocal."Entry User" := USERID;
          QualityOrderHeaderLocal."Posting Date":=WORKDATE;
          QualityOrderHeaderLocal.INSERT(TRUE);
        
          LineNo := 10000;
          SamplingTempLineLocal.RESET;
          SamplingTempLineLocal.SETRANGE("Document No.",SamplingTempHdrLocal."No.");
          IF SamplingTempLineLocal.FINDFIRST THEN
            REPEAT
              QualityOrderLineLocal.TRANSFERFIELDS(SamplingTempLineLocal);
              QualityOrderLineLocal."Document No." := QualityOrderHeaderLocal."No.";
              QualityOrderLineLocal."Sampling Template No.":=QualityOrderHeaderLocal."Sampling Temp. No.";
              QualityOrderLineLocal."Template Type" := RecSourceType;
              QualityOrderLineLocal."Line No." := LineNo;
              LineNo := LineNo + 10000;
              QualityOrderLineLocal.INSERT;
            UNTIL SamplingTempLineLocal.NEXT = 0;
        UNTIL ReservationEntry.NEXT=0;//ALLE[5.51]
        END ELSE
          ERROR(Txt00010);
        */
        //ALL-NM 11102019
        Clear(Qty);
        ReservationEntry.Reset;
        //Blocked
        //ReservationEntry.SETRANGE("Source ID",ItemJournalLine."Prod. Order No.");
        //ReservationEntry.SETRANGE("Source Prod. Order Line",ItemJournalLine."Prod. Order Line No.");
        //inserted.begin
        ReservationEntry.SetRange("Source ID", ItemJournalLine."Journal Template Name");
        ReservationEntry.SetRange("Source Batch Name", ItemJournalLine."Journal Batch Name");
        ReservationEntry.SetRange("Source Ref. No.", ItemJournalLine."Line No.");
        //inserted.end
        ReservationEntry.SetRange("Item No.", ItemJournalLine."Item No.");
        if ReservationEntry.FindSet then begin
            repeat Qty+=ReservationEntry.Quantity;
            until ReservationEntry.Next = 0; //ALLE[5.51]
            QualityOrderHeaderLocal.Init;
            QualityOrderHeaderLocal.TransferFields(SamplingTempHdrLocal);
            QualityOrderHeaderLocal."Entry Source Type":=RecSourceType;
            QualityOrderHeaderLocal."Template Type":=RecSourceType;
            QualityOrderHeaderLocal."Creation Date":=WorkDate;
            QualityOrderHeaderLocal.Status:=QualityOrderHeaderLocal.Status::Open;
            QualityOrderHeaderLocal."Source Code":=ItemJournalLine."Order No.";
            QualityOrderHeaderLocal."Item No.":=ItemJournalLine."Item No.";
            QualityOrderHeaderLocal.Description:=ItemJournalLine.Description;
            QualityOrderHeaderLocal."Source Document No.":=ItemJournalLine."Order No."; // BIS 1145
            QualityOrderHeaderLocal."Time of Creation":=Time; //Alle[Z];
            QualityOrderHeaderLocal."Source Doc. Line No.":=ProdOrderLineLocal."Line No.";
            ProductionOrderLocal.Get(ProdOrderLineLocal.Status::Released, ItemJournalLine."Order No."); // BIS 1145
            QualityOrderHeaderLocal."Lot Size":=Qty; //ProductionOrderLocal.Quantity;
            QualityOrderHeaderLocal."Sampling Temp. No.":=ItemJournalLine."Quality Template Master";
            QualityOrderHeaderLocal."Qty. Sent For Inspection":=ItemJournalLine."Sample Quantity";
            QualityOrderHeaderLocal."Sample Size":=ItemJournalLine."Sample Quantity";
            QualityOrderHeaderLocal."Accepted Qty.":=Qty; //ItemJournalLine."Sample Quantity";
            QualityOrderHeaderLocal."Source Doc. Line No.":=ItemJournalLine."Order Line No.";
            QualityOrderHeaderLocal."Location Code":=ItemJournalLine."Location Code";
            QualityOrderHeaderLocal."Source Doc Date":=ProductionOrderLocal."Creation Date";
            QualityOrderHeaderLocal."Order No.":=ItemJournalLine."Order No.";
            QualityOrderHeaderLocal."Routing No.":=ItemJournalLine."Routing No.";
            QualityOrderHeaderLocal.Validate("Process/Operation Type", ItemJournalLine.Type);
            QualityOrderHeaderLocal."Process/Operation No.":=ItemJournalLine."Operation No.";
            QualityOrderHeaderLocal.Validate("W.C. / M.C. No.", ItemJournalLine."No.");
            QualityOrderHeaderLocal."Work Center No.":=ItemJournalLine."Work Center No.";
            QualityOrderHeaderLocal."IJL Line No":=ItemJournalLine."Line No.";
            QualityOrderHeaderLocal."Work Center Group Code":=ItemJournalLine."Work Center Group Code";
            QualityOrderHeaderLocal."Variant Code":=ProdOrderLineLocal."Variant Code";
            QualityOrderHeaderLocal."Unit of Measure Code":=ItemJournalLine."Unit of Measure Code";
            QualityOrderHeaderLocal."Kind of Sampling":=SamplingTempHdrLocal."Kind of Sampling";
            QualityOrderHeaderLocal."Sampling Temp. No.":=SamplingTempHdrLocal."No.";
            QualityOrderHeaderLocal."Sampling Method":=QualityOrderHeaderLocal."sampling method"::"Complete Quantity";
            QualityOrderHeaderLocal."Lot No.":=ReservationEntry."Lot No.";
            QualityOrderHeaderLocal."Bin Code":=ProdOrderLineLocal."Bin Code";
            if ItemLocal.Get(QualityOrderHeaderLocal."Item No.")then begin
                QualityOrderHeaderLocal."Reprocess Routing No.":=ItemLocal."Reprocess Routing No.";
                QualityOrderHeaderLocal."Reprocess BOM No.":=ItemLocal."Reprocess BOM No.";
            end;
            QualityOrderHeaderLocal."No. Series":=QualityOrderHeaderLocal.GetNoSeries(true);
            QualityOrderHeaderLocal."No.":='';
            QualityOrderHeaderLocal."Entry User":=UserId;
            QualityOrderHeaderLocal."Posting Date":=WorkDate;
            OnBeforeInsertManufacturingQualityOrder(ItemJournalLine, QualityOrderHeaderLocal);
            QualityOrderHeaderLocal.Insert(true);
            LineNo:=10000;
            SamplingTempLineLocal.Reset;
            SamplingTempLineLocal.SetRange("Document No.", SamplingTempHdrLocal."No.");
            if SamplingTempLineLocal.FindFirst then repeat QualityOrderLineLocal.TransferFields(SamplingTempLineLocal);
                    QualityOrderLineLocal."Document No.":=QualityOrderHeaderLocal."No.";
                    QualityOrderLineLocal."Sampling Template No.":=QualityOrderHeaderLocal."Sampling Temp. No.";
                    QualityOrderLineLocal."Template Type":=RecSourceType;
                    QualityOrderLineLocal."Line No.":=LineNo;
                    LineNo:=LineNo + 10000;
                    QualityOrderLineLocal.Insert;
                until SamplingTempLineLocal.Next = 0;
        end
        else
            Error(Txt00010);
        //ALLE-NM 11102019
        ItemJournalLine."Sent for Quality":=true;
        ItemJournalLine."Sample Qty. Sent to QC":=ItemJournalLine."Sample Quantity";
        ItemJournalLine."Sample Quantity":=0;
        ItemJournalLine.Modify;
        ProdOrderRoutingLines.Reset;
        ProdOrderRoutingLines.SetRange("Prod. Order No.", ItemJournalLine."Order No.");
        ProdOrderRoutingLines.SetRange("Routing Reference No.", ItemJournalLine."Order Line No.");
        ProdOrderRoutingLines.SetRange("Routing No.", ItemJournalLine."Routing No.");
        ProdOrderRoutingLines.SetRange("Work Center No.", ItemJournalLine."Work Center No.");
        ProdOrderRoutingLines.SetRange("Operation No.", ItemJournalLine."Operation No.");
        if ProdOrderRoutingLines.FindFirst then begin
            ProdOrderRoutingLines."Sent for Quality":=ItemJournalLine."Sent for Quality";
            ProdOrderRoutingLines."Sample Quantity":=ItemJournalLine."Sample Qty. Sent to QC";
            ProdOrderRoutingLines.Modify;
        end;
        Message('Quality Order Generated ', ReservationEntry.Count); //ALLE[5.51]
    end;
    procedure CreateReceiptQualityOrder(RecSourceType: Option Purchase, Manufacturing, , Calibration; var RecMRNLine: Record "Warehouse Receipt Line"; RecTemplateType: Option Receipt, Manufacturing, , Calibration; var OrderCount: Integer)
    var
        MRNQOHDR: Record "SSD Quality Order Header";
        ItemLocal: Record Item;
        ItemVendorLocal: Record "Item Vendor";
        ItemUMLocal: Record "Item Unit of Measure";
        ItemSamplingTemp: Record "Item Sampling Template";
        QOLine: Record "SSD Quality Order Line";
        STLine: Record "SSD Sampling Temp. Line";
        MRNQOHDR1: Record "SSD Quality Order Header";
        LineNo: Integer;
        ReservationEntry: Record "Reservation Entry";
        MRNHeader: Record "Warehouse Receipt Header";
        SamplingTempHeader: Record "SSD Sampling Temp. Header";
        ItemSamplingTemp1: Record "Item Sampling Template";
    begin
        OrderCount:=0;
        //PQA-003
        ReservationEntry.Reset;
        ReservationEntry.SETCURRENTKEY("Source ID", "Source Ref. No.", "Source Type", "Source Subtype", "Source Batch Name", "Source Prod. Order Line", "Reservation Status", "Shipment Date", "Expected Receipt Date");
        ReservationEntry.SetRange("Source Type", RecMRNLine."Source Type");
        ReservationEntry.SetRange("Source Subtype", RecMRNLine."Source Subtype");
        ReservationEntry.SetRange("Source ID", RecMRNLine."Source No.");
        ReservationEntry.SetRange("Source Ref. No.", RecMRNLine."Source Line No.");
        ReservationEntry.SetFilter("Item Tracking", '%1|%2|%3|%4', ReservationEntry."Item Tracking"::"Lot No.", ReservationEntry."Item Tracking"::"Lot and Package No.", ReservationEntry."Item Tracking"::"Lot and Serial and Package No.", ReservationEntry."Item Tracking"::"Lot and Serial No.");
        if ReservationEntry.FindSet()then begin
            repeat MRNQOHDR1.Reset;
                MRNQOHDR1.SetCurrentkey("Lot No.", "Source Document No.", "Source Doc. Line No.");
                MRNQOHDR1.SetRange("Lot No.", ReservationEntry."Lot No.");
                MRNQOHDR1.SetRange("Source Document No.", RecMRNLine."No.");
                MRNQOHDR1.SetRange("Source Doc. Line No.", RecMRNLine."Line No.");
                if MRNQOHDR1.FindFirst then begin
                    MRNQOHDR1."Lot Size":=MRNQOHDR1."Lot Size" + ReservationEntry."Quantity (Base)";
                    MRNQOHDR1.Modify;
                end
                else
                begin
                    OrderCount+=1;
                    MRNQOHDR.Init;
                    MRNQOHDR."Template Type":=RecTemplateType;
                    MRNQOHDR."Entry Source Type":=MRNQOHDR."entry source type"::MRN;
                    MRNQOHDR."Source Document No.":=RecMRNLine."No.";
                    MRNQOHDR."Creation Date":=WorkDate;
                    MRNQOHDR."Source Doc. Line No.":=RecMRNLine."Line No.";
                    MRNQOHDR."Order No.":=RecMRNLine."Source No.";
                    MRNQOHDR."Sampling Method":=MRNQOHDR."sampling method"::"Complete Quantity";
                    MRNQOHDR."Item No.":=RecMRNLine."Item No.";
                    MRNQOHDR."Vendor Item Description":=RecMRNLine."Vendor Item Description"; //Sunil
                    MRNQOHDR."Unit of Measure Code":=RecMRNLine."Unit of Measure Code";
                    MRNQOHDR."Qty. per Unit of Measure":=RecMRNLine."Qty. per Unit of Measure";
                    MRNQOHDR."Variant Code":=RecMRNLine."Variant Code";
                    MRNQOHDR."Location Code":=RecMRNLine."Location Code";
                    MRNQOHDR."Bin Code":=RecMRNLine."Bin Code";
                    MRNQOHDR."Lot Size":=Abs(ReservationEntry."Quantity (Base)");
                    MRNQOHDR."Lot No.":=ReservationEntry."Lot No.";
                    MRNQOHDR."Time of Creation":=Time; //Alle[Z]
                    MRNQOHDR."Supplier Batch No.":=RecMRNLine."Supplier Batch No."; //ALLE-NM 280519
                    //5.51 to add sampling template automatically.
                    ItemSamplingTemp1.Reset;
                    ItemSamplingTemp1.SetRange(ItemSamplingTemp1."Item Code", RecMRNLine."Item No.");
                    ItemSamplingTemp1.SetRange(ItemSamplingTemp1.Active, true);
                    if ItemSamplingTemp1.FindFirst then MRNQOHDR."Sampling Temp. No.":=ItemSamplingTemp1."Sampling Temp. No.";
                    //end 5.51
                    MRNQOHDR."No. Series":=MRNQOHDR.GetNoSeries(true);
                    MRNQOHDR."No.":='';
                    MRNQOHDR."Entry User":=UserId;
                    MRNQOHDR."Posting Date":=WorkDate;
                    MRNQOHDR.Insert(true);
                end;
            until ReservationEntry.Next = 0;
        end
        else
            Error(Txt00010);
        RecMRNLine."Send For Quality":=true;
        RecMRNLine.Modify;
    //PQA-003
    end;
    procedure CreateQOrdForRcvdCoil(var RecQualityOrderHdr: Record "SSD Quality Order Header")
    var
        QualityOrderHeaderLocal: Record "SSD Quality Order Header";
        QualityOrderLineLocal: Record "SSD Quality Order Line";
        RoutingQualityOrderLineLocal: Record "SSD Quality Order Line";
    begin
        RecQualityOrderHdr.TestField("Template Type", RecQualityOrderHdr."template type"::Receipt);
        RecQualityOrderHdr.TestField("Is Coil Type", true);
        RecQualityOrderHdr.TestField("Sampling Temp. No.");
        if RecQualityOrderHdr."Sample Size" <= 0 then Error(Txt00005, RecQualityOrderHdr.FieldCaption("Sample Size"));
        if(RecQualityOrderHdr."Lot Size" <= 0)then Error(Txt00005, RecQualityOrderHdr.FieldCaption("Lot Size"));
        RecQualityOrderHdr.CalcFields("Total Qty. Sent For Inspection");
        if RecQualityOrderHdr."Sample Size" > (RecQualityOrderHdr."Lot Size" - RecQualityOrderHdr."Total Qty. Sent For Inspection")then Error(Txt00006, RecQualityOrderHdr.FieldCaption("Sample Size"), Format((RecQualityOrderHdr."Lot Size" - RecQualityOrderHdr."Total Qty. Sent For Inspection")));
        QualityOrderHeaderLocal.Init;
        QualityOrderHeaderLocal.TransferFields(RecQualityOrderHdr);
        QualityOrderHeaderLocal."Template Type":=QualityOrderHeaderLocal."template type"::RcvdCoil;
        QualityOrderHeaderLocal."Creation Date":=WorkDate;
        QualityOrderHeaderLocal."Order No.":=RecQualityOrderHdr."No.";
        QualityOrderHeaderLocal."Lot Size":=RecQualityOrderHdr."Sample Size";
        QualityOrderHeaderLocal.Validate("Sample Size", QualityOrderHeaderLocal."Lot Size");
        QualityOrderHeaderLocal."Accepted Qty.":=QualityOrderHeaderLocal."Lot Size";
        QualityOrderHeaderLocal."Rejected Qty.":=0;
        QualityOrderHeaderLocal."No. Series":=QualityOrderHeaderLocal.GetNoSeries(true);
        QualityOrderHeaderLocal."No.":='';
        QualityOrderHeaderLocal."Entry User":=UserId;
        QualityOrderHeaderLocal."Posting Date":=WorkDate;
        QualityOrderHeaderLocal.Insert(true);
        ///*********** Create Line ***********************************************
        QualityOrderLineLocal.Reset;
        QualityOrderLineLocal.SetRange("Document No.", RecQualityOrderHdr."No.");
        if QualityOrderLineLocal.Find('-')then repeat RoutingQualityOrderLineLocal.Init;
                RoutingQualityOrderLineLocal.TransferFields(QualityOrderLineLocal);
                RoutingQualityOrderLineLocal."Template Type":=QualityOrderHeaderLocal."Template Type";
                RoutingQualityOrderLineLocal."Document No.":=QualityOrderHeaderLocal."No.";
                RoutingQualityOrderLineLocal.Validate("Qty. to be Inspected", QualityOrderHeaderLocal."Lot Size");
                RoutingQualityOrderLineLocal.Validate("Accepted Qty.", QualityOrderHeaderLocal."Lot Size");
                RoutingQualityOrderLineLocal.Insert;
            until QualityOrderLineLocal.Next = 0;
        RecQualityOrderHdr."Sample Size":=0;
        RecQualityOrderHdr.Modify;
        Message(Txt00007, QualityOrderHeaderLocal."No.");
    end;
    procedure CreateReceiptQualityOrder2(RecSourceType: Option Purchase, Manufacturing, , Calibration; var RecMRNLine: Record "Purchase Line"; RecTemplateType: Option Receipt, Manufacturing, , Calibration)
    var
        MRNQOHDR: Record "SSD Quality Order Header";
        ItemLocal: Record Item;
        ItemVendorLocal: Record "Item Vendor";
        ItemUMLocal: Record "Item Unit of Measure";
        ItemSamplingTemp: Record "Item Sampling Template";
        QOLine: Record "SSD Quality Order Line";
        STLine: Record "SSD Sampling Temp. Line";
        MRNQOHDR1: Record "SSD Quality Order Header";
        LineNo: Integer;
        ReservationEntry: Record "Reservation Entry";
        MRNHeader: Record "Warehouse Receipt Header";
        SamplingTempHeader: Record "SSD Sampling Temp. Header";
        ItemSamplingTemp1: Record "Item Sampling Template";
        Qty: Decimal;
    begin
        //PQA-003
        Clear(Qty);
        ReservationEntry.Reset;
        ReservationEntry.SetCurrentkey("MRN No.", "Item No.", "MRN Line No.", "Lot No.");
        ReservationEntry.SetRange("Source Type", 5406);
        ReservationEntry.SetRange("Source Subtype", 3);
        ReservationEntry.SetRange("Source ID", RecMRNLine."Prod. Order No.");
        ReservationEntry.SetRange("Source Prod. Order Line", RecMRNLine."Prod. Order Line No.");
        ReservationEntry.SetRange("Item No.", RecMRNLine."No.");
        ReservationEntry.SetRange("Item Tracking", ReservationEntry."item tracking"::"Lot No."); //CORP::PK 210120
        // ReservationEntry.SETRANGE("Quantity (Base)",RecMRNLine."Qty. to Receive");
        if ReservationEntry.FindSet then begin
            if RecMRNLine."Qty. to Receive" <> 0 then begin
                Qty:=Abs(RecMRNLine."Qty. to Receive");
                MRNQOHDR1.Reset;
                MRNQOHDR1.SetCurrentkey("Lot No.", "Source Document No.", "Source Doc. Line No.");
                MRNQOHDR1.SetRange("Lot No.", ReservationEntry."Lot No.");
                MRNQOHDR1.SetRange("Source Document No.", RecMRNLine."Document No.");
                MRNQOHDR1.SetRange("Source Doc. Line No.", RecMRNLine."Line No.");
                if MRNQOHDR1.FindFirst then begin
                    MRNQOHDR1."Lot Size":=MRNQOHDR1."Lot Size" + Qty;
                    MRNQOHDR1.Modify;
                end
                else
                begin
                    MRNQOHDR.Init;
                    MRNQOHDR."Template Type":=RecTemplateType;
                    MRNQOHDR."Entry Source Type":=MRNQOHDR."entry source type"::MRN;
                    MRNQOHDR."Source Document No.":=RecMRNLine."Document No.";
                    MRNQOHDR."Creation Date":=WorkDate;
                    MRNQOHDR."Source Doc. Line No.":=RecMRNLine."Line No.";
                    MRNQOHDR."Order No.":=RecMRNLine."Prod. Order No.";
                    MRNQOHDR."Sampling Method":=MRNQOHDR."sampling method"::"Complete Quantity";
                    MRNQOHDR."Item No.":=RecMRNLine."No.";
                    MRNQOHDR."Unit of Measure Code":=RecMRNLine."Unit of Measure Code";
                    MRNQOHDR."Qty. per Unit of Measure":=RecMRNLine."Qty. per Unit of Measure";
                    MRNQOHDR."Variant Code":=RecMRNLine."Variant Code";
                    MRNQOHDR."Location Code":=RecMRNLine."Location Code";
                    MRNQOHDR."Bin Code":=RecMRNLine."Bin Code";
                    MRNQOHDR."Lot Size":=Abs(Qty);
                    MRNQOHDR."Lot No.":=ReservationEntry."Lot No.";
                    MRNQOHDR."No. Series":=MRNQOHDR.GetNoSeries(true);
                    MRNQOHDR."No.":='';
                    //5.51 to add sampling template automatically.
                    ItemSamplingTemp1.Reset;
                    ItemSamplingTemp1.SetRange(ItemSamplingTemp1."Item Code", RecMRNLine."No.");
                    ItemSamplingTemp1.SetRange(ItemSamplingTemp1.Active, true);
                    if ItemSamplingTemp1.FindFirst then MRNQOHDR."Sampling Temp. No.":=ItemSamplingTemp1."Sampling Temp. No.";
                    //end 5.51
                    MRNQOHDR.Subcontracting:=true;
                    MRNQOHDR."Entry User":=UserId;
                    MRNQOHDR."Posting Date":=WorkDate;
                    MRNQOHDR.Insert(true);
                    LineNo:=10000;
                end;
            end;
        end
        else
            Error(Txt00010);
        RecMRNLine."Quality Send":=true;
        RecMRNLine.Modify;
    //PQA-003
    end;
    [IntegrationEvent(false, false)]
    local procedure OnBeforeInsertManufacturingQualityOrder(ItemJournalLine: Record "Item Journal Line"; SSDQualityOrderHeader: Record "SSD Quality Order Header")
    begin
    end;
}
