Report 50203 "Gate Pass RGP Receipt26"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Gate Pass RGP Receipt26.rdl';
    UsageCategory = ReportsandAnalysis;
    ApplicationArea = all;

    dataset
    {
        dataitem("RGP Receipt Header"; "SSD RGP Receipt Header")
        {
            RequestFilterFields = "Party No.", "No.";

            column(ReportForNavId_1000000091;1000000091)
            {
            }
            column(HeaderPrint; HeaderPrint)
            {
            }
            column(ZAVENIR_DAUBERT_INDIA_PRIVATE_LIMITED_;'ZAVENIR DAUBERT INDIA PRIVATE LIMITED')
            {
            }
            column(ResponsibilityCenter__E_C_C__No__; ResponsibilityCenter."E.C.C. No.")
            {
            }
            column(ResponsibilityCenter__T_I_N__No__; ResponsibilityCenter."T.I.N. No.")
            {
            }
            column(ResponsibilityCenter__Phone_No__; ResponsibilityCenter."Phone No.")
            {
            }
            column(CurrReport_PAGENO; CurrReport.PageNo)
            {
            }
            column(FORMAT_TODAY_0_4_; Format(Today, 0, 4))
            {
            }
            column(RGP_Receipt_Header__No__; "No.")
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
            column(V57Th_KM_STONE__DELHI___JAIPUR_HIGHWAY___VILLAGE_BINOLA__DISTRICT_GURGAON___122_413___HARYANA__INDIA_;'57Th KM STONE, DELHI - JAIPUR HIGHWAY, \VILLAGE BINOLA, DISTRICT GURGAON - 122 413, \HARYANA, INDIA')
            {
            }
            column(RGP_Receipt_Header__Vehical_No__; "Vehical No.")
            {
            }
            column(CST; CST)
            {
            }
            column(ECC; ECC)
            {
            }
            column(RGP_Receipt_Header__RGP_Receipt_Header___Pre_Assigned_No__; "RGP Receipt Header"."Pre-Assigned No.")
            {
            }
            column(RGP_Receipt_Header__RGP_Receipt_Header___Document_Date_; "RGP Receipt Header"."Document Date")
            {
            }
            column(RGP_Receipt_Header__Party_Name_; "Party Name")
            {
            }
            column(RGP_Receipt_Header__Party_No__; "Party No.")
            {
            }
            column(RGP_Receipt_Header__Party_Address_; "Party Address")
            {
            }
            column(RGP_Receipt_Header__Party_Address_2_; "Party Address 2")
            {
            }
            column(Party_City_____________Party_PostCode_; "Party City" + ' - ' + "Party PostCode")
            {
            }
            column(StateName; StateName)
            {
            }
            column(RGP_Receipt_Header__RGP_Receipt_Header___Purpose_Description_; "RGP Receipt Header"."Purpose Description")
            {
            }
            column(EmptyString;'')
            {
            }
            column(RGP_Receipt_Line___Line_Amount_; "RGP Receipt Line"."Line Amount")
            {
            }
            column(TIN_No__Caption; TIN_No__CaptionLbl)
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
            column(RGP_Receipt_Header__Vehical_No__Caption; FieldCaption("Vehical No."))
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
            column(Part___IICaption; Part___IICaptionLbl)
            {
            }
            column(V1__Date_and_Time_of_despatch_of_finished_goodsCaption; V1__Date_and_Time_of_despatch_of_finished_goodsCaptionLbl)
            {
            }
            column(V2__Quantity_despatchedCaption; V2__Quantity_despatchedCaptionLbl)
            {
            }
            column(V3__Nature_of_processing_doneCaption; V3__Nature_of_processing_doneCaptionLbl)
            {
            }
            column(EmptyStringCaption_Control1000000111; EmptyStringCaption_Control1000000111Lbl)
            {
            }
            column(EmptyStringCaption_Control1000000112; EmptyStringCaption_Control1000000112Lbl)
            {
            }
            column(EmptyStringCaption_Control1000000113; EmptyStringCaption_Control1000000113Lbl)
            {
            }
            column(V4__Quantity_of_waste_material_returnedCaption; V4__Quantity_of_waste_material_returnedCaptionLbl)
            {
            }
            column(EmptyStringCaption_Control1000000114; EmptyStringCaption_Control1000000114Lbl)
            {
            }
            column(Place___Caption; Place___CaptionLbl)
            {
            }
            column(Date___Caption; Date___CaptionLbl)
            {
            }
            column(Signature_of_the_Processor_Caption; Signature_of_the_Processor_CaptionLbl)
            {
            }
            column(Name_of_the_factory_Caption; Name_of_the_factory_CaptionLbl)
            {
            }
            column(Address_Caption; Address_CaptionLbl)
            {
            }
            column(CES_STR_F_12Caption; CES_STR_F_12CaptionLbl)
            {
            }
            column(RGP_Receipt_Header_Document_Type; "Document Type")
            {
            }
            column(FooterPrint; FooterPrint)
            {
            }
            dataitem("RGP Receipt Line"; "SSD RGP Receipt Line")
            {
                DataItemLink = "Document No."=field("No.");

                column(ReportForNavId_1000000018;1000000018)
                {
                }
                column(RGP_Receipt_Line__No__; "No.")
                {
                }
                column(EmptyString_Control1000000002;'')
                {
                }
                column(RGP_Receipt_Line__Unit_Of_Measure_Code_; "Unit Of Measure Code")
                {
                }
                column(RGP_Receipt_Line_Quantity; Quantity)
                {
                }
                column(S_No__; "S No.")
                {
                }
                column(RGP_Receipt_Line__RGP_Receipt_Line__Description; "RGP Receipt Line".Description)
                {
                }
                column(RGP_Receipt_Line__RGP_Receipt_Line___Line_Amount_; "RGP Receipt Line"."Line Amount")
                {
                }
                column(Item_CodeCaption; Item_CodeCaptionLbl)
                {
                }
                column(UOMCaption; UOMCaptionLbl)
                {
                }
                column(RGP_Receipt_Line_QuantityCaption; FieldCaption(Quantity))
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
                column(RGP_Receipt_Line_Document_No_; "Document No.")
                {
                }
                column(RGP_Receipt_Line_Line_No_; "Line No.")
                {
                }
                trigger OnAfterGetRecord()
                begin
                    XX:=XX - 1;
                    "S No."+=1;
                    if "RGP Receipt Line"."No." <> '' then if ItemRec.Get("RGP Receipt Line"."No.")then begin
                            Description:=ItemRec.Description;
                            No2:=ItemRec."No. 2";
                        end;
                end;
                trigger OnPreDataItem()
                begin
                    CurrReport.CreateTotals("RGP Receipt Line"."Line Amount");
                    "S No.":=0;
                    XX:=12;
                end;
            }
            dataitem("Integer"; "Integer")
            {
                column(ReportForNavId_1000000001;1000000001)
                {
                }
                column(CountLoopLbl; CountLoop)
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
                "RGP Receipt Header".SetRange("Responsibility Center", ResponsibilityCenter.Code);
                ResAdd:=ResponsibilityCenter.Address + ', ' + ResponsibilityCenter."Address 2" + ', ' + ResponsibilityCenter.City + '-' + ResponsibilityCenter."Post Code";
                HeaderPrint:=false;
                if "RGP Receipt Header"."Document SubType" = "RGP Receipt Header"."document subtype"::"57F4" then HeaderPrint:=true;
                if not "RGP Receipt Header".NRGP then Heading:='RETURNABLE  GATE  PASS   (RGP)'
                else
                    Heading:='NON-RETURNABLE  GATE  PASS   (NRGP)';
                if "RGP Receipt Header"."Document SubType" = "RGP Receipt Header"."document subtype"::"57F4" then Heading:='RETURNABLE  GATE  PASS   (57F4)';
                if Vend.Get("RGP Receipt Header"."Party No.")then begin
                    if States1.Get(Vend."State Code")then StateName:=States1.Description;
                end;
                if "RGP Receipt Header"."Document SubType" = "RGP Receipt Header"."document subtype"::"57F4" then FooterPrint:=true
                else
                    FooterPrint:=false;
            end;
            trigger OnPreDataItem()
            begin
                CurrReport.CreateTotals("RGP Receipt Line"."Line Amount");
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
    XX: Integer;
    RgpLineRec: Record "SSD RGP Shipment Line";
    ResAdd: Text[250];
    Heading: Text[250];
    HeaderPrint: Boolean;
    TIN_No__CaptionLbl: label 'TIN No.-';
    ECC_No__CaptionLbl: label 'ECC No.-';
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
    Part___IICaptionLbl: label 'Part - II';
    V1__Date_and_Time_of_despatch_of_finished_goodsCaptionLbl: label '1. Date and Time of despatch of finished goods';
    V2__Quantity_despatchedCaptionLbl: label '2. Quantity despatched';
    V3__Nature_of_processing_doneCaptionLbl: label '3. Nature of processing done';
    EmptyStringCaption_Control1000000111Lbl: label ' : ';
    EmptyStringCaption_Control1000000112Lbl: label ' : ';
    EmptyStringCaption_Control1000000113Lbl: label ' : ';
    V4__Quantity_of_waste_material_returnedCaptionLbl: label '4. Quantity of waste material returned';
    EmptyStringCaption_Control1000000114Lbl: label ' : ';
    Place___CaptionLbl: label 'Place : ';
    Date___CaptionLbl: label 'Date : ';
    Signature_of_the_Processor_CaptionLbl: label 'Signature of the Processor ';
    Name_of_the_factory_CaptionLbl: label 'Name of the factory ';
    Address_CaptionLbl: label 'Address ';
    CES_STR_F_12CaptionLbl: label 'CES/STR/F/12';
    Item_CodeCaptionLbl: label 'Item Code';
    UOMCaptionLbl: label 'UOM';
    RemarksCaptionLbl: label 'Remarks';
    S_No_CaptionLbl: label 'S No.';
    Estimated_ValueCaptionLbl: label 'Estimated Value';
    DescriptionCaptionLbl: label 'Description';
    CountLoop: label 'CountLoopLbl';
    FooterPrint: Boolean;
}
