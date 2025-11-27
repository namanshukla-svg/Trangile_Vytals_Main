Report 50006 "Pending RGP/NRGP"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Pending RGPNRGP.rdl';
    UsageCategory = ReportsandAnalysis;
    ApplicationArea = all;

    dataset
    {
        dataitem("RGP Line"; "SSD RGP Line")
        {
            DataItemTableView = sorting("Party No.", "Document No.", "Document Type", "No.")order(ascending)where(Subcontracting=filter(false));
            RequestFilterFields = "Document No.", "Party Type", "Party No.", "Posting Date", "Document SubType";

            column(ReportForNavId_7724;7724)
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
            column(rescen__Country_Region_Code_; rescen."Country/Region Code")
            {
            }
            column(rescen__Post_Code_; rescen."Post Code")
            {
            }
            column(rescen_City; rescen.City)
            {
            }
            column(rescen__Address_2_; rescen."Address 2")
            {
            }
            column(rescen_State; rescen.State)
            {
            }
            column(rescen_Address; rescen.Address)
            {
            }
            column(rescen_Name; rescen.Name)
            {
            }
            column(RGPHeaderRec__Party_Name_; RGPHeaderRec."Party Name")
            {
            }
            column(SrNo; SrNo)
            {
            }
            column(RGP_Line_Description; Description)
            {
            }
            column(RGPHeaderRec__Posting_Date_; RGPHeaderRec."Posting Date")
            {
            }
            column(RGP_Line___Quantity_Shipped_____RGP_Line___Quantity_Received_; "RGP Line"."Quantity Shipped" - "RGP Line"."Quantity Received")
            {
            }
            column(RGP_Line__Expected_Receipt_Date_; "Expected Receipt Date")
            {
            }
            column(overdue; overdue)
            {
            }
            column(RGP_Line__No__; "No.")
            {
            }
            column(RGP_Line__Quantity_Shipped_; "Quantity Shipped")
            {
            }
            column(RGP_Line__Quantity_Received_; "Quantity Received")
            {
            }
            column(RGP_Line__Document_No__; "Document No.")
            {
            }
            column(DimensionValue_Name; DimensionValue.Name)
            {
            }
            column(SrNo_Control1000000047; SrNo)
            {
            }
            column(RGP_Line_Description_Control1000000057; Description)
            {
            }
            column(RGPHeaderRec__Posting_Date__Control1000000058; RGPHeaderRec."Posting Date")
            {
            }
            column(RGP_Line___Quantity_Shipped_____RGP_Line___Quantity_Received__Control1000000059; "RGP Line"."Quantity Shipped" - "RGP Line"."Quantity Received")
            {
            }
            column(RGP_Line__Expected_Receipt_Date__Control1000000060; "Expected Receipt Date")
            {
            }
            column(overdue_Control1000000061; overdue)
            {
            }
            column(RGP_Line__No___Control1000000062; "No.")
            {
            }
            column(RGP_Line__Quantity_Shipped__Control1000000063; "Quantity Shipped")
            {
            }
            column(RGP_Line__Quantity_Received__Control1000000067; "Quantity Received")
            {
            }
            column(RGP_Line__Document_No___Control1000000070; "Document No.")
            {
            }
            column(DimensionValue_Name_Control1000000084; DimensionValue.Name)
            {
            }
            column(SrNoCaption; SrNoCaptionLbl)
            {
            }
            column(RGP_Line_DescriptionCaption; FieldCaption(Description))
            {
            }
            column(Gate_Pass_DateCaption; Gate_Pass_DateCaptionLbl)
            {
            }
            column(Balance_QuantityCaption; Balance_QuantityCaptionLbl)
            {
            }
            column(RGP_Line__Expected_Receipt_Date_Caption; FieldCaption("Expected Receipt Date"))
            {
            }
            column(Overdue_DaysCaption; Overdue_DaysCaptionLbl)
            {
            }
            column(PENDING__RGPCaption; PENDING__RGPCaptionLbl)
            {
            }
            column(Item_No_Caption; Item_No_CaptionLbl)
            {
            }
            column(RGP_Line__Quantity_Shipped_Caption; FieldCaption("Quantity Shipped"))
            {
            }
            column(RGP_Line__Quantity_Received_Caption; FieldCaption("Quantity Received"))
            {
            }
            column(NumberCaption; NumberCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(EmployeeCaption; EmployeeCaptionLbl)
            {
            }
            column(Party_NameCaption; Party_NameCaptionLbl)
            {
            }
            column(RGP_Line_Document_Type; "Document Type")
            {
            }
            column(RGP_Line_Line_No_; "Line No.")
            {
            }
            column(RGP_Line_Party_No_; "Party No.")
            {
            }
            trigger OnAfterGetRecord()
            begin
                if "RGP Line"."Expected Receipt Date" = 0D then overdue:=0
                else
                    overdue:=Today - "RGP Line"."Expected Receipt Date";
                RGPHeaderRec.Get("Document Type", "Document No.");
                if DimensionValue.Get('EMPLOYEE', RGPHeaderRec."Advising Employee")then;
                if not alldetail then if "RGP Line"."Quantity Shipped" - "RGP Line"."Quantity Received" = 0 then CurrReport.Skip;
            end;
            trigger OnPreDataItem()
            begin
                //"RGP Line".SetRange("Responsibility Center", ResponsibilityCenter.Code);
                ResAdd:=ResponsibilityCenter.Address + ', ' + ResponsibilityCenter."Address 2" + ', ' + ResponsibilityCenter.City + '-' + ResponsibilityCenter."Post Code";
                SrNo:=0;
                SetRange("RGP Line".NRGP, false);
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
    trigger OnInitReport()
    begin
        alldetail:=false;
    end;
    trigger OnPreReport()
    begin
        ResponsibilityCenter.Get(UserMgt.GetRespCenterFilter);
        rescen.Get(UserMgt.GetRespCenterFilter);
    end;
    var rescen: Record "Responsibility Center";
    SrNo: Integer;
    overdue: Integer;
    RGPHeaderRec: Record "SSD RGP Header";
    ResponsibilityCenter: Record "Responsibility Center";
    UserMgt: Codeunit "SSD User Setup Management";
    ResAdd: Text[250];
    alldetail: Boolean;
    DimensionValue: Record "Dimension Value";
    NRGP: Boolean;
    SrNoCaptionLbl: label 'SrNo';
    Gate_Pass_DateCaptionLbl: label 'Gate Pass Date';
    Balance_QuantityCaptionLbl: label 'Balance Quantity';
    Overdue_DaysCaptionLbl: label 'Overdue Days';
    PENDING__RGPCaptionLbl: label 'PENDING  RGP';
    Item_No_CaptionLbl: label 'Item No.';
    NumberCaptionLbl: label 'Number';
    CurrReport_PAGENOCaptionLbl: label 'Page';
    EmployeeCaptionLbl: label 'Employee';
    Party_NameCaptionLbl: label 'Party Name';
}
