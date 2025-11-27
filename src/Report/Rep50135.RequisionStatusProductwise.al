Report 50135 "Requision Status-Productwise"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Requision Status-Productwise.rdl';
    UseRequestPage = true;
    UsageCategory = ReportsandAnalysis;
    ApplicationArea = all;

    dataset
    {
        dataitem("Posted Requision Slip Line"; "SSD Posted Requision Slip Line")
        {
            DataItemTableView = sorting("Document Type", "Req. Slip Document No.", "Line No.")order(ascending);
            RequestFilterFields = "Req. Slip Document No.";

            column(ReportForNavId_9904;9904)
            {
            }
            column(ResponsibilityCenter_Name______ResponsibilityCenter__Name_2_____; ResponsibilityCenter.Name + '(' + ResponsibilityCenter."Name 2" + ')')
            {
            }
            column(RespCntrAddr_1________RespCntrAddr_2_________RespCntrAddr_3_________RespCntrAddr_4_; RespCntrAddr[1] + ', ' + RespCntrAddr[2] + ', ' + RespCntrAddr[3] + ', ' + RespCntrAddr[4])
            {
            }
            column(FORMAT_RecReqheader__Req__Date___________FORMAT_RecReqheader__Req__Time__; Format(RecReqheader."Req. Date") + '  ' + Format(RecReqheader."Req. Time"))
            {
            }
            column(Posted_Requision_Slip_Line__Posted_Requision_Slip_Line___Req__Slip_Document_No__; "Posted Requision Slip Line"."Req. Slip Document No.")
            {
            }
            column(Product_Name_____FORMAT__Prod_Order_Source_No_________FORMAT_RecReqheader__Source_Description__;'Product Name : ' + Format("Prod.Order Source No.") + '  ' + Format(RecReqheader."Source Description"))
            {
            }
            column(SNO; SNO)
            {
            }
            column(Posted_Requision_Slip_Line_Description; Description)
            {
            }
            column(Posted_Requision_Slip_Line__Item_No__; "Item No.")
            {
            }
            column(Posted_Requision_Slip_Line__Posted_Requision_Slip_Line__Quantity; "Posted Requision Slip Line".Quantity)
            {
            }
            column(Recitem__Base_Unit_of_Measure_; Recitem."Base Unit of Measure")
            {
            }
            column(Date__Caption; Date__CaptionLbl)
            {
            }
            column(Component_Requirement___Issue_SlipCaption; Component_Requirement___Issue_SlipCaptionLbl)
            {
            }
            column(Slip_noCaption; Slip_noCaptionLbl)
            {
            }
            column(RemarkCaption; RemarkCaptionLbl)
            {
            }
            column(Required_QuantityCaption; Required_QuantityCaptionLbl)
            {
            }
            column(Issue_QuantityCaption; Issue_QuantityCaptionLbl)
            {
            }
            column(DescriptionCaption; DescriptionCaptionLbl)
            {
            }
            column(PART_NOCaption; PART_NOCaptionLbl)
            {
            }
            column(S_NOCaption; S_NOCaptionLbl)
            {
            }
            column(UnitCaption; UnitCaptionLbl)
            {
            }
            column(Issued_ByCaption; Issued_ByCaptionLbl)
            {
            }
            column(Authorised_ByCaption; Authorised_ByCaptionLbl)
            {
            }
            column(Head_of_Prod___Supervisor_Caption; Head_of_Prod___Supervisor_CaptionLbl)
            {
            }
            column(F_1521__03Caption; F_1521__03CaptionLbl)
            {
            }
            column(Posted_Requision_Slip_Line_Document_Type; "Document Type")
            {
            }
            column(Posted_Requision_Slip_Line_Line_No_; "Line No.")
            {
            }
            column(Posted_Requision_Slip_Line_Prod__Order_No_; "Prod. Order No.")
            {
            }
            dataitem("Transfer Receipt Line"; "Transfer Receipt Line")
            {
                DataItemLink = "Document No."=field("Req. Slip Document No."), "Item No."=field("Item No.");
                DataItemTableView = sorting("Document No.", "Line No.");

                column(ReportForNavId_4146;4146)
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
        SNO1:=0;
        SNO2:=0;
        SNO3:=0;
        UserSetup.Get(UserId);
        if ResponsibilityCenter.Get(UserSetup."Responsibility Center")then RespCntrAddr[1]:=ResponsibilityCenter.Address;
        RespCntrAddr[2]:=ResponsibilityCenter."Address 2";
        RespCntrAddr[3]:=ResponsibilityCenter."Address 3" + ', ' + ResponsibilityCenter.City;
        RespCntrAddr[4]:='Phone No. : ' + ResponsibilityCenter."Phone No.";
        CompressArray(RespCntrAddr);
    end;
    var RecILE: Record "Item Ledger Entry";
    SNO: Integer;
    Type: Option Summary, Detail;
    SNO1: Integer;
    RecProdComp: Record "Prod. Order Component";
    RectrnsferRcptLine: Record "Transfer Receipt Line";
    IssuedQty: Decimal;
    SNO2: Integer;
    SNO3: Integer;
    BalQty: Decimal;
    NetBal: Decimal;
    TotalIssue: Decimal;
    Recitem: Record Item;
    ResponsibilityCenter: Record "Responsibility Center";
    RespCntrAddr: array[4]of Text[80];
    UserSetup: Record "User Setup";
    RecReqheader: Record "SSD Posted Req. Slip Header";
    Date__CaptionLbl: label 'Date :';
    Component_Requirement___Issue_SlipCaptionLbl: label 'Component Requirement / Issue Slip';
    Slip_noCaptionLbl: label 'Slip no';
    RemarkCaptionLbl: label 'Remark';
    Required_QuantityCaptionLbl: label 'Required Quantity';
    Issue_QuantityCaptionLbl: label 'Issue Quantity';
    DescriptionCaptionLbl: label 'Description';
    PART_NOCaptionLbl: label 'PART NO';
    S_NOCaptionLbl: label 'S NO';
    UnitCaptionLbl: label 'Unit';
    Issued_ByCaptionLbl: label 'Issued By';
    Authorised_ByCaptionLbl: label 'Authorised By';
    Head_of_Prod___Supervisor_CaptionLbl: label '(Head of Prod / Supervisor)';
    F_1521__03CaptionLbl: label 'F 1521/ 03';
}
