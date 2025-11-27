PageExtension 50023 "SSD Customer Ledger Entries" extends "Customer Ledger Entries"
{
    layout
    {
        addafter(Amount)
        {
            field("Invoice Basic Amount"; Rec."Invoice Basic Amount")
            {
                ApplicationArea = All;
            }
        }
        addafter("Remaining Amt. (LCY)")
        {
            field(Remarks; Rec.Remarks)
            {
                ApplicationArea = All;
            }
            field("Check For Email"; Rec."Check For Email")
            {
                ApplicationArea = All;
            }
        }
        addafter("Payment Method Code")
        {
            field("Actual Delivery Date"; SalesInvoiceHeader."Actual Delivery Date")
            {
                ApplicationArea = All;
                Editable = false;
            }
            field("Expected Delivery Date"; SalesInvoiceHeader."Expected Delivery Date")
            {
                ApplicationArea = All;
                Editable = false;
            }
        }
    }
    var NavigateVisible: Boolean;
    SalesInvoiceHeader: Record "Sales Invoice Header";
    trigger OnAfterGetRecord()
    begin
        CLEAR(SalesInvoiceHeader);
        SalesInvoiceHeader.RESET;
        SalesInvoiceHeader.SETRANGE("No.", Rec."Document No.");
        IF SalesInvoiceHeader.FINDFIRST THEN;
    end;
}
