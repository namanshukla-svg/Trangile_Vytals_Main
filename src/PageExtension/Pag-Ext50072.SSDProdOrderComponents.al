PageExtension 50072 "SSD Prod. Order Components" extends "Prod. Order Components"
{
    layout
    {
        modify("Item No.")
        {
            Editable = false;
        }
        modify("Quantity per")
        {
            Editable = false;
        }
        modify("Remaining Quantity")
        {
            Editable = false;
        }
        modify("Location Code")
        {
            Visible = true;
        }
        addafter("Scrap %")
        {
            field("Direct Unit Cost"; Rec."Direct Unit Cost")
            {
                ApplicationArea = All;
            }
        }
        addafter("Calculation Formula")
        {
            field("Direct Cost Amount"; Rec."Direct Cost Amount")
            {
                ApplicationArea = All;
            }
        }
        addafter("Flushing Method")
        {
            field("Act. Consumption (Qty)"; Rec."Act. Consumption (Qty)")
            {
                ApplicationArea = All;
            }
            field("Planning Level Code"; Rec."Planning Level Code")
            {
                ApplicationArea = All;
                Editable = false;
            }
            field("Qty. To Consume"; Rec."Qty. To Consume")
            {
                ApplicationArea = All;
            }
        }
    }
    actions
    {
        addafter(SelectItemSubstitution)
        {
            action("Fill Qty To Consume")
            {
                ApplicationArea = All;
                Caption = 'Fill Qty To Consume';

                trigger OnAction()
                var
                    ProdOrderComponent: Record "Prod. Order Component";
                begin
                    CurrPage.SetSelectionFilter(ProdOrderComponent);
                    if ProdOrderComponent.FindFirst then repeat ProdOrderComponent."Qty. To Consume":=ProdOrderComponent."Remaining Quantity";
                            ProdOrderComponent.Modify;
                        until ProdOrderComponent.Next = 0;
                end;
            }
        }
        addafter(OrderTracking)
        {
            action("Item Phy. Bin Details")
            {
                ApplicationArea = All;
                Caption = 'Item Phy. Bin Details';
                Image = BinJournal;
                Promoted = true;
                ShortCutKey = 'Shift+Ctrl+P';

                trigger OnAction()
                var
                    ReservationEntry: Record "Reservation Entry";
                    EntryNo: Integer;
                    LotNo: Code[20];
                    Item: Record Item;
                    LineNo: Integer;
                begin
                    //CORP::PK 010719 >>>
                    if Location.Get(Rec."Location Code")then;
                    if Item.Get(Rec."Item No.")then;
                    if(Location."Phy. Bin Required") and (Item."Phy. Bin Required")then begin
                        ItemPhyBinDetails.Reset;
                        ItemPhyBinDetails.SetRange("Document No.", Rec."Prod. Order No.");
                        ItemPhyBinDetails.SetRange("Document Line No.", Rec."Line No.");
                        ItemPhyBinDetails.SetRange("Posted Document No.", '');
                        if not ItemPhyBinDetails.FindFirst then begin
                            ReservationEntry.Reset;
                            ReservationEntry.SetRange("Source ID", Rec."Prod. Order No.");
                            ReservationEntry.SetRange("Source Ref. No.", Rec."Line No.");
                            ReservationEntry.SetFilter("Lot No.", '<>%1', '');
                            ReservationEntry.SetRange("Item No.", Rec."Item No.");
                            if ReservationEntry.FindSet then repeat ItemPhyBinDetails.Reset;
                                    ItemPhyBinDetails.SetRange("Document No.", Rec."Prod. Order No.");
                                    if ItemPhyBinDetails.FindLast then LineNo:=ItemPhyBinDetails."Line No." + 10000
                                    else
                                        LineNo:=10000;
                                    ItemPhyBinDetails.Init;
                                    ItemPhyBinDetails.Validate("Line No.", LineNo);
                                    ItemPhyBinDetails.Validate("Document No.", Rec."Prod. Order No.");
                                    ItemPhyBinDetails.Validate("Document Line No.", Rec."Line No.");
                                    ItemPhyBinDetails.Validate("Item No.", Rec."Item No.");
                                    ItemPhyBinDetails.Validate("Qty. Per Unit Of Measure", Rec."Qty. per Unit of Measure");
                                    ItemPhyBinDetails.Validate("Unit Of Measure", Rec."Unit of Measure Code");
                                    ItemPhyBinDetails.Validate("Location Code", Rec."Location Code");
                                    ItemPhyBinDetails.Validate("Bin Code", Rec."Bin Code");
                                    ItemPhyBinDetails.Validate("Lot No.", ReservationEntry."Lot No.");
                                    //ItemPhyBinDetails.VALIDATE("Journal Batch Name","Journal Batch Name");
                                    ItemPhyBinDetails.Validate("Journal Template Name", 'PROD.ORDER');
                                    ItemPhyBinDetails.Validate("Document Type", ItemPhyBinDetails."document type"::Consumption);
                                    ItemPhyBinDetails.Insert;
                                until ReservationEntry.Next = 0;
                        end;
                        Commit;
                        ItemPhyBinDetails.Reset;
                        ItemPhyBinDetails.SetRange("Document No.", Rec."Prod. Order No.");
                        ItemPhyBinDetails.SetRange("Document Line No.", Rec."Line No.");
                        ItemPhyBinDetails.SetRange("Posted Document No.", '');
                        Page.RunModal(50238, ItemPhyBinDetails);
                    end;
                //CORP::PK 010719 <<<
                end;
            }
        }
    }
    var ItemPhyBinDetails: Record "SSD Item Phy. Bin Details";
    Location: Record Location;
    ReservationEntry: Record "Reservation Entry";
}
