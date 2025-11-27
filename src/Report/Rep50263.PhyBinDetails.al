Report 50263 "Phy. Bin Details"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Phy. Bin Details.rdl';
    PreviewMode = PrintLayout;
    UsageCategory = ReportsandAnalysis;
    ApplicationArea = all;

    dataset
    {
        dataitem("Item Phy. Bin Details"; "SSD Item Phy. Bin Details")
        {
            DataItemTableView = where("Whse. Entry  No."=filter(<>0));

            column(ReportForNavId_1000000000;1000000000)
            {
            }
            column(ItemNo_ItemPhyBinDetails; "Item Phy. Bin Details"."Item No.")
            {
            }
            column(Quantity_ItemPhyBinDetails; Qty)
            {
            }
            column(LocationCode_ItemPhyBinDetails; "Item Phy. Bin Details"."Location Code")
            {
            }
            column(BinCode_ItemPhyBinDetails; "Item Phy. Bin Details"."Bin Code")
            {
            }
            column(PhyBinCode_ItemPhyBinDetails; "Item Phy. Bin Details"."Phy. Bin Code")
            {
            }
            column(LotNo_ItemPhyBinDetails; "Item Phy. Bin Details"."Lot No.")
            {
            }
            trigger OnAfterGetRecord()
            begin
                Qty:=0;
                ItemPhyBinDetails.Reset;
                ItemPhyBinDetails.SetCurrentkey("Item No.", "Location Code", "Bin Code");
                ItemPhyBinDetails.SetRange("Item No.", "Item No.");
                ItemPhyBinDetails.SetRange("Location Code", "Location Code");
                ItemPhyBinDetails.SetRange("Bin Code", "Bin Code");
                ItemPhyBinDetails.SetRange("Phy. Bin Code", "Phy. Bin Code");
                ItemPhyBinDetails.SetRange("Lot No.", "Lot No.");
                ItemPhyBinDetails.SetFilter("Whse. Entry  No.", '<>%1', 0);
                if ItemPhyBinDetails.FindSet then repeat //Qty += ROUND(ItemPhyBinDetails."ILE Quantity",0.001,'=');
                        Qty+=ItemPhyBinDetails."ILE Quantity";
                    until ItemPhyBinDetails.Next = 0;
            end;
        }
    }
    requestpage
    {
        layout
        {
        }
        actions
        {
        }
    }
    labels
    {
    }
    var ItemPhyBinDetails: Record "SSD Item Phy. Bin Details";
    Qty: Decimal;
}
