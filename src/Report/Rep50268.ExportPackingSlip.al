Report 50268 "Export Packing Slip"
{
    DefaultLayout = RDLC;
    Caption = 'Export Packing Slip';
    RDLCLayout = './Layouts/Export Packing Slip.rdl';
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
            dataitem("Sales Header"; "Sales Header")
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
                column(CompPostCode; CompanyInfo."Post Code")
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
                column(No_SalesInvoiceHeader; "No.")
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
                column(ExternalDocDate_SalesInvoiceHeader; "External Doc. Date")
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
                column(VesselFlightNo_SalesInvoiceHeader; "Vessel/Flight No.")
                {
                }
                column(PortofLading_SalesInvoiceHeader; "Port of Lading")
                {
                }
                column(PlaceofReceiptbyPrecarr_SalesInvoiceHeader; "Place of Receipt by Pre-carr")
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
                column(PostingDate_SalesInvoiceHeader; "Posting Date")
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
                column(PallatNo; PallatNo)
                {
                }
                column(DescOption; DescOption)
                {
                }
                column(InvoiceDate; SalesInvoiceHeader."Posting Date")
                {
                }
                column(InvoiceNo; SalesInvoiceHeader."No.")
                {
                }
                column(NoOfPallets; NoOfPallets)
                {
                }
                column(PalletGrossWt; PalletGrossWt)
                {
                }
                column(PreCarriageBy; "Sales Header"."GR No.")
                {
                }
                dataitem("Sales Line"; "Sales Line")
                {
                    DataItemLink = "Document No."=field("No."), "Document Type"=field("Document Type");
                    DataItemTableView = sorting("Document No.", "Line No.", "Document Type")order(descending)where("No."=filter(<>'22045710'));

                    column(ReportForNavId_1000000002;1000000002)
                    {
                    }
                    column(LineNo_SalesLine; "Sales Line"."Line No.")
                    {
                    }
                    column("COUNT"; Count)
                    {
                    }
                    column(TxtCartonPalletNo; TxtCartonPalletNo)
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
                    column(No_SalesInvoiceLine; "No.")
                    {
                    }
                    column(Description2_SalesInvoiceLine; "Description 2")
                    {
                    }
                    column(Description_SalesInvoiceLine; Description)
                    {
                    }
                    column(Quantity_S; Quantity)
                    {
                    }
                    column(LineAmount_SalesInvoiceLine; "Line Amount")
                    {
                    }
                    column(UnitPrice_S; "Unit Price")
                    {
                    }
                    column(UnitofMeasure_SalesInvoiceLine; "Unit of Measure Code")
                    {
                    }
                    column(InvDiscountAmount_SalesInvoiceLine; "Inv. Discount Amount")
                    {
                    }
                    column(DocumentNo_SalesInvoiceLine; "Document No.")
                    {
                    }
                    column(GrandTotal2; GTotal)
                    {
                    }
                    column(SRNo; SRNo)
                    {
                    }
                    column(LineAmountTotals; LineAmountTotal + Freight)
                    {
                    }
                    column(NetWeight_SalesLine; "Sales Line"."Actual Wt")
                    {
                    }
                    column(GrossWeight_SalesLine; "Sales Line"."Gross Wt")
                    {
                    }
                    column(CrossReferenceNo_SalesLine; "Sales Line"."Item Reference No.")
                    {
                    }
                    column(OrderLineNo_SalesLine; "Sales Line"."Order Line No.")
                    {
                    }
                    trigger OnAfterGetRecord()
                    begin
                        // IF "Sales Line"."No." <> '' THEN
                        //  SRNo -= 1;
                        SRNo:=SRNo + 1; //Alle 07022020
                        //SSDU GTotal += "Sales Line"."Amount To Customer";
                        InvDisc+="Sales Line"."Inv. Discount Amount";
                        if Type = "Sales Line".Type::Item then begin
                            TotalNetWeight+=Quantity * "Sales Line"."Net Weight";
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
                            VarientItemDiscription:="Sales Line"."Item Reference No." end
                        else
                        begin
                            if ItemVariant.Get("No.", "Variant Code")then begin
                                ItemNo:=ItemVariant."Item No.";
                                VarientItemCode:=RecItem."Description 3";
                            //VarientItemDiscription:=ItemVariant."Customer Item Code";
                            end;
                        end;
                        //SSDU if not ProductGroup.Get("Item Category Code", "Product Group Code") then ProductGroup.Init;
                        FreightText:='';
                        //SSDU Start
                        // if "Sales Line"."Charges To Customer" > 0 then FreightText := 'Freight';
                        // if "Sales Line"."Charges To Customer" < 0 then
                        //     Freight := 0
                        // else begin
                        //     PostedStructureOrderDetails.Reset;
                        //     PostedStructureOrderDetails.SetRange(Type, PostedStructureOrderDetails.Type::Sale);
                        //     PostedStructureOrderDetails.SetRange("Document Type", PostedStructureOrderDetails."document type"::Invoice);
                        //     PostedStructureOrderDetails.SetRange("No.", "Sales Line"."Document No.");
                        //     PostedStructureOrderDetails.SetRange("Tax/Charge Type", PostedStructureOrderDetails."tax/charge type"::Charges);
                        //     if PostedStructureOrderDetails.FindFirst then
                        //         Freight := PostedStructureOrderDetails."Calculation Value";
                        // end;
                        //SSDU End
                        LineAmountTotal+="Sales Line"."Line Amount" - "Sales Line"."Inv. Discount Amount";
                        RptCheck.InitTextVariable;
                        RptCheck.FormatNoText(InvAmountTxt, (LineAmountTotal + Freight), "Sales Header"."Currency Code");
                        SalesInvoiceLine.Reset;
                        SalesInvoiceLine.SetRange("Despatch Slip No.", "Sales Header"."No.");
                        if SalesInvoiceLine.FindFirst then SalesInvoiceHeader.Reset;
                        SalesInvoiceHeader.SetRange("No.", SalesInvoiceLine."Document No.");
                        if SalesInvoiceHeader.FindFirst then;
                    end;
                    trigger OnPreDataItem()
                    begin
                        LineAmountTotal:=0;
                        SalesLine.Reset;
                        SalesLine.SetRange("Document No.", "Sales Header"."No.");
                        SalesLine.SetRange("Document Type", "Sales Header"."Document Type");
                        SalesLine.SetFilter("No.", '<>%1', '');
                        // IF SalesLine.FINDSET THEN
                        //  SRNo := SalesLine.COUNT + 1;
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
                        DataItemLinkReference = "Sales Header";
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
                            decGrandTotal:="Sales Line"."Amount Including VAT" + Freight;
                            IsVisible:=false;
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
                    if "Sales Header"."Posting Date" > 20181130D then begin
                        BankDetail1:=Text003;
                        BankDetail2:=Text004;
                    end
                    else
                    begin
                        BankDetail1:=Text001;
                        BankDetail2:=Text002;
                    end;
                    if Location.Get("Sales Header"."Location Code")then;
                    tmpItemUOM.DeleteAll;
                    if not RespCenter.Get("Responsibility Center")then RespCenter.Init;
                    Clear(CompanyAddr);
                    CompanyAddr[1]:=RespCenter.Name;
                    CompanyAddr[2]:=RespCenter.Address;
                    CompanyAddr[3]:=RespCenter."Address 2" + ' - 122413, Haryana, INDIA';
                    //CompanyAddr[4] := //RespCenter.City + ',' + RespCenter."Post Code";
                    CompanyAddr[5]:='Phone: ' + RespCenter."Phone No." + ', Fax: ' + RespCenter."Fax No.";
                    if not Country.Get(RespCenter."Country/Region Code")then Country.Init;
                    CompanyAddr[6]:=Country.Name;
                    Clear(CustAddr);
                    Clear(ShipToAddr);
                    CompressArray(CompanyAddr);
                    Cust.Get("Bill-to Customer No.");
                    if "Ship-to Code" = '' then begin
                        FormatAddr.SalesHeaderBillTo(ShipToAddr, "Sales Header");
                        if Cust."Phone No." <> '' then ShipToAddr[6]:='PH.:' + Cust."Phone No.";
                        if Cust."Fax No." <> '' then ShipToAddr[6]+=' FAX :' + Cust."Fax No.";
                        CustAddr[1]:='SAME AS CONSIGNEE' end
                    else
                    begin
                        FormatAddr.SalesHeaderBillTo(CustAddr, "Sales Header");
                        if Cust."Phone No." <> '' then CustAddr[6]:='PH.:' + Cust."Phone No.";
                        if Cust."Fax No." <> '' then CustAddr[6]+=' FAX :' + Cust."Fax No.";
                        //SSDU FormatAddr.SalesHeaderShipTo(ShipToAddr, "Sales Header");
                        if RShiptoAddr.Get("Sell-to Customer No.", "Ship-to Code")then begin
                            if RShiptoAddr."Phone No." <> '' then ShipToAddr[6]:='PH.:' + RShiptoAddr."Phone No.";
                            if RShiptoAddr."Phone No." <> '' then ShipToAddr[6]+=' FAX :' + RShiptoAddr."Fax No.";
                        end;
                    end;
                    CompressArray(CustAddr);
                    CompressArray(ShipToAddr);
                    if CountryRegionCust.Get(Cust."Country/Region Code")then;
                    if not Country.Get(RespCenter."Country/Region Code")then Country.Init;
                    Mark1:=CopyStr(Cust.Name, 1, StrPos(Cust.Name, ' ')) + '-' + CountryRegionCust.Name;
                    Mark2:='ZAVENIR - ' + CompCountryRegion.Name;
                    Mark3:='PALLET ' + PallatNo;
                    SRNo:=0;
                    NoofCarton:=0;
                    TotalNetWeight:=0;
                    if not ShipmentMethod.Get("Shipment Method Code")then ShipmentMethod.Init;
                    if not PaymentTerm.Get("Payment Terms Code")then PaymentTerm.Init;
                    if NoofPallet > 0 then begin
                        if NoofLooseCarton > 0 then TxtCartonPalletNo:=Format(NoofPallet + NoofLooseCarton) + ' PACKAGES (' + Format(NoofPallet) + ' PALLETS + ' + Format(NoofLooseCarton) + ' LOOSE CARTONS)'
                        else
                            TxtCartonPalletNo:=Format(NoofPallet) + ' PALLETS ( ' + Format(NoofCarton) + ' CARTONS )';
                    end
                    else
                        TxtCartonPalletNo:=Format(NoofCarton) + ' CARTONS';
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
                field("Pallat No."; PallatNo)
                {
                    ApplicationArea = All;
                }
                field(Description; DescOption)
                {
                    ApplicationArea = All;
                }
                field(NoOfPallets; NoOfPallets)
                {
                    ApplicationArea = All;
                    Caption = 'No Of Pallets';
                }
                field(PalletGrossWt; PalletGrossWt)
                {
                    ApplicationArea = All;
                    Caption = 'Pallet Gross Wt';
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
    CustAddr: array[8]of Text[50];
    CompanyAddr: array[8]of Text[50];
    CompanyInfo: Record "Company Information";
    RespCenter: Record "Responsibility Center";
    SRNo: Integer;
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
    ShipToAddr: array[8]of Text[50];
    ShowShippingAddr: Boolean;
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
    PallatNo: Text[20];
    DescOption: Option " ", "INDUSTRIAL LDPE VCI IMPRIGNATED BAGS & SHEETS";
    SalesInvoiceHeader: Record "Sales Invoice Header";
    SalesInvoiceLine: Record "Sales Invoice Line";
    NoOfPallets: Text;
    PalletGrossWt: Decimal;
    SalesLine: Record "Sales Line";
}
