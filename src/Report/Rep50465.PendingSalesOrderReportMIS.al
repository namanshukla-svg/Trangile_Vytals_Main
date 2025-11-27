report 50465 "Pending Sales Order Report-MIS"
{
    ApplicationArea = All;
    Caption = 'Pending Sales Order Report - MIS';
    UsageCategory = ReportsAndAnalysis;
    ProcessingOnly = true;
    UseRequestPage = true;

    dataset
    {
        dataitem("Sales Header"; "Sales Header")
        {
            DataItemTableView = SORTING("Document Type", "No.")WHERE("Document Type"=filter(Order), "Document Subtype"=filter(order));
            RequestFilterFields = "Order Date";

            dataitem("Sales Line"; "Sales Line")
            {
                DataItemLinkReference = "Sales Header";
                DataItemLink = "Document No."=field("No.");
                DataItemTableView = sorting("Document Type", "Document No.", "Line No.")WHERE("Document Type"=filter(Order), "Document Subtype"=filter(order), "Outstanding Quantity"=filter(>0));

                trigger OnAfterGetRecord()
                begin
                    MOQ:=0;
                    ManufacturingLeadTime:=0;
                    InventoryVar:=0;
                    Clear(Desc3);
                    varItem.Reset();
                    varItem.SetRange("No.", "Sales Line"."No.");
                    varItem.SetFilter("Location Filter", '<>%1&<>%2&<>%3', 'STR_REJ', 'STR_DAMAGE', 'STR_D3');
                    varItem.SetRange("Variant Filter", "Sales Line"."Variant Code");
                    if varItem.FindFirst()then begin
                        varItem.CalcFields(Inventory);
                        InventoryVar:=varItem.Inventory;
                        Desc3:=varItem."Description 3";
                    end;
                    if varItem.Get("Sales Line"."No.")then begin
                        MOQ:=varItem."Minimum Order Quantity";
                        ManufacturingLeadTime:=varItem."Lead time in days";
                        Desc3:=varItem."Description 3";
                    end;
                    IF CUSTOMER.Get("Sales Header"."Sell-to Customer No.")then if CUSTOMER.Blocked = CUSTOMER.Blocked::" " then BlockStatus:='Active'
                        else
                            BlockStatus:=Format(CUSTOMER.Blocked);
                    if "Shipment Date" <> 0D then if "Sales Header"."Order Date" <> 0D then DaysDiff:="Shipment Date" - "Sales Header"."Order Date"
                        else
                            DaysDiff:=0
                    ELSE
                        DaysDiff:=0;
                    if ItemCategory.Get("Sales Line"."Item Category Code")then if ItemCategory."Parent Category" <> '' then PrentCategory:=ItemCategory."Parent Category"
                        else
                            PrentCategory:=''
                    else
                        PrentCategory:='';
                    ExcelBuffer.NewRow();
                    ExcelBuffer.AddColumn("Sales Header"."No.", false, '', false, false, false, '', ExcelBuffer."cell type"::Text);
                    ExcelBuffer.AddColumn("Sales Header"."Order Date", false, '', false, false, false, '', ExcelBuffer."cell type"::Date);
                    ExcelBuffer.AddColumn("Sales Header".Status, false, '', false, false, false, '', ExcelBuffer."cell type"::Text);
                    ExcelBuffer.AddColumn("Sales Header"."Bill-to Customer No.", false, '', false, false, false, '', ExcelBuffer."cell type"::Text);
                    ExcelBuffer.AddColumn("Sales Header"."Bill-to Name", false, '', false, false, false, '', ExcelBuffer."cell type"::Text);
                    ExcelBuffer.AddColumn("Sales Header"."Ship-to Name", false, '', false, false, false, '', ExcelBuffer."cell type"::Text);
                    ExcelBuffer.AddColumn("Sales Header"."Sell-to Customer No.", false, '', false, false, false, '', ExcelBuffer."cell type"::Text);
                    ExcelBuffer.AddColumn("Sales Header"."Sell-to Customer Name", false, '', false, false, false, '', ExcelBuffer."cell type"::Text);
                    ExcelBuffer.AddColumn("Sales Header"."External Document No.", false, '', false, false, false, '', ExcelBuffer."cell type"::Text);
                    ExcelBuffer.AddColumn("Sales Header"."Salesperson Code", false, '', false, false, false, '', ExcelBuffer."cell type"::Text);
                    ExcelBuffer.AddColumn(PrentCategory, false, '', false, false, false, '', ExcelBuffer."cell type"::Text);
                    ExcelBuffer.AddColumn("Sales Line"."No.", false, '', false, false, false, '', ExcelBuffer."cell type"::Text);
                    ExcelBuffer.AddColumn("Sales Line"."Location Code", false, '', false, false, false, '', ExcelBuffer."cell type"::Text);
                    ExcelBuffer.AddColumn("Sales Line"."Variant Code", false, '', false, false, false, '', ExcelBuffer."cell type"::Text);
                    ExcelBuffer.AddColumn("Sales Line".Description, false, '', false, false, false, '', ExcelBuffer."cell type"::Text);
                    ExcelBuffer.AddColumn("Sales Line"."Description 2", false, '', false, false, false, '', ExcelBuffer."cell type"::Text);
                    ExcelBuffer.AddColumn(Desc3, false, '', false, false, false, '', ExcelBuffer."cell type"::Text);
                    ExcelBuffer.AddColumn("Sales Line"."Unit of Measure Code", false, '', false, false, false, '', ExcelBuffer."cell type"::Text);
                    ExcelBuffer.AddColumn("Sales Line".Quantity, false, '', false, false, false, '', ExcelBuffer."cell type"::Number);
                    ExcelBuffer.AddColumn("Sales Line".Quantity * "Sales Line"."Unit Price", false, '', false, false, false, '', ExcelBuffer."cell type"::Number);
                    ExcelBuffer.AddColumn("Sales Line"."Outstanding Quantity", false, '', false, false, false, '', ExcelBuffer."cell type"::Number);
                    ExcelBuffer.AddColumn(InventoryVar, false, '', false, false, false, '', ExcelBuffer."cell type"::Number);
                    ExcelBuffer.AddColumn("Sales Line"."Outstanding Quantity" * "Sales Line"."Unit Price", false, '', false, false, false, '', ExcelBuffer."cell type"::Number);
                    ExcelBuffer.AddColumn("Sales Line"."Unit Price", false, '', false, false, false, '', ExcelBuffer."cell type"::Number);
                    ExcelBuffer.AddColumn("Sales Line"."Net Weight", false, '', false, false, false, '', ExcelBuffer."cell type"::Number);
                    ExcelBuffer.AddColumn(MOQ, false, '', false, false, false, '', ExcelBuffer."cell type"::Number);
                    ExcelBuffer.AddColumn("Sales Line"."Shipment Date", false, '', false, false, false, '', ExcelBuffer."cell type"::Date);
                    ExcelBuffer.AddColumn("Sales Line".Remarks, false, '', false, false, false, '', ExcelBuffer."cell type"::Text);
                    ExcelBuffer.AddColumn("Sales Line"."Internal Remarks", false, '', false, false, false, '', ExcelBuffer."cell type"::Text);
                    ExcelBuffer.AddColumn("Sales Line"."PMM Remarks", false, '', false, false, false, '', ExcelBuffer."cell type"::Text);
                    ExcelBuffer.AddColumn(BlockStatus, false, '', false, false, false, '', ExcelBuffer."cell type"::Text);
                    ExcelBuffer.AddColumn(ManufacturingLeadTime, false, '', false, false, false, '', ExcelBuffer."cell type"::Number);
                    ExcelBuffer.AddColumn(DaysDiff, false, '', false, false, false, '', ExcelBuffer."cell type"::Number);
                end;
            }
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
    varItem: Record item;
    MOQ: Decimal;
    BlockStatus: Text;
    CUSTOMER: Record Customer;
    InventoryVar: Decimal;
    DaysDiff: Integer;
    ManufacturingLeadTime: Decimal;
    PrentCategory: Text;
    ItemCategory: Record "Item Category";
    Desc3: Text;
    procedure CreateHeading()
    begin
        ExcelBuffer.NewRow();
        ExcelBuffer.AddColumn('Sales Order No.', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
        ExcelBuffer.AddColumn('Order Date', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
        ExcelBuffer.AddColumn('Status', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
        ExcelBuffer.AddColumn('Bill To Customer Code', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
        ExcelBuffer.AddColumn('Bill To Customer Name', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
        ExcelBuffer.AddColumn('Ship to Customer Name', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
        ExcelBuffer.AddColumn('Sell-to Customer Code', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
        ExcelBuffer.AddColumn('Sell-to Customer Name', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
        ExcelBuffer.AddColumn('External Document No_', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
        ExcelBuffer.AddColumn('Salesperson Code', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
        ExcelBuffer.AddColumn('Item Category Code', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
        ExcelBuffer.AddColumn('Item Code', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
        ExcelBuffer.AddColumn('Location Code', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
        ExcelBuffer.AddColumn('Varient Code', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
        ExcelBuffer.AddColumn('Description', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
        ExcelBuffer.AddColumn('Description 2', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
        ExcelBuffer.AddColumn('Description 3', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
        ExcelBuffer.AddColumn('UOM', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
        ExcelBuffer.AddColumn('SO Quantity', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
        ExcelBuffer.AddColumn('Line Amount', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
        ExcelBuffer.AddColumn('Outstanding Quantity', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
        ExcelBuffer.AddColumn('Inventory', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
        ExcelBuffer.AddColumn('Calculated Outstanding Amount', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
        ExcelBuffer.AddColumn('Unit Price', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
        ExcelBuffer.AddColumn('Net Weight', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
        ExcelBuffer.AddColumn('MOQ', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
        ExcelBuffer.AddColumn('Shipment Date', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
        ExcelBuffer.AddColumn('Remarks for Customer', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
        ExcelBuffer.AddColumn('Internal Remarks', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
        ExcelBuffer.AddColumn('PMM Remarks', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
        ExcelBuffer.AddColumn('Customer Block Status', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
        ExcelBuffer.AddColumn('Manufacturing Lead Time', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
        ExcelBuffer.AddColumn('Days Diff.', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
    end;
    Local procedure CreateExcelBook();
    begin
        ExcelBuffer.CreateNewBook('Pending Sales Order Report - MIS');
        ExcelBuffer.WriteSheet('Pending Sales Order Report - MIS', CompanyName, UserId);
        ExcelBuffer.CloseBook();
        ExcelBuffer.SetFriendlyFilename('Pending Sales Order Report - MIS');
        ExcelBuffer.OpenExcel();
    end;
}
