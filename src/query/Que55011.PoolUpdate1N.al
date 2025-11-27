query 55011 PoolUpdate1N
{
    Caption = 'PoolUpdate1N';
    QueryType = Normal;

    elements
    {
        dataitem(SalespersonPurchaser; "Salesperson/Purchaser")
        {
            column("Code"; "Code") { }
            column(Sales_Region; "Sales Region") { }

            dataitem(Sales_Invoice_Header; "Sales Invoice Header")
            {
                DataItemLink = "Salesperson Code" = SalespersonPurchaser.Code;

                column(Posting_Date; "Posting Date") { }
                column(Amount; Amount)
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
