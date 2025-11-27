Report 50106 "Transfer Order (Receipt)"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Transfer Order (Receipt).rdl';
    PreviewMode = PrintLayout;
    ApplicationArea = all;
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem("Transfer Receipt Header"; "Transfer Receipt Header")
        {
            DataItemTableView = sorting("No.");
            RequestFilterFields = "Transfer-to Code", "No.";

            column(ReportForNavId_4354;4354)
            {
            }
            column(CommenrsCheck; CommenrsCheck)
            {
            }
            column(CompInfoText; CompInfoText)
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
            column(ResponsibilityCenterPANNo; ResponsibilityCenter."P.A.N. No.")
            {
            }
            column(CurrReport_PAGENO; CurrReport.PageNo)
            {
            }
            column(FORMAT_TODAY_0_4_; Format(Today, 0, 4))
            {
            }
            column(Transfer_Receipt_Header__No__; "No.")
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
            column(Loc_City___________Loc__Post_Code______Loc__State_Code_; Loc.City + ' - ' + Loc."Post Code" + ' ' + Loc."State Code")
            {
            }
            column(LocPANNo; Loc."PAN No.")
            {
            }
            column(Loc__Address_2_; Loc."Address 2")
            {
            }
            column(Loc_Address; Loc.Address)
            {
            }
            column(FromGST; Loc."GST Registration No.")
            {
            }
            column(ToGST; Loc1."GST Registration No.")
            {
            }
            column(LoctO_PANNo; Loc1."PAN No.")
            {
            }
            column(Transfer_Receipt_Header__Transfer_Receipt_Header___Shipping_Agent_Code_; "Transfer Receipt Header"."Shipping Agent Code")
            {
            }
            column(CST; CST)
            {
            }
            column(ECC; ECC)
            {
            }
            column(Transfer_Receipt_Header__Transfer_Receipt_Header___No__; "Transfer Receipt Header"."No.")
            {
            }
            column(Transfer_Receipt_Header__Transfer_Receipt_Header___Receipt_Date_; "Transfer Receipt Header"."Receipt Date")
            {
            }
            column(Transfer_Receipt_Header__Transfer_Receipt_Header___Transfer_to_Name_; "Transfer Receipt Header"."Transfer-to Name")
            {
            }
            column(Transfer_Receipt_Header__Transfer_Receipt_Header___Transfer_to_Code_; "Transfer Receipt Header"."Transfer-to Code")
            {
            }
            column(Vend_Address; LocationRec.Address)
            {
            }
            column(Vend__Address_2_; LocationRec."Address 2")
            {
            }
            column(Vend_City___________Vend__Post_Code_; LocationRec.City + ' - ' + LocationRec."Post Code")
            {
            }
            column(StateName; StateName)
            {
            }
            column(Transfer_Receipt_Header__Transfer_Receipt_Header__Comment; "Transfer Receipt Header".Comment)
            {
            }
            // column(Vend__T_I_N__No__;Vend."T.I.N. No.")
            // {
            // }
            column(Transfer_Receipt_Header__Transfer_Receipt_Header___Transfer_from_Name_; "Transfer Receipt Header"."Transfer-from Name")
            {
            }
            column(Loc_Address_Control1000000016; Loc.Address)
            {
            }
            column(Loc__Address_2__Control1000000043; Loc."Address 2")
            {
            }
            column(Loc_City___________Loc__Post_Code_; Loc.City + ' - ' + Loc."Post Code")
            {
            }
            column(StateName_Control1000000059; StateName)
            {
            }
            column(Transfer_Receipt_Header__Transfer_Receipt_Header___Transfer_from_Code_; "Transfer Receipt Header"."Transfer-from Code")
            {
            }
            column(CST2; CST2)
            {
            }
            column(ECC1; ECC1)
            {
            }
            // column(Loc__T_I_N__No__;Loc."T.I.N. No.")
            // {
            // }
            column(Transfer_Receipt_Header__Transfer_Receipt_Header__Comment_Control1000000036; "Transfer Receipt Header".Comment)
            {
            }
            column(TotalAmount1; TotalAmount1)
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
            column(Transfer_Receipt_Header__Transfer_Receipt_Header___Shipping_Agent_Code_Caption; FieldCaption("Shipping Agent Code"))
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
            column(To_Location_Caption; To_Location_CaptionLbl)
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
            column(From_Location_Caption; From_Location_CaptionLbl)
            {
            }
            column(CST_No_Caption_Control1000000070; CST_No_Caption_Control1000000070Lbl)
            {
            }
            column(EmptyStringCaption_Control1000000072; EmptyStringCaption_Control1000000072Lbl)
            {
            }
            column(ECC_No_Caption_Control1000000078; ECC_No_Caption_Control1000000078Lbl)
            {
            }
            column(EmptyStringCaption_Control1000000081; EmptyStringCaption_Control1000000081Lbl)
            {
            }
            column(EmptyStringCaption_Control1000000084; EmptyStringCaption_Control1000000084Lbl)
            {
            }
            column(TIN_No_Caption_Control1000000085; TIN_No_Caption_Control1000000085Lbl)
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
            dataitem("Transfer Receipt Line"; "Transfer Receipt Line")
            {
                DataItemLink = "Document No."=field("No.");
                DataItemTableView = sorting("Document No.", "Line No.");

                column(ReportForNavId_4146;4146)
                {
                }
                column(Transfer_Receipt_Line__Item_No__; "Item No.")
                {
                }
                column(ItemRec__Description_2_; ItemRec."Description 2")
                {
                }
                column(ItemRec__Base_Unit_of_Measure_; ItemRec."Base Unit of Measure")
                {
                }
                column(Transfer_Receipt_Line_Quantity; Quantity)
                {
                }
                column(S_No__; "S No.")
                {
                }
                column(Transfer_Receipt_Line_Description; Description)
                {
                }
                column(HSNCodee;'[HSN: ' + "Transfer Receipt Line"."HSN/SAC Code" + '  ' + GSTGroup.Description + ']')
                {
                }
                column(Transfer_Receipt_Line__Transfer_Receipt_Line__Amount; "Transfer Receipt Line".Amount)
                {
                }
                column(Item_CodeCaption; Item_CodeCaptionLbl)
                {
                }
                column(UOMCaption; UOMCaptionLbl)
                {
                }
                column(Transfer_Receipt_Line_QuantityCaption; FieldCaption(Quantity))
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
                column(RemarksCaption_Control1000000087; RemarksCaption_Control1000000087Lbl)
                {
                }
                column(Control1000000088Caption; Control1000000088CaptionLbl)
                {
                }
                column(Estimated_ValueCaption_Control1000000089; Estimated_ValueCaption_Control1000000089Lbl)
                {
                }
                column(UOMCaption_Control1000000115; UOMCaption_Control1000000115Lbl)
                {
                }
                column(DescriptionCaption_Control1000000126; DescriptionCaption_Control1000000126Lbl)
                {
                }
                column(Item_CodeCaption_Control1000000135; Item_CodeCaption_Control1000000135Lbl)
                {
                }
                column(S_No_Caption_Control1000000138; S_No_Caption_Control1000000138Lbl)
                {
                }
                column(Transfer_Receipt_Line_Document_No_; "Document No.")
                {
                }
                column(Transfer_Receipt_Line_Line_No_; "Line No.")
                {
                }
                trigger OnAfterGetRecord()
                begin
                    TotalAmount1:=0;
                    "S No.":="S No." + 1;
                    if ItemRec.Get("Transfer Receipt Line"."Item No.")then begin
                        Description:=ItemRec.Description;
                        No2:=ItemRec."No. 2";
                    end;
                    TotalAmount1:="Transfer Receipt Line".Amount;
                    if GSTGroup.Get("Transfer Receipt Line"."GST Group Code")then;
                end;
                trigger OnPreDataItem()
                begin
                    //CurrReport.CREATETOTALS("RGP Shipment Line"."Line Amount");
                    //CurrReport.CREATETOTALS("Transfer Receipt Line".Amount);
                    "S No.":=0;
                    TotalAmount1:=0;
                end;
            }
            dataitem("Integer"; "Integer")
            {
                DataItemTableView = sorting(Number);

                column(ReportForNavId_5444;5444)
                {
                }
                column(Integer_Number; Number)
                {
                }
                trigger OnPreDataItem()
                begin
                    SetRange(Number, 1, 4 - XX);
                    if Find('-')then;
                end;
            }
            trigger OnAfterGetRecord()
            begin
                Heading:='RETURNABLE  GATE  PASS  (RECEIPT)';
                CommenrsCheck:='NO';
                if "Transfer Receipt Header".Comment then CommenrsCheck:='YES';
                CompInfo.Get;
                Loc.Reset;
                Loc.Get("Transfer Receipt Header"."Transfer-from Code");
                Loc1.Get("Transfer Receipt Header"."Transfer-to Code");
                if LocationRec.Get("Transfer Receipt Header"."Transfer-to Code")then begin
                    // CST:=Vend."C.S.T No.";
                    // LST:=Vend."L.S.T. No.";
                    //"CST Dt":=Vend."C.S.T. Date";
                    // ECC:=Vend."E.C.C. No.";
                    if States1.Get(LocationRec."State Code")then StateName:=States1.Description;
                end;
                if Loc.Get("Transfer Receipt Header"."Transfer-from Code")then begin
                    // CST2:=Loc."C.S.T No.";
                    // LST2:=Loc."L.S.T. No.";
                    //"CST Dt":=Vend."C.S.T. Date";
                    // ECC1:=Loc."E.C.C. No.";
                    States1.Reset;
                    if States1.Get(LocationRec."State Code")then StateName1:=States1.Description;
                end;
                if CompInfo.Get()then begin
                // LST1:=CompInfo."L.S.T. No.";
                // CST1:=CompInfo."C.S.T No.";
                end;
            end;
            trigger OnPreDataItem()
            begin
                //CurrReport.CREATETOTALS("RGP Shipment Line"."Line Amount");
                // CurrReport.CreateTotals("Transfer Receipt Line"."Amount Including Excise");
                //"Transfer Receipt Header".SetRange("Responsibility Center", ResponsibilityCenter.Code);
                ResAdd:=ResponsibilityCenter.Address + ', ' + ResponsibilityCenter."Address 2" + ', ' + ResponsibilityCenter.City + '-' + ResponsibilityCenter."Post Code";
                CompInfoText:='57Th KM STONE, DELHI - JAIPUR HIGHWAY, \VILLAGE BINOLA, DISTRICT GURGAON - 122 413, \HARYANA, INDIA';
                XX:=0;
                RgpLineRec.Reset;
                RgpLineRec.SetRange(RgpLineRec."Document No.", "Transfer Receipt Header"."No.");
                if RgpLineRec.Find('-')then XX:=RgpLineRec.Count;
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
    // if ResponsibilityCenter.Get(UserMgt.GetRespCenterFilter) then
    //   begin
    //     FormatAddr.RespCenter(CompanyAddr,ResponsibilityCenter);
    //     Remail := ResponsibilityCenter."E-Mail";
    //     RespPhoneNo:=ResponsibilityCenter."Phone No.";
    //     RespFaxNo:=ResponsibilityCenter."Fax No.";
    //     RespTINNo:=ResponsibilityCenter."T.I.N. No.";
    //     RespECCNo:=  ResponsibilityCenter."E.C.C. No.";
    //     RespCSTNo:=ResponsibilityCenter."C.S.T. No.";
    //     RespLSTNo:=ResponsibilityCenter."L.S.T. No.";
    //   end
    // else
    //   begin
    //     FormatAddr.Company(CompanyAddr,CompanyInfo);
    //     Remail := CompanyInfo."E-Mail";
    //     RespPhoneNo:=CompanyInfo."Phone No.";
    //     RespFaxNo:=CompanyInfo."Fax No.";
    //     RespTINNo:=CompanyInfo."T.I.N. No.";
    //     RespECCNo:=  CompanyInfo."E.C.C. No.";
    //     RespCSTNo:=CompanyInfo."C.S.T No.";
    //     RespLSTNo:=CompanyInfo."L.S.T. No.";
    //   end;
    end;
    var LocationRec: Record Location;
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
    UserMgt: Codeunit "User Setup Management";
    RespPhoneNo: Text[30];
    RespFaxNo: Text[30];
    RespTINNo: Code[20];
    RespECCNo: Code[20];
    Remail: Text[30];
    States1: Record State;
    StateName: Text[50];
    XX: Integer;
    RgpLineRec: Record "Transfer Receipt Line";
    ResAdd: Text[250];
    Heading: Text[250];
    Loc: Record Location;
    LST2: Text[50];
    ECC1: Text[50];
    CST2: Text[50];
    StateName1: Text[50];
    TotalAmount1: Decimal;
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
    To_Location_CaptionLbl: label 'To Location:';
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
    From_Location_CaptionLbl: label 'From Location:';
    CST_No_Caption_Control1000000070Lbl: label 'CST No.';
    EmptyStringCaption_Control1000000072Lbl: label ':';
    ECC_No_Caption_Control1000000078Lbl: label 'ECC No.';
    EmptyStringCaption_Control1000000081Lbl: label ':';
    EmptyStringCaption_Control1000000084Lbl: label ':';
    TIN_No_Caption_Control1000000085Lbl: label 'TIN No.';
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
    RemarksCaption_Control1000000087Lbl: label 'Remarks';
    Control1000000088CaptionLbl: label 'Label1000000088';
    Estimated_ValueCaption_Control1000000089Lbl: label 'Estimated Value';
    UOMCaption_Control1000000115Lbl: label 'UOM';
    DescriptionCaption_Control1000000126Lbl: label 'Description';
    Item_CodeCaption_Control1000000135Lbl: label 'Item Code';
    S_No_Caption_Control1000000138Lbl: label 'S No.';
    CompInfoText: Text;
    CommenrsCheck: Text;
    Loc1: Record Location;
    GSTGroup: Record "GST Group";
}
