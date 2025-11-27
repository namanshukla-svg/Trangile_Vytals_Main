Report 50279 "Production Actual / Std."
{
    // ALLE-HG-Item category for Parent corrected
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Production Actual  Std..rdl';
    UsageCategory = ReportsandAnalysis;
    ApplicationArea = all;

    dataset
    {
        dataitem("Production Order"; "Production Order")
        {
            DataItemTableView = sorting(Status, "No.")order(ascending);
            RequestFilterFields = Status, "No.", "Source No.", "Starting Date", "Finished Date";

            column(ReportForNavId_1000000000;1000000000)
            {
            }
            column(Remarks_ProductionOrder; "Production Order".Remarks)
            {
            }
            dataitem("Prod. Order Line"; "Prod. Order Line")
            {
                DataItemLink = Status=field(Status), "Prod. Order No."=field("No.");
                DataItemTableView = sorting(Status, "Prod. Order No.", "Line No.")order(ascending);

                column(ReportForNavId_1170000000;1170000000)
                {
                }
                column(Status_ProdOrderLine; Format("Prod. Order Line".Status))
                {
                }
                column(ProdOrderNo_ProdOrderLine; "Prod. Order Line"."Prod. Order No.")
                {
                }
                column(ProductionOrderFinishedDate; Format(ProductionOrder."Finished Date"))
                {
                }
                column(LineNo_ProdOrderLine; "Prod. Order Line"."Line No.")
                {
                }
                column(ItemNo_ProdOrderLine; "Prod. Order Line"."Item No.")
                {
                }
                column(ItemDescription2; Item."Description 2")
                {
                }
                column(ItemItemCategoryCode; Item."Item Category Code")
                {
                }
                column(VariantCode_ProdOrderLine; "Prod. Order Line"."Variant Code")
                {
                }
                column(Description_ProdOrderLine; "Prod. Order Line".Description)
                {
                }
                column(Description2_ProdOrderLine; "Prod. Order Line"."Description 2")
                {
                }
                column(UnitofMeasureCode_ProdOrderLine; "Prod. Order Line"."Unit of Measure Code")
                {
                }
                column(LocationCode_ProdOrderLine; "Prod. Order Line"."Location Code")
                {
                }
                column(Quantity_ProdOrderLine; "Prod. Order Line".Quantity)
                {
                }
                column(FinishedQuantity_ProdOrderLine; "Prod. Order Line"."Finished Quantity")
                {
                }
                column(RemainingQuantity_ProdOrderLine; "Prod. Order Line"."Remaining Quantity")
                {
                }
                column(MachineNo; MachineNo)
                {
                }
                column(MachineCode; MachineCode)
                {
                }
                column(VS; VS)
                {
                }
                column(ITGCode; ITGCode)
                {
                }
                dataitem("Prod. Order Component"; "Prod. Order Component")
                {
                    DataItemLink = Status=field(Status), "Prod. Order No."=field("Prod. Order No."), "Prod. Order Line No."=field("Line No.");
                    DataItemTableView = sorting(Status, "Prod. Order No.", "Prod. Order Line No.", "Line No.")order(ascending);

                    column(ReportForNavId_1170000001;1170000001)
                    {
                    }
                    column(ItemNo_ProdOrderComponent; "Prod. Order Component"."Item No.")
                    {
                    }
                    column(Description_ProdOrderComponent; "Prod. Order Component".Description)
                    {
                    }
                    column(CItemDescription2; Item."Description 2")
                    {
                    }
                    column(UnitofMeasureCode_ProdOrderComponent; "Prod. Order Component"."Unit of Measure Code")
                    {
                    }
                    column(Quantity_ProdOrderComponent; "Prod. Order Component"."Expected Quantity")
                    {
                    }
                    column(Quantityper_ProdOrderComponent; "Prod. Order Component"."Quantity per")
                    {
                    }
                    column(UnitCost_ProdOrderComponent; "Prod. Order Component"."Unit Cost")
                    {
                    }
                    column(CostAmount_ProdOrderComponent; "Prod. Order Component"."Cost Amount")
                    {
                    }
                    column(ChildItemCategoryCode; Item."Item Category Code")
                    {
                    }
                    column(ActualTotalConQty; ActualTotalConQty)
                    {
                    }
                    column(ActualTotalConAmt; ActualTotalConAmt)
                    {
                    }
                    column(ActualUnitCost; ActualUnitCost)
                    {
                    }
                    trigger OnAfterGetRecord()
                    var
                        ItemLedgerEntry: Record "Item Ledger Entry";
                    begin
                        ActualTotalConQty:=0;
                        ActualTotalConAmt:=0;
                        ActualUnitCost:=0;
                        Item.Get("Item No.");
                        ItemLedgerEntry.SetRange("Order Type", ItemLedgerEntry."order type"::Production);
                        ItemLedgerEntry.SetRange("Order No.", "Prod. Order Component"."Prod. Order No.");
                        ItemLedgerEntry.SetRange("Item No.", "Prod. Order Component"."Item No.");
                        ItemLedgerEntry.SetRange("Entry Type", ItemLedgerEntry."entry type"::Consumption);
                        if ItemLedgerEntry.FindSet then repeat ActualTotalConQty+=-ItemLedgerEntry.Quantity;
                            until ItemLedgerEntry.Next = 0;
                    //MESSAGE('%1 child',Item."Item Category Code");
                    end;
                }
                dataitem("Item Ledger Entry"; "Item Ledger Entry")
                {
                    CalcFields = "Cost Amount (Actual)";
                    DataItemLink = "Order No."=field("Prod. Order No."), "Order Line No."=field("Line No.");
                    DataItemTableView = sorting("Order Type", "Order No.", "Order Line No.", "Prod. Order Comp. Line No.", "Entry Type", "Location Code")order(ascending)where("Order Type"=filter(Production), "Entry Type"=filter(Consumption));

                    column(ReportForNavId_1170000020;1170000020)
                    {
                    }
                    column(CostAmountActual_ItemLedgerEntry; "Item Ledger Entry"."Cost Amount (Actual)")
                    {
                    }
                    column(QtyperUnitofMeasure_ItemLedgerEntry; "Item Ledger Entry"."Qty. per Unit of Measure")
                    {
                    }
                    column(UnitofMeasureCode_ItemLedgerEntry; "Item Ledger Entry"."Unit of Measure Code")
                    {
                    }
                    column(ItemNo_ItemLedgerEntry; "Item Ledger Entry"."Item No.")
                    {
                    }
                    column(Description_ItemLedgerEntry; Item.Description)
                    {
                    }
                    column(IItemDescription2; Item."Description 2")
                    {
                    }
                    column(LocationCode_ItemLedgerEntry; "Item Ledger Entry"."Location Code")
                    {
                    }
                    column(Quantity_ItemLedgerEntry; "Item Ledger Entry".Quantity)
                    {
                    }
                    column(TItemItemCategoryCode; Item."Item Category Code")
                    {
                    }
                    column(TUnitCost; Abs("Item Ledger Entry"."Cost Amount (Actual)" / "Item Ledger Entry".Quantity))
                    {
                    }
                    column(Printed; Printed)
                    {
                    }
                    column(LastDirectCost; LastDirectCost)
                    {
                    }
                    trigger OnAfterGetRecord()
                    var
                        ProdOrderComponent: Record "Prod. Order Component";
                    begin
                        Item.Get("Item No.");
                        ProdOrderComponent.SetRange("Prod. Order No.", "Item Ledger Entry"."Order No.");
                        ProdOrderComponent.SetRange("Item No.", "Item Ledger Entry"."Item No.");
                        if ProdOrderComponent.FindFirst then begin
                            Printed:=true;
                            CurrReport.Skip end;
                        Clear(LastDirectCost);
                        RecITem.Reset;
                        //MESSAGE(FORMAT("Item Ledger Entry"."Item No."));
                        if RecITem.Get("Item Ledger Entry"."Item No.")then LastDirectCost:=RecITem."Last Direct Cost";
                    end;
                }
                trigger OnAfterGetRecord()
                var
                    ProdOrderRoutingLine: Record "Prod. Order Routing Line";
                begin
                    MachineNo:='';
                    ITGCode:='';
                    ProductionOrder.Get("Prod. Order Line".Status, "Prod. Order Line"."Prod. Order No.");
                    Item.Get("Item No.");
                    ProdOrderRoutingLine.SetRange(Status, "Prod. Order Line".Status);
                    ProdOrderRoutingLine.SetRange("Prod. Order No.", "Prod. Order Line"."Prod. Order No.");
                    if ProdOrderRoutingLine.FindFirst then begin
                        MachineNo:=ProdOrderRoutingLine.Description;
                        MachineCode:=ProdOrderRoutingLine."No.";
                    end;
                    VS:=ProductionOrder."Variance Cause";
                    ITGCode:=Item."Item Category Code";
                end;
            }
            trigger OnAfterGetRecord()
            begin
                Printed:=false;
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
    var ProductionOrder: Record "Production Order";
    Item: Record Item;
    ActualTotalConQty: Decimal;
    ActualTotalConAmt: Decimal;
    ActualUnitCost: Decimal;
    MachineNo: Text;
    MachineCode: Code[20];
    Printed: Boolean;
    Sdate: Date;
    Edate: Date;
    ITGCode: Text;
    RecITem: Record Item;
    LastDirectCost: Decimal;
    VS: Option " ", "DN-PPC", "DN-PPC YIELD", "DN-BOM", "DN-SALES", "DN-SUBCON", "DN-QA", "DN-VENDOR", "NO LOSS", "NOTIONAL-SCM", "DN-TS/PMM", "NOTIONAL-GENERAL";
}
