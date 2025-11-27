report 50476 "Inv Slow Moving and Non-Moving"
{
    ApplicationArea = All;
    Caption = 'Inventory Slow Moving and Non-Moving Report - MIS';
    UsageCategory = ReportsAndAnalysis;
    ProcessingOnly = true;
    UseRequestPage = true;

    dataset
    {
        dataitem(ItemLedgerEntry; "Item Ledger Entry")
        {
            RequestFilterFields = "Location Code";
            DataItemTableView = where("Remaining Quantity"=filter(>0), Open=filter(true));

            trigger OnAfterGetRecord()
            begin
                ParenTCategory:='';
                Replenishment:='';
                VarientName:='';
                if Item.Get(ItemLedgerEntry."Item No.")then begin
                    VARDescription:=Item.Description;
                    VARDescription2:=Item."Description 2";
                    ItemCategoryCode:=Item."Item Category Code";
                    Replenishment:=Format(Item."Replenishment System");
                    if ItemCategory.Get(Item."Item Category Code")then if ItemCategory."Parent Category" <> '' then ParenTCategory:=ItemCategory."Parent Category"
                        else
                            ParenTCategory:='';
                end;
                if ItemVarientRec.Get(ItemLedgerEntry."Item No.", "Variant Code")then VarientName:=ItemVarientRec.Description;
                ExcelBuffer.NewRow();
                ExcelBuffer.AddColumn(ItemLedgerEntry."Item No.", false, '', false, false, false, '', ExcelBuffer."cell type"::Text);
                ExcelBuffer.AddColumn(VARDescription, false, '', false, false, false, '', ExcelBuffer."cell type"::Text);
                ExcelBuffer.AddColumn(VARDescription2, false, '', false, false, false, '', ExcelBuffer."cell type"::Text);
                ExcelBuffer.AddColumn(ParenTCategory, false, '', false, false, false, '', ExcelBuffer."cell type"::Text);
                ExcelBuffer.AddColumn(ItemCategoryCode, false, '', false, false, false, '', ExcelBuffer."cell type"::Text);
                ExcelBuffer.AddColumn(ItemLedgerEntry."Posting Date", false, '', false, false, false, '', ExcelBuffer."cell type"::Date);
                ExcelBuffer.AddColumn(ItemLedgerEntry."Unit of Measure Code", false, '', false, false, false, '', ExcelBuffer."cell type"::Text);
                ExcelBuffer.AddColumn(ItemLedgerEntry."Variant Code", false, '', false, false, false, '', ExcelBuffer."cell type"::Text);
                ExcelBuffer.AddColumn(VarientName, false, '', false, false, false, '', ExcelBuffer."cell type"::Text);
                ExcelBuffer.AddColumn(ItemLedgerEntry."Location Code", false, '', false, false, false, '', ExcelBuffer."cell type"::Text);
                ExcelBuffer.AddColumn(ItemLedgerEntry."Lot No.", false, '', false, false, false, '', ExcelBuffer."cell type"::Text);
                ExcelBuffer.AddColumn(ItemLedgerEntry."Remaining Quantity", false, '', false, false, false, '', ExcelBuffer."cell type"::Number);
                ExcelBuffer.AddColumn(Replenishment, false, '', false, false, false, '', ExcelBuffer."cell type"::Text);
                ExcelBuffer.AddColumn(Today - ItemLedgerEntry."Posting Date", false, '', false, false, false, '', ExcelBuffer."cell type"::Text);
                ExcelBuffer.AddColumn(ItemLedgerEntry."Manufacturing date", false, '', false, false, false, '', ExcelBuffer."cell type"::Date);
                ExcelBuffer.AddColumn(ItemLedgerEntry."Expiration Date", false, '', false, false, false, '', ExcelBuffer."cell type"::Date);
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
    ItemVarientRec: Record "Item Variant";
    VarientName: Text;
    Replenishment: Text;
    procedure CreateHeading()
    begin
        ExcelBuffer.NewRow();
        ExcelBuffer.AddColumn('Item No_', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
        ExcelBuffer.AddColumn('Description', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
        ExcelBuffer.AddColumn('Description 2', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
        ExcelBuffer.AddColumn('Item Category Code', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
        ExcelBuffer.AddColumn('Product Group Code', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
        ExcelBuffer.AddColumn('Posting Date', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
        ExcelBuffer.AddColumn('UOM', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
        ExcelBuffer.AddColumn('Variant Code', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
        ExcelBuffer.AddColumn('Variant Name', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
        ExcelBuffer.AddColumn('Location Code', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
        ExcelBuffer.AddColumn('Lot No_', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
        ExcelBuffer.AddColumn('Quantity', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
        ExcelBuffer.AddColumn('Replenishment', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
        ExcelBuffer.AddColumn('Age', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
        ExcelBuffer.AddColumn('Manufacturing Date', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
        ExcelBuffer.AddColumn('Expiration Date', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
    end;
    Local procedure CreateExcelBook();
    begin
        ExcelBuffer.CreateNewBook('Inventory Slow Moving and Non-Moving Report - MIS');
        ExcelBuffer.WriteSheet('Inventory Slow Moving and Non-Moving Report - MIS', CompanyName, UserId);
        ExcelBuffer.CloseBook();
        ExcelBuffer.SetFriendlyFilename('Inventory Slow Moving and Non-Moving Report - MIS');
        ExcelBuffer.OpenExcel();
    end;
}
