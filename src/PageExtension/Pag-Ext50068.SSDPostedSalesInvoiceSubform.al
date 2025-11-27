PageExtension 50068 "SSD PostedSalesInvoiceSubform" extends "Posted Sales Invoice Subform"
{
    layout
    {
        addafter("IC Partner Code")
        {
            field("Planned Delivery DT"; Rec."Planned Delivery DT")
            {
                ApplicationArea = All;
            }
            field("Shipment Date"; Rec."Shipment Date")
            {
                ApplicationArea = All;
            }
        }
        addafter("Net Weight")
        {
            field("Actual Wt"; Rec."Actual Wt")
            {
                ApplicationArea = All;
            }
            field("Gross Wt"; Rec."Gross Wt")
            {
                ApplicationArea = All;
            }
        }
        addafter("Shortcut Dimension 1 Code")
        {
            field("GST Place of Supply"; Rec."GST Place of Supply")
            {
                ApplicationArea = All;
            }
        }
        modify("Description 2")
        {
            Visible = false;
        }
    }
}
