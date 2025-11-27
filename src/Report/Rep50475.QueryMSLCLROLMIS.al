report 50475 "Query MSL CL ROL - MIS"
{
    ApplicationArea = All;
    Caption = 'Query MSL CL ROL - MIS';
    UsageCategory = ReportsAndAnalysis;
    ProcessingOnly = true;
    UseRequestPage = true;

    dataset
    {
        dataitem(Item; Item)
        {
            trigger OnAfterGetRecord()
            begin
                QTYONPO:=0;
                TotalInventory:=0;
                EffectiveInventory:=0;
                PurchaseLineRec.Reset();
                PurchaseLineRec.SetRange("Document Type", PurchaseLineRec."Document Type"::Order);
                PurchaseLineRec.SetRange(Type, PurchaseLineRec.Type::Item);
                PurchaseLineRec.SetRange("No.", Item."No.");
                if PurchaseLineRec.FindSet()then repeat QTYONPO+=PurchaseLineRec."Outstanding Qty. (Base)";
                    until PurchaseLineRec.Next() = 0;
                ItemLedgerEntryRec.Reset();
                ItemLedgerEntryRec.SetRange("Item No.", "No.");
                if ItemLedgerEntryRec.FindSet()then repeat TotalInventory+=ItemLedgerEntryRec.Quantity;
                    until ItemLedgerEntryRec.Next() = 0;
                ItemLedgerEntryRec.Reset();
                ItemLedgerEntryRec.SetRange("Item No.", "No.");
                ItemLedgerEntryRec.SetFilter("Location Code", '<>%1&<>%2&<>%3&<>%4', 'STR_DAMAGE', 'STR_REJ', 'STR_D3', 'STR_REJ U2');
                if ItemLedgerEntryRec.FindSet()then repeat EffectiveInventory+=ItemLedgerEntryRec.Quantity;
                    until ItemLedgerEntryRec.Next() = 0;
                ExcelBuffer.NewRow();
                ExcelBuffer.AddColumn(Item."No.", false, '', false, false, false, '', ExcelBuffer."cell type"::Text);
                ExcelBuffer.AddColumn(Item.Description, false, '', false, false, false, '', ExcelBuffer."cell type"::Text);
                ExcelBuffer.AddColumn(Item."Description 2", false, '', false, false, false, '', ExcelBuffer."cell type"::Text);
                ExcelBuffer.AddColumn(Item."Base Unit of Measure", false, '', false, false, false, '', ExcelBuffer."cell type"::Text);
                ExcelBuffer.AddColumn(Item."Safety Stock Quantity", false, '', false, false, false, '', ExcelBuffer."cell type"::Number);
                ExcelBuffer.AddColumn(Item."Minimum Order Quantity", false, '', false, false, false, '', ExcelBuffer."cell type"::Number);
                ExcelBuffer.AddColumn(Item."Maximum Order Quantity", false, '', false, false, false, '', ExcelBuffer."cell type"::Number);
                ExcelBuffer.AddColumn(QTYONPO, false, '', false, false, false, '', ExcelBuffer."cell type"::Number);
                ExcelBuffer.AddColumn(TotalInventory, false, '', false, false, false, '', ExcelBuffer."cell type"::Number);
                ExcelBuffer.AddColumn(EffectiveInventory, false, '', false, false, false, '', ExcelBuffer."cell type"::Number);
                ExcelBuffer.AddColumn(Item."Replenishment System", false, '', false, false, false, '', ExcelBuffer."cell type"::Text);
                ExcelBuffer.AddColumn(EffectiveInventory - Item."Safety Stock Quantity", false, '', false, false, false, '', ExcelBuffer."cell type"::Number);
                ExcelBuffer.AddColumn(EffectiveInventory - Item."Minimum Order Quantity", false, '', false, false, false, '', ExcelBuffer."cell type"::Number);
                ExcelBuffer.AddColumn(EffectiveInventory - Item."Maximum Order Quantity", false, '', false, false, false, '', ExcelBuffer."cell type"::Number);
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
    PurchaseLineRec: Record "Purchase Line";
    ItemLedgerEntryRec: Record "Item Ledger Entry";
    QTYONPO: Decimal;
    TotalInventory: Decimal;
    EffectiveInventory: Decimal;
    procedure CreateHeading()
    begin
        ExcelBuffer.NewRow();
        ExcelBuffer.AddColumn('No_', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
        ExcelBuffer.AddColumn('Description', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
        ExcelBuffer.AddColumn('Description 2', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
        ExcelBuffer.AddColumn('UOM', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
        ExcelBuffer.AddColumn('MSL', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
        ExcelBuffer.AddColumn('CL', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
        ExcelBuffer.AddColumn('ROL', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
        ExcelBuffer.AddColumn('QTY. ON PO', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
        ExcelBuffer.AddColumn('Total Inventory', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
        ExcelBuffer.AddColumn('Effective Inventory', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
        ExcelBuffer.AddColumn('Replenishment', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
        ExcelBuffer.AddColumn('SHORT QTY. MSL', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
        ExcelBuffer.AddColumn('SHORT QTY. CL', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
        ExcelBuffer.AddColumn('SHORT QTY. ROL', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
    end;
    Local procedure CreateExcelBook();
    begin
        ExcelBuffer.CreateNewBook('Query MSL CL ROL - MIS');
        ExcelBuffer.WriteSheet('Query MSL CL ROL - MIS', CompanyName, UserId);
        ExcelBuffer.CloseBook();
        ExcelBuffer.SetFriendlyFilename('Query MSL CL ROL - MIS');
        ExcelBuffer.OpenExcel();
    end;
}
