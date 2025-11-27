PageExtension 50071 "SSD Posted WhseReceipt List" extends "Posted Whse. Receipt List"
{
    layout
    {
        addafter("Assignment Date")
        {
            // field("Bill No."; Rec."Vendor Shipment No.")
            // {
            //     ApplicationArea = All;
            // }
            field("Bill Amount"; Rec."Bill Amount")
            {
                ApplicationArea = All;
            }
            field("Gate Entry no."; Rec."Gate Entry no.")
            {
                ApplicationArea = All;
            }
            field("Vendor No."; Rec."Vendor No.")
            {
                ApplicationArea = All;
                Visible = false;
            }
            field("Vendor No.1"; Rec."Vendor No.1")
            {
                ApplicationArea = all;
                Caption = 'Vendor No.';
            }
            field("Vendor Name"; Rec."Vendor Name")
            {
                ApplicationArea = all;
            }
        }
    }
    actions
    {
        addafter(Card)
        {
            action("Create QR Code")
            {
                ApplicationArea = All;
                Caption = 'Create QR Code';
                Image = CreateDocument;

                trigger OnAction()
                begin
                    //CORP::P.K.>>>
                    QRCodeDetail.Reset;
                    if not QRCodeDetail.Find('+') then
                        BarCodeNoInt := 0
                    else
                        BarCodeNoInt := QRCodeDetail."Barcode No Integer";
                    I := 1;
                    ReceiptNo := '';
                    WarehouseEntry.Reset;
                    WarehouseEntry.SetRange("Whse. Document No.", Rec."No.");
                    if WarehouseEntry.FindFirst then ReceiptNo := WarehouseEntry."Reference No.";
                    ItemLedgerEntry.Reset;
                    ItemLedgerEntry.SetRange("Document No.", ReceiptNo);
                    ItemLedgerEntry.SetRange("Document Type", ItemLedgerEntry."document type"::"Purchase Receipt");
                    if ItemLedgerEntry.FindSet then
                        repeat
                            BarCodeNoInt += 1;
                            QRCodeDetail.Reset;
                            QRCodeDetail.SetRange("QR Code No.", ItemLedgerEntry."Document No." + '/' + Format(I));
                            if not QRCodeDetail.FindFirst then begin
                                BinCode := '';
                                WarehouseEntry.Reset;
                                WarehouseEntry.SetRange("Reference No.", ItemLedgerEntry."Document No.");
                                WarehouseEntry.SetRange("Item No.", ItemLedgerEntry."Item No.");
                                if WarehouseEntry.FindFirst then BinCode := WarehouseEntry."Bin Code";
                                QRCodeDetail.Init;
                                QRCodeDetail."QR Code No." := Rec."No." + '/' + Format(I); // '-' + COPYSTR("No.",8,11) +
                                QRCodeDetail."Lot No." := ItemLedgerEntry."Lot No.";
                                QRCodeDetail."MRN No." := Rec."No."; //ItemLedgerEntry."Document No.";
                                QRCodeDetail."MRN Date" := Rec."Posting Date";
                                QRCodeDetail."Item Code" := ItemLedgerEntry."Item No.";
                                QRCodeDetail."Location Code" := ItemLedgerEntry."Location Code";
                                QRCodeDetail.UOM := ItemLedgerEntry."Unit of Measure Code";
                                QRCodeDetail."Expiration Date" := ItemLedgerEntry."Expiration Date";
                                QRCodeDetail."Barcode No Integer" := BarCodeNoInt;
                                QRCodeDetail."Creation Date" := Today;
                                QRCodeDetail."BIN Code" := BinCode;
                                QRCodeDetail.Quantity := ItemLedgerEntry.Quantity;
                                QRCodeDetail.Insert;
                                I += 1;
                            end;
                        until ItemLedgerEntry.Next = 0;
                    Message(Text001);
                    Commit;
                    //CORP::P.K.<<<
                end;
            }
            action("Print QR Code")
            {
                ApplicationArea = All;
                Caption = 'Print QR Code';
                Image = BarCode;

                trigger OnAction()
                begin
                    QRCodeMgt.BarcodeForWhseRecpt(Rec); //CORP::P.K.>>>
                end;
            }
        }
    }
    var
        QRCodeDetail: Record "SSD QR Code Detail";
        BarCodeNoInt: Integer;
        I: Integer;
        ItemLedgerEntry: Record "Item Ledger Entry";
        QRCodeMgt: Codeunit "QR Code Mgt.";
        WarehouseEntry: Record "Warehouse Entry";
        BinCode: Code[20];
        Text001: label 'QR Code Successfully Created.';
        ReceiptNo: Code[20];

    trigger OnOpenPage()
    var
        PostedWhseRcptLine: Record "Posted Whse. Receipt Line";
        PostedWhseRcptHdr: Record "Posted Whse. Receipt Header";
        PurchaseHeader: Record "Purchase Header";
    begin
        PostedWhseRcptHdr.Reset();
        PostedWhseRcptHdr.SetRange("Vendor No.1", '');
        if PostedWhseRcptHdr.FindSet() then
            repeat
                PostedWhseRcptLine.Reset();
                PostedWhseRcptLine.SetRange("No.", PostedWhseRcptHdr."No.");
                PostedWhseRcptLine.SetRange("Source Document", PostedWhseRcptLine."Source Document"::"Purchase Order");
                if PostedWhseRcptLine.FindFirst() then begin
                    PurchaseHeader.Reset();
                    PurchaseHeader.SetRange("No.", PostedWhseRcptLine."Source No.");
                    if PurchaseHeader.FindFirst() then begin
                        if PostedWhseRcptHdr."Vendor No.1" = '' then
                            PostedWhseRcptHdr."Vendor No.1" := PurchaseHeader."Buy-from Vendor No.";
                        if PostedWhseRcptHdr."Vendor Name" = '' then
                            PostedWhseRcptHdr."Vendor Name" := PurchaseHeader."Buy-from Vendor Name";
                        PostedWhseRcptHdr.Modify();
                    end;
                end;
            until PostedWhseRcptHdr.Next() = 0;
    end;
}
