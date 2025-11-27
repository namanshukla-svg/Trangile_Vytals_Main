Page 50094 "Responsibility NoSeries Card"
{
    // ALLE 2.17....Added a new Field 'Maximum Cash Receipt Limit'
    // ALLE 2.18....Added a new Field 'Maximum Cash Payment Limit'
    // ALLE 3.11.....Lead Time Despatch Setup Check
    // ALLE 2.21....Invoice Type Customisation
    // ALLE 3.14....ARE1
    // ALLE 3.15....ARE3
    // ALLE 3.16....ARE3
    // MSI.RC.....Responsibility Center
    ApplicationArea = All;
    DeleteAllowed = false;
    PageType = Card;
    SourceTable = "Responsibility Center";
    UsageCategory = Tasks;

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';

                field("Code"; Rec.Code)
                {
                    ApplicationArea = All;
                    Caption = 'Resp.Center  Code';
                    Editable = false;
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = All;
                    Caption = 'Resp. Center Name';
                    Editable = false;
                }
                field(Address; Rec.Address)
                {
                    ApplicationArea = All;
                    Editable = true;
                }
                field("Address 2"; Rec."Address 2")
                {
                    ApplicationArea = All;
                    Editable = true;
                }
                field(City; Rec.City)
                {
                    ApplicationArea = All;
                    Editable = true;
                }
                field("Post Code"; Rec."Post Code")
                {
                    ApplicationArea = All;
                }
                field("Country/Region Code"; Rec."Country/Region Code")
                {
                    ApplicationArea = All;
                }
                field(State; Rec.State)
                {
                    ApplicationArea = All;
                }
                field("FA No. Series"; Rec."FA No. Series")
                {
                    ApplicationArea = All;
                }
                field("FA Insurance No. Series"; Rec."FA Insurance No. Series")
                {
                    ApplicationArea = All;
                }
                field("Maximum Cash Receipt Limit"; Rec."Maximum Cash Receipt Limit")
                {
                    ApplicationArea = All;
                }
                field("Maximum Cash Payment Limit"; Rec."Maximum Cash Payment Limit")
                {
                    ApplicationArea = All;
                }
                field("Block Negative Cash"; Rec."Block Negative Cash")
                {
                    ApplicationArea = All;
                }
                field("Cash Account"; Rec."Cash Account")
                {
                    ApplicationArea = All;
                }
                field("Freight Zone No. Series"; Rec."Freight Zone No. Series")
                {
                    ApplicationArea = All;
                }
                field("Freight Zone Account"; Rec."Freight Zone Account")
                {
                    ApplicationArea = All;
                }
                field("Include Lead Time Despatch"; Rec."Include Lead Time Despatch")
                {
                    ApplicationArea = All;
                }
                field("ARE1 No. Series"; Rec."ARE1 No. Series")
                {
                    ApplicationArea = All;
                }
                field("CT2 No. Series"; Rec."CT2 No. Series")
                {
                    ApplicationArea = All;
                }
                field("ARE3 No. Series"; Rec."ARE3 No. Series")
                {
                    ApplicationArea = All;
                }
                field("CT3 No. Series"; Rec."CT3 No. Series")
                {
                    ApplicationArea = All;
                }
            }
            group("Sales Setup")
            {
                Caption = 'Sales Setup';

                field("Customer Nos."; Rec."Customer Nos.")
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
                field("Sales Sch. Order Nos."; Rec."Sales Sch. Order Nos.")
                {
                    ApplicationArea = All;
                }
                field("Sales Despatch Slip Nos."; Rec."Sales Despatch Slip Nos.")
                {
                    ApplicationArea = All;
                }
                field("Sales Invoice Nos."; Rec."Sales Invoice Nos.")
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
                field("'""RFQ/Enquiry Nos.""'";'"RFQ/Enquiry Nos."')
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Third Party Code"; Rec."Third Party Code")
                {
                    ApplicationArea = All;
                }
                field("Sales Return Order Nos."; Rec."Sales Return Order Nos.")
                {
                    ApplicationArea = All;
                }
                field("Posted Return Receipt Nos."; Rec."Posted Return Receipt Nos.")
                {
                    ApplicationArea = All;
                }
                field("Sales Credit Memo Nos."; Rec."Sales Credit Memo Nos.")
                {
                    ApplicationArea = All;
                }
                field("Posted SalesCredit Memo Nos."; Rec."Posted SalesCredit Memo Nos.")
                {
                    ApplicationArea = All;
                }
                field("Sales Reminder Nos."; Rec."Sales Reminder Nos.")
                {
                    ApplicationArea = All;
                }
                field("Issued Sales Reminder Nos."; Rec."Issued Sales Reminder Nos.")
                {
                    ApplicationArea = All;
                }
                field("Sales Fin. Chrg. Memo Nos."; Rec."Sales Fin. Chrg. Memo Nos.")
                {
                    ApplicationArea = All;
                }
                field("Issued SalesFin. Chrg. M. Nos."; Rec."Issued SalesFin. Chrg. M. Nos.")
                {
                    ApplicationArea = All;
                }
                field("Free Sample Invoice Nos."; Rec."Free Sample Invoice Nos.")
                {
                    ApplicationArea = All;
                }
                field("VAT Invoice Nos."; Rec."VAT Invoice Nos.")
                {
                    ApplicationArea = All;
                }
                field("F Form Invoice Nos."; Rec."F Form Invoice Nos.")
                {
                    ApplicationArea = All;
                }
                field("Excise Invoice Nos."; Rec."Excise Invoice Nos.")
                {
                    ApplicationArea = All;
                }
                field("Posted Comm. Inv. No. Series"; Rec."Posted Comm. Inv. No. Series")
                {
                    ApplicationArea = All;
                }
            }
            group("Inventory && Warehouse Setup")
            {
                Caption = 'Inventory && Warehouse Setup';

                field("Item Nos."; Rec."Item Nos.")
                {
                    ApplicationArea = All;
                }
                field("Inv. Transfer Order Nos."; Rec."Inv. Transfer Order Nos.")
                {
                    ApplicationArea = All;
                }
                field("Posted Inv Transfer Shpt. Nos."; Rec."Posted Inv Transfer Shpt. Nos.")
                {
                    ApplicationArea = All;
                }
                field("Posted Inv Transfer Rcpt. Nos."; Rec."Posted Inv Transfer Rcpt. Nos.")
                {
                    ApplicationArea = All;
                }
                field("Inventory Put-away Nos."; Rec."Inventory Put-away Nos.")
                {
                    ApplicationArea = All;
                }
                field("Posted Invt. Put-away Nos."; Rec."Posted Invt. Put-away Nos.")
                {
                    ApplicationArea = All;
                }
                field("Inventory Pick Nos."; Rec."Inventory Pick Nos.")
                {
                    ApplicationArea = All;
                }
                field("Posted Invt. Pick Nos."; Rec."Posted Invt. Pick Nos.")
                {
                    ApplicationArea = All;
                }
                field("Inv. Third Party Nos."; Rec."Inv. Third Party Nos.")
                {
                    ApplicationArea = All;
                }
                field("Whse. Receipt Nos."; Rec."Whse. Receipt Nos.")
                {
                    ApplicationArea = All;
                }
                field("Posted Whse. Receipt Nos."; Rec."Posted Whse. Receipt Nos.")
                {
                    ApplicationArea = All;
                }
                field("Whse. Ship Nos."; Rec."Whse. Ship Nos.")
                {
                    ApplicationArea = All;
                }
                field("Posted Whse. Shipment Nos."; Rec."Posted Whse. Shipment Nos.")
                {
                    ApplicationArea = All;
                }
                field("Whse. Put-away Nos."; Rec."Whse. Put-away Nos.")
                {
                    ApplicationArea = All;
                }
                field("Registered Whse. Put-away Nos."; Rec."Registered Whse. Put-away Nos.")
                {
                    ApplicationArea = All;
                }
                field("Whse. Pick Nos."; Rec."Whse. Pick Nos.")
                {
                    ApplicationArea = All;
                }
                field("Registered Whse. Pick Nos."; Rec."Registered Whse. Pick Nos.")
                {
                    ApplicationArea = All;
                }
                field("Whse. Internal Put-away Nos."; Rec."Whse. Internal Put-away Nos.")
                {
                    ApplicationArea = All;
                }
                field("Whse. Internal Pick Nos."; Rec."Whse. Internal Pick Nos.")
                {
                    ApplicationArea = All;
                }
                field("Whse. Movement Nos."; Rec."Whse. Movement Nos.")
                {
                    ApplicationArea = All;
                }
                field("Registered Whse. Movement Nos."; Rec."Registered Whse. Movement Nos.")
                {
                    ApplicationArea = All;
                }
            }
            group("Purchase && Indent Setup")
            {
                Caption = 'Purchase && Indent Setup';

                field("Vendor Nos."; Rec."Vendor Nos.")
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
                field("Purchase Invoice Nos."; Rec."Purchase Invoice Nos.")
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
                field("Purchase Return Order Nos."; Rec."Purchase Return Order Nos.")
                {
                    ApplicationArea = All;
                }
                field("Posted Return Shpt. Nos."; Rec."Posted Return Shpt. Nos.")
                {
                    ApplicationArea = All;
                }
                field("Purchase Credit Memo Nos."; Rec."Purchase Credit Memo Nos.")
                {
                    ApplicationArea = All;
                }
                field("Posted PurchCredit Memo Nos."; Rec."Posted PurchCredit Memo Nos.")
                {
                    ApplicationArea = All;
                }
                field("Delivery Challan No."; Rec."Delivery Challan No.")
                {
                    ApplicationArea = All;
                }
                field("Posted Delivery Challan No."; Rec."Posted Delivery Challan No.")
                {
                    ApplicationArea = All;
                }
                field("Subcontracting Order No."; Rec."Subcontracting Order No.")
                {
                    ApplicationArea = All;
                }
                field("Posted SubCon. Comp. Recpt. No"; Rec."Posted SubCon. Comp. Recpt. No")
                {
                    ApplicationArea = All;
                }
                field("Purchase Invoice Direct No."; Rec."Purchase Invoice Direct No.")
                {
                    ApplicationArea = All;
                }
                field("Posted Purch Inv Direct No."; Rec."Posted Purch Inv Direct No.")
                {
                    ApplicationArea = All;
                }
                field("Purch. Sch. Order Nos."; Rec."Purch. Sch. Order Nos.")
                {
                    ApplicationArea = All;
                }
            }
            group("Gate Entry Setup")
            {
                Caption = 'Gate Entry Setup';

                field("Gate In Nos"; Rec."Gate In Nos")
                {
                    ApplicationArea = All;
                }
                field("Gate Out Nos"; Rec."Gate Out Nos")
                {
                    ApplicationArea = All;
                }
                field("57F4 Nos"; Rec."57F4 Nos")
                {
                    ApplicationArea = All;
                }
                field("57F4 Shpt Nos"; Rec."57F4 Shpt Nos")
                {
                    ApplicationArea = All;
                }
                field("57F4 Rcpt Nos"; Rec."57F4 Rcpt Nos")
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
                field("Posted RGP OUT Shipment Nos"; Rec."Posted RGP OUT Shipment Nos")
                {
                    ApplicationArea = All;
                }
                field("Gate Pass Nos"; Rec."Gate Pass Nos")
                {
                    ApplicationArea = All;
                }
                field("Posted RGP OUT Receipt Nos"; Rec."Posted RGP OUT Receipt Nos")
                {
                    ApplicationArea = All;
                }
            }
            group("Manufacturing Setup")
            {
                Caption = 'Manufacturing Setup';

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
                field("Tool Planned Order Nos."; Rec."Tool Planned Order Nos.")
                {
                    ApplicationArea = All;
                }
                field("Tool Firm Planned Order Nos."; Rec."Tool Firm Planned Order Nos.")
                {
                    ApplicationArea = All;
                }
                field("Tool Released Order Nos."; Rec."Tool Released Order Nos.")
                {
                    ApplicationArea = All;
                }
                field("Req. Slip No. Series"; Rec."Req. Slip No. Series")
                {
                    ApplicationArea = All;
                }
                field("Req. Slip Return No. Series"; Rec."Req. Slip Return No. Series")
                {
                    ApplicationArea = All;
                }
                field("Req. Issue Slip No. Series"; Rec."Req. Issue Slip No. Series")
                {
                    ApplicationArea = All;
                }
                field("Intransit Location"; Rec."Intransit Location")
                {
                    ApplicationArea = All;
                }
                field("Work Center Nos."; Rec."Work Center Nos.")
                {
                    ApplicationArea = All;
                }
                field("Machine Center Nos."; Rec."Machine Center Nos.")
                {
                    ApplicationArea = All;
                }
                field("Production BOM Nos."; Rec."Production BOM Nos.")
                {
                    ApplicationArea = All;
                }
                field("Routing Nos."; Rec."Routing Nos.")
                {
                    ApplicationArea = All;
                }
                field("Prod. Line Reject Location"; Rec."Prod. Line Reject Location")
                {
                    ApplicationArea = All;
                    Caption = 'Line Reject Location Code';
                }
                field("Prod. Line Reject Bin Code"; Rec."Prod. Line Reject Bin Code")
                {
                    ApplicationArea = All;
                    Caption = 'Line Reject Bin Code';
                }
            }
        }
    }
    actions
    {
        area(navigation)
        {
            group("&Resp. NoSeries")
            {
                Caption = '&Resp. NoSeries';

                action(Card)
                {
                    ApplicationArea = All;
                    Caption = 'Card';
                    Image = EditLines;
                    RunObject = Page "Responsibility Center Card";
                    RunPageLink = Code=field(Code);
                    ShortCutKey = 'Shift+F7';
                }
                action(List)
                {
                    ApplicationArea = All;
                    Caption = 'List';
                    RunObject = Page "Res. Center No. Series";
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
