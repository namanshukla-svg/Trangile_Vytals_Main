report 50459 "Production Order Report -MIS"
{
    ApplicationArea = All;
    Caption = 'Production Order Report -MIS';
    UsageCategory = ReportsAndAnalysis;
    ProcessingOnly = true;
    UseRequestPage = true;

    dataset
    {
        dataitem(ItemLedgerEntry; "Item Ledger Entry")
        {
            RequestFilterFields = "Posting Date", "Entry Type", "Document No.";

            trigger OnAfterGetRecord()
            begin
                ParenTCategory:='';
                ExcelBuffer.NewRow();
                if Item.Get(ItemLedgerEntry."Item No.")then begin
                    VARDescription:=Item.Description;
                    VARDescription2:=Item."Description 2";
                    BUOM:=Item."Base Unit of Measure";
                    ItemCategoryCode:=Item."Item Category Code";
                    if ItemCategory.Get(Item."Item Category Code")then if ItemCategory."Parent Category" <> '' then ParenTCategory:=ItemCategory."Parent Category"
                        else
                            ParenTCategory:='';
                end;
                ExcelBuffer.AddColumn(ItemLedgerEntry."Posting Date", false, '', false, false, false, '', ExcelBuffer."cell type"::Date);
                ExcelBuffer.AddColumn(ItemLedgerEntry."Entry Type", false, '', false, false, false, '', ExcelBuffer."cell type"::Text);
                ExcelBuffer.AddColumn(ItemLedgerEntry."Item No.", false, '', false, false, false, '', ExcelBuffer."cell type"::Text);
                ExcelBuffer.AddColumn(ItemLedgerEntry."Lot No.", false, '', false, false, false, '', ExcelBuffer."cell type"::Text);
                ExcelBuffer.AddColumn(VARDescription, false, '', false, false, false, '', ExcelBuffer."cell type"::Text);
                ExcelBuffer.AddColumn(VARDescription2, false, '', false, false, false, '', ExcelBuffer."cell type"::Text);
                ExcelBuffer.AddColumn(ItemLedgerEntry."Document No.", false, '', false, false, false, '', ExcelBuffer."cell type"::Text);
                ExcelBuffer.AddColumn(BUOM, false, '', false, false, false, '', ExcelBuffer."cell type"::Text);
                ExcelBuffer.AddColumn(ItemLedgerEntry.Quantity, false, '', false, false, false, '', ExcelBuffer."cell type"::Number);
                ExcelBuffer.AddColumn(ParenTCategory, false, '', false, false, false, '', ExcelBuffer."cell type"::Text);
                ExcelBuffer.AddColumn(ItemCategoryCode, false, '', false, false, false, '', ExcelBuffer."cell type"::Text);
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
    ParenTCategory: Text;
    VARDescription: Text;
    VARDescription2: Text;
    BUOM: Text;
    ItemCategoryCode: Text;
    procedure CreateHeading()
    begin
        ExcelBuffer.NewRow();
        ExcelBuffer.AddColumn('Posting Date', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
        ExcelBuffer.AddColumn('Entry Type', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
        ExcelBuffer.AddColumn('Item No_', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
        ExcelBuffer.AddColumn('Lot No.', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
        ExcelBuffer.AddColumn('Description', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
        ExcelBuffer.AddColumn('Description 2', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
        ExcelBuffer.AddColumn('Document No_', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
        ExcelBuffer.AddColumn('Base Unit of Measure', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
        ExcelBuffer.AddColumn('Quantity', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
        ExcelBuffer.AddColumn('Item Category Code', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
        ExcelBuffer.AddColumn('Product Group Code', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
    end;
    Local procedure CreateExcelBook();
    begin
        ExcelBuffer.CreateNewBook('Production Order Report -MIS');
        ExcelBuffer.WriteSheet('Production Order Report -MIS', CompanyName, UserId);
        ExcelBuffer.CloseBook();
        ExcelBuffer.SetFriendlyFilename('Production Order Report -MIS');
        ExcelBuffer.OpenExcel();
    end;
}
