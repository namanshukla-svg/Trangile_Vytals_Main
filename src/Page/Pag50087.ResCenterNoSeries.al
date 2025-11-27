Page 50087 "Res. Center No. Series"
{
    Caption = 'Responsibility Center No. Series';
    PageType = List;
    SourceTable = "Responsibility Center";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                field("Code"; Rec.Code)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = All;
                }
                field("Indent No. Series"; Rec."Indent No. Series")
                {
                    ApplicationArea = All;
                }
                field("Indent Template Name"; Rec."Indent Template Name")
                {
                    ApplicationArea = All;
                }
                field("Indent Batch Name"; Rec."Indent Batch Name")
                {
                    ApplicationArea = All;
                }
                field("RGP In Nos"; Rec."RGP In Nos")
                {
                    ApplicationArea = All;
                }
                field("RGP Out Nos"; Rec."RGP Out Nos")
                {
                    ApplicationArea = All;
                }
                field("Posted RGP IN Shipment Nos"; Rec."Posted RGP IN Shipment Nos")
                {
                    ApplicationArea = All;
                }
                field("Posted RGP IN Receipt Nos"; Rec."Posted RGP IN Receipt Nos")
                {
                    ApplicationArea = All;
                }
                field("NRGP In Nos"; Rec."NRGP In Nos")
                {
                    ApplicationArea = All;
                }
                field("NRGP Out Nos"; Rec."NRGP Out Nos")
                {
                    ApplicationArea = All;
                }
                field("Gate In Nos"; Rec."Gate In Nos")
                {
                    ApplicationArea = All;
                }
                field("Gate Out Nos"; Rec."Gate Out Nos")
                {
                    ApplicationArea = All;
                }
                field("Sales Enquiry Nos."; Rec."Sales Enquiry Nos.")
                {
                    ApplicationArea = All;
                }
                field("Sales Quote Nos."; Rec."Sales Quote Nos.")
                {
                    ApplicationArea = All;
                }
                field("Sales Blanket Order Nos."; Rec."Sales Blanket Order Nos.")
                {
                    ApplicationArea = All;
                }
                field("Sales Order Nos."; Rec."Sales Order Nos.")
                {
                    ApplicationArea = All;
                }
                field("Sales Invoice Nos."; Rec."Sales Invoice Nos.")
                {
                    ApplicationArea = All;
                }
                field("Sales Credit Memo Nos."; Rec."Sales Credit Memo Nos.")
                {
                    ApplicationArea = All;
                }
                field("Sales Return Order Nos."; Rec."Sales Return Order Nos.")
                {
                    ApplicationArea = All;
                }
                field("Posted Shipment Nos."; Rec."Posted Shipment Nos.")
                {
                    ApplicationArea = All;
                }
                field("Posted SalesInvoice Nos."; Rec."Posted SalesInvoice Nos.")
                {
                    ApplicationArea = All;
                }
                field("Posted SalesCredit Memo Nos."; Rec."Posted SalesCredit Memo Nos.")
                {
                    ApplicationArea = All;
                }
                field("Posted Return Receipt Nos."; Rec."Posted Return Receipt Nos.")
                {
                    ApplicationArea = All;
                }
                field("Purchase Order Document No."; Rec."Purchase Order Document No.")
                {
                    ApplicationArea = All;
                }
                field("Purch. Enquiry Nos."; Rec."Purch. Enquiry Nos.")
                {
                    ApplicationArea = All;
                }
                field("Purchase Quote Nos."; Rec."Purchase Quote Nos.")
                {
                    ApplicationArea = All;
                }
                field("Purchase Blanket Order Nos."; Rec."Purchase Blanket Order Nos.")
                {
                    ApplicationArea = All;
                }
                field("Purchase Order Nos."; Rec."Purchase Order Nos.")
                {
                    ApplicationArea = All;
                }
                field("Subcontracting Order No."; Rec."Subcontracting Order No.")
                {
                    ApplicationArea = All;
                }
                field("Delivery Challan No."; Rec."Delivery Challan No.")
                {
                    ApplicationArea = All;
                }
                field("Purchase Invoice Nos."; Rec."Purchase Invoice Nos.")
                {
                    ApplicationArea = All;
                }
                field("Purchase Credit Memo Nos."; Rec."Purchase Credit Memo Nos.")
                {
                    ApplicationArea = All;
                }
                field("Purchase Return Order Nos."; Rec."Purchase Return Order Nos.")
                {
                    ApplicationArea = All;
                }
                field("Posted Receipt Nos."; Rec."Posted Receipt Nos.")
                {
                    ApplicationArea = All;
                }
                field("Posted PurchInvoice Nos."; Rec."Posted PurchInvoice Nos.")
                {
                    ApplicationArea = All;
                }
                field("Posted PurchCredit Memo Nos."; Rec."Posted PurchCredit Memo Nos.")
                {
                    ApplicationArea = All;
                }
                field("Posted Return Shpt. Nos."; Rec."Posted Return Shpt. Nos.")
                {
                    ApplicationArea = All;
                }
                field("Posted SubCon. Comp. Recpt. No"; Rec."Posted SubCon. Comp. Recpt. No")
                {
                    ApplicationArea = All;
                }
                field("Simulated Order Nos."; Rec."Simulated Order Nos.")
                {
                    ApplicationArea = All;
                }
                field("Planned Order Nos."; Rec."Planned Order Nos.")
                {
                    ApplicationArea = All;
                }
                field("Firm Planned Order Nos."; Rec."Firm Planned Order Nos.")
                {
                    ApplicationArea = All;
                }
                field("Released Order Nos."; Rec."Released Order Nos.")
                {
                    ApplicationArea = All;
                }
                field("Posted Delivery Challan No."; Rec."Posted Delivery Challan No.")
                {
                    ApplicationArea = All;
                }
                field("Production BOM Nos."; Rec."Production BOM Nos.")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
    actions
    {
        area(navigation)
        {
            group("&Resp. Ctr.")
            {
                Caption = '&Resp. Ctr.';

                action(Card)
                {
                    ApplicationArea = All;
                    Caption = 'Card';
                    Image = EditLines;
                    RunObject = Page "Responsibility Center Card";
                    RunPageLink = Code=field(Code);
                    ShortCutKey = 'Shift+F7';
                }
                group(Dimensions)
                {
                    Caption = 'Dimensions';

                    action("Dimensions-Single")
                    {
                        ApplicationArea = All;
                        Caption = 'Dimensions-Single';
                        RunObject = Page "Default Dimensions";
                        RunPageLink = "Table ID"=const(5714), "No."=field(Code);
                        ShortCutKey = 'Shift+Ctrl+D';
                    }
                }
            }
        }
    }
}
