report 50512 "Services Cumulative Report"
{
    ApplicationArea = All;
    Caption = 'Services Cumulative Report';
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/ServicesCumulativeReport.rdl';

    dataset
    {
        dataitem(Integer; "Integer")
        {
            column(ServicesCumulativeReportQuery_No_; ServicesCumulativeReportQuery.No)
            {
            }
            column(ServicesCumulativeReportQuery_Buy_from_Vendor_No_; ServicesCumulativeReportQuery.BuyfromVendorNo)
            {
            }
            column(ServicesCumulativeReportQuery_Buy_from_Vendor_Name; ServicesCumulativeReportQuery.BuyfromVendorName)
            {
            }
            column(ServicesCumulativeReportQuery_No; ServicesCumulativeReportQuery.No_)
            {
            }
            column(ServicesCumulativeReportQuery_Description; ServicesCumulativeReportQuery.Description)
            {
            }
            column(ServicesCumulativeReportQuery_Description_2; ServicesCumulativeReportQuery.Description_2)
            {
            }
            column(ServicesCumulativeReportQuery_Quantity; ServicesCumulativeReportQuery.Quantity)
            {
            }
            column(ServicesCumulativeReportQuery_Status; ServicesCumulativeReportQuery.Status)
            {
            }
            column(ServicesCumulativeReportQuery_No_Purch__Rcpt__Header; ServicesCumulativeReportQuery.Document_No_)
            {
            }
            column(ServicesCumulativeReportQuery_Quantity_Purch__Rcpt__Line; ServicesCumulativeReportQuery.Quantity_Purch__Rcpt__Line)
            {
            }
            column(ServicesCumulativeReportQuery_Qty__Rcd__Not_Invoiced; ServicesCumulativeReportQuery.Qty__Rcd__Not_Invoiced)
            {
            }
            column(ServicesCumulativeReportQuery_Quantity_PINumber; ServicesCumulativeReportQuery.No_Purch__Inv__Header)
            {
            }
            column(ServicesCumulativeReportQuery_AmountofQtyrecd; ServicesCumulativeReportQuery.Quantity_Purch__Rcpt__Line * ServicesCumulativeReportQuery.Direct_Unit_Cost)
            {
            }
            column(ServicesCumulativeReportQuery_Vendor_Invoice_No_; ServicesCumulativeReportQuery.Vendor_Invoice_No_)
            {
            }
            trigger OnPreDataItem()
            begin
                ServicesCumulativeReportQuery.Open();
            end;
            trigger OnAfterGetRecord()
            begin
                if not ServicesCumulativeReportQuery.Read()then CurrReport.Break();
            end;
        }
    }
    requestpage
    {
        layout
        {
            area(content)
            {
                group(GroupName)
                {
                }
            }
        }
        actions
        {
            area(processing)
            {
            }
        }
    }
    var ServicesCumulativeReportQuery: Query "Services Cumulative Report Que";
    PurchRcptHeader: Record "Purch. Rcpt. Header";
    PurchRcptLine: Record "Purch. Rcpt. Line";
}
