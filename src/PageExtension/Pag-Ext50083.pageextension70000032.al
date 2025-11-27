PageExtension 50083 pageextension70000032 extends "Purchase Order Subform"
{
    layout
    {
        //IG_DS
        modify("No.")
        {
            trigger OnAfterValidate()
            var
                Item: Record Item;
            begin
                if (Rec.Type = Rec.Type::Item) and (Rec."Document Type" = Rec."Document Type"::Order) then begin
                    Item.Get(Rec."No.");
                    if Item."Item Type" = Item."Item Type"::Indent then
                        Error(
                          'You cannot manually select an item with Type "Indent". ' +
                          'Please use the "Copy Requisition Lines" button if required.');
                end;
            end;
        }
        //IG_DS
        modify(Quantity)
        {
            trigger OnBeforeValidate()
            begin
                Rec.CalcFields("Indent No.", "Indent Line No.", "Total Indent Qty");
                IF (Rec."Indent No." <> '') AND (Rec."Indent Line No." <> 0) THEN
                    IF Rec.Quantity < Rec."Total Indent Qty" THEN BEGIN
                        ERROR(Text0001, Rec.FIELDCAPTION(Quantity), Rec.FIELDCAPTION("Total Indent Qty"), Rec."Total Indent Qty");
                    END;
            end;
        }
        modify("TDS Section Code")
        {
            Visible = false;
        }
        addafter("No.")
        {
            field("Gate Entry no."; Rec."Gate Entry no.")
            {
                ApplicationArea = All;
            }
            field("Gate Entry Date"; Rec."Gate Entry Date")
            {
                ApplicationArea = All;
            }
        }
        addafter(Description)
        {
            field("Description 3"; Rec."Description 3")
            {
                ApplicationArea = All;

                trigger OnValidate()
                begin
                    Rec.TestStatusOpen();
                end;
            }
            field("Vendor Item Description"; Rec."Vendor Item Description")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Vendor Item Description field.';
                Editable = false;
            }
        }
        addafter(Quantity)
        {
            field("Price Match/Mismatch"; Rec."Price Match/Mismatch")
            {
                ApplicationArea = All;
                Editable = false;
            }
            field("MRP Qty."; Rec."MRP Qty.")
            {
                ApplicationArea = All;
            }
        }
        addafter("Quantity Invoiced")
        {
            field("Short Closed"; Rec."Short Closed")
            {
                ApplicationArea = All;
                Editable = false;
            }
            field("Short Closed Qty"; Rec."Short Closed Qty")
            {
                ApplicationArea = All;
                Editable = false;
            }
            field("Outstanding Quantity"; Rec."Outstanding Quantity")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies how many units on the order line have not yet been received.';
            }
            field("Last PO Price"; Rec."Last PO Price")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Last PO Price field.';
                Editable = false;
            }
            field("Last Landed Cost"; Rec."Last Landed Cost")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Last Landed Cost field.';
                Editable = false;
            }
        }
        addafter("Qty. Assigned")
        {
            field("Assessable Value GST"; Rec."Assessable Value GST")
            {
                ApplicationArea = All;
            }
            field("Assessable Value GST LCY"; Rec."Assessable Value GST LCY")
            {
                ApplicationArea = All;
            }
            field("Custom Duty Amount LCY"; Rec."Custom Duty Amount LCY")
            {
                ApplicationArea = All;
            }
        }
        addafter("Planned Receipt Date")
        {
            // field("Gen. Prod. Posting Group"; Rec."Gen. Prod. Posting Group")
            // {
            //     ApplicationArea = All;
            //     Visible = false;
            // }
        }
        addafter("Shortcut Dimension 2 Code")
        {
            field("Budgeted Cost Amount"; Rec."Budgeted Cost Amount")
            {
                ApplicationArea = All;
                Editable = false;
            }
        }
        addafter(Control19)
        {
            field("Customer No."; Rec."Customer No.")
            {
                ApplicationArea = All;
            }
            field("SalesPerson Code"; Rec."SalesPerson Code")
            {
                ApplicationArea = All;
            }
        }
        modify("Description 2")
        {
            Visible = true;
            Enabled = IsNotServiceLine;

            trigger OnBeforeValidate()
            begin
                Rec.TestStatusOpen();
            end;
        }
        modify(Description)
        {
            Enabled = false;

            trigger OnBeforeValidate()
            begin
                Rec.TestStatusOpen();
            end;
        }
    }
    actions
    {
        addafter("Insert Ext. Texts")
        {
            action("Get Inde&nt Lines")
            {
                ApplicationArea = All;
                Caption = 'Get Inde&nt Lines';
                Visible = false;

                trigger OnAction()
                begin
                    GetIndent;
                end;
            }
        }
        addafter(OrderTracking)
        {
            action("Short Close")
            {
                ApplicationArea = All;
                Caption = 'Short Close';

                trigger OnAction()
                begin
                    UserSetup.Get(UserId);
                    if UserSetup."Short Close" = true then begin
                        if Confirm('Are you sure, you want to short close the selected Purchase Line?') then begin
                            ShortClose;
                            Message('Selected Purchase Line has been short closed successfully');
                        end;
                    end
                    else
                        Message('NOT ALLOWED');
                end;
            }
        }
    }
    var
        PostedIndentLine: Record "SSD Posted Indent Line";
        UserSetup: Record "User Setup";
        GetIndents: Page "Get Indent Lines";
        Text0001: label '%1 cannot be less than %2   %3';
        Text002: label 'Type cannot be Item';
        Text003: label 'Item cannot be changed';
        IsNotServiceLine: Boolean;

    trigger OnAfterGetCurrRecord()
    begin
        SetFieldEditable();
    end;

    trigger OnDeleteRecord(): Boolean
    begin
        Rec.CalcFields("Total Indent Qty");
        ModifyPostedReqPurchLine(Rec, Rec."Total Indent Qty");
    end;

    local procedure SetFieldEditable()
    var
        Item: Record Item;
    begin
        IsNotServiceLine := false;
        if (Rec.Type = Rec.Type::Item) and (Rec."No." <> '') then begin
            Item.Get(Rec."No.");
            if Item.Type <> Item.Type::Service then IsNotServiceLine := true;
        end;
        if Rec.Type = Rec.Type::" " then IsNotServiceLine := true;
    end;

    procedure ModifyPostedReqPurchLine(var RecPurchaseLine: Record "Purchase Line"; TotalIndentQty: Decimal)
    var
        PostedReqPurchLinesLocal: Record "SSD Posted Req. Purch. Line";
    begin
        //IND St
        if TotalIndentQty = 0 then exit;
        PostedReqPurchLinesLocal.Reset;
        PostedReqPurchLinesLocal.SetCurrentkey("Purch. Document Type", "Purch. Document No.", "Purch. Document Line No.", "Due Date", "Line No.");
        PostedReqPurchLinesLocal.SetRange("Purch. Document Type", RecPurchaseLine."Document Type");
        PostedReqPurchLinesLocal.SetRange("Purch. Document No.", RecPurchaseLine."Document No.");
        PostedReqPurchLinesLocal.SetRange("Purch. Document Line No.", RecPurchaseLine."Line No.");
        if PostedReqPurchLinesLocal.Find('+') then
            repeat
                PostedReqPurchLinesLocal.ModifyPostedReqLines(PostedReqPurchLinesLocal, PostedReqPurchLinesLocal."Requisition Qty");
                if PostedReqPurchLinesLocal."Posted Indent Document No." <> '' then PostedReqPurchLinesLocal.ModifyPostedIndentLines(PostedReqPurchLinesLocal, PostedReqPurchLinesLocal."Requisition Qty");
            until (PostedReqPurchLinesLocal.Next(-1) = 0) or (TotalIndentQty = 0);
        PostedReqPurchLinesLocal.Reset;
        PostedReqPurchLinesLocal.SetCurrentkey("Purch. Document Type", "Purch. Document No.", "Purch. Document Line No.", "Due Date", "Line No.");
        PostedReqPurchLinesLocal.SetRange("Purch. Document Type", RecPurchaseLine."Document Type");
        PostedReqPurchLinesLocal.SetRange("Purch. Document No.", RecPurchaseLine."Document No.");
        PostedReqPurchLinesLocal.SetRange("Purch. Document Line No.", RecPurchaseLine."Line No.");
        if PostedReqPurchLinesLocal.Find('-') then
            repeat
                PostedReqPurchLinesLocal.Delete;
            until PostedReqPurchLinesLocal.Next = 0;
        //IND En
    end;

    procedure ShowRequisitionLinesForm()
    var
        FrmPostedReqPurchLines: Page "Posted Req. Purch. Lines";
        PostedReqPurchLinesLocal: Record "SSD Posted Req. Purch. Line";
    begin
        //IND St
        Clear(FrmPostedReqPurchLines);
        PostedReqPurchLinesLocal.Reset;
        PostedReqPurchLinesLocal.SetCurrentkey("Purch. Document Type", "Purch. Document No.", "Purch. Document Line No.", "Due Date");
        PostedReqPurchLinesLocal.FilterGroup(2);
        PostedReqPurchLinesLocal.SetRange("Purch. Document Type", Rec."Document Type");
        PostedReqPurchLinesLocal.SetRange("Purch. Document No.", Rec."Document No.");
        PostedReqPurchLinesLocal.SetRange("Purch. Document Line No.", Rec."Line No.");
        PostedReqPurchLinesLocal.FilterGroup(0);
        if PostedReqPurchLinesLocal.Find('-') then begin
            FrmPostedReqPurchLines.LookupMode := true;
            FrmPostedReqPurchLines.PermissionForChangeIndentQty;
            FrmPostedReqPurchLines.SetTableview(PostedReqPurchLinesLocal);
            FrmPostedReqPurchLines.RunModal;
        end;
        //IND En
    end;

    procedure GetIndent()
    begin
        //CF_SC_001
        Codeunit.Run(Codeunit::"Get Indent Lines", Rec);
    end;

    procedure ShortClose()
    begin
        if ((Rec."Outstanding Quantity" <> 0) or (Rec."Outstanding Quantity" = 0)) then begin //Alle_070319
            //  IF ("Outstanding Quantity" <> 0) THEN BEGIN//Alle_070319
            if Rec.FindSet then
                repeat
                    Rec."Short Closed Qty" := Rec."Outstanding Quantity";
                    Rec."Outstanding Quantity" := 0;
                    Rec."Outstanding Qty. (Base)" := 0;
                    Rec."Short Closed" := true;
                    Rec.Modify; //Alle_070319
                until Rec.Next = 0;
        end;
    end;
}
