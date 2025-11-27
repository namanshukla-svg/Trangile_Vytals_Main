Page 50317 "Item Phy. Bin Details Lookup"
{
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    ShowFilter = false;
    SourceTable = "SSD Phy. Bin Details";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Location Code"; Rec."Location Code")
                {
                    ApplicationArea = All;
                }
                field("Bin Code"; Rec."Bin Code")
                {
                    ApplicationArea = All;
                }
                field("Phy. Bin Code"; Rec."Phy. Bin Code")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
    actions
    {
    }
    var ItemPhyBinDetails: Record "SSD Item Phy. Bin Details";
    ReservationEntry: Record "Reservation Entry";
    LotQty: Decimal;
    Qty: Decimal;
    ItemPhyBinDetails1: Record "SSD Item Phy. Bin Details";
    Location: Record Location;
    QtyToReceive: Decimal;
    QtyToReceive2: Decimal;
    Qty1: Decimal;
}
