report 50478 "Inv. Dashboard Query Report"
{
    ApplicationArea = All;
    Caption = 'Inv. Dashboard Query Report';
    UsageCategory = ReportsAndAnalysis;
    // DefaultLayout = Excel;
    // ExcelLayout = './Layouts/InvDashboardQueryReport.xlsx';
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/InvDashboardQueryReport.rdl';

    dataset
    {
        dataitem(Integer; "Integer")
        {
            column(InventoryDashboardQuery_PostingDate; InventoryDashboardQuery.PostingDate)
            {
            }
            column(InventoryDashboardQuery_ItemNo; InventoryDashboardQuery.ItemNo)
            {
            }
            column(InventoryDashboardQuery_Description; InventoryDashboardQuery.Description)
            {
            }
            column(InventoryDashboardQuery_Description2; InventoryDashboardQuery.Description2)
            {
            }
            column(InventoryDashboardQuery_LocationCode; InventoryDashboardQuery.LocationCode)
            {
            }
            column(InventoryDashboardQuery_UnitofMeasureCode; InventoryDashboardQuery.UnitofMeasureCode)
            {
            }
            column(InventoryDashboardQuery_Quantity; InventoryDashboardQuery.RemainingQuantity)
            {
            }
            column(InventoryDashboardQuery_Value; Round(((InventoryDashboardQuery.CostAmountActual + InventoryDashboardQuery.CostAmountExpected) / InventoryDashboardQuery.Quantity * InventoryDashboardQuery.RemainingQuantity) / 100000, 0.01, '='))
            {
            }
            column(InventoryDashboardQuery_ProcurementType; InventoryDashboardQuery.ProcurementType)
            {
            }
            column(InventoryDashboardQuery_GenProdPostingGroup; InventoryDashboardQuery.GenProdPostingGroup)
            {
            }
            column(InventoryDashboardQuery_Parent_Category; InventoryDashboardQuery.Parent_Category)
            {
            }
            trigger OnAfterGetRecord()
            begin
                // InventoryDashboardQuery.Open();
                if not InventoryDashboardQuery.Read()then CurrReport.Break();
            end;
            trigger OnPreDataItem()
            begin
                // SetRange(Number, 1);
                InventoryDashboardQuery.Open();
            end;
        }
    }
    requestpage
    {
        layout
        {
            area(content)
            {
                group(GroupName)
                {
                }
            }
        }
        actions
        {
            area(processing)
            {
            }
        }
    }
    var InventoryDashboardQuery: Query "Inventory Dashboard Query";
// PostingDate: Date;
// ItemNo_: Code[20];
// Description: Text[100];
// Description2: Text[50];
// LocationCode: Code[20];
// UOM: Code[20];
// Qty: Decimal;
// Value: Decimal;
// ProcurementType: Code[20];
// ValueCat: Code[20];
// ItemCategoryCode: Code[20];
}
