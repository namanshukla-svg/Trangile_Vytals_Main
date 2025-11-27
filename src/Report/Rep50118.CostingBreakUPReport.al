Report 50118 "Costing BreakUP Report."
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Costing BreakUP Report..rdl';
    UsageCategory = ReportsandAnalysis;
    ApplicationArea = all;

    dataset
    {
        dataitem(Item; Item)
        {
            DataItemTableView = order(ascending);
            PrintOnlyIfDetail = true;
            RequestFilterFields = "No.", "Item Category Code";

            column(ReportForNavId_8129;8129)
            {
            }
            column(GrTotalExpCost; GrTotalExpCost)
            {
            }
            column(GrTotalActualCost; GrTotalActualCost)
            {
            }
            column(Costing_BreakUp_ReportCaption; Costing_BreakUp_ReportCaptionLbl)
            {
            }
            column(Actual_CostCaption; Actual_CostCaptionLbl)
            {
            }
            column(Expected_CostCaption; Expected_CostCaptionLbl)
            {
            }
            column(Prod__Order_Component__Unit_Cost_Caption; "Prod. Order Component".FieldCaption("Unit Cost"))
            {
            }
            column(Actual_QtyCaption; Actual_QtyCaptionLbl)
            {
            }
            column(BOM_QuantityCaption; BOM_QuantityCaptionLbl)
            {
            }
            column(Prod__Order_Component__Unit_of_Measure_Code_Caption; "Prod. Order Component".FieldCaption("Unit of Measure Code"))
            {
            }
            column(Description_1Caption; Description_1CaptionLbl)
            {
            }
            column(Child_Item_No_Caption; Child_Item_No_CaptionLbl)
            {
            }
            column(Prod__Order_Line__Finished_Quantity_Caption; "Prod. Order Line".FieldCaption("Finished Quantity"))
            {
            }
            column(Prod__Order_Line_QuantityCaption; "Prod. Order Line".FieldCaption(Quantity))
            {
            }
            column(UOMCaption; UOMCaptionLbl)
            {
            }
            column(Description_1_and_2Caption; Description_1_and_2CaptionLbl)
            {
            }
            column(Prod__Order_Line__Item_No__Caption; "Prod. Order Line".FieldCaption("Item No."))
            {
            }
            column(whether_Order_finished_in_system_yes_No_Caption; whether_Order_finished_in_system_yes_No_CaptionLbl)
            {
            }
            column(Prod__Order_Line__Prod__Order_No__Caption; "Prod. Order Line".FieldCaption("Prod. Order No."))
            {
            }
            column(Prod__Order_Line__Starting_Date_Caption; "Prod. Order Line".FieldCaption("Starting Date"))
            {
            }
            column(Variance___in_Rs_Caption; Variance___in_Rs_CaptionLbl)
            {
            }
            column(Variance___in___Caption; Variance___in___CaptionLbl)
            {
            }
            column(Description_2Caption; Description_2CaptionLbl)
            {
            }
            column(Work_Machine_CenterCaption; Work_Machine_CenterCaptionLbl)
            {
            }
            column(Grand_TotalCaption; Grand_TotalCaptionLbl)
            {
            }
            column(Item_No_; "No.")
            {
            }
            dataitem("Production Order"; "Production Order")
            {
                DataItemLink = "Source No."=field("No.");
                DataItemTableView = sorting(Status, "No.")order(ascending);
                RequestFilterFields = "No.", "Creation Date";

                column(ReportForNavId_4824;4824)
                {
                }
                column(Production_Order_Status; Status)
                {
                }
                column(Production_Order_No_; "No.")
                {
                }
                column(Production_Order_Source_No_; "Source No.")
                {
                }
                dataitem("Prod. Order Line"; "Prod. Order Line")
                {
                    DataItemLink = "Prod. Order No."=field("No.");
                    DataItemTableView = sorting(Status, "Prod. Order No.", "Line No.")order(ascending);
                    RequestFilterFields = Status, "Item No.";

                    column(ReportForNavId_3581;3581)
                    {
                    }
                    column(Prod__Order_Line__Starting_Date_; "Starting Date")
                    {
                    }
                    column(Prod__Order_Line__Prod__Order_No__; "Prod. Order No.")
                    {
                    }
                    column(Prod__Order_Line__Item_No__; "Item No.")
                    {
                    }
                    column(Description___________Description_2_; Description + ' -  ' + "Description 2")
                    {
                    }
                    column(StatusCheck; StatusCheck)
                    {
                    }
                    column(Prod__Order_Line__Unit_of_Measure_Code_; "Unit of Measure Code")
                    {
                    }
                    column(Prod__Order_Line_Quantity; Quantity)
                    {
                    }
                    column(Prod__Order_Line__Finished_Quantity_; "Finished Quantity")
                    {
                    }
                    column(ProdOrdRoutingLine__No__; ProdOrdRoutingLine."No.")
                    {
                    }
                    column(ProdOrdRoutingLine_Description; ProdOrdRoutingLine.Description)
                    {
                    }
                    column(ProdOrdRoutingLine__Setup_Time_Unit_of_Meas__Code_; ProdOrdRoutingLine."Setup Time Unit of Meas. Code")
                    {
                    }
                    column(Prod__Order_Line_Status; Status)
                    {
                    }
                    column(Prod__Order_Line_Line_No_; "Line No.")
                    {
                    }
                    dataitem("Prod. Order Component"; "Prod. Order Component")
                    {
                        DataItemLink = "Prod. Order No."=field("Prod. Order No.");
                        DataItemTableView = sorting(Status, "Prod. Order No.", "Prod. Order Line No.", "Line No.")order(ascending);
                        RequestFilterFields = "Item No.";

                        column(ReportForNavId_7771;7771)
                        {
                        }
                        column(Prod__Order_Component__Item_No__; "Item No.")
                        {
                        }
                        column(Prod__Order_Component_Description_; Description)
                        {
                        }
                        column(Prod__Order_Component__Unit_of_Measure_Code_; "Unit of Measure Code")
                        {
                        }
                        column(BomQty_2; BomQty_2)
                        {
                        }
                        column(Prod__Order_Component__Act__Consumption__Qty__; "Act. Consumption (Qty)")
                        {
                        }
                        column(Prod__Order_Component__Unit_Cost_; "Unit Cost")
                        {
                        }
                        column(Unit_Cost___Expected_Quantity_; "Unit Cost" * "Expected Quantity")
                        {
                        }
                        column(Act__Consumption__Qty____Unit_Cost_; "Act. Consumption (Qty)" * "Unit Cost")
                        {
                        }
                        column(Act__Consumption__Qty____Unit_Cost_____Unit_Cost___Expected_Quantity___;(("Act. Consumption (Qty)" * "Unit Cost") - ("Unit Cost" * "Expected Quantity")))
                        {
                        }
                        column(VarianceInPer; VarianceInPer)
                        {
                        DecimalPlaces = 2: 2;
                        }
                        column(ItemNo; ItemNo)
                        {
                        }
                        column(Descrp; Descrp)
                        {
                        }
                        column(UOM; UOM)
                        {
                        }
                        column(BomQty; BomQty)
                        {
                        }
                        column(ActQty; ActQty)
                        {
                        }
                        column(UnitCost; UnitCost)
                        {
                        }
                        column(UnitCost_BomQty; UnitCost * BomQty)
                        {
                        }
                        column(ActQty___UnitCost; ActQty * UnitCost)
                        {
                        }
                        column(ActQty___UnitCost___UnitCost_BomQty_;(ActQty * UnitCost) - (UnitCost * BomQty))
                        {
                        }
                        column(VarianceInPer_2; VarianceInPer_2)
                        {
                        }
                        column(childDescrptn2; childDescrptn2)
                        {
                        }
                        column(childDescrptn2_2; childDescrptn2_2)
                        {
                        }
                        column(TotalExpCost; TotalExpCost)
                        {
                        }
                        column(TotalActualCost; TotalActualCost)
                        {
                        }
                        column(TotalCaption; TotalCaptionLbl)
                        {
                        }
                        column(Prod__Order_Component_Status; Status)
                        {
                        }
                        column(Prod__Order_Component_Prod__Order_No_; "Prod. Order No.")
                        {
                        }
                        column(Prod__Order_Component_Prod__Order_Line_No_; "Prod. Order Line No.")
                        {
                        }
                        column(Prod__Order_Component_Line_No_; "Line No.")
                        {
                        }
                        trigger OnAfterGetRecord()
                        begin
                            ItemRec.Reset;
                            if ItemRec.Get("Prod. Order Component"."Item No.")then childDescrptn2:=ItemRec."Description 2";
                            TotalExpCost+="Unit Cost" * "Expected Quantity";
                            TotalActualCost+="Act. Consumption (Qty)" * "Unit Cost";
                            if("Act. Consumption (Qty)" * "Unit Cost") <> 0 then VarianceInPer:=((("Act. Consumption (Qty)" * "Unit Cost") - ("Unit Cost" * "Expected Quantity")) / ("Act. Consumption (Qty)" * "Unit Cost")) * 100
                            else
                                VarianceInPer:=0;
                            if Countt = 1 then begin
                                Countt+=1;
                                ProductBomLine.SetRange(ProductBomLine."Production BOM No.", "Prod. Order Line"."Item No.");
                                if ProductBomLine.FindFirst then;
                            end;
                            if ProductBomLine."No." <> "Item No." then begin
                                BomQty:=ProductBomLine.Quantity * "Prod. Order Line".Quantity;
                                ItemNo:=ProductBomLine."No.";
                                Descrp:=ProductBomLine.Description;
                                ActQty:=0;
                                UOM:=ProductBomLine."Unit of Measure Code";
                                ItemRec.Reset;
                                if ItemRec.Get(ItemNo)then UnitCost:=ItemRec."Unit Cost";
                                childDescrptn2_2:=ItemRec."Description 2";
                                if(ActQty * UnitCost) <> 0 then VarianceInPer_2:=(((ActQty * UnitCost) - (UnitCost * BomQty)) / (ActQty * UnitCost)) * 100
                                else
                                    VarianceInPer_2:=0;
                                BomQty_2:=0;
                                ProductBomLine.Next;
                            end
                            else
                            begin
                                UOM:='';
                                ItemNo:='';
                                Descrp:='';
                                childDescrptn2_2:='';
                                BomQty:=0;
                                BomQty_2:="Expected Quantity";
                                ProductBomLine.Next;
                            end;
                        end;
                    }
                    trigger OnAfterGetRecord()
                    begin
                        if Format("Prod. Order Line".Status) = 'Finished' then StatusCheck:='Yes'
                        else
                            StatusCheck:='No';
                        TotalBomQty:=0;
                        TotalActQty:=0;
                        TotalExpCost:=0;
                        TotalUnitCost:=0;
                        TotalActualCost:=0;
                        Countt:=1;
                        ProdOrdRoutingLine.Reset;
                        ProdOrdRoutingLine.SetRange(ProdOrdRoutingLine."Prod. Order No.", "Prod. Order Line"."Prod. Order No.");
                        if ProdOrdRoutingLine.FindFirst then MchnNo:=ProdOrdRoutingLine."No.";
                    end;
                }
            }
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
    trigger OnPreReport()
    begin
    //GrTotalExpCost:=0;
    //GrTotalActualCost:=0;
    end;
    var StatusCheck: Text[5];
    TotalBomQty: Decimal;
    TotalActQty: Decimal;
    TotalExpCost: Decimal;
    TotalUnitCost: Decimal;
    TotalActualCost: Decimal;
    GrTotalBomQty: Decimal;
    GrTotalActQty: Decimal;
    GrTotalExpCost: Decimal;
    GrTotalUnitCost: Decimal;
    GrTotalActualCost: Decimal;
    VarianceInPer: Decimal;
    ItemJounalLine: Record "Item Journal Line";
    ProductBomLine: Record "Production BOM Line";
    Countt: Integer;
    BomQty: Decimal;
    ActQty: Decimal;
    UnitCost: Decimal;
    ExpCost: Decimal;
    ActCost: Decimal;
    VarInRs: Decimal;
    VarInPer: Decimal;
    ItemNo: Code[10];
    Descrp: Text[30];
    UOM: Code[10];
    ItemRec: Record Item;
    VarianceInPer_2: Decimal;
    BomQty_2: Decimal;
    childDescrptn2: Text[30];
    childDescrptn2_2: Text[30];
    ProdOrdRoutingLine: Record "Prod. Order Routing Line";
    MchnNo: Code[10];
    Costing_BreakUp_ReportCaptionLbl: label 'Costing BreakUp Report';
    Actual_CostCaptionLbl: label 'Actual Cost';
    Expected_CostCaptionLbl: label 'Expected Cost';
    Actual_QtyCaptionLbl: label 'Actual Qty';
    BOM_QuantityCaptionLbl: label 'BOM Quantity';
    Description_1CaptionLbl: label 'Description 1';
    Child_Item_No_CaptionLbl: label 'Child Item No.';
    UOMCaptionLbl: label 'UOM';
    Description_1_and_2CaptionLbl: label 'Description 1 and 2';
    whether_Order_finished_in_system_yes_No_CaptionLbl: label 'whether Order finished in system(yes/No)';
    Variance___in_Rs_CaptionLbl: label 'Variance ( in Rs)';
    Variance___in___CaptionLbl: label 'Variance ( in %)';
    Description_2CaptionLbl: label 'Description 2';
    Work_Machine_CenterCaptionLbl: label 'Work/Machine Center';
    Grand_TotalCaptionLbl: label 'Grand Total';
    TotalCaptionLbl: label 'Total';
}
