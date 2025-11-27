report 50453 "Sales Invoice Report - MIS"
{
    ApplicationArea = All;
    Caption = 'Sales Invoice Report - MIS';
    UsageCategory = ReportsAndAnalysis;
    ProcessingOnly = true;
    UseRequestPage = true;

    dataset
    {
        dataitem("Sales Invoice Header"; "Sales Invoice Header")
        {
            DataItemTableView = SORTING("No.");
            RequestFilterFields = "Posting Date";

            dataitem("Sales Invoice Line"; "Sales Invoice Line")
            {
                DataItemLinkReference = "Sales Invoice Header";
                DataItemLink = "Document No." = field("No.");

                trigger OnAfterGetRecord()
                begin
                    //IG_DS
                    if ItemRec.Get("Sales Invoice Line"."No.") then;
                    //IG_DS
                    IGST_Amt := 0;
                    CGST_Amt := 0;
                    SGST_Amt := 0;
                    GSTAmount := 0;
                    GST_Per := 0;
                    IGST_Per := 0;
                    CGST_Per := 0;
                    SGST_Per := 0;
                    DetailedGSTLedgerEntry1.Reset();
                    DetailedGSTLedgerEntry1.SetRange("Transaction Type", DetailedGSTLedgerEntry1."Transaction Type"::Sales);
                    DetailedGSTLedgerEntry1.SetRange("Document Type", DetailedGSTLedgerEntry1."Document Type"::Invoice);
                    DetailedGSTLedgerEntry1.SetRange("Document No.", "Document No.");
                    DetailedGSTLedgerEntry1.SetRange("Document Line No.", "Line No.");
                    DetailedGSTLedgerEntry1.SetRange("Entry Type", DetailedGSTLedgerEntry1."Entry Type"::"Initial Entry");
                    if DetailedGSTLedgerEntry1.FindSet() then
                        repeat
                            if DetailedGSTLedgerEntry1."GST Component Code" = 'IGST' then begin
                                IGST_Per := DetailedGSTLedgerEntry1."GST %";
                                IGST_Amt += Abs(DetailedGSTLedgerEntry1."GST Amount");
                            end;
                            if DetailedGSTLedgerEntry1."GST Component Code" = 'CGST' then begin
                                CGST_Per := DetailedGSTLedgerEntry1."GST %";
                                CGST_Amt += abs(DetailedGSTLedgerEntry1."GST Amount");
                            end;
                            if DetailedGSTLedgerEntry1."GST Component Code" = 'SGST' then begin
                                SGST_Per := DetailedGSTLedgerEntry1."GST %";
                                SGST_Amt += abs(DetailedGSTLedgerEntry1."GST Amount");
                            end;
                        until DetailedGSTLedgerEntry1.Next() = 0;
                    GSTAmount := CGST_Amt + SGST_Amt + IGST_Amt;
                    GST_Per := CGST_Per + SGST_Per + IGST_Per;
                    if ItemCategory.Get("Sales Invoice Line"."Item Category Code") then
                        if ItemCategory."Parent Category" <> '' then
                            ItemCategoryCode := ItemCategory."Parent Category"
                        else
                            ItemCategoryCode := ''
                    else
                        ItemCategoryCode := '';
                    GLSetup.Get();
                    if DimensionSetEntry.Get("Sales Invoice Line"."Dimension Set ID", GLSetup."Shortcut Dimension 5 Code") then begin
                        DimensionSetEntry.CalcFields("Dimension Value Name");
                        SalesAreaCode := DimensionSetEntry."Dimension Value Code";
                        SalesAreaName := DimensionSetEntry."Dimension Value Name";
                    end
                    else begin
                        SalesAreaCode := '';
                        SalesAreaName := '';
                    end;
                    // if "Sales Invoice Header"."Currency Code" <> '' then
                    //     GSTAmount := GSTAmount * "Sales Invoice Header"."Currency Factor";
                    if SalespersonPurchaser.Get("Sales Invoice Header"."Salesperson Code") then
                        SalespersonPurchaserName := SalespersonPurchaser.Name
                    else
                        SalespersonPurchaserName := '';
                    ExcelBuffer.NewRow();
                    if "Sales Invoice Header"."Order/Scd. No." <> '' then
                        ExcelBuffer.AddColumn("Sales Invoice Header"."Order/Scd. No.", false, '', false, false, false, '', ExcelBuffer."cell type"::Text)
                    else begin
                        if "Sales Invoice Line"."SSD Order No." <> '' then
                            ExcelBuffer.AddColumn("Sales Invoice Line"."SSD Order No.", false, '', false, false, false, '', ExcelBuffer."cell type"::Text)
                        else
                            ExcelBuffer.AddColumn("Sales Invoice Line"."Order No.", false, '', false, false, false, '', ExcelBuffer."cell type"::Text);
                    end;
                    ExcelBuffer.AddColumn("Sales Invoice Header"."External Document No.", false, '', false, false, false, '', ExcelBuffer."cell type"::Text);
                    ExcelBuffer.AddColumn("Sales Invoice Header"."No.", false, '', false, false, false, '', ExcelBuffer."cell type"::Text);
                    ExcelBuffer.AddColumn("Sales Invoice Header"."Type of Invoice", false, '', false, false, false, '', ExcelBuffer."cell type"::Text);
                    ExcelBuffer.AddColumn("Sales Invoice Header"."Posting Date", false, '', false, false, false, '', ExcelBuffer."cell type"::Date);
                    ExcelBuffer.AddColumn("Sales Invoice Header"."Due Date", false, '', false, false, false, '', ExcelBuffer."cell type"::Date);
                    ExcelBuffer.AddColumn("Sales Invoice Header"."Sell-to Customer No.", false, '', false, false, false, '', ExcelBuffer."cell type"::Text);
                    ExcelBuffer.AddColumn("Sales Invoice Header"."Sell-to Customer Name", false, '', false, false, false, '', ExcelBuffer."cell type"::Text);
                    ExcelBuffer.AddColumn("Sales Invoice Header"."Bill-to Customer No.", false, '', false, false, false, '', ExcelBuffer."cell type"::Text);
                    ExcelBuffer.AddColumn("Sales Invoice Header"."Bill-to Name", false, '', false, false, false, '', ExcelBuffer."cell type"::Text);
                    ExcelBuffer.AddColumn("Sales Invoice Header"."Ship-to Code", false, '', false, false, false, '', ExcelBuffer."cell type"::Text);
                    ExcelBuffer.AddColumn("Sales Invoice Header"."Ship-to Name", false, '', false, false, false, '', ExcelBuffer."cell type"::Text);
                    ExcelBuffer.AddColumn(SalesAreaCode, false, '', false, false, false, '', ExcelBuffer."cell type"::Text);
                    ExcelBuffer.AddColumn(SalesAreaName, false, '', false, false, false, '', ExcelBuffer."cell type"::Text);
                    ExcelBuffer.AddColumn("Sales Invoice Header"."Salesperson Code", false, '', false, false, false, '', ExcelBuffer."cell type"::Text);
                    ExcelBuffer.AddColumn(SalespersonPurchaserName, false, '', false, false, false, '', ExcelBuffer."cell type"::Text);
                    ExcelBuffer.AddColumn("Sales Invoice Line".Type, false, '', false, false, false, '', ExcelBuffer."cell type"::Text);
                    ExcelBuffer.AddColumn(ItemRec."Product Classification", false, '', false, false, false, '', ExcelBuffer."cell type"::Text);
                    ExcelBuffer.AddColumn(ItemCategoryCode, false, '', false, false, false, '', ExcelBuffer."cell type"::Number);
                    ExcelBuffer.AddColumn("Sales Invoice Line"."Item Category Code", false, '', false, false, false, '', ExcelBuffer."cell type"::Number);
                    ExcelBuffer.AddColumn("Sales Invoice Line"."No.", false, '', false, false, false, '', ExcelBuffer."cell type"::Text);
                    ExcelBuffer.AddColumn("Sales Invoice Line".Description, false, '', false, false, false, '', ExcelBuffer."cell type"::Text);
                    ExcelBuffer.AddColumn("Sales Invoice Line"."Description 2", false, '', false, false, false, '', ExcelBuffer."cell type"::Number);
                    ExcelBuffer.AddColumn('', false, '', false, false, false, '', ExcelBuffer."cell type"::Number);
                    ExcelBuffer.AddColumn("Sales Invoice Line"."Unit of Measure Code", false, '', false, false, false, '', ExcelBuffer."cell type"::Text);
                    ExcelBuffer.AddColumn("Sales Invoice Line".Quantity, false, '', false, false, false, '', ExcelBuffer."cell type"::Number);
                    ExcelBuffer.AddColumn("Sales Invoice Line"."Net Weight", false, '', false, false, false, '', ExcelBuffer."cell type"::Number);
                    if "Sales Invoice Header"."Currency Code" <> '' then begin
                        ExcelBuffer.AddColumn("Sales Invoice Line"."Unit Price" / "Sales Invoice Header"."Currency Factor", false, '', false, false, false, '', ExcelBuffer."cell type"::Number);
                        ExcelBuffer.AddColumn("Sales Invoice Line"."Line Amount" / "Sales Invoice Header"."Currency Factor", false, '', false, false, false, '', ExcelBuffer."cell type"::Number);
                    end
                    else begin
                        ExcelBuffer.AddColumn("Sales Invoice Line"."Unit Price", false, '', false, false, false, '', ExcelBuffer."cell type"::Number);
                        ExcelBuffer.AddColumn("Sales Invoice Line"."Line Amount", false, '', false, false, false, '', ExcelBuffer."cell type"::Number);
                    end;
                    ExcelBuffer.AddColumn("Sales Invoice Line"."GST Group Code", false, '', false, false, false, '', ExcelBuffer."cell type"::Text);
                    ExcelBuffer.AddColumn(GST_Per, false, '', false, false, false, '', ExcelBuffer."cell type"::Number);
                    ExcelBuffer.AddColumn("Sales Invoice Line"."HSN/SAC Code", false, '', false, false, false, '', ExcelBuffer."cell type"::Text);
                    ExcelBuffer.AddColumn(GSTAmount, false, '', false, false, false, '', ExcelBuffer."cell type"::Number);
                    ExcelBuffer.AddColumn("Sales Invoice Header"."Shipping Agent Code", false, '', false, false, false, '', ExcelBuffer."cell type"::Text);
                    ExcelBuffer.AddColumn("Sales Invoice Line"."Transport Method", false, '', false, false, false, '', ExcelBuffer."cell type"::Text);
                    ExcelBuffer.AddColumn("Sales Invoice Header"."Shipment Method Code", false, '', false, false, false, '', ExcelBuffer."cell type"::Text);
                    ExcelBuffer.AddColumn("Sales Invoice Header"."LR/RR No.", false, '', false, false, false, '', ExcelBuffer."cell type"::Text);
                    ExcelBuffer.AddColumn("Sales Invoice Header"."LR/RR Date", false, '', false, false, false, '', ExcelBuffer."cell type"::Date);
                    ExcelBuffer.AddColumn("Sales Invoice Header"."Actual Delivery Date", false, '', false, false, false, '', ExcelBuffer."cell type"::Date);
                    ExcelBuffer.AddColumn("Sales Invoice Header"."Currency Code", false, '', false, false, false, '', ExcelBuffer."cell type"::Text);
                    ExcelBuffer.AddColumn("Sales Invoice Header"."Currency Factor", false, '', false, false, false, '', ExcelBuffer."cell type"::Number);
                    if "Sales Invoice Header"."Currency Code" <> '' then begin
                        ExcelBuffer.AddColumn("Sales Invoice Line"."Line Amount" / "Sales Invoice Header"."Currency Factor" + GSTAmount, false, '', false, false, false, '', ExcelBuffer."cell type"::Number);
                        ExcelBuffer.AddColumn("Sales Invoice Line"."Line Amount" / "Sales Invoice Header"."Currency Factor" + GSTAmount, false, '', false, false, false, '', ExcelBuffer."cell type"::Number);
                    end
                    else begin
                        ExcelBuffer.AddColumn("Sales Invoice Line"."Line Amount" + GSTAmount, false, '', false, false, false, '', ExcelBuffer."cell type"::Number);
                        ExcelBuffer.AddColumn("Sales Invoice Line"."Line Amount" + GSTAmount, false, '', false, false, false, '', ExcelBuffer."cell type"::Number);
                    end;
                    ExcelBuffer.AddColumn("Sales Invoice Header"."Firm Freight", false, '', false, false, false, '', ExcelBuffer."cell type"::Text);
                    if "Sales Invoice Header"."Currency Code" <> '' then
                        ExcelBuffer.AddColumn("Sales Invoice Header"."Calculated Freight Amount" / "Sales Invoice Header"."Currency Factor", false, '', false, false, false, '', ExcelBuffer."cell type"::Number)
                    else
                        ExcelBuffer.AddColumn("Sales Invoice Header"."Calculated Freight Amount", false, '', false, false, false, '', ExcelBuffer."cell type"::Number);
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

    var
        SalespersonPurchaser: Record "Salesperson/Purchaser";
        SalespersonPurchaserName: Text;
        ExcelBuffer: Record "Excel Buffer";
        IGST_Amt: Decimal;
        IGST_Per: Decimal;
        CGST_Amt: Decimal;
        CGST_Per: Decimal;
        SGST_Amt: Decimal;
        SGST_Per: Decimal;
        GSTAmount: Decimal;
        GST_Per: Decimal;
        SalesAreaCode: Code[20];
        SalesAreaName: Text;
        DetailedGSTLedgerEntry1: Record "Detailed GST Ledger Entry";
        DimensionSetEntry: Record "Dimension Set Entry";
        GLSetup: Record "General Ledger Setup";
        ItemCategoryCode: Code[20];
        ItemCategory: Record "Item Category";
        ItemRec: Record item;

    procedure CreateHeading()
    begin
        ExcelBuffer.NewRow();
        ExcelBuffer.AddColumn('SO No', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
        ExcelBuffer.AddColumn('External Document No.', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
        ExcelBuffer.AddColumn('ZD Inv No', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
        ExcelBuffer.AddColumn('Type Of Invoice', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
        ExcelBuffer.AddColumn('Inv Date', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
        ExcelBuffer.AddColumn('Due Date', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
        ExcelBuffer.AddColumn('Sell to Customer Code', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
        ExcelBuffer.AddColumn('Sell to Name', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
        ExcelBuffer.AddColumn('Bill to Code', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
        ExcelBuffer.AddColumn('Bill to Name', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
        ExcelBuffer.AddColumn('Ship-to-Code', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
        ExcelBuffer.AddColumn('Ship-to-Name', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
        ExcelBuffer.AddColumn('Sales Area Code', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
        ExcelBuffer.AddColumn('Sales Area Name', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
        ExcelBuffer.AddColumn('Salesperson Code', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
        ExcelBuffer.AddColumn('Salesperson Name', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
        ExcelBuffer.AddColumn('Type', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
        ExcelBuffer.AddColumn('Product Classification', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
        ExcelBuffer.AddColumn('Item Category Code', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
        ExcelBuffer.AddColumn('Product Group', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
        ExcelBuffer.AddColumn('Item Code', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
        ExcelBuffer.AddColumn('Description', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
        ExcelBuffer.AddColumn('Description 2', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
        ExcelBuffer.AddColumn('Description 3', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
        ExcelBuffer.AddColumn('Unit of Measure Code', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
        ExcelBuffer.AddColumn('Quantity', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
        ExcelBuffer.AddColumn('Net Weight', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
        ExcelBuffer.AddColumn('Unit Price', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
        ExcelBuffer.AddColumn('Line Amount', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
        ExcelBuffer.AddColumn('GST Group Code', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
        ExcelBuffer.AddColumn('GST %', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
        ExcelBuffer.AddColumn('HSN/SAC', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
        ExcelBuffer.AddColumn('GST Amount', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
        ExcelBuffer.AddColumn('Transporter Name', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
        ExcelBuffer.AddColumn('Transport Method', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
        ExcelBuffer.AddColumn('Shipment Method', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
        ExcelBuffer.AddColumn('LR_RR No_', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
        ExcelBuffer.AddColumn('LR_RR Date', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
        ExcelBuffer.AddColumn('Actual Delivery Date', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
        ExcelBuffer.AddColumn('Currency Code', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
        ExcelBuffer.AddColumn('Currency Factor', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
        ExcelBuffer.AddColumn('Total Landed Amount', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
        ExcelBuffer.AddColumn('Amount to Customer', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
        ExcelBuffer.AddColumn('Firm Freight', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
        ExcelBuffer.AddColumn('Calculated Freight Field', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
    end;

    Local procedure CreateExcelBook();
    begin
        ExcelBuffer.CreateNewBook('Sales Invoice Report');
        ExcelBuffer.WriteSheet('Sales Invoice Report', CompanyName, UserId);
        ExcelBuffer.CloseBook();
        ExcelBuffer.SetFriendlyFilename('Sales Invoice Report');
        ExcelBuffer.OpenExcel();
    end;
}
