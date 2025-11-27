Report 50013 "RTGS Document-Pre"
{
    // ALLE 2.15....NEFT/RTGS
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/RTGS Document-Pre.rdl';
    UsageCategory = ReportsandAnalysis;
    ApplicationArea = all;

    dataset
    {
        dataitem("Gen. Journal Line"; "Gen. Journal Line")
        {
            DataItemTableView = sorting("Journal Template Name", "Journal Batch Name", "Posting Date", "Document No.")where("Transfer Type"=filter(RTGS), "Vendor Bank Account"=filter(<>''), "NEFT / RTGS Code"=filter(<>''));
            RequestFilterFields = "Document No.";

            column(ReportForNavId_7024;7024)
            {
            }
            column(CompInfo_Name; CompInfo.Name)
            {
            }
            column(RespCent_Address______RespCent__Address_2_; RespCent.Address + '  ' + RespCent."Address 2")
            {
            }
            column(RespCent__Address_2________RespCent_City_____RespCent__Post_Code_; RespCent."Address 2" + ' | ' + RespCent.City + ' ' + RespCent."Post Code")
            {
            }
            column(Fax____FORMAT_RespCent__Fax_No___;'Fax  ' + Format(RespCent."Fax No."))
            {
            }
            column(Phone____FORMAT_RespCent__Phone_No___;'Phone  ' + Format(RespCent."Phone No."))
            {
            }
            column(Email____RespCent__E_Mail________RespCent__Home_Page_;'Email  ' + RespCent."E-Mail" + ' | ' + RespCent."Home Page")
            {
            }
            column(CompInfo_Picture; CompInfo.Picture)
            {
            }
            column(CompInfo_Picture_Control1000000064; CompInfo.Picture)
            {
            }
            column(Date____FORMAT__Posting_Date__0_4_;'Date: ' + Format("Posting Date", 0, 4))
            {
            }
            column(Ref__________Our_Account_No____BankAcc__Bank_Account_No_____with_you_;'Ref       :  Our Account No. ' + BankAcc."Bank Account No." + ' with you')
            {
            }
            column(vend_Name; vend.Name)
            {
            }
            column(vend_Address______vend__Address_2________vend_City_______vend__State_Code_; vend.Address + '  ' + vend."Address 2" + ' , ' + vend.City + ' , ' + vend."State Code")
            {
            }
            column(VendBankAcc__Bank_Account_No__; VendBankAcc."Bank Account No.")
            {
            }
            column(VendBankAcc_Name; VendBankAcc.Name)
            {
            }
            column(VendBankAcc_Address______VendBankAcc__Address_2_; VendBankAcc.Address + '  ' + VendBankAcc."Address 2")
            {
            }
            column(NoInText_1_; NoInText[1])
            {
            }
            column(VendBankAcc_City; VendBankAcc.City)
            {
            }
            column(Gen__Journal_Line__NEFT___RTGS_Code_; "NEFT / RTGS Code")
            {
            }
            column(Gen__Journal_Line_Amount; Amount)
            {
            }
            column(CompInfo_Name_Control1000000043; CompInfo.Name)
            {
            }
            column(The_ManagerCaption; The_ManagerCaptionLbl)
            {
            }
            column(Barclays_Bank_PlcCaption; Barclays_Bank_PlcCaptionLbl)
            {
            }
            column(Nehru_PlaceCaption; Nehru_PlaceCaptionLbl)
            {
            }
            column(Gr____First_Floor__Eros_Corporate_TowerCaption; Gr____First_Floor__Eros_Corporate_TowerCaptionLbl)
            {
            }
            column(New_Delhi__110019Caption; New_Delhi__110019CaptionLbl)
            {
            }
            column(Dear_Sir_Caption; Dear_Sir_CaptionLbl)
            {
            }
            column(Sub__________Real_Time_Gross_Settlement__RTGS__Fund_Transfer_ApplicationCaption; Sub__________Real_Time_Gross_Settlement__RTGS__Fund_Transfer_ApplicationCaptionLbl)
            {
            }
            column(Kindly_transfer_fund_through_RTGS_to_the_beneficiary_as_detail_given_hereunder_Caption; Kindly_transfer_fund_through_RTGS_to_the_beneficiary_as_detail_given_hereunder_CaptionLbl)
            {
            }
            column(Beneficiary_Details_Caption; Beneficiary_Details_CaptionLbl)
            {
            }
            column(Beneficiary_NameCaption; Beneficiary_NameCaptionLbl)
            {
            }
            column(Beneficiary_AddressCaption; Beneficiary_AddressCaptionLbl)
            {
            }
            column(Beneficiary_BankCaption; Beneficiary_BankCaptionLbl)
            {
            }
            column(Account_NumberCaption; Account_NumberCaptionLbl)
            {
            }
            column(Beneficiary_BranchCaption; Beneficiary_BranchCaptionLbl)
            {
            }
            column(LocationCaption; LocationCaptionLbl)
            {
            }
            column(Amount__in_figures_Caption; Amount__in_figures_CaptionLbl)
            {
            }
            column(NEFT___RTGS_CodeCaption; NEFT___RTGS_CodeCaptionLbl)
            {
            }
            column(Amount__in_words_Caption; Amount__in_words_CaptionLbl)
            {
            }
            column(With_Warm_RegardsCaption; With_Warm_RegardsCaptionLbl)
            {
            }
            column(SincerelyCaption; SincerelyCaptionLbl)
            {
            }
            column(Saket_BhartiaCaption; Saket_BhartiaCaptionLbl)
            {
            }
            column(Authorised_SignatoryCaption; Authorised_SignatoryCaptionLbl)
            {
            }
            column(Gen__Journal_Line_Journal_Template_Name; "Journal Template Name")
            {
            }
            column(Gen__Journal_Line_Journal_Batch_Name; "Journal Batch Name")
            {
            }
            column(Gen__Journal_Line_Line_No_; "Line No.")
            {
            }
            column(Gen__Journal_Line_Document_No_; "Document No.")
            {
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
        if UserSet.Get(UserId)then if RespCent.Get(UserSet."Responsibility Center")then;
    end;
    var UserSet: Record "User Setup";
    RespCent: Record "Responsibility Center";
    CompInfo: Record "Company Information";
    AccNo: label 'Ref       :  Our Account No. %1 with you';
    BankAcc: Record "Bank Account";
    vend: Record Vendor;
    VendBankAcc: Record "Vendor Bank Account";
    Check: Report Check;
    NoInText: array[2]of Text[250];
    The_ManagerCaptionLbl: label 'The Manager';
    Barclays_Bank_PlcCaptionLbl: label 'Barclays Bank Plc';
    Nehru_PlaceCaptionLbl: label 'Nehru Place';
    Gr____First_Floor__Eros_Corporate_TowerCaptionLbl: label 'Gr. & First Floor, Eros Corporate Tower';
    New_Delhi__110019CaptionLbl: label 'New Delhi- 110019';
    Dear_Sir_CaptionLbl: label 'Dear Sir,';
    Sub__________Real_Time_Gross_Settlement__RTGS__Fund_Transfer_ApplicationCaptionLbl: label 'Sub       :  Real Time Gross Settlement (RTGS) Fund Transfer Application';
    Kindly_transfer_fund_through_RTGS_to_the_beneficiary_as_detail_given_hereunder_CaptionLbl: label 'Kindly transfer fund through RTGS to the beneficiary as detail given hereunder.';
    Beneficiary_Details_CaptionLbl: label 'Beneficiary Details:';
    Beneficiary_NameCaptionLbl: label 'Beneficiary Name';
    Beneficiary_AddressCaptionLbl: label 'Beneficiary Address';
    Beneficiary_BankCaptionLbl: label 'Beneficiary Bank';
    Account_NumberCaptionLbl: label 'Account Number';
    Beneficiary_BranchCaptionLbl: label 'Beneficiary Branch';
    LocationCaptionLbl: label 'Location';
    Amount__in_figures_CaptionLbl: label 'Amount (in figures)';
    NEFT___RTGS_CodeCaptionLbl: label 'NEFT / RTGS Code';
    Amount__in_words_CaptionLbl: label 'Amount (in words)';
    With_Warm_RegardsCaptionLbl: label 'With Warm Regards';
    SincerelyCaptionLbl: label 'Sincerely';
    Saket_BhartiaCaptionLbl: label 'Saket Bhartia';
    Authorised_SignatoryCaptionLbl: label 'Authorised Signatory';
}
