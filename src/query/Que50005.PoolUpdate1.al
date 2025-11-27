query 50005 PoolUpdate1
{
    Caption = 'PoolUpdate1';
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
    dataitem(Sales_Invoice_Header;
    "Sales Invoice Header")
    {
    DataItemLink = "Salesperson Code"=SalespersonPurchaser.Code;

    column(Posting_Date;
    "Posting Date")
    {
    }
    column(Amount;
    Amount)
    {
    Method = Sum;
    }
    }
    }
    }
    trigger OnBeforeOpen()
    begin
    end;
}
