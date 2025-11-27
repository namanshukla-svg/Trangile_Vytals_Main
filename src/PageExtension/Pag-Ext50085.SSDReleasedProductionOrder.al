PageExtension 50085 "SSD Released Production Order" extends "Released Production Order"
{
    layout
    {
        modify("Source No.")
        {
            Enabled = false;
            Editable = false;
        }
        addafter("Last Date Modified")
        {
            field("Order Created from MRP"; Rec."Order Created from MRP")
            {
                ApplicationArea = All;
                Editable = false;
            }
            field("Manufacturing Date"; Rec."Manufacturing Date")
            {
                ApplicationArea = All;
                Editable = false;
            }
        }
        modify("Starting Date-Time")
        {
            Visible = true;
        }
        modify("Ending Date-Time")
        {
            Visible = true;
        }
        moveafter("Manufacturing Date"; "Starting Date-Time")
        moveafter("Starting Date-Time"; "Ending Date-Time")
    }
    actions
    {
        addafter("Registered Invt. Movement Lines")
        {
            action("Item Ledger E&ntries For QR Code")
            {
                ApplicationArea = All;
                Caption = 'Item Ledger E&ntries For QR Code';
                Image = ItemLedger;
                RunObject = Page "Item Ledger Entries For QR Cod";
                RunPageLink = "Order Type"=const(Production), "Order No."=field("No.");
                RunPageView = sorting("Order Type", "Order No.");
            }
        }
        addafter("Shortage List")
        {
            action("ZEV-JOB CARD")
            {
                ApplicationArea = All;
                Caption = 'ZEV-JOB CARD';

                trigger OnAction()
                var
                    ProductionOrderLine: Record "Prod. Order Line";
                    JobCard: Report "Job Card/Production Card";
                begin
                    ProductionOrderLine.Reset;
                    ProductionOrderLine.SetRange(ProductionOrderLine."Prod. Order No.", Rec."No.");
                    JobCard.SetTableview(ProductionOrderLine);
                    JobCard.Run;
                end;
            }
        }
    }
}
