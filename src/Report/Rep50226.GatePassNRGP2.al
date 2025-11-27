Report 50226 "Gate Pass NRGP2"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Gate Pass NRGP2.rdl';
    UsageCategory = ReportsandAnalysis;
    ApplicationArea = all;

    dataset
    {
        dataitem("RGP Header"; "SSD RGP Header")
        {
            RequestFilterFields = "Party No.";

            column(ReportForNavId_6494;6494)
            {
            }
            column(CompanyAddr_2_; CompanyAddr[2])
            {
            }
            column(CompanyAddr_1_; CompanyAddr[1])
            {
            }
            column(CompanyAddr_4_; CompanyAddr[4])
            {
            }
            column(RespLSTNo; RespLSTNo)
            {
            }
            column(RespCSTNo; RespCSTNo)
            {
            }
            column(RespECCNo; RespECCNo)
            {
            }
            column(CST; CST)
            {
            }
            column(ECC; ECC)
            {
            }
            column(RGP_Header__Party_Name_; "Party Name")
            {
            }
            column(RGP_Header__Party_No__; "Party No.")
            {
            }
            column(RGP_Header__Party_Address_; "Party Address")
            {
            }
            column(RGP_Header__Party_Address_2_; "Party Address 2")
            {
            }
            column(RGP_Header__Party_City_; "Party City")
            {
            }
            column(RGP_Header__Party_PostCode_; "Party PostCode")
            {
            }
            column(StateName; StateName)
            {
            }
            column(RGP_Header__Vehical_No__; "Vehical No.")
            {
            }
            column(RGP_Header__RGP_Header___No__; "RGP Header"."No.")
            {
            }
            column(RGP_Header__RGP_Header___Posting_Date_; "RGP Header"."Posting Date")
            {
            }
            column(RGP_Header__Purpose_Code_; "Purpose Code")
            {
            }
            column(RGP_Header__RGP_Header___Shortcut_Dimension_2_Code_; "RGP Header"."Shortcut Dimension 2 Code")
            {
            }
            column(RGP_Header_Remark2; Remark2)
            {
            }
            column(TSF_ST_09_Rev__No_A_01_06_2006Caption; TSF_ST_09_Rev__No_A_01_06_2006CaptionLbl)
            {
            }
            column(E_C_C__No_Caption; E_C_C__No_CaptionLbl)
            {
            }
            column(L_S_T__No_Caption; L_S_T__No_CaptionLbl)
            {
            }
            column(C_S_T__No_Caption; C_S_T__No_CaptionLbl)
            {
            }
            column(CST_No_Caption; CST_No_CaptionLbl)
            {
            }
            column(ECC_No_Caption; ECC_No_CaptionLbl)
            {
            }
            column(Party__Caption; Party__CaptionLbl)
            {
            }
            column(V57_AC_No_Caption; V57_AC_No_CaptionLbl)
            {
            }
            column(EmptyStringCaption; EmptyStringCaptionLbl)
            {
            }
            column(EmptyStringCaption_Control1000000046; EmptyStringCaption_Control1000000046Lbl)
            {
            }
            column(EmptyStringCaption_Control1000000066; EmptyStringCaption_Control1000000066Lbl)
            {
            }
            column(NON_RETURNABLE_MATERIAL_GATE_PASSCaption; NON_RETURNABLE_MATERIAL_GATE_PASSCaptionLbl)
            {
            }
            column(NRGP_No_Caption; NRGP_No_CaptionLbl)
            {
            }
            column(NRGP_Dt_Caption; NRGP_Dt_CaptionLbl)
            {
            }
            column(RGP_Header__Vehical_No__Caption; FieldCaption("Vehical No."))
            {
            }
            column(DepartmentCaption; DepartmentCaptionLbl)
            {
            }
            column(PurposeCaption; PurposeCaptionLbl)
            {
            }
            column(EmptyStringCaption_Control1000000032; EmptyStringCaption_Control1000000032Lbl)
            {
            }
            column(EmptyStringCaption_Control1000000033; EmptyStringCaption_Control1000000033Lbl)
            {
            }
            column(EmptyStringCaption_Control1000000034; EmptyStringCaption_Control1000000034Lbl)
            {
            }
            column(EmptyStringCaption_Control1000000039; EmptyStringCaption_Control1000000039Lbl)
            {
            }
            column(EmptyStringCaption_Control1000000040; EmptyStringCaption_Control1000000040Lbl)
            {
            }
            column(Note__Caption; Note__CaptionLbl)
            {
            }
            column(Authorised_Signatory_Caption; Authorised_Signatory_CaptionLbl)
            {
            }
            column(For_Caparo_Engg__India_Pvt__Ltd_Caption; For_Caparo_Engg__India_Pvt__Ltd_CaptionLbl)
            {
            }
            column(Prepared_ByCaption; Prepared_ByCaptionLbl)
            {
            }
            column(RGP_Header_Document_Type; "Document Type")
            {
            }
            dataitem("RGP Line"; "SSD RGP Line")
            {
                DataItemLink = "Document No."=field("No.");

                column(ReportForNavId_7724;7724)
                {
                }
                column(RGP_Line__No__; "No.")
                {
                }
                column(RGP_Line_Description; Description)
                {
                }
                column(RGP_Line__Unit_Of_Measure_Code_; "Unit Of Measure Code")
                {
                }
                column(RGP_Line_Quantity; Quantity)
                {
                }
                column(S_No__; "S No.")
                {
                }
                column(No2; No2)
                {
                }
                column(Item_Caption; Item_CaptionLbl)
                {
                }
                column(UOMCaption; UOMCaptionLbl)
                {
                }
                column(RGP_Line_QuantityCaption; FieldCaption(Quantity))
                {
                }
                column(RemarksCaption; RemarksCaptionLbl)
                {
                }
                column(S_No_Caption; S_No_CaptionLbl)
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
        CompanyInfo.Get;
        CompanyInfo.CalcFields(Picture);
        if ResponsibilityCenter.Get(UserMgt.GetRespCenterFilter)then begin
            FormatAddr.RespCenter(CompanyAddr, ResponsibilityCenter);
            Remail:=ResponsibilityCenter."E-Mail";
            RespPhoneNo:=ResponsibilityCenter."Phone No.";
            RespFaxNo:=ResponsibilityCenter."Fax No.";
            RespTINNo:=ResponsibilityCenter."T.I.N. No.";
            RespECCNo:=ResponsibilityCenter."E.C.C. No.";
            RespCSTNo:=ResponsibilityCenter."C.S.T. No.";
            RespLSTNo:=ResponsibilityCenter."L.S.T. No.";
        end
        else
        begin
            FormatAddr.Company(CompanyAddr, CompanyInfo);
            Remail:=CompanyInfo."E-Mail";
            RespPhoneNo:=CompanyInfo."Phone No.";
            RespFaxNo:=CompanyInfo."Fax No.";
        end;
    end;
    var Vend: Record Vendor;
    "S No.": Integer;
    CST: Text[50];
    LST: Text[50];
    "CST Dt": Date;
    "Dim.Val": Record "Dimension Value";
    RCode: Record "Reason Code";
    Desc: Text[50];
    Purp: Text[50];
    ECC: Text[50];
    CompInfo: Record "Company Information";
    LST1: Text[50];
    CST1: Text[50];
    CSTDt1: Date;
    ItemRec: Record Item;
    No2: Code[20];
    CompanyInfo: Record "Company Information";
    ResponsibilityCenter: Record "Responsibility Center";
    FormatAddr: Codeunit "Format Address";
    CompanyAddr: array[8]of Text[50];
    RespCSTNo: Code[20];
    RespLSTNo: Code[20];
    UserMgt: Codeunit "SSD User Setup Management";
    RespPhoneNo: Text[30];
    RespFaxNo: Text[30];
    RespTINNo: Code[20];
    RespECCNo: Code[20];
    Remail: Text[30];
    States1: Record State;
    StateName: Text[50];
    TSF_ST_09_Rev__No_A_01_06_2006CaptionLbl: label 'TSF/ST/09 Rev. No.A,01-06-2006';
    E_C_C__No_CaptionLbl: label 'E.C.C. No.';
    L_S_T__No_CaptionLbl: label 'L.S.T. No.';
    C_S_T__No_CaptionLbl: label 'C.S.T. No.';
    CST_No_CaptionLbl: label 'CST No.';
    ECC_No_CaptionLbl: label 'ECC No.';
    Party__CaptionLbl: label 'Party :';
    V57_AC_No_CaptionLbl: label '57 AC No.';
    EmptyStringCaptionLbl: label ':';
    EmptyStringCaption_Control1000000046Lbl: label ':';
    EmptyStringCaption_Control1000000066Lbl: label ':';
    NON_RETURNABLE_MATERIAL_GATE_PASSCaptionLbl: label 'NON RETURNABLE MATERIAL GATE PASS';
    NRGP_No_CaptionLbl: label 'NRGP No.';
    NRGP_Dt_CaptionLbl: label 'NRGP Dt.';
    DepartmentCaptionLbl: label 'Department';
    PurposeCaptionLbl: label 'Purpose';
    EmptyStringCaption_Control1000000032Lbl: label ':';
    EmptyStringCaption_Control1000000033Lbl: label ':';
    EmptyStringCaption_Control1000000034Lbl: label ':';
    EmptyStringCaption_Control1000000039Lbl: label ':';
    EmptyStringCaption_Control1000000040Lbl: label ':';
    Note__CaptionLbl: label 'Note :';
    Authorised_Signatory_CaptionLbl: label '(Authorised Signatory)';
    For_Caparo_Engg__India_Pvt__Ltd_CaptionLbl: label 'For Caparo Engg. India Pvt. Ltd.';
    Prepared_ByCaptionLbl: label 'Prepared By';
    Item_CaptionLbl: label 'Item ';
    UOMCaptionLbl: label 'UOM';
    RemarksCaptionLbl: label 'Remarks';
    S_No_CaptionLbl: label 'S No.';
}
