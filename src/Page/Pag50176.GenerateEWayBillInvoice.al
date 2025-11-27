Page 50176 "Generate E Way Bill Invoice"
{
    ApplicationArea = All;
    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = List;
    Permissions = TableData "Sales Invoice Header"=rim;
    SourceTable = "Sales Invoice Header";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("E-Way Bill No."; Rec."E-Way Bill No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("E-Way Bill Date"; Rec."E-Way Bill Date")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("E-Way Bill Validity"; Rec."E-Way Bill Validity")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("E-Way Generated"; Rec."E-Way Generated")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Sell-to Customer Name"; Rec."Sell-to Customer Name")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Bill-to Name"; Rec."Bill-to Name")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Ship-to Name"; Rec."Ship-to Name")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Order Date"; Rec."Order Date")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Vehicle No."; Rec."Vehicle No.")
                {
                    ApplicationArea = All;
                }
                field("Shipment Date"; Rec."Shipment Date")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Order No."; Rec."Order No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = All;
                }
                field("Mode of Transport"; Rec."Mode of Transport")
                {
                    ApplicationArea = All;
                }
                field("New Vechile No."; Rec."New Vechile No.")
                {
                    ApplicationArea = All;
                }
                field("Vechile No. Update Remark"; Rec."Vechile No. Update Remark")
                {
                    ApplicationArea = All;
                }
                field("E-Way Canceled"; Rec."E-Way Canceled")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Transporter Id"; Rec."Shipping Agent Code")
                {
                    ApplicationArea = All;
                    Caption = 'Transporter Id';

                    trigger OnValidate()
                    begin
                        if ShippingAgent.Get(Rec."Shipping Agent Code")then begin
                            //IF ShippingAgent.Blocked THEN ERROR('You Cannot Select Blocked Transporter');
                            if ShippingAgent."Transporter GST No." = '' then Error('Transporter GSTIN must have value in Shipping Agent Table');
                        end;
                    end;
                }
                field("Transporte Name"; Rec."Shipping Agent Code")
                {
                    ApplicationArea = All;
                    Caption = 'Transporte Name';
                }
                field("Transporter Mode"; Rec."Transport Method")
                {
                    ApplicationArea = All;
                    Caption = 'Transporter Mode';

                    trigger OnValidate()
                    begin
                        if Rec."Transport Method" = 'BY ROAD' then Trans_DocDate_No:=false
                        else
                            Trans_DocDate_No:=true;
                    end;
                }
                field("Transporter Document No."; Rec."LR/RR No.")
                {
                    ApplicationArea = All;
                    Caption = 'Transporter Document No.';
                    Editable = Trans_DocDate_No;
                }
                field("Transporter Document Date"; Rec."LR/RR Date")
                {
                    ApplicationArea = All;
                    Caption = 'Transporter Document Date';
                    Editable = Trans_DocDate_No;
                }
                field("Transportation Distance"; Rec."Transportation Distance")
                {
                    ApplicationArea = All;
                    Caption = 'Transportation Distance';
                }
            }
        }
    }
    actions
    {
        area(creation)
        {
            action("Generate E-Way Bill No")
            {
                ApplicationArea = All;
                Image = Import;
                Promoted = true;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    SalesInvoiceHeader: Record "Sales Invoice Header";
                    //APIConsumer: Codeunit "API Consumer E-Way Bill";
                    //GenerateEWB: Codeunit "Generate EWB";
                    EInvoiceMgt: Codeunit "SSD EInvoice Management";
                begin
                    //CreateJSONSalesInvoiceEvent(Rec);
                    EInvoiceMgt.GenerateSalesInvoiceEWB(Rec);
                    CurrPage.SetSelectionFilter(SalesInvoiceHeader);
                    SalesInvoiceHeader.ModifyAll("E-Way-to generate", false);
                end;
            }
            action("Update Vehicle No")
            {
                ApplicationArea = All;
                Image = UpdateXML;
                Promoted = true;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    APIConsumer: Codeunit "API Consumer E-Way Bill";
                begin
                    UpdateVehicleNoEvent(Rec);
                end;
            }
            action("Cancel E-way")
            {
                ApplicationArea = All;

                trigger OnAction()
                begin
                    Rec.TestField("E-Way Bill No.");
                    CancelEwaySalesInvoiceEvent(Rec);
                end;
            }
            action("E-way Manual")
            {
                ApplicationArea = All;

                trigger OnAction()
                begin
                    CreateManualJSONInvoice(Rec);
                end;
            }
        }
    }
    trigger OnOpenPage()
    begin
        Rec.SetSecurityFilterOnRespCenter;
        Trans_DocDate_No:=true;
    end;
    var JSONCreater: Codeunit "API Consumer E-Way Bill";
    gUserSetup: Record "User Setup";
    Trans_DocDate_No: Boolean;
    ShippingAgent: Record "Shipping Agent";
    ShippingAgentspage: Page "Shipping Agents";
    [IntegrationEvent(false, false)]
    local procedure CreateJSONSalesInvoiceEvent(SalesInvoiceHeader: Record "Sales Invoice Header")
    begin
    end;
    [IntegrationEvent(false, false)]
    local procedure ConsolitedEWayBillSalesInvoiceEvent(JsonString: Text)
    begin
    end;
    [IntegrationEvent(false, false)]
    local procedure UpdateVehicleNoEvent(SalesInvoiceHeader: Record "Sales Invoice Header")
    begin
    end;
    [IntegrationEvent(false, false)]
    local procedure CancelEwaySalesInvoiceEvent(SalesInvoiceHeader: Record "Sales Invoice Header")
    begin
    end;
    [IntegrationEvent(false, false)]
    local procedure CreateManualJSONInvoice(SalesInvoiceHeader: Record "Sales Invoice Header")
    begin
    end;
}
