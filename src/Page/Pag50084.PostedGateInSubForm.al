Page 50084 "Posted Gate In SubForm"
{
    DelayedInsert = true;
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = ListPart;
    SourceTable = "SSD Posted Gate Line";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                field(Type; Rec.Type)
                {
                    ApplicationArea = All;
                }
                field("No. 2"; Rec."No. 2")
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
                field("Vendor Item Description"; Rec."Vendor Item Description")
                {
                    ToolTip = 'Specifies the value of the Vendor Item Description field.';
                    Editable = false;
                }
                field("Shortage Quantity"; ShortageQtyText)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Ref. Document No."; Rec."Ref. Document No.")
                {
                    ApplicationArea = All;
                }
                field("Expected Receipt Date"; Rec."Expected Receipt Date")
                {
                    ApplicationArea = All;
                }
                field("Total Quantity"; Rec."Total Quantity")
                {
                    ApplicationArea = All;
                    Editable = true;
                }
                field("Outstanding Quantity"; Rec."Outstanding Quantity")
                {
                    ApplicationArea = All;
                    Caption = 'Balance Quantity';
                    DecimalPlaces = 1: 4;
                    Editable = false;
                }
                field("Unit of Measure Code"; Rec."Unit of Measure Code")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Challan Quantity"; Rec."Challan Quantity")
                {
                    ApplicationArea = All;
                    DecimalPlaces = 1: 4;
                }
            }
        }
    }
    actions
    {
    }
    trigger OnAfterGetRecord()
    begin
        ShortageQtyText:=Format("ShortageQty.");
        ShortageQtyTextOnFormat(ShortageQtyText);
    end;
    var "ShortageQty.": Decimal;
    ShortageQtyText: Text[1024];
    local procedure ShortageQtyTextOnFormat(var Text: Text[1024])
    var
        PurchRcptHeader: Record "Purch. Rcpt. Header";
        PurchRcptLine: Record "Purch. Rcpt. Line";
        ShortageQty: Decimal;
    begin
        ShortageQty:=0;
        PurchRcptHeader.SetCurrentkey("Order No.");
        PurchRcptHeader.SetRange("Order No.", Rec."Ref. Document No.");
        if PurchRcptHeader.Find('-')then begin
            repeat if PurchRcptLine.Get(PurchRcptHeader."No.", Rec."Line No.")then begin
                    ShortageQty:=ShortageQty + PurchRcptLine."Challan Quantity" - PurchRcptLine.Quantity;
                end;
            until PurchRcptHeader.Next = 0;
        end;
        Text:=Format(ShortageQty);
    end;
}
