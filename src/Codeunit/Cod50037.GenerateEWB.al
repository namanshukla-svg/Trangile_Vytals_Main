codeunit 50037 "Generate EWB"
{
    TableNo = "Sales Invoice Header";

    trigger OnRun()
    var
        GeneralLedgerSetup: Record "General Ledger Setup";
    begin
        IF Rec.FINDFIRST THEN BEGIN
            GeneralLedgerSetup.Get();
            // if not GeneralLedgerSetup."Test Instance" then
            GenerateSalesInvoice(Rec)// else
        //     GenerateSalesInvoiceTest(Rec);
        END;
    end;
    var SSDEWB: Codeunit "SSD EWB";
    JsonTxt: Text;
    TokenTxt: Text;
    ReturnMessage: Text;
    ReturnResult: Text;
    EwbNo: Text[20];
    EWBBillDate: Text[50];
    EWBValidityDate: Text[50];
    //EWBMgt: Codeunit "Einvoice-EWB Management";
    ReturnStatus: Boolean;
    EWBType: Option Sales, Purchase, Transfer, SalesReturn, SalesIRN;
    procedure GenerateSalesInvoice(var SalesInvHeader: Record "Sales Invoice Header")
    var
        ReqId: Code[20];
        EinvError: Label 'Without E-Invoice, no E-way bill to be generated';
        Location: Record Location;
    //EWBAd: DotNet AdequareEWB;
    begin
        WITH SalesInvHeader DO BEGIN
            //SSD Sunil Remove After Live
            // if "Acknowledgement No." = '' then
            //     Error(EinvError);
            //SSD Sunil Remove After Live
            //ReqId := GetRequestId;
            //IF "IRN Hash" = ''  THEN BEGIN
            SSDEWB.SetSalesInvHeader(SalesInvHeader, EWBType::Sales);
            JsonTxt:=SSDEWB.ExportJsonTxt;
            MESSAGE(JsonTxt);
        // SSD -29-03-23
        // EWBAd := EWBAd.GenerateEWB();
        // //EXIT;
        // EWBAd.r_ID := ReqId;
        // TokenTxt := EWBAd.FetchData;
        // Location.Reset();
        // Location.Get(SalesInvHeader."Location Code");
        // EWBAd.InUserId := Location."EInvoice User ID";
        // EWBAd.InPassword := Location."EInvoice Password";
        // EWBAd.InGSTRegNo := Location."GST Registration No.";
        // EWBAd.intoken := TokenTxt;
        // EWBAd.Json_txt := JsonTxt;
        // ReturnMessage := EWBAd.FetchIRN;
        // ReturnStatus := EWBAd.GetReturnStatus;
        // MESSAGE(ReturnMessage);
        // MESSAGE('%1', ReturnStatus);
        // IF ReturnStatus THEN BEGIN
        //     ReturnResult := EWBAd.GetReturnResult;
        //     MESSAGE(ReturnResult);
        //     EwbNo := EWBAd.GetEwbNo;
        //     EWBBillDate := EWBAd.GetEwbDate;
        //     EWBValidityDate := EWBAd.GetEwbValidity;
        //     EWBMgt.InsertEWBDetails(0, "No.", EwbNo, EWBBillDate, EWBValidityDate);
        //     "E-Way Bill No." := EWBAd.GetEwbNo;
        //     MODIFY;
        // END;
        //  END ELSE BEGIN
        //    SSDEWB.SetSalesInvHeader(SalesInvHeader,EWBType::SalesIRN);
        //    JsonTxt := SSDEWB.ExportJsonTxt;
        //    MESSAGE(JsonTxt);
        //    EWBIRN := EWBIRN.EWBWithIRN;
        //    //EXIT;
        //    EWBIRN.r_ID := ReqId;
        //
        //    TokenTxt := EWBIRN.FetchData;
        //
        //    EWBIRN.intoken := TokenTxt;
        //    EWBIRN.InGSTRegNo := '37AMBPG7773M002';
        //    EWBIRN.InUserId := 'adqgspapusr1';
        //    EWBIRN.InPassword := 'Gsp@1234';
        //    EWBIRN.Json_txt := JsonTxt;
        //    ReturnMessage := EWBIRN.FetchIRN;
        //    ReturnStatus := EWBIRN.GetReturnStatus;
        //    MESSAGE(ReturnMessage);
        //    MESSAGE('%1',ReturnStatus);
        //    IF ReturnStatus THEN BEGIN
        //      ReturnResult := EWBIRN.GetReturnResult;
        //      MESSAGE(ReturnResult);
        //      EwbNo := EWBIRN.GetEwbNo;
        //      EWBBillDate := EWBIRN.GetEwbDate;
        //      EWBValidityDate := EWBIRN.GetEwbValidity;
        //      EWBMgt.InsertEWBDetails(0,"No.",EwbNo,EWBBillDate,EWBValidityDate);
        //      "E-Way Bill No." := EWBIRN.GetEwbNo;
        //      MODIFY;
        //    END;
        //  END;
        END;
    end;
    // procedure GenerateSalesInvoiceTest(var SalesInvHeader: Record "Sales Invoice Header")
    // var
    //     ReqId: Code[20];
    //     EinvError: Label 'Without E-Invoice, no E-way bill to be generated';
    //     Location: Record Location;
    // //EWBAd: DotNet AdequareEWBTest;
    // begin
    //     WITH SalesInvHeader DO BEGIN
    //         if "Acknowledgement No." = '' then
    //             Error(EinvError);
    //         //ReqId := GetRequestId;
    //         //IF "IRN Hash" = ''  THEN BEGIN
    //         SSDEWB.SetSalesInvHeader(SalesInvHeader, EWBType::Sales);
    //         JsonTxt := SSDEWB.ExportJsonTxt;
    //         MESSAGE(JsonTxt);
    //         // EWBAd := EWBAd.GenerateEWB();
    //         // //EXIT;
    //         // EWBAd.r_ID := ReqId;
    //         // TokenTxt := EWBAd.FetchData;
    //         // Location.Reset();
    //         // Location.Get(SalesInvHeader."Location Code");
    //         // EWBAd.InUserId := Location."EInvoice User ID";
    //         // EWBAd.InPassword := Location."EInvoice Password";
    //         // EWBAd.InGSTRegNo := Location."GST Registration No.";
    //         // EWBAd.intoken := TokenTxt;
    //         // EWBAd.Json_txt := JsonTxt;
    //         // ReturnMessage := EWBAd.FetchIRN;
    //         // ReturnStatus := EWBAd.GetReturnStatus;
    //         // MESSAGE(ReturnMessage);
    //         // MESSAGE('%1', ReturnStatus);
    //         // IF ReturnStatus THEN BEGIN
    //         //     ReturnResult := EWBAd.GetReturnResult;
    //         //     MESSAGE(ReturnResult);
    //         //     EwbNo := EWBAd.GetEwbNo;
    //         //     EWBBillDate := EWBAd.GetEwbDate;
    //         //     EWBValidityDate := EWBAd.GetEwbValidity;
    //         //     EWBMgt.InsertEWBDetails(0, "No.", EwbNo, EWBBillDate, EWBValidityDate);
    //         //     "E-Way Bill No." := EWBAd.GetEwbNo;
    //         //     MODIFY;
    //         // END;
    //         //  END ELSE BEGIN
    //         //    SSDEWB.SetSalesInvHeader(SalesInvHeader,EWBType::SalesIRN);
    //         //    JsonTxt := SSDEWB.ExportJsonTxt;
    //         //    MESSAGE(JsonTxt);
    //         //    EWBIRN := EWBIRN.EWBWithIRN;
    //         //    //EXIT;
    //         //    EWBIRN.r_ID := ReqId;
    //         //
    //         //    TokenTxt := EWBIRN.FetchData;
    //         //
    //         //    EWBIRN.intoken := TokenTxt;
    //         //    EWBIRN.InGSTRegNo := '37AMBPG7773M002';
    //         //    EWBIRN.InUserId := 'adqgspapusr1';
    //         //    EWBIRN.InPassword := 'Gsp@1234';
    //         //    EWBIRN.Json_txt := JsonTxt;
    //         //    ReturnMessage := EWBIRN.FetchIRN;
    //         //    ReturnStatus := EWBIRN.GetReturnStatus;
    //         //    MESSAGE(ReturnMessage);
    //         //    MESSAGE('%1',ReturnStatus);
    //         //    IF ReturnStatus THEN BEGIN
    //         //      ReturnResult := EWBIRN.GetReturnResult;
    //         //      MESSAGE(ReturnResult);
    //         //      EwbNo := EWBIRN.GetEwbNo;
    //         //      EWBBillDate := EWBIRN.GetEwbDate;
    //         //      EWBValidityDate := EWBIRN.GetEwbValidity;
    //         //      EWBMgt.InsertEWBDetails(0,"No.",EwbNo,EWBBillDate,EWBValidityDate);
    //         //      "E-Way Bill No." := EWBIRN.GetEwbNo;
    //         //      MODIFY;
    //         //    END;
    //         //  END;
    //     END;
    // end;
    procedure GenerateSalesCrMemo(var SalesCrMemoHeader: Record "Sales Cr.Memo Header")
    var
        ReqId: Code[20];
        EinvError: Label 'Without E-Invoice, no E-way bill to be generated';
        Location: Record Location;
    //EWBAd: DotNet AdequareEWB;
    begin
        WITH SalesCrMemoHeader DO BEGIN
            if "Acknowledgement No." = '' then Error(EinvError);
            //ReqId := GetRequestId;
            SSDEWB.SetSalesCrMemoHeader(SalesCrMemoHeader, EWBType::SalesReturn);
            JsonTxt:=SSDEWB.ExportJsonTxt;
            MESSAGE(JsonTxt);
        // EWBAd := EWBAd.GenerateEWB();
        // EWBAd.r_ID := ReqId;
        // TokenTxt := EWBAd.FetchData;
        // Location.Reset();
        // Location.Get(SalesCrMemoHeader."Location Code");
        // EWBAd.InUserId := Location."EInvoice User ID";
        // EWBAd.InPassword := Location."EInvoice Password";
        // EWBAd.InGSTRegNo := Location."GST Registration No.";
        // EWBAd.intoken := TokenTxt;
        // EWBAd.Json_txt := JsonTxt;
        // ReturnMessage := EWBAd.FetchIRN;
        // ReturnStatus := EWBAd.GetReturnStatus;
        // MESSAGE(ReturnMessage);
        // MESSAGE('%1', ReturnStatus);
        // IF ReturnStatus THEN BEGIN
        //     ReturnResult := EWBAd.GetReturnResult;
        //     MESSAGE(ReturnResult);
        //     EwbNo := EWBAd.GetEwbNo;
        //     EWBBillDate := EWBAd.GetEwbDate;
        //     EWBValidityDate := EWBAd.GetEwbValidity;
        //     EWBMgt.InsertEWBDetails(3, "No.", EwbNo, EWBBillDate, EWBValidityDate);
        //     "E-Way Bill No." := EWBAd.GetEwbNo;
        //     MODIFY;
        // END;
        END;
    end;
    // procedure GenerateSalesCrMemoTest(var SalesCrMemoHeader: Record "Sales Cr.Memo Header")
    // var
    //     ReqId: Code[20];
    //     EinvError: Label 'Without E-Invoice, no E-way bill to be generated';
    //     Location: Record Location;
    // //EWBAd: DotNet AdequareEWBTest;
    // begin
    //     WITH SalesCrMemoHeader DO BEGIN
    //         if "Acknowledgement No." = '' then
    //             Error(EinvError);
    //         //ReqId := GetRequestId;
    //         SSDEWB.SetSalesCrMemoHeader(SalesCrMemoHeader, EWBType::SalesReturn);
    //         JsonTxt := SSDEWB.ExportJsonTxt;
    //         MESSAGE(JsonTxt);
    //         // EWBAd := EWBAd.GenerateEWB();
    //         // EWBAd.r_ID := ReqId;
    //         // TokenTxt := EWBAd.FetchData;
    //         // Location.Reset();
    //         // Location.Get(SalesCrMemoHeader."Location Code");
    //         // EWBAd.InUserId := Location."EInvoice User ID";
    //         // EWBAd.InPassword := Location."EInvoice Password";
    //         // EWBAd.InGSTRegNo := Location."GST Registration No.";
    //         // EWBAd.intoken := TokenTxt;
    //         // EWBAd.Json_txt := JsonTxt;
    //         // ReturnMessage := EWBAd.FetchIRN;
    //         // ReturnStatus := EWBAd.GetReturnStatus;
    //         // MESSAGE(ReturnMessage);
    //         // MESSAGE('%1', ReturnStatus);
    //         // IF ReturnStatus THEN BEGIN
    //         //     ReturnResult := EWBAd.GetReturnResult;
    //         //     MESSAGE(ReturnResult);
    //         //     EwbNo := EWBAd.GetEwbNo;
    //         //     EWBBillDate := EWBAd.GetEwbDate;
    //         //     EWBValidityDate := EWBAd.GetEwbValidity;
    //         //     EWBMgt.InsertEWBDetails(3, "No.", EwbNo, EWBBillDate, EWBValidityDate);
    //         //     "E-Way Bill No." := EWBAd.GetEwbNo;
    //         //     MODIFY;
    //         // END;
    //     END;
    // end;
    procedure GeneratePurchCrMemo(var PurchCrMemoHeader: Record "Purch. Cr. Memo Hdr.")
    var
        ReqId: Code[20];
        Location: Record Location;
    //EWBAd: DotNet AdequareEWB;
    begin
        WITH PurchCrMemoHeader DO BEGIN
            //ReqId := GetRequestId;
            SSDEWB.SetPurchCrMemoHeader(PurchCrMemoHeader, EWBType::Purchase);
            JsonTxt:=SSDEWB.ExportJsonTxt;
            MESSAGE(JsonTxt);
        // EWBAd := EWBAd.GenerateEWB();
        // EWBAd.r_ID := ReqId;
        // TokenTxt := EWBAd.FetchData;
        // Location.Reset();
        // Location.Get(PurchCrMemoHeader."Location Code");
        // EWBAd.InUserId := Location."EInvoice User ID";
        // EWBAd.InPassword := Location."EInvoice Password";
        // EWBAd.InGSTRegNo := Location."GST Registration No.";
        // EWBAd.intoken := TokenTxt;
        // EWBAd.Json_txt := JsonTxt;
        // ReturnMessage := EWBAd.FetchIRN;
        // ReturnStatus := EWBAd.GetReturnStatus;
        // MESSAGE(ReturnMessage);
        // MESSAGE('%1', ReturnStatus);
        // IF ReturnStatus THEN BEGIN
        //     ReturnResult := EWBAd.GetReturnResult;
        //     MESSAGE(ReturnResult);
        //     EwbNo := EWBAd.GetEwbNo;
        //     EWBBillDate := EWBAd.GetEwbDate;
        //     EWBValidityDate := EWBAd.GetEwbValidity;
        //     EWBMgt.InsertEWBDetails(0, "No.", EwbNo, EWBBillDate, EWBValidityDate);
        //     "E-Way Bill No." := EWBAd.GetEwbNo;
        //     MODIFY;
        // END;
        END;
    end;
    procedure GeneratePurchCrMemoTest(var PurchCrMemoHeader: Record "Purch. Cr. Memo Hdr.")
    var
        ReqId: Code[20];
        Location: Record Location;
    //EWBAd: DotNet AdequareEWBTest;
    begin
        WITH PurchCrMemoHeader DO BEGIN
            //ReqId := GetRequestId;
            SSDEWB.SetPurchCrMemoHeader(PurchCrMemoHeader, EWBType::Purchase);
            JsonTxt:=SSDEWB.ExportJsonTxt;
            MESSAGE(JsonTxt);
        // EWBAd := EWBAd.GenerateEWB();
        // EWBAd.r_ID := ReqId;
        // TokenTxt := EWBAd.FetchData;
        // Location.Reset();
        // Location.Get(PurchCrMemoHeader."Location Code");
        // EWBAd.InUserId := Location."EInvoice User ID";
        // EWBAd.InPassword := Location."EInvoice Password";
        // EWBAd.InGSTRegNo := Location."GST Registration No.";
        // EWBAd.intoken := TokenTxt;
        // EWBAd.Json_txt := JsonTxt;
        // ReturnMessage := EWBAd.FetchIRN;
        // ReturnStatus := EWBAd.GetReturnStatus;
        // MESSAGE(ReturnMessage);
        // MESSAGE('%1', ReturnStatus);
        // IF ReturnStatus THEN BEGIN
        //     ReturnResult := EWBAd.GetReturnResult;
        //     MESSAGE(ReturnResult);
        //     EwbNo := EWBAd.GetEwbNo;
        //     EWBBillDate := EWBAd.GetEwbDate;
        //     EWBValidityDate := EWBAd.GetEwbValidity;
        //     EWBMgt.InsertEWBDetails(0, "No.", EwbNo, EWBBillDate, EWBValidityDate);
        //     "E-Way Bill No." := EWBAd.GetEwbNo;
        //     MODIFY;
        // END;
        END;
    end;
    procedure GenerateTransferInvoice(var TransShipHeader: Record "Transfer Shipment Header")
    var
        ReqId: Code[20];
        Location: Record Location;
    //EWBAd: DotNet AdequareEWB;
    begin
        WITH TransShipHeader DO BEGIN
            //ReqId := GetRequestId;
            SSDEWB.SetTransShipHeader(TransShipHeader, EWBType::Transfer);
            JsonTxt:=SSDEWB.ExportJsonTxt;
            MESSAGE(JsonTxt);
        // EWBAd := EWBAd.GenerateEWB();
        // EWBAd.r_ID := ReqId;
        // TokenTxt := EWBAd.FetchData;
        // Location.Reset();
        // Location.Get(TransShipHeader."Transfer-from Code");
        // EWBAd.InUserId := Location."EInvoice User ID";
        // EWBAd.InPassword := Location."EInvoice Password";
        // EWBAd.InGSTRegNo := Location."GST Registration No.";
        // EWBAd.intoken := TokenTxt;
        // EWBAd.Json_txt := JsonTxt;
        // ReturnMessage := EWBAd.FetchIRN;
        // ReturnStatus := EWBAd.GetReturnStatus;
        // MESSAGE(ReturnMessage);
        // //MESSAGE('%1',ReturnStatus);
        // IF ReturnStatus THEN BEGIN
        //     ReturnResult := EWBAd.GetReturnResult;
        //     MESSAGE(ReturnResult);
        //     EwbNo := EWBAd.GetEwbNo;
        //     EWBBillDate := EWBAd.GetEwbDate;
        //     EWBValidityDate := EWBAd.GetEwbValidity;
        //     EWBMgt.InsertEWBDetails(2, "No.", EwbNo, EWBBillDate, EWBValidityDate);
        //     "E-Way Bill No." := EWBAd.GetEwbNo;
        //     MODIFY;
        // END;
        END;
    end;
// procedure GenerateTransferInvoiceTest(var TransShipHeader: Record "Transfer Shipment Header")
// var
//     ReqId: Code[20];
//     Location: Record Location;
// //EWBAd: DotNet AdequareEWBTest;
// begin
//     WITH TransShipHeader DO BEGIN
//         //ReqId := GetRequestId;
//         SSDEWB.SetTransShipHeader(TransShipHeader, EWBType::Transfer);
//         JsonTxt := SSDEWB.ExportJsonTxt;
//         MESSAGE(JsonTxt);
//         // EWBAd := EWBAd.GenerateEWB();
//         // EWBAd.r_ID := ReqId;
//         // TokenTxt := EWBAd.FetchData;
//         // Location.Reset();
//         // Location.Get(TransShipHeader."Transfer-from Code");
//         // EWBAd.InUserId := Location."EInvoice User ID";
//         // EWBAd.InPassword := Location."EInvoice Password";
//         // EWBAd.InGSTRegNo := Location."GST Registration No.";
//         // EWBAd.intoken := TokenTxt;
//         // EWBAd.Json_txt := JsonTxt;
//         // ReturnMessage := EWBAd.FetchIRN;
//         // ReturnStatus := EWBAd.GetReturnStatus;
//         // MESSAGE(ReturnMessage);
//         // //MESSAGE('%1',ReturnStatus);
//         // IF ReturnStatus THEN BEGIN
//         //     ReturnResult := EWBAd.GetReturnResult;
//         //     MESSAGE(ReturnResult);
//         //     EwbNo := EWBAd.GetEwbNo;
//         //     EWBBillDate := EWBAd.GetEwbDate;
//         //     EWBValidityDate := EWBAd.GetEwbValidity;
//         //     EWBMgt.InsertEWBDetails(2, "No.", EwbNo, EWBBillDate, EWBValidityDate);
//         //     "E-Way Bill No." := EWBAd.GetEwbNo;
//         //     MODIFY;
//         // END;
//     END;
// end;
// procedure CancelEWB(EWBDetails: Record "EWB Details")
// var
//     ReqId: Code[20];
//     SalesInvHeader: Record "Sales Invoice Header";
//     PurchCrMemoHdr: Record "Purch. Cr. Memo Hdr.";
//     TransShipHeader: Record "Transfer Shipment Header";
//     //EWBCancel: DotNet AdequareCancelEWB;
//     Location: Record Location;
// begin
//     CLEARALL;
//     WITH EWBDetails DO BEGIN
//         //ReqId := GetRequestId;
//         JsonTxt := SSDEWB.ExportCancellationJsonTxt(EWBDetails);
//         // EWBCancel := EWBCancel.CancelEWB;
//         // EWBCancel.r_ID := ReqId;
//         // TokenTxt := EWBCancel.FetchData;
//         /*
//         Location.Reset();
//         Location.Get(EWBDetails.lo)
//         EWBCancel.InGSTRegNo := '05AAACG2314E1ZD';
//         EWBCancel.InUserId := '05AAACG2314E1ZD';
//         EWBCancel.InPassword := 'abc123@@';
//         */
//         // EWBCancel.intoken := TokenTxt;
//         // EWBCancel.Json_txt := JsonTxt;
//         // ReturnMessage := EWBCancel.FetchIRN;
//         // ReturnStatus := EWBCancel.GetReturnStatus;
//         IF ReturnStatus THEN BEGIN
//             //ReturnResult := EWBCancel.GetReturnResult;
//             MESSAGE(ReturnResult);
//             //"Portal Cancellation Date" := EWBCancel.GetEwbCancellationDate;
//             "Cancellation By" := USERID;
//             "Cancellation DateTime" := CURRENTDATETIME;
//             Active := FALSE;
//             MODIFY;
//             CASE "Document Type" OF
//                 "Document Type"::Sales:
//                     BEGIN
//                         SalesInvHeader.GET("Document No.");
//                         SalesInvHeader."E-Way Bill No." := '';
//                         SalesInvHeader.MODIFY;
//                     END;
//                 "Document Type"::Purchase:
//                     BEGIN
//                         PurchCrMemoHdr.GET("Document No.");
//                         PurchCrMemoHdr."E-Way Bill No." := '';
//                         PurchCrMemoHdr.MODIFY;
//                     END;
//                 "Document Type"::Transfer:
//                     BEGIN
//                         TransShipHeader.GET("Document No.");
//                         TransShipHeader."E-Way Bill No." := '';
//                         TransShipHeader.MODIFY;
//                     END;
//             END;
//         END;
//     END;
// end;
// procedure CancelEWBTest(EWBDetails: Record "EWB Details")
// var
//     ReqId: Code[20];
//     SalesInvHeader: Record "Sales Invoice Header";
//     PurchCrMemoHdr: Record "Purch. Cr. Memo Hdr.";
//     TransShipHeader: Record "Transfer Shipment Header";
//     //EWBCancel: DotNet AdequareCancelEWBTest;
//     Location: Record Location;
// begin
//     CLEARALL;
//     WITH EWBDetails DO BEGIN
//         //ReqId := GetRequestId;
//         JsonTxt := SSDEWB.ExportCancellationJsonTxt(EWBDetails);
//         // EWBCancel := EWBCancel.CancelEWB;
//         // EWBCancel.r_ID := ReqId;
//         // TokenTxt := EWBCancel.FetchData;
//         /*
//         Location.Reset();
//         Location.Get(EWBDetails.lo)
//         EWBCancel.InGSTRegNo := '05AAACG2314E1ZD';
//         EWBCancel.InUserId := '05AAACG2314E1ZD';
//         EWBCancel.InPassword := 'abc123@@';
//         */
//         // EWBCancel.intoken := TokenTxt;
//         // EWBCancel.Json_txt := JsonTxt;
//         // ReturnMessage := EWBCancel.FetchIRN;
//         // ReturnStatus := EWBCancel.GetReturnStatus;
//         IF ReturnStatus THEN BEGIN
//             //ReturnResult := EWBCancel.GetReturnResult;
//             MESSAGE(ReturnResult);
//             //"Portal Cancellation Date" := EWBCancel.GetEwbCancellationDate;
//             "Cancellation By" := USERID;
//             "Cancellation DateTime" := CURRENTDATETIME;
//             Active := FALSE;
//             MODIFY;
//             CASE "Document Type" OF
//                 "Document Type"::Sales:
//                     BEGIN
//                         SalesInvHeader.GET("Document No.");
//                         SalesInvHeader."E-Way Bill No." := '';
//                         SalesInvHeader.MODIFY;
//                     END;
//                 "Document Type"::Purchase:
//                     BEGIN
//                         PurchCrMemoHdr.GET("Document No.");
//                         PurchCrMemoHdr."E-Way Bill No." := '';
//                         PurchCrMemoHdr.MODIFY;
//                     END;
//                 "Document Type"::Transfer:
//                     BEGIN
//                         TransShipHeader.GET("Document No.");
//                         TransShipHeader."E-Way Bill No." := '';
//                         TransShipHeader.MODIFY;
//                     END;
//             END;
//         END;
//     END;
// end;
// local procedure GetRequestId() RequestId: code[20]
// var
//     PreFix: Label 'SSDT';
//     GLSetup: Record "General Ledger Setup";
// begin
//     GLSetup.GET;
//     IF NOT GLSetup."Test Instance" THEN begin
//         IF GLSetup."Unique Request No." = '' THEN
//             GLSetup."Unique Request No." := 'SSD' + CopyStr(CompanyName, 1, 1) + '3900001'
//         ELSE
//             GLSetup."Unique Request No." := INCSTR(GLSetup."Unique Request No.");
//         GLSetup.MODIFY;
//         RequestId := GLSetup."Unique Request No.";
//     end else begin
//         IF (PreFix <> CopyStr(GLSetup."Unique Request No.", 1, 4)) then
//             GLSetup."Unique Request No." := '';
//         IF GLSetup."Unique Request No." = '' THEN
//             GLSetup."Unique Request No." := PreFix + CopyStr(CompanyName, 1, 1) + '3900001'
//         ELSE
//             GLSetup."Unique Request No." := INCSTR(GLSetup."Unique Request No.");
//         GLSetup.MODIFY;
//         RequestId := GLSetup."Unique Request No.";
//     end;
//     COMMIT;
// end;
}
