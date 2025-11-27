Page 50011 "Posted Req. Purch. Lines"
{
    ApplicationArea = All;
    InsertAllowed = false;
    PageType = List;
    SourceTable = "SSD Posted Req. Purch. Line";
    UsageCategory = Tasks;

    layout
    {
        area(content)
        {
            repeater(Control1000000000)
            {
                field("Posted Indent Document No."; Rec."Posted Indent Document No.")
                {
                    ApplicationArea = All;
                }
                field("Posted Indent Line No."; Rec."Posted Indent Line No.")
                {
                    ApplicationArea = All;
                }
                field("Due Date"; Rec."Due Date")
                {
                    ApplicationArea = All;
                }
                field("Purch. Document Type"; Rec."Purch. Document Type")
                {
                    ApplicationArea = All;
                }
                field("Purch. Document No."; Rec."Purch. Document No.")
                {
                    ApplicationArea = All;
                }
                field("Purch. Document Line No."; Rec."Purch. Document Line No.")
                {
                    ApplicationArea = All;
                }
                field("Requisition Qty"; Rec."Requisition Qty")
                {
                    ApplicationArea = All;
                }
                field("Requested Qty"; Rec."Requested Qty")
                {
                    ApplicationArea = All;
                    Editable = "Requested QtyEditable";
                    Visible = "Requested QtyVisible";

                    trigger OnValidate()
                    begin
                        RequestedQtyOnValidate;
                        RequestedQtyOnAfterValidate;
                    end;
                }
            }
        }
    }
    actions
    {
        area(navigation)
        {
            group("&Line")
            {
                Caption = '&Line';

                action("Show Document")
                {
                    ApplicationArea = All;
                    Caption = 'Show Document';
                    Image = View;
                    ShortCutKey = 'Shift+F7';

                    trigger OnAction()
                    var
                        PurchRcptHeaderLocal: Record "Purch. Rcpt. Header";
                        PurchaseHeaderLocal: Record "Purchase Header";
                    begin
                        case Rec."Purch. Document Type" of Rec."purch. document type"::Quote: begin
                            if PurchaseHeaderLocal.Get(PurchaseHeaderLocal."document type"::Quote, Rec."Purch. Document No.")then Page.Run(Page::"Purchase Quote", PurchaseHeaderLocal);
                        end;
                        Rec."purch. document type"::"Blanket Order": begin
                            if PurchaseHeaderLocal.Get(PurchaseHeaderLocal."document type"::"Blanket Order", Rec."Purch. Document No.")then Page.Run(Page::"Blanket Purchase Order", PurchaseHeaderLocal);
                        end;
                        Rec."purch. document type"::Order: begin
                            if PurchaseHeaderLocal.Get(PurchaseHeaderLocal."document type"::Order, Rec."Purch. Document No.")then begin
                                case PurchaseHeaderLocal."Document Subtype" of PurchaseHeaderLocal."document subtype"::Order: Page.Run(Page::"Purchase Order", PurchaseHeaderLocal);
                                PurchaseHeaderLocal."document subtype"::Schedule: Page.Run(Page::"Purchase Order", PurchaseHeaderLocal);
                                end;
                            end;
                        end;
                        Rec."purch. document type"::Receipt: begin
                            if PurchRcptHeaderLocal.Get(Rec."Purch. Document No.")then Page.Run(Page::"Posted Purchase Receipt", PurchRcptHeaderLocal);
                        end;
                        end;
                    end;
                }
            }
        }
        area(processing)
        {
            group("Function")
            {
                Caption = 'F&unctions';
                Visible = FunctionVisible;

                action("Change Indent Qty")
                {
                    ApplicationArea = All;
                    Caption = 'Change Indent Qty';
                    Visible = false;

                    trigger OnAction()
                    begin
                        if IsChangeIndentQty then begin
                            "Requested QtyEditable":=true;
                            "Requested QtyVisible":=true;
                        end;
                    end;
                }
            }
        }
    }
    trigger OnInit()
    begin
        "Requested QtyEditable":=true;
        FunctionVisible:=true;
        "Requested QtyVisible":=true;
    end;
    trigger OnOpenPage()
    begin
        OnActivateForm;
    end;
    var Text001: label '%1 cannot be more than %2';
    IsChangeIndentQty: Boolean;
    "Requested QtyVisible": Boolean;
    FunctionVisible: Boolean;
    "Requested QtyEditable": Boolean;
    procedure PermissionForChangeIndentQty()
    begin
        IsChangeIndentQty:=true;
    end;
    local procedure RequestedQtyOnAfterValidate()
    begin
        CurrPage.Update(false);
    end;
    local procedure RequestedQtyOnValidate()
    begin
        if Rec."Requested Qty" = 0 then exit;
        if Rec."Requested Qty" > Rec."Requisition Qty" then Error(Text001, Rec.FieldCaption("Requested Qty"), Rec."Requisition Qty");
        ///********** Posted Indent Lines ***********
        Rec.ModifyPostedReqLines(Rec, (Rec."Requisition Qty" - Rec."Requested Qty"));
        if Rec."Posted Indent Document No." <> '' then Rec.ModifyPostedIndentLines(Rec, (Rec."Requisition Qty" - Rec."Requested Qty"));
        Rec."Requisition Qty":=Rec."Requested Qty";
        Rec."Requested Qty":=0;
        Rec.Modify;
    end;
    local procedure OnActivateForm()
    begin
        if IsChangeIndentQty = false then begin
            "Requested QtyEditable":=false;
            "Requested QtyVisible":=false;
            FunctionVisible:=false;
        end
        else
        begin
            "Requested QtyEditable":=true;
            "Requested QtyVisible":=true;
            FunctionVisible:=true;
        end;
    end;
}
