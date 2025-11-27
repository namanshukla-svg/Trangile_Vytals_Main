Codeunit 50016 "API Consumer E-Invoicing"
{
//     //SSDU Commented
//     // // ALLE SB_09122022
//     // // -> Changed the to remove ® and ™.
//     trigger OnRun()
//     begin
//     end;
//     var
//         CompanyInformation: Record "Company Information";
//         HttpWebRequestMgt: Codeunit "Http Web Request Mgt.";
//         FileManagement: Codeunit "File Management";
//         StringBuilder: dotnet StringBuilder;
//         StringWriter: JsonObject;
//         StringReader: StringReader;
//         Json: dotnet String;
//         JsonTextWriter: dotnet JsonTextWriter;
//         JsonTextReader: dotnet JsonTextReader;
//         StreamWriter: dotnet StreamWriter;
//         StreamReader: dotnet StreamReader;
//         Encoding: dotnet Encoding;
//         RequestStr: dotnet Stream;
//         MessageText: Text;
//         ItemDesc_GTxt: Text;
//         ItemDesc_GtextN: Text;
//     local procedure SetINIT()
//     begin
//         StringBuilder := StringBuilder.StringBuilder;
//         StringWriter := StringWriter.StringWriter(StringBuilder);
//         JsonTextWriter := JsonTextWriter.JsonTextWriter(StringWriter);
//     end;
//     procedure StartJson()
//     begin
//         SetINIT;
//         JsonTextWriter.WriteStartObject;
//     end;
//     local procedure AddToJson(Variablename: Text; Variable: Variant)
//     begin
//         JsonTextWriter.WritePropertyName(Variablename);
//         JsonTextWriter.WriteValue(Format(Variable, 0, 9));
//     end;
//     procedure EndJson()
//     begin
//         JsonTextWriter.WriteEndObject;
//     end;
//     local procedure GetJson()
//     begin
//         Json := StringBuilder.ToString;
//     end;
//     local procedure GetClientFile(): Text
//     var
//         ClientAppFile: dotnet Path;
//     begin
//         exit(ClientAppFile.GetTempPath);
//     end;
//     procedure GetAccessToken(): Text
//     var
//         DataExch: Record "Data Exch. Field";
//         EInvIntegrationSetup: Record "SSD E-Inv Integration Setup";
//         TempBlob: Record TempBlob;
//         HttpStatusCode_L: dotnet HttpStatusCode;
//         ResponseHeaders_L: dotnet NameValueCollection;
//         OutStrm: OutStream;
//         ResponseInStream_L: InStream;
//         FL: File;
//         ResponseText: Text;
//         JString: Text;
//         Validity: Text;
//         ValidSec: Integer;
//     begin
//         EInvIntegrationSetup.Get;
//         if CurrentDatetime > EInvIntegrationSetup."Access Token Validity" then begin
//             StartJson;
//             AddToJson('username', EInvIntegrationSetup."User Name");
//             AddToJson('password', EInvIntegrationSetup.Password);
//             AddToJson('client_id', EInvIntegrationSetup."Client ID");
//             AddToJson('client_secret', EInvIntegrationSetup."Client Secret");
//             AddToJson('grant_type', 'password');
//             EndJson;
//             GetJson;
//             if FILE.Exists(GetClientFile + 'J.txt') then
//                 Erase(GetClientFile + 'J.txt');
//             FL.Create(GetClientFile + 'J.txt');
//             FL.CreateOutstream(OutStrm);
//             OutStrm.WriteText(Format(Json));
//             FL.Close;
//             HttpWebRequestMgt.Initialize(EInvIntegrationSetup."Access Token URL");
//             HttpWebRequestMgt.DisableUI;
//             HttpWebRequestMgt.SetMethod('POST');
//             HttpWebRequestMgt.SetReturnType('application/json');
//             HttpWebRequestMgt.SetContentType('application/json');
//             HttpWebRequestMgt.AddBody(GetClientFile + 'J.txt');
//             TempBlob.Init;
//             TempBlob.Blob.CreateInstream(ResponseInStream_L);
//             if HttpWebRequestMgt.GetResponse(ResponseInStream_L, HttpStatusCode_L, ResponseHeaders_L) then begin
//                 ResponseInStream_L.Read(ResponseText);
//                 Json := ResponseText;
//                 ReadJSon(Json, DataExch);
//                 DataExch.Reset;
//                 DataExch.SetRange("Node ID", 'access_token');
//                 if DataExch.FindFirst then
//                     MessageText := DataExch.Value;
//                 DataExch.Reset;
//                 DataExch.SetRange("Node ID", 'expires_in');
//                 if DataExch.FindFirst then
//                     Validity := DataExch.Value;
//                 Evaluate(ValidSec, Validity);
//                 EInvIntegrationSetup."Access Token" := MessageText;
//                 EInvIntegrationSetup."Access Token Validity" := CurrentDatetime + (ValidSec * 1000);
//                 EInvIntegrationSetup.Modify;
//                 exit(MessageText);
//             end;
//         end else
//             exit(EInvIntegrationSetup."Access Token");
//     end;
//     procedure GenerateEInvoice(JsonString: Text; var ResponseText: Text)
//     var
//         EInvIntegrationSetup: Record "SSD E-Inv Integration Setup";
//         TempBlob: Record TempBlob;
//         ResponseInStream_L: InStream;
//         OutStrm: OutStream;
//         HttpStatusCode_L: dotnet HttpStatusCode;
//         ResponseHeaders_L: dotnet NameValueCollection;
//         JString: Text;
//         FL: File;
//     begin
//         GetJson;
//         if FILE.Exists(GetClientFile + 'J.txt') then
//             Erase(GetClientFile + 'J.txt');
//         FL.Create(GetClientFile + 'J.txt');
//         FL.CreateOutstream(OutStrm);
//         OutStrm.WriteText(Format(Json));
//         FL.Close;
//         if GuiAllowed then // To avoid error while Background Posting
//             if Confirm('Do you want view the JSON') then
//                 Message('%1', Json);
//         EInvIntegrationSetup.Get;
//         HttpWebRequestMgt.Initialize(EInvIntegrationSetup."Generate E-Invoice URL");
//         HttpWebRequestMgt.DisableUI;
//         HttpWebRequestMgt.SetMethod('POST');
//         HttpWebRequestMgt.SetReturnType('application/json');
//         HttpWebRequestMgt.SetContentType('application/json');
//         HttpWebRequestMgt.AddBody(GetClientFile + 'J.txt');
//         TempBlob.Init;
//         TempBlob.Blob.CreateInstream(ResponseInStream_L);
//         if HttpWebRequestMgt.GetResponse(ResponseInStream_L, HttpStatusCode_L, ResponseHeaders_L) then
//             ResponseInStream_L.Read(ResponseText);
//     end;
//     procedure ReadJSon(var String: dotnet String; var TempDataExchField: Record "Data Exch. Field" temporary)
//     var
//         JsonToken: dotnet JsonToken;
//         PrefixArray: dotnet Array;
//         PrefixString: dotnet String;
//         PropertyName: Text;
//         ColumnNo: Integer;
//         InArray: array[1000] of Boolean;
//     begin
//         PrefixArray := PrefixArray.CreateInstance(GetDotNetType(String), 250);
//         StringReader := StringReader.StringReader(String);
//         JsonTextReader := JsonTextReader.JsonTextReader(StringReader);
//         TempDataExchField.DeleteAll;
//         //new code for delete all data from temp table
//         while JsonTextReader.Read do
//             case true of
//                 JsonTextReader.TokenType.CompareTo(JsonToken.StartObject) = 0:
//                     ;
//                 JsonTextReader.TokenType.CompareTo(JsonToken.StartArray) = 0:
//                     begin
//                         InArray[JsonTextReader.Depth + 1] := true;
//                     end;
//                 JsonTextReader.TokenType.CompareTo(JsonToken.StartConstructor) = 0:
//                     ;
//                 JsonTextReader.TokenType.CompareTo(JsonToken.PropertyName) = 0:
//                     begin
//                         PrefixArray.SetValue(JsonTextReader.Value, JsonTextReader.Depth - 1);
//                         if JsonTextReader.Depth > 1 then begin
//                             PrefixString := PrefixString.Join('.', PrefixArray, 0, JsonTextReader.Depth - 1);
//                             if PrefixString.Length > 0 then
//                                 PropertyName := PrefixString.ToString + '.' + Format(JsonTextReader.Value, 0, 9)
//                             else
//                                 PropertyName := Format(JsonTextReader.Value, 0, 9);
//                         end else
//                             PropertyName := Format(JsonTextReader.Value, 0, 9);
//                     end;
//                 JsonTextReader.TokenType.CompareTo(JsonToken.String) = 0,
//                 JsonTextReader.TokenType.CompareTo(JsonToken.Integer) = 0,
//                 JsonTextReader.TokenType.CompareTo(JsonToken.Float) = 0,
//                 JsonTextReader.TokenType.CompareTo(JsonToken.Boolean) = 0,
//                 JsonTextReader.TokenType.CompareTo(JsonToken.Date) = 0,
//                 JsonTextReader.TokenType.CompareTo(JsonToken.Bytes) = 0:
//                     begin
//                         TempDataExchField.Init;
//                         TempDataExchField."Data Exch. No." := JsonTextReader.Depth;
//                         TempDataExchField."Line No." := JsonTextReader.LineNumber;
//                         TempDataExchField."Column No." := ColumnNo;
//                         TempDataExchField."Node ID" := PropertyName;
//                         if (StrLen(Format(JsonTextReader.Value, 0, 9)) > 250) and (TempDataExchField."Node ID" <> 'results.message.SignedInvoice') then begin
//                             TempDataExchField.Value := CopyStr(Format(JsonTextReader.Value, 0, 9), 1, 250);
//                             TempDataExchField."SSD Value2" := CopyStr(Format(JsonTextReader.Value, 0, 9), 251, 250);
//                             TempDataExchField."SSD Value3" := CopyStr(Format(JsonTextReader.Value, 0, 9), 501, 250);
//                             TempDataExchField."SSD Value4" := CopyStr(Format(JsonTextReader.Value, 0, 9), 751, 250);
//                         end else
//                             TempDataExchField.Value := CopyStr(Format(JsonTextReader.Value, 0, 9), 1, 250);
//                         TempDataExchField."Data Exch. Line Def Code" := JsonTextReader.TokenType.ToString;
//                         TempDataExchField.Insert;
//                         Commit;
//                     end;
//                 JsonTextReader.TokenType.CompareTo(JsonToken.EndConstructor) = 0:
//                     ;
//                 JsonTextReader.TokenType.CompareTo(JsonToken.EndArray) = 0:
//                     InArray[JsonTextReader.Depth + 1] := false;
//                 JsonTextReader.TokenType.CompareTo(JsonToken.EndObject) = 0:
//                     if JsonTextReader.Depth > 0 then
//                         if InArray[JsonTextReader.Depth] then ColumnNo += 1;
//             end;
//     end;
//     local procedure GetJsonNodeValue(NodeId: Text[30]): Text[1024]
//     var
//         DataExch: Record "Data Exch. Field";
//     begin
//         Clear(MessageText);
//         DataExch.SetRange("Node ID", NodeId);
//         if DataExch.FindFirst then
//             MessageText := DataExch.Value + DataExch."SSD Value2" + DataExch."SSD Value3" + DataExch."SSD Value4";
//         exit(MessageText);
//     end;
//     local procedure GetCompanyInfo()
//     begin
//         CompanyInformation.Get;
//     end;
//     local procedure GetStateCode(StateCode: Code[20]): Text
//     var
//         StateL: Record State;
//     begin
//         if StateL.Get(StateCode) then
//             exit(UpperCase(StateL.Description));
//         exit('');
//     end;
//     local procedure GetStateCode_POS(StateCode: Code[20]): Text
//     var
//         StateL: Record State;
//     begin
//         if StateL.Get(StateCode) then
//             exit(UpperCase(StateL."State Code (GST Reg. No.)"));
//         exit('');
//     end;
//     local procedure GetGSTAmount(DocNo: Code[20]; CompCode: Code[10]): Decimal
//     var
//         DetailedGSTLedgerEntry: Record "Detailed GST Ledger Entry";
//         GSTAmt: Decimal;
//     begin
//         DetailedGSTLedgerEntry.SetCurrentkey("Document No.", "Document Line No.", "GST Component Code");
//         DetailedGSTLedgerEntry.SetRange("Document No.", DocNo);
//         DetailedGSTLedgerEntry.SetRange("GST Component Code", CompCode);
//         DetailedGSTLedgerEntry.CalcSums("GST Amount");
//         exit(Abs(DetailedGSTLedgerEntry."GST Amount"));
//     end;
//     local procedure GetGSTAmountLineWise(DocNo: Code[20]; CompCode: Code[10]; LineNo: Integer): Decimal
//     var
//         DetailedGSTLedgerEntry: Record "Detailed GST Ledger Entry";
//         GSTAmt: Decimal;
//     begin
//         DetailedGSTLedgerEntry.SetCurrentkey("Document No.", "Document Line No.", "GST Component Code");
//         DetailedGSTLedgerEntry.SetRange("Document No.", DocNo);
//         DetailedGSTLedgerEntry.SetRange("Document Line No.", LineNo);
//         DetailedGSTLedgerEntry.SetRange("GST Component Code", CompCode);
//         DetailedGSTLedgerEntry.CalcSums("GST Amount");
//         exit(Abs(DetailedGSTLedgerEntry."GST Amount"));
//     end;
//     local procedure CheckGST(DocNo: Code[20]): Boolean
//     var
//         DetailedGSTLedgerEntry: Record "Detailed GST Ledger Entry";
//     begin
//         DetailedGSTLedgerEntry.SetCurrentkey("Document No.", "Document Line No.", "GST Component Code");
//         DetailedGSTLedgerEntry.SetRange("Document No.", DocNo);
//         if DetailedGSTLedgerEntry.FindFirst then
//             exit(true);
//         exit(false);
//     end;
//     local procedure GetGSTRate(DocNo: Code[20]; CompCode: Code[10]; LineNo: Integer): Decimal
//     var
//         DetailedGSTLedgerEntry: Record "Detailed GST Ledger Entry";
//     begin
//         DetailedGSTLedgerEntry.SetCurrentkey("Document No.", "Document Line No.", "GST Component Code");
//         DetailedGSTLedgerEntry.SetRange("Document No.", DocNo);
//         DetailedGSTLedgerEntry.SetRange("Document Line No.", LineNo);
//         DetailedGSTLedgerEntry.SetRange("GST Component Code", CompCode);
//         if DetailedGSTLedgerEntry.FindFirst then
//             exit(ROUND(DetailedGSTLedgerEntry."GST %", 0.01));
//         exit(0);
//     end;
//     local procedure GetTaxableAmountSalesInvoice(DocNo: Code[20]): Decimal
//     var
//         SalesInvoiceLine: Record "Sales Invoice Line";
//     begin
//         SalesInvoiceLine.SetRange("Document No.", DocNo);
//         SalesInvoiceLine.SetFilter(Quantity, '<>%1', 0);
//         SalesInvoiceLine.CalcSums("GST Base Amount");
//         if SalesInvoiceLine."GST Base Amount" <> 0 then
//             exit(SalesInvoiceLine."GST Base Amount");
//         SalesInvoiceLine.CalcSums(Amount);
//         exit(SalesInvoiceLine.Amount);
//     end;
//     local procedure GetTaxableAmountTransfer(DocNo: Code[20]): Decimal
//     var
//         TransferShipmentLine: Record "Transfer Shipment Line";
//     begin
//         TransferShipmentLine.SetRange("Document No.", DocNo);
//         TransferShipmentLine.SetFilter(Quantity, '<>%1', 0);
//         TransferShipmentLine.CalcSums("GST Base Amount");
//         if TransferShipmentLine."GST Base Amount" <> 0 then
//             exit(TransferShipmentLine."GST Base Amount");
//         TransferShipmentLine.CalcSums(Amount);
//         exit(TransferShipmentLine.Amount);
//     end;
//     local procedure GetTaxableAmountSCrMemo(DocNo: Code[20]): Decimal
//     var
//         SalesCrMemoLine: Record "Sales Cr.Memo Line";
//     begin
//         SalesCrMemoLine.SetRange("Document No.", DocNo);
//         SalesCrMemoLine.SetFilter(Quantity, '<>%1', 0);
//         SalesCrMemoLine.CalcSums("GST Base Amount");
//         if SalesCrMemoLine."GST Base Amount" <> 0 then
//             exit(SalesCrMemoLine."GST Base Amount");
//         SalesCrMemoLine.CalcSums(Amount);
//         exit(SalesCrMemoLine.Amount);
//     end;
//     local procedure GetDateFormated(Originaldate: Date): Text
//     var
//         Day: Text[2];
//         mnth: Text[2];
//     begin
//         if Originaldate <> 0D then begin
//             if Date2dmy(Originaldate, 2) > 9 then
//                 mnth := Format(Date2dmy(Originaldate, 2))
//             else
//                 mnth := '0' + Format(Date2dmy(Originaldate, 2));
//             if Date2dmy(Originaldate, 1) > 9 then
//                 Day := Format(Date2dmy(Originaldate, 1))
//             else
//                 Day := '0' + Format(Date2dmy(Originaldate, 1));
//             exit(Day + '/' + mnth + '/' + Format(Date2dmy(Originaldate, 3)));
//         end;
//     end;
//     local procedure GetGSTIN(LocCode: Code[20]): Text
//     var
//         Location: Record Location;
//         CompanyInformation: Record "Company Information";
//     begin
//         if Location.Get(LocCode) then begin
//             Location.TestField("GST Registration No.");
//             exit(Location."GST Registration No.");
//         end;
//         CompanyInformation.Get;
//         exit(CompanyInformation."GST Registration No.");
//     end;
//     local procedure GetRoundingGL(CustPostingGrp: Code[10]; var GstRoundingGL: Code[20]; var InvRoundingGL: Code[20]; var PITRoundingGL: Code[20])
//     var
//         GeneralLedgerSetup: Record "General Ledger Setup";
//         CustomerPostingGroup: Record "Customer Posting Group";
//     begin
//         GeneralLedgerSetup.Get;
//         GstRoundingGL := GeneralLedgerSetup."GST Inv. Rounding Account";
//         if CustomerPostingGroup.Get(CustPostingGrp) then begin
//             InvRoundingGL := CustomerPostingGroup."Invoice Rounding Account";
//             PITRoundingGL := CustomerPostingGroup."PIT Difference Acc.";
//         end;
//     end;
// local procedure InsertResponse(RequestId: Text[250]; DocumentNo: Code[20]; DocType: Option " ","Sale Invoice","Sale Cr. Memo",Transfer; AckNo: Text; AckDt: Text; Irn: Text; SignedQRCode: Text; StatusP: Text; ErrorMessage: Text; DocDate: Date; QRCodeURL: Text; EInvoicePDFURL: Text; InfoDetails: Text)
// var
//     EInvoicingRequests: Record "SSD E-Invoicing Requests";
//     EInvoicingRequests2: Record "SSD E-Invoicing Requests";
// begin
//     EInvoicingRequests2.SetCurrentkey("Document Type", "Document No.", "E-Invoice Generated");
//     EInvoicingRequests2.SetRange("Document Type", DocType);
//     EInvoicingRequests2.SetRange("Document No.", DocumentNo);
//     if EInvoicingRequests2.FindFirst then begin
//         EInvoicingRequests2."Acknowledgement No." := AckNo;
//         EInvoicingRequests2."Acknowledgement Date" := AckDt;
//         EInvoicingRequests2."IRN No." := Irn;
//         if StrLen(SignedQRCode) > 250 then begin
//             EInvoicingRequests2."Signed QR Code" := CopyStr(SignedQRCode, 1, 250);
//             EInvoicingRequests2."Signed QR Code2" := CopyStr(SignedQRCode, 251, 250);
//             EInvoicingRequests2."Signed QR Code3" := CopyStr(SignedQRCode, 501, 250);
//             EInvoicingRequests2."Signed QR Code4" := CopyStr(SignedQRCode, 751, 250);
//         end else
//             EInvoicingRequests2."Signed QR Code" := (SignedQRCode);
//         if StrLen(ErrorMessage) > 250 then begin
//             EInvoicingRequests2."Error Message" := CopyStr(ErrorMessage, 1, 250);
//             EInvoicingRequests2."Error Message2" := CopyStr(ErrorMessage, 251, 250);
//             EInvoicingRequests2."Error Message3" := CopyStr(ErrorMessage, 501, 250);
//         end else
//             EInvoicingRequests2."Error Message" := ErrorMessage;
//         EInvoicingRequests2.Status := StatusP;
//         EInvoicingRequests2."Request ID" := RequestId;
//         EInvoicingRequests2."Request Date" := WorkDate;
//         EInvoicingRequests2."Request Time" := Time;
//         EInvoicingRequests2."User Id" := UserId;
//         EInvoicingRequests2."QR Code URL" := QRCodeURL; //Alle 01032021
//         EInvoicingRequests2."E Invoice PDF URL" := EInvoicePDFURL; //Alle 01032021
//         if StrLen(InfoDetails) > 250 then begin
//             EInvoicingRequests2."Info Details" := CopyStr(InfoDetails, 1, 250);
//             EInvoicingRequests2."Info Details2" := CopyStr(InfoDetails, 251, 250);
//         end else
//             EInvoicingRequests2."Info Details" := InfoDetails;
//         if Irn <> '' then begin
//             if GuiAllowed then begin // To avoid error while Background Posting
//                 //GenerateQRCode(EInvoicingRequests2);
//         end;
//             EInvoicingRequests2."E-Invoice Generated" := true;
//         end;
//         EInvoicingRequests2.Modify;
//     end else begin
//         EInvoicingRequests."Entry No." := CreateGuid;
//         EInvoicingRequests."Document Type" := DocType;
//         EInvoicingRequests."Document No." := DocumentNo;
//         EInvoicingRequests."Document Date" := DocDate;
//         EInvoicingRequests."Acknowledgement No." := AckNo;
//         EInvoicingRequests."Acknowledgement Date" := AckDt;
//         EInvoicingRequests."IRN No." := Irn;
//         if StrLen(SignedQRCode) > 250 then begin
//             EInvoicingRequests."Signed QR Code" := CopyStr(SignedQRCode, 1, 250);
//             EInvoicingRequests."Signed QR Code2" := CopyStr(SignedQRCode, 251, 250);
//             EInvoicingRequests."Signed QR Code3" := CopyStr(SignedQRCode, 501, 250);
//             EInvoicingRequests."Signed QR Code4" := CopyStr(SignedQRCode, 751, 250);
//         end else
//             EInvoicingRequests."Signed QR Code" := (SignedQRCode);
//         if StrLen(ErrorMessage) > 250 then begin
//             EInvoicingRequests."Error Message" := CopyStr(ErrorMessage, 1, 250);
//             EInvoicingRequests."Error Message2" := CopyStr(ErrorMessage, 251, 250);
//             EInvoicingRequests."Error Message3" := CopyStr(ErrorMessage, 501, 250);
//         end else
//             EInvoicingRequests."Error Message" := ErrorMessage;
//         EInvoicingRequests.Status := StatusP;
//         EInvoicingRequests."Request ID" := RequestId;
//         EInvoicingRequests."Request Date" := WorkDate;
//         EInvoicingRequests."Request Time" := Time;
//         EInvoicingRequests."User Id" := UserId;
//         EInvoicingRequests."QR Code URL" := QRCodeURL;
//         EInvoicingRequests."E Invoice PDF URL" := EInvoicePDFURL;
//         if StrLen(InfoDetails) > 250 then begin
//             EInvoicingRequests."Info Details" := CopyStr(InfoDetails, 1, 250);
//             EInvoicingRequests."Info Details2" := CopyStr(InfoDetails, 251, 250);
//         end else
//             EInvoicingRequests."Info Details" := InfoDetails;
//         if Irn <> '' then begin
//             EInvoicingRequests."E-Invoice Generated" := true;
//             if GuiAllowed then // To avoid error while Background Posting
//                 GenerateQRCode(EInvoicingRequests);
//         end;
//         EInvoicingRequests.Insert;
//     end;
// end;
//     local procedure GetUOM(UOMCode: Code[10]): Text
//     var
//         UnitofMeasure: Record "Unit of Measure";
//     begin
//         if ((UnitofMeasure.Get(UOMCode)) and (UnitofMeasure."GST Reporting UQC" <> '')) then
//             exit(UnitofMeasure."GST Reporting UQC");
//     end;
//     procedure CheckValidations_BeforePost(var SalesHeader: Record "Sales Header")
//     var
//         SalesLine: Record "Sales Line";
//     begin
//         if SalesHeader."Document Type" in [SalesHeader."document type"::Order, SalesHeader."document type"::Invoice, SalesHeader."document type"::"Credit Memo"] then begin
//             if (SalesHeader."GST Customer Type" in
//                        [SalesHeader."gst customer type"::Export]) and (SalesHeader."Nature of Supply" = SalesHeader."nature of supply"::B2B)
//                     then begin
//                 SalesLine.SetRange("Document Type", SalesHeader."Document Type");
//                 SalesLine.SetRange("Document No.", SalesHeader."No.");
//                 SalesLine.SetRange(Type, SalesLine.Type::Item);
//                 if SalesLine.FindFirst then
//                     SalesHeader.TestField("Exit Point");
//             end;
//         end;
//     end;
//     [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnAfterPostSalesDoc', '', false, false)]
//     procedure CreateJSONSalesInvoice_OnPost(var SalesHeader: Record "Sales Header"; var GenJnlPostLine: Codeunit "Gen. Jnl.-Post Line"; SalesShptHdrNo: Code[20]; RetRcpHdrNo: Code[20]; SalesInvHdrNo: Code[20]; SalesCrMemoHdrNo: Code[20])
//     var
//         SalesInvoiceHeader: Record "Sales Invoice Header";
//         EInvIntegrationSetup: Record "SSD E-Inv Integration Setup";
//     begin
//         EInvIntegrationSetup.Get;
//         if EInvIntegrationSetup."Mode of E-Invoice - Sales" = EInvIntegrationSetup."mode of e-invoice - sales"::"BackGround Posting" then
//             exit;
//         if not SalesInvoiceHeader.Get(SalesInvHdrNo) then
//             exit;
//         CreateJson(SalesInvoiceHeader, 1);
//     end;
//     [EventSubscriber(ObjectType::Codeunit, Codeunit::"TransferOrder-Post Shipment", 'OnAfterPostTransferDoc', '', false, false)]
//     procedure CreateJSONTransferShipment_OnPost(var TransferHeader: Record "Transfer Header"; TransferShptHdrNo: Code[20])
//     var
//         TransferShipmentHeader: Record "Transfer Shipment Header";
//         EInvIntegrationSetup: Record "SSD E-Inv Integration Setup";
//     begin
//         EInvIntegrationSetup.Get;
//         if EInvIntegrationSetup."Mode of E-Invoice - Transfer" = EInvIntegrationSetup."mode of e-invoice - transfer"::"BackGround Posting" then
//             exit;
//         if not TransferShipmentHeader.Get(TransferShptHdrNo) then
//             exit;
//         CreateJson(TransferShipmentHeader, 3);
//     end;
//     [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnAfterPostSalesDoc', '', false, false)]
//     procedure CreateJSONSalesCrmemo_OnPost(var SalesHeader: Record "Sales Header"; var GenJnlPostLine: Codeunit "Gen. Jnl.-Post Line"; SalesShptHdrNo: Code[20]; RetRcpHdrNo: Code[20]; SalesInvHdrNo: Code[20]; SalesCrMemoHdrNo: Code[20])
//     var
//         SalesCrMemoHeader: Record "Sales Cr.Memo Header";
//         EInvIntegrationSetup: Record "SSD E-Inv Integration Setup";
//     begin
//         EInvIntegrationSetup.Get;
//         if EInvIntegrationSetup."Mode of E-Invoice - Sales" = EInvIntegrationSetup."mode of e-invoice - sales"::"BackGround Posting" then
//             exit;
//         if (SalesHeader."Document Type" <> SalesHeader."document type"::"Credit Memo") and (not SalesCrMemoHeader.Get(SalesCrMemoHdrNo)) then
//             exit;
//         CreateJson(SalesCrMemoHeader, 2);
//     end;
//     [EventSubscriber(Objecttype::Page, 132, 'OnAfterActionEvent', 'Generate E-Invoice', false, false)]
//     procedure CreateJSONSalesInvoice_OnPostedInvoice(var Rec: Record "Sales Invoice Header")
//     begin
//         CreateJson(Rec, 1);
//     end;
//     [EventSubscriber(Objecttype::Page, 5743, 'OnAfterActionEvent', 'Generate E-Invoice', false, false)]
//     procedure CreateJSONTransferShipment__OnPostedInvoice(var Rec: Record "Transfer Shipment Header")
//     begin
//         CreateJson(Rec, 3);
//     end;
//     [EventSubscriber(Objecttype::Page, 134, 'OnAfterActionEvent', 'Generate E-Invoice', false, false)]
//     procedure CreateJSONSalesCrmemo__OnPostedInvoice(var Rec: Record "Sales Cr.Memo Header")
//     begin
//         CreateJson(Rec, 2);
//     end;
//     local procedure CreateJson(RecVariant: Variant; DocumentType: Option " ","Sale Invoice","Sale Cr. Memo",Transfer)
//     var
//         Text50000: label 'AT365 EInvoice';
//     begin
//         case DocumentType of
//             Documenttype::"Sale Invoice":
//                 CreateJSONSalesInvoice(RecVariant);
//             Documenttype::Transfer:
//                 CreateJSONTransferShipment(RecVariant);
//             Documenttype::"Sale Cr. Memo":
//                 CreateJSONSalesCrmemo(RecVariant);
//         end;
//     end;
//     local procedure CreateJSONSalesInvoice(SalesInvoiceHeader: Record "Sales Invoice Header")
//     var
//         Customer: Record Customer;
//         SalesInvoiceLine: Record "Sales Invoice Line";
//         ShiptoAddress: Record "Ship-to Address";
//         SalesInvoiceHeader2: Record "Sales Invoice Header";
//         DataExch: Record "Data Exch. Field";
//         TransportMethod: Record "Transport Method";
//         State_rec: Record State;
//         EInvIntegrationSetup: Record "SSD E-Inv Integration Setup";
//         eCommerceMerchantId: Record "e-Commerce Merchant Id";
//         SalesInvoiceLine2: Record "Sales Invoice Line";
//         SalesInvoiceLine3: Record "Sales Invoice Line";
//         PostedStructureOrderDetails: Record "Posted Structure Order Details";
//         TempBlob: Record TempBlob;
//         ResponseInStream_L: InStream;
//         OutStrm: OutStream;
//         FL: File;
//         HttpStatusCode_L: dotnet HttpStatusCode;
//         ResponseHeaders_L: dotnet NameValueCollection;
//         CustGstin: Code[15];
//         State_Gst: Code[2];
//         CustGstin2: Code[15];
//         InvRoundingGL: Code[20];
//         RefDocNo: Code[20];
//         GstRoundingGL: Code[20];
//         PITRoundingGL: Code[20];
//         DocNo: Code[20];
//         RequestString: Text;
//         TknNo: Text[50];
//         ResponseText: Text;
//         JString: Text;
//         AckNo: Text;
//         AckDt: Text;
//         Irn: Text;
//         Mnth: Text[2];
//         Day: Text[2];
//         SignedQRCode: Text;
//         SNo: Integer;
//         LCYCurrency: Decimal;
//         Text50000: label 'E-Invoice generated successfully for Document No. %1.';
//         Text50001: label '%1 Please share this request ID for support %2.';
//         Text50002: label 'No Response captured.';
//         Location: Record Location;
//         RespCenter: Record "Responsibility Center";
//     begin
//         if not CheckGST(SalesInvoiceHeader."No.") then
//             exit;
//         EInvIntegrationSetup.Get;
//         if (SalesInvoiceHeader."Nature of Supply" = SalesInvoiceHeader."nature of supply"::B2C) then
//             exit;
//         CheckEInvoiceStatus(SalesInvoiceHeader."No.", 1);
//         GetCompanyInfo;
//         TknNo := GetAccessToken;
//         Location.Get(SalesInvoiceHeader."Location Code");
//         Customer.Get(SalesInvoiceHeader."Bill-to Customer No.");
//         LCYCurrency := 1;
//         StartJson;
//         AddToJson('access_token', TknNo);
//         //AddToJson('user_gstin','09AAAPG7885R002');//For SandBox
//         AddToJson('user_gstin', GetGSTIN(SalesInvoiceHeader."Location Code"));
//         AddToJson('data_soure', 'erp');
//         JsonTextWriter.WritePropertyName('transaction_details');
//         JsonTextWriter.WriteStartObject;
//         case SalesInvoiceHeader."GST Customer Type" of
//             SalesInvoiceHeader."gst customer type"::Export:
//                 begin
//                     if SalesInvoiceHeader."GST Without Payment of Duty" then
//                         AddToJson('supply_type', 'EXPWOP')
//                     else
//                         AddToJson('supply_type', 'EXPWP');
//                 end;
//             SalesInvoiceHeader."gst customer type"::"SEZ Development", SalesInvoiceHeader."gst customer type"::"SEZ Unit":
//                 begin
//                     if SalesInvoiceHeader."GST Without Payment of Duty" then
//                         AddToJson('supply_type', 'SEZWOP')
//                     else
//                         AddToJson('supply_type', 'SEZWP');
//                 end;
//             SalesInvoiceHeader."gst customer type"::"Deemed Export":
//                 AddToJson('supply_type', 'DEXP');
//             SalesInvoiceHeader."gst customer type"::Registered, SalesInvoiceHeader."gst customer type"::Exempted:
//                 AddToJson('supply_type', 'B2B');
//         end;
//         AddToJson('charge_type', 'N');
//         if SalesInvoiceHeader."POS Out Of India" then
//             AddToJson('igst_on_intra', 'Y')
//         else
//             AddToJson('igst_on_intra', 'N');
//         if SalesInvoiceHeader."e-Commerce Customer" <> '' then begin
//             if eCommerceMerchantId.Get(SalesInvoiceHeader."e-Commerce Customer", SalesInvoiceHeader."e-Commerce Merchant Id") then
//                 AddToJson('ecommerce_gstin', eCommerceMerchantId."Company GST Reg. No.");
//         end;
//         JsonTextWriter.WriteEndObject;
//         JsonTextWriter.WritePropertyName('document_details');
//         JsonTextWriter.WriteStartObject;
//         if SalesInvoiceHeader."Invoice Type" = SalesInvoiceHeader."invoice type"::Taxable then
//             AddToJson('document_type', 'INV')
//         else
//             if (SalesInvoiceHeader."Invoice Type" = SalesInvoiceHeader."invoice type"::"Debit Note") or
//               (SalesInvoiceHeader."Invoice Type" = SalesInvoiceHeader."invoice type"::Supplementary)
//             then
//                 AddToJson('document_type', 'DBN')
//             else
//                 AddToJson('document_type', 'INV');
//         AddToJson('document_number', SalesInvoiceHeader."No.");
//         AddToJson('document_date', GetDateFormated(SalesInvoiceHeader."Posting Date"));
//         JsonTextWriter.WriteEndObject;
//         if Location."Temp JW Location" then begin
//             JsonTextWriter.WritePropertyName('seller_details');
//             JsonTextWriter.WriteStartObject;
//             RespCenter.Get(SalesInvoiceHeader."Responsibility Center");
//             AddToJson('gstin', GetGSTIN(SalesInvoiceHeader."Location Code"));
//             //AddToJson('gstin','09AAAPG7885R002'); //For SandBox
//             AddToJson('legal_name', CompanyInformation.Name);
//             AddToJson('trade_name', RespCenter.Name);
//             AddToJson('address1', RespCenter.Address);
//             AddToJson('address2', RespCenter."Address 2");
//             AddToJson('location', RespCenter.City);
//             AddToJson('pincode', RespCenter."Post Code");
//             AddToJson('state_code', GetStateCode(RespCenter.State));
//             //AddToJson('location','Noida');//For SandBox
//             //AddToJson('pincode','201306');//For SandBox
//             //AddToJson('state_code',GetStateCode('UP'));//For SandBox
//             JsonTextWriter.WriteEndObject;
//             //SSD Code commented to hide dispatch details
//             //JsonTextWriter.WritePropertyName('dispatch_details');
//             //JsonTextWriter.WriteStartObject;
//             //AddToJson('company_name',Location.Name);
//             //AddToJson('address1',Location.Address);
//             //AddToJson('address2',Location."Address 2");
//             //AddToJson('location',Location.City);
//             //AddToJson('pincode',Location."Post Code");
//             //AddToJson('state_code',GetStateCode(Location."Temp State Code"));
//             //JsonTextWriter.WriteEndObject;
//         end else begin
//             JsonTextWriter.WritePropertyName('seller_details');
//             JsonTextWriter.WriteStartObject;
//             AddToJson('gstin', GetGSTIN(SalesInvoiceHeader."Location Code"));
//             //AddToJson('gstin','09AAAPG7885R002'); //For SandBox
//             AddToJson('legal_name', CompanyInformation.Name);
//             AddToJson('trade_name', Location.Name);
//             AddToJson('address1', Location.Address);
//             AddToJson('address2', Location."Address 2");
//             AddToJson('location', Location.City);
//             AddToJson('pincode', Location."Post Code");
//             AddToJson('state_code', GetStateCode(Location."State Code"));
//             //AddToJson('location','Noida'); //For SandBox
//             //AddToJson('pincode','201306'); //For SandBox
//             //AddToJson('state_code',GetStateCode('UP')); //For SandBox
//             JsonTextWriter.WriteEndObject;
//         end;
//         //SSD Commented
//         /*
//           JsonTextWriter.WritePropertyName('seller_details');
//           JsonTextWriter.WriteStartObject;
//           AddToJson('gstin',GetGSTIN("Location Code"));
//           //AddToJson('gstin','09AAAPG7885R002'); //For SandBox
//           AddToJson('legal_name',CompanyInformation.Name);
//           AddToJson('trade_name',Location.Name);
//           AddToJson('address1',Location.Address);
//           AddToJson('address2',Location."Address 2");
//           AddToJson('location',Location.City);
//           AddToJson('pincode',Location."Post Code");
//           AddToJson('state_code',GetStateCode(Location."State Code"));
//           JsonTextWriter.WriteEndObject;
//         */
//         JsonTextWriter.WritePropertyName('buyer_details');
//         JsonTextWriter.WriteStartObject;
//         if (SalesInvoiceHeader."GST Customer Type" = SalesInvoiceHeader."gst customer type"::Export) then
//             AddToJson('gstin', 'URP')
//         else
//             AddToJson('gstin', Customer."GST Registration No.");
//         //AddToJson('gstin','05AAAPG7885R002'); //For SandBox
//         AddToJson('legal_name', SalesInvoiceHeader."Bill-to Name");
//         AddToJson('trade_name', SalesInvoiceHeader."Bill-to Name");
//         SalesInvoiceLine3.SetRange("Document No.", SalesInvoiceHeader."No.");
//         SalesInvoiceLine3.SetFilter("GST Place of Supply", '<>%1', SalesInvoiceLine3."gst place of supply"::" ");
//         if SalesInvoiceLine3.FindFirst then
//             if SalesInvoiceLine3."GST Place of Supply" = SalesInvoiceLine3."gst place of supply"::"Bill-to Address" then begin
//                 AddToJson('address1', SalesInvoiceHeader."Bill-to Address");
//                 AddToJson('address2', SalesInvoiceHeader."Bill-to Address 2");
//                 AddToJson('location', SalesInvoiceHeader."Bill-to City");
//                 if SalesInvoiceHeader."GST Customer Type" in [SalesInvoiceHeader."gst customer type"::Export, SalesInvoiceHeader."gst customer type"::"Deemed Export", SalesInvoiceHeader."gst customer type"::"SEZ Development", SalesInvoiceHeader."gst customer type"::"SEZ Unit"] then
//                     AddToJson('place_of_supply', '96')
//                 else
//                     AddToJson('place_of_supply', GetStateCode_POS(SalesInvoiceHeader."GST Bill-to State Code"));
//                 if SalesInvoiceHeader."GST Customer Type" = SalesInvoiceHeader."gst customer type"::Export then
//                     AddToJson('state_code', '96')
//                 else
//                     AddToJson('state_code', GetStateCode(SalesInvoiceHeader."GST Bill-to State Code"));
//             end else
//                 if SalesInvoiceLine3."GST Place of Supply" = SalesInvoiceLine3."gst place of supply"::"Ship-to Address" then begin
//                     if ShiptoAddress.Get(SalesInvoiceHeader."Sell-to Customer No.", SalesInvoiceHeader."Ship-to Code") then begin
//                         AddToJson('address1', ShiptoAddress.Address);
//                         AddToJson('address2', ShiptoAddress."Address 2");
//                         AddToJson('location', ShiptoAddress.City);
//                     end;
//                     if SalesInvoiceHeader."GST Customer Type" in [SalesInvoiceHeader."gst customer type"::Export, SalesInvoiceHeader."gst customer type"::"Deemed Export", SalesInvoiceHeader."gst customer type"::"SEZ Development", SalesInvoiceHeader."gst customer type"::"SEZ Unit"] then
//                         AddToJson('place_of_supply', '96')
//                     else
//                         AddToJson('place_of_supply', GetStateCode_POS(SalesInvoiceHeader."GST Ship-to State Code"));
//                     if SalesInvoiceHeader."GST Customer Type" = SalesInvoiceHeader."gst customer type"::Export then
//                         AddToJson('state_code', '96')
//                     else
//                         AddToJson('state_code', GetStateCode(SalesInvoiceHeader."GST Ship-to State Code"));
//                 end;
//         if SalesInvoiceHeader."GST Customer Type" = SalesInvoiceHeader."gst customer type"::Export then
//             AddToJson('pincode', '999999')
//         else
//             AddToJson('pincode', SalesInvoiceHeader."Bill-to Post Code");
//         JsonTextWriter.WriteEndObject;
//         /*IF ("GST Customer Type" = "GST Customer Type"::Export) THEN BEGIN
//            // Port Address Details in ship To Address(New Table Exit/Entry Point Details is created) // If Port Details otherwise comment
//           IF ExitEntryPointDetails.GET("Exit Point") THEN;
//           JsonTextWriter.WritePropertyName('ship_details');
//           JsonTextWriter.WriteStartObject;
//           AddToJson('gstin','URP');
//           AddToJson('legal_name',ExitEntryPointDetails.Name);
//           AddToJson('trade_name',ExitEntryPointDetails.Name);
//           AddToJson('address1',ExitEntryPointDetails.Address);
//           AddToJson('address2',ExitEntryPointDetails.Address2);
//           AddToJson('location',ExitEntryPointDetails.City);
//           AddToJson('pincode',ExitEntryPointDetails."Post Code");
//           AddToJson('state_code',GetStateCode(ExitEntryPointDetails."State Code"));
//           JsonTextWriter.WriteEndObject;
//         END ELSE BEGIN*/
//         if (SalesInvoiceHeader."Ship-to Code" <> '') and (ShiptoAddress.Get(SalesInvoiceHeader."Sell-to Customer No.", SalesInvoiceHeader."Ship-to Code")) then begin
//             CustGstin := ShiptoAddress."GST Registration No.";
//             JsonTextWriter.WritePropertyName('ship_details');
//             JsonTextWriter.WriteStartObject;
//             if SalesInvoiceHeader."GST Customer Type" = SalesInvoiceHeader."gst customer type"::Export then
//                 AddToJson('gstin', 'URP')
//             else
//                 AddToJson('gstin', CustGstin);
//             //AddToJson('gstin','05AAABB0639G1Z8'); //For SandBox
//             AddToJson('legal_name', SalesInvoiceHeader."Ship-to Name");
//             AddToJson('trade_name', SalesInvoiceHeader."Ship-to Name");
//             AddToJson('address1', SalesInvoiceHeader."Ship-to Address");
//             AddToJson('address2', SalesInvoiceHeader."Ship-to Address 2");
//             AddToJson('location', SalesInvoiceHeader."Ship-to City");
//             if SalesInvoiceHeader."GST Customer Type" = SalesInvoiceHeader."gst customer type"::Export then begin
//                 AddToJson('pincode', '999999');
//                 AddToJson('state_code', '96')
//             end else begin
//                 AddToJson('pincode', SalesInvoiceHeader."Ship-to Post Code");
//                 AddToJson('state_code', GetStateCode(SalesInvoiceHeader."GST Ship-to State Code"));
//             end;
//             JsonTextWriter.WriteEndObject;
//         end;
//         //END;
//         if SalesInvoiceHeader."GST Customer Type" in
//                  [SalesInvoiceHeader."gst customer type"::Export]
//               then begin
//             if SalesInvoiceHeader."Currency Factor" <> 0 then
//                 LCYCurrency := (1 / SalesInvoiceHeader."Currency Factor")
//             else
//                 LCYCurrency := 1;
//             JsonTextWriter.WritePropertyName('export_details');
//             JsonTextWriter.WriteStartObject;
//             AddToJson('ship_bill_number', SalesInvoiceHeader."Bill Of Export No.");
//             AddToJson('ship_bill_date', GetDateFormated(SalesInvoiceHeader."Bill Of Export Date"));
//             AddToJson('port_code', SalesInvoiceHeader."Exit Point");
//             AddToJson('country_code', SalesInvoiceHeader."Bill-to Country/Region Code");
//             AddToJson('foreign_currency', SalesInvoiceHeader."Currency Code");
//             JsonTextWriter.WriteEndObject;
//         end;
//         if (SalesInvoiceHeader."Invoice Type" = SalesInvoiceHeader."invoice type"::"Debit Note") or
//             (SalesInvoiceHeader."Invoice Type" = SalesInvoiceHeader."invoice type"::Supplementary)
//           then begin
//             RefDocNo := GetRefInvNo(SalesInvoiceHeader."No.");
//             if RefDocNo = '' then
//                 RefDocNo := SalesInvoiceHeader."Reference Invoice No.";
//             if SalesInvoiceHeader2.Get(RefDocNo) then begin
//                 JsonTextWriter.WritePropertyName('reference_details');
//                 JsonTextWriter.WriteStartObject;
//                 AddToJson('invoice_remarks', 'Sales Invoice');
//                 JsonTextWriter.WritePropertyName('document_period_details');
//                 JsonTextWriter.WriteStartObject;
//                 AddToJson('invoice_period_start_date', GetDateFormated(SalesInvoiceHeader2."Posting Date"));
//                 AddToJson('invoice_period_end_date', GetDateFormated(SalesInvoiceHeader2."Posting Date"));
//                 JsonTextWriter.WriteEndObject;
//                 JsonTextWriter.WritePropertyName('preceding_document_details');
//                 JsonTextWriter.WriteStartArray;
//                 JsonTextWriter.WriteStartObject;
//                 AddToJson('reference_of_original_invoice', RefDocNo);
//                 AddToJson('preceding_invoice_date', GetDateFormated(SalesInvoiceHeader2."Posting Date"));
//                 JsonTextWriter.WriteEndObject;
//                 JsonTextWriter.WriteEndArray;
//                 JsonTextWriter.WriteEndObject;
//             end;
//         end;
//         JsonTextWriter.WritePropertyName('value_details');
//         JsonTextWriter.WriteStartObject;
//         AddToJson('total_assessable_value', ROUND(GetTaxableAmountSalesInvoice(SalesInvoiceHeader."No.") * LCYCurrency, 0.01, '='));
//         AddToJson('total_cgst_value', GetGSTAmount(SalesInvoiceHeader."No.", 'CGST'));
//         AddToJson('total_sgst_value', GetGSTAmount(SalesInvoiceHeader."No.", 'SGST'));
//         AddToJson('total_igst_value', GetGSTAmount(SalesInvoiceHeader."No.", 'IGST'));
//         AddToJson('total_cess_value', GetGSTAmount(SalesInvoiceHeader."No.", 'CESS'));
//         SalesInvoiceLine2.SetRange("Document No.", SalesInvoiceHeader."No.");
//         SalesInvoiceLine2.SetFilter(Quantity, '<>%1', 0);
//         SalesInvoiceLine2.CalcSums("Line Amount", "Inv. Discount Amount", "Total GST Amount", "TDS/TCS Amount");
//         //AddToJson('total_discount',SalesInvoiceLine2."Inv. Discount Amount"*LCYCurrency);
//         if SalesInvoiceLine2."TDS/TCS Amount" <> 0 then
//             AddToJson('total_other_charge', SalesInvoiceLine2."TDS/TCS Amount");
//         AddToJson('total_invoice_value', ROUND((SalesInvoiceLine2."Line Amount" + SalesInvoiceLine2."Total GST Amount" + SalesInvoiceLine2."TDS/TCS Amount" - SalesInvoiceLine2."Inv. Discount Amount") * LCYCurrency, 0.01, '='));
//         GetRoundingGL(Customer."Customer Posting Group", GstRoundingGL, InvRoundingGL, PITRoundingGL);
//         SalesInvoiceLine2.SetRange(Type, SalesInvoiceLine2.Type::"G/L Account");
//         if GstRoundingGL <> '' then
//             SalesInvoiceLine2.SetFilter("No.", '%1|%2|%3', GstRoundingGL, InvRoundingGL, PITRoundingGL) //Rounding G/L
//         else
//             SalesInvoiceLine2.SetFilter("No.", '%1|%2', InvRoundingGL, PITRoundingGL);
//         SalesInvoiceLine2.CalcSums("Line Amount");
//         AddToJson('round_off_amount', ROUND(SalesInvoiceLine2."Line Amount" * LCYCurrency, 0.01, '='));
//         JsonTextWriter.WriteEndObject;
//         Clear(SNo);
//         SalesInvoiceLine.SetRange("Document No.", SalesInvoiceHeader."No.");
//         if GstRoundingGL <> '' then
//             SalesInvoiceLine.SetFilter("No.", '<>%1&<>%2&<>%3', GstRoundingGL, InvRoundingGL, PITRoundingGL) //Rounding G/L
//         else
//             SalesInvoiceLine.SetFilter("No.", '<>%1&<>%2', InvRoundingGL, PITRoundingGL);
//         SalesInvoiceLine.SetFilter(Quantity, '<>%1', 0);
//         if SalesInvoiceLine.FindSet then begin
//             JsonTextWriter.WritePropertyName('item_list');
//             JsonTextWriter.WriteStartArray;
//             repeat
//                 //ALLE SB_09122022 +
//                 Clear(ItemDesc_GTxt);
//                 Clear(ItemDesc_GtextN);
//                 //ALLE SB_09122022 -
//                 SNo += 1;
//                 JsonTextWriter.WriteStartObject;
//                 AddToJson('item_serial_number', SNo);
//                 //ALLE SB_09122022 +
//                 ItemDesc_GTxt := DelChr(SalesInvoiceLine.Description, '=', '®');
//                 ItemDesc_GtextN := DelChr(ItemDesc_GTxt, '=', '™');
//                 AddToJson('product_description', ItemDesc_GtextN);
//                 //ALLE SB_09122022 -
//                 if SalesInvoiceLine."GST Group Type" = SalesInvoiceLine."gst group type"::Service then
//                     AddToJson('is_service', 'Y')
//                 else
//                     AddToJson('is_service', 'N');
//                 AddToJson('hsn_code', SalesInvoiceLine."HSN/SAC Code");
//                 AddToJson('quantity', SalesInvoiceLine.Quantity);
//                 if SalesInvoiceLine."GST Group Type" = SalesInvoiceLine."gst group type"::Service then
//                     AddToJson('unit', 'OTH')
//                 else
//                     AddToJson('unit', GetUOM(SalesInvoiceLine."Unit of Measure Code"));
//                 AddToJson('unit_price', ROUND(SalesInvoiceLine."Unit Price" * LCYCurrency, 0.01, '='));
//                 AddToJson('total_amount', ROUND((SalesInvoiceLine."Unit Price" * SalesInvoiceLine.Quantity) * LCYCurrency, 0.01, '='));
//                 PostedStructureOrderDetails.SetRange(Type, PostedStructureOrderDetails.Type::Sale);
//                 PostedStructureOrderDetails.SetRange("Document Type", PostedStructureOrderDetails."document type"::Invoice);
//                 PostedStructureOrderDetails.SetRange(SalesInvoiceHeader."No.", SalesInvoiceHeader."No.");
//                 PostedStructureOrderDetails.SetRange("Structure Code", Structure);
//                 if PostedStructureOrderDetails.FindFirst then begin
//                     if (PostedStructureOrderDetails."Include Line Discount") and (PostedStructureOrderDetails."Include Invoice Discount") then
//                         AddToJson('discount', ROUND((SalesInvoiceLine."Line Discount Amount" + SalesInvoiceLine."Inv. Discount Amount") * LCYCurrency, 0.01, '='))
//                     else
//                         if (not PostedStructureOrderDetails."Include Line Discount") and (PostedStructureOrderDetails."Include Invoice Discount") then
//                             AddToJson('discount', ROUND((SalesInvoiceLine."Inv. Discount Amount") * LCYCurrency, 0.01, '='))
//                         else
//                             if (PostedStructureOrderDetails."Include Line Discount") and (not PostedStructureOrderDetails."Include Invoice Discount") then
//                                 AddToJson('discount', ROUND((SalesInvoiceLine."Line Discount Amount") * LCYCurrency, 0.01, '='));
//                 end;
//                 AddToJson('assessable_value', ROUND(SalesInvoiceLine."GST Base Amount" * LCYCurrency, 0.01, '='));
//                 if SalesInvoiceLine."GST Jurisdiction Type" = SalesInvoiceLine."gst jurisdiction type"::Interstate then
//                     AddToJson('gst_rate', GetGSTRate(SalesInvoiceLine."Document No.", 'IGST', SalesInvoiceLine."Line No."))
//                 else
//                     AddToJson('gst_rate', GetGSTRate(SalesInvoiceLine."Document No.", 'CGST', SalesInvoiceLine."Line No.") * 2);
//                 AddToJson('cgst_amount', GetGSTAmountLineWise(SalesInvoiceLine."Document No.", 'CGST', SalesInvoiceLine."Line No."));
//                 AddToJson('sgst_amount', GetGSTAmountLineWise(SalesInvoiceLine."Document No.", 'SGST', SalesInvoiceLine."Line No."));
//                 AddToJson('igst_amount', GetGSTAmountLineWise(SalesInvoiceLine."Document No.", 'IGST', SalesInvoiceLine."Line No."));
//                 AddToJson('cess_rate', GetGSTRate(SalesInvoiceLine."Document No.", 'CESS', SalesInvoiceLine."Line No."));
//                 AddToJson('cess_amount', GetGSTAmountLineWise(SalesInvoiceLine."Document No.", 'CESS', SalesInvoiceLine."Line No."));
//                 //AddToJson('cess_nonadvol_amount',0);
//                 //AddToJson('state_cess_rate',GetGSTRate(SalesInvoiceLine."Document No.",'CESS',SalesInvoiceLine."Line No."));
//                 //AddToJson('state_cess_amount',GetGSTAmountLineWise(SalesInvoiceLine."Document No.",'CESS',SalesInvoiceLine."Line No."));
//                 AddToJson('total_item_value', ROUND((SalesInvoiceLine."Line Amount" + SalesInvoiceLine."Total GST Amount" - SalesInvoiceLine."Inv. Discount Amount") * LCYCurrency, 0.01, '='));
//                 JsonTextWriter.WriteEndObject;
//             until SalesInvoiceLine.Next = 0;
//         end;
//         JsonTextWriter.WriteEndArray;
//         EndJson;
//         GenerateEInvoice('', ResponseText);
//         Json := ResponseText;
//         ReadJSon(Json, DataExch);
//         AckNo := GetJsonNodeValue('results.message.AckNo');
//         AckDt := GetJsonNodeValue('results.message.AckDt');
//         Irn := GetJsonNodeValue('results.message.Irn');
//         SignedQRCode := GetJsonNodeValue('results.message.SignedQRCode');
//         if GetJsonNodeValue('results.requestId') <> '' then begin
//             RequestString := CopyStr(GetJsonNodeValue('results.requestId'), StrPos(GetJsonNodeValue('results.requestId'), '_') + 1, StrLen(GetJsonNodeValue('results.requestId')));
//             DocNo := CopyStr(RequestString, 1, StrPos(RequestString, '_') - 1);
//             InsertResponse(GetJsonNodeValue('results.requestId'), DocNo, 1, AckNo, AckDt, Irn,
//                             SignedQRCode, GetJsonNodeValue('results.status'), GetJsonNodeValue('results.errorMessage'), SalesInvoiceHeader."Posting Date"
//                      , GetJsonNodeValue('results.message.QRCodeUrl'), GetJsonNodeValue('results.message.EinvoicePdf'), GetJsonNodeValue('results.InfoDtls'));
//             Commit;
//             if Irn <> '' then begin
//                 Message(Text50000, DocNo);
//                 //UpdateIRNOnDoc(SalesInvoiceHeader."No.",1,Irn);
//                 // IRN/QR Code can be updated On SIH if updated GST Patch is available
//             end else
//                 Error(Text50001, GetJsonNodeValue('results.errorMessage'), GetJsonNodeValue('results.requestId'));
//         end else
//             Error(Text50002);
//     end;
//     local procedure CreateJSONTransferShipment(TransferShipmentHeader: Record "Transfer Shipment Header")
//     var
//         TransferShipmentLine: Record "Transfer Shipment Line";
//         ShiptoAddress: Record "Ship-to Address";
//         TransferShipmentHeader2: Record "Transfer Shipment Header";
//         DataExch: Record "Data Exch. Field";
//         TransportMethod: Record "Transport Method";
//         Location: Record Location;
//         State_rec: Record State;
//         EInvIntegrationSetup: Record "SSD E-Inv Integration Setup";
//         eCommerceMerchantId: Record "e-Commerce Merchant Id";
//         LocationTo: Record Location;
//         TransferShipmentLine2: Record "Transfer Shipment Line";
//         TempBlob: Record TempBlob;
//         ResponseInStream_L: InStream;
//         OutStrm: OutStream;
//         FL: File;
//         HttpStatusCode_L: dotnet HttpStatusCode;
//         ResponseHeaders_L: dotnet NameValueCollection;
//         CustGstin: Code[15];
//         State_Gst: Code[2];
//         CustGstin2: Code[15];
//         DocNo: Code[20];
//         RequestString: Text;
//         TknNo: Text[50];
//         ResponseText: Text;
//         JString: Text;
//         AckNo: Text;
//         Irn: Text;
//         Mnth: Text[2];
//         Day: Text[2];
//         SignedQRCode: Text;
//         SNo: Integer;
//         Text50000: label 'E-Invoice generated successfully for Document No. %1.';
//         Text50001: label '%1 Please share this request ID for support %2.';
//         AckDt: Variant;
//         Text50002: label 'No Response captured.';
//     begin
//         if not CheckGST(TransferShipmentHeader."No.") then
//             exit;
//         EInvIntegrationSetup.Get;
//         GetCompanyInfo;
//         TknNo := GetAccessToken;
//         Location.Get(TransferShipmentHeader."Transfer-from Code");
//         LocationTo.Get(TransferShipmentHeader."Transfer-to Code");
//         //IF Location."State Code" = LocationTo."State Code" THEN
//         if Location."GST Registration No." = LocationTo."GST Registration No." then
//             exit;
//         CheckEInvoiceStatus(TransferShipmentHeader."No.", 3);
//         StartJson;
//         AddToJson('access_token', TknNo);
//         //AddToJson('user_gstin','09AAAPG7885R002'); //For SandBox
//         AddToJson('user_gstin', GetGSTIN(TransferShipmentHeader."Transfer-from Code"));
//         AddToJson('data_soure', 'erp');
//         JsonTextWriter.WritePropertyName('transaction_details');
//         JsonTextWriter.WriteStartObject;
//         AddToJson('supply_type', 'B2B');
//         AddToJson('charge_type', 'N');
//         JsonTextWriter.WriteEndObject;
//         JsonTextWriter.WritePropertyName('document_details');
//         JsonTextWriter.WriteStartObject;
//         AddToJson('document_type', 'INV');
//         AddToJson('document_number', TransferShipmentHeader."No.");
//         AddToJson('document_date', GetDateFormated(TransferShipmentHeader."Posting Date"));
//         JsonTextWriter.WriteEndObject;
//         JsonTextWriter.WritePropertyName('seller_details');
//         JsonTextWriter.WriteStartObject;
//         AddToJson('gstin', GetGSTIN(TransferShipmentHeader."Transfer-from Code"));
//         //AddToJson('gstin','09AAAPG7885R002'); //For SandBox
//         AddToJson('legal_name', CompanyInformation.Name);
//         AddToJson('trade_name', Location.Name);
//         AddToJson('address1', Location.Address);
//         AddToJson('address2', Location."Address 2");
//         AddToJson('location', Location.City);
//         AddToJson('pincode', Location."Post Code");
//         AddToJson('state_code', GetStateCode(Location."State Code"));
//         JsonTextWriter.WriteEndObject;
//         JsonTextWriter.WritePropertyName('buyer_details');
//         JsonTextWriter.WriteStartObject;
//         AddToJson('gstin', GetGSTIN(TransferShipmentHeader."Transfer-to Code"));
//         //AddToJson('gstin','05AAAPG7885R002'); //For SandBox
//         AddToJson('legal_name', CompanyInformation.Name);
//         AddToJson('trade_name', LocationTo.Name);
//         AddToJson('address1', LocationTo.Address);
//         AddToJson('address2', LocationTo."Address 2");
//         AddToJson('location', LocationTo.City);
//         AddToJson('pincode', LocationTo."Post Code");
//         AddToJson('place_of_supply', GetStateCode_POS(LocationTo."State Code"));
//         AddToJson('state_code', GetStateCode(LocationTo."State Code"));
//         JsonTextWriter.WriteEndObject;
//         JsonTextWriter.WritePropertyName('value_details');
//         JsonTextWriter.WriteStartObject;
//         AddToJson('total_assessable_value', ROUND(GetTaxableAmountTransfer(TransferShipmentHeader."No."), 0.01, '='));
//         AddToJson('total_cgst_value', GetGSTAmount(TransferShipmentHeader."No.", 'CGST'));
//         AddToJson('total_sgst_value', GetGSTAmount(TransferShipmentHeader."No.", 'SGST'));
//         AddToJson('total_igst_value', GetGSTAmount(TransferShipmentHeader."No.", 'IGST'));
//         AddToJson('total_cess_value', GetGSTAmount(TransferShipmentHeader."No.", 'CESS'));
//         //AddToJson('total_cess_value_of_state',GetGSTAmount("No.",'CESS'));
//         TransferShipmentLine2.SetRange("Document No.", TransferShipmentHeader."No.");
//         TransferShipmentLine2.SetFilter(Quantity, '<>%1', 0);
//         TransferShipmentLine2.CalcSums("Total GST Amount");
//         AddToJson('total_invoice_value', ROUND(GetTaxableAmountTransfer(TransferShipmentHeader."No.") + TransferShipmentLine2."Total GST Amount", 0.01, '='));
//         JsonTextWriter.WriteEndObject;
//         Clear(SNo);
//         TransferShipmentLine.SetRange("Document No.", TransferShipmentHeader."No.");
//         TransferShipmentLine.SetFilter("Item No.", '<>%1', '');
//         TransferShipmentLine.SetFilter(Quantity, '<>%1', 0);
//         if TransferShipmentLine.FindSet then begin
//             JsonTextWriter.WritePropertyName('item_list');
//             JsonTextWriter.WriteStartArray;
//             repeat
//                 SNo += 1;
//                 JsonTextWriter.WriteStartObject;
//                 AddToJson('item_serial_number', SNo);
//                 AddToJson('product_description', DelChr(TransferShipmentLine.Description, '=', '®'));
//                 AddToJson('is_service', 'N');
//                 AddToJson('hsn_code', TransferShipmentLine."HSN/SAC Code");
//                 AddToJson('quantity', TransferShipmentLine.Quantity);
//                 AddToJson('unit', GetUOM(TransferShipmentLine."Unit of Measure Code"));
//                 AddToJson('unit_price', ROUND(TransferShipmentLine."Unit Price", 0.01, '='));
//                 AddToJson('total_amount', ROUND(TransferShipmentLine."GST Base Amount", 0.01, '='));
//                 AddToJson('assessable_value', ROUND(TransferShipmentLine."GST Base Amount", 0.01, '='));
//                 if Location."State Code" <> LocationTo."State Code" then
//                     AddToJson('gst_rate', GetGSTRate(TransferShipmentLine."Document No.", 'IGST', TransferShipmentLine."Line No."))
//                 else
//                     AddToJson('gst_rate', GetGSTRate(TransferShipmentLine."Document No.", 'CGST', TransferShipmentLine."Line No.") * 2);
//                 AddToJson('cgst_amount', GetGSTAmountLineWise(TransferShipmentLine."Document No.", 'CGST', TransferShipmentLine."Line No."));
//                 AddToJson('sgst_amount', GetGSTAmountLineWise(TransferShipmentLine."Document No.", 'SGST', TransferShipmentLine."Line No."));
//                 AddToJson('igst_amount', GetGSTAmountLineWise(TransferShipmentLine."Document No.", 'IGST', TransferShipmentLine."Line No."));
//                 AddToJson('cess_rate', GetGSTRate(TransferShipmentLine."Document No.", 'CESS', TransferShipmentLine."Line No."));
//                 AddToJson('cess_amount', GetGSTAmountLineWise(TransferShipmentLine."Document No.", 'CESS', TransferShipmentLine."Line No."));
//                 AddToJson('cess_nonadvol_value', 0);
//                 //AddToJson('state_cess_rate',GetGSTRate(TransferShipmentLine."Document No.",'CESS',TransferShipmentLine."Line No."));
//                 //AddToJson('state_cess_amount',GetGSTAmountLineWise(TransferShipmentLine."Document No.",'CESS',TransferShipmentLine."Line No."));
//                 AddToJson('total_item_value', ROUND(TransferShipmentLine."GST Base Amount" + TransferShipmentLine."Total GST Amount", 0.01, '='));
//                 JsonTextWriter.WriteEndObject;
//             until TransferShipmentLine.Next = 0;
//         end;
//         JsonTextWriter.WriteEndArray;
//         EndJson;
//         GenerateEInvoice('', ResponseText);
//         Json := ResponseText;
//         ReadJSon(Json, DataExch);
//         AckNo := GetJsonNodeValue('results.message.AckNo');
//         AckDt := GetJsonNodeValue('results.message.AckDt');
//         Irn := GetJsonNodeValue('results.message.Irn');
//         SignedQRCode := GetJsonNodeValue('results.message.SignedQRCode');
//         if GetJsonNodeValue('results.requestId') <> '' then begin
//             RequestString := CopyStr(GetJsonNodeValue('results.requestId'), StrPos(GetJsonNodeValue('results.requestId'), '_') + 1, StrLen(GetJsonNodeValue('results.requestId')));
//             DocNo := CopyStr(RequestString, 1, StrPos(RequestString, '_') - 1);
//             InsertResponse(GetJsonNodeValue('results.requestId'), DocNo, 3, AckNo, AckDt,
//                 Irn, SignedQRCode, GetJsonNodeValue('results.status'), GetJsonNodeValue('results.errorMessage'), TransferShipmentHeader."Posting Date"
//                               , GetJsonNodeValue('results.message.QRCodeUrl'), GetJsonNodeValue('results.message.EinvoicePdf'), GetJsonNodeValue('results.InfoDtls'));
//             Commit;
//             if Irn <> '' then
//                 Message(Text50000, DocNo)
//             else
//                 Error(Text50001, GetJsonNodeValue('results.errorMessage'), GetJsonNodeValue('results.requestId'));
//         end else
//             Error(Text50002);
//     end;
//     local procedure CreateJSONSalesCrmemo(SalesCrMemoHeader: Record "Sales Cr.Memo Header")
//     var
//         Customer: Record Customer;
//         SalesCrMemoLine: Record "Sales Cr.Memo Line";
//         ShiptoAddress: Record "Ship-to Address";
//         SalesCrMemoHeader2: Record "Sales Cr.Memo Header";
//         DataExch: Record "Data Exch. Field";
//         TransportMethod: Record "Transport Method";
//         Location: Record Location;
//         State_rec: Record State;
//         EInvIntegrationSetup: Record "SSD E-Inv Integration Setup";
//         eCommerceMerchantId: Record "e-Commerce Merchant Id";
//         SalesInvoiceHeader: Record "Sales Invoice Header";
//         EInvoicingRequests: Record "SSD E-Invoicing Requests";
//         TempBlob: Record TempBlob;
//         SalesCrMemoLine2: Record "Sales Cr.Memo Line";
//         SalesCrMemoLine3: Record "Sales Cr.Memo Line";
//         PostedStructureOrderDetails: Record "Posted Structure Order Details";
//         ResponseInStream_L: InStream;
//         OutStrm: OutStream;
//         FL: File;
//         HttpStatusCode_L: dotnet HttpStatusCode;
//         ResponseHeaders_L: dotnet NameValueCollection;
//         CustGstin: Code[15];
//         State_Gst: Code[2];
//         RefDocNo: Code[20];
//         GstRoundingGL: Code[20];
//         InvRoundingGL: Code[20];
//         PITRoundingGL: Code[20];
//         DocNo: Code[20];
//         RequestString: Text;
//         TknNo: Text[50];
//         ResponseText: Text;
//         JString: Text;
//         AckNo: Text;
//         Irn: Text;
//         Mnth: Text[2];
//         Day: Text[2];
//         SignedQRCode: Text;
//         Text50000: label 'You cannot generate E-Invoice for Credit Memo %1 as E-Invoice for Applied Invoice %2 is not generated.';
//         AckDt: Variant;
//         SNo: Integer;
//         LCYCurrency: Decimal;
//         Text50001: label 'E-Invoice generated successfully for Document No. %1.';
//         Text50002: label '%1 Please share this request ID for support %2.';
//         Text50003: label 'No Response captured.';
//     begin
//         if not CheckGST(SalesCrMemoHeader."No.") then
//             exit;
//         EInvIntegrationSetup.Get;
//         if (SalesCrMemoHeader."Nature of Supply" = SalesCrMemoHeader."nature of supply"::B2C) then
//             exit;
//         RefDocNo := GetRefInvNo(SalesCrMemoHeader."No.");
//         if RefDocNo = '' then
//             RefDocNo := SalesCrMemoHeader."Reference Invoice No.";
//         if SalesInvoiceHeader.Get(RefDocNo) then
//             // IF SalesInvoiceHeader."Posting Date" >= EInvIntegrationSetup."Activation Date" THEN BEGIN // Date acc. to E-Inv Live Date
//             //EXIT;
//             EInvoicingRequests.SetCurrentkey("Document Type", "Document No.", "E-Invoice Generated");
//         EInvoicingRequests.SetRange("Document Type", EInvoicingRequests."document type"::"Sale Invoice");
//         EInvoicingRequests.SetRange("Document No.", RefDocNo);
//         EInvoicingRequests.SetRange("E-Invoice Generated", false);
//         if EInvoicingRequests.FindFirst then
//             Error(Text50000, SalesCrMemoHeader."No.", RefDocNo);
//         //  END;
//         CheckEInvoiceStatus(SalesCrMemoHeader."No.", 2);
//         GetCompanyInfo;
//         TknNo := GetAccessToken;
//         Location.Get(SalesCrMemoHeader."Location Code");
//         Customer.Get(SalesCrMemoHeader."Bill-to Customer No.");
//         LCYCurrency := 1;
//         StartJson;
//         AddToJson('access_token', TknNo);
//         //AddToJson('user_gstin','09AAAPG7885R002'); //For SandBox
//         AddToJson('user_gstin', GetGSTIN(SalesCrMemoHeader."Location Code"));
//         AddToJson('data_soure', 'erp');
//         JsonTextWriter.WritePropertyName('transaction_details');
//         JsonTextWriter.WriteStartObject;
//         case SalesCrMemoHeader."GST Customer Type" of
//             SalesCrMemoHeader."gst customer type"::Export:
//                 begin
//                     if SalesCrMemoHeader."GST Without Payment of Duty" then
//                         AddToJson('supply_type', 'EXPWOP')
//                     else
//                         AddToJson('supply_type', 'EXPWP');
//                 end;
//             SalesCrMemoHeader."gst customer type"::"SEZ Development", SalesCrMemoHeader."gst customer type"::"SEZ Unit":
//                 begin
//                     if SalesCrMemoHeader."GST Without Payment of Duty" then
//                         AddToJson('supply_type', 'SEZWOP')
//                     else
//                         AddToJson('supply_type', 'SEZWP');
//                 end;
//             SalesCrMemoHeader."gst customer type"::"Deemed Export":
//                 AddToJson('supply_type', 'DEXP');
//             SalesCrMemoHeader."gst customer type"::Registered, SalesCrMemoHeader."gst customer type"::Exempted:
//                 AddToJson('supply_type', 'B2B');
//         end;
//         AddToJson('charge_type', 'N');
//         if SalesCrMemoHeader."POS Out Of India" then
//             AddToJson('igst_on_intra', 'Y')
//         else
//             AddToJson('igst_on_intra', 'N');
//         if SalesCrMemoHeader."e-Commerce Customer" <> '' then begin
//             if eCommerceMerchantId.Get(SalesCrMemoHeader."e-Commerce Customer", SalesCrMemoHeader."e-Commerce Merchant Id") then
//                 AddToJson('ecommerce_gstin', eCommerceMerchantId."Company GST Reg. No.");
//         end;
//         JsonTextWriter.WriteEndObject;
//         JsonTextWriter.WritePropertyName('document_details');
//         JsonTextWriter.WriteStartObject;
//         AddToJson('document_type', 'CRN');
//         AddToJson('document_number', SalesCrMemoHeader."No.");
//         AddToJson('document_date', GetDateFormated(SalesCrMemoHeader."Posting Date"));
//         JsonTextWriter.WriteEndObject;
//         JsonTextWriter.WritePropertyName('seller_details');
//         JsonTextWriter.WriteStartObject;
//         AddToJson('gstin', GetGSTIN(SalesCrMemoHeader."Location Code"));
//         //AddToJson('gstin','09AAAPG7885R002');//For SandBox
//         AddToJson('legal_name', CompanyInformation.Name);
//         AddToJson('trade_name', Location.Name);
//         AddToJson('address1', Location.Address);
//         AddToJson('address2', Location."Address 2");
//         AddToJson('location', Location.City);
//         AddToJson('pincode', Location."Post Code");
//         AddToJson('state_code', GetStateCode(Location."State Code"));
//         JsonTextWriter.WriteEndObject;
//         JsonTextWriter.WritePropertyName('buyer_details');
//         JsonTextWriter.WriteStartObject;
//         if (SalesCrMemoHeader."GST Customer Type" = SalesCrMemoHeader."gst customer type"::Export) then
//             AddToJson('gstin', 'URP')
//         else
//             AddToJson('gstin', Customer."GST Registration No.");
//         //AddToJson('gstin','05AAAPG7885R002'); //For SandBox
//         AddToJson('legal_name', SalesCrMemoHeader."Bill-to Name");
//         AddToJson('trade_name', SalesCrMemoHeader."Bill-to Name");
//         SalesCrMemoLine3.SetRange("Document No.", SalesCrMemoHeader."No.");
//         SalesCrMemoLine3.SetFilter("GST Place of Supply", '<>%1', SalesCrMemoLine3."gst place of supply"::" ");
//         if SalesCrMemoLine3.FindFirst then
//             if SalesCrMemoLine3."GST Place of Supply" = SalesCrMemoLine3."gst place of supply"::"Bill-to Address" then begin
//                 AddToJson('address1', SalesCrMemoHeader."Bill-to Address");
//                 AddToJson('address2', SalesCrMemoHeader."Bill-to Address 2");
//                 AddToJson('location', SalesCrMemoHeader."Bill-to City");
//                 if SalesCrMemoHeader."GST Customer Type" in [SalesCrMemoHeader."gst customer type"::Export, SalesCrMemoHeader."gst customer type"::"Deemed Export", SalesCrMemoHeader."gst customer type"::"SEZ Development", SalesCrMemoHeader."gst customer type"::"SEZ Unit"] then
//                     AddToJson('place_of_supply', '96')
//                 else
//                     AddToJson('place_of_supply', GetStateCode_POS(SalesCrMemoHeader."GST Bill-to State Code"));
//                 if SalesCrMemoHeader."GST Customer Type" = SalesCrMemoHeader."gst customer type"::Export then
//                     AddToJson('state_code', '96')
//                 else
//                     AddToJson('state_code', GetStateCode(SalesCrMemoHeader."GST Bill-to State Code"));
//             end else
//                 if SalesCrMemoLine3."GST Place of Supply" = SalesCrMemoLine3."gst place of supply"::"Ship-to Address" then begin
//                     if ShiptoAddress.Get(SalesCrMemoHeader."Sell-to Customer No.", SalesCrMemoHeader."Ship-to Code") then begin
//                         AddToJson('address1', ShiptoAddress.Address);
//                         AddToJson('address2', ShiptoAddress."Address 2");
//                         AddToJson('location', ShiptoAddress.City);
//                     end;
//                     if SalesCrMemoHeader."GST Customer Type" in [SalesCrMemoHeader."gst customer type"::Export, SalesCrMemoHeader."gst customer type"::"Deemed Export", SalesCrMemoHeader."gst customer type"::"SEZ Development", SalesCrMemoHeader."gst customer type"::"SEZ Unit"] then
//                         AddToJson('place_of_supply', '96')
//                     else
//                         AddToJson('place_of_supply', GetStateCode_POS(SalesCrMemoHeader."GST Ship-to State Code"));
//                     if SalesCrMemoHeader."GST Customer Type" = SalesCrMemoHeader."gst customer type"::Export then
//                         AddToJson('state_code', '96')
//                     else
//                         AddToJson('state_code', GetStateCode(SalesCrMemoHeader."GST Ship-to State Code"));
//                 end;
//         if SalesCrMemoHeader."GST Customer Type" = SalesCrMemoHeader."gst customer type"::Export then
//             AddToJson('pincode', '999999')
//         else
//             AddToJson('pincode', SalesCrMemoHeader."Bill-to Post Code");
//         JsonTextWriter.WriteEndObject;
//         /*IF ("GST Customer Type" = "GST Customer Type"::Export) THEN BEGIN
//           // Port Address Details in ship To Address(New Table Exit/Entry Point Details is created)
//           IF ExitEntryPointDetails.GET("Exit Point") THEN;
//           JsonTextWriter.WritePropertyName('ship_details');
//           JsonTextWriter.WriteStartObject;
//           AddToJson('gstin','URP');
//           AddToJson('legal_name',ExitEntryPointDetails.Name);
//           AddToJson('trade_name',ExitEntryPointDetails.Name);
//           AddToJson('address1',ExitEntryPointDetails.Address);
//           AddToJson('address2',ExitEntryPointDetails.Address2);
//           AddToJson('location',ExitEntryPointDetails.City);
//           AddToJson('pincode',ExitEntryPointDetails."Post Code");
//           AddToJson('state_code',GetStateCode(ExitEntryPointDetails."State Code"));
//           JsonTextWriter.WriteEndObject;
//         END ELSE BEGIN*/
//         if (SalesCrMemoHeader."Ship-to Code" <> '') and (ShiptoAddress.Get(SalesCrMemoHeader."Sell-to Customer No.", SalesCrMemoHeader."Ship-to Code")) then begin
//             CustGstin := ShiptoAddress."GST Registration No.";
//             JsonTextWriter.WritePropertyName('ship_details');
//             JsonTextWriter.WriteStartObject;
//             if SalesCrMemoHeader."GST Customer Type" = SalesCrMemoHeader."gst customer type"::Export then
//                 AddToJson('gstin', 'URP')
//             else
//                 AddToJson('gstin', CustGstin);
//             //AddToJson('gstin','05AAABB0639G1Z8'); //For SandBox
//             AddToJson('legal_name', SalesCrMemoHeader."Ship-to Name");
//             AddToJson('trade_name', SalesCrMemoHeader."Ship-to Name");
//             AddToJson('address1', SalesCrMemoHeader."Ship-to Address");
//             AddToJson('address2', SalesCrMemoHeader."Ship-to Address 2");
//             AddToJson('location', SalesCrMemoHeader."Ship-to City");
//             if SalesCrMemoHeader."GST Customer Type" = SalesCrMemoHeader."gst customer type"::Export then begin
//                 AddToJson('pincode', '999999');
//                 AddToJson('state_code', '96')
//             end else begin
//                 AddToJson('pincode', SalesCrMemoHeader."Ship-to Post Code");
//                 AddToJson('state_code', GetStateCode(SalesCrMemoHeader."GST Ship-to State Code"));
//             end;
//             JsonTextWriter.WriteEndObject;
//         end;
//         //END;
//         if SalesCrMemoHeader."GST Customer Type" in
//             [SalesCrMemoHeader."gst customer type"::Export]
//                then begin
//             if SalesCrMemoHeader."Currency Factor" <> 0 then
//                 LCYCurrency := (1 / SalesCrMemoHeader."Currency Factor")
//             else
//                 LCYCurrency := 1;
//             JsonTextWriter.WritePropertyName('export_details');
//             JsonTextWriter.WriteStartObject;
//             AddToJson('ship_bill_number', SalesCrMemoHeader."Bill Of Export No.");
//             AddToJson('ship_bill_date', GetDateFormated(SalesCrMemoHeader."Bill Of Export Date"));
//             AddToJson('port_code', SalesCrMemoHeader."Exit Point");
//             AddToJson('country_code', SalesCrMemoHeader."Bill-to Country/Region Code");
//             AddToJson('foreign_currency', SalesCrMemoHeader."Currency Code");
//             JsonTextWriter.WriteEndObject;
//         end;
//         JsonTextWriter.WritePropertyName('reference_details');
//         JsonTextWriter.WriteStartObject;
//         AddToJson('invoice_remarks', 'Sale Return');
//         JsonTextWriter.WritePropertyName('document_period_details');
//         JsonTextWriter.WriteStartObject;
//         AddToJson('invoice_period_start_date', GetDateFormated(SalesInvoiceHeader."Posting Date"));
//         AddToJson('invoice_period_end_date', GetDateFormated(SalesInvoiceHeader."Posting Date"));
//         JsonTextWriter.WriteEndObject;
//         JsonTextWriter.WritePropertyName('preceding_document_details');
//         JsonTextWriter.WriteStartArray;
//         JsonTextWriter.WriteStartObject;
//         AddToJson('reference_of_original_invoice', RefDocNo);
//         AddToJson('preceding_invoice_date', GetDateFormated(SalesInvoiceHeader."Posting Date"));
//         JsonTextWriter.WriteEndObject;
//         JsonTextWriter.WriteEndArray;
//         JsonTextWriter.WriteEndObject;
//         JsonTextWriter.WritePropertyName('value_details');
//         JsonTextWriter.WriteStartObject;
//         AddToJson('total_assessable_value', ROUND(GetTaxableAmountSCrMemo(SalesCrMemoHeader."No.") * LCYCurrency, 0.01, '='));
//         AddToJson('total_cgst_value', GetGSTAmount(SalesCrMemoHeader."No.", 'CGST'));
//         AddToJson('total_sgst_value', GetGSTAmount(SalesCrMemoHeader."No.", 'SGST'));
//         AddToJson('total_igst_value', GetGSTAmount(SalesCrMemoHeader."No.", 'IGST'));
//         AddToJson('total_cess_value', GetGSTAmount(SalesCrMemoHeader."No.", 'CESS'));
//         SalesCrMemoLine2.SetRange("Document No.", SalesCrMemoHeader."No.");
//         SalesCrMemoLine.SetFilter(Quantity, '<>%1', 0);
//         SalesCrMemoLine2.CalcSums("Line Amount", "Inv. Discount Amount", "Total GST Amount", "TDS/TCS Amount");
//         //AddToJson('total_discount',SalesCrMemoLine2."Inv. Discount Amount"*LCYCurrency);
//         if SalesCrMemoLine2."TDS/TCS Amount" <> 0 then
//             AddToJson('total_other_charge', SalesCrMemoLine2."TDS/TCS Amount");
//         AddToJson('total_invoice_value', ROUND((SalesCrMemoLine2."Line Amount" + SalesCrMemoLine2."Total GST Amount" + SalesCrMemoLine2."TDS/TCS Amount" - SalesCrMemoLine2."Inv. Discount Amount") * LCYCurrency, 0.01, '='));
//         GetRoundingGL(Customer."Customer Posting Group", GstRoundingGL, InvRoundingGL, PITRoundingGL);
//         SalesCrMemoLine2.SetRange(Type, SalesCrMemoLine2.Type::"G/L Account");
//         if GstRoundingGL <> '' then
//             SalesCrMemoLine2.SetFilter("No.", '%1|%2|%3', GstRoundingGL, InvRoundingGL, PITRoundingGL) //Rounding G/L
//         else
//             SalesCrMemoLine2.SetFilter("No.", '%1|%2', InvRoundingGL, PITRoundingGL);
//         SalesCrMemoLine2.CalcSums("Line Amount");
//         AddToJson('round_off_amount', ROUND(SalesCrMemoLine2."Line Amount" * LCYCurrency, 0.01, '='));
//         JsonTextWriter.WriteEndObject;
//         Clear(SNo);
//         SalesCrMemoLine.SetRange("Document No.", SalesCrMemoHeader."No.");
//         if GstRoundingGL <> '' then
//             SalesCrMemoLine.SetFilter("No.", '<>%1&<>%2&<>%3', GstRoundingGL, InvRoundingGL, PITRoundingGL) //Rounding G/L
//         else
//             SalesCrMemoLine.SetFilter("No.", '<>%1&<>%2', InvRoundingGL, PITRoundingGL);
//         SalesCrMemoLine.SetFilter(Quantity, '<>%1', 0);
//         if SalesCrMemoLine.FindSet then begin
//             JsonTextWriter.WritePropertyName('item_list');
//             JsonTextWriter.WriteStartArray;
//             repeat
//                 SNo += 1;
//                 JsonTextWriter.WriteStartObject;
//                 AddToJson('item_serial_number', SNo);
//                 AddToJson('product_description', SalesCrMemoLine.Description);
//                 if SalesCrMemoLine."GST Group Type" = SalesCrMemoLine."gst group type"::Service then
//                     AddToJson('is_service', 'Y')
//                 else
//                     AddToJson('is_service', 'N');
//                 AddToJson('hsn_code', SalesCrMemoLine."HSN/SAC Code");
//                 AddToJson('quantity', SalesCrMemoLine.Quantity);
//                 if SalesCrMemoLine."GST Group Type" = SalesCrMemoLine."gst group type"::Service then
//                     AddToJson('unit', 'OTH')
//                 else
//                     AddToJson('unit', GetUOM(SalesCrMemoLine."Unit of Measure Code"));
//                 AddToJson('unit_price', ROUND(SalesCrMemoLine."Unit Price" * LCYCurrency, 0.01, '='));
//                 AddToJson('total_amount', ROUND((SalesCrMemoLine."Unit Price" * SalesCrMemoLine.Quantity) * LCYCurrency, 0.01, '='));
//                 PostedStructureOrderDetails.SetRange(Type, PostedStructureOrderDetails.Type::Sale);
//                 PostedStructureOrderDetails.SetRange("Document Type", PostedStructureOrderDetails."document type"::"Credit Memo");
//                 PostedStructureOrderDetails.SetRange(SalesCrMemoHeader."No.", SalesCrMemoHeader."No.");
//                 PostedStructureOrderDetails.SetRange("Structure Code", Structure);
//                 if PostedStructureOrderDetails.FindFirst then begin
//                     if (PostedStructureOrderDetails."Include Line Discount") and (PostedStructureOrderDetails."Include Invoice Discount") then
//                         AddToJson('discount', ROUND((SalesCrMemoLine."Line Discount Amount" + SalesCrMemoLine."Inv. Discount Amount") * LCYCurrency, 0.01, '='))
//                     else
//                         if (not PostedStructureOrderDetails."Include Line Discount") and (PostedStructureOrderDetails."Include Invoice Discount") then
//                             AddToJson('discount', ROUND((SalesCrMemoLine."Inv. Discount Amount") * LCYCurrency, 0.01, '='))
//                         else
//                             if (PostedStructureOrderDetails."Include Line Discount") and (not PostedStructureOrderDetails."Include Invoice Discount") then
//                                 AddToJson('discount', ROUND((SalesCrMemoLine."Line Discount Amount") * LCYCurrency, 0.01, '='));
//                 end;
//                 AddToJson('assessable_value', ROUND(SalesCrMemoLine."GST Base Amount" * LCYCurrency, 0.01, '='));
//                 if SalesCrMemoLine."GST Jurisdiction Type" = SalesCrMemoLine."gst jurisdiction type"::Interstate then
//                     AddToJson('gst_rate', GetGSTRate(SalesCrMemoLine."Document No.", 'IGST', SalesCrMemoLine."Line No."))
//                 else
//                     AddToJson('gst_rate', GetGSTRate(SalesCrMemoLine."Document No.", 'CGST', SalesCrMemoLine."Line No.") * 2);
//                 AddToJson('cgst_amount', GetGSTAmountLineWise(SalesCrMemoLine."Document No.", 'CGST', SalesCrMemoLine."Line No."));
//                 AddToJson('sgst_amount', GetGSTAmountLineWise(SalesCrMemoLine."Document No.", 'SGST', SalesCrMemoLine."Line No."));
//                 AddToJson('igst_amount', GetGSTAmountLineWise(SalesCrMemoLine."Document No.", 'IGST', SalesCrMemoLine."Line No."));
//                 AddToJson('cess_rate', GetGSTRate(SalesCrMemoLine."Document No.", 'CESS', SalesCrMemoLine."Line No."));
//                 AddToJson('cess_amount', GetGSTAmountLineWise(SalesCrMemoLine."Document No.", 'CESS', SalesCrMemoLine."Line No."));
//                 //AddToJson('cess_nonadvol_amount',0);
//                 //AddToJson('state_cess_rate',GetGSTRate(SalesCrMemoLine."Document No.",'CESS',SalesCrMemoLine."Line No."));
//                 //AddToJson('state_cess_amount',GetGSTAmountLineWise(SalesCrMemoLine."Document No.",'CESS',SalesCrMemoLine."Line No."));
//                 AddToJson('total_item_value', ROUND((SalesCrMemoLine."Line Amount" + SalesCrMemoLine."Total GST Amount" - SalesCrMemoLine."Inv. Discount Amount") * LCYCurrency, 0.01, '='));
//                 JsonTextWriter.WriteEndObject;
//             until SalesCrMemoLine.Next = 0;
//         end;
//         JsonTextWriter.WriteEndArray;
//         EndJson;
//         GenerateEInvoice('', ResponseText);
//         Json := ResponseText;
//         ReadJSon(Json, DataExch);
//         AckNo := GetJsonNodeValue('results.message.AckNo');
//         AckDt := GetJsonNodeValue('results.message.AckDt');
//         Irn := GetJsonNodeValue('results.message.Irn');
//         SignedQRCode := GetJsonNodeValue('results.message.SignedQRCode');
//         if GetJsonNodeValue('results.requestId') <> '' then begin
//             RequestString := CopyStr(GetJsonNodeValue('results.requestId'), StrPos(GetJsonNodeValue('results.requestId'), '_') + 1, StrLen(GetJsonNodeValue('results.requestId')));
//             DocNo := CopyStr(RequestString, 1, StrPos(RequestString, '_') - 1);
//             InsertResponse(GetJsonNodeValue('results.requestId'), DocNo, 2, AckNo, AckDt, Irn,
//                   SignedQRCode, GetJsonNodeValue('results.status'), GetJsonNodeValue('results.errorMessage'), SalesCrMemoHeader."Posting Date"
//                               , GetJsonNodeValue('results.message.QRCodeUrl'), GetJsonNodeValue('results.message.EinvoicePdf'), GetJsonNodeValue('results.InfoDtls'));
//             Commit;
//             if Irn <> '' then begin
//                 Message(Text50001, DocNo);
//                 //UpdateIRNOnDoc(SalesCrMemoHeader."No.",2,Irn);
//             end else
//                 Error(Text50002, GetJsonNodeValue('results.errorMessage'), GetJsonNodeValue('results.requestId'));
//         end else
//             Error(Text50003);
//     end;
//     local procedure UpdateIRNOnDoc(DocNo: Code[20]; DocType: Option " ","Sale Invoice","Sale Cr. Memo",Transfer; IRN: Text)
//     var
//         SalesInvoiceHeader: Record "Sales Invoice Header";
//         SalesCrMemoHeader: Record "Sales Cr.Memo Header";
//         TransferShipmentHeader: Record "Transfer Shipment Header";
//     begin
//         /*IF DocType = 1 THEN BEGIN
//           IF SalesInvoiceHeader.GET(DocNo) THEN BEGIN
//             SalesInvoiceHeader."IRN Hash" := IRN;
//             SalesInvoiceHeader.MODIFY;
//           END;
//         END ELSE IF DocType = 2 THEN BEGIN
//           IF SalesCrMemoHeader.GET(DocNo) THEN BEGIN
//             SalesCrMemoHeader."IRN Hash" := IRN;
//             SalesCrMemoHeader.MODIFY;
//           END;
//         END;
//         */
//     end;
//     local procedure CheckEInvoiceStatus(DocumentNo: Code[20]; DocType: Option)
//     var
//         EInvoicingRequests: Record "SSD E-Invoicing Requests";
//         Text50000: label 'E-Invoice is already generated for Document No. %1.';
//     begin
//         EInvoicingRequests.SetCurrentkey("Document Type", "Document No.", "E-Invoice Generated");
//         EInvoicingRequests.SetRange("Document Type", DocType);
//         EInvoicingRequests.SetRange("Document No.", DocumentNo);
//         EInvoicingRequests.SetRange("E-Invoice Generated", true);
//         if EInvoicingRequests.FindFirst then
//             Error(Text50000, DocumentNo);
//     end;
//     [EventSubscriber(Objecttype::Codeunit, 33083461, 'CheckEInvoiceStatusForReportPrinting', '', false, false)]
//     local procedure CheckEInvoiceStatusForReportPrint(DocType: Option " ","Sale Invoice","Sale Cr. Memo",Transfer; DocNo: Code[20])
//     var
//         GSTManagement: Codeunit "GST Management";
//         EInvoicingRequests: Record "SSD E-Invoicing Requests";
//         Text50000: label 'E-Invoice is not generated for Document No. %1.';
//         SalesInvoiceHeader: Record "Sales Invoice Header";
//         SalesCrMemoHeader: Record "Sales Cr.Memo Header";
//         TransferShipmentHeader: Record "Transfer Shipment Header";
//         Location: Record Location;
//         LocationTo: Record Location;
//         EInvIntegrationSetup: Record "SSD E-Inv Integration Setup";
//     begin
//         EInvIntegrationSetup.Get;
//         case DocType of
//             Doctype::"Sale Invoice":
//                 begin
//                     if SalesInvoiceHeader.Get(DocNo) then begin
//                         if SalesInvoiceHeader."Nature of Supply" = SalesInvoiceHeader."nature of supply"::B2C then
//                             exit;
//                         if not GSTManagement.CheckGSTStrucure(SalesInvoiceHeader.Structure) then
//                             exit;
//                         //        IF SalesInvoiceHeader."Posting Date" < EInvIntegrationSetup."Activation Date" THEN  //Alle 01032021
//                         //          EXIT;
//                     end;
//                 end;
//             Doctype::"Sale Cr. Memo":
//                 begin
//                     if SalesCrMemoHeader.Get(DocNo) then begin
//                         if SalesCrMemoHeader."Nature of Supply" = SalesCrMemoHeader."nature of supply"::B2C then
//                             exit;
//                         if not GSTManagement.CheckGSTStrucure(SalesCrMemoHeader.Structure) then
//                             exit;
//                         //        IF SalesCrMemoHeader."Posting Date" < EInvIntegrationSetup."Activation Date" THEN  //Alle 03012021
//                         //          EXIT;
//                     end;
//                 end;
//             Doctype::Transfer:
//                 begin
//                     if TransferShipmentHeader.Get(DocNo) then begin
//                         Location.Get(TransferShipmentHeader."Transfer-from Code");
//                         LocationTo.Get(TransferShipmentHeader."Transfer-to Code");
//                         if Location."State Code" = LocationTo."State Code" then
//                             exit;
//                         if not GSTManagement.CheckGSTStrucure(TransferShipmentHeader.Structure) then
//                             exit;
//                         //        IF TransferShipmentHeader."Posting Date" < EInvIntegrationSetup."Activation Date" THEN  //Alle 01032021
//                         //          EXIT;
//                     end;
//                 end;
//         end;
//         EInvoicingRequests.SetCurrentkey("Document Type", "Document No.", "E-Invoice Generated");
//         EInvoicingRequests.SetRange("Document Type", DocType);
//         EInvoicingRequests.SetRange("Document No.", DocNo);
//         EInvoicingRequests.SetRange("E-Invoice Generated", true);
//         if not EInvoicingRequests.FindFirst then
//             Error(Text50000, DocNo);
//     end;
//     local procedure GetRefInvNo(DocNo: Code[20]) RefInvNo: Code[20]
//     var
//         ReferenceInvoiceNo: Record "Reference Invoice No.";
//     begin
//         ReferenceInvoiceNo.SetRange("Document No.", DocNo);
//         if ReferenceInvoiceNo.FindFirst then
//             RefInvNo := ReferenceInvoiceNo."Reference Invoice Nos."
//         else
//             RefInvNo := '';
//     end;
//     local procedure "//QRCode"()
//     begin
//     end;
//     local procedure GetQRCode(QRCodeInput: Text[1024]) QRCodeFileName: Text[1024]
//     var
//         [RunOnClient]
//         IBarCodeProvider: dotnet IBarcodeProvider;
//     begin
//         GetBarCodeProvider(IBarCodeProvider);
//         QRCodeFileName := IBarCodeProvider.GetBarcode(QRCodeInput);
//     end;
//     procedure MoveToMagicPath(SourceFileName: Text[1024]) DestinationFileName: Text[1024]
//     var
//         FileSystemObject: Automation FileSystemObject;
//     begin
//         // User Temp Path
//         DestinationFileName := FileManagement.ClientTempFileName('');
//         if ISCLEAR(FileSystemObject) then
//             Create(FileSystemObject, true, true);
//         FileSystemObject.MoveFile(SourceFileName, DestinationFileName);
//     end;
//     procedure GetBarCodeProvider(var IBarCodeProvider: dotnet IBarcodeProvider)
//     var
//         [RunOnClient]
//         QRCodeProvider: dotnet QRCodeProvider;
//     begin
//         QRCodeProvider := QRCodeProvider.QRCodeProvider;
//         IBarCodeProvider := QRCodeProvider;
//     end;
//     procedure GenerateQRCode(var EInvoicingRequests: Record "SSD E-Invoicing Requests")
//     var
//         QRCodeInput: Text[1024];
//         QRCodeFileName: Text[1024];
//         TempBlob: Record TempBlob;
//         Text50000: label 'QR Code doesn''t exist for Document No %1, as its E-Invoice is not processed.';
//     begin
//         QRCodeInput := EInvoicingRequests."Signed QR Code" + EInvoicingRequests."Signed QR Code2" + EInvoicingRequests."Signed QR Code3" + EInvoicingRequests."Signed QR Code4";
//         QRCodeFileName := GetQRCode(QRCodeInput);
//         QRCodeFileName := MoveToMagicPath(QRCodeFileName); // To avoid confirmation dialogue on RTC
//                                                            // Load the image from file into the BLOB field
//         Clear(TempBlob);
//         FileManagement.BLOBImport(TempBlob, QRCodeFileName);
//         if TempBlob.Blob.Hasvalue then
//             EInvoicingRequests."QR Image" := TempBlob.Blob;
//         // Erase the temporary file
//         if not ISSERVICETIER then
//             if Exists(QRCodeFileName) then
//                 Erase(QRCodeFileName);
//     end;
//     [EventSubscriber(Objecttype::Codeunit, 33083461, 'ReturnQRCodeEinvoicing', '', false, false)]
//     procedure ReturnQRImage(DocType: Option; DocNo: Code[20]; var TempBlob: Record TempBlob; var IRN: Text)
//     var
//         QRCodeInput: Text[1024];
//         QRCodeFileName: Text[1024];
//         Text50000: label 'QR Code doesn''t exist for Document No %1, as its E-Invoice is not processed.';
//         EInvoicingRequests: Record "SSD E-Invoicing Requests";
//     begin
//         EInvoicingRequests.SetCurrentkey("Document Type", "Document No.", "E-Invoice Generated");
//         EInvoicingRequests.SetRange("Document Type", DocType);
//         EInvoicingRequests.SetRange("Document No.", DocNo);
//         EInvoicingRequests.SetRange("E-Invoice Generated", true);
//         EInvoicingRequests.SetFilter("Signed QR Code", '<>%1', '');
//         if EInvoicingRequests.FindFirst then begin
//             QRCodeInput := EInvoicingRequests."Signed QR Code" + EInvoicingRequests."Signed QR Code2" + EInvoicingRequests."Signed QR Code3" + EInvoicingRequests."Signed QR Code4";
//             IRN := EInvoicingRequests."IRN No.";
//         end;
//         if QRCodeInput <> '' then begin
//             QRCodeFileName := GetQRCode(QRCodeInput);
//             QRCodeFileName := MoveToMagicPath(QRCodeFileName); // To avoid confirmation dialogue on RTC
//                                                                // Load the image from file into the BLOB field
//             Clear(TempBlob);
//             FileManagement.BLOBImport(TempBlob, QRCodeFileName);
//         end;
//     end;
//     procedure PrintQRCode(DocumentNo: Code[20]; DocType: Option)
//     var
//         QRCodeInput: Text[1024];
//         QRCodeFileName: Text[1024];
//         TempBlob: Record TempBlob;
//         EInvoicingRequests: Record "SSD E-Invoicing Requests";
//         SalesInvoiceHeader: Record "Sales Invoice Header";
//         TransferShipmentHeader: Record "Transfer Shipment Header";
//         SalesCrMemoHeader: Record "Sales Cr.Memo Header";
//         Text50000: label 'QR Code doesn''t exist for Document No %1, as its E-Invoice is not processed.';
//     begin
//         EInvoicingRequests.SetCurrentkey("Document Type", "Document No.", "E-Invoice Generated");
//         EInvoicingRequests.SetRange("Document Type", DocType);
//         EInvoicingRequests.SetRange("Document No.", DocumentNo);
//         EInvoicingRequests.SetRange("E-Invoice Generated", true);
//         EInvoicingRequests.SetFilter("Signed QR Code", '<>%1', '');
//         if EInvoicingRequests.FindFirst then
//             QRCodeInput := EInvoicingRequests."Signed QR Code" + EInvoicingRequests."Signed QR Code2" + EInvoicingRequests."Signed QR Code3" + EInvoicingRequests."Signed QR Code4";
//         //ELSE
//         //ERROR(Text50000,DocumentNo);
//         if QRCodeInput <> '' then begin
//             QRCodeFileName := GetQRCode(QRCodeInput);
//             QRCodeFileName := MoveToMagicPath(QRCodeFileName); // To avoid confirmation dialogue on RTC
//                                                                // Load the image from file into the BLOB field
//             Clear(TempBlob);
//             FileManagement.BLOBImport(TempBlob, QRCodeFileName);
//             if TempBlob.Blob.Hasvalue then begin
//                 EInvoicingRequests."QR Image" := TempBlob.Blob;
//                 EInvoicingRequests.Modify
//             end;
//         end;
//         // Erase the temporary file
//         if not ISSERVICETIER then
//             if Exists(QRCodeFileName) then
//                 Erase(QRCodeFileName);
//     end;
//     //SSDU Commented
}
