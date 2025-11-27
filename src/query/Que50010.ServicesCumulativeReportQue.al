query 50010 "Services Cumulative Report Que"
{
    Caption = 'Services Cumulative Report Query';
    QueryType = Normal;

    elements
    {
    dataitem(PurchaseHeader;
    "Purchase Header")
    {
    DataItemTableFilter = "Document Type"=filter('Order'), "SSD Order Type"=filter('Service'|'Fixed Assets');

    column(No;
    "No.")
    {
    }
    column(BuyfromVendorNo;
    "Buy-from Vendor No.")
    {
    }
    column(BuyfromVendorName;
    "Buy-from Vendor Name")
    {
    }
    column(Status;
    Status)
    {
    }
    column(Vendor_Invoice_No_;
    "Vendor Invoice No.")
    {
    }
    dataitem(Purchase_Line;
    "Purchase Line")
    {
    SqlJoinType = InnerJoin;
    DataItemLink = "Document No."=PurchaseHeader."No.";

    column(No_;
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
    column(Quantity;
    Quantity)
    {
    }
    dataitem(Purch__Rcpt__Line;
    "Purch. Rcpt. Line")
    {
    DataItemLink = "Order No."=Purchase_Line."Document No.", "No."=Purchase_Line."No.", "Line No."=Purchase_Line."Line No.";

    column(Document_No_;
    "Document No.")
    {
    }
    column(Quantity_Purch__Rcpt__Line;
    Quantity)
    {
    }
    column(Qty__Rcd__Not_Invoiced;
    "Qty. Rcd. Not Invoiced")
    {
    }
    column(Direct_Unit_Cost;
    "Direct Unit Cost")
    {
    }
    dataitem(Purch__Inv__Header;
    "Purch. Inv. Header")
    {
    DataItemLink = "Order No."=PurchaseHeader."No.";

    column(No_Purch__Inv__Header;
    "No.")
    {
    }
    }
    }
    }
    }
    }
    trigger OnBeforeOpen()
    begin
    end;
}
