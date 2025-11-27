codeunit 50065 "SSDEinvGenerateEinvoice"
{
    var SalesSetup: Record "Sales & Receivables Setup";
    GLSetup: Record "General Ledger Setup";
    JsonTxt: Text;
    salesInv: page "Sales Order";
    einv: Codeunit "e-Invoice Json Handler";
    procedure GenerateSalesInvoice(var SalesInvoiceHeader: record "Sales Invoice Header")
    var
        QRGenerator: Codeunit "QR Generator";
        ReqId: Code[20];
        SSDEinv: Codeunit SSDEinvPrepareEinvoice;
        // EinvAd: DotNet Adequare;
        TokenTxt: Text;
        ReturnMessage: Text;
        ReturnStatus: Boolean;
        ReturnResult: Text;
        QRTxt: Text;
        OutStream: OutStream;
        TempBlob: Codeunit "Temp Blob";
        RecRef: RecordRef;
        FieldRef: FieldRef;
        EwbNo: Code[20];
        EWBApplicable: Boolean;
        //EInv_EWBMgt: Codeunit "Einvoice-EWB Management";
        Location: Record Location;
    begin
        // ReqId := GetRequestId();
        // Clear(SSDEinv);
        // Clear(EinvAd);
        // //EWBApplicable := IsEWBInfoAvailable(SalesInvoiceHeader);
        SSDEinv.SetSalesInvHeader(SalesInvoiceHeader, EWBApplicable);
        JsonTxt:=SSDEinv.EsportJsonTxt();
        Message(JsonTxt);
        if not Confirm('Do you want to continue?', false)then exit;
    // EinvAd := EinvAd.GenerateIRNEWB();
    // EinvAd.r_ID := ReqId;
    // TokenTxt := EinvAd.FetchData;
    // Location.Reset();
    // Location.Get(SalesInvoiceHeader."Location Code");
    // Location.TestField("E Invoice User ID");
    // Location.TestField("E Invoice Password");
    // Location.TestField("GST Registration No.");
    // EinvAd.InUserId := Location."E Invoice User ID";
    // EinvAd.InPassword := Location."E Invoice Password";
    // EinvAd.InGSTRegNo := Location."GST Registration No.";
    // //Message(Location."GST Registration No.");//Remove SSD
    // EinvAd.intoken := TokenTxt;
    // EinvAd.Json_txt := JsonTxt;
    // ReturnMessage := EinvAd.FetchIRN;
    // MESSAGE(ReturnMessage);
    // ReturnStatus := EinvAd.GetReturnStatus;
    // IF ReturnStatus THEN BEGIN
    //     RecRef.GetTable(SalesInvoiceHeader);
    //     FieldRef := RecRef.Field(SalesInvoiceHeader.FieldNo("Acknowledgement No."));
    //     FieldRef.Value := EinvAd.GetAckNo;
    //     FieldRef := RecRef.Field(SalesInvoiceHeader.FieldNo("Acknowledgement Date"));
    //     FieldRef.Value := EinvAd.GetAckDate - ((1000 * 60) * 330);
    //     FieldRef := RecRef.Field(SalesInvoiceHeader.FieldNo("IRN Hash"));
    //     FieldRef.Value := EinvAd.GetIRN;
    //     FieldRef := RecRef.Field(SalesInvoiceHeader.FieldNo(IsJSONImported));
    //     FieldRef.Value := true;
    //     QRTxt := EinvAd.GetSignedQRCode;
    //     if QRTxt <> '' then begin
    //         QRGenerator.GenerateQRCodeImage(QRTxt, TempBlob);
    //         FieldRef := RecRef.Field(SalesInvoiceHeader.FieldNo("QR Code"));
    //         TempBlob.ToRecordRef(RecRef, SalesInvoiceHeader.FieldNo("QR Code"));
    //     end;
    //     ReturnResult := EinvAd.GetReturnResult;
    //     MESSAGE(ReturnResult);
    //     //EwbNo := EinvAd.GetEwbNo;
    //     /*
    //     if EwbNo <> '' then begin
    //         FieldRef := RecRef.Field(SalesInvoiceHeader.FieldNo("E-Way Bill No."));
    //         FieldRef.Value := EinvAd.GetEwbNo;
    //         EInv_EWBMgt.InsertEInvoiceDetails(0, SalesInvoiceHeader."No.");
    //     end;
    //     */
    //     RecRef.Modify();
    // END;
    end;
    procedure GenerateSalesCrMemo(var SalesCrMemoHeader: Record "Sales Cr.Memo Header")
    var
        QRGenerator: Codeunit "QR Generator";
        ReqId: Code[20];
        SSDEinv: Codeunit SSDEinvPrepareEinvoice;
        //EinvAd: DotNet Adequare;
        TokenTxt: Text;
        ReturnMessage: Text;
        ReturnStatus: Boolean;
        ReturnResult: Text;
        QRTxt: Text;
        OutStream: OutStream;
        TempBlob: Codeunit "Temp Blob";
        RecRef: RecordRef;
        FieldRef: FieldRef;
        EwbNo: Code[20];
        EWBApplicable: Boolean;
        Location: Record Location;
    begin
        // ReqId := GetRequestId();
        EWBApplicable:=false;
        SSDEinv.SetCrMemoHeader(SalesCrMemoHeader, EWBApplicable);
        JsonTxt:=SSDEinv.EsportJsonTxt();
        Message(JsonTxt);
        if not Confirm('Do you want to continue?', false)then exit;
    //     EinvAd := EinvAd.GenerateIRNEWB();
    //     EinvAd.r_ID := ReqId;
    //     TokenTxt := EinvAd.FetchData;
    //     Location.Reset();
    //     Location.Get(SalesCrMemoHeader."Location Code");
    //     Location.TestField("E Invoice User ID");
    //     Location.TestField("E Invoice Password");
    //     Location.TestField("GST Registration No.");
    //     EinvAd.InUserId := Location."E Invoice User ID";
    //     EinvAd.InPassword := Location."E Invoice Password";
    //     EinvAd.InGSTRegNo := Location."GST Registration No.";
    //     EinvAd.intoken := TokenTxt;
    //     EinvAd.Json_txt := JsonTxt;
    //     ReturnMessage := EinvAd.FetchIRN;
    //     MESSAGE(ReturnMessage);
    //     ReturnStatus := EinvAd.GetReturnStatus;
    //     IF ReturnStatus THEN BEGIN
    //         RecRef.GetTable(SalesCrMemoHeader);
    //         FieldRef := RecRef.Field(SalesCrMemoHeader.FieldNo("Acknowledgement No."));
    //         FieldRef.Value := EinvAd.GetAckNo;
    //         FieldRef := RecRef.Field(SalesCrMemoHeader.FieldNo("Acknowledgement Date"));
    //         FieldRef.Value := EinvAd.GetAckDate - ((1000 * 60) * 330);
    //         FieldRef := RecRef.Field(SalesCrMemoHeader.FieldNo("IRN Hash"));
    //         FieldRef.Value := EinvAd.GetIRN;
    //         FieldRef := RecRef.Field(SalesCrMemoHeader.FieldNo(IsJSONImported));
    //         FieldRef.Value := true;
    //         QRTxt := EinvAd.GetSignedQRCode;
    //         if QRTxt <> '' then begin
    //             QRGenerator.GenerateQRCodeImage(QRTxt, TempBlob);
    //             FieldRef := RecRef.Field(SalesCrMemoHeader.FieldNo("QR Code"));
    //             TempBlob.ToRecordRef(RecRef, SalesCrMemoHeader.FieldNo("QR Code"));
    //         end;
    //         //ReturnResult := EinvAd.GetReturnResult;
    //         //MESSAGE(ReturnResult);
    //         RecRef.Modify();
    //         ReturnResult := EinvAd.GetReturnResult;
    //         MESSAGE(ReturnResult);
    //         // SalesCrMemoHeader.Modify();//Sourabh 130122
    //     END;
    end;
//     procedure GenerateSalesCrMemoTest(var SalesCrMemoHeader: Record "Sales Cr.Memo Header")
//     var
//         QRGenerator: Codeunit "QR Generator";
//         ReqId: Code[20];
//         SSDEinv: Codeunit SSDEinvPrepareEinvoice;
//         EinvAd: DotNet AdequareTest;
//         TokenTxt: Text;
//         ReturnMessage: Text;
//         ReturnStatus: Boolean;
//         ReturnResult: Text;
//         QRTxt: Text;
//         OutStream: OutStream;
//         TempBlob: Codeunit "Temp Blob";
//         RecRef: RecordRef;
//         FieldRef: FieldRef;
//         EwbNo: Code[20];
//         EWBApplicable: Boolean;
//         Location: Record Location;
//     begin
//         ReqId := GetRequestId();
//         EWBApplicable := false;
//         SSDEinv.SetCrMemoHeader(SalesCrMemoHeader, EWBApplicable);
//         JsonTxt := SSDEinv.EsportJsonTxt();
//         Message(JsonTxt);
//         if not Confirm('Do you want to continue?', false) then
//             exit;
//         EinvAd := EinvAd.GenerateIRNEWB();
//         EinvAd.r_ID := ReqId;
//         TokenTxt := EinvAd.FetchData;
//         Location.Reset();
//         Location.Get(SalesCrMemoHeader."Location Code");
//         EinvAd.InUserId := Location."E Invoice User ID";
//         EinvAd.InPassword := Location."E Invoice Password";
//         EinvAd.InGSTRegNo := Location."GST Registration No.";
//         EinvAd.intoken := TokenTxt;
//         EinvAd.Json_txt := JsonTxt;
//         ReturnMessage := EinvAd.FetchIRN;
//         MESSAGE(ReturnMessage);
//         ReturnStatus := EinvAd.GetReturnStatus;
//         IF ReturnStatus THEN BEGIN
//             RecRef.GetTable(SalesCrMemoHeader);
//             FieldRef := RecRef.Field(SalesCrMemoHeader.FieldNo("Acknowledgement No."));
//             FieldRef.Value := EinvAd.GetAckNo;
//             FieldRef := RecRef.Field(SalesCrMemoHeader.FieldNo("Acknowledgement Date"));
//             FieldRef.Value := EinvAd.GetAckDate - ((1000 * 60) * 330);
//             FieldRef := RecRef.Field(SalesCrMemoHeader.FieldNo("IRN Hash"));
//             FieldRef.Value := EinvAd.GetIRN;
//             FieldRef := RecRef.Field(SalesCrMemoHeader.FieldNo(IsJSONImported));
//             FieldRef.Value := true;
//             QRTxt := EinvAd.GetSignedQRCode;
//             if QRTxt <> '' then begin
//                 QRGenerator.GenerateQRCodeImage(QRTxt, TempBlob);
//                 FieldRef := RecRef.Field(SalesCrMemoHeader.FieldNo("QR Code"));
//                 TempBlob.ToRecordRef(RecRef, SalesCrMemoHeader.FieldNo("QR Code"));
//             end;
//             //ReturnResult := EinvAd.GetReturnResult;
//             //MESSAGE(ReturnResult);
//             RecRef.Modify();
//             ReturnResult := EinvAd.GetReturnResult;
//             MESSAGE(ReturnResult);
//             // SalesCrMemoHeader.Modify();//Sourabh 130122
//         END;
//     end;
//     /*
//         procedure GenerateTransferShipment(VAR TransferShipmentHeader: Record "Transfer Shipment Header")
//         var
//             QRGenerator: Codeunit "QR Generator";
//             ReqId: Code[20];
//             SSDEinv: Codeunit SSDEinvPrepareEinvoice;
//             EinvAd: DotNet Adequare;
//             TokenTxt: Text;
//             ReturnMessage: Text;
//             ReturnStatus: Boolean;
//             ReturnResult: Text;
//             QRTxt: Text;
//             OutStream: OutStream;
//             TempBlob: Codeunit "Temp Blob";
//             RecRef: RecordRef;
//             EwbNo: Code[20];
//             EWBApplicable: Boolean;
//             EWBValidityDate: Text;
//             //EInv_EWBMgt: Codeunit "Einvoice-EWB Management";
//             FieldRef: FieldRef;
//             Location: Record Location;
//         begin
//             ReqId := GetRequestId();
//             //EWBApplicable := IsTransferEWBInfoAvailable(TransferShipmentHeader);
//             JsonTxt := SSDEinv.ExportTransferJsonTxt(TransferShipmentHeader, EWBApplicable);
//             MESSAGE(JsonTxt);
//             if not Confirm('Do you want to continue?', false) then
//                 exit;
//             EinvAd := EinvAd.GenerateIRNEWB;
//             EinvAd.r_ID := ReqId;
//             TokenTxt := EinvAd.FetchData;
//             Location.Reset();
//             Location.Get(TransferShipmentHeader."Transfer-from Code");
//             Location.TestField("E Invoice User ID");
//             Location.TestField("E Invoice Password");
//             Location.TestField("GST Registration No.");
//             EinvAd.InUserId := Location."E Invoice User ID";
//             EinvAd.InPassword := Location."E Invoice Password";
//             EinvAd.InGSTRegNo := Location."GST Registration No.";
//             EinvAd.intoken := TokenTxt;
//             EinvAd.Json_txt := JsonTxt;
//             ReturnMessage := EinvAd.FetchIRN;
//             MESSAGE(ReturnMessage);
//             ReturnStatus := EinvAd.GetReturnStatus;
//             IF ReturnStatus THEN BEGIN
//                 RecRef.GetTable(TransferShipmentHeader);
//                 FieldRef := RecRef.Field(TransferShipmentHeader.FieldNo(ack));
//                 FieldRef.Value := EinvAd.GetAckNo;
//                 FieldRef := RecRef.Field(TransferShipmentHeader.FieldNo("AckDate/Cancel Date"));
//                 FieldRef.Value := EinvAd.GetAckDate - ((1000 * 60) * 330);
//                 FieldRef := RecRef.Field(TransferShipmentHeader.FieldNo("IRN No."));
//                 FieldRef.Value := EinvAd.GetIRN;
//                 QRTxt := EinvAd.GetSignedQRCode;
//                 if QRTxt <> '' then begin
//                     QRGenerator.GenerateQRCodeImage(QRTxt, TempBlob);
//                     FieldRef := RecRef.Field(TransferShipmentHeader.FieldNo(SignedQRCode));
//                     TempBlob.ToRecordRef(RecRef, TransferShipmentHeader.FieldNo(SignedQRCode));
//                 end;
//                 ReturnResult := EinvAd.GetReturnResult;
//                 MESSAGE(ReturnResult);
//                 IF EWBApplicable THEN BEGIN
//                     EwbNo := EinvAd.GetEwbNo;
//                     EWBValidityDate := EinvAd.GetEwbValidity;
//                     FieldRef := RecRef.Field(TransferShipmentHeader.FieldNo("E-Way Bill No."));
//                     FieldRef.Value := EinvAd.GetEwbNo;
//                     EInv_EWBMgt.InsertEWBDetails(2, TransferShipmentHeader."No.", EwbNo, FORMAT(CurrentDateTime), EWBValidityDate);
//                 END;
//                 //EInv_EWBMgt.InsertEInvoiceDetails(2, TransferShipmentHeader."No.");
//                 RecRef.Modify();
//             END;
//         end;
//     */
//     /*
//     procedure GenerateTransferShipmentTest(VAR TransferShipmentHeader: Record "Transfer Shipment Header")
//     var
//         QRGenerator: Codeunit "QR Generator";
//         ReqId: Code[20];
//         SSDEinv: Codeunit SSDEinvPrepareEinvoice;
//         EinvAd: DotNet AdequareTest;
//         TokenTxt: Text;
//         ReturnMessage: Text;
//         ReturnStatus: Boolean;
//         ReturnResult: Text;
//         QRTxt: Text;
//         OutStream: OutStream;
//         TempBlob: Codeunit "Temp Blob";
//         RecRef: RecordRef;
//         EwbNo: Code[20];
//         EWBApplicable: Boolean;
//         EWBValidityDate: Text;
//         //EInv_EWBMgt: Codeunit "Einvoice-EWB Management";
//         FieldRef: FieldRef;
//         Location: Record Location;
//     begin
//         ReqId := GetRequestId();
//         //EWBApplicable := IsTransferEWBInfoAvailable(TransferShipmentHeader);
//         JsonTxt := SSDEinv.ExportTransferJsonTxt(TransferShipmentHeader, EWBApplicable);
//         MESSAGE(JsonTxt);
//         if not Confirm('Do you want to continue?', false) then
//             exit;
//         EinvAd := EinvAd.GenerateIRNEWB;
//         EinvAd.r_ID := ReqId;
//         TokenTxt := EinvAd.FetchData;
//         Location.Reset();
//         Location.Get(TransferShipmentHeader."Transfer-from Code");
//         EinvAd.InUserId := Location."E Invoice User ID";
//         EinvAd.InPassword := Location."E Invoice Password";
//         EinvAd.InGSTRegNo := Location."GST Registration No.";
//         EinvAd.intoken := TokenTxt;
//         EinvAd.Json_txt := JsonTxt;
//         ReturnMessage := EinvAd.FetchIRN;
//         MESSAGE(ReturnMessage);
//         ReturnStatus := EinvAd.GetReturnStatus;
//         IF ReturnStatus THEN BEGIN
//             RecRef.GetTable(TransferShipmentHeader);
//             FieldRef := RecRef.Field(TransferShipmentHeader.FieldNo(AckNo));
//             FieldRef.Value := EinvAd.GetAckNo;
//             FieldRef := RecRef.Field(TransferShipmentHeader.FieldNo("AckDate/Cancel Date"));
//             FieldRef.Value := EinvAd.GetAckDate - ((1000 * 60) * 330);
//             FieldRef := RecRef.Field(TransferShipmentHeader.FieldNo("IRN No."));
//             FieldRef.Value := EinvAd.GetIRN;
//             QRTxt := EinvAd.GetSignedQRCode;
//             if QRTxt <> '' then begin
//                 QRGenerator.GenerateQRCodeImage(QRTxt, TempBlob);
//                 FieldRef := RecRef.Field(TransferShipmentHeader.FieldNo(SignedQRCode));
//                 TempBlob.ToRecordRef(RecRef, TransferShipmentHeader.FieldNo(SignedQRCode));
//             end;
//             ReturnResult := EinvAd.GetReturnResult;
//             MESSAGE(ReturnResult);
//             IF EWBApplicable THEN BEGIN
//                 EwbNo := EinvAd.GetEwbNo;
//                 EWBValidityDate := EinvAd.GetEwbValidity;
//                 FieldRef := RecRef.Field(TransferShipmentHeader.FieldNo("E-Way Bill No."));
//                 FieldRef.Value := EinvAd.GetEwbNo;
//                 EInv_EWBMgt.InsertEWBDetails(2, TransferShipmentHeader."No.", EwbNo, FORMAT(CurrentDateTime), EWBValidityDate);
//             END;
//             //EInv_EWBMgt.InsertEInvoiceDetails(2, TransferShipmentHeader."No.");
//             RecRef.Modify();
//         END;
//     end;
// */
//     local procedure IsEWBInfoAvailable(var SalesInvHeader: Record "Sales Invoice Header"): Boolean
//     begin
//         IF (SalesInvHeader."Shipping Agent Code" <> '') AND (SalesInvHeader."Vehicle No." <> '') AND (SalesInvHeader."LR/RR No." <> '') AND (SalesInvHeader."E-Way Bill No." = '') THEN
//             EXIT(TRUE)
//         ELSE
//             EXIT(FALSE);
//     end;
//     /*
//         procedure IsTransferEWBInfoAvailable(VAR TransferShipmentHeader: Record "Transfer Shipment Header"): Boolean
//         begin
//             WITH TransferShipmentHeader DO BEGIN
//                 IF ("Shipping Agent Code" <> '') AND ("Vehicle No." <> '') AND ("E-Way Bill No." = '') THEN
//                     EXIT(TRUE)
//                 ELSE
//                     EXIT(FALSE);
//             END
//         end;
//         */
//     /*
//         local procedure GetRequestId() RequestId: code[20]
//         var
//             PreFix: Label 'AAKT';
//         begin
//             GLSetup.GET;
//             IF NOT GLSetup."Test Instance" THEN begin
//                 IF GLSetup."Unique Request No." = '' THEN
//                     GLSetup."Unique Request No." := 'AAK' + CopyStr(CompanyName, 1, 1) + '3900001'
//                 ELSE
//                     GLSetup."Unique Request No." := INCSTR(GLSetup."Unique Request No.");
//                 GLSetup.MODIFY;
//                 RequestId := GLSetup."Unique Request No.";
//             end else begin
//                 IF (PreFix <> CopyStr(GLSetup."Unique Request No.", 1, 4)) then
//                     GLSetup."Unique Request No." := '';
//                 IF GLSetup."Unique Request No." = '' THEN
//                     GLSetup."Unique Request No." := PreFix + CopyStr(CompanyName, 1, 1) + '3900001'
//                 ELSE
//                     GLSetup."Unique Request No." := INCSTR(GLSetup."Unique Request No.");
//                 GLSetup.MODIFY;
//                 RequestId := GLSetup."Unique Request No.";
//             end;
//             COMMIT;
//         end;
//     */
}
