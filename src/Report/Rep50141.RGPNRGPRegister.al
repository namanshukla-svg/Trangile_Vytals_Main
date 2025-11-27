Report 50141 "RGP/NRGP Register"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/RGPNRGP Register.rdl';
    UsageCategory = ReportsandAnalysis;
    ApplicationArea = all;

    dataset
    {
        dataitem("RGP Line"; "SSD RGP Line")
        {
            DataItemTableView = sorting("Document Type", "Document No.", "Line No.");
            RequestFilterFields = "Document No.", "No.", NRGP, "Party No.";

            column(ReportForNavId_7724;7724)
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
            column(RGP_Line__Document_No__; "Document No.")
            {
            }
            column(RGP_Line__No__; "No.")
            {
            }
            column(RGP_Line_Quantity; Quantity)
            {
            }
            column(RGP_Line__Party_No__; "Party No.")
            {
            }
            column(VendorName; VendorName)
            {
            }
            column(RGP_NRGP_LedgerCaption; RGP_NRGP_LedgerCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(Document_No_Caption; Document_No_CaptionLbl)
            {
            }
            column(Item_No_Caption; Item_No_CaptionLbl)
            {
            }
            column(Party_No_Caption; Party_No_CaptionLbl)
            {
            }
            column(Party_NameCaption; Party_NameCaptionLbl)
            {
            }
            column(QuantityCaption; QuantityCaptionLbl)
            {
            }
            column(RGP_Line_Document_Type; "Document Type")
            {
            }
            column(RGP_Line_Line_No_; "Line No.")
            {
            }
            trigger OnPreDataItem()
            begin
                LastFieldNo:=FieldNo("Document Type");
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
    var LastFieldNo: Integer;
    FooterPrinted: Boolean;
    Vendor: Record Vendor;
    VendorName: Text[50];
    RGP_NRGP_LedgerCaptionLbl: label 'RGP/NRGP Ledger';
    CurrReport_PAGENOCaptionLbl: label 'Page';
    Document_No_CaptionLbl: label 'Document No.';
    Item_No_CaptionLbl: label 'Item No.';
    Party_No_CaptionLbl: label 'Party No.';
    Party_NameCaptionLbl: label 'Party Name';
    QuantityCaptionLbl: label 'Quantity';
}
