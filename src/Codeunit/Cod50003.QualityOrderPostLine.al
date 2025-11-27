Codeunit 50003 "Quality Order -Post Line"
{
    // /////Reg. Doc. Muestreo==>Sampling Doc.-Post Line
    // CMLTEST-026 AA 100208
    //   - Code Added In SQL Migration for deleting the Quality Header
    // //WMC001.01
    // // SR_PQA003: To update Warehouse Recept header and Line "Accepted Qty and Rejected Qty" with Item tracking Lot Size
    Permissions = TableData "Item Ledger Entry"=rm,
        TableData "Reservation Entry"=rm;
    TableNo = "SSD Quality Order Header";

    trigger OnRun()
    var
        WHReceiptLineLocal: Record "Warehouse Receipt Line";
        QualityOrderLineLocal: Record "SSD Quality Order Line";
        QualityCommentsLocal: Record "SSD Quality Comments";
        PostedQCommentsLocal: Record "SSD Quality Comments";
        PostedQOrderHeaderLocal: Record "SSD Posted Quality Order Hdr";
        PostedQOrderLineLocal: Record "SSD Posted Quality Order Line";
        QualityTypeLocal: Option Scrap, Reclassification, Reprocess, Wrong;
        QualityOrderHeaderLocal: Record "SSD Quality Order Header";
        QOrderSampleLineLocal: Record "SSD Quality Order Sample Line";
        TotalAcceptedQty: Decimal;
        TotalRejectedQty: Decimal;
        PostedSubQOrderNo: Code[20];
        ItemLocal: Record Item;
        QualityHeaderDelete: Record "SSD Quality Order Header";
        LocalLocation: Record Location;
        PostedQualityOrderHeader: Record "SSD Posted Quality Order Hdr";
        WHReceiptHeaderLocal: Record "Warehouse Receipt Header";
        WHReceiptLineLocal2: Record "Warehouse Receipt Line";
        WHReceiptLineLocal3: Record "Warehouse Receipt Line";
        PurchaselineLocal: Record "Purchase Line";
        QualityOrdHdrLocal: Record "SSD Quality Order Header";
        IsHandled: Boolean;
    begin
        if Rec."Template Type" in[Rec."template type"::Manufacturing, Rec."template type"::Receipt, Rec."template type"::RcvdCoil]then if not Confirm(Txt00001, false, Rec.TableCaption, Rec."No.")then exit;
        ///******* Checking For Quality Order Header ***************
        Rec.CheckingOfQualityOrder(Rec);
        Rec.TestField(Finished, false);
        Rec.TestField(Status, Rec.Status::Released);
        //******** Checking For Lot Size and Sample size ***************
        if(Rec."Is Coil Type") and (Rec."Template Type" = Rec."template type"::Receipt)then begin
            Rec.CalcFields(Rec."Total Qty. Sent For Inspection");
            //ALLE
            if COMPANYNAME = 'Zavenir Daubert India (P) Ltd.' then begin
                if Rec."Total Qty. Sent For Inspection" <> Rec."Lot Size" then Error(Txt00005, Rec.FieldCaption("Lot Size"), Rec.FieldCaption("Total Qty. Sent For Inspection"));
            end;
            if COMPANYNAME = 'Zavenir Kluthe India (P) Ltd.' then begin
                if Rec."Total Qty. Sent For Inspet(K)" <> Rec."Lot Size" then Error(Txt00005, Rec.FieldCaption("Lot Size"), Rec.FieldCaption("Total Qty. Sent For Inspet(K)"));
            end;
            //ALLE
            if Rec."Lot Size" <> (Rec."Accepted Qty." + Rec."Rejected Qty.")then Error(Txt00006, Rec."Lot Size");
        end;
        if Rec."Posting Date" = 0D then Rec."Posting Date":=WorkDate;
        Setup.Get(UserMgt.GetRespCenterFilter);
        QualityOrderHeader.Copy(Rec);
        Vendorcode:='';
        case QualityOrderHeader."Template Type" of QualityOrderHeader."template type"::Receipt, QualityOrderHeader."template type"::RcvdCoil: Vendorcode:=QualityOrderHeader."Source Code";
        QualityOrderHeader."template type"::Manufacturing: if WordCenter.ReadPermission and (QualityOrderHeader."Entry Source Type" <> QualityOrderHeader."entry source type"::Routing)then if WordCenter.Get(QualityOrderHeader."W.C. / M.C. No.") and (WordCenter."Subcontractor No." <> '')then Vendorcode:=WordCenter."Subcontractor No.";
        end;
        QualityOrderHeader.Modify;
        /////********** Posting Of Quality Order *******************
        if Rec."Template Type" <> Rec."template type"::RcvdCoil then begin
            PostedQualityOrderHeader.Reset;
            PostedQualityOrderHeader.SetCurrentkey("Source Document No.", "Item No.");
            PostedQualityOrderHeader.SetRange("Source Document No.", Rec."Source Document No.");
            PostedQualityOrderHeader.SetRange("Item No.", Rec."Item No.");
            PostedQualityOrderHeader.CalcSums("Accepted Qty.");
            PostedQualityOrderHeader.CalcSums("Rejected Qty.");
            PostedQOrderHeaderLocal.Init;
            PostedQOrderHeaderLocal.TransferFields(Rec);
            PostedQOrderHeaderLocal."Posted By":=UserId;
            PostedQOrderNo:=PostedQOrderHeaderLocal."No.";
            PostedQOrderHeaderLocal."Time Of Posting":=Time; //Alle[Z]
            PostedQOrderHeaderLocal.Insert;
            QualityOrderLineLocal.Reset;
            QualityOrderLineLocal.SetRange("Document No.", Rec."No.");
            if QualityOrderLineLocal.Find('-')then repeat PostedQOrderLineLocal.Init;
                    PostedQOrderLineLocal.TransferFields(QualityOrderLineLocal);
                    PostedQOrderLineLocal."Document No.":=PostedQOrderNo;
                    PostedQOrderLineLocal.Insert;
                until QualityOrderLineLocal.Next = 0;
            QualityCommentsLocal.Reset;
            QualityCommentsLocal.SetRange(TableId, Database::"SSD Quality Order Header");
            QualityCommentsLocal.SetRange("Doc. No.", Rec."No.");
            if QualityCommentsLocal.Find('-')then repeat PostedQCommentsLocal.Init;
                    PostedQCommentsLocal:=QualityCommentsLocal;
                    PostedQCommentsLocal.TableId:=Database::"SSD Posted Quality Order Hdr";
                    PostedQCommentsLocal."Doc. No.":=PostedQOrderNo;
                    PostedQCommentsLocal.Insert;
                until QualityCommentsLocal.Next = 0;
            QualityCommentsLocal.Reset;
            QualityCommentsLocal.SetRange(TableId, Database::"SSD Quality Order Line");
            QualityCommentsLocal.SetRange("Doc. No.", Rec."No.");
            if QualityCommentsLocal.Find('-')then repeat PostedQCommentsLocal.Init;
                    PostedQCommentsLocal:=QualityCommentsLocal;
                    PostedQCommentsLocal.TableId:=Database::"SSD Posted Quality Order Line";
                    PostedQCommentsLocal."Doc. No.":=PostedQOrderNo;
                    PostedQCommentsLocal.Insert;
                until QualityCommentsLocal.Next = 0;
            ///*********** For Posting of Sub Quality Order *****************
            case Rec."Template Type" of Rec."template type"::Receipt: begin
                if Rec."Is Coil Type" then begin
                    QualityOrderHeaderLocal.Reset;
                    QualityOrderHeaderLocal.SetCurrentkey("Template Type", "Entry Source Type", "Order No.");
                    QualityOrderHeaderLocal.SetRange("Template Type", QualityOrderHeaderLocal."template type"::RcvdCoil);
                    QualityOrderHeaderLocal.SetRange("Entry Source Type", QualityOrderHeaderLocal."entry source type"::MRN);
                    QualityOrderHeaderLocal.SetRange("Order No.", Rec."No.");
                    if QualityOrderHeaderLocal.Find('-')then repeat PostedQOrderHeaderLocal.Init;
                            PostedQOrderHeaderLocal.TransferFields(QualityOrderHeaderLocal);
                            PostedQOrderHeaderLocal."Order No.":=PostedQOrderNo;
                            PostedSubQOrderNo:=PostedQOrderHeaderLocal."No.";
                            PostedQOrderHeaderLocal."Posted By":=UserId;
                            PostedQOrderHeaderLocal.Insert;
                            QualityOrderLineLocal.Reset;
                            QualityOrderLineLocal.SetRange("Document No.", QualityOrderHeaderLocal."No.");
                            if QualityOrderLineLocal.Find('-')then repeat PostedQOrderLineLocal.Init;
                                    PostedQOrderLineLocal.TransferFields(QualityOrderLineLocal);
                                    PostedQOrderLineLocal."Document No.":=PostedSubQOrderNo;
                                    PostedQOrderLineLocal.Insert;
                                    QualityCommentsLocal.Reset;
                                    QualityCommentsLocal.SetRange(TableId, Database::"SSD Quality Order Line");
                                    QualityCommentsLocal.SetRange("Doc. No.", QualityOrderHeaderLocal."No.");
                                    if QualityCommentsLocal.Find('-')then repeat PostedQCommentsLocal.Init;
                                            PostedQCommentsLocal:=QualityCommentsLocal;
                                            PostedQCommentsLocal.TableId:=Database::"SSD Posted Quality Order Line";
                                            PostedQCommentsLocal."Doc. No.":=PostedSubQOrderNo;
                                            PostedQCommentsLocal.Insert;
                                        until QualityCommentsLocal.Next = 0;
                                until QualityOrderLineLocal.Next = 0;
                            QualityCommentsLocal.Reset;
                            QualityCommentsLocal.SetRange(TableId, Database::"SSD Quality Order Header");
                            QualityCommentsLocal.SetRange("Doc. No.", QualityOrderHeaderLocal."No.");
                            if QualityCommentsLocal.Find('-')then repeat PostedQCommentsLocal.Init;
                                    PostedQCommentsLocal:=QualityCommentsLocal;
                                    PostedQCommentsLocal.TableId:=Database::"SSD Posted Quality Order Hdr";
                                    PostedQCommentsLocal."Doc. No.":=PostedSubQOrderNo;
                                    PostedQCommentsLocal.Insert;
                                until QualityCommentsLocal.Next = 0;
                        until QualityOrderHeaderLocal.Next = 0;
                end;
            end;
            Rec."template type"::Manufacturing: begin
                QualityOrderHeaderLocal.Reset;
                QualityOrderHeaderLocal.SetCurrentkey("Template Type", "Entry Source Type", "Order No.");
                QualityOrderHeaderLocal.SetRange("Template Type", QualityOrderHeaderLocal."template type"::Routing);
                QualityOrderHeaderLocal.SetRange("Entry Source Type", QualityOrderHeaderLocal."entry source type"::"Manufac.");
                QualityOrderHeaderLocal.SetRange("Order No.", Rec."No.");
                if QualityOrderHeaderLocal.Find('-')then repeat PostedQOrderHeaderLocal.Init;
                        PostedQOrderHeaderLocal.TransferFields(QualityOrderHeaderLocal);
                        PostedQOrderHeaderLocal."Order No.":=PostedQOrderNo;
                        PostedQOrderHeaderLocal."Time Of Posting":=Time; //Alle[Z]
                        PostedSubQOrderNo:=PostedQOrderHeaderLocal."No.";
                        PostedQOrderHeaderLocal."Posted By":=UserId;
                        PostedQOrderHeaderLocal.Insert;
                        QualityOrderLineLocal.Reset;
                        QualityOrderLineLocal.SetRange("Document No.", QualityOrderHeaderLocal."No.");
                        if QualityOrderLineLocal.Find('-')then repeat PostedQOrderLineLocal.Init;
                                PostedQOrderLineLocal.TransferFields(QualityOrderLineLocal);
                                PostedQOrderLineLocal."Document No.":=PostedSubQOrderNo;
                                PostedQOrderLineLocal.Insert;
                                QualityCommentsLocal.Reset;
                                QualityCommentsLocal.SetRange(TableId, Database::"SSD Quality Order Line");
                                QualityCommentsLocal.SetRange("Doc. No.", QualityOrderHeaderLocal."No.");
                                if QualityCommentsLocal.Find('-')then repeat PostedQCommentsLocal.Init;
                                        PostedQCommentsLocal:=QualityCommentsLocal;
                                        PostedQCommentsLocal.TableId:=Database::"SSD Posted Quality Order Line";
                                        PostedQCommentsLocal."Doc. No.":=PostedSubQOrderNo;
                                        PostedQCommentsLocal.Insert;
                                    until QualityCommentsLocal.Next = 0;
                            until QualityOrderLineLocal.Next = 0;
                        QualityCommentsLocal.Reset;
                        QualityCommentsLocal.SetRange(TableId, Database::"SSD Quality Order Header");
                        QualityCommentsLocal.SetRange("Doc. No.", QualityOrderHeaderLocal."No.");
                        if QualityCommentsLocal.Find('-')then repeat PostedQCommentsLocal.Init;
                                PostedQCommentsLocal:=QualityCommentsLocal;
                                PostedQCommentsLocal.TableId:=Database::"SSD Posted Quality Order Hdr";
                                PostedQCommentsLocal."Doc. No.":=PostedSubQOrderNo;
                                PostedQCommentsLocal.Insert;
                            until QualityCommentsLocal.Next = 0;
                        QualityOrderHeaderLocal.Finished:=true;
                        QualityOrderHeaderLocal.Modify;
                    until QualityOrderHeaderLocal.Next = 0;
            end;
            end;
        end;
        /////********** Modify Source Entry with Acceptable And Rejectable Quantity **********
        OnBeforeReceiptUpdate(Rec, IsHandled);
        if not IsHandled then if not Rec.Subcontracting then begin
                case Rec."Entry Source Type" of Rec."Entry source type"::MRN: begin
                    case Rec."Template Type" of Rec."template type"::Receipt: begin
                        //<<< ALLE[5.51] in case of item journal
                        if not WHReceiptLineLocal.Get(Rec."Source Document No.", Rec."Source Doc. Line No.")then begin
                            QualityOrderHeaderLocal.SetRange(QualityOrderHeaderLocal."No.", PostedQOrderNo);
                            if QualityOrderHeaderLocal.Find('-')then QualityOrderHeaderLocal.Delete;
                            PostedQOrderLineLocal.SetRange(PostedQOrderLineLocal."Document No.", PostedQOrderNo);
                            if QualityOrderLineLocal.Find('-')then QualityOrderLineLocal.DeleteAll;
                            Rec:=QualityOrderHeaderLocal;
                            exit;
                        end;
                        //>>>> ALLE[5.51]
                        WHReceiptLineLocal.Get(Rec."Source Document No.", Rec."Source Doc. Line No.");
                        if Rec."Sampling Method" = Rec."sampling method"::"Complete Quantity" then begin
                            WHReceiptLineLocal."Accepted Qty.":=Rec."Accepted Qty." + PostedQualityOrderHeader."Accepted Qty.";
                            WHReceiptLineLocal."Rejected Qty.":=Rec."Rejected Qty." + PostedQualityOrderHeader."Rejected Qty.";
                            WHReceiptLineLocal."Posted Quality Order No.":=PostedQOrderNo; // SR_PQA003
                            //IF WHReceiptLineLocal."Actual Qty. to Receive" = WHReceiptLineLocal."Accepted Qty." +
                            //WHReceiptLineLocal."Rejected Qty."
                            //THEN
                            //WHReceiptLineLocal."Quality Done":=TRUE;
                            if WHReceiptLineLocal."Actual Qty. to Receive" = WHReceiptLineLocal."Accepted Qty." + WHReceiptLineLocal."Rejected Qty." //Alle[Z]
 then WHReceiptLineLocal."Quality Done":=true;
                            if ROUND(WHReceiptLineLocal."Qty. to Receive (Base)", 1, '=') = ROUND((WHReceiptLineLocal."Accepted Qty." + WHReceiptLineLocal."Rejected Qty."), 1, '=')then WHReceiptLineLocal."Quality Done":=true;
                            if not WHReceiptLineLocal.Trading then WHReceiptLineLocal."Reject Location Code":=Setup."Rejection Location Code"
                            else
                                WHReceiptLineLocal."Reject Location Code":=Setup."Trading Rejection Location";
                            WHReceiptLineLocal.Modify;
                            //PQA-003
                            ReservationEntry.Reset;
                            ReservationEntry.SetCurrentkey("MRN No.", "Item No.", "MRN Line No.", "Lot No.");
                            ReservationEntry.SetRange("MRN No.", WHReceiptLineLocal."No.");
                            ReservationEntry.SetRange("Item No.", WHReceiptLineLocal."Item No.");
                            ReservationEntry.SetRange("MRN Line No.", WHReceiptLineLocal."Line No.");
                            ReservationEntry.SetRange("Lot No.", Rec."Lot No.");
                            if ReservationEntry.FindFirst then begin
                                ReservationEntry."Rejected Qty.":=Rec."Rejected Qty.";
                                ReservationEntry.Modify;
                            end;
                        // PQA-003
                        end
                        else
                        begin
                            case Rec."Decision For Quality Pass" of Rec."decision for quality pass"::Accepted: begin
                                WHReceiptLineLocal."Accepted Qty.":=Rec."Lot Size";
                                WHReceiptLineLocal."Rejected Qty.":=0;
                                WHReceiptLineLocal."Posted Quality Order No.":=PostedQOrderNo;
                                //IF WHReceiptLineLocal."Actual Qty. to Receive" = WHReceiptLineLocal."Accepted Qty." +
                                //  WHReceiptLineLocal."Rejected Qty."
                                //THEN
                                //  WHReceiptLineLocal."Quality Done":=TRUE;
                                if WHReceiptLineLocal."Actual Qty. to Receive" = WHReceiptLineLocal."Accepted Qty." + WHReceiptLineLocal."Rejected Qty." then WHReceiptLineLocal."Quality Done":=true;
                                //Added For Sampling method %ge  Begin
                                if ROUND(WHReceiptLineLocal."Qty. to Receive (Base)", 1, '=') = ROUND((WHReceiptLineLocal."Accepted Qty." + WHReceiptLineLocal."Rejected Qty."), 1, '=')then WHReceiptLineLocal."Quality Done":=true;
                                //Added For Sampling method %ge  End
                                // SR_PQA003.end
                                WHReceiptLineLocal."Reject Location Code":=Setup."Rejection Location Code";
                                WHReceiptLineLocal.Modify;
                            end;
                            Rec."decision for quality pass"::Rejected: begin
                                // SR_PQA003.begin    -not required Yet
                                WHReceiptLineLocal."Accepted Qty.":=0 + PostedQualityOrderHeader."Accepted Qty.";
                                WHReceiptLineLocal."Rejected Qty.":=Rec."Lot Size" + PostedQualityOrderHeader."Rejected Qty.";
                                // SR_PQA003.end
                                WHReceiptLineLocal."Posted Quality Order No.":=PostedQOrderNo;
                                // SR_PQA003.begin
                                if WHReceiptLineLocal."Actual Qty. to Receive" = WHReceiptLineLocal."Accepted Qty." + WHReceiptLineLocal."Rejected Qty." then WHReceiptLineLocal."Quality Done":=true;
                                //Added For Sampling method %ge  Begin
                                if ROUND(WHReceiptLineLocal."Qty. to Receive (Base)", 1, '=') = ROUND((WHReceiptLineLocal."Accepted Qty." + WHReceiptLineLocal."Rejected Qty."), 1, '=')then WHReceiptLineLocal."Quality Done":=true;
                                //Added For Sampling method %ge  End
                                // SR_PQA003.end
                                WHReceiptLineLocal."Reject Location Code":=Setup."Rejection Location Code";
                                WHReceiptLineLocal.Modify;
                            end;
                            end;
                        end;
                        // SR_PQA003.begin    // To mark Quality done true on Warehouse receipt header
                        WHReceiptLineLocal2.Reset;
                        WHReceiptLineLocal2.SetRange("No.", WHReceiptLineLocal."No.");
                        WHReceiptLineLocal2.SetRange("Quality Required", true);
                        WHReceiptLineLocal3.Reset;
                        WHReceiptLineLocal3.SetRange("No.", WHReceiptLineLocal."No.");
                        WHReceiptLineLocal3.SetRange("Quality Done", true);
                        if WHReceiptLineLocal2.Count = WHReceiptLineLocal3.Count then begin
                            WHReceiptHeaderLocal.Get(WHReceiptLineLocal."No.");
                            WHReceiptHeaderLocal."Quality Done":=true;
                            WHReceiptHeaderLocal.Modify;
                        end;
                    // SR_PQA003.end
                    end;
                    Rec."template type"::RcvdCoil: begin
                        QualityOrderHeaderLocal.Get(Rec."Order No.");
                        if Rec."Sampling Method" = Rec."sampling method"::"Complete Quantity" then begin
                            QualityOrderHeaderLocal."Accepted Qty."+=Rec."Accepted Qty.";
                            QualityOrderHeaderLocal."Rejected Qty."+=Rec."Rejected Qty.";
                            QualityOrderHeaderLocal.Modify;
                        end
                        else
                        begin
                            case Rec."Decision For Quality Pass" of Rec."decision for quality pass"::Accepted: begin
                                QualityOrderHeaderLocal."Accepted Qty."+=Rec."Lot Size";
                                QualityOrderHeaderLocal.Modify;
                            end;
                            Rec."decision for quality pass"::Rejected: begin
                                QualityOrderHeaderLocal."Rejected Qty."+=Rec."Lot Size";
                                QualityOrderHeaderLocal.Modify;
                            end;
                            end;
                        end;
                    end;
                    end;
                end;
                end;
            end;
        //***************************************************** end of rcpt ql *************************************************************
        //****************** 5.51 Subcontracting **************************************
        if Rec.Subcontracting then begin
            case Rec."Entry Source Type" of Rec."entry source type"::MRN: begin
                case Rec."Template Type" of Rec."template type"::Receipt: begin
                    PurchaselineLocal.Get(PurchaselineLocal."document type"::Order, Rec."Source Document No.", Rec."Source Doc. Line No.");
                    if Rec."Sampling Method" = Rec."sampling method"::"Complete Quantity" then begin
                        PurchaselineLocal."Accepted Qty.":=Rec."Accepted Qty." + PostedQualityOrderHeader."Accepted Qty.";
                        PurchaselineLocal."Rejected Qty.":=Rec."Rejected Qty." + PostedQualityOrderHeader."Rejected Qty.";
                        PurchaselineLocal."Quality Done":=true;
                        PurchaselineLocal."Posted Quality Order No.":=PostedQOrderNo; // SR_PQA003
                        if PurchaselineLocal."Qty. to Receive" = PurchaselineLocal."Accepted Qty." + PurchaselineLocal."Rejected Qty." then PurchaselineLocal."Quality Done":=true;
                        PurchaselineLocal."Reject Location Code":=Setup."Rejection Location Code";
                        PurchaselineLocal.Modify;
                        //PQA-003
                        ReservationEntry.Reset;
                        ReservationEntry.SetCurrentkey("MRN No.", "Item No.", "MRN Line No.", "Lot No.");
                        ReservationEntry.SetRange("Source Type", 5406);
                        ReservationEntry.SetRange("Source Subtype", 3);
                        ReservationEntry.SetRange("Source ID", PurchaselineLocal."Prod. Order No.");
                        ReservationEntry.SetRange("Source Prod. Order Line", PurchaselineLocal."Prod. Order Line No.");
                        ReservationEntry.SetRange("Item No.", PurchaselineLocal."No.");
                        ReservationEntry.SetRange("Quantity (Base)", PurchaselineLocal."Qty. to Receive");
                        ReservationEntry.SetRange("Lot No.", Rec."Lot No.");
                        if ReservationEntry.FindFirst then begin
                            ReservationEntry."Rejected Qty.":=Rec."Rejected Qty.";
                            ReservationEntry.Modify;
                        end;
                    // PQA-003
                    end
                    else
                    begin
                        case Rec."Decision For Quality Pass" of Rec."decision for quality pass"::Accepted: begin
                            PurchaselineLocal."Accepted Qty.":=Rec."Lot Size";
                            PurchaselineLocal."Rejected Qty.":=0;
                            PurchaselineLocal."Posted Quality Order No.":=PostedQOrderNo;
                            if PurchaselineLocal."Qty. to Receive" = PurchaselineLocal."Accepted Qty." + PurchaselineLocal."Rejected Qty." then PurchaselineLocal."Quality Done":=true;
                            // SR_PQA003.end
                            PurchaselineLocal."Reject Location Code":=Setup."Rejection Location Code";
                            PurchaselineLocal.Modify;
                        end;
                        Rec."decision for quality pass"::Rejected: begin
                            // SR_PQA003.begin    -not required Yet
                            PurchaselineLocal."Accepted Qty.":=0 + PostedQualityOrderHeader."Accepted Qty.";
                            PurchaselineLocal."Rejected Qty.":=Rec."Lot Size" + PostedQualityOrderHeader."Rejected Qty.";
                            // SR_PQA003.end
                            PurchaselineLocal."Posted Quality Order No.":=PostedQOrderNo;
                            // SR_PQA003.begin
                            if PurchaselineLocal."Qty. to Receive" = PurchaselineLocal."Accepted Qty." + PurchaselineLocal."Rejected Qty." then PurchaselineLocal."Quality Done":=true;
                            // SR_PQA003.end
                            PurchaselineLocal."Reject Location Code":=Setup."Rejection Location Code";
                            PurchaselineLocal."Quality Done":=true;
                            PurchaselineLocal.Modify;
                        end;
                        end;
                    end;
                end;
                Rec."template type"::RcvdCoil: begin
                    QualityOrderHeaderLocal.Get(Rec."Order No.");
                    if Rec."Sampling Method" = Rec."sampling method"::"Complete Quantity" then begin
                        QualityOrderHeaderLocal."Accepted Qty."+=Rec."Accepted Qty.";
                        QualityOrderHeaderLocal."Rejected Qty."+=Rec."Rejected Qty.";
                        QualityOrderHeaderLocal.Modify;
                    end
                    else
                    begin
                        case Rec."Decision For Quality Pass" of Rec."decision for quality pass"::Accepted: begin
                            QualityOrderHeaderLocal."Accepted Qty."+=Rec."Lot Size";
                            QualityOrderHeaderLocal.Modify;
                        end;
                        Rec."decision for quality pass"::Rejected: begin
                            QualityOrderHeaderLocal."Rejected Qty."+=Rec."Lot Size";
                            QualityOrderHeaderLocal.Modify;
                        end;
                        end;
                    end;
                end;
                end;
            end;
            end;
        end;
        //****************** 5.51 subconyracting end **********************************
        if Rec."Template Type" <> Rec."template type"::RcvdCoil then begin
            case Rec."Template Type" of Rec."template type"::Manufacturing: begin
                QualityOrderHeaderLocal.Reset;
                QualityOrderHeaderLocal.SetCurrentkey("Template Type", "Entry Source Type", "Order No.");
                QualityOrderHeaderLocal.SetRange("Template Type", QualityOrderHeaderLocal."template type"::Routing);
                QualityOrderHeaderLocal.SetRange("Entry Source Type", QualityOrderHeaderLocal."entry source type"::"Manufac.");
                QualityOrderHeaderLocal.SetRange("Order No.", Rec."No.");
                if QualityOrderHeaderLocal.Find('-')then repeat QualityOrderLineLocal.Reset;
                        QualityOrderLineLocal.SetRange("Document No.", QualityOrderHeaderLocal."No.");
                        QualityOrderLineLocal.DeleteAll;
                        QualityCommentsLocal.Reset;
                        QualityCommentsLocal.SetRange(TableId, Database::"SSD Quality Order Line");
                        QualityCommentsLocal.SetRange("Doc. No.", QualityOrderHeaderLocal."No.");
                        if QualityCommentsLocal.Find('-')then QualityCommentsLocal.DeleteAll;
                        QualityCommentsLocal.Reset;
                        QualityCommentsLocal.SetRange(TableId, Database::"SSD Quality Order Header");
                        QualityCommentsLocal.SetRange("Doc. No.", QualityOrderHeaderLocal."No.");
                        if QualityCommentsLocal.Find('-')then QualityCommentsLocal.DeleteAll;
                        QualityOrderHeaderLocal.Delete;
                    until QualityOrderHeaderLocal.Next = 0;
            end;
            Rec."template type"::Receipt: begin
                if Rec."Is Coil Type" then begin
                    QualityOrderHeaderLocal.Reset;
                    QualityOrderHeaderLocal.SetCurrentkey("Template Type", "Entry Source Type", "Order No.");
                    QualityOrderHeaderLocal.SetRange("Template Type", QualityOrderHeaderLocal."template type"::RcvdCoil);
                    QualityOrderHeaderLocal.SetRange("Entry Source Type", QualityOrderHeaderLocal."entry source type"::MRN);
                    QualityOrderHeaderLocal.SetRange("Order No.", Rec."No.");
                    if QualityOrderHeaderLocal.Find('-')then repeat QualityOrderLineLocal.Reset;
                            QualityOrderLineLocal.SetRange("Document No.", QualityOrderHeaderLocal."No.");
                            QualityOrderLineLocal.DeleteAll;
                            QualityCommentsLocal.Reset;
                            QualityCommentsLocal.SetRange(TableId, Database::"SSD Quality Order Line");
                            QualityCommentsLocal.SetRange("Doc. No.", QualityOrderHeaderLocal."No.");
                            if QualityCommentsLocal.Find('-')then QualityCommentsLocal.DeleteAll;
                            QualityCommentsLocal.Reset;
                            QualityCommentsLocal.SetRange(TableId, Database::"SSD Quality Order Header");
                            QualityCommentsLocal.SetRange("Doc. No.", QualityOrderHeaderLocal."No.");
                            if QualityCommentsLocal.Find('-')then QualityCommentsLocal.DeleteAll;
                            QualityOrderHeaderLocal.Delete;
                        until QualityOrderHeaderLocal.Next = 0;
                end;
            end;
            end;
            /////********** Deletion Of Quality Order *******************
            QualityOrderLineLocal.Reset;
            QualityOrderLineLocal.SetRange("Document No.", Rec."No.");
            if QualityOrderLineLocal.Find('-')then QualityOrderLineLocal.DeleteAll;
            QualityCommentsLocal.Reset;
            QualityCommentsLocal.SetRange(TableId, Database::"SSD Quality Order Line");
            QualityCommentsLocal.SetRange("Doc. No.", Rec."No.");
            if QualityCommentsLocal.Find('-')then QualityCommentsLocal.DeleteAll;
            QualityCommentsLocal.Reset;
            QualityCommentsLocal.SetRange(TableId, Database::"SSD Quality Order Header");
            QualityCommentsLocal.SetRange("Doc. No.", Rec."No.");
            if QualityCommentsLocal.Find('-')then QualityCommentsLocal.DeleteAll;
            //CMLTEST-026 AA 100208 Start
            QualityHeaderDelete.Reset;
            QualityHeaderDelete.SetRange("No.", Rec."No.");
            if QualityHeaderDelete.Find('-')then QualityHeaderDelete.DeleteAll;
        //DELETE;
        //CMLTEST-026 AA 100208 Finish
        end
        else
        begin
            Rec."Inspection Report Generated":=true;
            Rec.Finished:=true;
            Rec.Modify;
        end;
        //******** For Rerceipt Coil Type ->> Update of Accepted and Rejected qty
        if Rec."Template Type" = Rec."template type"::RcvdCoil then begin
            TotalAcceptedQty:=0;
            TotalRejectedQty:=0;
            QualityOrderHeaderLocal.Reset;
            QualityOrderHeaderLocal.SetCurrentkey("Template Type", "Entry Source Type", "Source Document No.", "Order No.");
            QualityOrderHeaderLocal.SetRange("Template Type", Rec."Template Type");
            QualityOrderHeaderLocal.SetRange("Entry Source Type", Rec."Entry Source Type");
            QualityOrderHeaderLocal.SetRange("Source Document No.", Rec."Source Document No.");
            QualityOrderHeaderLocal.SetRange("Order No.", Rec."Order No.");
            QualityOrderHeaderLocal.SetRange(Finished, true);
            if QualityOrderHeaderLocal.Find('-')then repeat if QualityOrderHeaderLocal."Sampling Method" = QualityOrderHeaderLocal."sampling method"::"Complete Quantity" then begin
                        TotalAcceptedQty+=QualityOrderHeaderLocal."Accepted Qty.";
                        TotalRejectedQty+=QualityOrderHeaderLocal."Rejected Qty.";
                    end
                    else
                    begin
                        case QualityOrderHeaderLocal."Decision For Quality Pass" of QualityOrderHeaderLocal."decision for quality pass"::Accepted: begin
                            TotalAcceptedQty+=QualityOrderHeaderLocal."Lot Size";
                        end;
                        QualityOrderHeaderLocal."decision for quality pass"::Rejected: begin
                            TotalRejectedQty+=QualityOrderHeaderLocal."Lot Size";
                        end;
                        end;
                    end;
                until QualityOrderHeaderLocal.Next = 0;
            QualityOrderHeaderLocal.Get(Rec."Order No.");
            QualityOrderHeaderLocal."Accepted Qty.":=TotalAcceptedQty;
            QualityOrderHeaderLocal."Rejected Qty.":=TotalRejectedQty;
            QualityOrderHeaderLocal.Modify;
        end;
        Rec:=QualityOrderHeader;
        //QualityOrderHeaderLocal
        if(PostedQOrderHeaderLocal."Rejected Qty." = 0)then begin
            ProdOrderRoutingLine.Reset;
            ProdOrderRoutingLine.SetRange("Prod. Order No.", PostedQOrderHeaderLocal."Order No.");
            ProdOrderRoutingLine.SetRange("Routing Reference No.", PostedQOrderHeaderLocal."Source Doc. Line No.");
            ProdOrderRoutingLine.SetRange("Routing No.", PostedQOrderHeaderLocal."Routing No.");
            ProdOrderRoutingLine.SetRange("No.", PostedQOrderHeaderLocal."W.C. / M.C. No.");
            ProdOrderRoutingLine.SetRange("Operation No.", PostedQOrderHeaderLocal."Process/Operation No.");
            if ProdOrderRoutingLine.FindFirst then begin
                ProdOrderRoutingLine."Sent for Quality":=true;
                //<<< ALLE[5.51]
                QualityOrdHdrLocal.SetRange("Entry Source Type", QualityOrdHdrLocal."entry source type"::"Manufac.");
                QualityOrdHdrLocal.SetRange("Source Document No.", PostedQOrderHeaderLocal."Source Document No.");
                QualityOrdHdrLocal.SetRange("Process/Operation No.", PostedQOrderHeaderLocal."Process/Operation No.");
                if QualityOrdHdrLocal.FindFirst then ProdOrderRoutingLine."Quality Done":=false
                else
                    ProdOrderRoutingLine."Quality Done":=true;
                //>>>> ALLE[5.51]
                ProdOrderRoutingLine.Modify;
            end;
            ItemJournalLine.Reset;
            ItemJournalLine.SetRange("Order No.", PostedQOrderHeaderLocal."Order No.");
            //ItemJournalLine.SETRANGE("Line No.",PostedQOrderHeaderLocal."IJL Line No");
            ItemJournalLine.SetRange("Order Line No.", PostedQOrderHeaderLocal."Source Doc. Line No.");
            ItemJournalLine.SetRange("Routing No.", PostedQOrderHeaderLocal."Routing No.");
            ItemJournalLine.SetRange("Work Center No.", PostedQOrderHeaderLocal."Work Center No.");
            if ItemJournalLine.FindFirst then begin
                ItemJournalLine."Sent for Quality":=true;
                //<<< ALLE[5.51]
                QualityOrdHdrLocal.SetRange("Entry Source Type", QualityOrdHdrLocal."entry source type"::"Manufac.");
                QualityOrdHdrLocal.SetRange("Source Document No.", PostedQOrderHeaderLocal."Source Document No.");
                QualityOrdHdrLocal.SetRange("Process/Operation No.", PostedQOrderHeaderLocal."Process/Operation No.");
                if QualityOrdHdrLocal.FindFirst then ItemJournalLine."Quality Done":=false
                else
                    ItemJournalLine."Quality Done":=true;
                //>>>> ALLE[5.51]
                //ItemJournalLine."Quality Done" := TRUE;
                ItemJournalLine.Modify;
            end;
        end
        else
        begin
            ProdOrderRoutingLine.Reset;
            ProdOrderRoutingLine.SetRange("Prod. Order No.", PostedQOrderHeaderLocal."Order No.");
            ProdOrderRoutingLine.SetRange("Routing Reference No.", PostedQOrderHeaderLocal."Source Doc. Line No.");
            ProdOrderRoutingLine.SetRange("Routing No.", PostedQOrderHeaderLocal."Routing No.");
            ProdOrderRoutingLine.SetRange("No.", PostedQOrderHeaderLocal."W.C. / M.C. No.");
            ProdOrderRoutingLine.SetRange("Operation No.", PostedQOrderHeaderLocal."Process/Operation No.");
            if ProdOrderRoutingLine.FindFirst then begin
                ProdOrderRoutingLine."Sent for Quality":=false;
                ProdOrderRoutingLine."Quality Done":=false;
                ProdOrderRoutingLine."Sample Quantity":=0;
                ProdOrderRoutingLine.Modify;
            end;
            ItemJournalLine.Reset;
            ItemJournalLine.SetRange("Order No.", PostedQOrderHeaderLocal."Order No.");
            //vij ItemJournalLine.SETRANGE("Line No.",PostedQOrderHeaderLocal."IJL Line No");
            ItemJournalLine.SetRange("Order Line No.", PostedQOrderHeaderLocal."Source Doc. Line No.");
            ItemJournalLine.SetRange("Routing No.", PostedQOrderHeaderLocal."Routing No.");
            ItemJournalLine.SetRange("Work Center No.", PostedQOrderHeaderLocal."Work Center No.");
            if ItemJournalLine.FindFirst then begin
                ItemJournalLine."Sent for Quality":=false;
                ItemJournalLine."Quality Done":=false;
                ItemJournalLine."Sample Qty. Sent to QC":=0;
                ItemJournalLine.Modify;
            end;
        end;
        Message('%1', 'Document has been successfully Posted');
    end;
    var QualityOrderHeader: Record "SSD Quality Order Header";
    ItemLedgerEntry: Record "Item Ledger Entry";
    xItemLedgerEntry: Record "Item Ledger Entry";
    PostItemLedgerEntry: Codeunit "Item Jnl.-Post Line";
    ItemJnlLine: Record "Item Journal Line";
    Setup: Record "SSD Quality Setup";
    CalcProdOrder: Codeunit "Calculate Prod. Order";
    CreateProdOrderLine: Codeunit "Create Prod. Order Lines";
    POHeader: Record "Production Order";
    POLine: Record "Prod. Order Line";
    POcomponent: Record "Prod. Order Component";
    WordCenter: Record "Work Center";
    Vendorcode: Code[20];
    cReserveManagement: Codeunit "Reservation Engine Mgt.";
    ReservaCompoOrdProd: Codeunit "Prod. Order Comp.-Reserve";
    CreateReservEntry: Codeunit "Create Reserv. Entry";
    VendorClaimPostLine: Codeunit "Vendor Claim -Post Line";
    ItemTrackingMgt: Codeunit "Item Tracking Management";
    TmpReserveEntryPos: Record "Reservation Entry" temporary;
    TmpReserveEntryNeg: Record "Reservation Entry" temporary;
    ReservEngineMgt: Codeunit "Reservation Engine Mgt.";
    TempItemTrackingLine: Record "Tracking Specification" temporary;
    ReservationMgt: Codeunit "Reservation Management";
    ReservEntry: Record "Reservation Entry";
    ReservEntryTransfer: Record "Reservation Entry";
    Txt00001: label 'Do you want to post %1 %2';
    UserMgt: Codeunit "SSD User Setup Management";
    Txt00002: label '%1 must be Acceptable or Rejectable';
    PostedQOrderNo: Code[20];
    Txt00003: label 'No Line Present';
    Txt00004: label 'Sampling Template No %1 not attached with Item Code %2';
    Txt00005: label '%1 must be equal to %2';
    Txt00006: label 'Sum of Accepted Qt and Rejected Qty must be equal to %1';
    ReservationEntry: Record "Reservation Entry";
    ProdOrderRoutingLine: Record "Prod. Order Routing Line";
    ItemJournalLine: Record "Item Journal Line";
    [IntegrationEvent(false, false)]
    local procedure OnBeforeReceiptUpdate(SSDQualityOrderHeader: Record "SSD Quality Order Header"; var IsHandled: Boolean)
    begin
    end;
}
