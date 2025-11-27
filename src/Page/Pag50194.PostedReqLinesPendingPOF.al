Page 50194 "Posted Req. Lines Pending PO-F"
{
    // //CF001 23.02.2006 Responsibility Center
    // CML-Check Ashish 150108
    ApplicationArea = All;
    Caption = 'Posted Requisition but Pending PO Lists';
    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = List;
    SourceTable = "Requisition Line";
    SourceTableView = sorting("Replenishment System", "Action Message", "Created PO Doc. type", Posted, "Due Date") order(ascending) where("Replenishment System" = filter(Purchase | "Prod. Order"), "Created PO Doc. type" = const(Order), Posted = const(true), "Pending PO" = const(true));
    UsageCategory = Tasks;

    layout
    {
        area(content)
        {
            repeater(Control1000000000)
            {
                field("Indent No."; Rec."Indent No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Indent Line No."; Rec."Indent Line No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Remaining Qty. (Base)"; Rec."Remaining Qty. (Base)")
                {
                    ApplicationArea = All;
                }
                field("Cost Amount"; Rec."Cost Amount")
                {
                    ApplicationArea = All;
                }
                field("Ref. Line No."; Rec."Ref. Line No.")
                {
                    ApplicationArea = All;
                }
                field("Ref. Order No."; Rec."Ref. Order No.")
                {
                    ApplicationArea = All;
                }
                field(Type; Rec.Type)
                {
                    ApplicationArea = All;
                }
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field("Description 2"; Rec."Description 2")
                {
                    ApplicationArea = All;
                }
                field(Quantity; Rec.Quantity)
                {
                    ApplicationArea = All;
                }
                field("Direct Unit Cost"; Rec."Direct Unit Cost")
                {
                    ApplicationArea = All;
                }
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                    ApplicationArea = All;
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                    ApplicationArea = All;
                }
                field("Pending PO Qty"; Rec."Pending PO Qty")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Requested PO Qty"; Rec."Requested PO Qty")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
    actions
    {
        area(processing)
        {
            action("&Short Close Line")
            {
                ApplicationArea = All;
                Caption = '&Short Close Line';
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    //5.51
                    if Confirm('Are you sure, you want to short close the selected Requisition Line?') then begin
                        Rec."Pending PO Qty" := 0;
                        Rec."Pending PO" := false;
                        Rec.Modify;
                        Message('Selected Requisition Line has been short closed successfully');
                    end;
                    //5.51
                end;
            }
        }
    }
    trigger OnQueryClosePage(CloseAction: action): Boolean
    begin
        if CloseAction = Action::LookupOK then LookupOKOnPush;
    end;

    var
        PurchOrderLine: Record "Purchase Line";
        ReserveReqLine: Codeunit "Req. Line-Reserve";
        DimMgt: Codeunit DimensionManagement;
        PurchasingCode: Record Purchasing;
        TransferExtendedText: Codeunit "Transfer Extended Text";
        NextLineNo: Integer;
        GPurchaseHeader: Record "Purchase Header";
        Text001: label 'Requested Qty. cannot be more than %1';
        Text002: label 'Pending PO Qty cannot be less than 0 for Indent No. %1 Line No %2';
        Text006: label '%1 on sales order %2 is already associated with purchase order %3.';
        Text007: label 'Already Received is done against Doc No. %1\  Line No %2\  Item No %3';
        UserMgt: Codeunit "SSD User Setup Management";

    local procedure InsertPurchOrderLine(var RecReqLine: Record "Requisition Line"; var RecPurchHeader: Record "Purchase Header")
    var
        AddOnIntegrMgt: Codeunit AddOnIntegrManagement;
        PurchOrderLine2: Record "Purchase Line";
        PostedIndentLineLocal: Record "SSD Posted Indent Line";
        PostedReqPurchLinesLocal: Record "SSD Posted Req. Purch. Line";
        LastLineNo: Integer;
    begin
        //with RecReqLine do begin
        if (RecReqLine."No." = '') or (RecReqLine.Quantity = 0) or (RecReqLine."Requested PO Qty" = 0) or (RecReqLine."Created PO Doc. type" <> RecReqLine."created po doc. type"::Order) then exit;
        //TESTFIELD("Vendor No.",RecPurchHeader."Buy-from Vendor No.");
        RecReqLine.TestField("Currency Code", RecPurchHeader."Currency Code");
        PurchOrderLine2.Reset;
        PurchOrderLine2.SetRange("Document Type", RecPurchHeader."Document Type");
        PurchOrderLine2.SetRange("Document No.", RecPurchHeader."No.");
        if PurchOrderLine2.Find('+') then NextLineNo := PurchOrderLine2."Line No.";
        PurchOrderLine.Init;
        PurchOrderLine.BlockDynamicTracking(true);
        PurchOrderLine."Document Type" := RecPurchHeader."Document Type";
        PurchOrderLine."Document No." := RecPurchHeader."No.";
        PurchOrderLine."Buy-from Vendor No." := RecReqLine."Vendor No.";
        PurchOrderLine."Line No." := NextLineNo + 10000;
        PurchOrderLine."Responsibility Center" := RecPurchHeader."Responsibility Center";
        PurchOrderLine.Validate(Type, GetPurchaseLineType(RecReqLine.Type));
        PurchOrderLine.Validate("No.", RecReqLine."No.");
        PurchOrderLine."Variant Code" := RecReqLine."Variant Code";
        PurchOrderLine.Validate("Unit of Measure Code", RecReqLine."Unit of Measure Code");
        PurchOrderLine."Qty. per Unit of Measure" := RecReqLine."Qty. per Unit of Measure";
        PurchOrderLine."Prod. Order No." := RecReqLine."Prod. Order No.";
        PurchOrderLine."Prod. Order Line No." := RecReqLine."Prod. Order Line No.";
        PurchOrderLine.Subcontracting := RecReqLine."Prod. Order No." <> '';
        PurchOrderLine."Shortcut Dimension 1 Code" := RecPurchHeader."Shortcut Dimension 1 Code";
        PurchOrderLine."Shortcut Dimension 2 Code" := RecPurchHeader."Shortcut Dimension 2 Code";
        PurchOrderLine."Vendor Item No." := RecReqLine."Vendor Item No.";
        PurchOrderLine.Description := RecReqLine.Description;
        PurchOrderLine."Description 2" := RecReqLine."Description 2";
        PurchOrderLine."Description 3" := RecReqLine."Description 3";
        PurchOrderLine."Sales Order No." := RecReqLine."Sales Order No.";
        PurchOrderLine."Sales Order Line No." := RecReqLine."Sales Order Line No.";
        PurchOrderLine."Prod. Order No." := RecReqLine."Prod. Order No.";
        PurchOrderLine."Bin Code" := RecReqLine."Bin Code";
        PurchOrderLine."Item Category Code" := RecReqLine."Item Category Code";
        PurchOrderLine.Nonstock := RecReqLine.Nonstock;
        PurchOrderLine.Validate(Quantity, RecReqLine."Requested PO Qty");
        PurchOrderLine."Document Subtype" := RecPurchHeader."Document Subtype";
        PurchOrderLine.Validate("Planning Flexibility", RecReqLine."Planning Flexibility");
        PurchOrderLine.Validate("Purchasing Code", RecReqLine."Purchasing Code");
        PurchOrderLine."Posted Indent No." := RecReqLine."Indent No.";
        PurchOrderLine."Posted Indent Line No." := RecReqLine."Indent Line No.";
        PurchOrderLine."Location Code" := RecReqLine."Location Code"; //IG_DS
        PurchOrderLine.Insert(true);
        if RecPurchHeader."Prices Including VAT" then
            PurchOrderLine.Validate("Direct Unit Cost", RecReqLine."Direct Unit Cost" * (1 + PurchOrderLine."VAT %" / 100))
        else
            PurchOrderLine.Validate("Direct Unit Cost", RecReqLine."Direct Unit Cost");
        PurchOrderLine."Total Indent Qty" := PurchOrderLine."Total Indent Qty" + RecReqLine."Requested PO Qty";
        ///******** Insert Into Posted Indent Purch. Lines Tables *********
        LastLineNo := 0;
        PostedReqPurchLinesLocal.Reset;
        PostedReqPurchLinesLocal.SetRange("Posted Indent Document No.", RecReqLine."Indent No.");
        PostedReqPurchLinesLocal.SetRange("Posted Indent Line No.", RecReqLine."Indent Line No.");
        if PostedReqPurchLinesLocal.Find('+') then LastLineNo := PostedReqPurchLinesLocal."Line No.";
        PostedReqPurchLinesLocal.Init;
        PostedReqPurchLinesLocal."Posted Indent Document No." := RecReqLine."Indent No.";
        PostedReqPurchLinesLocal."Posted Indent Line No." := RecReqLine."Indent Line No.";
        PostedReqPurchLinesLocal."Line No." := LastLineNo + 1000;
        PostedReqPurchLinesLocal."Purch. Document Type" := PurchOrderLine."Document Type";
        PostedReqPurchLinesLocal."Purch. Document No." := PurchOrderLine."Document No.";
        PostedReqPurchLinesLocal."Purch. Document Line No." := PurchOrderLine."Line No.";
        PostedReqPurchLinesLocal."Requisition Qty" := RecReqLine."Requested PO Qty";
        PostedReqPurchLinesLocal."Due Date" := RecReqLine."Due Date";
        PostedReqPurchLinesLocal."Requisition Template Name" := RecReqLine."Worksheet Template Name";
        PostedReqPurchLinesLocal."Requisition Batch Name" := RecReqLine."Journal Batch Name";
        PostedReqPurchLinesLocal."Requisition Line No." := RecReqLine."Line No.";
        PostedReqPurchLinesLocal."Responsibility Center" := RecReqLine."Responsibility Center";
        PostedReqPurchLinesLocal.Insert;
        ///******** Modify Posted Indent Table with Purchase Information
        if (RecReqLine."Indent No." <> '') and (RecReqLine."Indent Line No." <> 0) then begin
            PostedIndentLineLocal.Reset;
            PostedIndentLineLocal.SetRange("Document No.", RecReqLine."Indent No.");
            PostedIndentLineLocal.SetRange("Line No.", RecReqLine."Indent Line No.");
            if PostedIndentLineLocal.Find('-') then
                repeat
                    case RecReqLine."Created PO Doc. type" of
                        RecReqLine."created po doc. type"::Order:
                            begin
                                PostedIndentLineLocal."Pending PO Qty" := PostedIndentLineLocal."Pending PO Qty" - RecReqLine."Requested PO Qty";
                                if PostedIndentLineLocal."Pending PO Qty" <= 0 then begin
                                    if PostedIndentLineLocal."Pending PO Qty" < 0 then Error(Text002, PostedIndentLineLocal."Document No.", PostedIndentLineLocal."Line No.");
                                    PostedIndentLineLocal."Pending PO Qty" := 0;
                                    PostedIndentLineLocal."Pending PO" := false;
                                end;
                            end;
                    end;
                    PostedIndentLineLocal."Created Doc. No." := RecPurchHeader."No.";
                    PostedIndentLineLocal."Created Doc. Line No." := PurchOrderLine."Line No.";
                    PostedIndentLineLocal.Modify;
                until PostedIndentLineLocal.Next = 0;
        end;
        if (RecReqLine."Due Date" <> 0D) and (PurchOrderLine."Expected Receipt Date" > RecReqLine."Due Date") then begin
            PurchOrderLine.Validate("Expected Receipt Date", RecReqLine."Due Date");
            PurchOrderLine."Requested Receipt Date" := PurchOrderLine."Planned Receipt Date";
        end;
        PurchOrderLine."Drop Shipment" := RecReqLine."Sales Order Line No." <> 0;
        if PurchasingCode.Get(RecReqLine."Purchasing Code") then
            if PurchasingCode."Special Order" then begin
                PurchOrderLine."Special Order Sales No." := RecReqLine."Sales Order No.";
                PurchOrderLine."Special Order Sales Line No." := RecReqLine."Sales Order Line No.";
                PurchOrderLine."Special Order" := true;
                PurchOrderLine."Drop Shipment" := false;
                PurchOrderLine."Sales Order No." := '';
                PurchOrderLine."Sales Order Line No." := 0;
                PurchOrderLine."Special Order" := true;
            end;
        AddOnIntegrMgt.TransferFromReqLineToPurchLine(PurchOrderLine, RecReqLine);
        if RecReqLine.Type = RecReqLine.Type::Item then begin
            ReserveReqLine.TransferReqLineToPurchLine(RecReqLine, PurchOrderLine, RecReqLine."Quantity (Base)", false);
            PurchOrderLine.Modify;
            if PurchOrderLine.Subcontracting then begin
                InsertSubComponentsDetails(PurchOrderLine, RecReqLine."Requested PO Qty");
                UpdateProdOrderline(RecReqLine, RecPurchHeader);
            end;
            if RecReqLine.Reserve then ReserveBindingOrderToPurch(PurchOrderLine, RecReqLine);
            if RecReqLine."Prod. Order No." <> '' then RecPurchHeader.Subcontracting := true;
        end;
        RecPurchHeader.Modify;
        if TransferExtendedText.PurchCheckIfAnyExtText(PurchOrderLine, true) then begin
            TransferExtendedText.InsertPurchExtText(PurchOrderLine);
            // PurchOrderLine2.Reset;
            // PurchOrderLine2.SetRange("Document Type", RecPurchHeader."Document Type");
            // PurchOrderLine2.SetRange("Document No.", RecPurchHeader."No.");
            // if PurchOrderLine2.Find('+') then
            //     NextLineNo := PurchOrderLine2."Line No.";
        end;
        //***** Modify Current Record
        RecReqLine."Pending PO Qty" := RecReqLine."Pending PO Qty" - RecReqLine."Requested PO Qty";
        if RecReqLine."Pending PO Qty" <= 0 then begin
            RecReqLine."Pending PO Qty" := 0;
            RecReqLine."Pending PO" := false;
        end;
        RecReqLine."Requested PO Qty" := 0;
        RecReqLine.Modify;
    end;
    //end;
    procedure InsertSubComponentsDetails(RecPurchLine: Record "Purchase Line"; RecRequestedQty: Decimal)
    var
        SubOrderComponents: Record "Sub Order Component List";
        NextLineNo: Decimal;
        Item: Record Item;
        ProdOrderComponent: Record "Prod. Order Component";
        Vendor: Record Vendor;
        SubOrderCompListVend: Record "Sub Order Comp. List Vend";
    begin
        //For Subcontracting Order Components at Company Location
        ProdOrderComponent.SetRange(Status, ProdOrderComponent.Status::Released);
        ProdOrderComponent.SetFilter("Prod. Order No.", RecPurchLine."Prod. Order No.");
        ProdOrderComponent.SetRange(ProdOrderComponent."Prod. Order Line No.", RecPurchLine."Prod. Order Line No.");
        if ProdOrderComponent.Find('-') then
            repeat
                SubOrderComponents.Init;
                SubOrderComponents."Document No." := RecPurchLine."Document No.";
                SubOrderComponents."Document Line No." := RecPurchLine."Line No.";
                SubOrderComponents."Production Order No." := RecPurchLine."Prod. Order No.";
                SubOrderComponents."Production Order Line No." := RecPurchLine."Prod. Order Line No.";
                SubOrderComponents."Line No." := ProdOrderComponent."Line No.";
                SubOrderComponents."Parent Item No." := RecPurchLine."No.";
                SubOrderComponents.Insert;
                SubOrderComponents."Item No." := ProdOrderComponent."Item No.";
                SubOrderComponents."Unit of Measure Code" := ProdOrderComponent."Unit of Measure Code";
                SubOrderComponents.Description := ProdOrderComponent.Description;
                SubOrderComponents."Quantity per" := ProdOrderComponent."Quantity per";
                SubOrderComponents."Quantity To Send" := RecRequestedQty;
                SubOrderComponents."Quantity (Base)" := RecRequestedQty;
                SubOrderComponents."Quantity To Send (Base)" := RecRequestedQty;
                SubOrderComponents.Description := ProdOrderComponent.Description;
                SubOrderComponents.Validate("Scrap %", ProdOrderComponent."Scrap %");
                SubOrderComponents."Variant Code" := ProdOrderComponent."Variant Code";
                Item.Get(SubOrderComponents."Parent Item No.");
                SubOrderComponents."Company Location" := Item."Sub. Comp. Location";
                SubOrderComponents."Gen. Prod. Posting Group" := Item."Gen. Prod. Posting Group";
                Vendor.Get(RecPurchLine."Buy-from Vendor No.");
                Vendor.TestField(Vendor."Vendor Location");
                SubOrderComponents."Vendor Location" := Vendor."Vendor Location";
                SubOrderComponents.Modify;
            until ProdOrderComponent.Next = 0;
        //for Vendor Location
        ProdOrderComponent.Reset;
        ProdOrderComponent.SetRange(Status, ProdOrderComponent.Status::Released);
        ProdOrderComponent.SetFilter("Prod. Order No.", RecPurchLine."Prod. Order No.");
        ProdOrderComponent.SetRange(ProdOrderComponent."Prod. Order Line No.", RecPurchLine."Prod. Order Line No.");
        if ProdOrderComponent.Find('-') then
            repeat
                SubOrderCompListVend.Init;
                SubOrderCompListVend."Document No." := RecPurchLine."Document No.";
                SubOrderCompListVend."Document Line No." := RecPurchLine."Line No.";
                SubOrderCompListVend."Production Order No." := RecPurchLine."Prod. Order No.";
                SubOrderCompListVend."Production Order Line No." := RecPurchLine."Prod. Order Line No.";
                SubOrderCompListVend."Line No." := ProdOrderComponent."Line No.";
                SubOrderCompListVend."Parent Item No." := RecPurchLine."No.";
                SubOrderCompListVend.Insert;
                SubOrderCompListVend."Item No." := ProdOrderComponent."Item No.";
                SubOrderCompListVend."Unit of Measure" := ProdOrderComponent."Unit of Measure Code";
                SubOrderCompListVend.Description := ProdOrderComponent.Description;
                SubOrderCompListVend."Quantity per" := ProdOrderComponent."Quantity per";
                SubOrderCompListVend."Quantity (Base)" := RecRequestedQty;
                SubOrderCompListVend."Qty. to Receive" := RecRequestedQty;
                SubOrderCompListVend.Description := ProdOrderComponent.Description;
                SubOrderCompListVend.Validate("Scrap %", ProdOrderComponent."Scrap %");
                SubOrderCompListVend."Variant Code" := ProdOrderComponent."Variant Code";
                Item.Get(SubOrderCompListVend."Parent Item No.");
                SubOrderCompListVend."Company Location" := Item."Sub. Comp. Location";
                SubOrderCompListVend."Gen. Prod. Posting Group" := Item."Gen. Prod. Posting Group";
                Vendor.Get(RecPurchLine."Buy-from Vendor No.");
                Vendor.TestField(Vendor."Vendor Location");
                SubOrderCompListVend."Vendor Location" := Vendor."Vendor Location";
                SubOrderCompListVend.Modify;
            until ProdOrderComponent.Next = 0;
        RecPurchLine.Modify;
    end;

    procedure UpdateProdOrderline(RecReqLine: Record "Requisition Line"; RecPurchaseHeader: Record "Purchase Header")
    var
        ProdOrderLine: Record "Prod. Order Line";
    begin
        ProdOrderLine.Reset;
        ProdOrderLine.SetRange(ProdOrderLine.Status, ProdOrderLine.Status::Released);
        ProdOrderLine.SetFilter(ProdOrderLine."Prod. Order No.", RecReqLine."Prod. Order No.");
        ProdOrderLine.SetRange(ProdOrderLine."Line No.", RecReqLine."Prod. Order Line No.");
        ProdOrderLine.Find('-');
        ProdOrderLine."Subcontracting Order No." := RecPurchaseHeader."No.";
        ProdOrderLine."Subcontractor Code" := RecPurchaseHeader."Buy-from Vendor No.";
        ProdOrderLine.Modify;
    end;

    procedure ReserveBindingOrderToPurch(var PurchLine: Record "Purchase Line"; var ReqLine: Record "Requisition Line")
    var
        ProdOrderComp: Record "Prod. Order Component";
        SalesLine: Record "Sales Line";
        ReservEntry: Record "Reservation Entry";
        ReserveProdOrderComp: Codeunit "Prod. Order Comp.-Reserve";
        ReserveSalesLine: Codeunit "Sales Line-Reserve";
        ReservMgt: Codeunit "Reservation Management";
        ReservQty: Decimal;
    begin
        Clear(ReservMgt);
        PurchLine.CalcFields("Reserved Qty. (Base)");
        if (PurchLine."Quantity (Base)" - PurchLine."Reserved Qty. (Base)") > ReqLine."Demand Quantity (Base)" then
            ReservQty := ReqLine."Demand Quantity (Base)"
        else
            ReservQty := PurchLine."Quantity (Base)" - PurchLine."Reserved Qty. (Base)";
    end;

    procedure SetPurchaseHeader(var RecPurchaseHeader: Record "Purchase Header")
    begin
        GPurchaseHeader := RecPurchaseHeader;
    end;

    local procedure LookupOKOnPush()
    var
        RequisitionLineLocal: Record "Requisition Line";
    begin
        GPurchaseHeader.TestField("Document Type", GPurchaseHeader."document type"::Order);
        GPurchaseHeader.TestField("Buy-from Vendor No.");
        CurrPage.SetSelectionFilter(RequisitionLineLocal);
        if RequisitionLineLocal.FindSet() then
            repeat
                RequisitionLineLocal.TestField("Pending PO", true);
                if RequisitionLineLocal."Pending PO Qty" <> 0 then begin
                    if (RequisitionLineLocal."Pending PO" = true) and (RequisitionLineLocal."Pending PO Qty" <> 0) and (RequisitionLineLocal."Requested PO Qty" > RequisitionLineLocal."Pending PO Qty") then Error(Text001, RequisitionLineLocal."Pending PO Qty");
                    InsertPurchOrderLine(RequisitionLineLocal, GPurchaseHeader);
                end;
            until RequisitionLineLocal.Next = 0;
        GPurchaseHeader."Order Created from Indent" := true;
        GPurchaseHeader."Requested Receipt Date" := RequisitionLineLocal."Due Date"; //ALLE
        GPurchaseHeader.Modify;
    end;

    local procedure GetPurchaseLineType(ReqLineType: Enum "Requisition Line Type") PurchLineType: Enum "Purchase Line Type"
    begin
        case ReqLineType of
            ReqLineType::" ":
                PurchLineType := PurchLineType::" ";
            ReqLineType::"G/L Account":
                PurchLineType := PurchLineType::"G/L Account";
            ReqLineType::Item:
                PurchLineType := PurchLineType::Item;
            ReqLineType::"SSD Charge (Item)":
                PurchLineType := PurchLineType::"Charge (Item)";
            ReqLineType::"SSD Fixed Asset":
                PurchLineType := PurchLineType::"Fixed Asset";
            ReqLineType::"SSD Resource":
                PurchLineType := PurchLineType::Resource;
        end;
    end;
}
