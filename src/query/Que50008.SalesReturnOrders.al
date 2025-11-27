query 50008 "Sales Return Orders"
{
    Caption = 'Sales Return Orders';
    QueryType = Normal;

    elements
    {
    dataitem(Sales_Header;
    "Sales Header")
    {
    DataItemTableFilter = "Document Type"=const("Return Order"), "Document Subtype"=filter(order|" "), Status=filter(Released);

    column(Posting_Date;
    "Posting Date")
    {
    }
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
    column(Salesperson_Code;
    "Salesperson Code")
    {
    }
    column(External_Document_No_;
    "External Document No.")
    {
    }
    column(External_Doc__Date;
    "External Doc. Date")
    {
    }
    dataitem(Sales_Line;
    "Sales Line")
    {
    DataItemLink = "Document No."=Sales_Header."No.";
    DataItemTableFilter = "Document Type"=const("Return Order"), "Document Subtype"=filter(order|" "), Type=filter(Item);

    column(ItemCategoryCode;
    "Item Category Code")
    {
    }
    column(No_Sales_Line;
    "No.")
    {
    }
    column(LineNo;
    "Line No.")
    {
    }
    column(Description_Sales_Line;
    Description)
    {
    }
    column(Description2_Sales_Line;
    "Description 2")
    {
    }
    column(Quantity_Sales_Line;
    Quantity)
    {
    }
    column(Unit_Price;
    "Unit Price")
    {
    }
    dataitem(Item_Category;
    "Item Category")
    {
    DataItemLink = Code=Sales_Line."Item Category Code";

    column(Parent_Category;
    "Parent Category")
    {
    }
    dataitem(SalespersonPurchaser;
    "Salesperson/Purchaser")
    {
    DataItemLink = Code=Sales_Header."Salesperson Code";

    column("Code";
    "Code")
    {
    }
    column(Category;
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
