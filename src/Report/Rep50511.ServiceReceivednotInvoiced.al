report 50511 "Service Received not Invoiced"
{
    ApplicationArea = All;
    Caption = 'Service Received But not Invoiced';
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/ServiceReceivedButnotInvoiced.rdl';

    dataset
    {
        dataitem(Integer; Integer)
        {
            column(ServiceReceivednotInvoicedQuery_No_; ServiceReceivednotInvoicedQuery.No_)
            {
            }
            column(ServiceReceivednotInvoicedQuery_Posting_Date; Format(ServiceReceivednotInvoicedQuery.Posting_Date))
            {
            }
            column(ServiceReceivednotInvoicedQuery_Quantity; ServiceReceivednotInvoicedQuery.Quantity)
            {
            }
            column(ServiceReceivednotInvoicedQuery_Qty__Rcd__Not_Invoiced; ServiceReceivednotInvoicedQuery.Qty__Rcd__Not_Invoiced)
            {
            }
            column(ServiceReceivednotInvoicedQuery_AmountofQtyrecd; ServiceReceivednotInvoicedQuery.Quantity * ServiceReceivednotInvoicedQuery.Direct_Unit_Cost)
            {
            }
            column(ServiceReceivednotInvoicedQuery_Location_Code; ServiceReceivednotInvoicedQuery.Location_Code)
            {
            }
            column(ServiceReceivednotInvoicedQuery_Order_No_; ServiceReceivednotInvoicedQuery.Order_No_)
            {
            }
            column(ServiceReceivednotInvoicedQuery_Vendor_Invoice_No_; ServiceReceivednotInvoicedQuery.Vendor_Invoice_No_)
            {
            }
            column(ServiceReceivednotInvoicedQuery_Buy_from_Vendor_No_; ServiceReceivednotInvoicedQuery.Buy_from_Vendor_No_)
            {
            }
            column(ServiceReceivednotInvoicedQuery_Buy_from_Vendor_Name; ServiceReceivednotInvoicedQuery.Buy_from_Vendor_Name)
            {
            }
            column(ServiceReceivednotInvoicedQuery_Type; ServiceReceivednotInvoicedQuery.Type)
            {
            }
            column(ServiceReceivednotInvoicedQuery_No; ServiceReceivednotInvoicedQuery.No)
            {
            }
            column(ServiceReceivednotInvoicedQuery_Description; ServiceReceivednotInvoicedQuery.Description)
            {
            }
            column(ServiceReceivednotInvoicedQuery_Description_2; ServiceReceivednotInvoicedQuery.Description_2)
            {
            }
            trigger OnPreDataItem()
            begin
                Clear(ServiceReceivednotInvoicedQuery);
                IF Location_Code <> '' then ServiceReceivednotInvoicedQuery.SetFilter(ServiceReceivednotInvoicedQuery.Location_Code, Location_Code);
                IF(EndDate <> 0D)then ServiceReceivednotInvoicedQuery.SetRange(ServiceReceivednotInvoicedQuery.Posting_Date, StartDate, EndDate);
                IF Buy_from_Vendor_No_ <> '' then ServiceReceivednotInvoicedQuery.SetFilter(ServiceReceivednotInvoicedQuery.Buy_from_Vendor_No_, Buy_from_Vendor_No_);
                ServiceReceivednotInvoicedQuery.Open();
            end;
            trigger OnAfterGetRecord()
            begin
                if not ServiceReceivednotInvoicedQuery.Read()then CurrReport.Break();
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
                    field(StartDate; StartDate)
                    {
                        ApplicationArea = all;
                        Caption = 'StartDate';
                    }
                    field(EndDate; EndDate)
                    {
                        ApplicationArea = all;
                        Caption = 'EndDate';
                    }
                    field(Buy_from_Vendor_No_; Buy_from_Vendor_No_)
                    {
                        ApplicationArea = all;
                        Caption = 'Vendor No.';
                        TableRelation = Vendor."No.";
                    }
                    field(Location_Code; Location_Code)
                    {
                        ApplicationArea = all;
                        Caption = 'Location Code';
                        TableRelation = Location.Code;
                    }
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
    trigger OnPreReport()
    BEGIN
    END;
    var ServiceReceivednotInvoicedQuery: Query "Service Received not Invoiced";
    Posting_Date: Date;
    Buy_from_Vendor_No_: Code[20];
    Location_Code: Code[10];
    StartDate: Date;
    EndDate: Date;
}
