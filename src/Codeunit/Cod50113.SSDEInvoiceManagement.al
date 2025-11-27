codeunit 50113 "SSD EInvoice Management"
{
    Permissions = tabledata "Sales Invoice Header"=m,
        tabledata "Sales Cr.Memo Header"=m;

    var SalesSetup: Record "Sales & Receivables Setup";
    GLSetup: Record "General Ledger Setup";
    JsonTxt: Text;
    salesInv: page "Sales Order";
    einv: Codeunit "e-Invoice Json Handler";
    procedure GenerateSalesInvoice(var SalesInvoiceHeader: record "Sales Invoice Header")
    var
        Location: Record Location;
        EInvoicingRequests: Record "SSD E-Invoicing Requests";
        EInvoicingRequests2: Record "SSD E-Invoicing Requests";
        EInvoicingRequests3: Record "SSD E-Invoicing Requests";
        TempBlob: Codeunit "Temp Blob";
        QRGenerator: Codeunit "QR Generator";
        SSDEinv: Codeunit "SSD Generate Einvoice";
        GSPManagment: Codeunit "SSD GSP Management";
        TokenTxt: Text;
        ReturnMessage: Text;
        ReturnStatus: Boolean;
        ReturnResult: Text;
        QRTxt: Text;
        OutStream: OutStream;
        RecRef: RecordRef;
        FieldRef: FieldRef;
        EwbNo: Code[20];
        EWBApplicable: Boolean;
        ErrorMessage: Text;
        InfoDetails: Text;
        ReturnMessage2: Label 'Invoice successfully gerenarted for Invoice No. %1';
    //EInv_EWBMgt: Codeunit "Einvoice-EWB Management";
    begin
        //ReqId := GetRequestId();
        EWBApplicable:=IsEWBInfoAvailable(SalesInvoiceHeader);
        SSDEinv.SetSalesInvHeader(SalesInvoiceHeader, EWBApplicable);
        JsonTxt:=SSDEinv.ExportJsonTxt();
        Message(JsonTxt);
        //SSD Uncomment
        Clear(GSPManagment);
        GSPManagment.GenerateEInvoice(JsonTxt, EWBApplicable);
        ReturnStatus:=GSPManagment.GetEInvoiceReturnStatus();
        if ReturnStatus then begin
            EInvoicingRequests2.SetCurrentkey("Document Type", "Document No.", "E-Invoice Generated");
            EInvoicingRequests2.SetRange("Document Type", EInvoicingRequests2."Document Type"::"Sale Invoice");
            EInvoicingRequests2.SetRange("Document No.", SalesInvoiceHeader."No.");
            if EInvoicingRequests2.FindFirst then begin
                EInvoicingRequests2."Acknowledgement No.":=GSPManagment.GetAckNo();
                EInvoicingRequests2."Acknowledgement Date":=GSPManagment.GetAckDate();
                EInvoicingRequests2."IRN No.":=GSPManagment.GetIRN();
                QRTxt:=GSPManagment.GetQRCode();
                if StrLen(QRTxt) > 250 then begin
                    EInvoicingRequests2."Signed QR Code":=CopyStr(QRTxt, 1, 250);
                    EInvoicingRequests2."Signed QR Code2":=CopyStr(QRTxt, 251, 250);
                    EInvoicingRequests2."Signed QR Code3":=CopyStr(QRTxt, 501, 250);
                    EInvoicingRequests2."Signed QR Code4":=CopyStr(QRTxt, 751, 250);
                end
                else
                    EInvoicingRequests2."Signed QR Code":=(QRTxt);
                ErrorMessage:=GSPManagment.GetErrorMesage();
                if StrLen(ErrorMessage) > 250 then begin
                    EInvoicingRequests2."Error Message":=CopyStr(ErrorMessage, 1, 250);
                    EInvoicingRequests2."Error Message2":=CopyStr(ErrorMessage, 251, 250);
                    EInvoicingRequests2."Error Message3":=CopyStr(ErrorMessage, 501, 250);
                end
                else
                    EInvoicingRequests2."Error Message":=ErrorMessage;
                EInvoicingRequests2.Status:=format(ReturnStatus);
                EInvoicingRequests2."Request ID":=GSPManagment.GetReqId();
                EInvoicingRequests2."Request Date":=WorkDate;
                EInvoicingRequests2."Request Time":=Time;
                EInvoicingRequests2."User Id":=UserId;
                EInvoicingRequests2."QR Code URL":=GSPManagment.GetQRURL(); //Alle 01032021
                EInvoicingRequests2."E Invoice PDF URL":=GSPManagment.GetInvURL(); //Alle 01032021
                InfoDetails:=GSPManagment.GetInfoDtls();
                if StrLen(InfoDetails) > 250 then begin
                    EInvoicingRequests2."Info Details":=CopyStr(InfoDetails, 1, 250);
                    EInvoicingRequests2."Info Details2":=CopyStr(InfoDetails, 251, 250);
                end
                else
                    EInvoicingRequests2."Info Details":=InfoDetails;
                if EInvoicingRequests2."IRN No." <> '' then begin
                    if GuiAllowed then begin // To avoid error while Background Posting
                        QRGenerator.GenerateQRCodeImage(QRTxt, TempBlob);
                        RecRef.GetTable(EInvoicingRequests3);
                        FieldRef:=RecRef.Field(EInvoicingRequests3.FieldNo("QR Image"));
                        TempBlob.ToRecordRef(RecRef, EInvoicingRequests3.FieldNo("QR Image"));
                        if not EInvoicingRequests3."QR Image".HasValue then error('stop');
                        EInvoicingRequests2."QR Image":=EInvoicingRequests3."QR Image";
                    end;
                    EInvoicingRequests2."E-Invoice Generated":=true;
                end;
                EInvoicingRequests2.Modify;
                Message(ReturnMessage2, SalesInvoiceHeader."No.");
            end
            else
            begin
                EInvoicingRequests."Entry No.":=CreateGuid;
                EInvoicingRequests."Document Type":=EInvoicingRequests."Document Type"::"Sale Invoice";
                EInvoicingRequests."Document No.":=SalesInvoiceHeader."No.";
                EInvoicingRequests."Document Date":=SalesInvoiceHeader."Posting Date";
                EInvoicingRequests."Acknowledgement No.":=GSPManagment.GetAckNo();
                EInvoicingRequests."Acknowledgement Date":=GSPManagment.GetAckDate();
                EInvoicingRequests."IRN No.":=GSPManagment.GetIRN();
                QRTxt:=GSPManagment.GetQRCode();
                if StrLen(QRTxt) > 250 then begin
                    EInvoicingRequests."Signed QR Code":=CopyStr(QRTxt, 1, 250);
                    EInvoicingRequests."Signed QR Code2":=CopyStr(QRTxt, 251, 250);
                    EInvoicingRequests."Signed QR Code3":=CopyStr(QRTxt, 501, 250);
                    EInvoicingRequests."Signed QR Code4":=CopyStr(QRTxt, 751, 250);
                end
                else
                    EInvoicingRequests."Signed QR Code":=(QRTxt);
                ErrorMessage:=GSPManagment.GetErrorMesage();
                if StrLen(ErrorMessage) > 250 then begin
                    EInvoicingRequests."Error Message":=CopyStr(ErrorMessage, 1, 250);
                    EInvoicingRequests."Error Message2":=CopyStr(ErrorMessage, 251, 250);
                    EInvoicingRequests."Error Message3":=CopyStr(ErrorMessage, 501, 250);
                end
                else
                    EInvoicingRequests."Error Message":=ErrorMessage;
                EInvoicingRequests.Status:=format(ReturnStatus);
                EInvoicingRequests."Request ID":=GSPManagment.GetReqId();
                EInvoicingRequests."Request Date":=WorkDate;
                EInvoicingRequests."Request Time":=Time;
                EInvoicingRequests."User Id":=UserId;
                EInvoicingRequests."QR Code URL":=GSPManagment.GetQRURL();
                EInvoicingRequests."E Invoice PDF URL":=GSPManagment.GetInvURL();
                if StrLen(InfoDetails) > 250 then begin
                    EInvoicingRequests."Info Details":=CopyStr(InfoDetails, 1, 250);
                    EInvoicingRequests."Info Details2":=CopyStr(InfoDetails, 251, 250);
                end
                else
                    EInvoicingRequests."Info Details":=InfoDetails;
                EInvoicingRequests."E-Invoice Generated":=true;
                EInvoicingRequests.Insert;
                if QRTxt <> '' then begin
                    RecRef.GetTable(SalesInvoiceHeader);
                    QRGenerator.GenerateQRCodeImage(QRTxt, TempBlob);
                    FieldRef:=RecRef.Field(SalesInvoiceHeader.FieldNo("QR Code"));
                    TempBlob.ToRecordRef(RecRef, SalesInvoiceHeader.FieldNo("QR Code"));
                    RecRef.Modify();
                end;
                Commit();
                if EInvoicingRequests."IRN No." <> '' then begin
                    Clear(TempBlob);
                    Clear(RecRef);
                    Clear(FieldRef);
                    RecRef.GetTable(EInvoicingRequests);
                    QRGenerator.GenerateQRCodeImage(QRTxt, TempBlob);
                    FieldRef:=RecRef.Field(EInvoicingRequests.FieldNo("QR Image"));
                    TempBlob.ToRecordRef(RecRef, EInvoicingRequests.FieldNo("QR Image"));
                    RecRef.Modify();
                end;
                Message(ReturnMessage2, SalesInvoiceHeader."No.");
            end;
        end
        else
            Error(GSPManagment.GetErrorMesage());
    end;
    procedure GenerateSalesInvoiceEWB(var SalesInvoiceHeader: record "Sales Invoice Header")
    var
        Location: Record Location;
        QRGenerator: Codeunit "QR Generator";
        SSDEinv: Codeunit "SSD Generate EWB";
        GSPManagment: Codeunit "SSD GSP Management";
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
    begin
        SSDEinv.SetSalesInvHeader(SalesInvoiceHeader, 0);
        JsonTxt:=SSDEinv.ExportJsonTxt();
        Message(JsonTxt);
        Clear(GSPManagment);
        GSPManagment.GenerateEWB(JsonTxt);
        ReturnStatus:=GSPManagment.GetEWBReturnStatus();
        if ReturnStatus then begin
            RecRef.GetTable(SalesInvoiceHeader);
            EwbNo:=copystr(GSPManagment.GetEwbNo(), 1, 20);
            if EwbNo <> '' then begin
                FieldRef:=RecRef.Field(SalesInvoiceHeader.FieldNo("E-Way Bill No."));
                FieldRef.Value:=EwbNo;
                FieldRef:=RecRef.Field(SalesInvoiceHeader.FieldNo("E-Way Bill Validity"));
                FieldRef.Value:=GSPManagment.GetEwbValidity();
                FieldRef:=RecRef.Field(SalesInvoiceHeader.FieldNo("E-Way Generated"));
                FieldRef.Value:=true;
                FieldRef:=RecRef.Field(SalesInvoiceHeader.FieldNo("E-Way Canceled"));
                FieldRef.Value:=false;
            end;
            RecRef.Modify();
            ReturnResult:=GSPManagment.GetEInvoiceReturnMessage();
            MESSAGE(ReturnResult);
        end;
    end;
    procedure GenerateSalesCrMemoEWB(var SalesCrMemoHeader: record "Sales Cr.Memo Header")
    var
        Location: Record Location;
        QRGenerator: Codeunit "QR Generator";
        SSDEinv: Codeunit "SSD Generate EWB";
        GSPManagment: Codeunit "SSD GSP Management";
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
    begin
        //ReqId := GetRequestId();
        // EWBApplicable := IsEWBInfoAvailable(SalesInvoiceHeader);
        SSDEinv.SetSalesCrMemoHeader(SalesCrMemoHeader, 3);
        JsonTxt:=SSDEinv.ExportJsonTxt();
        Message(JsonTxt);
        Location.Get(SalesCrMemoHeader."Location Code");
    //SSD Uncomment
    // Clear(GSPManagment);
    // GSPManagment.GenerateEWB(Location."GSTIN Login id", Location."GSTIN Login Pass", copystr(Location."GST Registration No.", 1, 15), JsonTxt);
    // ReturnStatus := GSPManagment.GetEInvoiceReturnStatus();
    // if ReturnStatus then begin
    //     RecRef.GetTable(SalesCrMemoHeader);
    //     FieldRef := RecRef.Field(SalesCrMemoHeader.FieldNo(IsJSONImported));
    //     FieldRef.Value := true;
    //     EwbNo := copystr(GSPManagment.GetEwbNo(), 1, 20);
    //     if EwbNo <> '' then begin
    //         FieldRef := RecRef.Field(SalesCrMemoHeader.FieldNo("E-Way Bill No."));
    //         FieldRef.Value := EwbNo;
    //         //EInv_EWBMgt.InsertEInvoiceDetails(0, SalesInvoiceHeader."No.");
    //     end;
    //     RecRef.Modify();
    //     ReturnResult := GSPManagment.GetEInvoiceReturnMessage();
    //     MESSAGE(ReturnResult);
    // end;
    end;
    procedure GenerateTransShipEWB(var TransshipmentHeader: record "Transfer Shipment Header")
    var
        Location: Record Location;
        QRGenerator: Codeunit "QR Generator";
        SSDEinv: Codeunit "SSD Generate EWB";
        GSPManagment: Codeunit "SSD GSP Management";
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
    begin
        //ReqId := GetRequestId();
        // EWBApplicable := IsEWBInfoAvailable(SalesInvoiceHeader);
        SSDEinv.SetTransShipHeader(TransshipmentHeader, 2);
        JsonTxt:=SSDEinv.ExportJsonTxt();
        Message(JsonTxt);
    //SSD Uncomment
    // Location.Get(TransshipmentHeader."Transfer-from Code");
    // Clear(GSPManagment);
    // GSPManagment.GenerateEWB(Location."GSTIN Login id", Location."GSTIN Login Pass", copystr(Location."GST Registration No.", 1, 15), JsonTxt);
    // ReturnStatus := GSPManagment.GetEInvoiceReturnStatus();
    // if ReturnStatus then begin
    //     RecRef.GetTable(TransshipmentHeader);
    //     //FieldRef := RecRef.Field(SalesInvoiceHeader.FieldNo("Acknowledgement Date"));
    //     //FieldRef.Value := GSPManagment.GetAckDate() - ((1000 * 60) * 330);
    //     FieldRef := RecRef.Field(TransshipmentHeader.FieldNo(IsJSONImported));
    //     FieldRef.Value := true;
    //     EwbNo := copystr(GSPManagment.GetEwbNo(), 1, 20);
    //     if EwbNo <> '' then begin
    //         FieldRef := RecRef.Field(TransshipmentHeader.FieldNo("E-Way Bill No."));
    //         FieldRef.Value := EwbNo;
    //         //EInv_EWBMgt.InsertEInvoiceDetails(0, SalesInvoiceHeader."No.");
    //     end;
    //     RecRef.Modify();
    //     ReturnResult := GSPManagment.GetEInvoiceReturnMessage();
    //     MESSAGE(ReturnResult);
    // end;
    end;
    procedure GetIRNbyDocDetails(var SalesInvoiceHeader: record "Sales Invoice Header")
    var
        Location: Record Location;
        QRGenerator: Codeunit "QR Generator";
        SSDEinv: Codeunit "SSD Generate Einvoice";
        DocType: Code[10];
        DocDate: Text[30];
        GSPManagment: Codeunit "SSD GSP Management";
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
    begin
        //ReqId := GetRequestId();
        Location.Get(SalesInvoiceHeader."Location Code");
        DocType:=GetDocType(Database::"Sales Invoice Header", SalesInvoiceHeader."No.");
        DocDate:=FORMAT(SalesInvoiceHeader."Posting Date", 0, '<Day,2>/<Month,2>/<Year4>');
    //SSD Uncomment
    // Clear(GSPManagment);
    // GSPManagment.GetEInvoiceDetails(Location."GSTIN Login id", Location."GSTIN Login Pass", copystr(Location."GST Registration No.", 1, 15), DocType, SalesInvoiceHeader."No.", DocDate);
    // ReturnStatus := GSPManagment.GetEInvoiceReturnStatus();
    // if ReturnStatus then begin
    //     RecRef.GetTable(SalesInvoiceHeader);
    //     FieldRef := RecRef.Field(SalesInvoiceHeader.FieldNo("Acknowledgement No."));
    //     FieldRef.Value := GSPManagment.GetAckNo();
    //     FieldRef := RecRef.Field(SalesInvoiceHeader.FieldNo("Acknowledgement Date"));
    //     FieldRef.Value := GSPManagment.GetAckDate();
    //     FieldRef := RecRef.Field(SalesInvoiceHeader.FieldNo("IRN Hash"));
    //     FieldRef.Value := GSPManagment.GetIRN();
    //     FieldRef := RecRef.Field(SalesInvoiceHeader.FieldNo(IsJSONImported));
    //     FieldRef.Value := true;
    //     QRTxt := GSPManagment.GetQRCode();
    //     if QRTxt <> '' then begin
    //         QRGenerator.GenerateQRCodeImage(QRTxt, TempBlob);
    //         FieldRef := RecRef.Field(SalesInvoiceHeader.FieldNo("QR Code"));
    //         TempBlob.ToRecordRef(RecRef, SalesInvoiceHeader.FieldNo("QR Code"));
    //     end;
    //     EwbNo := copystr(GSPManagment.GetEwbNo(), 1, 20);
    //     if EwbNo <> '' then begin
    //         FieldRef := RecRef.Field(SalesInvoiceHeader.FieldNo("E-Way Bill No."));
    //         FieldRef.Value := EwbNo;
    //         //EInv_EWBMgt.InsertEInvoiceDetails(0, SalesInvoiceHeader."No.");
    //     end;
    //     RecRef.Modify();
    //     ReturnResult := GSPManagment.GetEInvoiceReturnMessage();
    //     MESSAGE(ReturnResult);
    // end;
    end;
    local procedure GetDocType(TableId: Integer; DocNo: Code[20]): Text[3]var
        SalesInvoiceHeader: Record "Sales Invoice Header";
    begin
        if TableId = Database::"Sales Invoice Header" then begin
            SalesInvoiceHeader.Get(DocNo);
            if(SalesInvoiceHeader."Invoice Type" = SalesInvoiceHeader."Invoice Type"::"Debit Note") or (SalesInvoiceHeader."Invoice Type" = SalesInvoiceHeader."Invoice Type"::Supplementary)then exit('DBN')
            else
                exit('INV');
        end;
        exit('CRN');
    end;
    // procedure GenerateSalesInvoiceTest(var SalesInvoiceHeader: record "Sales Invoice Header")
    // var
    //     QRGenerator: Codeunit "QR Generator";
    //     ReqId: Code[20];
    //     SSDEinv: Codeunit "SSD Generate Einvoice";
    //     //EinvAd: DotNet AdequareTest;
    //     TokenTxt: Text;
    //     ReturnMessage: Text;
    //     ReturnStatus: Boolean;
    //     ReturnResult: Text;
    //     QRTxt: Text;
    //     OutStream: OutStream;
    //     TempBlob: Codeunit "Temp Blob";
    //     RecRef: RecordRef;
    //     FieldRef: FieldRef;
    //     EwbNo: Code[20];
    //     EWBApplicable: Boolean;
    //     //EInv_EWBMgt: Codeunit "Einvoice-EWB Management";
    //     Location: Record Location;
    // begin
    //     //ReqId := GetRequestId();
    //     EWBApplicable := IsEWBInfoAvailable(SalesInvoiceHeader);
    //     SSDEinv.SetSalesInvHeader(SalesInvoiceHeader, EWBApplicable);
    //     JsonTxt := SSDEinv.ExportJsonTxt();
    //     Message(JsonTxt);
    //     if not Confirm('Do you want to continue?', false) then
    //         exit;
    //     // SSD 29-03-23
    // EinvAd := EinvAd.GenerateIRNEWB();
    // EinvAd.r_ID := ReqId;
    // TokenTxt := EinvAd.FetchData;
    // Location.Reset();
    // Location.Get(SalesInvoiceHeader."Location Code");
    // EinvAd.InUserId := Location."EInvoice User ID";
    // EinvAd.InPassword := Location."EInvoice Password";
    // EinvAd.InGSTRegNo := Location."GST Registration No.";
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
    //     EwbNo := EinvAd.GetEwbNo;
    //     if EwbNo <> '' then begin
    //         FieldRef := RecRef.Field(SalesInvoiceHeader.FieldNo("E-Way Bill No."));
    //         FieldRef.Value := EinvAd.GetEwbNo;
    //         EInv_EWBMgt.InsertEInvoiceDetails(0, SalesInvoiceHeader."No.");
    //     end;
    //     RecRef.Modify();
    // END;
    // SSD
    //end;
    procedure GenerateSalesCrMemo(var SalesCrMemoHeader: Record "Sales Cr.Memo Header")
    var
        QRGenerator: Codeunit "QR Generator";
        ReqId: Code[20];
        //QRGenerator: Codeunit "QR Generator";
        SSDEinv: Codeunit "SSD Generate Einvoice";
        GSPManagment: Codeunit "SSD GSP Management";
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
        //ReqId := GetRequestId();
        EWBApplicable:=IsEWBCreMemoAvailable(SalesCrMemoHeader);
        SSDEinv.SetCrMemoHeader(SalesCrMemoHeader, EWBApplicable);
        JsonTxt:=SSDEinv.ExportJsonTxt();
        Message(JsonTxt);
    //SSD Uncomment
    // Location.Get(SalesCrMemoHeader."Location Code");
    // GSPManagment.GenerateEInvoice(Location."GSTIN Login id", Location."GSTIN Login Pass", copystr(Location."GST Registration No.", 1, 15), JsonTxt, EWBApplicable);
    // ReturnStatus := GSPManagment.GetEInvoiceReturnStatus();
    // if ReturnStatus then begin
    //     RecRef.GetTable(SalesCrMemoHeader);
    //     FieldRef := RecRef.Field(SalesCrMemoHeader.FieldNo("Acknowledgement No."));
    //     FieldRef.Value := GSPManagment.GetAckNo();
    //     FieldRef := RecRef.Field(SalesCrMemoHeader.FieldNo("Acknowledgement Date"));
    //     FieldRef.Value := GSPManagment.GetAckDate();
    //     FieldRef := RecRef.Field(SalesCrMemoHeader.FieldNo("IRN Hash"));
    //     FieldRef.Value := GSPManagment.GetIRN();
    //     FieldRef := RecRef.Field(SalesCrMemoHeader.FieldNo(IsJSONImported));
    //     FieldRef.Value := true;
    //     QRTxt := GSPManagment.GetQRCode();
    //     if QRTxt <> '' then begin
    //         QRGenerator.GenerateQRCodeImage(QRTxt, TempBlob);
    //         FieldRef := RecRef.Field(SalesCrMemoHeader.FieldNo("QR Code"));
    //         TempBlob.ToRecordRef(RecRef, SalesCrMemoHeader.FieldNo("QR Code"));
    //     end;
    //     EwbNo := copystr(GSPManagment.GetEwbNo(), 1, 20);
    //     if EwbNo <> '' then begin
    //         FieldRef := RecRef.Field(SalesCrMemoHeader.FieldNo("E-Way Bill No."));
    //         FieldRef.Value := EwbNo;
    //         //EInv_EWBMgt.InsertEInvoiceDetails(0, SalesInvoiceHeader."No.");
    //     end;
    //     RecRef.Modify();
    //     ReturnResult := GSPManagment.GetEInvoiceReturnMessage();
    //     MESSAGE(ReturnResult);
    // end;
    //SSD Uncomment
    // // SSD-29-03-23
    // EinvAd := EinvAd.GenerateIRNEWB();
    // EinvAd.r_ID := ReqId;
    // TokenTxt := EinvAd.FetchData;
    // Location.Reset();
    // Location.Get(SalesCrMemoHeader."Location Code");
    // EinvAd.InUserId := Location."EInvoice User ID";
    // EinvAd.InPassword := Location."EInvoice Password";
    // EinvAd.InGSTRegNo := Location."GST Registration No.";
    // EinvAd.intoken := TokenTxt;
    // EinvAd.Json_txt := JsonTxt;
    // ReturnMessage := EinvAd.FetchIRN;
    // MESSAGE(ReturnMessage);
    // ReturnStatus := EinvAd.GetReturnStatus;
    // IF ReturnStatus THEN BEGIN
    //     RecRef.GetTable(SalesCrMemoHeader);
    //     FieldRef := RecRef.Field(SalesCrMemoHeader.FieldNo("Acknowledgement No."));
    //     FieldRef.Value := EinvAd.GetAckNo;
    //     FieldRef := RecRef.Field(SalesCrMemoHeader.FieldNo("Acknowledgement Date"));
    //     FieldRef.Value := EinvAd.GetAckDate - ((1000 * 60) * 330);
    //     FieldRef := RecRef.Field(SalesCrMemoHeader.FieldNo("IRN Hash"));
    //     FieldRef.Value := EinvAd.GetIRN;
    //     FieldRef := RecRef.Field(SalesCrMemoHeader.FieldNo(IsJSONImported));
    //     FieldRef.Value := true;
    //     QRTxt := EinvAd.GetSignedQRCode;
    //     if QRTxt <> '' then begin
    //         QRGenerator.GenerateQRCodeImage(QRTxt, TempBlob);
    //         FieldRef := RecRef.Field(SalesCrMemoHeader.FieldNo("QR Code"));
    //         TempBlob.ToRecordRef(RecRef, SalesCrMemoHeader.FieldNo("QR Code"));
    //     end;
    //     //ReturnResult := EinvAd.GetReturnResult;
    //     //MESSAGE(ReturnResult);
    //     RecRef.Modify();
    //     ReturnResult := EinvAd.GetReturnResult;
    //     MESSAGE(ReturnResult);
    //     // SalesCrMemoHeader.Modify();//Sourabh 130122
    // END;
    // SSD
    end;
    procedure GenerateTransferShipment(VAR TransferShipmentHeader: Record "Transfer Shipment Header")
    var
        // QRGenerator: Codeunit "QR Generator";
        // ReqId: Code[20];
        // SSDEinv: Codeunit SSDEinvPrepareEinvoice;
        // //EinvAd: DotNet Adequare;
        // TokenTxt: Text;
        // ReturnMessage: Text;
        // ReturnStatus: Boolean;
        // ReturnResult: Text;
        // QRTxt: Text;
        // OutStream: OutStream;
        // TempBlob: Codeunit "Temp Blob";
        // RecRef: RecordRef;
        // EwbNo: Code[20];
        // EWBApplicable: Boolean;
        // EWBValidityDate: Text;
        // EInv_EWBMgt: Codeunit "Einvoice-EWB Management";
        // FieldRef: FieldRef;
        // Location: Record Location;
        QRGenerator: Codeunit "QR Generator";
        ReqId: Code[20];
        //QRGenerator: Codeunit "QR Generator";
        SSDEinv: Codeunit "SSD Generate Einvoice";
        GSPManagment: Codeunit "SSD GSP Management";
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
        EWBApplicable:=IsEWBTrnShipAvailable(TransferShipmentHeader);
        SSDEinv.SetTranShipmentHeader(TransferShipmentHeader, EWBApplicable);
        JsonTxt:=SSDEinv.ExportTransferJsonTxt(TransferShipmentHeader, EWBApplicable);
        Message(JsonTxt);
        if not confirm('Do you want to continue?', false)then exit;
    //SSD Uncomment
    // Location.Get(TransferShipmentHeader."Transfer-from Code");
    // GSPManagment.GenerateEInvoice(Location."GSTIN Login id", Location."GSTIN Login Pass", copystr(Location."GST Registration No.", 1, 15), JsonTxt, EWBApplicable);
    // ReturnStatus := GSPManagment.GetEInvoiceReturnStatus();
    // if ReturnStatus then begin
    //     RecRef.GetTable(TransferShipmentHeader);
    //     FieldRef := RecRef.Field(TransferShipmentHeader.FieldNo("Acknowledgement No."));
    //     FieldRef.Value := GSPManagment.GetAckNo();
    //     //FieldRef := RecRef.Field(SalesInvoiceHeader.FieldNo("Acknowledgement Date"));
    //     //FieldRef.Value := GSPManagment.GetAckDate() - ((1000 * 60) * 330);
    //     FieldRef := RecRef.Field(TransferShipmentHeader.FieldNo("IRN Hash"));
    //     FieldRef.Value := GSPManagment.GetIRN();
    //     FieldRef := RecRef.Field(TransferShipmentHeader.FieldNo(IsJSONImported));
    //     FieldRef.Value := true;
    //     QRTxt := GSPManagment.GetQRCode();
    //     if QRTxt <> '' then begin
    //         QRGenerator.GenerateQRCodeImage(QRTxt, TempBlob);
    //         FieldRef := RecRef.Field(TransferShipmentHeader.FieldNo("QR Code"));
    //         TempBlob.ToRecordRef(RecRef, TransferShipmentHeader.FieldNo("QR Code"));
    //     end;
    //     EwbNo := copystr(GSPManagment.GetEwbNo(), 1, 20);
    //     if EwbNo <> '' then begin
    //         FieldRef := RecRef.Field(TransferShipmentHeader.FieldNo("E-Way Bill No."));
    //         FieldRef.Value := EwbNo;
    //         //EInv_EWBMgt.InsertEInvoiceDetails(0, SalesInvoiceHeader."No.");
    //     end;
    //     RecRef.Modify();
    //     ReturnResult := GSPManagment.GetEInvoiceReturnMessage();
    //     MESSAGE(ReturnResult);
    // end;
    //SSD Uncomment
    end;
    // procedure ReGenerateTransferShipment(VAR TransferShipmentHeader: Record "Transfer Shipment Header")
    // var
    //     QRGenerator: Codeunit "QR Generator";
    //     ReqId: Code[20];
    //     SSDEinv: Codeunit SSDEinvPrepareEinvoice;
    //     // EinvAd: DotNet Adequare;
    //     // EinvAd2: DotNet ReGenerateAdequare;
    //     TokenTxt: Text;
    //     ReturnMessage: Text;
    //     ReturnStatus: Boolean;
    //     ReturnResult: Text;
    //     QRTxt: Text;
    //     OutStream: OutStream;
    //     TempBlob: Codeunit "Temp Blob";
    //     RecRef: RecordRef;
    //     EwbNo: Code[20];
    //     EWBApplicable: Boolean;
    //     EWBValidityDate: Text;
    //     EInv_EWBMgt: Codeunit "Einvoice-EWB Management";
    //     FieldRef: FieldRef;
    //     Location: Record Location;
    //     DocNo: Text;
    //     DocType: Text;
    //     DocDate: Text;
    //     ReGenError: Label 'IRN Hash is already generated.';
    // begin
    //     if TransferShipmentHeader."IRN Hash" <> '' then
    //         Error(ReGenError);
    //     //ReqId := GetRequestId();
    //     if not Confirm('Do you want to continue?', false) then
    //         exit;
    //     //SSD-29-03-23
    //     // EinvAd2 := EinvAd2.GetIRNDetails();
    //     // EinvAd2.r_ID := ReqId;
    //     // TokenTxt := EinvAd2.FetchData;
    //     // Location.Reset();
    //     // Location.Get(TransferShipmentHeader."Transfer-from Code");
    //     // EinvAd2.InUserId := Location."EInvoice User ID";
    //     // EinvAd2.InPassword := Location."EInvoice Password";
    //     // EinvAd2.InGSTRegNo := Location."GST Registration No.";
    //     // EinvAd2.intoken := TokenTxt;
    //     // DocNo := TransferShipmentHeader."No.";
    //     // DocType := 'INV';
    //     // DocDate := FORMAT(TransferShipmentHeader."Posting Date", 0, '<Day,2>/<Month,2>/<Year4>');
    //     // EinvAd2.InDocNo := DocNo;
    //     // EinvAd2.InDocDate := DocDate;
    //     // EinvAd2.InDocType := DocType;
    //     // ReturnMessage := EinvAd2.FetchIRN;
    //     // MESSAGE(ReturnMessage);
    //     // ReturnStatus := EinvAd2.GetReturnStatus;
    //     // IF ReturnStatus THEN BEGIN
    //     //     RecRef.GetTable(TransferShipmentHeader);
    //     //     FieldRef := RecRef.Field(TransferShipmentHeader.FieldNo("Acknowledgement No."));
    //     //     FieldRef.Value := EinvAd2.GetAckNo;
    //     //     FieldRef := RecRef.Field(TransferShipmentHeader.FieldNo("Acknowledgement Date"));
    //     //     FieldRef.Value := EinvAd2.GetAckDate - ((1000 * 60) * 330);
    //     //     FieldRef := RecRef.Field(TransferShipmentHeader.FieldNo("IRN Hash"));
    //     //     FieldRef.Value := EinvAd2.GetIRN;
    //     //     QRTxt := EinvAd2.GetSignedQRCode;
    //     //     if QRTxt <> '' then begin
    //     //         QRGenerator.GenerateQRCodeImage(QRTxt, TempBlob);
    //     //         FieldRef := RecRef.Field(TransferShipmentHeader.FieldNo("QR Code"));
    //     //         TempBlob.ToRecordRef(RecRef, TransferShipmentHeader.FieldNo("QR Code"));
    //     //     end;
    //     //     ReturnResult := EinvAd2.GetReturnResult;
    //     //     MESSAGE(ReturnResult);
    //     //     IF EWBApplicable THEN BEGIN
    //     //         EwbNo := EinvAd2.GetEwbNo;
    //     //         EWBValidityDate := EinvAd2.GetEwbValidity;
    //     //         FieldRef := RecRef.Field(TransferShipmentHeader.FieldNo("E-Way Bill No."));
    //     //         FieldRef.Value := EinvAd2.GetEwbNo;
    //     //         EInv_EWBMgt.InsertEWBDetails(2, TransferShipmentHeader."No.", EwbNo, FORMAT(CurrentDateTime), EWBValidityDate);
    //     //     END;
    //     //     EInv_EWBMgt.InsertEInvoiceDetails(2, TransferShipmentHeader."No.");
    //     //     RecRef.Modify();
    //     // END;
    //     //SSD
    // end;
    //Sandeep Comment End
    local procedure IsEWBInfoAvailable(var SalesInvHeader: Record "Sales Invoice Header"): Boolean begin
        if(SalesInvHeader."Vehicle No." <> '') and (SalesInvHeader."E-Way Bill No." = '')then exit(true)
        else
            exit(false);
    end;
    local procedure IsEWBCreMemoAvailable(var SalesCrMemoHeader: Record "Sales Cr.Memo Header"): Boolean begin
        if(SalesCrMemoHeader."Shipping Agent Code" <> '') and (SalesCrMemoHeader."Vehicle No." <> '')then exit(true)
        else
            exit(false);
    end;
    local procedure IsEWBTrnShipAvailable(var TransfershipmentHeader: Record "Transfer Shipment Header"): Boolean begin
        if(TransfershipmentHeader."Vehicle No." <> '') and (TransfershipmentHeader."SSD E-Way Bill No." = '')then exit(true)
        else
            exit(false);
    end;
//Sandeep Comment Start
// procedure IsTransferEWBInfoAvailable(VAR TransferShipmentHeader: Record "Transfer Shipment Header"): Boolean
// begin
//     WITH TransferShipmentHeader DO BEGIN
//         IF ("Shipping Agent Code" <> '') AND ("Vehicle No." <> '') AND ("E-Way Bill No." = '') THEN
//             EXIT(TRUE)
//         ELSE
//             EXIT(FALSE);
//     END
// end;
//Sandeep Comment End
// local procedure GetRequestId() RequestId: code[20]
// var
//     PreFix: Label 'SSDT';
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
