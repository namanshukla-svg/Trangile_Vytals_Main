query 55012 PoolUpdate2N
{
    Caption = 'PoolUpdate2N';
    QueryType = Normal;

    elements
    {
        dataitem(SalespersonPurchaser; "Salesperson/Purchaser")
        {
            column("Code"; "Code") { }
            column(Sales_Region; "Sales Region") { }

            dataitem(Sales_Header; "Sales Header")
            {
                DataItemLink = "Salesperson Code" = SalespersonPurchaser.Code;
                DataItemTableFilter = "Document Type" = const(Order), "Document Subtype" = filter(order);

                column(Order_Date; "Order Date") { }

                dataitem(Sales_Line; "Sales Line")
                {
                    DataItemLink = "Document No." = Sales_Header."No.";
                    DataItemTableFilter = "Document Type" = const(Order), "Document Subtype" = filter(order);

                    column(Outstanding_Quantity; "Outstanding Quantity") { }
                    column(Unit_Price; "Unit Price") { }

                }
            }
        }
    }
    trigger OnBeforeOpen()
    begin
    end;
}
