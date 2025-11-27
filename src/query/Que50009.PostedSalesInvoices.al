query 50009 "Posted Sales Invoices"
{
    Caption = 'Posted Sales Invoices';
    QueryType = Normal;

    elements
    {
    dataitem(Sales_Invoice_Header;
    "Sales Invoice Header")
    {
    column(No;
    "No.")
    {
    }
    column(BilltoCustomerNo;
    "Bill-to Customer No.")
    {
    }
    column(BilltoName;
    "Bill-to Name")
    {
    }
    column(SalespersonCode;
    "Salesperson Code")
    {
    }
    column(Posting_Date;
    "Posting Date")
    {
    }
    dataitem(Sales_Invoice_Line;
    "Sales Invoice Line")
    {
    DataItemLink = "Document No."=Sales_Invoice_Header."No.";
    DataItemTableFilter = Type=filter(Item);

    column(LineNo;
    "Line No.")
    {
    }
    column(ItemCategoryCode_Sales_Invoice_Line;
    "Item Category Code")
    {
    }
    column(No_Sales_Invoice_Line;
    "No.")
    {
    }
    column(Description_Sales_Invoice_Line;
    Description)
    {
    }
    column(Description2_Sales_Invoice_Line;
    "Description 2")
    {
    }
    column(Quantity_Sales_Invoice_Line;
    Quantity)
    {
    }
    column(UnitPrice_Sales_Invoice_Line;
    "Unit Price")
    {
    }
    dataitem(Item_Category;
    "Item Category")
    {
    DataItemLink = Code=Sales_Invoice_Line."Item Category Code";

    column(Parent_Category;
    "Parent Category")
    {
    }
    dataitem(SalespersonPurchaser;
    "Salesperson/Purchaser")
    {
    DataItemLink = Code=Sales_Invoice_Header."Salesperson Code";

    column(Code_SalespersonPurchaser;
    "Code")
    {
    }
    column(Category_SalespersonPurchaser;
    Category)
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
