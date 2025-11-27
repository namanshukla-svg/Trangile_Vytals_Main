Report 50074 "OTIF-Incoming Shipments"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/OTIF-Incoming Shipments.rdl';
    UsageCategory = ReportsandAnalysis;
    ApplicationArea = all;

    dataset
    {
        dataitem("Purchase Header"; "Purchase Header")
        {
            DataItemTableView = sorting("Document Type", "No.")order(ascending)where("Document Type"=const(Order));
            PrintOnlyIfDetail = true;
            RequestFilterFields = "No.", "Order Date", "Buy-from Vendor No.", "Vendor Posting Group";

            column(ReportForNavId_4458;4458)
            {
            }
            column(UserId; UserId)
            {
            }
            column(CompanyAddr_1_1; ReportFilters)
            {
            }
            column(CurrReport_PAGENO; CurrReport.PageNo)
            {
            }
            column(FORMAT_TODAY_0_4_; Format(Today, 0, 4))
            {
            }
            column(CompanyAddr_1_; CompInfo.Name)
            {
            }
            column(Purchase_Header__Order_Date_; "Order Date")
            {
            }
            column(Purchase_Header__Purchase_Header___No__; "Purchase Header"."No.")
            {
            }
            column(Purchase_Header__Purchase_Header___Pay_to_Name_; "Purchase Header"."Pay-to Name")
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
            column(Received_DateCaption; Received_DateCaptionLbl)
            {
            }
            column(Promised_DateCaption; Promised_DateCaptionLbl)
            {
            }
            column(Received_Qty_Caption; Received_Qty_CaptionLbl)
            {
            }
            column(Net_Qty__to_be_ReceivedCaption; Net_Qty__to_be_ReceivedCaptionLbl)
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
            column(PO_Date_or_Amendment_DateCaption; PO_Date_or_Amendment_DateCaptionLbl)
            {
            }
            column(Purchase_Order_No__or_Subcontracting_Order_No_Caption; Purchase_Order_No__or_Subcontracting_Order_No_CaptionLbl)
            {
            }
            column(Vendor_NameCaption; Vendor_NameCaptionLbl)
            {
            }
            column(Purchase_Header_Document_Type; "Document Type")
            {
            }
            dataitem("Purchase Line"; "Purchase Line")
            {
                DataItemLink = "Document No."=field("No.");
                DataItemTableView = sorting("Document Type", "Document No.", "Line No.")order(ascending)where("Document Type"=const(Order), Type=const(Item));
                RequestFilterFields = "Item Category Code", "No.";

                column(ReportForNavId_6547;6547)
                {
                }
                column(Description______Description_2_; Description + ' ' + "Description 2")
                {
                }
                column(Purchase_Line_Quantity; Quantity)
                {
                }
                column(ShortCloseQty; ShortCloseQty)
                {
                }
                column(NetQtyToBeRcvd; NetQtyToBeRcvd)
                {
                }
                column(ReceivedQty; ReceivedQty)
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
                column(PromisedDate; PromisedDate)
                {
                }
                column(ReceivedDate; ReceivedDate)
                {
                }
                column(Purchase_Line_Document_Type; "Document Type")
                {
                }
                column(Purchase_Line_Document_No_; "Document No.")
                {
                }
                column(Purchase_Line_Line_No_; "Line No.")
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
        if "Purchase Header".GetFilters <> '' then ReportFilters:="Purchase Header".GetFilters;
        TempVar:=0;
        TempVar2:=0;
        TempVar3:=0;
        GTOTIFRate:=0;
        GTOTIFRate2:=0;
    end;
    var CompInfo: Record "Company Information";
    ReportFilters: Text[150];
    PurchRcptLine: Record "Purch. Rcpt. Line";
    ShortCloseQty: Decimal;
    NetQtyToBeRcvd: Decimal;
    GroupTotNetQtyToBeRcvd: Decimal;
    FinTotNetQtyToBeRcvd: Decimal;
    ReceivedQty: Decimal;
    PODate: Date;
    PromisedDate: Date;
    ReceivedDate: Date;
    DaysDelays: Integer;
    OTIFRate: Decimal;
    OTIFRate2: Decimal;
    OTOTIFRate: Decimal;
    OTOTIFRate2: Decimal;
    GTOTIFRate: Decimal;
    GTOTIFRate2: Decimal;
    BasicPrice: Decimal;
    PurchaseLineArchive: Record "Purchase Line Archive";
    TempVar: Decimal;
    TempVar2: Decimal;
    BasicPriceGpTot: Decimal;
    TempVar3: Decimal;
    CurrReport_PAGENOCaptionLbl: label 'Page';
    Gate_Entry_ListCaptionLbl: label 'For Incoming Shipments - Vendor Shipments';
    OTIF_Rate_By_Value__Basic_Value_on_SO__CaptionLbl: label 'OTIF Rate(By Value -Basic Value on SO )';
    OTIF_Rate_by_Qty___Item_Wise_on_SO__CaptionLbl: label 'OTIF Rate(by Qty. -Item Wise on SO )';
    Days_DelayCaptionLbl: label 'Days Delay';
    Received_DateCaptionLbl: label 'Received Date';
    Promised_DateCaptionLbl: label 'Promised Date';
    Received_Qty_CaptionLbl: label 'Received Qty.';
    Net_Qty__to_be_ReceivedCaptionLbl: label 'Net Qty. to be Received';
    Short_Close_Qty_CaptionLbl: label 'Short Close Qty.';
    Ordered_Qty_CaptionLbl: label 'Ordered Qty.';
    Item_DescriptionCaptionLbl: label 'Item Description';
    PO_Date_or_Amendment_DateCaptionLbl: label 'PO Date or Amendment Date';
    Purchase_Order_No__or_Subcontracting_Order_No_CaptionLbl: label 'Purchase Order No. or Subcontracting Order No.';
    Vendor_NameCaptionLbl: label 'Vendor Name';
}
