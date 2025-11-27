Page 50241 "Posted Purchase Rcpt.Subform11"
{
    // CML-038 - Changes related to "Creation of RG Entry in bt Item Receipt and Invoice".
    AutoSplitKey = true;
    Caption = 'Posted Purchase Rcpt. Subform';
    DeleteAllowed = false;
    Editable = true;
    InsertAllowed = false;
    PageType = ListPart;
    Permissions = TableData "Purch. Rcpt. Header"=rimd,
        TableData "Purch. Rcpt. Line"=rimd;
    SourceTable = "Purch. Rcpt. Line";
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
                    Editable = false;
                }
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Quantity; Rec.Quantity)
                {
                    ApplicationArea = All;
                }
                field("Direct Unit Cost"; Rec."Direct Unit Cost")
                {
                    ApplicationArea = All;
                }
                field("Pre Assign MRN No."; Rec."Pre Assign MRN No.")
                {
                    ApplicationArea = All;
                }
                field("Location Code"; Rec."Location Code")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Bin Code"; Rec."Bin Code")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Visible = false;
                }
                field("Unit of Measure Code"; Rec."Unit of Measure Code")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Qty. Rcd. Not Invoiced"; Rec."Qty. Rcd. Not Invoiced")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Visible = false;
                }
                field("Gate Entry no."; Rec."Gate Entry no.")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
    actions
    {
    }
    var PruchRcptLine1: Record "Purch. Rcpt. Line";
    PruchRcptHeader: Record "Purch. Rcpt. Header";
    ReturnShptHeader: Record "Return Shipment Header";
    procedure ShowTracking()
    var
        ItemLedgEntry: Record "Item Ledger Entry";
        TempItemLedgEntry: Record "Item Ledger Entry" temporary;
        TrackingForm: Page "Order Tracking";
    begin
        Rec.TestField(Type, Rec.Type::Item);
        if Rec."Item Rcpt. Entry No." <> 0 then begin
            ItemLedgEntry.Get(Rec."Item Rcpt. Entry No.");
            TrackingForm.SetItemLedgEntry(ItemLedgEntry);
        end
        else
            TrackingForm.SetMultipleItemLedgEntries(TempItemLedgEntry, Database::"Purch. Rcpt. Line", 0, Rec."Document No.", '', 0, Rec."Line No.");
        TrackingForm.RunModal;
    end;
    procedure ShowDimensions()
    begin
        Rec.ShowDimensions;
    end;
    procedure ShowItemTrackingLines()
    begin
        Rec.ShowItemTrackingLines;
    end;
    procedure UndoReceiptLine()
    var
        PurchRcptLine: Record "Purch. Rcpt. Line";
    begin
        PurchRcptLine.Copy(Rec);
        CurrPage.SetSelectionFilter(PurchRcptLine);
        Codeunit.Run(Codeunit::"Undo Purchase Receipt Line", PurchRcptLine);
    end;
}
