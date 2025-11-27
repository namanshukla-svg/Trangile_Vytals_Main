Report 50184 "Indent Tracking New"
{
    // Vipin 17.03.08 new report taking care of aging
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Indent Tracking New.rdl';
    UsageCategory = ReportsandAnalysis;
    ApplicationArea = all;

    dataset
    {
        dataitem("Posted Indent Header"; "SSD Posted Indent Header")
        {
            DataItemTableView = sorting("Posting Date");
            RequestFilterFields = "Posting Date", "No.";

            column(ReportForNavId_8065;8065)
            {
            }
            column(FORMAT_TODAY_0_4_; Format(Today, 0, 4))
            {
            }
            column(COMPANYNAME; COMPANYNAME)
            {
            }
            column(CurrReport_PAGENO; CurrReport.PageNo)
            {
            }
            column(UserId; UserId)
            {
            }
            column(Datefilter; Datefilter)
            {
            }
            column(rescen_Name; rescen.Name)
            {
            }
            column(Posted_Indent_HeaderCaption; Posted_Indent_HeaderCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(Pend_POQtyCaption; Pend_POQtyCaptionLbl)
            {
            }
            column(QuantityCaption; QuantityCaptionLbl)
            {
            }
            column(DescriptionCaption; DescriptionCaptionLbl)
            {
            }
            column(No_Caption; No_CaptionLbl)
            {
            }
            column(Indent_No_Caption; Indent_No_CaptionLbl)
            {
            }
            column(Posting_Dt_Caption; Posting_Dt_CaptionLbl)
            {
            }
            column(Due_DaysCaption; Due_DaysCaptionLbl)
            {
            }
            column(Indent_Dt_Caption; Indent_Dt_CaptionLbl)
            {
            }
            column(Purchase_Order_No_Caption; Purchase_Order_No_CaptionLbl)
            {
            }
            column(Order_Dt_Caption; Order_Dt_CaptionLbl)
            {
            }
            column(Vendor_NameCaption; Vendor_NameCaptionLbl)
            {
            }
            column(PO_QtyCaption; PO_QtyCaptionLbl)
            {
            }
            column(Rec__QtyCaption; Rec__QtyCaptionLbl)
            {
            }
            column(Pend_IndQtyCaption; Pend_IndQtyCaptionLbl)
            {
            }
            column(UserIDCaption; UserIDCaptionLbl)
            {
            }
            column(Posted_Indent_Header_No_; "No.")
            {
            }
            column(Posted_Indent_Header_Posting_Date; "Posting Date")
            {
            }
            dataitem("Posted Indent Line"; "SSD Posted Indent Line")
            {
                DataItemLink = "Document No."=field("No.");
                DataItemTableView = where(Type=const("Fixed Asset"));

                column(ReportForNavId_3692;3692)
                {
                }
                column(PostedIndentHEader__Posting_Date_; PostedIndentHEader."Posting Date")
                {
                }
                column(Posted_Indent_Line__Document_No__; "Document No.")
                {
                }
                column(Posted_Indent_Line__No__; "No.")
                {
                }
                column(Posted_Indent_Line_Description; Description)
                {
                }
                column(Posted_Indent_Line_Quantity; Quantity)
                {
                }
                column(Posted_Indent_Line__Pending_PO_Qty_; "Pending PO Qty")
                {
                }
                column(TODAY_PostedIndentHEader__Posting_Date_; Today - PostedIndentHEader."Posting Date")
                {
                }
                column(Posted_Indent_Line__Indent_Date_; "Indent Date")
                {
                }
                column(Posted_Indent_Line__Posted_Indent_Line___Created_Doc__No__; "Posted Indent Line"."Created Doc. No.")
                {
                }
                column(PurchaseLine__Posting_Date_; PurchaseLine."Posting Date")
                {
                }
                column(Vendname; Vendname)
                {
                }
                column(POQty; POQty)
                {
                }
                column(QtyReceived; QtyReceived)
                {
                }
                column(Posted_Indent_Line__Pending_PO_Qty__Control1000000033; "Pending PO Qty")
                {
                }
                column(PostedIndentHEader__User_ID_; PostedIndentHEader."User ID")
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
                    if(PendingIndent = true)then SetFilter("Pending PO Qty", '<>%1', 0);
                end;
            }
            trigger OnAfterGetRecord()
            begin
                if(PendingIndent = true)then begin
                    PostedIndentLine.SetRange(PostedIndentLine."Document No.", "Posted Indent Header"."No.");
                    PostedIndentLine.SetRange(PostedIndentLine.Type, PostedIndentLine.Type::"Fixed Asset");
                    PostedIndentLine.SetFilter(PostedIndentLine."Pending PO Qty", '<>%1', 0);
                    if not PostedIndentLine.Find('-')then CurrReport.Skip;
                end;
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
        Datefilter:="Posted Indent Header".GetFilter("Posted Indent Header"."Indent Date");
    end;
    var PostedIndentLine: Record "SSD Posted Indent Line";
    PostedIndentHEader: Record "SSD Posted Indent Header";
    Vend: Record Vendor;
    PurchaseLine: Record "Purchase Line";
    VendNo: Code[20];
    PostingDate: Date;
    QtyOutstanding: Decimal;
    Vendname: Text[80];
    QtyReceived: Decimal;
    POQty: Decimal;
    rescen: Record "Responsibility Center";
    UserMgt: Codeunit "SSD User Setup Management";
    Datefilter: Text[50];
    PendingIndent: Boolean;
    Posted_Indent_HeaderCaptionLbl: label 'Posted Indent Header';
    CurrReport_PAGENOCaptionLbl: label 'Page';
    Pend_POQtyCaptionLbl: label 'Pend POQty';
    QuantityCaptionLbl: label 'Quantity';
    DescriptionCaptionLbl: label 'Description';
    No_CaptionLbl: label 'No.';
    Indent_No_CaptionLbl: label 'Indent No.';
    Posting_Dt_CaptionLbl: label 'Posting Dt.';
    Due_DaysCaptionLbl: label 'Due Days';
    Indent_Dt_CaptionLbl: label 'Indent Dt.';
    Purchase_Order_No_CaptionLbl: label 'Purchase Order No.';
    Order_Dt_CaptionLbl: label 'Order Dt.';
    Vendor_NameCaptionLbl: label 'Vendor Name';
    PO_QtyCaptionLbl: label 'PO Qty';
    Rec__QtyCaptionLbl: label 'Rec. Qty';
    Pend_IndQtyCaptionLbl: label 'Pend IndQty';
    UserIDCaptionLbl: label 'UserID';
}
