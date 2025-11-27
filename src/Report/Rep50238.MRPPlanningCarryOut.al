Report 50238 "MRP Planning Carry Out"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/MRP Planning Carry Out.rdl';
    UsageCategory = ReportsandAnalysis;
    ApplicationArea = all;

    dataset
    {
        dataitem(TestMail; "SSD MRP Mail Send")
        {
            column(ReportForNavId_1000000000;1000000000)
            {
            }
            column(No; TestMail."No.")
            {
            }
            column(Description; Item.Description)
            {
            }
            column(Description_2; Item."Description 2")
            {
            }
            column(UOM; Item."Base Unit of Measure")
            {
            }
            column(Qty_on_Prod_Order; Item."Qty. on Prod. Order")
            {
            }
            column(Qty_on_Purch_Order; Item."Qty. on Purch. Order")
            {
            }
            column(Qty_on_Sales_Order; Item."Qty. on Sales Order")
            {
            }
            column(Qty_on_Component_Line; Item."Qty. on Component Lines")
            {
            }
            column(CL; Item."Minimum Order Quantity")
            {
            }
            column(ROL; Item."Maximum Order Quantity")
            {
            }
            column(MSL; Item."Safety Stock Quantity")
            {
            }
            column(MRPQty; TestMail."MRP Qty.")
            {
            }
            column(StockkeepingUnit_Inventory; StockkeepingUnit.Inventory)
            {
            }
            column(MRPRemark_RequisitionLine; TestMail."MRP Remark")
            {
            }
            column(Quantity_RequisitionLine; TestMail.Quantity)
            {
            }
            column(ReplenishmentSystem; Item."Replenishment System")
            {
            }
            column(LocCode; LocCode)
            {
            }
            trigger OnAfterGetRecord()
            begin
                Item.Get("No.");
                Item.CalcFields("Qty. on Purch. Order");
                Item.CalcFields("Qty. on Sales Order");
                Item.CalcFields("Qty. on Component Lines");
                /*
                StockkeepingUnit.RESET;
                StockkeepingUnit.SETRANGE("Item No.","No.");
                IF StockkeepingUnit.FINDFIRST THEN;
                StockkeepingUnit.CALCFIELDS(Inventory);
                */
                //ALLE
                Clear(LocCode);
                StockkeepingUnit.Reset;
                StockkeepingUnit.SetRange("Item No.", "No.");
                StockkeepingUnit.SetRange("Replenishment System", Item."Replenishment System");
                if StockkeepingUnit.FindFirst then begin
                    StockkeepingUnit.CalcFields(Inventory);
                    LocCode:=StockkeepingUnit."Location Code";
                end;
            //ALLE
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
    StockkeepingUnit: Record "Stockkeeping Unit";
    LocCode: Code[20];
}
