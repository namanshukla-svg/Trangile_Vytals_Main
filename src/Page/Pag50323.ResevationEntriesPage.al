Page 50323 "Resevation Entries Page"
{
    ApplicationArea = All;
    UsageCategory = Administration;
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = "Reservation Entry";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Item No."; Rec."Item No.")
                {
                    ApplicationArea = All;
                }
                field("Location Code"; Rec."Location Code")
                {
                    ApplicationArea = All;
                }
                field("Quantity (Base)"; Rec."Quantity (Base)")
                {
                    ApplicationArea = All;
                }
                field("Source ID"; Rec."Source ID")
                {
                    ApplicationArea = All;
                }
                field("Source Ref. No."; Rec."Source Ref. No.")
                {
                    ApplicationArea = All;
                }
                field("MRN No."; Rec."MRN No.")
                {
                    ApplicationArea = All;
                }
                field("MRN Line No."; Rec."MRN Line No.")
                {
                    ApplicationArea = All;
                }
                field("Action Message Adjustment"; Rec."Action Message Adjustment")
                {
                    ToolTip = 'Specifies the value of the Action Message Adjustment field.';
                }
                field("Appl.-from Item Entry"; Rec."Appl.-from Item Entry")
                {
                    ToolTip = 'Specifies the value of the Appl.-from Item Entry field.';
                }
                field("Appl.-to Item Entry"; Rec."Appl.-to Item Entry")
                {
                    ToolTip = 'Specifies the value of the Appl.-to Item Entry field.';
                }
                field("Bin Code"; Rec."Bin Code")
                {
                    ToolTip = 'Specifies the value of the Bin Code field.';
                }
                field(Binding; Rec.Binding)
                {
                    ToolTip = 'Specifies the value of the Binding field.';
                }
                field("Changed By"; Rec."Changed By")
                {
                    ToolTip = 'Specifies the value of the Changed By field.';
                }
                field("Copy Made For FG item Of PL"; Rec."Copy Made For FG item Of PL")
                {
                    ToolTip = 'Specifies the value of the Copy Made For FG item Of PL field.';
                }
                field(Correction; Rec.Correction)
                {
                    ToolTip = 'Specifies the value of the Correction field.';
                }
                field("Created By"; Rec."Created By")
                {
                    ToolTip = 'Specifies the user who created the traced record.';
                }
                field("Creation Date"; Rec."Creation Date")
                {
                    ToolTip = 'Specifies when the traced record was created.';
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies a description of the record.';
                }
                field("Disallow Cancellation"; Rec."Disallow Cancellation")
                {
                    ToolTip = 'Specifies the value of the Disallow Cancellation field.';
                }
                field("Entry No."; Rec."Entry No.")
                {
                    ToolTip = 'Specifies the number that is assigned to the entry.';
                }
                field("Expected Receipt Date"; Rec."Expected Receipt Date")
                {
                    ToolTip = 'Specifies the date on which the reserved items are expected to enter inventory.';
                }
                field("Expiration Date"; Rec."Expiration Date")
                {
                    ToolTip = 'Specifies the expiration date of the lot or serial number on the item tracking line.';
                }
                field("Item Ledger Entry No."; Rec."Item Ledger Entry No.")
                {
                    ToolTip = 'Specifies the value of the Item Ledger Entry No. field.';
                }
                field("Item Tracking"; Rec."Item Tracking")
                {
                    ToolTip = 'Specifies the value of the Item Tracking field.';
                }
                field("Lot No."; Rec."Lot No.")
                {
                    ToolTip = 'Specifies the lot number of the item that is being handled with the associated document line.';
                }
                field("Manufacturing date"; Rec."Manufacturing date")
                {
                    ToolTip = 'Specifies the value of the Manufacturing date field.';
                }
                field("New Expiration Date"; Rec."New Expiration Date")
                {
                    ToolTip = 'Specifies the value of the New Expiration Date field.';
                }
                field("New Lot No."; Rec."New Lot No.")
                {
                    ToolTip = 'Specifies the value of the New Lot No. field.';
                }
                field("New Package No."; Rec."New Package No.")
                {
                    ToolTip = 'Specifies the value of the New Package No. field.';
                }
                field("New Serial No."; Rec."New Serial No.")
                {
                    ToolTip = 'Specifies the value of the New Serial No. field.';
                }
                field("No. of Container"; Rec."No. of Container")
                {
                    ToolTip = 'Specifies the value of the No. of Container field.';
                }
                field("Pack Quantity"; Rec."Pack Quantity")
                {
                    ToolTip = 'Specifies the value of the Pack Quantity field.';
                }
                field("Package No."; Rec."Package No.")
                {
                    ToolTip = 'Specifies the package number of the item that is being handled with the associated document line.';
                }
                field("Planning Flexibility"; Rec."Planning Flexibility")
                {
                    ToolTip = 'Specifies the value of the Planning Flexibility field.';
                }
                field(Positive; Rec.Positive)
                {
                    ToolTip = 'Specifies that the difference is positive.';
                }
                field("QR Scanned"; Rec."QR Scanned")
                {
                    ToolTip = 'Specifies the value of the QR Scanned field.';
                }
                field("Qty. per Unit of Measure"; Rec."Qty. per Unit of Measure")
                {
                    ToolTip = 'Specifies how many of the base unit of measure are contained in one unit of the item.';
                }
                field("Qty. to Handle (Base)"; Rec."Qty. to Handle (Base)")
                {
                    ToolTip = 'Specifies the quantity of item, in the base unit of measure, to be handled in a warehouse activity.';
                }
                field("Qty. to Invoice (Base)"; Rec."Qty. to Invoice (Base)")
                {
                    ToolTip = 'Specifies the quantity, in the base unit of measure, that remains to be invoiced. It is calculated as Quantity - Qty. Invoiced.';
                }
                field(Quantity; Rec.Quantity)
                {
                    ToolTip = 'Specifies the quantity of the record.';
                }
                field("Quantity Invoiced (Base)"; Rec."Quantity Invoiced (Base)")
                {
                    ToolTip = 'Specifies the value of the Quantity Invoiced (Base) field.';
                }
                field("Rejected Qty."; Rec."Rejected Qty.")
                {
                    ToolTip = 'Specifies the value of the Rejected Qty. field.';
                }
                field("Reservation Status"; Rec."Reservation Status")
                {
                    ToolTip = 'Specifies the status of the reservation.';
                }
                field("Responsibility Center"; Rec."Responsibility Center")
                {
                    ToolTip = 'Specifies the value of the Responsibility Center field.';
                }
                field(Sample; Rec.Sample)
                {
                    ToolTip = 'Specifies the value of the Sample field.';
                }
                field("Sample Quantity"; Rec."Sample Quantity")
                {
                    ToolTip = 'Specifies the value of the Sample Quantity field.';
                }
                field("Sampled By"; Rec."Sampled By")
                {
                    ToolTip = 'Specifies the value of the Sampled By field.';
                }
                field("Sampling Date"; Rec."Sampling Date")
                {
                    ToolTip = 'Specifies the value of the Sampling Date field.';
                }
                field("Serial No."; Rec."Serial No.")
                {
                    ToolTip = 'Specifies the serial number of the item that is being handled on the document line.';
                }
                field("Shipment Date"; Rec."Shipment Date")
                {
                    ToolTip = 'Specifies when items on the document are shipped or were shipped. A shipment date is usually calculated from a requested delivery date plus lead time.';
                }
                field("Source Batch Name"; Rec."Source Batch Name")
                {
                    ToolTip = 'Specifies the journal batch name if the reservation entry is related to a journal or requisition line.';
                }
                field("Source Prod. Order Line"; Rec."Source Prod. Order Line")
                {
                    ToolTip = 'Specifies the value of the Source Prod. Order Line field.';
                }
                field("Source Subtype"; Rec."Source Subtype")
                {
                    ToolTip = 'Specifies which source subtype the reservation entry is related to.';
                }
                field("Source Type"; Rec."Source Type")
                {
                    ToolTip = 'Specifies for which source type the reservation entry is related to.';
                }
                field("Suppressed Action Msg."; Rec."Suppressed Action Msg.")
                {
                    ToolTip = 'Specifies the value of the Suppressed Action Msg. field.';
                }
                field("Transferred from Entry No."; Rec."Transferred from Entry No.")
                {
                    ToolTip = 'Specifies a value when the order tracking entry is for the quantity that remains on a document line after a partial posting.';
                }
                field(SystemModifiedBy; Rec.SystemModifiedBy)
                {
                    ToolTip = 'Specifies the value of the SystemModifiedBy field.';
                }
                field("Untracked Surplus"; Rec."Untracked Surplus")
                {
                    ToolTip = 'Specifies the value of the Untracked Surplus field.';
                }
                field("Variant Code"; Rec."Variant Code")
                {
                    ToolTip = 'Specifies the variant of the item on the line.';
                }
                field("Warranty Date"; Rec."Warranty Date")
                {
                    ToolTip = 'Specifies the last day of the serial/lot number''s warranty.';
                }
            }
        }
    }
    actions
    {
    }
}
