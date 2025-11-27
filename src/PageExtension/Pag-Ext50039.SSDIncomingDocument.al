PageExtension 50039 "SSD Incoming Document" extends "Incoming Document"
{
    trigger OnDeleteRecord(): Boolean var
        RelatedRecord: Variant;
        RecRef: RecordRef;
        PurchaseHeader: Record "Purchase Header";
        SalesHeader: Record "Sales Header";
    begin
        IF Rec.GetRecord(RelatedRecord)THEN BEGIN
            RecRef.GETTABLE(RelatedRecord);
            IF RecRef.NUMBER = 38 THEN BEGIN
                PurchaseHeader:=RelatedRecord;
                IF PurchaseHeader.Status <> PurchaseHeader.Status::Open THEN ERROR('Status should not be in %1 for Purchase Order No. %2', PurchaseHeader.Status, PurchaseHeader."No.");
            END;
        END;
        IF Rec.GetRecord(RelatedRecord)THEN BEGIN
            RecRef.GETTABLE(RelatedRecord);
            IF RecRef.NUMBER = 36 THEN BEGIN
                SalesHeader:=RelatedRecord;
                IF SalesHeader.Status <> SalesHeader.Status::Open THEN ERROR('Status should not be in %1 for Sales Credit Memo No. %2', SalesHeader.Status, SalesHeader."No.");
            END;
        END;
    end;
}
