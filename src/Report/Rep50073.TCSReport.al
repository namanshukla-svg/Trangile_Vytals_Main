Report 50073 "TCS Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/TCS Report.rdl';
    ApplicationArea = all;
    UsageCategory = Administration;

    dataset
    {
        dataitem("TCS Entry"; "TCS Entry")
        {
            DataItemTableView = sorting("Document No.", "Posting Date")order(ascending);
            RequestFilterFields = "TCS Nature of Collection", "Posting Date";

            column(ReportForNavId_8102;8102)
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
            column(TCS_Entry__TCS_Entry___TCS_Nature_of_Collection_; "TCS Entry"."TCS Nature of Collection")
            {
            }
            column(TCS_Entry__Assessee_Code_; "Assessee Code")
            {
            }
            column(TCS_Entry__TCS_Amount_; "TCS Amount")
            {
            }
            column(TCS_Entry__TCS___; "TCS %")
            {
            }
            column(TCS_Entry__TCS_Base_Amount_; "TCS Base Amount")
            {
            }
            column(BillNo; BillNo)
            {
            }
            column(TCS_Entry__TCS_Entry___Party_P_A_N__No__; "TCS Entry"."Customer P.A.N. No.")
            {
            }
            column(PartyName; "TCS Entry".Description)
            {
            }
            column(TCS_Entry__Posting_Date_; "Posting Date")
            {
            }
            column(TCS_Entry__Document_No__; "Document No.")
            {
            }
            column(TCS_Entry__TCS_Base_Amount__Control1000000019; "TCS Base Amount")
            {
            }
            column(TCS_Entry__TCS_Amount__Control1000000020; "TCS Amount")
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(TCS_SummaryCaption; TCS_SummaryCaptionLbl)
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
            column(TCS_RateCaption; TCS_RateCaptionLbl)
            {
            }
            column(TCS_Amt_Caption; TCS_Amt_CaptionLbl)
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
            column(TCS_Entry_Entry_No_; "Entry No.")
            {
            }
            trigger OnAfterGetRecord()
            begin
                // if Format("Account Type") <> '' then
                // begin
                //   if Format("TCS Entry"."Party Type") = 'Party' then
                //   begin
                //       PartyRec.Get("Party Code");
                //       PartyName:=PartyRec.Name;
                //   end;
                //   if Format("TCS Entry"."Party Type") = 'Customer' then
                //   begin
                //     Vend.Get("Party Code");
                //     PartyName:=Vend.Name;
                //   end;
                // end
                // else
                //   PartyName:='';
                VendLedEntry.SetRange(VendLedEntry."Document No.", "TCS Entry"."Document No.");
                if VendLedEntry.FindFirst then if VendLedEntry."External Document No." <> '' then BillNo:=VendLedEntry."External Document No."
                    else
                        BillNo:='';
            end;
            trigger OnPreDataItem()
            begin
                CurrReport.CreateTotals("TCS Entry"."TCS Base Amount", "TCS Entry"."TCS Amount");
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
    var BillNo: Code[30];
    PartyName: Text[50];
    VendLedEntry: Record "Cust. Ledger Entry";
    Vend: Record Customer;
    PartyRec: Record Party;
    ResCen: Record "Responsibility Center";
    UserMgt: Codeunit "User Setup Management";
    CurrReport_PAGENOCaptionLbl: label 'Page';
    TCS_SummaryCaptionLbl: label 'TCS Summary';
    ERP_Voucher_No_CaptionLbl: label 'ERP Voucher No.';
    DateCaptionLbl: label 'Date';
    Party_NameCaptionLbl: label 'Party Name';
    P_A_N__No_CaptionLbl: label 'P.A.N. No.';
    Taxable_Amt_CaptionLbl: label 'Taxable Amt.';
    TCS_RateCaptionLbl: label 'TCS Rate';
    TCS_Amt_CaptionLbl: label 'TCS Amt.';
    StatusCaptionLbl: label 'Status';
    Party_Bill_No_CaptionLbl: label 'Party Bill No.';
    TotalCaptionLbl: label 'Total';
}
