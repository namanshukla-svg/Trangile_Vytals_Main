Report 50260 "BOM vs Actual Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/BOM vs Actual Report.rdl';
    UsageCategory = ReportsandAnalysis;
    ApplicationArea = all;

    dataset
    {
        dataitem("Item Ledger Entry"; "Item Ledger Entry")
        {
            DataItemTableView = where("Entry Type"=filter(Output|Consumption));
            RequestFilterFields = "Posting Date";

            column(ReportForNavId_1000000000;1000000000)
            {
            }
            column(DocumentNo_ILE; "Item Ledger Entry"."Document No.")
            {
            }
            column(SourceNo_ILE; "Item Ledger Entry"."Source No.")
            {
            }
            column(ItemNo_ILE; "Item Ledger Entry"."Item No.")
            {
            }
            column(Quantity_ILE; "Item Ledger Entry".Quantity)
            {
            }
            column(BOMItems; BOMItems)
            {
            }
            column(BOMQty; BOMQty)
            {
            }
            trigger OnAfterGetRecord()
            begin
                BOMItems:='';
                BOMQty:=0;
                if Item.Get("Source No.")then;
                ProductionBOMLine.Reset;
                ProductionBOMLine.SetRange("Production BOM No.", Item."Production BOM No.");
                ProductionBOMLine.SetRange("No.", "Item Ledger Entry"."Item No.");
                if ProductionBOMLine.FindSet then repeat BOMItems:=ProductionBOMLine."No.";
                        BOMQty:=ProductionBOMLine.Quantity * "Item Ledger Entry".Quantity;
                    until ProductionBOMLine.Next = 0;
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
    var Item: Record Item;
    ProductionBOMHeader: Record "Production BOM Header";
    ProductionBOMLine: Record "Production BOM Line";
    BOMItems: Code[10];
    BOMQty: Decimal;
}
