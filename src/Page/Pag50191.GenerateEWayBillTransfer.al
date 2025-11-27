Page 50191 "Generate E Way Bill Transfer"
{
    ApplicationArea = All;
    Caption = 'Generate E Way Bill Transfer Shipment';
    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = List;
    SourceTable = "Transfer Shipment Header";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("E-Way Bill No."; Rec."SSD E-Way Bill No.")
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
                field("LR/RR No."; Rec."LR/RR No.")
                {
                    ApplicationArea = All;
                }
                field("LR/RR Date"; Rec."LR/RR Date")
                {
                    ApplicationArea = All;
                }
                field("Vehicle No."; Rec."Vehicle No.")
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
                            //  IF ShippingAgent.Blocked THEN ERROR('You Cannot Select Blocked Transporter');
                            if ShippingAgent."Transporter GST No." = '' then Error('Transporter GSTIN must have value in Shipping Agent Table');
                        end;
                    end;
                }
                field("Transporter Name"; Rec."Shipping Agent Code")
                {
                    ApplicationArea = All;
                    Caption = 'Transporter Name';
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
                field("Transporter Document No."; Rec."External Document No.")
                {
                    ApplicationArea = All;
                    Caption = 'Transporter Document No.';
                    Editable = Trans_DocDate_No;
                }
                field("Transporter Document Date"; Rec."Posting Date")
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
                    TransferShipmentHeader: Record "Transfer Shipment Header";
                    APIConsumer: Codeunit "API Consumer E-Way Bill";
                begin
                    CreateJSONTransferShipmentEvent(Rec);
                    CurrPage.SetSelectionFilter(TransferShipmentHeader);
                    TransferShipmentHeader.ModifyAll("E-Way-to generate", false);
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
                    UpdateVehicleNo_TransferShipmentEvent(Rec);
                end;
            }
            action("Cancel E-way")
            {
                ApplicationArea = All;

                trigger OnAction()
                begin
                    Rec.TestField("SSD E-Way Bill No.");
                    CancelEwayTransferEvent(Rec);
                end;
            }
            action("E-way Manual")
            {
                ApplicationArea = All;

                trigger OnAction()
                begin
                    CreateJSONTransferShipmentEventMan(Rec);
                end;
            }
        }
    }
    trigger OnOpenPage()
    begin
        //>>SM_MUA01
        if UserMgt.GetRespCenterFilter() <> '' then begin
            Rec.FilterGroup(2);
            Rec.SetRange("Responsibility Center", UserMgt.GetRespCenterFilter());
            Rec.FilterGroup(0);
        end;
        //<<SM_MUA01
        Trans_DocDate_No:=true;
    end;
    var JSONCreater: Codeunit "API Consumer E-Way Bill";
    gUserSetup: Record "User Setup";
    UserMgt: Codeunit "SSD User Setup Management";
    Trans_DocDate_No: Boolean;
    ShippingAgent: Record "Shipping Agent";
    [IntegrationEvent(false, false)]
    local procedure CreateJSONTransferShipmentEvent(var TransferShipmentHeaderL: Record "Transfer Shipment Header")
    begin
    end;
    [IntegrationEvent(false, false)]
    local procedure ConsolitedEWayBillSalesReturnEvent(JsonString: Text)
    begin
    end;
    [IntegrationEvent(false, false)]
    local procedure UpdateVehicleNo_TransferShipmentEvent(var TransferShipmentHeader: Record "Transfer Shipment Header")
    begin
    end;
    [IntegrationEvent(false, false)]
    local procedure CancelEwayTransferEvent(TransferShipmentHeader: Record "Transfer Shipment Header")
    begin
    end;
    [IntegrationEvent(false, false)]
    local procedure CreateJSONTransferShipmentEventMan(var TransferShipmentHeaderL: Record "Transfer Shipment Header")
    begin
    end;
}
