query 50007 PoolUpdate3
{
    Caption = 'PoolUpdate3';
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
    DataItemTableFilter = "Document Type"=const("Return Order"), "Document Subtype"=filter(order|" "), Status=filter(Released);

    column(Salesperson_Code;
    "Salesperson Code")
    {
    }
    column(Posting_Date;
    "Posting Date")
    {
    }
    dataitem(Sales_Line;
    "Sales Line")
    {
    DataItemLink = "Document No."=Sales_Header."No.";
    DataItemTableFilter = "Document Type"=const("Return Order"), "Document Subtype"=filter(order|" ");

    column(Quantity;
    Quantity)
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
