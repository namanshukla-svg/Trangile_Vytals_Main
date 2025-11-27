Page 50187 "Generate E Way Bill Subcon"
{
    ApplicationArea = All;
    Caption = 'Generate E Way Bill Delivery Challan';
    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = List;
    SourceTable = "Delivery Challan Header";
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
                }
                field("E-Way Bill Date"; Rec."E-Way Bill Date")
                {
                    ApplicationArea = All;
                }
                field("E-Way Bill Validity"; Rec."E-Way Bill Validity")
                {
                    ApplicationArea = All;
                }
                field("E-Way Generated"; Rec."E-Way Generated")
                {
                    ApplicationArea = All;
                }
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Posting Date"; Rec."Posting Date")
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
                field("Transporter Mode"; Rec."Transportation Distance")
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
                field("Transporter Document Date"; Rec."E-Way Canceled")
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
                    DeliveryChallanHeader: Record "Delivery Challan Header";
                    APIConsumer: Codeunit "API Consumer E-Way Bill";
                begin
                    CreateJSONDeliveryChallanEvent(Rec);
                    CurrPage.SetSelectionFilter(DeliveryChallanHeader);
                    DeliveryChallanHeader.ModifyAll("E-Way-to generate", false);
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
                    UpdateVehicleNo_DeliveryChallanEvent(Rec);
                end;
            }
            action("Cancel E-way")
            {
                ApplicationArea = All;

                trigger OnAction()
                begin
                    Rec.TestField("E-Way Bill No.");
                    CancelEwaySubconEvent(Rec);
                end;
            }
            action("E-way Manual")
            {
                ApplicationArea = All;

                trigger OnAction()
                begin
                    CreateJSONDeliveryChallanEventMan(Rec);
                end;
            }
        }
    }
    trigger OnOpenPage()
    begin
        if UserMgt.GetPurchasesFilter() <> '' then begin
            Rec.FilterGroup(2);
            Rec.SetRange("Responsibility Center", UserMgt.GetPurchasesFilter());
            Rec.FilterGroup(0);
        end;
        Trans_DocDate_No:=true;
    end;
    var JSONCreater: Codeunit "API Consumer E-Way Bill";
    gUserSetup: Record "User Setup";
    UserMgt: Codeunit "User Setup Management";
    Trans_DocDate_No: Boolean;
    ShippingAgent: Record "Shipping Agent";
    [IntegrationEvent(false, false)]
    local procedure CreateJSONDeliveryChallanEvent(var DeliveryChallanHeaderL: Record "Delivery Challan Header")
    begin
    end;
    [IntegrationEvent(false, false)]
    local procedure ConsolitedEWayBillSalesReturnEvent(JsonString: Text)
    begin
    end;
    [IntegrationEvent(false, false)]
    local procedure UpdateVehicleNo_DeliveryChallanEvent(var DeliveryChallanHeader: Record "Delivery Challan Header")
    begin
    end;
    [IntegrationEvent(false, false)]
    local procedure CancelEwaySubconEvent(DeliveryChallanHeader: Record "Delivery Challan Header")
    begin
    end;
    [IntegrationEvent(false, false)]
    local procedure CreateJSONDeliveryChallanEventMan(var DeliveryChallanHeaderL: Record "Delivery Challan Header")
    begin
    end;
}
