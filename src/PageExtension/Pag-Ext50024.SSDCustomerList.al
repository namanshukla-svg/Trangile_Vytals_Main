PageExtension 50024 "SSD Customer List" extends "Customer List"
{
    layout
    {
        modify("Privacy Blocked")
        {
            Visible = false;
        }
        addafter(Name)
        {
            field(Address; Rec.Address)
            {
                ApplicationArea = All;
            }
            field("Address 2"; Rec."Address 2")
            {
                ApplicationArea = All;
            }
            field(City; Rec.City)
            {
                ApplicationArea = All;
            }
            field("State Code"; Rec."State Code")
            {
                ApplicationArea = All;
            }
        }
        addafter(Contact)
        {
            field("Bill-to Customer No."; Rec."Bill-to Customer No.")
            {
                ApplicationArea = All;
            }
        }
        addafter("Gen. Bus. Posting Group")
        {
            field("Shipment Method Code"; Rec."Shipment Method Code")
            {
                ApplicationArea = All;
            }
        }
        addafter("Payment Terms Code")
        {
            field("GST Registration No."; Rec."GST Registration No.")
            {
                ApplicationArea = All;
            }
        }
        addafter("Search Name")
        {
            field("Freight Zone"; Rec."Freight Zone")
            {
                ApplicationArea = All;
            }
        }
        addafter("Credit Limit (LCY)")
        {
            field("E-Mail"; Rec."E-Mail")
            {
                ApplicationArea = All;
            }
        }
        addafter("Base Calendar Code")
        {
            field("P.A.N. No."; Rec."P.A.N. No.")
            {
                ApplicationArea = All;
            }
            field("CRM Temp Id"; Rec."CRM Temp Id")
            {
                ApplicationArea = All;
            }
            field("Shipping Time"; Rec."Shipping Time")
            {
                ApplicationArea = All;
            }
            field("Email for Payment"; Rec."Email for Payment")
            {
                ApplicationArea = All;
            }
            field("DDC as Per Invoice Date"; Rec."DDC as Per Invoice Date")
            {
                ApplicationArea = All;
            }
        }
    }
    trigger OnDeleteRecord(): Boolean var
        UserSetup: Record "User Setup";
    begin
        UserSetup.Get(UserId);
        if not UserSetup."SSD Delete Administrator" then error('You are not authorise to delete this record');
    end;
}
