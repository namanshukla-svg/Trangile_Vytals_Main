Report 50250 "Sales LR Date & Time"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Sales LR Date & Time.rdl';
    UsageCategory = Administration;
    ApplicationArea = all;

    dataset
    {
        dataitem("Sales Invoice Header"; "Sales Invoice Header")
        {
            DataItemTableView = sorting("No.")order(ascending);
            RequestFilterFields = "Posting Date";

            column(ReportForNavId_1000000000;1000000000)
            {
            }
            column(ActualDeliveryCaptureDate_SalesInvoiceHeader; "Sales Invoice Header"."Actual Delivery Capture Date")
            {
            }
            column(CaptureTime_SalesInvoiceHeader; "Sales Invoice Header"."Capture Time")
            {
            }
            column(LRRRNoCaptureDate_SalesInvoiceHeader; "Sales Invoice Header"."LR/RR No. Capture Date")
            {
            }
            column(LRRRNoCaptureTime_SalesInvoiceHeader; "Sales Invoice Header"."LR/RR No. Capture Time")
            {
            }
            column(SendMailCaptureDate_SalesInvoiceHeader; "Sales Invoice Header"."Send Mail Capture Date")
            {
            }
            column(SendMailCaptureTime_SalesInvoiceHeader; "Sales Invoice Header"."Send Mail Capture Time")
            {
            }
            column(No_SalesInvoiceHeader; "Sales Invoice Header"."No.")
            {
            }
            column(BilltoCustomerNo_SalesInvoiceHeader; "Sales Invoice Header"."Bill-to Customer No.")
            {
            }
            column(BilltoName_SalesInvoiceHeader; "Sales Invoice Header"."Bill-to Name")
            {
            }
            column(BilltoAddress_SalesInvoiceHeader; "Sales Invoice Header"."Bill-to Address")
            {
            }
            column(BilltoCity_SalesInvoiceHeader; "Sales Invoice Header"."Bill-to City")
            {
            }
            column(PostingDate_SalesInvoiceHeader; "Sales Invoice Header"."Posting Date")
            {
            }
            column(LRRRDate_SalesInvoiceHeader; "Sales Invoice Header"."LR/RR Date")
            {
            }
            column(ActualDeliveryDate_SalesInvoiceHeader; "Sales Invoice Header"."Actual Delivery Date")
            {
            }
            column(SalespersonCode_SalesInvoiceHeader; "Sales Invoice Header"."Salesperson Code")
            {
            }
            column(S_Name; SalespersonPurchaser.Name)
            {
            }
            trigger OnAfterGetRecord()
            begin
                if SalespersonPurchaser.Get("Sales Invoice Header"."Salesperson Code")then;
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
    var SalespersonPurchaser: Record "Salesperson/Purchaser";
}
