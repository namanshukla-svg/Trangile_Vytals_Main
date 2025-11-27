Report 50297 "Posted NRGP"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Posted NRGP.rdl';
    UsageCategory = ReportsandAnalysis;
    ApplicationArea = all;

    dataset
    {
        dataitem("RGP Shipment Header"; "SSD RGP Shipment Header")
        {
            DataItemTableView = sorting("No.")where(NRGP=filter(true));
            RequestFilterFields = "Posting Date", "Party Type", "Party No.";

            column(ReportForNavId_4282;4282)
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
            column(SrNoCaption; SrNoCaptionLbl)
            {
            }
            column(RGP_Shipment_Line_DescriptionCaption; "RGP Shipment Line".FieldCaption(Description))
            {
            }
            column(Gate_Pass_DateCaption; Gate_Pass_DateCaptionLbl)
            {
            }
            column(Posting_DateCaption; Posting_DateCaptionLbl)
            {
            }
            column(Posted_NRGPCaption; Posted_NRGPCaptionLbl)
            {
            }
            column(Item_No_Caption; Item_No_CaptionLbl)
            {
            }
            column(RGP_Shipment_Line_QuantityCaption; "RGP Shipment Line".FieldCaption(Quantity))
            {
            }
            column(RGP_Shipment_Line__Quantity_Base__Caption; "RGP Shipment Line".FieldCaption("Quantity(Base)"))
            {
            }
            column(NumberCaption; NumberCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(Party_NameCaption; Party_NameCaptionLbl)
            {
            }
            column(RGP_Shipment_Header_No_; "No.")
            {
            }
            dataitem("RGP Shipment Line"; "SSD RGP Shipment Line")
            {
                DataItemLink = "Document No."=field("No.");
                DataItemTableView = sorting("Document Type", "Document No.")order(ascending)where(NRGP=filter(true));

                column(ReportForNavId_5260;5260)
                {
                }
                column(RGPHeaderRec__Party_Name_; RGPHeaderRec."Party Name")
                {
                }
                column(SrNo; SrNo)
                {
                }
                column(RGP_Shipment_Line_Description; Description)
                {
                }
                column(RGP_Shipment_Header___Posting_Date_; "RGP Shipment Header"."Posting Date")
                {
                }
                column(RGP_Shipment_Header___Posting_Date__Control1000000019; "RGP Shipment Header"."Posting Date")
                {
                }
                column(RGP_Shipment_Line__No__; "No.")
                {
                }
                column(RGP_Shipment_Line_Quantity; Quantity)
                {
                }
                column(RGP_Shipment_Line__Quantity_Base__; "Quantity(Base)")
                {
                }
                column(RGP_Shipment_Line__Document_No__; "Document No.")
                {
                }
                column(RGP_Shipment_Header___Party_Name_; "RGP Shipment Header"."Party Name")
                {
                }
                column(SrNo_Control1000000047; SrNo)
                {
                }
                column(RGP_Shipment_Line_Description_Control1000000057; Description)
                {
                }
                column(RGPHeaderRec__Posting_Date_; RGPHeaderRec."Posting Date")
                {
                }
                column(Quantity___Quantity_Base__; Quantity - "Quantity(Base)")
                {
                }
                column(RGP_Shipment_Line__Posting_Date_; "Posting Date")
                {
                }
                column(overdue; overdue)
                {
                }
                column(RGP_Shipment_Line__No___Control1000000062; "No.")
                {
                }
                column(RGP_Shipment_Line_Quantity_Control1000000063; Quantity)
                {
                }
                column(RGP_Shipment_Line__Quantity_Base___Control1000000067; "Quantity(Base)")
                {
                }
                column(RGP_Shipment_Line__Document_No___Control1000000070; "Document No.")
                {
                }
                column(Party_NameCaption_Control1000000013; Party_NameCaption_Control1000000013Lbl)
                {
                }
                column(RGP_Shipment_Line_Line_No_; "Line No.")
                {
                }
                trigger OnPreDataItem()
                begin
                    SetRange("Responsibility Center", ResponsibilityCenter.Code);
                    ResAdd:=ResponsibilityCenter.Address + ', ' + ResponsibilityCenter."Address 2" + ', ' + ResponsibilityCenter.City + '-' + ResponsibilityCenter."Post Code";
                    SrNo:=0;
                end;
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
        ResponsibilityCenter.Get(UserMgt.GetRespCenterFilter);
        rescen.Get(UserMgt.GetRespCenterFilter);
    end;
    var rescen: Record "Responsibility Center";
    SrNo: Integer;
    overdue: Integer;
    RGPHeaderRec: Record "SSD RGP Shipment Header";
    ResponsibilityCenter: Record "Responsibility Center";
    UserMgt: Codeunit "SSD User Setup Management";
    ResAdd: Text[250];
    SrNoCaptionLbl: label 'SrNo';
    Gate_Pass_DateCaptionLbl: label 'Gate Pass Date';
    Posting_DateCaptionLbl: label 'Posting Date';
    Posted_NRGPCaptionLbl: label 'Posted NRGP';
    Item_No_CaptionLbl: label 'Item No.';
    NumberCaptionLbl: label 'Number';
    CurrReport_PAGENOCaptionLbl: label 'Page';
    Party_NameCaptionLbl: label 'Party Name';
    Party_NameCaption_Control1000000013Lbl: label 'Party Name';
}
