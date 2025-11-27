codeunit 50062 "SSD GSP Management"
{
    procedure GenerateEInvoice(InvoiceJson: Text; EWBApplicable: Boolean)
    var
        SSDJsonObject: JsonObject;
        SSDJsonToken: JsonToken;
        EInvoiceUrl: Text;
        ResponseText: Text;
        SSDHttpHeaders: HttpHeaders;
        SSDHttpHeaders2: HttpHeaders;
        SSDHttpClient: HttpClient;
        SSDHttpContent: HttpContent;
        SSDHttpContent2: HttpContent;
        SSDHttpRequestMessage: HttpRequestMessage;
        SSDHttpResponseMessage: HttpResponseMessage;
        SuccessBool: Boolean;
        AckDateText: Text;
        AckDateTime2: DateTime;
    begin
        EInvoiceUrl:=GetEInvoiceUrl();
        SSDHttpRequestMessage.Method:='POST';
        SSDHttpRequestMessage.SetRequestUri(EInvoiceUrl);
        SSDHttpRequestMessage.GetHeaders(SSDHttpHeaders);
        SSDHttpContent.WriteFrom(InvoiceJson);
        SSDHttpContent.GetHeaders(SSDHttpHeaders);
        SSDHttpHeaders.Remove('Content-Type');
        SSDHttpHeaders.Add('Content-Type', 'application/json');
        SSDHttpRequestMessage.Content:=SSDHttpContent;
        if SSDHttpClient.Send(SSDHttpRequestMessage, SSDHttpResponseMessage)then begin
            SSDHttpHeaders2:=SSDHttpResponseMessage.Headers;
            SSDHttpContent2:=SSDHttpResponseMessage.Content;
            SSDHttpResponseMessage.Content.ReadAs(ResponseText);
            SSDJsonObject.ReadFrom(ResponseText);
            //Message(ResponseText);
            if SSDJsonObject.Get('results', SSDJsonToken)then begin
                SSDJsonToken.WriteTo(ResponseText);
                SSDJsonObject.ReadFrom(ResponseText);
                if GetJsonToken(SSDJsonObject, 'status').AsValue().AsText() = 'Success' then begin
                    SetEInvoiceReturnStatus(true);
                    SetReqId(GetJsonToken(SSDJsonObject, 'requestId').AsValue().AsText());
                    SetInfoDtls(GetJsonToken(SSDJsonObject, 'InfoDtls').AsValue().AsText());
                    SSDJsonToken:=GetJsonToken(SSDJsonObject, 'message');
                    SSDJsonToken.WriteTo(JsonText);
                    SSDJsonObject.ReadFrom(JsonText);
                    SetAckNo(GetJsonToken(SSDJsonObject, 'AckNo').AsValue().AsText());
                    //SetAckDate(GetJsonToken(SSDJsonObject, 'AckDt').AsValue().AsDateTime());
                    AckDateText:=copystr(GetJsonToken(SSDJsonObject, 'AckDt').AsValue().AsText(), 1, 30);
                    SetAckDate(AckDateText);
                    SetIRN(GetJsonToken(SSDJsonObject, 'Irn').AsValue().AsText());
                    SetQRCode(GetJsonToken(SSDJsonObject, 'SignedQRCode').AsValue().AsText());
                    SetQRUrl(GetJsonToken(SSDJsonObject, 'QRCodeUrl').AsValue().AsText());
                    SetInvUrl(GetJsonToken(SSDJsonObject, 'EinvoicePdf').AsValue().AsText());
                    if not GetJsonToken(SSDJsonObject, 'EwbNo').AsValue().IsNull then begin
                        SetEwbNo(GetJsonToken(SSDJsonObject, 'EwbNo').AsValue().AsText());
                        SetEwbDate(GetJsonToken(SSDJsonObject, 'EwbDt').AsValue().AsText());
                        SetEwbValidity(GetJsonToken(SSDJsonObject, 'EwbValidTill').AsValue().AsText());
                    end;
                    Message('%1', JsonText);
                end
                else
                    SetErrorMsg(ResponseText);
            end
            else
                SetErrorMsg(ResponseText);
        end;
    end;
    procedure GenerateEWB(InvoiceJson: Text)
    var
        SSDJsonObject: JsonObject;
        SSDJsonToken: JsonToken;
        MasterEWBUrl: Text;
        ResponseText: Text;
        SSDHttpHeaders: HttpHeaders;
        SSDHttpHeaders2: HttpHeaders;
        SSDHttpClient: HttpClient;
        SSDHttpContent: HttpContent;
        SSDHttpContent2: HttpContent;
        SSDHttpRequestMessage: HttpRequestMessage;
        SSDHttpResponseMessage: HttpResponseMessage;
        SuccessBool: Boolean;
        AckDateText: Text;
        AckDateTime2: DateTime;
    begin
        MasterEWBUrl:=GetEWBUrl();
        SSDHttpRequestMessage.Method:='POST';
        SSDHttpRequestMessage.SetRequestUri(MasterEWBUrl);
        SSDHttpRequestMessage.GetHeaders(SSDHttpHeaders);
        SSDHttpContent.WriteFrom(InvoiceJson);
        SSDHttpContent.GetHeaders(SSDHttpHeaders);
        SSDHttpHeaders.Remove('Content-Type');
        SSDHttpHeaders.Add('Content-Type', 'application/json');
        SSDHttpRequestMessage.Content:=SSDHttpContent;
        if SSDHttpClient.Send(SSDHttpRequestMessage, SSDHttpResponseMessage)then begin
            SSDHttpHeaders2:=SSDHttpResponseMessage.Headers;
            SSDHttpContent2:=SSDHttpResponseMessage.Content;
            SSDHttpResponseMessage.Content.ReadAs(ResponseText);
            SSDJsonObject.ReadFrom(ResponseText);
            //Message(ResponseText);
            if SSDJsonObject.Get('results', SSDJsonToken)then begin
                SSDJsonToken.WriteTo(ResponseText);
                SSDJsonObject.ReadFrom(ResponseText);
                if GetJsonToken(SSDJsonObject, 'status').AsValue().AsText() = 'Success' then begin
                    SetEWBReturnStatus(true);
                    SetReqId(GetJsonToken(SSDJsonObject, 'requestId').AsValue().AsText());
                    SSDJsonToken:=GetJsonToken(SSDJsonObject, 'message');
                    SSDJsonToken.WriteTo(JsonText);
                    SSDJsonObject.ReadFrom(JsonText);
                    SetEwbNo(GetJsonToken(SSDJsonObject, 'ewayBillNo').AsValue().AsText());
                    SetEwbDate(GetJsonToken(SSDJsonObject, 'ewayBillDate').AsValue().AsText());
                    SetEwbValidity(GetJsonToken(SSDJsonObject, 'validUpto').AsValue().AsText());
                    Message('%1', 'E-Way Bill Generated');
                end
                else
                    SetErrorMsg(ResponseText);
            end
            else
                SetErrorMsg(ResponseText);
        end;
    end;
    procedure CancelEWB(EWBNo: Code[20]; GSTIN: Code[20])
    var
        SSDJsonObject: JsonObject;
        SSDJsonToken: JsonToken;
        MasterEWBUrl: Text;
        SSDJsonText: Text;
        TknNo: Text;
        ResponseText: Text;
        SSDHttpHeaders: HttpHeaders;
        SSDHttpHeaders2: HttpHeaders;
        SSDHttpClient: HttpClient;
        SSDHttpContent: HttpContent;
        SSDHttpContent2: HttpContent;
        SSDHttpRequestMessage: HttpRequestMessage;
        SSDHttpResponseMessage: HttpResponseMessage;
    begin
        Clear(SSDJsonObject);
        Clear(SSDJsonText);
        MasterEWBUrl:=GetEWBCancelUrl();
        TknNo:=SSDGetAccessToken();
        SSDJsonObject.Add('access_token', TknNo);
        SSDJsonObject.Add('userGstin', GSTIN);
        SSDJsonObject.Add('eway_bill_number', EWBNo);
        SSDJsonObject.Add('reason_of_cancel', 'Others');
        SSDJsonObject.Add('cancel_remark', 'Cancelled the order');
        SSDJsonObject.Add('data_source', 'erp');
        SSDJsonObject.WriteTo(SSDJsonText);
        SSDHttpRequestMessage.Method:='POST';
        SSDHttpRequestMessage.SetRequestUri(MasterEWBUrl);
        SSDHttpRequestMessage.GetHeaders(SSDHttpHeaders);
        SSDHttpContent.WriteFrom(SSDJsonText);
        SSDHttpContent.GetHeaders(SSDHttpHeaders);
        SSDHttpHeaders.Remove('Content-Type');
        SSDHttpHeaders.Add('Content-Type', 'application/json');
        SSDHttpRequestMessage.Content:=SSDHttpContent;
        if SSDHttpClient.Send(SSDHttpRequestMessage, SSDHttpResponseMessage)then begin
            SSDHttpHeaders2:=SSDHttpResponseMessage.Headers;
            SSDHttpContent2:=SSDHttpResponseMessage.Content;
            SSDHttpResponseMessage.Content.ReadAs(ResponseText);
            SSDJsonObject.ReadFrom(ResponseText);
            //Message(ResponseText);
            if SSDJsonObject.Get('results', SSDJsonToken)then begin
                SSDJsonToken.WriteTo(ResponseText);
                SSDJsonObject.ReadFrom(ResponseText);
                if GetJsonToken(SSDJsonObject, 'status').AsValue().AsText() = 'Success' then begin
                    Message('%1', 'E-Way Bill Generated');
                end
                else
                    SetErrorMsg(ResponseText);
            end
            else
                SetErrorMsg(ResponseText);
        end;
    end;
    procedure SSDGetAccessToken()AccessTokenTxt: Text var
        SSDEInvIntegrationSetup: Record "SSD E-Inv Integration Setup";
        SSDJsonObject: JsonObject;
        SSDHttpHeaders: HttpHeaders;
        SSDHttpHeaders2: HttpHeaders;
        SSDHttpClient: HttpClient;
        SSDHttpContent: HttpContent;
        SSDHttpContent2: HttpContent;
        SSDHttpResponseMessage: HttpResponseMessage;
        SSDHttpRequestMessage: HttpRequestMessage;
        ResponseText: Text;
        AuthTokenUrl: Text;
        AppId: Text[50];
        AppPassword: Text[50];
        GSPUserId: Text[50];
        GSPPassword: Text[50];
        SSDJsonText: Text;
    begin
        AuthTokenUrl:=GetAuthTokenUrl();
        SSDEInvIntegrationSetup.Get();
        if EnvironmentInformation.IsProduction()then begin
            SSDEInvIntegrationSetup.TestField("User Name");
            SSDEInvIntegrationSetup.TestField(Password);
            SSDEInvIntegrationSetup.TestField("Client ID");
            SSDEInvIntegrationSetup.TestField("Client Secret");
        end;
        AppId:=SSDEInvIntegrationSetup."Client ID";
        AppPassword:=SSDEInvIntegrationSetup."Client Secret";
        GSPUserId:=SSDEInvIntegrationSetup."User Name";
        GSPPassword:=SSDEInvIntegrationSetup.Password;
        CheckAppid(AppId);
        CheckAppPassword(AppPassword);
        CheckUserid(GSPUserId);
        CheckUserPassword(GSPPassword);
        SSDHttpRequestMessage.Method:='POST';
        SSDHttpRequestMessage.SetRequestUri(AuthTokenUrl);
        SSDHttpRequestMessage.GetHeaders(SSDHttpHeaders);
        //SSDJsonObject.Add('Content-Type', 'application/json');
        SSDJsonObject.Add('username', GSPUserId);
        SSDJsonObject.Add('password', GSPPassword);
        SSDJsonObject.Add('client_id', AppId);
        SSDJsonObject.Add('client_secret', AppPassword);
        SSDJsonObject.Add('grant_type', 'password');
        SSDJsonObject.WriteTo(SSDJsonText);
        SSDHttpContent.WriteFrom(SSDJsonText);
        SSDHttpContent.GetHeaders(SSDHttpHeaders);
        SSDHttpHeaders.Remove('Content-Type');
        SSDHttpHeaders.Add('Content-Type', 'application/json');
        SSDHttpRequestMessage.Content:=SSDHttpContent;
        if SSDHttpClient.Send(SSDHttpRequestMessage, SSDHttpResponseMessage)then begin
            SSDHttpHeaders2:=SSDHttpResponseMessage.Headers;
            SSDHttpContent2:=SSDHttpResponseMessage.Content;
            SSDHttpResponseMessage.Content.ReadAs(ResponseText);
            Clear(SSDJsonObject);
            SSDJsonObject.ReadFrom(ResponseText);
            AccessTokenTxt:=GetJsonToken(SSDJsonObject, 'access_token').AsValue().AsText();
        end;
    end;
    local procedure SetGSTIN(InGSTIN: Code[15])
    begin
        GSTINCode:=InGSTIN;
    end;
    procedure GetGSTIN()OutGSTIN: Code[15]begin
        OutGSTIN:=GSTINCode;
    end;
    local procedure SetTradeName(InTradeName: Text)
    begin
        TradeNameText:=InTradeName;
    end;
    procedure GetTradeName()OutTradeName: Text begin
        OutTradeName:=TradeNameText;
    end;
    local procedure SetLegalName(InLegalName: Text)
    begin
        LegalNameText:=InLegalName;
    end;
    procedure GetLegalName()OutLegalName: Text begin
        OutLegalName:=LegalNameText;
    end;
    local procedure SetBuildingName(InBuildingName: Text)
    begin
        BuildingNameText:=InBuildingName;
    end;
    procedure GetBuildingName()OutBuildingName: Text begin
        OutBuildingName:=BuildingNameText;
    end;
    local procedure SetBuildingNo(InBuildingNo: Text)
    begin
        BuildingNoText:=InBuildingNo;
    end;
    procedure GetBuildingNo()OutBuildingNo: Text begin
        OutBuildingNo:=BuildingNoText;
    end;
    local procedure SetFloorNo(InFloorNo: Text)
    begin
        FloorNoText:=InFloorNo;
    end;
    procedure GetFloorNo()OutFloorNo: Text begin
        OutFloorNo:=FloorNoText;
    end;
    local procedure SetStreetNo(InStreetNo: Text)
    begin
        StreetNoText:=InStreetNo;
    end;
    procedure GetStreetNo()OutStreetNo: Text begin
        OutStreetNo:=StreetNoText;
    end;
    local procedure SetLocation(InLocation: Text)
    begin
        LocationText:=InLocation;
    end;
    procedure GetLocation()OutLocation: Text begin
        OutLocation:=LocationText;
    end;
    local procedure SetStateCode(InStateCode: Text)
    begin
        StateCodeText:=InStateCode;
    end;
    procedure GetStateCode()OutStateCode: Text begin
        OutStateCode:=StateCodeText;
    end;
    local procedure SetPostCode(InPostCode: Text)
    begin
        PostCodeText:=InPostCode;
    end;
    procedure GetPostCode()OutPostCode: Text begin
        OutPostCode:=PostCodeText;
    end;
    local procedure SetPartyType(InPartyType: Text)
    begin
        PartyTypeText:=InPartyType;
    end;
    procedure GetPartyType()OutPartyType: Text begin
        OutPartyType:=PartyTypeText;
    end;
    local procedure SetStatus(InStatus: Text)
    begin
        StatusText:=InStatus;
    end;
    procedure GetStatus()OutStatus: Text begin
        OutStatus:=StatusText;
    end;
    local procedure SetBlockStatus(InBlockStatus: Text)
    begin
        BlockStatusText:=InBlockStatus;
    end;
    procedure GetBlockStatus()OutBlockStatus: Text begin
        OutBlockStatus:=BlockStatusText;
    end;
    local procedure SetRegistrationDate(InRegistrationDate: Text)
    begin
        RegistrationDateText:=InRegistrationDate;
    end;
    procedure GetRegistrationDate()OutRegistrationDate: Text begin
        OutRegistrationDate:=RegistrationDateText;
    end;
    local procedure SetQRUrl(InQRUrl: Text)
    begin
        QRUrl:=InQRUrl;
    end;
    procedure GetQRURL()OutQRUrl: Text begin
        OutQRUrl:=QRUrl;
    end;
    local procedure SetInvUrl(InInvUrl: Text)
    begin
        InvUrl:=InInvUrl;
    end;
    procedure GetInvURL()OutInvUrl: Text begin
        OutInvUrl:=InvUrl;
    end;
    local procedure SetErrorMsg(InErrMsg: Text)
    begin
        ErrorMsg:=InErrMsg;
    end;
    procedure GetErrorMesage()OutErrMsg: Text begin
        OutErrMsg:=ErrorMsg;
    end;
    local procedure SetReqId(InReqId: Text)
    begin
        RequestId:=InReqId;
    end;
    procedure GetReqId()OutReqId: Text begin
        OutReqId:=RequestId;
    end;
    local procedure SetInfoDtls(InInfoDtls: Text)
    begin
        InfoDtls:=InInfoDtls;
    end;
    procedure GetInfoDtls()OutInfoDtls: Text begin
        OutInfoDtls:=InfoDtls;
    end;
    local procedure SetAckNo(InAckNo: Text)
    begin
        AckNoText:=InAckNo;
    end;
    procedure GetAckNo()OutAckNo: Text begin
        OutAckNo:=AckNoText;
    end;
    local procedure SetAckDate(InAckDate: Text)
    begin
        AckDateTime:=InAckDate;
    end;
    procedure GetAckDate()OutAckDate: Text begin
        OutAckDate:=AckDateTime;
    end;
    local procedure SetIRN(InIRN: Text)
    begin
        IRNText:=InIRN;
    end;
    procedure GetIRN()OutIRN: Text begin
        OutIRN:=IRNText;
    end;
    local procedure SetQRCode(InQRCode: Text)
    begin
        QRCodeText:=InQRCode;
    end;
    procedure GetQRCode()OutQRCode: Text begin
        OutQRCode:=QRCodeText;
    end;
    local procedure SetEwbNo(InEwbNo: Text)
    begin
        EwbNoText:=InEwbNo;
    end;
    procedure GetEwbNo()OutEwbNo: Text begin
        OutEwbNo:=EwbNoText;
    end;
    local procedure SetEwbDate(InEwbDate: Text)
    begin
        EwbDateText:=InEwbDate;
    end;
    procedure GetEwbDate()OutEwbDate: Text begin
        OutEwbDate:=EwbDateText;
    end;
    local procedure SetEwbValidity(InEwbValidity: Text)
    begin
        EwbValidityText:=InEwbValidity;
    end;
    procedure GetEwbValidity()OutEwbValidity: Text begin
        OutEwbValidity:=EwbValidityText;
    end;
    local procedure SetConfirmMessage(InConfirmMessage: Text)
    begin
        ConfirmMessageText:=InConfirmMessage;
    end;
    procedure GetConfirmMessage()OutConfirmMessage: Text begin
        OutConfirmMessage:=ConfirmMessageText;
    end;
    local procedure SetEInvoiceReturnMessage(InEInvoiceReturnMessage: Text)
    begin
        EInvoiceReturnMessageText:=InEInvoiceReturnMessage;
    end;
    procedure GetEInvoiceReturnMessage()OutEInvoiceReturnMessage: Text begin
        OutEInvoiceReturnMessage:=EInvoiceReturnMessageText;
    end;
    local procedure SetEInvoiceReturnStatus(InEInvoiceReturnStatus: Boolean)
    begin
        EInvoiceReturnStatus:=InEInvoiceReturnStatus;
    end;
    procedure GetEInvoiceReturnStatus()OutEInvoiceReturnStatus: Boolean begin
        OutEInvoiceReturnStatus:=EInvoiceReturnStatus;
    end;
    local procedure SetEWBReturnStatus(InEWBReturnStatus: Boolean)
    begin
        EWBReturnStatus:=InEWBReturnStatus;
    end;
    procedure GetEWBReturnStatus()OutEWBReturnStatus: Boolean begin
        OutEWBReturnStatus:=EWBReturnStatus;
    end;
    //EInvoiceReturnStatus
    local procedure GetJsonToken(JsonObject: JsonObject; TokenKey: text)JsonToken: JsonToken;
    begin
        if not JsonObject.Get(TokenKey, JsonToken)then Error('Could not find a token with key %1', TokenKey);
    end;
    local procedure CheckAppid(var UserAppId: Text[50])
    begin
        if EnvironmentInformation.IsSandbox()then UserAppId:='fIXefFyxGNfDWOcCWnj';
    end;
    local procedure CheckAppPassword(var UserAppPwd: Text[50])
    begin
        if EnvironmentInformation.IsSandbox()then UserAppPwd:='QFd6dZvCGqckabKxTapfZgJc';
    end;
    local procedure CheckUserid(var GSPUserId2: Text[50])
    begin
        if EnvironmentInformation.IsSandbox()then GSPUserId2:='testeway@mastersindia.co';
    end;
    local procedure CheckUserPassword(var GSPUserPassword2: Text[50])
    begin
        if EnvironmentInformation.IsSandbox()then GSPUserPassword2:='!@#Demo!@#123';
    end;
    local procedure GetAuthTokenUrl(): Text begin
        if EnvironmentInformation.IsProduction()then exit('https://pro.mastersindia.co/oauth/access_token')
        else
            exit('https://clientbasic.mastersindia.co/oauth/access_token');
    //exit('https://clientbasic.mastersindia.co/generateEinvoice');
    end;
    local procedure GetEInvoiceUrl(): Text begin
        if EnvironmentInformation.IsProduction()then exit('https://pro.mastersindia.co/generateEinvoice')
        else
            exit('https://clientbasic.mastersindia.co/generateEinvoice');
    end;
    local procedure GetEWBUrl(): Text begin
        if EnvironmentInformation.IsProduction()then exit('https://pro.mastersindia.co/ewayBillsGenerate')
        else
            exit('https://clientbasic.mastersindia.co/ewayBillsGenerate');
    end;
    local procedure GetEWBCancelUrl(): Text begin
        if EnvironmentInformation.IsProduction()then exit('https://pro.mastersindia.co/ewayBillCancel')
        else
            exit('https://clientbasic.mastersindia.co/ewayBillCancel');
    end;
    local procedure GetAckDate(AckDateText: Text[30])OutAckDate: DateTime var
        AckDate: Date;
        AckTime: Time;
        YearInt: Integer;
        MonthInt: Integer;
        DayInt: Integer;
        Hours: Integer;
        Minutes: Integer;
        Seconds: Integer;
        Milliseconds: Integer;
        tim: Time;
    begin
        Evaluate(YearInt, copystr(AckDateText, 1, 4));
        Evaluate(MonthInt, copystr(AckDateText, 6, 2));
        Evaluate(DayInt, copystr(AckDateText, 9, 2));
        Evaluate(Hours, copystr(AckDateText, 12, 2));
        Evaluate(Minutes, copystr(AckDateText, 15, 2));
        Evaluate(Seconds, copystr(AckDateText, 18, 2));
        AckDate:=DMY2Date(DayInt, MonthInt, YearInt);
        //AckTime:=
        Milliseconds+=Seconds * 1000 + Minutes * 1000 * 60 + Hours * 1000 * 60 * 60; //convert time to milliseconds
        Milliseconds:=Milliseconds / 1000; //convert milliseconds to seconds
        tim:=000000T;
        tim:=tim + (Milliseconds MOD 60) * 1000; // get the seconds
        Milliseconds:=Milliseconds DIV 60; // keep the minutes
        tim:=tim + (Milliseconds MOD 60) * 1000 * 60; // get the minutes
        Milliseconds:=Milliseconds DIV 60; // keep the hours
        tim:=tim + (Milliseconds MOD 60) * 1000 * 60 * 60; // get the hours
        OutAckDate:=CreateDateTime(AckDate, tim);
    end;
    var EnvironmentInformation: Codeunit "Environment Information";
    TokenText: Text;
    JsonText: Text;
    GSTINCode: Code[15];
    TradeNameText: Text;
    LegalNameText: Text;
    BuildingNameText: Text;
    BuildingNoText: Text;
    FloorNoText: Text;
    StreetNoText: Text;
    LocationText: Text;
    StateCodeText: Text;
    PostCodeText: Text;
    PartyTypeText: Text;
    StatusText: Text;
    BlockStatusText: Text;
    RegistrationDateText: Text;
    AckNoText: Text;
    AckDateTime: Text;
    IRNText: Text;
    QRCodeText: Text;
    EwbNoText: Text;
    EwbDateText: Text;
    EwbValidityText: Text;
    ConfirmMessageText: Text;
    EInvoiceReturnStatus: Boolean;
    EWBReturnStatus: Boolean;
    EInvoiceReturnMessageText: Text;
    ErrorMsg: Text;
    RequestId: Text;
    QRUrl: Text;
    InvUrl: Text;
    InfoDtls: Text;
}
