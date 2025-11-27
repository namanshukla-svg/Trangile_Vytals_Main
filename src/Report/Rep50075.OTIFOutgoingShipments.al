Report 50075 "OTIF-Outgoing Shipments"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/OTIF-Outgoing Shipments.rdl';
    UsageCategory = ReportsandAnalysis;
    ApplicationArea = all;

    dataset
    {
        dataitem("Sales Header"; "Sales Header")
        {
            DataItemTableView = sorting("Document Type", "No.")order(ascending)where("Document Type"=const(Order), "Document Subtype"=const(Order));
            PrintOnlyIfDetail = true;
            RequestFilterFields = "No.", "Order Date", "Sell-to Customer No.", "Customer Posting Group", "Salesperson Code";

            column(ReportForNavId_6640;6640)
            {
            }
            column(UserId; UserId)
            {
            }
            column(CurrReport_PAGENO; CurrReport.PageNo)
            {
            }
            column(FORMAT_TODAY_0_4_; Format(Today, 0, 4))
            {
            }
            column(CompanyAddr_1_1; ReportFilters)
            {
            }
            column(CompanyAddr_1_; CompInfo.Name)
            {
            }
            column(Sales_Header__No__; "No.")
            {
            }
            column(Sales_Header__Order_Date_; "Order Date")
            {
            }
            column(Sales_Header__Bill_to_Name_; "Bill-to Name")
            {
            }
            column(OTOTIFRate; OTOTIFRate)
            {
            }
            column(OTOTIFRate2; OTOTIFRate2)
            {
            }
            column(GTOTIFRate; GTOTIFRate)
            {
            }
            column(GTOTIFRate2; GTOTIFRate2)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(Gate_Entry_ListCaption; Gate_Entry_ListCaptionLbl)
            {
            }
            column(OTIF_Rate_By_Value__Basic_Value_on_SO__Caption; OTIF_Rate_By_Value__Basic_Value_on_SO__CaptionLbl)
            {
            }
            column(OTIF_Rate_by_Qty___Item_Wise_on_SO__Caption; OTIF_Rate_by_Qty___Item_Wise_on_SO__CaptionLbl)
            {
            }
            column(Days_DelayCaption; Days_DelayCaptionLbl)
            {
            }
            column(Delivered_DateCaption; Delivered_DateCaptionLbl)
            {
            }
            column(Promised_DateCaption; Promised_DateCaptionLbl)
            {
            }
            column(Delivered_Qty_Caption; Delivered_Qty_CaptionLbl)
            {
            }
            column(Net_Qty__to_be_DeliveredCaption; Net_Qty__to_be_DeliveredCaptionLbl)
            {
            }
            column(Short_Close_Qty_Caption; Short_Close_Qty_CaptionLbl)
            {
            }
            column(Ordered_Qty_Caption; Ordered_Qty_CaptionLbl)
            {
            }
            column(Item_DescriptionCaption; Item_DescriptionCaptionLbl)
            {
            }
            column(SO_Date_or_Amendment_DateCaption; SO_Date_or_Amendment_DateCaptionLbl)
            {
            }
            column(Sales_Order_No_Caption; Sales_Order_No_CaptionLbl)
            {
            }
            column(Customer_NameCaption; Customer_NameCaptionLbl)
            {
            }
            column(Gate_Entry_ListCaption1; Gate_Entry_ListCaption1Lbl)
            {
            }
            column(Gate_Entry_ListCaption2; Gate_Entry_ListCaption2Lbl)
            {
            }
            column(Sales_Header_Document_Type; "Document Type")
            {
            }
            dataitem("Sales Line"; "Sales Line")
            {
                DataItemLink = "Document No."=field("No.");
                DataItemTableView = sorting("Document Type", "Document No.", "Line No.")order(ascending)where("Document Type"=const(Order), Type=const(Item));
                RequestFilterFields = "Item Category Code", "No.";

                column(ReportForNavId_2844;2844)
                {
                }
                column(Description________Description_2_; Description + ' & ' + "Description 2")
                {
                }
                column(Sales_Line_Quantity; Quantity)
                {
                }
                column(ShortCloseQty; ShortCloseQty)
                {
                }
                column(NetQtyToBeRcvd; NetQtyToBeRcvd)
                {
                }
                column(DeliveredQty; DeliveredQty)
                {
                }
                column(DaysDelays; DaysDelays)
                {
                }
                column(OTIFRate; OTIFRate)
                {
                }
                column(OTIFRate2; OTIFRate2)
                {
                }
                column(Promised_Date; PromisedDate)
                {
                }
                column(DeliverededDate; DeliverededDate)
                {
                }
                column(Sales_Line_Document_Type; "Document Type")
                {
                }
                column(Sales_Line_Document_No_; "Document No.")
                {
                }
                column(Sales_Line_Line_No_; "Line No.")
                {
                }
            }
        }
    }
    requestpage
    {
        layout
        {
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
        CompInfo.Get;
        if "Sales Header".GetFilters <> '' then ReportFilters:="Sales Header".GetFilters;
        TempVar:=0;
        TempVar2:=0;
        TempVar3:=0;
        GTOTIFRate:=0;
        GTOTIFRate2:=0;
    end;
    var CompInfo: Record "Company Information";
    ReportFilters: Text[150];
    SalesShipmentLine: Record "Sales Shipment Line";
    ShortCloseQty: Decimal;
    NetQtyToBeRcvd: Decimal;
    DeliveredQty: Decimal;
    PromisedDate: Date;
    DeliverededDate: Date;
    DaysDelays: Integer;
    BasicPrice: Decimal;
    OTIFRate: Decimal;
    OTIFRate2: Decimal;
    SalesLineArchieve: Record "Sales Line Archive";
    SalesLine: Record "Sales Line";
    DespatchNO: Code[20];
    OTOTIFRate: Decimal;
    OTOTIFRate2: Decimal;
    GTOTIFRate: Decimal;
    GTOTIFRate2: Decimal;
    TempVar: Decimal;
    TempVar2: Decimal;
    BasicPriceGpTot: Decimal;
    TempVar3: Decimal;
    FinTotNetQtyToBeRcvd: Decimal;
    GroupTotNetQtyToBeRcvd: Decimal;
    CurrReport_PAGENOCaptionLbl: label 'Page';
    Gate_Entry_ListCaptionLbl: label 'For Outgoing Shipments - Customer Shipments';
    OTIF_Rate_By_Value__Basic_Value_on_SO__CaptionLbl: label 'OTIF Rate(By Value -Basic Value on SO )';
    OTIF_Rate_by_Qty___Item_Wise_on_SO__CaptionLbl: label 'OTIF Rate(by Qty. -Item Wise on SO )';
    Days_DelayCaptionLbl: label 'Days Delay';
    Delivered_DateCaptionLbl: label 'Delivered Date';
    Promised_DateCaptionLbl: label 'Promised Date';
    Delivered_Qty_CaptionLbl: label 'Delivered Qty.';
    Net_Qty__to_be_DeliveredCaptionLbl: label 'Net Qty. to be Delivered';
    Short_Close_Qty_CaptionLbl: label 'Short Close Qty.';
    Ordered_Qty_CaptionLbl: label 'Ordered Qty.';
    Item_DescriptionCaptionLbl: label 'Item Description';
    SO_Date_or_Amendment_DateCaptionLbl: label 'SO Date or Amendment Date';
    Sales_Order_No_CaptionLbl: label 'Sales Order No.';
    Customer_NameCaptionLbl: label 'Customer Name';
    Gate_Entry_ListCaption1Lbl: label 'TOTAL';
    Gate_Entry_ListCaption2Lbl: label 'GRAND TOTAL';
}
