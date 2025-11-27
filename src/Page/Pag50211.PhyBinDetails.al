Page 50211 "Phy. Bin Details"
{
    PageType = List;
    SourceTable = "SSD Item Phy. Bin Details";
    ApplicationArea = All;

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
                field("Bin Code"; Rec."Bin Code")
                {
                    ApplicationArea = All;
                }
                field("Phy. Bin Code"; Rec."Phy. Bin Code")
                {
                    ApplicationArea = All;
                }
                field(Quantity; Qty)
                {
                    ApplicationArea = All;
                }
            }
        }
    }
    actions
    {
    }
    trigger OnAfterGetRecord()
    begin
        Qty:=0;
        ItemPhyBinDetails.Reset;
        ItemPhyBinDetails.SetCurrentkey("Phy. Bin Code");
        ItemPhyBinDetails.SetRange("Location Code", Rec."Location Code");
        ItemPhyBinDetails.SetRange("Bin Code", Rec."Bin Code");
        ItemPhyBinDetails.SetRange("Phy. Bin Code", Rec."Phy. Bin Code");
        ItemPhyBinDetails.SetRange("Item No.", Rec."Item No.");
        if ItemPhyBinDetails.FindSet then repeat Qty+=ItemPhyBinDetails.Quantity;
            until ItemPhyBinDetails.Next = 0;
    end;
    var Qty: Decimal;
    ItemPhyBinDetails: Record "SSD Item Phy. Bin Details";
}
