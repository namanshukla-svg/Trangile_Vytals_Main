Report 50119 "Agewise Inventory"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Agewise Inventory.rdl';
    // UsageCategory = Lists;
    UsageCategory = ReportsandAnalysis;
    ApplicationArea = all;

    dataset
    {
        dataitem(Item; Item)
        {
            CalcFields = "Net Change";
            DataItemTableView = order(ascending)where("Net Change"=filter(>0));
            PrintOnlyIfDetail = true;
            RequestFilterFields = "No.", "Item Category Code", "Date Filter", "Location Filter";

            column(ReportForNavId_8129;8129)
            {
            }
            column(Greatethan; Greatethan)
            {
            }
            column(Lessthan; Lessthan)
            {
            }
            column(Item_GETFILTERS; Item.GetFilters)
            {
            }
            column(Item__No__; "No.")
            {
            }
            column(Description__Description_2_; Description + "Description 2")
            {
            }
            column(Item_Item__Location_Filter_; Item."Location Filter")
            {
            }
            column(Item__Item_Category_Code_; "Item Category Code")
            {
            }
            column(Item__Replenishment_System_; "Replenishment System")
            {
            }
            column(Item_Item__Net_Change_; Item."Net Change")
            {
            }
            column(Item__Net_Change___Unit_Cost_; Item."Net Change" * "Unit Cost")
            {
            }
            column(Item_Item__Unit_Cost_; Item."Unit Cost")
            {
            }
            column(Item_Item__Base_Unit_of_Measure_; Item."Base Unit of Measure")
            {
            }
            column(Item_Ledger_Entry___Remaining_Quantity__Item__Unit_Cost_; "Item Ledger Entry"."Remaining Quantity" * Item."Unit Cost")
            {
            }
            column(Total__;'Total:')
            {
            }
            column(Report_Agewise_InventoryCaption; Report_Agewise_InventoryCaptionLbl)
            {
            }
            column(Item__No__Caption; FieldCaption("No."))
            {
            }
            column(DescriptionCaption; DescriptionCaptionLbl)
            {
            }
            column(Location_CodeCaption; Location_CodeCaptionLbl)
            {
            }
            column(Item__Item_Category_Code_Caption; FieldCaption("Item Category Code"))
            {
            }
            column(Item__Replenishment_System_Caption; FieldCaption("Replenishment System"))
            {
            }
            column(Receipt___Production_Qty_Caption; Receipt___Production_Qty_CaptionLbl)
            {
            }
            column(Qty__in_Inventory_as_on_dateCaption; Qty__in_Inventory_as_on_dateCaptionLbl)
            {
            }
            column(Document_Source_Ref_Caption; Document_Source_Ref_CaptionLbl)
            {
            }
            column(Mfg__Recd__DateCaption; Mfg__Recd__DateCaptionLbl)
            {
            }
            column(Unit_CostCaption; Unit_CostCaptionLbl)
            {
            }
            column(Age_as_on_dateCaption; Age_as_on_dateCaptionLbl)
            {
            }
            column(Expiry_DateCaption; Expiry_DateCaptionLbl)
            {
            }
            column(Value_of_Inventory_as_on_dateCaption; Value_of_Inventory_as_on_dateCaptionLbl)
            {
            }
            column(U_O_MCaption; U_O_MCaptionLbl)
            {
            }
            column(Item_Date_Filter; "Date Filter")
            {
            }
            dataitem("Item Ledger Entry"; "Item Ledger Entry")
            {
                DataItemLink = "Item No."=field("No."), "Location Code"=field("Location Filter"), "Posting Date"=field("Date Filter");
                DataItemTableView = sorting("Item No.", "Posting Date")order(ascending)where("Remaining Quantity"=filter(>0));
                RequestFilterFields = "Expiration Date";

                column(ReportForNavId_7209;7209)
                {
                }
                column(Item_Ledger_Entry__Item_Ledger_Entry__Quantity; "Item Ledger Entry".Quantity)
                {
                }
                column(Item_Ledger_Entry__Document_No__; "Document No.")
                {
                }
                column(Item_Ledger_Entry__Posting_Date_; "Posting Date")
                {
                }
                column(Item__Unit_Cost_; Item."Unit Cost")
                {
                }
                column(Item_Ledger_Entry__Item_Ledger_Entry___Remaining_Quantity_; "Item Ledger Entry"."Remaining Quantity")
                {
                }
                column(Item_Ledger_Entry__Expiration_Date_; "Expiration Date")
                {
                }
                column(Item_Ledger_Entry___Remaining_Quantity__Item__Unit_Cost__Control1000000026; "Item Ledger Entry"."Remaining Quantity" * Item."Unit Cost")
                {
                }
                column(Item_Ledger_Entry__Item_Ledger_Entry___Location_Code_; "Item Ledger Entry"."Location Code")
                {
                }
                column(Age; Age)
                {
                }
                column(Item__Base_Unit_of_Measure_; Item."Base Unit of Measure")
                {
                }
                column(Item_Ledger_Entry__Item_Ledger_Entry___Lot_No__; "Item Ledger Entry"."Lot No.")
                {
                }
                column(Item_Ledger_Entry_Entry_No_; "Entry No.")
                {
                }
                column(Item_Ledger_Entry_Item_No_; "Item No.")
                {
                }
                trigger OnAfterGetRecord()
                begin
                    Age:=Item.GetRangemax(Item."Date Filter") - "Item Ledger Entry"."Posting Date";
                /*
                    IF ((Greatethan<>0) OR (Lessthan<>0)) THEN
                    CurrReport.SKIP;
                    
                    IF Greatethan<> 0 THEN
                    IF Age<Greatethan THEN
                    CurrReport.SKIP;
                    
                    IF Lessthan<> 0 THEN
                    IF Age>Lessthan THEN
                    CurrReport.SKIP;
                     */
                end;
            }
            trigger OnPreDataItem()
            begin
                Item.SetFilter(Item."Date Filter", '%1..%2', 0D, Item.GetRangemax(Item."Date Filter"));
            end;
        }
    }
    requestpage
    {
        layout
        {
            area(content)
            {
                field(Greatethan; Greatethan)
                {
                    ApplicationArea = All;
                    Caption = 'Age Greater Than';
                }
                field(Lessthan; Lessthan)
                {
                    ApplicationArea = All;
                    Caption = 'Age Less Than';
                }
            }
        }
        actions
        {
        }
    }
    labels
    {
    }
    var Item1: Record Item;
    Age: Decimal;
    Greatethan: Decimal;
    Lessthan: Decimal;
    Report_Agewise_InventoryCaptionLbl: label 'Report Agewise Inventory';
    DescriptionCaptionLbl: label 'Description';
    Location_CodeCaptionLbl: label 'Location Code';
    Receipt___Production_Qty_CaptionLbl: label 'Receipt / Production Qty.';
    Qty__in_Inventory_as_on_dateCaptionLbl: label 'Qty. in Inventory as on date';
    Document_Source_Ref_CaptionLbl: label 'Document Source Ref.';
    Mfg__Recd__DateCaptionLbl: label 'Mfg./Recd. Date';
    Unit_CostCaptionLbl: label 'Unit Cost';
    Age_as_on_dateCaptionLbl: label 'Age as on date';
    Expiry_DateCaptionLbl: label 'Expiry Date';
    Value_of_Inventory_as_on_dateCaptionLbl: label 'Value of Inventory as on date';
    U_O_MCaptionLbl: label 'U.O.M';
}
