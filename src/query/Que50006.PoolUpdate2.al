query 50006 PoolUpdate2
{
    Caption = 'PoolUpdate2';
    QueryType = Normal;

    elements
    {
    dataitem(SalespersonPurchaser;
    "Salesperson/Purchaser")
    {
    column("Code";
    "Code")
    {
    }
    column(Category;
    Category)
    {
    }
    dataitem(Sales_Header;
    "Sales Header")
    {
    DataItemLink = "Salesperson Code"=SalespersonPurchaser.Code;
    DataItemTableFilter = "Document Type"=const(Order), "Document Subtype"=filter(order);

    column(Order_Date;
    "Order Date")
    {
    }
    dataitem(Sales_Line;
    "Sales Line")
    {
    DataItemLink = "Document No."=Sales_Header."No.";
    DataItemTableFilter = "Document Type"=const(Order), "Document Subtype"=filter(order);

    column(Outstanding_Quantity;
    "Outstanding Quantity")
    {
    }
    column(Unit_Price;
    "Unit Price")
    {
    }
    }
    }
    }
    }
    trigger OnBeforeOpen()
    begin
    end;
}
