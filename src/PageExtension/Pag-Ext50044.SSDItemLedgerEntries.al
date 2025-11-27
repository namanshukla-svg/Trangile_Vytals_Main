PageExtension 50044 "SSD Item Ledger Entries" extends "Item Ledger Entries"
{
    layout
    {
        addafter("Document Line No.")
        {
            field("Item Category Code"; Rec."Item Category Code")
            {
                ApplicationArea = All;
            }
        }
        addafter("Item No.")
        {
            field("Inventory Tagging Person"; Rec."Inventory Taging Person")
            {
                ApplicationArea = All;
                Caption = 'Inventory Tagging Person';
            }
        }
        modify("Lot No.")
        {
            Visible = true;
        }
        addafter(Quantity)
        {
            field("Manufacturing Date New"; Rec."Manufacturing Date New")
            {
                ApplicationArea = All;
            }
        }
        addafter("Cost Amount (Actual)")
        {
            field("Manufacturing date"; Rec."Manufacturing date")
            {
                ApplicationArea = All;
            }
            field("Lot Blocked"; Rec."Lot Blocked")
            {
                ApplicationArea = All;
            }
            field("Unblock Date"; Rec."Unblock Date")
            {
                ApplicationArea = All;
            }
        }
        modify("Variant Code")
        {
            Visible = true;
        }
        movebefore(Quantity; "Variant Code")
    }
    actions
    {
        addafter("Application Worksheet")
        {
            action("View Posted Quality Order")
            {
                ApplicationArea = All;
                Caption = 'View Posted Quality Order';

                trigger OnAction()
                var
                    PostedQualityOrderHeader1: Record "SSD Posted Quality Order Hdr";
                    FormPosteQualityOrderList1: Page "Posted Quality Order List";
                begin
                    //<<<********** ALLE[5.51]
                    PostedQualityOrderHeader1.Reset;
                    PostedQualityOrderHeader1.SetRange(PostedQualityOrderHeader1."Lot No.", Rec."Lot No.");
                    if PostedQualityOrderHeader1.FindFirst then begin
                        Clear(FormPosteQualityOrderList1);
                        FormPosteQualityOrderList1.SetTableview(PostedQualityOrderHeader1);
                        FormPosteQualityOrderList1.RunModal;
                    end;
                //>>>********** ALLE[5.51]
                end;
            }
            action("Label - 3 * 2 Automation")
            {
                ApplicationArea = All;
                Caption = 'Label - 3 * 2 Automation';
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Image = Image;
                RunObject = report "Label - 3 * 2 Automation";
            }
        }
        addfirst(Processing)
        {
            action(Action1000000000)
            {
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Process;
                Visible = false;

                trigger OnAction()
                var
                    we: Record "Warehouse Entry";
                    i: Integer;
                begin
                    if not Confirm('create')then exit;
                    i:=1;
                    we.Reset;
                    if we.FindLast then i:=we."Entry No." + 1;
                    we.Init;
                    we."Entry No.":=i;
                    we."Journal Batch Name":='JOBWORK';
                    //WE."Line No." := ILE."";
                    we."Registering Date":=Rec."Posting Date";
                    we."Location Code":=Rec."Location Code";
                    //WE."Zone Code" := ILE."";
                    we."Bin Code":=Rec."Bin Code";
                    //WE."Description" := ILE."";
                    we."Item No.":=Rec."Item No.";
                    we.Quantity:=Rec.Quantity;
                    we."Qty. (Base)":=Rec.Quantity;
                    we."Source Type":=83;
                    we."Source Subtype":=1;
                    we."Source No.":=Rec."Document No.";
                    we."Source Line No.":=10000;
                    //WE."Source Subline No." := ILE."";
                    we."Source Document":=we."source document"::"Reclass. Jnl.";
                    we."Source Code":='ITEMJNL';
                    //WE."Reason Code" := ILE."";
                    //WE."No. Series" := ILE."";
                    //WE."Bin Type Code" := ILE."";
                    //WE."Cubage" := ILE."";
                    //WE."Weight" := ILE."";
                    //WE."Journal Template Name" := ILE."";
                    //WE."Whse. Document No." := ILE."";
                    //WE."Whse. Document Type" := ILE."";
                    //WE."Whse. Document Line No." := ILE."";
                    we."Entry Type":=we."entry type"::Movement;
                    we."Reference Document":=we."reference document"::"Item Journal";
                    we."Reference No.":=Rec."Document No.";
                    //WE."User ID" := ILE."";
                    //WE."Variant Code" := ILE."";
                    we."Qty. per Unit of Measure":=1;
                    we."Unit of Measure Code":=Rec."Unit of Measure Code";
                    //WE."Serial No." := ILE."";
                    //WE."Lot No." := ILE."";
                    //WE."Warranty Date" := ILE."";
                    //WE."Expiration Date" := ILE."";
                    //WE."Phys Invt Counting Period Code" := ILE."";
                    //WE."Phys Invt Counting Period Type" := ILE."";
                    we."Responsibility Center":='BINOLa';
                    we.Insert;
                end;
            }
        }
    }
    var UserMgt: Codeunit "SSD User Setup Management";
    InventoryTaging: Code[20];
    ItemL: Record Item;
}
