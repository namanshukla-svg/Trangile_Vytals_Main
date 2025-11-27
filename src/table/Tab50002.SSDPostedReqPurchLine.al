Table 50002 "SSD Posted Req. Purch. Line"
{
    Caption = 'Posted Requisition Purchase Line';
    DrillDownPageID = "Posted Req. Purch. Lines";
    LookupPageID = "Posted Req. Purch. Lines";
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Posted Indent Document No."; Code[20])
        {
            Editable = false;
            TableRelation = "SSD Posted Indent Line"."Document No.";
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
            DataClassification = CustomerContent;
            Caption = 'Posted Indent Document No.';
        }
        field(2; "Posted Indent Line No."; Integer)
        {
            Editable = false;
            TableRelation = "SSD Posted Indent Line"."Line No.";
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
            DataClassification = CustomerContent;
            Caption = 'Posted Indent Line No.';
        }
        field(3; "Line No."; Integer)
        {
            Editable = false;
            DataClassification = CustomerContent;
            Caption = 'Line No.';
        }
        field(4; "Purch. Document Type"; Option)
        {
            Editable = false;
            OptionCaption = 'Quote,Order,Invoice,Credit Memo,Blanket Order,Return Order,Receipt';
            OptionMembers = Quote, "Order", Invoice, "Credit Memo", "Blanket Order", "Return Order", Receipt;
            DataClassification = CustomerContent;
            Caption = 'Purch. Document Type';
        }
        field(5; "Purch. Document No."; Code[20])
        {
            Editable = false;
            DataClassification = CustomerContent;
            Caption = 'Purch. Document No.';
        }
        field(6; "Purch. Document Line No."; Integer)
        {
            Editable = false;
            DataClassification = CustomerContent;
            Caption = 'Purch. Document Line No.';
        }
        field(7; "Requisition Qty"; Decimal)
        {
            Editable = false;
            DataClassification = CustomerContent;
            Caption = 'Requisition Qty';
        }
        field(8; "Due Date"; Date)
        {
            Editable = false;
            DataClassification = CustomerContent;
            Caption = 'Due Date';
        }
        field(9; "Requested Qty"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Requested Qty';
        }
        field(10; "Requisition Template Name"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Requisition Template Name';
        }
        field(11; "Requisition Batch Name"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Requisition Batch Name';
        }
        field(12; "Requisition Line No."; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Requisition Line No.';
        }
        field(20; "Responsibility Center"; Code[20])
        {
            TableRelation = "Responsibility Center";
            DataClassification = CustomerContent;
            Caption = 'Responsibility Center';
        }
    }
    keys
    {
        key(Key1; "Posted Indent Document No.", "Posted Indent Line No.", "Line No.")
        {
            Clustered = true;
        }
        key(Key2; "Purch. Document Type", "Purch. Document No.", "Purch. Document Line No.", "Due Date", "Line No.")
        {
            SumIndexFields = "Requisition Qty";
        }
        key(Key3; "Posted Indent Document No.", "Posted Indent Line No.", "Purch. Document Type")
        {
        }
    }
    fieldgroups
    {
    }
    trigger OnDelete()
    begin
    //SSD ModifyPostedReqLines(Rec, "Requisition Qty");
    //SSD if "Posted Indent Document No." <> '' then
    //SSD ModifyPostedIndentLines(Rec, "Requisition Qty");
    end;
    trigger OnInsert()
    begin
    //SSD if "Responsibility Center" = '' then
    //SSD UserMgt.GetRespCenterFilter;
    end;
    var Text001: label '%1 cannot be more than %2';
    //SSD UserMgt: Codeunit "SSD User Setup Management";
    procedure ModifyPostedIndentLines(RecPostedReqPurchLines: Record "SSD Posted Req. Purch. Line"; RecRequestedQty: Decimal)
    var
        PostedIndentLineLocal: Record "SSD Posted Indent Line";
    begin
        //IND St
        PostedIndentLineLocal.Reset;
        PostedIndentLineLocal.SetCurrentkey("Replenishment System", "Action Message", "Document No.", "Line No.");
        PostedIndentLineLocal.SetFilter("Replenishment System", '%1|%2', PostedIndentLineLocal."replenishment system"::Purchase, PostedIndentLineLocal."replenishment system"::"Prod. Order");
        PostedIndentLineLocal.SetRange("Action Message", PostedIndentLineLocal."action message"::"Change Qty.");
        PostedIndentLineLocal.SetRange("Document No.", RecPostedReqPurchLines."Posted Indent Document No.");
        PostedIndentLineLocal.SetRange("Line No.", RecPostedReqPurchLines."Posted Indent Line No.");
        if PostedIndentLineLocal.Find('-')then begin
            PostedIndentLineLocal."Pending PO Qty":=PostedIndentLineLocal."Pending PO Qty" + RecRequestedQty;
            if PostedIndentLineLocal."Pending PO Qty" >= PostedIndentLineLocal.Quantity then begin
                PostedIndentLineLocal."Pending PO Qty":=PostedIndentLineLocal.Quantity;
            end;
            if PostedIndentLineLocal."Pending PO Qty" <> 0 then begin
                PostedIndentLineLocal."Pending PO":=true;
                if PostedIndentLineLocal."Created Doc. SubType" = PostedIndentLineLocal."created doc. subtype"::"P.Order" then begin
                    PostedIndentLineLocal."Created Doc. No.":='';
                    PostedIndentLineLocal."Created Doc. Line No.":=0;
                end;
            end;
            PostedIndentLineLocal.Modify;
        end;
    //IND En
    end;
    procedure ModifyPostedReqLines(RecPostedReqPurchLines: Record "SSD Posted Req. Purch. Line"; RecRequestedQty: Decimal)
    var
        RequisitionLineLocal: Record "Requisition Line";
        PurchaseLineLocal: Record "Purchase Line";
        PurchaseHeaderLocal: Record "Purchase Header";
    begin
        //IND St
        RequisitionLineLocal.Reset;
        RequisitionLineLocal.SetCurrentkey("Worksheet Template Name", "Journal Batch Name", "Line No.");
        RequisitionLineLocal.SetRange("Worksheet Template Name", RecPostedReqPurchLines."Requisition Template Name");
        RequisitionLineLocal.SetRange("Journal Batch Name", RecPostedReqPurchLines."Requisition Batch Name");
        RequisitionLineLocal.SetRange("Line No.", RecPostedReqPurchLines."Requisition Line No.");
        RequisitionLineLocal.SetCurrentkey("Replenishment System", "Action Message", "Created PO Doc. type", Posted, "Due Date");
        RequisitionLineLocal.SetRange(Posted, true);
        RequisitionLineLocal.SetFilter("Replenishment System", '%1|%2', RequisitionLineLocal."replenishment system"::Purchase, RequisitionLineLocal."replenishment system"::"Prod. Order");
        RequisitionLineLocal.SetRange("Action Message", RequisitionLineLocal."action message"::"Change Qty.");
        if RequisitionLineLocal.Find('-')then begin
            RequisitionLineLocal."Pending PO Qty":=RequisitionLineLocal."Pending PO Qty" + RecRequestedQty;
            if RequisitionLineLocal."Pending PO Qty" >= RequisitionLineLocal.Quantity then begin
                RequisitionLineLocal."Pending PO Qty":=RequisitionLineLocal.Quantity;
            end;
            if RequisitionLineLocal."Pending PO Qty" <> 0 then begin
                RequisitionLineLocal."Pending PO":=true;
            end;
            RequisitionLineLocal.Modify;
            PurchaseLineLocal.Reset;
            PurchaseLineLocal.SetRange("Document Type", RecPostedReqPurchLines."Purch. Document Type");
            PurchaseLineLocal.SetRange("Document No.", RecPostedReqPurchLines."Purch. Document No.");
            PurchaseLineLocal.SetRange("Line No.", RecPostedReqPurchLines."Purch. Document Line No.");
            if PurchaseLineLocal.Find('-')then if PurchaseLineLocal.Subcontracting then begin
                    if RequisitionLineLocal."Pending PO Qty" = RequisitionLineLocal.Quantity then begin
                        DeleteSubComponentsDetails(PurchaseLineLocal, RecRequestedQty);
                        PurchaseHeaderLocal.Get(PurchaseLineLocal."Document Type", PurchaseLineLocal."Document No.");
                        UpdateProdOrderline(RequisitionLineLocal, PurchaseHeaderLocal);
                    end
                    else
                    begin
                        ModifySubComponentsDetails(PurchaseLineLocal, RecRequestedQty);
                    end;
                end;
        end;
    //IND En
    end;
    procedure ModifySubComponentsDetails(RecPurchLine: Record "Purchase Line"; RecRequestedQty: Decimal)
    var
        SubOrderComponents: Record "Sub Order Component List";
        NextLineNo: Decimal;
        Item: Record Item;
        ProdOrderComponent: Record "Prod. Order Component";
        Vendor: Record Vendor;
        SubOrderCompListVend: Record "Sub Order Comp. List Vend";
    begin
        //IND St
        //For Subcontracting Order Components at Company Location
        ProdOrderComponent.SetRange(Status, ProdOrderComponent.Status::Released);
        ProdOrderComponent.SetFilter("Prod. Order No.", RecPurchLine."Prod. Order No.");
        ProdOrderComponent.SetRange(ProdOrderComponent."Prod. Order Line No.", RecPurchLine."Prod. Order Line No.");
        if ProdOrderComponent.Find('-')then repeat SubOrderComponents.Reset;
                SubOrderComponents.SetRange("Document No.", RecPurchLine."Document No.");
                SubOrderComponents.SetRange("Document Line No.", RecPurchLine."Line No.");
                SubOrderComponents.SetRange("Parent Item No.", RecPurchLine."No.");
                SubOrderComponents.SetRange("Line No.", ProdOrderComponent."Line No.");
                if SubOrderComponents.Find('-')then begin
                    SubOrderComponents."Quantity To Send":=SubOrderComponents."Quantity To Send" - RecRequestedQty;
                    SubOrderComponents."Quantity (Base)":=SubOrderComponents."Quantity (Base)" - RecRequestedQty;
                    SubOrderComponents."Quantity To Send (Base)":=SubOrderComponents."Quantity To Send (Base)" - RecRequestedQty;
                    SubOrderComponents.Modify;
                end;
            until ProdOrderComponent.Next = 0;
        //for Vendor Location
        ProdOrderComponent.Reset;
        ProdOrderComponent.SetRange(Status, ProdOrderComponent.Status::Released);
        ProdOrderComponent.SetFilter("Prod. Order No.", RecPurchLine."Prod. Order No.");
        ProdOrderComponent.SetRange(ProdOrderComponent."Prod. Order Line No.", RecPurchLine."Prod. Order Line No.");
        if ProdOrderComponent.Find('-')then repeat SubOrderCompListVend.Reset;
                SubOrderCompListVend.SetRange("Document No.", RecPurchLine."Document No.");
                SubOrderCompListVend.SetRange("Document Line No.", RecPurchLine."Line No.");
                SubOrderCompListVend.SetRange("Parent Item No.", RecPurchLine."No.");
                SubOrderCompListVend.SetRange("Line No.", ProdOrderComponent."Line No.");
                if SubOrderCompListVend.Find('-')then begin
                    SubOrderCompListVend."Quantity (Base)":=SubOrderCompListVend."Quantity (Base)" - RecRequestedQty;
                    SubOrderCompListVend.Modify;
                end;
            until ProdOrderComponent.Next = 0;
        RecPurchLine.Modify;
    //IND En
    end;
    procedure UpdateProdOrderline(RecReqLine: Record "Requisition Line"; RecPurchaseHeader: Record "Purchase Header")
    var
        ProdOrderLine: Record "Prod. Order Line";
    begin
        //IND St
        ProdOrderLine.Reset;
        ProdOrderLine.SetRange(ProdOrderLine.Status, ProdOrderLine.Status::Released);
        ProdOrderLine.SetFilter(ProdOrderLine."Prod. Order No.", RecReqLine."Prod. Order No.");
        ProdOrderLine.SetRange(ProdOrderLine."Line No.", RecReqLine."Prod. Order Line No.");
        ProdOrderLine.Find('-');
        ProdOrderLine."Subcontracting Order No.":='';
        ProdOrderLine."Subcontractor Code":='';
        ProdOrderLine.Modify;
    //IND En
    end;
    procedure DeleteSubComponentsDetails(RecPurchLine: Record "Purchase Line"; RecRequestedQty: Decimal)
    var
        SubOrderComponents: Record "Sub Order Component List";
        NextLineNo: Decimal;
        Item: Record Item;
        ProdOrderComponent: Record "Prod. Order Component";
        Vendor: Record Vendor;
        SubOrderCompListVend: Record "Sub Order Comp. List Vend";
    begin
        //IND St
        //For Subcontracting Order Components at Company Location
        ProdOrderComponent.SetRange(Status, ProdOrderComponent.Status::Released);
        ProdOrderComponent.SetFilter("Prod. Order No.", RecPurchLine."Prod. Order No.");
        ProdOrderComponent.SetRange(ProdOrderComponent."Prod. Order Line No.", RecPurchLine."Prod. Order Line No.");
        if ProdOrderComponent.Find('-')then repeat SubOrderComponents.Reset;
                SubOrderComponents.SetRange("Document No.", RecPurchLine."Document No.");
                SubOrderComponents.SetRange("Document Line No.", RecPurchLine."Line No.");
                SubOrderComponents.SetRange("Parent Item No.", RecPurchLine."No.");
                SubOrderComponents.SetRange("Line No.", ProdOrderComponent."Line No.");
                SubOrderComponents.DeleteAll;
            until ProdOrderComponent.Next = 0;
        //for Vendor Location
        ProdOrderComponent.Reset;
        ProdOrderComponent.SetRange(Status, ProdOrderComponent.Status::Released);
        ProdOrderComponent.SetFilter("Prod. Order No.", RecPurchLine."Prod. Order No.");
        ProdOrderComponent.SetRange(ProdOrderComponent."Prod. Order Line No.", RecPurchLine."Prod. Order Line No.");
        if ProdOrderComponent.Find('-')then repeat SubOrderCompListVend.Reset;
                SubOrderCompListVend.SetRange("Document No.", RecPurchLine."Document No.");
                SubOrderCompListVend.SetRange("Document Line No.", RecPurchLine."Line No.");
                SubOrderCompListVend.SetRange("Parent Item No.", RecPurchLine."No.");
                SubOrderCompListVend.SetRange("Line No.", ProdOrderComponent."Line No.");
                SubOrderCompListVend.DeleteAll;
            until ProdOrderComponent.Next = 0;
        RecPurchLine.Modify;
    //IND En
    end;
}
