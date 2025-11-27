report 50463 "Inventory by Location - MIS"
{
    ApplicationArea = All;
    Caption = 'Inventory by Location - MIS';
    UsageCategory = ReportsAndAnalysis;
    ProcessingOnly = true;
    UseRequestPage = true;

    dataset
    {
        dataitem(ItemLedgerEntry; "Item Ledger Entry")
        {
            RequestFilterFields = "Location Code";
            DataItemTableView = where("Remaining Quantity"=filter(>0));

            trigger OnAfterGetRecord()
            begin
                ParenTCategory:='';
                if Item.Get(ItemLedgerEntry."Item No.")then begin
                    VARDescription:=Item.Description;
                    VARDescription2:=Item."Description 2";
                    VARDescription3:=Item."Description 3";
                    UnitCost:=Item."Unit Cost";
                    MSL:=Item."Minimum Order Quantity";
                    ItemCategoryCode:=Item."Item Category Code";
                    if ItemCategory.Get(Item."Item Category Code")then if ItemCategory."Parent Category" <> '' then ParenTCategory:=ItemCategory."Parent Category"
                        else
                            ParenTCategory:='';
                end;
                ExcelBuffer.NewRow();
                ExcelBuffer.AddColumn(ItemLedgerEntry."Posting Date", false, '', false, false, false, '', ExcelBuffer."cell type"::Date);
                // ExcelBuffer.AddColumn(ItemLedgerEntry."Entry Type", false, '', false, false, false, '', ExcelBuffer."cell type"::Text);
                // ExcelBuffer.AddColumn(ItemLedgerEntry."Document No.", false, '', false, false, false, '', ExcelBuffer."cell type"::Text);
                ExcelBuffer.AddColumn(ItemLedgerEntry."Item No.", false, '', false, false, false, '', ExcelBuffer."cell type"::Text);
                ExcelBuffer.AddColumn(ItemLedgerEntry."Variant Code", false, '', false, false, false, '', ExcelBuffer."cell type"::Text);
                ExcelBuffer.AddColumn(VARDescription, false, '', false, false, false, '', ExcelBuffer."cell type"::Text);
                ExcelBuffer.AddColumn(VARDescription2, false, '', false, false, false, '', ExcelBuffer."cell type"::Text);
                ExcelBuffer.AddColumn(VARDescription3, false, '', false, false, false, '', ExcelBuffer."cell type"::Text);
                ExcelBuffer.AddColumn(ParenTCategory, false, '', false, false, false, '', ExcelBuffer."cell type"::Text);
                ExcelBuffer.AddColumn(ItemCategoryCode, false, '', false, false, false, '', ExcelBuffer."cell type"::Text);
                ExcelBuffer.AddColumn(ItemLedgerEntry."Unit of Measure Code", false, '', false, false, false, '', ExcelBuffer."cell type"::Text);
                ExcelBuffer.AddColumn(UnitCost, false, '', false, false, false, '', ExcelBuffer."cell type"::Text);
                ExcelBuffer.AddColumn(ItemLedgerEntry."Lot No.", false, '', false, false, false, '', ExcelBuffer."cell type"::Text);
                ExcelBuffer.AddColumn(ItemLedgerEntry."Manufacturing date", false, '', false, false, false, '', ExcelBuffer."cell type"::Date);
                ExcelBuffer.AddColumn(ItemLedgerEntry."Expiration Date", false, '', false, false, false, '', ExcelBuffer."cell type"::Date);
                ExcelBuffer.AddColumn(ItemLedgerEntry."Location Code", false, '', false, false, false, '', ExcelBuffer."cell type"::Text);
                // ExcelBuffer.AddColumn(ItemLedgerEntry.Quantity, false, '', false, false, false, '', ExcelBuffer."cell type"::Number);
                ExcelBuffer.AddColumn(ItemLedgerEntry."Remaining Quantity", false, '', false, false, false, '', ExcelBuffer."cell type"::Number);
                ExcelBuffer.AddColumn(MSL, false, '', false, false, false, '', ExcelBuffer."cell type"::Number);
                ExcelBuffer.AddColumn(ItemLedgerEntry."Remaining Quantity" * UnitCost, false, '', false, false, false, '', ExcelBuffer."cell type"::Number);
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
    trigger OnPreReport()
    begin
        ExcelBuffer.DeleteAll();
        CreateHeading();
    end;
    trigger OnPostReport()
    begin
        CreateExcelBook();
    end;
    var ExcelBuffer: Record "Excel Buffer";
    Item: Record Item;
    ItemCategory: Record "Item Category";
    ItemCategoryCode: Text;
    ParenTCategory: Text;
    VARDescription: Text;
    VARDescription2: Text;
    VARDescription3: Text;
    MSL: Decimal;
    UnitCost: Decimal;
    procedure CreateHeading()
    begin
        ExcelBuffer.NewRow();
        ExcelBuffer.AddColumn('Posting Date', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
        // ExcelBuffer.AddColumn('Entry Type', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
        // ExcelBuffer.AddColumn('Document No_', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
        ExcelBuffer.AddColumn('Item No_', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
        ExcelBuffer.AddColumn('Variant Code', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
        ExcelBuffer.AddColumn('Description', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
        ExcelBuffer.AddColumn('Description 2', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
        ExcelBuffer.AddColumn('Description 3', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
        ExcelBuffer.AddColumn('Item Category', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
        ExcelBuffer.AddColumn('Product Group', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
        ExcelBuffer.AddColumn('UOM', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
        ExcelBuffer.AddColumn('Unit Cost', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
        ExcelBuffer.AddColumn('Lot No_', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
        ExcelBuffer.AddColumn('Manufacturing Date', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
        ExcelBuffer.AddColumn('Expiration Date', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
        ExcelBuffer.AddColumn('Location', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
        //ExcelBuffer.AddColumn('Quantity', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
        ExcelBuffer.AddColumn('Quantity', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
        ExcelBuffer.AddColumn('MSL', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
        ExcelBuffer.AddColumn('Value', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
    end;
    Local procedure CreateExcelBook();
    begin
        ExcelBuffer.CreateNewBook('Inventory by Location - MIS');
        ExcelBuffer.WriteSheet('Inventory by Location - MIS', CompanyName, UserId);
        ExcelBuffer.CloseBook();
        ExcelBuffer.SetFriendlyFilename('Inventory by Location - MIS');
        ExcelBuffer.OpenExcel();
    end;
}
