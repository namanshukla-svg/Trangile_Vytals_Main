Report 50266 "Post Export Commercial Invoice"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Post Export Commercial Invoice.rdl';
    PreviewMode = PrintLayout;
    ApplicationArea = all;
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem(CopyLoop; "Integer")
        {
            DataItemTableView = sorting(Number)order(ascending);

            column(ReportForNavId_1000000000;1000000000)
            {
            }
            dataitem("Sales Invoice Header"; "Sales Invoice Header")
            {
                DataItemTableView = sorting("No.")order(ascending);
                RequestFilterFields = "No.";

                column(ReportForNavId_1000000001;1000000001)
                {
                }
                column(CompanyAddr1; CompanyAddr[1])
                {
                }
                column(CompanyAddr2; CompanyAddr[2])
                {
                }
                column(CompanyAddr3; CompanyAddr[3])
                {
                }
                column(CompanyAddr4; CompanyAddr[4])
                {
                }
                column(CompanyAddr5; CompanyAddr[5])
                {
                }
                column(CompanyAddr6; CompanyAddr[6])
                {
                }
                column(CompanyName; CompanyInfo.Name)
                {
                }
                column(CompAdd; CompanyInfo.Address)
                {
                }
                column(CompAdd2; CompanyInfo."Address 2")
                {
                }
                column(CompPostCode; CompanyInfo."Post Code")
                {
                }
                column(CompCity; CompanyInfo.City)
                {
                }
                column(CompState; CompState.Description)
                {
                }
                column(CompCountry; CompCountryRegion.Name)
                {
                }
                column(CompPhone; CompanyInfo."Phone No.")
                {
                }
                column(CompFAX; CompanyInfo."Fax No.")
                {
                }
                column(CompanyInfoPicture; CompanyInfo.Picture)
                {
                }
                column(CompRegNo; CompanyInfo."Company Registration  No.")
                {
                }
                column(RespCenter_IECCode; RespCenter."I.E.C. Code")
                {
                }
                column(IEDate; RespCenter.IEDate)
                {
                }
                column(GSTRegNo; CompanyInfo."GST Registration No.")
                {
                }
                column(ShipToAddr1; ShipToAddr[1])
                {
                }
                column(ShipToAddr2; ShipToAddr[2])
                {
                }
                column(ShipToAddr3ShipToAddr4; ShipToAddr[3] + ' ' + ShipToAddr[4])
                {
                }
                column(ShipToAddr5; ShipToAddr[5])
                {
                }
                column(GSTNo; Location."GST Registration No.")
                {
                }
                column(No; "No.")
                {
                }
                column(No_SalesInvoiceHeader; "Sales Invoice Header"."No.")
                {
                }
                column(CustName; Cust.Name)
                {
                }
                column(CustAdd; Cust.Address)
                {
                }
                column(CustAdd2; Cust."Address 2")
                {
                }
                column(CustCity; Cust.City)
                {
                }
                column(CustPhone; Cust."Phone No.")
                {
                }
                column(CustPostCode; Cust."Post Code")
                {
                }
                column(ExternalDocDate_SalesInvoiceHeader; "Sales Invoice Header"."External Doc. Date")
                {
                }
                column(CustCountry; CountryRegionCust.Name)
                {
                }
                column(CustAddr1; CustAddr[1])
                {
                }
                column(CustAddr2; CustAddr[2])
                {
                }
                column(CustAddr3CustAddr4; CustAddr[3] + ' ' + CustAddr[4])
                {
                }
                column(CustAddr5CustAddr6; CustAddr[5] + ' ' + CustAddr[6])
                {
                }
                column(PortofDischarge; "Port of Discharge")
                {
                }
                column(FinalDestination; "Final Destination")
                {
                }
                column(FinalDestination_SalesInvoiceHeader; "Sales Invoice Header"."Final Destination")
                {
                }
                column(VesselFlightNo_SalesInvoiceHeader; "Sales Invoice Header"."Vessel/Flight No.")
                {
                }
                column(PortofLading_SalesInvoiceHeader; "Sales Invoice Header"."Port of Lading")
                {
                }
                column(PlaceofReceiptbyPrecarr_SalesInvoiceHeader; "Sales Invoice Header"."Place of Receipt by Pre-carr")
                {
                }
                column(UPPERCASECountryName; UpperCase(Country.Name))
                {
                }
                column(ShipmentMethodDescription; ShipmentMethod.Description)
                {
                }
                column(PaymentTermDescription; PaymentTerm.Description)
                {
                }
                column(CurrencyCod; "Currency Code")
                {
                }
                column(RespCenterNameRespCenterCity; RespCenter.Name + ', ' + RespCenter.City)
                {
                }
                column(PostingDate_SalesInvoiceHeader; "Sales Invoice Header"."Posting Date")
                {
                }
                column(ExternalDocumentNo_SalesInvoiceHeader; "External Document No.")
                {
                }
                column(Mark1; Mark1)
                {
                }
                column(Mark2; Mark2)
                {
                }
                column(Mark3; Mark3)
                {
                }
                column(DescOption; DescOption)
                {
                }
                column(PreCarriageBy; "Sales Invoice Header"."GR No.")
                {
                }
                dataitem("Sales Invoice Line"; "Sales Invoice Line")
                {
                    DataItemLink = "Document No."=field("No.");
                    DataItemTableView = sorting("Document No.", "Line No.")order(ascending)where("No."=filter(<>'22045710'), Type=filter(<>" "));

                    column(ReportForNavId_1000000002;1000000002)
                    {
                    }
                    column(OrderLineNo_SalesInvoiceLine; "Sales Invoice Line"."Order Line No.")
                    {
                    }
                    column(LineNo_SalesInvoiceLine; "Sales Invoice Line"."Line No.")
                    {
                    }
                    column("COUNT"; "Sales Invoice Line".Count)
                    {
                    }
                    column(TxtCartonPalletNo; TxtCartonPalletNo)
                    {
                    }
                    column(ProductGroupDescription; ItemCategory.Description)
                    {
                    }
                    column(ProductGroupCode_SalesInvoiceLine; "Sales Invoice Line"."Item Category Code")
                    {
                    }
                    column(ItemVariantItemNo; ItemVariant."Item No.")
                    {
                    }
                    column(ItemNo; ItemNo)
                    {
                    }
                    column(VarientItemCode; VarientItemCode)
                    {
                    }
                    column(VarientItemDiscription; VarientItemDiscription)
                    {
                    }
                    column(SaleHeaderExternalDocumentNo; SaleHeader."External Document No.")
                    {
                    }
                    column(UnitofMeasure; "Unit of Measure")
                    {
                    }
                    column(UnitPrice; "Unit Price")
                    {
                    }
                    column(Quantity; Quantity)
                    {
                    }
                    column(LineAmount; "Line Amount")
                    {
                    }
                    column(No_SalesInvoiceLine; "Sales Invoice Line"."No.")
                    {
                    }
                    column(CrossReferenceNo_SalesInvoiceLine; "Sales Invoice Line"."Item Reference No.")
                    {
                    }
                    column(Description2_SalesInvoiceLine; "Sales Invoice Line"."Description 2")
                    {
                    }
                    column(Description_SalesInvoiceLine; "Sales Invoice Line".Description)
                    {
                    }
                    column(Quantity_S; "Sales Invoice Line".Quantity)
                    {
                    }
                    column(LineAmount_SalesInvoiceLine; "Sales Invoice Line"."Line Amount")
                    {
                    }
                    column(UnitPrice_S; "Sales Invoice Line"."Unit Price")
                    {
                    }
                    column(UnitofMeasure_SalesInvoiceLine; "Sales Invoice Line"."Unit of Measure Code")
                    {
                    }
                    column(InvDiscountAmount_SalesInvoiceLine; "Sales Invoice Line"."Inv. Discount Amount")
                    {
                    }
                    column(DocumentNo_SalesInvoiceLine; "Sales Invoice Line"."Document No.")
                    {
                    }
                    // column(GrandTotal1;"Sales Invoice Line"."Amount Including VAT"+Freight+"Sales Invoice Line"."Service Tax eCess Amount"+"Sales Invoice Line"."Service Tax SHE Cess Amount"+"Sales Invoice Line"."Service Tax Amount")
                    // {
                    // }
                    column(GrandTotal2; GTotal)
                    {
                    }
                    column(SRNo; SRNo)
                    {
                    }
                    column(LineAmountTotals; LineAmountTotal + Freight)
                    {
                    }
                    trigger OnAfterGetRecord()
                    begin
                        // IF "Sales Invoice Line"."No." <> '' THEN
                        //  SRNo -= 1;
                        SRNo:=SRNo + 1; //Alle 07022020
                        // GTotal += "Sales Invoice Line"."Amount To Customer";
                        InvDisc+="Sales Invoice Line"."Inv. Discount Amount";
                        if Type = "Sales Invoice Line".Type::Item then begin
                            // ExciseEntry.Reset;
                            // ExciseEntry.SetRange("Document Type",ExciseEntry."document type"::Invoice);
                            // ExciseEntry.SetRange(Type,ExciseEntry.Type::Sale);
                            // ExciseEntry.SetRange("Document No.","Document No.");
                            // ExciseEntry.SetRange("Item No.","No.");
                            // if ExciseEntry.Find('-') then begin
                            //    "Excise%":=ExciseEntry."BED %";
                            //    "Ecess%":=ExciseEntry."eCess %";
                            //    "SHECess%":=ExciseEntry."SHE Cess %";
                            // end;
                            TotalNetWeight+=Quantity * "Sales Invoice Line"."Net Weight";
                        end;
                        if not tmpItemUOM.Get('', "Unit of Measure")then begin
                            tmpItemUOM.Init;
                            tmpItemUOM.Code:="Unit of Measure";
                            tmpItemUOM."Qty. per Unit of Measure":=Quantity;
                            tmpItemUOM.Insert;
                        end
                        else
                        begin
                            tmpItemUOM."Qty. per Unit of Measure"+=Quantity;
                            tmpItemUOM.Modify;
                        end;
                        if not RecItem.Get("No.")then RecItem.Init;
                        if "Variant Code" = '' then begin
                            ItemNo:="No.";
                            VarientItemCode:=RecItem."Description 3";
                            //VarientItemDiscription:=Description+' '+"Description 2";
                            VarientItemDiscription:="Sales Invoice Line"."Item Reference No." end
                        else
                        begin
                            if ItemVariant.Get("No.", "Variant Code")then begin
                                ItemNo:=ItemVariant."Item No.";
                                VarientItemCode:=RecItem."Description 3";
                            //VarientItemDiscription:=ItemVariant."Customer Item Code";
                            end;
                        end;
                        // if not ItemCategory.Get("Item Category Code","Product Group Code") then ItemCategory.Init;
                        // FreightText:='';
                        // if "Sales Invoice Line"."Charges To Customer">0 then FreightText:='Freight';
                        // if "Sales Invoice Line"."Charges To Customer" < 0 then
                        //   Freight := 0
                        // else begin
                        //   PostedStructureOrderDetails.Reset;
                        //   PostedStructureOrderDetails.SetRange(Type,PostedStructureOrderDetails.Type::Sale);
                        //   PostedStructureOrderDetails.SetRange("Document Type",PostedStructureOrderDetails."document type"::Invoice);
                        //   PostedStructureOrderDetails.SetRange("No.","Sales Invoice Line"."Document No.");
                        //   PostedStructureOrderDetails.SetRange("Tax/Charge Type",PostedStructureOrderDetails."tax/charge type"::Charges);
                        //   if PostedStructureOrderDetails.FindFirst then
                        //     Freight := PostedStructureOrderDetails."Calculation Value";
                        // end;
                        LineAmountTotal+="Sales Invoice Line"."Line Amount" - "Sales Invoice Line"."Inv. Discount Amount";
                        RptCheck.InitTextVariable;
                        RptCheck.FormatNoText(InvAmountTxt, (LineAmountTotal + Freight), "Sales Invoice Header"."Currency Code");
                    end;
                    trigger OnPreDataItem()
                    begin
                        LineAmountTotal:=0;
                        //SRNo := "Sales Invoice Line".COUNT;
                        SRNo:=0; //Alle 07022020
                    end;
                }
                dataitem(Gap; "Integer")
                {
                    DataItemTableView = sorting(Number)order(ascending);

                    column(ReportForNavId_1000000003;1000000003)
                    {
                    }
                    dataitem(UOMQty; "Integer")
                    {
                        DataItemLinkReference = "Sales Invoice Header";
                        DataItemTableView = sorting(Number)order(ascending);

                        column(ReportForNavId_1000000005;1000000005)
                        {
                        }
                        column(InvAmountTxt1InvAmountTxt2; InvAmountTxt[1] + ' ' + InvAmountTxt[2])
                        {
                        }
                        column(InvAmountTxt; InvAmountTxt[1])
                        {
                        }
                        trigger OnAfterGetRecord()
                        begin
                            if Number = 1 then tmpItemUOM.FindFirst
                            else
                                tmpItemUOM.Next;
                        // decGrandTotal := "Sales Invoice Line"."Amount Including VAT"+Freight+"Sales Invoice Line"."Service Tax eCess Amount"+"Sales Invoice Line"."Service Tax SHE Cess Amount"+"Sales Invoice Line"."Service Tax Amount";
                        // if ("Sales Invoice Line"."Service Tax eCess Amount"+"Sales Invoice Line"."Service Tax SHE Cess Amount"+
                        //   "Sales Invoice Line"."Service Tax Amount"<>0) then
                        //   IsVisible := true
                        // else
                        //   IsVisible := false;
                        end;
                        trigger OnPreDataItem()
                        begin
                            SetRange(Number, 1, tmpItemUOM.Count);
                        end;
                    }
                    trigger OnPreDataItem()
                    begin
                        SetRange(Gap.Number, 1, 33 - (SRNo) - tmpItemUOM.Count);
                    end;
                }
                trigger OnAfterGetRecord()
                var
                    tmpItem: Record Item temporary;
                begin
                    CountryRegion.SetRange(Code, CompanyInfo."Country/Region Code");
                    if CountryRegion.FindFirst then;
                    if "Sales Invoice Header"."Posting Date" > 20181130D then begin
                        BankDetail1:=Text003;
                        BankDetail2:=Text004;
                    end
                    else
                    begin
                        BankDetail1:=Text001;
                        BankDetail2:=Text002;
                    end;
                    if Location.Get("Sales Invoice Header"."Location Code")then;
                    tmpItemUOM.DeleteAll;
                    if not RespCenter.Get("Responsibility Center")then RespCenter.Init;
                    Clear(CompanyAddr);
                    CompanyAddr[1]:=RespCenter.Name;
                    CompanyAddr[2]:=RespCenter.Address;
                    // CompanyAddr[3] := RespCenter."Address 2";
                    CompanyAddr[3]:=RespCenter."Address 2" + ' - 122413, Haryana, INDIA';
                    //CompanyAddr[4] := RespCenter.City + ',' + RespCenter."Post Code";
                    CompanyAddr[5]:='Phone: ' + RespCenter."Phone No." + ', Fax: ' + RespCenter."Fax No.";
                    if not Country.Get(RespCenter."Country/Region Code")then Country.Init;
                    CompanyAddr[6]:=Country.Name;
                    Clear(CustAddr);
                    Clear(ShipToAddr);
                    CompressArray(CompanyAddr);
                    Cust.Get("Bill-to Customer No.");
                    if "Ship-to Code" = '' then begin
                        FormatAddr.SalesInvBillTo(ShipToAddr, "Sales Invoice Header");
                        if Cust."Phone No." <> '' then ShipToAddr[6]:='PH.:' + Cust."Phone No.";
                        if Cust."Fax No." <> '' then ShipToAddr[6]+=' FAX :' + Cust."Fax No.";
                        CustAddr[1]:='SAME AS CONSIGNEE' end
                    else
                    begin
                        FormatAddr.SalesInvBillTo(CustAddr, "Sales Invoice Header");
                        if Cust."Phone No." <> '' then CustAddr[6]:='PH.:' + Cust."Phone No.";
                        if Cust."Fax No." <> '' then CustAddr[6]+=' FAX :' + Cust."Fax No.";
                        FormatAddr.SalesInvShipTo(ShipToAddr, CustAddr, "Sales Invoice Header");
                        if RShiptoAddr.Get("Sell-to Customer No.", "Ship-to Code")then begin
                            if RShiptoAddr."Phone No." <> '' then ShipToAddr[6]:='PH.:' + RShiptoAddr."Phone No.";
                            if RShiptoAddr."Phone No." <> '' then ShipToAddr[6]+=' FAX :' + RShiptoAddr."Fax No.";
                        end;
                    end;
                    CompressArray(CustAddr);
                    CompressArray(ShipToAddr);
                    if CountryRegionCust.Get(Cust."Country/Region Code")then;
                    if not Country.Get(RespCenter."Country/Region Code")then Country.Init;
                    pos:=Cust.Name;
                    FirstWord:=StrPos(pos, ' ');
                    Mark4:=CopyStr(pos, 1, FirstWord);
                    Mark1:=Mark4 + '-' + CountryRegionCust.Name;
                    //Mark1 := Cust.Name + '-' + CountryRegionCust.Name;
                    Mark2:='ZAVENIR - ' + CompCountryRegion.Name;
                    Mark3:='PALLET ' + PalletNo;
                    SRNo:=0;
                    NoofCarton:=0;
                    TotalNetWeight:=0;
                    if not ShipmentMethod.Get("Shipment Method Code")then ShipmentMethod.Init;
                    if not PaymentTerm.Get("Payment Terms Code")then PaymentTerm.Init;
                    RptCheck.InitTextVariable;
                    GTotal:=0;
                    InvDisc:=0;
                end;
                trigger OnPreDataItem()
                begin
                    BankDetail1:='';
                    BankDetail2:='';
                end;
            }
            trigger OnAfterGetRecord()
            begin
                CompanyInfo.CalcFields(Picture);
                case CopyLoop.Number of 1: CopyText:='Original for Buyer';
                2: CopyText:='Transporter Copy';
                3: CopyText:='3 Copy';
                4: CopyText:='For Office Use';
                end;
            end;
            trigger OnPreDataItem()
            begin
                NoOfLoops:=Abs(NoOfCopies) + Cust."Invoice Copies" + 1;
                if NoOfLoops <= 0 then NoOfLoops:=1;
                CopyText:='';
                SetRange(Number, 1, NoOfLoops);
                if CompState.Get(CompanyInfo."State Code")then;
                if CompCountryRegion.Get(CompanyInfo."Country/Region Code")then;
            end;
        }
    }
    requestpage
    {
        layout
        {
            area(content)
            {
                field("Pallet No."; PalletNo)
                {
                    ApplicationArea = Basic;
                }
                field(Description; DescOption)
                {
                    ApplicationArea = Basic;
                }
            }
        }
        actions
        {
        }
    }
    labels
    {
    }
    trigger OnPreReport()
    begin
        CompanyInfo.Get;
        CompanyInfo.CalcFields(Picture);
    end;
    var NoOfCopies: Integer;
    NoOfLoops: Integer;
    Cust: Record Customer;
    CopyText: Text[50];
    FormatAddr: Codeunit "Format Address";
    CustAddr: array[8]of Text[100];
    CompanyAddr: array[8]of Text[100];
    CompanyInfo: Record "Company Information";
    RespCenter: Record "Responsibility Center";
    SRNo: Integer;
    // ExciseEntry: Record UnknownRecord13712;
    "Excise%": Decimal;
    "Ecess%": Decimal;
    "SHECess%": Decimal;
    RptCheck: Report Check;
    InvAmountTxt: array[2]of Text[80];
    BedAmountTxt: array[2]of Text[80];
    ShipmentMethod: Record "Shipment Method";
    PaymentTerm: Record "Payment Terms";
    TotalNetWeight: Decimal;
    NoofCarton: Decimal;
    FromCartonNo: Text[30];
    UptoCartonNo: Text[30];
    ShipToAddr: array[8]of Text[100];
    ShowShippingAddr: Boolean;
    ItemCategory: Record "Item Category";
    Country: Record "Country/Region";
    tmpItemUOM: Record "Item Unit of Measure" temporary;
    ItemVariant: Record "Item Variant";
    VarientItemCode: Text[30];
    VarientItemDiscription: Text[60];
    RecItem: Record Item;
    RShiptoAddr: Record "Ship-to Address";
    TxtCartonPalletNo: Text[200];
    NoofPallet: Decimal;
    FreightText: Text[30];
    SaleHeader: Record "Sales Header";
    NoofLooseCarton: Decimal;
    Freight: Decimal;
    // PostedStructureOrderDetails: Record UnknownRecord13760;
    ItemNo: Code[20];
    PackingText: Text[1024];
    IsVisible: Boolean;
    decGrandTotal: Decimal;
    Visibility: Boolean;
    ProdVisible: Boolean;
    CompState: Record State;
    TQty: Text[1024];
    GTotal: Decimal;
    InvDisc: Decimal;
    LineAmountTotal: Decimal;
    Text001: label 'KOTAK MAHINDRA BANK LTD., SCO-91, URBAN ESTATE, SEC - 22, GURGAON - 122015, HARYANA, INDIA';
    Text002: label 'A/C No. 592044001430  IFSC Code.  KKBK0004260 Swift Code - KKBKINBBCPC';
    Text003: label 'DBS BANK INDIA LTD., CAPITOL POINT, BABA KHARAK SINGH MARG, CONNAUGHT PLACE, NEW DELHI, INDIA';
    Text004: label 'Account No. : 820200166485   IFSC Code : DBSS0IN0811   Swift Code : DBSSINBB';
    BankDetail1: Text;
    BankDetail2: Text;
    CountryRegion: Record "Country/Region";
    CompCountryRegion: Record "Country/Region";
    CountryRegionCust: Record "Country/Region";
    Location: Record Location;
    Mark1: Text;
    Mark2: Text;
    Mark3: Text;
    pos: Text;
    FirstWord: Integer;
    Mark4: Text;
    PalletNo: Text[30];
    DescOption: Option " ", "INDUSTRIAL LDPE VCI IMPRIGNATED BAGS & SHEETS";
}
