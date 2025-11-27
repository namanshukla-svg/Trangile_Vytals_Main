codeunit 50060 "SSD Generate Einvoice"
{
    Permissions = TableData "Sales Invoice Header" = m,
        TableData "Sales Cr.Memo Header" = m;

    trigger OnRun()
    begin
        Initialize();
        if IsInvoice then
            ExportInvoice()
        else
            ExportCrMemo();
        if DocumentNo <> '' then
            ExportAsJson(DocumentNo)
        else
            Error(RecIsEmptyErr);
    end;

    var
        SalesInvoiceHeader: Record "Sales Invoice Header";
        SalesCrMemoHeader: Record "Sales Cr.Memo Header";
        TransferShipmentHeader: Record "Transfer Shipment Header";
        EnvironmentInformation: Codeunit "Environment Information";
        SSDGSPManagement: Codeunit "SSD GSP Management";
        SSDJsonObject: JsonObject;
        JsonArrayData: JsonArray;
        EWBApplicable: Boolean;
        JsonText: Text;
        UnRegCusrErr: Label 'E-Invoicing is not applicable for Unregistered Customer.';
        RecIsEmptyErr: Label 'Record variable uninitialized.';
        IsInvoice: Boolean;
        SalesLinesErr: Label 'E-Invoice allowes only 100 lines per Invoice. Curent transaction is having %1 lines.', Comment = '%1 = Sales Lines count';
        DocumentNo: Text[20];
        GNull: JsonValue;
        CurrExRate: Decimal;
        ChargeAmt: Decimal;
        ChargeGSTAmt: Decimal;
        ChargeLineNo: Integer;
        StringWriterJson: JsonObject;

    local procedure ExportInvoice()
    begin
        GNull.SetValueToNull();
        if SalesInvoiceHeader."GST Customer Type" in ["GST Customer Type"::Unregistered, SalesInvoiceHeader."GST Customer Type"::" "] then Error(UnRegCusrErr);
        DocumentNo := SalesInvoiceHeader."No.";
        WriteFileHeader();
        Clear(JsonArrayData);
        ReadTransDtls(SalesInvoiceHeader."GST Customer Type", SalesInvoiceHeader."Ship-to Code");
        Clear(JsonArrayData);
        ReadDocDtls();
        Clear(JsonArrayData);
        ReadSellerDtls();
        Clear(JsonArrayData);
        ReadBuyerDtls();
        Clear(JsonArrayData);
        ReadShipDtls();
        Clear(JsonArrayData);
        ReadExpDtls();
        Clear(JsonArrayData);
        ReadReferenceDocDtls();
        Clear(JsonArrayData);
        ReadValDtls();
        Clear(JsonArrayData);
        ReadItemList();
        // if EWBApplicable then
        //     ReadEwbDtls();
    end;

    local procedure ExportCrMemo()
    begin
        GNull.SetValueToNull();
        if SalesCrMemoHeader."GST Customer Type" in ["GST Customer Type"::Unregistered, SalesCrMemoHeader."GST Customer Type"::" "] then Error(UnRegCusrErr);
        DocumentNo := SalesCrMemoHeader."No.";
        WriteFileHeader();
        Clear(JsonArrayData);
        ReadTransDtls(SalesInvoiceHeader."GST Customer Type", SalesInvoiceHeader."Ship-to Code");
        Clear(JsonArrayData);
        ReadDocDtls();
        Clear(JsonArrayData);
        ReadSellerDtls();
        Clear(JsonArrayData);
        ReadBuyerDtls();
        Clear(JsonArrayData);
        ReadShipDtls();
        Clear(JsonArrayData);
        ReadExpDtls();
        Clear(JsonArrayData);
        ReadReferenceDocDtls();
        Clear(JsonArrayData);
        ReadValDtls();
        Clear(JsonArrayData);
        ReadItemList();
    end;

    local procedure Initialize()
    begin
        CLEAR(GNull);
        Clear(SSDJsonObject);
        Clear(JsonArrayData);
        Clear(JsonText);
    end;

    procedure ExportJsonTxt() JsonTxt: Text;
    var
    begin
        Initialize();
        if IsInvoice then
            ExportInvoice()
        else
            ExportCrMemo();
        StringWriterJson.WriteTo(JsonText);
        JsonTxt := JsonText;
    end;

    local procedure WriteFileHeader()
    var
        UserGSTIN: Code[15];
    begin
        StringWriterJson.Add('access_token', SSDGSPManagement.SSDGetAccessToken());
        UserGSTIN := CopyStr(GetGSTIN(SalesInvoiceHeader."Location Code"), 1, 15);
        CheckUserGSTIN(UserGSTIN);
        StringWriterJson.Add('user_gstin', UserGSTIN);
        StringWriterJson.Add('data_soure', 'erp');
        JsonArrayData.Add(StringWriterJson);
    end;

    local procedure ReadTransDtls(GSTCustType: Enum "GST Customer Type"; ShipToCode: Code[12])
    var
        SalesInvoiceLine: Record "Sales Invoice Line";
        SalesCrMemoLine: Record "Sales Cr.Memo Line";
        catg: Text[10];
        Typ: Text[3];
        POS: Code[10];
        ReverseCharge: Text[2];
        eCommerceMerchantId: Record "E-Comm. Merchant";
        eCommerceGSTIN: Code[20];
    begin
        if IsInvoice then begin
            if GSTCustType in [SalesInvoiceHeader."GST Customer Type"::Registered, SalesInvoiceHeader."GST Customer Type"::Exempted] then catg := 'B2B';
            IF GSTCustType = SalesInvoiceHeader."GST Customer Type"::Export THEN begin
                IF SalesInvoiceHeader."GST Without Payment of Duty" THEN
                    catg := 'EXPWOP'
                ELSE
                    catg := 'EXPWP';
            end;
            IF GSTCustType = GSTCustType::"Deemed Export" then catg := 'DEXP';
            IF GSTCustType IN [SalesInvoiceHeader."GST Customer Type"::"SEZ Development", SalesInvoiceHeader."GST Customer Type"::"SEZ Unit"] then
                IF SalesInvoiceHeader."GST Without Payment of Duty" THEN
                    catg := 'SEZWOP'
                ELSE
                    catg := 'SEZWP';
            if SalesInvoiceHeader."POS Out Of India" then
                POS := 'Y'
            else
                POS := 'N';
            if SalesInvoiceHeader."e-Commerce Customer" <> '' then begin
                //  if eCommerceMerchantId.Get(SalesInvoiceHeader."e-Commerce Customer", SalesInvoiceHeader."e-Commerce Merchant Id")then eCommerceGSTIN:=eCommerceMerchantId."Company GST Reg. No."; //IG_DS_before
                if eCommerceMerchantId.Get(SalesInvoiceHeader."e-Commerce Customer", SalesInvoiceHeader."E-Comm. Merchant Id") then eCommerceGSTIN := eCommerceMerchantId."Company GST Reg. No."; //IG_DS_after
            end;
            if ShipToCode <> '' then begin
                SalesInvoiceLine.SETRANGE("Document No.", DocumentNo);
                if SalesInvoiceLine.FindSet() then
                    repeat
                        if SalesInvoiceLine."GST Place of Supply" <> SalesInvoiceLine."GST Place of Supply"::"Ship-to Address" then
                            Typ := 'SHP'
                        else
                            Typ := 'REG';
                    until SalesInvoiceLine.Next() = 0;
            end
            else
                Typ := 'REG';
        end
        else begin
            if GSTCustType in [SalesCrMemoHeader."GST Customer Type"::Registered, SalesCrMemoHeader."GST Customer Type"::Exempted] then catg := 'B2B';
            IF SalesCrMemoHeader."GST Customer Type" = SalesCrMemoHeader."GST Customer Type"::Export THEN begin
                IF SalesCrMemoHeader."GST Without Payment of Duty" THEN
                    catg := 'EXPWOP'
                ELSE
                    catg := 'EXPWP';
            end;
            if (SalesCrMemoHeader."GST Customer Type" = SalesCrMemoHeader."GST Customer Type"::"SEZ Development") or (SalesCrMemoHeader."GST Customer Type" = SalesCrMemoHeader."GST Customer Type"::"SEZ Development") then BEGIN
                IF SalesCrMemoHeader."GST Without Payment of Duty" THEN
                    catg := 'SEZWOP'
                ELSE
                    catg := 'SEZWP';
            END;
            IF SalesCrMemoHeader."GST Customer Type" = SalesCrMemoHeader."GST Customer Type"::"Deemed Export" THEN catg := 'DEXP';
            if SalesCrMemoHeader."POS Out Of India" then
                POS := 'Y'
            else
                POS := 'N';
            if SalesCrMemoHeader."e-Commerce Customer" <> '' then begin
                // if eCommerceMerchantId.Get(SalesCrMemoHeader."e-Commerce Customer", SalesCrMemoHeader."e-Commerce Merchant Id") then eCommerceGSTIN := eCommerceMerchantId."Company GST Reg. No."; //IG_DS_before
                if eCommerceMerchantId.Get(SalesCrMemoHeader."e-Commerce Customer", SalesCrMemoHeader."E-Comm. Merchant Id") then eCommerceGSTIN := eCommerceMerchantId."Company GST Reg. No."; //IG_DS_after
            end;
            SalesCrMemoLine.SetRange("Document No.", DocumentNo);
            if SalesCrMemoLine.FindSet() then
                repeat
                    if SalesCrMemoLine."GST Place of Supply" = SalesCrMemoLine."GST Place of Supply"::"Ship-to Address" then
                        Typ := 'REG'
                    else
                        Typ := 'SHP';
                until SalesCrMemoLine.Next() = 0;
        END;
        WriteTransDtls(catg, 'RG', Typ, 'false', 'Y', '', POS, eCommerceGSTIN);
    end;

    local procedure WriteTransDtls(catg: Text[10]; RegRev: Text[2]; Typ: Text[3]; EcmTrnSel: Text[5]; EcmTrn: Text[1]; EcmGstin: Text[15]; POS: Code[10]; eCommGSTN: Code[20])
    var
        TranDtlsWriter: JsonObject;
    begin
        TranDtlsWriter.Add('supply_type', catg);
        TranDtlsWriter.Add('charge_type', 'N');
        TranDtlsWriter.Add('igst_on_intra', POS);
        if eCommGSTN <> '' then TranDtlsWriter.Add('ecommerce_gstin', eCommGSTN);
        StringWriterJson.Add('transaction_details', TranDtlsWriter);
    end;

    local procedure WriteTrandferTransDtls(catg: Text[10]; RegRev: Text[2]; Typ: Text[3]; EcmTrnSel: Text[5]; EcmTrn: Text[1]; EcmGstin: Text[15]; POS: Code[10]; eCommGSTN: Code[20])
    var
        TranDtlsWriter: JsonObject;
    begin
        TranDtlsWriter.Add('supply_type', 'B2B');
        TranDtlsWriter.Add('charge_type', 'N');
        StringWriterJson.Add('transaction_details', TranDtlsWriter);
    end;

    local procedure ReadDocDtls()
    var
        Typ: Text[3];
        Dt: Text[10];
        OrgInvNo: Text[16];
    begin
        if IsInvoice then begin
            if (SalesInvoiceHeader."Invoice Type" = SalesInvoiceHeader."Invoice Type"::"Debit Note") OR (SalesInvoiceHeader."Invoice Type" = SalesInvoiceHeader."Invoice Type"::Supplementary) then
                Typ := 'DBN'
            else
                Typ := 'INV';
            Dt := GetDateFormated(SalesInvoiceHeader."Posting Date");
            OrgInvNo := SalesInvoiceHeader."No.";
            WriteDocDtls(Typ, OrgInvNo, Dt, '');
        end
        else begin
            Typ := 'CRN';
            Dt := GetDateFormated(SalesInvoiceHeader."Posting Date");
            OrgInvNo := SalesInvoiceHeader."No.";
            WriteDocDtls(Typ, OrgInvNo, Dt, '');
        end;
    end;

    local procedure WriteDocDtls(Typ: Text[3]; No: Text[16]; Dt: Text[10]; OrgInvNo: Text[16])
    var
        DocDtlsWriter: JsonObject;
    begin
        DocDtlsWriter.Add('document_type', Typ);
        DocDtlsWriter.Add('document_number', No);
        DocDtlsWriter.Add('document_date', Dt);
        StringWriterJson.Add('document_details', DocDtlsWriter);
    end;

    local procedure ReadExpDtls()
    var
        SalesInvoiceLine: Record "Sales Invoice Line";
        SalesCrMemoLine: Record "Sales Cr.Memo Line";
        ExpCat: Text[3];
        WithPay: Text[1];
        ShipBNo: Text[16];
        ShipBDt: Text[10];
        Port: Text[10];
        InvForCur: Decimal;
        ForCur: Text[16];
        CntCode: Text[2];
    begin
        if IsInvoice then
            if SalesInvoiceHeader."GST Customer Type" IN [SalesInvoiceHeader."GST Customer Type"::Export, SalesInvoiceHeader."GST Customer Type"::"Deemed Export", SalesInvoiceHeader."GST Customer Type"::"SEZ Unit", SalesInvoiceHeader."GST Customer Type"::"SEZ Development"] then begin
                CASE SalesInvoiceHeader."GST Customer Type" OF
                    SalesInvoiceHeader."GST Customer Type"::Export:
                        ExpCat := 'DIR';
                    SalesInvoiceHeader."GST Customer Type"::"Deemed Export":
                        ExpCat := 'DEM';
                    SalesInvoiceHeader."GST Customer Type"::"SEZ Unit":
                        ExpCat := 'SEZ';
                    SalesInvoiceHeader."GST Customer Type"::"SEZ Development":
                        ExpCat := 'SED';
                END;
                if SalesInvoiceHeader."GST Without Payment of Duty" then
                    WithPay := 'N'
                ELSE
                    WithPay := 'Y';
                ShipBNo := (SalesInvoiceHeader."Bill Of Export No.");
                ShipBDt := GetDateFormated(SalesInvoiceHeader."Bill Of Export Date");
                Port := SalesInvoiceHeader."Exit Point";
                SalesInvoiceLine.SETRANGE("Document No.", SalesInvoiceHeader."No.");
                if SalesInvoiceLine.FINDSET() then
                    REPEAT
                        InvForCur := InvForCur + SalesInvoiceLine.Amount;
                    UNTIL SalesInvoiceLine.NEXT() = 0;
                ForCur := (SalesInvoiceHeader."Currency Code");
                CntCode := SalesInvoiceHeader."Bill-to Country/Region Code";
            END
            ELSE
                EXIT
        else if SalesCrMemoHeader."GST Customer Type" IN [SalesCrMemoHeader."GST Customer Type"::Export, SalesCrMemoHeader."GST Customer Type"::"Deemed Export", SalesCrMemoHeader."GST Customer Type"::"SEZ Unit", SalesCrMemoHeader."GST Customer Type"::"SEZ Development"] then begin
            CASE SalesCrMemoHeader."GST Customer Type" OF
                SalesCrMemoHeader."GST Customer Type"::Export:
                    ExpCat := 'DIR';
                SalesCrMemoHeader."GST Customer Type"::"Deemed Export":
                    ExpCat := 'DEM';
                SalesCrMemoHeader."GST Customer Type"::"SEZ Unit":
                    ExpCat := 'SEZ';
                "GST Customer Type"::"SEZ Development":
                    ExpCat := 'SED';
            END;
            if SalesCrMemoHeader."GST Without Payment of Duty" then
                WithPay := 'N'
            ELSE
                WithPay := 'Y';
            ShipBNo := (SalesCrMemoHeader."Bill Of Export No.");
            ShipBDt := GetDateFormated(SalesCrMemoHeader."Bill Of Export Date");
            Port := SalesCrMemoHeader."Exit Point";
            SalesCrMemoLine.SETRANGE("Document No.", SalesCrMemoHeader."No.");
            if SalesCrMemoLine.FINDSET() then
                REPEAT
                    InvForCur := InvForCur + SalesCrMemoLine.Amount;
                UNTIL SalesCrMemoLine.NEXT() = 0;
            ForCur := (SalesCrMemoHeader."Currency Code");
            CntCode := SalesCrMemoHeader."Bill-to Country/Region Code";
        END
        ELSE
            EXIT;
        WriteExpDtls(ExpCat, WithPay, ShipBNo, ShipBDt, Port, InvForCur, ForCur, CntCode);
    end;

    local procedure WriteExpDtls(ExpCat: Text[3]; WithPay: Text[1]; ShipBNo: Text[16]; ShipBDt: Text[10]; Port: Text[10]; InvForCur: Decimal; ForCur: Text[20]; CntCode: Text[2])
    var
        ExpDtlsWtriter: JsonObject;
    begin
        ExpDtlsWtriter.Add('ship_bill_number', ShipBNo);
        ExpDtlsWtriter.Add('ship_bill_date', ShipBDt);
        ExpDtlsWtriter.Add('port_code', Port);
        ExpDtlsWtriter.Add('country_code', CntCode);
        ExpDtlsWtriter.Add('InvForCur', InvForCur);
        ExpDtlsWtriter.Add('foreign_currency', ForCur);
        //JsonArrayData.Add(ExpDtlsWtriter);
        StringWriterJson.Add('export_details', ExpDtlsWtriter);
    end;

    local procedure ReadSellerDtls()
    var
        CompanyInformationBuff: Record "Company Information";
        LocationBuff: Record "Location";
        Location2: Record Location;
        StateBuff: Record "State";
        Gstin: Code[15];
        TrdNm: Text[100];
        Bno: Text[100];
        Bnm: Text[100];
        Flno: Text[60];
        Loc: Text[60];
        Dst: Text[60];
        Pin: Code[10];
        Stcd: Text;
        Ph: Text[10];
        Em: Text[50];
        GLSetup: Record "General Ledger Setup";
        PinInt: Integer;
        LegalName: Text;
    begin
        GLSetup.Get();
        if IsInvoice then begin
            LocationBuff.GET(SalesInvoiceHeader."Location Code");
            //SSD_Sunil
            if LocationBuff."Temp JW Location" then begin
                Location2.Get('STR_FG');
                Gstin := GetGSTIN(SalesInvoiceHeader."Location Code");
                CheckUserGSTIN(Gstin); //Sandeep 07042023
                CompanyInformationBuff.GET();
                LegalName := CompanyInformationBuff.Name;
                TrdNm := Location2.Name;
                Bno := Location2.Address;
                Bnm := Location2."Address 2";
                //Flno := 'FLNo1'; //SSD_Sunil
                Loc := Location2.City;
                CheckLocation(Loc); //Sandeep 07042023
                //Dst := LocationBuff.City;//SSD_Sunil
                evaluate(Pin, COPYSTR(Location2."Post Code", 1, 6));
                CheckPinCode(Pin); //Sandeep 07042023
                StateBuff.GET(Location2."State Code");
                //Stcd := StateBuff."State Code (GST Reg. No.)";
                Stcd := UpperCase(StateBuff.Description);
                CheckStateName(Stcd); //Sandeep 07042023
                Ph := RemoveSpecialChar(COPYSTR(Location2."Phone No.", 1, 10));
                Em := COPYSTR(Location2."E-Mail", 1, 50);
            end
            else begin
                LocationBuff.GET(SalesInvoiceHeader."Location Code");
                //SSD_Sunil
                Gstin := GetGSTIN(SalesInvoiceHeader."Location Code");
                CheckUserGSTIN(Gstin); //Sandeep 07042023
                CompanyInformationBuff.GET();
                LegalName := CompanyInformationBuff.Name;
                TrdNm := LocationBuff.Name;
                Bno := LocationBuff.Address;
                Bnm := LocationBuff."Address 2";
                //Flno := 'FLNo1'; //SSD_Sunil
                Loc := LocationBuff.City;
                CheckLocation(Loc); //Sandeep 07042023
                //Dst := LocationBuff.City;//SSD_Sunil
                evaluate(Pin, COPYSTR(LocationBuff."Post Code", 1, 6));
                CheckPinCode(Pin); //Sandeep 07042023
                StateBuff.GET(LocationBuff."State Code");
                //Stcd := StateBuff."State Code (GST Reg. No.)";
                Stcd := UpperCase(StateBuff.Description);
                CheckStateName(Stcd); //Sandeep 07042023
                Ph := RemoveSpecialChar(COPYSTR(LocationBuff."Phone No.", 1, 10));
                Em := COPYSTR(LocationBuff."E-Mail", 1, 50);
            END
        end
        ELSE BEGIN
            LocationBuff.GET(SalesCrMemoHeader."Location Code");
            Gstin := LocationBuff."GST Registration No.";
            CompanyInformationBuff.GET();
            LegalName := CompanyInformationBuff.Name;
            TrdNm := LocationBuff.Name;
            Bno := LocationBuff.Address;
            Bnm := LocationBuff."Address 2";
            Flno := '';
            Loc := LocationBuff.City;
            Dst := LocationBuff.City;
            Pin := LocationBuff."Post Code";
            StateBuff.GET(LocationBuff."State Code");
            Stcd := UpperCase(StateBuff.Description);
            Ph := RemoveSpecialChar(COPYSTR(LocationBuff."Phone No.", 1, 10));
            Em := COPYSTR(LocationBuff."E-Mail", 1, 50);
        END;
        WriteSellerDtls(Gstin, TrdNm, Bno, Bnm, Flno, Loc, Dst, Pin, Stcd, Ph, Em, LegalName);
    end;

    local procedure WriteSellerDtls(Gstin: Code[15]; TrdNm: Text[100]; Bno: Text[100]; Bnm: Text[100]; Flno: Text[60]; Loc: Text[60]; Dst: Text[60]; Pin: Code[10]; Stcd: Text; Ph: Text[10]; Em: Text[50]; LegalName: text)
    var
        SellerDtlsWriter: JsonObject;
    begin
        SellerDtlsWriter.Add('gstin', Gstin);
        SellerDtlsWriter.Add('legal_name', LegalName);
        SellerDtlsWriter.Add('trade_name', TrdNm);
        SellerDtlsWriter.Add('address1', Bno);
        SellerDtlsWriter.Add('address2', Bnm);
        SellerDtlsWriter.Add('location', Loc);
        SellerDtlsWriter.Add('pincode', Pin);
        SellerDtlsWriter.Add('state_code', Stcd);
        StringWriterJson.Add('seller_details', SellerDtlsWriter)
    end;

    local procedure ReadBuyerDtls()
    var
        Contact: Record Contact;
        SalesInvoiceLine: Record "Sales Invoice Line";
        SalesCrMemoLine: Record "Sales Cr.Memo Line";
        ShipToAddr: Record "Ship-to Address";
        StateBuff: Record State;
        Gstin: Code[15];
        TrdNm: Text[100];
        Bno: Text[100];
        Bnm: Text[100];
        Flno: Text[60];
        Loc: Text[60];
        Dst: Text[60];
        Pin: Code[20];
        Stcd: Text;
        Ph: Text[10];
        Em: Text[50];
        POS: Text[2];
        AddTxt: Text;
        Customer: Record Customer;
    begin
        if IsInvoice then begin
            Customer.Get(SalesInvoiceHeader."Bill-to Customer No.");
            if Customer."GST Registration No." <> '' then
                Gstin := Customer."GST Registration No."
            else
                Gstin := 'URP';
            TrdNm := SalesInvoiceHeader."Bill-to Name";
            //Bno := SalesInvoiceHeader."Bill-to Address";
            //Bnm := SalesInvoiceHeader."Bill-to Address 2";
            //Flno := 'F1';
            //Loc := SalesInvoiceHeader."Bill-to City";
            //Dst := Customer.City;
            // if SalesInvoiceHeader."Bill-to Post Code" <> '' then
            //     evaluate(Pin, COPYSTR(SalesInvoiceHeader."Bill-to Post Code", 1, 6));
            SalesInvoiceLine.SETRANGE("Document No.", SalesInvoiceHeader."No.");
            SalesInvoiceLine.SETFILTER("GST Place of Supply", '<>%1', SalesInvoiceLine."GST Place of Supply"::" ");
            SalesInvoiceLine.SetFilter(Quantity, '<>%1', 0);
            if SalesInvoiceLine.FINDFIRST() then
                case SalesInvoiceLine."GST Place of Supply" of
                    SalesInvoiceLine."GST Place of Supply"::"Bill-to Address":
                        begin
                            Bno := SalesInvoiceHeader."Bill-to Address";
                            Bnm := SalesInvoiceHeader."Bill-to Address 2";
                            Loc := SalesInvoiceHeader."Bill-to City";
                            if SalesInvoiceHeader."GST Customer Type" in [SalesInvoiceHeader."GST Customer Type"::Export, SalesInvoiceHeader."GST Customer Type"::"Deemed Export", SalesInvoiceHeader."GST Customer Type"::"SEZ Development", SalesInvoiceHeader."GST Customer Type"::"SEZ Unit"] then begin
                                Stcd := '96';
                                POS := '96';
                                IF SalesInvoiceHeader."GST Customer Type" = SalesInvoiceHeader."GST Customer Type"::Export THEN
                                    Stcd := '96'
                                ELSE
                                    Stcd := GetStateCode(SalesInvoiceHeader."GST Bill-to State Code");
                                IF SalesInvoiceHeader."GST Customer Type" = SalesInvoiceHeader."GST Customer Type"::Export THEN
                                    Pin := '999999'
                                ELSE
                                    Pin := SalesInvoiceHeader."Bill-to Post Code";
                                //Dst := 'Other Territory';
                            end
                            else begin
                                // (SalesInvoiceHeader."GST Customer Type" = SalesInvoiceHeader."GST Customer Type"::Export) then begin
                                StateBuff.GET(SalesInvoiceHeader."GST Bill-to State Code");
                                Stcd := UpperCase(StateBuff.Description);
                                POS := StateBuff."State Code (GST Reg. No.)";
                                Bno := SalesInvoiceHeader."Bill-to Address";
                                Bnm := SalesInvoiceHeader."Bill-to Address 2";
                                //Flno := 'F1';
                                Loc := SalesInvoiceHeader."Bill-to City";
                                Pin := SalesInvoiceHeader."Bill-to Post Code";
                                //Dst := Customer.City;
                            end;
                            // END ELSE begin
                            //     Stcd := '96';
                            //     POS := '96';
                            //     Pin := 999999;
                            //     Loc := 'Other Territory';
                            //     Dst := 'Other Territory';
                            // end;
                            // IF Customer."Phone No." <> '' THEN BEGIN
                            //     Ph := RemoveSpecialChar(COPYSTR(Customer."Phone No.", 1, 10));
                            //     Em := COPYSTR(Customer."E-Mail", 1, 50);
                            // END ELSE
                            //     if Contact.GET(SalesInvoiceHeader."Bill-to Contact No.") then begin
                            //         Ph := RemoveSpecialChar(COPYSTR(Contact."Phone No.", 1, 10));
                            //         Em := COPYSTR(Contact."E-Mail", 1, 50);
                            //     END ELSE begin
                            //         Ph := '';
                            //         Em := '';
                            //     END;
                        END;
                    SalesInvoiceLine."GST Place of Supply"::"Ship-to Address":
                        begin
                            if SalesInvoiceHeader."GST Customer Type" in [SalesInvoiceHeader."GST Customer Type"::Export, SalesInvoiceHeader."GST Customer Type"::"Deemed Export", SalesInvoiceHeader."GST Customer Type"::"SEZ Development", SalesInvoiceHeader."GST Customer Type"::"SEZ Unit"] then begin
                                Stcd := '96';
                                POS := '96';
                                Pin := '999999';
                                Loc := 'Other Territory';
                            end
                            else begin
                                //StateBuff.Get(SalesInvoiceHeader."GST Ship-to State Code");
                                //Stcd := StateBuff."State Code (GST Reg. No.)";
                                Stcd := GetStateCode_POS(SalesInvoiceHeader."GST Ship-to State Code");
                                POS := StateBuff."State Code (GST Reg. No.)";
                            end;
                            if ShipToAddr.GET(SalesInvoiceHeader."Sell-to Customer No.", SalesInvoiceHeader."Ship-to Code") then begin
                                Ph := RemoveSpecialChar(COPYSTR(ShipToAddr."Phone No.", 1, 10));
                                Em := COPYSTR(ShipToAddr."E-Mail", 1, 50);
                                Bno := ShipToAddr.Address;
                                Bnm := ShipToAddr."Address 2";
                                Loc := ShipToAddr.City;
                                Pin := SalesInvoiceHeader."Bill-to Post Code";
                            END
                            ELSE begin
                                Ph := '';
                                Em := '';
                            END;
                        END;
                    SalesInvoiceLine."GST Place of Supply"::"Location Address":
                        begin
                            if NOT (SalesInvoiceHeader."GST Customer Type" = SalesInvoiceHeader."GST Customer Type"::Export) then begin
                                StateBuff.GET(SalesInvoiceHeader."GST Bill-to State Code");
                                Stcd := StateBuff."State Code (GST Reg. No.)";
                                POS := StateBuff."State Code (GST Reg. No.)"
                            END
                            ELSE begin
                                Stcd := '96';
                                POS := '96';
                                Pin := '999999';
                                Loc := 'Other Territory';
                            end;
                            if Contact.GET(SalesInvoiceHeader."Bill-to Contact No.") then begin
                                Ph := RemoveSpecialChar(COPYSTR(Contact."Phone No.", 1, 10));
                                Em := COPYSTR(Contact."E-Mail", 1, 50);
                            END
                            ELSE begin
                                Ph := '';
                                Em := '';
                            END;
                        END;
                    else begin
                        Stcd := '';
                        Ph := '';
                        Em := '';
                        POS := '';
                    END;
                end;
        end
        else begin
            Customer.Get(SalesCrMemoHeader."Bill-to Customer No.");
            if Customer."GST Registration No." <> '' then
                Gstin := Customer."GST Registration No."
            else
                Gstin := 'URP';
            TrdNm := SalesCrMemoHeader."Bill-to Name";
            //Bno := SalesInvoiceHeader."Bill-to Address";
            //Bnm := SalesInvoiceHeader."Bill-to Address 2";
            //Flno := 'F1';
            //Loc := SalesInvoiceHeader."Bill-to City";
            //Dst := Customer.City;
            // if SalesInvoiceHeader."Bill-to Post Code" <> '' then
            //     evaluate(Pin, COPYSTR(SalesInvoiceHeader."Bill-to Post Code", 1, 6));
            SalesCrMemoLine.SETRANGE("Document No.", SalesCrMemoHeader."No.");
            SalesCrMemoLine.SETFILTER("GST Place of Supply", '<>%1', SalesCrMemoLine."GST Place of Supply"::" ");
            SalesCrMemoLine.SetFilter(Quantity, '<>%1', 0);
            if SalesCrMemoLine.FINDFIRST() then
                case SalesCrMemoLine."GST Place of Supply" of
                    SalesCrMemoLine."GST Place of Supply"::"Bill-to Address":
                        begin
                            if SalesCrMemoHeader."GST Customer Type" in [SalesCrMemoHeader."GST Customer Type"::Export, SalesCrMemoHeader."GST Customer Type"::"Deemed Export", SalesCrMemoHeader."GST Customer Type"::"SEZ Development", SalesCrMemoHeader."GST Customer Type"::"SEZ Unit"] then begin
                                Stcd := '96';
                                POS := '96';
                                Pin := '999999';
                                Loc := 'Other Territory';
                                //Dst := 'Other Territory';
                            end
                            else begin
                                // (SalesInvoiceHeader."GST Customer Type" = SalesInvoiceHeader."GST Customer Type"::Export) then begin
                                StateBuff.GET(SalesCrMemoHeader."GST Bill-to State Code");
                                Stcd := UpperCase(StateBuff.Description);
                                POS := StateBuff."State Code (GST Reg. No.)";
                                Bno := SalesCrMemoHeader."Bill-to Address";
                                Bnm := SalesCrMemoHeader."Bill-to Address 2";
                                //Flno := 'F1';
                                Loc := SalesCrMemoHeader."Bill-to City";
                                Pin := SalesCrMemoHeader."Bill-to Post Code";
                                //Dst := Customer.City;
                            end;
                        END;
                    SalesCrMemoLine."GST Place of Supply"::"Ship-to Address":
                        begin
                            if SalesCrMemoHeader."GST Customer Type" in [SalesCrMemoHeader."GST Customer Type"::Export, SalesCrMemoHeader."GST Customer Type"::"Deemed Export", SalesCrMemoHeader."GST Customer Type"::"SEZ Development", SalesCrMemoHeader."GST Customer Type"::"SEZ Unit"] then begin
                                Stcd := '96';
                                POS := '96';
                                Pin := '999999';
                                Loc := 'Other Territory';
                            end
                            else begin
                                //StateBuff.Get(SalesInvoiceHeader."GST Ship-to State Code");
                                //Stcd := StateBuff."State Code (GST Reg. No.)";
                                Stcd := GetStateCode_POS(SalesCrMemoHeader."GST Ship-to State Code");
                                POS := StateBuff."State Code (GST Reg. No.)";
                            end;
                            if ShipToAddr.GET(SalesCrMemoHeader."Sell-to Customer No.", SalesCrMemoHeader."Ship-to Code") then begin
                                Ph := RemoveSpecialChar(COPYSTR(ShipToAddr."Phone No.", 1, 10));
                                Em := COPYSTR(ShipToAddr."E-Mail", 1, 50);
                                Bno := ShipToAddr.Address;
                                Bnm := ShipToAddr."Address 2";
                                Loc := ShipToAddr.City;
                                Pin := SalesInvoiceHeader."Bill-to Post Code";
                            END
                            ELSE begin
                                Ph := '';
                                Em := '';
                            END;
                        END;
                    SalesInvoiceLine."GST Place of Supply"::"Location Address":
                        begin
                            if NOT (SalesInvoiceHeader."GST Customer Type" = SalesInvoiceHeader."GST Customer Type"::Export) then begin
                                StateBuff.GET(SalesInvoiceHeader."GST Bill-to State Code");
                                Stcd := StateBuff."State Code (GST Reg. No.)";
                                POS := StateBuff."State Code (GST Reg. No.)"
                            END
                            ELSE begin
                                Stcd := '96';
                                POS := '96';
                                Pin := '999999';
                                Loc := 'Other Territory';
                            end;
                            if Contact.GET(SalesInvoiceHeader."Bill-to Contact No.") then begin
                                Ph := RemoveSpecialChar(COPYSTR(Contact."Phone No.", 1, 10));
                                Em := COPYSTR(Contact."E-Mail", 1, 50);
                            END
                            ELSE begin
                                Ph := '';
                                Em := '';
                            END;
                        END;
                    else begin
                        Stcd := '';
                        Ph := '';
                        Em := '';
                        POS := '';
                    END;
                end;
        END;
        CheckBuyerGSTIN(Gstin);
        if EnvironmentInformation.IsSandbox() then begin
            Pin := '248001';
            POS := '05';
            Stcd := 'UTTARAKHAND';
        end;
        WriteBuyerDtls(Gstin, TrdNm, Bno, Bnm, Flno, Loc, Dst, Pin, Stcd, Ph, Em, POS);
    end;

    local procedure WriteBuyerDtls(Gstin: Code[15]; TrdNm: Text[100]; Bno: Text[100]; Bnm: Text[100]; Flno: Text[60]; Loc: Text[60]; Dst: Text[60]; Pin: Code[20]; Stcd: Text; Ph: Text[10]; Em: Text[50]; POS: Text[2])
    var
        BuyerDtlsWriter: JsonObject;
    begin
        BuyerDtlsWriter.Add('gstin', Gstin);
        BuyerDtlsWriter.Add('legal_name', TrdNm);
        BuyerDtlsWriter.Add('trade_name', TrdNm);
        BuyerDtlsWriter.Add('address1', Bno);
        BuyerDtlsWriter.Add('address2', Bnm);
        BuyerDtlsWriter.Add('location', Loc);
        BuyerDtlsWriter.Add('place_of_supply', POS);
        BuyerDtlsWriter.Add('state_code', Stcd);
        BuyerDtlsWriter.Add('pincode', Pin);
        StringWriterJson.Add('buyer_details', BuyerDtlsWriter);
    end;

    Local procedure WriteBuyerTransDtls(Gstin: Code[15]; TrdNm: Text[100]; Bno: Text[100]; Bnm: Text[100]; Flno: Text[60]; Loc: Text[60]; Dst: Text[60]; Pin: Code[20]; Stcd: Text; Ph: Text[10]; Em: Text[50]; POS: Text[2]; LegName: Text)
    var
        BuyerDtlsWriter: JsonObject;
    begin
        BuyerDtlsWriter.Add('gstin', Gstin);
        BuyerDtlsWriter.Add('legal_name', LegName);
        BuyerDtlsWriter.Add('trade_name', TrdNm);
        BuyerDtlsWriter.Add('address1', Bno);
        BuyerDtlsWriter.Add('address2', Bnm);
        BuyerDtlsWriter.Add('location', Loc);
        BuyerDtlsWriter.Add('place_of_supply', POS);
        BuyerDtlsWriter.Add('state_code', Stcd);
        BuyerDtlsWriter.Add('pincode', Pin);
        StringWriterJson.Add('buyer_details', BuyerDtlsWriter);
    end;

    local procedure ReadShipDtls()
    var
        ShipToAddr: Record "Ship-to Address";
        StateBuff: Record State;
        Gstin: Code[15];
        TrdNm: Text[100];
        Bno: Text[100];
        Bnm: Text[100];
        Flno: Text[100];
        Loc: Text[100];
        Dst: Text[60];
        Pin: Code[10];
        Stcd: Text;
        Ph: Text[10];
        Em: Text[50];
    begin
        if IsInvoice AND (SalesInvoiceHeader."Ship-to Code" <> '') then begin
            ShipToAddr.GET(SalesInvoiceHeader."Sell-to Customer No.", SalesInvoiceHeader."Ship-to Code");
            IF SalesInvoiceHeader."GST Customer Type" = SalesInvoiceHeader."GST Customer Type"::Export THEN
                Gstin := 'URP'
            ELSE
                Gstin := ShipToAddr."GST Registration No.";
            TrdNm := SalesInvoiceHeader."Ship-to Name";
            Bno := SalesInvoiceHeader."Ship-to Address";
            Bnm := SalesInvoiceHeader."Ship-to Address 2";
            Loc := SalesInvoiceHeader."Ship-to City";
            if SalesInvoiceHeader."GST Customer Type" = SalesInvoiceHeader."GST Customer Type"::Export then begin
                Pin := '99999';
                Stcd := '96';
            end
            else begin
                StateBuff.Reset();
                StateBuff.Get(SalesInvoiceHeader."GST Ship-to State Code");
                Stcd := UpperCase(StateBuff.Description);
                Pin := SalesInvoiceHeader."Ship-to Post Code";
            end;
            StateBuff.GET(SalesInvoiceHeader."GST Ship-to State Code");
            Stcd := StateBuff."State Code (GST Reg. No.)";
            Ph := RemoveSpecialChar(COPYSTR(ShipToAddr."Phone No.", 1, 10));
            Em := COPYSTR(ShipToAddr."E-Mail", 1, 50);
            CheckUserGSTIN(Gstin);
            WriteShipDtls(Gstin, TrdNm, Bno, Bnm, Flno, Loc, Dst, Pin, Stcd, Ph, Em);
        END
        ELSE if SalesCrMemoHeader."Ship-to Code" <> '' then begin
            ShipToAddr.GET(SalesCrMemoHeader."Sell-to Customer No.", SalesCrMemoHeader."Ship-to Code");
            IF SalesCrMemoHeader."GST Customer Type" = SalesCrMemoHeader."GST Customer Type"::Export THEN
                Gstin := 'URP'
            ELSE
                Gstin := ShipToAddr."GST Registration No.";
            TrdNm := SalesCrMemoHeader."Ship-to Name";
            Bno := SalesCrMemoHeader."Ship-to Address";
            Bnm := SalesCrMemoHeader."Ship-to Address 2";
            Loc := SalesCrMemoHeader."Ship-to City";
            if SalesCrMemoHeader."GST Customer Type" = SalesCrMemoHeader."GST Customer Type"::Export then begin
                Pin := '99999';
                Stcd := '96';
            end
            else begin
                StateBuff.Reset();
                StateBuff.Get(SalesCrMemoHeader."GST Ship-to State Code");
                Stcd := UpperCase(StateBuff.Description);
                Pin := SalesCrMemoHeader."Ship-to Post Code";
            end;
            StateBuff.GET(SalesCrMemoHeader."GST Ship-to State Code");
            Stcd := StateBuff."State Code (GST Reg. No.)";
            Ph := RemoveSpecialChar(COPYSTR(ShipToAddr."Phone No.", 1, 10));
            Em := COPYSTR(ShipToAddr."E-Mail", 1, 50);
            WriteShipDtls(Gstin, TrdNm, Bno, Bnm, Flno, Loc, Dst, Pin, Stcd, Ph, Em);
        END;
    end;

    local procedure WriteShipDtls(Gstin: Code[15]; TrdNm: Text[100]; Bno: Text[100]; Bnm: Text[100]; Flno: Text[100]; Loc: Text[60]; Dst: Text[60]; Pin: Code[10]; Stcd: Text; Ph: Text[10]; Em: Text[50])
    var
        ShipDtlsWriter: JsonObject;
    begin
        ShipDtlsWriter.Add('gstin', Gstin);
        ShipDtlsWriter.Add('legal_name', TrdNm);
        ShipDtlsWriter.Add('trade_name', TrdNm);
        ShipDtlsWriter.Add('address1', Bno);
        ShipDtlsWriter.Add('address2', Bnm);
        ShipDtlsWriter.Add('location', Loc);
        ShipDtlsWriter.Add('pincode', Pin);
        ShipDtlsWriter.Add('state_code', Stcd);
        StringWriterJson.Add('ship_details', ShipDtlsWriter);
    end;

    local procedure ReadValDtls()
    var
        AssVal: Decimal;
        CgstVal: Decimal;
        SgstVal: Decimal;
        IgstVal: Decimal;
        CesVal: Decimal;
        StCesVal: Decimal;
        Disc: Decimal;
        OthChrg: Decimal;
        TotInvVal: Decimal;
        RndOffAmt: Decimal;
        TotiInvValFc: Decimal;
    begin
        GetGSTVal(AssVal, CgstVal, SgstVal, IgstVal, CesVal, StCesVal, Disc, OthChrg, TotInvVal, RndOffAmt, TotiInvValFc);
        WriteValDtls(AssVal, CgstVal, SgstVal, IgstVal, CesVal, StCesVal, Disc, OthChrg, TotInvVal, RndOffAmt, TotiInvValFc);
    end;

    local procedure WriteValDtls(Assval: Decimal; CgstVal: Decimal; SgstVAl: Decimal; IgstVal: Decimal; CesVal: Decimal; StCesVal: Decimal; Disc: Decimal; OthChrg: Decimal; TotInvVal: Decimal; RndOffAmt: Decimal; TotiInvValFc: Decimal)
    var
        ValDtlsWriter: JsonObject;
    begin
        ValDtlsWriter.Add('total_assessable_value', Assval);
        ValDtlsWriter.Add('total_cgst_value', CgstVal);
        ValDtlsWriter.Add('total_sgst_value', SgstVAl);
        ValDtlsWriter.Add('total_igst_value', IgstVal);
        ValDtlsWriter.Add('total_cess_value', CesVal);
        if OthChrg <> 0 then ValDtlsWriter.Add('total_other_charge', OthChrg);
        ValDtlsWriter.Add('total_invoice_value', TotInvVal);
        ValDtlsWriter.Add('round_off_amount', RndOffAmt);
        StringWriterJson.Add('value_details', ValDtlsWriter);
    end;

    local procedure WriteValTransDtls(Assval: Decimal; CgstVal: Decimal; SgstVAl: Decimal; IgstVal: Decimal; CesVal: Decimal; StCesVal: Decimal; Disc: Decimal; OthChrg: Decimal; TotInvVal: Decimal; RndOffAmt: Decimal; TotiInvValFc: Decimal)
    var
        ValDtlsWriter: JsonObject;
    begin
        ValDtlsWriter.Add('total_assessable_value', Assval);
        ValDtlsWriter.Add('total_cgst_value', CgstVal);
        ValDtlsWriter.Add('total_sgst_value', SgstVAl);
        ValDtlsWriter.Add('total_igst_value', IgstVal);
        ValDtlsWriter.Add('total_cess_value', CesVal);
        ValDtlsWriter.Add('total_invoice_value', TotInvVal);
        StringWriterJson.Add('value_details', ValDtlsWriter);
    end;

    local procedure ReadItemList()
    var
        SalesInvoiceLine: Record "Sales Invoice Line";
        SalesCrMemoLine: Record "Sales Cr.Memo Line";
        AssAmt: Decimal;
        CgstAmt: Decimal;
        SgstAmt: Decimal;
        IgstAmt: Decimal;
        CesRt: Decimal;
        CesAmt: Decimal;
        CesNonAdval: Decimal;
        StateCesRt: Decimal;
        StateCesAmt: Decimal;
        FreeQty: Decimal;
        StateCesNonAdvlAmt: Decimal;
        SlNo: Integer;
        UOM: Text[8];
        IsServc: Text[1];
        GSTRt: Decimal;
        TotalGSTAmount: Decimal;
        ItemListWtiter: JsonObject;
        OTHTxt: TextConst ENU = 'OTH', ENN = 'OTH';
        UnitOfMeasure: Record "Unit of Measure";
        ItemDes: Text;
        ItemDesc_GtextN: Text;
    begin
        Clear(SlNo);
        IF SalesInvoiceHeader."Currency Factor" <> 0 THEN
            CurrExRate := ROUND((1 / SalesInvoiceHeader."Currency Factor"), 0.01)
        ELSE
            CurrExRate := 1;
        IF SalesCrMemoHeader."Currency Factor" <> 0 THEN
            CurrExRate := ROUND((1 / SalesCrMemoHeader."Currency Factor"), 0.01)
        ELSE
            CurrExRate := 1;
        Clear(SlNo);
        Clear(AssAmt);
        if IsInvoice then begin
            SalesInvoiceLine.SETRANGE("Document No.", DocumentNo);
            SalesInvoiceLine.SetFilter("No.", '<>%1', '');
            SalesInvoiceLine.SetRange("Non-GST Line", false);
            SalesInvoiceLine.SetFilter("Unit Price", '<>%1', 0);
            SalesInvoiceLine.SetRange("System-Created Entry", false);
            SalesInvoiceLine.SetFilter(Quantity, '<>%1', 0);
            if SalesInvoiceLine.FINDSET() then begin
                // if SalesInvoiceLine.COUNT > 1000 then
                //   ERROR(SalesLinesErr, SalesInvoiceLine.COUNT);
                REPEAT
                    SlNo += 1;
                    AssAmt := SalesInvoiceLine.Amount;
                    ItemDes := DELCHR(SalesInvoiceLine.Description, '=', '®');
                    ItemDesc_GtextN := DELCHR(ItemDes, '=', '™');
                    //Free supply_SSD
                    //Charges to customer
                    FreeQty := 0;
                    GetGSTCompRate(SalesInvoiceLine."Document No.", SalesInvoiceLine."Line No.", GSTRt, CgstAmt, SgstAmt, IgstAmt, CesRt, CesAmt, CesNonAdval, StateCesRt, StateCesAmt, StateCesNonAdvlAmt);
                    if (SalesInvoiceLine."Unit of Measure Code" <> '') then
                        UOM := COPYSTR(SalesInvoiceLine."Unit of Measure Code", 1, 8)
                    ELSE
                        UOM := OTHTxt;
                    TotalGSTAmount := CgstAmt + SgstAmt + IgstAmt;
                    IF SalesInvoiceLine."GST Group Type" = SalesInvoiceLine."GST Group Type"::Service THEN
                        IsServc := 'Y'
                    ELSE
                        IsServc := 'N';
                    WriteItem(ItemDesc_GtextN, SalesInvoiceLine."HSN/SAC Code", SalesInvoiceLine.Quantity, FreeQty, UOM, Round(SalesInvoiceLine."Unit Price", 0.001, '='), SalesInvoiceLine."Line Amount", SalesInvoiceLine."Line Discount Amount" + SalesInvoiceLine."Inv. Discount Amount", SalesInvoiceLine.Amount, AssAmt, GSTRt, CgstAmt, SgstAmt, IgstAmt, CesRt, CesAmt, CesNonAdval, StateCesRt, StateCesAmt, StateCesNonAdvlAmt, 0, SalesInvoiceLine.Amount + TotalGSTAmount, SalesInvoiceLine."Line No.", SlNo, IsServc);
                UNTIL SalesInvoiceLine.NEXT() = 0;
            END;
            StringWriterJson.Add('item_list', JsonArrayData);
        END
        ELSE begin
            SalesCrMemoLine.SETRANGE("Document No.", DocumentNo);
            SalesCrMemoLine.SetFilter("No.", '<>%1', '');
            SalesCrMemoLine.SetRange("Non-GST Line", false);
            SalesCrMemoLine.SetFilter("Unit Price", '<>%1', 0);
            SalesCrMemoLine.SetRange("System-Created Entry", false);
            SalesCrMemoLine.SetFilter(Quantity, '<>%1', 0);
            if SalesCrMemoLine.FINDSET() then begin
                // if SalesInvoiceLine.COUNT > 1000 then
                //   ERROR(SalesLinesErr, SalesInvoiceLine.COUNT);
                REPEAT
                    SlNo += 1;
                    AssAmt := SalesCrMemoLine.Amount;
                    ItemDes := DELCHR(SalesCrMemoLine.Description, '=', '®');
                    ItemDesc_GtextN := DELCHR(ItemDes, '=', '™');
                    //Free supply_SSD
                    //Charges to customer
                    FreeQty := 0;
                    GetGSTCompRate(SalesCrMemoLine."Document No.", SalesCrMemoLine."Line No.", GSTRt, CgstAmt, SgstAmt, IgstAmt, CesRt, CesAmt, CesNonAdval, StateCesRt, StateCesAmt, StateCesNonAdvlAmt);
                    if (SalesCrMemoLine."Unit of Measure Code" <> '') then
                        UOM := COPYSTR(SalesCrMemoLine."Unit of Measure Code", 1, 8)
                    ELSE
                        UOM := OTHTxt;
                    TotalGSTAmount := CgstAmt + SgstAmt + IgstAmt;
                    IF SalesCrMemoLine."GST Group Type" = SalesCrMemoLine."GST Group Type"::Service THEN
                        IsServc := 'Y'
                    ELSE
                        IsServc := 'N';
                    WriteItem(ItemDesc_GtextN, SalesCrMemoLine."HSN/SAC Code", SalesCrMemoLine.Quantity, FreeQty, UOM, round(SalesCrMemoLine."Unit Price", 0.001, '='), SalesCrMemoLine."Line Amount", SalesCrMemoLine."Line Discount Amount" + SalesCrMemoLine."Inv. Discount Amount", SalesCrMemoLine.Amount, AssAmt, GSTRt, CgstAmt, SgstAmt, IgstAmt, CesRt, CesAmt, CesNonAdval, StateCesRt, StateCesAmt, StateCesNonAdvlAmt, 0, SalesCrMemoLine.Amount + TotalGSTAmount, SalesCrMemoLine."Line No.", SlNo, IsServc);
                UNTIL SalesCrMemoLine.NEXT() = 0;
                StringWriterJson.Add('item_list', JsonArrayData);
            END;
        end;
    end;

    local procedure WriteItem(PrdDesc: Text[100]; HsnCd: Text[8]; Qty: Decimal; FreeQty: Decimal; Unit: Text[8]; UnitPrice: Decimal; TotAmt: Decimal; Discount: Decimal; PreTaxVal: Decimal; AssAmt: Decimal; GstRt: Decimal; CgstAmt: Decimal; SgstAmt: Decimal; IgstAmt: Decimal; CesRt: Decimal; CesAmt: Decimal; CesNonAdval: Decimal; StateCes: Decimal; StateCesAmt: Decimal; StateCesNonAdvlAmt: Decimal; OthChrg: Decimal; TotItemVal: Decimal; SILineNo: Integer; SlNo: Integer; IsServc: Text[1])
    var
        ValueEntry: Record "Value Entry";
        ItemLedgerEntry: Record "Item Ledger Entry";
        ValueEntryRelation: Record "Value Entry Relation";
        ItemTrackingManagement: Codeunit "Item Tracking Management";
        InvoiceRowID: Text[250];
        ItemWriter: JsonObject;
    begin
        ItemWriter.Add('item_serial_number', SlNo);
        ItemWriter.Add('product_description', PrdDesc);
        ItemWriter.Add('is_service', IsServc);
        ItemWriter.Add('hsn_code', HsnCd);
        ItemWriter.Add('quantity', Qty);
        ItemWriter.Add('unit', Unit);
        ItemWriter.Add('unit_price', UnitPrice);
        ItemWriter.Add('total_amount', TotAmt);
        ItemWriter.Add('discount', Discount);
        ItemWriter.Add('assessable_value', AssAmt);
        ItemWriter.Add('gst_rate', GstRt);
        //ItemWriter.Add('PreTaxVal', PreTaxVal);
        ItemWriter.Add('cgst_amount', CgstAmt);
        ItemWriter.Add('sgst_amount', SgstAmt);
        ItemWriter.Add('igst_amount', IgstAmt);
        ItemWriter.Add('cess_rate', CesRt);
        ItemWriter.Add('cess_amount', CesAmt);
        ItemWriter.Add('total_item_value', TotItemVal);
        JsonArrayData.Add(ItemWriter);
    end;

    local procedure WriteItemTrans(PrdDesc: Text[100]; HsnCd: Text[8]; Qty: Decimal; FreeQty: Decimal; Unit: Text[8]; UnitPrice: Decimal; TotAmt: Decimal; Discount: Decimal; PreTaxVal: Decimal; AssAmt: Decimal; GstRt: Decimal; CgstAmt: Decimal; SgstAmt: Decimal; IgstAmt: Decimal; CesRt: Decimal; CesAmt: Decimal; CesNonAdval: Decimal; StateCes: Decimal; StateCesAmt: Decimal; StateCesNonAdvlAmt: Decimal; OthChrg: Decimal; TotItemVal: Decimal; SILineNo: Integer; SlNo: Integer; IsServc: Text[1])
    var
        ValueEntry: Record "Value Entry";
        ItemLedgerEntry: Record "Item Ledger Entry";
        ValueEntryRelation: Record "Value Entry Relation";
        ItemTrackingManagement: Codeunit "Item Tracking Management";
        InvoiceRowID: Text[250];
        ItemWriter: JsonObject;
    begin
        ItemWriter.Add('item_serial_number', SlNo);
        ItemWriter.Add('product_description', PrdDesc);
        ItemWriter.Add('is_service', IsServc);
        ItemWriter.Add('hsn_code', HsnCd);
        ItemWriter.Add('quantity', Qty);
        ItemWriter.Add('unit', Unit);
        ItemWriter.Add('unit_price', UnitPrice);
        ItemWriter.Add('total_amount', TotAmt);
        ItemWriter.Add('assessable_value', AssAmt);
        ItemWriter.Add('gst_rate', GstRt);
        ItemWriter.Add('cgst_amount', CgstAmt);
        ItemWriter.Add('sgst_amount', SgstAmt);
        ItemWriter.Add('igst_amount', IgstAmt);
        ItemWriter.Add('cess_rate', CesRt);
        ItemWriter.Add('cess_amount', CesAmt);
        ItemWriter.Add('cess_nonadvol_value', 0);
        ItemWriter.Add('total_item_value', TotItemVal);
        JsonArrayData.Add(ItemWriter);
    end;

    local procedure ReadEwbDtls()
    var
        ShippingAgent: Record "Shipping Agent";
        TptId: Text[15];
        TptName: Text[50];
        TransMode: Text[1];
        Distance: Integer;
        TptDocNo: Text[20];
        TptDocDate: Text[30];
        VehicleNo: Text[20];
        VehicleType: Text[1];
    begin
        if IsInvoice then begin
            SalesInvoiceHeader.TestField("Shipping Agent Code");
            SalesInvoiceHeader.TestField("Mode of Transport");
            SalesInvoiceHeader.TestField("Distance (Km)");
            SalesInvoiceHeader.TestField("LR/RR No.");
            SalesInvoiceHeader.TestField("LR/RR Date");
            SalesInvoiceHeader.TestField("Vehicle No.");
            SalesInvoiceHeader.TestField("Vehicle Type");
            if ShippingAgent.get(SalesInvoiceHeader."Shipping Agent Code") then;
            TptId := ShippingAgent."GST Registration No.";
            TptName := ShippingAgent.Name;
            TransMode := format(SalesInvoiceHeader."Mode of Transport");
            Distance := SalesInvoiceHeader."Distance (Km)";
            TptDocNo := SalesInvoiceHeader."LR/RR No.";
            TptDocDate := FORMAT(SalesInvoiceHeader."LR/RR Date", 0, '<Day,2>/<Month,2>/<Year4>');
            VehicleNo := SalesInvoiceHeader."Vehicle No.";
            CASE SalesInvoiceHeader."Vehicle Type" OF
                SalesInvoiceHeader."Vehicle Type"::ODC:
                    VehicleType := 'O';
                SalesInvoiceHeader."Vehicle Type"::Regular:
                    VehicleType := 'R';
            END;
            WriteEWBDtls(TptId, TptName, TransMode, Distance, TptDocNo, TptDocDate, VehicleNo, VehicleType);
        end;
    end;

    local procedure WriteEWBDtls(TptId: Text[15]; TptName: Text[50]; TransMode: Text[1]; Distance: Integer; TptDocNo: Text[20]; TptDocDate: Text[30]; VehicleNo: Text[20]; VehicleType: Text[1])
    var
        EwbDtlsWriter: JsonObject;
    begin
        IF TptId <> '' THEN EwbDtlsWriter.Add('TransId', TptId);
        EwbDtlsWriter.Add('TransName', TptName);
        EwbDtlsWriter.Add('TransMode', TransMode);
        EwbDtlsWriter.Add('Distance', Distance);
        EwbDtlsWriter.Add('TransDocDt', TptDocDate);
        EwbDtlsWriter.Add('TransDocNo', TptDocNo);
        EwbDtlsWriter.Add('VehNo', VehicleNo);
        EwbDtlsWriter.Add('VehType', VehicleType);
        StringWriterJson.Add('EwbDtls', EwbDtlsWriter);
    end;

    local procedure ExportAsJson(FileName: Text[20])
    var
        TempBlob: Codeunit "Temp Blob";
        TempFile: File;
        ToFile: Variant;
        InStream: InStream;
        OutStream: OutStream;
    begin
        SSDJsonObject.WriteTo(JsonText);
        TempBlob.CreateOutStream(OutStream);
        OutStream.WriteText(JsonText);
        ToFile := FileName + '.json';
        TempBlob.CreateInStream(InStream);
        DOWNLOADFROMSTREAM(InStream, 'e-Invoice', '', '', ToFile);
    end;

    procedure SetSalesInvHeader(SalesInvoiceHeaderBuff: Record "Sales Invoice Header"; EWBApplicaleBuff: Boolean)
    begin
        SalesInvoiceHeader := SalesInvoiceHeaderBuff;
        EWBApplicable := EWBApplicaleBuff;
        IsInvoice := true;
    end;

    procedure SetCrMemoHeader(SalesCrMemoHeaderBuff: Record "Sales Cr.Memo Header"; EWBApplicaleBuff: Boolean)
    begin
        SalesCrMemoHeader := SalesCrMemoHeaderBuff;
        EWBApplicable := EWBApplicaleBuff;
        IsInvoice := false;
    end;

    procedure SetTranShipmentHeader(TranShipmentHeaderBuff: Record "Transfer Shipment Header"; EWBApplicaleBuff: Boolean)
    begin
        TransferShipmentHeader := TranShipmentHeaderBuff;
        EWBApplicable := EWBApplicaleBuff;
        IsInvoice := false;
    end;

    local procedure GetRefInvNo(DocNo: Code[20]) RefInvNo: Code[20]
    var
        ReferenceInvoiceNo: Record "Reference Invoice No.";
    begin
        ReferenceInvoiceNo.SETRANGE("Document No.", DocNo);
        if ReferenceInvoiceNo.FINDFIRST() then
            RefInvNo := ReferenceInvoiceNo."Reference Invoice Nos."
        else
            RefInvNo := '';
    end;

    local procedure GetGSTCompRate(DocNo: Code[20]; LineNo: Integer; var GSTRt: Decimal; var CgstAmt: Decimal; var SgstAmt: Decimal; var IgstAmt: Decimal; var CesRt: Decimal; var CesAmt: Decimal; var CesNonAdval: Decimal; var StateCesRt: Decimal; var StateCesAmt: Decimal; var StateCesNonAdvlAmt: Decimal)
    var
        DetailedGSTLedgerEntry: Record "Detailed GST Ledger Entry";
    begin
        clear(GSTRt);
        clear(CgstAmt);
        clear(SgstAmt);
        clear(IgstAmt);
        DetailedGSTLedgerEntry.SETRANGE("Document No.", DocNo);
        DetailedGSTLedgerEntry.SETRANGE("Document Line No.", LineNo);
        DetailedGSTLedgerEntry.SETRANGE("GST Component Code", 'CGST');
        if DetailedGSTLedgerEntry.FINDFIRST() then begin
            GSTRt := DetailedGSTLedgerEntry."GST %";
            CgstAmt := ABS(DetailedGSTLedgerEntry."GST Amount");
        end;
        DetailedGSTLedgerEntry.SETRANGE("GST Component Code", 'SGST');
        if DetailedGSTLedgerEntry.FINDFIRST() then begin
            GSTRt += DetailedGSTLedgerEntry."GST %";
            SgstAmt := ABS(DetailedGSTLedgerEntry."GST Amount");
        end;
        DetailedGSTLedgerEntry.SETRANGE("GST Component Code", 'IGST');
        if DetailedGSTLedgerEntry.FINDFIRST() then begin
            GSTRt += DetailedGSTLedgerEntry."GST %";
            IgstAmt := ABS(DetailedGSTLedgerEntry."GST Amount");
        end;
        CesNonAdval := 0;
        CesAmt := 0;
        CLEAR(CesRt);
        DetailedGSTLedgerEntry.SETFILTER("GST Component Code", '%1|%2', 'CESS', 'INTERCESS');
        if DetailedGSTLedgerEntry.FINDFIRST then begin
            CesRt := DetailedGSTLedgerEntry."GST %";
            if DetailedGSTLedgerEntry."GST %" <> 0 then
                CesAmt := ABS(DetailedGSTLedgerEntry."GST Amount")
            else
                CesNonAdval := ABS(DetailedGSTLedgerEntry."GST Amount");
        end;
        StateCesRt := 0;
        StateCesAmt := 0;
        StateCesNonAdvlAmt := 0;
    end;

    local procedure GetGSTVal(var AssVal: Decimal; var CgstVal: Decimal; var SgstVal: Decimal; var IgstVal: Decimal; var CesVal: Decimal; var StCesVal: Decimal; var Disc: Decimal; var OthChrg: Decimal; var TotInvVal: Decimal; var RndOffAmt: Decimal; var TotiInvValFc: Decimal)
    var
        SalesInvoiceLine: Record "Sales Invoice Line";
        SalesCrMemoLine: Record "Sales Cr.Memo Line";
        GSTLedgerEntry: Record "GST Ledger Entry";
        DetailedGSTLedgerEntry: Record "Detailed GST Ledger Entry";
        CurrExchRate: Record "Currency Exchange Rate";
        CustLedgerEntry: Record "Cust. Ledger Entry";
        TotGSTAmt: Decimal;
        TotLineAmt: Decimal;
        GLSetup: Record "General Ledger Setup";
        OtherCharge: Decimal;
        TCSEntry: Record "TCS Entry";
        CustPostingGrp: Code[10];
        GstRoundingGL: Code[20];
        InvRoundingGL: Code[20];
        PITRoundingGL: Code[20];
    begin
        RndOffAmt := 0;
        TotiInvValFc := 0;
        GSTLedgerEntry.SETRANGE("Document No.", DocumentNo);
        GSTLedgerEntry.SETRANGE("GST Component Code", 'CGST');
        if GSTLedgerEntry.FINDSET() then
            repeat
                CgstVal += ABS(GSTLedgerEntry."GST Amount");
            until GSTLedgerEntry.NEXT() = 0
        else
            CgstVal := 0;
        GSTLedgerEntry.SETRANGE("GST Component Code", 'SGST');
        if GSTLedgerEntry.FINDSET() then
            repeat SgstVal += ABS(GSTLedgerEntry."GST Amount") until GSTLedgerEntry.NEXT() = 0
        else
            SgstVal := 0;
        GSTLedgerEntry.SETRANGE("GST Component Code", 'IGST');
        if GSTLedgerEntry.FINDSET() then
            repeat IgstVal += ABS(GSTLedgerEntry."GST Amount") until GSTLedgerEntry.NEXT() = 0
        else
            IgstVal := 0;
        CesVal := 0;
        GSTLedgerEntry.SETFILTER("GST Component Code", '%1|%2', 'CESS', 'INTERCESS');
        if GSTLedgerEntry.FINDSET then repeat CesVal += ABS(GSTLedgerEntry."GST Amount") until GSTLedgerEntry.NEXT = 0;
        OthChrg := 0;
        TCSEntry.SetRange("Document No.", DocumentNo);
        if TCSEntry.FindSet() then
            repeat
                OthChrg := TCSEntry."TCS Amount";
            until TCSEntry.Next() = 0;
        CLEAR(TotLineAmt);
        if IsInvoice then begin
            SalesInvoiceLine.SETRANGE("Document No.", DocumentNo);
            if SalesInvoiceLine.FINDSET then begin
                repeat
                    TotLineAmt += SalesInvoiceLine."Line Amount";
                    AssVal += SalesInvoiceLine.Amount;
                    Disc += SalesInvoiceLine."Line Discount Amount" + SalesInvoiceLine."Inv. Discount Amount";
                until SalesInvoiceLine.NEXT = 0;
            end;
            //SSD Sunil
            Clear(OthChrg);
            TCSEntry.Reset();
            TCSEntry.SetRange("Document No.", DocumentNo);
            if TCSEntry.FindSet() then
                repeat
                    OthChrg += TCSEntry."TCS Amount";
                until TCSEntry.Next() = 0;
            //SSD Sunil
            TotGSTAmt := CgstVal + SgstVal + IgstVal + CesVal + StCesVal;
            SalesInvoiceLine.SETRANGE(Type, SalesInvoiceLine.Type::"G/L Account");
            SalesInvoiceLine.SetRange("System-Created Entry", true);
            //SalesInvoiceLine.SETFILTER("No.", '%1|%2|%3', '2719', '9140', '9150');
            if SalesInvoiceLine.FINDFIRST then
                repeat
                    RndOffAmt += SalesInvoiceLine."Line Amount";
                until SalesInvoiceLine.NEXT = 0;
            TotiInvValFc := TotLineAmt + TotGSTAmt - Disc + OthChrg + RndOffAmt;
            TotLineAmt := ROUND(CurrExchRate.ExchangeAmtFCYToLCY(SalesInvoiceHeader."Posting Date", SalesInvoiceHeader."Currency Code", TotLineAmt, SalesInvoiceHeader."Currency Factor"), 0.01, '=');
            AssVal := ROUND(CurrExchRate.ExchangeAmtFCYToLCY(SalesInvoiceHeader."Posting Date", SalesInvoiceHeader."Currency Code", AssVal, SalesInvoiceHeader."Currency Factor"), 0.01, '=');
            TotGSTAmt := ROUND(CurrExchRate.ExchangeAmtFCYToLCY(SalesInvoiceHeader."Posting Date", SalesInvoiceHeader."Currency Code", TotGSTAmt, SalesInvoiceHeader."Currency Factor"), 0.01, '=');
            Disc := ROUND(CurrExchRate.ExchangeAmtFCYToLCY(SalesInvoiceHeader."Posting Date", SalesInvoiceHeader."Currency Code", Disc, SalesInvoiceHeader."Currency Factor"), 0.01, '=');
            TotInvVal := TotLineAmt + TotGSTAmt - Disc + RndOffAmt + OtherCharge;
        end
        else begin
            SalesCrMemoLine.SETRANGE("Document No.", DocumentNo);
            if SalesCrMemoLine.FINDSET then begin
                repeat
                    TotLineAmt += SalesCrMemoLine."Line Amount";
                    AssVal += SalesCrMemoLine.Amount;
                    Disc += SalesCrMemoLine."Inv. Discount Amount" + SalesCrMemoLine."Line Discount Amount";
                until SalesCrMemoLine.NEXT = 0;
            end;
            //SSD Sunil
            Clear(OthChrg);
            TCSEntry.Reset();
            TCSEntry.SetRange("Document No.", DocumentNo);
            if TCSEntry.FindSet() then
                repeat
                    OthChrg += TCSEntry."TCS Amount";
                until TCSEntry.Next() = 0;
            //SSD Sunil
            TotGSTAmt := CgstVal + SgstVal + IgstVal + CesVal + StCesVal;
            SalesCrMemoLine.SETRANGE(Type, SalesCrMemoLine.Type::"G/L Account");
            SalesCrMemoLine.SetRange("System-Created Entry", true);
            //SalesCrMemoLine.SETFILTER("No.", '%1|%2|%3', '2719', '9140', '9150');
            if SalesCrMemoLine.FINDFIRST then
                repeat
                    RndOffAmt += SalesCrMemoLine."Line Amount";
                until SalesCrMemoLine.NEXT = 0;
            TotInvVal := TotLineAmt + TotGSTAmt - Disc + RndOffAmt + OthChrg;
            TotLineAmt := ROUND(CurrExchRate.ExchangeAmtFCYToLCY(SalesCrMemoHeader."Posting Date", SalesCrMemoHeader."Currency Code", TotLineAmt, SalesCrMemoHeader."Currency Factor"), 0.01, '=');
            AssVal := ROUND(CurrExchRate.ExchangeAmtFCYToLCY(SalesCrMemoHeader."Posting Date", SalesCrMemoHeader."Currency Code", AssVal, SalesCrMemoHeader."Currency Factor"), 0.01, '=');
            TotGSTAmt := ROUND(CurrExchRate.ExchangeAmtFCYToLCY(SalesCrMemoHeader."Posting Date", SalesCrMemoHeader."Currency Code", TotGSTAmt, SalesCrMemoHeader."Currency Factor"), 0.01, '=');
            Disc := ROUND(CurrExchRate.ExchangeAmtFCYToLCY(SalesCrMemoHeader."Posting Date", SalesCrMemoHeader."Currency Code", Disc, SalesCrMemoHeader."Currency Factor"), 0.01, '=');
            TotInvVal := TotLineAmt + TotGSTAmt - Disc + OthChrg + RndOffAmt;
        end;
        //OthChrg := 0;
    end;

    local procedure GetGSTValForLine(DocumentLineNo: Integer; var CgstLineVal: Decimal; var SgstLineVal: Decimal; var IgstLineVal: Decimal)
    var
        SalesInvoiceLine: Record "Sales Invoice Line";
        SalesCrMemoLine: Record "Sales Cr.Memo Line";
        DetailedGSTLedgerEntry: Record "Detailed GST Ledger Entry";
    begin
        Clear(CgstLineVal);
        Clear(SgstLineVal);
        Clear(IgstLineVal);
        DetailedGSTLedgerEntry.SETRANGE("Document No.", DocumentNo);
        DetailedGSTLedgerEntry.SetRange("Document Line No.", DocumentLineNo);
        DetailedGSTLedgerEntry.SETRANGE("GST Component Code", 'CGST');
        if DetailedGSTLedgerEntry.FINDSET() then
            repeat
                CgstLineVal += ABS(DetailedGSTLedgerEntry."GST Amount");
            until DetailedGSTLedgerEntry.NEXT() = 0
        else
            CgstLineVal := 0;
        DetailedGSTLedgerEntry.SETRANGE("GST Component Code", 'SGST');
        if DetailedGSTLedgerEntry.FINDSET() then
            repeat SgstLineVal += ABS(DetailedGSTLedgerEntry."GST Amount") until DetailedGSTLedgerEntry.NEXT() = 0
        else
            SgstLineVal := 0;
        DetailedGSTLedgerEntry.SETRANGE("GST Component Code", 'IGST');
        if DetailedGSTLedgerEntry.FINDSET() then
            repeat IgstLineVal += ABS(DetailedGSTLedgerEntry."GST Amount") until DetailedGSTLedgerEntry.NEXT() = 0
        else
            IgstLineVal := 0;
    end;
    //Transfer Start >>
    procedure ExportTransferJsonTxt(var TransShipHeaderBuff: Record 5744; var EWBApplicableBuff: Boolean) JsonTxt: Text
    begin
        Initialize;
        TransferShipmentHeader.RESET;
        TransferShipmentHeader.COPY(TransShipHeaderBuff);
        EWBApplicable := EWBApplicableBuff;
        ExportTransferShipment;
        StringWriterJson.WriteTo(JsonTxt);
    end;

    local procedure ExportTransferShipment()
    begin
        CLEAR(CurrExRate);
        DocumentNo := TransferShipmentHeader."No.";
        CurrExRate := 1;
        DocumentNo := TransferShipmentHeader."No.";
        WriteFileHeader;
        Clear(JsonArrayData);
        WriteTrandferTransDtls('B2B', '', '', '', '', '', '', '');
        Clear(JsonArrayData);
        ReadTrfDocDtls;
        Clear(JsonArrayData);
        ReadTransferorDtls;
        Clear(JsonArrayData);
        ReadTransfereeDtls;
        Clear(JsonArrayData);
        ReadTransferValDtls;
        // WriteDispDtls;
        //ReadShipDtls;
        Clear(JsonArrayData);
        ReadTransferItemList;
        // WritePayDtls;
        // WriteRefDtls;
        //ReadExpDtls;
        // if EWBApplicable then
        //     ReadTransferEWBDtls;
        //JsonTextWriter.WriteEndArray;
    end;

    local procedure ReadTrfDocDtls()
    var
        Typ: Text[3];
        Dt: Text[10];
        OrgInvNo: Code[20];
    begin
        Typ := 'INV';
        Dt := FORMAT(TransferShipmentHeader."Posting Date", 0, '<Day,2>/<Month,2>/<Year4>');
        OrgInvNo := COPYSTR(GetRefInvNo(DocumentNo), 1, 16);
        WriteDocDtls(Typ, COPYSTR(DocumentNo, 1, 16), Dt, OrgInvNo);
    end;

    local procedure ReadTransferorDtls()
    var
        CompanyInformationBuff: Record 79;
        LocationBuff: Record 14;
        StateBuff: Record State;
        Gstin: Code[15];
        LglNm: Text[100];
        TrdNm: Text[100];
        Addr1: Text[100];
        Addr2: Text[100];
        Loc: Text[50];
        Pin: Code[20];
        Stcd: Text[50];
        Ph: Text[10];
        Em: Text[100];
        GLSetup: Record "General Ledger Setup";
    begin
        CLEAR(Loc);
        CLEAR(Pin);
        CLEAR(Stcd);
        CLEAR(Ph);
        CLEAR(Em);
        GLSetup.Get();
        with TransferShipmentHeader do begin
            CompanyInformationBuff.GET;
            LocationBuff.GET("Transfer-from Code");
            Gstin := GetGSTIN("Transfer-from Code");
            TrdNm := LocationBuff.Name;
            LglNm := CompanyInformationBuff.Name;
            Addr1 := LocationBuff.Address;
            Addr2 := LocationBuff."Address 2";
            Loc := LocationBuff.City;
            Pin := LocationBuff."Post Code";
            StateBuff.GET(LocationBuff."State Code");
            Stcd := GetStateCode(LocationBuff."State Code");
            Ph := COPYSTR(LocationBuff."Phone No.", 1, 10);
            Em := COPYSTR(LocationBuff."E-Mail", 1, 100);
        end;
        /*
        if GLSetup."Test Instance" then begin
            // Temp Values only for Sandbox. To be removed for Go-Live
            Gstin := '37AMBPG7773M002';
            Loc := 'VIJAYWADA';
            Pin := 502355;
            Stcd := '37';
            // Temp Values only for Sandbox. To be removed for Go-Live
        end;
*/
        WriteSellerDtls(Gstin, TrdNm, LglNm, Addr1, Addr2, '', '', Loc, Pin, Stcd, Ph, Em);
    end;

    local procedure ReadTransfereeDtls()
    var
        LocationBuff: Record 14;
        StateBuff: Record State;
        Gstin: Code[15];
        LglNm: Text[100];
        TrdNm: Text[100];
        POS: Text[2];
        Addr1: Text[100];
        Addr2: Text[100];
        Loc: Text[100];
        Pin: Code[20];
        Stcd: Text[50];
        Ph: Text[10];
        Em: Text[100];
        CompanyInformation: Record "Company Information";
    begin
        CLEAR(POS);
        CLEAR(Stcd);
        CLEAR(Ph);
        CLEAR(Em);
        with TransferShipmentHeader do begin
            CompanyInformation.get();
            LocationBuff.GET("Transfer-to Code");
            Gstin := GetGSTIN("Transfer-to Code");
            LglNm := CompanyInformation.Name;
            TrdNm := LocationBuff.Name;
            Addr1 := LocationBuff.Address;
            Addr2 := LocationBuff."Address 2";
            Loc := LocationBuff.City;
            Pin := LocationBuff."Post Code";
            StateBuff.RESET;
            StateBuff.GET(LocationBuff."State Code");
            POS := FORMAT(StateBuff."State Code (GST Reg. No.)");
            Stcd := GetStateCode(LocationBuff."State Code");
            Ph := COPYSTR(LocationBuff."Phone No.", 1, 10);
            Em := COPYSTR(LocationBuff."E-Mail", 1, 100);
        end;
        WriteBuyerTransDtls(Gstin, TrdNm, Addr1, Addr2, '', '', Loc, Pin, Stcd, Ph, Em, POS, LglNm);
    end;

    local procedure ReadTransferItemList()
    var
        TransShipmentLine: Record "Transfer Shipment Line";
        AssAmt: Decimal;
        CgstAmt: Decimal;
        SgstAmt: Decimal;
        IgstAmt: Decimal;
        CesRt: Decimal;
        CesAmt: Decimal;
        CesNonAdval: Decimal;
        StateCesRt: Decimal;
        StateCesAmt: Decimal;
        FreeQty: Decimal;
        StateCesNonAdvlAmt: Decimal;
        SlNo: Integer;
        UOM: Text[8];
        IsServc: Text[1];
        GSTRt: Decimal;
        GSTAmt: Decimal;
    begin
        CLEAR(SlNo);
        Clear(GSTAmt);
        Clear(CgstAmt);
        Clear(SgstAmt);
        Clear(IgstAmt);
        TransShipmentLine.SETRANGE("Document No.", DocumentNo);
        TransShipmentLine.SETFILTER("Item No.", '<>%1', '');
        TransShipmentLine.SETFILTER(Quantity, '<>%1', 0);
        if TransShipmentLine.FINDSET then begin
            if TransShipmentLine.COUNT > 100 then ERROR(SalesLinesErr, TransShipmentLine.COUNT);
            // JsonTextWriter.WritePropertyName('ItemList');
            // JsonTextWriter.WriteStartArray;
            repeat
                SlNo += 1;
                AssAmt := TransShipmentLine.Amount;
                FreeQty := 0;
                GetGSTCompRate(TransShipmentLine."Document No.", TransShipmentLine."Line No.", GSTRt, CgstAmt, SgstAmt, IgstAmt, CesRt, CesAmt, CesNonAdval, StateCesRt, StateCesAmt, StateCesNonAdvlAmt);
                CLEAR(UOM);
                UOM := COPYSTR(TransShipmentLine."Unit of Measure Code", 1, 8);
                IsServc := 'N';
                Clear(GSTAmt);
                ReturnGSTAmount(TransShipmentLine."Document No.", TransShipmentLine."Line No.", GSTAmt);
                WriteItemTrans(DELCHR(TransShipmentLine.Description, '=', '®'), TransShipmentLine."HSN/SAC Code", TransShipmentLine.Quantity, FreeQty, UOM, Round(TransShipmentLine."Unit Price", 0.01, '='), TransShipmentLine.Amount, 0, TransShipmentLine.Amount, AssAmt, GSTRt, CgstAmt, SgstAmt, IgstAmt, CesRt, CesAmt, CesNonAdval, StateCesRt, StateCesAmt, StateCesNonAdvlAmt, 0, AssAmt + GSTAmt, TransShipmentLine."Line No.", SlNo, IsServc);
            until TransShipmentLine.NEXT = 0;
            //JsonTextWriter.WriteEndArray;
            StringWriterJson.Add('ItemList', JsonArrayData);
        end;
    end;

    local procedure ReadTransferValDtls()
    var
        AssVal: Decimal;
        CgstVal: Decimal;
        SgstVal: Decimal;
        IgstVal: Decimal;
        CesVal: Decimal;
        StCesVal: Decimal;
        Disc: Decimal;
        OthChrg: Decimal;
        TotInvVal: Decimal;
        RndOffAmt: Decimal;
        TotiInvValFc: Decimal;
    begin
        GetTransferGSTVal(AssVal, CgstVal, SgstVal, IgstVal, CesVal, StCesVal, Disc, OthChrg, TotInvVal, RndOffAmt, TotiInvValFc);
        WriteValTransDtls(AssVal, CgstVal, SgstVal, IgstVal, CesVal, StCesVal, Disc, OthChrg, TotInvVal, RndOffAmt, TotiInvValFc);
    end;

    local procedure GetTransferGSTVal(var AssVal: Decimal; var CgstVal: Decimal; var SgstVal: Decimal; var IgstVal: Decimal; var CesVal: Decimal; var StCesVal: Decimal; var Disc: Decimal; var OthChrg: Decimal; var TotInvVal: Decimal; var RndOffAmt: Decimal; var TotiInvValFc: Decimal)
    var
        TransferShipmentLine: Record "Transfer Shipment Line";
        GSTLedgerEntry: Record "GST Ledger Entry";
        CurrExchRate: Record 330;
        TotGSTAmt: Decimal;
        TotLineAmt: Decimal;
    begin
        RndOffAmt := 0;
        TotiInvValFc := 0;
        GSTLedgerEntry.SETRANGE("Document No.", DocumentNo);
        GSTLedgerEntry.SETRANGE("Transaction Type", GSTLedgerEntry."Transaction Type"::Sales);
        GSTLedgerEntry.SETRANGE("Posting Date", TransferShipmentHeader."Posting Date");
        GSTLedgerEntry.SETRANGE("Document Type", GSTLedgerEntry."Document Type"::Invoice);
        GSTLedgerEntry.SETRANGE("GST Component Code", 'CGST');
        if GSTLedgerEntry.FINDSET then begin
            repeat
                CgstVal += ABS(GSTLedgerEntry."GST Amount");
            until GSTLedgerEntry.NEXT = 0;
        end
        else
            CgstVal := 0;
        GSTLedgerEntry.SETRANGE("Document No.", DocumentNo);
        GSTLedgerEntry.SETRANGE("Transaction Type", GSTLedgerEntry."Transaction Type"::Sales);
        GSTLedgerEntry.SETRANGE("Posting Date", TransferShipmentHeader."Posting Date");
        GSTLedgerEntry.SETRANGE("Document Type", GSTLedgerEntry."Document Type"::Invoice);
        GSTLedgerEntry.SETRANGE("GST Component Code", 'SGST');
        if GSTLedgerEntry.FINDSET then begin
            repeat SgstVal += ABS(GSTLedgerEntry."GST Amount") until GSTLedgerEntry.NEXT = 0;
        end
        else
            SgstVal := 0;
        GSTLedgerEntry.SETRANGE("Document No.", DocumentNo);
        GSTLedgerEntry.SETRANGE("Transaction Type", GSTLedgerEntry."Transaction Type"::Sales);
        GSTLedgerEntry.SETRANGE("Posting Date", TransferShipmentHeader."Posting Date");
        GSTLedgerEntry.SETRANGE("Document Type", GSTLedgerEntry."Document Type"::Invoice);
        GSTLedgerEntry.SETRANGE("GST Component Code", 'IGST');
        if GSTLedgerEntry.FINDSET then begin
            repeat IgstVal += ABS(GSTLedgerEntry."GST Amount") until GSTLedgerEntry.NEXT = 0;
        end
        else
            IgstVal := 0;
        CesVal := 0;
        GSTLedgerEntry.SETRANGE("Document No.", DocumentNo);
        GSTLedgerEntry.SETRANGE("Transaction Type", GSTLedgerEntry."Transaction Type"::Sales);
        GSTLedgerEntry.SETRANGE("Posting Date", TransferShipmentHeader."Posting Date");
        GSTLedgerEntry.SETRANGE("Document Type", GSTLedgerEntry."Document Type"::Invoice);
        GSTLedgerEntry.SETFILTER("GST Component Code", '%1|%2', 'CESS', 'INTERCESS');
        if GSTLedgerEntry.FINDSET then repeat CesVal += ABS(GSTLedgerEntry."GST Amount") until GSTLedgerEntry.NEXT = 0;
        CLEAR(TotLineAmt);
        Clear(AssVal);
        Clear(TotInvVal);
        Clear(TotiInvValFc);
        Clear(TotGSTAmt);
        TransferShipmentLine.SETRANGE("Document No.", DocumentNo);
        if TransferShipmentLine.FINDSET then begin
            repeat
                TotLineAmt += TransferShipmentLine.Amount;
                AssVal += TransferShipmentLine.Amount;
                ReturnGSTAmount(TransferShipmentLine."Document No.", TransferShipmentLine."Line No.", TotGSTAmt);
                Disc += 0;
                RndOffAmt += 0;
            until TransferShipmentLine.NEXT = 0;
        end;
        TotiInvValFc := TotLineAmt + TotGSTAmt - Disc;
        TotInvVal := TotLineAmt + TotGSTAmt - Disc;
        OthChrg := 0;
    end;

    local procedure ReadTransferEWBDtls()
    var
        ShippingAgent: Record 291;
        TptId: Text[15];
        TptName: Text[50];
        TransMode: Text[1];
        Distance: Integer;
        TptDocNo: Text[20];
        TptDocDate: Text[30];
        VehicleNo: Text[20];
        VehicleType: Text[1];
    begin
        with TransferShipmentHeader do begin
            if "Shipping Agent Code" <> '' then TESTFIELD("Shipping Agent Code");
            IF "Mode of Transport" <> '' THEN TESTFIELD("Mode of Transport");
            TESTFIELD("Distance (Km)");
            IF "LR/RR No." <> '' THEN TESTFIELD("LR/RR No.");
            TESTFIELD("LR/RR Date");
            TESTFIELD("Vehicle No.");
            TESTFIELD("Vehicle Type");
            IF "Shipping Agent Code" <> '' THEN BEGIN
                ShippingAgent.GET("Shipping Agent Code");
                ShippingAgent.TESTFIELD("GST Registration No.");
                TptId := ShippingAgent."GST Registration No.";
                TptName := ShippingAgent.Name;
            END
            ELSE BEGIN
                TptName := 'LOCAL';
            END;
            TransMode := "Mode of Transport";
            Distance := "Distance (Km)";
            TptDocNo := "LR/RR No.";
            TptDocDate := FORMAT("LR/RR Date", 0, '<Day,2>/<Month,2>/<Year4>');
            VehicleNo := "Vehicle No.";
            case "Vehicle Type" of
                "Vehicle Type"::ODC:
                    VehicleType := 'O';
                "Vehicle Type"::Regular:
                    VehicleType := 'R';
            end;
        end;
        WriteEWBDtls(TptId, TptName, TransMode, Distance, TptDocNo, TptDocDate, VehicleNo, VehicleType);
    end;

    local procedure ReturnGSTBaseAmount(DocumentNo: Code[20]; LineNo: Integer; var GSTBaseAmount: Decimal)
    var
        GSTLedger: Record "Detailed GST Ledger Entry";
    begin
        GSTLedger.Reset();
        GSTLedger.SetRange("Document No.", DocumentNo);
        if LineNo <> 0 then GSTLedger.SetRange("Document Line No.", LineNo);
        if GSTLedger.FindLast() then GSTBaseAmount := abs(GSTLedger."GST Base Amount");
    end;

    local procedure ReturnGSTAmount(DocumentNo: Code[20]; LineNo: Integer; var GSTAmount: Decimal)
    var
        GSTLedger: Record "Detailed GST Ledger Entry";
    begin
        GSTLedger.Reset();
        GSTLedger.SetRange("Document No.", DocumentNo);
        if LineNo <> 0 then GSTLedger.SetRange("Document Line No.", LineNo);
        if GSTLedger.FindSet() then begin
            repeat
                GSTAmount += abs(GSTLedger."GST Amount");
            until GSTLedger.Next() = 0;
        end;
    end;

    local procedure GetChargesAmt(DocNo: Code[20]; LineNo1: Integer)
    var
        DetailedGSTLedgerEntry: Record "Detailed GST Ledger Entry";
        SalesInvoiceLine2: Record "Sales Invoice Line";
        SalesCrMemoLine2: Record "Sales Cr.Memo Line";
    begin
        clear(ChargeAmt);
        Clear(ChargeGSTAmt);
        // if SalesInvoiceLine.Type <> SalesInvoiceLine.Type::Item then
        //     exit;
        SalesInvoiceLine2.SetRange("Document No.", DocNo);
        SalesInvoiceLine2.SetFilter("Line No.", '>%1', LineNo1);
        SalesInvoiceLine2.SetRange(Type, SalesInvoiceLine2.Type::"Charge (Item)");
        if SalesInvoiceLine2.FindSet() then
            repeat
                if ChargeAmt = 0 then begin
                    ChargeAmt := SalesInvoiceLine2.Amount;
                    DetailedGSTLedgerEntry.Reset();
                    DetailedGSTLedgerEntry.SetRange("Document No.", SalesInvoiceLine2."Document No.");
                    DetailedGSTLedgerEntry.SetRange("Document Line No.", SalesInvoiceLine2."Line No.");
                    if DetailedGSTLedgerEntry.FindSet() then
                        repeat
                            ChargeGSTAmt += DetailedGSTLedgerEntry."GST Amount";
                        until DetailedGSTLedgerEntry.Next() = 0;
                end;
            until SalesInvoiceLine2.Next = 0;
        SalesCrMemoLine2.SetRange("Document No.", DocNo);
        SalesCrMemoLine2.SetFilter("Line No.", '>%1', LineNo1);
        SalesCrMemoLine2.SetRange(Type, SalesCrMemoLine2.Type::"Charge (Item)");
        if SalesCrMemoLine2.FindSet() then
            repeat
                if ChargeAmt = 0 then begin
                    ChargeAmt := SalesCrMemoLine2.Amount;
                    DetailedGSTLedgerEntry.Reset();
                    DetailedGSTLedgerEntry.SetRange("Document No.", SalesCrMemoLine2."Document No.");
                    DetailedGSTLedgerEntry.SetRange("Document Line No.", SalesCrMemoLine2."Line No.");
                    if DetailedGSTLedgerEntry.FindSet() then
                        repeat
                            ChargeGSTAmt += DetailedGSTLedgerEntry."GST Amount";
                        until DetailedGSTLedgerEntry.Next() = 0;
                end;
            until SalesCrMemoLine2.Next = 0;
    end;

    local procedure ReadReferenceDocDtls()
    var
        Typ: Text[3];
        Dt: Text[10];
        OrgInvNo: Code[20];
        RefDocNo: code[20];
        PosDate: Text;
    begin
        IF (SalesInvoiceHeader."Invoice Type" = SalesInvoiceHeader."Invoice Type"::"Debit Note") OR (SalesInvoiceHeader."Invoice Type" = SalesInvoiceHeader."Invoice Type"::Supplementary) THEN BEGIN
            RefDocNo := GetRefInvNo(SalesInvoiceHeader."No.");
            IF RefDocNo = '' THEN RefDocNo := SalesInvoiceHeader."Reference Invoice No.";
            IF SalesInvoiceHeader.GET(RefDocNo) THEN BEGIN
                PosDate := GetDateFormated(SalesInvoiceHeader."Posting Date");
                WriteReferenceDtls(RefDocNo, PosDate);
            END;
        END;
    end;

    local procedure WriteReferenceDtls(ReferenceNo: Code[20]; PosD: Text)
    var
        RefDtlsWriter: JsonObject;
    begin
        if SalesInvoiceHeader.get(ReferenceNo) then begin
            RefDtlsWriter.Add('invoice_remarks', 'Sales Invoice');
            RefDtlsWriter.Add('invoice_period_start_date', PosD);
            RefDtlsWriter.Add('invoice_period_end_date', PosD);
            RefDtlsWriter.Add('rdocument_period_details', RefDtlsWriter);
            RefDtlsWriter.Add('reference_details', RefDtlsWriter);
            RefDtlsWriter.Add('reference_of_original_invoice', ReferenceNo);
            RefDtlsWriter.Add('preceding_invoice_date', PosD);
            StringWriterJson.Add('preceding_document_details', RefDtlsWriter);
        end;
    end;

    local procedure RemoveSpecialChar(TxtDoc: Text): Text
    begin
        EXIT(DELCHR(TxtDoc, '=', './,-\!@#$%^&*()+ '));
    end;

    local procedure GetGSTIN(LocCode: Code[20]): Code[20]
    var
        Location: Record Location;
        CompanyInformation: Record "Company Information";
    begin
        if Location.Get(LocCode) then begin
            Location.TestField("GST Registration No.");
            exit(Location."GST Registration No.");
        end;
        CompanyInformation.Get;
        exit(CompanyInformation."GST Registration No.");
    end;

    local procedure GetStateCode(StateCode: Code[20]): Text
    var
        StateL: Record State;
    begin
        if StateL.Get(StateCode) then exit(UpperCase(StateL.Description));
        exit('');
    end;

    local procedure GetStateCode_POS(StateCode: Code[20]): Text
    var
        StateL: Record State;
    begin
        if StateL.Get(StateCode) then exit(UpperCase(StateL."State Code (GST Reg. No.)"));
        exit('');
    end;

    local procedure GetDateFormated(Originaldate: Date): Text
    var
        Day: Text[2];
        mnth: Text[2];
    begin
        if Originaldate <> 0D then begin
            if Date2dmy(Originaldate, 2) > 9 then
                mnth := Format(Date2dmy(Originaldate, 2))
            else
                mnth := '0' + Format(Date2dmy(Originaldate, 2));
            if Date2dmy(Originaldate, 1) > 9 then
                Day := Format(Date2dmy(Originaldate, 1))
            else
                Day := '0' + Format(Date2dmy(Originaldate, 1));
            exit(Day + '/' + mnth + '/' + Format(Date2dmy(Originaldate, 3)));
        end;
    end;

    local procedure CheckUserGSTIN(var UserGSTIN: Code[15])
    begin
        IF EnvironmentInformation.IsSandbox() then UserGSTIN := '09AAAPG7885R002';
    end;

    local procedure CheckLocation(var InCity: Text[60])
    begin
        if EnvironmentInformation.IsSandbox() then InCity := 'Noida';
    end;

    local procedure CheckPinCode(var InPinCode: Code[10])
    begin
        if EnvironmentInformation.IsSandbox() then InPinCode := '201306';
    end;

    local procedure CheckStateCode(var InStateCode: Code[2])
    begin
        if EnvironmentInformation.IsSandbox() then InStateCode := '09';
    end;

    local procedure CheckStateName(var InStateName: Text)
    begin
        if EnvironmentInformation.IsSandbox() then InStateName := 'UTTAR PRADESH';
    end;

    local procedure CheckBuyerGSTIN(var BuyerGSTIN: Code[15])
    begin
        IF EnvironmentInformation.IsSandbox() then BuyerGSTIN := '05AAAPG7885R002';
    end;
}
