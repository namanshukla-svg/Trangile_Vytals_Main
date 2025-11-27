codeunit 50061 "SSD Generate EWB"
{
    Permissions = TableData "Sales Invoice Header"=m,
        TableData "Sales Cr.Memo Header"=m;

    trigger OnRun()
    begin
    end;
    procedure ExportJsonTxt()JsonTxt: Text begin
        Initialize();
        ExportInvoice();
        SSDJsonObject.WriteTo(SSDJsonText);
        JsonTxt:=SSDJsonText;
    end;
    local procedure Initialize()
    begin
        Clear(SSDJsonObject);
        Clear(SSDJsonArrayData);
        Clear(SSDJsonText);
        CLEAR(GlobalNULL);
    end;
    local procedure ExportInvoice()
    begin
        CLEAR(CurrExRate);
        case EWBType of EWBType::Sales: begin
            if SalesInvoiceHeader."Currency Factor" <> 0 then CurrExRate:=1 / SalesInvoiceHeader."Currency Factor"
            else
                CurrExRate:=1;
            DocumentNo:=SalesInvoiceHeader."No.";
            ReadEwayDocDtls();
            ReadSellerDtls();
            ReadBuyerDtls();
            ReadValDtls();
            ReadEWBDtls();
            ReadItemList();
        end;
        EWBType::SalesReturn: if SalesCrMemoHeader.FINDSET()then repeat if SalesCrMemoHeader."Currency Factor" <> 0 then CurrExRate:=1 / SalesCrMemoHeader."Currency Factor"
                    else
                        CurrExRate:=1;
                    DocumentNo:=SalesCrMemoHeader."No.";
                    ReadEwayDocDtls();
                    ReadSellerDtls();
                    ReadBuyerDtls();
                    ReadValDtls();
                    ReadEWBDtls();
                    ReadItemList();
                //JsonTextWriter.WriteEndObject;
                until SalesCrMemoHeader.NEXT() = 0;
        EWBType::Purchase: if PurchCrMemoHeader.FINDSET()then repeat if PurchCrMemoHeader."Currency Factor" <> 0 then CurrExRate:=1 / PurchCrMemoHeader."Currency Factor"
                    else
                        CurrExRate:=1;
                    DocumentNo:=PurchCrMemoHeader."No.";
                    ReadEwayDocDtls();
                    ReadSellerDtls();
                    ReadBuyerDtls();
                    ReadValDtls();
                    ReadEWBDtls();
                    ReadItemList();
                //JsonTextWriter.WriteEndObject;
                until PurchCrMemoHeader.NEXT() = 0;
        EWBType::Transfer: begin
            CurrExRate:=1;
            DocumentNo:=TransShipHeader."No.";
            ReadEwayDocDtls();
            ReadSellerDtls();
            ReadBuyerDtls();
            ReadValDtls();
            ReadEWBDtls();
            ReadItemList();
        end;
        EWBType::SalesIRN: if SalesInvoiceHeader.FINDSET()then repeat if SalesInvoiceHeader."Currency Factor" <> 0 then CurrExRate:=1 / SalesInvoiceHeader."Currency Factor"
                    else
                        CurrExRate:=1;
                    DocumentNo:=SalesInvoiceHeader."No.";
                    ReadEWBIRNDtls();
                //JsonTextWriter.WriteEndObject;
                until SalesInvoiceHeader.NEXT() = 0;
        end;
    end;
    procedure SetSalesInvHeader(var SalesInvoiceHeaderBuff: Record "Sales Invoice Header"; EWBTypeBuff: Option Sales, Purchase, Transfer, SalesReturn)
    begin
        SalesInvoiceHeader.RESET();
        SalesInvoiceHeader.COPY(SalesInvoiceHeaderBuff);
        EWBType:=EWBTypeBuff;
    end;
    procedure SetSalesCrMemoHeader(var SalesCrMemoBuff: Record "Sales Cr.Memo Header"; EWBTypeBuff: Option Sales, Purchase, Transfer, SalesReturn)
    begin
        SalesCrMemoHeader.RESET();
        SalesCrMemoHeader.COPY(SalesCrMemoBuff);
        EWBType:=EWBTypeBuff;
    end;
    procedure SetPurchCrMemoHeader(var PurchCrMemoHeaderBuff: Record "Purch. Cr. Memo Hdr."; EWBTypeBuff: Option Sales, Purchase, Transfer, SalesReturn)
    begin
        PurchCrMemoHeader.RESET();
        PurchCrMemoHeader.COPY(PurchCrMemoHeaderBuff);
        EWBType:=EWBTypeBuff;
    end;
    procedure SetTransShipHeader(var TransShipHeaderBuff: Record "Transfer Shipment Header"; EWBTypeBuff: Option Sales, Purchase, Transfer, SalesReturn)
    begin
        TransShipHeader.RESET();
        TransShipHeader.COPY(TransShipHeaderBuff);
        EWBType:=EWBTypeBuff;
    end;
    local procedure ReadEwayDocDtls()
    var
        CommpanyInfo: Record "Company Information";
        TransportMethod: Record "Transport Method";
        ShippingAgent: Record "Shipping Agent";
        Location: Record Location;
        GSPManagement: Codeunit "SSD GSP Management";
        SuppType: Text;
        SubSupplyType: Text;
        SubSupplyDesc: Text;
        DocType: Text;
        DocNo: Text;
        DocDate: Text;
        TknNo: Text[50];
        GSTIN: Code[15];
        Mnth: Text[2];
        Day: Text[2];
    begin
        case EWBType of EWBType::Sales: begin
            WITH SalesInvoiceHeader DO BEGIN
                CommpanyInfo.get();
                TknNo:=GSPManagement.SSDGetAccessToken();
                if TransportMethod.Get(SalesInvoiceHeader."Transport Method")then;
                if ShippingAgent.Get(SalesInvoiceHeader."Shipping Agent Code")then;
                if Location.Get(SalesInvoiceHeader."Location Code")then;
                SalesInvoiceHeader.TESTFIELD("Transportation Distance");
                SalesInvoiceHeader.TESTFIELD("E-Way Generated", FALSE);
                SalesInvoiceHeader.TESTFIELD("E-Way Bill No.", '');
                SuppType:='outward';
                GSTIN:=GetGSTIN(SalesInvoiceHeader."Location Code");
                if SalesInvoiceHeader."Invoice Type" = SalesInvoiceHeader."invoice type"::Taxable then SubSupplyType:='Supply'
                else if SalesInvoiceHeader."Invoice Type" = SalesInvoiceHeader."invoice type"::Export then SubSupplyType:='Export';
                SubSupplyDesc:='';
                DocType:='tax invoice';
                DocNo:=SalesInvoiceHeader."No.";
                DocDate:=GetDateFormatedN(SalesInvoiceHeader."Posting Date");
            end;
        end;
        EWBType::SalesReturn: begin
            SuppType:='I';
            SubSupplyType:='7';
            SubSupplyDesc:='Sales Return';
            DocType:='CHL';
            DocNo:=SalesCrMemoHeader."No.";
            DocDate:=FORMAT(SalesCrMemoHeader."Posting Date", 0, '<Day,2>/<Month,2>/<Year4>');
        end;
        EWBType::Purchase: begin
            SuppType:='O';
            SubSupplyType:='8';
            SubSupplyDesc:='Credit Note';
            DocType:='CNT';
            DocNo:=PurchCrMemoHeader."No.";
            DocDate:=FORMAT(PurchCrMemoHeader."Posting Date", 0, '<Day,2>/<Month,2>/<Year4>');
        end;
        EWBType::Transfer: begin
            SuppType:='outward';
            SubSupplyType:='Others';
            SubSupplyDesc:='Others';
            DocType:='Challan';
            DocNo:=TransShipHeader."No.";
            IF DATE2DMY(TransShipHeader."Posting Date", 2) > 9 THEN Mnth:=FORMAT(DATE2DMY(TransShipHeader."Posting Date", 2))
            ELSE
                Mnth:='0' + FORMAT(DATE2DMY(TransShipHeader."Posting Date", 2));
            IF DATE2DMY(TransShipHeader."Posting Date", 1) > 9 THEN Day:=FORMAT(DATE2DMY(TransShipHeader."Posting Date", 1))
            ELSE
                Day:='0' + FORMAT(DATE2DMY(TransShipHeader."Posting Date", 1));
            DocDate:=Day + '/' + Mnth + '/' + FORMAT(DATE2DMY(TransShipHeader."Posting Date", 3));
        end;
        end;
        if EnvironmentInformation.IsSandbox()then GSTIN:='05AAABC0181E1ZE';
        WriteEwayDocDtls(SuppType, SubSupplyType, SubSupplyDesc, DocType, DocNo, DocDate, GSTIN, TknNo);
    end;
    local procedure WriteEwayDocDtls(SuppType: Text; SubSupplyType: Text; SubSupplyDesc: Text; DocType: Text; DocNo: Text; DocDate: Text; GSTIN: Code[15]; TknNo: Text[50])
    begin
        SSDJsonObject.Add('access_token', TknNo);
        SSDJsonObject.Add('userGstin', GSTIN);
        SSDJsonObject.Add('supply_type', SuppType);
        SSDJsonObject.Add('sub_supply_type', SubSupplyType);
        SSDJsonObject.Add('sub_supply_description', SubSupplyDesc);
        SSDJsonObject.Add('document_type', DocType);
        SSDJsonObject.Add('document_number', DocNo);
        SSDJsonObject.Add('document_date', DocDate);
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
        Pin: Integer;
        Stcd: Text[50];
        LegalName: Text;
        ActualState: Code[20];
    begin
        CLEAR(Loc);
        CLEAR(Pin);
        CLEAR(Stcd);
        case EWBType of EWBType::Sales: begin
            WITH SalesInvoiceHeader DO BEGIN
                LocationBuff.GET("Location Code");
                if LocationBuff."Temp JW Location" then begin
                    Gstin:=GetGSTIN(SalesInvoiceHeader."Location Code");
                    CompanyInformationBuff.GET;
                    TrdNm:=CompanyInformationBuff.Name;
                    Addr1:=LocationBuff.Address;
                    Addr2:=LocationBuff."Address 2";
                    Loc:=LocationBuff.City;
                    Evaluate(Pin, LocationBuff."Post Code");
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
                    Evaluate(Pin, LocationBuff."Post Code");
                    Stcd:=GetStateCodeN(LocationBuff."State Code");
                    ActualState:=GetStateCodeN(LocationBuff."State Code");
                end;
            END;
        end;
        EWBType::SalesReturn: begin
            if SalesCrMemoHeader."GST Customer Type" = SalesCrMemoHeader."GST Customer Type"::Unregistered then Gstin:='URP'
            else
                Gstin:=SalesCrMemoHeader."Customer GST Reg. No.";
            TrdNm:=SalesCrMemoHeader."Bill-to Name";
            StateBuff.RESET();
            StateBuff.GET(SalesCrMemoHeader."GST Bill-to State Code");
            Stcd:=StateBuff."State Code (GST Reg. No.)";
            if SalesCrMemoHeader."Ship-to Code" <> '' then begin
                ShipToAddr.GET(SalesCrMemoHeader."Sell-to Customer No.", SalesCrMemoHeader."Ship-to Code");
                Addr1:=ShipToAddr.Address;
                Addr2:=ShipToAddr."Address 2";
                Loc:=ShipToAddr.City;
                if SalesCrMemoHeader."GST Customer Type" <> SalesCrMemoHeader."GST Customer Type"::Export then EVALUATE(Pin, COPYSTR(SalesCrMemoHeader."Bill-to Post Code", 1, 6));
                StateBuff.RESET();
                StateBuff.GET(ShipToAddr.State);
                Stcd:=StateBuff."State Code (GST Reg. No.)";
            end
            else
            begin
                Addr1:=SalesCrMemoHeader."Bill-to Address";
                Addr2:=SalesCrMemoHeader."Bill-to Address 2";
                Loc:=SalesCrMemoHeader."Bill-to City";
                if SalesCrMemoHeader."GST Customer Type" <> SalesCrMemoHeader."GST Customer Type"::Export then EVALUATE(Pin, COPYSTR(SalesCrMemoHeader."Bill-to Post Code", 1, 6));
                StateBuff.RESET();
                StateBuff.GET(SalesCrMemoHeader."GST Bill-to State Code");
                Stcd:=StateBuff."State Code (GST Reg. No.)";
            end;
        end;
        EWBType::Purchase: begin
            PurchCrMemoHeader.TESTFIELD("Location GST Reg. No.");
            Gstin:=PurchCrMemoHeader."Location GST Reg. No.";
            CompanyInformationBuff.GET();
            TrdNm:=CompanyInformationBuff.Name;
            LocationBuff.GET(PurchCrMemoHeader."Location Code");
            Addr1:=LocationBuff.Address;
            Addr2:=LocationBuff."Address 2";
            Loc:=LocationBuff.City;
            EVALUATE(Pin, COPYSTR(LocationBuff."Post Code", 1, 6));
            StateBuff.GET(LocationBuff."State Code");
            Stcd:=StateBuff."State Code (GST Reg. No.)";
        end;
        EWBType::Transfer: begin
            LocationBuff.GET(TransShipHeader."Transfer-from Code");
            LocationBuff.TESTFIELD("GST Registration No.");
            Gstin:=LocationBuff."GST Registration No.";
            CompanyInformationBuff.GET();
            TrdNm:=LocationBuff.Name;
            Addr1:=LocationBuff.Address;
            Addr2:=LocationBuff."Address 2";
            Loc:=LocationBuff.City;
            Evaluate(Pin, LocationBuff."Post Code");
            StateBuff.GET(LocationBuff."State Code");
            Stcd:=GetStateCodeN(LocationBuff."State Code");
        end;
        end;
        // Temp Values only for Sandbox. To be removed for Go-Live
        if EnvironmentInformation.IsSandbox()then begin
            if EWBType = EWBType::SalesReturn then begin
                Gstin:='05AAABC0181E1ZE';
            end
            else
            begin
                Gstin:='05AAABC0181E1ZE';
                Loc:='Dehradun';
                Pin:=248001;
                Stcd:='UTTARAKHAND';
                ActualState:='UTTARAKHAND';
            end;
        end;
        // Temp Values only for Sandbox. To be removed for Go-Live
        WriteSellerDtls(Gstin, TrdNm, Addr1, Addr2, Loc, Pin, Stcd, ActualState);
    end;
    local procedure WriteSellerDtls(Gstin: Text[15]; TrdNm: Text[100]; Addr1: Text[100]; Addr2: Text[100]; Loc: Text[50]; Pin: Integer; Stcd: Text[50]; ActState: code[20])
    begin
        SSDJsonObject.Add('gstin_of_consignor', Gstin);
        SSDJsonObject.Add('legal_name_of_consignor', TrdNm);
        SSDJsonObject.Add('address1_of_consignor', Addr1);
        SSDJsonObject.Add('address2_of_consignor', Addr2);
        SSDJsonObject.Add('place_of_consignor', Loc);
        SSDJsonObject.Add('pincode_of_consignor', Pin);
        SSDJsonObject.Add('state_of_consignor', Stcd);
        SSDJsonObject.Add('actual_from_state_name', ActState);
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
        Pin: Integer;
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
        ActualToState: Code[30];
        StateOfSupply: Text[50];
    begin
        case EWBType of EWBType::Sales: begin
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
                Evaluate(Pin, "Ship-to Post Code");
                if SalesInvoiceHeader."Invoice Type" = SalesInvoiceHeader."invoice type"::Taxable then Stcd:=StateBuff.Description //GetStateCodeN(SalesInvoiceHeader.State)); // Alle "Invoice Type"::Taxable
                else if SalesInvoiceHeader."Invoice Type" = SalesInvoiceHeader."invoice type"::Export then Stcd:='Other Country';
                ActualToState:=GetStateCodeN(SalesInvoiceHeader.State);
            END;
        END;
        EWBType::SalesReturn: begin
            SalesCrMemoHeader.TESTFIELD("Location GST Reg. No.");
            Gstin:=SalesCrMemoHeader."Location GST Reg. No.";
            CompanyInformationBuff.GET();
            TrdNm:=CompanyInformationBuff.Name;
            LocationBuff.GET(SalesCrMemoHeader."Location Code");
            Addr1:=LocationBuff.Address;
            Addr2:=LocationBuff."Address 2";
            LocationBuff.GET(SalesCrMemoHeader."Location Code");
            Loc:=LocationBuff.City;
            EVALUATE(Pin, COPYSTR(LocationBuff."Post Code", 1, 6));
            StateBuff.GET(LocationBuff."State Code");
            Stcd:=StateBuff."State Code (GST Reg. No.)";
            ShipToStcd:=Stcd;
            ShipToGstin:=Gstin;
            ShipToTrdNm:=TrdNm;
            TranType:=1;
        end;
        EWBType::Purchase: begin
            if PurchCrMemoHeader."GST Vendor Type" = PurchCrMemoHeader."GST Vendor Type"::Unregistered then Gstin:='URP'
            else
                Gstin:=PurchCrMemoHeader."Vendor GST Reg. No.";
            Vend.Get(PurchCrMemoHeader."Buy-from Vendor No."); //BMS1.0
            StateBuff.RESET();
            StateBuff.GET(Vend."State Code"); //BMS1.0
            Stcd:=StateBuff."State Code (GST Reg. No.)";
            if PurchCrMemoHeader."Order Address Code" <> '' then begin
                OrderAddress.GET(PurchCrMemoHeader."Buy-from Vendor No.", PurchCrMemoHeader."Order Address Code");
                TrdNm:=OrderAddress.Name;
                Addr1:=OrderAddress.Address;
                Addr2:=OrderAddress."Address 2";
                Loc:=OrderAddress.City;
                EVALUATE(Pin, COPYSTR(OrderAddress."Post Code", 1, 6));
                StateBuff.RESET();
                StateBuff.GET(OrderAddress.State);
                ShipToStcd:=StateBuff."State Code (GST Reg. No.)";
                TranType:=2;
                ShipToGstin:=OrderAddress."GST Registration No.";
                ShipToTrdNm:=OrderAddress.Name;
            end
            else
            begin
                TrdNm:=PurchCrMemoHeader."Buy-from Vendor Name";
                Addr1:=PurchCrMemoHeader."Buy-from Address";
                Addr2:=PurchCrMemoHeader."Buy-from Address 2";
                Loc:=PurchCrMemoHeader."Buy-from City";
                EVALUATE(Pin, COPYSTR(PurchCrMemoHeader."Buy-from Post Code", 1, 6));
                ShipToStcd:=Stcd;
                TranType:=1;
                ShipToGstin:=Gstin;
                ShipToTrdNm:=PurchCrMemoHeader."Buy-from Vendor Name";
            end;
        end;
        EWBType::Transfer: begin
            LocationBuff.GET(TransShipHeader."Transfer-to Code");
            Gstin:=LocationBuff."GST Registration No.";
            TrdNm:=TransShipHeader."Transfer-to Name";
            Addr1:=TransShipHeader."Transfer-to Address";
            Addr2:=TransShipHeader."Transfer-to Address 2";
            Loc:=TransShipHeader."Transfer-to City";
            evaluate(Pin, TransShipHeader."Transfer-to Post Code");
            StateBuff.RESET();
            StateBuff.GET(LocationBuff."State Code");
            Stcd:=GetStateCodeN(LocationBuff."State Code");
            ShipToStcd:=Stcd;
            TranType:=1;
            ShipToGstin:=Gstin;
            ShipToTrdNm:=TrdNm;
        end;
        end;
        // Temp Values only for Sandbox. To be removed for Go-Live
        if EnvironmentInformation.IsSandbox()then begin
            if EWBType <> EWBType::SalesReturn then begin
                Gstin:='05AAABB0639G1Z8';
                Loc:='Dehradun';
                Pin:=248001;
                Stcd:='UTTARAKHAND';
                ShipToStcd:='05';
                ShipToGstin:=Gstin;
                ActualToState:='UTTARAKHAND';
            end
            else
                Gstin:='05AAABB0639G1Z8';
        end;
        // Temp Values only for Sandbox. To be removed for Go-Live
        WriteBuyerDtls(Gstin, TrdNm, POS, Addr1, Addr2, Loc, Pin, Stcd, ShipToStcd, TranType, ShipToGstin, ShipToTrdNm, ActualToState, StateOfSupply);
    end;
    local procedure WriteBuyerDtls(Gstin: Text[15]; Trdm: Text[100]; POS: Text[2]; Addr1: Text[100]; Addr2: Text[100]; Loc: Text[100]; Pin: Integer; Stcd: Text[50]; ShipToStcd: Text; TranType: Integer; ShipToGstin: Text; ShipToTrdNm: Text; ActState: Code[20]; StateOfSupply: Text[50])
    begin
        SSDJsonObject.Add('transaction_type', TranType);
        SSDJsonObject.Add('gstin_of_consignee', Gstin);
        SSDJsonObject.Add('legal_name_of_consignee', Trdm);
        SSDJsonObject.Add('address1_of_consignee', Addr1);
        SSDJsonObject.Add('address2_of_consignee', Addr2);
        SSDJsonObject.Add('place_of_consignee', Loc);
        SSDJsonObject.Add('pincode_of_consignee', Pin);
        SSDJsonObject.Add('state_of_supply', Stcd);
        SSDJsonObject.Add('actual_to_state_name', ActState);
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
        IF EnvironmentInformation.IsSandbox()then begin
            CgstVal:=round(IgstVal / 2, 0.01, '=');
            SgstVal:=round(IgstVal / 2, 0.01, '=');
            IgstVal:=0;
        end;
        WriteValDtls(AssVal, CgstVal, SgstVal, IgstVal, CesVal, StCesVal, TotInvVal, RndOffAmt, TotiInvValFc);
    end;
    local procedure WriteValDtls(Assval: Decimal; CgstVal: Decimal; SgstVAl: Decimal; IgstVal: Decimal; CesVal: Decimal; StCesVal: Decimal; TotInvVal: Decimal; OthChgs: Decimal; TotiInvValFc: Decimal)
    var
        ValDtlsWriter: JsonObject;
    begin
        SSDJsonObject.Add('total_invoice_value', TotInvVal);
        SSDJsonObject.Add('taxable_amount', Assval);
        SSDJsonObject.Add('cgst_amount', CgstVal);
        SSDJsonObject.Add('sgst_amount', SgstVAl);
        SSDJsonObject.Add('igst_amount', IgstVal);
        SSDJsonObject.Add('cess_amount', CesVal);
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
        Clear(SSDJsonArrayData);
        case EWBType of EWBType::Sales: begin
            SalesInvoiceLine.SETRANGE("Document No.", DocumentNo);
            SalesInvoiceLine.SetFilter("No.", '<>%1', '');
            SalesInvoiceLine.SETRANGE("Non-GST Line", false);
            SalesInvoiceLine.SetRange("System-Created Entry", false);
            SalesInvoiceLine.SetRange(Type, SalesInvoiceLine.Type::Item);
            if SalesInvoiceLine.FINDSET()then begin
                // if SalesInvoiceLine.COUNT > 100 then
                //     ERROR(SalesLinesErr, SalesInvoiceLine.COUNT);
                repeat SlNo+=1;
                    IF SalesInvoiceLine."GST On Assessable Value" THEN AssAmt:=SalesInvoiceLine."GST Assessable Value (LCY)"
                    ELSE
                        ReturnGSTBaseAmount(SalesInvoiceLine."Document No.", SalesInvoiceLine."Line No.", AssAmt);
                    //SalesInvoiceLine."GST Base Amount"; //BMS1.0
                    GetGSTCompRate(SalesInvoiceLine."Document No.", SalesInvoiceLine."Line No.", GSTRt, CgstRt, SgstRt, IgstRt, CesRt, CesAmt, CesNonAdval, StateCesRt, StateCesAmt, StateCesNonAdvlAmt);
                    CLEAR(UOM);
                    if SalesInvoiceLine."Unit of Measure Code" <> '' then UOM:=COPYSTR(SalesInvoiceLine."Unit of Measure Code", 1, 8)
                    else
                        UOM:=OTHTxt;
                    if SalesInvoiceLine."GST Group Type" = SalesInvoiceLine."GST Group Type"::Service then IsServc:='Y'
                    else
                        IsServc:='N';
                    ReturnGSTAmount(SalesInvoiceLine."Document No.", SalesInvoiceLine."Line No.", GSTAmt); //BMS1.0
                    WriteItem(SalesInvoiceLine.Description + SalesInvoiceLine."Description 2", SalesInvoiceLine."HSN/SAC Code", SalesInvoiceLine.Quantity, FreeQty, UOM, SalesInvoiceLine."Unit Price", SalesInvoiceLine."Line Amount" + SalesInvoiceLine."Line Discount Amount", SalesInvoiceLine."Line Discount Amount", SalesInvoiceLine."Line Amount", AssAmt, GSTRt, CgstRt, SgstRt, IgstRt, CesRt, CesAmt, CesNonAdval, StateCesRt, StateCesAmt, StateCesNonAdvlAmt, 0, AssAmt + GSTAmt, //BMS1.0
 SalesInvoiceLine."Line No.", SlNo, IsServc);
                until SalesInvoiceLine.NEXT() = 0;
                SSDJsonObject.Add('itemList', JsonArrayData);
            //JsonTextWriter.WriteEndArray;
            end;
        end;
        EWBType::SalesReturn: begin
            SalesCrMemoLine.SETRANGE("Document No.", DocumentNo);
            SalesCrMemoLine.SetFilter("No.", '<>%1', '');
            SalesCrMemoLine.SETRANGE("Non-GST Line", false);
            SalesCrMemoLine.SetRange(Type, SalesCrMemoLine.Type::Item);
            SalesCrMemoLine.SetRange("System-Created Entry", false);
            if SalesCrMemoLine.FINDSET()then begin
                if SalesCrMemoLine.COUNT > 100 then ERROR(SalesLinesErr, SalesCrMemoLine.COUNT);
                repeat SlNo+=1;
                    if SalesCrMemoLine."GST On Assessable Value" then AssAmt:=SalesCrMemoLine."GST Assessable Value (LCY)"
                    else
                        ReturnGSTBaseAmount(SalesCrMemoLine."Document No.", SalesCrMemoLine."Line No.", AssAmt); //BMS1.0
                    GetGSTCompRate(SalesCrMemoLine."Document No.", SalesCrMemoLine."Line No.", GSTRt, CgstRt, SgstRt, IgstRt, CesRt, CesAmt, CesNonAdval, StateCesRt, StateCesAmt, StateCesNonAdvlAmt);
                    CLEAR(UOM);
                    if SalesCrMemoLine."Unit of Measure Code" <> '' then UOM:=COPYSTR(SalesCrMemoLine."Unit of Measure Code", 1, 8)
                    else
                        UOM:=OTHTxt;
                    if SalesCrMemoLine."GST Group Type" = SalesCrMemoLine."GST Group Type"::Service then IsServc:='Y'
                    else
                        IsServc:='N';
                    ReturnGSTAmount(SalesInvoiceLine."Document No.", SalesInvoiceLine."Line No.", GSTAmt); //BMS1.0
                    WriteItem(SalesCrMemoLine.Description + SalesCrMemoLine."Description 2", SalesCrMemoLine."HSN/SAC Code", SalesCrMemoLine.Quantity, FreeQty, UOM, SalesCrMemoLine."Unit Price", SalesCrMemoLine."Line Amount" + SalesCrMemoLine."Line Discount Amount", SalesCrMemoLine."Line Discount Amount", SalesCrMemoLine."Line Amount", AssAmt, GSTRt, CgstRt, SgstRt, IgstRt, CesRt, CesAmt, CesNonAdval, StateCesRt, StateCesAmt, StateCesNonAdvlAmt, 0, AssAmt + GSTAmt, //BMS1.0
 SalesCrMemoLine."Line No.", SlNo, IsServc);
                until SalesCrMemoLine.NEXT() = 0;
            //JsonTextWriter.WriteEndArray;
            end;
        end;
        EWBType::Purchase: begin
            PurchCrMemoLine.SETRANGE("Document No.", DocumentNo);
            PurchCrMemoLine.SetFilter("No.", '<>%1', '');
            PurchCrMemoLine.SETRANGE("Non-GST Line", false);
            PurchCrMemoLine.SetRange("System-Created Entry", false);
            PurchCrMemoLine.SetRange(Type, SalesCrMemoLine.Type::Item);
            if PurchCrMemoLine.FINDSET()then begin
                if PurchCrMemoLine.COUNT > 100 then ERROR(SalesLinesErr, PurchCrMemoLine.COUNT);
                // JsonTextWriter.WritePropertyName('itemList');
                // JsonTextWriter.WriteStartArray;
                repeat SlNo+=1;
                    //AssAmt := PurchCrMemoLine."GST Base Amount";
                    ReturnGSTBaseAmount(PurchCrMemoLine."Document No.", PurchCrMemoLine."Line No.", AssAmt); //BMS1.0
                    FreeQty:=0;
                    GetGSTCompRate(PurchCrMemoLine."Document No.", PurchCrMemoLine."Line No.", GSTRt, CgstRt, SgstRt, IgstRt, CesRt, CesAmt, CesNonAdval, StateCesRt, StateCesAmt, StateCesNonAdvlAmt);
                    CLEAR(UOM);
                    if PurchCrMemoLine."Unit of Measure Code" <> '' then UOM:=COPYSTR(PurchCrMemoLine."Unit of Measure Code", 1, 8)
                    else
                        UOM:=OTHTxt;
                    if PurchCrMemoLine."GST Group Type" = PurchCrMemoLine."GST Group Type"::Service then IsServc:='Y'
                    else
                        IsServc:='N';
                    ReturnGSTAmount(SalesInvoiceLine."Document No.", SalesInvoiceLine."Line No.", GSTAmt); //BMS1.0
                    WriteItem(PurchCrMemoLine.Description + PurchCrMemoLine."Description 2", PurchCrMemoLine."HSN/SAC Code", PurchCrMemoLine.Quantity, FreeQty, UOM, PurchCrMemoLine."Unit Cost", PurchCrMemoLine."Line Amount" + PurchCrMemoLine."Line Discount Amount", PurchCrMemoLine."Line Discount Amount", PurchCrMemoLine."Line Amount", AssAmt, GSTRt, CgstRt, SgstRt, IgstRt, CesRt, CesAmt, CesNonAdval, StateCesRt, StateCesAmt, StateCesNonAdvlAmt, 0, AssAmt + GSTAmt, PurchCrMemoLine."Line No.", SlNo, IsServc);
                until PurchCrMemoLine.NEXT() = 0;
            //JsonTextWriter.WriteEndArray;
            end;
        end;
        EWBType::Transfer: begin
            TransShipmentLine.SETRANGE("Document No.", DocumentNo);
            TransShipmentLine.SetFilter("Item No.", '<>%1', '');
            if TransShipmentLine.FINDSET()then begin
                if TransShipmentLine.COUNT > 100 then ERROR(SalesLinesErr, TransShipmentLine.COUNT);
                // JsonTextWriter.WritePropertyName('itemList');
                // JsonTextWriter.WriteStartArray;
                repeat SlNo+=1;
                    //AssAmt := TransShipmentLine."GST Base Amount";//BMS1.0
                    ReturnGSTBaseAmount(TransShipmentLine."Document No.", TransShipmentLine."Line No.", AssAmt); //BMS1.0
                    FreeQty:=0;
                    GetGSTCompRate(TransShipmentLine."Document No.", TransShipmentLine."Line No.", GSTRt, CgstRt, SgstRt, IgstRt, CesRt, CesAmt, CesNonAdval, StateCesRt, StateCesAmt, StateCesNonAdvlAmt);
                    CLEAR(UOM);
                    if TransShipmentLine."Unit of Measure Code" <> '' then UOM:=COPYSTR(TransShipmentLine."Unit of Measure Code", 1, 8)
                    else
                        UOM:=OTHTxt;
                    IsServc:='N';
                    ReturnGSTAmount(SalesInvoiceLine."Document No.", SalesInvoiceLine."Line No.", GSTAmt); //BMS1.0
                    WriteItem(TransShipmentLine.Description + TransShipmentLine."Description 2", TransShipmentLine."HSN/SAC Code", TransShipmentLine.Quantity, FreeQty, UOM, TransShipmentLine."Unit Price", TransShipmentLine.Amount, 0, TransShipmentLine.Amount, AssAmt, GSTRt, CgstRt, SgstRt, IgstRt, CesRt, CesAmt, CesNonAdval, StateCesRt, StateCesAmt, StateCesNonAdvlAmt, 0, AssAmt + GSTAmt, //BMS1.0
 TransShipmentLine."Line No.", SlNo, IsServc);
                until TransShipmentLine.NEXT() = 0;
            end;
        end;
        end;
    end;
    local procedure WriteItem(PrdDesc: Text[300]; HsnCd: Text[8]; Qty: Decimal; FreeQty: Decimal; Unit: Text[8]; UnitPrice: Decimal; TotAmt: Decimal; Discount: Decimal; PreTaxVal: Decimal; AssAmt: Decimal; GSTRt: Decimal; CgstRt: Decimal; SgstRt: Decimal; IgstRt: Decimal; CesRt: Decimal; CesAmt: Decimal; CesNonAdval: Decimal; StateCes: Decimal; StateCesAmt: Decimal; StateCesNonAdvlAmt: Decimal; OthChrg: Decimal; TotItemVal: Decimal; SILineNo: Integer; SlNo: Integer; IsServc: Text[1])
    var
        ValueEntry: Record "Value Entry";
        ItemLedgerEntry: Record "Item Ledger Entry";
        ValueEntryRelation: Record "Value Entry Relation";
        ItemTrackingManagement: Codeunit "Item Tracking Management";
        InvoiceRowID: Text[250];
        xLotNo: Code[20];
        SSDJsonObject2: JsonObject;
    begin
        if EnvironmentInformation.IsSandbox()then begin
            CgstRt:=ROUND(IgstRt / 2, 0.01, '=');
            SgstRt:=ROUND(IgstRt / 2, 0.01, '=');
            IgstRt:=0;
        end;
        SSDJsonObject2.Add('product_name', PrdDesc);
        SSDJsonObject2.Add('product_description', PrdDesc);
        SSDJsonObject2.Add('hsn_code', HsnCd);
        SSDJsonObject2.Add('quantity', Qty);
        SSDJsonObject2.Add('unit_of_product', Unit);
        SSDJsonObject2.Add('CgstAmt', CgstRt);
        SSDJsonObject2.Add('SgstAmt', SgstRt);
        SSDJsonObject2.Add('IgstAmt', IgstRt);
        SSDJsonObject2.Add('CesRt', CesRt);
        SSDJsonObject2.Add('cessAdvol', 0);
        SSDJsonObject2.Add('taxable_amount', AssAmt);
        JsonArrayData.Add(SSDJsonObject2);
    end;
    local procedure ReadEWBDtls()
    var
        ShippingAgent: Record "Shipping Agent";
        TptId: Text[15];
        TptName: Text[50];
        TransMode: Text[10];
        Distance: Integer;
        TptDocNo: Text[20];
        TptDocDate: Text[30];
        VehicleNo: Text[20];
        VehicleType: Text[1];
        TransMethod: Record "Transport Method";
    begin
        case EWBType of EWBType::Sales: begin
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
        EWBType::SalesReturn: begin
        // SalesCrMemoHeader.TESTFIELD("Shipping Agent Code");
        // SalesCrMemoHeader.TESTFIELD("Mode of Transport");
        // SalesCrMemoHeader.TESTFIELD("Distance (Km)");
        // if SalesCrMemoHeader."LR/RR No." <> '' then
        //     SalesCrMemoHeader.TESTFIELD("LR/RR No.");
        // SalesCrMemoHeader.TESTFIELD("LR/RR Date");
        // SalesCrMemoHeader.TESTFIELD("Vehicle No.");
        // SalesCrMemoHeader.TESTFIELD("Vehicle Type");
        // ShippingAgent.GET(SalesCrMemoHeader."Shipping Agent Code");
        // //ShippingAgent.TESTFIELD("State Code");//BMS1.0
        // ShippingAgent.TESTFIELD("GST Registration No.");
        // TptId := ShippingAgent."GST Registration No.";
        // TptName := ShippingAgent.Name;
        // TransMode := SalesCrMemoHeader."Mode of Transport";
        // Distance := SalesCrMemoHeader."Distance (Km)";
        // //TptDocNo := copystr(SalesCrMemoHeader."No.", StrLen(SalesCrMemoHeader."No.") - 4, StrLen(SalesCrMemoHeader."No."));
        // TptDocNo := SalesCrMemoHeader."LR/RR No.";
        // TptDocDate := FORMAT(SalesCrMemoHeader."LR/RR Date", 0, '<Day,2>/<Month,2>/<Year4>');//FORMAT("LR/RR Date", 0, '<Day,2>/<Month,2>/<Year4>');
        // VehicleNo := SalesCrMemoHeader."Vehicle No.";
        // case SalesCrMemoHeader."Vehicle Type" of
        //     SalesCrMemoHeader."Vehicle Type"::ODC:
        //         VehicleType := 'O';
        //     SalesCrMemoHeader."Vehicle Type"::Regular:
        //         VehicleType := 'R';
        // end;
        end;
        EWBType::Transfer: begin
            TransShipHeader.TESTFIELD("Shipping Agent Code");
            TransShipHeader.TESTFIELD("Mode of Transport");
            TransShipHeader.TESTFIELD("Transportation Distance");
            if TransShipHeader."LR/RR No." <> '' then TransShipHeader.TESTFIELD("LR/RR No.");
            TransShipHeader.TESTFIELD("LR/RR Date");
            TransShipHeader.TESTFIELD("Vehicle No.");
            TransShipHeader.TESTFIELD("Vehicle Type");
            ShippingAgent.GET(TransShipHeader."Shipping Agent Code");
            //ShippingAgent.TESTFIELD("State Code");
            //ShippingAgent.TESTFIELD("GST Registration No.");
            TptId:=ShippingAgent."Transporter GST No.";
            TptName:=TransShipHeader."Shipping Agent Code";
            TransMode:=TransMethod."E-Way transport method";
            Distance:=TransShipHeader."Transportation Distance";
            //TptDocNo := copystr(TransShipHeader."No.", StrLen(TransShipHeader."No.") - 4, StrLen(TransShipHeader."No."));
            TptDocNo:=TransShipHeader."External Document No.";
            TptDocDate:=GetDateFormatedN(TransShipHeader."Posting Date");
            VehicleNo:=DELCHR(TransShipHeader."Vehicle No.", '=', ' ,-!@$#%^&*()_+{}|:<>?');
            //case TransShipHeader."Vehicle Type" of
            //TransShipHeader."Vehicle Type"::ODC:
            // VehicleType := 'O';
            //TransShipHeader."Vehicle Type"::Regular:
            VehicleType:='Regular';
        end;
        end;
        IF EnvironmentInformation.IsSandbox()then begin
            TptId:='05AAABC0181E1ZE';
            Distance:=20;
        end;
        WriteEWBDtls(TptId, TptName, TransMode, Distance, TptDocNo, TptDocDate, VehicleNo, VehicleType, SalesInvoiceHeader."Location Code", SalesInvoiceHeader."User ID");
    end;
    local procedure WriteEWBDtls(TptId: Text[15]; TptName: Text[50]; TransMode: Text[10]; Distance: Integer; TptDocNo: Text[20]; TptDocDate: Text[30]; VehicleNo: Text[20]; VehicleType: Text[1]; LocCode: Code[20]; RefUser: Code[50])
    var
        SSDStatus: Integer;
    begin
        SSDJsonObject.Add('transporter_id', TptId);
        SSDJsonObject.Add('transporter_name', TptName);
        SSDJsonObject.Add('transporter_document_number', TptDocNo);
        SSDJsonObject.Add('transportation_mode', TransMode);
        SSDJsonObject.Add('transportation_distance', Distance);
        SSDJsonObject.Add('transporter_document_date', TptDocDate);
        SSDJsonObject.Add('vehicle_number', VehicleNo);
        SSDJsonObject.Add('vehicle_type', 'Regular');
        //SSD Sunil Addional
        if Confirm('Do you want instant genrate the E-way')then begin
            SSDStatus:=1;
            SSDJsonObject.Add('generate_status', SSDStatus);
        end
        else
        begin
            SSDStatus:=0;
            SSDJsonObject.Add('generate_status', SSDStatus);
        end;
        SSDJsonObject.Add('data_source', 'erp');
        SSDJsonObject.Add('user_ref', DelChr(RefUser, '=', ' ,<>/\-_()[]{}|'));
        SSDJsonObject.Add('email', 'gurgaon.dispatch@zavenir.com');
        SSDJsonObject.Add('location_code', LocCode);
        SSDJsonObject.Add('eway_bill_status', 'ABC');
        SSDJsonObject.Add('auto_print', 'Y');
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
        case EWBType of EWBType::Sales: begin
            SalesInvoiceHeader.TESTFIELD("Shipping Agent Code");
            //TESTFIELD("Mode of Transport");//BMS1.0
            SalesInvoiceHeader.TESTFIELD("Distance (Km)");
            //TESTFIELD("LR/RR No.");//BMS1.0
            //TESTFIELD("LR/RR Date");/BMS1.0
            SalesInvoiceHeader.TESTFIELD("Vehicle No.");
            SalesInvoiceHeader.TESTFIELD("Vehicle Type");
            ShippingAgent.GET(SalesInvoiceHeader."Shipping Agent Code");
            //ShippingAgent.TESTFIELD("State Code");
            //ShippingAgent.TESTFIELD("GST Registration No.");
            TptId:=ShippingAgent."GST Registration No.";
            TptName:=ShippingAgent.Name;
            TransMode:=format(SalesInvoiceHeader."Mode of Transport");
            Distance:=SalesInvoiceHeader."Distance (Km)";
            TptDocNo:=copystr(SalesInvoiceHeader."No.", StrLen(SalesInvoiceHeader."No.") - 4, StrLen(SalesInvoiceHeader."No."));
            ; //"LR/RR No.";//BMS1.0
            TptDocDate:=FORMAT(SalesInvoiceHeader."Posting Date", 0, '<Day,2>/<Month,2>/<Year4>'); //FORMAT("LR/RR Date", 0, '<Day,2>/<Month,2>/<Year4>'); //BMS1.0
            VehicleNo:=SalesInvoiceHeader."Vehicle No.";
            case SalesInvoiceHeader."Vehicle Type" of SalesInvoiceHeader."Vehicle Type"::ODC: VehicleType:='O';
            SalesInvoiceHeader."Vehicle Type"::Regular: VehicleType:='R';
            end;
        end;
        EWBType::SalesReturn: begin
            SalesCrMemoHeader.TESTFIELD("Shipping Agent Code");
            //TESTFIELD("Mode of Transport");//BMS1.0
            SalesCrMemoHeader.TESTFIELD("Distance (Km)");
            //TESTFIELD("LR/RR No.");//BMS1.0
            //TESTFIELD("LR/RR Date");//BMS1.0
            SalesCrMemoHeader.TESTFIELD("Vehicle No.");
            SalesCrMemoHeader.TESTFIELD("Vehicle Type");
            ShippingAgent.GET(SalesCrMemoHeader."Shipping Agent Code");
            //ShippingAgent.TESTFIELD("State Code");
            ShippingAgent.TESTFIELD("GST Registration No.");
            TptId:=ShippingAgent."GST Registration No.";
            TptName:=ShippingAgent.Name;
            TransMode:=''; //"Mode of Transport";
            Distance:=SalesCrMemoHeader."Distance (Km)";
            TptDocNo:=copystr(SalesCrMemoHeader."No.", StrLen(SalesCrMemoHeader."No.") - 4, StrLen(SalesCrMemoHeader."No.")); //"LR/RR No.";
            TptDocDate:=FORMAT(SalesCrMemoHeader."Posting Date", 0, '<Day,2>/<Month,2>/<Year4>'); //FORMAT("LR/RR Date", 0, '<Day,2>/<Month,2>/<Year4>');
            VehicleNo:=SalesCrMemoHeader."Vehicle No.";
            case SalesCrMemoHeader."Vehicle Type" of SalesCrMemoHeader."Vehicle Type"::ODC: VehicleType:='O';
            SalesCrMemoHeader."Vehicle Type"::Regular: VehicleType:='R';
            end;
        end;
        EWBType::Transfer: begin
            TransShipHeader.TESTFIELD("Shipping Agent Code");
            TransShipHeader.TESTFIELD("Mode of Transport");
            TransShipHeader.TESTFIELD("Distance (Km)");
            TransShipHeader.TESTFIELD("LR/RR No.");
            TransShipHeader.TESTFIELD("LR/RR Date");
            TransShipHeader.TESTFIELD("Vehicle No.");
            TransShipHeader.TESTFIELD("Vehicle Type");
            ShippingAgent.GET(TransShipHeader."Shipping Agent Code");
            //ShippingAgent.TESTFIELD("State Code");
            ShippingAgent.TESTFIELD("GST Registration No.");
            TptId:=ShippingAgent."GST Registration No.";
            TptName:=ShippingAgent.Name;
            TransMode:=TransShipHeader."Mode of Transport";
            Distance:=TransShipHeader."Distance (Km)";
            TptDocNo:=copystr(TransShipHeader."No.", StrLen(TransShipHeader."No.") - 4, StrLen(TransShipHeader."No.")); // "LR/RR No.";
            TptDocDate:=FORMAT(TransShipHeader."LR/RR Date", 0, '<Day,2>/<Month,2>/<Year4>');
            VehicleNo:=TransShipHeader."Vehicle No.";
            case TransShipHeader."Vehicle Type" of TransShipHeader."Vehicle Type"::ODC: VehicleType:='O';
            TransShipHeader."Vehicle Type"::Regular: VehicleType:='R';
            end;
        end;
        EWBType::SalesIRN: begin
            SalesInvoiceHeader.TESTFIELD("Shipping Agent Code");
            SalesInvoiceHeader.TESTFIELD("Mode of Transport");
            SalesInvoiceHeader.TESTFIELD("Distance (Km)");
            //TESTFIELD("LR/RR No.");
            //TESTFIELD("LR/RR Date");
            SalesInvoiceHeader.TESTFIELD("Vehicle No.");
            SalesInvoiceHeader.TESTFIELD("Vehicle Type");
            ShippingAgent.GET(SalesInvoiceHeader."Shipping Agent Code");
            //ShippingAgent.TESTFIELD("State Code");
            //ShippingAgent.TESTFIELD("GST Registration No.");
            IRNNo:=SalesInvoiceHeader."IRN Hash";
            TptId:=ShippingAgent."GST Registration No.";
            TptName:=ShippingAgent.Name;
            TransMode:=format(SalesInvoiceHeader."Mode of Transport");
            Distance:=SalesInvoiceHeader."Distance (Km)";
            TptDocNo:=copystr(SalesInvoiceHeader."No.", StrLen(SalesInvoiceHeader."No.") - 4, StrLen(SalesInvoiceHeader."No."));
            //"LR/RR No.";
            TptDocDate:=FORMAT(SalesInvoiceHeader."Posting Date", 0, '<Day,2>/<Month,2>/<Year4>'); //FORMAT("LR/RR Date", 0, '<Day,2>/<Month,2>/<Year4>');
            VehicleNo:=SalesInvoiceHeader."Vehicle No.";
            case SalesInvoiceHeader."Vehicle Type" of SalesInvoiceHeader."Vehicle Type"::ODC: VehicleType:='O';
            SalesInvoiceHeader."Vehicle Type"::Regular: VehicleType:='R';
            end;
        end;
        end;
        WriteEWBIRNDtls(IRNNo, TptId, TptName, TransMode, Distance, TptDocNo, TptDocDate, VehicleNo, VehicleType);
    end;
    local procedure WriteEWBIRNDtls(IRNNo: Text; TptId: Text[15]; TptName: Text[50]; TransMode: Text[1]; Distance: Integer; TptDocNo: Text[20]; TptDocDate: Text[30]; VehicleNo: Text[20]; VehicleType: Text[1])
    var
        EwbIRNDtlsWriter: JsonObject;
    begin
        SSDJsonObject.Add('IRNNo', IRNNo);
        SSDJsonObject.Add('TptId', TptId);
        SSDJsonObject.Add('TptName', TptName);
        SSDJsonObject.Add('TransMode', TransMode);
        SSDJsonObject.Add('Distance', Distance);
        SSDJsonObject.Add('TptDocNo', TptDocNo);
        SSDJsonObject.Add('TptDocDate', TptDocDate);
        SSDJsonObject.Add('VehicleNo', VehicleNo);
        SSDJsonObject.Add('VehicleType', VehicleType);
    //SSDJsonArrayData.Add(SSDJsonObject);
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
        case EWBType of EWBType::Sales: begin
            if SalesInvoiceHeader."GST Customer Type" = SalesInvoiceHeader."GST Customer Type"::Unregistered then Gstin:='URP'
            else
                Gstin:=SalesInvoiceHeader."Customer GST Reg. No.";
            TrdNm:=SalesInvoiceHeader."Bill-to Name";
            if SalesInvoiceHeader."Ship-to Code" <> '' then begin
                ShipToAddr.GET(SalesInvoiceHeader."Sell-to Customer No.", SalesInvoiceHeader."Ship-to Code");
                Addr1:=ShipToAddr.Address;
                Addr2:=ShipToAddr."Address 2";
                Loc:=ShipToAddr.City;
                if SalesInvoiceHeader."GST Customer Type" in[SalesInvoiceHeader."GST Customer Type"::Export, SalesInvoiceHeader."GST Customer Type"::"SEZ Unit", SalesInvoiceHeader."GST Customer Type"::"SEZ Development"]then Pin:=999999
                else
                    EVALUATE(Pin, COPYSTR(SalesInvoiceHeader."Bill-to Post Code", 1, 6));
                if SalesInvoiceHeader."GST Customer Type" = SalesInvoiceHeader."GST Customer Type"::Unregistered then ShipToGstin:='URP'
                else
                    ShipToGstin:=ShipToAddr."GST Registration No.";
                ShipToTrdNm:=SalesInvoiceHeader."Ship-to Name";
                if SalesInvoiceHeader."GST Customer Type" in[SalesInvoiceHeader."GST Customer Type"::Export, SalesInvoiceHeader."GST Customer Type"::"SEZ Unit", SalesInvoiceHeader."GST Customer Type"::"SEZ Development"]then Stcd:='96'
                else
                begin
                    StateBuff.RESET();
                    StateBuff.GET(ShipToAddr.State);
                    ShipToStcd:=StateBuff."State Code (GST Reg. No.)";
                end;
                TranType:=2;
            end
            else
            begin
                Addr1:=SalesInvoiceHeader."Bill-to Address";
                Addr2:=SalesInvoiceHeader."Bill-to Address 2";
                Loc:=SalesInvoiceHeader."Bill-to City";
                if SalesInvoiceHeader."GST Customer Type" in[SalesInvoiceHeader."GST Customer Type"::Export, SalesInvoiceHeader."GST Customer Type"::"SEZ Unit", SalesInvoiceHeader."GST Customer Type"::"SEZ Development"]then Pin:=999999
                else
                    EVALUATE(Pin, COPYSTR(SalesInvoiceHeader."Bill-to Post Code", 1, 6));
                if SalesInvoiceHeader."GST Customer Type" in[SalesInvoiceHeader."GST Customer Type"::Export, SalesInvoiceHeader."GST Customer Type"::"SEZ Unit", SalesInvoiceHeader."GST Customer Type"::"SEZ Development"]then begin
                    Stcd:='96';
                end
                else
                begin
                    StateBuff.RESET();
                    StateBuff.GET(SalesInvoiceHeader."GST Bill-to State Code");
                    Stcd:=StateBuff."State Code (GST Reg. No.)";
                end;
                ShipToGstin:=Gstin;
                ShipToTrdNm:=SalesInvoiceHeader."Bill-to Name";
                if SalesInvoiceHeader."GST Customer Type" in[SalesInvoiceHeader."GST Customer Type"::Export, SalesInvoiceHeader."GST Customer Type"::"SEZ Unit", SalesInvoiceHeader."GST Customer Type"::"SEZ Development"]then ShipToStcd:='97'
                else
                    ShipToStcd:=Stcd;
                TranType:=2;
            end;
        end;
        EWBType::SalesReturn: begin
            SalesCrMemoHeader.TESTFIELD("Location GST Reg. No.");
            Gstin:=SalesCrMemoHeader."Location GST Reg. No.";
            CompanyInformationBuff.GET();
            TrdNm:=CompanyInformationBuff.Name;
            LocationBuff.GET(SalesCrMemoHeader."Location Code");
            Addr1:=LocationBuff.Address;
            Addr2:=LocationBuff."Address 2";
            LocationBuff.GET(SalesCrMemoHeader."Location Code");
            Loc:=LocationBuff.City;
            EVALUATE(Pin, COPYSTR(LocationBuff."Post Code", 1, 6));
            StateBuff.GET(LocationBuff."State Code");
            Stcd:=StateBuff."State Code (GST Reg. No.)";
            ShipToStcd:=Stcd;
            ShipToGstin:=Gstin;
            ShipToTrdNm:=TrdNm;
            TranType:=1;
        end;
        EWBType::Purchase: begin
            if PurchCrMemoHeader."GST Vendor Type" = PurchCrMemoHeader."GST Vendor Type"::Unregistered then Gstin:='URP'
            else
                Gstin:=PurchCrMemoHeader."Vendor GST Reg. No.";
            Vend.Get(PurchCrMemoHeader."Buy-from Vendor No."); //BMS1.0
            StateBuff.RESET();
            StateBuff.GET(Vend."State Code"); //BMS1.0
            Stcd:=StateBuff."State Code (GST Reg. No.)";
            if PurchCrMemoHeader."Order Address Code" <> '' then begin
                OrderAddress.GET(PurchCrMemoHeader."Buy-from Vendor No.", PurchCrMemoHeader."Order Address Code");
                TrdNm:=OrderAddress.Name;
                Addr1:=OrderAddress.Address;
                Addr2:=OrderAddress."Address 2";
                Loc:=OrderAddress.City;
                EVALUATE(Pin, COPYSTR(OrderAddress."Post Code", 1, 6));
                StateBuff.RESET();
                StateBuff.GET(OrderAddress.State);
                ShipToStcd:=StateBuff."State Code (GST Reg. No.)";
                TranType:=2;
                ShipToGstin:=OrderAddress."GST Registration No.";
                ShipToTrdNm:=OrderAddress.Name;
            end
            else
            begin
                TrdNm:=PurchCrMemoHeader."Buy-from Vendor Name";
                Addr1:=PurchCrMemoHeader."Buy-from Address";
                Addr2:=PurchCrMemoHeader."Buy-from Address 2";
                Loc:=PurchCrMemoHeader."Buy-from City";
                EVALUATE(Pin, COPYSTR(PurchCrMemoHeader."Buy-from Post Code", 1, 6));
                ShipToStcd:=Stcd;
                TranType:=1;
                ShipToGstin:=Gstin;
                ShipToTrdNm:=PurchCrMemoHeader."Buy-from Vendor Name";
            end;
        end;
        EWBType::Transfer: begin
            LocationBuff.GET(TransShipHeader."Transfer-to Code");
            Gstin:=LocationBuff."GST Registration No.";
            TrdNm:=LocationBuff.Name;
            Addr1:=LocationBuff.Address;
            Addr2:=LocationBuff."Address 2";
            Loc:=LocationBuff.City;
            EVALUATE(Pin, COPYSTR(LocationBuff."Post Code", 1, 6));
            StateBuff.RESET();
            StateBuff.GET(LocationBuff."State Code");
            Stcd:=StateBuff."State Code (GST Reg. No.)";
            ShipToStcd:=Stcd;
            TranType:=1;
            ShipToGstin:=Gstin;
            ShipToTrdNm:=TrdNm;
        end;
        end;
        // Temp Values only for Sandbox. To be removed for Go-Live
        if EWBType <> EWBType::SalesReturn then Gstin:='05AAACG2140A1ZL'
        else
        begin
            Gstin:='05AAACG2314E1ZD';
            Loc:='Dehradun';
            Pin:=248001;
            Stcd:='05';
            ShipToStcd:='05';
            ShipToGstin:=Gstin;
        end;
        // Temp Values only for Sandbox. To be removed for Go-Live
        WriteEWBIRNBuyerDtls(Gstin, TrdNm, POS, Addr1, Addr2, Loc, Pin, Stcd, ShipToStcd, TranType, ShipToGstin, ShipToTrdNm);
    end;
    local procedure WriteEWBIRNBuyerDtls(Gstin: Text[15]; Trdm: Text[100]; POS: Text[2]; Addr1: Text[100]; Addr2: Text[100]; Loc: Text[100]; Pin: Integer; Stcd: Text[50]; ShipToStcd: Text; TranType: Integer; ShipToGstin: Text; ShipToTrdNm: Text)
    var
        BuyerDtlsWriter: JsonObject;
    begin
        if Gstin <> '' then SSDJsonObject.Add('Gstin', Gstin)
        else
            SSDJsonObject.Add('Gstin', 'URP');
        if Trdm <> '' then begin
            SSDJsonObject.Add('LglNm', Trdm);
            SSDJsonObject.Add('TrdNm', Trdm);
        end
        else
        begin
            SSDJsonObject.Add('LglNm', GNull.AsToken());
            SSDJsonObject.Add('TrdNm', GNull.AsToken());
        end;
        SSDJsonObject.Add('Pos', POS);
        if Addr1 <> '' then SSDJsonObject.Add('Addr1', Addr1)
        else
            SSDJsonObject.Add('Addr1', GNull.AsToken());
        if Addr2 <> '' then SSDJsonObject.Add('Addr2', Addr2)
        else
            SSDJsonObject.Add('Addr2', GNull.AsToken());
        if Loc <> '' then SSDJsonObject.Add('Loc', Loc)
        else
            SSDJsonObject.Add('Loc', GNull.AsToken());
        if Pin <> 0 then SSDJsonObject.Add('Pin', Pin)
        else
            SSDJsonObject.Add('Pin', GNull.AsToken());
        if Stcd <> '' then SSDJsonObject.Add('Stcd', Stcd)
        else
            SSDJsonObject.Add('Stcd', GNull.AsToken());
        SSDJsonObject.Add('ShipToStcd', ShipToStcd);
        SSDJsonObject.Add('TranType', TranType);
        SSDJsonObject.Add('ShipToGstin', ShipToGstin);
        SSDJsonObject.Add('ShipToTrdNm', ShipToTrdNm);
    //SSDJsonArrayData.Add(SSDJsonObject);
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
        if DetailedGSTLedgerEntry.FINDFIRST()then begin
            GSTRt:=DetailedGSTLedgerEntry."GST %";
            CgstRt:=DetailedGSTLedgerEntry."GST %";
        end;
        DetailedGSTLedgerEntry.SETRANGE("GST Component Code", 'SGST');
        if DetailedGSTLedgerEntry.FINDFIRST()then begin
            GSTRt+=DetailedGSTLedgerEntry."GST %";
            SgstRt:=DetailedGSTLedgerEntry."GST %";
        end;
        DetailedGSTLedgerEntry.SETRANGE("GST Component Code", 'IGST');
        if DetailedGSTLedgerEntry.FINDFIRST()then begin
            GSTRt:=DetailedGSTLedgerEntry."GST %";
            IgstRt:=DetailedGSTLedgerEntry."GST %";
        end;
        CesNonAdval:=0;
        CesAmt:=0;
        CLEAR(CesRt);
        DetailedGSTLedgerEntry.SETFILTER("GST Component Code", '%1|%2', 'CESS', 'INTERCESS');
        if DetailedGSTLedgerEntry.FINDFIRST()then begin
            CesRt:=DetailedGSTLedgerEntry."GST %";
            if DetailedGSTLedgerEntry."GST %" <> 0 then CesAmt:=ABS(DetailedGSTLedgerEntry."GST Amount")
            else
                CesNonAdval:=ABS(DetailedGSTLedgerEntry."GST Amount");
        end;
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
        OthChrg:=0;
        GSTLedgerEntry.SETRANGE("Document No.", DocumentNo);
        case EWBType of EWBType::Sales: begin
            GSTLedgerEntry.SETRANGE("Transaction Type", GSTLedgerEntry."Transaction Type"::Sales);
            GSTLedgerEntry.SETRANGE("Posting Date", SalesInvoiceHeader."Posting Date");
            GSTLedgerEntry.SETRANGE("Document Type", GSTLedgerEntry."Document Type"::Invoice);
        end;
        EWBType::SalesReturn: begin
            GSTLedgerEntry.SETRANGE("Transaction Type", GSTLedgerEntry."Transaction Type"::Sales);
            GSTLedgerEntry.SETRANGE("Posting Date", SalesCrMemoHeader."Posting Date");
            GSTLedgerEntry.SETRANGE("Document Type", GSTLedgerEntry."Document Type"::"Credit Memo");
        end;
        EWBType::Purchase: begin
            GSTLedgerEntry.SETRANGE("Transaction Type", GSTLedgerEntry."Transaction Type"::Purchase);
            GSTLedgerEntry.SETRANGE("Posting Date", PurchCrMemoHeader."Posting Date");
            GSTLedgerEntry.SETRANGE("Document Type", GSTLedgerEntry."Document Type"::"Credit Memo");
        end;
        EWBType::Transfer: begin
            GSTLedgerEntry.SETRANGE("Transaction Type", GSTLedgerEntry."Transaction Type"::Sales);
            GSTLedgerEntry.SETRANGE("Posting Date", TransShipHeader."Posting Date");
            GSTLedgerEntry.SETRANGE("Document Type", GSTLedgerEntry."Document Type"::Invoice);
        end;
        end;
        GSTLedgerEntry.SETRANGE("GST Component Code", 'CGST');
        if GSTLedgerEntry.FINDSET()then begin
            repeat CgstVal+=ABS(GSTLedgerEntry."GST Amount");
            until GSTLedgerEntry.NEXT() = 0;
        end
        else
            CgstVal:=0;
        GSTLedgerEntry.SETRANGE("GST Component Code", 'SGST');
        if GSTLedgerEntry.FINDSET()then begin
            repeat SgstVal+=ABS(GSTLedgerEntry."GST Amount")until GSTLedgerEntry.NEXT() = 0;
        end
        else
            SgstVal:=0;
        GSTLedgerEntry.SETRANGE("GST Component Code", 'IGST');
        if GSTLedgerEntry.FINDSET()then begin
            repeat IgstVal+=ABS(GSTLedgerEntry."GST Amount")until GSTLedgerEntry.NEXT() = 0;
        end
        else
            IgstVal:=0;
        CesVal:=0;
        GSTLedgerEntry.SETFILTER("GST Component Code", '%1|%2', 'CESS', 'INTERCESS');
        if GSTLedgerEntry.FINDSET()then repeat CesVal+=ABS(GSTLedgerEntry."GST Amount")until GSTLedgerEntry.NEXT() = 0;
        CLEAR(TotLineAmt);
        case EWBType of EWBType::Sales: begin
            SalesInvoiceLine.SETRANGE("Document No.", DocumentNo);
            if SalesInvoiceLine.FINDSET()then repeat TotLineAmt+=SalesInvoiceLine."Line Amount";
                    //AssVal += SalesInvoiceLine."GST Base Amount";//BMS1.0
                    //TotGSTAmt += SalesInvoiceLine."Total GST Amount";//BMS1.0
                    if SalesInvoiceLine.Type = SalesInvoiceLine.Type::Item then ReturnGSTBaseAmount(SalesInvoiceLine."Document No.", SalesInvoiceLine."Line No.", AssVal); //BMS1.0
                    ReturnGSTAmount(SalesInvoiceLine."Document No.", SalesInvoiceLine."Line No.", TotGSTAmt); //BMS1.0
                    Disc+=SalesInvoiceLine."Inv. Discount Amount";
                until SalesInvoiceLine.NEXT() = 0;
            SalesInvoiceLine.SETRANGE(Type, SalesInvoiceLine.Type::"G/L Account");
            //SalesInvoiceLine.SETFILTER("No.", '%1|%2|%3', '2719', '9140', '9150');
            if SalesInvoiceLine.FINDFIRST()then repeat RndOffAmt+=SalesInvoiceLine."Line Amount";
                until SalesInvoiceLine.NEXT() = 0;
            SalesInvoiceLine.SETRANGE(Type, SalesInvoiceLine.Type::"Charge (Item)");
            if SalesInvoiceLine.FINDFIRST()then repeat RndOffAmt+=SalesInvoiceLine."Line Amount";
                until SalesInvoiceLine.NEXT() = 0;
            TotiInvValFc:=TotLineAmt + TotGSTAmt - Disc;
            TotLineAmt:=ROUND(CurrExchRate.ExchangeAmtFCYToLCY(SalesInvoiceHeader."Posting Date", SalesInvoiceHeader."Currency Code", TotLineAmt, SalesInvoiceHeader."Currency Factor"), 0.01, '=');
            AssVal:=ROUND(CurrExchRate.ExchangeAmtFCYToLCY(SalesInvoiceHeader."Posting Date", SalesInvoiceHeader."Currency Code", AssVal, SalesInvoiceHeader."Currency Factor"), 0.01, '=');
            TotGSTAmt:=ROUND(CurrExchRate.ExchangeAmtFCYToLCY(SalesInvoiceHeader."Posting Date", SalesInvoiceHeader."Currency Code", TotGSTAmt, SalesInvoiceHeader."Currency Factor"), 0.01, '=');
            Disc:=ROUND(CurrExchRate.ExchangeAmtFCYToLCY(SalesInvoiceHeader."Posting Date", SalesInvoiceHeader."Currency Code", Disc, SalesInvoiceHeader."Currency Factor"), 0.01, '=');
            TotInvVal:=TotLineAmt + TotGSTAmt - Disc;
        //OthChrg := 0;
        end;
        EWBType::SalesReturn: begin
            SalesCrMemoLine.SETRANGE("Document No.", DocumentNo);
            if SalesCrMemoLine.FINDSET()then begin
                repeat TotLineAmt+=SalesCrMemoLine."Line Amount";
                    //AssVal += SalesCrMemoLine."GST Base Amount";//BMS1.0
                    //TotGSTAmt += SalesCrMemoLine."Total GST Amount";//BMS1.0
                    ReturnGSTBaseAmount(SalesCrMemoLine."Document No.", SalesCrMemoLine."Line No.", AssVal); //BMS1.0
                    ReturnGSTAmount(SalesCrMemoLine."Document No.", SalesCrMemoLine."Line No.", TotGSTAmt); //BMS1.0
                    Disc+=SalesCrMemoLine."Inv. Discount Amount";
                until SalesCrMemoLine.NEXT() = 0;
            end;
            SalesCrMemoLine.SETRANGE(Type, SalesCrMemoLine.Type::"G/L Account");
            SalesCrMemoLine.SETFILTER("No.", '%1|%2|%3', '2719', '9140', '9150');
            if SalesCrMemoLine.FINDFIRST()then repeat RndOffAmt+=SalesCrMemoLine."Line Amount";
                until SalesCrMemoLine.NEXT() = 0;
            TotiInvValFc:=TotLineAmt + TotGSTAmt - Disc;
            TotLineAmt:=ROUND(CurrExchRate.ExchangeAmtFCYToLCY(SalesCrMemoHeader."Posting Date", SalesCrMemoHeader."Currency Code", TotLineAmt, SalesCrMemoHeader."Currency Factor"), 0.01, '=');
            AssVal:=ROUND(CurrExchRate.ExchangeAmtFCYToLCY(SalesCrMemoHeader."Posting Date", SalesCrMemoHeader."Currency Code", AssVal, SalesCrMemoHeader."Currency Factor"), 0.01, '=');
            TotGSTAmt:=ROUND(CurrExchRate.ExchangeAmtFCYToLCY(SalesCrMemoHeader."Posting Date", SalesCrMemoHeader."Currency Code", TotGSTAmt, SalesCrMemoHeader."Currency Factor"), 0.01, '=');
            Disc:=ROUND(CurrExchRate.ExchangeAmtFCYToLCY(SalesCrMemoHeader."Posting Date", SalesCrMemoHeader."Currency Code", Disc, SalesCrMemoHeader."Currency Factor"), 0.01, '=');
            TotInvVal:=TotLineAmt + TotGSTAmt - Disc;
            OthChrg:=0;
        end;
        EWBType::Purchase: begin
            PurchCrMemoLine.SETRANGE("Document No.", DocumentNo);
            if PurchCrMemoLine.FINDSET()then begin
                repeat TotLineAmt+=PurchCrMemoLine."Line Amount";
                    //AssVal += PurchCrMemoLine."GST Base Amount";//BMS1.0
                    //TotGSTAmt += PurchCrMemoLine."Total GST Amount";//BMS1.0
                    ReturnGSTBaseAmount(PurchCrMemoLine."Document No.", PurchCrMemoLine."Line No.", AssVal); //BMS1.0
                    ReturnGSTAmount(PurchCrMemoLine."Document No.", PurchCrMemoLine."Line No.", TotGSTAmt); //BMS1.0
                    Disc+=PurchCrMemoLine."Inv. Discount Amount";
                until PurchCrMemoLine.NEXT() = 0;
            end;
            PurchCrMemoLine.SETRANGE(Type, PurchCrMemoLine.Type::"G/L Account");
            PurchCrMemoLine.SETFILTER("No.", '%1|%2|%3', '2719', '9140', '9150');
            if PurchCrMemoLine.FINDFIRST()then repeat RndOffAmt+=PurchCrMemoLine."Line Amount";
                until PurchCrMemoLine.NEXT() = 0;
            TotiInvValFc:=TotLineAmt + TotGSTAmt - Disc;
            TotLineAmt:=ROUND(CurrExchRate.ExchangeAmtFCYToLCY(PurchCrMemoHeader."Posting Date", PurchCrMemoHeader."Currency Code", TotLineAmt, PurchCrMemoHeader."Currency Factor"), 0.01, '=');
            AssVal:=ROUND(CurrExchRate.ExchangeAmtFCYToLCY(PurchCrMemoHeader."Posting Date", PurchCrMemoHeader."Currency Code", AssVal, PurchCrMemoHeader."Currency Factor"), 0.01, '=');
            TotGSTAmt:=ROUND(CurrExchRate.ExchangeAmtFCYToLCY(PurchCrMemoHeader."Posting Date", PurchCrMemoHeader."Currency Code", TotGSTAmt, PurchCrMemoHeader."Currency Factor"), 0.01, '=');
            Disc:=ROUND(CurrExchRate.ExchangeAmtFCYToLCY(PurchCrMemoHeader."Posting Date", PurchCrMemoHeader."Currency Code", Disc, PurchCrMemoHeader."Currency Factor"), 0.01, '=');
            TotInvVal:=TotLineAmt + TotGSTAmt - Disc;
            OthChrg:=0;
        end;
        EWBType::Transfer: begin
            TransShipmentLine.SETRANGE("Document No.", DocumentNo);
            if TransShipmentLine.FINDSET()then repeat TotLineAmt+=TransShipmentLine.Amount;
                    //AssVal += TransShipmentLine."GST Base Amount";//BMS1.0
                    //TotGSTAmt += TransShipmentLine."Total GST Amount";//BMS1.0
                    ReturnGSTBaseAmount(TransShipmentLine."Document No.", TransShipmentLine."Line No.", AssVal); //BMS1.0
                    ReturnGSTAmount(TransShipmentLine."Document No.", TransShipmentLine."Line No.", TotGSTAmt); //BMS1.0
                    Disc:=0;
                    RndOffAmt:=0;
                    OthChrg:=0;
                    TotInvVal:=AssVal + TotGSTAmt;
                until TransShipmentLine.NEXT() = 0;
        end;
        end;
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
    local procedure ReturnGSTBaseAmount(DocumentNoBase: Code[20]; LineNo: Integer; var GSTBaseAmount: Decimal)
    var
        GSTLedger: Record "Detailed GST Ledger Entry";
    begin
        GSTLedger.Reset();
        GSTLedger.SetRange("Document No.", DocumentNoBase);
        if LineNo <> 0 then GSTLedger.SetRange("Document Line No.", LineNo);
        if GSTLedger.FindLast()then GSTBaseAmount+=abs(GSTLedger."GST Base Amount");
    end;
    local procedure ReturnGSTAmount(DocumentNoAmount: Code[20]; LineNo: Integer; var GSTAmount: Decimal)
    var
        GSTLedger: Record "Detailed GST Ledger Entry";
    begin
        GSTLedger.Reset();
        GSTLedger.SetRange("Document No.", DocumentNoAmount);
        if LineNo <> 0 then GSTLedger.SetRange("Document Line No.", LineNo);
        if GSTLedger.FindSet()then repeat GSTAmount+=abs(GSTLedger."GST Amount");
            until GSTLedger.Next() = 0;
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
        if SalesInvoiceLine2.FindSet()then repeat if ChargeAmt = 0 then begin
                    ChargeAmt:=SalesInvoiceLine2.Amount;
                    DetailedGSTLedgerEntry.Reset();
                    DetailedGSTLedgerEntry.SetRange("Document No.", SalesInvoiceLine2."Document No.");
                    DetailedGSTLedgerEntry.SetRange("Document Line No.", SalesInvoiceLine2."Line No.");
                    if DetailedGSTLedgerEntry.FindSet()then repeat ChargeGSTAmt+=DetailedGSTLedgerEntry."GST Amount";
                        until DetailedGSTLedgerEntry.Next() = 0;
                end;
            until SalesInvoiceLine2.Next = 0;
        SalesCrMemoLine2.SetRange("Document No.", DocNo);
        SalesCrMemoLine2.SetFilter("Line No.", '>%1', LineNo1);
        if SalesCrMemoLine2.FindSet()then repeat if ChargeAmt = 0 then begin
                    ChargeAmt:=SalesCrMemoLine2.Amount;
                    DetailedGSTLedgerEntry.Reset();
                    DetailedGSTLedgerEntry.SetRange("Document No.", SalesCrMemoLine2."Document No.");
                    DetailedGSTLedgerEntry.SetRange("Document Line No.", SalesCrMemoLine2."Line No.");
                    if DetailedGSTLedgerEntry.FindSet()then repeat ChargeGSTAmt+=DetailedGSTLedgerEntry."GST Amount";
                        until DetailedGSTLedgerEntry.Next() = 0;
                end;
            until SalesCrMemoLine2.Next = 0;
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
    var SalesInvoiceHeader: Record "Sales Invoice Header";
    SalesCrMemoHeader: Record "Sales Cr.Memo Header";
    PurchCrMemoHeader: Record "Purch. Cr. Memo Hdr.";
    TransShipHeader: Record "Transfer Shipment Header";
    SSDJsonArrayData: JsonArray;
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
    SSDJsonObject: JsonObject;
    SSDJsonText: Text;
    ChargeAmt: Decimal;
    ChargeGSTAmt: Decimal;
    ChargeLineNo: Integer;
    EnvironmentInformation: Codeunit "Environment Information";
    JsonArrayData: JsonArray;
}
