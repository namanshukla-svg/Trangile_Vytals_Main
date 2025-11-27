Report 50113 "Report-Agewise Inventory"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Report-Agewise Inventory.rdl';
    UsageCategory = ReportsandAnalysis;
    ApplicationArea = all;

    dataset
    {
        dataitem(Item; Item)
        {
            DataItemTableView = sorting("No.")where(Blocked=const(false));

            column(ReportForNavId_8129;8129)
            {
            }
            column(Agewise_InventoryCaption; Agewise_InventoryCaptionLbl)
            {
            }
            column(Item_CodeCaption; Item_CodeCaptionLbl)
            {
            }
            column(Desc_1Caption; Desc_1CaptionLbl)
            {
            }
            column(Location_CodeCaption; Location_CodeCaptionLbl)
            {
            }
            column(Desc_2Caption; Desc_2CaptionLbl)
            {
            }
            column(Replenishment_SystemCaption; Replenishment_SystemCaptionLbl)
            {
            }
            column(Item_CategoryCaption; Item_CategoryCaptionLbl)
            {
            }
            column(Age_As_On_DateCaption; Age_As_On_DateCaptionLbl)
            {
            }
            column(Unit_Cost__Including_Expected_Cost_Caption; Unit_Cost__Including_Expected_Cost_CaptionLbl)
            {
            }
            column(Mfg__Recd__DateCaption; Mfg__Recd__DateCaptionLbl)
            {
            }
            column(Document_Source_Ref_Caption; Document_Source_Ref_CaptionLbl)
            {
            }
            column(Inventory_As_on_DateCaption; Inventory_As_on_DateCaptionLbl)
            {
            }
            column(Receipt_Prod__Qty_Caption; Receipt_Prod__Qty_CaptionLbl)
            {
            }
            column(Value_of_Inventory_as_on_dateCaption; Value_of_Inventory_as_on_dateCaptionLbl)
            {
            }
            column(Expire_DateCaption; Expire_DateCaptionLbl)
            {
            }
            column(Item_No_; "No.")
            {
            }
            dataitem("Item Ledger Entry"; "Item Ledger Entry")
            {
                DataItemLink = "Item No."=field("No.");
                DataItemTableView = sorting("Item No.", "Posting Date");

                column(ReportForNavId_7209;7209)
                {
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
    var Agewise_InventoryCaptionLbl: label 'Agewise Inventory';
    Item_CodeCaptionLbl: label 'Item Code';
    Desc_1CaptionLbl: label 'Desc.1';
    Location_CodeCaptionLbl: label 'Location Code';
    Desc_2CaptionLbl: label 'Desc.2';
    Replenishment_SystemCaptionLbl: label 'Replenishment System';
    Item_CategoryCaptionLbl: label 'Item Category';
    Age_As_On_DateCaptionLbl: label 'Age As On Date';
    Unit_Cost__Including_Expected_Cost_CaptionLbl: label 'Unit Cost (Including Expected Cost)';
    Mfg__Recd__DateCaptionLbl: label 'Mfg./Recd. Date';
    Document_Source_Ref_CaptionLbl: label 'Document Source Ref.';
    Inventory_As_on_DateCaptionLbl: label 'Inventory As on Date';
    Receipt_Prod__Qty_CaptionLbl: label 'Receipt/Prod. Qty.';
    Value_of_Inventory_as_on_dateCaptionLbl: label 'Value of Inventory as on date';
    Expire_DateCaptionLbl: label 'Expire Date';
}
