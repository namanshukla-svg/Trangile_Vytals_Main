codeunit 55001 "Package Mgmt"  //IG_DS
{

    var
        ItemTrackingLine: Page "Item Tracking Lines";
        CreateReserveEntry: Codeunit "Create Reserv. Entry";
        ItemJnlPostLine: Codeunit "Item Jnl.-Post Line";
        ModifyRun: Boolean;
        MIllCode: Code[250];
        VendorTagNo: Code[250];
        VendorBatchNo: Code[30];
        QrSerialNo: Code[25];
        BatchNo: Code[32];
        YP: Option " ","620-770","771-850","851-920";
        NetYp: Code[100];
        YPStatus: Option " ","Low YP","Medium YP","High YP";
        NoOfSheet: Decimal;
        SlitPosition: Text[10];
        ProcessNo: Code[30];
        Specification: Code[50];

    [EventSubscriber(ObjectType::Table, Database::"Transfer Line", OnValidateQuantityOnBeforeTransLineVerifyChange, '', false, false)]
    local procedure "Transfer Line_OnValidateQuantityOnBeforeTransLineVerifyChange"(var TransferLine: Record "Transfer Line"; xTransferLine: Record "Transfer Line"; var IsHandled: Boolean)
    begin
        if TransferLine.Quantity <> 0 then
            TransferLine.Validate("Qty. to Ship", (TransferLine.Quantity - TransferLine."Quantity Shipped"));
    end;

    [EventSubscriber(ObjectType::Table, Database::"Transfer Line", OnAfterUpdateWithWarehouseShipReceive, '', false, false)]
    local procedure "Transfer Line_OnAfterUpdateWithWarehouseShipReceive"(var TransferLine: Record "Transfer Line"; CurrentFieldNo: Integer)
    begin
        if TransferLine.Quantity <> 0 then begin
            TransferLine.Validate("Qty. to Ship", (TransferLine.Quantity - TransferLine."Quantity Shipped"));
            TransferLine.Validate("Qty. to Receive", (TransferLine."Quantity Shipped" - TransferLine."Quantity Received"));
        end;
    end;


    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Item Tracking Data Collection", OnRetrieveLookupDataOnBeforeTransferToTempRec, '', false, false)]
    local procedure "Item Tracking Data Collection_OnRetrieveLookupDataOnBeforeTransferToTempRec"(var TempTrackingSpecification: Record "Tracking Specification" temporary; var TempReservationEntry: Record "Reservation Entry" temporary; var ItemLedgerEntry: Record "Item Ledger Entry"; var FullDataSet: Boolean)
    var
        PostedQualityOrder: Record 50082;
        QualityOrderList: Record 50084;
    begin
        ItemLedgerEntry.SetRange("Lot Blocked", false);
        //IG_DS>>
        if not (((TempTrackingSpecification."Source Type" = 5741) and
        (TempTrackingSpecification."Source Subtype" = TempTrackingSpecification."Source Subtype"::"0")) or
        ((TempTrackingSpecification."Source Type" = 83) and
        (TempTrackingSpecification."Source Subtype" = TempTrackingSpecification."Source Subtype"::"4"))) then begin //IG_DS and (TempTrackingSpecification."Source ID" = 'CONSUMPTIO')
            ItemLedgerEntry.CalcFields("Quality Status Released");
            ItemLedgerEntry.SetRange("Quality Status Released", false);
        end;
        // end;
        // if (TempTrackingSpecification."Source Type" = 5407) and (TempTrackingSpecification."Source Subtype" = TempTrackingSpecification."Source Subtype"::"3") then begin
        //     PostedQualityOrder.Reset();
        //     PostedQualityOrder.SetRange("Decision For Quality Pass", PostedQualityOrder."Decision For Quality Pass"::Accepted);
        //     PostedQualityOrder.SetRange("Lot No.", ItemLedgerEntry."Lot No.");
        //     if PostedQualityOrder.FindFirst() then
        //         ItemLedgerEntry.SetRange("Lot No.", PostedQualityOrder."Lot No.");
        // end;
    end;


    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Item Jnl.-Post Line", OnBeforeInsertItemLedgEntry, '', false, false)]
    local procedure "Item Jnl.-Post Line_OnBeforeInsertItemLedgEntry"(var ItemLedgerEntry: Record "Item Ledger Entry"; ItemJournalLine: Record "Item Journal Line"; TransferItem: Boolean; OldItemLedgEntry: Record "Item Ledger Entry"; ItemJournalLineOrigin: Record "Item Journal Line")
    var
    begin
        // InsertPackingTrackingFromItemJournal(ItemJournalLine);
        // InsertPackingTrackingFromItemReclass(ItemJournalLine);
        // InsertPackingTrackingFromWarehouseShip(ItemJournalLine);
        // InsertPackingTrackingFromRPOConsumption(ItemJournalLine);
        // InsertPackingTrackingFromTransferOrder(ItemJournalLine);
    end;

    local procedure InsertPackingTrackingFromItemJournal(ItemJournalLine: Record "Item Journal Line")
    var
        PackageTracking: Record "Package Tracking";
        PackageTrackingSourceIDUpdate: Record "Package Tracking";
        PackageTrackingXRec: Record "Package Tracking";
        PackageTrackingOld: Record "Package Tracking";
        EntryNo: Integer;
        FromEntryNo: Integer;
        ToEntryNo: Integer;
    begin
        // if (ItemJournalLine."Entry Type" = ItemJournalLine."Entry Type"::"Positive Adjmt.") and
        //        (ItemJournalLine."Journal Template Name" = 'ISSUE') then begin
        //     PackageTrackingSourceIDUpdate.Reset();
        //     PackageTrackingSourceIDUpdate.SetRange("Lot No.", ItemJournalLine."Lot No.");
        //     if PackageTrackingSourceIDUpdate.FindFirst() then
        //         repeat
        //             if PackageTrackingSourceIDUpdate."Source ID" <> ItemJournalLine."Document No." then begin
        //                 PackageTrackingSourceIDUpdate."Source ID" := ItemJournalLine."Document No.";
        //                 PackageTrackingSourceIDUpdate.Modify();
        //             end;
        //         until PackageTrackingSourceIDUpdate.Next() = 0;
        // end;

        if (ItemJournalLine."Entry Type" = ItemJournalLine."Entry Type"::"Negative Adjmt.") and
               (ItemJournalLine."Journal Template Name" = 'ISSUE') and
                 (ItemJournalLine."From Package" <> '') and
                 (ItemJournalLine."To Package" <> '') then begin

            Clear(FromEntryNo);
            PackageTrackingXRec.Reset();
            PackageTrackingXRec.SetRange("Package No.", ItemJournalLine."From Package");
            PackageTrackingXRec.SetRange(Utilized, false);
            PackageTrackingXRec.SetFilter(Quantity, '>%1', 0);
            if PackageTrackingXRec.FindFirst() then
                FromEntryNo := PackageTrackingXRec."Entry No.";

            Clear(ToEntryNo);
            PackageTrackingXRec.Reset();
            PackageTrackingXRec.SetRange("Package No.", ItemJournalLine."To Package");
            PackageTrackingXRec.SetRange(Utilized, false);
            PackageTrackingXRec.SetFilter(Quantity, '>%1', 0);
            if PackageTrackingXRec.FindFirst() then
                ToEntryNo := PackageTrackingXRec."Entry No.";

            if (FromEntryNo <> 0) and (ToEntryNo <> 0) then begin
                PackageTrackingXRec.Reset();
                PackageTrackingXRec.SetRange("Entry No.", FromEntryNo, ToEntryNo);
                if PackageTrackingXRec.FindFirst() then
                    repeat
                        PackageTracking.Init();

                        // Get the next Entry No.
                        PackageTrackingOld.Reset();
                        PackageTrackingOld.SetCurrentKey("Entry No.");
                        if PackageTrackingOld.FindLast() then
                            EntryNo := PackageTrackingOld."Entry No." + 1
                        else
                            EntryNo := 1;

                        // Assign fields from XRec
                        PackageTracking."Entry No." := EntryNo;
                        PackageTracking."Entry Type" := PackageTracking."Entry Type"::"Negative Adjmt.";
                        PackageTracking."Source ID" := PackageTrackingXRec."Source ID";
                        PackageTracking."Document No." := ItemJournalLine."Document No.";
                        PackageTracking."Source Subtype" := PackageTrackingXRec."Source Subtype";
                        PackageTracking."Source Type" := PackageTrackingXRec."Source Type";
                        PackageTracking."Source Ref. No." := PackageTrackingXRec."Source Ref. No.";
                        PackageTracking."Expiration Date" := PackageTrackingXRec."Expiration Date";
                        PackageTracking."Item No." := PackageTrackingXRec."Item No.";
                        PackageTracking."Lot No." := PackageTrackingXRec."Lot No.";
                        PackageTracking."Location Code" := PackageTrackingXRec."Location Code";
                        PackageTracking."Pack Quantity" := -PackageTrackingXRec."Pack Quantity";
                        PackageTracking."Package No." := PackageTrackingXRec."Package No.";
                        PackageTracking."Posting Date" := ItemJournalLine."Posting Date";
                        PackageTracking.Quantity := -PackageTrackingXRec."Pack Quantity";
                        PackageTrackingXRec.Utilized := true;
                        PackageTrackingXRec.Modify();
                        // Insert the new tracking entry
                        PackageTracking.Insert();

                    until PackageTrackingXRec.Next() = 0;
            end;
        end;
    end;

    local procedure InsertPackingTrackingFromItemReclass(ItemJournalLine: Record "Item Journal Line")
    var
        PackageTracking: Record "Package Tracking";
        PackageTrackingXRec: Record "Package Tracking";
        PackageTrackingOld: Record "Package Tracking";
        EntryNo: Integer;
        FromEntryNo: Integer;
        ToEntryNo: Integer;
    begin

        if (ItemJournalLine."Entry Type" = ItemJournalLine."Entry Type"::Transfer) and
               (ItemJournalLine."Journal Template Name" = 'TRANSFER') and
                 (ItemJournalLine."From Package" <> '') and
                 (ItemJournalLine."To Package" <> '') then begin

            Clear(FromEntryNo);
            PackageTrackingXRec.Reset();
            PackageTrackingXRec.SetRange("Package No.", ItemJournalLine."From Package");
            PackageTrackingXRec.SetRange(Utilized, false);
            PackageTrackingXRec.SetFilter(Quantity, '>%1', 0);
            if PackageTrackingXRec.FindFirst() then
                FromEntryNo := PackageTrackingXRec."Entry No.";

            Clear(ToEntryNo);
            PackageTrackingXRec.Reset();
            PackageTrackingXRec.SetRange("Package No.", ItemJournalLine."To Package");
            PackageTrackingXRec.SetRange(Utilized, false);
            PackageTrackingXRec.SetFilter(Quantity, '>%1', 0);
            if PackageTrackingXRec.FindFirst() then
                ToEntryNo := PackageTrackingXRec."Entry No.";

            if (FromEntryNo <> 0) and (ToEntryNo <> 0) then begin
                PackageTrackingXRec.Reset();
                PackageTrackingXRec.SetRange("Entry No.", FromEntryNo, ToEntryNo);
                if PackageTrackingXRec.FindFirst() then
                    repeat
                        PackageTracking.Init();

                        // Get the next Entry No.
                        PackageTrackingOld.Reset();
                        PackageTrackingOld.SetCurrentKey("Entry No.");
                        if PackageTrackingOld.FindLast() then
                            EntryNo := PackageTrackingOld."Entry No." + 1
                        else
                            EntryNo := 1;

                        // Assign fields from XRec
                        PackageTracking."Entry No." := EntryNo;
                        PackageTracking."Entry Type" := PackageTracking."Entry Type"::Transfer;
                        PackageTracking."Source ID" := PackageTrackingXRec."Source ID";
                        PackageTracking."Document No." := ItemJournalLine."Document No.";
                        PackageTracking."Source Subtype" := PackageTrackingXRec."Source Subtype";
                        PackageTracking."Source Type" := PackageTrackingXRec."Source Type";
                        PackageTracking."Source Ref. No." := PackageTrackingXRec."Source Ref. No.";
                        PackageTracking."Expiration Date" := PackageTrackingXRec."Expiration Date";
                        PackageTracking."Item No." := PackageTrackingXRec."Item No.";
                        PackageTracking."Lot No." := PackageTrackingXRec."Lot No.";
                        PackageTracking."Location Code" := PackageTrackingXRec."Location Code";
                        PackageTracking."Pack Quantity" := -PackageTrackingXRec."Pack Quantity";
                        PackageTracking."Package No." := PackageTrackingXRec."Package No.";
                        PackageTracking."Posting Date" := ItemJournalLine."Posting Date";
                        PackageTracking.Quantity := -PackageTrackingXRec."Pack Quantity";
                        PackageTrackingXRec.Utilized := true;
                        PackageTrackingXRec.Modify();

                        // Insert the new tracking entry
                        PackageTracking.Insert();

                    until PackageTrackingXRec.Next() = 0;
            end;
        end;
    end;

    local procedure InsertPackingTrackingFromWarehouseShip(ItemJournalLine: Record "Item Journal Line")
    var
        PackageTracking: Record "Package Tracking";
        PackageTrackingXRec: Record "Package Tracking";
        PackageTrackingOld: Record "Package Tracking";
        EntryNo: Integer;
        FromEntryNo: Integer;
        ToEntryNo: Integer;
    begin

        if (ItemJournalLine."Entry Type" = ItemJournalLine."Entry Type"::Sale) and
               (ItemJournalLine."Source Type" = ItemJournalLine."Source Type"::Customer) and
                 (ItemJournalLine."From Package" <> '') and
                 (ItemJournalLine."To Package" <> '') then begin

            Clear(FromEntryNo);
            PackageTrackingXRec.Reset();
            PackageTrackingXRec.SetRange("Package No.", ItemJournalLine."From Package");
            PackageTrackingXRec.SetRange(Utilized, false);
            PackageTrackingXRec.SetFilter(Quantity, '>%1', 0);
            if PackageTrackingXRec.FindFirst() then
                FromEntryNo := PackageTrackingXRec."Entry No.";

            Clear(ToEntryNo);
            PackageTrackingXRec.Reset();
            PackageTrackingXRec.SetRange("Package No.", ItemJournalLine."To Package");
            PackageTrackingXRec.SetRange(Utilized, false);
            PackageTrackingXRec.SetFilter(Quantity, '>%1', 0);
            if PackageTrackingXRec.FindFirst() then
                ToEntryNo := PackageTrackingXRec."Entry No.";

            if (FromEntryNo <> 0) and (ToEntryNo <> 0) then begin
                PackageTrackingXRec.Reset();
                PackageTrackingXRec.SetRange("Entry No.", FromEntryNo, ToEntryNo);
                if PackageTrackingXRec.FindFirst() then
                    repeat
                        PackageTracking.Init();

                        // Get the next Entry No.
                        PackageTrackingOld.Reset();
                        PackageTrackingOld.SetCurrentKey("Entry No.");
                        if PackageTrackingOld.FindLast() then
                            EntryNo := PackageTrackingOld."Entry No." + 1
                        else
                            EntryNo := 1;

                        // Assign fields from XRec
                        PackageTracking."Entry No." := EntryNo;
                        PackageTracking."Entry Type" := PackageTracking."Entry Type"::Sale;
                        PackageTracking."Document No." := ItemJournalLine."Document No.";
                        PackageTracking."Source ID" := PackageTrackingXRec."Source ID";
                        PackageTracking."Source Subtype" := PackageTrackingXRec."Source Subtype";
                        PackageTracking."Source Type" := PackageTrackingXRec."Source Type";
                        PackageTracking."Source Ref. No." := PackageTrackingXRec."Source Ref. No.";
                        PackageTracking."Expiration Date" := PackageTrackingXRec."Expiration Date";
                        PackageTracking."Item No." := PackageTrackingXRec."Item No.";
                        PackageTracking."Lot No." := PackageTrackingXRec."Lot No.";
                        PackageTracking."Location Code" := PackageTrackingXRec."Location Code";
                        PackageTracking."Pack Quantity" := -PackageTrackingXRec."Pack Quantity";
                        PackageTracking."Package No." := PackageTrackingXRec."Package No.";
                        PackageTracking."Posting Date" := ItemJournalLine."Posting Date";
                        PackageTracking.Quantity := -PackageTrackingXRec."Pack Quantity";
                        PackageTrackingXRec.Utilized := true;
                        PackageTrackingXRec.Modify();

                        // Insert the new tracking entry
                        PackageTracking.Insert();

                    until PackageTrackingXRec.Next() = 0;
            end;
        end;
    end;

    local procedure InsertPackingTrackingFromRPOConsumption(ItemJournalLine: Record "Item Journal Line")
    var
        PackageTracking: Record "Package Tracking";
        PackageTrackingXRec: Record "Package Tracking";
        PackageTrackingOld: Record "Package Tracking";
        EntryNo: Integer;
        FromEntryNo: Integer;
        ToEntryNo: Integer;
    begin

        if (ItemJournalLine."Entry Type" = ItemJournalLine."Entry Type"::Consumption) and
               (ItemJournalLine."Source Type" = ItemJournalLine."Source Type"::Item) and
                 (ItemJournalLine."From Package" <> '') and
                 (ItemJournalLine."To Package" <> '') then begin

            Clear(FromEntryNo);
            PackageTrackingXRec.Reset();
            PackageTrackingXRec.SetRange("Package No.", ItemJournalLine."From Package");
            PackageTrackingXRec.SetRange(Utilized, false);
            PackageTrackingXRec.SetFilter(Quantity, '>%1', 0);
            if PackageTrackingXRec.FindFirst() then
                FromEntryNo := PackageTrackingXRec."Entry No.";

            Clear(ToEntryNo);
            PackageTrackingXRec.Reset();
            PackageTrackingXRec.SetRange("Package No.", ItemJournalLine."To Package");
            PackageTrackingXRec.SetRange(Utilized, false);
            PackageTrackingXRec.SetFilter(Quantity, '>%1', 0);
            if PackageTrackingXRec.FindFirst() then
                ToEntryNo := PackageTrackingXRec."Entry No.";

            if (FromEntryNo <> 0) and (ToEntryNo <> 0) then begin
                PackageTrackingXRec.Reset();
                PackageTrackingXRec.SetRange("Entry No.", FromEntryNo, ToEntryNo);
                if PackageTrackingXRec.FindFirst() then
                    repeat
                        PackageTracking.Init();

                        // Get the next Entry No.
                        PackageTrackingOld.Reset();
                        PackageTrackingOld.SetCurrentKey("Entry No.");
                        if PackageTrackingOld.FindLast() then
                            EntryNo := PackageTrackingOld."Entry No." + 1
                        else
                            EntryNo := 1;

                        // Assign fields from XRec
                        PackageTracking."Entry No." := EntryNo;
                        PackageTracking."Entry Type" := PackageTracking."Entry Type"::Consumption;
                        PackageTracking."Document No." := ItemJournalLine."Document No.";
                        PackageTracking."Source ID" := PackageTrackingXRec."Source ID";
                        PackageTracking."Source Subtype" := PackageTrackingXRec."Source Subtype";
                        PackageTracking."Source Type" := PackageTrackingXRec."Source Type";
                        PackageTracking."Source Ref. No." := PackageTrackingXRec."Source Ref. No.";
                        PackageTracking."Expiration Date" := PackageTrackingXRec."Expiration Date";
                        PackageTracking."Item No." := PackageTrackingXRec."Item No.";
                        PackageTracking."Lot No." := PackageTrackingXRec."Lot No.";
                        PackageTracking."Location Code" := PackageTrackingXRec."Location Code";
                        PackageTracking."Pack Quantity" := -PackageTrackingXRec."Pack Quantity";
                        PackageTracking."Package No." := PackageTrackingXRec."Package No.";
                        PackageTracking."Posting Date" := ItemJournalLine."Posting Date";
                        PackageTracking.Quantity := -PackageTrackingXRec."Pack Quantity";
                        PackageTrackingXRec.Utilized := true;
                        PackageTrackingXRec.Modify();

                        // Insert the new tracking entry
                        PackageTracking.Insert();

                    until PackageTrackingXRec.Next() = 0;
            end;
        end;
    end;

    local procedure InsertPackingTrackingFromTransferOrder(ItemJournalLine: Record "Item Journal Line")
    var
        PackageTracking: Record "Package Tracking";
        PackageTrackingXRec: Record "Package Tracking";
        PackageTrackingOld: Record "Package Tracking";
        EntryNo: Integer;
        FromEntryNo: Integer;
        ToEntryNo: Integer;
    begin

        if (ItemJournalLine."Entry Type" = ItemJournalLine."Entry Type"::Transfer) and
               (ItemJournalLine."Document Type" = ItemJournalLine."Document Type"::"Transfer Shipment") and
                 (ItemJournalLine."From Package" <> '') and
                 (ItemJournalLine."To Package" <> '') then begin

            Clear(FromEntryNo);
            PackageTrackingXRec.Reset();
            PackageTrackingXRec.SetRange("Package No.", ItemJournalLine."From Package");
            PackageTrackingXRec.SetRange(Utilized, false);
            PackageTrackingXRec.SetFilter(Quantity, '>%1', 0);
            if PackageTrackingXRec.FindFirst() then
                FromEntryNo := PackageTrackingXRec."Entry No.";

            Clear(ToEntryNo);
            PackageTrackingXRec.Reset();
            PackageTrackingXRec.SetRange("Package No.", ItemJournalLine."To Package");
            PackageTrackingXRec.SetRange(Utilized, false);
            PackageTrackingXRec.SetFilter(Quantity, '>%1', 0);
            if PackageTrackingXRec.FindFirst() then
                ToEntryNo := PackageTrackingXRec."Entry No.";

            if (FromEntryNo <> 0) and (ToEntryNo <> 0) then begin
                PackageTrackingXRec.Reset();
                PackageTrackingXRec.SetRange("Entry No.", FromEntryNo, ToEntryNo);
                if PackageTrackingXRec.FindFirst() then
                    repeat
                        PackageTracking.Init();

                        // Get the next Entry No.
                        PackageTrackingOld.Reset();
                        PackageTrackingOld.SetCurrentKey("Entry No.");
                        if PackageTrackingOld.FindLast() then
                            EntryNo := PackageTrackingOld."Entry No." + 1
                        else
                            EntryNo := 1;

                        // Assign fields from XRec
                        PackageTracking."Entry No." := EntryNo;
                        PackageTracking."Entry Type" := PackageTracking."Entry Type"::Transfer;
                        PackageTracking."Document No." := ItemJournalLine."Document No.";
                        PackageTracking."Source ID" := PackageTrackingXRec."Source ID";
                        PackageTracking."Source Subtype" := PackageTrackingXRec."Source Subtype";
                        PackageTracking."Source Type" := PackageTrackingXRec."Source Type";
                        PackageTracking."Source Ref. No." := PackageTrackingXRec."Source Ref. No.";
                        PackageTracking."Expiration Date" := PackageTrackingXRec."Expiration Date";
                        PackageTracking."Item No." := PackageTrackingXRec."Item No.";
                        PackageTracking."Lot No." := PackageTrackingXRec."Lot No.";
                        PackageTracking."Location Code" := PackageTrackingXRec."Location Code";
                        PackageTracking."Pack Quantity" := -PackageTrackingXRec."Pack Quantity";
                        PackageTracking."Package No." := PackageTrackingXRec."Package No.";
                        PackageTracking."Posting Date" := ItemJournalLine."Posting Date";
                        PackageTracking.Quantity := -PackageTrackingXRec."Pack Quantity";
                        PackageTrackingXRec.Utilized := true;
                        PackageTrackingXRec.Modify();

                        // Insert the new tracking entry
                        PackageTracking.Insert();

                    until PackageTrackingXRec.Next() = 0;
            end;
        end;
    end;

}