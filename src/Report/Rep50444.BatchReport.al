Report 50444 "Batch Report"
{
    ProcessingOnly = true;
    ApplicationArea = All;

    dataset
    {
        dataitem("Prod. Order Line"; "Prod. Order Line")
        {
            column(ReportForNavId_1000000000;1000000000)
            {
            }
            dataitem("Production BOM Line"; "Production BOM Line")
            {
                DataItemLink = "Production BOM No."=field("Production BOM No.");
                DataItemTableView = sorting("Production BOM No.", "Version Code", "Line No.");

                column(ReportForNavId_1000000001;1000000001)
                {
                }
                trigger OnAfterGetRecord()
                begin
                    ProdOrderCompo.Init;
                    ProdOrderCompo.Status:="Prod. Order Line".Status;
                    ProdOrderCompo."Prod. Order No.":="Prod. Order Line"."Prod. Order No.";
                    ProdOrderCompo."Prod. Order Line No.":="Prod. Order Line"."Line No.";
                    ProdOrderCompo."Line No.":=LineNo + 10000;
                    LineNo:=ProdOrderCompo."Line No." + 10000;
                    ProdOrderCompo."Item No.":="Production BOM Line"."No.";
                    ProdOrderCompo.Description:="Production BOM Line".Description;
                    ProdOrderCompo."Unit of Measure Code":="Production BOM Line"."Unit of Measure Code";
                    ProdOrderCompo.Quantity:="Prod. Order Line".Quantity * "Production BOM Line"."Quantity per";
                    ProdOrderCompo."Routing Link Code":="Production BOM Line"."Routing Link Code";
                    ProdOrderCompo."Scrap %":="Production BOM Line"."Scrap %";
                    ProdOrderCompo."Variant Code":="Production BOM Line"."Variant Code";
                    ProdOrderCompo."Expected Quantity":="Prod. Order Line".Quantity * "Production BOM Line"."Quantity per";
                    ProdOrderCompo."Remaining Quantity":="Prod. Order Line".Quantity * "Production BOM Line"."Quantity per";
                    ProdOrderCompo."Flushing Method":=ProdOrderCompo."Flushing Method";
                    ProdOrderCompo."Location Code":="Prod. Order Line"."Location Code";
                    ProdOrderCompo."Shortcut Dimension 1 Code":="Prod. Order Line"."Shortcut Dimension 1 Code";
                    ProdOrderCompo."Shortcut Dimension 2 Code":="Prod. Order Line"."Shortcut Dimension 2 Code";
                    ProdOrderCompo."Bin Code":="Production BOM Line"."Bin Code";
                    ProdOrderCompo."Planning Level Code":="Prod. Order Line"."Planning Level Code";
                    ProdOrderCompo."Calculation Formula":="Production BOM Line"."Calculation Formula";
                    ProdOrderCompo."Quantity per":="Production BOM Line"."Quantity per";
                    ProdOrderCompo."Due Date":="Prod. Order Line"."Due Date";
                    ProdOrderCompo."Qty. per Unit of Measure":="Production BOM Line"."Quantity per";
                    ProdOrderCompo."Remaining Qty. (Base)":="Prod. Order Line".Quantity * "Production BOM Line"."Quantity per";
                    ProdOrderCompo."Quantity (Base)":="Prod. Order Line".Quantity * "Production BOM Line"."Quantity per";
                    ProdOrderCompo."Expected Qty. (Base)":="Prod. Order Line".Quantity * "Production BOM Line"."Quantity per";
                    ProdOrderCompo."Dimension Set ID":="Prod. Order Line"."Dimension Set ID";
                    ProdOrderCompo."Qty. To Consume":="Prod. Order Line".Quantity * "Production BOM Line"."Quantity per";
                    ProdOrderCompo."Source No.":="Prod. Order Line"."Item No.";
                    ProdOrderCompo.Insert;
                end;
            }
            trigger OnAfterGetRecord()
            begin
            //LineNo := 0;
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
    var ProdOrderCompo: Record "Prod. Order Component";
    LineNo: Integer;
}
