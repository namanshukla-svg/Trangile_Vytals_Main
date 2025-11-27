PageExtension 50094 "SSD Sales Invoice Subform" extends "Sales Invoice Subform"
{
    layout
    {
        modify(Type)
        {
            Editable = true;
        }
        modify("No.")
        {
            Editable = true;
        }
        modify("Variant Code")
        {
            Visible = true;
            Editable = true;
        }
        modify(Description)
        {
            Editable = false;
        }
        modify("Description 2")
        {
            Visible = true;
        }
        modify(Quantity)
        {
            Editable = QuantityEditable;
        }
        modify("Unit of Measure Code")
        {
            Editable = true;
        }
        modify("Unit of Measure")
        {
            Editable = true;
        }
        modify("Unit Price")
        {
            Editable = true;
        }
        modify("Line Amount")
        {
            Editable = false;
        }
        modify("Line Discount %")
        {
            Editable = false;
        }
        modify("Line Discount Amount")
        {
            Editable = false;
        }
        addbefore("Gen. Prod. Posting Group")
        {
        // field("Gen. Bus. Posting Group"; Rec."Gen. Bus. Posting Group")
        // {
        //     ApplicationArea = All;
        //     ToolTip = 'Specifies the value of the Gen. Bus. Posting Group field.';
        // }
        }
    }
    actions
    {
        addafter(GetShipmentLines)
        {
            action("Get &Despatch Line")
            {
                ApplicationArea = All;
                Caption = 'Get &Despatch Line';

                trigger OnAction()
                begin
                    GetDespatch;
                end;
            }
        }
    }
    var QuantityEditable: Boolean;
    trigger OnAfterGetRecord()
    begin
        IF Rec."Despatch Slip No." <> '' THEN QuantityEditable:=FALSE
        ELSE
            QuantityEditable:=TRUE;
    end;
    local procedure ValidateSaveShortcutDimCode(FieldNumber: Integer; var ShortcutDimCode: Code[20])
    begin
        Rec.ValidateShortcutDimCode(FieldNumber, ShortcutDimCode);
        CurrPage.SaveRecord;
    end;
    procedure GetDespatch()
    var
        SalesHeaderLocal: Record "Sales Header";
        SalesDespatchLineLocal: Record "Sales Line";
        FrmGetDespatch: Page "Get Despatch Lines";
        SalesDespatchHeaderLocal: Record "Sales Header";
        SampleOrder: Record "Sales Header";
    begin
        //CF001 St
        SalesHeaderLocal.Get(Rec."Document Type", Rec."Document No.");
        SalesHeaderLocal.TestField("Document Type", SalesHeaderLocal."document type"::Invoice);
        SalesHeaderLocal.TestField(Status, SalesHeaderLocal.Status::Open);
        SalesDespatchLineLocal.Reset;
        SalesDespatchLineLocal.SetRange("Document Type", SalesDespatchLineLocal."document type"::Order);
        SalesDespatchLineLocal.SetRange("Bill-to Customer No.", SalesHeaderLocal."Bill-to Customer No.");
        SalesDespatchLineLocal.SetRange("Document Subtype", SalesDespatchLineLocal."document subtype"::Despatch);
        SalesDespatchLineLocal.SetFilter("Qty. to Ship", '>%1', 0);
        //SalesDespatchLineLocal.SETFILTER("Qty. Shipped Not Invoiced",
        if SalesDespatchLineLocal.Find('-')then repeat SalesDespatchHeaderLocal.Get(SalesDespatchLineLocal."Document Type", SalesDespatchLineLocal."Document No.");
                if SalesDespatchHeaderLocal.Status = SalesDespatchHeaderLocal.Status::Released then begin
                    SalesDespatchLineLocal.Mark(true);
                    //>> BS03012017
                    SampleOrder.Get(SalesDespatchLineLocal."Document Type", SalesDespatchLineLocal."Order No.");
                    if SampleOrder."SPD/Sample Order" then begin
                        SalesHeaderLocal."SPD/Sample Order":=SampleOrder."SPD/Sample Order";
                        SalesHeaderLocal.Modify;
                        Commit;
                    end;
                //<< BS03012017
                end;
            until SalesDespatchLineLocal.Next = 0;
        SalesDespatchLineLocal.MarkedOnly(true);
        FrmGetDespatch.SetTableview(SalesDespatchLineLocal);
        FrmGetDespatch.SetSalesHeader(SalesHeaderLocal);
        FrmGetDespatch.RunModal;
    //CF001 En
    end;
    procedure PacketInformation()
    var
        SalesScheduleBufferLocal: Record "SSD Sales Schedule Buffer";
        SalesPacketDetailsForm: Page "Sales Packet Details";
    begin
        //CF002 St
        SalesScheduleBufferLocal.Reset;
        SalesScheduleBufferLocal.SetRange("Document Type", Rec."Document Type");
        SalesScheduleBufferLocal.SetRange("Document No.", Rec."Document No.");
        SalesScheduleBufferLocal.SetRange("Sell-to Customer No.", Rec."Sell-to Customer No.");
        SalesScheduleBufferLocal.SetRange("Item No.", Rec."No.");
        SalesScheduleBufferLocal.SetRange("Order Line No.", Rec."Line No.");
        SalesScheduleBufferLocal.SetFilter("No. of Box", '<>0', 0);
        Clear(SalesPacketDetailsForm);
        SalesPacketDetailsForm.SetRecord(SalesScheduleBufferLocal);
        SalesPacketDetailsForm.SetTableview(SalesScheduleBufferLocal);
        SalesPacketDetailsForm.LookupMode:=true;
        SalesPacketDetailsForm.Editable:=false;
        SalesPacketDetailsForm.RunModal;
    //CF002 En
    end;
}
