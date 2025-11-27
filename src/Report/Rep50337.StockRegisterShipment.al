Report 50337 "Stock Register(Shipment)"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Stock Register(Shipment).rdl';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = all;

    dataset
    {
        dataitem("SSD Stock Register 57F4"; "SSD Stock Register 57F4")
        {
            RequestFilterFields = "Entry No.", "Challan No.", "Challan Date";

            column(ReportForNavId_6030;6030)
            {
            }
            column(Challan_No; "SSD Stock Register 57F4"."Challan No.")
            {
            }
            column(Challan_Date; "SSD Stock Register 57F4"."Challan Date")
            {
            }
            column(Item_no; "SSD Stock Register 57F4"."Item No.")
            {
            }
            column(Description; "SSD Stock Register 57F4"."Item Description 1")
            {
            }
            column(Description2; "SSD Stock Register 57F4"."Item Description 2")
            {
            }
            column(HSNCode_SSDStockRegister57F4; "HSN Code")
            {
            }
            column(UOM; "SSD Stock Register 57F4"."Unit of Measure Code")
            {
            }
            column(Quantity_Received; "SSD Stock Register 57F4"."Quantity Shipped")
            {
            }
            column(Unit_Cost; "SSD Stock Register 57F4"."Unit Cost")
            {
            }
            column(Transfer_Shipment_Header__No__; "SSD Stock Register 57F4"."Challan No.")
            {
            }
            column(PurposeCheck; PurposeCheck)
            {
            }
            column(Loc1_code; Loc1Code)
            {
            }
            column(Loc1_Name; Loc1Name)
            {
            }
            column(Loc1_Address; Loc1Address)
            {
            }
            column(Loc1_Address2; Loc1Address2)
            {
            }
            column(Loc1_City; Loc1City)
            {
            }
            column(Loc1_state; StateName1)
            {
            }
            column(ZAVENIR_DAUBERT_INDIA_PRIVATE_LIMITED_; CompInfo.Name)
            {
            }
            column(ResponsibilityCenter__E_C_C__No__; VendGSTRegistrationNo)
            {
            }
            column(ResponsibilityCenter__T_I_N__No__; ResponsibilityCenter."T.I.N. No.")
            {
            }
            column(ResponsibilityCenter__Phone_No__; PhoneNo)
            {
            }
            column(ResponsibilityCenterPANNo; locPANNo)
            {
            }
            column(CurrReport_PAGENO; CurrReport.PageNo)
            {
            }
            column(FORMAT_TODAY_0_4_; Format(Today, 0, 4))
            {
            }
            column(ResponsibilityCenter__C_S_T__No__; ResponsibilityCenter."C.S.T. No.")
            {
            }
            column(CompanyInfo_Picture; CompanyInfo.Picture)
            {
            }
            column(Snum; "S No.")
            {
            }
            column(Heading; Heading)
            {
            }
            column(V57Th_KM_STONE__DELHI___JAIPUR_HIGHWAY___VILLAGE_BINOLA__DISTRICT_GURGAON___122_413___HARYANA__INDIA_;'57Th KM STONE, DELHI - JAIPUR HIGHWAY, \VILLAGE BINOLA, DISTRICT GURGAON - 122 413, \HARYANA, INDIA')
            {
            }
            column(loc_City___________loc__Post_Code______loc__State_Code_; VendCity + ' - ' + VendPostCode + ' ' + StateCode)
            {
            }
            column(locPANNo; locPANNo)
            {
            }
            column(loc__Address_2_; vendadd2)
            {
            }
            column(loc_Address; vendadd)
            {
            }
            column(LocTo_PanNo; Loc1PANNo)
            {
            }
            column(Vend_cpde; vendcode)
            {
            }
            column(Vend_Name; vendname)
            {
            }
            column(Vend_Address; vendadd)
            {
            }
            column(FromGST; VendGSTRegistrationNo)
            {
            }
            column(ToGST; Loc1GSTRegistrationNo)
            {
            }
            column(Vend__Address_2_; vendadd2)
            {
            }
            column(Vend_City___________Vend__Post_Code_; VendCity + ' - ' + VendPostCode)
            {
            }
            column(StateName; StateName)
            {
            }
            column(Transfer_Shipment_Header__Transfer_Shipment_Header___Transfer_from_Name_; loc.Name)
            {
            }
            column(StateName1; StateName1)
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
            column(RMGP_No_Caption; RMGP_No_CaptionLbl)
            {
            }
            column(RMGP_Dt_Caption; RMGP_Dt_CaptionLbl)
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
            column(From_Location_Caption; From_Location_CaptionLbl)
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
            column(Fax__91_11_66544052___Email_ccare_zavenir_com___www_zavenir_com___CIN_No__U74899DL1995PTC069625Caption; Fax__91_11_66544052___Email_ccare_zavenir_com___www_zavenir_com___CIN_No__U74899DL1995PTC069625CaptionLbl + CompInfo."Company Registration  No.")
            {
            }
            column(Regus_Rectangle___Level_4___Rectangle_1___D_4__Saket_District_Centre___New_Delhi_110017___Phone__91_11_66544255Caption; CompanyAddress)
            {
            }
            column(Registered_Office__Caption; Registered_Office__CaptionLbl)
            {
            }
            column(Transfer_Shipment_Line__Item_No__; "Item No.")
            {
            }
            column(ItemRec__Description_2_; ItemRec."Description 2")
            {
            }
            column(ItemRec__Base_Unit_of_Measure_; ItemRec."Base Unit of Measure")
            {
            }
            column(Item_CodeCaption; Item_CodeCaptionLbl)
            {
            }
            column(UOMCaption; UOMCaptionLbl)
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
            column(TotalAmount11; TotalAmount1)
            {
            }
            trigger OnAfterGetRecord()
            begin
                "S No."+=1;
                TotalAmount1:=0;
                CompInfo.Get;
                vendcode:='';
                vendname:='';
                StateCode:='';
                PhoneNo:='';
                loc.Reset;
                if loc.Get("SSD Stock Register 57F4"."Job Work Location Code")then;
                if Loc1.Get('STR_BWH')then begin
                    vendcode:=Loc1.Code;
                    vendname:=Loc1.Name;
                    vendadd:=Loc1.Address;
                    vendadd2:=Loc1."Address 2";
                    VendCity:=Loc1.City;
                    VendPostCode:=Loc1."Post Code";
                    VendGSTRegistrationNo:=Loc1."GST Registration No.";
                    locPANNo:=Loc1."PAN No.";
                    StateCode:=Loc1."State Code";
                    PhoneNo:=Loc1."Phone No.";
                    States1.Reset;
                    if States1.Get(Loc1."State Code")then StateName1:=States1.Description;
                end;
                IF Location.Get("SSD Stock Register 57F4"."Job Work Location Code")then begin
                    Loc1Code:=Location.Code;
                    Loc1Name:=Location.Name;
                    Loc1Address:=Location.Address;
                    Loc1Address2:=Location."Address 2";
                    Loc1City:=Location.City;
                    Loc1PostCode:=Location."Post Code";
                    IF Location."Temp JW Location" then Loc1GSTRegistrationNo:=Location."Temp GST Registration No."
                    ELSE
                        Loc1GSTRegistrationNo:=Location."GST Registration No.";
                    Loc1PANNo:=Location."PAN No.";
                    // CST:=Vend."C.S.T No.";
                    // LST:=Vend."L.S.T. No.";
                    // ECC:=Vend."E.C.C. No.";
                    IF Location."Temp JW Location" then begin
                        if States1.Get(Location."Temp State Code")then StateName1:=States1.Description end
                    else
                    begin
                        if States1.Get(Location."State Code")then StateName1:=States1.Description end;
                // if States1.Get(loc."State Code") then
                //     StateName := States1.Description;
                end;
                //IF loc.GET("Stock Register 57F4"."Job Work Location Code") THEN
                begin
                    // gurmeet
                    // CST2 := loc."C.S.T No.";
                    // LST2 := loc."L.S.T. No.";
                    // ECC1 := loc."E.C.C. No.";
                    // gurmeet
                    CST2:='';
                    LST2:='';
                    ECC1:='';
                // States1.Reset;
                // if States1.Get(Vend."State Code") then
                //     StateName := States1.Description;
                end;
                //END;
                if CompInfo.Get()then begin
                    // gurmeet
                    // LST1 := CompInfo."L.S.T. No.";
                    // CST1 := CompInfo."C.S.T No.";
                    // gurmeet
                    LST1:='';
                    CST1:='';
                end;
                // PurposeCheck:='NO';
                // IF "Stock Register 57F4".Comment THEN
                // PurposeCheck:='YES';
                CompanyAddress:=CompInfo.Address + ' | ' + CompInfo."Address 2" + ' | ' + CompInfo.City + ' ' + CompInfo."Post Code" + ' | Phone No. : ' + CompInfo."Phone No.";
                Fax__91_11_66544052___Email_ccare_zavenir_com___www_zavenir_com___CIN_No__U74899DL1995PTC069625CaptionLbl:='Fax: ' + CompInfo."Fax No." + ' | Email: ' + CompInfo."E-Mail";
            end;
            trigger OnPreDataItem()
            begin
                //CurrReport.CREATETOTALS("Transfer Shipment Line"."Amount Including Excise");
                "S No.":=0;
                //"SSD Stock Register 57F4".SetRange("Responsibility Center", ResponsibilityCenter.Code);
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
    // gurmeet
    // if ResponsibilityCenter.Get(UserMgt.GetRespCenterFilter) then begin
    //     FormatAddr.RespCenter(CompanyAddr, ResponsibilityCenter);
    //     Remail := ResponsibilityCenter."E-Mail";
    //     RespPhoneNo := ResponsibilityCenter."Phone No.";
    //     RespFaxNo := ResponsibilityCenter."Fax No.";
    //     RespTINNo := ResponsibilityCenter."T.I.N. No.";
    //     RespECCNo := ResponsibilityCenter."E.C.C. No.";
    //     RespCSTNo := ResponsibilityCenter."C.S.T. No.";
    //     RespLSTNo := ResponsibilityCenter."L.S.T. No.";
    // end
    // else begin
    //     FormatAddr.Company(CompanyAddr, CompanyInfo);
    //     Remail := CompanyInfo."E-Mail";
    //     RespPhoneNo := CompanyInfo."Phone No.";
    //     RespFaxNo := CompanyInfo."Fax No.";
    //     RespTINNo := CompanyInfo."T.I.N. No.";
    //     RespECCNo := CompanyInfo."E.C.C. No.";
    //     RespCSTNo := CompanyInfo."C.S.T No.";
    //     RespLSTNo := CompanyInfo."L.S.T. No.";
    // end;
    // gurmeet
    end;
    var Location: Record Location;
    Loc1Code: Code[20];
    Loc1Name: Text;
    Loc1Address: Text;
    Loc1Address2: Text;
    Loc1City: Text[30];
    Loc1PostCode: Code[20];
    StateCode: Code[20];
    PhoneNo: Code[20];
    Loc1GSTRegistrationNo: Code[20];
    Loc1PANNo: Code[10];
    VendCity: Text[30];
    VendPostCode: Code[20];
    VendGSTRegistrationNo: Code[20];
    locPANNo: Code[20];
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
    UserMgt: Codeunit "User Setup Management";
    RespPhoneNo: Text[30];
    RespFaxNo: Text[30];
    RespTINNo: Code[20];
    RespECCNo: Code[20];
    Remail: Text[30];
    States1: Record State;
    StateName: Text[50];
    StateName1: Text[50];
    XX: Integer;
    RgpLineRec: Record "Transfer Shipment Line";
    ResAdd: Text[250];
    Heading: Text[250];
    loc: Record Location;
    ECC1: Text[50];
    LST2: Text[50];
    CST2: Text[50];
    TotalAmount1: Decimal;
    TIN_No__CaptionLbl: label 'TIN No.-';
    ECC_No__CaptionLbl: label 'ECC No.-';
    Phone_No__CaptionLbl: label 'Phone No.-';
    PageCaptionLbl: label 'Page';
    SL_No_CaptionLbl: label 'SL No.';
    CST_No_CaptionLbl: label 'CST No.';
    RMGP_No_CaptionLbl: label 'RMGP No.';
    RMGP_Dt_CaptionLbl: label 'RMGP Dt.';
    To_Location_CaptionLbl: label 'To Location:';
    PurposeCaptionLbl: label 'Purpose';
    V57_AC_No_CaptionLbl: label '57 AC No.';
    EmptyStringCaptionLbl: label ':';
    EmptyStringCaption_Control1000000021Lbl: label ':';
    EmptyStringCaption_Control1000000031Lbl: label ':';
    EmptyStringCaption_Control1000000032Lbl: label ':';
    EmptyStringCaption_Control1000000033Lbl: label ':';
    From_Location_CaptionLbl: label 'From Location:';
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
    Fax__91_11_66544052___Email_ccare_zavenir_com___www_zavenir_com___CIN_No__U74899DL1995PTC069625CaptionLbl: Text;
    // Regus_Rectangle___Level_4___Rectangle_1___D_4__Saket_District_Centre___New_Delhi_110017___Phone__91_11_66544255CaptionLbl: label 'Regus Rectangle | Level-4 | Rectangle 1 | D-4, Saket District Centre | New Delhi 110017 | Phone +91 11 66544255';
    Registered_Office__CaptionLbl: label 'Registered Office :';
    Item_CodeCaptionLbl: label 'Item Code';
    UOMCaptionLbl: label 'UOM';
    RemarksCaptionLbl: label 'Remarks';
    S_No_CaptionLbl: label 'S No.';
    Estimated_ValueCaptionLbl: label 'Estimated Value';
    DescriptionCaptionLbl: label 'Description';
    PurposeCheck: Text;
    Loc1: Record Location;
    GSTGroup: Record "GST Group";
    TSL: Record "Transfer Shipment Line";
    vendcode: Code[20];
    vendname: Text;
    vendadd: Text;
    vendadd2: Text;
    CompanyAddress: Text;
}
