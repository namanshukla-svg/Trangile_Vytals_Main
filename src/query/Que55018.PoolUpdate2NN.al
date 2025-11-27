query 55018 PoolUpdate2NN
{
    Caption = 'PoolUpdate2NN';
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
                DataItemTableFilter = "Document Type" = const(Order), "Document Subtype" = filter(order),
                 "Sell-to Customer No." = filter('<>C0137');

                column(Order_Date; "Order Date") { }

                dataitem(Sales_Line; "Sales Line")
                {
                    DataItemLink = "Document No." = Sales_Header."No.";
                    DataItemTableFilter = "Document Type" = const(Order), "Document Subtype" = filter(order),
                      "Outstanding Quantity" = filter('>0'),
                        "Short Close Qty." = filter('=0');

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