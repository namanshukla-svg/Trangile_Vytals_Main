Report 50187 "Daily Average Inventory."
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Daily Average Inventory..rdl';
    UsageCategory = ReportsandAnalysis;
    ApplicationArea = all;

    dataset
    {
        dataitem(Item; Item)
        {
            CalcFields = "Net Change";
            DataItemTableView = sorting("No.");
            RequestFilterFields = "Item Category Code", "No.", "Date Filter", "Location Filter", "Global Dimension 1 Filter";

            column(Inventory_Posting_Group; "Inventory Posting Group") { }
            column(ParentCategory; ParentCategory) { }
            column(ReportForNavId_8129; 8129)
            {
            }
            column(Item_GETFILTERS; Item.GetFilters)
            {
            }
            column(Daily_Average_InventoryCaption; Daily_Average_InventoryCaptionLbl)
            {
            }
            column(Average_ValueCaption; Average_ValueCaptionLbl)
            {
            }
            column(Average_Qty_Caption; Average_Qty_CaptionLbl)
            {
            }
            column(Closing_ValueCaption; Closing_ValueCaptionLbl)
            {
            }
            column(Closing_Qty_Caption; Closing_Qty_CaptionLbl)
            {
            }
            column(Opening_ValueCaption; Opening_ValueCaptionLbl)
            {
            }
            column(Opening_Qty_Caption; Opening_Qty_CaptionLbl)
            {
            }
            column(DateCaption; DateCaptionLbl)
            {
            }
            column(Unit_CostCaption; Unit_CostCaptionLbl)
            {
            }
            column(UOMCaption; UOMCaptionLbl)
            {
            }
            column(Item_CategoryCaption; Item_CategoryCaptionLbl)
            {
            }
            column(Description_2Caption; Description_2CaptionLbl)
            {
            }
            column(DescriptionCaption; DescriptionCaptionLbl)
            {
            }
            column(Item_CodeCaption; Item_CodeCaptionLbl)
            {
            }
            column(Item_No_; "No.")
            {
            }
            column(Item_Date_Filter; "Date Filter")
            {
            }
            dataitem(Date; Date)
            {
                DataItemLink = "Period Start" = field("Date Filter");
                DataItemTableView = sorting("Period Type", "Period Start") where("Period Type" = const(Date));

                column(ReportForNavId_9857; 9857)
                {
                }
                column(AvgVal; AvgVal)
                {
                }
                column(AvgQty; AvgQty)
                {
                }
                column(CloVal; CloVal)
                {
                }
                column(CloQty; CloQty)
                {
                }
                column(OpnVal; OpnVal)
                {
                }
                column(OpnQty; OpnQty)
                {
                }
                column(Date_Date__Period_Start_; Date."Period Start")
                {
                }
                column(UnitCost; UnitCost)
                {
                }
                column(Item__Base_Unit_of_Measure_; Item."Base Unit of Measure")
                {
                }
                column(Item__Item_Category_Code_; Item."Item Category Code")
                {
                }
                column(Item__Description_2_; Item."Description 2")
                {
                }
                column(Item_Description; Item.Description)
                {
                }
                column(Item__No__; Item."No.")
                {
                }
                column(Date_Period_Type; "Period Type")
                {
                }
                trigger OnAfterGetRecord()
                begin
                    //UnitCost:=0;
                    OpnQty := 0;
                    OpnVal := 0;
                    CloQty := 0;
                    CloVal := 0;
                    AvgQty := 0;
                    AvgVal := 0;
                    ILE.Reset;
                    ILE.SetCurrentkey("Item No.", "Posting Date");
                    ILE.SetRange(ILE."Item No.", Item."No.");
                    ILE.SetRange(ILE."Posting Date", 0D, Date."Period Start" - 1);
                    ILE.SetRange(ILE."Item Category Code", Item."Item Category Code");
                    ILE.SetFilter(ILE."Global Dimension 1 Code", Item.GetFilter(Item."Global Dimension 1 Filter"));
                    ILE.SetFilter(ILE."Location Code", Item."Location Filter");
                    if ILE.FindFirst then
                        repeat
                            ILE.CalcFields(ILE."Cost Amount (Actual)");
                            OpnQty += ILE.Quantity;
                            OpnVal += ILE."Cost Amount (Actual)";
                        until ILE.Next = 0;
                    if OpnQty = 0 then OpnQty := PrevOpnQty;
                    if OpnVal = 0 then OpnVal := PrevOpnVal;
                    //PrevOpnQty:=OpnQty;
                    //PrevOpnVal:=OpnVal;
                    ILE.Reset;
                    ILE.SetCurrentkey("Item No.", "Posting Date");
                    ILE.SetRange(ILE."Item No.", Item."No.");
                    ILE.SetRange(ILE."Posting Date", Date."Period Start");
                    ILE.SetRange(ILE."Item Category Code", Item."Item Category Code");
                    ILE.SetFilter(ILE."Global Dimension 1 Code", Item.GetFilter(Item."Global Dimension 1 Filter"));
                    ILE.SetFilter(ILE."Location Code", Item."Location Filter");
                    if ILE.FindFirst then
                        repeat
                            ILE.CalcFields(ILE."Cost Amount (Actual)");
                            //IF ILE."Cost Amount (Actual)"<> 0 THEN
                            // UnitCost:=ILE."Cost Amount (Actual)"/ILE.Quantity;
                            CloQty += ILE.Quantity;
                            CloVal += ILE."Cost Amount (Actual)";
                        until ILE.Next = 0;
                    CloQty += OpnQty;
                    CloVal += OpnVal;
                    if CloQty <> 0 then UnitCost := CloVal / CloQty;
                    AvgQty := (OpnQty + CloQty) / 2;
                    AvgVal := (OpnVal + CloVal) / 2;
                    if (XitemNo <> Item."No.") and (I <> 1) then begin
                        PrevOpnQty := 0;
                        PrevOpnVal := 0;
                        OpnQty := 0;
                        OpnVal := 0;
                        CloQty := 0;
                        CloVal := 0;
                        AvgQty := 0;
                        AvgVal := 0;
                    end;
                    I := I + 1;
                    XitemNo := Item."No.";
                end;

                trigger OnPreDataItem()
                begin
                    I := 1;
                end;
            }
            trigger OnAfterGetRecord()
            var
                Category: Record "Item Category";
            begin
                Clear(ParentCategory);
                Category.Reset();
                Category.SetRange(code, Item."Item Category Code");
                if Category.FindFirst() then
                    ParentCategory := Category."Parent Category";
                OpnQty := 0;
                OpnVal := 0;
                CloQty := 0;
                CloVal := 0;
                AvgQty := 0;
                AvgVal := 0;
                I := 1;
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
    trigger OnPostReport()
    begin
        /* // BIS 1145
            IF ExportToExcel THEN BEGIN
              TempExcelBuffer.CreateBook;
              TempExcelBuffer.CreateSheet('Avg Daily Inventory', '', COMPANYNAME, USERID);
              TempExcelBuffer.GiveUserControl;
            END;
            */
        // BIS 1145
    end;

    trigger OnPreReport()
    begin
        RowNo := 1;
    end;

    var
        ILE: Record "Item Ledger Entry";
        UnitCost: Decimal;
        ParentCategory: Code[20];
        OpnQty: Decimal;
        OpnVal: Decimal;
        CloQty: Decimal;
        CloVal: Decimal;
        AvgQty: Decimal;
        AvgVal: Decimal;
        PrevOpnQty: Decimal;
        PrevOpnVal: Decimal;
        TempExcelBuffer: Record "Excel Buffer" temporary;
        ExportToExcel: Boolean;
        RowNo: Integer;
        Daily_Average_InventoryCaptionLbl: label 'Daily Average Inventory';
        Average_ValueCaptionLbl: label 'Average Value';
        Average_Qty_CaptionLbl: label 'Average Qty.';
        Closing_ValueCaptionLbl: label 'Closing Value';
        Closing_Qty_CaptionLbl: label 'Closing Qty.';
        Opening_ValueCaptionLbl: label 'Opening Value';
        Opening_Qty_CaptionLbl: label 'Opening Qty.';
        DateCaptionLbl: label 'Date';
        Unit_CostCaptionLbl: label 'Unit Cost';
        UOMCaptionLbl: label 'UOM';
        Item_CategoryCaptionLbl: label 'Item Category';
        Description_2CaptionLbl: label 'Description 2';
        DescriptionCaptionLbl: label 'Description';
        Item_CodeCaptionLbl: label 'Item Code';
        XitemNo: Code[20];
        I: Integer;

    local procedure EnterCell(RowNo: Integer; ColumnNo: Integer; CellValue: Text[250]; Bold: Boolean; UnderLine: Boolean)
    begin
        TempExcelBuffer.Init;
        TempExcelBuffer.Validate("Row No.", RowNo);
        TempExcelBuffer.Validate("Column No.", ColumnNo);
        TempExcelBuffer."Cell Value as Text" := CellValue;
        TempExcelBuffer.Formula := '';
        TempExcelBuffer.Bold := Bold;
        TempExcelBuffer.Underline := UnderLine;
        TempExcelBuffer.Insert;
    end;
}
