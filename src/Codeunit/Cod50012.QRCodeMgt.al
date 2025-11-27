Codeunit 50012 "QR Code Mgt."
{
    trigger OnRun()
    begin
    end;
    var QRGenerator: Codeunit "QR Generator";
    TempBlob: Codeunit "Temp Blob";
    SSDRecRef: RecordRef;
    SSDFieldRef: FieldRef;
    QRCodeStr2: Record "SSD QR Code Str" temporary;
    procedure BarcodeForPurchaseRcpt(WarehouseReceiptHeader: Record "Warehouse Receipt Header")
    var
        ItemLedgerEntry: Record "Item Ledger Entry";
        Text5000_Ctx: label '<xpml><page quantity=''0'' pitch=''74.1 mm''></xpml>SIZE 100 mm, 74.1 mm';
        Text5001_Ctx: label 'DIRECTION 0,0';
        Text5002_Ctx: label 'REFERENCE 0,0';
        Text5003_Ctx: label 'OFFSET 0 mm';
        Text5004_Ctx: label 'SET PEEL OFF';
        Text5005_Ctx: label 'SET CUTTER OFF';
        Text5006_Ctx: label 'SET PARTIAL_CUTTER OFF';
        Text5007_Ctx: label '<xpml></page></xpml><xpml><page quantity=''1'' pitch=''74.1 mm''></xpml>SET TEAR ON';
        Text5008_Ctx: label 'CLS';
        Text5009_Ctx: label 'CODEPAGE 1252';
        Text5010_Ctx: label 'TEXT 806,792,"0",180,17,14,"SCHILLER_"';
        Text5011_Ctx: label 'TEXT 1093,443,"0",180,14,12,"Item"';
        Text5012_Ctx: label 'TEXT 1093,303,"0",180,10,12,"Part No."';
        Text5013_Ctx: label 'TEXT 1093,166,"0",180,12,12,"Sr. No."';
        Text5014_Ctx: label 'TEXT 933,443,"0",180,14,12,":"';
        Text5015_Ctx: label 'TEXT 933,303,"0",180,14,12,":"';
        Text5016_Ctx: label 'TEXT 933,166,"0",180,14,12,":"';
        Text5017_Ctx: label 'TEXT 896,303,"0",180,10,12,"%1"';
        Text5018_Ctx: label 'TEXT 896,166,"0",180,10,12,"%1"';
        Text5019_Ctx: label 'QRCODE 330,300,L,10,A,180,M2,S7,"%1"';
        Text5020_Ctx: label 'TEXT 896,443,"0",180,10,12,"%1"';
        Text5021_Ctx: label 'PRINT 1,1';
        Text5022_Ctx: label '<xpml></page></xpml><xpml><end/></xpml>';
        QRCodeStr: Record "SSD QR Code Str" temporary;
        QRCodeInput: Text;
        QRCodePrint: Report "QR Code Print";
        CRLF: Text[30];
        QRCodeDetail: Record "SSD QR Code Detail";
    begin
        QRCodeStr.Reset;
        QRCodeStr.DeleteAll;
        QRCodeDetail.Reset;
        QRCodeDetail.SetRange("MRN No.", WarehouseReceiptHeader."No.");
        if QRCodeDetail.FindSet then begin
            repeat Clear(QRCodeStr);
                QRCodeStr.Init;
                QRCodeStr."QR No Integer":=QRCodeDetail."Barcode No Integer";
                QRCodeInput:='QR Code:' + Format(QRCodeDetail."QR Code No.") + '; Lot No.:' + Format(QRCodeDetail."Lot No.") + '; Item No.:' + Format(QRCodeDetail."Item Code") + '; Location:' + Format(QRCodeDetail."Location Code") + '; Quantity:' + Format(QRCodeDetail.Quantity) + '; UOM:' + Format(QRCodeDetail.UOM) + '; BIN Code:' + Format(QRCodeDetail."BIN Code") + '; Description: ' + QRCodeDetail."Item Description";
                Clear(TempBlob);
                Clear(QRGenerator);
                Clear(SSDRecRef);
                Clear(SSDFieldRef);
                QRCodeStr2.DeleteAll();
                QRGenerator.GenerateQRCodeImage(QRCodeInput, TempBlob);
                SSDRecRef.GetTable(QRCodeStr2);
                SSDFieldRef:=SSDRecRef.Field(QRCodeStr2.FieldNo(QRCode));
                TempBlob.ToRecordRef(SSDRecRef, QRCodeStr2.FieldNo(QRCode));
                QRCodeStr.QRCode:=QRCodeStr2.QRCode;
                //SSD CreateQRCode(QRCodeInput, TempBlob);
                QRCodeStr."QR Code No.":=QRCodeDetail."QR Code No.";
                QRCodeStr."Document No.":=QRCodeDetail."MRN No.";
                QRCodeStr."Item No.":=QRCodeDetail."Item Code";
                QRCodeStr."Qty.":=QRCodeDetail.Quantity;
                QRCodeStr."Lot No.":=QRCodeDetail."Lot No.";
                QRCodeStr."Expiration Date":=QRCodeDetail."Expiration Date";
                //SSD QRCodeStr.QRCode := TempBlob.Blob;
                QRCodeStr.Insert;
            until QRCodeDetail.Next = 0;
            Clear(QRCodePrint);
            QRCodePrint.TransfterDate(QRCodeStr);
            QRCodePrint.RunModal;
        end
        else
            Message('QR Code not generated for this document');
    end;
    procedure BarcodeForWhseRecpt(PostedWhseReceiptHeader: Record "Posted Whse. Receipt Header")
    var
        ItemLedgerEntry: Record "Item Ledger Entry";
        Text5000_Ctx: label '<xpml><page quantity=''0'' pitch=''74.1 mm''></xpml>SIZE 100 mm, 74.1 mm';
        Text5001_Ctx: label 'DIRECTION 0,0';
        Text5002_Ctx: label 'REFERENCE 0,0';
        Text5003_Ctx: label 'OFFSET 0 mm';
        Text5004_Ctx: label 'SET PEEL OFF';
        Text5005_Ctx: label 'SET CUTTER OFF';
        Text5006_Ctx: label 'SET PARTIAL_CUTTER OFF';
        Text5007_Ctx: label '<xpml></page></xpml><xpml><page quantity=''1'' pitch=''74.1 mm''></xpml>SET TEAR ON';
        Text5008_Ctx: label 'CLS';
        Text5009_Ctx: label 'CODEPAGE 1252';
        Text5010_Ctx: label 'TEXT 806,792,"0",180,17,14,"SCHILLER_"';
        Text5011_Ctx: label 'TEXT 1093,443,"0",180,14,12,"Item"';
        Text5012_Ctx: label 'TEXT 1093,303,"0",180,10,12,"Part No."';
        Text5013_Ctx: label 'TEXT 1093,166,"0",180,12,12,"Sr. No."';
        Text5014_Ctx: label 'TEXT 933,443,"0",180,14,12,":"';
        Text5015_Ctx: label 'TEXT 933,303,"0",180,14,12,":"';
        Text5016_Ctx: label 'TEXT 933,166,"0",180,14,12,":"';
        Text5017_Ctx: label 'TEXT 896,303,"0",180,10,12,"%1"';
        Text5018_Ctx: label 'TEXT 896,166,"0",180,10,12,"%1"';
        Text5019_Ctx: label 'QRCODE 330,300,L,10,A,180,M2,S7,"%1"';
        Text5020_Ctx: label 'TEXT 896,443,"0",180,10,12,"%1"';
        Text5021_Ctx: label 'PRINT 1,1';
        Text5022_Ctx: label '<xpml></page></xpml><xpml><end/></xpml>';
        QRCodeStr: Record "SSD QR Code Str" temporary;
        QRCodeInput: Text;
        //SSD TempBlob: Record TempBlob;
        QRCodePrintWhseRecpt: Report "QR Code Print Whse. Recpt.";
        CRLF: Text[30];
        QRCodeDetail: Record "SSD QR Code Detail";
    begin
        QRCodeStr.Reset;
        QRCodeStr.DeleteAll;
        QRCodeDetail.Reset;
        QRCodeDetail.SetRange("MRN No.", PostedWhseReceiptHeader."No.");
        if QRCodeDetail.FindSet then begin
            repeat Clear(QRCodeStr);
                QRCodeStr.Init;
                QRCodeStr."QR No Integer":=QRCodeDetail."Barcode No Integer";
                QRCodeInput:='QR Code:' + Format(QRCodeDetail."QR Code No.") + '; Lot No.:' + Format(QRCodeDetail."Lot No.") + '; Item No.:' + Format(QRCodeDetail."Item Code") + '; Location:' + Format(QRCodeDetail."Location Code") + '; Quantity:' + Format(QRCodeDetail.Quantity) + '; UOM:' + Format(QRCodeDetail.UOM) + '; BIN Code:' + Format(QRCodeDetail."BIN Code");
                Clear(TempBlob);
                Clear(QRGenerator);
                Clear(SSDRecRef);
                Clear(SSDFieldRef);
                QRCodeStr2.DeleteAll();
                QRGenerator.GenerateQRCodeImage(QRCodeInput, TempBlob);
                SSDRecRef.GetTable(QRCodeStr2);
                SSDFieldRef:=SSDRecRef.Field(QRCodeStr2.FieldNo(QRCode));
                TempBlob.ToRecordRef(SSDRecRef, QRCodeStr2.FieldNo(QRCode));
                QRCodeStr.QRCode:=QRCodeStr2.QRCode;
                //SSD CreateQRCode(QRCodeInput, TempBlob);
                QRCodeStr."QR Code No.":=QRCodeDetail."QR Code No.";
                QRCodeStr."Document No.":=QRCodeDetail."MRN No.";
                QRCodeStr."Item No.":=QRCodeDetail."Item Code";
                QRCodeStr."Qty.":=QRCodeDetail.Quantity;
                QRCodeStr."Lot No.":=QRCodeDetail."Lot No.";
                QRCodeStr."Expiration Date":=QRCodeDetail."Expiration Date";
                //SSD QRCodeStr.QRCode := TempBlob.Blob;
                QRCodeStr.Insert;
            until QRCodeDetail.Next = 0;
            Clear(QRCodePrintWhseRecpt);
            QRCodePrintWhseRecpt.TransfterDate(QRCodeStr);
            QRCodePrintWhseRecpt.RunModal;
        end
        else
            Message('QR Code not generated for this document');
    end;
    procedure BarcodeForRPO(ProductionOrder: Record "Production Order")
    var
        ItemLedgerEntry: Record "Item Ledger Entry";
        Text5000_Ctx: label '<xpml><page quantity=''0'' pitch=''74.1 mm''></xpml>SIZE 100 mm, 74.1 mm';
        Text5001_Ctx: label 'DIRECTION 0,0';
        Text5002_Ctx: label 'REFERENCE 0,0';
        Text5003_Ctx: label 'OFFSET 0 mm';
        Text5004_Ctx: label 'SET PEEL OFF';
        Text5005_Ctx: label 'SET CUTTER OFF';
        Text5006_Ctx: label 'SET PARTIAL_CUTTER OFF';
        Text5007_Ctx: label '<xpml></page></xpml><xpml><page quantity=''1'' pitch=''74.1 mm''></xpml>SET TEAR ON';
        Text5008_Ctx: label 'CLS';
        Text5009_Ctx: label 'CODEPAGE 1252';
        Text5010_Ctx: label 'TEXT 806,792,"0",180,17,14,"SCHILLER_"';
        Text5011_Ctx: label 'TEXT 1093,443,"0",180,14,12,"Item"';
        Text5012_Ctx: label 'TEXT 1093,303,"0",180,10,12,"Part No."';
        Text5013_Ctx: label 'TEXT 1093,166,"0",180,12,12,"Sr. No."';
        Text5014_Ctx: label 'TEXT 933,443,"0",180,14,12,":"';
        Text5015_Ctx: label 'TEXT 933,303,"0",180,14,12,":"';
        Text5016_Ctx: label 'TEXT 933,166,"0",180,14,12,":"';
        Text5017_Ctx: label 'TEXT 896,303,"0",180,10,12,"%1"';
        Text5018_Ctx: label 'TEXT 896,166,"0",180,10,12,"%1"';
        Text5019_Ctx: label 'QRCODE 330,300,L,10,A,180,M2,S7,"%1"';
        Text5020_Ctx: label 'TEXT 896,443,"0",180,10,12,"%1"';
        Text5021_Ctx: label 'PRINT 1,1';
        Text5022_Ctx: label '<xpml></page></xpml><xpml><end/></xpml>';
        QRCodeStr: Record "SSD QR Code Str" temporary;
        QRGenerator: codeunit "QR Generator";
        TempBlob: Codeunit "Temp Blob";
        RecRef: RecordRef;
        FieldRef: FieldRef;
        QRCodeInput: Text;
        //SSD TempBlob: Record TempBlob;
        QRCodePrintRPO: Report "QR Code Print RPO";
        CRLF: Text[30];
        QRCodeDetail: Record "SSD QR Code Detail";
    begin
        QRCodeStr.Reset;
        QRCodeStr.DeleteAll;
        QRCodeDetail.Reset;
        QRCodeDetail.SetRange("MRN No.", ProductionOrder."No.");
        if QRCodeDetail.FindSet then begin
            repeat Clear(QRCodeStr);
                QRCodeStr.Init;
                QRCodeStr."QR No Integer":=QRCodeDetail."Barcode No Integer";
                QRCodeInput:='QR Code:' + Format(QRCodeDetail."QR Code No.") + '; Lot No.:' + Format(QRCodeDetail."Lot No.") + '; Item No.:' + Format(QRCodeDetail."Item Code") + '; Location:' + Format(QRCodeDetail."Location Code") + '; Quantity:' + Format(QRCodeDetail.Quantity) + '; UOM:' + Format(QRCodeDetail.UOM) + '; BIN Code:' + Format(QRCodeDetail."BIN Code");
                Clear(TempBlob);
                Clear(QRGenerator);
                Clear(SSDRecRef);
                Clear(SSDFieldRef);
                QRCodeStr2.DeleteAll();
                QRGenerator.GenerateQRCodeImage(QRCodeInput, TempBlob);
                SSDRecRef.GetTable(QRCodeStr2);
                SSDFieldRef:=SSDRecRef.Field(QRCodeStr2.FieldNo(QRCode));
                TempBlob.ToRecordRef(SSDRecRef, QRCodeStr2.FieldNo(QRCode));
                QRCodeStr.QRCode:=QRCodeStr2.QRCode;
                //SSD CreateQRCode(QRCodeInput, TempBlob);
                QRCodeStr."QR Code No.":=QRCodeDetail."QR Code No.";
                QRCodeStr."Document No.":=QRCodeDetail."MRN No.";
                QRCodeStr."Item No.":=QRCodeDetail."Item Code";
                QRCodeStr."Qty.":=QRCodeDetail.Quantity;
                QRCodeStr."Lot No.":=QRCodeDetail."Lot No.";
                QRCodeStr."Expiration Date":=QRCodeDetail."Expiration Date";
                //SSD QRCodeStr.QRCode := TempBlob.Blob;
                QRCodeStr.Insert;
                Clear(TempBlob);
                QRGenerator.GenerateQRCodeImage(QRCodeInput, TempBlob);
                Recref.GetTable(QRCodeStr);
                RecRef.Init();
                FieldRef:=RecRef.Field(QRCodeStr.FieldNo(QRCode));
                TempBlob.ToRecordRef(RecRef, QRCodeStr.FieldNo(QRCode));
                RecRef.Insert();
            until QRCodeDetail.Next = 0;
            Clear(QRCodePrintRPO);
            QRCodePrintRPO.TransfterDate(QRCodeStr);
            QRCodePrintRPO.RunModal;
        end
        else
            Message('QR Code not generated for this document');
    end;
    //SSD Comment Start
    // local procedure CreateQRCode(QRCodeInput: Text; var TempBLOB: Record TempBlob)
    // var
    //     QRCodeFileName: Text[1024];
    // begin
    //     Clear(TempBLOB);
    //     QRCodeFileName := GetQRCode(QRCodeInput);
    //     UploadFileBLOBImportandDeleteServerFile(TempBLOB, QRCodeFileName);
    // end;
    // procedure UploadFileBLOBImportandDeleteServerFile(var TempBlob: Record TempBlob; FileName: Text[1024])
    // var
    //     FileManagement: Codeunit "File Management";
    // begin
    //     FileName := FileManagement.UploadFileSilent(FileName);
    //     FileManagement.BLOBImportFromServerFile(TempBlob, FileName);
    //     DeleteServerFile(FileName);
    // end;
    // local procedure DeleteServerFile(ServerFileName: Text)
    // begin
    //     if Erase(ServerFileName) then;
    // end;
    // local procedure GetQRCode(QRCodeInput: Text) QRCodeFileName: Text[1024]
    // var
    //     [RunOnClient]
    //     IBarCodeProvider: dotnet IBarcodeProvider;
    // begin
    //     GetBarCodeProvider(IBarCodeProvider);
    //     QRCodeFileName := IBarCodeProvider.GetBarcode(QRCodeInput);
    // end;
    // procedure GetBarCodeProvider(var IBarCodeProvider: dotnet IBarcodeProvider)
    // var
    //     [RunOnClient]
    //     QRCodeProvider: dotnet QRCodeProvider;
    // begin
    //     if IsNull(IBarCodeProvider) then
    //         IBarCodeProvider := QRCodeProvider.QRCodeProvider;
    // end;
    //SSD Comment End;
    procedure BarcodeForILE(ItemLedgerEntry: Record "Item Ledger Entry")
    var
        Text5000_Ctx: label '<xpml><page quantity=''0'' pitch=''74.1 mm''></xpml>SIZE 100 mm, 74.1 mm';
        Text5001_Ctx: label 'DIRECTION 0,0';
        Text5002_Ctx: label 'REFERENCE 0,0';
        Text5003_Ctx: label 'OFFSET 0 mm';
        Text5004_Ctx: label 'SET PEEL OFF';
        Text5005_Ctx: label 'SET CUTTER OFF';
        Text5006_Ctx: label 'SET PARTIAL_CUTTER OFF';
        Text5007_Ctx: label '<xpml></page></xpml><xpml><page quantity=''1'' pitch=''74.1 mm''></xpml>SET TEAR ON';
        Text5008_Ctx: label 'CLS';
        Text5009_Ctx: label 'CODEPAGE 1252';
        Text5010_Ctx: label 'TEXT 806,792,"0",180,17,14,"SCHILLER_"';
        Text5011_Ctx: label 'TEXT 1093,443,"0",180,14,12,"Item"';
        Text5012_Ctx: label 'TEXT 1093,303,"0",180,10,12,"Part No."';
        Text5013_Ctx: label 'TEXT 1093,166,"0",180,12,12,"Sr. No."';
        Text5014_Ctx: label 'TEXT 933,443,"0",180,14,12,":"';
        Text5015_Ctx: label 'TEXT 933,303,"0",180,14,12,":"';
        Text5016_Ctx: label 'TEXT 933,166,"0",180,14,12,":"';
        Text5017_Ctx: label 'TEXT 896,303,"0",180,10,12,"%1"';
        Text5018_Ctx: label 'TEXT 896,166,"0",180,10,12,"%1"';
        Text5019_Ctx: label 'QRCODE 330,300,L,10,A,180,M2,S7,"%1"';
        Text5020_Ctx: label 'TEXT 896,443,"0",180,10,12,"%1"';
        Text5021_Ctx: label 'PRINT 1,1';
        Text5022_Ctx: label '<xpml></page></xpml><xpml><end/></xpml>';
        QRCodeStr: Record "SSD QR Code Str" temporary;
        QRCodeInput: Text;
        //SSD TempBlob: Record TempBlob;
        QRCodePrintRPO: Report "QR Code Print RPO";
        CRLF: Text[30];
        QRCodeDetail: Record "SSD QR Code Detail";
    begin
        QRCodeStr.Reset;
        QRCodeStr.DeleteAll;
        QRCodeDetail.Reset;
        QRCodeDetail.SetRange("MRN No.", ItemLedgerEntry."Document No.");
        if QRCodeDetail.FindSet then begin
            repeat Clear(QRCodeStr);
                QRCodeStr.Init;
                QRCodeStr."QR No Integer":=QRCodeDetail."Barcode No Integer";
                QRCodeInput:='QR Code:' + Format(QRCodeDetail."QR Code No.") + '; Lot No.:' + Format(QRCodeDetail."Lot No.") + '; Item No.:' + Format(QRCodeDetail."Item Code") + '; Location:' + Format(QRCodeDetail."Location Code") + '; Quantity:' + Format(QRCodeDetail.Quantity) + '; UOM:' + Format(QRCodeDetail.UOM) + '; BIN Code:' + Format(QRCodeDetail."BIN Code") + '; Description: ' + QRCodeDetail."Item Description";
                Clear(TempBlob);
                Clear(QRGenerator);
                Clear(SSDRecRef);
                Clear(SSDFieldRef);
                QRCodeStr2.DeleteAll();
                QRGenerator.GenerateQRCodeImage(QRCodeInput, TempBlob);
                SSDRecRef.GetTable(QRCodeStr2);
                SSDFieldRef:=SSDRecRef.Field(QRCodeStr2.FieldNo(QRCode));
                TempBlob.ToRecordRef(SSDRecRef, QRCodeStr2.FieldNo(QRCode));
                QRCodeStr.QRCode:=QRCodeStr2.QRCode;
                //SSD CreateQRCode(QRCodeInput, TempBlob);
                QRCodeStr."QR Code No.":=QRCodeDetail."QR Code No.";
                QRCodeStr."Document No.":=QRCodeDetail."MRN No.";
                QRCodeStr."Item No.":=QRCodeDetail."Item Code";
                QRCodeStr."Qty.":=QRCodeDetail.Quantity;
                QRCodeStr."Lot No.":=QRCodeDetail."Lot No.";
                QRCodeStr."Expiration Date":=QRCodeDetail."Expiration Date";
                //SSD QRCodeStr.QRCode := TempBlob.Blob;
                QRCodeStr.Insert;
            until QRCodeDetail.Next = 0;
            Clear(QRCodePrintRPO);
            QRCodePrintRPO.TransfterDate(QRCodeStr);
            QRCodePrintRPO.RunModal;
        end
        else
            Message('QR Code not generated for this document');
    end;
    procedure BarcodeForLocation(LocationCode: Code[20]; BinCode: Code[20])
    var
        Text5000_Ctx: label '<xpml><page quantity=''0'' pitch=''74.1 mm''></xpml>SIZE 100 mm, 74.1 mm';
        Text5001_Ctx: label 'DIRECTION 0,0';
        Text5002_Ctx: label 'REFERENCE 0,0';
        Text5003_Ctx: label 'OFFSET 0 mm';
        Text5004_Ctx: label 'SET PEEL OFF';
        Text5005_Ctx: label 'SET CUTTER OFF';
        Text5006_Ctx: label 'SET PARTIAL_CUTTER OFF';
        Text5007_Ctx: label '<xpml></page></xpml><xpml><page quantity=''1'' pitch=''74.1 mm''></xpml>SET TEAR ON';
        Text5008_Ctx: label 'CLS';
        Text5009_Ctx: label 'CODEPAGE 1252';
        Text5010_Ctx: label 'TEXT 806,792,"0",180,17,14,"SCHILLER_"';
        Text5011_Ctx: label 'TEXT 1093,443,"0",180,14,12,"Item"';
        Text5012_Ctx: label 'TEXT 1093,303,"0",180,10,12,"Part No."';
        Text5013_Ctx: label 'TEXT 1093,166,"0",180,12,12,"Sr. No."';
        Text5014_Ctx: label 'TEXT 933,443,"0",180,14,12,":"';
        Text5015_Ctx: label 'TEXT 933,303,"0",180,14,12,":"';
        Text5016_Ctx: label 'TEXT 933,166,"0",180,14,12,":"';
        Text5017_Ctx: label 'TEXT 896,303,"0",180,10,12,"%1"';
        Text5018_Ctx: label 'TEXT 896,166,"0",180,10,12,"%1"';
        Text5019_Ctx: label 'QRCODE 330,300,L,10,A,180,M2,S7,"%1"';
        Text5020_Ctx: label 'TEXT 896,443,"0",180,10,12,"%1"';
        Text5021_Ctx: label 'PRINT 1,1';
        Text5022_Ctx: label '<xpml></page></xpml><xpml><end/></xpml>';
        QRCodeStr: Record "SSD QR Code Str" temporary;
        QRCodeInput: Text;
        //SSD TempBlob: Record TempBlob;
        QRCodePrintRPO: Report "QR Code Print RPO";
        CRLF: Text[30];
    begin
        QRCodeStr.Reset;
        QRCodeStr.DeleteAll;
        Clear(QRCodeStr);
        QRCodeStr.Init;
        QRCodeStr."QR No Integer":=10000;
        QRCodeInput:='Location: ' + Format(LocationCode) + '; BIN Code: ' + Format(BinCode);
        Clear(TempBlob);
        Clear(QRGenerator);
        Clear(SSDRecRef);
        Clear(SSDFieldRef);
        QRCodeStr2.DeleteAll();
        QRGenerator.GenerateQRCodeImage(QRCodeInput, TempBlob);
        SSDRecRef.GetTable(QRCodeStr2);
        SSDFieldRef:=SSDRecRef.Field(QRCodeStr2.FieldNo(QRCode));
        TempBlob.ToRecordRef(SSDRecRef, QRCodeStr2.FieldNo(QRCode));
        QRCodeStr.QRCode:=QRCodeStr2.QRCode;
        //SSD CreateQRCode(QRCodeInput, TempBlob);
        QRCodeStr."QR Code No.":='1';
        QRCodeStr."Item No.":='00';
        //SSD QRCodeStr.QRCode := TempBlob.Blob;
        QRCodeStr.Insert;
        Clear(QRCodePrintRPO);
        QRCodePrintRPO.TransfterDate(QRCodeStr);
        QRCodePrintRPO.RunModal;
    end;
    procedure BarcodeForCrMemo(DocumentNo: Code[20]; PostingDate: Date; OrderNo: Code[20]; PartyName: Text)
    var
        Text5000_Ctx: label '<xpml><page quantity=''0'' pitch=''74.1 mm''></xpml>SIZE 100 mm, 74.1 mm';
        Text5001_Ctx: label 'DIRECTION 0,0';
        Text5002_Ctx: label 'REFERENCE 0,0';
        Text5003_Ctx: label 'OFFSET 0 mm';
        Text5004_Ctx: label 'SET PEEL OFF';
        Text5005_Ctx: label 'SET CUTTER OFF';
        Text5006_Ctx: label 'SET PARTIAL_CUTTER OFF';
        Text5007_Ctx: label '<xpml></page></xpml><xpml><page quantity=''1'' pitch=''74.1 mm''></xpml>SET TEAR ON';
        Text5008_Ctx: label 'CLS';
        Text5009_Ctx: label 'CODEPAGE 1252';
        Text5010_Ctx: label 'TEXT 806,792,"0",180,17,14,"SCHILLER_"';
        Text5011_Ctx: label 'TEXT 1093,443,"0",180,14,12,"Item"';
        Text5012_Ctx: label 'TEXT 1093,303,"0",180,10,12,"Part No."';
        Text5013_Ctx: label 'TEXT 1093,166,"0",180,12,12,"Sr. No."';
        Text5014_Ctx: label 'TEXT 933,443,"0",180,14,12,":"';
        Text5015_Ctx: label 'TEXT 933,303,"0",180,14,12,":"';
        Text5016_Ctx: label 'TEXT 933,166,"0",180,14,12,":"';
        Text5017_Ctx: label 'TEXT 896,303,"0",180,10,12,"%1"';
        Text5018_Ctx: label 'TEXT 896,166,"0",180,10,12,"%1"';
        Text5019_Ctx: label 'QRCODE 330,300,L,10,A,180,M2,S7,"%1"';
        Text5020_Ctx: label 'TEXT 896,443,"0",180,10,12,"%1"';
        Text5021_Ctx: label 'PRINT 1,1';
        Text5022_Ctx: label '<xpml></page></xpml><xpml><end/></xpml>';
        QRCodeStr: Record "SSD QR Code Str";
        QRCodeInput: Text;
        QRCodePrintRPO: Report "QR Code Print RPO";
    //SSD TempBlob: Record TempBlob;
    begin
        QRCodeStr.Reset;
        QRCodeStr.DeleteAll;
        Clear(QRCodeStr);
        QRCodeStr.Init;
        QRCodeStr."QR No Integer":=10000;
        QRCodeInput:=Format(DocumentNo) + ';' + Format(PostingDate) + ';' + OrderNo + ';' + PartyName + ';';
        Clear(TempBlob);
        Clear(QRGenerator);
        Clear(SSDRecRef);
        Clear(SSDFieldRef);
        QRCodeStr2.DeleteAll();
        QRGenerator.GenerateQRCodeImage(QRCodeInput, TempBlob);
        SSDRecRef.GetTable(QRCodeStr2);
        SSDFieldRef:=SSDRecRef.Field(QRCodeStr2.FieldNo(QRCode));
        TempBlob.ToRecordRef(SSDRecRef, QRCodeStr2.FieldNo(QRCode));
        //QRCodeStr.QRCode := QRCodeStr2.QRCode;
        //SSD Sunil
        QRCodeStr.QRCode:=SSDFieldRef.Value;
        //SSD CreateQRCode(QRCodeInput, TempBlob);
        QRCodeStr."QR Code No.":='1';
        QRCodeStr."Item No.":='ITM001';
        //SSD QRCodeStr.QRCode := TempBlob.Blob;
        QRCodeStr.Insert;
    end;
    procedure BarcodeForReservationEntry(MRNNo: Code[30]; LotNo: Code[20]; ItemNo: Code[20]; LocationCode: Code[20]; Qty: Decimal)
    var
        Text5000_Ctx: label '<xpml><page quantity=''0'' pitch=''74.1 mm''></xpml>SIZE 100 mm, 74.1 mm';
        Text5001_Ctx: label 'DIRECTION 0,0';
        Text5002_Ctx: label 'REFERENCE 0,0';
        Text5003_Ctx: label 'OFFSET 0 mm';
        Text5004_Ctx: label 'SET PEEL OFF';
        Text5005_Ctx: label 'SET CUTTER OFF';
        Text5006_Ctx: label 'SET PARTIAL_CUTTER OFF';
        Text5007_Ctx: label '<xpml></page></xpml><xpml><page quantity=''1'' pitch=''74.1 mm''></xpml>SET TEAR ON';
        Text5008_Ctx: label 'CLS';
        Text5009_Ctx: label 'CODEPAGE 1252';
        Text5010_Ctx: label 'TEXT 806,792,"0",180,17,14,"SCHILLER_"';
        Text5011_Ctx: label 'TEXT 1093,443,"0",180,14,12,"Item"';
        Text5012_Ctx: label 'TEXT 1093,303,"0",180,10,12,"Part No."';
        Text5013_Ctx: label 'TEXT 1093,166,"0",180,12,12,"Sr. No."';
        Text5014_Ctx: label 'TEXT 933,443,"0",180,14,12,":"';
        Text5015_Ctx: label 'TEXT 933,303,"0",180,14,12,":"';
        Text5016_Ctx: label 'TEXT 933,166,"0",180,14,12,":"';
        Text5017_Ctx: label 'TEXT 896,303,"0",180,10,12,"%1"';
        Text5018_Ctx: label 'TEXT 896,166,"0",180,10,12,"%1"';
        Text5019_Ctx: label 'QRCODE 330,300,L,10,A,180,M2,S7,"%1"';
        Text5020_Ctx: label 'TEXT 896,443,"0",180,10,12,"%1"';
        Text5021_Ctx: label 'PRINT 1,1';
        Text5022_Ctx: label '<xpml></page></xpml><xpml><end/></xpml>';
        QRCodeStr: Record "SSD QR Code Str";
        QRCodeInput: Text;
        //SSD TempBlob: Record TempBlob;
        LineNo: Integer;
    begin
        QRCodeStr.Reset;
        QRCodeStr.DeleteAll;
        Clear(QRCodeStr);
        QRCodeStr.Init;
        QRCodeStr."QR No Integer":=10000;
        QRCodeInput:='Doc No: ' + Format(MRNNo) + '; Lot: ' + LotNo + '; Item: ' + ItemNo + '; Location: ' + LocationCode + '; QTY: ' + Format(Qty) + ';';
        Clear(TempBlob);
        Clear(QRGenerator);
        Clear(SSDRecRef);
        Clear(SSDFieldRef);
        QRCodeStr2.DeleteAll();
        QRGenerator.GenerateQRCodeImage(QRCodeInput, TempBlob);
        SSDRecRef.GetTable(QRCodeStr2);
        SSDFieldRef:=SSDRecRef.Field(QRCodeStr2.FieldNo(QRCode));
        TempBlob.ToRecordRef(SSDRecRef, QRCodeStr2.FieldNo(QRCode));
        QRCodeStr.QRCode:=QRCodeStr2.QRCode;
        //SSD CreateQRCode(QRCodeInput, TempBlob);
        QRCodeStr."QR Code No.":='1';
        QRCodeStr."Item No.":='ITM001';
        //SSD QRCodeStr.QRCode := TempBlob.Blob;
        QRCodeStr.Insert;
    end;
    procedure BarcodeForReservationEntry1(MRNNo: Code[30]; LotNo: Code[20]; ItemNo: Code[20]; LocationCode: Code[20]; Qty: Decimal; SrNo: Integer)
    var
        Text5000_Ctx: label '<xpml><page quantity=''0'' pitch=''74.1 mm''></xpml>SIZE 100 mm, 74.1 mm';
        Text5001_Ctx: label 'DIRECTION 0,0';
        Text5002_Ctx: label 'REFERENCE 0,0';
        Text5003_Ctx: label 'OFFSET 0 mm';
        Text5004_Ctx: label 'SET PEEL OFF';
        Text5005_Ctx: label 'SET CUTTER OFF';
        Text5006_Ctx: label 'SET PARTIAL_CUTTER OFF';
        Text5007_Ctx: label '<xpml></page></xpml><xpml><page quantity=''1'' pitch=''74.1 mm''></xpml>SET TEAR ON';
        Text5008_Ctx: label 'CLS';
        Text5009_Ctx: label 'CODEPAGE 1252';
        Text5010_Ctx: label 'TEXT 806,792,"0",180,17,14,"SCHILLER_"';
        Text5011_Ctx: label 'TEXT 1093,443,"0",180,14,12,"Item"';
        Text5012_Ctx: label 'TEXT 1093,303,"0",180,10,12,"Part No."';
        Text5013_Ctx: label 'TEXT 1093,166,"0",180,12,12,"Sr. No."';
        Text5014_Ctx: label 'TEXT 933,443,"0",180,14,12,":"';
        Text5015_Ctx: label 'TEXT 933,303,"0",180,14,12,":"';
        Text5016_Ctx: label 'TEXT 933,166,"0",180,14,12,":"';
        Text5017_Ctx: label 'TEXT 896,303,"0",180,10,12,"%1"';
        Text5018_Ctx: label 'TEXT 896,166,"0",180,10,12,"%1"';
        Text5019_Ctx: label 'QRCODE 330,300,L,10,A,180,M2,S7,"%1"';
        Text5020_Ctx: label 'TEXT 896,443,"0",180,10,12,"%1"';
        Text5021_Ctx: label 'PRINT 1,1';
        Text5022_Ctx: label '<xpml></page></xpml><xpml><end/></xpml>';
        QRCodeStr: Record "SSD QR Code Str";
        QRCodeInput: Text;
    //SSD TempBlob: Record TempBlob;
    begin
        QRCodeStr.Reset;
        QRCodeStr.SetRange("QR No Integer", SrNo);
        if QRCodeStr.FindFirst then QRCodeStr.Delete;
        Clear(QRCodeStr);
        QRCodeStr.Init;
        QRCodeStr."QR No Integer":=SrNo;
        QRCodeInput:='Doc No: ' + Format(MRNNo) + '; Lot: ' + LotNo + '; Item: ' + ItemNo + '; Location: ' + LocationCode + '; QTY: ' + Format(Qty) + ';';
        Clear(TempBlob);
        Clear(QRGenerator);
        Clear(SSDRecRef);
        Clear(SSDFieldRef);
        QRCodeStr2.DeleteAll();
        QRGenerator.GenerateQRCodeImage(QRCodeInput, TempBlob);
        SSDRecRef.GetTable(QRCodeStr2);
        SSDFieldRef:=SSDRecRef.Field(QRCodeStr2.FieldNo(QRCode));
        TempBlob.ToRecordRef(SSDRecRef, QRCodeStr2.FieldNo(QRCode));
        QRCodeStr.QRCode:=QRCodeStr2.QRCode;
        //SSD CreateQRCode(QRCodeInput, TempBlob);
        QRCodeStr."QR Code No.":=LotNo;
        QRCodeStr."Item No.":=ItemNo;
        //SSD QRCodeStr.QRCode := TempBlob.Blob;
        QRCodeStr.Insert;
    end;
}
