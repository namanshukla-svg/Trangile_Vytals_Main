PageExtension 50066 "SSD PostedSalesInvoiceLines" extends "Posted Sales Invoice Lines"
{
    layout
    {
        addafter("No.")
        {
            field("HSN/SAC Code"; Rec."HSN/SAC Code")
            {
                ApplicationArea = All;
            }
        }
    }
}
