pageextension 55001 "Warehouse Ship" extends "Warehouse Shipment"
{
    layout
    {
        // Add changes to page layout here
    }

    actions
    {
        // Add changes to page actions here
        modify("P&ost Shipment")
        {
            trigger OnBeforeAction()
            var
                WhseShipHeader: Record "Warehouse Shipment Header";
                WhseShipLine: Record "Warehouse Shipment Line";
                SalesHeader: Record "Sales Header";
                SalesLine: Record "Sales Line";
                WhsePostShipment: Codeunit "Whse.-Post Shipment";
                TaxTransactionValue: Record "Tax Transaction Value";
                WarehouseShipLineX: Record "Warehouse Shipment Line";
                WarehouseShipLine: Record "Warehouse Shipment Line";
                TaxTypeObjHelper: Codeunit "Tax Type Object Helper";
                SGSTAmt: Decimal;
                IGSTAmt: Decimal;
                CGSTAmt: Decimal;
                SalesHeaderGST: Record "Sales Header";
                SalesLineGST: Record "Sales Line";
            begin
                WarehouseShipLine.Reset();
                WarehouseShipLine.SetRange("No.", Rec."No.");
                WarehouseShipLine.Setfilter("Item No.", '<>%1', '');
                if WarehouseShipLine.FindFirst() then
                    repeat
                        if WarehouseShipLine."Location Code" <> Rec."Location Code" then
                            Error('Location must be same');
                    until WarehouseShipLine.Next() = 0;

                WhseShipHeader := Rec;
                WhseShipLine.Reset();
                WhseShipLine.SetRange("No.", WhseShipHeader."No.");
                WhseShipLine.SetFilter("Qty. to Ship", '<>%1', 0);
                if WhseShipLine.FindFirst() then
                    repeat
                        if WhseShipLine."Source Type" = DATABASE::"Sales Line" then begin

                            // 🔒 Validation 1: Check Sales Header "Hold-Dispatch"
                            SalesHeader.Reset();
                            SalesHeader.SetRange("No.", WhseShipLine."Source No.");
                            if SalesHeader.FindFirst() then
                                if SalesHeader."Hold-Dispatch" then
                                    Error('Sales Order %1 is on Hold for Dispatch.', SalesHeader."No.");

                            // 🔒 Validation 2: Check Sales Line "Hold-Dispatch"
                            SalesLine.Reset();
                            SalesLine.SetRange("Document No.", WhseShipLine."Source No.");
                            SalesLine.SetRange("No.", WhseShipLine."Item No.");
                            if SalesLine.FindFirst() then
                                if SalesLine."Hold-Dispatch" then
                                    Error('Sales Line for Item %1 is on Hold for Dispatch.', SalesLine."No.");
                        end;
                    until WhseShipLine.Next() = 0;

                WarehouseShipLineX.Reset();
                WarehouseShipLineX.SetRange("No.", Rec."No.");
                WarehouseShipLineX.Setfilter("Item No.", '<>%1', '');
                if WarehouseShipLineX.FindFirst() then begin
                    SalesHeaderGST.Reset();
                    SalesHeaderGST.SetRange("No.", WarehouseShipLineX."Source No.");
                    if SalesHeaderGST.FindFirst() then
                        if (SalesHeaderGST."GST Customer Type" = SalesHeaderGST."GST Customer Type"::Registered) or (SalesHeaderGST."GST Customer Type" = SalesHeaderGST."GST Customer Type"::Unregistered) then begin
                            WarehouseShipLine.Reset();
                            WarehouseShipLine.SetRange("No.", Rec."No.");
                            WarehouseShipLine.Setfilter("Item No.", '<>%1', '');
                            if WarehouseShipLine.FindFirst() then
                                repeat
                                    SGSTAmt := 0;
                                    IGSTAmt := 0;
                                    CGSTAmt := 0;
                                    SalesLineGST.Reset();
                                    SalesLineGST.SetRange("Document No.", WarehouseShipLine."Source No.");
                                    SalesLineGST.SetRange("Line No.", WarehouseShipLine."Source Line No.");
                                    if SalesLineGST.FindFirst() then begin
                                        TaxTransactionValue.Reset();
                                        TaxTransactionValue.SetFilter("Tax Record ID", '%1', SalesLineGST.RecordId);
                                        TaxTransactionValue.SetFilter("Value Type", '%1', TaxTransactionValue."Value Type"::Component);
                                        TaxTransactionValue.SetRange("Visible on Interface", true);
                                        if TaxTransactionValue.FindSet() then
                                            repeat
                                                if TaxTransactionValue.GetAttributeColumName = 'IGST' then begin
                                                    // IGSTPer := TaxTransactionValue.Percent;
                                                    IGSTAmt += TaxTypeObjHelper.GetComponentAmountFrmTransValue(TaxTransactionValue);
                                                end;
                                                if TaxTransactionValue.GetAttributeColumName = 'CGST' then begin
                                                    // CGSTPer := TaxTransactionValue.Percent;
                                                    CGSTAmt += TaxTypeObjHelper.GetComponentAmountFrmTransValue(TaxTransactionValue);
                                                end;
                                                if TaxTransactionValue.GetAttributeColumName = 'SGST' then begin
                                                    // SGSTPer := TaxTransactionValue.Percent;
                                                    SGSTAmt += TaxTypeObjHelper.GetComponentAmountFrmTransValue(TaxTransactionValue);
                                                end;
                                            until TaxTransactionValue.Next() = 0;
                                        if (IGSTAmt = 0) and ((SGSTAmt = 0) and (CGSTAmt = 0)) then
                                            Error('Please calculate the GST for Line No. %1', WarehouseShipLine."Line No.");
                                    end;
                                until WarehouseShipLine.Next() = 0;
                        end;
                end;
            end;
        }
        modify("Post and &Print")
        {
            trigger OnBeforeAction()
            var
                WhseShipHeader: Record "Warehouse Shipment Header";
                WhseShipLine: Record "Warehouse Shipment Line";
                SalesHeader: Record "Sales Header";
                SalesLine: Record "Sales Line";
                WhsePostShipment: Codeunit "Whse.-Post Shipment";
                TaxTransactionValue: Record "Tax Transaction Value";
                WarehouseShipLineX: Record "Warehouse Shipment Line";
                WarehouseShipLine: Record "Warehouse Shipment Line";
                TaxTypeObjHelper: Codeunit "Tax Type Object Helper";
                SGSTAmt: Decimal;
                IGSTAmt: Decimal;
                CGSTAmt: Decimal;
                SalesHeaderGST: Record "Sales Header";
                SalesLineGST: Record "Sales Line";
            begin
                WhseShipHeader := Rec;
                WhseShipLine.Reset();
                WhseShipLine.SetRange("No.", WhseShipHeader."No.");
                WhseShipLine.SetFilter("Qty. to Ship", '<>%1', 0);
                if WhseShipLine.FindFirst() then
                    repeat
                        if WhseShipLine."Source Type" = DATABASE::"Sales Line" then begin

                            // 🔒 Validation 1: Check Sales Header "Hold-Dispatch"
                            SalesHeader.Reset();
                            SalesHeader.SetRange("No.", WhseShipLine."Source No.");
                            if SalesHeader.FindFirst() then
                                if SalesHeader."Hold-Dispatch" then
                                    Error('Sales Order %1 is on Hold for Dispatch.', SalesHeader."No.");

                            // 🔒 Validation 2: Check Sales Line "Hold-Dispatch"
                            SalesLine.Reset();
                            SalesLine.SetRange("Document No.", WhseShipLine."Source No.");
                            SalesLine.SetRange("No.", WhseShipLine."Item No.");
                            if SalesLine.FindFirst() then
                                if SalesLine."Hold-Dispatch" then
                                    Error('Sales Line for Item %1 is on Hold for Dispatch.', SalesLine."No.");
                        end;
                    until WhseShipLine.Next() = 0;

                WarehouseShipLineX.Reset();
                WarehouseShipLineX.SetRange("No.", Rec."No.");
                WarehouseShipLineX.Setfilter("Item No.", '<>%1', '');
                if WarehouseShipLineX.FindFirst() then begin
                    SalesHeaderGST.Reset();
                    SalesHeaderGST.SetRange("No.", WarehouseShipLineX."Source No.");
                    if SalesHeaderGST.FindFirst() then
                        if (SalesHeaderGST."GST Customer Type" = SalesHeaderGST."GST Customer Type"::Registered) or (SalesHeaderGST."GST Customer Type" = SalesHeaderGST."GST Customer Type"::Unregistered) then begin
                            WarehouseShipLine.Reset();
                            WarehouseShipLine.SetRange("No.", Rec."No.");
                            WarehouseShipLine.Setfilter("Item No.", '<>%1', '');
                            if WarehouseShipLine.FindFirst() then
                                repeat
                                    SGSTAmt := 0;
                                    IGSTAmt := 0;
                                    CGSTAmt := 0;
                                    SalesLineGST.Reset();
                                    SalesLineGST.SetRange("Document No.", WarehouseShipLine."Source No.");
                                    SalesLineGST.SetRange("Line No.", WarehouseShipLine."Source Line No.");
                                    if SalesLineGST.FindFirst() then begin
                                        TaxTransactionValue.Reset();
                                        TaxTransactionValue.SetFilter("Tax Record ID", '%1', SalesLineGST.RecordId);
                                        TaxTransactionValue.SetFilter("Value Type", '%1', TaxTransactionValue."Value Type"::Component);
                                        TaxTransactionValue.SetRange("Visible on Interface", true);
                                        if TaxTransactionValue.FindSet() then
                                            repeat
                                                if TaxTransactionValue.GetAttributeColumName = 'IGST' then begin
                                                    // IGSTPer := TaxTransactionValue.Percent;
                                                    IGSTAmt += TaxTypeObjHelper.GetComponentAmountFrmTransValue(TaxTransactionValue);
                                                end;
                                                if TaxTransactionValue.GetAttributeColumName = 'CGST' then begin
                                                    // CGSTPer := TaxTransactionValue.Percent;
                                                    CGSTAmt += TaxTypeObjHelper.GetComponentAmountFrmTransValue(TaxTransactionValue);
                                                end;
                                                if TaxTransactionValue.GetAttributeColumName = 'SGST' then begin
                                                    // SGSTPer := TaxTransactionValue.Percent;
                                                    SGSTAmt += TaxTypeObjHelper.GetComponentAmountFrmTransValue(TaxTransactionValue);
                                                end;
                                            until TaxTransactionValue.Next() = 0;
                                        if (IGSTAmt = 0) and ((SGSTAmt = 0) and (CGSTAmt = 0)) then
                                            Error('Please calculate the GST for Line No. %1', WarehouseShipLine."Line No.");
                                    end;
                                until WarehouseShipLine.Next() = 0;
                        end;
                end;
            end;
        }

    }

    var
        myInt: Integer;
}