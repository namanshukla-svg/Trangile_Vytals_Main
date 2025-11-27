Report 50152 "Dispatch Details"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Dispatch Details.rdl';
    UsageCategory = ReportsandAnalysis;
    ApplicationArea = all;

    dataset
    {
        dataitem("Sales Invoice Header"; "Sales Invoice Header")
        {
            RequestFilterFields = "LR/RR No.";

            column(ReportForNavId_1000000000;1000000000)
            {
            }
            column(CompInfo_Picture; CompInfo.Picture)
            {
            }
            column(CompInfo_NewLogo1; CompInfo."New Logo1")
            {
            }
            column(LRFilter; LRFilter)
            {
            }
            column(SIH_No; "Sales Invoice Header"."No.")
            {
            IncludeCaption = true;
            }
            column(InvNoStr; InvNoStr)
            {
            }
            column(SIH_PostingDate; "Sales Invoice Header"."Posting Date")
            {
            IncludeCaption = true;
            }
            column(SIH_AmtToCustomer; "Sales Invoice Header"."Amount") //SSD Amount to customer changed to Amount 
            {
            IncludeCaption = true;
            }
            column(SIH_ExtDocNo; "Sales Invoice Header"."External Document No.")
            {
            IncludeCaption = true;
            }
            column(SIH_OrderSCDNo; "Sales Invoice Header"."Order/Scd. No.")
            {
            IncludeCaption = true;
            }
            column(SIH_SellToCustNo; "Sales Invoice Header"."Sell-to Customer No.")
            {
            IncludeCaption = true;
            }
            column(SIH_SellToCustName; "Sales Invoice Header"."Sell-to Customer Name")
            {
            }
            column(SIH_BillToCustNo; "Sales Invoice Header"."Bill-to Customer No.")
            {
            IncludeCaption = true;
            }
            column(SIH_BillToCustName; "Sales Invoice Header"."Bill-to Name")
            {
            }
            column(SIH_SalesPersonCode; "Sales Invoice Header"."Salesperson Code")
            {
            IncludeCaption = true;
            }
            column(SPName; SPName)
            {
            }
            column(SPPhNo; SPPhNo)
            {
            }
            column(SPEmail; SPEmail)
            {
            }
            column(CustAss_AcNo; CustAss_AcNo)
            {
            }
            column(i; i)
            {
            }
            column(SIH_ShippingAgentCode; "Sales Invoice Header"."Shipping Agent Code")
            {
            }
            column(SIH_AmmendedShippingAgentCode; "Sales Invoice Header"."Actual Shipping Agent code")
            {
            }
            column(SIH_TransportMethod; "Sales Invoice Header"."Transport Method")
            {
            }
            column(SIH_ShippingMethodCode; "Sales Invoice Header"."Shipment Method Code")
            {
            }
            column(SIH_LRNo; "Sales Invoice Header"."LR/RR No.")
            {
            }
            column(SIH_ExpectedDeliveryDate; "Sales Invoice Header"."Expected Delivery Date")
            {
            }
            column(SIH_CustRoadPermitNo; "Sales Invoice Header"."Customer Road Permit No.")
            {
            }
            column(TrackingSite; TrackingSite)
            {
            }
            column(Cont3Name; Cont3Name)
            {
            }
            column(Cont3Mobile; Cont3Mobile)
            {
            }
            column(Cont3Email; Cont3Email)
            {
            }
            dataitem("Sales Invoice Line"; "Sales Invoice Line")
            {
                DataItemLink = "Document No."=field("No.");
                DataItemTableView = sorting("Document No.", "Line No.")order(ascending)where(Type=const(Item));

                column(ReportForNavId_1000000057;1000000057)
                {
                }
                column(SIL_Desc; "Sales Invoice Line".Description)
                {
                }
                column(SIL_Desc2; "Sales Invoice Line"."Description 2")
                {
                }
                column(SIL_Qty; "Sales Invoice Line".Quantity)
                {
                }
                column(SIL_UOM; "Sales Invoice Line"."Unit of Measure Code")
                {
                }
                column(SIL_CrossRefNo; "Sales Invoice Line"."Item Reference No.")
                {
                }
                column(SL_OutstandingQty; SalesLine."Outstanding Quantity")
                {
                }
                column(SL_ShortCloseQty; SalesLine."Short Close Qty.")
                {
                }
                trigger OnAfterGetRecord()
                begin
                    if SalesLine.Get(SalesLine."document type"::Order, "Sales Invoice Line"."Order No.", "Sales Invoice Line"."Order Line No.")then;
                end;
            }
            dataitem("Actual Transporter ContDetail"; "SSD Actual Tpt Cont Detail")
            {
                DataItemLink = "Shipping Agent Code"=field("Shipping Agent Code");

                column(ReportForNavId_1000000063;1000000063)
                {
                }
                column(ATCD_ShipppingAgentCode; "Actual Transporter ContDetail"."Shipping Agent Code")
                {
                }
                column(ATCD_Contact1_Name; Cont1Name)
                {
                }
                column(ATCD_Contact1_Mob; Cont1Mobile)
                {
                }
                column(ATCD_Contact1_Email; Cont1Email)
                {
                }
                column(ATCD_Contact2_Name; Cont2Name)
                {
                }
                column(ATCD_Contact2_Mob; Cont2Mobile)
                {
                }
                column(ATCD_Contact2_Email; Cont2Email)
                {
                }
                trigger OnPreDataItem()
                begin
                    if Customer1.Get("Sales Invoice Header"."Sell-to Customer No.")then;
                    "Actual Transporter ContDetail".Reset;
                    "Actual Transporter ContDetail".SetRange("Shipping Agent Code", Customer1."Shipping Agent Code");
                    "Actual Transporter ContDetail".SetRange("Post Code", Customer1."Post Code");
                    if "Actual Transporter ContDetail".FindFirst then Cont1Email:="Actual Transporter ContDetail"."Contact1 Email";
                    Cont1Mobile:="Actual Transporter ContDetail"."Contact1 Mob";
                    Cont1Name:="Actual Transporter ContDetail"."Contact1 Name";
                    Cont2Email:="Actual Transporter ContDetail"."Contact2 Email";
                    Cont2Mobile:="Actual Transporter ContDetail"."Contact2 Mob";
                    Cont2Name:="Actual Transporter ContDetail"."Contact2 Name";
                //"Actual Transporter ContDetail".SETRANGE("Shipping Agent Code","Sales Invoice Header".State);
                end;
            }
            trigger OnAfterGetRecord()
            begin
                i+=1;
                Cont3Name:='';
                Cont3Mobile:='';
                Cont3Email:='';
                InvNoStr:=CopyStr("No.", StrLen("No.") - 4, 5);
                if ShippingAgent.Get("Sales Invoice Header"."Shipping Agent Code")then begin
                    TrackingSite:=ShippingAgent."Internet Address";
                    Cont3Name:=ShippingAgent."Contact3 Name";
                    Cont3Mobile:=ShippingAgent."Contact3 Mobile";
                    Cont3Email:=ShippingAgent."Contact3 Email";
                end;
                if Saleserson.Get("Salesperson Code")then begin
                    SPName:=Saleserson.Name;
                    SPPhNo:=Saleserson."Phone No.";
                    SPEmail:=Saleserson."E-Mail";
                end;
                if Cust.Get("Sales Invoice Header"."Sell-to Customer No.")then CustAss_AcNo:=Cust."Our Account No.";
            end;
            trigger OnPreDataItem()
            begin
                i:=0;
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
    DispatchDetailsCap='Dispatch Details #';
    LRNo='<LR No. _______________________________________>';
    DearCap='Dear Sir or Madam,';
    PleaseCap='Please find below the dispatch details and related COAs attached for your kind reference:';
    ZDSalesInvNo='ZD Sales Invoice No.';
    InvoiceDateCap='Invoice Date';
    InvoiceAmtCap='Invoice Amount';
    CustomerPONoCap='Customer PO No.';
    ZDSalesOrderNoCap='ZD Sales Order No.';
    ConsignerWithCap='Consigner with Vendor Code';
    SellToCustomerCodeNameCap='Sell to Customer Code & Name';
    BillToCustNameCap='Bill To Customer Name';
    ZDSalesPersonContactNoCap='ZD Sales Person & contact No.';
    SrNoCap='Sr. No.';
    DescOfGoodsCap='Description of Goods';
    CustItemCodeCap='Customer Item Code';
    QtyDispatchedCap='Qty. Dispatched';
    ShortClosedQtyCap='Short Closed Qty.';
    OutstandingQtyCap='Outstanding Qty.';
    INVOICENOCap='INVOICE NO.';
    ActualTransporterName='(Actual) Transporter Name';
    TrnsptMode='Transport Method';
    ShipmentMethodCodeCap='Shipment Method Code';
    LRRRNoCap='LR_RR No.';
    ExpDeliDateCap='Expected Delivery Date';
    TrackingSiteCap='Tracking Site';
    CustomerRoadPermitNoCap='Customer Road Permit No.';
    ActualTransprtrCap='(Actual) Transporter Contact Details';
    ContDetAtDelGodCap='Contact details at Delivery Godown';
    ManagerContAtDelivPointCap='Manager Contact at Delivery Point';
    ContDetAtBookGodCap='Contact details at Booking Godown';
    NameCap='Name:';
    MobileCap='Mobile:';
    EmailCap='Email';
    SincerelyCap='Sincerely,';
    ZavCareTeamCap='Zavenir Daubert Customer Care Team';
    ThisIsAutomatedCap='This is an automated email. Replies to this message are not monitored or answered. To contact us, please visit www.zavenir.com  or call us at +91 124 4981000';
    ZavCompNameCap='Zavenir Daubert India Private Limited';
    ZavAddressCap='Regus Rectangle, Level 4,Rectangle 1,D-4, Saket District Centre, New Delhi';
    WebsiteCap='www.zavenir.com';
    }
    trigger OnPreReport()
    begin
        CompInfo.Get;
        CompInfo.CalcFields(Picture, CompInfo."New Logo1");
        LRFilter:="Sales Invoice Header".GetFilter("Sales Invoice Header"."LR/RR No.");
    end;
    var Saleserson: Record "Salesperson/Purchaser";
    SPName: Text;
    SPPhNo: Code[20];
    SPEmail: Text;
    DispatchDetailsCap: label 'Dispatch Details #';
    LRNo: label '<LR No. _______________________________________>';
    DearCap: label 'Dear Sir or Madam,';
    PleaseCap: label 'Please find below the dispatch details and related COAs attached for your kind reference:';
    ConsignerWithCap: label 'Consigner with Vendor Code';
    SellToCustomerCodeNameCap: label 'Sell to Customer Code & Name';
    BillToCustNameCap: label 'Bill To Customer Name';
    ZDSalesPersonContactNoCap: label 'ZD Sales Person & contact No.';
    SrNoCap: label 'Sr. No.';
    DescOfGoodsCap: label 'Description of Goods';
    CustItemCodeCap: label 'Customer Item Code';
    QtyDispatchedCap: label 'Qty. Dispatched';
    ShortClosedQtyCap: label 'Short Closed Qty.';
    OutstandingQtyCap: label 'Outstanding Qty.';
    INVOICENOCap: label 'INVOICE NO.';
    "(Actual)TransporterName": label '(Actual) Transporter Name';
    TrnsptMode: label 'Transport Method';
    ShipmentMethodCodeCap: label 'Shipment Method Code';
    LRRRNoCap: label 'LR_RR No.';
    ExpDeliDateCap: label 'Expected Delivery Date';
    TrackingSiteCap: label 'Tracking Site';
    "(Actual)TransprtrCap": label '(Actual) Transporter Contact Details';
    ContDetAtDelGodCap: label 'Contact details at Delivery Godown';
    ManagerContAtDelivPointCap: label 'Manager Contact at Delivery Point';
    ContDetAtBookGodCap: label 'Contact details at Booking Godown';
    NameCap: label 'Name:';
    MobileCap: label 'Mobile:';
    EmailCap: label 'Email';
    SincerelyCap: label 'Sincerely,';
    ZavCareTeamCap: label 'Zavenir Daubert Customer Care Team';
    ThisIsAutomatedCap: label 'This is an automated email. Replies to this message are not monitored or answered. To contact us, please visit  or call us at +91 124 4981000';
    ZavCompNameCap: label 'Zavenir Daubert India Private Limited';
    ZavAddressCap: label 'Regus Rectangle, Level 4,Rectangle 1,D-4, Saket District Centre, New Delhi';
    WebsiteCap: label 'www.zavenir.com';
    i: Integer;
    CompInfo: Record "Company Information";
    Cust: Record Customer;
    CustAss_AcNo: Code[20];
    ShippingAgent: Record "Shipping Agent";
    TrackingSite: Text;
    InvNoStr: Text;
    LRFilter: Text;
    Cont3Name: Text[50];
    Cont3Mobile: Code[30];
    Cont3Email: Text[40];
    SalesLine: Record "Sales Line";
    Customer1: Record Customer;
    Cont2Name: Text[50];
    Cont2Mobile: Code[30];
    Cont2Email: Text[40];
    Cont1Name: Text[50];
    Cont1Mobile: Code[30];
    Cont1Email: Text[40];
}
