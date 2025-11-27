codeunit 50028 "SSD SMS Management"
{
    procedure SendOrderBookingSMS(SalesHeader: Record "Sales Header")
    var
        Customer: Record Customer;
        SalesLine: Record "Sales Line";
        ItemInfo: Text[1024];
        URLText: Text;
        PhoneNo: Text[250];
        BillToPhoneNo: Text;
        ShipToPhoneNo: Text;
        SalespersonPurchaser: Record "Salesperson/Purchaser";
        SalespersonPurchaserPhoneNo: Text;
        KMAInteger: Integer;
        RMSContactNo: Text;
        NMSContactNo: Text;
        CCareContactNo: Text;
        SearchName: Text;
    begin
        //ALLE-281020 new code added below
        PhoneNo:='';
        if Customer.Get(SalesHeader."Bill-to Customer No.")then SearchName:=Customer."Search Name";
        if SalesHeader."Delivery Resp. Contact No." <> '' then BillToPhoneNo:=SalesHeader."Delivery Resp. Contact No.";
        if BillToPhoneNo <> '' then BillToPhoneNo:=BillToPhoneNo + ','; //ALLE
        if SalesHeader."SPD/Sample Order" then begin
            if FindSAMPInDocNumber(SalesHeader."No.")then ItemInfo:=CalculateItemInfoWithDescription(SalesHeader."No.")
            else
                ItemInfo:=CalculateItemInfo(SalesHeader."No.");
            if SalesHeader."Salesperson Code" <> '' then begin
                SalespersonPurchaser.Get(SalesHeader."Salesperson Code");
                SalespersonPurchaserPhoneNo:=CalculateProperPhoneNumber(SalespersonPurchaser."Phone No.");
                if SalespersonPurchaserPhoneNo <> '' then SalespersonPurchaserPhoneNo:=SalespersonPurchaserPhoneNo + ','; //ALLE
                RMSContactNo:=CalculateProperPhoneNumber(SalespersonPurchaser."RSM Contact No.");
                if RMSContactNo <> '' then RMSContactNo:=RMSContactNo + ','; //ALLE
                NMSContactNo:=CalculateProperPhoneNumber(SalespersonPurchaser."NSM Contact No.");
                if NMSContactNo <> '' then NMSContactNo:=NMSContactNo + ','; //ALLE
                CCareContactNo:=CalculateProperPhoneNumber(SalespersonPurchaser."Resp. CCare Exe. Phone No.");
                if CCareContactNo <> '' then CCareContactNo:=CCareContactNo + ','; //ALLE
            end;
            PhoneNo:=BillToPhoneNo + SalespersonPurchaserPhoneNo + RMSContactNo + NMSContactNo + CCareContactNo;
            CheckMobileNo(PhoneNo);
            SalesLine.SetRange("Document Type", SalesLine."document type"::Order);
            SalesLine.SetRange("Document No.", SalesHeader."No.");
            SalesLine.SetRange(Type, SalesLine.Type::Item);
            if SalesLine.FindFirst then URLText:='https://www.uengage.in/ueapi/sendTemplate?longSms=1&usr=lmohan@zavenir.com&pwd=uengage123' + '&mobileNo=' + PhoneNo + '&senderId=ZDIGGN&templateId=722&param=' + SalesHeader."No." + '::' + Format(SalesHeader."Order Date");
            CallHttp(URLText);
        end end;
    local procedure CallHttp(SMSUrl: Text)
    var
        SSDHttpClient: HttpClient;
        SSDHttpResponseMessage: HttpResponseMessage;
        ResponseText: Text;
        ErrorMsg: Text;
    begin
        if not SSDHttpClient.Get(SMSUrl, SSDHttpResponseMessage)then Error('The call to send SMS failed');
        if not SSDHttpResponseMessage.IsSuccessStatusCode then begin
            ErrorMsg+='\The request to send SMS returned an error message. \Detail: \Status Code: ' + Format(SSDHttpResponseMessage.HttpStatusCode) + '\Description: ' + SSDHttpResponseMessage.ReasonPhrase;
        end;
        SSDHttpResponseMessage.Content.ReadAs(ResponseText);
        Message(ResponseText);
    end;
    local procedure FindSAMPInDocNumber(DocNo: Code[20]): Boolean var
        SAMPCnt: Integer;
    begin
        // BS21122016 New function added.
        SAMPCnt:=StrPos(DocNo, 'SAMP');
        if SAMPCnt >= 1 then exit(true);
        exit(false);
    end;
    local procedure CalculateItemInfo(DocNo: Code[20])ItemInfo: Text[1024]var
        SalesLine: Record "Sales Line";
        ItemCnt: Integer;
        CrossReferenceNo: Text;
    begin
        // BS21122016 New function added.
        Clear(ItemInfo);
        ItemCnt:=0;
        SalesLine.Reset;
        SalesLine.SetRange("Document No.", DocNo);
        SalesLine.SetRange("Document Type", SalesLine."document type"::Order);
        SalesLine.SetRange(Type, SalesLine.Type::Item);
        if SalesLine.FindSet then repeat ItemCnt+=1;
                if ItemCnt > 1 then ItemInfo+=',';
                if SalesLine."Item Reference No." = '' then CrossReferenceNo:=''
                else
                    CrossReferenceNo:='(' + SalesLine."Item Reference No." + ')';
                ItemInfo+=SalesLine."No." + ' ' + SalesLine."Item Category Code" + ' ' + CrossReferenceNo + ' ' + Format(SalesLine.Quantity) + ' ' + SalesLine."Unit of Measure Code";
            until SalesLine.Next = 0;
    end;
    local procedure CalculateItemInfoWithDescription(DocNo: Code[20])ItemInfo: Text[1024]var
        SalesLine: Record "Sales Line";
        ItemCnt: Integer;
        CrossReferenceNo: Text;
    begin
        // BS21122016 New function added.
        Clear(ItemInfo);
        ItemCnt:=0;
        SalesLine.Reset;
        SalesLine.SetRange("Document No.", DocNo);
        SalesLine.SetRange("Document Type", SalesLine."Document type"::Order);
        SalesLine.SetRange(Type, SalesLine.Type::Item);
        if SalesLine.FindSet()then repeat ItemCnt+=1;
                if ItemCnt > 1 then ItemInfo+=',';
                if SalesLine."Item Reference No." = '' then CrossReferenceNo:=''
                else
                    CrossReferenceNo:='(' + SalesLine."Item Reference No." + ')';
                ItemInfo+=SalesLine."No." + ' ' + SalesLine."Description 2" + ' ' + CrossReferenceNo + ' ' + Format(SalesLine.Quantity) + ' ' + SalesLine."Unit of Measure Code";
            until SalesLine.Next = 0;
    end;
    local procedure CalculateProperPhoneNumber(InputPhoneNumber: Text)OutPhoneNumber: Text var
        InPhoneLength: Integer;
    begin
        // BS21122016 New function added.
        InPhoneLength:=StrLen(InputPhoneNumber);
        if InPhoneLength = 10 then begin
            OutPhoneNumber:=InputPhoneNumber;
            exit(OutPhoneNumber);
        end;
        if InPhoneLength > 10 then begin
            OutPhoneNumber:=CopyStr(InputPhoneNumber, (InPhoneLength - 9), InPhoneLength);
        end;
        exit(OutPhoneNumber);
    end;
    local procedure CheckMobileNo(var MobileNo: Text[250])
    var
        GeneralLedgerSetup: Record "General Ledger Setup";
        EnvironmentInformation: Codeunit "Environment Information";
    begin
        if EnvironmentInformation.IsProduction()then exit;
        GeneralLedgerSetup.Get();
        GeneralLedgerSetup.TestField("Sandbox Mobile No.");
        MobileNo:=GeneralLedgerSetup."Sandbox Mobile No.";
    end;
}
