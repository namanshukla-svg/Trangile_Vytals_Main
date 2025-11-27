Report 50482 "Gate Pass RGP Shipment- Vytals"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Gate Pass RGP Shipment- Vytals.rdl';
    UsageCategory = Lists;
    ApplicationArea = all;

    dataset
    {
        dataitem("RGP Shipment Header"; "SSD RGP Shipment Header")
        {
            RequestFilterFields = "No.", "Party No.";

            column(ReportForNavId_1000000000;1000000000)
            {
            }
            column(QRCode; QRCodeStr.QRCode)
            {
            }
            column(ZAVENIR_DAUBERT_INDIA_PRIVATE_LIMITED_; CompInfo.Name)
            {
            }
            column(ResponsibilityCenter__E_C_C__No__; CompInfo."GST Registration No.")
            {
            }
            column(ResponsibilityCenter__T_I_N__No__; ResponsibilityCenter."T.I.N. No.")
            {
            }
            column(ResponsibilityCenter__Phone_No__; ResponsibilityCenter."Phone No.")
            {
            }
            column(ResponsibilityCenterPANNo; CompInfo."P.A.N. No.")
            {
            }
            column(CurrReport_PAGENO; CurrReport.PageNo)
            {
            }
            column(FORMAT_TODAY_0_4_; Format(Today, 0, 4))
            {
            }
            column(RGP_Shipment_Header__No__; "No.")
            {
            }
            column(ResponsibilityCenter__C_S_T__No__; ResponsibilityCenter."C.S.T. No.")
            {
            }
            column(CompanyInfo_Picture; CompanyInfo.Picture)
            {
            }
            column(Heading; Heading)
            {
            }
            column(V57Th_KM_STONE__DELHI___JAIPUR_HIGHWAY___VILLAGE_BINOLA__DISTRICT_GURGAON___122_413___HARYANA__INDIA_;'Block A, Building 5, 16th Floor, DLF Cyber City, Gurugram, Gurugram, Haryana, 122002')
            {
            }
            column(RGP_Shipment_Header__Vehical_No__; "Vehical No.")
            {
            }
            column(CST; CST)
            {
            }
            column(ECC; ECC)
            {
            }
            column(RGP_Shipment_Header__RGP_Shipment_Header___Pre_Assigned_No__; "RGP Shipment Header"."Pre-Assigned No.")
            {
            }
            column(RGP_Shipment_Header__RGP_Shipment_Header___Document_Date_; "RGP Shipment Header"."Document Date")
            {
            }
            column(RGP_Shipment_Header__Party_Name_; "Party Name")
            {
            }
            column(RGP_Shipment_Header__Party_No__; "Party No.")
            {
            }
            column(RGP_Shipment_Header__Party_Address_; "Party Address")
            {
            }
            column(RGP_Shipment_Header__Party_Address_2_; "Party Address 2")
            {
            }
            column(Party_City_____________Party_PostCode_; "Party City" + ' - ' + "Party PostCode")
            {
            }
            column(StateName; StateName)
            {
            }
            column(RGP_Shipment_Header__RGP_Shipment_Header___Purpose_Description_; "RGP Shipment Header"."Purpose Description")
            {
            }
            column(VendPANNo; VendPANNo)
            {
            }
            column(RGP_Shipment_Header__RGP_Shipment_Header__Remark2; "RGP Shipment Header".Remark2)
            {
            }
            column(RGP_Shipment_Line___Line_Amount_; "RGP Shipment Line"."Line Amount")
            {
            }
            column(TIN_No__Caption; TIN_No_CaptionLbl)
            {
            }
            column(ECC_No__Caption; ECC_No__CaptionLbl)
            {
            }
            column(Phone_No__Caption; Phone_No__CaptionLbl)
            {
            }
            column(PageCaption; PageCaptionLbl)
            {
            }
            column(SL_No_Caption; SL_No_CaptionLbl)
            {
            }
            column(CST_No_Caption; CST_No_CaptionLbl)
            {
            }
            column(RGP_Shipment_Header__Vehical_No__Caption; FieldCaption("Vehical No."))
            {
            }
            column(CST_No_Caption_Control1000000024; CST_No_Caption_Control1000000024Lbl)
            {
            }
            column(RMGP_No_Caption; RMGP_No_CaptionLbl)
            {
            }
            column(RMGP_Dt_Caption; RMGP_Dt_CaptionLbl)
            {
            }
            column(ECC_No_Caption; ECC_No_CaptionLbl)
            {
            }
            column(Party__Caption; Party__CaptionLbl)
            {
            }
            column(PurposeCaption; PurposeCaptionLbl)
            {
            }
            column(V57_AC_No_Caption; V57_AC_No_CaptionLbl)
            {
            }
            column(EmptyStringCaption; EmptyStringCaptionLbl)
            {
            }
            column(EmptyStringCaption_Control1000000021; EmptyStringCaption_Control1000000021Lbl)
            {
            }
            column(EmptyStringCaption_Control1000000031; EmptyStringCaption_Control1000000031Lbl)
            {
            }
            column(EmptyStringCaption_Control1000000032; EmptyStringCaption_Control1000000032Lbl)
            {
            }
            column(EmptyStringCaption_Control1000000033; EmptyStringCaption_Control1000000033Lbl)
            {
            }
            column(EmptyStringCaption_Control1000000046; EmptyStringCaption_Control1000000046Lbl)
            {
            }
            column(EmptyStringCaption_Control1000000066; EmptyStringCaption_Control1000000066Lbl)
            {
            }
            column(EmptyStringCaption_Control1000000022; EmptyStringCaption_Control1000000022Lbl)
            {
            }
            column(TIN_No_Caption; TIN_No_CaptionLbl)
            {
            }
            column(Note__Caption; Note__CaptionLbl)
            {
            }
            column(TotalCaption; TotalCaptionLbl)
            {
            }
            column(SecurityCaption; SecurityCaptionLbl)
            {
            }
            column(Received_byCaption; Received_byCaptionLbl)
            {
            }
            column(Authorised__byCaption; Authorised__byCaptionLbl)
            {
            }
            column(Prepared_By__Caption; Prepared_By__CaptionLbl)
            {
            }
            column(CES_STR_F_12Caption; CES_STR_F_12CaptionLbl)
            {
            }
            column(Registered_Office__Caption; Registered_Office__CaptionLbl)
            {
            }
            column(Regus_Rectangle___Level_4___Rectangle_1___D_4__Saket_District_Centre___New_Delhi_110017___Phone__91_11_66544255Caption; RCaptionLbl)
            {
            }
            column(Fax__91_11_66544052___Email_ccare_zavenir_com___www_zavenir_com___CIN_No__U74899DL1995PTC069625Caption;'Email ' + CompanyInfo."E-Mail" + ' | ' + CompanyInfo."Home Page")
            {
            }
            column(ddsd; CompInfo."Registration No.")
            {
            }
            column(Remark; RGPHeader."Receipt Remarks")
            {
            }
            dataitem("RGP Shipment Line"; "SSD RGP Shipment Line")
            {
                DataItemLink = "Document No."=field("No.");

                column(ReportForNavId_1000000059;1000000059)
                {
                }
                column(RGP_Shipment_Line__No__; "No.")
                {
                }
                column(RGP_Shipment_Line__Description_2_; "Description 2")
                {
                }
                column(RGP_Shipment_Line__Unit_Of_Measure_Code_; "Unit Of Measure Code")
                {
                }
                column(RGP_Shipment_Line_Quantity; Quantity)
                {
                }
                column(S_No__; "S No.")
                {
                }
                column(RGP_Shipment_Line__RGP_Shipment_Line__Description; "RGP Shipment Line".Description)
                {
                }
                column(RGP_Shipment_Line__RGP_Shipment_Line___Line_Amount_; "RGP Shipment Line"."Line Amount")
                {
                }
                column(Item_CodeCaption; Item_CodeCaptionLbl)
                {
                }
                column(UOMCaption; UOMCaptionLbl)
                {
                }
                column(RGP_Shipment_Line_QuantityCaption; FieldCaption(Quantity))
                {
                }
                column(RemarksCaption; RemarksCaptionLbl)
                {
                }
                column(S_No_Caption; S_No_CaptionLbl)
                {
                }
                column(Estimated_ValueCaption; Estimated_ValueCaptionLbl)
                {
                }
                column(DescriptionCaption; DescriptionCaptionLbl)
                {
                }
                column(RGP_Shipment_Line_Document_No_; "Document No.")
                {
                }
                column(RGP_Shipment_Line_Line_No_; "Line No.")
                {
                }
                trigger OnAfterGetRecord()
                begin
                    XX:=XX - 1;
                    "S No.":="S No." + 1;
                    if "RGP Shipment Line"."No." <> '' then //ALLE[5.51]
 if ItemRec.Get("RGP Shipment Line"."No.")then begin
                            Description:=ItemRec.Description;
                            No2:=ItemRec."No. 2";
                        end;
                end;
                trigger OnPreDataItem()
                begin
                    "S No.":=0;
                    XX:=7;
                end;
            }
            dataitem(CopyLoop; "Integer")
            {
                DataItemTableView = sorting(Number);

                column(ReportForNavId_1000000076;1000000076)
                {
                }
                column(CountLoop; CountLoop)
                {
                }
                trigger OnAfterGetRecord()
                begin
                    XX:=XX - 1;
                end;
                trigger OnPreDataItem()
                begin
                    SetRange(Number, 1, XX);
                end;
            }
            trigger OnAfterGetRecord()
            begin
                //CORP::PK 250819 >>>
                Clear(QRCodeMgt);
                Clear(QRCodeStr);
                QRCodeMgt.BarcodeForCrMemo("RGP Shipment Header"."No.", "RGP Shipment Header"."Posting Date", "RGP Shipment Header"."Pre-Assigned No.", "RGP Shipment Header"."Party Name");
                if QRCodeStr.FindFirst then;
                QRCodeStr.CalcFields(QRCode);
                //CORP::PK 250819 <<<
                Heading:='';
                CompInfo.Get();
                if not "RGP Shipment Header".NRGP then Heading:='RETURNABLE  GATE  PASS   (RGP-OUT)'
                else
                    Heading:='NON-RETURNABLE  GATE  PASS   (NRGP-OUT)';
                if "RGP Shipment Header"."Document SubType" = "RGP Shipment Header"."document subtype"::"57F4" then Heading:='RETURNABLE  GATE  PASS   (57F4)';
                if Vend.Get("RGP Shipment Header"."Party No.")then begin
                    ECC:=Vend."GST Registration No.";
                    VendPANNo:=Vend."P.A.N. No.";
                    if States1.Get(Vend."State Code")then StateName:=States1.Description;
                end;
                if RGPHeader.Get("Document Type", "Pre-Assigned No.")then;
            end;
            trigger OnPreDataItem()
            begin
                "RGP Shipment Header".SetRange("Responsibility Center", ResponsibilityCenter.Code);
                ResAdd:=ResponsibilityCenter.Address + ', ' + ResponsibilityCenter."Address 2" + ', ' + ResponsibilityCenter.City + '-' + ResponsibilityCenter."Post Code";
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
    var VendPANNo: Code[20];
    Vend: Record Vendor;
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
    XX: Integer;
    RgpLineRec: Record "SSD RGP Shipment Line";
    ResAdd: Text[250];
    Heading: Text[250];
    TIN_No__CaptionLbl: label 'TIN No.-';
    ECC_No__CaptionLbl: label 'GSTIN';
    Phone_No__CaptionLbl: label 'Phone No.-';
    PageCaptionLbl: label 'Page';
    SL_No_CaptionLbl: label 'SL No.';
    CST_No_CaptionLbl: label 'CST No.';
    CST_No_Caption_Control1000000024Lbl: label 'CST No.';
    RMGP_No_CaptionLbl: label 'RMGP No.';
    RMGP_Dt_CaptionLbl: label 'RMGP Dt.';
    ECC_No_CaptionLbl: label 'ECC No.';
    Party__CaptionLbl: label 'Party :';
    PurposeCaptionLbl: label 'Purpose';
    V57_AC_No_CaptionLbl: label '57 AC No.';
    EmptyStringCaptionLbl: label ':';
    EmptyStringCaption_Control1000000021Lbl: label ':';
    EmptyStringCaption_Control1000000031Lbl: label ':';
    EmptyStringCaption_Control1000000032Lbl: label ':';
    EmptyStringCaption_Control1000000033Lbl: label ':';
    EmptyStringCaption_Control1000000046Lbl: label ':';
    EmptyStringCaption_Control1000000066Lbl: label ':';
    EmptyStringCaption_Control1000000022Lbl: label ':';
    TIN_No_CaptionLbl: label 'TIN No.';
    Note__CaptionLbl: label 'Note :';
    TotalCaptionLbl: label 'Total';
    SecurityCaptionLbl: label 'Security';
    Received_byCaptionLbl: label 'Received by';
    Authorised__byCaptionLbl: label 'Authorised  by';
    Prepared_By__CaptionLbl: label 'Prepared By:-';
    CES_STR_F_12CaptionLbl: label 'CES/STR/F/12';
    Registered_Office__CaptionLbl: label 'Registered Office :';
    RCaptionLbl: label 'Regus Rectangle | Level-4 | Rectangle 1 | D-4, Saket District Centre | New Delhi 110017 | Phone +91 11 66544255';
    Fax__91_11_66544052___Email_ccare_zavenir_com___www_zavenir_com___CIN_No__U74899DL1995PTC069625CaptionLbl: label 'Fax +91 11 66544052 | Email ccare@zavenir.com | www.zavenir.com | ';
    Item_CodeCaptionLbl: label 'Item Code';
    UOMCaptionLbl: label 'UOM';
    RemarksCaptionLbl: label 'Remarks';
    S_No_CaptionLbl: label 'S No.';
    Estimated_ValueCaptionLbl: label 'Estimated Value';
    DescriptionCaptionLbl: label 'Description';
    CountLoop: label 'CountLoopLbl';
    Heading1: Text;
    RGPHeader: Record "SSD RGP Header";
    QRCodeStr: Record "SSD QR Code Str";
    QRCodeMgt: Codeunit "QR Code Mgt.";
}
