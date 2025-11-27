report 50452 "Sales Order Report - MIS"
{
    ApplicationArea = All;
    Caption = 'Sales Order Report - MIS';
    UsageCategory = ReportsAndAnalysis;
    ProcessingOnly = true;
    UseRequestPage = true;

    dataset
    {
        dataitem("Sales Header"; "Sales Header")
        {
            DataItemTableView = SORTING("Document Type", "No.") WHERE("Document Type" = filter(Order), "Document Subtype" = filter(order));
            RequestFilterFields = "Order Date";

            dataitem("Sales Line"; "Sales Line")
            {
                DataItemLinkReference = "Sales Header";
                DataItemLink = "Document No." = field("No.");
                DataItemTableView = sorting("Document Type", "Document No.", "Line No.") WHERE("Document Type" = filter(Order), "Document Subtype" = filter(order));

                trigger OnAfterGetRecord()
                begin
                    if "Short Close Qty." = "Outstanding Quantity" then
                        CurrReport.Skip();
                    IGST_Amt := 0;
                    CGST_Amt := 0;
                    SGST_Amt := 0;
                    GSTAmount := 0;
                    TaxTransactionValue.Reset();
                    TaxTransactionValue.SetRange("Tax Record ID", "Sales Line".RecordId);
                    TaxTransactionValue.SetRange("Tax Type", 'GST');
                    TaxTransactionValue.SetRange("Value Type", TaxTransactionValue."Value Type"::COMPONENT);
                    IF TaxTransactionValue.FindSet() then
                        repeat
                            if TaxTransactionValue."Value ID" = 2 then begin
                                CGST_Amt := TaxTransactionValue.Amount;
                            end;
                            IF TaxTransactionValue."Value ID" = 3 then begin
                                IGST_Amt := TaxTransactionValue.Amount;
                            end;
                            IF TaxTransactionValue."Value ID" = 6 then begin
                                SGST_Amt := TaxTransactionValue.Amount;
                            end;
                            GSTAmount := CGST_Amt + SGST_Amt + IGST_Amt;
                        until TaxTransactionValue.Next() = 0;
                    ItemCategory.Reset();
                    if ItemCategory.Get("Sales Line"."Item Category Code") then
                        if ItemCategory."Parent Category" <> '' then
                            ItemCategoryCode := ItemCategory."Parent Category"
                        else
                            ItemCategoryCode := ''
                    else
                        ItemCategoryCode := '';
                    varItem.Reset();
                    if varItem.Get("Sales Line"."No.") then begin
                        MOQ := varItem."Minimum Order Quantity";
                        Desc3 := varItem."Description 3";
                    end
                    else begin
                        MOQ := 0;
                        Desc3 := '';
                    end;
                    // if "Sales Line".Quantity - "Sales Line"."Short Close Qty." <> 0 then begin
                    ExcelBuffer.NewRow();
                    ExcelBuffer.AddColumn("Sales Header"."No.", false, '', false, false, false, '', ExcelBuffer."cell type"::Text);
                    ExcelBuffer.AddColumn("Sales Header"."Order Date", false, '', false, false, false, '', ExcelBuffer."cell type"::Date);
                    ExcelBuffer.AddColumn("Sales Header".Status, false, '', false, false, false, '', ExcelBuffer."cell type"::Text);
                    ExcelBuffer.AddColumn("Sales Header"."Bill-to Customer No.", false, '', false, false, false, '', ExcelBuffer."cell type"::Text);
                    ExcelBuffer.AddColumn("Sales Header"."Bill-to Name", false, '', false, false, false, '', ExcelBuffer."cell type"::Text);
                    ExcelBuffer.AddColumn("Sales Header"."Ship-to Customer", false, '', false, false, false, '', ExcelBuffer."cell type"::Text);
                    ExcelBuffer.AddColumn("Sales Header"."Ship-to Name", false, '', false, false, false, '', ExcelBuffer."cell type"::Text);
                    ExcelBuffer.AddColumn("Sales Header"."Sell-to Customer No.", false, '', false, false, false, '', ExcelBuffer."cell type"::Text);
                    ExcelBuffer.AddColumn("Sales Header"."Sell-to Customer Name", false, '', false, false, false, '', ExcelBuffer."cell type"::Text);
                    ExcelBuffer.AddColumn("Sales Header"."External Document No.", false, '', false, false, false, '', ExcelBuffer."cell type"::Text);
                    ExcelBuffer.AddColumn("Sales Header"."External Doc. Date", false, '', false, false, false, '', ExcelBuffer."cell type"::Date);
                    ExcelBuffer.AddColumn("Sales Header"."Shortcut Dimension 1 Code", false, '', false, false, false, '', ExcelBuffer."cell type"::Text);
                    ExcelBuffer.AddColumn("Sales Header"."Salesperson Code", false, '', false, false, false, '', ExcelBuffer."cell type"::Text);
                    ExcelBuffer.AddColumn(ItemCategoryCode, false, '', false, false, false, '', ExcelBuffer."cell type"::Text);
                    ExcelBuffer.AddColumn("Sales Line"."Item Category Code", false, '', false, false, false, '', ExcelBuffer."cell type"::Text);
                    ExcelBuffer.AddColumn("Sales Line"."No.", false, '', false, false, false, '', ExcelBuffer."cell type"::Text);
                    ExcelBuffer.AddColumn("Sales Line"."Location Code", false, '', false, false, false, '', ExcelBuffer."cell type"::Text);
                    ExcelBuffer.AddColumn(GSTAmount, false, '', false, false, false, '#,##0.00', ExcelBuffer."cell type"::Number);
                    ExcelBuffer.AddColumn("Sales Line".Description, false, '', false, false, false, '', ExcelBuffer."cell type"::Text);
                    ExcelBuffer.AddColumn("Sales Line"."Description 2", false, '', false, false, false, '', ExcelBuffer."cell type"::Text);
                    ExcelBuffer.AddColumn(Desc3, false, '', false, false, false, '', ExcelBuffer."cell type"::Text);
                    ExcelBuffer.AddColumn("Sales Line"."Outstanding Quantity", false, '', false, false, false, '#,##0.00', ExcelBuffer."cell type"::Number);
                    ExcelBuffer.AddColumn("Sales Line"."Unit of Measure Code", false, '', false, false, false, '', ExcelBuffer."cell type"::Text);
                    ExcelBuffer.AddColumn("Sales Line".Quantity, false, '', false, false, false, '#,##0.00', ExcelBuffer."cell type"::Number);
                    ExcelBuffer.AddColumn("Sales Line"."Unit Price", false, '', false, false, false, '#,##0.00', ExcelBuffer."cell type"::Number);
                    ExcelBuffer.AddColumn("Sales Line".Quantity * "Sales Line"."Unit Price", false, '', false, false, false, '#,##0.00', ExcelBuffer."cell type"::Number);
                    ExcelBuffer.AddColumn("Sales Line"."Outstanding Quantity" * "Sales Line"."Unit Price", false, '', false, false, false, '#,##0.00', ExcelBuffer."cell type"::Number);
                    ExcelBuffer.AddColumn("Sales Line"."Net Weight", false, '', false, false, false, '#,##0.00', ExcelBuffer."cell type"::Number);
                    ExcelBuffer.AddColumn(MOQ, false, '', false, false, false, '#,##0.00', ExcelBuffer."cell type"::Number);
                    ExcelBuffer.AddColumn("Sales Line"."Short Close Qty.", false, '', false, false, false, '#,##0.00', ExcelBuffer."cell type"::Number);
                    ExcelBuffer.AddColumn("Sales Line"."Planned Shipment Date", false, '', false, false, false, '', ExcelBuffer."cell type"::Date);
                    ExcelBuffer.AddColumn("Sales Line"."Shipment Date", false, '', false, false, false, '', ExcelBuffer."cell type"::Date);
                    ExcelBuffer.AddColumn("Sales Line"."Planned Delivery Date", false, '', false, false, false, '', ExcelBuffer."cell type"::Date);
                    ExcelBuffer.AddColumn("Sales Line".Remarks, false, '', false, false, false, '', ExcelBuffer."cell type"::Text);
                    ExcelBuffer.AddColumn('', false, '', false, false, false, '', ExcelBuffer."cell type"::Text);
                    ExcelBuffer.AddColumn("Sales Line"."Internal Remarks", false, '', false, false, false, '', ExcelBuffer."cell type"::Text);
                    ExcelBuffer.AddColumn("Sales Line"."PMM Remarks", false, '', false, false, false, '', ExcelBuffer."cell type"::Text);
                end;
                // end;
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

    var
        ExcelBuffer: Record "Excel Buffer";
        IGST_Amt: Decimal;
        CGST_Amt: Decimal;
        SGST_Amt: Decimal;
        GSTAmount: Decimal;
        TaxTransactionValue: Record "Tax Transaction Value";
        ItemCategory: Record "Item Category";
        ItemCategoryCode: Code[20];
        varItem: Record item;
        MOQ: Decimal;
        Desc3: Text;

    procedure CreateHeading()
    begin
        ExcelBuffer.NewRow();
        ExcelBuffer.AddColumn('Sales Order No.', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
        ExcelBuffer.AddColumn('Order Date', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
        ExcelBuffer.AddColumn('Status', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
        ExcelBuffer.AddColumn('Bill To Customer Code', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
        ExcelBuffer.AddColumn('Bill To Customer Name', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
        ExcelBuffer.AddColumn('Ship to Customer Code', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
        ExcelBuffer.AddColumn('Ship to Customer Name', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
        ExcelBuffer.AddColumn('Sell-to Customer Code', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
        ExcelBuffer.AddColumn('Sell-to Customer Name', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
        ExcelBuffer.AddColumn('External Document No_', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
        ExcelBuffer.AddColumn('External Doc_ Date', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
        ExcelBuffer.AddColumn('Shortcut Dimension 1 Code', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
        ExcelBuffer.AddColumn('Salesperson Code', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
        ExcelBuffer.AddColumn('Item Category Code', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
        ExcelBuffer.AddColumn('Product Group', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
        ExcelBuffer.AddColumn('Item Code', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
        ExcelBuffer.AddColumn('Location Code', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
        ExcelBuffer.AddColumn('GST Amount', false, '', true, false, true, '', ExcelBuffer."cell type"::Number);
        ExcelBuffer.AddColumn('Description', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
        ExcelBuffer.AddColumn('Description 2', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
        ExcelBuffer.AddColumn('Description 3', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
        ExcelBuffer.AddColumn('Outstanding Quantity', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
        ExcelBuffer.AddColumn('UOM', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
        ExcelBuffer.AddColumn('SO Quantity', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
        ExcelBuffer.AddColumn('Unit Price', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
        ExcelBuffer.AddColumn('Line Amount', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
        ExcelBuffer.AddColumn('Calculated Outstanding Amount', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
        ExcelBuffer.AddColumn('Net Weight', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
        ExcelBuffer.AddColumn('MOQ', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
        ExcelBuffer.AddColumn('Short Close Qty', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
        ExcelBuffer.AddColumn('Planned Shipment Date', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
        ExcelBuffer.AddColumn('Shipment Date', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
        ExcelBuffer.AddColumn('Planned Delivery Date', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
        ExcelBuffer.AddColumn('Remarks', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
        ExcelBuffer.AddColumn('Hold Status', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
        ExcelBuffer.AddColumn('Internal Remarks', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
        ExcelBuffer.AddColumn('PMM Remarks', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
    end;

    Local procedure CreateExcelBook();
    begin
        ExcelBuffer.CreateNewBook('Sales Order Report');
        ExcelBuffer.WriteSheet('Sales Order Report', CompanyName, UserId);
        ExcelBuffer.CloseBook();
        ExcelBuffer.SetFriendlyFilename('Sales Order Report');
        ExcelBuffer.OpenExcel();
    end;
}
