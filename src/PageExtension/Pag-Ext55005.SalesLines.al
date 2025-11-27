pageextension 55005 SalesLines extends "Sales Lines"
{
    layout
    {
        // Add changes to page layout here
        addafter("Outstanding Quantity")
        {
            field("Unit Price"; Rec."Unit Price")
            {
                ApplicationArea = all;
            }
            field("SalesPerson Code"; Rec."SalesPerson Code")
            {
                ApplicationArea = all;
            }
            field("Order Date"; Rec."Order Date")
            {
                ApplicationArea = all;
            }
        }
    }

    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;
}