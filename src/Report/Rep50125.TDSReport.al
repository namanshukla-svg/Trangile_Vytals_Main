Report 50125 "TDS Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/TDS Report.rdl';
    PreviewMode = PrintLayout;
    ApplicationArea = all;
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem("TDS Entry"; "TDS Entry")
        {
            DataItemTableView = sorting("Document No.", "Posting Date")order(ascending);

            // RequestFilterFields = "TDS Nature of Deduction", "Party Type", "Posting Date";
            column(ReportForNavId_6446;6446)
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
            column(ResCen_City_______ResCen__Post_Code_; ResCen.City + ' - ' + ResCen."Post Code")
            {
            }
            column(ResCen__Address_2_; ResCen."Address 2")
            {
            }
            column(ResCen_State; ResCen.State)
            {
            }
            column(ResCen_Address; ResCen.Address)
            {
            }
            column(ResCen_Name; ResCen.Name)
            {
            }
            column(TDS_Entry__TDS_Entry___TDS_Nature_of_Deduction_;'')
            {
            }
            column(TDS_Entry__Assessee_Code_; "Assessee Code")
            {
            }
            column(TDS_Entry__TDS_Amount_; "TDS Amount")
            {
            }
            column(TDS_Entry__TDS___; "TDS %")
            {
            }
            column(TDS_Entry__TDS_Base_Amount_; "TDS Base Amount")
            {
            }
            column(BillNo; BillNo)
            {
            }
            column(TDS_Entry__Deductee_P_A_N__No__; "Deductee PAN No.")
            {
            }
            column(PartyName; PartyName)
            {
            }
            column(TDS_Entry__Posting_Date_; "Posting Date")
            {
            }
            column(TDS_Entry__Document_No__; "Document No.")
            {
            }
            column(TDS_Entry__TDS_Base_Amount__Control1000000019; "TDS Base Amount")
            {
            }
            column(TDS_Entry__TDS_Amount__Control1000000020; "TDS Amount")
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(TDS_SummaryCaption; TDS_SummaryCaptionLbl)
            {
            }
            column(ERP_Voucher_No_Caption; ERP_Voucher_No_CaptionLbl)
            {
            }
            column(DateCaption; DateCaptionLbl)
            {
            }
            column(Party_NameCaption; Party_NameCaptionLbl)
            {
            }
            column(P_A_N__No_Caption; P_A_N__No_CaptionLbl)
            {
            }
            column(Taxable_Amt_Caption; Taxable_Amt_CaptionLbl)
            {
            }
            column(TDS_RateCaption; TDS_RateCaptionLbl)
            {
            }
            column(TDS_Amt_Caption; TDS_Amt_CaptionLbl)
            {
            }
            column(StatusCaption; StatusCaptionLbl)
            {
            }
            column(Party_Bill_No_Caption; Party_Bill_No_CaptionLbl)
            {
            }
            column(TotalCaption; TotalCaptionLbl)
            {
            }
            column(TDS_Entry_Entry_No_; "Entry No.")
            {
            }
            trigger OnAfterGetRecord()
            begin
                if Format("Party Type") <> '' then begin
                    if Format("TDS Entry"."Party Type") = 'Party' then begin
                        PartyRec.Get("Party Code");
                        PartyName:=PartyRec.Name;
                    end;
                    if Format("TDS Entry"."Party Type") = 'Vendor' then begin
                        Vend.Get("Party Code");
                        PartyName:=Vend.Name;
                    end;
                end
                else
                    PartyName:='';
                VendLedEntry.SetRange(VendLedEntry."Document No.", "TDS Entry"."Document No.");
                if VendLedEntry.FindFirst then if VendLedEntry."External Document No." <> '' then BillNo:=VendLedEntry."External Document No."
                    else
                        BillNo:='';
            end;
            trigger OnPreDataItem()
            begin
                CurrReport.CreateTotals("TDS Entry"."TDS Base Amount", "TDS Entry"."TDS Amount");
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
    // ResCen.Get(UserMgt.GetRespCenterFilter);
    end;
    var BillNo: Code[35];
    PartyName: Text[100];
    VendLedEntry: Record "Vendor Ledger Entry";
    Vend: Record Vendor;
    PartyRec: Record Party;
    ResCen: Record "Responsibility Center";
    UserMgt: Codeunit "User Setup Management";
    CurrReport_PAGENOCaptionLbl: label 'Page';
    TDS_SummaryCaptionLbl: label 'TDS Summary';
    ERP_Voucher_No_CaptionLbl: label 'ERP Voucher No.';
    DateCaptionLbl: label 'Date';
    Party_NameCaptionLbl: label 'Party Name';
    P_A_N__No_CaptionLbl: label 'P.A.N. No.';
    Taxable_Amt_CaptionLbl: label 'Taxable Amt.';
    TDS_RateCaptionLbl: label 'TDS Rate';
    TDS_Amt_CaptionLbl: label 'TDS Amt.';
    StatusCaptionLbl: label 'Status';
    Party_Bill_No_CaptionLbl: label 'Party Bill No.';
    TotalCaptionLbl: label 'Total';
}
