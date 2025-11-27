report 50460 "Freight Final - MIS"
{
    ApplicationArea = All;
    Caption = 'Freight Final - MIS';
    UsageCategory = ReportsAndAnalysis;
    ProcessingOnly = true;
    UseRequestPage = true;

    dataset
    {
        dataitem("Sales Invoice Header"; "Sales Invoice Header")
        {
            DataItemTableView = SORTING("No.");
            RequestFilterFields = "Posting Date";

            trigger OnAfterGetRecord()
            begin
                VARTYPE:='';
                SumofGrossWt:=0;
                InvoiceBasicAmount:=0;
                InvoiceGrossAmount:=0;
                SalesInvoiceLine.Reset();
                SalesInvoiceLine.SetRange("Document No.", "Sales Invoice Header"."No.");
                SalesInvoiceLine.SetRange(Type, SalesInvoiceLine.Type::Item);
                if SalesInvoiceLine.FindSet()then repeat SumofGrossWt+=SalesInvoiceLine."Gross Wt";
                        InvoiceBasicAmount+=SalesInvoiceLine."Line Amount";
                    until SalesInvoiceLine.Next() = 0;
                // 
                CgstRate:=0;
                CgstAmount:=0;
                SgstRate:=0;
                SgstAmount:=0;
                IgstRate:=0;
                IgstAmount:=0;
                TotalGST:=0;
                SalesInvoiceLine.Reset();
                SalesInvoiceLine.SetRange("Document No.", "Sales Invoice Header"."No.");
                SalesInvoiceLine.SetRange(Type, SalesInvoiceLine.Type::Item);
                if SalesInvoiceLine.FindSet()then repeat DetailedGSTLedgerEntry.Reset();
                        DetailedGSTLedgerEntry.SetRange("Transaction Type", DetailedGSTLedgerEntry."Transaction Type"::Sales);
                        DetailedGSTLedgerEntry.SetRange("Document Type", DetailedGSTLedgerEntry."Document Type"::Invoice);
                        DetailedGSTLedgerEntry.SetRange(DetailedGSTLedgerEntry."Entry Type", DetailedGSTLedgerEntry."entry type"::"Initial Entry");
                        DetailedGSTLedgerEntry.SetRange(DetailedGSTLedgerEntry."Document No.", SalesInvoiceLine."Document No.");
                        DetailedGSTLedgerEntry.SetRange("Document Line No.", SalesInvoiceLine."Line No.");
                        if DetailedGSTLedgerEntry.FindSet()then repeat if DetailedGSTLedgerEntry."GST Component Code" = 'CGST' then begin
                                    CgstRate:=DetailedGSTLedgerEntry."GST %";
                                    CgstAmount:=Abs(DetailedGSTLedgerEntry."GST Amount");
                                end;
                                if DetailedGSTLedgerEntry."GST Component Code" = 'SGST' then begin
                                    SgstRate:=DetailedGSTLedgerEntry."GST %";
                                    SgstAmount:=Abs(DetailedGSTLedgerEntry."GST Amount");
                                end;
                                if DetailedGSTLedgerEntry."GST Component Code" = 'IGST' then begin
                                    IgstRate:=DetailedGSTLedgerEntry."GST %";
                                    IgstAmount:=Abs(DetailedGSTLedgerEntry."GST Amount");
                                end;
                            until DetailedGSTLedgerEntry.Next = 0;
                        TotalGST+=CgstAmount + SgstAmount + IgstAmount;
                        VARTYPE:=Format(SalesInvoiceLine.Type);
                    until SalesInvoiceLine.Next() = 0;
                // 
                if "Sales Invoice Header"."Currency Code" <> '' then begin
                    TotalGST:=TotalGST * "Currency Factor";
                end;
                InvoiceGrossAmount:=TotalGST + InvoiceBasicAmount;
                if VARTYPE <> 'Item' then CurrReport.Skip();
                ExcelBuffer.NewRow();
                ExcelBuffer.AddColumn("Sales Invoice Header"."No.", false, '', false, false, false, '', ExcelBuffer."cell type"::Text);
                ExcelBuffer.AddColumn("Sales Invoice Header"."Posting Date", false, '', false, false, false, '', ExcelBuffer."cell type"::Text);
                ExcelBuffer.AddColumn("Sales Invoice Header"."Sell-to Customer Name", false, '', false, false, false, '', ExcelBuffer."cell type"::Text);
                ExcelBuffer.AddColumn("Sales Invoice Header"."Bill-to Name", false, '', false, false, false, '', ExcelBuffer."cell type"::Text);
                ExcelBuffer.AddColumn("Sales Invoice Header"."Freight Zone", false, '', false, false, false, '', ExcelBuffer."cell type"::Text);
                ExcelBuffer.AddColumn("Sales Invoice Header".State, false, '', false, false, false, '', ExcelBuffer."cell type"::Text);
                ExcelBuffer.AddColumn("Sales Invoice Header"."Actual Shipping Agent code", false, '', false, false, false, '', ExcelBuffer."cell type"::Text);
                ExcelBuffer.AddColumn("Sales Invoice Header"."Transport Method", false, '', false, false, false, '', ExcelBuffer."cell type"::Text);
                ExcelBuffer.AddColumn("Sales Invoice Header"."Shipment Method Code", false, '', false, false, false, '', ExcelBuffer."cell type"::Text);
                ExcelBuffer.AddColumn(SumofGrossWt, false, '', false, false, false, '', ExcelBuffer."cell type"::Text);
                ExcelBuffer.AddColumn("Sales Invoice Header"."Freight Amount", false, '', false, false, false, '', ExcelBuffer."cell type"::Text);
                ExcelBuffer.AddColumn("Sales Invoice Header"."Firm Freight", false, '', false, false, false, '', ExcelBuffer."cell type"::Text);
                ExcelBuffer.AddColumn("Sales Invoice Header"."Actual Shipping Agent code", false, '', false, false, false, '', ExcelBuffer."cell type"::Text);
                ExcelBuffer.AddColumn("Sales Invoice Header"."Calculated Freight Amount", false, '', false, false, false, '', ExcelBuffer."cell type"::Text);
                ExcelBuffer.AddColumn("Sales Invoice Header"."Sell-to City", false, '', false, false, false, '', ExcelBuffer."cell type"::Text);
                ExcelBuffer.AddColumn("Sales Invoice Header"."Shortcut Dimension 1 Code", false, '', false, false, false, '', ExcelBuffer."cell type"::Text);
                ExcelBuffer.AddColumn(VARTYPE, false, '', false, false, false, '', ExcelBuffer."cell type"::Text);
                ExcelBuffer.AddColumn("Sales Invoice Header"."LR/RR No.", false, '', false, false, false, '', ExcelBuffer."cell type"::Text);
                ExcelBuffer.AddColumn("Sales Invoice Header"."LR/RR Date", false, '', false, false, false, '', ExcelBuffer."cell type"::Text);
                ExcelBuffer.AddColumn(InvoiceBasicAmount, false, '', false, false, false, '', ExcelBuffer."cell type"::Text);
                ExcelBuffer.AddColumn(InvoiceGrossAmount, false, '', false, false, false, '', ExcelBuffer."cell type"::Text);
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
    var ShipmentDateWO: Date;
    SalesInvoiceLine: Record "Sales Invoice Line";
    ExcelBuffer: Record "Excel Buffer";
    DetailedGSTLedgerEntry: Record "Detailed GST Ledger Entry";
    SumofGrossWt: Decimal;
    CgstRate: Decimal;
    CgstAmount: Decimal;
    SgstRate: Decimal;
    SgstAmount: Decimal;
    IgstRate: Decimal;
    IgstAmount: Decimal;
    TotalGST: Decimal;
    InvoiceBasicAmount: Decimal;
    InvoiceGrossAmount: Decimal;
    VARTYPE: Text;
    ItemCategoryCode: Code[20];
    ItemCategory: Record "Item Category";
    ShipmentDate2: Date;
    procedure CreateHeading()
    begin
        ExcelBuffer.NewRow();
        ExcelBuffer.AddColumn('Sales Invoice No.', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
        ExcelBuffer.AddColumn('Posting Date', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
        ExcelBuffer.AddColumn('Sell-to Customer Name', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
        ExcelBuffer.AddColumn('Bill-to Name', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
        ExcelBuffer.AddColumn('Freight Zone', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
        ExcelBuffer.AddColumn('State', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
        ExcelBuffer.AddColumn('Shipping Agent Code', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
        ExcelBuffer.AddColumn('Transport Method', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
        ExcelBuffer.AddColumn('Shipment Method Code', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
        ExcelBuffer.AddColumn('Sum of Gross Wt', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
        ExcelBuffer.AddColumn('Freight Amount', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
        ExcelBuffer.AddColumn('Firm Freight', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
        ExcelBuffer.AddColumn('Actual Shipping Agent code', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
        ExcelBuffer.AddColumn('Calculated Freight Amount', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
        ExcelBuffer.AddColumn('Sell-to City', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
        ExcelBuffer.AddColumn('Cost Center', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
        ExcelBuffer.AddColumn('Type', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
        ExcelBuffer.AddColumn('LR_RR No_', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
        ExcelBuffer.AddColumn('LR_RR Date', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
        ExcelBuffer.AddColumn('Invoice Basic Amount', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
        ExcelBuffer.AddColumn('Invoice Gross Amount', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
    end;
    Local procedure CreateExcelBook();
    begin
        ExcelBuffer.CreateNewBook('Freight Final - MIS');
        ExcelBuffer.WriteSheet('Freight Final - MIS', CompanyName, UserId);
        ExcelBuffer.CloseBook();
        ExcelBuffer.SetFriendlyFilename('Freight Final - MIS');
        ExcelBuffer.OpenExcel();
    end;
}
