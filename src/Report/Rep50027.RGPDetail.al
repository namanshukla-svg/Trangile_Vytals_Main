Report 50027 "RGP Detail"
{
    // CML-016 DKU 100108
    //   - Adding field "No.","Advising Employee" and "Advising Name' and Formating of fields.
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/RGP Detail.rdl';
    UsageCategory = Lists;
    ApplicationArea = all;

    dataset
    {
        dataitem("RGP Header"; "SSD RGP Header")
        {
            DataItemTableView = sorting("No.", NRGP)order(ascending)where(NRGP=filter(false));
            PrintOnlyIfDetail = true;
            RequestFilterFields = "No.", "Posting Date", "Responsibility Center", "Party No.";

            column(ReportForNavId_6494;6494)
            {
            }
            column(FORMAT_TODAY_0_4_; Format(Today, 0, 4))
            {
            }
            column(CurrReport_PAGENO; CurrReport.PageNo)
            {
            }
            column(comp_Name________comp__Name_2_; comp.Name + '  ' + comp."Name 2")
            {
            }
            column(RGP_Header__GETFILTERS; "RGP Header".GetFilters)
            {
            }
            column(RGP_Header__No__; "No.")
            {
            }
            column(RGP_Header__Party_Name_; "Party Name")
            {
            }
            column(S_No__; "S.No.")
            {
            }
            column(RGP_Header__Shipment_Date_; "Shipment Date")
            {
            }
            column(RGP_Header__Receipt_Date_; "Receipt Date")
            {
            }
            column(DimensionValue_Name; DimensionValue.Name)
            {
            }
            column(RGP_Header__Advising_Employee_; "Advising Employee")
            {
            }
            column(RGP_Header__Party_Name_Caption; FieldCaption("Party Name"))
            {
            }
            column(RGP__Code__________Ship_Date__Caption; RGP__Code__________Ship_Date__CaptionLbl)
            {
            }
            column(S_No_Caption; S_No_CaptionLbl)
            {
            }
            column(Recd_QtyCaption; Recd_QtyCaptionLbl)
            {
            }
            column(Sent_QtyCaption; Sent_QtyCaptionLbl)
            {
            }
            column(Item_NameCaption; Item_NameCaptionLbl)
            {
            }
            column(RGP_Pending_Detail__Date_WiseCaption; RGP_Pending_Detail__Date_WiseCaptionLbl)
            {
            }
            column(Bal_QtyCaption; Bal_QtyCaptionLbl)
            {
            }
            column(Rcpt__DateCaption; Rcpt__DateCaptionLbl)
            {
            }
            column(RGP_Header_Document_Type; "Document Type")
            {
            }
            dataitem("RGP Line"; "SSD RGP Line")
            {
                DataItemLink = "Document No."=field("No.");
                DataItemTableView = sorting("Document Type", "Document No.", "Line No.")order(ascending);
                RequestFilterFields = "No.", Type;

                column(ReportForNavId_7724;7724)
                {
                }
                column(RGP_Line_Description; Description)
                {
                }
                column(RGP_Line__Quantity_Shipped_; "Quantity Shipped")
                {
                DecimalPlaces = 0: 5;
                }
                column(RGP_Line__Quantity_Received_; "Quantity Received")
                {
                DecimalPlaces = 2: 5;
                }
                column(RGP_Line__Outstanding_Rcpt__Quantity_; "Outstanding Rcpt. Quantity")
                {
                DecimalPlaces = 0: 5;
                }
                column(RGP_Line__No__; "No.")
                {
                }
                column(RGP_Line_Document_Type; "Document Type")
                {
                }
                column(RGP_Line_Document_No_; "Document No.")
                {
                }
                column(RGP_Line_Line_No_; "Line No.")
                {
                }
                trigger OnPreDataItem()
                begin
                    if SendQty = true then begin
                        if BalQuantity <= 0 then CurrReport.Skip;
                        if BalQuantity = 0 then CurrReport.Skip;
                    end;
                    if "Outstanding Rcpt. Quantity" > 0 then flag:=1
                    else
                        flag:=0;
                end;
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
        comp.Get();
    end;
    var "S.No.": Integer;
    comp: Record "Company Information";
    flag: Integer;
    rgpline: Record "SSD RGP Line";
    BalQuantity: Decimal;
    SendQty: Boolean;
    DimensionValue: Record "Dimension Value";
    AdEmployeeName: Text[100];
    RGP__Code__________Ship_Date__CaptionLbl: label ' RGP. Code          Ship Date  ';
    S_No_CaptionLbl: label 'S.No.';
    Recd_QtyCaptionLbl: label 'Recd Qty';
    Sent_QtyCaptionLbl: label 'Sent Qty';
    Item_NameCaptionLbl: label 'Item Name';
    RGP_Pending_Detail__Date_WiseCaptionLbl: label 'RGP Pending Detail, Date Wise';
    Bal_QtyCaptionLbl: label 'Bal Qty';
    Rcpt__DateCaptionLbl: label 'Rcpt. Date';
}
