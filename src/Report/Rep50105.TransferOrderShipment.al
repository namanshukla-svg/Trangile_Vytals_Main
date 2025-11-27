Report 50105 "Transfer Order (Shipment)"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Transfer Order (Shipment).rdl';
    ApplicationArea = all;
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem("Transfer Shipment Header"; "Transfer Shipment Header")
        {
            DataItemTableView = sorting("No.");
            RequestFilterFields = "Transfer-to Code", "No.";

            column(ReportForNavId_6030;6030)
            {
            }
            column(AppliedtoInsurancePolicy_TransferShipmentHeader; "Transfer Shipment Header"."Applied to Insurance Policy")
            {
            }
            column(PurposeCheck; PurposeCheck)
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
            column(Transfer_Shipment_Header__No__; "No.")
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
            column(loc_City___________loc__Post_Code______loc__State_Code_; loc.City + ' - ' + loc."Post Code" + ' ' + loc."State Code")
            {
            }
            column(locPANNo; loc."PAN No.")
            {
            }
            column(loc__Address_2_; loc."Address 2")
            {
            }
            column(loc_Address; loc.Address)
            {
            }
            column(LocTo_PanNo; Loc1."PAN No.")
            {
            }
            column(Transfer_Shipment_Header__Vehicle_No__; "Vehicle No.")
            {
            }
            column(Transfer_Shipment_Header__Transfer_Shipment_Header___No__; "Transfer Shipment Header"."No.")
            {
            }
            column(Transfer_Shipment_Header__Transfer_Shipment_Header___Shipment_Date_; "Transfer Shipment Header"."Shipment Date")
            {
            }
            column(Transfer_Shipment_Header__Transfer_Shipment_Header___Transfer_to_Name_; "Transfer Shipment Header"."Transfer-to Name")
            {
            }
            column(Transfer_Shipment_Header__Transfer_Shipment_Header___Transfer_to_Code_; "Transfer Shipment Header"."Transfer-to Code")
            {
            }
            column(Vend_Address; Vend.Address)
            {
            }
            column(FromGST; loc."GST Registration No.")
            {
            }
            column(ToGST; TempGSTIN)
            {
            }
            column(Vend__Address_2_; Vend."Address 2")
            {
            }
            column(Vend_City___________Vend__Post_Code_; Vend.City + ' - ' + Vend."Post Code")
            {
            }
            column(StateName; StateName)
            {
            }
            column(Transfer_Shipment_Header__Transfer_Shipment_Header__Comment; "Transfer Shipment Header".Comment)
            {
            }
            column(Transfer_Shipment_Header__Transfer_Shipment_Header___Transfer_from_Name_; loc.Name)
            {
            }
            column(Transfer_Shipment_Header__Transfer_Shipment_Header___Transfer_from_Address_; "Transfer Shipment Header"."Transfer-from Address")
            {
            }
            column(Transfer_Shipment_Header__Transfer_Shipment_Header___Transfer_from_Address_2_; "Transfer Shipment Header"."Transfer-from Address 2")
            {
            }
            column(Transfer_from_City_____________Transfer_from_Post_Code_; "Transfer-from City" + ' - ' + "Transfer-from Post Code")
            {
            }
            column(StateName1; StateName1)
            {
            }
            column(Transfer_Shipment_Header__Transfer_Shipment_Header___Transfer_from_Code_; "Transfer Shipment Header"."Transfer-from Code")
            {
            }
            column(Transfer_Shipment_Header__Transfer_Shipment_Header__Comment_Control1000000036; "Transfer Shipment Header".Comment)
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
            column(Transfer_Shipment_Header__Vehicle_No__Caption; FieldCaption("Vehicle No."))
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
            column(Regus_Rectangle___Level_4___Rectangle_1___D_4__Saket_District_Centre___New_Delhi_110017___Phone__91_11_66544255Caption; LocationName.Name + LocationName.Address + LocationName."Address 2" + LocationName.City + LocationName."Post Code" + 'Fax No.' + LocationName."Fax No." + 'Phone. No.' + LocationName."Phone No.")
            {
            }
            column(Registered_Office__Caption; Registered_Office__CaptionLbl)
            {
            }
            dataitem("Transfer Shipment Line"; "Transfer Shipment Line")
            {
                DataItemLink = "Document No."=field("No.");
                DataItemTableView = sorting("Document No.", "Line No.");

                column(ReportForNavId_3226;3226)
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
                column(HSNSACCode_TransferShipmentLine;'[HSN: ' + "Transfer Shipment Line"."HSN/SAC Code" + '  ' + GSTGroup.Description + ']')
                {
                }
                column(Transfer_Shipment_Line_Quantity; Quantity)
                {
                }
                column(S_No__; "S No.")
                {
                }
                column(Transfer_Shipment_Line_Description; Description)
                {
                }
                column(Transfer_Shipment_Line__Transfer_Shipment_Line__Amount; "Transfer Shipment Line".Amount)
                {
                }
                column(Item_CodeCaption; Item_CodeCaptionLbl)
                {
                }
                column(UOMCaption; UOMCaptionLbl)
                {
                }
                column(Transfer_Shipment_Line_QuantityCaption; FieldCaption(Quantity))
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
                column(Transfer_Shipment_Line_Document_No_; "Document No.")
                {
                }
                column(Transfer_Shipment_Line_Line_No_; "Line No.")
                {
                }
                column(TotalAmount11; TotalAmount1)
                {
                }
                trigger OnAfterGetRecord()
                begin
                    TotalAmount1:=0;
                    TotalAmount1:="Transfer Shipment Line".Amount;
                    "S No."+=1;
                    if ItemRec.Get("Transfer Shipment Line"."Item No.")then begin
                        Description:=ItemRec.Description;
                        No2:=ItemRec."No. 2";
                    end;
                    // XX:=XX-1;
                    if GSTGroup.Get("Transfer Shipment Line"."GST Group Code")then;
                end;
                trigger OnPreDataItem()
                begin
                    "S No.":=0;
                    //XX := 10 ;
                    XX:=0;
                    TSL.Reset;
                    TSL.SetRange(TSL."Document No.", "Transfer Shipment Line"."Document No.");
                    if TSL.Find('-')then XX:=TSL.Count;
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
                trigger OnAfterGetRecord()
                begin
                //XX:=XX-1;
                end;
                trigger OnPreDataItem()
                begin
                    //SETRANGE(Number,1,XX);
                    SetRange(Number, 1, 4 - XX);
                    if Find('-')then;
                end;
            }
            trigger OnAfterGetRecord()
            begin
                // LocationName.Get();
                Clear(TempGSTIN);
                TotalAmount1:=0;
                CompInfo.Get;
                loc.Reset;
                loc.Get("Transfer Shipment Header"."Transfer-from Code");
                Loc1.Get("Transfer Shipment Header"."Transfer-to Code");
                if Loc1."Temp GST Registration No." <> '' then TempGSTIN:=Loc1."Temp GST Registration No."
                else
                    TempGSTIN:=Loc1."GST Registration No.";
                if Vend.Get("Transfer Shipment Header"."Transfer-to Code")then begin
                    // CST := Vend."C.S.T No.";
                    // LST := Vend."L.S.T. No.";
                    // ECC := Vend."E.C.C. No.";
                    if States1.Get(loc."State Code")then StateName:=States1.Description;
                end;
                if loc.Get("Transfer Shipment Header"."Transfer-from Code")then begin
                    // CST2 := loc."C.S.T No.";
                    // LST2 := loc."L.S.T. No.";
                    // ECC1 := loc."E.C.C. No.";
                    States1.Reset;
                    if States1.Get(Vend."State Code")then StateName:=States1.Description;
                end;
                States1.Reset;
                if States1.Get(loc."State Code")then StateName1:=States1.Description;
                //END;
                if CompInfo.Get()then begin
                // LST1 := CompInfo."L.S.T. No.";
                // CST1 := CompInfo."C.S.T No.";
                end;
                PurposeCheck:='NO';
                if "Transfer Shipment Header".Comment then PurposeCheck:='YES';
            end;
            trigger OnPreDataItem()
            begin
                // CurrReport.CreateTotals("Transfer Shipment Line"."Amount Including Excise");
                //"Transfer Shipment Header".SetRange("Responsibility Center", ResponsibilityCenter.Code);
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
    end;
    var Vend: Record Location;
    LocationName: Record Location;
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
    Fax__91_11_66544052___Email_ccare_zavenir_com___www_zavenir_com___CIN_No__U74899DL1995PTC069625CaptionLbl: label 'Fax +91 11 66544052 | Email ccare@zavenir.com | www.zavenir.com |';
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
    TempGSTIN: Code[15];
}
