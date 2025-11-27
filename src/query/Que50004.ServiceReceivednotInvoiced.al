query 50004 "Service Received not Invoiced"
{
    Caption = 'Service Received not Invoiced';
    QueryType = Normal;

    elements
    {
    dataitem(PurchRcptHeader;
    "Purch. Rcpt. Header")
    {
    DataItemTableFilter = "SSD Order Type"=filter('Service'|'Fixed Assets');

    column(No_;
    "No.")
    {
    }
    column(Posting_Date;
    "Posting Date")
    {
    }
    column(Location_Code;
    "Location Code")
    {
    }
    column(Order_No_;
    "Order No.")
    {
    }
    column(Vendor_Invoice_No_;
    "Vendor Shipment No.")
    {
    }
    column(Buy_from_Vendor_No_;
    "Buy-from Vendor No.")
    {
    }
    column(Buy_from_Vendor_Name;
    "Buy-from Vendor Name")
    {
    }
    dataitem(Purch__Rcpt__Line;
    "Purch. Rcpt. Line")
    {
    SqlJoinType = InnerJoin;
    DataItemLink = "Document No."=PurchRcptHeader."No.";

    column(Type;
    Type)
    {
    }
    column(No;
    "No.")
    {
    }
    column(Description;
    Description)
    {
    }
    column(Description_2;
    "Description 2")
    {
    }
    column(Qty__Rcd__Not_Invoiced;
    "Qty. Rcd. Not Invoiced")
    {
    }
    column(Quantity;
    Quantity)
    {
    }
    column(Direct_Unit_Cost;
    "Direct Unit Cost")
    {
    }
    }
    }
    }
    trigger OnBeforeOpen()
    begin
    end;
}
