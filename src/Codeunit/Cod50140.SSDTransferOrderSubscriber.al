codeunit 50140 "SSD Transfer Order Subscriber"
{
    [EventSubscriber(ObjectType::Table, Database::"Transfer Header", 'OnAfterInitRecord', '', false, false)]
    local procedure SSDOnAfterInitRecord(var TransferHeader: Record "Transfer Header")
    var
        UserMgt: Codeunit "SSD User Setup Management";
    begin
        TransferHeader."Responsibility Center":=UserMgt.GetRespCenterFilter();
    end;
    [EventSubscriber(ObjectType::Table, Database::"Transfer Line", 'OnAfterGetTransHeader', '', false, false)]
    local procedure SSDOnAfterGetTransHeader(var TransferLine: Record "Transfer Line"; TransferHeader: Record "Transfer Header")
    begin
        TransferLine."Responsibility Center":=TransferHeader."Responsibility Center";
    end;
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"TransferOrder-Post Shipment", 'OnBeforeTransferOrderPostShipment', '', false, false)]
    local procedure SSDOnBeforeTransferOrderPostShipment(TransferHeader: Record "Transfer Header")
    var
        TransferLine: Record "Transfer Line";
        Location: Record Location;
        Item: Record Item;
        SSDItemPhyBinDetails: Record "SSD Item Phy. Bin Details";
    begin
        TransferLine.RESET();
        TransferLine.SETRANGE("Document No.", TransferHeader."No.");
        if TransferLine.FINDSET()then repeat if Location.GET(TransferLine."Transfer-from Code")then;
                if Item.GET(TransferLine."Item No.")then;
                if(Location."Phy. Bin Required") and (Item."Phy. Bin Required")then begin
                    SSDItemPhyBinDetails.RESET();
                    SSDItemPhyBinDetails.SETRANGE("Document No.", TransferLine."Document No.");
                    //ItemPhyBinDetails.SETRANGE("Document Line No.",TransferLine."Line No.");
                    SSDItemPhyBinDetails.SETRANGE("Item No.", TransferLine."Item No.");
                    SSDItemPhyBinDetails.SETRANGE("Posted Document No.", '');
                    if not SSDItemPhyBinDetails.FINDFIRST()then ERROR('Please fill the Item Phy. Details in Line No. %1', TransferLine."Line No.")
                    else
                    begin
                        SSDItemPhyBinDetails."Posting Date":=TransferHeader."Posting Date";
                        SSDItemPhyBinDetails.MODIFY();
                    end;
                end;
            until TransferLine.NEXT() = 0;
    end;
    [EventSubscriber(ObjectType::Table, Database::"Transfer Shipment Header", 'OnAfterCopyFromTransferHeader', '', false, false)]
    local procedure SSDOnAfterCopyFromTransferHeader(var TransferShipmentHeader: Record "Transfer Shipment Header"; TransferHeader: Record "Transfer Header")
    begin
        TransferShipmentHeader."Responsibility Center":=TransferHeader."Responsibility Center";
        TransferShipmentHeader."Slip No.":=TransferHeader."Slip No.";
        TransferShipmentHeader."Prod. Order Source No.":=TransferHeader."Prod. Order Source No.";
        TransferShipmentHeader."Prod. Order Source Description":=TransferHeader."Prod. Order Source Description";
        TransferShipmentHeader."Prod. Order No.":=TransferHeader."Prod. Order No.";
        TransferShipmentHeader."Applied to Insurance Policy":=TransferHeader."Applied to Insurance Policy";
    end;
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"TransferOrder-Post Shipment", 'OnBeforeInsertTransShptLine', '', false, false)]
    local procedure SSDOnBeforeInsertTransShptLine(var TransShptLine: Record "Transfer Shipment Line"; TransLine: Record "Transfer Line"; TransShptHeader: Record "Transfer Shipment Header")
    begin
        TransShptLine."Responsibility Center":=TransShptHeader."Responsibility Center";
        TransShptLine."Slip No.":=TransShptHeader."Slip No.";
        TransShptLine."Prod. Order No.":=TransShptHeader."Prod. Order No.";
        TransShptLine."Amount DUP. CSP":=TransLine."Amount DUP. CSP";
        TransShptLine."Trf Price DUP. CSP":=TransLine."Trf Price DUP. CSP";
    end;
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"TransferOrder-Post Shipment", 'OnAfterCreateItemJnlLine', '', false, false)]
    local procedure SSDOnAfterCreateItemJnlLine(var ItemJournalLine: Record "Item Journal Line"; TransferShipmentLine: Record "Transfer Shipment Line")
    begin
        ItemJournalLine."Responsibility Center":=TransferShipmentLine."Responsibility Center";
    end;
    //Transfer Receipt
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"TransferOrder-Post Receipt", 'OnBeforeReleaseDocument', '', false, false)]
    local procedure SSDOnBeforeReleaseDocument(TransferHeader: Record "Transfer Header")
    var
        TransferLine: Record "Transfer Line";
        Location: Record Location;
        Item: Record Item;
        SSDItemPhyBinDetails: Record "SSD Item Phy. Bin Details";
    begin
        TransferLine.RESET();
        TransferLine.SETRANGE("Document No.", TransferHeader."No.");
        if TransferLine.FINDSET()then repeat if Location.GET(TransferLine."Transfer-from Code")then;
                if Item.GET(TransferLine."Item No.")then;
                if(Location."Phy. Bin Required") and (Item."Phy. Bin Required")then begin
                    SSDItemPhyBinDetails.RESET();
                    SSDItemPhyBinDetails.SETRANGE("Document No.", TransferLine."Document No.");
                    //ItemPhyBinDetails.SETRANGE("Document Line No.",TransferLine."Line No.");
                    SSDItemPhyBinDetails.SETRANGE("Item No.", TransferLine."Item No.");
                    SSDItemPhyBinDetails.SETRANGE("Posted Document No.", '');
                    if not SSDItemPhyBinDetails.FINDFIRST()then ERROR('Please fill the Item Phy. Details in Line No. %1', TransferLine."Line No.")
                    else
                    begin
                        SSDItemPhyBinDetails."Posting Date":=TransferHeader."Posting Date";
                        SSDItemPhyBinDetails.MODIFY();
                    end;
                end;
            until TransferLine.NEXT() = 0;
    end;
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"TransferOrder-Post Receipt", 'OnBeforeTransferOrderPostReceipt', '', false, false)]
    local procedure SSDOnBeforeTransferOrderPostReceipt(TransferHeader: Record "Transfer Header")
    var
        SSDItemPhyBinDetails: Record "SSD Item Phy. Bin Details";
        SSDItemPhyBinDetails1: Record "SSD Item Phy. Bin Details";
    begin
        SSDItemPhyBinDetails.RESET();
        SSDItemPhyBinDetails.SETRANGE("Document No.", TransferHeader."No.");
        SSDItemPhyBinDetails.SETRANGE("Document Type", SSDItemPhyBinDetails."Document Type"::"Transfer Order Ship");
        if SSDItemPhyBinDetails.FINDFIRST()then begin
            SSDItemPhyBinDetails1.RESET();
            SSDItemPhyBinDetails1.SETRANGE("Document No.", TransferHeader."No.");
            SSDItemPhyBinDetails1.SETRANGE("Document Type", SSDItemPhyBinDetails1."Document Type"::"Transfer Order Receipt");
            if SSDItemPhyBinDetails1.FINDFIRST()then begin
                SSDItemPhyBinDetails1."Whse. Entry  No.":=SSDItemPhyBinDetails."Whse. Entry  No.";
                SSDItemPhyBinDetails1."Posted Document No.":=SSDItemPhyBinDetails."Posted Document No.";
                SSDItemPhyBinDetails1.MODIFY();
            end;
        end;
    end;
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"TransferOrder-Post Receipt", 'OnAfterInsertTransRcptHeader', '', false, false)]
    local procedure SSDOnAfterInsertTransRcptHeader(var TransRcptHeader: Record "Transfer Receipt Header"; var TransHeader: Record "Transfer Header")
    begin
        TransRcptHeader."Responsibility Center":=TransHeader."Responsibility Center";
        TransRcptHeader."Applied to Insurance Policy":=TransHeader."Applied to Insurance Policy";
        TransRcptHeader."Slip No.":=TransHeader."Slip No.";
        TransRcptHeader."Document Type":=TransHeader."Document Type";
        TransRcptHeader."Responsibility Center":=TransHeader."Responsibility Center";
        TransRcptHeader.Departments:=TransHeader.Departments;
        TransRcptHeader."Prod. Order Source No.":=TransHeader."Prod. Order Source No.";
        TransRcptHeader."Prod. Order Source Description":=TransHeader."Prod. Order Source Description";
        TransRcptHeader."Prod. Order No.":=TransHeader."Prod. Order No.";
    end;
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"TransferOrder-Post Receipt", 'OnBeforeInsertTransRcptLine', '', false, false)]
    local procedure SSDOnBeforeInsertTransRcptLine(var TransRcptLine: Record "Transfer Receipt Line"; TransLine: Record "Transfer Line"; CommitIsSuppressed: Boolean; var IsHandled: Boolean; TransferReceiptHeader: Record "Transfer Receipt Header")
    begin
        TransRcptLine."Responsibility Center":=TransferReceiptHeader."Responsibility Center";
        TransRcptLine."Slip No.":=TransferReceiptHeader."Slip No.";
        TransRcptLine."Prod. Order No.":=TransferReceiptHeader."Prod. Order No.";
        TransRcptLine."Amount DUP. CSP":=TransLine."Amount DUP. CSP";
        TransRcptLine."Trf Price DUP. CSP":=TransLine."Trf Price DUP. CSP";
    end;
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"TransferOrder-Post Receipt", 'OnBeforePostItemJournalLine', '', false, false)]
    local procedure SSDOnBeforePostItemJournalLine(var ItemJournalLine: Record "Item Journal Line"; TransferReceiptLine: Record "Transfer Receipt Line")
    begin
        ItemJournalLine."Responsibility Center":=TransferReceiptLine."Responsibility Center";
    end;
}
