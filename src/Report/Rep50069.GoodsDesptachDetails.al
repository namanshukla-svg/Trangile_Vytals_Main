Report 50069 "Goods Desptach Details"
{
    // Table ID,Document No.,Line No.,Dimension Code
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Goods Desptach Details.rdl';
    UsageCategory = ReportsandAnalysis;
    ApplicationArea = all;

    dataset
    {
        dataitem(Date; Date)
        {
            DataItemTableView = sorting("Period Type", "Period Start")order(ascending)where("Period Type"=const(Date));
            PrintOnlyIfDetail = true;

            column(ReportForNavId_9857;9857)
            {
            }
            column(CompInfo_Name; CompInfo.Name)
            {
            }
            column(CompInfo_Picture; CompInfo.Picture)
            {
            }
            column(Goods_Dispatch_Details_;'Goods Dispatch Details')
            {
            }
            column(DataItem1102152003;'57Th KM STONE, DELHI - JAIPUR HIGHWAY, VILLAGE BINOLA, DISTRICT GURGAON - 122 413, HARYANA, INDIA\ PHONE ++91 124 4981000, FAX: ++91 124 4981002')
            {
            }
            column(Date_______FORMAT__Period_Start__;'Date : ' + Format("Period Start"))
            {
            }
            column(Date_Period_Type; "Period Type")
            {
            }
            column(Date_Period_Start; "Period Start")
            {
            }
            dataitem("Sales Invoice Line"; "Sales Invoice Line")
            {
                DataItemTableView = sorting("Posting Date", "Document No.", "Line No.")where(Type=const(Item));

                column(ReportForNavId_1570;1570)
                {
                }
                column(Region; Region)
                {
                }
                column(Sales_Invoice_Line__Document_No__; "Document No.")
                {
                }
                column(Sales_Invoice_Line__Posting_Date_; "Posting Date")
                {
                }
                column(PartyName; PartyName)
                {
                }
                column(Sales_Invoice_Line__No__; "No.")
                {
                }
                column(Description________Description_2_; Description + ' ' + "Description 2")
                {
                }
                column(Sales_Invoice_Line__Unit_of_Measure_Code_; "Unit of Measure Code")
                {
                }
                column(Sales_Invoice_Line_Quantity; Quantity)
                {
                }
                column(Sales_Invoice_Line__Line_Amount_; "Line Amount")
                {
                }
                column(Sales_Invoice_Line__Actual_Wt_; "Actual Wt")
                {
                }
                column(Sales_Invoice_Line__Gross_Wt_; "Gross Wt")
                {
                }
                column(Sales_Invoice_Line__Freight_Amount_; "Freight Amount")
                {
                }
                column(TransporterName; TransporterName)
                {
                }
                column(ShipmentMethodCode; ShipmentMethodCode)
                {
                }
                column(Sales_Invoice_Line__Transport_Method_; "Transport Method")
                {
                }
                column(Document_No_______Total__; "Document No." + ' Total:')
                {
                }
                column(Sales_Invoice_Line__Gross_Wt__Control1102152084; "Gross Wt")
                {
                }
                column(Sales_Invoice_Line_Quantity_Control1102152085; Quantity)
                {
                }
                column(Sales_Invoice_Line_Quantity_Control1000000111; Quantity)
                {
                }
                column(RegionCaption; RegionCaptionLbl)
                {
                }
                column(Invoice_NoCaption; Invoice_NoCaptionLbl)
                {
                }
                column(Invoice_DateCaption; Invoice_DateCaptionLbl)
                {
                }
                column(PartyCaption; PartyCaptionLbl)
                {
                }
                column(DescriptionCaption; DescriptionCaptionLbl)
                {
                }
                column(Item_CodeCaption; Item_CodeCaptionLbl)
                {
                }
                column(QuantityCaption; QuantityCaptionLbl)
                {
                }
                column(AmountCaption; AmountCaptionLbl)
                {
                }
                column(UOMCaption; UOMCaptionLbl)
                {
                }
                column(Net_Wt_Caption; Net_Wt_CaptionLbl)
                {
                }
                column(GWT_Caption; GWT_CaptionLbl)
                {
                }
                column(FreightCaption; FreightCaptionLbl)
                {
                }
                column(TransporterCaption; TransporterCaptionLbl)
                {
                }
                column(Sales_Invoice_EntryCaption; Sales_Invoice_EntryCaptionLbl)
                {
                }
                column(Shipment_MethodCaption; Shipment_MethodCaptionLbl)
                {
                }
                column(Sales_Invoice_Line__Transport_Method_Caption; FieldCaption("Transport Method"))
                {
                }
                column(TotalCaption; TotalCaptionLbl)
                {
                }
                column(Sales_Invoice_Line_Line_No_; "Line No.")
                {
                }
                trigger OnAfterGetRecord()
                begin
                    // For Getting Region Name
                    //PostedDocDimension.GET(113, "Document No.", "Line No.", GLSetup."Shortcut Dimension 5 Code"); // BIS 1145
                    //DimensionValue.GET(PostedDocDimension."Dimension Code", PostedDocDimension."Dimension Value Code"); // BIS 1145
                    Region:=DimensionValue.Name;
                    // For Getting Party Name
                    Customer.Get("Sell-to Customer No.");
                    PartyName:="Sell-to Customer No." + '-' + Customer.Name;
                    // For Getting Transporter Name
                    SalesInvoiceHeader.Get("Document No.");
                    if SalesInvoiceHeader."Shipping Agent Code" <> '' then begin
                        ShippingAgent.Get(SalesInvoiceHeader."Shipping Agent Code");
                        TransporterName:=ShippingAgent.Name;
                    end;
                    // For Getting Shipment Method
                    if SalesInvoiceHeader."Shipment Method Code" <> '' then begin
                        ShipmentMethod.Get(SalesInvoiceHeader."Shipment Method Code");
                        ShipmentMethodCode:=ShipmentMethod.Code;
                    end;
                end;
                trigger OnPreDataItem()
                begin
                    InitializeVariable;
                    if EndDate <> 0D then SetRange("Posting Date", Date."Period Start"); //StartDate, EndDate);
                    SetFilter("Location Code", "Location Filter");
                end;
            }
            dataitem(RGP; "SSD RGP Shipment Line")
            {
                DataItemTableView = sorting("Document Type", "Document No.")where(NRGP=const(false), "Document SubType"=const(" "));

                column(ReportForNavId_7923;7923)
                {
                }
                column(EmptyString;'-')
                {
                }
                column(RGP__Document_No__; "Document No.")
                {
                }
                column(RGP__Posting_Date_; "Posting Date")
                {
                }
                column(RGP__No__; "No.")
                {
                }
                column(RGP_Quantity; Quantity)
                {
                }
                column(ShipmentMethodCode_Control1000000041; ShipmentMethodCode)
                {
                }
                column(RGP__Unit_Of_Measure_Code_; "Unit Of Measure Code")
                {
                }
                column(RGP__Line_Amount_; "Line Amount")
                {
                }
                column(PartyName_Control1102152021; PartyName)
                {
                }
                column(Description________Description_2__Control1102152022; Description + ' ' + "Description 2")
                {
                }
                column(TransporterName_Control1102152023; TransporterName)
                {
                }
                column(RGP_Quantity_Control1000000114; Quantity)
                {
                }
                column(RGP_EntryCaption; RGP_EntryCaptionLbl)
                {
                }
                column(RegionCaption_Control1102152006; RegionCaption_Control1102152006Lbl)
                {
                }
                column(Invoice_NoCaption_Control1102152007; Invoice_NoCaption_Control1102152007Lbl)
                {
                }
                column(Invoice_DateCaption_Control1102152008; Invoice_DateCaption_Control1102152008Lbl)
                {
                }
                column(PartyCaption_Control1102152009; PartyCaption_Control1102152009Lbl)
                {
                }
                column(Item_CodeCaption_Control1102152010; Item_CodeCaption_Control1102152010Lbl)
                {
                }
                column(DescriptionCaption_Control1102152011; DescriptionCaption_Control1102152011Lbl)
                {
                }
                column(QuantityCaption_Control1102152012; QuantityCaption_Control1102152012Lbl)
                {
                }
                column(UOMCaption_Control1102152013; UOMCaption_Control1102152013Lbl)
                {
                }
                column(AmountCaption_Control1102152014; AmountCaption_Control1102152014Lbl)
                {
                }
                column(Net_Wt_Caption_Control1102152015; Net_Wt_Caption_Control1102152015Lbl)
                {
                }
                column(GWT_Caption_Control1102152016; GWT_Caption_Control1102152016Lbl)
                {
                }
                column(FreightCaption_Control1102152017; FreightCaption_Control1102152017Lbl)
                {
                }
                column(TransporterCaption_Control1102152019; TransporterCaption_Control1102152019Lbl)
                {
                }
                column(Shipment_Method_CodeCaption; Shipment_Method_CodeCaptionLbl)
                {
                }
                column(TotalCaption_Control1000000115; TotalCaption_Control1000000115Lbl)
                {
                }
                column(RGP_Line_No_; "Line No.")
                {
                }
                trigger OnAfterGetRecord()
                begin
                    // For Getting Party Name
                    RGPShipmentHeader.Get("Document No.");
                    PartyName:=RGPShipmentHeader."Party No." + '-' + RGPShipmentHeader."Party Name";
                    // For Getting Transporter Name
                    TransporterName:=RGPShipmentHeader."Transporter Name";
                end;
                trigger OnPreDataItem()
                begin
                    InitializeVariable;
                    if EndDate <> 0D then SetRange("Posting Date", Date."Period Start"); //StartDate, EndDate);
                    SetFilter("Location Code", "Location Filter");
                end;
            }
            dataitem(NRGP; "SSD RGP Shipment Line")
            {
                DataItemTableView = sorting("Document Type", "Document No.")where(NRGP=const(true), "Document SubType"=const(" "));

                column(ReportForNavId_8576;8576)
                {
                }
                column(ShipmentMethodCode_Control1102152039; ShipmentMethodCode)
                {
                }
                column(TransporterName_Control1102152040; TransporterName)
                {
                }
                column(NRGP__Line_Amount_; "Line Amount")
                {
                }
                column(NRGP__Unit_Of_Measure_Code_; "Unit Of Measure Code")
                {
                }
                column(NRGP_Quantity; Quantity)
                {
                }
                column(Description________Description_2__Control1102152044; Description + ' ' + "Description 2")
                {
                }
                column(NRGP__No__; "No.")
                {
                }
                column(PartyName_Control1102152046; PartyName)
                {
                }
                column(NRGP__Posting_Date_; "Posting Date")
                {
                }
                column(NRGP__Document_No__; "Document No.")
                {
                }
                column(EmptyString_Control1102152049;'-')
                {
                }
                column(NRGP_Quantity_Control1000000116; Quantity)
                {
                }
                column(NRGP_EntryCaption; NRGP_EntryCaptionLbl)
                {
                }
                column(Shipment_Method_CodeCaption_Control1102152024; Shipment_Method_CodeCaption_Control1102152024Lbl)
                {
                }
                column(TransporterCaption_Control1102152025; TransporterCaption_Control1102152025Lbl)
                {
                }
                column(FreightCaption_Control1102152026; FreightCaption_Control1102152026Lbl)
                {
                }
                column(GWT_Caption_Control1102152027; GWT_Caption_Control1102152027Lbl)
                {
                }
                column(Net_Wt_Caption_Control1102152028; Net_Wt_Caption_Control1102152028Lbl)
                {
                }
                column(AmountCaption_Control1102152029; AmountCaption_Control1102152029Lbl)
                {
                }
                column(QuantityCaption_Control1102152030; QuantityCaption_Control1102152030Lbl)
                {
                }
                column(UOMCaption_Control1102152031; UOMCaption_Control1102152031Lbl)
                {
                }
                column(DescriptionCaption_Control1102152032; DescriptionCaption_Control1102152032Lbl)
                {
                }
                column(Item_CodeCaption_Control1102152033; Item_CodeCaption_Control1102152033Lbl)
                {
                }
                column(PartyCaption_Control1102152034; PartyCaption_Control1102152034Lbl)
                {
                }
                column(Invoice_DateCaption_Control1102152035; Invoice_DateCaption_Control1102152035Lbl)
                {
                }
                column(Invoice_NoCaption_Control1102152036; Invoice_NoCaption_Control1102152036Lbl)
                {
                }
                column(RegionCaption_Control1102152037; RegionCaption_Control1102152037Lbl)
                {
                }
                column(TotalCaption_Control1000000117; TotalCaption_Control1000000117Lbl)
                {
                }
                column(NRGP_Line_No_; "Line No.")
                {
                }
                trigger OnAfterGetRecord()
                begin
                    // For Getting Party Name
                    RGPShipmentHeader.Get("Document No.");
                    PartyName:=RGPShipmentHeader."Party No." + '-' + RGPShipmentHeader."Party Name";
                    // For Getting Transporter Name
                    TransporterName:=RGPShipmentHeader."Transporter Name";
                end;
                trigger OnPreDataItem()
                begin
                    InitializeVariable;
                    if EndDate <> 0D then SetRange("Posting Date", Date."Period Start"); //StartDate, EndDate);
                    SetFilter("Location Code", "Location Filter");
                end;
            }
            dataitem("57F4"; "SSD RGP Shipment Line")
            {
                DataItemTableView = sorting("Document Type", "Document No.")where("Document SubType"=const("57F4"));

                column(ReportForNavId_8116;8116)
                {
                }
                column(ShipmentMethodCode_Control1102152065; ShipmentMethodCode)
                {
                }
                column(TransporterName_Control1102152066; TransporterName)
                {
                }
                column(V57F4__Line_Amount_; "Line Amount")
                {
                }
                column(V57F4__Unit_Of_Measure_Code_; "Unit Of Measure Code")
                {
                }
                column(V57F4_Quantity; Quantity)
                {
                }
                column(Description________Description_2__Control1102152070; Description + ' ' + "Description 2")
                {
                }
                column(V57F4__No__; "No.")
                {
                }
                column(PartyName_Control1102152072; PartyName)
                {
                }
                column(V57F4__Posting_Date_; "Posting Date")
                {
                }
                column(V57F4__Document_No__; "Document No.")
                {
                }
                column(EmptyString_Control1102152075;'-')
                {
                }
                column(V57F4_Quantity_Control1102152076; Quantity)
                {
                }
                column(V57F4_EntryCaption; V57F4_EntryCaptionLbl)
                {
                }
                column(Shipment_Method_CodeCaption_Control1102152050; Shipment_Method_CodeCaption_Control1102152050Lbl)
                {
                }
                column(TransporterCaption_Control1102152051; TransporterCaption_Control1102152051Lbl)
                {
                }
                column(FreightCaption_Control1102152052; FreightCaption_Control1102152052Lbl)
                {
                }
                column(GWT_Caption_Control1102152053; GWT_Caption_Control1102152053Lbl)
                {
                }
                column(Net_Wt_Caption_Control1102152054; Net_Wt_Caption_Control1102152054Lbl)
                {
                }
                column(AmountCaption_Control1102152055; AmountCaption_Control1102152055Lbl)
                {
                }
                column(UOMCaption_Control1102152056; UOMCaption_Control1102152056Lbl)
                {
                }
                column(QuantityCaption_Control1102152057; QuantityCaption_Control1102152057Lbl)
                {
                }
                column(DescriptionCaption_Control1102152059; DescriptionCaption_Control1102152059Lbl)
                {
                }
                column(Item_CodeCaption_Control1102152060; Item_CodeCaption_Control1102152060Lbl)
                {
                }
                column(PartyCaption_Control1102152061; PartyCaption_Control1102152061Lbl)
                {
                }
                column(Invoice_DateCaption_Control1102152062; Invoice_DateCaption_Control1102152062Lbl)
                {
                }
                column(Invoice_NoCaption_Control1102152063; Invoice_NoCaption_Control1102152063Lbl)
                {
                }
                column(RegionCaption_Control1102152064; RegionCaption_Control1102152064Lbl)
                {
                }
                column(TotalCaption_Control1102152077; TotalCaption_Control1102152077Lbl)
                {
                }
                column(V57F4_Line_No_; "Line No.")
                {
                }
                trigger OnAfterGetRecord()
                begin
                    // For Getting Party Name
                    RGPShipmentHeader.Get("Document No.");
                    PartyName:=RGPShipmentHeader."Party No." + '-' + RGPShipmentHeader."Party Name";
                    // For Getting Transporter Name
                    TransporterName:=RGPShipmentHeader."Transporter Name";
                end;
                trigger OnPreDataItem()
                begin
                    InitializeVariable;
                    if EndDate <> 0D then SetRange("Posting Date", Date."Period Start"); //StartDate, EndDate);
                    SetFilter("Location Code", "Location Filter");
                end;
            }
            trigger OnPreDataItem()
            begin
                CompInfo.Get;
                CompInfo.CalcFields(Picture);
                SetRange("Period Start", StartDate, EndDate);
                RGPShptLine.Reset;
                RGPShptLine.SetRange("Posting Date", 0D);
                if RGPShptLine.FindFirst then repeat RGPShipmentHeader.Get(RGPShptLine."Document No.");
                        RGPShptLine."Posting Date":=RGPShipmentHeader."Posting Date";
                        RGPShptLine.Modify;
                    until RGPShptLine.Next = 0;
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
        GLSetup.Get;
        if EndDate = 0D then Error(Text0001);
    end;
    var SalesInvoiceHeader: Record "Sales Invoice Header";
    RGPShipmentHeader: Record "SSD RGP Shipment Header";
    DimensionValue: Record "Dimension Value";
    Vendor: Record Vendor;
    Customer: Record Customer;
    Employee: Record Employee;
    Item: Record Item;
    GLSetup: Record "General Ledger Setup";
    ShippingAgent: Record "Shipping Agent";
    ShipmentMethod: Record "Shipment Method";
    StartDate: Date;
    EndDate: Date;
    Region: Text[50];
    PartyName: Text[100];
    TransporterName: Text[50];
    ShipmentMethodCode: Code[20];
    Text0001: label 'Please Enter Date Range';
    ShowSalesInvHeaderFalse: Boolean;
    ShowRGPHeaderFalse: Boolean;
    ShowNRGPHeaderFalse: Boolean;
    CompInfo: Record "Company Information";
    RGPShptLine: Record "SSD RGP Shipment Line";
    "Location Filter": Code[250];
    RegionCaptionLbl: label 'Region';
    Invoice_NoCaptionLbl: label 'Invoice No';
    Invoice_DateCaptionLbl: label 'Invoice Date';
    PartyCaptionLbl: label 'Party';
    DescriptionCaptionLbl: label 'Description';
    Item_CodeCaptionLbl: label 'Item Code';
    QuantityCaptionLbl: label 'Quantity';
    AmountCaptionLbl: label 'Amount';
    UOMCaptionLbl: label 'UOM';
    Net_Wt_CaptionLbl: label 'Net Wt.';
    GWT_CaptionLbl: label 'GWT.';
    FreightCaptionLbl: label 'Freight';
    TransporterCaptionLbl: label 'Transporter';
    Sales_Invoice_EntryCaptionLbl: label 'Sales Invoice Entry';
    Shipment_MethodCaptionLbl: label 'Shipment Method';
    TotalCaptionLbl: label 'Total';
    RGP_EntryCaptionLbl: label 'RGP Entry';
    RegionCaption_Control1102152006Lbl: label 'Region';
    Invoice_NoCaption_Control1102152007Lbl: label 'Invoice No';
    Invoice_DateCaption_Control1102152008Lbl: label 'Invoice Date';
    PartyCaption_Control1102152009Lbl: label 'Party';
    Item_CodeCaption_Control1102152010Lbl: label 'Item Code';
    DescriptionCaption_Control1102152011Lbl: label 'Description';
    QuantityCaption_Control1102152012Lbl: label 'Quantity';
    UOMCaption_Control1102152013Lbl: label 'UOM';
    AmountCaption_Control1102152014Lbl: label 'Amount';
    Net_Wt_Caption_Control1102152015Lbl: label 'Net Wt.';
    GWT_Caption_Control1102152016Lbl: label 'GWT.';
    FreightCaption_Control1102152017Lbl: label 'Freight';
    TransporterCaption_Control1102152019Lbl: label 'Transporter';
    Shipment_Method_CodeCaptionLbl: label 'Shipment Method Code';
    TotalCaption_Control1000000115Lbl: label 'Total';
    NRGP_EntryCaptionLbl: label 'NRGP Entry';
    Shipment_Method_CodeCaption_Control1102152024Lbl: label 'Shipment Method Code';
    TransporterCaption_Control1102152025Lbl: label 'Transporter';
    FreightCaption_Control1102152026Lbl: label 'Freight';
    GWT_Caption_Control1102152027Lbl: label 'GWT.';
    Net_Wt_Caption_Control1102152028Lbl: label 'Net Wt.';
    AmountCaption_Control1102152029Lbl: label 'Amount';
    QuantityCaption_Control1102152030Lbl: label 'Quantity';
    UOMCaption_Control1102152031Lbl: label 'UOM';
    DescriptionCaption_Control1102152032Lbl: label 'Description';
    Item_CodeCaption_Control1102152033Lbl: label 'Item Code';
    PartyCaption_Control1102152034Lbl: label 'Party';
    Invoice_DateCaption_Control1102152035Lbl: label 'Invoice Date';
    Invoice_NoCaption_Control1102152036Lbl: label 'Invoice No';
    RegionCaption_Control1102152037Lbl: label 'Region';
    TotalCaption_Control1000000117Lbl: label 'Total';
    V57F4_EntryCaptionLbl: label '57F4 Entry';
    Shipment_Method_CodeCaption_Control1102152050Lbl: label 'Shipment Method Code';
    TransporterCaption_Control1102152051Lbl: label 'Transporter';
    FreightCaption_Control1102152052Lbl: label 'Freight';
    GWT_Caption_Control1102152053Lbl: label 'GWT.';
    Net_Wt_Caption_Control1102152054Lbl: label 'Net Wt.';
    AmountCaption_Control1102152055Lbl: label 'Amount';
    UOMCaption_Control1102152056Lbl: label 'UOM';
    QuantityCaption_Control1102152057Lbl: label 'Quantity';
    DescriptionCaption_Control1102152059Lbl: label 'Description';
    Item_CodeCaption_Control1102152060Lbl: label 'Item Code';
    PartyCaption_Control1102152061Lbl: label 'Party';
    Invoice_DateCaption_Control1102152062Lbl: label 'Invoice Date';
    Invoice_NoCaption_Control1102152063Lbl: label 'Invoice No';
    RegionCaption_Control1102152064Lbl: label 'Region';
    TotalCaption_Control1102152077Lbl: label 'Total';
    procedure InitializeVariable()
    begin
        // Initialize the local variable
        Region:='';
        PartyName:='';
        TransporterName:='';
        ShipmentMethodCode:='';
        ShowSalesInvHeaderFalse:=true;
        ShowRGPHeaderFalse:=true;
        ShowNRGPHeaderFalse:=true;
    end;
}
