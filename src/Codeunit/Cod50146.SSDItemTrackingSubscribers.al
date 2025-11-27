codeunit 50146 "SSD Item Tracking Subscribers"
{
    var cu: Codeunit "Purch. Line-Reserve";
    //OnAfterInitFromPurchLine
    // [EventSubscriber(ObjectType::Table, Database::"Tracking Specification", 'OnAfterInitFromPurchLine', '', false, false)]
    // local procedure SSDOnAfterInitFromPurchLine(var TrackingSpecification: Record "Tracking Specification"; PurchaseLine: Record "Purchase Line")
    // var
    //     WarehouseReceiptLine: Record "Warehouse Receipt Line";
    // begin
    //     if TrackingSpecification."Source Type" <> 39 then
    //         exit;
    //     WarehouseReceiptLine.Reset();
    //     WarehouseReceiptLine.SetRange("Source Type", 39);
    //     WarehouseReceiptLine.SetRange("Source Subtype", PurchaseLine."Document Type".AsInteger());
    //     WarehouseReceiptLine.SetRange("Source No.", PurchaseLine."Document No.");
    //     WarehouseReceiptLine.SetRange("Source Line No.", PurchaseLine."Line No.");
    //     if WarehouseReceiptLine.FindFirst() then begin
    //         TrackingSpecification."MRN No." := WarehouseReceiptLine."No.";
    //         TrackingSpecification."MRN Line No." := WarehouseReceiptLine."Line No.";
    //     end;
    // end;
    // [EventSubscriber(ObjectType::Page, Page::"Item Tracking Lines", 'OnAfterSetSourceSpec', '', false, false)]
    // local procedure SSDOnAfterSetSourceSpec(var TrackingSpecification: Record "Tracking Specification"; var CurrTrackingSpecification: Record "Tracking Specification")
    // begin
    //     CurrTrackingSpecification."MRN No." := TrackingSpecification."MRN No.";
    //     CurrTrackingSpecification."MRN Line No." := TrackingSpecification."MRN Line No.";
    // end;
    // [EventSubscriber(ObjectType::Page, Page::"Item Tracking Lines", 'OnAssignLotNoOnAfterInsert', '', false, false)]
    // local procedure SSDOnAssignLotNoOnAfterInsert(var TrackingSpecification: Record "Tracking Specification"; QtyToCreate: Decimal)
    // var
    //     WarehouseReceiptLine: Record "Warehouse Receipt Line";
    // begin
    //     if TrackingSpecification."Source Type" <> 39 then
    //         exit;
    //     WarehouseReceiptLine.Reset();
    //     WarehouseReceiptLine.SetRange("Source Type", TrackingSpecification."Source Type");
    //     WarehouseReceiptLine.SetRange("Source Subtype", TrackingSpecification."Source Subtype");
    //     WarehouseReceiptLine.SetRange("Source No.", TrackingSpecification."Source ID");
    //     WarehouseReceiptLine.SetRange("Source Line No.", TrackingSpecification."Source Ref. No.");
    //     if WarehouseReceiptLine.FindFirst() then begin
    //         TrackingSpecification."MRN No." := WarehouseReceiptLine."No.";
    //         TrackingSpecification."MRN Line No." := WarehouseReceiptLine."Line No.";
    //     end;
    // end;
    //OnAssignLotNoOnAfterInsert
    // [EventSubscriber(ObjectType::Codeunit, Codeunit::"Item Tracking Data Collection", 'OnAssistEditTrackingNoOnAfterAssignTrackingToSpec', '', false, false)]
    // local procedure SSDOnBeforeGetUnplannedSalesLine(var TempTrackingSpecification: Record "Tracking Specification" temporary; TempGlobalEntrySummary: Record "Entry Summary")
    // begin
    //     TempTrackingSpecification."MRN No." := TempGlobalEntrySummary."MRN No.";
    //     TempTrackingSpecification."No. of Container" := TempGlobalEntrySummary."No. of Container";
    //     //SSDU TempTrackingSpecification."Pack Quantity" := NewQtyOnLine;
    //     TempTrackingSpecification."Manufacturing date" := TempGlobalEntrySummary."Manufacturing date";
    //     TempTrackingSpecification."Sampling Date" := TempGlobalEntrySummary."Sampling Date";
    //     TempTrackingSpecification."Sampled By" := TempGlobalEntrySummary."Sampled By";
    //     TempTrackingSpecification."MRN Line No." := TempGlobalEntrySummary."MRN Line No.";
    // end;
    // [EventSubscriber(ObjectType::Codeunit, Codeunit::"Item Tracking Data Collection", 'OnTransferItemLedgToTempRecOnBeforeInsert', '', false, false)]
    // local procedure SSDOnTransferItemLedgToTempRecOnBeforeInsert(var TempGlobalReservEntry: Record "Reservation Entry" temporary; ItemLedgerEntry: Record "Item Ledger Entry"; TrackingSpecification: Record "Tracking Specification")
    // begin
    //     TempGlobalReservEntry."Sample Quantity" := ItemLedgerEntry."Sample Quantity";
    //     TempGlobalReservEntry.Sample := ItemLedgerEntry.Sample;
    //     TempGlobalReservEntry."Rejected Qty." := ItemLedgerEntry."Rejected Qty.";
    //     TempGlobalReservEntry."MRN No." := ItemLedgerEntry."MRN No.";
    //     TempGlobalReservEntry."No. of Container" := ItemLedgerEntry."No. of Container";
    //     TempGlobalReservEntry."Pack Quantity" := ItemLedgerEntry."Pack Quantity";
    //     TempGlobalReservEntry."Manufacturing date" := ItemLedgerEntry."Manufacturing date";
    //     TempGlobalReservEntry."Sampling Date" := ItemLedgerEntry."Sampling Date";
    //     TempGlobalReservEntry."Sampled By" := ItemLedgerEntry."Sampled By";
    //     TempGlobalReservEntry."MRN Line No." := ItemLedgerEntry."MRN Line No.";
    // end;
    // [EventSubscriber(ObjectType::Codeunit, Codeunit::"Item Tracking Data Collection", 'OnBeforeUpdateBinContent', '', false, false)]
    // local procedure SSDOnBeforeUpdateBinContent(var TempEntrySummary: Record "Entry Summary" temporary; var TempReservationEntry: Record "Reservation Entry" temporary)
    // begin
    //     TempEntrySummary."MRN No." := TempReservationEntry."MRN No."; //CORP::PK
    //     TempEntrySummary."MRN Line No." := TempReservationEntry."MRN Line No."; //CORP::PK
    // end;
    // [EventSubscriber(ObjectType::Codeunit, Codeunit::"Item Tracking Data Collection", 'OnAfterCreateEntrySummary2', '', false, false)]
    // local procedure SSDOnAfterCreateEntrySummary2(var TempGlobalEntrySummary: Record "Entry Summary" temporary; var TempGlobalReservEntry: Record "Reservation Entry" temporary)
    // begin
    //     TempGlobalEntrySummary."Sample Quantity" := TempGlobalReservEntry."Sample Quantity";
    //     TempGlobalEntrySummary.Sample := TempGlobalReservEntry.Sample;
    //     TempGlobalEntrySummary."Rejected Qty." := TempGlobalReservEntry."Rejected Qty.";
    //     TempGlobalEntrySummary."MRN No." := TempGlobalReservEntry."MRN No.";
    //     TempGlobalEntrySummary."No. of Container" := TempGlobalReservEntry."No. of Container";
    //     TempGlobalEntrySummary."Pack Quantity" := TempGlobalReservEntry."Pack Quantity";
    //     TempGlobalEntrySummary."Manufacturing date" := TempGlobalReservEntry."Manufacturing date";
    //     TempGlobalEntrySummary."Sampling Date" := TempGlobalReservEntry."Sampling Date";
    //     TempGlobalEntrySummary."Sampled By" := TempGlobalReservEntry."Sampled By";
    //     TempGlobalEntrySummary."MRN Line No." := TempGlobalReservEntry."MRN Line No.";
    // end;
    // [EventSubscriber(ObjectType::Table, Database::"Tracking Specification", 'OnAfterCopyTrackingFromEntrySummary', '', false, false)]
    // local procedure SSDOnAfterCopyTrackingFromEntrySummary(var TrackingSpecification: Record "Tracking Specification"; EntrySummary: Record "Entry Summary")
    // begin
    //     TrackingSpecification."MRN No." := EntrySummary."MRN No."; //CORP::PK
    //     TrackingSpecification."MRN Line No." := EntrySummary."MRN Line No."; //CORP::PK        
    // end;
    // [EventSubscriber(ObjectType::Table, Database::"Entry Summary", 'OnAfterCopyTrackingFromSpec', '', false, false)]
    // local procedure SSDOnAfterCopyTrackingFromSpec(var ToEntrySummary: Record "Entry Summary"; TrackingSpecification: Record "Tracking Specification")
    // begin
    //     ToEntrySummary."Sample Quantity" := TrackingSpecification."Sample Quantity";
    //     ToEntrySummary.Sample := TrackingSpecification.Sample;
    //     ToEntrySummary."Rejected Qty." := TrackingSpecification."Rejected Qty.";
    //     ToEntrySummary."MRN No." := TrackingSpecification."MRN No.";
    //     ToEntrySummary."No. of Container" := TrackingSpecification."No. of Container";
    //     ToEntrySummary."Pack Quantity" := TrackingSpecification."Pack Quantity";
    //     ToEntrySummary."Manufacturing date" := TrackingSpecification."Manufacturing date";
    //     ToEntrySummary."Sampling Date" := TrackingSpecification."Sampling Date";
    //     ToEntrySummary."Sampled By" := TrackingSpecification."Sampled By";
    //     ToEntrySummary."MRN Line No." := TrackingSpecification."MRN Line No.";
    // end;
    // [EventSubscriber(ObjectType::Page, Page::"Item Tracking Lines", 'OnRegisterItemTrackingLinesOnBeforeInsert', '', false, false)]
    // local procedure SSDOnRegisterItemTrackingLinesOnBeforeInsert(var TrackingSpecification: Record "Tracking Specification"; var TempTrackingSpecification: Record "Tracking Specification" temporary; SourceTrackingSpecification: Record "Tracking Specification")
    // begin
    //     // PQA-003
    //     TrackingSpecification.Sample := TempTrackingSpecification.Sample;
    //     TrackingSpecification."Sample Quantity" := TempTrackingSpecification."Sample Quantity";
    //     TrackingSpecification."Rejected Qty." := TempTrackingSpecification."Rejected Qty.";
    //     TrackingSpecification."MRN No." := TempTrackingSpecification."MRN No.";  //CORP::PK
    //     TrackingSpecification."No. of Container" := TempTrackingSpecification."No. of Container";
    //     TrackingSpecification."Pack Quantity" := TempTrackingSpecification."Pack Quantity";
    //     TrackingSpecification."Manufacturing date" := TempTrackingSpecification."Manufacturing date";
    //     TrackingSpecification."Sampling Date" := TempTrackingSpecification."Sampling Date";
    //     TrackingSpecification."Sampled By" := TempTrackingSpecification."Sampled By";
    //     TrackingSpecification."MRN Line No." := TempTrackingSpecification."MRN Line No.";
    //     TrackingSpecification."Unused Field 1" := TempTrackingSpecification."Unused Field 1";
    //     TrackingSpecification."Unused Field 2" := TempTrackingSpecification."Unused Field 2";
    //     TrackingSpecification."Unused Field 3" := TempTrackingSpecification."Unused Field 3";
    //     TrackingSpecification."Unused Field 4" := TempTrackingSpecification."Unused Field 4";
    //     TrackingSpecification."Unused Field 5" := TempTrackingSpecification."Unused Field 5";
    //     // PQA-003
    // end;
    // [EventSubscriber(ObjectType::Page, Page::"Item Tracking Lines", 'OnBeforeUpdateTrackingData', '', false, false)]
    // local procedure SSDOnBeforeUpdateTrackingData(var TrackingSpecification: Record "Tracking Specification"; xTrackingSpecification: Record "Tracking Specification"; var xTempTrackingSpec: Record "Tracking Specification" temporary; CurrentSignFactor: Integer; var SourceQuantityArray: array[5] of Decimal; var IsHandled: Boolean)
    // var
    //     PostedQualityOrder1: Record "SSD Posted Quality Order Hdr";
    //     QualityOrderHeader1: Record "SSD Quality Order Header";
    //     TempTrackingSpec: Record "Tracking Specification" temporary;
    //     TempItemTrackLineModify: Record "Tracking Specification" temporary;
    //     TempItemTrackLineInsert: Record "Tracking Specification" temporary;
    //     ItemTrackingDataCollection: Codeunit "Item Tracking Data Collection";
    // begin
    //     if not TestTempSpecificationExists(TrackingSpecification) then begin
    //         TrackingSpecification.Modify();
    //         if not TrackingSpecification.HasSameTracking(xTrackingSpecification) then begin
    //             TempTrackingSpec := xTrackingSpecification;
    //             ItemTrackingDataCollection.UpdateTrackingDataSetWithChange(
    //               TempTrackingSpec, CurrentSignFactor * SourceQuantityArray[1] < 0, CurrentSignFactor, 2);
    //         end;
    //         //ALLE[5.51]
    //         PostedQualityOrder1.RESET;
    //         PostedQualityOrder1.SETRANGE(PostedQualityOrder1."Lot No.", TrackingSpecification."Lot No.");
    //         IF PostedQualityOrder1.FINDFIRST THEN
    //             IF TrackingSpecification."MRN No." <> '' THEN
    //                 //ERROR('Quality Order Posted for this Lot');
    //                 QualityOrderHeader1.RESET;
    //         QualityOrderHeader1.SETRANGE(QualityOrderHeader1."Lot No.", TrackingSpecification."Lot No.");
    //         IF QualityOrderHeader1.FINDFIRST THEN
    //             IF TrackingSpecification."MRN No." <> '' THEN
    //                 ERROR('Quality Order Created for this Lot');
    //         //ALLE[5.51]
    //         if TempItemTrackLineModify.Get(TrackingSpecification."Entry No.") then
    //             TempItemTrackLineModify.Delete();
    //         if TempItemTrackLineInsert.Get(TrackingSpecification."Entry No.") then begin
    //             TempItemTrackLineInsert.TransferFields(TrackingSpecification);
    //             TempItemTrackLineInsert.Modify();
    //             ItemTrackingDataCollection.UpdateTrackingDataSetWithChange(
    //               TempItemTrackLineInsert, CurrentSignFactor * SourceQuantityArray[1] < 0, CurrentSignFactor, 1);
    //         end else begin
    //             TempItemTrackLineModify.TransferFields(TrackingSpecification);
    //             // PQA-003.begin
    //             TempItemTrackLineModify.Sample := TrackingSpecification.Sample;
    //             TempItemTrackLineModify."Sample Quantity" := TrackingSpecification."Sample Quantity";
    //             TempItemTrackLineModify."Rejected Qty." := TrackingSpecification."Rejected Qty.";
    //             TempItemTrackLineModify."MRN No." := TrackingSpecification."MRN No.";
    //             TempItemTrackLineModify."No. of Container" := TrackingSpecification."No. of Container";
    //             TempItemTrackLineModify."Pack Quantity" := TrackingSpecification."Pack Quantity";
    //             TempItemTrackLineModify."Manufacturing date" := TrackingSpecification."Manufacturing date";
    //             TempItemTrackLineModify."Sampling Date" := TrackingSpecification."Sampling Date";
    //             TempItemTrackLineModify."Sampled By" := TrackingSpecification."Sampled By";
    //             IF GMRNNo <> '' THEN //ALLE[5.51]
    //                 TempItemTrackLineModify."MRN Line No." := TrackingSpecification."MRN Line No.";
    //             TempItemTrackLineModify."Unused Field 1" := TrackingSpecification."Unused Field 1";
    //             TempItemTrackLineModify."Unused Field 2" := TrackingSpecification."Unused Field 2";
    //             TempItemTrackLineModify."Unused Field 3" := TrackingSpecification."Unused Field 3";
    //             TempItemTrackLineModify."Unused Field 4" := TrackingSpecification."Unused Field 4";
    //             TempItemTrackLineModify."Unused Field 5" := TrackingSpecification."Unused Field 5";
    //             // PQA-003.end
    //             TempItemTrackLineModify.Insert();
    //             ItemTrackingDataCollection.UpdateTrackingDataSetWithChange(
    //               TempItemTrackLineModify, CurrentSignFactor * SourceQuantityArray[1] < 0, CurrentSignFactor, 1);
    //         end;
    //     end;
    //     IsHandled := true;
    // end;
    [EventSubscriber(ObjectType::Page, Page::"Item Tracking Lines", 'OnDeleteRecordOnAfterWMSCheckTrackingChange', '', false, false)]
    local procedure SSDOnDeleteRecordOnAfterWMSCheckTrackingChange(TrackingSpecification: Record "Tracking Specification"; xTrackingSpecification: Record "Tracking Specification")
    var
        PostedQualityOrder1: Record "SSD Posted Quality Order Hdr";
        QualityOrderHeader1: Record "SSD Quality Order Header";
    begin
        //ALLE[5.51]
        PostedQualityOrder1.RESET;
        PostedQualityOrder1.SETRANGE(PostedQualityOrder1."Lot No.", TrackingSpecification."Lot No.");
        IF PostedQualityOrder1.FINDFIRST THEN ERROR('Quality Order Posted for this Lot');
        QualityOrderHeader1.RESET;
        QualityOrderHeader1.SETRANGE(QualityOrderHeader1."Lot No.", TrackingSpecification."Lot No.");
        IF QualityOrderHeader1.FINDFIRST THEN ERROR('Quality Order Created for this Lot');
    //ALLE[5.51] // BIS 1145 01042015
    end;
    // [EventSubscriber(ObjectType::Page, Page::"Item Tracking Lines", 'OnBeforeSetSourceSpecForTransferReceipt', '', false, false)]
    // local procedure SSDOnBeforeSetSourceSpecForTransferReceipt(var TrackingSpecificationRec: Record "Tracking Specification"; var ReservEntry: Record "Reservation Entry")
    // begin
    //     ReservEntry.SETRANGE("Item No.", TrackingSpecificationRec."Item No.");//ALLE[US]
    //     ReservEntry.SETRANGE("Location Code", TrackingSpecificationRec."Location Code"); //ALLE[US]
    //     // PQA-003.begin
    //     IF TrackingSpecificationRec."MRN No." <> '' THEN BEGIN
    //         ReservEntry.SETRANGE("MRN No.", TrackingSpecificationRec."MRN No.");
    //         ReservEntry.SETRANGE("MRN Line No.", TrackingSpecificationRec."MRN Line No.");
    //     END;
    //     // PQA-003.end
    // end;
    // [EventSubscriber(ObjectType::Table, Database::"Tracking Specification", 'OnAfterSetTrackingFilterFromTrackingSpec', '', false, false)]
    // local procedure SSDOnAfterSetTrackingFilterFromTrackingSpec(var TrackingSpecification: Record "Tracking Specification"; FromTrackingSpecification: Record "Tracking Specification")
    // begin
    //     IF FromTrackingSpecification."MRN No." <> '' THEN BEGIN
    //         TrackingSpecification.SETRANGE("MRN No.", FromTrackingSpecification."MRN No.");
    //         TrackingSpecification.SETRANGE("MRN Line No.", FromTrackingSpecification."MRN Line No.");
    //     END;
    // end;
    //OnDeleteRecordOnAfterWMSCheckTrackingChange
    // procedure TestTempSpecificationExists(var TrackingSpecification: Record "Tracking Specification") Exists: Boolean
    // begin
    //     TestTempSpecificationExists(TrackingSpecification, -1);
    // end;
    // local procedure TestTempSpecificationExists(var TrackingSpecification2: Record "Tracking Specification"; CheckTillEntryNo: Integer) Exists: Boolean
    // var
    //     TrackingSpecification: Record "Tracking Specification";
    //     Text011: Label 'Tracking specification with Serial No. %1 and Lot No. %2 and Package %3 already exists.', Comment = '%1 - serial no, %2 - lot no, %3 - package no.';
    //     Text012: Label 'Tracking specification with Serial No. %1 already exists.';
    // begin
    //     if not TrackingSpecification2.TrackingExists() then
    //         exit(false);
    //     TrackingSpecification.Copy(TrackingSpecification2);
    //     TrackingSpecification2.SetTrackingKey();
    //     TrackingSpecification2.SetRange("Serial No.", TrackingSpecification2."Serial No.");
    //     if TrackingSpecification2."Serial No." = '' then
    //         TrackingSpecification2.SetNonSerialTrackingFilterFromSpec(TrackingSpecification2);
    //     if CheckTillEntryNo = -1 then
    //         TrackingSpecification2.SetFilter("Entry No.", '<>%1', TrackingSpecification2."Entry No.")
    //     else
    //         TrackingSpecification2.SetFilter("Entry No.", '<=%1', CheckTillEntryNo); // Validate only against the existing entries.
    //     TrackingSpecification2.SetRange("Buffer Status", 0);
    //     //OnTestTempSpecificationExistsOnAfterSetFilters(Rec);
    //     Exists := not TrackingSpecification2.IsEmpty();
    //     TrackingSpecification2.Copy(TrackingSpecification);
    //     if Exists and CurrentPageIsOpen then
    //         if TrackingSpecification2."Serial No." = '' then
    //             Message(Text011, TrackingSpecification2."Serial No.", TrackingSpecification2."Lot No.", TrackingSpecification2."Package No.")
    //         else
    //             Message(Text012, TrackingSpecification2."Serial No.");
    // end;
    var GMRNQty: Decimal;
    GRejectedQty: Decimal;
    GSample: Boolean;
    GSampleQty: Decimal;
    GMRNNo: Code[20];
    GNoOfContainer: Integer;
    GPackQty: Decimal;
    GManufacturingdate: Date;
    RecptNo: Code[20];
    GSamplingDate: Date;
    GSampledBy: Code[20];
    GMRNLineNo: Integer;
    CurrentPageIsOpen: Boolean;
}
