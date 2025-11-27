codeunit 50036 "SSD EWB"
{
    Permissions = TableData "Sales Invoice Header"=rimd,
        TableData "Sales Cr.Memo Header"=rimd;

    trigger OnRun()
    begin
    end;
    var SalesInvoiceHeader: Record "Sales Invoice Header";
    SalesCrMemoHeader: Record "Sales Cr.Memo Header";
    PurchCrMemoHeader: Record "Purch. Cr. Memo Hdr.";
    TransShipHeader: Record "Transfer Shipment Header";
    JsonArrayData: JsonArray;
    FileManagement: Codeunit "File Management";
    // StringBuilder: DotNet StringBuilder;
    // StringWriter: DotNet StringWriter;
    // JsonTextWriter: DotNet JsonTextWriter;
    // JsonFormatting: DotNet Formatting;
    GlobalNULL: Variant;
    GNull: JsonValue;
    UnRegCustErr: Label 'E-Invoicing is not applicable for Unregistered, Export and Deemed Export Customers.';
    SalesLinesErr: Label 'E-Invoice allowes only 100 lines per Invoice. Curent transaction is having %1 lines.', Comment = '%1 = Sales Lines count';
    DocumentNo: Text[20];
    OTHTxt: Label 'OTH';
    AckNoTxt: Label 'AckNo';
    AckDtTxt: Label 'AckDt';
    IrnTxt: Label 'Irn';
    SelectFileTxt: Label 'Select Json Response File.';
    SignedQRCodeTxt: Label 'SignedQRCode';
    POSForExportTxt: Label '96';
    FileFilterTxt: Label '*.JSON|*.json';
    ImportedMsg: Label 'Total %1 files out of %2 files has been imported.', Comment = '%1 = Imported files, %2 = Total no. of files';
    SelectMultipleFilesTxt: Label 'Select muliple files';
    TempDateTime: DateTime;
    IRNHashErr: Label 'No matched IRN Hash %1 found to update.', Comment = '%1 = IRN Hash value';
    CurrExRate: Decimal;
    EWBType: Option Sales, Purchase, Transfer, SalesReturn, SalesIRN;
    StringWriter: JsonObject;
    JsonText: Text;
    procedure ExportJsonTxt()JsonTxt: Text begin
        Initialize;
        ExportInvoice;
        StringWriter.WriteTo(JsonText);
        JsonTxt:=JsonText;
    //JsonTxt := StringBuilder.ToString;
    end;
    local procedure Initialize()
    begin
        // StringBuilder := StringBuilder.StringBuilder;
        // StringWriter := StringWriter.StringWriter(StringBuilder);
        // JsonTextWriter := JsonTextWriter.JsonTextWriter(StringWriter);
        //JsonTextWriter.Formatting := JsonFormatting.Indented;
        Clear(StringWriter);
        Clear(JsonArrayData);
        Clear(JsonText);
        CLEAR(GlobalNULL);
    end;
    local procedure ExportInvoice()
    begin
        CLEAR(CurrExRate);
        IF EWBType = EWBType::Sales THEN BEGIN
            //IF SalesInvoiceHeader.FINDSET THEN BEGIN
            // REPEAT
            IF SalesInvoiceHeader."Currency Factor" <> 0 THEN CurrExRate:=1 / SalesInvoiceHeader."Currency Factor"
            ELSE
                CurrExRate:=1;
            DocumentNo:=SalesInvoiceHeader."No.";
            ReadEwayDocDtls;
            ReadSellerDtls;
            ReadBuyerDtls;
            ReadValDtls;
            ReadEWBDtls;
            ReadItemList;
        //JsonTextWriter.WriteEndObject;
        // UNTIL SalesInvoiceHeader.NEXT = 0;
        //JsonTextWriter.Flush;
        // END;
        END;
        IF EWBType = EWBType::SalesReturn THEN BEGIN
            IF SalesCrMemoHeader."Currency Factor" <> 0 THEN CurrExRate:=1 / SalesCrMemoHeader."Currency Factor"
            ELSE
                CurrExRate:=1;
            DocumentNo:=SalesCrMemoHeader."No.";
            ReadEwayDocDtls;
            ReadSellerDtls;
            ReadBuyerDtls;
            ReadValDtls;
            ReadEWBDtls;
            ReadItemList;
        END;
        IF EWBType = EWBType::Purchase THEN BEGIN
            IF PurchCrMemoHeader.FINDSET THEN BEGIN
                REPEAT IF PurchCrMemoHeader."Currency Factor" <> 0 THEN CurrExRate:=1 / PurchCrMemoHeader."Currency Factor"
                    ELSE
                        CurrExRate:=1;
                    DocumentNo:=PurchCrMemoHeader."No.";
                    ReadEwayDocDtls;
                    ReadSellerDtls;
                    ReadBuyerDtls;
                    ReadValDtls;
                    ReadEWBDtls;
                    ReadItemList;
                //JsonTextWriter.WriteEndObject;
                UNTIL PurchCrMemoHeader.NEXT = 0;
            //JsonTextWriter.Flush;
            END;
        END;
        IF EWBType = EWBType::Transfer THEN BEGIN
            CurrExRate:=1;
            DocumentNo:=TransShipHeader."No.";
            ReadEwayDocDtls;
            ReadSellerDtls;
            ReadBuyerDtls;
            ReadValDtls;
            ReadEWBDtls;
            ReadItemList;
        END;
        IF EWBType = EWBType::SalesIRN THEN BEGIN
            IF SalesInvoiceHeader.FINDSET THEN BEGIN
                REPEAT IF SalesInvoiceHeader."Currency Factor" <> 0 THEN CurrExRate:=1 / SalesInvoiceHeader."Currency Factor"
                    ELSE
                        CurrExRate:=1;
                    DocumentNo:=SalesInvoiceHeader."No.";
                //JsonTextWriter.WriteStartObject;
                //ReadEWBIRNDtls;
                //JsonTextWriter.WriteEndObject;
                UNTIL SalesInvoiceHeader.NEXT = 0;
            //JsonTextWriter.Flush;
            END;
        END;
    end;
    procedure SetSalesInvHeader(var SalesInvoiceHeaderBuff: Record "Sales Invoice Header"; EWBTypeBuff: Option Sales, Purchase, Transfer, SalesReturn)
    begin
        SalesInvoiceHeader.RESET;
        SalesInvoiceHeader.COPY(SalesInvoiceHeaderBuff);
        EWBType:=EWBTypeBuff;
    end;
    procedure SetSalesCrMemoHeader(var SalesCrMemoBuff: Record "Sales Cr.Memo Header"; EWBTypeBuff: Option Sales, Purchase, Transfer, SalesReturn)
    begin
        SalesCrMemoHeader.RESET;
        SalesCrMemoHeader.COPY(SalesCrMemoBuff);
        EWBType:=EWBTypeBuff;
    end;
    procedure SetPurchCrMemoHeader(var PurchCrMemoHeaderBuff: Record "Purch. Cr. Memo Hdr."; EWBTypeBuff: Option Sales, Purchase, Transfer, SalesReturn)
    begin
        PurchCrMemoHeader.RESET;
        PurchCrMemoHeader.COPY(PurchCrMemoHeaderBuff);
        EWBType:=EWBTypeBuff;
    end;
    procedure SetTransShipHeader(var TransShipHeaderBuff: Record "Transfer Shipment Header"; EWBTypeBuff: Option Sales, Purchase, Transfer, SalesReturn)
    begin
        TransShipHeader.RESET;
        TransShipHeader.COPY(TransShipHeaderBuff);
        EWBType:=EWBTypeBuff;
    end;
    local procedure ReadEwayDocDtls()
    var
        SuppType: Text;
        SubSupplyType: Text;
        SubSupplyDesc: Text;
        DocType: Text;
        DocNo: Text;
        DocDate: Text;
        CommpanyInfo: Record "Company Information";
        TransportMethod: Record "Transport Method";
        ShippingAgent: Record "Shipping Agent";
        Location: Record Location;
        TknNo: Text[50];
        GSTIN: Code[15];
    begin
        CASE EWBType OF EWBType::Sales: BEGIN
            CommpanyInfo.get();
            //TknNo := GetAccessToken;
            if TransportMethod.Get(SalesInvoiceHeader."Transport Method")then;
            if ShippingAgent.Get(SalesInvoiceHeader."Shipping Agent Code")then;
            if Location.Get(SalesInvoiceHeader."Location Code")then;
            SalesInvoiceHeader.TESTFIELD("Transportation Distance");
            SalesInvoiceHeader.TESTFIELD("E-Way Generated", FALSE);
            SalesInvoiceHeader.TESTFIELD("E-Way Bill No.", '');
            TknNo:='';
            SuppType:='outward';
            GSTIN:=GetGSTIN(SalesInvoiceHeader."Location Code");
            if SalesInvoiceHeader."Invoice Type" = SalesInvoiceHeader."invoice type"::Taxable then SubSupplyType:='Supply'
            else if SalesInvoiceHeader."Invoice Type" = SalesInvoiceHeader."invoice type"::Export then SubSupplyType:='Export';
            SubSupplyDesc:='';
            DocType:='tax invoice';
            DocNo:=SalesInvoiceHeader."No.";
            DocDate:=GetDateFormatedN(SalesInvoiceHeader."Posting Date");
        END;
        EWBType::SalesReturn: BEGIN
            SuppType:='I';
            SubSupplyType:='7';
            SubSupplyDesc:='Sales Return';
            DocType:='CHL';
            DocNo:=SalesCrMemoHeader."No.";
            DocDate:=FORMAT(SalesCrMemoHeader."Posting Date", 0, '<Day,2>/<Month,2>/<Year4>');
        END;
        EWBType::Purchase: BEGIN
            SuppType:='O';
            SubSupplyType:='8';
            SubSupplyDesc:='Credit Note';
            DocType:='CNT';
            DocNo:=PurchCrMemoHeader."No.";
            DocDate:=FORMAT(PurchCrMemoHeader."Posting Date", 0, '<Day,2>/<Month,2>/<Year4>');
        END;
        EWBType::Transfer: BEGIN
            SuppType:='O';
            SubSupplyType:='1';
            SubSupplyDesc:='Supply';
            DocType:='INV';
            DocNo:=TransShipHeader."No.";
            DocDate:=FORMAT(TransShipHeader."Posting Date", 0, '<Day,2>/<Month,2>/<Year4>');
        END;
        END;
        WriteEwayDocDtls(SuppType, SubSupplyType, SubSupplyDesc, DocType, DocNo, DocDate, GSTIN, TknNo);
    end;
    local procedure WriteEwayDocDtls(SuppType: Text; SubSupplyType: Text; SubSupplyDesc: Text; DocType: Text; DocNo: Text; DocDate: Text; GSTIN: Code[15]; TknNo: Text[50])
    var
        DocDtlsWriter: JsonObject;
    begin
        StringWriter.Add('access_token', TknNo);
        StringWriter.Add('userGstin', GSTIN);
        StringWriter.Add('supply_type', SuppType);
        StringWriter.Add('sub_supply_type', SubSupplyType);
        StringWriter.Add('sub_supply_description', SubSupplyDesc);
        StringWriter.Add('document_type', DocType);
        StringWriter.Add('document_number', DocNo);
        StringWriter.Add('document_date', DocDate);
        JsonArrayData.Add(StringWriter);
    //StringWriter.Add('DocDtls', DocDtlsWriter); //Group
    // JsonTextWriter.WriteStartObject;
    // JsonTextWriter.WritePropertyName('supplyType');
    // JsonTextWriter.WriteValue(SuppType);
    // JsonTextWriter.WritePropertyName('subSupplyType');
    // JsonTextWriter.WriteValue(SubSupplyType);
    // JsonTextWriter.WritePropertyName('subSupplyDesc');
    // JsonTextWriter.WriteValue(SubSupplyDesc);
    // JsonTextWriter.WritePropertyName('docType');
    // JsonTextWriter.WriteValue(DocType);
    // JsonTextWriter.WritePropertyName('docNo');
    // JsonTextWriter.WriteValue(DocNo);
    // JsonTextWriter.WritePropertyName('docDate');
    // JsonTextWriter.WriteValue(DocDate);
    end;
    local procedure ReadSellerDtls()
    var
        CompanyInformationBuff: Record "Company Information";
        LocationBuff: Record Location;
        StateBuff: Record State;
        ShipToAddr: Record "Ship-to Address";
        Gstin: Text[15];
        TrdNm: Text[100];
        Addr1: Text[100];
        Addr2: Text[100];
        Loc: Text[50];
        Pin: Code[20];
        Stcd: Text[50];
        LegalName: Text;
        ActualState: Code[20];
    begin
        CLEAR(Loc);
        CLEAR(Pin);
        CLEAR(Stcd);
        CASE EWBType OF EWBType::Sales: BEGIN
            WITH SalesInvoiceHeader DO BEGIN
                LocationBuff.GET("Location Code");
                if LocationBuff."Temp JW Location" then begin
                    Gstin:=GetGSTIN(SalesInvoiceHeader."Location Code");
                    CompanyInformationBuff.GET;
                    TrdNm:=CompanyInformationBuff.Name;
                    Addr1:=LocationBuff.Address;
                    Addr2:=LocationBuff."Address 2";
                    Loc:=LocationBuff.City;
                    Pin:=LocationBuff."Post Code";
                    Stcd:=GetStateCodeN(LocationBuff."State Code");
                    ActualState:=GetStateCodeN(LocationBuff."Temp State Code");
                end
                else
                begin
                    Gstin:=GetGSTIN(SalesInvoiceHeader."Location Code");
                    CompanyInformationBuff.GET;
                    TrdNm:=LocationBuff.Name;
                    Addr1:=LocationBuff.Address;
                    Addr2:=LocationBuff."Address 2";
                    Loc:=LocationBuff.City;
                    Pin:=LocationBuff."Post Code";
                    Stcd:=GetStateCodeN(LocationBuff."State Code");
                    ActualState:=GetStateCodeN(LocationBuff."State Code");
                end;
            END;
        END;
        EWBType::SalesReturn: BEGIN
            WITH SalesCrMemoHeader DO BEGIN
                IF "GST Customer Type" = "GST Customer Type"::Unregistered THEN Gstin:='URP'
                ELSE
                    Gstin:="Customer GST Reg. No.";
                TrdNm:="Bill-to Name";
                StateBuff.RESET;
                StateBuff.GET("GST Bill-to State Code");
                Stcd:=StateBuff."State Code (GST Reg. No.)";
                IF "Ship-to Code" <> '' THEN BEGIN
                    ShipToAddr.GET("Sell-to Customer No.", "Ship-to Code");
                    Addr1:=ShipToAddr.Address;
                    Addr2:=ShipToAddr."Address 2";
                    Loc:=ShipToAddr.City;
                    IF "GST Customer Type" <> "GST Customer Type"::Export THEN EVALUATE(Pin, COPYSTR("Bill-to Post Code", 1, 6));
                    StateBuff.RESET;
                    StateBuff.GET(ShipToAddr.State);
                    Stcd:=StateBuff."State Code (GST Reg. No.)";
                END
                ELSE
                BEGIN
                    Addr1:="Bill-to Address";
                    Addr2:="Bill-to Address 2";
                    Loc:="Bill-to City";
                    IF "GST Customer Type" <> "GST Customer Type"::Export THEN EVALUATE(Pin, COPYSTR("Bill-to Post Code", 1, 6));
                    StateBuff.RESET;
                    StateBuff.GET("GST Bill-to State Code");
                    Stcd:=StateBuff."State Code (GST Reg. No.)";
                END;
            END;
        END;
        EWBType::Purchase: BEGIN
            WITH PurchCrMemoHeader DO BEGIN
                TESTFIELD("Location GST Reg. No.");
                Gstin:="Location GST Reg. No.";
                CompanyInformationBuff.GET;
                TrdNm:=CompanyInformationBuff.Name;
                LocationBuff.GET("Location Code");
                Addr1:=LocationBuff.Address;
                Addr2:=LocationBuff."Address 2";
                Loc:=LocationBuff.City;
                EVALUATE(Pin, COPYSTR(LocationBuff."Post Code", 1, 6));
                StateBuff.GET(LocationBuff."State Code");
                Stcd:=StateBuff."State Code (GST Reg. No.)";
            END;
        END;
        EWBType::Transfer: BEGIN
            WITH TransShipHeader DO BEGIN
                LocationBuff.GET("Transfer-from Code");
                LocationBuff.TESTFIELD("GST Registration No.");
                Gstin:=LocationBuff."GST Registration No.";
                CompanyInformationBuff.GET;
                TrdNm:=CompanyInformationBuff.Name;
                Addr1:=LocationBuff.Address;
                Addr2:=LocationBuff."Address 2";
                Loc:=LocationBuff.City;
                EVALUATE(Pin, COPYSTR(LocationBuff."Post Code", 1, 6));
                StateBuff.GET(LocationBuff."State Code");
                Stcd:=StateBuff."State Code (GST Reg. No.)";
            END;
        END;
        END;
        // Temp Values only for Sandbox. To be removed for Go-Live
        IF EWBType = EWBType::SalesReturn THEN BEGIN
            Gstin:='05AAACG2140A1ZL';
        END
        ELSE
        BEGIN
            Gstin:='05AAACG2314E1ZD';
            Loc:='Dehradun';
            Pin:='248001';
            Stcd:='05';
        END;
        // Temp Values only for Sandbox. To be removed for Go-Live
        WriteSellerDtls(Gstin, TrdNm, Addr1, Addr2, Loc, Pin, Stcd, ActualState);
    end;
    local procedure WriteSellerDtls(Gstin: Text[15]; TrdNm: Text[100]; Addr1: Text[100]; Addr2: Text[100]; Loc: Text[50]; Pin: Code[20]; Stcd: Text[50]; ActState: code[20])
    var
        SellerDtlsWriter: JsonObject;
    begin
        StringWriter.Add('gstin_of_consignor', Gstin);
        StringWriter.Add('legal_name_of_consignor', TrdNm);
        StringWriter.Add('address1_of_consignor', Addr1);
        StringWriter.Add('address2_of_consignor', Addr2);
        StringWriter.Add('place_of_consignor', Loc);
        StringWriter.Add('pincode_of_consignor', Pin);
        StringWriter.Add('state_of_consignor', Stcd);
        StringWriter.Add('actual_from_state_name', ActState);
        JsonArrayData.Add(StringWriter);
    //StringWriter.Add('SellerDtls', SellerDtlsWriter)
    end;
    local procedure ReadBuyerDtls()
    var
        CompanyInformationBuff: Record "Company Information";
        Contact: Record Contact;
        SalesInvoiceLine: Record "Sales Invoice Line";
        SalesCrMemoLine: Record "Sales Cr.Memo Line";
        ShipToAddr: Record "Ship-to Address";
        StateBuff: Record State;
        Gstin: Text[15];
        TrdNm: Text[100];
        POS: Text[2];
        Addr1: Text[100];
        Addr2: Text[100];
        Loc: Text[100];
        Pin: Code[20];
        Stcd: Text[50];
        TranType: Integer;
        ShipToStcd: Text;
        ShipToGstin: Text;
        ShipToTrdNm: Text;
        OrderAddress: Record "Order Address";
        Vend: Record Vendor;
        LocationBuff: Record Location;
        Customer: Record Customer;
        State_Gst: Code[2];
        ActualToState: Code[10];
        StateOfSupply: Text[50];
    begin
        CASE EWBType OF EWBType::Sales: BEGIN
            WITH SalesInvoiceHeader DO BEGIN
                if ShipToAddr.GET("Bill-to Customer No.", "Ship-to Code")then begin
                    TranType:=4;
                    Gstin:="Ship-to GST Reg. No.";
                end
                else if Customer.Get(SalesInvoiceHeader."Bill-to Customer No.")then begin
                        Gstin:=Customer."GST Registration No.";
                        TranType:=3;
                    end;
                State_Gst:='';
                State_Gst:=CopyStr(Gstin, 1, 2);
                StateBuff.SetRange("State Code (GST Reg. No.)", State_Gst);
                if StateBuff.FindFirst()then StateOfSupply:=StateBuff.Description;
                TrdNm:="Ship-to Name";
                Addr1:="Ship-to Address";
                Addr2:="Ship-to Address 2";
                Loc:="Ship-to City";
                Pin:="Ship-to Post Code";
                if SalesInvoiceHeader."Invoice Type" = SalesInvoiceHeader."invoice type"::Taxable then Stcd:=StateBuff.Description //GetStateCodeN(SalesInvoiceHeader.State)); // Alle "Invoice Type"::Taxable
                else if SalesInvoiceHeader."Invoice Type" = SalesInvoiceHeader."invoice type"::Export then Stcd:='Other Country';
                ActualToState:=GetStateCodeN(SalesInvoiceHeader.State);
            END;
        END;
        EWBType::SalesReturn: BEGIN
            WITH SalesCrMemoHeader DO BEGIN
                TESTFIELD("Location GST Reg. No.");
                Gstin:="Location GST Reg. No.";
                CompanyInformationBuff.GET;
                TrdNm:=CompanyInformationBuff.Name;
                LocationBuff.GET("Location Code");
                Addr1:=LocationBuff.Address;
                Addr2:=LocationBuff."Address 2";
                LocationBuff.GET("Location Code");
                Loc:=LocationBuff.City;
                EVALUATE(Pin, COPYSTR(LocationBuff."Post Code", 1, 6));
                StateBuff.GET(LocationBuff."State Code");
                Stcd:=StateBuff."State Code (GST Reg. No.)";
                ShipToStcd:=Stcd;
                ShipToGstin:=Gstin;
                ShipToTrdNm:=TrdNm;
                TranType:=1;
            END;
        END;
        EWBType::Purchase: BEGIN
            WITH PurchCrMemoHeader DO BEGIN
                IF "GST Vendor Type" = "GST Vendor Type"::Unregistered THEN Gstin:='URP'
                ELSE
                    Gstin:="Vendor GST Reg. No.";
                Vend.Get(PurchCrMemoHeader."Buy-from Vendor No."); //BMS1.0
                StateBuff.RESET;
                StateBuff.GET(Vend."State Code"); //BMS1.0
                Stcd:=StateBuff."State Code (GST Reg. No.)";
                IF "Order Address Code" <> '' THEN BEGIN
                    OrderAddress.GET("Buy-from Vendor No.", "Order Address Code");
                    TrdNm:=OrderAddress.Name;
                    Addr1:=OrderAddress.Address;
                    Addr2:=OrderAddress."Address 2";
                    Loc:=OrderAddress.City;
                    EVALUATE(Pin, COPYSTR(OrderAddress."Post Code", 1, 6));
                    StateBuff.RESET;
                    StateBuff.GET(OrderAddress.State);
                    ShipToStcd:=StateBuff."State Code (GST Reg. No.)";
                    TranType:=2;
                    ShipToGstin:=OrderAddress."GST Registration No.";
                    ShipToTrdNm:=OrderAddress.Name;
                END
                ELSE
                BEGIN
                    TrdNm:="Buy-from Vendor Name";
                    Addr1:="Buy-from Address";
                    Addr2:="Buy-from Address 2";
                    Loc:="Buy-from City";
                    EVALUATE(Pin, COPYSTR("Buy-from Post Code", 1, 6));
                    ShipToStcd:=Stcd;
                    TranType:=1;
                    ShipToGstin:=Gstin;
                    ShipToTrdNm:="Buy-from Vendor Name";
                END;
            END;
        END;
        EWBType::Transfer: BEGIN
            WITH TransShipHeader DO BEGIN
                LocationBuff.GET("Transfer-to Code");
                Gstin:=LocationBuff."GST Registration No.";
                TrdNm:=LocationBuff.Name;
                Addr1:=LocationBuff.Address;
                Addr2:=LocationBuff."Address 2";
                Loc:=LocationBuff.City;
                EVALUATE(Pin, COPYSTR(LocationBuff."Post Code", 1, 6));
                StateBuff.RESET;
                StateBuff.GET(LocationBuff."State Code");
                Stcd:=StateBuff."State Code (GST Reg. No.)";
                ShipToStcd:=Stcd;
                TranType:=1;
                ShipToGstin:=Gstin;
                ShipToTrdNm:=TrdNm;
            END;
        END;
        END;
        // Temp Values only for Sandbox. To be removed for Go-Live
        IF EWBType <> EWBType::SalesReturn THEN Gstin:='05AAACG2140A1ZL'
        ELSE
        BEGIN
            Gstin:='05AAACG2314E1ZD';
            Loc:='Dehradun';
            Pin:='248001';
            Stcd:='05';
            ShipToStcd:='05';
            ShipToGstin:=Gstin;
        END;
        // Temp Values only for Sandbox. To be removed for Go-Live
        WriteBuyerDtls(Gstin, TrdNm, POS, Addr1, Addr2, Loc, Pin, Stcd, ShipToStcd, TranType, ShipToGstin, ShipToTrdNm, ActualToState, StateOfSupply);
    end;
    local procedure WriteBuyerDtls(Gstin: Text[15]; Trdm: Text[100]; POS: Text[2]; Addr1: Text[100]; Addr2: Text[100]; Loc: Text[100]; Pin: Code[20]; Stcd: Text[50]; ShipToStcd: Text; TranType: Integer; ShipToGstin: Text; ShipToTrdNm: Text; ActState: Code[20]; StateOfSupply: Text[50])
    var
        BuyerDtlsWriter: JsonObject;
    begin
        StringWriter.Add('transaction_type', TranType);
        StringWriter.Add('gstin_of_consignee', TranType);
        StringWriter.Add('legal_name_of_consignee', Trdm);
        StringWriter.Add('address1_of_consignee', Addr1);
        StringWriter.Add('address2_of_consignee', Addr2);
        StringWriter.Add('place_of_consignee', Loc);
        StringWriter.Add('pincode_of_consignee', Pin);
        StringWriter.Add('state_of_supply', Stcd);
        StringWriter.Add('actual_to_state_name', ActState);
        JsonArrayData.Add(StringWriter);
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
        WriteValDtls(AssVal, CgstVal, SgstVal, IgstVal, CesVal, StCesVal, TotInvVal, RndOffAmt, TotiInvValFc);
    end;
    local procedure WriteValDtls(Assval: Decimal; CgstVal: Decimal; SgstVAl: Decimal; IgstVal: Decimal; CesVal: Decimal; StCesVal: Decimal; TotInvVal: Decimal; RndOffAmt: Decimal; TotiInvValFc: Decimal)
    var
        ValDtlsWriter: JsonObject;
    begin
        // IF Assval <> 0 THEN
        //     ValDtlsWriter.Add('Assval', Assval)
        // ELSE
        //     ValDtlsWriter.Add('Assval', GNull.AsToken());
        // if CgstVal <> 0 then
        //     ValDtlsWriter.Add('CgstVal', CgstVal)
        // else
        //     ValDtlsWriter.Add('CgstVal', GNull.AsToken());
        // if SgstVAl <> 0 then
        //     ValDtlsWriter.Add('SgstVAl', SgstVAl)
        // else
        //     ValDtlsWriter.Add('SgstVAl', GNull.AsToken());
        // if IgstVal <> 0 then
        //     ValDtlsWriter.Add('IgstVal', IgstVal)
        // else
        //     ValDtlsWriter.Add('IgstVal', GNull.AsToken());
        // if CesVal <> 0 then
        //     ValDtlsWriter.Add('CesVal', CesVal)
        // else
        //     ValDtlsWriter.Add('CesVal', GNull.AsToken());
        // if StCesVal <> 0 then
        //     ValDtlsWriter.Add('StCesVal', StCesVal)
        // else
        //     ValDtlsWriter.Add('StCesVal', GNull.AsToken());
        // if RndOffAmt <> 0 then
        //     ValDtlsWriter.Add('RndOffAmt', RndOffAmt)
        // else
        //     ValDtlsWriter.Add('RndOffAmt', GNull.AsToken());
        StringWriter.Add('total_invoice_value', TotInvVal);
        StringWriter.Add('taxable_amount', Assval);
        StringWriter.Add('cgst_amount', CgstVal);
        StringWriter.Add('sgst_amount', SgstVAl);
        StringWriter.Add('igst_amount', IgstVal);
        StringWriter.Add('cess_amount', CesVal);
        JsonArrayData.Add(StringWriter);
    //StringWriter.Add('ValDtls', ValDtlsWriter);
    end;
    local procedure ReadItemList()
    var
        SalesInvoiceLine: Record "Sales Invoice Line";
        SalesCrMemoLine: Record "Sales Cr.Memo Line";
        PurchCrMemoLine: Record "Purch. Cr. Memo Line";
        TransShipmentLine: Record "Transfer Shipment Line";
        GSTLedger: Record "GST Ledger Entry";
        AssAmt: Decimal;
        CgstRt: Decimal;
        SgstRt: Decimal;
        IgstRt: Decimal;
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
        CASE EWBType OF EWBType::Sales: BEGIN
            SalesInvoiceLine.SETRANGE("Document No.", DocumentNo);
            SalesInvoiceLine.SetFilter("No.", '<>%1', '');
            SalesInvoiceLine.SetRange(Type, SalesInvoiceLine.Type::Item);
            SalesInvoiceLine.SETRANGE("Non-GST Line", FALSE);
            IF SalesInvoiceLine.FINDSET THEN BEGIN
                // IF SalesInvoiceLine.COUNT > 100 THEN
                //     ERROR(SalesLinesErr, SalesInvoiceLine.COUNT);
                // JsonTextWriter.WritePropertyName('itemList');
                // JsonTextWriter.WriteStartArray;
                REPEAT //SlNo += 1; //Not user In ZAV
                    IF SalesInvoiceLine."GST On Assessable Value" THEN AssAmt:=SalesInvoiceLine."GST Assessable Value (LCY)"
                    ELSE
                        ReturnGSTBaseAmount(SalesInvoiceLine."Document No.", SalesInvoiceLine."Line No.", AssAmt); //SalesInvoiceLine."GST Base Amount"; //BMS1.0
                    /*    //BMS1.0
                            IF SalesInvoiceLine."Free Supply" THEN
                                FreeQty := SalesInvoiceLine.Quantity
                            ELSE
                                FreeQty := 0;
                            */
                    GetGSTCompRate(SalesInvoiceLine."Document No.", SalesInvoiceLine."Line No.", GSTRt, CgstRt, SgstRt, IgstRt, CesRt, CesAmt, CesNonAdval, StateCesRt, StateCesAmt, StateCesNonAdvlAmt);
                    CLEAR(UOM);
                    IF SalesInvoiceLine."Unit of Measure Code" <> '' THEN UOM:=COPYSTR(SalesInvoiceLine."Unit of Measure Code", 1, 8)
                    ELSE
                        UOM:=OTHTxt;
                    IF SalesInvoiceLine."GST Group Type" = SalesInvoiceLine."GST Group Type"::Service THEN IsServc:='Y'
                    ELSE
                        IsServc:='N';
                    ReturnGSTAmount(SalesInvoiceLine."Document No.", SalesInvoiceLine."Line No.", GSTAmt); //BMS1.0
                    WriteItem(SalesInvoiceLine.Description + SalesInvoiceLine."Description 2", SalesInvoiceLine."HSN/SAC Code", SalesInvoiceLine.Quantity, FreeQty, UOM, SalesInvoiceLine."Unit Price", SalesInvoiceLine."Line Amount" + SalesInvoiceLine."Line Discount Amount", SalesInvoiceLine."Line Discount Amount", SalesInvoiceLine."Line Amount", AssAmt, GSTRt, CgstRt, SgstRt, IgstRt, CesRt, CesAmt, CesNonAdval, StateCesRt, StateCesAmt, StateCesNonAdvlAmt, 0, AssAmt + GSTAmt, //BMS1.0
 SalesInvoiceLine."Line No.", SlNo, IsServc);
                UNTIL SalesInvoiceLine.NEXT = 0;
            //JsonTextWriter.WriteEndArray;
            END;
        END;
        EWBType::SalesReturn: BEGIN
            SalesCrMemoLine.SETRANGE("Document No.", DocumentNo);
            SalesCrMemoLine.SetFilter("No.", '<>%1', '');
            SalesCrMemoLine.SETRANGE("Non-GST Line", FALSE);
            IF SalesCrMemoLine.FINDSET THEN BEGIN
                IF SalesCrMemoLine.COUNT > 100 THEN ERROR(SalesLinesErr, SalesCrMemoLine.COUNT);
                // JsonTextWriter.WritePropertyName('itemList');
                // JsonTextWriter.WriteStartArray;
                REPEAT SlNo+=1;
                    IF SalesCrMemoLine."GST On Assessable Value" THEN AssAmt:=SalesCrMemoLine."GST Assessable Value (LCY)"
                    ELSE
                        ReturnGSTBaseAmount(SalesCrMemoLine."Document No.", SalesCrMemoLine."Line No.", AssAmt); //BMS1.0
                    /*
                            IF SalesCrMemoLine."Free Supply" THEN
                                FreeQty := SalesCrMemoLine.Quantity
                            ELSE
                                FreeQty := 0;
                            */
                    //BMS1.0
                    GetGSTCompRate(SalesCrMemoLine."Document No.", SalesCrMemoLine."Line No.", GSTRt, CgstRt, SgstRt, IgstRt, CesRt, CesAmt, CesNonAdval, StateCesRt, StateCesAmt, StateCesNonAdvlAmt);
                    CLEAR(UOM);
                    IF SalesCrMemoLine."Unit of Measure Code" <> '' THEN UOM:=COPYSTR(SalesCrMemoLine."Unit of Measure Code", 1, 8)
                    ELSE
                        UOM:=OTHTxt;
                    IF SalesCrMemoLine."GST Group Type" = SalesCrMemoLine."GST Group Type"::Service THEN IsServc:='Y'
                    ELSE
                        IsServc:='N';
                    ReturnGSTAmount(SalesInvoiceLine."Document No.", SalesInvoiceLine."Line No.", GSTAmt); //BMS1.0
                    WriteItem(SalesCrMemoLine.Description + SalesCrMemoLine."Description 2", SalesCrMemoLine."HSN/SAC Code", SalesCrMemoLine.Quantity, FreeQty, UOM, SalesCrMemoLine."Unit Price", SalesCrMemoLine."Line Amount" + SalesCrMemoLine."Line Discount Amount", SalesCrMemoLine."Line Discount Amount", SalesCrMemoLine."Line Amount", AssAmt, GSTRt, CgstRt, SgstRt, IgstRt, CesRt, CesAmt, CesNonAdval, StateCesRt, StateCesAmt, StateCesNonAdvlAmt, 0, AssAmt + GSTAmt, //BMS1.0
 SalesCrMemoLine."Line No.", SlNo, IsServc);
                UNTIL SalesCrMemoLine.NEXT = 0;
            //JsonTextWriter.WriteEndArray;
            END;
        END;
        EWBType::Purchase: BEGIN
            PurchCrMemoLine.SETRANGE("Document No.", DocumentNo);
            PurchCrMemoLine.SetFilter("No.", '<>%1', '');
            PurchCrMemoLine.SETRANGE("Non-GST Line", FALSE);
            IF PurchCrMemoLine.FINDSET THEN BEGIN
                IF PurchCrMemoLine.COUNT > 100 THEN ERROR(SalesLinesErr, PurchCrMemoLine.COUNT);
                // JsonTextWriter.WritePropertyName('itemList');
                // JsonTextWriter.WriteStartArray;
                REPEAT SlNo+=1;
                    //AssAmt := PurchCrMemoLine."GST Base Amount";
                    ReturnGSTBaseAmount(PurchCrMemoLine."Document No.", PurchCrMemoLine."Line No.", AssAmt); //BMS1.0
                    FreeQty:=0;
                    GetGSTCompRate(PurchCrMemoLine."Document No.", PurchCrMemoLine."Line No.", GSTRt, CgstRt, SgstRt, IgstRt, CesRt, CesAmt, CesNonAdval, StateCesRt, StateCesAmt, StateCesNonAdvlAmt);
                    CLEAR(UOM);
                    IF PurchCrMemoLine."Unit of Measure Code" <> '' THEN UOM:=COPYSTR(PurchCrMemoLine."Unit of Measure Code", 1, 8)
                    ELSE
                        UOM:=OTHTxt;
                    IF PurchCrMemoLine."GST Group Type" = PurchCrMemoLine."GST Group Type"::Service THEN IsServc:='Y'
                    ELSE
                        IsServc:='N';
                    ReturnGSTAmount(SalesInvoiceLine."Document No.", SalesInvoiceLine."Line No.", GSTAmt); //BMS1.0
                    WriteItem(PurchCrMemoLine.Description + PurchCrMemoLine."Description 2", PurchCrMemoLine."HSN/SAC Code", PurchCrMemoLine.Quantity, FreeQty, UOM, PurchCrMemoLine."Unit Cost", PurchCrMemoLine."Line Amount" + PurchCrMemoLine."Line Discount Amount", PurchCrMemoLine."Line Discount Amount", PurchCrMemoLine."Line Amount", AssAmt, GSTRt, CgstRt, SgstRt, IgstRt, CesRt, CesAmt, CesNonAdval, StateCesRt, StateCesAmt, StateCesNonAdvlAmt, 0, AssAmt + GSTAmt, PurchCrMemoLine."Line No.", SlNo, IsServc);
                UNTIL PurchCrMemoLine.NEXT = 0;
            //JsonTextWriter.WriteEndArray;
            END;
        END;
        EWBType::Transfer: BEGIN
            TransShipmentLine.SETRANGE("Document No.", DocumentNo);
            TransShipmentLine.SetFilter("Item No.", '<>%1', '');
            IF TransShipmentLine.FINDSET THEN BEGIN
                IF TransShipmentLine.COUNT > 100 THEN ERROR(SalesLinesErr, TransShipmentLine.COUNT);
                // JsonTextWriter.WritePropertyName('itemList');
                // JsonTextWriter.WriteStartArray;
                REPEAT SlNo+=1;
                    //AssAmt := TransShipmentLine."GST Base Amount";//BMS1.0
                    ReturnGSTBaseAmount(TransShipmentLine."Document No.", TransShipmentLine."Line No.", AssAmt); //BMS1.0
                    FreeQty:=0;
                    GetGSTCompRate(TransShipmentLine."Document No.", TransShipmentLine."Line No.", GSTRt, CgstRt, SgstRt, IgstRt, CesRt, CesAmt, CesNonAdval, StateCesRt, StateCesAmt, StateCesNonAdvlAmt);
                    CLEAR(UOM);
                    IF TransShipmentLine."Unit of Measure Code" <> '' THEN UOM:=COPYSTR(TransShipmentLine."Unit of Measure Code", 1, 8)
                    ELSE
                        UOM:=OTHTxt;
                    IsServc:='N';
                    ReturnGSTAmount(SalesInvoiceLine."Document No.", SalesInvoiceLine."Line No.", GSTAmt); //BMS1.0
                    WriteItem(TransShipmentLine.Description + TransShipmentLine."Description 2", TransShipmentLine."HSN/SAC Code", TransShipmentLine.Quantity, FreeQty, UOM, TransShipmentLine."Unit Price", TransShipmentLine.Amount, 0, TransShipmentLine.Amount, AssAmt, GSTRt, CgstRt, SgstRt, IgstRt, CesRt, CesAmt, CesNonAdval, StateCesRt, StateCesAmt, StateCesNonAdvlAmt, 0, AssAmt + GSTAmt, //BMS1.0
 TransShipmentLine."Line No.", SlNo, IsServc);
                UNTIL TransShipmentLine.NEXT = 0;
            //JsonTextWriter.WriteEndArray;
            END;
        END;
        END;
    end;
    local procedure WriteItem(PrdDesc: Text[300]; HsnCd: Text[8]; Qty: Decimal; FreeQty: Decimal; Unit: Text[8]; UnitPrice: Decimal; TotAmt: Decimal; Discount: Decimal; PreTaxVal: Decimal; AssAmt: Decimal; GSTRt: Decimal; CgstRt: Decimal; SgstRt: Decimal; IgstRt: Decimal; CesRt: Decimal; CesAmt: Decimal; CesNonAdval: Decimal; StateCes: Decimal; StateCesAmt: Decimal; StateCesNonAdvlAmt: Decimal; OthChrg: Decimal; TotItemVal: Decimal; SILineNo: Integer; SlNo: Integer; IsServc: Text[1])
    var
        ValueEntry: Record "Value Entry";
        ItemLedgerEntry: Record "Item Ledger Entry";
        ValueEntryRelation: Record "Value Entry Relation";
        ItemTrackingManagement: Codeunit "Item Tracking Management";
        InvoiceRowID: Text[250];
        xLotNo: Code[20];
        ItemWriter: JsonObject;
    begin
        //ItemWriter.Add('SlNo', FORMAT(SlNo));
        ItemWriter.Add('product_name', PrdDesc);
        ItemWriter.Add('product_description', PrdDesc);
        ItemWriter.Add('hsn_code', HsnCd);
        ItemWriter.Add('quantity', Qty);
        ItemWriter.Add('unit_of_product', Unit);
        ItemWriter.Add('CgstAmt', CgstRt);
        ItemWriter.Add('SgstAmt', SgstRt);
        ItemWriter.Add('IgstAmt', IgstRt);
        ItemWriter.Add('CesRt', CesRt);
        ItemWriter.Add('cessAdvol', 0);
        ItemWriter.Add('taxable_amount', AssAmt);
        // ItemWriter.Add('Barcde', GNull.AsToken());
        // IF FreeQty <> 0 THEN
        //     ItemWriter.Add('cessAdvol', 0)
        // ELSE
        //     ItemWriter.Add('FreeQty', GNull.AsToken());
        // ItemWriter.Add('UnitPrice', UnitPrice);
        // ItemWriter.Add('TotAmt', TotAmt);
        // ItemWriter.Add('PreTaxVal', PreTaxVal);
        // ItemWriter.Add('Discount', Discount);
        // ItemWriter.Add('GstRt', GstRt);
        // if IgstRt <> 0 then
        //     else
        //     ItemWriter.Add('IgstAmt', GNull.AsToken());
        // if CgstRt <> 0 then
        //     else
        //     ItemWriter.Add('CgstAmt', GNull.AsToken());
        // if SgstRt <> 0 then
        //     else
        //     ItemWriter.Add('SgstAmt', GNull.AsToken());
        // if CesRt <> 0 then
        //     else
        //     ItemWriter.Add('CesRt', GNull.AsToken());
        // if CesAmt <> 0 then
        //     ItemWriter.Add('CesAmt', CesAmt)
        // else
        //     ItemWriter.Add('CesAmt', GNull.AsToken());
        // if CesNonAdval <> 0 then
        //     ItemWriter.Add('CesNonAdvlAmt', CesNonAdval)
        // else
        //     ItemWriter.Add('CesNonAdvlAmt', GNull.AsToken());
        // if StateCes <> 0 then
        //     ItemWriter.Add('StateCesRt', StateCes)
        // else
        //     ItemWriter.Add('StateCesRt', GNull.AsToken());
        // if StateCesAmt <> 0 then
        //     ItemWriter.Add('StateCesAmt', StateCesAmt)
        // else
        //     ItemWriter.Add('StateCesAmt', GNull.AsToken());
        // if StateCesNonAdvlAmt <> 0 then
        //     ItemWriter.Add('StateCesNonAdvlAmt', StateCesNonAdvlAmt)
        // else
        //     ItemWriter.Add('StateCesNonAdvlAmt', GNull.AsToken());
        // if OthChrg <> 0 then
        //     ItemWriter.Add('OthChrg', OthChrg)
        // else
        //     ItemWriter.Add('OthChrg', GNull.AsToken());
        // ItemWriter.Add('TotItemVal', TotItemVal);
        // ItemWriter.Add('OrdLineRef', GNull.AsToken());
        // ItemWriter.Add('OrgCntry', GNull.AsToken());
        // ItemWriter.Add('PrdSlNo', GNull.AsToken());
        StringWriter.Add('itemList', ItemWriter);
    //JsonArrayData.Add(ItemWriter);
    end;
    local procedure ReadEWBDtls()
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
        TransMethod: Record "Transport Method";
    begin
        CASE EWBType OF EWBType::Sales: BEGIN
            WITH SalesInvoiceHeader DO BEGIN
                // TESTFIELD("Shipping Agent Code");
                // TESTFIELD("Mode of Transport");
                // TESTFIELD("Distance (Km)");
                // TESTFIELD("LR/RR No.");//BMS1.0
                // TESTFIELD("LR/RR Date");//BMS1.0
                // TESTFIELD("Vehicle No.");
                // TESTFIELD("Vehicle Type");
                ShippingAgent.GET("Shipping Agent Code");
                if TransMethod.Get("Transport Method")then;
                //ShippingAgent.TESTFIELD("State Code");
                //ShippingAgent.TESTFIELD("GST Registration No.");
                TptId:=ShippingAgent."Transporter GST No.";
                TptName:="Shipping Agent Code";
                TransMode:=TransMethod."E-Way transport method";
                Distance:="Transportation Distance";
                TptDocNo:="LR/RR No.";
                TptDocDate:=GetDateFormatedN(SalesInvoiceHeader."LR/RR Date");
                VehicleNo:=DelChr("Vehicle No.", '=', ' ,/-<>  !@#$%^&*()_+{}');
                CASE "Vehicle Type" OF "Vehicle Type"::ODC: VehicleType:='O';
                "Vehicle Type"::Regular: VehicleType:='R';
                END;
            END;
        END;
        EWBType::SalesReturn: BEGIN
            WITH SalesCrMemoHeader DO BEGIN
                TESTFIELD("Shipping Agent Code");
                TESTFIELD("Transport Method");
                TESTFIELD("Distance (Km)");
                //TESTFIELD("LR/RR No.");
                //TESTFIELD("LR/RR Date");
                TESTFIELD("Vehicle No.");
                TESTFIELD("Vehicle Type");
                ShippingAgent.GET("Shipping Agent Code");
                //ShippingAgent.TESTFIELD("State Code");//BMS1.0
                ShippingAgent.TESTFIELD("GST Registration No.");
                TptId:=ShippingAgent."GST Registration No.";
                TptName:=ShippingAgent.Name;
                TransMode:=''; //"Mode of Transport";
                Distance:="Distance (Km)";
                TptDocNo:=copystr(SalesCrMemoHeader."No.", StrLen(SalesCrMemoHeader."No.") - 4, StrLen(SalesCrMemoHeader."No."));
                TptDocDate:=FORMAT("Posting Date", 0, '<Day,2>/<Month,2>/<Year4>'); //FORMAT("LR/RR Date", 0, '<Day,2>/<Month,2>/<Year4>');
                VehicleNo:="Vehicle No.";
                CASE "Vehicle Type" OF "Vehicle Type"::ODC: VehicleType:='O';
                "Vehicle Type"::Regular: VehicleType:='R';
                END;
            END;
        END;
        EWBType::Purchase: BEGIN
        /*
                    WITH PurchCrMemoHeader DO BEGIN
                        TESTFIELD("Shipping Agent Code");
                        TESTFIELD("Mode of Transport");
                        TESTFIELD("Distance (Km)");
                        TESTFIELD("LR/RR No.");
                        TESTFIELD("LR/RR Date");
                        TESTFIELD("Vehicle No.");
                        TESTFIELD("Vehicle Type");
                        ShippingAgent.GET("Shipping Agent Code");
                        //ShippingAgent.TESTFIELD("State Code");//BMS1.0
                        ShippingAgent.TESTFIELD("GST Registration No.");

                        TptId := ShippingAgent."GST Registration No.";
                        TptName := ShippingAgent.Name;
                        TransMode := "Mode of Transport";
                        Distance := "Distance (Km)";
                        TptDocNo := "LR/RR No.";
                        TptDocDate := FORMAT("LR/RR Date", 0, '<Day,2>/<Month,2>/<Year4>');
                        VehicleNo := "Vehicle No.";
                        CASE "Vehicle Type" OF
                            "Vehicle Type"::ODC:
                                VehicleType := 'O';
                            "Vehicle Type"::Regular:
                                VehicleType := 'R';
                        END;
                    END;
                    */
        END;
        EWBType::Transfer: BEGIN
            WITH TransShipHeader DO BEGIN
                TESTFIELD("Shipping Agent Code");
                TESTFIELD("Mode of Transport");
                TESTFIELD("Distance (Km)");
                TESTFIELD("LR/RR No.");
                TESTFIELD("LR/RR Date");
                TESTFIELD("Vehicle No.");
                TESTFIELD("Vehicle Type");
                ShippingAgent.GET("Shipping Agent Code");
                //ShippingAgent.TESTFIELD("State Code");
                //ShippingAgent.TESTFIELD("GST Registration No.");
                TptId:=ShippingAgent."GST Registration No.";
                TptName:=ShippingAgent.Name;
                TransMode:="Mode of Transport";
                Distance:="Distance (Km)";
                TptDocNo:=copystr(TransShipHeader."No.", StrLen(TransShipHeader."No.") - 4, StrLen(TransShipHeader."No."));
                ;
                TptDocDate:=FORMAT("LR/RR Date", 0, '<Day,2>/<Month,2>/<Year4>');
                VehicleNo:="Vehicle No.";
                CASE "Vehicle Type" OF "Vehicle Type"::ODC: VehicleType:='O';
                "Vehicle Type"::Regular: VehicleType:='R';
                END;
            END;
        END;
        END;
        WriteEWBDtls(TptId, TptName, TransMode, Distance, TptDocNo, TptDocDate, VehicleNo, VehicleType, SalesInvoiceHeader."Location Code", SalesInvoiceHeader."User ID");
    end;
    local procedure WriteEWBDtls(TptId: Text[15]; TptName: Text[50]; TransMode: Text[1]; Distance: Integer; TptDocNo: Text[20]; TptDocDate: Text[30]; VehicleNo: Text[20]; VehicleType: Text[1]; LocCode: Code[20]; RefUser: Code[50])EwbDtlsWriter: JsonObject;
    begin
        EwbDtlsWriter.Add('transporter_id', TptId);
        EwbDtlsWriter.Add('transporter_name', TptName);
        EwbDtlsWriter.Add('transporter_document_number', TptDocNo);
        EwbDtlsWriter.Add('transportation_mode', TransMode);
        EwbDtlsWriter.Add('transportation_distance', Distance);
        EwbDtlsWriter.Add('transporter_document_date', TptDocDate);
        EwbDtlsWriter.Add('vehicle_number', VehicleNo);
        EwbDtlsWriter.Add('vehicle_type', 'Regular');
        //SSD Sunil Addional
        EwbDtlsWriter.Add('data_source', 'erp');
        EwbDtlsWriter.Add('user_ref', DelChr(RefUser, '=', ' ,<>/\-_()[]{}|'));
        EwbDtlsWriter.Add('email', 'gurgaon.dispatch@zavenir.com');
        EwbDtlsWriter.Add('location_code', LocCode);
        EwbDtlsWriter.Add('eway_bill_status', 'ABC');
        EwbDtlsWriter.Add('auto_print', 'Y');
        JsonArrayData.Add(StringWriter);
    //SSD Sunil Addional
    //StringWriter.Add('EwbDtls', EwbDtlsWriter);
    end;
    local procedure ReadEWBIRNDtls()
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
        IRNNo: Text;
    begin
        CASE EWBType OF EWBType::Sales: BEGIN
            WITH SalesInvoiceHeader DO BEGIN
                TESTFIELD("Shipping Agent Code");
                //TESTFIELD("Mode of Transport");//BMS1.0
                TESTFIELD("Distance (Km)");
                //TESTFIELD("LR/RR No.");//BMS1.0
                //TESTFIELD("LR/RR Date");/BMS1.0
                TESTFIELD("Vehicle No.");
                TESTFIELD("Vehicle Type");
                ShippingAgent.GET("Shipping Agent Code");
                //ShippingAgent.TESTFIELD("State Code");
                //ShippingAgent.TESTFIELD("GST Registration No.");
                TptId:=ShippingAgent."GST Registration No.";
                TptName:=ShippingAgent.Name;
                TransMode:=format("Mode of Transport");
                Distance:="Distance (Km)";
                TptDocNo:=copystr(SalesInvoiceHeader."No.", StrLen(SalesInvoiceHeader."No.") - 4, StrLen(SalesInvoiceHeader."No."));
                ; //"LR/RR No.";//BMS1.0
                TptDocDate:=FORMAT("Posting Date", 0, '<Day,2>/<Month,2>/<Year4>'); //FORMAT("LR/RR Date", 0, '<Day,2>/<Month,2>/<Year4>'); //BMS1.0
                VehicleNo:="Vehicle No.";
                CASE "Vehicle Type" OF "Vehicle Type"::ODC: VehicleType:='O';
                "Vehicle Type"::Regular: VehicleType:='R';
                END;
            END;
        END;
        EWBType::SalesReturn: BEGIN
            WITH SalesCrMemoHeader DO BEGIN
                TESTFIELD("Shipping Agent Code");
                //TESTFIELD("Mode of Transport");//BMS1.0
                TESTFIELD("Distance (Km)");
                //TESTFIELD("LR/RR No.");//BMS1.0
                //TESTFIELD("LR/RR Date");//BMS1.0
                TESTFIELD("Vehicle No.");
                TESTFIELD("Vehicle Type");
                ShippingAgent.GET("Shipping Agent Code");
                //ShippingAgent.TESTFIELD("State Code");
                ShippingAgent.TESTFIELD("GST Registration No.");
                TptId:=ShippingAgent."GST Registration No.";
                TptName:=ShippingAgent.Name;
                TransMode:=''; //"Mode of Transport";
                Distance:="Distance (Km)";
                TptDocNo:=copystr(SalesCrMemoHeader."No.", StrLen(SalesCrMemoHeader."No.") - 4, StrLen(SalesCrMemoHeader."No.")); //"LR/RR No.";
                TptDocDate:=FORMAT("Posting Date", 0, '<Day,2>/<Month,2>/<Year4>'); //FORMAT("LR/RR Date", 0, '<Day,2>/<Month,2>/<Year4>');
                VehicleNo:="Vehicle No.";
                CASE "Vehicle Type" OF "Vehicle Type"::ODC: VehicleType:='O';
                "Vehicle Type"::Regular: VehicleType:='R';
                END;
            END;
        END;
        EWBType::Purchase: BEGIN
        /*
                    WITH PurchCrMemoHeader DO BEGIN
                        TESTFIELD("Shipping Agent Code");
                        TESTFIELD("Mode of Transport");
                        TESTFIELD("Distance (Km)");
                        TESTFIELD("LR/RR No.");
                        TESTFIELD("LR/RR Date");
                        TESTFIELD("Vehicle No.");
                        TESTFIELD("Vehicle Type");
                        ShippingAgent.GET("Shipping Agent Code");
                        ShippingAgent.TESTFIELD("State Code");
                        ShippingAgent.TESTFIELD("GST Registration No.");

                        TptId := ShippingAgent."GST Registration No.";
                        TptName := ShippingAgent.Name;
                        TransMode := "Mode of Transport";
                        Distance := "Distance (Km)";
                        TptDocNo := "LR/RR No.";
                        TptDocDate := FORMAT("LR/RR Date", 0, '<Day,2>/<Month,2>/<Year4>');
                        VehicleNo := "Vehicle No.";
                        CASE "Vehicle Type" OF
                            "Vehicle Type"::ODC:
                                VehicleType := 'O';
                            "Vehicle Type"::Regular:
                                VehicleType := 'R';
                        END;
                    END;
                    */
        END;
        EWBType::Transfer: BEGIN
            WITH TransShipHeader DO BEGIN
                TESTFIELD("Shipping Agent Code");
                TESTFIELD("Mode of Transport");
                TESTFIELD("Distance (Km)");
                TESTFIELD("LR/RR No.");
                TESTFIELD("LR/RR Date");
                TESTFIELD("Vehicle No.");
                TESTFIELD("Vehicle Type");
                ShippingAgent.GET("Shipping Agent Code");
                //ShippingAgent.TESTFIELD("State Code");
                ShippingAgent.TESTFIELD("GST Registration No.");
                TptId:=ShippingAgent."GST Registration No.";
                TptName:=ShippingAgent.Name;
                TransMode:="Mode of Transport";
                Distance:="Distance (Km)";
                TptDocNo:=copystr(TransShipHeader."No.", StrLen(TransShipHeader."No.") - 4, StrLen(TransShipHeader."No.")); // "LR/RR No.";
                TptDocDate:=FORMAT("LR/RR Date", 0, '<Day,2>/<Month,2>/<Year4>');
                VehicleNo:="Vehicle No.";
                CASE "Vehicle Type" OF "Vehicle Type"::ODC: VehicleType:='O';
                "Vehicle Type"::Regular: VehicleType:='R';
                END;
            END;
        END;
        EWBType::SalesIRN: BEGIN
            WITH SalesInvoiceHeader DO BEGIN
                TESTFIELD("Shipping Agent Code");
                TESTFIELD("Mode of Transport");
                TESTFIELD("Distance (Km)");
                //TESTFIELD("LR/RR No.");
                //TESTFIELD("LR/RR Date");
                TESTFIELD("Vehicle No.");
                TESTFIELD("Vehicle Type");
                ShippingAgent.GET("Shipping Agent Code");
                //ShippingAgent.TESTFIELD("State Code");
                //ShippingAgent.TESTFIELD("GST Registration No.");
                IRNNo:="IRN Hash";
                TptId:=ShippingAgent."GST Registration No.";
                TptName:=ShippingAgent.Name;
                TransMode:=format("Mode of Transport");
                Distance:="Distance (Km)";
                TptDocNo:=copystr(SalesInvoiceHeader."No.", StrLen(SalesInvoiceHeader."No.") - 4, StrLen(SalesInvoiceHeader."No."));
                //"LR/RR No.";
                TptDocDate:=FORMAT("Posting Date", 0, '<Day,2>/<Month,2>/<Year4>'); //FORMAT("LR/RR Date", 0, '<Day,2>/<Month,2>/<Year4>');
                VehicleNo:="Vehicle No.";
                CASE "Vehicle Type" OF "Vehicle Type"::ODC: VehicleType:='O';
                "Vehicle Type"::Regular: VehicleType:='R';
                END;
            END;
        END;
        END;
        WriteEWBIRNDtls(IRNNo, TptId, TptName, TransMode, Distance, TptDocNo, TptDocDate, VehicleNo, VehicleType);
    end;
    local procedure WriteEWBIRNDtls(IRNNo: Text; TptId: Text[15]; TptName: Text[50]; TransMode: Text[1]; Distance: Integer; TptDocNo: Text[20]; TptDocDate: Text[30]; VehicleNo: Text[20]; VehicleType: Text[1])
    var
        EwbIRNDtlsWriter: JsonObject;
    begin
        EwbIRNDtlsWriter.Add('IRNNo', IRNNo);
        EwbIRNDtlsWriter.Add('TptId', TptId);
        EwbIRNDtlsWriter.Add('TptName', TptName);
        EwbIRNDtlsWriter.Add('TransMode', TransMode);
        EwbIRNDtlsWriter.Add('Distance', Distance);
        EwbIRNDtlsWriter.Add('TptDocNo', TptDocNo);
        EwbIRNDtlsWriter.Add('TptDocDate', TptDocDate);
        EwbIRNDtlsWriter.Add('VehicleNo', VehicleNo);
        EwbIRNDtlsWriter.Add('VehicleType', VehicleType);
        StringWriter.Add('WriteEWBIRNDtls', EwbIRNDtlsWriter);
    end;
    local procedure ReadEWBIRNBuyerDtls()
    var
        CompanyInformationBuff: Record "Company Information";
        Contact: Record Contact;
        SalesInvoiceLine: Record "Sales Invoice Line";
        SalesCrMemoLine: Record "Sales Cr.Memo Line";
        ShipToAddr: Record "Ship-to Address";
        StateBuff: Record State;
        Gstin: Text[15];
        TrdNm: Text[100];
        POS: Text[2];
        Addr1: Text[100];
        Addr2: Text[100];
        Loc: Text[100];
        Pin: Integer;
        Stcd: Text[50];
        TranType: Integer;
        ShipToStcd: Text;
        ShipToGstin: Text;
        ShipToTrdNm: Text;
        OrderAddress: Record "Order Address";
        Vend: Record Vendor;
        LocationBuff: Record Location;
    begin
        CASE EWBType OF EWBType::Sales: BEGIN
            WITH SalesInvoiceHeader DO BEGIN
                IF "GST Customer Type" = "GST Customer Type"::Unregistered THEN Gstin:='URP'
                ELSE
                    Gstin:="Customer GST Reg. No.";
                TrdNm:="Bill-to Name";
                IF "Ship-to Code" <> '' THEN BEGIN
                    ShipToAddr.GET("Sell-to Customer No.", "Ship-to Code");
                    Addr1:=ShipToAddr.Address;
                    Addr2:=ShipToAddr."Address 2";
                    Loc:=ShipToAddr.City;
                    IF "GST Customer Type" IN["GST Customer Type"::Export, "GST Customer Type"::"SEZ Unit", "GST Customer Type"::"SEZ Development"]THEN Pin:=999999
                    ELSE
                        EVALUATE(Pin, COPYSTR("Bill-to Post Code", 1, 6));
                    IF "GST Customer Type" = "GST Customer Type"::Unregistered THEN ShipToGstin:='URP'
                    ELSE
                        ShipToGstin:=ShipToAddr."GST Registration No.";
                    ShipToTrdNm:="Ship-to Name";
                    IF "GST Customer Type" IN["GST Customer Type"::Export, "GST Customer Type"::"SEZ Unit", "GST Customer Type"::"SEZ Development"]THEN Stcd:='96'
                    ELSE
                    BEGIN
                        StateBuff.RESET;
                        StateBuff.GET(ShipToAddr.State);
                        ShipToStcd:=StateBuff."State Code (GST Reg. No.)";
                    END;
                    TranType:=2;
                END
                ELSE
                BEGIN
                    Addr1:="Bill-to Address";
                    Addr2:="Bill-to Address 2";
                    Loc:="Bill-to City";
                    IF "GST Customer Type" IN["GST Customer Type"::Export, "GST Customer Type"::"SEZ Unit", "GST Customer Type"::"SEZ Development"]THEN Pin:=999999
                    ELSE
                        EVALUATE(Pin, COPYSTR("Bill-to Post Code", 1, 6));
                    IF "GST Customer Type" IN["GST Customer Type"::Export, "GST Customer Type"::"SEZ Unit", "GST Customer Type"::"SEZ Development"]THEN BEGIN
                        Stcd:='96';
                    END
                    ELSE
                    BEGIN
                        StateBuff.RESET;
                        StateBuff.GET("GST Bill-to State Code");
                        Stcd:=StateBuff."State Code (GST Reg. No.)";
                    END;
                    ShipToGstin:=Gstin;
                    ShipToTrdNm:="Bill-to Name";
                    IF "GST Customer Type" IN["GST Customer Type"::Export, "GST Customer Type"::"SEZ Unit", "GST Customer Type"::"SEZ Development"]THEN ShipToStcd:='97'
                    ELSE
                        ShipToStcd:=Stcd;
                    TranType:=2;
                END;
            END;
        END;
        EWBType::SalesReturn: BEGIN
            WITH SalesCrMemoHeader DO BEGIN
                TESTFIELD("Location GST Reg. No.");
                Gstin:="Location GST Reg. No.";
                CompanyInformationBuff.GET;
                TrdNm:=CompanyInformationBuff.Name;
                LocationBuff.GET("Location Code");
                Addr1:=LocationBuff.Address;
                Addr2:=LocationBuff."Address 2";
                LocationBuff.GET("Location Code");
                Loc:=LocationBuff.City;
                EVALUATE(Pin, COPYSTR(LocationBuff."Post Code", 1, 6));
                StateBuff.GET(LocationBuff."State Code");
                Stcd:=StateBuff."State Code (GST Reg. No.)";
                ShipToStcd:=Stcd;
                ShipToGstin:=Gstin;
                ShipToTrdNm:=TrdNm;
                TranType:=1;
            END;
        END;
        EWBType::Purchase: BEGIN
            WITH PurchCrMemoHeader DO BEGIN
                IF "GST Vendor Type" = "GST Vendor Type"::Unregistered THEN Gstin:='URP'
                ELSE
                    Gstin:="Vendor GST Reg. No.";
                Vend.Get(PurchCrMemoHeader."Buy-from Vendor No."); //BMS1.0
                StateBuff.RESET;
                StateBuff.GET(Vend."State Code"); //BMS1.0
                Stcd:=StateBuff."State Code (GST Reg. No.)";
                IF "Order Address Code" <> '' THEN BEGIN
                    OrderAddress.GET("Buy-from Vendor No.", "Order Address Code");
                    TrdNm:=OrderAddress.Name;
                    Addr1:=OrderAddress.Address;
                    Addr2:=OrderAddress."Address 2";
                    Loc:=OrderAddress.City;
                    EVALUATE(Pin, COPYSTR(OrderAddress."Post Code", 1, 6));
                    StateBuff.RESET;
                    StateBuff.GET(OrderAddress.State);
                    ShipToStcd:=StateBuff."State Code (GST Reg. No.)";
                    TranType:=2;
                    ShipToGstin:=OrderAddress."GST Registration No.";
                    ShipToTrdNm:=OrderAddress.Name;
                END
                ELSE
                BEGIN
                    TrdNm:="Buy-from Vendor Name";
                    Addr1:="Buy-from Address";
                    Addr2:="Buy-from Address 2";
                    Loc:="Buy-from City";
                    EVALUATE(Pin, COPYSTR("Buy-from Post Code", 1, 6));
                    ShipToStcd:=Stcd;
                    TranType:=1;
                    ShipToGstin:=Gstin;
                    ShipToTrdNm:="Buy-from Vendor Name";
                END;
            END;
        END;
        EWBType::Transfer: BEGIN
            WITH TransShipHeader DO BEGIN
                LocationBuff.GET("Transfer-to Code");
                Gstin:=LocationBuff."GST Registration No.";
                TrdNm:=LocationBuff.Name;
                Addr1:=LocationBuff.Address;
                Addr2:=LocationBuff."Address 2";
                Loc:=LocationBuff.City;
                EVALUATE(Pin, COPYSTR(LocationBuff."Post Code", 1, 6));
                StateBuff.RESET;
                StateBuff.GET(LocationBuff."State Code");
                Stcd:=StateBuff."State Code (GST Reg. No.)";
                ShipToStcd:=Stcd;
                TranType:=1;
                ShipToGstin:=Gstin;
                ShipToTrdNm:=TrdNm;
            END;
        END;
        END;
        // Temp Values only for Sandbox. To be removed for Go-Live
        IF EWBType <> EWBType::SalesReturn THEN Gstin:='05AAACG2140A1ZL'
        ELSE
        BEGIN
            Gstin:='05AAACG2314E1ZD';
            Loc:='Dehradun';
            Pin:=248001;
            Stcd:='05';
            ShipToStcd:='05';
            ShipToGstin:=Gstin;
        END;
        // Temp Values only for Sandbox. To be removed for Go-Live
        WriteEWBIRNBuyerDtls(Gstin, TrdNm, POS, Addr1, Addr2, Loc, Pin, Stcd, ShipToStcd, TranType, ShipToGstin, ShipToTrdNm);
    end;
    local procedure WriteEWBIRNBuyerDtls(Gstin: Text[15]; Trdm: Text[100]; POS: Text[2]; Addr1: Text[100]; Addr2: Text[100]; Loc: Text[100]; Pin: Integer; Stcd: Text[50]; ShipToStcd: Text; TranType: Integer; ShipToGstin: Text; ShipToTrdNm: Text)
    var
        BuyerDtlsWriter: JsonObject;
    begin
        if Gstin <> '' then BuyerDtlsWriter.Add('Gstin', Gstin)
        else
            BuyerDtlsWriter.Add('Gstin', 'URP');
        if Trdm <> '' then begin
            BuyerDtlsWriter.Add('LglNm', Trdm);
            BuyerDtlsWriter.Add('TrdNm', Trdm);
        end
        else
        begin
            BuyerDtlsWriter.Add('LglNm', GNull.AsToken());
            BuyerDtlsWriter.Add('TrdNm', GNull.AsToken());
        end;
        BuyerDtlsWriter.Add('Pos', POS);
        if Addr1 <> '' then BuyerDtlsWriter.Add('Addr1', Addr1)
        else
            BuyerDtlsWriter.Add('Addr1', GNull.AsToken());
        if Addr2 <> '' then BuyerDtlsWriter.Add('Addr2', Addr2)
        else
            BuyerDtlsWriter.Add('Addr2', GNull.AsToken());
        if Loc <> '' then BuyerDtlsWriter.Add('Loc', Loc)
        else
            BuyerDtlsWriter.Add('Loc', GNull.AsToken());
        if Pin <> 0 then BuyerDtlsWriter.Add('Pin', Pin)
        else
            BuyerDtlsWriter.Add('Pin', GNull.AsToken());
        if Stcd <> '' then BuyerDtlsWriter.Add('Stcd', Stcd)
        else
            BuyerDtlsWriter.Add('Stcd', GNull.AsToken());
        BuyerDtlsWriter.Add('ShipToStcd', ShipToStcd);
        BuyerDtlsWriter.Add('TranType', TranType);
        BuyerDtlsWriter.Add('ShipToGstin', ShipToGstin);
        BuyerDtlsWriter.Add('ShipToTrdNm', ShipToTrdNm);
        StringWriter.Add('WriteEWBIRNBuyerDtls', BuyerDtlsWriter);
    end;
    local procedure GetGSTCompRate(DocNo: Code[20]; LineNo: Integer; var GSTRt: Decimal; var CgstRt: Decimal; var SgstRt: Decimal; var IgstRt: Decimal; var CesRt: Decimal; var CesAmt: Decimal; var CesNonAdval: Decimal; var StateCesRt: Decimal; var StateCesAmt: Decimal; var StateCesNonAdvlAmt: Decimal)
    var
        DetailedGSTLedgerEntry: Record "Detailed GST Ledger Entry";
    begin
        CLEAR(GSTRt);
        CLEAR(CgstRt);
        CLEAR(SgstRt);
        CLEAR(IgstRt);
        DetailedGSTLedgerEntry.SETRANGE("Document No.", DocNo);
        DetailedGSTLedgerEntry.SETRANGE("Document Line No.", LineNo);
        DetailedGSTLedgerEntry.SETRANGE("GST Component Code", 'CGST');
        IF DetailedGSTLedgerEntry.FINDFIRST THEN BEGIN
            GSTRt:=DetailedGSTLedgerEntry."GST %";
            CgstRt:=DetailedGSTLedgerEntry."GST %";
        END;
        DetailedGSTLedgerEntry.SETRANGE("GST Component Code", 'SGST');
        IF DetailedGSTLedgerEntry.FINDFIRST THEN BEGIN
            GSTRt+=DetailedGSTLedgerEntry."GST %";
            SgstRt:=DetailedGSTLedgerEntry."GST %";
        END;
        DetailedGSTLedgerEntry.SETRANGE("GST Component Code", 'IGST');
        IF DetailedGSTLedgerEntry.FINDFIRST THEN BEGIN
            GSTRt:=DetailedGSTLedgerEntry."GST %";
            IgstRt:=DetailedGSTLedgerEntry."GST %";
        END;
        CesNonAdval:=0;
        CesAmt:=0;
        CLEAR(CesRt);
        DetailedGSTLedgerEntry.SETFILTER("GST Component Code", '%1|%2', 'CESS', 'INTERCESS');
        IF DetailedGSTLedgerEntry.FINDFIRST THEN BEGIN
            CesRt:=DetailedGSTLedgerEntry."GST %";
            IF DetailedGSTLedgerEntry."GST %" <> 0 THEN CesAmt:=ABS(DetailedGSTLedgerEntry."GST Amount")
            ELSE
                CesNonAdval:=ABS(DetailedGSTLedgerEntry."GST Amount");
        END;
        StateCesRt:=0;
        StateCesAmt:=0;
        StateCesNonAdvlAmt:=0;
    end;
    local procedure GetGSTVal(var AssVal: Decimal; var CgstVal: Decimal; var SgstVal: Decimal; var IgstVal: Decimal; var CesVal: Decimal; var StCesVal: Decimal; var Disc: Decimal; var OthChrg: Decimal; var TotInvVal: Decimal; var RndOffAmt: Decimal; var TotiInvValFc: Decimal)
    var
        SalesInvoiceLine: Record "Sales Invoice Line";
        SalesCrMemoLine: Record "Sales Cr.Memo Line";
        GSTLedgerEntry: Record "GST Ledger Entry";
        CurrExchRate: Record "Currency Exchange Rate";
        TotGSTAmt: Decimal;
        TotLineAmt: Decimal;
        PurchCrMemoLine: Record "Purch. Cr. Memo Line";
        TransShipmentLine: Record "Transfer Shipment Line";
    begin
        RndOffAmt:=0;
        TotiInvValFc:=0;
        GSTLedgerEntry.SETRANGE("Document No.", DocumentNo);
        CASE EWBType OF EWBType::Sales: BEGIN
            GSTLedgerEntry.SETRANGE("Transaction Type", GSTLedgerEntry."Transaction Type"::Sales);
            GSTLedgerEntry.SETRANGE("Posting Date", SalesInvoiceHeader."Posting Date");
            GSTLedgerEntry.SETRANGE("Document Type", GSTLedgerEntry."Document Type"::Invoice);
        END;
        EWBType::SalesReturn: BEGIN
            GSTLedgerEntry.SETRANGE("Transaction Type", GSTLedgerEntry."Transaction Type"::Sales);
            GSTLedgerEntry.SETRANGE("Posting Date", SalesCrMemoHeader."Posting Date");
            GSTLedgerEntry.SETRANGE("Document Type", GSTLedgerEntry."Document Type"::"Credit Memo");
        END;
        EWBType::Purchase: BEGIN
            GSTLedgerEntry.SETRANGE("Transaction Type", GSTLedgerEntry."Transaction Type"::Purchase);
            GSTLedgerEntry.SETRANGE("Posting Date", PurchCrMemoHeader."Posting Date");
            GSTLedgerEntry.SETRANGE("Document Type", GSTLedgerEntry."Document Type"::"Credit Memo");
        END;
        EWBType::Transfer: BEGIN
            GSTLedgerEntry.SETRANGE("Transaction Type", GSTLedgerEntry."Transaction Type"::Sales);
            GSTLedgerEntry.SETRANGE("Posting Date", TransShipHeader."Posting Date");
            GSTLedgerEntry.SETRANGE("Document Type", GSTLedgerEntry."Document Type"::Invoice);
        END;
        END;
        GSTLedgerEntry.SETRANGE("GST Component Code", 'CGST');
        IF GSTLedgerEntry.FINDSET THEN BEGIN
            REPEAT CgstVal+=ABS(GSTLedgerEntry."GST Amount");
            UNTIL GSTLedgerEntry.NEXT = 0;
        END
        ELSE
            CgstVal:=0;
        GSTLedgerEntry.SETRANGE("GST Component Code", 'SGST');
        IF GSTLedgerEntry.FINDSET THEN BEGIN
            REPEAT SgstVal+=ABS(GSTLedgerEntry."GST Amount")UNTIL GSTLedgerEntry.NEXT = 0;
        END
        ELSE
            SgstVal:=0;
        GSTLedgerEntry.SETRANGE("GST Component Code", 'IGST');
        IF GSTLedgerEntry.FINDSET THEN BEGIN
            REPEAT IgstVal+=ABS(GSTLedgerEntry."GST Amount")UNTIL GSTLedgerEntry.NEXT = 0;
        END
        ELSE
            IgstVal:=0;
        CesVal:=0;
        GSTLedgerEntry.SETFILTER("GST Component Code", '%1|%2', 'CESS', 'INTERCESS');
        IF GSTLedgerEntry.FINDSET THEN REPEAT CesVal+=ABS(GSTLedgerEntry."GST Amount")UNTIL GSTLedgerEntry.NEXT = 0;
        CLEAR(TotLineAmt);
        CASE EWBType OF EWBType::Sales: BEGIN
            SalesInvoiceLine.SETRANGE("Document No.", DocumentNo);
            IF SalesInvoiceLine.FINDSET THEN BEGIN
                REPEAT TotLineAmt+=SalesInvoiceLine."Line Amount";
                    //AssVal += SalesInvoiceLine."GST Base Amount";//BMS1.0
                    //TotGSTAmt += SalesInvoiceLine."Total GST Amount";//BMS1.0
                    ReturnGSTBaseAmount(SalesInvoiceLine."Document No.", SalesInvoiceLine."Line No.", AssVal); //BMS1.0
                    ReturnGSTAmount(SalesInvoiceLine."Document No.", SalesInvoiceLine."Line No.", TotGSTAmt); //BMS1.0
                    Disc+=SalesInvoiceLine."Inv. Discount Amount";
                UNTIL SalesInvoiceLine.NEXT = 0;
            END;
            //SSD Confirm with Hemanth regarding to ROunding Account
            SalesInvoiceLine.SETRANGE(Type, SalesInvoiceLine.Type::"G/L Account");
            SalesInvoiceLine.SETFILTER("No.", '%1|%2|%3', '2719', '9140', '9150');
            IF SalesInvoiceLine.FINDFIRST THEN REPEAT RndOffAmt+=SalesInvoiceLine."Line Amount";
                UNTIL SalesInvoiceLine.NEXT = 0;
            TotiInvValFc:=TotLineAmt + TotGSTAmt - Disc;
            TotLineAmt:=ROUND(CurrExchRate.ExchangeAmtFCYToLCY(SalesInvoiceHeader."Posting Date", SalesInvoiceHeader."Currency Code", TotLineAmt, SalesInvoiceHeader."Currency Factor"), 0.01, '=');
            AssVal:=ROUND(CurrExchRate.ExchangeAmtFCYToLCY(SalesInvoiceHeader."Posting Date", SalesInvoiceHeader."Currency Code", AssVal, SalesInvoiceHeader."Currency Factor"), 0.01, '=');
            TotGSTAmt:=ROUND(CurrExchRate.ExchangeAmtFCYToLCY(SalesInvoiceHeader."Posting Date", SalesInvoiceHeader."Currency Code", TotGSTAmt, SalesInvoiceHeader."Currency Factor"), 0.01, '=');
            Disc:=ROUND(CurrExchRate.ExchangeAmtFCYToLCY(SalesInvoiceHeader."Posting Date", SalesInvoiceHeader."Currency Code", Disc, SalesInvoiceHeader."Currency Factor"), 0.01, '=');
            TotInvVal:=TotLineAmt + TotGSTAmt - Disc;
            OthChrg:=0;
        END;
        EWBType::SalesReturn: BEGIN
            SalesCrMemoLine.SETRANGE("Document No.", DocumentNo);
            IF SalesCrMemoLine.FINDSET THEN BEGIN
                REPEAT TotLineAmt+=SalesCrMemoLine."Line Amount";
                    //AssVal += SalesCrMemoLine."GST Base Amount";//BMS1.0
                    //TotGSTAmt += SalesCrMemoLine."Total GST Amount";//BMS1.0
                    ReturnGSTBaseAmount(SalesCrMemoLine."Document No.", SalesCrMemoLine."Line No.", AssVal); //BMS1.0
                    ReturnGSTAmount(SalesCrMemoLine."Document No.", SalesCrMemoLine."Line No.", TotGSTAmt); //BMS1.0
                    Disc+=SalesCrMemoLine."Inv. Discount Amount";
                UNTIL SalesCrMemoLine.NEXT = 0;
            END;
            SalesCrMemoLine.SETRANGE(Type, SalesCrMemoLine.Type::"G/L Account");
            SalesCrMemoLine.SETFILTER("No.", '%1|%2|%3', '2719', '9140', '9150');
            IF SalesCrMemoLine.FINDFIRST THEN REPEAT RndOffAmt+=SalesCrMemoLine."Line Amount";
                UNTIL SalesCrMemoLine.NEXT = 0;
            TotiInvValFc:=TotLineAmt + TotGSTAmt - Disc;
            TotLineAmt:=ROUND(CurrExchRate.ExchangeAmtFCYToLCY(SalesCrMemoHeader."Posting Date", SalesCrMemoHeader."Currency Code", TotLineAmt, SalesCrMemoHeader."Currency Factor"), 0.01, '=');
            AssVal:=ROUND(CurrExchRate.ExchangeAmtFCYToLCY(SalesCrMemoHeader."Posting Date", SalesCrMemoHeader."Currency Code", AssVal, SalesCrMemoHeader."Currency Factor"), 0.01, '=');
            TotGSTAmt:=ROUND(CurrExchRate.ExchangeAmtFCYToLCY(SalesCrMemoHeader."Posting Date", SalesCrMemoHeader."Currency Code", TotGSTAmt, SalesCrMemoHeader."Currency Factor"), 0.01, '=');
            Disc:=ROUND(CurrExchRate.ExchangeAmtFCYToLCY(SalesCrMemoHeader."Posting Date", SalesCrMemoHeader."Currency Code", Disc, SalesCrMemoHeader."Currency Factor"), 0.01, '=');
            TotInvVal:=TotLineAmt + TotGSTAmt - Disc;
            OthChrg:=0;
        END;
        EWBType::Purchase: BEGIN
            PurchCrMemoLine.SETRANGE("Document No.", DocumentNo);
            IF PurchCrMemoLine.FINDSET THEN BEGIN
                REPEAT TotLineAmt+=PurchCrMemoLine."Line Amount";
                    //AssVal += PurchCrMemoLine."GST Base Amount";//BMS1.0
                    //TotGSTAmt += PurchCrMemoLine."Total GST Amount";//BMS1.0
                    ReturnGSTBaseAmount(PurchCrMemoLine."Document No.", PurchCrMemoLine."Line No.", AssVal); //BMS1.0
                    ReturnGSTAmount(PurchCrMemoLine."Document No.", PurchCrMemoLine."Line No.", TotGSTAmt); //BMS1.0
                    Disc+=PurchCrMemoLine."Inv. Discount Amount";
                UNTIL PurchCrMemoLine.NEXT = 0;
            END;
            PurchCrMemoLine.SETRANGE(Type, PurchCrMemoLine.Type::"G/L Account");
            PurchCrMemoLine.SETFILTER("No.", '%1|%2|%3', '2719', '9140', '9150');
            IF PurchCrMemoLine.FINDFIRST THEN REPEAT RndOffAmt+=PurchCrMemoLine."Line Amount";
                UNTIL PurchCrMemoLine.NEXT = 0;
            TotiInvValFc:=TotLineAmt + TotGSTAmt - Disc;
            TotLineAmt:=ROUND(CurrExchRate.ExchangeAmtFCYToLCY(PurchCrMemoHeader."Posting Date", PurchCrMemoHeader."Currency Code", TotLineAmt, PurchCrMemoHeader."Currency Factor"), 0.01, '=');
            AssVal:=ROUND(CurrExchRate.ExchangeAmtFCYToLCY(PurchCrMemoHeader."Posting Date", PurchCrMemoHeader."Currency Code", AssVal, PurchCrMemoHeader."Currency Factor"), 0.01, '=');
            TotGSTAmt:=ROUND(CurrExchRate.ExchangeAmtFCYToLCY(PurchCrMemoHeader."Posting Date", PurchCrMemoHeader."Currency Code", TotGSTAmt, PurchCrMemoHeader."Currency Factor"), 0.01, '=');
            Disc:=ROUND(CurrExchRate.ExchangeAmtFCYToLCY(PurchCrMemoHeader."Posting Date", PurchCrMemoHeader."Currency Code", Disc, PurchCrMemoHeader."Currency Factor"), 0.01, '=');
            TotInvVal:=TotLineAmt + TotGSTAmt - Disc;
            OthChrg:=0;
        END;
        EWBType::Transfer: BEGIN
            TransShipmentLine.SETRANGE("Document No.", DocumentNo);
            IF TransShipmentLine.FINDSET THEN BEGIN
                REPEAT TotLineAmt+=TransShipmentLine.Amount;
                    //AssVal += TransShipmentLine."GST Base Amount";//BMS1.0
                    //TotGSTAmt += TransShipmentLine."Total GST Amount";//BMS1.0
                    ReturnGSTBaseAmount(TransShipmentLine."Document No.", TransShipmentLine."Line No.", AssVal); //BMS1.0
                    ReturnGSTAmount(TransShipmentLine."Document No.", TransShipmentLine."Line No.", TotGSTAmt); //BMS1.0
                    Disc:=0;
                    RndOffAmt:=0;
                    OthChrg:=0;
                    TotInvVal:=AssVal + TotGSTAmt;
                UNTIL TransShipmentLine.NEXT = 0;
            END;
        END;
        END;
    end;
    // procedure ExportCancellationJsonTxt(EWBDetails: Record "EWB Details") JsonTxt: Text
    // var
    //     EWBDate: Date;
    //     EWBTime: Time;
    //     MaxCancelDateTime: DateTime;
    // begin
    //     WITH EWBDetails DO BEGIN
    //         TESTFIELD(Active);
    //         TESTFIELD("Cancellation Reason Code");
    //         IF "Cancellation Reason Code" = 4 THEN
    //             TESTFIELD("Cancellation Reason Desc.");
    //         EWBDate := DT2DATE("Creation DateTime");
    //         EWBTime := DT2TIME("Creation DateTime");
    //         EWBDate := CALCDATE('1D', EWBDate);
    //         MaxCancelDateTime := CREATEDATETIME(EWBDate, EWBTime);
    //         IF CURRENTDATETIME < MaxCancelDateTime THEN BEGIN
    //             Initialize;
    //             /*
    //                             JsonTextWriter.WriteStartObject;
    //                             JsonTextWriter.WritePropertyName('ewbNo');
    //                             JsonTextWriter.WriteValue("EWB No.");
    //                             JsonTextWriter.WritePropertyName('cancelRsnCode');
    //                             JsonTextWriter.WriteValue("Cancellation Reason Code");
    //                             JsonTextWriter.WritePropertyName('cancelRmrk');
    //                             JsonTextWriter.WriteValue("Cancellation Reason Desc.");
    //                             JsonTextWriter.WriteEndObject;
    //                             JsonTextWriter.Flush;
    //             */
    //         END ELSE
    //             ERROR('E-way Bill cannot be cancelled');
    //         //JsonTxt := StringBuilder.ToString;
    //     END;
    // end;
    procedure ReturnGSTBaseAmount(DocumentNo: Code[20]; LineNo: Integer; var GSTBaseAmount: Decimal)
    var
        GSTLedger: Record "Detailed GST Ledger Entry";
    begin
        GSTLedger.Reset();
        GSTLedger.SetRange("Document No.", DocumentNo);
        if LineNo <> 0 then GSTLedger.SetRange("Document Line No.", LineNo);
        if GSTLedger.FindLast()then GSTBaseAmount:=abs(GSTLedger."GST Base Amount");
    end;
    procedure ReturnGSTAmount(DocumentNo: Code[20]; LineNo: Integer; var GSTAmount: Decimal)
    var
        GSTLedger: Record "Detailed GST Ledger Entry";
    begin
        GSTLedger.Reset();
        GSTLedger.SetRange("Document No.", DocumentNo);
        if LineNo <> 0 then GSTLedger.SetRange("Document Line No.", LineNo);
        if GSTLedger.FindSet()then begin
            repeat GSTAmount+=abs(GSTLedger."GST Amount");
            until GSTLedger.Next() = 0;
        end;
    end;
    procedure RemoveSpecialChar(TxtDoc: Text): Text begin
        EXIT(DELCHR(TxtDoc, '=', './,-\!@#$%^&*()+ '));
    end;
    procedure GetGSTIN(LocCode: Code[20]): Text var
        Location: Record Location;
        CompanyInformation: Record "Company Information";
    begin
        if Location.Get(LocCode)then begin
            Location.TestField("GST Registration No.");
            exit(Location."GST Registration No.");
        end;
        CompanyInformation.Get;
        exit(CompanyInformation."GST Registration No.");
    end;
    procedure GetStateCodeN(StateCode: Code[20]): Text var
        StateL: Record State;
    begin
        if StateL.Get(StateCode)then exit(UpperCase(StateL.Description));
        exit('');
    end;
    procedure GetStateCodeN_POSN(StateCode: Code[20]): Text var
        StateL: Record State;
    begin
        if StateL.Get(StateCode)then exit(UpperCase(StateL."State Code (GST Reg. No.)"));
        exit('');
    end;
    procedure GetDateFormatedN(Originaldate: Date): Text var
        Day: Text[2];
        mnth: Text[2];
    begin
        if Originaldate <> 0D then begin
            if Date2dmy(Originaldate, 2) > 9 then mnth:=Format(Date2dmy(Originaldate, 2))
            else
                mnth:='0' + Format(Date2dmy(Originaldate, 2));
            if Date2dmy(Originaldate, 1) > 9 then Day:=Format(Date2dmy(Originaldate, 1))
            else
                Day:='0' + Format(Date2dmy(Originaldate, 1));
            exit(Day + '/' + mnth + '/' + Format(Date2dmy(Originaldate, 3)));
        end;
    end;
}
