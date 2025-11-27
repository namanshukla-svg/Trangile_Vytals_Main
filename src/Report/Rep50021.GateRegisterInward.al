Report 50021 "Gate Register-Inward.."
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Gate Register-Inward...rdl';
    UsageCategory = ReportsandAnalysis;
    ApplicationArea = all;

    dataset
    {
        dataitem("Gate Register"; "SSD Gate Register")
        {
            DataItemTableView = sorting("Entry No.")order(ascending)where("Gate Entry Type"=filter(Inbound));
            RequestFilterFields = "Document Type", "Document No.", "Gate Entry Type", "Party Type", "Party No.", "Gate Entry Date";

            column(ReportForNavId_1171;1171)
            {
            }
            column(FORMAT_TODAY_0_4_; Format(Today, 0, 4))
            {
            }
            column(CurrReport_PAGENO; CurrReport.PageNo)
            {
            }
            column(UserId; UserId)
            {
            }
            column(startingdate; startingdate)
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
            column(rescen_State; rescen.State)
            {
            }
            column(rescen__Address_2_; rescen."Address 2")
            {
            }
            column(rescen_Address; rescen.Address)
            {
            }
            column(rescen_Name; rescen.Name)
            {
            }
            column(endingdate; endingdate)
            {
            }
            column(Gate_Register__Gate_Entry_No__; "Gate Entry No.")
            {
            }
            column(Gate_Register__Gate_Entry_Date_; "Gate Entry Date")
            {
            }
            column(Gate_Register__Gate_Entry_Time_; "Gate Entry Time")
            {
            }
            column(Gate_Register__Party_No__; "Party No.")
            {
            }
            column(Gate_Register__Party_Name_; "Party Name")
            {
            }
            column(Gate_Register__No__; "No.")
            {
            }
            column(Gate_Register_Quantity; Quantity)
            {
            }
            column(Gate_Register__Unit_of_Measure_Code_; "Unit of Measure Code")
            {
            }
            column(Gate_Register__Challan_Bill_No__; "Challan/Bill No.")
            {
            }
            column(Gate_Register_Description; Description)
            {
            }
            column(Gate_Register__Vechile_No__; "Vechile No.")
            {
            }
            column(Gate_Register__No_2_; "No.2")
            {
            }
            column(Gate_Register_Quantity_Control1000000008; Quantity)
            {
            }
            column(Gate_Register__Inward_Caption; Gate_Register__Inward_CaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(From_DateCaption; From_DateCaptionLbl)
            {
            }
            column(IN_Coming_Register_Type_Caption; IN_Coming_Register_Type_CaptionLbl)
            {
            }
            column(To_DateCaption; To_DateCaptionLbl)
            {
            }
            column(Vehicle_No_Caption; Vehicle_No_CaptionLbl)
            {
            }
            column(GE_No_Caption; GE_No_CaptionLbl)
            {
            }
            column(Gate_In__Out_Date___TimeCaption; Gate_In__Out_Date___TimeCaptionLbl)
            {
            }
            column(Party_CodeCaption; Party_CodeCaptionLbl)
            {
            }
            column(Party_NameCaption; Party_NameCaptionLbl)
            {
            }
            column(Item_CodeCaption; Item_CodeCaptionLbl)
            {
            }
            column(QuantityCaption; QuantityCaptionLbl)
            {
            }
            column(UOMCaption; UOMCaptionLbl)
            {
            }
            column(Challan_Bill_No_Caption; Challan_Bill_No_CaptionLbl)
            {
            }
            column(Item_DescriptionCaption; Item_DescriptionCaptionLbl)
            {
            }
            column(Grand_TotalCaption; Grand_TotalCaptionLbl)
            {
            }
            column(Gate_Register_Entry_No_; "Entry No.")
            {
            }
            trigger OnPreDataItem()
            begin
                if "Gate Register".GetFilter("Gate Register"."Gate Entry Date") <> '' then begin
                    startingdate:=GetRangeMin("Gate Register"."Gate Entry Date");
                    endingdate:=GetRangemax("Gate Register"."Gate Entry Date");
                end;
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
        Datefilter:="Gate Register".GetFilter("Gate Register"."Gate Entry Date");
        //GlobalDim1.GET();
        rescen.Get(UserMgt.GetRespCenterFilter);
        rescen.Get(UserMgt.GetRespCenterFilter);
    end;
    var TotalGrossWeight: Decimal;
    SalesInvLine: Record "Sales Invoice Line";
    SalesInvHeader: Record "Sales Invoice Header";
    InvAmt: Decimal;
    "No.ofPkt.": Decimal;
    NetTotal: Decimal;
    GrossWt: Decimal;
    "No.ofPkt": Decimal;
    "LRNo.": Code[20];
    Datefilter: Text[30];
    rescen: Record "Responsibility Center";
    UserMgt: Codeunit "SSD User Setup Management";
    Saleschebuff: Record "SSD Sales Schedule Buffer";
    startingdate: Date;
    endingdate: Date;
    Gate_Register__Inward_CaptionLbl: label 'Gate Register (Inward)';
    CurrReport_PAGENOCaptionLbl: label 'Page';
    From_DateCaptionLbl: label 'From Date';
    IN_Coming_Register_Type_CaptionLbl: label 'IN Coming Register Type:';
    To_DateCaptionLbl: label 'To Date';
    Vehicle_No_CaptionLbl: label 'Vehicle No.';
    GE_No_CaptionLbl: label 'GE No.';
    Gate_In__Out_Date___TimeCaptionLbl: label 'Gate In/ Out Date & Time';
    Party_CodeCaptionLbl: label 'Party Code';
    Party_NameCaptionLbl: label 'Party Name';
    Item_CodeCaptionLbl: label 'Item Code';
    QuantityCaptionLbl: label 'Quantity';
    UOMCaptionLbl: label 'UOM';
    Challan_Bill_No_CaptionLbl: label 'Challan/Bill No.';
    Item_DescriptionCaptionLbl: label 'Item Description';
    Grand_TotalCaptionLbl: label 'Grand Total';
}
