Report 50104 "57F4-Delivcery Challan"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/57F4-Delivcery Challan.rdl';
    UsageCategory = ReportsandAnalysis;
    ApplicationArea = all;

    dataset
    {
        dataitem("Delivery Challan Header"; "Delivery Challan Header")
        {
            DataItemTableView = sorting("No.");
            RequestFilterFields = "No.", "Vendor No.";

            column(ReportForNavId_4640;4640)
            {
            }
            column(QRCode; QRCodeStr.QRCode)
            {
            }
            column(ZAVENIR_DAUBERT_INDIA_PRIVATE_LIMITED_;'ZAVENIR DAUBERT INDIA PRIVATE LIMITED')
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
            column(Delivery_Challan_Header__No__; "No.")
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
            column(Delivery_Challan_Header__Vehical_No__; "Vehical No.")
            {
            }
            column(CST; CST)
            {
            }
            column(ECC; ECC)
            {
            }
            column(Delivery_Challan_Header__Delivery_Challan_Header___No__; "Delivery Challan Header"."No.")
            {
            }
            column(Delivery_Challan_Header__Delivery_Challan_Header___Challan_Date_; "Delivery Challan Header"."Challan Date")
            {
            }
            column(Delivery_Challan_Header__Vendor_Name_; "Vendor Name")
            {
            }
            column(Delivery_Challan_Header__Vendor_No__; "Vendor No.")
            {
            }
            column(Vend_Address; Vend.Address)
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
            column(Delivery_Challan_Header__Delivery_Challan_Header___Item_No__; "Delivery Challan Header"."Item No.")
            {
            }
            column(VendPANNo; Vend."P.A.N. No.")
            {
            }
            column(Delivery_Challan_Header__Sub__order_No__; "Sub. order No.")
            {
            }
            column(Item2_Description; Item2.Description)
            {
            }
            column(Item2__Description_2_; Item2."Description 2")
            {
            }
            column(PurchaseLine1_Quantity; PurchaseLine1.Quantity)
            {
            }
            column(Item2__Base_Unit_of_Measure_; Item2."Base Unit of Measure")
            {
            }
            column(PurchCommentLine_Comment; PurchCommentLine.Comment)
            {
            }
            column(AMT1; AMT1)
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
            column(Delivery_Challan_Header__Vehical_No__Caption; FieldCaption("Vehical No."))
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
            column(Delivery_Challan_Header__Sub__order_No__Caption; FieldCaption("Sub. order No."))
            {
            }
            column(Qty_Caption; Qty_CaptionLbl)
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
            column(Registered_Office__Caption; Registered_Office__CaptionLbl)
            {
            }
            dataitem("Delivery Challan Line"; "Delivery Challan Line")
            {
                DataItemLink = "Delivery Challan No."=field("No.");
                DataItemTableView = sorting("Delivery Challan No.", "Line No.")where(Quantity=filter(<>0));

                column(ReportForNavId_1280;1280)
                {
                }
                column(Delivery_Challan_Line__Item_No__; "Item No.")
                {
                }
                column(ItemRec__Description_2_; ItemRec."Description 2")
                {
                }
                column(Delivery_Challan_Line__Unit_of_Measure_; "Unit of Measure")
                {
                }
                column(Delivery_Challan_Line_Quantity; Quantity)
                {
                }
                column(S_No__; "S No.")
                {
                }
                column(HSNSACCode_DeliveryChallanLine;'[HSN: ' + HSNCode + '  ' + GSTGroup.Description + ']')
                {
                }
                column(Delivery_Challan_Line_Description; Description)
                {
                }
                column(Item_CodeCaption; Item_CodeCaptionLbl)
                {
                }
                column(UOMCaption; UOMCaptionLbl)
                {
                }
                column(Delivery_Challan_Line_QuantityCaption; FieldCaption(Quantity))
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
                column(Delivery_Challan_Line_Deliver_Challan_No_; "Delivery Challan No.")
                {
                }
                column(Delivery_Challan_Line_Line_No_; "Line No.")
                {
                }
                column(AMT1_Control1000000026; AMT1)
                {
                }
                trigger OnAfterGetRecord()
                begin
                    "S No.":="S No." + 1;
                    if ItemRec.Get("Delivery Challan Line"."Item No.")then begin
                        Description:=ItemRec.Description;
                        No2:=ItemRec."No. 2";
                        AMT1:=ItemRec."Last Direct Cost" * "Delivery Challan Line".Quantity;
                        HSNCode:=ItemRec."HSN/SAC Code";
                    end;
                    if GSTGroup.Get(ItemRec."GST Group Code")then;
                end;
                trigger OnPreDataItem()
                begin
                    "S No.":=0;
                    AMT1:=0;
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
                Clear(QRCodeMgt);
                Clear(QRCodeStr);
                "Delivery Challan Header".CalcFields("Vendor Name");
                //CORP::PK 250819 >>>
                QRCodeMgt.BarcodeForCrMemo("Delivery Challan Header"."No.", "Delivery Challan Header"."Posting Date", "Delivery Challan Header"."Sub. order No.", "Delivery Challan Header"."Vendor Name");
                if QRCodeStr.FindFirst then;
                QRCodeStr.CalcFields(QRCode);
                //CORP::PK 250819 <<<
                PurchCommentLine.Reset;
                PurchCommentLine.SetRange(PurchCommentLine."No.", "Delivery Challan Header"."Sub. order No.");
                if PurchCommentLine.FindFirst then;
                CompInfo.Get;
                if Vend.Get("Delivery Challan Header"."Vendor No.")then begin
                    ECC:=Vend."GST Registration No.";
                    if States1.Get(Vend."State Code")then StateName:=States1.Description;
                end;
                Item2.Reset;
                if Item2.Get("Delivery Challan Header"."Item No.")then;
                PurchaseLine1.Reset;
                PurchaseLine1.SetRange(PurchaseLine1."Document No.", "Delivery Challan Header"."Sub. order No.");
                if PurchaseLine1.FindFirst then;
            end;
            trigger OnPreDataItem()
            begin
                //CurrReport.CREATETOTALS("RGP Shipment Line"."Line Amount");
                //"Delivery Challan Header".SetRange("Responsibility Center", ResponsibilityCenter.Code);
                ResAdd:=ResponsibilityCenter.Address + ', ' + ResponsibilityCenter."Address 2" + ', ' + ResponsibilityCenter.City + '-' + ResponsibilityCenter."Post Code";
                XX:=0;
                RgpLineRec.Reset;
                RgpLineRec.SetRange(RgpLineRec."Document No.", "Delivery Challan Header"."No.");
                if RgpLineRec.Find('-')then XX:=RgpLineRec.Count;
                Heading:='RETURNABLE  GATE  PASS   (57F4)';
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
    RgpLineRec: Record "Delivery Challan Line";
    ResAdd: Text[250];
    Heading: Text[250];
    AMT1: Decimal;
    Item2: Record Item;
    PurchaseLine1: Record "Purchase Line";
    PurchCommentLine: Record "Purch. Comment Line";
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
    Qty_CaptionLbl: label 'Qty.';
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
    Registered_Office__CaptionLbl: label 'Registered Office :';
    Fax__91_11_66544052___Email_ccare_zavenir_com___www_zavenir_com___CIN_No__U74899DL1995PTC069625CaptionLbl: label 'Fax +91 11 66544052 | Email ccare@zavenir.com | www.zavenir.com |';
    Item_CodeCaptionLbl: label 'Item Code';
    UOMCaptionLbl: label 'UOM';
    RemarksCaptionLbl: label 'Remarks';
    S_No_CaptionLbl: label 'S No.';
    Estimated_ValueCaptionLbl: label 'Estimated Value';
    DescriptionCaptionLbl: label 'Description';
    GSTGroup: Record "GST Group";
    QRCodeStr: Record "SSD QR Code Str";
    QRCodeMgt: Codeunit "QR Code Mgt.";
    HSNCode: Code[20];
}
