Report 50200 "Pending Indent"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Pending Indent.rdl';
    UsageCategory = ReportsandAnalysis;
    ApplicationArea = all;

    dataset
    {
        dataitem("Posted Indent Line"; "SSD Posted Indent Line")
        {
            DataItemTableView = sorting("Document No.", "Line No.")where("Pending PO Qty"=filter(<>0));
            PrintOnlyIfDetail = false;
            RequestFilterFields = "Document No.", "Shortcut Dimension 2 Code", "Indent Date", "Due Date";

            column(ReportForNavId_3692;3692)
            {
            }
            column(FORMAT_TODAY_0_4_; Format(Today, 0, 4))
            {
            }
            column(CurrReport_PAGENO; CurrReport.PageNo)
            {
            }
            column(UserId; UserId)
            {
            }
            column(rescen__Country_Region_Code_; rescen."Country/Region Code")
            {
            }
            column(rescen_City; rescen.City)
            {
            }
            column(rescen__Post_Code_; rescen."Post Code")
            {
            }
            column(rescen_State; rescen.State)
            {
            }
            column(rescen__Address_2_; rescen."Address 2")
            {
            }
            column(rescen_Address; rescen.Address)
            {
            }
            column(rescen_Name; rescen.Name)
            {
            }
            column(Posted_Indent_Line__Document_No__; "Document No.")
            {
            }
            column(Posted_Indent_Line__Posted_Indent_Line___Indent_Date_; "Posted Indent Line"."Indent Date")
            {
            }
            column(Posted_Indent_Line__Posted_Indent_Line___No__; "Posted Indent Line"."No.")
            {
            }
            column(VendNo; VendNo)
            {
            }
            column(Posted_Indent_Line__Posted_Indent_Line___Document_No__; "Posted Indent Line"."Document No.")
            {
            }
            column(Posted_Indent_Line__Posted_Indent_Line__Description; "Posted Indent Line".Description)
            {
            }
            column(Posted_Indent_Line__Posted_Indent_Line__Quantity; "Posted Indent Line".Quantity)
            {
            }
            column(Posted_Indent_Line__Posted_Indent_Line___Created_Doc__No__; "Posted Indent Line"."Created Doc. No.")
            {
            }
            column(VendName; VendName)
            {
            }
            column(QtyReceived; QtyReceived)
            {
            DecimalPlaces = 0: 2;
            }
            column(QtyOutStanding; QtyOutStanding)
            {
            DecimalPlaces = 0: 2;
            }
            column(PostingDate; PostingDate)
            {
            }
            column(POQTY; POQTY)
            {
            DecimalPlaces = 0: 2;
            }
            column(Posted_Indent_Line__Pending_PO_Qty_; "Pending PO Qty")
            {
            DecimalPlaces = 0: 2;
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(Pending_IndentCaption; Pending_IndentCaptionLbl)
            {
            }
            column(Purchase_Order_No_Caption; Purchase_Order_No_CaptionLbl)
            {
            }
            column(Item_No_Caption; Item_No_CaptionLbl)
            {
            }
            column(Item_Description_Caption; Item_Description_CaptionLbl)
            {
            }
            column(Vendor_No_Caption; Vendor_No_CaptionLbl)
            {
            }
            column(Vendor_NameCaption; Vendor_NameCaptionLbl)
            {
            }
            column(PO_DateCaption; PO_DateCaptionLbl)
            {
            }
            column(Indent_QuantityCaption; Indent_QuantityCaptionLbl)
            {
            }
            column(Received_PO_Qty_Caption; Received_PO_Qty_CaptionLbl)
            {
            }
            column(O_standing_PO_Qty_Caption; O_standing_PO_Qty_CaptionLbl)
            {
            }
            column(PO_Qty_Caption; PO_Qty_CaptionLbl)
            {
            }
            column(O_standing_Indent_Qty_Caption; O_standing_Indent_Qty_CaptionLbl)
            {
            }
            column(Indent_No_Caption; Indent_No_CaptionLbl)
            {
            }
            column(Indent_DateCaption; Indent_DateCaptionLbl)
            {
            }
            column(Posted_Indent_Line_Line_No_; "Line No.")
            {
            }
            column(Posted_Indent_Line_Type; Type)
            {
            }
            trigger OnPreDataItem()
            begin
                LastFieldNo:=FieldNo("Document No.");
            end;
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
        rescen.Get(UserMgt.GetRespCenterFilter);
    end;
    var LastFieldNo: Integer;
    FooterPrinted: Boolean;
    PurchaseLine: Record "Purchase Line";
    Vend: Record Vendor;
    QtyReceived: Decimal;
    QtyOutStanding: Decimal;
    VendNo: Code[20];
    VendName: Text[50];
    rescen: Record "Responsibility Center";
    UserMgt: Codeunit "SSD User Setup Management";
    PostingDate: Date;
    POQTY: Decimal;
    CurrReport_PAGENOCaptionLbl: label 'Page';
    Pending_IndentCaptionLbl: label 'Pending Indent';
    Purchase_Order_No_CaptionLbl: label 'Purchase Order No.';
    Item_No_CaptionLbl: label 'Item No.';
    Item_Description_CaptionLbl: label 'Item Description ';
    Vendor_No_CaptionLbl: label 'Vendor No.';
    Vendor_NameCaptionLbl: label 'Vendor Name';
    PO_DateCaptionLbl: label 'PO Date';
    Indent_QuantityCaptionLbl: label 'Indent Quantity';
    Received_PO_Qty_CaptionLbl: label 'Received PO Qty.';
    O_standing_PO_Qty_CaptionLbl: label 'O.standing PO Qty.';
    PO_Qty_CaptionLbl: label 'PO Qty.';
    O_standing_Indent_Qty_CaptionLbl: label 'O.standing Indent Qty.';
    Indent_No_CaptionLbl: label 'Indent No.';
    Indent_DateCaptionLbl: label 'Indent Date';
}
