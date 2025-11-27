Report 50231 "GST Excel Data Export"
{
    ProcessingOnly = true;
    ApplicationArea = all;
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem("Sales Invoice Header"; "Sales Invoice Header")
        {
            column(ReportForNavId_1000000006; 1000000006)
            {
            }
            dataitem("Sales Invoice Line"; "Sales Invoice Line")
            {
                DataItemLinkReference = "Sales Invoice Header";
                DataItemLink = "Document No." = field("No.");
                DataItemTableView = where("No." = filter(<> '' & <> '22045710'), Quantity = filter(<> 0));

                column(ReportForNavId_1000000000; 1000000000)
                {
                }
                trigger OnAfterGetRecord()
                var
                    Location: Record Location;
                begin
                    if Location.Get("Location Code") then begin
                        LocationName := Location.Name;
                        LocationStateCode := Location."State Code";
                        LocationGSTNo := Location."GST Registration No.";
                    end
                    else begin
                        LocationName := '';
                        LocationStateCode := '';
                        LocationGSTNo := '';
                    end;
                    CGSTAmount := 0;
                    CGSTPerc := 0;
                    IGSTAmount := 0;
                    IGSTPerc := 0;
                    SGSTAmount := 0;
                    SGSTPerc := 0;
                    TotalGSTAmount := 0;
                    TotalGSTPer := 0;
                    AmountVar := 0;
                    DetailedGSTLedgerEntry.Reset();
                    DetailedGSTLedgerEntry.SetRange("Transaction Type", DetailedGSTLedgerEntry."Transaction Type"::Sales);
                    DetailedGSTLedgerEntry.SetRange("Document Type", DetailedGSTLedgerEntry."Document Type"::Invoice);
                    DetailedGSTLedgerEntry.SetRange("Document No.", "Document No.");
                    DetailedGSTLedgerEntry.SetRange("Document Line No.", "Line No.");
                    DetailedGSTLedgerEntry.SetRange("Entry Type", DetailedGSTLedgerEntry."Entry Type"::"Initial Entry");
                    if DetailedGSTLedgerEntry.FindSet() then
                        repeat
                            if DetailedGSTLedgerEntry."GST Component Code" = 'IGST' then begin
                                IGSTPerc := DetailedGSTLedgerEntry."GST %";
                                IGSTAmount := DetailedGSTLedgerEntry."GST Amount";
                            end;
                            if DetailedGSTLedgerEntry."GST Component Code" = 'CGST' then begin
                                CGSTPerc := DetailedGSTLedgerEntry."GST %";
                                CGSTAmount := DetailedGSTLedgerEntry."GST Amount";
                            end;
                            if DetailedGSTLedgerEntry."GST Component Code" = 'SGST' then begin
                                SGSTPerc := DetailedGSTLedgerEntry."GST %";
                                SGSTAmount := DetailedGSTLedgerEntry."GST Amount";
                            end;
                            TotalGSTPer := CGSTPerc + SGSTPerc + IGSTPerc;
                            TotalGSTAmount := Abs(CGSTAmount + IGSTAmount + SGSTAmount);
                        until DetailedGSTLedgerEntry.Next() = 0;
                    // IF "Sales Invoice Line"."Gen. Bus. Posting Group" = 'SAMPLE' then
                    //     AmountVar := "Sales Invoice Line"."Line Discount Amount"
                    // else
                    //     AmountVar := "Sales Invoice Line".Amount;//IG_AS Old
                    Customer.Get("Bill-to Customer No.");
                    TempExcelBuffer.NewRow();
                    TempExcelBuffer.AddColumn(Format("Posting Date"), FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn("Document No.", FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn(Format("Line No."), FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn("Bill-to Customer No.", FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn(Customer.Name, FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn(Format("Sales Invoice Header"."GST Customer Type"), FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn(Customer."GST Registration No.", FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn(LocationName, FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn(LocationStateCode, FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn(LocationGSTNo, FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn("No.", FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn(Description, FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn(Quantity, FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Number);
                    if "Sales Invoice Header"."Currency Code" <> '' then
                        TempExcelBuffer.AddColumn("Unit Price" / "Sales Invoice Header"."Currency Factor", FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Number)
                    else
                        TempExcelBuffer.AddColumn("Unit Price", FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Number);
                    AmountVar := Quantity * "Unit Price";//IG_AS 22-08-2025
                    if "Sales Invoice Header"."Currency Code" <> '' then
                        TempExcelBuffer.AddColumn(AmountVar / "Sales Invoice Header"."Currency Factor", FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Number)
                    else
                        TempExcelBuffer.AddColumn(AmountVar, FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Number);
                    if "Sales Invoice Header"."Currency Code" <> '' then
                        TempExcelBuffer.AddColumn("Line Discount Amount" / "Sales Invoice Header"."Currency Factor", FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Number)
                    else
                        TempExcelBuffer.AddColumn("Line Discount Amount", FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Number);
                    TempExcelBuffer.AddColumn(TotalGSTPer, FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Number);
                    TempExcelBuffer.AddColumn(TotalGSTAmount, FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Number);
                    TempExcelBuffer.AddColumn(IGSTPerc, FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Number);
                    TempExcelBuffer.AddColumn(IGSTAmount, FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Number);
                    TempExcelBuffer.AddColumn(CGSTPerc, FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Number);
                    TempExcelBuffer.AddColumn(CGSTAmount, FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Number);
                    TempExcelBuffer.AddColumn(SGSTPerc, FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Number);
                    TempExcelBuffer.AddColumn(SGSTAmount, FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Number);
                    TempExcelBuffer.AddColumn(0, FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Number);
                    if "Sales Invoice Header"."Currency Code" <> '' then
                        TempExcelBuffer.AddColumn(AmountVar / "Sales Invoice Header"."Currency Factor" + TotalGSTAmount, FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Number)
                    else
                        TempExcelBuffer.AddColumn(AmountVar + TotalGSTAmount, FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Number);
                    TempExcelBuffer.AddColumn(Format("GST Place of Supply"), FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn("GST Group Code", FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn(Format("GST Group Type"), FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn(Format("GST Jurisdiction Type"), FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn("HSN/SAC Code", FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn(Format("Invoice Type"), FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn(Format(Exempted), FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn("GST Credit", FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
                end;
            }
            trigger OnPostDataItem()
            begin
                if ExportSaleData then begin
                    CreateNewSheet(SalesInvDataTxt, CheckMakeBookIsTrue);
                    CheckMakeBookIsTrue := false;
                end
                else begin
                    CheckMakeBookIsTrue := true;
                    TempExcelBuffer.DeleteAll();
                    TempExcelBuffer.ClearNewRow();
                end;
            end;

            trigger OnPreDataItem()
            begin
                SetRange("Posting Date", FromDate, ToDate);
                if not ExportSaleData then CurrReport.Break;
                TempExcelBuffer.NewRow();
                TempExcelBuffer.AddColumn(SalesInvDataTxt, FALSE, '', TRUE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn(GetFilters(), FALSE, '', TRUE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text);
                SalesDataItemRunning := true;
                PrePareHeading;
                SalesDataItemRunning := false;
            end;
        }
        dataitem("Sales Cr.Memo Header"; "Sales Cr.Memo Header")
        {
            column(ReportForNavId_1000000007; 1000000007)
            {
            }
            dataitem("Sales Cr.Memo Line"; "Sales Cr.Memo Line")
            {
                DataItemLink = "Document No." = field("No.");
                DataItemTableView = where("No." = filter(<> '' & <> '22045710'), Quantity = filter(<> 0));

                column(ReportForNavId_1000000001; 1000000001)
                {
                }
                trigger OnAfterGetRecord()
                var
                    Location: Record Location;
                begin
                    Customer.Get("Bill-to Customer No.");
                    if Location.Get("Location Code") then begin
                        LocationName := Location.Name;
                        LocationStateCode := Location."State Code";
                        LocationGSTNo := Location."GST Registration No.";
                    end
                    else begin
                        LocationName := '';
                        LocationStateCode := '';
                        LocationGSTNo := '';
                    end;
                    CGSTAmount := 0;
                    CGSTPerc := 0;
                    IGSTAmount := 0;
                    IGSTPerc := 0;
                    SGSTAmount := 0;
                    SGSTPerc := 0;
                    TotalGSTAmount := 0;
                    TotalGSTPer := 0;
                    DetailedGSTLedgerEntry.Reset();
                    DetailedGSTLedgerEntry.SetRange("Transaction Type", DetailedGSTLedgerEntry."Transaction Type"::Sales);
                    DetailedGSTLedgerEntry.SetRange("Document Type", DetailedGSTLedgerEntry."Document Type"::"Credit Memo");
                    DetailedGSTLedgerEntry.SetRange("Document No.", "Document No.");
                    DetailedGSTLedgerEntry.SetRange("Document Line No.", "Line No.");
                    DetailedGSTLedgerEntry.SetRange("Entry Type", DetailedGSTLedgerEntry."Entry Type"::"Initial Entry");
                    if DetailedGSTLedgerEntry.FindSet() then
                        repeat
                            if DetailedGSTLedgerEntry."GST Component Code" = 'IGST' then begin
                                IGSTPerc := DetailedGSTLedgerEntry."GST %";
                                IGSTAmount := DetailedGSTLedgerEntry."GST Amount";
                            end;
                            if DetailedGSTLedgerEntry."GST Component Code" = 'CGST' then begin
                                CGSTPerc := DetailedGSTLedgerEntry."GST %";
                                CGSTAmount := DetailedGSTLedgerEntry."GST Amount";
                            end;
                            if DetailedGSTLedgerEntry."GST Component Code" = 'SGST' then begin
                                SGSTPerc := DetailedGSTLedgerEntry."GST %";
                                SGSTAmount := DetailedGSTLedgerEntry."GST Amount";
                            end;
                            TotalGSTPer := CGSTPerc + SGSTPerc + IGSTPerc;
                            TotalGSTAmount := CGSTAmount + IGSTAmount + SGSTAmount;
                        until DetailedGSTLedgerEntry.Next() = 0;
                    TempExcelBuffer.NewRow();
                    TempExcelBuffer.AddColumn(Format("Posting Date"), FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn("Document No.", FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn(Format("Line No."), FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn("Bill-to Customer No.", FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn(Customer.Name, FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn(Format("Sales Cr.Memo Header"."GST Customer Type"), FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn(Customer."GST Registration No.", FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn(LocationName, FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn(LocationStateCode, FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn(LocationGSTNo, FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn("No.", FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn(Description, FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn(Quantity, FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Number);
                    if "Sales Cr.Memo Header"."Currency Code" <> '' then
                        TempExcelBuffer.AddColumn("Unit Price" / "Sales Cr.Memo Header"."Currency Factor", FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Number)
                    else
                        TempExcelBuffer.AddColumn("Unit Price", FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Number);
                    if "Sales Cr.Memo Header"."Currency Code" <> '' then
                        TempExcelBuffer.AddColumn(Amount / "Sales Cr.Memo Header"."Currency Factor", FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Number)
                    else
                        TempExcelBuffer.AddColumn(Amount, FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Number);
                    if "Sales Cr.Memo Header"."Currency Code" <> '' then
                        TempExcelBuffer.AddColumn("Line Discount Amount" / "Sales Cr.Memo Header"."Currency Factor", FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Number)
                    else
                        TempExcelBuffer.AddColumn("Line Discount Amount", FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Number);
                    IF TotalGSTAmount <> 0 then
                        TempExcelBuffer.AddColumn(TotalGSTPer, FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Number)
                    else
                        TempExcelBuffer.AddColumn(0, FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Number);
                    TempExcelBuffer.AddColumn(TotalGSTAmount, FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Number);
                    if IGSTAmount <> 0 then
                        TempExcelBuffer.AddColumn(IGSTPerc, FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Number)
                    else
                        TempExcelBuffer.AddColumn(0, FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Number);
                    TempExcelBuffer.AddColumn(IGSTAmount, FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Number);
                    if CGSTAmount <> 0 then
                        TempExcelBuffer.AddColumn(CGSTPerc, FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Number)
                    else
                        TempExcelBuffer.AddColumn(0, FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Number);
                    TempExcelBuffer.AddColumn(CGSTAmount, FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Number);
                    if SGSTAmount <> 0 then
                        TempExcelBuffer.AddColumn(SGSTPerc, FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Number)
                    else
                        TempExcelBuffer.AddColumn(0, FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Number);
                    TempExcelBuffer.AddColumn(SGSTAmount, FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Number);
                    TempExcelBuffer.AddColumn(0, FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Number);
                    if "Sales Cr.Memo Header"."Currency Code" <> '' then
                        TempExcelBuffer.AddColumn(Amount / "Sales Cr.Memo Header"."Currency Factor" + TotalGSTAmount, FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Number)
                    else
                        TempExcelBuffer.AddColumn(Amount + TotalGSTAmount, FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Number);
                    TempExcelBuffer.AddColumn(Format("GST Place of Supply"), FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn("GST Group Code", FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn(Format("GST Group Type"), FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn(Format("GST Jurisdiction Type"), FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn("HSN/SAC Code", FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn(Format("Invoice Type"), FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn(Format(Exempted), FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn("GST Credit", FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
                end;
            }
            trigger OnPostDataItem()
            begin
                if ExportSaleData then CreateNewSheet(SalesCrMemoTxt, CheckMakeBookIsTrue);
            end;

            trigger OnPreDataItem()
            begin
                SetRange("Posting Date", FromDate, ToDate);
                if not ExportSaleData then CurrReport.Break;
                TempExcelBuffer.NewRow();
                TempExcelBuffer.AddColumn(SalesCrMemoTxt, FALSE, '', true, FALSE, true, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn(GetFilters(), FALSE, '', true, FALSE, true, '', TempExcelBuffer."Cell Type"::Text);
                SalesDataItemRunning := true;
                PrePareHeading;
                SalesDataItemRunning := false;
            end;
        }
        dataitem("Purch. Inv. Header"; "Purch. Inv. Header")
        {
            column(ReportForNavId_1000000008; 1000000008)
            {
            }
            dataitem("Purch. Inv. Line"; "Purch. Inv. Line")
            {
                DataItemLink = "Document No." = field("No.");
                DataItemTableView = where("No." = filter(<> '' & <> '22045710'), Quantity = filter(<> 0));

                column(ReportForNavId_1000000002; 1000000002)
                {
                }
                trigger OnAfterGetRecord()
                var
                    Location: Record Location;
                begin
                    // PurchDataItemRunning := true;
                    Vendor.Get("Pay-to Vendor No.");
                    if Location.Get("Location Code") then begin
                        LocationName := Location.Name;
                        LocationStateCode := Location."State Code";
                        LocationGSTNo := Location."GST Registration No.";
                    end
                    else begin
                        LocationName := '';
                        LocationStateCode := '';
                        LocationGSTNo := '';
                    end;
                    CGSTAmount := 0;
                    CGSTPerc := 0;
                    IGSTAmount := 0;
                    IGSTPerc := 0;
                    SGSTAmount := 0;
                    SGSTPerc := 0;
                    TotalGSTAmount := 0;
                    TotalGSTPer := 0;
                    TDSAmt := 0;
                    AmountVar := 0;
                    DetailedGSTLedgerEntry.Reset();
                    DetailedGSTLedgerEntry.SetRange("Transaction Type", DetailedGSTLedgerEntry."Transaction Type"::Purchase);
                    DetailedGSTLedgerEntry.SetRange("Document Type", DetailedGSTLedgerEntry."Document Type"::Invoice);
                    DetailedGSTLedgerEntry.SetRange("Document No.", "Document No.");
                    DetailedGSTLedgerEntry.SetRange("Document Line No.", "Line No.");
                    DetailedGSTLedgerEntry.SetRange("Entry Type", DetailedGSTLedgerEntry."Entry Type"::"Initial Entry");
                    DetailedGSTLedgerEntry.SetRange("Entry Type", DetailedGSTLedgerEntry."Entry Type"::"Initial Entry");
                    if DetailedGSTLedgerEntry.FindSet() then
                        repeat
                            if DetailedGSTLedgerEntry."GST Component Code" = 'IGST' then begin
                                IGSTPerc := DetailedGSTLedgerEntry."GST %";
                                IGSTAmount := DetailedGSTLedgerEntry."GST Amount";
                            end;
                            if DetailedGSTLedgerEntry."GST Component Code" = 'CGST' then begin
                                CGSTPerc := DetailedGSTLedgerEntry."GST %";
                                CGSTAmount := DetailedGSTLedgerEntry."GST Amount";
                            end;
                            if DetailedGSTLedgerEntry."GST Component Code" = 'SGST' then begin
                                SGSTPerc := DetailedGSTLedgerEntry."GST %";
                                SGSTAmount := DetailedGSTLedgerEntry."GST Amount";
                            end;
                            TotalGSTPer := CGSTPerc + SGSTPerc + IGSTPerc;
                            TotalGSTAmount := CGSTAmount + IGSTAmount + SGSTAmount;
                        until DetailedGSTLedgerEntry.Next() = 0;
                    if "Purch. Inv. Header"."GST Vendor Type" = "Purch. Inv. Header"."GST Vendor Type"::Import then
                        AmountVar := "Purch. Inv. Line"."GST Assessable Value" + "Purch. Inv. Line"."Custom Duty Amount"
                    else
                        AmountVar := "Purch. Inv. Line".Amount;
                    // .........TDS
                    TaxTransactionValue.Reset();
                    TaxTransactionValue.SetRange("Tax Record ID", "Purch. Inv. Line".RecordId);
                    TaxTransactionValue.SetRange("Tax Type", 'TDS');
                    TaxTransactionValue.SetRange("Value Type", TaxTransactionValue."Value Type"::COMPONENT);
                    TaxTransactionValue.SetFilter(Percent, '<>%1', 0);
                    if TaxTransactionValue.FindSet() then
                        repeat
                            TDSAmt := TaxTransactionValue.Amount;
                        until TaxTransactionValue.Next() = 0;
                    // ................TDS
                    TempExcelBuffer.NewRow();
                    TempExcelBuffer.AddColumn(Format("Posting Date"), FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn("Document No.", FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn("Purch. Inv. Header"."Vendor Invoice No.", FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn(Format("Purch. Inv. Header"."Document Date"), FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn(Format("Line No."), FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn("Pay-to Vendor No.", FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn(Vendor.Name, FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn(Format("Purch. Inv. Header"."GST Vendor Type"), FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn(Vendor."GST Registration No.", FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn(LocationName, FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn(LocationStateCode, FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn(LocationGSTNo, FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn("No.", FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn(Description, FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn(Quantity, FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Number);
                    if "Purch. Inv. Header"."Currency Code" <> '' then
                        TempExcelBuffer.AddColumn("Direct Unit Cost" / "Purch. Inv. Header"."Currency Factor", FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Number)
                    else
                        TempExcelBuffer.AddColumn("Direct Unit Cost", FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Number);
                    if "Purch. Inv. Header"."Currency Code" <> '' then begin
                        //IG_AS 22-07-2025
                        if (AmountVar = 0) and (ExportPurchData = true) then begin
                            AmountVar := Quantity * ("Direct Unit Cost" / "Purch. Inv. Header"."Currency Factor");
                        end;
                        //IG_AS 22-07-2025
                        TempExcelBuffer.AddColumn(AmountVar / "Purch. Inv. Header"."Currency Factor", FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Number)
                    end else begin
                        //IG_AS 22-07-2025
                        if (AmountVar = 0) and (ExportPurchData = true) then begin
                            AmountVar := Quantity * ("Direct Unit Cost");
                        end;
                        //IG_AS 22-07-2025
                        TempExcelBuffer.AddColumn(AmountVar, FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Number);
                    end;
                    if "Purch. Inv. Header"."Currency Code" <> '' then
                        TempExcelBuffer.AddColumn("Line Discount Amount" / "Purch. Inv. Header"."Currency Factor", FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Number)
                    else
                        TempExcelBuffer.AddColumn("Line Discount Amount", FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Number);
                    TempExcelBuffer.AddColumn(TotalGSTPer, FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Number);
                    IF Quantity > 0 then
                        TempExcelBuffer.AddColumn(TotalGSTAmount, FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Number)
                    else
                        TempExcelBuffer.AddColumn(-TotalGSTAmount, FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Number);
                    TempExcelBuffer.AddColumn(IGSTPerc, FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Number);
                    IF Quantity > 0 then
                        TempExcelBuffer.AddColumn(IGSTAmount, FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Number)
                    else
                        TempExcelBuffer.AddColumn(-IGSTAmount, FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Number);
                    TempExcelBuffer.AddColumn(CGSTPerc, FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Number);
                    IF Quantity > 0 then
                        TempExcelBuffer.AddColumn(CGSTAmount, FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Number)
                    else
                        TempExcelBuffer.AddColumn(-CGSTAmount, FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Number);
                    TempExcelBuffer.AddColumn(SGSTPerc, FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Number);
                    IF Quantity > 0 then
                        TempExcelBuffer.AddColumn(SGSTAmount, FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Number)
                    else
                        TempExcelBuffer.AddColumn(-SGSTAmount, FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Number);
                    TempExcelBuffer.AddColumn(TDSAmt, FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Number);
                    if "Purch. Inv. Header"."Currency Code" <> '' then
                        TempExcelBuffer.AddColumn(AmountVar / "Purch. Inv. Header"."Currency Factor" - TDSAmt + TotalGSTAmount, FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Number)
                    else
                        TempExcelBuffer.AddColumn(AmountVar - TDSAmt + TotalGSTAmount, FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Number);
                    TempExcelBuffer.AddColumn(Format(''), FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn("GST Group Code", FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn(Format("GST Group Type"), FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn(Format("GST Jurisdiction Type"), FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn("HSN/SAC Code", FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn(Format(''), FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn(Format(Exempted), FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn("GST Credit", FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
                    if ExportPurchData = true then TempExcelBuffer.AddColumn("Purch. Inv. Header"."Local GSTIN No.", FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);//IG_AS 22-08-2025
                end;
            }
            trigger OnPostDataItem()
            begin
                if ExportPurchData then begin
                    CreateNewSheet(PurchInvDataTxt, CheckMakeBookIsTrue);
                    CheckMakeBookIsTrue := false;
                end
                else begin
                    if ExportSaleData then
                        CheckMakeBookIsTrue := false
                    else
                        CheckMakeBookIsTrue := true;
                    TempExcelBuffer.DeleteAll();
                    TempExcelBuffer.ClearNewRow();
                end;
            end;

            trigger OnPreDataItem()
            begin
                SetRange("Posting Date", FromDate, ToDate);
                if not ExportPurchData then CurrReport.Break;
                TempExcelBuffer.NewRow();
                TempExcelBuffer.AddColumn(PurchInvDataTxt, FALSE, '', true, FALSE, true, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn(GetFilters(), FALSE, '', true, FALSE, true, '', TempExcelBuffer."Cell Type"::Text);
                PurchDataItemRunning := true;
                PrePareHeading;
                PurchDataItemRunning := false;
            end;
        }
        dataitem("Purch. Cr. Memo Hdr."; "Purch. Cr. Memo Hdr.")
        {
            column(ReportForNavId_1000000009; 1000000009)
            {
            }
            dataitem("Purch. Cr. Memo Line"; "Purch. Cr. Memo Line")
            {
                DataItemLink = "Document No." = field("No.");
                DataItemTableView = where("No." = filter(<> '' & <> '22045710'), Quantity = filter(<> 0));

                column(ReportForNavId_1000000003; 1000000003)
                {
                }
                trigger OnAfterGetRecord()
                var
                    Location: Record Location;
                begin
                    CGSTAmount := 0;
                    IGSTAmount := 0;
                    SGSTAmount := 0;
                    ECessAmount := 0;
                    Vendor.Get("Pay-to Vendor No.");
                    if Location.Get("Location Code") then begin
                        LocationName := Location.Name;
                        LocationStateCode := Location."State Code";
                        LocationGSTNo := Location."GST Registration No.";
                    end
                    else begin
                        LocationName := '';
                        LocationStateCode := '';
                        LocationGSTNo := '';
                    end;
                    CGSTAmount := 0;
                    CGSTPerc := 0;
                    IGSTAmount := 0;
                    IGSTPerc := 0;
                    SGSTAmount := 0;
                    SGSTPerc := 0;
                    TotalGSTAmount := 0;
                    TotalGSTPer := 0;
                    TDSAmt := 0;
                    AmountVar := 0;
                    DetailedGSTLedgerEntry.Reset();
                    DetailedGSTLedgerEntry.SetRange("Transaction Type", DetailedGSTLedgerEntry."Transaction Type"::Purchase);
                    DetailedGSTLedgerEntry.SetRange("Document Type", DetailedGSTLedgerEntry."Document Type"::"Credit Memo");
                    DetailedGSTLedgerEntry.SetRange("Document No.", "Document No.");
                    DetailedGSTLedgerEntry.SetRange("Document Line No.", "Line No.");
                    DetailedGSTLedgerEntry.SetRange("Entry Type", DetailedGSTLedgerEntry."Entry Type"::"Initial Entry");
                    if DetailedGSTLedgerEntry.FindSet() then
                        repeat
                            if DetailedGSTLedgerEntry."GST Component Code" = 'IGST' then begin
                                IGSTPerc := DetailedGSTLedgerEntry."GST %";
                                IGSTAmount := DetailedGSTLedgerEntry."GST Amount";
                            end;
                            if DetailedGSTLedgerEntry."GST Component Code" = 'CGST' then begin
                                CGSTPerc := DetailedGSTLedgerEntry."GST %";
                                CGSTAmount := DetailedGSTLedgerEntry."GST Amount";
                            end;
                            if DetailedGSTLedgerEntry."GST Component Code" = 'SGST' then begin
                                SGSTPerc := DetailedGSTLedgerEntry."GST %";
                                SGSTAmount := DetailedGSTLedgerEntry."GST Amount";
                            end;
                            TotalGSTPer := CGSTPerc + SGSTPerc + IGSTPerc;
                            TotalGSTAmount := CGSTAmount + IGSTAmount + SGSTAmount;
                        until DetailedGSTLedgerEntry.Next() = 0;
                    if "Purch. Cr. Memo Hdr."."GST Vendor Type" = "Purch. Cr. Memo Hdr."."GST Vendor Type"::Import then AmountVar := "Purch. Cr. Memo Line"."GST Assessable Value" + "Purch. Cr. Memo Line"."Custom Duty Amount";
                    // .........TDS
                    TaxTransactionValue.Reset();
                    TaxTransactionValue.SetRange("Tax Record ID", "Purch. Cr. Memo Line".RecordId);
                    TaxTransactionValue.SetRange("Tax Type", 'TDS');
                    TaxTransactionValue.SetRange("Value Type", TaxTransactionValue."Value Type"::COMPONENT);
                    TaxTransactionValue.SetFilter(Percent, '<>%1', 0);
                    if TaxTransactionValue.FindSet() then
                        repeat
                            TDSAmt := TaxTransactionValue.Amount;
                        until TaxTransactionValue.Next() = 0;
                    // ................TDS
                    TempExcelBuffer.NewRow();
                    TempExcelBuffer.AddColumn(Format("Posting Date"), FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Date);
                    TempExcelBuffer.AddColumn("Document No.", FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn(Format("Line No."), FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn("Pay-to Vendor No.", FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn(Vendor.Name, FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn(Format("Purch. Cr. Memo Hdr."."GST Vendor Type"), FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn(Vendor."GST Registration No.", FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn(LocationName, FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn(LocationStateCode, FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn(LocationGSTNo, FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn("No.", FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn(Description, FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn(Quantity, FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Number);
                    if "Purch. Cr. Memo Hdr."."Currency Code" <> '' then
                        TempExcelBuffer.AddColumn("Direct Unit Cost" / "Purch. Cr. Memo Hdr."."Currency Factor", FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Number)
                    else
                        TempExcelBuffer.AddColumn("Direct Unit Cost", FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Number);
                    if "Purch. Cr. Memo Hdr."."Currency Code" <> '' then
                        TempExcelBuffer.AddColumn(AmountVar / "Purch. Cr. Memo Hdr."."Currency Factor", FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Number)
                    else
                        TempExcelBuffer.AddColumn(AmountVar, FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Number);
                    if "Purch. Cr. Memo Hdr."."Currency Code" <> '' then
                        TempExcelBuffer.AddColumn("Line Discount Amount" / "Purch. Cr. Memo Hdr."."Currency Factor", FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Number)
                    else
                        TempExcelBuffer.AddColumn("Line Discount Amount", FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Number);
                    TempExcelBuffer.AddColumn(TotalGSTPer, FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Number);
                    TempExcelBuffer.AddColumn(TotalGSTAmount, FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Number);
                    TempExcelBuffer.AddColumn(IGSTPerc, FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Number);
                    TempExcelBuffer.AddColumn(IGSTAmount, FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Number);
                    TempExcelBuffer.AddColumn(CGSTPerc, FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Number);
                    TempExcelBuffer.AddColumn(CGSTAmount, FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Number);
                    TempExcelBuffer.AddColumn(SGSTPerc, FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Number);
                    TempExcelBuffer.AddColumn(SGSTAmount, FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Number);
                    TempExcelBuffer.AddColumn(TDSAmt, FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Number);
                    if "Purch. Cr. Memo Hdr."."Currency Code" <> '' then
                        TempExcelBuffer.AddColumn(AmountVar / "Purch. Cr. Memo Hdr."."Currency Factor" - TDSAmt + TotalGSTAmount, FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Number)
                    else
                        TempExcelBuffer.AddColumn(AmountVar - TDSAmt + TotalGSTAmount, FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Number);
                    TempExcelBuffer.AddColumn(Format(''), FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn("GST Group Code", FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn(Format("GST Group Type"), FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn(Format("GST Jurisdiction Type"), FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn("HSN/SAC Code", FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn(Format(''), FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn(Format(Exempted), FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn("GST Credit", FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
                end;
            }
            trigger OnPostDataItem()
            begin
                if ExportPurchData then CreateNewSheet(PurchCrMemoTxt, CheckMakeBookIsTrue);
            end;

            trigger OnPreDataItem()
            begin
                SetRange("Posting Date", FromDate, ToDate);
                if not ExportPurchData then CurrReport.Break;
                TempExcelBuffer.NewRow();
                TempExcelBuffer.AddColumn(PurchCrMemoTxt, FALSE, '', true, FALSE, true, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn(GetFilters(), FALSE, '', true, FALSE, true, '', TempExcelBuffer."Cell Type"::Text);
                PurchDataItemRunning := true;
                PrePareHeading;
                PurchDataItemRunning := false;
            end;
        }
        dataitem("Transfer Shipment Header"; "Transfer Shipment Header")
        {
            column(ReportForNavId_1000000010; 1000000010)
            {
            }
            dataitem("Transfer Shipment Line"; "Transfer Shipment Line")
            {
                DataItemLink = "Document No." = field("No.");
                DataItemTableView = sorting("Document No.", "Line No.") order(ascending) where(Quantity = filter(<> 0));

                column(ReportForNavId_1000000004; 1000000004)
                {
                }
                trigger OnAfterGetRecord()
                var
                    FromLocation: Record Location;
                    ToLocation: Record Location;
                    TransferShipmentHeader: Record "Transfer Shipment Header";
                begin
                    FromLocation.Get("Transfer-from Code");
                    ToLocation.Get("Transfer-to Code");
                    // TransferDataItemRunning := true;
                    CGSTAmount := 0;
                    CGSTPerc := 0;
                    IGSTAmount := 0;
                    IGSTPerc := 0;
                    SGSTAmount := 0;
                    SGSTPerc := 0;
                    TotalGSTAmount := 0;
                    TotalGSTPer := 0;
                    DetailedGSTLedgerEntry.Reset();
                    DetailedGSTLedgerEntry.SetRange("Transaction Type", DetailedGSTLedgerEntry."Transaction Type"::Sales);
                    DetailedGSTLedgerEntry.SetRange("Document Type", DetailedGSTLedgerEntry."Document Type"::Invoice);
                    DetailedGSTLedgerEntry.SetRange("Document No.", "Document No.");
                    DetailedGSTLedgerEntry.SetRange("Document Line No.", "Line No.");
                    DetailedGSTLedgerEntry.SetRange("Entry Type", DetailedGSTLedgerEntry."Entry Type"::"Initial Entry");
                    if DetailedGSTLedgerEntry.FindSet() then
                        repeat
                            if DetailedGSTLedgerEntry."GST Component Code" = 'IGST' then begin
                                IGSTPerc := DetailedGSTLedgerEntry."GST %";
                                IGSTAmount := DetailedGSTLedgerEntry."GST Amount";
                            end;
                            if DetailedGSTLedgerEntry."GST Component Code" = 'CGST' then begin
                                CGSTPerc := DetailedGSTLedgerEntry."GST %";
                                CGSTAmount := DetailedGSTLedgerEntry."GST Amount";
                            end;
                            if DetailedGSTLedgerEntry."GST Component Code" = 'SGST' then begin
                                SGSTPerc := DetailedGSTLedgerEntry."GST %";
                                SGSTAmount := DetailedGSTLedgerEntry."GST Amount";
                            end;
                            TotalGSTPer := CGSTPerc + SGSTPerc + IGSTPerc;
                            TotalGSTAmount := CGSTAmount + IGSTAmount + SGSTAmount;
                        until DetailedGSTLedgerEntry.Next() = 0;
                    TempExcelBuffer.NewRow();
                    TempExcelBuffer.AddColumn(FORMAT("Transfer Shipment Header"."Posting Date"), FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Date);
                    TempExcelBuffer.AddColumn("Document No.", FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn(Format("Line No."), FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn(FromLocation.Name, FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn(FromLocation."State Code", FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn(FromLocation."GST Registration No.", FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn(ToLocation.Name, FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn(ToLocation."State Code", FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn(ToLocation."GST Registration No.", FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn("Item No.", FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn(Description, FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn(Quantity, FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Number);
                    TempExcelBuffer.AddColumn("Unit Price", FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Number);
                    TempExcelBuffer.AddColumn(Amount, FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Number);
                    TempExcelBuffer.AddColumn(Format('0.00'), FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn(TotalGSTPer, FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Number);
                    TempExcelBuffer.AddColumn(TotalGSTAmount, FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Number);
                    TempExcelBuffer.AddColumn(IGSTPerc, FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Number);
                    TempExcelBuffer.AddColumn(IGSTAmount, FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Number);
                    TempExcelBuffer.AddColumn(CGSTPerc, FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Number);
                    TempExcelBuffer.AddColumn(CGSTAmount, FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Number);
                    TempExcelBuffer.AddColumn(SGSTPerc, FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Number);
                    TempExcelBuffer.AddColumn(SGSTAmount, FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Number);
                    TempExcelBuffer.AddColumn(0, FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Number);
                    TempExcelBuffer.AddColumn(Amount + TotalGSTAmount, FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Number);
                    TempExcelBuffer.AddColumn(Format(''), FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn("GST Group Code", FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn(Format(''), FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn(Format(''), FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn("HSN/SAC Code", FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn(Format(''), FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn(Format(''), FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
                end;
            }
            trigger OnPostDataItem()
            begin
                if ExportTransferData then begin
                    CreateNewSheet(TransferShptTxt, CheckMakeBookIsTrue);
                    CheckMakeBookIsTrue := false;
                end
                else begin
                    if ExportPurchData then
                        CheckMakeBookIsTrue := false
                    else
                        CheckMakeBookIsTrue := true;
                    TempExcelBuffer.DeleteAll();
                    TempExcelBuffer.ClearNewRow();
                end;
            end;

            trigger OnPreDataItem()
            begin
                SetRange("Posting Date", FromDate, ToDate);
                if not ExportTransferData then CurrReport.Break;
                TempExcelBuffer.NewRow();
                TempExcelBuffer.AddColumn(TransferShptTxt, FALSE, '', TRUE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn(GetFilters(), FALSE, '', TRUE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text);
                TransferDataItemRunning := true;
                PrePareHeading;
                TransferDataItemRunning := false;
            end;
        }
        dataitem("Transfer Receipt Header"; "Transfer Receipt Header")
        {
            column(ReportForNavId_1000000011; 1000000011)
            {
            }
            dataitem("Transfer Receipt Line"; "Transfer Receipt Line")
            {
                DataItemLink = "Document No." = field("No.");
                DataItemTableView = sorting("Document No.", "Line No.") order(ascending) where(Quantity = filter(<> 0));

                column(ReportForNavId_1000000005; 1000000005)
                {
                }
                trigger OnAfterGetRecord()
                var
                    FromLocation: Record Location;
                    ToLocation: Record Location;
                    TransferReceiptHeader: Record "Transfer Receipt Header";
                begin
                    FromLocation.Get("Transfer-from Code");
                    ToLocation.Get("Transfer-to Code");
                    TotalGSTAmount := 0;
                    CGSTPerc := 0;
                    IGSTAmount := 0;
                    IGSTPerc := 0;
                    SGSTAmount := 0;
                    SGSTPerc := 0;
                    TotalGSTAmount := 0;
                    TotalGSTPer := 0;
                    DetailedGSTLedgerEntry.Reset();
                    DetailedGSTLedgerEntry.SetRange("Transaction Type", DetailedGSTLedgerEntry."Transaction Type"::Purchase);
                    DetailedGSTLedgerEntry.SetRange("Document Type", DetailedGSTLedgerEntry."Document Type"::Invoice);
                    DetailedGSTLedgerEntry.SetRange("Document No.", "Document No.");
                    DetailedGSTLedgerEntry.SetRange("Document Line No.", "Line No.");
                    DetailedGSTLedgerEntry.SetRange("Entry Type", DetailedGSTLedgerEntry."Entry Type"::"Initial Entry");
                    if DetailedGSTLedgerEntry.FindSet() then
                        repeat
                            if DetailedGSTLedgerEntry."GST Component Code" = 'IGST' then begin
                                IGSTPerc := DetailedGSTLedgerEntry."GST %";
                                IGSTAmount := DetailedGSTLedgerEntry."GST Amount";
                            end;
                            if DetailedGSTLedgerEntry."GST Component Code" = 'CGST' then begin
                                CGSTPerc := DetailedGSTLedgerEntry."GST %";
                                CGSTAmount := DetailedGSTLedgerEntry."GST Amount";
                            end;
                            if DetailedGSTLedgerEntry."GST Component Code" = 'SGST' then begin
                                SGSTPerc := DetailedGSTLedgerEntry."GST %";
                                SGSTAmount := DetailedGSTLedgerEntry."GST Amount";
                            end;
                            TotalGSTPer := CGSTPerc + SGSTPerc + IGSTPerc;
                            TotalGSTAmount := CGSTAmount + IGSTAmount + SGSTAmount;
                        until DetailedGSTLedgerEntry.Next() = 0;
                    TempExcelBuffer.NewRow();
                    TempExcelBuffer.AddColumn(Format("Transfer Receipt Header"."Posting Date"), FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Date);
                    TempExcelBuffer.AddColumn("Document No.", FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn(Format("Line No."), FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn(FromLocation.Name, FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn(FromLocation."State Code", FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn(FromLocation."GST Registration No.", FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn(ToLocation.Name, FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn(ToLocation."State Code", FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn(ToLocation."GST Registration No.", FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn("Item No.", FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn(Description, FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn(Quantity, FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Number);
                    TempExcelBuffer.AddColumn("Unit Price", FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Number);
                    TempExcelBuffer.AddColumn(Amount, FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Number);
                    TempExcelBuffer.AddColumn(Format('0.00'), FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn(TotalGSTPer, FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Number);
                    TempExcelBuffer.AddColumn(TotalGSTAmount, FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Number);
                    TempExcelBuffer.AddColumn(IGSTPerc, FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Number);
                    TempExcelBuffer.AddColumn(IGSTAmount, FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Number);
                    TempExcelBuffer.AddColumn(CGSTPerc, FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Number);
                    TempExcelBuffer.AddColumn(CGSTAmount, FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Number);
                    TempExcelBuffer.AddColumn(SGSTPerc, FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Number);
                    TempExcelBuffer.AddColumn(SGSTAmount, FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Number);
                    TempExcelBuffer.AddColumn(0, FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Number);
                    TempExcelBuffer.AddColumn(Amount + TotalGSTAmount, FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Number);
                    TempExcelBuffer.AddColumn(Format(''), FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn("GST Group Code", FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn(Format(''), FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn(Format(''), FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn("HSN/SAC Code", FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn(Format(''), FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
                    TempExcelBuffer.AddColumn(Format(''), FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
                end;
            }
            trigger OnPostDataItem()
            begin
                if ExportTransferData then begin
                    CreateNewSheet(TransferRcptTxt, CheckMakeBookIsTrue);
                end;
            end;

            trigger OnPreDataItem()
            begin
                SetRange("Posting Date", FromDate, ToDate);
                if not ExportTransferData then CurrReport.Break;
                TempExcelBuffer.NewRow();
                TempExcelBuffer.AddColumn(TransferRcptTxt, FALSE, '', true, FALSE, true, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn(GetFilters(), FALSE, '', true, FALSE, true, '', TempExcelBuffer."Cell Type"::Text);
                TransferDataItemRunning := true;
                PrePareHeading();
                TransferDataItemRunning := false;
            end;
        }
        dataitem("G/L Entry"; "G/L Entry")
        {
            // DataItemTableView = where("G/L Account No." = filter(11343805 .. 11343830 | 1247200 .. 12472700));
            // DataItemTableView = where("G/L Account No."=filter(11343805|11343810|11343815|11343820|11343825|11343830|12472100|12472200|12472400|12472500|12472600|12472700), "Source Code"=filter('JOURNALV'));//IG_AS Old 16-07-2025
            DataItemTableView = sorting("Document No.", "G/L Account No.") where("Source Code" = filter('JOURNALV'));//IG_AS New 16-07-2025
            // DataItemTableView = where("G/L Account No." = filter(11343805));
            trigger OnAfterGetRecord()
            var
                GLEntry: Record "G/L Entry";
                Customer: Record Customer;
                Vendor: Record Vendor;
                VendorName: Text[100];
                CustomerName: Text[100];
                DocNo: Text;
                GLAccNo: Text;
                EntryNo: Integer;
            begin
                Customer.Reset();
                Vendor.Reset();
                GLEntry.Reset();
                GLEntry.SetRange("Document No.", "G/L Entry"."Document No.");
                GLEntry.SetFilter("Source Code", '<>%1', '');
                GLEntry.SetLoadFields("Source Type", "Source No.", "Document No.");
                if GLEntry.FindFirst() then
                    repeat
                        if GLEntry."Source Type" = GLEntry."Source Type"::Customer then begin
                            Customer.SetLoadFields("Customer Posting Group", Name);
                            if not Customer.Get(GLEntry."Source No.") then;
                        end;
                        if GLEntry."Source Type" = GLEntry."Source Type"::Vendor then begin
                            Vendor.SetLoadFields("Vendor Posting Group", Name);
                            if Vendor.Get(GLEntry."Source No.") then;
                        end;
                        GLEntry.CalcFields("G/L Account Name");

                        TempGLEntry.Reset();
                        TempGLEntry.SetRange("Entry No.", GLEntry."Entry No.");
                        if TempGLEntry.FindFirst() then begin
                            TempGLEntry.DeleteAll();
                        end;
                        TempGLEntry.Init();
                        TempGLEntry.TransferFields(GLEntry);
                        TempGLEntry.Insert(true);
                    Until GLEntry.Next() = 0;

                // TempExcelBuffer.NewRow();
                // TempExcelBuffer.AddColumn("G/L Entry"."G/L Account No.", False, '', False, False, False, '', TempExcelBuffer."Cell Type"::Text);
                // TempExcelBuffer.AddColumn(Format("G/L Entry"."Posting Date"), False, '', False, False, False, '', TempExcelBuffer."Cell Type"::Date);
                // TempExcelBuffer.AddColumn(Format("G/L Entry"."Document Date"), False, '', False, False, False, '', TempExcelBuffer."Cell Type"::Date);
                // TempExcelBuffer.AddColumn("G/L Entry"."Document No.", False, '', False, False, False, '', TempExcelBuffer."Cell Type"::Text);
                // TempExcelBuffer.AddColumn("G/L Entry"."External Document No.", False, '', False, False, False, '', TempExcelBuffer."Cell Type"::Text);
                // TempExcelBuffer.AddColumn(Customer."No." + Vendor."No.", False, '', False, False, False, '', TempExcelBuffer."Cell Type"::Text);
                // TempExcelBuffer.AddColumn(Customer.Name + Vendor.Name, False, '', False, False, False, '', TempExcelBuffer."Cell Type"::Text);
                // TempExcelBuffer.AddColumn(Customer."Customer Posting Group" + Vendor."Vendor Posting Group", False, '', False, False, False, '', TempExcelBuffer."Cell Type"::Text);
                // TempExcelBuffer.AddColumn("G/L Entry"."Entry No.", False, '', False, False, False, '', TempExcelBuffer."Cell Type"::Number);
                // TempExcelBuffer.AddColumn("G/L Entry".Amount, False, '', False, False, False, '', TempExcelBuffer."Cell Type"::Number);
            end;

            trigger OnPostDataItem()
            begin
                TempGLEntry.Reset();
                if TempGLEntry.FindFirst() then
                    repeat
                        TempGLEntry.CalcFields("G/L Account Name");
                        TempExcelBuffer.NewRow();
                        TempExcelBuffer.AddColumn(TempGLEntry."G/L Account No.", False, '', False, False, False, '', TempExcelBuffer."Cell Type"::Text);
                        TempExcelBuffer.AddColumn(Format(TempGLEntry."Posting Date"), False, '', False, False, False, '', TempExcelBuffer."Cell Type"::Date);
                        TempExcelBuffer.AddColumn(Format(TempGLEntry."Document Date"), False, '', False, False, False, '', TempExcelBuffer."Cell Type"::Date);
                        TempExcelBuffer.AddColumn(TempGLEntry."Document No.", False, '', False, False, False, '', TempExcelBuffer."Cell Type"::Text);
                        TempExcelBuffer.AddColumn(TempGLEntry."External Document No.", False, '', False, False, False, '', TempExcelBuffer."Cell Type"::Text);
                        TempExcelBuffer.AddColumn(TempGLEntry."G/L Account Name", False, '', False, False, False, '', TempExcelBuffer."Cell Type"::Text);
                        TempExcelBuffer.AddColumn(Customer."No." + Vendor."No.", False, '', False, False, False, '', TempExcelBuffer."Cell Type"::Text);
                        TempExcelBuffer.AddColumn(Customer.Name + Vendor.Name, False, '', False, False, False, '', TempExcelBuffer."Cell Type"::Text);
                        TempExcelBuffer.AddColumn(Customer."Customer Posting Group" + Vendor."Vendor Posting Group", False, '', False, False, False, '', TempExcelBuffer."Cell Type"::Text);
                        TempExcelBuffer.AddColumn(TempGLEntry."Entry No.", False, '', False, False, False, '', TempExcelBuffer."Cell Type"::Number);
                        TempExcelBuffer.AddColumn(TempGLEntry.Amount, False, '', False, False, False, '', TempExcelBuffer."Cell Type"::Number);
                    Until TempGLEntry.Next() = 0;
                if ExportGLData then CreateNewSheet('GL Entry', CheckMakeBookIsTrue);
            end;

            trigger OnPreDataItem()
            begin
                TempGLEntry.Reset();
                TempGLEntry.DeleteAll();
                SetLoadFields("G/L Account No.", "Posting Date", "Document Date", "Document No.", "External Document No.", "Entry No.", Amount, "Source No.");
                SetRange("Posting Date", FromDate, ToDate);
                "G/L Entry".SetFilter("G/L Account No.", '11343805..11343830|12472100..12472700');//IG_AS 16-07-2025
                if not ExportGLData then CurrReport.Break;
                TempExcelBuffer.NewRow();
                TempExcelBuffer.AddColumn('GL Data', False, '', True, False, True, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn(GetFilters(), False, '', True, False, True, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.NewRow();
                CreateGLDataHeading();
            end;
        }
    }
    requestpage
    {
        SaveValues = true;

        layout
        {
            area(content)
            {
                field(ExportPurchData; ExportPurchData)
                {
                    ApplicationArea = Basic;
                    Caption = 'Export Purchase Data';
                }
                field(ExportSaleData; ExportSaleData)
                {
                    ApplicationArea = Basic;
                    Caption = 'Export Sales Data';
                }
                field(ExportTransferData; ExportTransferData)
                {
                    ApplicationArea = Basic;
                    Caption = 'Export Transfer Data';
                }
                field(ExportGLData; ExportGLData)
                {
                    ApplicationArea = Basic;
                    Caption = 'Export GL Data';
                }
                field(FromDate; FromDate)
                {
                    ApplicationArea = Basic;
                    Caption = 'From Date';
                }
                field(ToDate; ToDate)
                {
                    ApplicationArea = Basic;
                    Caption = 'To Date';
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
    trigger OnPreReport()
    begin
        CheckMakeBookIsTrue := true;
        if (FromDate = 0D) or (ToDate = 0D) then Error(DateRangeError);
        TransferDataItemRunning := false;
        SalesDataItemRunning := false;
        PurchDataItemRunning := false;
    end;

    trigger OnInitReport()
    begin
        TempExcelBuffer.DeleteAll();
    end;

    trigger OnPostReport()
    begin
        CreateExcelBook();
    end;

    var
        gstr: Report "GSTR_2 File Format";
        TempGLEntry: Record "G/L Entry" temporary;
        GLSetup: Record "General Ledger Setup";
        TotalGSTPer: Decimal;
        DetailedGSTLedgerEntry: Record "Detailed GST Ledger Entry";
        LocationName: Text[100];
        LocationStateCode: Code[10];
        LocationGSTNo: Code[20];
        TotalGSTAmount: Decimal;
        TempExcelBuffer: Record "Excel Buffer" temporary;
        Customer: Record Customer;
        Vendor: Record Vendor;
        TaxTransactionValue: Record "Tax Transaction Value";
        GlobalDocumentType: Option " ",Payment,Invoice,"Credit Memo",,,,Refund;
        GlobalTransactionType: Option Purchase,Sales,Transfer,Settlement;
        TDSAmt: Decimal;
        RowNo: Integer;
        ColumnNo: Integer;
        SalesInvDataTxt: label 'SALES INVOICE DATA';
        SalesCrMemoTxt: label 'SALES CREDIT MEMO DATA';
        PurchInvDataTxt: label 'PURCHASE INVOICE DATA';
        PurchCrMemoTxt: label 'PURCHASE CREDIT MEMO DATA';
        TransferShptTxt: label 'TRANSFER SHIPMENT DATA';
        TransferRcptTxt: label 'TRANSFER RECEIPT DATA';
        DocumentNoTxt: label 'Document No.';
        PostingDateTxt: label 'Posting Date';
        CustomerNoTxt: label 'Customer No.';
        CustomerNameTxt: label 'Customer Name';
        VendorNoTxt: label 'Vendor No.';
        VendorNameTxt: label 'Vendor Name';
        GSTNoTxt: label 'GST No.';
        FromLocationName: label 'From Location Name';
        FromLocationStateCode: label 'From Location State Code';
        FromLocationGSTNo: label 'From Location GST No.';
        ToLocationName: label 'To Location Name';
        ToLocationStateCode: label 'To Location State Code';
        ToLocationGSTNo: label 'To Location GST No.';
        DocumentLineNoTxt: label 'Document Line No.';
        ItemNoTxt: label 'Item No.';
        ItemDescTxt: label 'Item Description';
        QuantityTxt: label 'Quantity';
        UnitPriceTxt: label 'Unit Price';
        TaxBaseAmountTxt: label 'Tax Base Amount';
        LineDiscountTxt: label 'Line Discount';
        GSTPercTxt: label 'GST %';
        GSTAmountTxt: label 'GST Amount';
        IGSTPercTxt: label 'IGST Percent';
        CGSTPercTxt: label 'CGST Percent';
        SGSTPercTxt: label 'SGST Percent';
        IGSTAmountTxt: label 'IGST Amount';
        CGSTAmountTxt: label 'CGST Amount';
        SGSTAmountTxt: label 'SGST Amount';
        TotalAmountTxt: label 'Total Amount';
        SalesDataItemRunning: Boolean;
        PurchDataItemRunning: Boolean;
        GSTPlaceOfSupplyTxt: label 'GST Place of Supply';
        GSTGroupCodeTxt: label 'GST Group Code';
        GSTGroupTypeTxt: label 'GST Group Type';
        GSTJurisdictionTypeTxt: label 'GST Jurisdiction Type';
        GSTInvoiceTypeTxt: label 'GST Invoice Type';
        HSNSACCodeTxt: label 'HSN/SAC Code';
        InvoiceTypeTxt: label 'Invoice Type';
        ExemptedTxt: label 'Expempted';
        TransferDataItemRunning: Boolean;
        ExportPurchData: Boolean;
        ExportSaleData: Boolean;
        ExportTransferData: Boolean;
        CGSTAmount: Decimal;
        CGSTPerc: Decimal;
        SGSTAmount: Decimal;
        SGSTPerc: Decimal;
        IGSTAmount: Decimal;
        IGSTPerc: Decimal;
        ECessAmount: Decimal;
        ServerFileName: Text;
        FromDate: Date;
        ToDate: Date;
        DateRangeError: label 'From and To Date must not be blank.';
        VendorInvNoTxt: label 'Vendor Invoice No.';
        VendorInvDateTxt: label 'Vendor Invoice Date';
        VendorCustGSTTypeTxt: label 'Vendor / Customer GST Type';
        GSTINNoTxt: label 'Local GSTIN No.';
        SalesInvGSTBaseAmount: Decimal;
        CheckMakeBookIsTrue: Boolean;
        AmountVar: Decimal;
        ExportGLData: Boolean;

    local procedure PrePareHeading()
    begin
        TempExcelBuffer.NewRow();
        TempExcelBuffer.AddColumn(PostingDateTxt, FALSE, '', true, FALSE, true, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(DocumentNoTxt, FALSE, '', true, FALSE, true, '', TempExcelBuffer."Cell Type"::Text);
        if PurchDataItemRunning then begin
            TempExcelBuffer.AddColumn(VendorInvNoTxt, FALSE, '', true, FALSE, true, '', TempExcelBuffer."Cell Type"::Text);
            TempExcelBuffer.AddColumn(VendorInvDateTxt, FALSE, '', true, FALSE, true, '', TempExcelBuffer."Cell Type"::Text);
        end;
        TempExcelBuffer.AddColumn(DocumentLineNoTxt, FALSE, '', true, FALSE, true, '', TempExcelBuffer."Cell Type"::Text);
        if SalesDataItemRunning then begin
            TempExcelBuffer.AddColumn(CustomerNoTxt, FALSE, '', true, FALSE, true, '', TempExcelBuffer."Cell Type"::Text);
        end
        else if PurchDataItemRunning then begin
            TempExcelBuffer.AddColumn(VendorNoTxt, FALSE, '', true, FALSE, true, '', TempExcelBuffer."Cell Type"::Text);
        end;
        if SalesDataItemRunning then begin
            TempExcelBuffer.AddColumn(CustomerNameTxt, FALSE, '', true, FALSE, true, '', TempExcelBuffer."Cell Type"::Text);
        end
        else if PurchDataItemRunning then begin
            TempExcelBuffer.AddColumn(VendorNameTxt, FALSE, '', true, FALSE, true, '', TempExcelBuffer."Cell Type"::Text);
        end;
        if SalesDataItemRunning or PurchDataItemRunning then begin
            TempExcelBuffer.AddColumn(VendorCustGSTTypeTxt, FALSE, '', true, FALSE, true, '', TempExcelBuffer."Cell Type"::Text);
            TempExcelBuffer.AddColumn(GSTNoTxt, FALSE, '', true, FALSE, true, '', TempExcelBuffer."Cell Type"::Text);
        end;
        TempExcelBuffer.AddColumn(FromLocationName, FALSE, '', true, FALSE, true, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(FromLocationStateCode, FALSE, '', true, FALSE, true, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(FromLocationGSTNo, FALSE, '', true, FALSE, true, '', TempExcelBuffer."Cell Type"::Text);
        if TransferDataItemRunning then begin
            TempExcelBuffer.AddColumn(ToLocationName, FALSE, '', true, FALSE, true, '', TempExcelBuffer."Cell Type"::Text);
            TempExcelBuffer.AddColumn(ToLocationStateCode, FALSE, '', true, FALSE, true, '', TempExcelBuffer."Cell Type"::Text);
            TempExcelBuffer.AddColumn(ToLocationGSTNo, FALSE, '', true, FALSE, true, '', TempExcelBuffer."Cell Type"::Text);
        end;
        TempExcelBuffer.AddColumn(ItemNoTxt, FALSE, '', true, FALSE, true, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(ItemDescTxt, FALSE, '', true, FALSE, true, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(QuantityTxt, FALSE, '', true, FALSE, true, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(UnitPriceTxt, FALSE, '', true, FALSE, true, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(TaxBaseAmountTxt, FALSE, '', true, FALSE, true, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(LineDiscountTxt, FALSE, '', true, FALSE, true, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(GSTPercTxt, FALSE, '', true, FALSE, true, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(GSTAmountTxt, FALSE, '', true, FALSE, true, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(IGSTPercTxt, FALSE, '', true, FALSE, true, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(IGSTAmountTxt, FALSE, '', true, FALSE, true, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(CGSTPercTxt, FALSE, '', true, FALSE, true, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(CGSTAmountTxt, FALSE, '', true, FALSE, true, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(SGSTPercTxt, FALSE, '', true, FALSE, true, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(SGSTAmountTxt, FALSE, '', true, FALSE, true, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('TDS Amount', FALSE, '', true, FALSE, true, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(TotalAmountTxt, FALSE, '', true, FALSE, true, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(GSTPlaceOfSupplyTxt, FALSE, '', true, FALSE, true, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(GSTGroupCodeTxt, FALSE, '', true, FALSE, true, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(GSTGroupTypeTxt, FALSE, '', true, FALSE, true, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(GSTJurisdictionTypeTxt, FALSE, '', true, FALSE, true, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(HSNSACCodeTxt, FALSE, '', true, FALSE, true, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(InvoiceTypeTxt, FALSE, '', true, FALSE, true, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(ExemptedTxt, FALSE, '', true, FALSE, true, '', TempExcelBuffer."Cell Type"::Text);
        if not TransferDataItemRunning then TempExcelBuffer.AddColumn('Credit Availment ', FALSE, '', true, FALSE, true, '', TempExcelBuffer."Cell Type"::Text);
        if ExportPurchData = true then begin //Alle_290818
            TempExcelBuffer.AddColumn(GSTINNoTxt, FALSE, '', true, FALSE, true, '', TempExcelBuffer."Cell Type"::Text);
        end;//IG_AS 22-08-2025
    end;

    local procedure CreateGLDataHeading()
    var
        CustVendNoLbl: Label 'Cust./Vend. No';
        CustVendNameLbl: Label 'Cust./Vend. Name';
        EntryNoLbl: Label 'Entry No.';
        AmountLbl: Label 'Amount';
        GLNoLbl: Label 'GL No.';
        DocumentDateLbl: Label 'Document Date.';
        PostingGroupLbl: Label 'Posting Group';
    begin
        TempExcelBuffer.NewRow();
        TempExcelBuffer.AddColumn(GLNoLbl, False, '', true, False, true, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(PostingDateTxt, False, '', true, False, true, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(DocumentDateLbl, False, '', true, False, true, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(DocumentNoTxt, False, '', true, False, true, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(VendorInvNoTxt, False, '', true, False, true, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('G/L Account Name', False, '', true, False, true, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(CustVendNoLbl, False, '', true, False, true, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(CustVendNameLbl, False, '', true, False, true, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(PostingGroupLbl, False, '', true, False, true, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(EntryNoLbl, False, '', true, False, true, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(AmountLbl, False, '', true, False, true, '', TempExcelBuffer."Cell Type"::Text);
    end;

    Local procedure CreateExcelBook();
    begin
        TempExcelBuffer.CloseBook();
        TempExcelBuffer.SetFriendlyFilename('GST Excel Data Export');
        TempExcelBuffer.OpenExcel();
    end;

    local procedure CreateNewSheet(SheetName: Text[250]; NewBook: Boolean)
    begin
        if NewBook then
            TempExcelBuffer.CreateNewBook(SheetName)
        else
            TempExcelBuffer.SelectOrAddSheet(SheetName);
        TempExcelBuffer.WriteSheet(SheetName, CompanyName, UserId);
        TempExcelBuffer.DeleteAll();
        TempExcelBuffer.ClearNewRow();
    end;
}
