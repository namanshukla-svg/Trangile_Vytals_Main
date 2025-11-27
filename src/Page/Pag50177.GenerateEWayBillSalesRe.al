Page 50177 "Generate EWay Bill Sales Re"
{
    ApplicationArea = All;
    Caption = 'Generate EWay Bill Sales Return Shipment';
    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = List;
    SourceTable = "Return Shipment Header";
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
                field("Pay-to Name"; Rec."Pay-to Name")
                {
                    ApplicationArea = All;
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
                field("Transporter Document No."; Rec."Applies-to Doc. No.")
                {
                    ApplicationArea = All;
                    Caption = 'Transporter Document No.';
                    Editable = Trans_DocDate_No;
                }
                field("Transporter Document Date"; Rec."Document Date")
                {
                    ApplicationArea = All;
                    Caption = 'Transporter Document Date';
                    Editable = Trans_DocDate_No;
                }
                field("Transportation Distance"; Rec."Transportation Distance")
                {
                    ApplicationArea = All;
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
                    ReturnShipmentHeader: Record "Return Shipment Header";
                    APIConsumer: Codeunit "API Consumer E-Way Bill";
                begin
                    CreateJSONSalesReturnEvent(Rec);
                    CurrPage.SetSelectionFilter(ReturnShipmentHeader);
                    ReturnShipmentHeader.ModifyAll("E-Way-to generate", false);
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
                    UpdateVehicleNo_Purchase_ReturnEvent(Rec)end;
            }
            action("Cancel E-Way")
            {
                ApplicationArea = All;

                trigger OnAction()
                begin
                    Rec.TestField("E-Way Bill No.");
                    CancelEwayReturnEvent(Rec);
                end;
            }
            action("E-way Manual")
            {
                ApplicationArea = All;

                trigger OnAction()
                begin
                    CreateReturnMan(Rec)end;
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
    UserMgt: Record "User Setup";
    Trans_DocDate_No: Boolean;
    ShippingAgent: Record "Shipping Agent";
    [IntegrationEvent(false, false)]
    local procedure CreateJSONSalesReturnEvent(var ReturnShipmentHeaderL: Record "Return Shipment Header")
    begin
    end;
    [IntegrationEvent(false, false)]
    local procedure ConsolitedEWayBillSalesReturnEvent(JsonString: Text)
    begin
    end;
    [IntegrationEvent(false, false)]
    local procedure UpdateVehicleNo_Purchase_ReturnEvent(var ReturnShipmentHeader: Record "Return Shipment Header")
    begin
    end;
    [IntegrationEvent(false, false)]
    local procedure CancelEwayReturnEvent(ReturnShipmentHeader: Record "Return Shipment Header")
    begin
    end;
    [IntegrationEvent(false, false)]
    local procedure CreateReturnMan(ReturnShipmentHeaderL: Record "Return Shipment Header")
    begin
    end;
}
