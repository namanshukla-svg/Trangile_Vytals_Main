Codeunit 50100 "API Consumer E-Way Bill"
{
//SSDU Commented
// Permissions = TableData "Sales Invoice Header" = rim;
// trigger OnRun()
// var
//     ParamString: Text;
// begin
//     //MESSAGE('%1',GetAccessToken);
//     //GenerateEWay(ParamString);
// end;
// var
//     StringBuilder: dotnet StringBuilder;
//     StringWriter: dotnet StringWriter;
//     StringReader: dotnet StringReader;
//     Json: dotnet String;
//     JsonTextWriter: dotnet JsonTextWriter;
//     JsonTextReader: dotnet JsonTextReader;
//     StreamWriter: dotnet StreamWriter;
//     StreamReader: dotnet StreamReader;
//     Encoding: dotnet Encoding;
//     MessageText: Text;
//     HttpWebRequestMgt: Codeunit "Http Web Request Mgt.";
//     TmpBlob: Record TempBlob;
//     RequestStr: dotnet Stream;
//     CompanyInformation: Record "Company Information";
//     ShippingAgent: Record "Shipping Agent";
// local procedure SetINIT()
// begin
//     StringBuilder := StringBuilder.StringBuilder;
//     StringWriter := StringWriter.StringWriter(StringBuilder);
//     JsonTextWriter := JsonTextWriter.JsonTextWriter(StringWriter);
// end;
// local procedure StartJason()
// begin
//     SetINIT;
//     JsonTextWriter.WriteStartObject;
// end;
// local procedure AddToJason(Variablename: Text; Variable: Variant)
// begin
//     JsonTextWriter.WritePropertyName(Variablename);
//     JsonTextWriter.WriteValue(Format(Variable, 0, 9));
// end;
// local procedure EndJason()
// begin
//     JsonTextWriter.WriteEndObject;
// end;
// local procedure GetJason()
// begin
//     Json := StringBuilder.ToString;
// end;
// local procedure GetClientFile(): Text
// var
//     ClientAppFile: dotnet Path;
// begin
//     exit(ClientAppFile.GetTempPath);
// end;
// procedure GetAccessToken(): Text
// var
//     FL: File;
//     ResponseText: Text;
//     JString: Text;
//     OutStrm: OutStream;
//     ResponseInStream_L: InStream;
//     HttpStatusCode_L: dotnet HttpStatusCode;
//     ResponseHeaders_L: dotnet NameValueCollection;
//     DataExch: Record "Data Exch. Field";
//     SalesReceivablesSetup: Record "Sales & Receivables Setup";
//     Validity: Text;
//     ValidSec: Integer;
// begin
//     SalesReceivablesSetup.Get;
//     if CurrentDatetime > SalesReceivablesSetup."E-way Access Token Validity" then begin
//         StartJason;
//         AddToJason('username', SalesReceivablesSetup."E-Way User Name");
//         AddToJason('password', SalesReceivablesSetup."E-Way Password");
//         if COMPANYNAME = 'Zavenir Daubert India (P) Ltd.' then begin
//             AddToJason('client_id', 'znJGiubBitOnpNEwbH');
//             AddToJason('client_secret', '2KMLH8IU23OVz9EqA4Jl5JQ3');
//             AddToJason('grant_type', 'password');
//         end else begin
//             AddToJason('client_id', 'vSDKJsODUyCPIapsqW');
//             AddToJason('client_secret', '5rbJsM7NksenMQJyHBCLnXw2');
//             AddToJason('grant_type', 'password');
//         end;
//         EndJason;
//         GetJason;
//         //  MESSAGE('%1',Json);
//         if FILE.Exists(GetClientFile + 'J.txt') then
//             Erase(GetClientFile + 'J.txt');
//         FL.Create(GetClientFile + 'J.txt');
//         FL.CreateOutstream(OutStrm);
//         OutStrm.WriteText(Format(Json));
//         FL.Close;
//         HttpWebRequestMgt.Initialize('https://pro.mastersindia.co/oauth/access_token');
//         HttpWebRequestMgt.DisableUI;
//         HttpWebRequestMgt.SetMethod('POST');
//         HttpWebRequestMgt.SetReturnType('application/json');
//         HttpWebRequestMgt.SetContentType('application/json');
//         HttpWebRequestMgt.AddBody(GetClientFile + 'J.txt');
//         TmpBlob.Init;
//         TmpBlob.Blob.CreateInstream(ResponseInStream_L);
//         if HttpWebRequestMgt.GetResponse(ResponseInStream_L, HttpStatusCode_L, ResponseHeaders_L) then begin
//             ResponseInStream_L.Read(ResponseText);
//             //      MESSAGE('%1',ResponseText);
//             Json := ResponseText;
//             ReadJSon(Json, DataExch);
//             DataExch.Reset;
//             DataExch.SetRange("Node ID", 'access_token');
//             if DataExch.FindFirst then
//                 MessageText := DataExch.Value;
//             DataExch.Reset;
//             DataExch.SetRange("Node ID", 'expires_in');
//             if DataExch.FindFirst then
//                 Validity := DataExch.Value;
//             Evaluate(ValidSec, Validity);
//             SalesReceivablesSetup."E-way Access Token" := MessageText;
//             SalesReceivablesSetup."E-way Access Token Validity" := CurrentDatetime + (ValidSec * 1000);
//             SalesReceivablesSetup.Modify;
//             exit(MessageText);
//         end;
//     end else
//         exit(SalesReceivablesSetup."E-way Access Token");
// end;
// procedure GenerateEWay(JsonString: Text)
// var
//     ResponseInStream_L: InStream;
//     HttpStatusCode_L: dotnet HttpStatusCode;
//     ResponseHeaders_L: dotnet NameValueCollection;
//     ResponseText: Text;
//     JString: Text;
//     OutStrm: OutStream;
//     DataExch: Record "Data Exch. Field";
//     EWayBillNo: Text[30];
//     EWayBillDateTime: Variant;
//     EWayExpiryDateTime: Variant;
//     SalesInvoiceHeader: Record "Sales Invoice Header";
//     FL: File;
// begin
//     GetJason;
//     if FILE.Exists(GetClientFile + 'J.txt') then
//         Erase(GetClientFile + 'J.txt');
//     FL.Create(GetClientFile + 'J.txt');
//     FL.CreateOutstream(OutStrm);
//     OutStrm.WriteText(Format(Json));
//     FL.Close;
//     if Confirm('Do you want view the JSON') then
//         Message('%1', Json);
//     HttpWebRequestMgt.Initialize('https://pro.mastersindia.co/ewayBillsGenerate');
//     HttpWebRequestMgt.DisableUI;
//     HttpWebRequestMgt.SetMethod('POST');
//     HttpWebRequestMgt.SetReturnType('application/json');
//     HttpWebRequestMgt.SetContentType('application/json');
//     HttpWebRequestMgt.AddBody(GetClientFile + 'J.txt');
// end;
// [EventSubscriber(Objecttype::Page, 50176, 'UpdateVehicleNoEvent', '', false, false)]
// procedure UpdateVehicleNo(SalesInvoiceHeader: Record "Sales Invoice Header")
// var
//     FL: File;
//     ResponseText: Text;
//     JString: Text;
//     OutStrm: OutStream;
//     ResponseInStream_L: InStream;
//     HttpStatusCode_L: dotnet HttpStatusCode;
//     ResponseHeaders_L: dotnet NameValueCollection;
//     DataExch: Record "Data Exch. Field";
//     TknNo: Text[50];
// begin
//     SalesInvoiceHeader.TestField("E-Way Bill No.");
//     SalesInvoiceHeader.TestField("New Vechile No.");
//     SalesInvoiceHeader.TestField("Vechile No. Update Remark");
//     CompanyInformation.Get;
//     TknNo := GetAccessToken;
//     StartJason;
//     AddToJason('access_token', TknNo);
//     AddToJason('userGstin', GetGSTIN(SalesInvoiceHeader."Location Code"));
//     AddToJason('eway_bill_number', SalesInvoiceHeader."E-Way Bill No.");
//     AddToJason('vehicle_number', DelChr(SalesInvoiceHeader."New Vechile No.", '=', ' /\.<>-!@#$%^&*()_+'));
//     AddToJason('vehicle_type', 'Regular');
//     AddToJason('place_of_consignor', SalesInvoiceHeader."Ship-to City");
//     AddToJason('state_of_consignor', GetStateCode(SalesInvoiceHeader.State));
//     AddToJason('reason_code_for_vehicle_updation', 'due to break down');
//     AddToJason('reason_for_vehicle_updation', 'vehicle broke down');
//     AddToJason('transporter_document_number', SalesInvoiceHeader."External Document No.");
//     AddToJason('transporter_document_date', GetDateFormated(SalesInvoiceHeader."Posting Date"));
//     AddToJason('mode_of_transport', 'ROAD');//FORMAT(SalesInvoiceHeader."Mode of Transport"));
//     AddToJason('data_source', 'erp');
//     EndJason;
//     GetJason;
//     if FILE.Exists(GetClientFile + 'J.txt') then
//         Erase(GetClientFile + 'J.txt');
//     FL.Create(GetClientFile + 'J.txt');
//     FL.CreateOutstream(OutStrm);
//     OutStrm.WriteText(Format(Json));
//     FL.Close;
//     // MESSAGE('%1',Json);
//     HttpWebRequestMgt.Initialize('https://pro.mastersindia.co/updateVehicleNumber');
//     HttpWebRequestMgt.DisableUI;
//     HttpWebRequestMgt.SetMethod('POST');
//     HttpWebRequestMgt.SetReturnType('application/json');
//     HttpWebRequestMgt.SetContentType('application/json');
//     HttpWebRequestMgt.AddBody(GetClientFile + 'J.txt');
//     TmpBlob.Init;
//     TmpBlob.Blob.CreateInstream(ResponseInStream_L);
//     if HttpWebRequestMgt.GetResponse(ResponseInStream_L, HttpStatusCode_L, ResponseHeaders_L) then begin
//         ResponseInStream_L.Read(ResponseText);
//         //  //  MESSAGE('%1',ResponseText);
//         Json := ResponseText;
//         ReadJSon(Json, DataExch);
//         //  DataExch.RESET;
//         //  DataExch.SETRANGE("Node ID",'access_token');
//         //  IF DataExch.FINDFIRST THEN
//         //     MessageText := DataExch.Value;
//         //EXIT(MessageText);
//     end;
//     if GetJsonNodeValue('results.message.vehUpdDate') <> '' then
//         Message('Vechile No. Updated')
//     else
//         Error('%1', GetJsonNodeValue('results.message'));
// end;
// procedure CancelEWay("E-Way_BillNo": Text[30])
// var
//     FL: File;
//     ResponseText: Text;
//     JString: Text;
//     OutStrm: OutStream;
//     ResponseInStream_L: InStream;
//     HttpStatusCode_L: dotnet HttpStatusCode;
//     ResponseHeaders_L: dotnet NameValueCollection;
//     DataExch: Record "Data Exch. Field";
//     TknNo: Text[50];
//     EWayBillNo: Text[30];
//     EWayBillDateTime: Variant;
//     EWayExpiryDateTime: Variant;
// begin
//     CompanyInformation.Get;
//     TknNo := GetAccessToken;
//     StartJason;
//     AddToJason('access_token', TknNo);
//     AddToJason('userGstin', CompanyInformation."GST Registration No.");
//     AddToJason('eway_bill_number', "E-Way_BillNo");
//     AddToJason('reason_of_cancel', 'Others');
//     AddToJason('cancel_remark', 'Cancelled the order');
//     AddToJason('data_source', 'erp');
//     EndJason;
//     GetJason;
//     if FILE.Exists(GetClientFile + 'J.txt') then
//         Erase(GetClientFile + 'J.txt');
//     FL.Create(GetClientFile + 'J.txt');
//     FL.CreateOutstream(OutStrm);
//     OutStrm.WriteText(Format(Json));
//     FL.Close;
//     Message('%1', Json);
//     HttpWebRequestMgt.Initialize('https://pro.mastersindia.co/updateVehicleNumber');
//     HttpWebRequestMgt.DisableUI;
//     HttpWebRequestMgt.SetMethod('POST');
//     HttpWebRequestMgt.SetReturnType('application/json');
//     HttpWebRequestMgt.SetContentType('application/json');
//     HttpWebRequestMgt.AddBody(GetClientFile + 'J.txt');
//     TmpBlob.Init;
//     TmpBlob.Blob.CreateInstream(ResponseInStream_L);
//     if HttpWebRequestMgt.GetResponse(ResponseInStream_L, HttpStatusCode_L, ResponseHeaders_L) then begin
//         ResponseInStream_L.Read(ResponseText);
//         Json := ResponseText;
//         //  MESSAGE('%1',ResponseText);
//         ReadJSon(Json, DataExch);
//         EWayBillNo := GetJsonNodeValue('results.message.ewayBillNo');
//         EWayBillDateTime := GetJsonNodeValue('results.message.cancelDate');
//     end;
// end; 
// local procedure ConsolitedEWayBill(JsonString: Text)
// var
//     ResponseInStream_L: InStream;
//     HttpStatusCode_L: dotnet HttpStatusCode;
//     ResponseHeaders_L: dotnet NameValueCollection;
//     ResponseText: Text;
//     JString: Text;
//     OutStrm: OutStream;
//     DataExch: Record "Data Exch. Field";
//     EWayBillNo: Text[30];
//     EWayBillDateTime: Variant;
//     EWayExpiryDateTime: Variant;
//     SalesInvoiceHeader: Record "Sales Invoice Header";
//     FL: File;
// begin
//     SalesInvoiceHeader.Reset;
//     SalesInvoiceHeader.SetRange("E-Way-to generate", true);
//     if SalesInvoiceHeader.FindSet then
//         repeat
//             CreateJSONSalesInvoice(SalesInvoiceHeader);
//             GetJason;
//             if FILE.Exists(GetClientFile + 'J.txt') then
//                 Erase(GetClientFile + 'J.txt');
//             FL.Create(GetClientFile + 'J.txt');
//             FL.CreateOutstream(OutStrm);
//             OutStrm.WriteText(Format(Json));
//             FL.Close;
//             Message('%1', Json);
//             HttpWebRequestMgt.Initialize('https://pro.mastersindia.co/ewayBillsGenerate');
//             HttpWebRequestMgt.DisableUI;
//             HttpWebRequestMgt.SetMethod('POST');
//             HttpWebRequestMgt.SetReturnType('application/json');
//             HttpWebRequestMgt.SetContentType('application/json');
//             HttpWebRequestMgt.AddBody(GetClientFile + 'J.txt');
//             //HttpWebRequestMgt.AddBody( 'E:\JSS2.txt');
//             ////  MESSAGE('%1',ResponseText);
//             TmpBlob.Init;
//             TmpBlob.Blob.CreateInstream(ResponseInStream_L);
//             if HttpWebRequestMgt.GetResponse(ResponseInStream_L, HttpStatusCode_L, ResponseHeaders_L) then begin
//                 ResponseInStream_L.Read(ResponseText);
//                 ////  MESSAGE('%1',ResponseText);
//                 Json := ResponseText;
//                 //  MESSAGE('%1',ResponseText);
//                 ReadJSon(Json, DataExch);
//                 EWayBillNo := GetJsonNodeValue('results.message.ewayBillNo');
//                 EWayBillDateTime := GetJsonNodeValue('results.message.ewayBillDate');
//                 EWayExpiryDateTime := GetJsonNodeValue('results.message.validUpto');
//                 SalesInvoiceHeader."E-Way Bill No." := Format(EWayBillNo);
//                 SalesInvoiceHeader."E-Way Bill Date" := EWayBillDateTime;
//                 SalesInvoiceHeader."E-Way Bill Validity" := EWayExpiryDateTime;
//                 SalesInvoiceHeader."E-Way Generated" := true;
//                 SalesInvoiceHeader.Modify;
//             end;
//         until SalesInvoiceHeader.Next = 0;
//     SalesInvoiceHeader.ModifyAll("E-Way-to generate", false);
// end;
// local procedure RejectEWayBill(JsonString: Text)
// begin
// end;
// procedure ReadJSon(var String: dotnet String; var TempPostingExchField: Record "Data Exch. Field" temporary)
// var
//     JsonToken: dotnet JsonToken;
//     PrefixArray: dotnet Array;
//     PrefixString: dotnet String;
//     PropertyName: Text;
//     ColumnNo: Integer;
//     InArray: array[1000] of Boolean;
//     LineNo: Integer;
//     NewLn: Integer;
//     T1221_L: Record "Data Exch. Field";
//     Intn: Integer;
// begin
//     PrefixArray := PrefixArray.CreateInstance(GetDotNetType(String), 250);
//     StringReader := StringReader.StringReader(String);
//     JsonTextReader := JsonTextReader.JsonTextReader(StringReader);
//     LineNo := 0;
//     //
//     T1221_L.DeleteAll;
//     TempPostingExchField.Reset;
//     Clear(TempPostingExchField);
//     TempPostingExchField.DeleteAll;
//     //new code for delete all data from temp table
//     while JsonTextReader.Read do
//         case true of
//             JsonTextReader.TokenType.CompareTo(JsonToken.StartObject) = 0:
//                 ;
//             JsonTextReader.TokenType.CompareTo(JsonToken.StartArray) = 0:
//                 begin
//                     InArray[JsonTextReader.Depth + 1] := true;
//                     //ColumnNo := 0;
//                 end;
//             JsonTextReader.TokenType.CompareTo(JsonToken.StartConstructor) = 0:
//                 ;
//             JsonTextReader.TokenType.CompareTo(JsonToken.PropertyName) = 0:
//                 begin
//                     PrefixArray.SetValue(JsonTextReader.Value, JsonTextReader.Depth - 1);
//                     if JsonTextReader.Depth > 1 then begin
//                         PrefixString := PrefixString.Join('.', PrefixArray, 0, JsonTextReader.Depth - 1);
//                         if PrefixString.Length > 0 then
//                             PropertyName := PrefixString.ToString + '.' + Format(JsonTextReader.Value, 0, 9)
//                         else
//                             PropertyName := Format(JsonTextReader.Value, 0, 9);
//                     end else
//                         PropertyName := Format(JsonTextReader.Value, 0, 9);
//                 end;
//             JsonTextReader.TokenType.CompareTo(JsonToken.String) = 0,
//             JsonTextReader.TokenType.CompareTo(JsonToken.Integer) = 0,
//             JsonTextReader.TokenType.CompareTo(JsonToken.Float) = 0,
//             JsonTextReader.TokenType.CompareTo(JsonToken.Boolean) = 0,
//             JsonTextReader.TokenType.CompareTo(JsonToken.Date) = 0,
//             JsonTextReader.TokenType.CompareTo(JsonToken.Bytes) = 0:
//                 begin
//                     TempPostingExchField."Data Exch. No." := JsonTextReader.Depth;
//                     TempPostingExchField."Line No." := JsonTextReader.LineNumber;
//                     TempPostingExchField."Column No." := ColumnNo;
//                     TempPostingExchField."Node ID" := PropertyName;
//                     Intn += 1;
//                     TempPostingExchField.Value := CopyStr(Format(JsonTextReader.Value, 0, 9), 1, 250);
//                     TempPostingExchField."Data Exch. Line Def Code" := JsonTextReader.TokenType.ToString;
//                     TempPostingExchField.Insert;
//                     Commit;
//                 end;
//             JsonTextReader.TokenType.CompareTo(JsonToken.EndConstructor) = 0:
//                 ;
//             JsonTextReader.TokenType.CompareTo(JsonToken.EndArray) = 0:
//                 InArray[JsonTextReader.Depth + 1] := false;
//             JsonTextReader.TokenType.CompareTo(JsonToken.EndObject) = 0:
//                 if JsonTextReader.Depth > 0 then
//                     if InArray[JsonTextReader.Depth] then ColumnNo += 1;
//         end;
// end;
// procedure ReadFirstJSonValue(var String: dotnet String; ParameterName: Text) ParameterValue: Text
// var
//     JsonToken: dotnet JsonToken;
//     PropertyName: Text;
// begin
//     StringReader := StringReader.StringReader(String);
//     JsonTextReader := JsonTextReader.JsonTextReader(StringReader);
//     while JsonTextReader.Read do
//         case true of
//             JsonTextReader.TokenType.CompareTo(JsonToken.PropertyName) = 0:
//                 PropertyName := Format(JsonTextReader.Value, 0, 9);
//             not IsNull(JsonTextReader.Value):
//                 //JsonTextReader.TokenType.CompareTo(JsonToken.) = 0 :
//                 begin
//                     ParameterValue := Format(JsonTextReader.Value, 0, 9);
//                     exit;
//                 end;
//         end;
// end;
// procedure ConvertXMLToJSON(var TempBlob: Record TempBlob)
// var
//     XmlDocument: dotnet XmlDocument;
//     JSONConvert: dotnet JsonConvert;
//     JSONFormatting: dotnet Formatting;
//     myInStream: InStream;
//     myOutStream: OutStream;
//     myJSON: Text;
//     FL: File;
//     OutStrm: OutStream;
// begin
//     TempBlob.Blob.CreateInstream(myInStream);
//     XmlDocument := XmlDocument.XmlDocument;
//     XmlDocument.Load(myInStream);
//     myJSON := JSONConvert.SerializeXmlNode(XmlDocument.DocumentElement, JSONFormatting.Indented, true);
//     TempBlob.Init;
//     TempBlob.Blob.CreateOutstream(myOutStream, Textencoding::UTF8);
//     myOutStream.WriteText(myJSON);
//     if FILE.Exists(GetClientFile + 'J.txt') then
//         Erase(GetClientFile + 'J.txt');
//     FL.Create(GetClientFile + 'J.txt');
//     FL.CreateOutstream(OutStrm);
//     OutStrm.WriteText(Format(myJSON));
//     FL.Close;
//     //MESSAGE('%1',FORMAT(myJSON));
// end;
// procedure XMLPortToJSON(myXMLPort: Integer)
// var
//     myOutStream: OutStream;
//     myInStream: InStream;
//     tempBlob: Record TempBlob;
//     myJSON: Text;
// begin
//     tempBlob.Init;
//     tempBlob.Blob.CreateOutstream(myOutStream);
//     Xmlport.Export(myXMLPort, myOutStream);
//     ConvertXMLToJSON(tempBlob);
//     myJSON := tempBlob.ReadAsText('', Textencoding::UTF8);
// end;
// local procedure GetJsonNodeValue(NodeId: Text[30]): Text
// var
//     DataExch: Record "Data Exch. Field";
// begin
//     Clear(MessageText);
//     DataExch.Reset;
//     DataExch.SetRange("Node ID", NodeId);
//     if DataExch.FindFirst then
//         MessageText := DataExch.Value;
//     exit(MessageText);
// end;
// local procedure AddToJasonArray(Variablename: Text; Variable: Variant)
// var
//     JsonTextWriter2: dotnet JsonTextWriter;
//     StringWriter2: dotnet StringWriter;
//     StringBuilder2: dotnet StringBuilder;
// begin
//     JsonTextWriter.WritePropertyName(Variablename);
//     JsonTextWriter.WriteValue(Format(Variable));
// end;
// [EventSubscriber(Objecttype::Page, 50176, 'CreateJSONSalesInvoiceEvent', '', false, false)]
/*    procedure CreateJSONSalesInvoice(SalesInvoiceHeader: Record "Sales Invoice Header")
        var
            CustomerL: Record Customer;
            SalesInvoiceLineL: Record "Sales Invoice Line";
            ShiptoAddressL: Record "Ship-to Address";
            CustGstin: Code[15];
            TknNo: Text[50];
            SalesInvoiceHeader2: Record "Sales Invoice Header";
            ResponseInStream_L: InStream;
            HttpStatusCode_L: dotnet HttpStatusCode;
            ResponseHeaders_L: dotnet NameValueCollection;
            ResponseText: Text;
            JString: Text;
            OutStrm: OutStream;
            DataExch: Record "Data Exch. Field";
            EWayBillNo: Text[30];
            EWayBillDateTime: Variant;
            EWayExpiryDateTime: Variant;
            FL: File;
            Mnth: Text[2];
            Day: Text[2];
            TransportMethod: Record "Transport Method";
            Location: Record Location;
            State_Gst: Code[2];
            State_rec: Record State;
        begin
            GetCompanyInfo;
            TknNo := GetAccessToken;
            if TransportMethod.Get(SalesInvoiceHeader."Transport Method") then;
            if ShippingAgent.Get(SalesInvoiceHeader."Shipping Agent Code") then;
            if Location.Get(SalesInvoiceHeader."Location Code") then;
            // SalesInvoiceHeaderL.RESET;
            // SalesInvoiceHeaderL.SETRANGE("E-Way-to generate",TRUE);
            // IF SalesInvoiceHeaderL.FINDSET THEN
            //  REPEAT
            SalesInvoiceHeader.TestField("Transportation Distance");
            SalesInvoiceHeader.TestField("E-Way Generated", false);
            SalesInvoiceHeader.TestField("E-Way Bill No.", '');
            StartJason;
            AddToJason('access_token', TknNo);
            AddToJason('userGstin', GetGSTIN(SalesInvoiceHeader."Location Code"));
            AddToJason('supply_type', 'outward');
            if SalesInvoiceHeader."Invoice Type" = SalesInvoiceHeader."invoice type"::Taxable then
                AddToJason('sub_supply_type', 'Supply')    // Alle "Invoice Type"::Taxable
            else
                if SalesInvoiceHeader."Invoice Type" = SalesInvoiceHeader."invoice type"::Export then
                    AddToJason('sub_supply_type', 'Export');  // Alle "Invoice Type"::Export
            AddToJason('sub_supply_description', '');
            AddToJason('document_type', 'tax invoice');
            //AddToJason('document_number',COPYSTR(SalesInvoiceHeader."No.",14,18));  // Alle Send last 5 digit of invoice no.
            AddToJason('document_number', SalesInvoiceHeader."No.");
            // IF DATE2DMY(SalesInvoiceHeader."Posting Date",2) >9 THEN
            //  Mnth := FORMAT(DATE2DMY(SalesInvoiceHeader."Posting Date",2))
            // ELSE
            //  Mnth := '0'+FORMAT(DATE2DMY(SalesInvoiceHeader."Posting Date",2));
            // IF DATE2DMY(SalesInvoiceHeader."Posting Date",1) >9 THEN
            //  Day := FORMAT(DATE2DMY(SalesInvoiceHeader."Posting Date",1))
            // ELSE
            //  Day := '0'+FORMAT(DATE2DMY(SalesInvoiceHeader."Posting Date",1));
            AddToJason('document_date', GetDateFormated(SalesInvoiceHeader."Posting Date"));//Day+'/'+Mnth+'/'+FORMAT(DATE2DMY(SalesInvoiceHeader."Posting Date",3)));//'20/03/2018');//FORMAT(SalesInvoiceHeader."Posting Date",0,1));
            if Location."Temp JW Location" then begin
                AddToJason('gstin_of_consignor', GetGSTIN(SalesInvoiceHeader."Location Code"));
                //AddToJason('gstin_of_consignor','05AAABC0181E1ZE');
                AddToJason('legal_name_of_consignor', CompanyInformation.Name);                      //CompanyInformation.Name);
                AddToJason('address1_of_consignor', Location.Address);                     //CompanyInformation.Address);
                AddToJason('address2_of_consignor', Location."Address 2");                 //CompanyInformation."Address 2");

                AddToJason('place_of_consignor', Location.City);                           //CompanyInformation.City);
                AddToJason('pincode_of_consignor', Location."Post Code");                  //CompanyInformation."Post Code");
                AddToJason('state_of_consignor', GetStateCode(Location."State Code"));     //CompanyInformation.State));
                AddToJason('actual_from_state_name', GetStateCode(Location."Temp State Code")); // Alle "Invoice Type"::Taxable
            end else begin
                AddToJason('gstin_of_consignor', GetGSTIN(SalesInvoiceHeader."Location Code"));
                AddToJason('legal_name_of_consignor', Location.Name);                      //CompanyInformation.Name);
                AddToJason('address1_of_consignor', Location.Address);                     //CompanyInformation.Address);
                AddToJason('address2_of_consignor', Location."Address 2");                 //CompanyInformation."Address 2");
                AddToJason('place_of_consignor', Location.City);                           //CompanyInformation.City);
                AddToJason('pincode_of_consignor', Location."Post Code");                  //CompanyInformation."Post Code");
                AddToJason('state_of_consignor', GetStateCode(Location."State Code"));     //CompanyInformation.State));
                                                                                           //IF SalesInvoiceHeader."Invoice Type" = SalesInvoiceHeader."Invoice Type"::Taxable THEN
                AddToJason('actual_from_state_name', GetStateCode(Location."State Code")); // Alle "Invoice Type"::Taxable
                                                                                           //ELSE IF SalesInvoiceHeader."Invoice Type" = SalesInvoiceHeader."Invoice Type"::Export THEN
                                                                                           // AddToJason('actual_from_state_name','Other Country');             // Alle "Invoice Type"::Export
            end;
            if ShiptoAddressL.Get(SalesInvoiceHeader."Bill-to Customer No.", SalesInvoiceHeader."Ship-to Code") then begin
                CustGstin := ShiptoAddressL."GST Registration No.";
                AddToJason('transaction_type', 4);
            end else
                if CustomerL.Get(SalesInvoiceHeader."Bill-to Customer No.") then begin
                    CustGstin := CustomerL."GST Registration No.";
                    AddToJason('transaction_type', 3);
                end;

            State_Gst := '';
            State_Gst := CopyStr(CustGstin, 1, 2);

            State_rec.Reset;
            State_rec.SetRange("State Code (GST Reg. No.)", State_Gst);
            if State_rec.FindFirst then;

            AddToJason('gstin_of_consignee', CustGstin);
            AddToJason('legal_name_of_consignee', SalesInvoiceHeader."Ship-to Name");
            AddToJason('address1_of_consignee', SalesInvoiceHeader."Ship-to Address");
            AddToJason('address2_of_consignee', SalesInvoiceHeader."Ship-to Address 2");
            AddToJason('place_of_consignee', SalesInvoiceHeader."Ship-to City");
            AddToJason('pincode_of_consignee', SalesInvoiceHeader."Ship-to Post Code");//MESSAGE('%1..%2',SalesInvoiceHeader.State,GetStateCode(SalesInvoiceHeader.State));
            if SalesInvoiceHeader."Invoice Type" = SalesInvoiceHeader."invoice type"::Taxable then
                AddToJason('state_of_supply', State_rec.Description)            //GetStateCode(SalesInvoiceHeader.State)); // Alle "Invoice Type"::Taxable
            else
                if SalesInvoiceHeader."Invoice Type" = SalesInvoiceHeader."invoice type"::Export then
                    AddToJason('state_of_supply', 'Other Country');                      // Alle "Invoice Type"::Export
            AddToJason('actual_to_state_name', GetStateCode(SalesInvoiceHeader.State));
            SalesInvoiceHeader.CalcFields("Amount to Customer");
            AddToJason('total_invoice_value', SalesInvoiceHeader."Amount to Customer");
            AddToJason('taxable_amount', GetTaxableAmountSalesInvoice(SalesInvoiceHeader."No."));
            AddToJason('cgst_amount', GetGSTAmount(SalesInvoiceHeader."No.", 'CGST'));
            AddToJason('sgst_amount', GetGSTAmount(SalesInvoiceHeader."No.", 'SGST'));
            AddToJason('igst_amount', GetGSTAmount(SalesInvoiceHeader."No.", 'IGST'));
            AddToJason('cess_amount', GetGSTAmount(SalesInvoiceHeader."No.", 'CESS'));

            AddToJason('transporter_id', ShippingAgent."Transporter GST No.");
            AddToJason('transporter_name', SalesInvoiceHeader."Shipping Agent Code");
            AddToJason('transporter_document_number', SalesInvoiceHeader."LR/RR No.");
            AddToJason('transportation_mode', TransportMethod."E-Way transport method");//SalesInvoiceHeader."Mode of Transport");
            AddToJason('transportation_distance', SalesInvoiceHeader."Transportation Distance");
            AddToJason('transporter_document_date', GetDateFormated(SalesInvoiceHeader."LR/RR Date"));
            AddToJason('vehicle_number', DelChr(SalesInvoiceHeader."Vehicle No.", '=', ' ,/-<>  !@#$%^&*()_+{}'));//DELCHR(SalesInvoiceHeader."Vehicle No.",'=',' '));
            AddToJason('vehicle_type', 'Regular');

            if Confirm('Do you want instant genrate the E-way') then
                AddToJason('generate_status', '1')
            else
                AddToJason('generate_status', '0');
            AddToJason('data_source', 'erp');
            AddToJason('user_ref', DelChr(SalesInvoiceHeader."User ID", '=', ' ,<>/\-_()[]{}|'));
            AddToJason('email', 'gurgaon.dispatch@zavenir.com');
            AddToJason('location_code', SalesInvoiceHeader."Location Code");
            AddToJason('eway_bill_status', 'ABC');
            AddToJason('auto_print', 'Y');

            SalesInvoiceLineL.Reset;
            SalesInvoiceLineL.SetRange("Document No.", SalesInvoiceHeader."No.");
            SalesInvoiceLineL.SetRange(Type, SalesInvoiceLineL.Type::Item);
            SalesInvoiceLineL.SetFilter("No.", '<>%1', '');
            if SalesInvoiceLineL.FindSet then begin
                JsonTextWriter.WritePropertyName('itemList');
                JsonTextWriter.WriteStartArray;
                repeat
                    JsonTextWriter.WriteStartObject;
                    AddToJason('product_name', SalesInvoiceLineL."Product Group Code");
                    AddToJason('product_description', SalesInvoiceLineL."Product Group Code");
                    AddToJason('hsn_code', SalesInvoiceLineL."HSN/SAC Code");
                    AddToJason('quantity', SalesInvoiceLineL.Quantity);
                    AddToJason('unit_of_product', GetUOM(SalesInvoiceLineL."Unit of Measure Code"));
                    AddToJason('cgst_rate', GetGSTRate(SalesInvoiceLineL."Document No.", 'CGST'));
                    AddToJason('sgst_rate', GetGSTRate(SalesInvoiceLineL."Document No.", 'SGST'));
                    AddToJason('igst_rate', GetGSTRate(SalesInvoiceLineL."Document No.", 'IGST'));
                    AddToJason('cess_rate', GetGSTRate(SalesInvoiceLineL."Document No.", 'CESS'));
                    AddToJason('cessAdvol', 0);
                    AddToJason('taxable_amount', SalesInvoiceLineL."GST Base Amount");
                    JsonTextWriter.WriteEndObject;
                until SalesInvoiceLineL.Next = 0;
            end;
            EndJason;
            // UNTIL SalesInvoiceHeaderL.NEXT = 0;
            GenerateEWay('');
            TmpBlob.Init;
            TmpBlob.Blob.CreateInstream(ResponseInStream_L);
            if HttpWebRequestMgt.GetResponse(ResponseInStream_L, HttpStatusCode_L, ResponseHeaders_L) then begin
                ResponseInStream_L.Read(ResponseText);
                //  MESSAGE('%1',ResponseText);
                Json := ResponseText;
                // MESSAGE('%1',ResponseText);
                ReadJSon(Json, DataExch);

                EWayBillNo := GetJsonNodeValue('results.message.ewayBillNo');
                EWayBillDateTime := GetJsonNodeValue('results.message.ewayBillDate');
                EWayExpiryDateTime := GetJsonNodeValue('results.message.validUpto');
                InsertRequestId(GetJsonNodeValue('results.requestId'), SalesInvoiceHeader."No.");
                Commit;
                if EWayBillNo <> '' then begin
                    SalesInvoiceHeader2.Get(SalesInvoiceHeader."No.");
                    SalesInvoiceHeader2."E-Way Bill No." := Format(EWayBillNo);
                    //SalesInvoiceHeader2."E-Way Bill Date" :=  EWayBillDateTime;
                    SalesInvoiceHeader2."E-Way Bill Validity" := EWayExpiryDateTime;
                    SalesInvoiceHeader2."E-Way Generated" := true;
                    SalesInvoiceHeader2."E-Way Canceled" := false;
                    SalesInvoiceHeader2.Modify;
                    Message('E-Way Bill Generated');
                end else
                    Error('%1 Please share this request ID for support %2', GetJsonNodeValue('results.message'), GetJsonNodeValue('results.requestId'));
            end;
            Message(GetLastErrorText);
        end;
            */
//SSD S
// local procedure GetCompanyInfo()
// begin
//     CompanyInformation.Get;
// end;
// local procedure GetStateCode(StateCode: Code[20]): Text
// var
//     StateL: Record State;
// begin
//     if StateL.Get(StateCode) then
//         exit(UpperCase(StateL.Description));
//     exit('');
// end;
// local procedure GetGSTAmount(DocNo: Code[20]; CompCode: Code[10]): Decimal
// var
//     DetailedGSTLedgerEntry: Record "Detailed GST Ledger Entry";
//     GSTAmt: Decimal;
//     CGSTAmt: Decimal;
//     SGSTAmt: Decimal;
//     CGSTPer: Decimal;
//     IGSTPer: Decimal;
//     SGSTPer: Decimal;
//     CessPer: Decimal;
// begin
//     GSTAmt := 0;
//     DetailedGSTLedgerEntry.Reset;
//     // DetailedGSTLedgerEntry.SETRANGE("Transaction Type",DetailedGSTLedgerEntry."Transaction Type"::Sales);
//     // DetailedGSTLedgerEntry.SETRANGE("Document Type",DetailedGSTLedgerEntry."Document Type"::Invoice);
//     DetailedGSTLedgerEntry.SetRange("Document No.", DocNo);
//     DetailedGSTLedgerEntry.SetRange("GST Component Code", CompCode);
//     if DetailedGSTLedgerEntry.FindSet then
//         repeat
//             GSTAmt += Abs(DetailedGSTLedgerEntry."GST Amount");
//         until DetailedGSTLedgerEntry.Next = 0;
//     exit(GSTAmt);
// end;
// local procedure GetGSTRate(DocNo: Code[20]; CompCode: Code[10]): Decimal
// var
//     DetailedGSTLedgerEntry: Record "Detailed GST Ledger Entry";
//     GSTAmt: Decimal;
//     CGSTAmt: Decimal;
//     SGSTAmt: Decimal;
//     CGSTPer: Decimal;
//     IGSTPer: Decimal;
//     SGSTPer: Decimal;
//     CessPer: Decimal;
// begin
//     GSTAmt := 0;
//     DetailedGSTLedgerEntry.Reset;
//     // DetailedGSTLedgerEntry.SETRANGE("Transaction Type",DetailedGSTLedgerEntry."Transaction Type"::Sales);
//     // DetailedGSTLedgerEntry.SETRANGE("Document Type",DetailedGSTLedgerEntry."Document Type"::Invoice);
//     DetailedGSTLedgerEntry.SetRange("Document No.", DocNo);
//     DetailedGSTLedgerEntry.SetRange("GST Component Code", CompCode);
//     if DetailedGSTLedgerEntry.FindFirst then
//         exit(ROUND(DetailedGSTLedgerEntry."GST %", 1, '>'));
//     exit(0);
// end;
// local procedure GetTaxableAmountSalesInvoice(DocNo: Code[20]): Decimal
// var
//     SalesInvoiceLineL: Record "Sales Invoice Line";
// begin
//     SalesInvoiceLineL.Reset;
//     SalesInvoiceLineL.SetRange("Document No.", DocNo);
//     SalesInvoiceLineL.CalcSums("GST Base Amount");
//     if SalesInvoiceLineL."GST Base Amount" <> 0 then
//         exit(SalesInvoiceLineL."GST Base Amount");
//     SalesInvoiceLineL.CalcSums(Amount);
//     exit(SalesInvoiceLineL.Amount);
// end;
// [EventSubscriber(Objecttype::Page, 50177, 'CreateJSONSalesReturnEvent', '', false, false)]
// procedure CreateJSONSalesReturn(var ReturnShipmentHeaderL: Record "Return Shipment Header")
// var
//     VendorL: Record Vendor;
//     ReturnShipmentLineL: Record "Return Shipment Line";
//     ShiptoAddressL: Record "Ship-to Address";
//     CustGstin: Code[15];
//     TknNo: Text[50];
//     ResponseInStream_L: InStream;
//     HttpStatusCode_L: dotnet HttpStatusCode;
//     ResponseHeaders_L: dotnet NameValueCollection;
//     ResponseText: Text;
//     JString: Text;
//     OutStrm: OutStream;
//     DataExch: Record "Data Exch. Field";
//     EWayBillNo: Text[30];
//     EWayBillDateTime: Variant;
//     EWayExpiryDateTime: Variant;
//     FL: File;
//     ReturnShipmentHeader2: Record "Return Shipment Header";
//     Mnth: Text[2];
//     TransportMethod: Record "Transport Method";
//     Location: Record Location;
//     State_Gst: Code[2];
//     State_rec: Record State;
// begin
//     GetCompanyInfo;
//     TknNo := GetAccessToken;
//     if TransportMethod.Get(ReturnShipmentHeaderL."Transport Method") then;
//     if ShippingAgent.Get(ReturnShipmentHeaderL."Shipping Agent Code") then;
//     if Location.Get(ReturnShipmentHeaderL."Location Code") then;
//     // ReturnShipmentHeaderL.RESET;
//     // ReturnShipmentHeaderL.SETRANGE("E-Way-to generate",TRUE);
//     // IF ReturnShipmentHeaderL.FINDSET THEN
//     //  REPEAT
//     ReturnShipmentHeaderL.TestField("E-Way Bill No.", '');
//     ReturnShipmentHeaderL.TestField("Transportation Distance");
//     StartJason;
//     AddToJason('access_token', TknNo);
//     AddToJason('userGstin', GetGSTIN(ReturnShipmentHeaderL."Location Code"));
//     AddToJason('supply_type', 'outward');
//     AddToJason('sub_supply_type', 'Sales Return');
//     AddToJason('sub_supply_description', '');
//     AddToJason('document_type', 'credit note');
//     AddToJason('document_number', ReturnShipmentHeaderL."No.");
//     if Date2dmy(ReturnShipmentHeaderL."Posting Date", 2) > 9 then
//         Mnth := Format(Date2dmy(ReturnShipmentHeaderL."Posting Date", 2))
//     else
//         Mnth := '0' + Format(Date2dmy(ReturnShipmentHeaderL."Posting Date", 2));
//     AddToJason('document_date', GetDateFormated(ReturnShipmentHeaderL."Posting Date"));//FORMAT(DATE2DMY(ReturnShipmentHeaderL."Posting Date",1))+'/'+Mnth+'/'+FORMAT(DATE2DMY(ReturnShipmentHeaderL."Posting Date",3)));
//     AddToJason('gstin_of_consignor', GetGSTIN(ReturnShipmentHeaderL."Location Code"));
//     AddToJason('legal_name_of_consignor', Location.Name);
//     AddToJason('address1_of_consignor', Location.Address);
//     AddToJason('address2_of_consignor', Location."Address 2");
//     AddToJason('place_of_consignor', Location.City);
//     AddToJason('pincode_of_consignor', Location."Post Code");
//     AddToJason('state_of_consignor', GetStateCode(Location."State Code"));
//     AddToJason('actual_from_state_name', GetStateCode(Location."State Code"));
//     if ShiptoAddressL.Get(ReturnShipmentHeaderL."Pay-to Vendor No.", ReturnShipmentHeaderL."Ship-to Code") then
//         CustGstin := ShiptoAddressL."GST Registration No."
//     else
//         if VendorL.Get(ReturnShipmentHeaderL."Pay-to Vendor No.") then
//             CustGstin := VendorL."GST Registration No.";
//     State_Gst := '';
//     State_Gst := CopyStr(CustGstin, 1, 2);
//     State_rec.Reset;
//     State_rec.SetRange("State Code (GST Reg. No.)", State_Gst);
//     if State_rec.FindFirst then;
//     AddToJason('gstin_of_consignee', CustGstin);
//     AddToJason('legal_name_of_consignee', ReturnShipmentHeaderL."Ship-to Name");
//     AddToJason('address1_of_consignee', ReturnShipmentHeaderL."Ship-to Address");
//     AddToJason('address2_of_consignee', ReturnShipmentHeaderL."Ship-to Address 2");
//     AddToJason('place_of_consignee', ReturnShipmentHeaderL."Ship-to City");
//     AddToJason('pincode_of_consignee', ReturnShipmentHeaderL."Ship-to Post Code");
//     AddToJason('state_of_supply', State_rec.Description);       //GetStateCode(ReturnShipmentHeaderL.State));
//     AddToJason('actual_to_state_name', GetStateCode(ReturnShipmentHeaderL.State));
//     ReturnShipmentLineL.Reset;
//     ReturnShipmentLineL.SetRange("Document No.", ReturnShipmentHeaderL."No.");
//     ReturnShipmentLineL.CalcSums("GST Base Amount", "Amount Including Excise");
//     if ReturnShipmentLineL."GST Base Amount" <> 0 then begin
//         AddToJason('total_invoice_value', ReturnShipmentLineL."GST Base Amount");
//         AddToJason('taxable_amount', ReturnShipmentLineL."GST Base Amount")
//     end else begin
//         AddToJason('total_invoice_value', ReturnShipmentLineL."Amount Including Excise");
//         AddToJason('taxable_amount', ReturnShipmentLineL."Amount Including Excise");
//     end;
//     AddToJason('cgst_amount', GetGSTAmount(ReturnShipmentHeaderL."No.", 'CGST'));
//     AddToJason('sgst_amount', GetGSTAmount(ReturnShipmentHeaderL."No.", 'SGST'));
//     AddToJason('igst_amount', GetGSTAmount(ReturnShipmentHeaderL."No.", 'IGST'));
//     AddToJason('cess_amount', GetGSTAmount(ReturnShipmentHeaderL."No.", 'CESS'));
//     AddToJason('transporter_id', ShippingAgent."Transporter GST No.");
//     AddToJason('transporter_name', ReturnShipmentHeaderL."Shipping Agent Code");
//     AddToJason('transporter_document_number', ReturnShipmentHeaderL."Applies-to Doc. No.");
//     AddToJason('transportation_mode', TransportMethod."E-Way transport method");//FORMAT(ReturnShipmentHeaderL."Transport Method"));
//     AddToJason('transportation_distance', ReturnShipmentHeaderL."Transportation Distance");
//     AddToJason('transporter_document_date', GetDateFormated(ReturnShipmentHeaderL."Document Date"));
//     AddToJason('vehicle_number', DelChr(ReturnShipmentHeaderL."Vehicle No.", '=', ' ,/\-()!@#$%^&*()_+{}?'));
//     AddToJason('vehicle_type', 'Regular');
//     if Confirm('Do you want instant genrate the E-way') then
//         AddToJason('generate_status', '1')
//     else
//         AddToJason('generate_status', '0');
//     AddToJason('data_source', 'erp');
//     AddToJason('user_ref', DelChr(ReturnShipmentHeaderL."User ID", '=', ' /\,;-'));
//     AddToJason('email', 'gurgaon.dispatch@zavenir.com');
//     AddToJason('location_code', ReturnShipmentHeaderL."Location Code");
//     AddToJason('eway_bill_status', 'ABC');
//     AddToJason('auto_print', 'Y');
//     ReturnShipmentLineL.Reset;
//     ReturnShipmentLineL.SetRange("Document No.", ReturnShipmentHeaderL."No.");
//     if ReturnShipmentLineL.FindSet then begin
//         JsonTextWriter.WritePropertyName('itemList');
//         JsonTextWriter.WriteStartArray;
//         repeat
//             JsonTextWriter.WriteStartObject;
//             AddToJason('product_name', ReturnShipmentLineL."Product Group Code");
//             AddToJason('product_description', ReturnShipmentLineL."Product Group Code");
//             AddToJason('hsn_code', ReturnShipmentLineL."HSN/SAC Code");
//             AddToJason('quantity', ReturnShipmentLineL.Quantity);
//             AddToJason('unit_of_product', (ReturnShipmentLineL."Unit of Measure"));
//             AddToJason('cgst_rate', GetGSTRate(ReturnShipmentLineL."Document No.", 'CGST'));
//             AddToJason('sgst_rate', GetGSTRate(ReturnShipmentLineL."Document No.", 'SGST'));
//             AddToJason('igst_rate', GetGSTRate(ReturnShipmentLineL."Document No.", 'IGST'));
//             AddToJason('cess_rate', GetGSTRate(ReturnShipmentLineL."Document No.", 'CESS'));
//             AddToJason('cessAdvol', '');
//             AddToJason('taxable_amount', ReturnShipmentLineL."GST Base Amount");
//             JsonTextWriter.WriteEndObject;
//         until ReturnShipmentLineL.Next = 0;
//     end;
//     EndJason;
//     // UNTIL ReturnShipmentHeaderL.NEXT = 0;
//     GenerateEWay('');
//     TmpBlob.Init;
//     TmpBlob.Blob.CreateInstream(ResponseInStream_L);
//     if HttpWebRequestMgt.GetResponse(ResponseInStream_L, HttpStatusCode_L, ResponseHeaders_L) then begin
//         ResponseInStream_L.Read(ResponseText);
//         ////  MESSAGE('%1',ResponseText);
//         Json := ResponseText;
//         //  MESSAGE('%1',ResponseText);
//         DataExch.DeleteAll;
//         ReadJSon(Json, DataExch);
//         EWayBillNo := GetJsonNodeValue('results.message.ewayBillNo');
//         EWayBillDateTime := GetJsonNodeValue('results.message.ewayBillDate');
//         EWayExpiryDateTime := GetJsonNodeValue('results.message.validUpto');
//         InsertRequestId(GetJsonNodeValue('results.requestId'), ReturnShipmentHeaderL."No.");
//         Commit;
//         if EWayBillNo <> '' then begin
//             ReturnShipmentHeader2.Get(ReturnShipmentHeaderL."No.");
//             ReturnShipmentHeader2."E-Way Bill No." := Format(EWayBillNo);
//             ReturnShipmentHeader2."E-Way Bill Date" := EWayBillDateTime;
//             ReturnShipmentHeader2."E-Way Bill Validity" := EWayExpiryDateTime;
//             ReturnShipmentHeader2."E-Way Generated" := true;
//             ReturnShipmentHeader2."E-Way Canceled" := false;
//             ReturnShipmentHeader2.Modify;
//         end else
//             Error('%1 Please share this request ID for support %2', GetJsonNodeValue('results.message'), GetJsonNodeValue('results.requestId'));
//     end;
// end;
// [EventSubscriber(Objecttype::Page, 50191, 'CreateJSONTransferShipmentEvent', '', false, false)]
// procedure CreateJSONTransferShipment(var TransferShipmentHeaderL: Record "Transfer Shipment Header")
// var
//     VendorL: Record Vendor;
//     TransferShipmentLineL: Record "Transfer Shipment Line";
//     ShiptoAddressL: Record "Ship-to Address";
//     CustGstin: Code[15];
//     TknNo: Text[50];
//     ResponseInStream_L: InStream;
//     HttpStatusCode_L: dotnet HttpStatusCode;
//     ResponseHeaders_L: dotnet NameValueCollection;
//     ResponseText: Text;
//     JString: Text;
//     OutStrm: OutStream;
//     DataExch: Record "Data Exch. Field";
//     EWayBillNo: Text[30];
//     EWayBillDateTime: Variant;
//     EWayExpiryDateTime: Variant;
//     FL: File;
//     TransferShipmentHeader2: Record "Transfer Shipment Header";
//     Mnth: Text[2];
//     Day: Text[2];
//     Location: Record Location;
//     TransportMethod: Record "Transport Method";
//     State_Gst: Code[2];
//     State_rec: Record State;
//     ResponsibilityCenter: Record "Responsibility Center";
// begin
//     GetCompanyInfo;
//     TknNo := GetAccessToken;
//     if TransportMethod.Get(TransferShipmentHeaderL."Transport Method") then;
//     if ShippingAgent.Get(TransferShipmentHeaderL."Shipping Agent Code") then;
//     if Location.Get(TransferShipmentHeaderL."Transfer-from Code") then;
//     if VendorL.Get(TransferShipmentHeaderL."Vendor No.") then
//         CustGstin := VendorL."GST Registration No.";
//     if CustGstin = GetGSTIN(TransferShipmentHeaderL."Responsibility Center") then
//         Error('GST Registration No. is same for both consignor and consignee');
//     // TransferShipmentHeaderL.RESET;
//     // TransferShipmentHeaderL.SETRANGE("E-Way-to generate",TRUE);
//     // IF TransferShipmentHeaderL.FINDSET THEN
//     //  REPEAT
//     TransferShipmentHeaderL.TestField("E-Way Bill No.", '');
//     TransferShipmentHeaderL.TestField("Transportation Distance");
//     StartJason;
//     AddToJason('access_token', TknNo);
//     AddToJason('userGstin', GetGSTIN(TransferShipmentHeaderL."Transfer-from Code"));
//     AddToJason('supply_type', 'outward');
//     AddToJason('sub_supply_type', 'Others');
//     AddToJason('sub_supply_description', 'Others');
//     AddToJason('document_type', 'Challan');
//     AddToJason('document_number', TransferShipmentHeaderL."No.");
//     if Date2dmy(TransferShipmentHeaderL."Posting Date", 2) > 9 then
//         Mnth := Format(Date2dmy(TransferShipmentHeaderL."Posting Date", 2))
//     else
//         Mnth := '0' + Format(Date2dmy(TransferShipmentHeaderL."Posting Date", 2));
//     if Date2dmy(TransferShipmentHeaderL."Posting Date", 1) > 9 then
//         Day := Format(Date2dmy(TransferShipmentHeaderL."Posting Date", 1))
//     else
//         Day := '0' + Format(Date2dmy(TransferShipmentHeaderL."Posting Date", 1));
//     ResponsibilityCenter.Get(TransferShipmentHeaderL."Responsibility Center");
//     AddToJason('document_date', Day + '/' + Mnth + '/' + Format(Date2dmy(TransferShipmentHeaderL."Posting Date", 3)));
//     //AddToJason('gstin_of_consignor',ResponsibilityCenter."GST Registration No.");  //TransferShipmentHeaderL."Transfer-from Code"));//Alle
//     AddToJason('legal_name_of_consignor', Location.Name);
//     AddToJason('address1_of_consignor', Location.Address);
//     AddToJason('address2_of_consignor', Location."Address 2");
//     AddToJason('place_of_consignor', Location.City);
//     AddToJason('pincode_of_consignor', Location."Post Code");
//     AddToJason('state_of_consignor', GetStateCode(Location."State Code"));
//     AddToJason('actual_from_state_name', GetStateCode(Location."State Code"));
//     State_Gst := '';
//     State_Gst := CopyStr(CustGstin, 1, 2);
//     State_rec.Reset;
//     State_rec.SetRange("State Code (GST Reg. No.)", State_Gst);
//     if State_rec.FindFirst then;
//     AddToJason('gstin_of_consignee', CustGstin);
//     AddToJason('legal_name_of_consignee', TransferShipmentHeaderL."Transfer-to Name");
//     AddToJason('address1_of_consignee', TransferShipmentHeaderL."Transfer-to Address");
//     AddToJason('address2_of_consignee', TransferShipmentHeaderL."Transfer-to Address 2");
//     AddToJason('place_of_consignee', TransferShipmentHeaderL."Transfer-to City");
//     AddToJason('pincode_of_consignee', TransferShipmentHeaderL."Transfer-to Post Code");
//     Location.Get(TransferShipmentHeaderL."Transfer-to Code");
//     AddToJason('state_of_supply', State_rec.Description);   //GetStateCode(Location."State Code"));
//     AddToJason('actual_to_state_name', GetStateCode(Location."State Code"));
//     TransferShipmentLineL.Reset;
//     TransferShipmentLineL.SetRange("Document No.", TransferShipmentHeaderL."No.");
//     if TransferShipmentLineL.FindSet then
//         TransferShipmentLineL.CalcSums("GST Base Amount");
//     if TransferShipmentLineL."GST Base Amount" <> 0 then begin
//         AddToJason('total_invoice_value', TransferShipmentLineL."GST Base Amount");
//         AddToJason('taxable_amount', TransferShipmentLineL."GST Base Amount")
//     end else begin
//         TransferShipmentLineL.CalcSums(Amount);
//         AddToJason('total_invoice_value', TransferShipmentLineL.Amount);
//         AddToJason('taxable_amount', TransferShipmentLineL.Amount);
//     end;
//     AddToJason('cgst_amount', GetGSTAmount(TransferShipmentHeaderL."No.", 'CGST'));
//     AddToJason('sgst_amount', GetGSTAmount(TransferShipmentHeaderL."No.", 'SGST'));
//     AddToJason('igst_amount', GetGSTAmount(TransferShipmentHeaderL."No.", 'IGST'));
//     AddToJason('cess_amount', GetGSTAmount(TransferShipmentHeaderL."No.", 'CESS'));
//     AddToJason('transporter_id', ShippingAgent."Transporter GST No.");
//     AddToJason('transporter_name', TransferShipmentHeaderL."Shipping Agent Code");
//     AddToJason('transporter_document_number', TransferShipmentHeaderL."External Document No.");
//     AddToJason('transportation_mode', TransportMethod."E-Way transport method");//FORMAT(TransferShipmentHeaderL."Transport Method"));
//     AddToJason('transportation_distance', TransferShipmentHeaderL."Transportation Distance");
//     AddToJason('transporter_document_date', GetDateFormated(TransferShipmentHeaderL."Posting Date"));//FORMAT(TransferShipmentHeaderL."Transfer Order Date"));
//     AddToJason('vehicle_number', DelChr(TransferShipmentHeaderL."Vehicle No.", '=', ' ,-!@$#%^&*()_+{}|:<>?'));
//     AddToJason('vehicle_type', 'Regular');
//     if Confirm('Do you want instant genrate the E-way') then
//         AddToJason('generate_status', '1')
//     else
//         AddToJason('generate_status', '0');
//     AddToJason('data_source', 'erp');
//     AddToJason('user_ref', '123134434f');//DELCHR(USERID,'=','/, \'));
//     AddToJason('email', 'gurgaon.dispatch@zavenir.com');
//     AddToJason('location_code', 'XYZ');//TransferShipmentHeaderL."Transfer-from Code");
//     AddToJason('eway_bill_status', 'ABC');
//     AddToJason('auto_print', 'Y');
//     TransferShipmentLineL.Reset;
//     TransferShipmentLineL.SetRange("Document No.", TransferShipmentHeaderL."No.");
//     if TransferShipmentLineL.FindSet then begin
//         JsonTextWriter.WritePropertyName('itemList');
//         JsonTextWriter.WriteStartArray;
//         repeat
//             JsonTextWriter.WriteStartObject;
//             AddToJason('product_name', TransferShipmentLineL."Product Group Code");
//             AddToJason('product_description', TransferShipmentLineL."Product Group Code");
//             AddToJason('hsn_code', TransferShipmentLineL."HSN/SAC Code");
//             AddToJason('quantity', TransferShipmentLineL.Quantity);
//             AddToJason('unit_of_product', GetUOM(TransferShipmentLineL."Unit of Measure Code"));
//             AddToJason('cgst_rate', GetGSTRate(TransferShipmentLineL."Document No.", 'CGST'));
//             AddToJason('sgst_rate', GetGSTRate(TransferShipmentLineL."Document No.", 'SGST'));
//             AddToJason('igst_rate', GetGSTRate(TransferShipmentLineL."Document No.", 'IGST'));
//             AddToJason('cess_rate', GetGSTRate(TransferShipmentLineL."Document No.", 'CESS'));
//             AddToJason('cessAdvol', 0);
//             AddToJason('taxable_amount', TransferShipmentLineL."GST Base Amount");
//             JsonTextWriter.WriteEndObject;
//         until TransferShipmentLineL.Next = 0;
//     end;
//     EndJason;
//     // UNTIL TransferShipmentHeaderL.NEXT = 0;
//     GenerateEWay('');
//     TmpBlob.Init;
//     TmpBlob.Blob.CreateInstream(ResponseInStream_L);
//     if HttpWebRequestMgt.GetResponse(ResponseInStream_L, HttpStatusCode_L, ResponseHeaders_L) then begin
//         ResponseInStream_L.Read(ResponseText);
//         ////  MESSAGE('%1',ResponseText);
//         Json := ResponseText;
//         //  MESSAGE('%1',ResponseText);
//         ReadJSon(Json, DataExch);
//         EWayBillNo := GetJsonNodeValue('results.message.ewayBillNo');
//         EWayBillDateTime := GetJsonNodeValue('results.message.ewayBillDate');
//         EWayExpiryDateTime := GetJsonNodeValue('results.message.validUpto');
//         InsertRequestId(GetJsonNodeValue('results.requestId'), TransferShipmentHeaderL."No.");
//         Commit;
//         if EWayBillNo <> '' then begin
//             TransferShipmentHeader2.Get(TransferShipmentHeaderL."No.");
//             TransferShipmentHeader2."E-Way Bill No." := Format(EWayBillNo);
//             TransferShipmentHeader2."E-Way Bill Date" := EWayBillDateTime;
//             TransferShipmentHeader2."E-Way Bill Validity" := EWayExpiryDateTime;
//             TransferShipmentHeader2."E-Way Generated" := true;
//             TransferShipmentHeader2."E-Way Canceled" := false;
//             TransferShipmentHeader2.Modify;
//         end else
//             Error('%1 Please share this request ID for support %2', GetJsonNodeValue('results.message'), GetJsonNodeValue('results.requestId'));
//     end;
// end;
// [EventSubscriber(Objecttype::Page, 50196, 'CreateJSONRGPShipmentEvent', '', false, false)]
// procedure CreateJSONRGPShipment(var RGPShipmentHeaderL: Record "SSD RGP Shipment Header")
// var
//     VendorL: Record Vendor;
//     RGPShipmentLineL: Record "SSD RGP Shipment Line";
//     ShiptoAddressL: Record "Ship-to Address";
//     CustGstin: Code[15];
//     TknNo: Text[50];
//     ResponseInStream_L: InStream;
//     HttpStatusCode_L: dotnet HttpStatusCode;
//     ResponseHeaders_L: dotnet NameValueCollection;
//     ResponseText: Text;
//     JString: Text;
//     OutStrm: OutStream;
//     DataExch: Record "Data Exch. Field";
//     EWayBillNo: Text[30];
//     EWayBillDateTime: Variant;
//     EWayExpiryDateTime: Variant;
//     FL: File;
//     RGPShipmentHeader2: Record "SSD RGP Shipment Header";
//     Mnth: Text[2];
//     Day: Text[2];
//     Location: Record Location;
//     TransportMethod: Record "Transport Method";
//     Item: Record Item;
//     State_Gst: Code[2];
//     State_rec: Record State;
// begin
//     GetCompanyInfo;
//     TknNo := GetAccessToken;
//     if TransportMethod.Get(RGPShipmentHeaderL."Transport Method") then;
//     if Location.Get(RGPShipmentHeaderL."Location Code") then;
//     if ShippingAgent.Get(RGPShipmentHeaderL."Shipping Agent Code") then;
//     // ReturnShipmentHeaderL.RESET;
//     // ReturnShipmentHeaderL.SETRANGE("E-Way-to generate",TRUE);
//     // IF ReturnShipmentHeaderL.FINDSET THEN
//     //  REPEAT
//     RGPShipmentHeaderL.TestField("E-Way Bill No.", '');
//     RGPShipmentHeaderL.TestField("Transportation Distance");
//     StartJason;
//     AddToJason('access_token', TknNo);
//     AddToJason('userGstin', GetGSTIN(RGPShipmentHeaderL."Location Code"));
//     AddToJason('supply_type', 'outward');
//     AddToJason('sub_supply_type', 'Others');
//     AddToJason('sub_supply_description', 'Others');
//     AddToJason('document_type', 'Challan');
//     AddToJason('document_number', RGPShipmentHeaderL."No.");
//     if Date2dmy(RGPShipmentHeaderL."Posting Date", 2) > 9 then
//         Mnth := Format(Date2dmy(RGPShipmentHeaderL."Posting Date", 2))
//     else
//         Mnth := '0' + Format(Date2dmy(RGPShipmentHeaderL."Posting Date", 2));
//     AddToJason('document_date', GetDateFormated(RGPShipmentHeaderL."Posting Date"));//FORMAT(DATE2DMY(ReturnShipmentHeaderL."Posting Date",1))+'/'+Mnth+'/'+FORMAT(DATE2DMY(ReturnShipmentHeaderL."Posting Date",3)));
//     AddToJason('gstin_of_consignor', GetGSTIN(RGPShipmentHeaderL."Location Code"));
//     AddToJason('legal_name_of_consignor', Location.Name);
//     AddToJason('address1_of_consignor', Location.Address);
//     AddToJason('address2_of_consignor', Location."Address 2");
//     AddToJason('place_of_consignor', Location.City);
//     AddToJason('pincode_of_consignor', Location."Post Code");
//     AddToJason('state_of_consignor', GetStateCode(Location."State Code"));
//     AddToJason('actual_from_state_name', GetStateCode(Location."State Code"));
//     //IF ShiptoAddressL.GET(RGPShipmentHeaderL."Party No.",RGPShipmentHeaderL."Ship-to Code") THEN
//     //CustGstin := ShiptoAddressL."GST Registration No."
//     //ELSE
//     if VendorL.Get(RGPShipmentHeaderL."Party No.") then
//         CustGstin := VendorL."GST Registration No.";
//     State_Gst := '';
//     State_Gst := CopyStr(CustGstin, 1, 2);
//     State_rec.Reset;
//     State_rec.SetRange("State Code (GST Reg. No.)", State_Gst);
//     if State_rec.FindFirst then;
//     AddToJason('gstin_of_consignee', CustGstin);
//     AddToJason('legal_name_of_consignee', RGPShipmentHeaderL."Party Name");
//     AddToJason('address1_of_consignee', RGPShipmentHeaderL."Party Address");
//     AddToJason('address2_of_consignee', RGPShipmentHeaderL."Party Address 2");
//     AddToJason('place_of_consignee', RGPShipmentHeaderL."Party City");
//     AddToJason('pincode_of_consignee', RGPShipmentHeaderL."Party PostCode");
//     AddToJason('state_of_supply', State_rec.Description);   //GetStateCode(RGPShipmentHeaderL."Party State"));
//     AddToJason('actual_to_state_name', GetStateCode(RGPShipmentHeaderL."Party State"));
//     RGPShipmentLineL.Reset;
//     RGPShipmentLineL.SetRange("Document No.", RGPShipmentHeaderL."No.");
//     RGPShipmentLineL.CalcSums("Line Amount");
//     AddToJason('total_invoice_value', RGPShipmentLineL."Line Amount");
//     AddToJason('taxable_amount', RGPShipmentLineL."Line Amount");
//     AddToJason('cgst_amount', GetGSTAmount(RGPShipmentHeaderL."No.", 'CGST'));
//     AddToJason('sgst_amount', GetGSTAmount(RGPShipmentHeaderL."No.", 'SGST'));
//     AddToJason('igst_amount', GetGSTAmount(RGPShipmentHeaderL."No.", 'IGST'));
//     AddToJason('cess_amount', GetGSTAmount(RGPShipmentHeaderL."No.", 'CESS'));
//     AddToJason('transporter_id', ShippingAgent."Transporter GST No.");
//     AddToJason('transporter_name', RGPShipmentHeaderL."Shipping Agent Code");
//     AddToJason('transporter_document_number', RGPShipmentHeaderL."LR No.");
//     AddToJason('transportation_mode', TransportMethod."E-Way transport method");//FORMAT(ReturnShipmentHeaderL."Transport Method"));
//     AddToJason('transportation_distance', RGPShipmentHeaderL."Transportation Distance");
//     AddToJason('transporter_document_date', GetDateFormated(RGPShipmentHeaderL."LR/RR Date"));
//     AddToJason('vehicle_number', DelChr(RGPShipmentHeaderL."Vehical No.", '=', ' ,/\-()!@#$%^&*()_+{}?'));
//     AddToJason('vehicle_type', 'Regular');
//     if Confirm('Do you want instant genrate the E-way') then
//         AddToJason('generate_status', '1')
//     else
//         AddToJason('generate_status', '0');
//     AddToJason('data_source', 'erp');
//     AddToJason('user_ref', DelChr(RGPShipmentHeaderL."User ID", '=', ' /\,;-'));
//     AddToJason('email', 'gurgaon.dispatch@zavenir.com');
//     AddToJason('location_code', RGPShipmentHeaderL."Location Code");
//     AddToJason('eway_bill_status', 'ABC');
//     AddToJason('auto_print', 'Y');
//     RGPShipmentLineL.Reset;
//     RGPShipmentLineL.SetRange("Document No.", RGPShipmentHeaderL."No.");
//     if RGPShipmentLineL.FindSet then begin
//         JsonTextWriter.WritePropertyName('itemList');
//         JsonTextWriter.WriteStartArray;
//         repeat
//             Item.Get(RGPShipmentLineL."No.");
//             JsonTextWriter.WriteStartObject;
//             AddToJason('product_name', RGPShipmentLineL."Product Group Code");
//             AddToJason('product_description', RGPShipmentLineL."Product Group Code");
//             AddToJason('hsn_code', Item."HSN/SAC Code");
//             AddToJason('quantity', RGPShipmentLineL.Quantity);
//             AddToJason('unit_of_product', (Item."Base Unit of Measure"));
//             AddToJason('cgst_rate', GetGSTRate(RGPShipmentLineL."Document No.", 'CGST'));
//             AddToJason('sgst_rate', GetGSTRate(RGPShipmentLineL."Document No.", 'SGST'));
//             AddToJason('igst_rate', GetGSTRate(RGPShipmentLineL."Document No.", 'IGST'));
//             AddToJason('cess_rate', GetGSTRate(RGPShipmentLineL."Document No.", 'CESS'));
//             AddToJason('cessAdvol', '');
//             AddToJason('taxable_amount', RGPShipmentLineL."Line Amount");
//             JsonTextWriter.WriteEndObject;
//         until RGPShipmentLineL.Next = 0;
//     end;
//     EndJason;
//     // UNTIL ReturnShipmentHeaderL.NEXT = 0;
//     GenerateEWay('');
//     TmpBlob.Init;
//     TmpBlob.Blob.CreateInstream(ResponseInStream_L);
//     if HttpWebRequestMgt.GetResponse(ResponseInStream_L, HttpStatusCode_L, ResponseHeaders_L) then begin
//         ResponseInStream_L.Read(ResponseText);
//         ////  MESSAGE('%1',ResponseText);
//         Json := ResponseText;
//         //  MESSAGE('%1',ResponseText);
//         DataExch.DeleteAll;
//         ReadJSon(Json, DataExch);
//         EWayBillNo := GetJsonNodeValue('results.message.ewayBillNo');
//         EWayBillDateTime := GetJsonNodeValue('results.message.ewayBillDate');
//         EWayExpiryDateTime := GetJsonNodeValue('results.message.validUpto');
//         InsertRequestId(GetJsonNodeValue('results.requestId'), RGPShipmentHeaderL."No.");
//         Commit;
//         if EWayBillNo <> '' then begin
//             RGPShipmentHeader2.Get(RGPShipmentHeaderL."No.");
//             RGPShipmentHeader2."E-Way Bill No." := Format(EWayBillNo);
//             RGPShipmentHeader2."E-Way Bill Date" := EWayBillDateTime;
//             RGPShipmentHeader2."E-Way Bill Validity" := EWayExpiryDateTime;
//             RGPShipmentHeader2."E-Way Generated" := true;
//             RGPShipmentHeader2."E-Way Canceled" := false;
//             RGPShipmentHeader2.Modify;
//         end else
//             Error('%1 Please share this request ID for support %2', GetJsonNodeValue('results.message'), GetJsonNodeValue('results.requestId'));
//     end;
//     //END;
// end;
// [EventSubscriber(Objecttype::Page, 50187, 'CreateJSONDeliveryChallanEvent', '', false, false)]
// procedure CreateJSONDeliveryChallan(var DeliveryChallanHeaderL: Record "Delivery Challan Header")
// var
//     VendorL: Record Vendor;
//     DeliveryChallanLineL: Record "Delivery Challan Line";
//     ShiptoAddressL: Record "Ship-to Address";
//     CustGstin: Code[15];
//     TknNo: Text[50];
//     ItemL: Record Item;
//     ResponseInStream_L: InStream;
//     HttpStatusCode_L: dotnet HttpStatusCode;
//     ResponseHeaders_L: dotnet NameValueCollection;
//     ResponseText: Text;
//     JString: Text;
//     OutStrm: OutStream;
//     DataExch: Record "Data Exch. Field";
//     EWayBillNo: Text[30];
//     EWayBillDateTime: Variant;
//     EWayExpiryDateTime: Variant;
//     FL: File;
//     DeliveryChallanHeader2: Record "Delivery Challan Header";
//     TransportMethod: Record "Transport Method";
//     Location: Record Location;
//     State_Gst: Code[2];
//     State_rec: Record State;
// begin
//     GetCompanyInfo;
//     TknNo := GetAccessToken;
//     if TransportMethod.Get(DeliveryChallanHeaderL."Transportation Distance") then;
//     if ShippingAgent.Get(DeliveryChallanHeaderL."Shipping Agent Code") then;
//     // DeliveryChallanHeaderL.RESET;
//     // DeliveryChallanHeaderL.SETRANGE("E-Way-to generate",TRUE);
//     // IF DeliveryChallanHeaderL.FINDSET THEN
//     //  REPEAT
//     DeliveryChallanHeaderL.TestField("E-Way Bill No.", '');
//     DeliveryChallanHeaderL.TestField("Transportation Distance");
//     StartJason;
//     AddToJason('access_token', TknNo);
//     AddToJason('userGstin', CompanyInformation."GST Registration No.");
//     AddToJason('supply_type', 'outward');
//     AddToJason('sub_supply_type', 'Job Work');
//     AddToJason('sub_supply_description', '');
//     AddToJason('document_type', 'Challan');
//     AddToJason('document_number', DeliveryChallanHeaderL."No.");
//     AddToJason('document_date', DeliveryChallanHeaderL."Posting Date");
//     AddToJason('gstin_of_consignor', CompanyInformation."GST Registration No.");
//     AddToJason('legal_name_of_consignor', CompanyInformation.Name);
//     AddToJason('address1_of_consignor', CompanyInformation.Address);
//     AddToJason('address2_of_consignor', CompanyInformation."Address 2");
//     AddToJason('place_of_consignor', CompanyInformation.City);
//     AddToJason('pincode_of_consignor', CompanyInformation."Post Code");
//     AddToJason('state_of_consignor', GetStateCode(CompanyInformation.State));
//     AddToJason('actual_from_state_name', GetStateCode(CompanyInformation.State));
//     if VendorL.Get(DeliveryChallanHeaderL."Vendor No.") then
//         CustGstin := VendorL."GST Registration No.";
//     State_Gst := '';
//     State_Gst := CopyStr(CustGstin, 1, 2);
//     State_rec.Reset;
//     State_rec.SetRange("State Code (GST Reg. No.)", State_Gst);
//     if State_rec.FindFirst then;
//     AddToJason('gstin_of_consignee', CustGstin);
//     AddToJason('legal_name_of_consignee', VendorL.Name);
//     AddToJason('address1_of_consignee', VendorL.Address);
//     AddToJason('address2_of_consignee', VendorL."Address 2");
//     AddToJason('place_of_consignee', VendorL.City);
//     AddToJason('pincode_of_consignee', VendorL."Post Code");
//     AddToJason('state_of_supply', State_rec.Description);   //GetStateCode(VendorL."State Code"));
//     AddToJason('actual_to_state_name', GetStateCode(VendorL."State Code"));
//     AddToJason('total_invoice_value', GetTaxableAmountSalesInvoice(DeliveryChallanHeaderL."No."));
//     AddToJason('taxable_amount', GetTaxableAmountSalesInvoice(DeliveryChallanHeaderL."No."));
//     AddToJason('cgst_amount', GetGSTAmount(DeliveryChallanHeaderL."No.", 'CGST'));
//     AddToJason('sgst_amount', GetGSTAmount(DeliveryChallanHeaderL."No.", 'SGST'));
//     AddToJason('igst_amount', GetGSTAmount(DeliveryChallanHeaderL."No.", 'IGST'));
//     AddToJason('cess_amount', GetGSTAmount(DeliveryChallanHeaderL."No.", 'CESS'));
//     AddToJason('transporter_id', ShippingAgent."Transporter GST No.");
//     AddToJason('transporter_name', DeliveryChallanHeaderL."Shipping Agent Code");
//     AddToJason('transporter_document_number', DeliveryChallanHeaderL."LR/RR No.");
//     AddToJason('transportation_mode', TransportMethod."E-Way transport method");
//     AddToJason('transportation_distance', DeliveryChallanHeaderL."Transportation Distance");
//     //AddToJason('transporter_document_date',GetDateFormated(DeliveryChallanHeaderL."Date Of Issue"));//Alle
//     AddToJason('vehicle_number', DeliveryChallanHeaderL."Vehical No.");//Alle
//     AddToJason('vehicle_type', 'Regular');
//     AddToJason('generate_status', '1');
//     AddToJason('data_source', 'erp');
//     AddToJason('user_ref', '1232435466sdsf234');
//     AddToJason('email', 'gurgaon.dispatch@zavenir.com');
//     AddToJason('location_code', 'XYZ');
//     AddToJason('eway_bill_status', 'ABC');
//     AddToJason('auto_print', 'Y');
//     DeliveryChallanLineL.Reset;
//     DeliveryChallanLineL.SetRange("Document No.", DeliveryChallanHeaderL."No.");
//     if DeliveryChallanLineL.FindSet then begin
//         JsonTextWriter.WritePropertyName('ItemList');
//         JsonTextWriter.WriteStartArray;
//         repeat
//             JsonTextWriter.WriteStartObject;
//             ItemL.Get(DeliveryChallanLineL."Item No.");
//             AddToJason('product_name', ItemL."Product Group Code");
//             AddToJason('product_description', ItemL."Product Group Code");
//             AddToJason('hsn_code', DeliveryChallanLineL."HSN/SAC Code");
//             AddToJason('quantity', DeliveryChallanLineL.Quantity);
//             AddToJason('unit_of_product', GetUOM(DeliveryChallanLineL."Unit of Measure"));
//             AddToJason('cgst_rate', GetGSTRate(DeliveryChallanLineL."Document No.", 'CGST'));
//             AddToJason('sgst_rate', GetGSTRate(DeliveryChallanLineL."Document No.", 'SGST'));
//             AddToJason('igst_rate', GetGSTRate(DeliveryChallanLineL."Document No.", 'IGST'));
//             AddToJason('cess_rate', GetGSTRate(DeliveryChallanLineL."Document No.", 'CESS'));
//             AddToJason('cessAdvol', '');
//             AddToJason('taxable_amount', DeliveryChallanLineL."GST Base Amount");
//             JsonTextWriter.WriteEndObject;
//         until DeliveryChallanLineL.Next = 0;
//     end;
//     EndJason;
//     // UNTIL DeliveryChallanHeaderL.NEXT = 0;
//     GenerateEWay('');
//     TmpBlob.Init;
//     TmpBlob.Blob.CreateInstream(ResponseInStream_L);
//     if HttpWebRequestMgt.GetResponse(ResponseInStream_L, HttpStatusCode_L, ResponseHeaders_L) then begin
//         ResponseInStream_L.Read(ResponseText);
//         ////  MESSAGE('%1',ResponseText);
//         Json := ResponseText;
//         //  MESSAGE('%1',ResponseText);
//         ReadJSon(Json, DataExch);
//         EWayBillNo := GetJsonNodeValue('results.message.ewayBillNo');
//         EWayBillDateTime := GetJsonNodeValue('results.message.ewayBillDate');
//         EWayExpiryDateTime := GetJsonNodeValue('results.message.validUpto');
//         DeliveryChallanHeader2.Get(DeliveryChallanHeaderL."No.");
//         DeliveryChallanHeader2."E-Way Bill No." := Format(EWayBillNo);
//         DeliveryChallanHeader2."E-Way Bill Date" := EWayBillDateTime;
//         DeliveryChallanHeader2."E-Way Bill Validity" := EWayExpiryDateTime;
//         DeliveryChallanHeader2."E-Way Generated" := true;
//         DeliveryChallanHeader2.Modify;
//     end;
// end;
// procedure CreateJSONSalesInvoiceDemo(var SalesInvoiceHeaderL: Record "Sales Invoice Header")
// var
//     CustomerL: Record Customer;
//     SalesInvoiceLineL: Record "Sales Invoice Line";
//     ShiptoAddressL: Record "Ship-to Address";
//     CustGstin: Code[15];
//     TknNo: Text[50];
//     SalesInvoiceHeader2: Record "Sales Invoice Header";
//     ResponseInStream_L: InStream;
//     HttpStatusCode_L: dotnet HttpStatusCode;
//     ResponseHeaders_L: dotnet NameValueCollection;
//     ResponseText: Text;
//     JString: Text;
//     OutStrm: OutStream;
//     DataExch: Record "Data Exch. Field";
//     EWayBillNo: Text[30];
//     EWayBillDateTime: Variant;
//     EWayExpiryDateTime: Variant;
//     SalesInvoiceHeader: Record "Sales Invoice Header";
//     FL: File;
//     TransportMethod: Record "Transport Method";
// begin
//     GetCompanyInfo;
//     TknNo := GetAccessToken;
//     if TransportMethod.Get(SalesInvoiceHeaderL."Transport Method") then;
//     // SalesInvoiceHeaderL.RESET;
//     // SalesInvoiceHeaderL.SETRANGE("E-Way-to generate",TRUE);
//     // IF SalesInvoiceHeaderL.FINDSET THEN
//     //  REPEAT
//     StartJason;
//     AddToJason('access_token', TknNo);
//     AddToJason('userGstin', '05AAABB0639G1Z8');
//     AddToJason('supply_type', 'Outward');
//     AddToJason('sub_supply_type', 'Supply');
//     AddToJason('document_type', 'Tax Invoice');
//     AddToJason('document_number', SalesInvoiceHeaderL."No.");
//     AddToJason('document_date', '05/04/2018');//FORMAT(SalesInvoiceHeaderL."Posting Date",0,1));
//     AddToJason('gstin_of_consignor', '05AAABB0639G1Z8');
//     AddToJason('legal_name_of_consignor', CompanyInformation.Name);
//     AddToJason('address1_of_consignor', CompanyInformation.Address);
//     AddToJason('address2_of_consignor', CompanyInformation."Address 2");
//     AddToJason('place_of_consignor', CompanyInformation.City);
//     AddToJason('pincode_of_consignor', CompanyInformation."Post Code");
//     AddToJason('state_of_consignor', 'RAJASTHAN');
//     if ShiptoAddressL.Get(SalesInvoiceHeaderL."Bill-to Customer No.", SalesInvoiceHeaderL."Ship-to Code") then
//         CustGstin := ShiptoAddressL."GST Registration No."
//     else
//         if CustomerL.Get(SalesInvoiceHeaderL."Bill-to Customer No.") then
//             CustGstin := CustomerL."GST Registration No.";
//     AddToJason('gstin_of_consignee', '05AAABC0181E1ZE');
//     AddToJason('legal_name_of_consignee', SalesInvoiceHeaderL."Ship-to Name");
//     AddToJason('address1_of_consignee', SalesInvoiceHeaderL."Ship-to Address");
//     AddToJason('address2_of_consignee', SalesInvoiceHeaderL."Ship-to Address 2");
//     AddToJason('place_of_consignee', SalesInvoiceHeaderL."Ship-to City");
//     AddToJason('pincode_of_consignee', '689788');
//     AddToJason('state_of_supply', 'KARNATAKA');
//     AddToJason('taxable_amount', '100000');
//     AddToJason('cgst_amount', GetGSTAmount(SalesInvoiceHeaderL."No.", 'CGST'));
//     AddToJason('sgst_amount', GetGSTAmount(SalesInvoiceHeaderL."No.", 'SGST'));
//     AddToJason('igst_amount', '2000');
//     AddToJason('cess_amount', GetGSTAmount(SalesInvoiceHeaderL."No.", 'CESS'));
//     AddToJason('transporter_id', 'TCIP012');
//     AddToJason('transporter_name', SalesInvoiceHeaderL."Shipping Agent Code");
//     AddToJason('transporter_document_number', SalesInvoiceHeaderL."LR/RR No.");
//     AddToJason('transportation_mode', TransportMethod."E-Way transport method");
//     AddToJason('transportation_distance', '666');
//     AddToJason('transporter_document_date', '05/04/2018');//FORMAT(SalesInvoiceHeaderL."LR/RR Date"));
//     AddToJason('vehicle_number', SalesInvoiceHeaderL."Vehicle No.");
//     AddToJason('vehicle_type', 'Regular');
//     AddToJason('generate_status', '1');
//     AddToJason('data_source', 'erp');
//     AddToJason('user_ref', '1232435466sdsf234');
//     AddToJason('email', 'gurgaon.dispatch@zavenir.com');
//     AddToJason('location_code', 'XYZ');
//     AddToJason('eway_bill_status', 'ABC');
//     AddToJason('auto_print', 'Y');
//     SalesInvoiceLineL.Reset;
//     SalesInvoiceLineL.SetRange("Document No.", SalesInvoiceHeaderL."No.");
//     if SalesInvoiceLineL.FindSet then begin
//         JsonTextWriter.WritePropertyName('ItemList');
//         JsonTextWriter.WriteStartArray;
//         repeat
//             JsonTextWriter.WriteStartObject;
//             AddToJason('product_name', 'Wheat');
//             AddToJason('product_description', 'Wheat');
//             AddToJason('hsn_code', '1001');
//             AddToJason('quantity', SalesInvoiceLineL.Quantity);
//             AddToJason('unit_of_product', 'BOX');
//             AddToJason('cgst_rate', GetGSTRate(SalesInvoiceLineL."Document No.", 'CGST'));
//             AddToJason('sgst_rate', GetGSTRate(SalesInvoiceLineL."Document No.", 'SGST'));
//             AddToJason('igst_rate', '20');
//             AddToJason('cess_rate', GetGSTRate(SalesInvoiceLineL."Document No.", 'CESS'));
//             AddToJason('cessAdvol', '');
//             AddToJason('taxable_amount', '10000');
//             JsonTextWriter.WriteEndObject;
//         until SalesInvoiceLineL.Next = 0;
//     end;
//     EndJason;
//     // UNTIL SalesInvoiceHeaderL.NEXT = 0;
//     GenerateEWay('');
//     TmpBlob.Init;
//     TmpBlob.Blob.CreateInstream(ResponseInStream_L);
//     if HttpWebRequestMgt.GetResponse(ResponseInStream_L, HttpStatusCode_L, ResponseHeaders_L) then begin
//         ResponseInStream_L.Read(ResponseText);
//         ////  MESSAGE('%1',ResponseText);
//         Json := ResponseText;
//         //  MESSAGE('%1',ResponseText);
//         ReadJSon(Json, DataExch);
//         EWayBillNo := GetJsonNodeValue('results.message.ewayBillNo');
//         EWayBillDateTime := GetJsonNodeValue('results.message.ewayBillDate');
//         EWayExpiryDateTime := GetJsonNodeValue('results.message.validUpto');
//         SalesInvoiceHeader2.Get(SalesInvoiceHeaderL."No.");
//         SalesInvoiceHeader2."E-Way Bill No." := Format(EWayBillNo);
//         SalesInvoiceHeader2."E-Way Bill Date" := EWayBillDateTime;
//         SalesInvoiceHeader2."E-Way Bill Validity" := EWayExpiryDateTime;
//         SalesInvoiceHeader2."E-Way Generated" := true;
//         SalesInvoiceHeader2.Modify;
//     end;
// end;
// [EventSubscriber(Objecttype::Page, 50000, 'ConsolitedEWayBillSalesInvoiceEvent', '', false, false)]
// procedure ConsolitedEWayBillSalesInvoice(JsonStrng: Text)
// var
//     ResponseInStream_L: InStream;
//     HttpStatusCode_L: dotnet HttpStatusCode;
//     ResponseHeaders_L: dotnet NameValueCollection;
//     ResponseText: Text;
//     JString: Text;
//     OutStrm: OutStream;
//     DataExch: Record "Data Exch. Field";
//     EWayBillNo: Text[30];
//     EWayBillDateTime: Variant;
//     EWayExpiryDateTime: Variant;
//     SalesInvoiceHeader: Record "Sales Invoice Header";
//     FL: File;
//     TknNo: Text;
//     Location: Record Location;
// begin
//     GetCompanyInfo;
//     if Location.Get(SalesInvoiceHeader."Location Code") then;
//     TknNo := GetAccessToken;
//     SalesInvoiceHeader.Reset;
//     SalesInvoiceHeader.SetRange("E-Way-to generate", true);
//     SalesInvoiceHeader.SetRange("E-Way Generated", true);
//     if SalesInvoiceHeader.FindFirst then begin
//         StartJason;
//         AddToJason('access_token', TknNo);
//         AddToJason('userGstin', CompanyInformation."GST Registration No.");
//         AddToJason('place_of_consignor', CompanyInformation.City);
//         AddToJason('pincode_of_consignor', CompanyInformation."Post Code");
//         AddToJason('state_of_consignor', GetStateCode(CompanyInformation.State));
//         AddToJason('vehicle_number', SalesInvoiceHeader."Vehicle No.");
//         AddToJason('mode_of_transport', SalesInvoiceHeader."Mode of Transport");
//         AddToJason('transporter_document_number', SalesInvoiceHeader."LR/RR No.");
//         AddToJason('transporter_document_date', GetDateFormated(SalesInvoiceHeader."LR/RR Date"));
//         JsonTextWriter.WritePropertyName('list_of_eway_bills');
//         JsonTextWriter.WriteStartArray;
//         SalesInvoiceHeader.Reset;
//         SalesInvoiceHeader.SetRange("E-Way-to generate", true);
//         SalesInvoiceHeader.SetRange("E-Way Generated", true);
//         if SalesInvoiceHeader.FindSet then
//             repeat
//                 JsonTextWriter.WriteStartObject;
//                 AddToJason('eway_bill_number', SalesInvoiceHeader."E-Way Bill No.");
//                 JsonTextWriter.WriteEndObject;
//             until SalesInvoiceHeader.Next = 0;
//         EndJason;
//         GetJason;
//         if FILE.Exists(GetClientFile + 'J.txt') then
//             Erase(GetClientFile + 'J.txt');
//         FL.Create(GetClientFile + 'J.txt');
//         FL.CreateOutstream(OutStrm);
//         OutStrm.WriteText(Format(Json));
//         FL.Close;
//         Message('%1', Json);
//         HttpWebRequestMgt.Initialize('https://pro.mastersindia.co/ewayBillsGenerate');
//         HttpWebRequestMgt.DisableUI;
//         HttpWebRequestMgt.SetMethod('POST');
//         HttpWebRequestMgt.SetReturnType('application/json');
//         HttpWebRequestMgt.SetContentType('application/json');
//         HttpWebRequestMgt.AddBody(GetClientFile + 'J.txt');
//         TmpBlob.Init;
//         TmpBlob.Blob.CreateInstream(ResponseInStream_L);
//         if HttpWebRequestMgt.GetResponse(ResponseInStream_L, HttpStatusCode_L, ResponseHeaders_L) then begin
//             ResponseInStream_L.Read(ResponseText);
//             Json := ResponseText;
//             //  MESSAGE('%1',ResponseText);
//             ReadJSon(Json, DataExch);
//             EWayBillNo := GetJsonNodeValue('results.message.cEwbNo');
//             EWayBillDateTime := GetJsonNodeValue('results.message.cEWBDate');
//             SalesInvoiceHeader.Reset;
//             SalesInvoiceHeader.SetRange("E-Way-to generate", true);
//             SalesInvoiceHeader.SetRange("E-Way Generated", true);
//             if SalesInvoiceHeader.FindSet then begin
//                 SalesInvoiceHeader.ModifyAll("E-Way Bill No.", Format(EWayBillNo));
//                 SalesInvoiceHeader.ModifyAll("E-Way Bill Date", EWayBillDateTime);
//             end;
//         end;
//     end;
// end;
// [EventSubscriber(Objecttype::Page, 50001, 'ConsolitedEWayBillSalesReturnEvent', '', false, false)]
// procedure ConsolitedEWayBillSalesReturn(JsonString: Text)
// var
//     ResponseInStream_L: InStream;
//     HttpStatusCode_L: dotnet HttpStatusCode;
//     ResponseHeaders_L: dotnet NameValueCollection;
//     ResponseText: Text;
//     JString: Text;
//     OutStrm: OutStream;
//     DataExch: Record "Data Exch. Field";
//     EWayBillNo: Text[30];
//     EWayBillDateTime: Variant;
//     EWayExpiryDateTime: Variant;
//     ReturnShipmentHeader: Record "Return Shipment Header";
//     FL: File;
//     TknNo: Text;
//     ReturnShipmentHeader2: Record "Return Shipment Header";
// begin
//     GetCompanyInfo;
//     TknNo := GetAccessToken;
//     ReturnShipmentHeader.Reset;
//     ReturnShipmentHeader.SetRange("E-Way-to generate", true);
//     ReturnShipmentHeader.SetRange("E-Way Generated", true);
//     if ReturnShipmentHeader.FindFirst then begin
//         StartJason;
//         AddToJason('access_token', TknNo);
//         AddToJason('userGstin', CompanyInformation."GST Registration No.");
//         AddToJason('place_of_consignor', CompanyInformation.City);
//         AddToJason('pincode_of_consignor', CompanyInformation."Post Code");
//         AddToJason('state_of_consignor', GetStateCode(CompanyInformation.State));
//         AddToJason('vehicle_number', ReturnShipmentHeader."Vehicle No.");
//         AddToJason('mode_of_transport', ReturnShipmentHeader."Shipment Method Code");
//         AddToJason('transporter_document_number', ReturnShipmentHeader."Applies-to Doc. No.");
//         AddToJason('transporter_document_date', GetDateFormated(ReturnShipmentHeader."Document Date"));
//         JsonTextWriter.WritePropertyName('list_of_eway_bills');
//         JsonTextWriter.WriteStartArray;
//         ReturnShipmentHeader.Reset;
//         ReturnShipmentHeader.SetRange("E-Way-to generate", true);
//         ReturnShipmentHeader.SetRange("E-Way Generated", true);
//         if ReturnShipmentHeader.FindSet then
//             repeat
//                 JsonTextWriter.WriteStartObject;
//                 AddToJason('eway_bill_number', ReturnShipmentHeader."E-Way Bill No.");
//                 JsonTextWriter.WriteEndObject;
//             until ReturnShipmentHeader.Next = 0;
//         EndJason;
//         GetJason;
//         if FILE.Exists(GetClientFile + 'J.txt') then
//             Erase(GetClientFile + 'J.txt');
//         FL.Create(GetClientFile + 'J.txt');
//         FL.CreateOutstream(OutStrm);
//         OutStrm.WriteText(Format(Json));
//         FL.Close;
//         Message('%1', Json);
//         HttpWebRequestMgt.Initialize('https://pro.mastersindia.co/ewayBillsGenerate');
//         HttpWebRequestMgt.DisableUI;
//         HttpWebRequestMgt.SetMethod('POST');
//         HttpWebRequestMgt.SetReturnType('application/json');
//         HttpWebRequestMgt.SetContentType('application/json');
//         HttpWebRequestMgt.AddBody(GetClientFile + 'J.txt');
//         TmpBlob.Init;
//         TmpBlob.Blob.CreateInstream(ResponseInStream_L);
//         if HttpWebRequestMgt.GetResponse(ResponseInStream_L, HttpStatusCode_L, ResponseHeaders_L) then begin
//             ResponseInStream_L.Read(ResponseText);
//             Json := ResponseText;
//             //  MESSAGE('%1',ResponseText);
//             ReadJSon(Json, DataExch);
//             EWayBillNo := GetJsonNodeValue('results.message.cEwbNo');
//             EWayBillDateTime := GetJsonNodeValue('results.message.cEWBDate');
//             ReturnShipmentHeader.Reset;
//             ReturnShipmentHeader.SetRange("E-Way-to generate", true);
//             ReturnShipmentHeader.SetRange("E-Way Generated", true);
//             if ReturnShipmentHeader.FindSet then begin
//                 ReturnShipmentHeader.ModifyAll("E-Way Bill No.", Format(EWayBillNo));
//                 ReturnShipmentHeader.ModifyAll("E-Way Bill Date", EWayBillDateTime);
//             end;
//         end;
//     end;
// end;
// [EventSubscriber(Objecttype::Page, 50003, 'ConsolitedEWayBillSalesReturnEvent', '', false, false)]
// procedure ConsolitedEWayBillTransferShipment(var JsonString: Text)
// var
//     ResponseInStream_L: InStream;
//     HttpStatusCode_L: dotnet HttpStatusCode;
//     ResponseHeaders_L: dotnet NameValueCollection;
//     ResponseText: Text;
//     JString: Text;
//     OutStrm: OutStream;
//     DataExch: Record "Data Exch. Field";
//     EWayBillNo: Text[30];
//     EWayBillDateTime: Variant;
//     EWayExpiryDateTime: Variant;
//     TransferShipmentHeader: Record "Transfer Shipment Header";
//     FL: File;
//     TknNo: Text;
// begin
//     GetCompanyInfo;
//     TknNo := GetAccessToken;
//     TransferShipmentHeader.Reset;
//     TransferShipmentHeader.SetRange("E-Way-to generate", true);
//     TransferShipmentHeader.SetRange("E-Way Generated", true);
//     if TransferShipmentHeader.FindFirst then begin
//         StartJason;
//         AddToJason('access_token', TknNo);
//         AddToJason('userGstin', CompanyInformation."GST Registration No.");
//         AddToJason('place_of_consignor', CompanyInformation.City);
//         AddToJason('pincode_of_consignor', CompanyInformation."Post Code");
//         AddToJason('state_of_consignor', GetStateCode(CompanyInformation.State));
//         AddToJason('vehicle_number', TransferShipmentHeader."Vehicle No.");
//         AddToJason('mode_of_transport', TransferShipmentHeader."Mode of Transport");
//         AddToJason('transporter_document_number', TransferShipmentHeader."LR/RR No.");
//         AddToJason('transporter_document_date', GetDateFormated(TransferShipmentHeader."LR/RR Date"));
//         JsonTextWriter.WritePropertyName('list_of_eway_bills');
//         JsonTextWriter.WriteStartArray;
//         TransferShipmentHeader.Reset;
//         TransferShipmentHeader.SetRange("E-Way-to generate", true);
//         TransferShipmentHeader.SetRange("E-Way Generated", true);
//         if TransferShipmentHeader.FindSet then
//             repeat
//                 JsonTextWriter.WriteStartObject;
//                 AddToJason('eway_bill_number', TransferShipmentHeader."E-Way Bill No.");
//                 JsonTextWriter.WriteEndObject;
//             until TransferShipmentHeader.Next = 0;
//         EndJason;
//         GetJason;
//         if FILE.Exists(GetClientFile + 'J.txt') then
//             Erase(GetClientFile + 'J.txt');
//         FL.Create(GetClientFile + 'J.txt');
//         FL.CreateOutstream(OutStrm);
//         OutStrm.WriteText(Format(Json));
//         FL.Close;
//         Message('%1', Json);
//         HttpWebRequestMgt.Initialize('https://pro.mastersindia.co/ewayBillsGenerate');
//         HttpWebRequestMgt.DisableUI;
//         HttpWebRequestMgt.SetMethod('POST');
//         HttpWebRequestMgt.SetReturnType('application/json');
//         HttpWebRequestMgt.SetContentType('application/json');
//         HttpWebRequestMgt.AddBody(GetClientFile + 'J.txt');
//         TmpBlob.Init;
//         TmpBlob.Blob.CreateInstream(ResponseInStream_L);
//         if HttpWebRequestMgt.GetResponse(ResponseInStream_L, HttpStatusCode_L, ResponseHeaders_L) then begin
//             ResponseInStream_L.Read(ResponseText);
//             Json := ResponseText;
//             //  MESSAGE('%1',ResponseText);
//             ReadJSon(Json, DataExch);
//             EWayBillNo := GetJsonNodeValue('results.message.cEwbNo');
//             EWayBillDateTime := GetJsonNodeValue('results.message.cEWBDate');
//             TransferShipmentHeader.Reset;
//             TransferShipmentHeader.SetRange("E-Way-to generate", true);
//             TransferShipmentHeader.SetRange("E-Way Generated", true);
//             if TransferShipmentHeader.FindSet then begin
//                 TransferShipmentHeader.ModifyAll("E-Way Bill No.", Format(EWayBillNo));
//                 TransferShipmentHeader.ModifyAll("E-Way Bill Date", EWayBillDateTime);
//             end;
//         end;
//     end;
// end;
// [EventSubscriber(Objecttype::Page, 50002, 'ConsolitedEWayBillSalesReturnEvent', '', false, false)]
// procedure ConsolitedEWayBillDeliveryChallan(JsonString: Text)
// var
//     ResponseInStream_L: InStream;
//     HttpStatusCode_L: dotnet HttpStatusCode;
//     ResponseHeaders_L: dotnet NameValueCollection;
//     ResponseText: Text;
//     JString: Text;
//     OutStrm: OutStream;
//     DataExch: Record "Data Exch. Field";
//     EWayBillNo: Text[30];
//     EWayBillDateTime: Variant;
//     EWayExpiryDateTime: Variant;
//     DeliveryChallanHeader: Record "Delivery Challan Header";
//     FL: File;
//     TknNo: Text;
// begin
//     GetCompanyInfo;
//     TknNo := GetAccessToken;
//     DeliveryChallanHeader.Reset;
//     DeliveryChallanHeader.SetRange("E-Way-to generate", true);
//     DeliveryChallanHeader.SetRange("E-Way Generated", true);
//     if DeliveryChallanHeader.FindFirst then begin
//         StartJason;
//         AddToJason('access_token', TknNo);
//         AddToJason('userGstin', CompanyInformation."GST Registration No.");
//         AddToJason('place_of_consignor', CompanyInformation.City);
//         AddToJason('pincode_of_consignor', CompanyInformation."Post Code");
//         AddToJason('state_of_consignor', GetStateCode(CompanyInformation.State));
//         AddToJason('vehicle_number', DeliveryChallanHeader."Vehical No.");//Alle
//         AddToJason('mode_of_transport', DeliveryChallanHeader."Transportation Distance");
//         AddToJason('transporter_document_number', DeliveryChallanHeader."LR/RR No.");
//         //AddToJason('transporter_document_date',GetDateFormated(DeliveryChallanHeader."Date Of Issue"));//Alle
//         JsonTextWriter.WritePropertyName('list_of_eway_bills');
//         JsonTextWriter.WriteStartArray;
//         DeliveryChallanHeader.Reset;
//         DeliveryChallanHeader.SetRange("E-Way-to generate", true);
//         DeliveryChallanHeader.SetRange("E-Way Generated", true);
//         if DeliveryChallanHeader.FindSet then
//             repeat
//                 JsonTextWriter.WriteStartObject;
//                 AddToJason('eway_bill_number', DeliveryChallanHeader."E-Way Bill No.");
//                 JsonTextWriter.WriteEndObject;
//             until DeliveryChallanHeader.Next = 0;
//         EndJason;
//         GetJason;
//         if FILE.Exists(GetClientFile + 'J.txt') then
//             Erase(GetClientFile + 'J.txt');
//         FL.Create(GetClientFile + 'J.txt');
//         FL.CreateOutstream(OutStrm);
//         OutStrm.WriteText(Format(Json));
//         FL.Close;
//         Message('%1', Json);
//         HttpWebRequestMgt.Initialize('https://pro.mastersindia.co/ewayBillsGenerate');
//         HttpWebRequestMgt.DisableUI;
//         HttpWebRequestMgt.SetMethod('POST');
//         HttpWebRequestMgt.SetReturnType('application/json');
//         HttpWebRequestMgt.SetContentType('application/json');
//         HttpWebRequestMgt.AddBody(GetClientFile + 'J.txt');
//         TmpBlob.Init;
//         TmpBlob.Blob.CreateInstream(ResponseInStream_L);
//         if HttpWebRequestMgt.GetResponse(ResponseInStream_L, HttpStatusCode_L, ResponseHeaders_L) then begin
//             ResponseInStream_L.Read(ResponseText);
//             Json := ResponseText;
//             //  MESSAGE('%1',ResponseText);
//             ReadJSon(Json, DataExch);
//             EWayBillNo := GetJsonNodeValue('results.message.cEwbNo');
//             EWayBillDateTime := GetJsonNodeValue('results.message.cEWBDate');
//             DeliveryChallanHeader.Reset;
//             DeliveryChallanHeader.SetRange("E-Way-to generate", true);
//             DeliveryChallanHeader.SetRange("E-Way Generated", true);
//             if DeliveryChallanHeader.FindSet then begin
//                 DeliveryChallanHeader.ModifyAll("E-Way Bill No.", Format(EWayBillNo));
//                 DeliveryChallanHeader.ModifyAll("E-Way Bill Date", EWayBillDateTime);
//             end;
//         end;
//     end;
// end;
// [EventSubscriber(Objecttype::Page, 50177, 'UpdateVehicleNo_Purchase_ReturnEvent', '', false, false)]
// procedure UpdateVehicleNo_Purchase_Return(var ReturnShipmentHeader: Record "Return Shipment Header")
// var
//     FL: File;
//     ResponseText: Text;
//     JString: Text;
//     OutStrm: OutStream;
//     ResponseInStream_L: InStream;
//     HttpStatusCode_L: dotnet HttpStatusCode;
//     ResponseHeaders_L: dotnet NameValueCollection;
//     DataExch: Record "Data Exch. Field";
//     TknNo: Text[50];
// begin
//     ReturnShipmentHeader.TestField("E-Way Bill No.");
//     ReturnShipmentHeader.TestField("New Vechile No.");
//     ReturnShipmentHeader.TestField("Vechile No. Update Remark");
//     CompanyInformation.Get;
//     TknNo := GetAccessToken;
//     StartJason;
//     AddToJason('access_token', TknNo);
//     AddToJason('userGstin', GetGSTIN(ReturnShipmentHeader."Location Code"));
//     AddToJason('eway_bill_number', ReturnShipmentHeader."E-Way Bill No.");
//     AddToJason('vehicle_number', DelChr(ReturnShipmentHeader."New Vechile No.", '=', ' .,/-<>()\!@#$%^&*()_+{}|?><'));
//     AddToJason('vehicle_type', 'Regular');
//     AddToJason('place_of_consignor', ReturnShipmentHeader."Ship-to City");
//     AddToJason('state_of_consignor', GetStateCode(ReturnShipmentHeader.State));
//     AddToJason('reason_code_for_vehicle_updation', 'due to break down');
//     AddToJason('reason_for_vehicle_updation', 'vehicle broke down');
//     AddToJason('transporter_document_number', ReturnShipmentHeader."Applies-to Doc. No.");
//     AddToJason('transporter_document_date', GetDateFormated(ReturnShipmentHeader."Posting Date"));
//     AddToJason('mode_of_transport', 'ROAD');//FORMAT(ReturnShipmentHeader."Shipment Method Code"));
//     AddToJason('data_source', 'erp');
//     EndJason;
//     if FILE.Exists(GetClientFile + 'J.txt') then
//         Erase(GetClientFile + 'J.txt');
//     FL.Create(GetClientFile + 'J.txt');
//     FL.CreateOutstream(OutStrm);
//     OutStrm.WriteText(Format(Json));
//     FL.Close;
//     // MESSAGE('%1',Json);
//     HttpWebRequestMgt.Initialize('https://pro.mastersindia.co/updateVehicleNumber');
//     HttpWebRequestMgt.DisableUI;
//     HttpWebRequestMgt.SetMethod('POST');
//     HttpWebRequestMgt.SetReturnType('application/json');
//     HttpWebRequestMgt.SetContentType('application/json');
//     HttpWebRequestMgt.AddBody(GetClientFile + 'J.txt');
//     TmpBlob.Init;
//     TmpBlob.Blob.CreateInstream(ResponseInStream_L);
//     if HttpWebRequestMgt.GetResponse(ResponseInStream_L, HttpStatusCode_L, ResponseHeaders_L) then begin
//         ResponseInStream_L.Read(ResponseText);
//         //  MESSAGE('%1',ResponseText);
//         Json := ResponseText;
//         ReadJSon(Json, DataExch);
//     end;
//     if GetJsonNodeValue('results.message.vehUpdDate') <> '' then
//         Message('Vechile No. Updated')
//     else
//         Error('%1', GetJsonNodeValue('results.message'));
// end;
// [EventSubscriber(Objecttype::Page, 50191, 'UpdateVehicleNo_TransferShipmentEvent', '', false, false)]
// procedure UpdateVehicleNo_TransferShipment(var TransferShipmentHeader: Record "Transfer Shipment Header")
// var
//     FL: File;
//     ResponseText: Text;
//     JString: Text;
//     OutStrm: OutStream;
//     ResponseInStream_L: InStream;
//     HttpStatusCode_L: dotnet HttpStatusCode;
//     ResponseHeaders_L: dotnet NameValueCollection;
//     DataExch: Record "Data Exch. Field";
//     TknNo: Text[50];
//     Location: Record Location;
// begin
//     TransferShipmentHeader.TestField("E-Way Bill No.");
//     TransferShipmentHeader.TestField("New Vechile No.");
//     TransferShipmentHeader.TestField("Vechile No. Update Remark");
//     CompanyInformation.Get;
//     if Location.Get(TransferShipmentHeader."Transfer-from Code") then;
//     TknNo := GetAccessToken;
//     StartJason;
//     AddToJason('access_token', TknNo);
//     AddToJason('userGstin', GetGSTIN(TransferShipmentHeader."Transfer-from Code"));
//     AddToJason('eway_bill_number', TransferShipmentHeader."E-Way Bill No.");
//     AddToJason('vehicle_number', DelChr(TransferShipmentHeader."New Vechile No.", '=', ' .,/-<>()\!@#$%^&*()_+'));
//     AddToJason('vehicle_type', 'Regular');
//     AddToJason('place_of_consignor', Location.City);                        //TransferShipmentHeader."Transfer-to City");
//     AddToJason('state_of_consignor', GetStateCode(Location."State Code"));  //TransferShipmentHeader."Transfer-to Code"));
//     AddToJason('reason_code_for_vehicle_updation', 'due to break down');
//     AddToJason('reason_for_vehicle_updation', 'vehicle broke down');
//     AddToJason('transporter_document_number', TransferShipmentHeader."External Document No.");
//     AddToJason('transporter_document_date', GetDateFormated(TransferShipmentHeader."Posting Date"));
//     AddToJason('mode_of_transport', 'ROAD');//FORMAT(TransferShipmentHeader."Mode of Transport"));
//     AddToJason('data_source', 'erp');
//     EndJason;
//     GetJason;
//     if FILE.Exists(GetClientFile + 'J.txt') then
//         Erase(GetClientFile + 'J.txt');
//     FL.Create(GetClientFile + 'J.txt');
//     FL.CreateOutstream(OutStrm);
//     OutStrm.WriteText(Format(Json));
//     FL.Close;
//     // MESSAGE('%1',Json);
//     HttpWebRequestMgt.Initialize('https://pro.mastersindia.co/updateVehicleNumber');
//     HttpWebRequestMgt.DisableUI;
//     HttpWebRequestMgt.SetMethod('POST');
//     HttpWebRequestMgt.SetReturnType('application/json');
//     HttpWebRequestMgt.SetContentType('application/json');
//     HttpWebRequestMgt.AddBody(GetClientFile + 'J.txt');
//     TmpBlob.Init;
//     TmpBlob.Blob.CreateInstream(ResponseInStream_L);
//     if HttpWebRequestMgt.GetResponse(ResponseInStream_L, HttpStatusCode_L, ResponseHeaders_L) then begin
//         ResponseInStream_L.Read(ResponseText);
//         //  //  MESSAGE('%1',ResponseText);
//         Json := ResponseText;
//         ReadJSon(Json, DataExch);
//         //  DataExch.RESET;
//         //  DataExch.SETRANGE("Node ID",'access_token');
//         //  IF DataExch.FINDFIRST THEN
//         //     MessageText := DataExch.Value;
//         //EXIT(MessageText);
//     end;
//     if GetJsonNodeValue('results.message.vehUpdDate') <> '' then
//         Message('Vechile No. Updated')
//     else
//         Error('%1', GetJsonNodeValue('results.message'));
// end;
// [EventSubscriber(Objecttype::Page, 50196, 'UpdateVehicleNo_RGPShipmentEvent', '', false, false)]
// procedure UpdateVehicleNo_RGPShipment(var RGPShipmentHeader: Record "SSD RGP Shipment Header")
// var
//     FL: File;
//     ResponseText: Text;
//     JString: Text;
//     OutStrm: OutStream;
//     ResponseInStream_L: InStream;
//     HttpStatusCode_L: dotnet HttpStatusCode;
//     ResponseHeaders_L: dotnet NameValueCollection;
//     DataExch: Record "Data Exch. Field";
//     TknNo: Text[50];
//     Location: Record Location;
// begin
//     RGPShipmentHeader.TestField("E-Way Bill No.");
//     RGPShipmentHeader.TestField("New Vechile No.");
//     RGPShipmentHeader.TestField("Vechile No. Update Remark");
//     CompanyInformation.Get;
//     if Location.Get(RGPShipmentHeader."Location Code") then;
//     TknNo := GetAccessToken;
//     StartJason;
//     AddToJason('access_token', TknNo);
//     AddToJason('userGstin', GetGSTIN(RGPShipmentHeader."Location Code"));
//     AddToJason('eway_bill_number', RGPShipmentHeader."E-Way Bill No.");
//     AddToJason('vehicle_number', DelChr(RGPShipmentHeader."New Vechile No.", '=', ' .,/-<>()\!@#$%^&*()_+'));
//     AddToJason('vehicle_type', 'Regular');
//     AddToJason('place_of_consignor', Location.City);
//     AddToJason('state_of_consignor', GetStateCode(Location."State Code"));
//     AddToJason('reason_code_for_vehicle_updation', 'due to break down');
//     AddToJason('reason_for_vehicle_updation', 'vehicle broke down');
//     AddToJason('transporter_document_number', RGPShipmentHeader."LR No.");
//     AddToJason('transporter_document_date', GetDateFormated(RGPShipmentHeader."LR/RR Date"));
//     AddToJason('mode_of_transport', 'ROAD');//FORMAT(TransferShipmentHeader."Mode of Transport"));
//     AddToJason('data_source', 'erp');
//     EndJason;
//     GetJason;
//     if FILE.Exists(GetClientFile + 'J.txt') then
//         Erase(GetClientFile + 'J.txt');
//     FL.Create(GetClientFile + 'J.txt');
//     FL.CreateOutstream(OutStrm);
//     OutStrm.WriteText(Format(Json));
//     FL.Close;
//     // MESSAGE('%1',Json);
//     HttpWebRequestMgt.Initialize('https://clientbasic.mastersindia.co/updateVehicleNumber');
//     HttpWebRequestMgt.DisableUI;
//     HttpWebRequestMgt.SetMethod('POST');
//     HttpWebRequestMgt.SetReturnType('application/json');
//     HttpWebRequestMgt.SetContentType('application/json');
//     HttpWebRequestMgt.AddBody(GetClientFile + 'J.txt');
//     TmpBlob.Init;
//     TmpBlob.Blob.CreateInstream(ResponseInStream_L);
//     if HttpWebRequestMgt.GetResponse(ResponseInStream_L, HttpStatusCode_L, ResponseHeaders_L) then begin
//         ResponseInStream_L.Read(ResponseText);
//         //  //  MESSAGE('%1',ResponseText);
//         Json := ResponseText;
//         ReadJSon(Json, DataExch);
//         //  DataExch.RESET;
//         //  DataExch.SETRANGE("Node ID",'access_token');
//         //  IF DataExch.FINDFIRST THEN
//         //     MessageText := DataExch.Value;
//         //EXIT(MessageText);
//     end;
//     if GetJsonNodeValue('results.message.vehUpdDate') <> '' then
//         Message('Vechile No. Updated')
//     else
//         Error('%1', GetJsonNodeValue('results.message'));
// end;
// [EventSubscriber(Objecttype::Page, 50187, 'UpdateVehicleNo_DeliveryChallanEvent', '', false, false)]
// procedure UpdateVehicleNo_DeliveryChallan(var DeliveryChallanHeader: Record "Delivery Challan Header")
// var
//     FL: File;
//     ResponseText: Text;
//     JString: Text;
//     OutStrm: OutStream;
//     ResponseInStream_L: InStream;
//     HttpStatusCode_L: dotnet HttpStatusCode;
//     ResponseHeaders_L: dotnet NameValueCollection;
//     DataExch: Record "Data Exch. Field";
//     TknNo: Text[50];
// begin
//     DeliveryChallanHeader.TestField("E-Way Bill No.");
//     CompanyInformation.Get;
//     TknNo := GetAccessToken;
//     StartJason;
//     AddToJason('access_token', TknNo);
//     AddToJason('userGstin', CompanyInformation."GST Registration No.");
//     AddToJason('eway_bill_number', DeliveryChallanHeader."E-Way Bill No.");
//     AddToJason('vehicle_number', DeliveryChallanHeader."Vehical No.");//Alle
//     AddToJason('vehicle_type', 'Regular');
//     AddToJason('place_of_consignor', 'SURAT');
//     AddToJason('state_of_consignor', '08AMNPA8440K1ZS');
//     AddToJason('reason_code_for_vehicle_updation', '331000784260');
//     AddToJason('reason_for_vehicle_updation', 'due to breakdown');
//     AddToJason('transporter_document_number', 'SURAT');
//     AddToJason('transporter_document_date', '331000784260');
//     AddToJason('mode_of_transport', 'road');
//     AddToJason('data_source', 'erp');
//     EndJason;
//     GetJason;
//     if FILE.Exists(GetClientFile + 'J.txt') then
//         Erase(GetClientFile + 'J.txt');
//     FL.Create(GetClientFile + 'J.txt');
//     FL.CreateOutstream(OutStrm);
//     OutStrm.WriteText(Format(Json));
//     FL.Close;
//     Message('%1', Json);
//     HttpWebRequestMgt.Initialize('https://pro.mastersindia.co/updateVehicleNumber');
//     HttpWebRequestMgt.DisableUI;
//     HttpWebRequestMgt.SetMethod('POST');
//     HttpWebRequestMgt.SetReturnType('application/json');
//     HttpWebRequestMgt.SetContentType('application/json');
//     HttpWebRequestMgt.AddBody(GetClientFile + 'J.txt');
//     TmpBlob.Init;
//     TmpBlob.Blob.CreateInstream(ResponseInStream_L);
//     if HttpWebRequestMgt.GetResponse(ResponseInStream_L, HttpStatusCode_L, ResponseHeaders_L) then begin
//         ResponseInStream_L.Read(ResponseText);
//         //  MESSAGE('%1',ResponseText);
//         Json := ResponseText;
//         ReadJSon(Json, DataExch);
//         //  DataExch.RESET;
//         //  DataExch.SETRANGE("Node ID",'access_token');
//         //  IF DataExch.FINDFIRST THEN
//         //     MessageText := DataExch.Value;
//         //EXIT(MessageText);
//     end;
// end;
// [EventSubscriber(Objecttype::Page, 50176, 'CancelEwaySalesInvoiceEvent', '', false, false)]
// procedure CancelEWaySalesInvoice(SalesInvoiceHeader: Record "Sales Invoice Header")
// var
//     FL: File;
//     ResponseText: Text;
//     JString: Text;
//     OutStrm: OutStream;
//     ResponseInStream_L: InStream;
//     HttpStatusCode_L: dotnet HttpStatusCode;
//     ResponseHeaders_L: dotnet NameValueCollection;
//     DataExch: Record "Data Exch. Field";
//     TknNo: Text[50];
//     EWayBillNo: Text[30];
//     EWayBillDateTime: Variant;
//     EWayExpiryDateTime: Variant;
//     SalesInvoiceHeader2: Record "Sales Invoice Header";
// begin
//     CompanyInformation.Get;
//     SalesInvoiceHeader.TestField("E-Way Bill No.");
//     TknNo := GetAccessToken;
//     StartJason;
//     AddToJason('access_token', TknNo);
//     AddToJason('userGstin', GetGSTIN(SalesInvoiceHeader."Location Code"));
//     AddToJason('eway_bill_number', SalesInvoiceHeader."E-Way Bill No.");
//     AddToJason('reason_of_cancel', 'Others');
//     AddToJason('cancel_remark', 'Cancelled the order');
//     AddToJason('data_source', 'erp');
//     EndJason;
//     GetJason;
//     if FILE.Exists(GetClientFile + 'J.txt') then
//         Erase(GetClientFile + 'J.txt');
//     FL.Create(GetClientFile + 'J.txt');
//     FL.CreateOutstream(OutStrm);
//     OutStrm.WriteText(Format(Json));
//     FL.Close;
//     // MESSAGE('%1',Json);
//     HttpWebRequestMgt.Initialize('https://pro.mastersindia.co/ewayBillCancel');
//     HttpWebRequestMgt.DisableUI;
//     HttpWebRequestMgt.SetMethod('POST');
//     HttpWebRequestMgt.SetReturnType('application/json');
//     HttpWebRequestMgt.SetContentType('application/json');
//     HttpWebRequestMgt.AddBody(GetClientFile + 'J.txt');
//     TmpBlob.Init;
//     TmpBlob.Blob.CreateInstream(ResponseInStream_L);
//     if HttpWebRequestMgt.GetResponse(ResponseInStream_L, HttpStatusCode_L, ResponseHeaders_L) then begin
//         ResponseInStream_L.Read(ResponseText);
//         Json := ResponseText;
//         //  MESSAGE('%1',ResponseText);
//         ReadJSon(Json, DataExch);
//         EWayBillNo := GetJsonNodeValue('results.message.ewayBillNo');
//         EWayBillDateTime := GetJsonNodeValue('results.message.cancelDate');
//     end;
//     if EWayBillNo <> '' then begin
//         SalesInvoiceHeader2.Get(SalesInvoiceHeader."No.");
//         SalesInvoiceHeader2."E-Way Bill No." := '';//FORMAT(EWayBillNo);
//         SalesInvoiceHeader2."E-Way Bill Date" := 0D;// EWayBillDateTime;
//         SalesInvoiceHeader2."E-Way Bill Validity" := '';//EWayExpiryDateTime;
//         SalesInvoiceHeader2."E-Way Generated" := false;//TRUE;
//         SalesInvoiceHeader2."E-Way Canceled" := true;
//         SalesInvoiceHeader2.Modify;
//         Message('E-Way Bill Canceled');
//     end else
//         Error('%1', GetJsonNodeValue('results.message'));
// end;
// [EventSubscriber(Objecttype::Page, 50177, 'CancelEwayReturnEvent', '', false, false)]
// procedure CancelEWayReturn(ReturnShipmentHeader: Record "Return Shipment Header")
// var
//     FL: File;
//     ResponseText: Text;
//     JString: Text;
//     OutStrm: OutStream;
//     ResponseInStream_L: InStream;
//     HttpStatusCode_L: dotnet HttpStatusCode;
//     ResponseHeaders_L: dotnet NameValueCollection;
//     DataExch: Record "Data Exch. Field";
//     TknNo: Text[50];
//     EWayBillNo: Text[30];
//     EWayBillDateTime: Variant;
//     EWayExpiryDateTime: Variant;
//     ReturnShipmentHeader2: Record "Return Shipment Header";
// begin
//     CompanyInformation.Get;
//     ReturnShipmentHeader.TestField("E-Way Bill No.");
//     TknNo := GetAccessToken;
//     StartJason;
//     AddToJason('access_token', TknNo);
//     AddToJason('userGstin', GetGSTIN(ReturnShipmentHeader."Location Code"));
//     AddToJason('eway_bill_number', ReturnShipmentHeader."E-Way Bill No.");
//     AddToJason('reason_of_cancel', 'Others');
//     AddToJason('cancel_remark', 'Cancelled the order');
//     AddToJason('data_source', 'erp');
//     EndJason;
//     GetJason;
//     if FILE.Exists(GetClientFile + 'J.txt') then
//         Erase(GetClientFile + 'J.txt');
//     FL.Create(GetClientFile + 'J.txt');
//     FL.CreateOutstream(OutStrm);
//     OutStrm.WriteText(Format(Json));
//     FL.Close;
//     // MESSAGE('%1',Json);
//     HttpWebRequestMgt.Initialize('https://pro.mastersindia.co/ewayBillCancel');
//     HttpWebRequestMgt.DisableUI;
//     HttpWebRequestMgt.SetMethod('POST');
//     HttpWebRequestMgt.SetReturnType('application/json');
//     HttpWebRequestMgt.SetContentType('application/json');
//     HttpWebRequestMgt.AddBody(GetClientFile + 'J.txt');
//     TmpBlob.Init;
//     TmpBlob.Blob.CreateInstream(ResponseInStream_L);
//     if HttpWebRequestMgt.GetResponse(ResponseInStream_L, HttpStatusCode_L, ResponseHeaders_L) then begin
//         ResponseInStream_L.Read(ResponseText);
//         Json := ResponseText;
//         //  MESSAGE('%1',ResponseText);
//         ReadJSon(Json, DataExch);
//         EWayBillNo := GetJsonNodeValue('results.message.ewayBillNo');
//         EWayBillDateTime := GetJsonNodeValue('results.message.cancelDate');
//     end;
//     if EWayBillNo <> '' then begin
//         ReturnShipmentHeader2.Get(ReturnShipmentHeader."No.");
//         ReturnShipmentHeader2."E-Way Bill No." := '';//FORMAT(EWayBillNo);
//         ReturnShipmentHeader2."E-Way Bill Date" := '';// EWayBillDateTime;
//         ReturnShipmentHeader2."E-Way Bill Validity" := '';//EWayExpiryDateTime;
//         ReturnShipmentHeader2."E-Way Generated" := false;//TRUE;
//         ReturnShipmentHeader2."E-Way Canceled" := true;
//         ReturnShipmentHeader2.Modify;
//         Message('E-Way Bill Canceled');
//     end else
//         Error('%1', GetJsonNodeValue('results.message'));
// end;
// [EventSubscriber(Objecttype::Page, 50187, 'CancelEwaySubconEvent', '', false, false)]
// procedure CancelEWaySubcon(DeliveryChallanHeader: Record "Delivery Challan Header")
// var
//     FL: File;
//     ResponseText: Text;
//     JString: Text;
//     OutStrm: OutStream;
//     ResponseInStream_L: InStream;
//     HttpStatusCode_L: dotnet HttpStatusCode;
//     ResponseHeaders_L: dotnet NameValueCollection;
//     DataExch: Record "Data Exch. Field";
//     TknNo: Text[50];
//     EWayBillNo: Text[30];
//     EWayBillDateTime: Variant;
//     EWayExpiryDateTime: Variant;
// begin
//     CompanyInformation.Get;
//     TknNo := GetAccessToken;
//     StartJason;
//     AddToJason('access_token', TknNo);
//     AddToJason('userGstin', CompanyInformation."GST Registration No.");
//     AddToJason('eway_bill_number', DeliveryChallanHeader."E-Way Bill No.");
//     AddToJason('reason_of_cancel', 'Others');
//     AddToJason('cancel_remark', 'Cancelled the order');
//     AddToJason('data_source', 'erp');
//     EndJason;
//     GetJason;
//     if FILE.Exists(GetClientFile + 'J.txt') then
//         Erase(GetClientFile + 'J.txt');
//     FL.Create(GetClientFile + 'J.txt');
//     FL.CreateOutstream(OutStrm);
//     OutStrm.WriteText(Format(Json));
//     FL.Close;
//     Message('%1', Json);
//     HttpWebRequestMgt.Initialize('https://pro.mastersindia.co/ewayBillCancel');
//     HttpWebRequestMgt.DisableUI;
//     HttpWebRequestMgt.SetMethod('POST');
//     HttpWebRequestMgt.SetReturnType('application/json');
//     HttpWebRequestMgt.SetContentType('application/json');
//     HttpWebRequestMgt.AddBody(GetClientFile + 'J.txt');
//     TmpBlob.Init;
//     TmpBlob.Blob.CreateInstream(ResponseInStream_L);
//     if HttpWebRequestMgt.GetResponse(ResponseInStream_L, HttpStatusCode_L, ResponseHeaders_L) then begin
//         ResponseInStream_L.Read(ResponseText);
//         Json := ResponseText;
//         //  MESSAGE('%1',ResponseText);
//         ReadJSon(Json, DataExch);
//         EWayBillNo := GetJsonNodeValue('results.message.ewayBillNo');
//         EWayBillDateTime := GetJsonNodeValue('results.message.cancelDate');
//     end;
// end;
// [EventSubscriber(Objecttype::Page, 50191, 'CancelEwayTransferEvent', '', false, false)]
// procedure CancelEWayTransfer(TransferShipmentHeader: Record "Transfer Shipment Header")
// var
//     FL: File;
//     ResponseText: Text;
//     JString: Text;
//     OutStrm: OutStream;
//     ResponseInStream_L: InStream;
//     HttpStatusCode_L: dotnet HttpStatusCode;
//     ResponseHeaders_L: dotnet NameValueCollection;
//     DataExch: Record "Data Exch. Field";
//     TknNo: Text[50];
//     EWayBillNo: Text[30];
//     EWayBillDateTime: Variant;
//     EWayExpiryDateTime: Variant;
//     TransferShipmentHeader2: Record "Transfer Shipment Header";
// begin
//     CompanyInformation.Get;
//     TknNo := GetAccessToken;
//     StartJason;
//     AddToJason('access_token', TknNo);
//     AddToJason('userGstin', GetGSTIN(TransferShipmentHeader."Transfer-from Code"));//CompanyInformation."GST Registration No.");
//     AddToJason('eway_bill_number', TransferShipmentHeader."E-Way Bill No.");
//     AddToJason('reason_of_cancel', 'Others');
//     AddToJason('cancel_remark', 'Cancelled the order');
//     AddToJason('data_source', 'erp');
//     EndJason;
//     GetJason;
//     if FILE.Exists(GetClientFile + 'J.txt') then
//         Erase(GetClientFile + 'J.txt');
//     FL.Create(GetClientFile + 'J.txt');
//     FL.CreateOutstream(OutStrm);
//     OutStrm.WriteText(Format(Json));
//     FL.Close;
//     // MESSAGE('%1',Json);
//     HttpWebRequestMgt.Initialize('https://pro.mastersindia.co/ewayBillCancel');
//     HttpWebRequestMgt.DisableUI;
//     HttpWebRequestMgt.SetMethod('POST');
//     HttpWebRequestMgt.SetReturnType('application/json');
//     HttpWebRequestMgt.SetContentType('application/json');
//     HttpWebRequestMgt.AddBody(GetClientFile + 'J.txt');
//     TmpBlob.Init;
//     TmpBlob.Blob.CreateInstream(ResponseInStream_L);
//     if HttpWebRequestMgt.GetResponse(ResponseInStream_L, HttpStatusCode_L, ResponseHeaders_L) then begin
//         ResponseInStream_L.Read(ResponseText);
//         Json := ResponseText;
//         //  //  MESSAGE('%1',ResponseText);
//         ReadJSon(Json, DataExch);
//         EWayBillNo := GetJsonNodeValue('results.message.ewayBillNo');
//         EWayBillDateTime := GetJsonNodeValue('results.message.cancelDate');
//     end;
//     if EWayBillNo <> '' then begin
//         TransferShipmentHeader2.Get(TransferShipmentHeader."No.");
//         TransferShipmentHeader2."E-Way Bill No." := '';//FORMAT(EWayBillNo);
//         TransferShipmentHeader2."E-Way Bill Date" := '';// EWayBillDateTime;
//         TransferShipmentHeader2."E-Way Bill Validity" := '';//EWayExpiryDateTime;
//         TransferShipmentHeader2."E-Way Generated" := false;//TRUE;
//         TransferShipmentHeader2."E-Way Canceled" := true;
//         TransferShipmentHeader2.Modify;
//         Message('E-way bill canceled');
//     end else
//         Error('%1', GetJsonNodeValue('results.message'));
// end;
// [EventSubscriber(Objecttype::Page, 50196, 'CancelEwayRGPEvent', '', false, false)]
// procedure CancelEWayRGP(RGPShipmentHeader: Record "SSD RGP Shipment Header")
// var
//     FL: File;
//     ResponseText: Text;
//     JString: Text;
//     OutStrm: OutStream;
//     ResponseInStream_L: InStream;
//     HttpStatusCode_L: dotnet HttpStatusCode;
//     ResponseHeaders_L: dotnet NameValueCollection;
//     DataExch: Record "Data Exch. Field";
//     TknNo: Text[50];
//     EWayBillNo: Text[30];
//     EWayBillDateTime: Variant;
//     EWayExpiryDateTime: Variant;
//     RGPShipmentHeader2: Record "SSD RGP Shipment Header";
// begin
//     CompanyInformation.Get;
//     TknNo := GetAccessToken;
//     StartJason;
//     AddToJason('access_token', TknNo);
//     AddToJason('userGstin', GetGSTIN(RGPShipmentHeader."Location Code"));//CompanyInformation."GST Registration No.");
//     AddToJason('eway_bill_number', RGPShipmentHeader."E-Way Bill No.");
//     AddToJason('reason_of_cancel', 'Others');
//     AddToJason('cancel_remark', 'Cancelled the order');
//     AddToJason('data_source', 'erp');
//     EndJason;
//     GetJason;
//     if FILE.Exists(GetClientFile + 'J.txt') then
//         Erase(GetClientFile + 'J.txt');
//     FL.Create(GetClientFile + 'J.txt');
//     FL.CreateOutstream(OutStrm);
//     OutStrm.WriteText(Format(Json));
//     FL.Close;
//     // MESSAGE('%1',Json);
//     HttpWebRequestMgt.Initialize('https://clientbasic.mastersindia.co/ewayBillCancel');
//     HttpWebRequestMgt.DisableUI;
//     HttpWebRequestMgt.SetMethod('POST');
//     HttpWebRequestMgt.SetReturnType('application/json');
//     HttpWebRequestMgt.SetContentType('application/json');
//     HttpWebRequestMgt.AddBody(GetClientFile + 'J.txt');
//     TmpBlob.Init;
//     TmpBlob.Blob.CreateInstream(ResponseInStream_L);
//     if HttpWebRequestMgt.GetResponse(ResponseInStream_L, HttpStatusCode_L, ResponseHeaders_L) then begin
//         ResponseInStream_L.Read(ResponseText);
//         Json := ResponseText;
//         //  //  MESSAGE('%1',ResponseText);
//         ReadJSon(Json, DataExch);
//         EWayBillNo := GetJsonNodeValue('results.message.ewayBillNo');
//         EWayBillDateTime := GetJsonNodeValue('results.message.cancelDate');
//     end;
//     if EWayBillNo <> '' then begin
//         RGPShipmentHeader2.Get(RGPShipmentHeader."No.");
//         RGPShipmentHeader2."E-Way Bill No." := '';//FORMAT(EWayBillNo);
//         RGPShipmentHeader2."E-Way Bill Date" := '';// EWayBillDateTime;
//         RGPShipmentHeader2."E-Way Bill Validity" := '';//EWayExpiryDateTime;
//         RGPShipmentHeader2."E-Way Generated" := false;//TRUE;
//         RGPShipmentHeader2."E-Way Canceled" := true;
//         RGPShipmentHeader2.Modify;
//         Message('E-way bill canceled');
//     end else
//         Error('%1', GetJsonNodeValue('results.message'));
// end;
// local procedure GetDateFormated(Originaldate: Date): Text
// var
//     Day: Text[2];
//     mnth: Text[2];
// begin
//     if Date2dmy(Originaldate, 2) > 9 then
//         mnth := Format(Date2dmy(Originaldate, 2))
//     else
//         mnth := '0' + Format(Date2dmy(Originaldate, 2));
//     if Date2dmy(Originaldate, 1) > 9 then
//         Day := Format(Date2dmy(Originaldate, 1))
//     else
//         Day := '0' + Format(Date2dmy(Originaldate, 1));
//     exit(Day + '/' + mnth + '/' + Format(Date2dmy(Originaldate, 3)));
// end;
// local procedure GetGSTIN(LocCode: Code[20]): Text
// var
//     Location: Record Location;
//     CompanyInformation: Record "Company Information";
// begin
//     if Location.Get(LocCode) then begin
//         Location.TestField("GST Registration No.");
//         exit(Location."GST Registration No.");
//     end;
//     CompanyInformation.Get;
//     exit(CompanyInformation."GST Registration No.");
// end;
// local procedure InsertRequestId(RequestId: Text[250]; DocumentNo: Code[20])
// var
//     EWayRequestID: Record "SSD E-Way Request ID";
//     EntryNo: Integer;
// begin
//     EWayRequestID.Reset;
//     if EWayRequestID.FindLast then
//         EntryNo := EWayRequestID."Entry No.";
//     EWayRequestID."Entry No." := EntryNo + 1;
//     EWayRequestID."Document No." := DocumentNo;
//     EWayRequestID."Request Id" := RequestId;
//     EWayRequestID."Request Date" := WorkDate;
//     EWayRequestID."Request Time" := Time;
//     EWayRequestID.Insert;
// end;
// [EventSubscriber(Objecttype::Page, 50335, 'CreateManualJSONInvoice', '', false, false)]
// procedure CreateJSONSalesInvoiceMan(SalesInvoiceHeader: Record "Sales Invoice Header")
// var
//     CustomerL: Record Customer;
//     SalesInvoiceLineL: Record "Sales Invoice Line";
//     ShiptoAddressL: Record "Ship-to Address";
//     CustGstin: Code[15];
//     TknNo: Text[50];
//     SalesInvoiceHeader2: Record "Sales Invoice Header";
//     ResponseInStream_L: InStream;
//     HttpStatusCode_L: dotnet HttpStatusCode;
//     ResponseHeaders_L: dotnet NameValueCollection;
//     ResponseText: Text;
//     JString: Text;
//     OutStrm: OutStream;
//     DataExch: Record "Data Exch. Field";
//     EWayBillNo: Text[30];
//     EWayBillDateTime: Variant;
//     EWayExpiryDateTime: Variant;
//     FL: File;
//     Mnth: Text[2];
//     Day: Text[2];
// begin
//     StartJason;
//     if ShippingAgent.Get(SalesInvoiceHeader."Shipping Agent Code") then;
//     AddToJason('version', '1.0.0123');
//     JsonTextWriter.WritePropertyName('billLists');
//     JsonTextWriter.WriteStartArray;
//     JsonTextWriter.WriteStartObject;
//     AddToJason('userGstin', GetGSTIN(SalesInvoiceHeader."Location Code"));
//     AddToJason('supply_type', 'O');
//     AddToJason('sub_supply_type', '1');
//     AddToJason('document_type', 'INV');
//     AddToJason('document_number', SalesInvoiceHeader."Excise Invoice No.");
//     if Date2dmy(SalesInvoiceHeader."Posting Date", 2) > 9 then
//         Mnth := Format(Date2dmy(SalesInvoiceHeader."Posting Date", 2))
//     else
//         Mnth := '0' + Format(Date2dmy(SalesInvoiceHeader."Posting Date", 2));
//     if Date2dmy(SalesInvoiceHeader."Posting Date", 1) > 9 then
//         Day := Format(Date2dmy(SalesInvoiceHeader."Posting Date", 1))
//     else
//         Day := '0' + Format(Date2dmy(SalesInvoiceHeader."Posting Date", 1));
//     AddToJason('document_date', Day + '/' + Mnth + '/' + Format(Date2dmy(SalesInvoiceHeader."Posting Date", 3)));
//     AddToJason('fromGstin', CompanyInformation."GST Registration No.");
//     AddToJason('fromTrdName', CompanyInformation.Name);
//     AddToJason('fromAddr1', CompanyInformation.Address);
//     AddToJason('fromAddr2', CompanyInformation."Address 2");
//     AddToJason('fromPlace', CompanyInformation.City);
//     AddToJason('fromPincode', CompanyInformation."Post Code");
//     AddToJason('fromStateCode', GetStateCode(CompanyInformation.State));
//     if ShiptoAddressL.Get(SalesInvoiceHeader."Bill-to Customer No.", SalesInvoiceHeader."Ship-to Code") then
//         CustGstin := ShiptoAddressL."GST Registration No."
//     else
//         if CustomerL.Get(SalesInvoiceHeader."Bill-to Customer No.") then
//             CustGstin := CustomerL."GST Registration No.";
//     AddToJason('toGstin', CustGstin);
//     AddToJason('toTrdName', SalesInvoiceHeader."Ship-to Name");
//     AddToJason('toAddr1', SalesInvoiceHeader."Ship-to Address");
//     AddToJason('toAddr2', SalesInvoiceHeader."Ship-to Address 2");
//     AddToJason('toPlace', SalesInvoiceHeader."Ship-to City");
//     AddToJason('toPincode', SalesInvoiceHeader."Ship-to Post Code");
//     AddToJason('toStateCode', GetStateCode(SalesInvoiceHeader.State));
//     AddToJason('totalValue', GetTaxableAmountSalesInvoice(SalesInvoiceHeader."No."));
//     AddToJason('cgstValue', GetGSTAmount(SalesInvoiceHeader."No.", 'CGST'));
//     AddToJason('sgstValue', GetGSTAmount(SalesInvoiceHeader."No.", 'SGST'));
//     AddToJason('igstValue', GetGSTAmount(SalesInvoiceHeader."No.", 'IGST'));
//     AddToJason('cessValue', GetGSTAmount(SalesInvoiceHeader."No.", 'CESS'));
//     AddToJason('transMode', '1');
//     AddToJason('transDistance', SalesInvoiceHeader."Transportation Distance");
//     AddToJason('transporterName', SalesInvoiceHeader."Shipping Agent Code");
//     AddToJason('transporterId', ShippingAgent."Transporter GST No.");
//     AddToJason('transDocNo', SalesInvoiceHeader."LR/RR No.");
//     AddToJason('transDocDate', GetDateFormated(SalesInvoiceHeader."Posting Date"));
//     AddToJason('vehicle_number', DelChr(SalesInvoiceHeader."Vehicle No.", '=', ' ,/-<>  !@#$%^&*()_+{}'));//DELCHR(SalesInvoiceHeader."Vehicle No.",'=',' '));
//     SalesInvoiceLineL.Reset;
//     SalesInvoiceLineL.SetRange("Document No.", SalesInvoiceHeader."No.");
//     if SalesInvoiceLineL.FindSet then begin
//         JsonTextWriter.WritePropertyName('itemList');
//         JsonTextWriter.WriteStartArray;
//         repeat
//             JsonTextWriter.WriteStartObject;
//             AddToJason('itemNo', SalesInvoiceLineL."No.");
//             AddToJason('productName', SalesInvoiceLineL."Product Group Code");
//             AddToJason('productDesc', SalesInvoiceLineL."Product Group Code");
//             AddToJason('hsnCode', SalesInvoiceLineL."HSN/SAC Code");
//             AddToJason('quantity', SalesInvoiceLineL.Quantity);
//             AddToJason('qtyUnit', GetUOM(SalesInvoiceLineL."Unit of Measure Code"));
//             AddToJason('taxableAmount', SalesInvoiceLineL."GST Base Amount");
//             AddToJason('sgstRate', GetGSTRate(SalesInvoiceLineL."Document No.", 'SGST'));
//             AddToJason('cgstRate', GetGSTRate(SalesInvoiceLineL."Document No.", 'CGST'));
//             AddToJason('igstRate', GetGSTRate(SalesInvoiceLineL."Document No.", 'IGST'));
//             AddToJason('cessRate', GetGSTRate(SalesInvoiceLineL."Document No.", 'CESS'));
//             JsonTextWriter.WriteEndObject;
//         until SalesInvoiceLineL.Next = 0;
//     end;
//     EndJason;
//     SalesInvoiceHeader2.Get(SalesInvoiceHeader."No.");
//     SalesInvoiceHeader2."E-Way Generated" := true;
//     SalesInvoiceHeader2."E-Way Canceled" := false;
//     SalesInvoiceHeader2.Modify;
//     SaveCreatedManualJSON;
// end;
// [EventSubscriber(Objecttype::Page, 50336, 'CreateReturnMan', '', false, false)]
// procedure CreateJSONSalesReturnMan(ReturnShipmentHeaderL: Record "Return Shipment Header")
// var
//     VendorL: Record Vendor;
//     ReturnShipmentLineL: Record "Return Shipment Line";
//     ShiptoAddressL: Record "Ship-to Address";
//     CustGstin: Code[15];
//     TknNo: Text[50];
//     ResponseInStream_L: InStream;
//     HttpStatusCode_L: dotnet HttpStatusCode;
//     ResponseHeaders_L: dotnet NameValueCollection;
//     ResponseText: Text;
//     JString: Text;
//     OutStrm: OutStream;
//     DataExch: Record "Data Exch. Field";
//     EWayBillNo: Text[30];
//     EWayBillDateTime: Variant;
//     EWayExpiryDateTime: Variant;
//     FL: File;
//     ReturnShipmentHeader2: Record "Return Shipment Header";
//     Mnth: Text[2];
//     Day: Text[2];
// begin
//     StartJason;
//     if ShippingAgent.Get(ReturnShipmentHeaderL."Shipping Agent Code") then;
//     AddToJason('version', '1.0.0123');
//     JsonTextWriter.WritePropertyName('billLists');
//     JsonTextWriter.WriteStartArray;
//     JsonTextWriter.WriteStartObject;
//     AddToJason('userGstin', GetGSTIN(ReturnShipmentHeaderL."Location Code"));
//     AddToJason('supply_type', 'O');
//     AddToJason('sub_supply_type', '1');
//     AddToJason('document_type', 'INV');
//     AddToJason('document_number', ReturnShipmentHeaderL."No.");
//     if Date2dmy(ReturnShipmentHeaderL."Posting Date", 2) > 9 then
//         Mnth := Format(Date2dmy(ReturnShipmentHeaderL."Posting Date", 2))
//     else
//         Mnth := '0' + Format(Date2dmy(ReturnShipmentHeaderL."Posting Date", 2));
//     if Date2dmy(ReturnShipmentHeaderL."Posting Date", 1) > 9 then
//         Day := Format(Date2dmy(ReturnShipmentHeaderL."Posting Date", 1))
//     else
//         Day := '0' + Format(Date2dmy(ReturnShipmentHeaderL."Posting Date", 1));
//     AddToJason('document_date', Day + '/' + Mnth + '/' + Format(Date2dmy(ReturnShipmentHeaderL."Posting Date", 3)));
//     AddToJason('fromGstin', CompanyInformation."GST Registration No.");
//     AddToJason('fromTrdName', CompanyInformation.Name);
//     AddToJason('fromAddr1', CompanyInformation.Address);
//     AddToJason('fromAddr2', CompanyInformation."Address 2");
//     AddToJason('fromPlace', CompanyInformation.City);
//     AddToJason('fromPincode', CompanyInformation."Post Code");
//     AddToJason('fromStateCode', GetStateCode(CompanyInformation.State));
//     if ShiptoAddressL.Get(ReturnShipmentHeaderL."Pay-to Vendor No.", ReturnShipmentHeaderL."Ship-to Code") then
//         CustGstin := ShiptoAddressL."GST Registration No."
//     else
//         if VendorL.Get(ReturnShipmentHeaderL."Pay-to Vendor No.") then
//             CustGstin := VendorL."GST Registration No.";
//     AddToJason('toGstin', CustGstin);
//     AddToJason('toTrdName', ReturnShipmentHeaderL."Ship-to Name");
//     AddToJason('toAddr1', ReturnShipmentHeaderL."Ship-to Address");
//     AddToJason('toAddr2', ReturnShipmentHeaderL."Ship-to Address 2");
//     AddToJason('toPlace', ReturnShipmentHeaderL."Ship-to City");
//     AddToJason('toPincode', ReturnShipmentHeaderL."Ship-to Post Code");
//     AddToJason('toStateCode', GetStateCode(ReturnShipmentHeaderL.State));
//     ReturnShipmentLineL.Reset;
//     ReturnShipmentLineL.SetRange("Document No.", ReturnShipmentHeaderL."No.");
//     ReturnShipmentLineL.CalcSums("GST Base Amount", "Amount Including Excise");
//     if ReturnShipmentLineL."GST Base Amount" <> 0 then
//         AddToJason('totalValue', ReturnShipmentLineL."GST Base Amount")
//     else
//         AddToJason('totalValue', ReturnShipmentLineL."Amount Including Excise");
//     AddToJason('cgstValue', GetGSTAmount(ReturnShipmentHeaderL."No.", 'CGST'));
//     AddToJason('sgstValue', GetGSTAmount(ReturnShipmentHeaderL."No.", 'SGST'));
//     AddToJason('igstValue', GetGSTAmount(ReturnShipmentHeaderL."No.", 'IGST'));
//     AddToJason('cessValue', GetGSTAmount(ReturnShipmentHeaderL."No.", 'CESS'));
//     AddToJason('transMode', '1');
//     AddToJason('transDistance', ReturnShipmentHeaderL."Transportation Distance");
//     AddToJason('transporterName', ReturnShipmentHeaderL."Shipping Agent Code");
//     AddToJason('transporterId', ShippingAgent."Transporter GST No.");
//     AddToJason('transDocNo', ReturnShipmentHeaderL."Applies-to Doc. No.");
//     AddToJason('transDocDate', GetDateFormated(ReturnShipmentHeaderL."Posting Date"));
//     AddToJason('vehicle_number', DelChr(ReturnShipmentHeaderL."Vehicle No.", '=', ' ,/-<>  !@#$%^&*()_+{}'));//DELCHR(ReturnShipmentHeaderL."Vehicle No.",'=',' '));
//     ReturnShipmentLineL.Reset;
//     ReturnShipmentLineL.SetRange("Document No.", ReturnShipmentHeaderL."No.");
//     if ReturnShipmentLineL.FindSet then begin
//         JsonTextWriter.WritePropertyName('itemList');
//         JsonTextWriter.WriteStartArray;
//         repeat
//             JsonTextWriter.WriteStartObject;
//             AddToJason('itemNo', ReturnShipmentLineL."No.");
//             AddToJason('productName', ReturnShipmentLineL."Product Group Code");
//             AddToJason('productDesc', ReturnShipmentLineL."Product Group Code");
//             AddToJason('hsnCode', ReturnShipmentLineL."HSN/SAC Code");
//             AddToJason('quantity', ReturnShipmentLineL.Quantity);
//             AddToJason('qtyUnit', GetUOM(ReturnShipmentLineL."Unit of Measure Code"));
//             AddToJason('taxableAmount', ReturnShipmentLineL."GST Base Amount");
//             AddToJason('sgstRate', GetGSTRate(ReturnShipmentLineL."Document No.", 'SGST'));
//             AddToJason('cgstRate', GetGSTRate(ReturnShipmentLineL."Document No.", 'CGST'));
//             AddToJason('igstRate', GetGSTRate(ReturnShipmentLineL."Document No.", 'IGST'));
//             AddToJason('cessRate', GetGSTRate(ReturnShipmentLineL."Document No.", 'CESS'));
//             JsonTextWriter.WriteEndObject;
//         until ReturnShipmentLineL.Next = 0;
//     end;
//     EndJason;
//     ReturnShipmentHeader2.Get(ReturnShipmentHeaderL."No.");
//     ReturnShipmentHeader2."E-Way Generated" := true;
//     ReturnShipmentHeader2."E-Way Canceled" := false;
//     ReturnShipmentHeader2.Modify;
//     SaveCreatedManualJSON;
// end;
// [EventSubscriber(Objecttype::Page, 50338, 'CreateJSONTransferShipmentEventMan', '', false, false)]
// procedure CreateJSONTransferShipmentMan(var TransferShipmentHeaderL: Record "Transfer Shipment Header")
// var
//     VendorL: Record Vendor;
//     TransferShipmentLineL: Record "Transfer Shipment Line";
//     ShiptoAddressL: Record "Ship-to Address";
//     CustGstin: Code[15];
//     TknNo: Text[50];
//     ResponseInStream_L: InStream;
//     HttpStatusCode_L: dotnet HttpStatusCode;
//     ResponseHeaders_L: dotnet NameValueCollection;
//     ResponseText: Text;
//     JString: Text;
//     OutStrm: OutStream;
//     DataExch: Record "Data Exch. Field";
//     EWayBillNo: Text[30];
//     EWayBillDateTime: Variant;
//     EWayExpiryDateTime: Variant;
//     FL: File;
//     TransferShipmentHeader2: Record "Transfer Shipment Header";
//     Mnth: Text[2];
//     Day: Text[2];
//     Location: Record Location;
// begin
//     StartJason;
//     if ShippingAgent.Get(TransferShipmentHeaderL."Shipping Agent Code") then;
//     AddToJason('version', '1.0.0123');
//     JsonTextWriter.WritePropertyName('billLists');
//     JsonTextWriter.WriteStartArray;
//     JsonTextWriter.WriteStartObject;
//     AddToJason('userGstin', GetGSTIN(TransferShipmentHeaderL."Transfer-from Code"));
//     AddToJason('supply_type', 'O');
//     AddToJason('sub_supply_type', '1');
//     AddToJason('document_type', 'INV');
//     AddToJason('document_number', TransferShipmentHeaderL."No.");
//     if Date2dmy(TransferShipmentHeaderL."Posting Date", 2) > 9 then
//         Mnth := Format(Date2dmy(TransferShipmentHeaderL."Posting Date", 2))
//     else
//         Mnth := '0' + Format(Date2dmy(TransferShipmentHeaderL."Posting Date", 2));
//     if Date2dmy(TransferShipmentHeaderL."Posting Date", 1) > 9 then
//         Day := Format(Date2dmy(TransferShipmentHeaderL."Posting Date", 1))
//     else
//         Day := '0' + Format(Date2dmy(TransferShipmentHeaderL."Posting Date", 1));
//     AddToJason('document_date', Day + '/' + Mnth + '/' + Format(Date2dmy(TransferShipmentHeaderL."Posting Date", 3)));
//     AddToJason('fromGstin', CompanyInformation."GST Registration No.");
//     AddToJason('fromTrdName', CompanyInformation.Name);
//     AddToJason('fromAddr1', CompanyInformation.Address);
//     AddToJason('fromAddr2', CompanyInformation."Address 2");
//     AddToJason('fromPlace', CompanyInformation.City);
//     AddToJason('fromPincode', CompanyInformation."Post Code");
//     AddToJason('fromStateCode', GetStateCode(CompanyInformation.State));
//     if VendorL.Get(TransferShipmentHeaderL."Vendor No.") then
//         CustGstin := VendorL."GST Registration No.";
//     AddToJason('toGstin', CustGstin);
//     AddToJason('toTrdName', TransferShipmentHeaderL."Transfer-to Name");
//     AddToJason('toAddr1', TransferShipmentHeaderL."Transfer-from Address");
//     AddToJason('toAddr2', TransferShipmentHeaderL."Transfer-from Address 2");
//     AddToJason('toPlace', TransferShipmentHeaderL."Transfer-from City");
//     AddToJason('toPincode', TransferShipmentHeaderL."Transfer-to Post Code");
//     Location.Get(TransferShipmentHeaderL."Transfer-to Code");
//     AddToJason('toStateCode', GetStateCode(Location."State Code"));
//     TransferShipmentLineL.Reset;
//     TransferShipmentLineL.SetRange("Document No.", TransferShipmentHeaderL."No.");
//     if TransferShipmentLineL.FindSet then
//         TransferShipmentLineL.CalcSums("GST Base Amount");
//     if TransferShipmentLineL."GST Base Amount" <> 0 then
//         AddToJason('totalValue', TransferShipmentLineL."GST Base Amount")
//     else begin
//         TransferShipmentLineL.CalcSums(Amount);
//         AddToJason('totalValue', TransferShipmentLineL.Amount)
//     end;
//     AddToJason('cgstValue', GetGSTAmount(TransferShipmentHeaderL."No.", 'CGST'));
//     AddToJason('sgstValue', GetGSTAmount(TransferShipmentHeaderL."No.", 'SGST'));
//     AddToJason('igstValue', GetGSTAmount(TransferShipmentHeaderL."No.", 'IGST'));
//     AddToJason('cessValue', GetGSTAmount(TransferShipmentHeaderL."No.", 'CESS'));
//     AddToJason('transMode', '1');
//     AddToJason('transDistance', TransferShipmentHeaderL."Transportation Distance");
//     AddToJason('transporterName', TransferShipmentHeaderL."Shipping Agent Code");
//     AddToJason('transporterId', ShippingAgent."Transporter GST No.");
//     AddToJason('transDocNo', TransferShipmentHeaderL."LR/RR No.");
//     AddToJason('transDocDate', GetDateFormated(TransferShipmentHeaderL."Posting Date"));
//     AddToJason('vehicle_number', DelChr(TransferShipmentHeaderL."Vehicle No.", '=', ' ,/-<>  !@#$%^&*()_+{}'));//DELCHR(TransferShipmentHeaderL."Vehicle No.",'=',' '));
//     TransferShipmentLineL.Reset;
//     TransferShipmentLineL.SetRange("Document No.", TransferShipmentHeaderL."No.");
//     if TransferShipmentLineL.FindSet then begin
//         JsonTextWriter.WritePropertyName('itemList');
//         JsonTextWriter.WriteStartArray;
//         repeat
//             JsonTextWriter.WriteStartObject;
//             AddToJason('itemNo', TransferShipmentLineL."Item No.");
//             AddToJason('productName', TransferShipmentLineL."Product Group Code");
//             AddToJason('productDesc', TransferShipmentLineL."Product Group Code");
//             AddToJason('hsnCode', TransferShipmentLineL."HSN/SAC Code");
//             AddToJason('quantity', TransferShipmentLineL.Quantity);
//             AddToJason('qtyUnit', GetUOM(TransferShipmentLineL."Unit of Measure Code"));
//             AddToJason('taxableAmount', TransferShipmentLineL."GST Base Amount");
//             AddToJason('sgstRate', GetGSTRate(TransferShipmentLineL."Document No.", 'SGST'));
//             AddToJason('cgstRate', GetGSTRate(TransferShipmentLineL."Document No.", 'CGST'));
//             AddToJason('igstRate', GetGSTRate(TransferShipmentLineL."Document No.", 'IGST'));
//             AddToJason('cessRate', GetGSTRate(TransferShipmentLineL."Document No.", 'CESS'));
//             JsonTextWriter.WriteEndObject;
//         until TransferShipmentLineL.Next = 0;
//     end;
//     EndJason;
//     TransferShipmentHeader2.Get(TransferShipmentHeaderL."No.");
//     TransferShipmentHeader2."E-Way Generated" := true;
//     TransferShipmentHeader2."E-Way Canceled" := false;
//     TransferShipmentHeader2.Modify;
//     SaveCreatedManualJSON;
// end;
// [EventSubscriber(Objecttype::Page, 50337, 'CreateJSONDeliveryChallanEventMan', '', false, false)]
// procedure CreateJSONDeliveryChallanMan(var DeliveryChallanHeaderL: Record "Delivery Challan Header")
// var
//     VendorL: Record Vendor;
//     DeliveryChallanLineL: Record "Delivery Challan Line";
//     ShiptoAddressL: Record "Ship-to Address";
//     CustGstin: Code[15];
//     TknNo: Text[50];
//     ItemL: Record Item;
//     ResponseInStream_L: InStream;
//     HttpStatusCode_L: dotnet HttpStatusCode;
//     ResponseHeaders_L: dotnet NameValueCollection;
//     ResponseText: Text;
//     JString: Text;
//     OutStrm: OutStream;
//     DataExch: Record "Data Exch. Field";
//     EWayBillNo: Text[30];
//     EWayBillDateTime: Variant;
//     EWayExpiryDateTime: Variant;
//     FL: File;
//     DeliveryChallanHeader2: Record "Delivery Challan Header";
//     Mnth: Text[2];
//     Day: Text[2];
// begin
//     GetCompanyInfo;
//     StartJason;
//     if ShippingAgent.Get(DeliveryChallanHeaderL."Shipping Agent Code") then;
//     AddToJason('version', '1.0.0123');
//     JsonTextWriter.WritePropertyName('billLists');
//     JsonTextWriter.WriteStartArray;
//     JsonTextWriter.WriteStartObject;
//     AddToJason('userGstin', CompanyInformation."GST Registration No.");
//     AddToJason('supply_type', 'O');
//     AddToJason('sub_supply_type', '1');
//     AddToJason('document_type', 'INV');
//     AddToJason('document_number', DeliveryChallanHeaderL."No.");
//     if Date2dmy(DeliveryChallanHeaderL."Posting Date", 2) > 9 then
//         Mnth := Format(Date2dmy(DeliveryChallanHeaderL."Posting Date", 2))
//     else
//         Mnth := '0' + Format(Date2dmy(DeliveryChallanHeaderL."Posting Date", 2));
//     if Date2dmy(DeliveryChallanHeaderL."Posting Date", 1) > 9 then
//         Day := Format(Date2dmy(DeliveryChallanHeaderL."Posting Date", 1))
//     else
//         Day := '0' + Format(Date2dmy(DeliveryChallanHeaderL."Posting Date", 1));
//     AddToJason('document_date', Day + '/' + Mnth + '/' + Format(Date2dmy(DeliveryChallanHeaderL."Posting Date", 3)));
//     AddToJason('fromGstin', CompanyInformation."GST Registration No.");
//     AddToJason('fromTrdName', CompanyInformation.Name);
//     AddToJason('fromAddr1', CompanyInformation.Address);
//     AddToJason('fromAddr2', CompanyInformation."Address 2");
//     AddToJason('fromPlace', CompanyInformation.City);
//     AddToJason('fromPincode', CompanyInformation."Post Code");
//     AddToJason('fromStateCode', GetStateCode(CompanyInformation.State));
//     if VendorL.Get(DeliveryChallanHeaderL."Vendor No.") then
//         CustGstin := VendorL."GST Registration No.";
//     AddToJason('toGstin', CustGstin);
//     AddToJason('toTrdName', VendorL.Name);
//     AddToJason('toAddr1', VendorL.Address);
//     AddToJason('toAddr2', VendorL."Address 2");
//     AddToJason('toPlace', VendorL.City);
//     AddToJason('toPincode', VendorL."Post Code");
//     AddToJason('toStateCode', GetStateCode(VendorL."State Code"));
//     AddToJason('totalValue', GetTaxableAmountSalesInvoice(DeliveryChallanHeaderL."No."));
//     AddToJason('cgstValue', GetGSTAmount(DeliveryChallanHeaderL."No.", 'CGST'));
//     AddToJason('sgstValue', GetGSTAmount(DeliveryChallanHeaderL."No.", 'SGST'));
//     AddToJason('igstValue', GetGSTAmount(DeliveryChallanHeaderL."No.", 'IGST'));
//     AddToJason('cessValue', GetGSTAmount(DeliveryChallanHeaderL."No.", 'CESS'));
//     AddToJason('transMode', '1');
//     AddToJason('transDistance', DeliveryChallanHeaderL."Transportation Distance");
//     AddToJason('transporterName', '');
//     AddToJason('transporterId', '');
//     AddToJason('transDocNo', DeliveryChallanHeaderL."LR/RR No.");
//     AddToJason('transDocDate', GetDateFormated(DeliveryChallanHeaderL."Posting Date"));
//     AddToJason('vehicle_number', DelChr(DeliveryChallanHeaderL."Vehical No.", '=', ' ,/-<>  !@#$%^&*()_+{}'));//DELCHR(DeliveryChallanHeaderL."Vehicle No.",'=',' '));//Alle
//     DeliveryChallanLineL.Reset;
//     DeliveryChallanLineL.SetRange("Document No.", DeliveryChallanHeaderL."No.");
//     if DeliveryChallanLineL.FindSet then begin
//         JsonTextWriter.WritePropertyName('itemList');
//         JsonTextWriter.WriteStartArray;
//         repeat
//             JsonTextWriter.WriteStartObject;
//             ItemL.Get(DeliveryChallanLineL."Item No.");
//             AddToJason('itemNo', ItemL."No.");
//             AddToJason('productName', ItemL."Product Group Code");
//             AddToJason('productDesc', ItemL."Product Group Code");
//             AddToJason('hsnCode', DeliveryChallanLineL."HSN/SAC Code");
//             AddToJason('quantity', DeliveryChallanLineL.Quantity);
//             AddToJason('qtyUnit', GetUOM(DeliveryChallanLineL."Unit of Measure"));
//             AddToJason('taxableAmount', DeliveryChallanLineL."GST Base Amount");
//             AddToJason('sgstRate', GetGSTRate(DeliveryChallanLineL."Document No.", 'SGST'));
//             AddToJason('cgstRate', GetGSTRate(DeliveryChallanLineL."Document No.", 'CGST'));
//             AddToJason('igstRate', GetGSTRate(DeliveryChallanLineL."Document No.", 'IGST'));
//             AddToJason('cessRate', GetGSTRate(DeliveryChallanLineL."Document No.", 'CESS'));
//             JsonTextWriter.WriteEndObject;
//         until DeliveryChallanLineL.Next = 0;
//     end;
//     EndJason;
//     DeliveryChallanHeader2.Get(DeliveryChallanHeaderL."No.");
//     DeliveryChallanHeader2."E-Way Generated" := true;
//     // DeliveryChallanHeader2."E-Way Canceled" := FALSE;
//     DeliveryChallanHeader2.Modify;
//     SaveCreatedManualJSON;
// end;
// local procedure SaveCreatedManualJSON()
// var
//     FL: File;
//     OutStrm: OutStream;
//     InStrm: InStream;
//     FilePath: Text;
// begin
//     GetJason;
//     if FILE.Exists(GetClientFile + 'J.txt') then
//         Erase(GetClientFile + 'J.txt');
//     FL.Create(GetClientFile + 'J.txt');
//     FL.CreateOutstream(OutStrm);
//     OutStrm.WriteText(Format(Json));
//     FilePath := 'C:\' + 'E-way.JSON';
//     FL.CreateInstream(InStrm);
//     if not DownloadFromStream(InStrm, 'Save JSON file to', '', 'JSON File *.JSON| *.json', FilePath) then//'Text File *.txt| *.txt',FilePath) THEN
//         Error('Please save the file')
//     else
//         Message('E-way Bill File Saved');
//     FL.Close;
// end;
// local procedure GetUOM(UOMCode: Code[10]): Text
// var
//     UnitofMeasure: Record "Unit of Measure";
// begin
//     if ((UnitofMeasure.Get(UOMCode)) and (UnitofMeasure."E-Way Code" <> '')) then
//         exit(UnitofMeasure."E-Way Code");
//     Error('Unit of measure code must have value %1', UnitofMeasure.Code);
// end;
//SSDU Commented
}
