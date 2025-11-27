Page 50067 "Gate Pass"
{
    SourceTable = "SSD Gate Pass Header";
    SourceTableView = sorting("No.")order(ascending)where(Posted=const(false));
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';

                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                }
                field("Document Type"; Rec."Document Type")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Date; Rec.Date)
                {
                    ApplicationArea = All;
                }
                field("Gate Pass Time"; Rec."Gate Pass Time")
                {
                    ApplicationArea = All;
                    Caption = 'Time';
                }
                field("Vehicle No."; Rec."Vehicle No.")
                {
                    ApplicationArea = All;
                }
                field("Driver Name"; Rec."Driver Name")
                {
                    ApplicationArea = All;
                }
                field("Transporter Code"; Rec."Transporter Code")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    var
                        ShippingAgent: Record "Shipping Agent";
                    begin
                    end;
                }
                field("Transporter Name"; Rec."Transporter Name")
                {
                    ApplicationArea = All;
                }
                field("Bilty No."; Rec."Bilty No.")
                {
                    ApplicationArea = All;
                }
                field("Mobile No."; Rec."Mobile No.")
                {
                    ApplicationArea = All;
                }
            }
            part("Gate Pass Sub form"; "Gate Pass Sub form")
            {
                SubPageLink = "No."=field("No.");
                SubPageView = sorting("No.", "Line No.")order(ascending);
                ApplicationArea = All;
            }
        }
    }
    actions
    {
        area(navigation)
        {
            group("Function")
            {
                Caption = 'Function';
                Image = "Order";

                action("Get Posted &Invoices")
                {
                    ApplicationArea = All;
                    Caption = 'Get Posted &Invoices';

                    trigger OnAction()
                    begin
                        TestFields(Rec);
                        // TESTFIELD(Date);
                        // TESTFIELD("Vehicle No.");
                        // TESTFIELD("Driver Name");
                        // TESTFIELD("Transporter Code");
                        // TESTFIELD("Bilty No.");
                        Clear(GetSalesInvoices);
                        SalesInvoiceHeader.CalcFields("Gate Pass");
                        SalesInvoiceHeader.SetFilter("Gate Pass", '%1', false);
                        GetSalesInvoices.SetValue(Rec."No.");
                        GetSalesInvoices.LookupMode:=true;
                        GetSalesInvoices.SetTableview(SalesInvoiceHeader);
                        GetSalesInvoices.RunModal;
                    end;
                }
                action("Get Posted &Transfer Invoice")
                {
                    ApplicationArea = All;
                    Caption = 'Get Posted &Transfer Invoice';

                    trigger OnAction()
                    begin
                        TestFields(Rec);
                        // TESTFIELD(Date);
                        // TESTFIELD("Vehicle No.");
                        // TESTFIELD("Driver Name");
                        // TESTFIELD("Transporter Code");
                        // TESTFIELD("Bilty No.");
                        Clear(GetTransferInvoices);
                        TransferShipHeader.CalcFields("Gate Pass");
                        TransferShipHeader.SetFilter("Gate Pass", '%1', false);
                        GetTransferInvoices.SetValue(Rec."No.");
                        GetTransferInvoices.LookupMode:=true;
                        GetTransferInvoices.SetTableview(TransferShipHeader);
                        GetTransferInvoices.RunModal;
                    end;
                }
                action("Get Posted &Credit Moemo")
                {
                    ApplicationArea = All;
                    Caption = 'Get Posted &Credit Memo';

                    trigger OnAction()
                    begin
                        TestFields(Rec);
                        // TESTFIELD(Date);
                        // TESTFIELD("Vehicle No.");
                        // TESTFIELD("Driver Name");
                        // TESTFIELD("Transporter Code");
                        // TESTFIELD("Bilty No.");
                        Clear(GetCreditMemo);
                        SalesCreditMemo.CalcFields("Gate Pass");
                        SalesCreditMemo.SetFilter("Gate Pass", '%1', false);
                        GetCreditMemo.SetValue(Rec."No.");
                        GetCreditMemo.LookupMode:=true;
                        GetCreditMemo.SetTableview(SalesCreditMemo);
                        GetCreditMemo.RunModal;
                    end;
                }
                action("Get Posted &RGP Shipment")
                {
                    ApplicationArea = All;
                    Caption = 'Get Posted &RGP Shipment';

                    trigger OnAction()
                    begin
                        TestFields(Rec);
                        // TESTFIELD(Date);
                        // TESTFIELD("Vehicle No.");
                        // TESTFIELD("Driver Name");
                        // TESTFIELD("Transporter Code");
                        // TESTFIELD("Bilty No.");
                        Clear(GetPostedRGPShipment);
                        RGPShipmentHeader.CalcFields("Gate Pass");
                        RGPShipmentHeader.SetFilter(NRGP, '%1', false);
                        RGPShipmentHeader.SetFilter("Gate Pass", '%1', false);
                        GetPostedRGPShipment.SetValue(Rec."No.");
                        GetPostedRGPShipment.LookupMode:=true;
                        GetPostedRGPShipment.SetTableview(RGPShipmentHeader);
                        GetPostedRGPShipment.RunModal;
                    end;
                }
                action("Get Posted &NRGP Shipment")
                {
                    ApplicationArea = All;
                    Caption = 'Get Posted &NRGP Shipment';

                    trigger OnAction()
                    begin
                        TestFields(Rec);
                        // TESTFIELD(Date);
                        // TESTFIELD("Vehicle No.");
                        // TESTFIELD("Driver Name");
                        // TESTFIELD("Transporter Code");
                        // TESTFIELD("Bilty No.");
                        Clear(GetPostedNRGPShipment);
                        RGPShipmentHeader.CalcFields("Gate Pass");
                        RGPShipmentHeader.SetFilter(NRGP, '%1', true);
                        RGPShipmentHeader.SetFilter("Gate Pass", '%1', false);
                        GetPostedNRGPShipment.SetValue(Rec."No.");
                        GetPostedNRGPShipment.LookupMode:=true;
                        GetPostedNRGPShipment.SetTableview(RGPShipmentHeader);
                        GetPostedNRGPShipment.RunModal;
                    end;
                }
                action("Get Posted &Delivery Challan")
                {
                    ApplicationArea = All;
                    Caption = 'Get Posted &Delivery Challan';

                    trigger OnAction()
                    begin
                        TestFields(Rec);
                        // TESTFIELD(Date);
                        // TESTFIELD("Vehicle No.");
                        // TESTFIELD("Driver Name");
                        // TESTFIELD("Transporter Code");
                        // TESTFIELD("Bilty No.");
                        Clear(GetPostedDeliveryChallan);
                        DeliveryChallanHeader.CalcFields("Gate Pass");
                        DeliveryChallanHeader.SetFilter("Gate Pass", '%1', false);
                        GetPostedDeliveryChallan.SetValue(Rec."No.");
                        GetPostedDeliveryChallan.LookupMode:=true;
                        GetPostedDeliveryChallan.SetTableview(DeliveryChallanHeader);
                        GetPostedDeliveryChallan.RunModal;
                    end;
                }
                action("Get Posted &Purchase Credit Memo")
                {
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        TestFields(Rec);
                        // TESTFIELD(Date);
                        // TESTFIELD("Vehicle No.");
                        // TESTFIELD("Driver Name");
                        // TESTFIELD("Transporter Code");
                        // TESTFIELD("Bilty No.");
                        Clear(GetPostedPurchCreditMemo);
                        PurchCrMemoHdr.CalcFields("Gate Pass");
                        PurchCrMemoHdr.SetFilter("Gate Pass", '%1', false);
                        GetPostedPurchCreditMemo.SetValue(Rec."No.");
                        GetPostedPurchCreditMemo.LookupMode:=true;
                        GetPostedPurchCreditMemo.SetTableview(PurchCrMemoHdr);
                        GetPostedPurchCreditMemo.RunModal;
                    end;
                }
            }
            group(Posting)
            {
                Caption = 'Posting';
                Image = "Order";

                action(Post)
                {
                    ApplicationArea = All;

                    trigger OnAction()
                    var
                        UserSetup: Record "User Setup";
                        GenJnlCheckLine: Codeunit "Gen. Jnl.-Check Line";
                        Text045: label 'is not within your range of allowed posting dates.';
                    begin
                        if GenJnlCheckLine.DateNotAllowed(Rec.Date)then Rec.FieldError(Date, Text045);
                        PostGatePass;
                        // ALLE RK 11.04.2016
                        GatePassLine.SetRange("No.", Rec."No.");
                        if GatePassLine.FindSet then begin
                            repeat if Rec.Date < GatePassLine."Invoice Date" then Error('Posting Date must be greater to Invoice Date')until GatePassLine.Next = 0;
                        end;
                    end;
                }
                action("Post & Print")
                {
                    ApplicationArea = All;

                    trigger OnAction()
                    var
                        GatePassHeader1: Record "SSD Gate Pass Header";
                    begin
                        GatePassHeader1.SetRange("No.", Rec."No.");
                        PostGatePass;
                        Report.Run(Report::"Gate Pass", false, true, GatePassHeader1);
                    end;
                }
            }
        }
    }
    var Text50001: label 'Are you Sure ?';
    GetSalesInvoices: Page "Get Posted Sales Invoices";
    SalesInvoiceHeader: Record "Sales Invoice Header";
    SalesCreditMemo: Record "Sales Cr.Memo Header";
    GetCreditMemo: Page "Get Posted Credit Memo";
    GetTransferInvoices: Page "Get Posted Transfer Invoices";
    TransferShipHeader: Record "Transfer Shipment Header";
    GetPostedRGPShipment: Page "Get Posted RGP Shipment";
    RGPShipmentHeader: Record "SSD RGP Shipment Header";
    GetPostedNRGPShipment: Page "Get Posted NRGP Shipment";
    GetPostedDeliveryChallan: Page "Get Posted Delivery Challan";
    DeliveryChallanHeader: Record "Delivery Challan Header";
    PurchCrMemoHdr: Record "Purch. Cr. Memo Hdr.";
    GetPostedPurchCreditMemo: Page "Get Posted Purch. Credit Memo";
    GatePassLine: Record "SSD Gate Pass Line";
    procedure PostGatePass()
    var
        GatePassLine: Record "SSD Gate Pass Line";
    begin
        if Confirm(Text50001, false)then begin
            TestFields(Rec);
            //  TESTFIELD(Date);
            //  TESTFIELD("Vehicle No.");
            //  TESTFIELD("Driver Name");
            //  TESTFIELD("Transporter Code");
            //  TESTFIELD("Bilty No.");
            GatePassLine.SetRange("No.", Rec."No.");
            if GatePassLine.FindFirst then begin
                Rec.Posted:=true;
                Rec.Modify;
            end;
        end;
    end;
    [IntegrationEvent(false, false)]
    procedure TestFields(GatePassHeader: Record "SSD Gate Pass Header")
    begin
    end;
}
