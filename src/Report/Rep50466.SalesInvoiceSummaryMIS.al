// report 50466 "Sales Invoice Summary - MIS"
// {
//     ApplicationArea = All;
//     Caption = 'Sales Invoice Report Summary - MIS';
//     UsageCategory = ReportsAndAnalysis;
//     ProcessingOnly = true;

//     dataset
//     {
//         dataitem(Integer; "Integer")
//         {
//             trigger OnAfterGetRecord()
//             begin
//                 if StartDate <> 0D then if EndDate <> 0D then SalesInvoiceReport.SetRange(SalesInvoiceReport.PostingDate, StartDate, EndDate);
//                 SalesInvoiceReport.Open();
//                 while SalesInvoiceReport.Read() do MakeExcelBody(SalesInvoiceReport);
//             end;

//             trigger OnPreDataItem()
//             begin
//                 SetRange(Number, 1);
//             end;
//         }
//     }
//     requestpage
//     {
//         layout
//         {
//             area(content)
//             {
//                 group(FILTERS)
//                 {
//                     field(StartDate; StartDate)
//                     {
//                         ApplicationArea = ALL;
//                     }
//                     field(EndDate; EndDate)
//                     {
//                         ApplicationArea = ALL;
//                     }
//                 }
//             }
//         }
//         actions
//         {
//             area(processing)
//             {
//             }
//         }
//     }
//     trigger OnPreReport()
//     begin
//         ExcelBuffer.DeleteAll();
//         CreateHeading();
//     end;

//     trigger OnPostReport()
//     begin
//         CreateExcelBook();
//     end;

//     var
//         SalesInvoiceReport: Query SalesInvoiceReport;
//         SalespersonPurchaser: Record "Salesperson/Purchaser";
//         SalespersonPurchaserName: Text;
//         ExcelBuffer: Record "Excel Buffer";
//         IGST_Amt: Decimal;
//         IGST_Per: Decimal;
//         CGST_Amt: Decimal;
//         CGST_Per: Decimal;
//         SGST_Amt: Decimal;
//         SGST_Per: Decimal;
//         GSTAmount: Decimal;
//         GST_Per: Decimal;
//         SalesAreaCode: Code[20];
//         SalesAreaName: Text;
//         DetailedGSTLedgerEntry1: Record "Detailed GST Ledger Entry";
//         DimensionSetEntry: Record "Dimension Set Entry";
//         GLSetup: Record "General Ledger Setup";
//         ItemCategoryCode: Code[20];
//         ItemCategory: Record "Item Category";
//         StartDate: Date;
//         EndDate: Date;

//     procedure CreateHeading()
//     begin
//         ExcelBuffer.NewRow();
//         ExcelBuffer.AddColumn('ZD Inv No', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
//         ExcelBuffer.AddColumn('Type Of Invoice', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
//         ExcelBuffer.AddColumn('Inv Date', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
//         ExcelBuffer.AddColumn('Due Date', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
//         ExcelBuffer.AddColumn('Sell to Customer Code', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
//         ExcelBuffer.AddColumn('Sell to Name', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
//         ExcelBuffer.AddColumn('Bill to Code', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
//         ExcelBuffer.AddColumn('Bill to Name', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
//         ExcelBuffer.AddColumn('Sales Area Name', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
//         ExcelBuffer.AddColumn('Salesperson Code', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
//         ExcelBuffer.AddColumn('Item Category Code', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
//         ExcelBuffer.AddColumn('Item Code', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
//         ExcelBuffer.AddColumn('Description', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
//         ExcelBuffer.AddColumn('Description 2', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
//         ExcelBuffer.AddColumn('Unit of Measure Code', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
//         ExcelBuffer.AddColumn('Quantity', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
//         ExcelBuffer.AddColumn('Net Weight', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
//         ExcelBuffer.AddColumn('Unit Price', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
//         ExcelBuffer.AddColumn('Line Amount', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
//         ExcelBuffer.AddColumn('GST %', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
//         ExcelBuffer.AddColumn('HSN/SAC', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
//         ExcelBuffer.AddColumn('GST Amount', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
//         ExcelBuffer.AddColumn('Transporter Name', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
//         ExcelBuffer.AddColumn('Transport Method', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
//         ExcelBuffer.AddColumn('Shipment Method', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
//         ExcelBuffer.AddColumn('LR_RR No_', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
//         ExcelBuffer.AddColumn('LR_RR Date', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
//         ExcelBuffer.AddColumn('Actual Delivery Date', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
//         ExcelBuffer.AddColumn('Amount to Customer', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
//         ExcelBuffer.AddColumn('Firm Freight', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
//         ExcelBuffer.AddColumn('Calculated Freight Field', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
//         ExcelBuffer.AddColumn('Remarks1', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
//     end;

//     local procedure MakeExcelBody(SalesInvoiceReport: Query SalesInvoiceReport);
//     var
//         GSTQ: Query DetailedGSTLedgerEntryQUE;
//     begin
//         GST_Per := 0;
//         GSTAmount := 0;
//         GSTQ.SetRange(GSTQ.Document_No_, SalesInvoiceReport.No);
//         GSTQ.SetRange(GSTQ.Document_Line_No_, SalesInvoiceReport.Line_No_);
//         GSTQ.Open();
//         while GSTQ.Read() do begin
//             GST_Per := GSTQ.GST__;
//             GSTAmount := Abs(GSTQ.GST_Amount);
//         end;
//         GLSetup.Get();
//         if DimensionSetEntry.Get(SalesInvoiceReport.Dimension_Set_ID, GLSetup."Shortcut Dimension 5 Code") then begin
//             DimensionSetEntry.CalcFields("Dimension Value Name");
//             SalesAreaCode := DimensionSetEntry."Dimension Value Code";
//             SalesAreaName := DimensionSetEntry."Dimension Value Name";
//         end
//         else begin
//             SalesAreaCode := '';
//             SalesAreaName := '';
//         end;
//         ExcelBuffer.NewRow();
//         ExcelBuffer.AddColumn(SalesInvoiceReport.No, false, '', false, false, false, '', ExcelBuffer."cell type"::Text);
//         ExcelBuffer.AddColumn(SalesInvoiceReport.TypeofInvoice, false, '', false, false, false, '', ExcelBuffer."cell type"::Text);
//         ExcelBuffer.AddColumn(SalesInvoiceReport.PostingDate, false, '', false, false, false, '', ExcelBuffer."cell type"::Date);
//         ExcelBuffer.AddColumn(SalesInvoiceReport.DueDate, false, '', false, false, false, '', ExcelBuffer."cell type"::Date);
//         ExcelBuffer.AddColumn(SalesInvoiceReport.SelltoCustomerNo, false, '', false, false, false, '', ExcelBuffer."cell type"::Text);
//         ExcelBuffer.AddColumn(SalesInvoiceReport.SelltoCustomerName, false, '', false, false, false, '', ExcelBuffer."cell type"::Text);
//         ExcelBuffer.AddColumn(SalesInvoiceReport.BilltoCustomerNo, false, '', false, false, false, '', ExcelBuffer."cell type"::Text);
//         ExcelBuffer.AddColumn(SalesInvoiceReport.BilltoName, false, '', false, false, false, '', ExcelBuffer."cell type"::Text);
//         ExcelBuffer.AddColumn(SalesAreaName, false, '', false, false, false, '', ExcelBuffer."cell type"::Text);
//         ExcelBuffer.AddColumn(SalesInvoiceReport.SalespersonCode, false, '', false, false, false, '', ExcelBuffer."cell type"::Text);
//         ExcelBuffer.AddColumn(SalesInvoiceReport.Parent_Category, false, '', false, false, false, '', ExcelBuffer."cell type"::Text);
//         ExcelBuffer.AddColumn(SalesInvoiceReport.No_, false, '', false, false, false, '', ExcelBuffer."cell type"::Text);
//         ExcelBuffer.AddColumn(SalesInvoiceReport.Description, false, '', false, false, false, '', ExcelBuffer."cell type"::Text);
//         ExcelBuffer.AddColumn(SalesInvoiceReport.Description_2, false, '', false, false, false, '', ExcelBuffer."cell type"::Text);
//         ExcelBuffer.AddColumn(SalesInvoiceReport.Unit_of_Measure_Code, false, '', false, false, false, '', ExcelBuffer."cell type"::Text);
//         ExcelBuffer.AddColumn(SalesInvoiceReport.Quantity, false, '', false, false, false, '', ExcelBuffer."cell type"::Number);
//         ExcelBuffer.AddColumn(SalesInvoiceReport.Net_Weight, false, '', false, false, false, '', ExcelBuffer."cell type"::Number);
//         if SalesInvoiceReport.CurrencyCode <> '' then begin
//             ExcelBuffer.AddColumn(SalesInvoiceReport.Unit_Price / SalesInvoiceReport.CurrencyFactor, false, '', false, false, false, '', ExcelBuffer."cell type"::Number);
//             ExcelBuffer.AddColumn(SalesInvoiceReport.Line_Amount / SalesInvoiceReport.CurrencyFactor, false, '', false, false, false, '', ExcelBuffer."cell type"::Number);
//         end
//         else begin
//             ExcelBuffer.AddColumn(SalesInvoiceReport.Unit_Price, false, '', false, false, false, '', ExcelBuffer."cell type"::Number);
//             ExcelBuffer.AddColumn(SalesInvoiceReport.Line_Amount, false, '', false, false, false, '', ExcelBuffer."cell type"::Number);
//         end;
//         ExcelBuffer.AddColumn(GST_Per, false, '', false, false, false, '', ExcelBuffer."cell type"::Number);
//         ExcelBuffer.AddColumn(SalesInvoiceReport.HSN_SAC_Code, false, '', false, false, false, '', ExcelBuffer."cell type"::Text);
//         ExcelBuffer.AddColumn(GSTAmount, false, '', false, false, false, '', ExcelBuffer."cell type"::Number);
//         ExcelBuffer.AddColumn(SalesInvoiceReport.ShippingAgentCode, false, '', false, false, false, '', ExcelBuffer."cell type"::Text);
//         ExcelBuffer.AddColumn(SalesInvoiceReport.Transport_Method, false, '', false, false, false, '', ExcelBuffer."cell type"::Text);
//         ExcelBuffer.AddColumn(SalesInvoiceReport.ShipmentMethodCode, false, '', false, false, false, '', ExcelBuffer."cell type"::Text);
//         ExcelBuffer.AddColumn(SalesInvoiceReport.LRRRNo, false, '', false, false, false, '', ExcelBuffer."cell type"::Text);
//         ExcelBuffer.AddColumn(SalesInvoiceReport.LRRRDate, false, '', false, false, false, '', ExcelBuffer."cell type"::Date);
//         ExcelBuffer.AddColumn(SalesInvoiceReport.ActualDeliveryDate, false, '', false, false, false, '', ExcelBuffer."cell type"::Date);
//         if SalesInvoiceReport.CurrencyCode <> '' then begin
//             ExcelBuffer.AddColumn(SalesInvoiceReport.Line_Amount / SalesInvoiceReport.CurrencyFactor + GSTAmount, false, '', false, false, false, '', ExcelBuffer."cell type"::Number);
//         end
//         else begin
//             ExcelBuffer.AddColumn(SalesInvoiceReport.Line_Amount + GSTAmount, false, '', false, false, false, '', ExcelBuffer."cell type"::Number);
//         end;
//         ExcelBuffer.AddColumn(SalesInvoiceReport.FirmFreight, false, '', false, false, false, '', ExcelBuffer."cell type"::Text);
//         if SalesInvoiceReport.CurrencyCode <> '' then
//             ExcelBuffer.AddColumn(SalesInvoiceReport.CalculatedFreightAmount / SalesInvoiceReport.CurrencyFactor, false, '', false, false, false, '', ExcelBuffer."cell type"::Number)
//         else
//             ExcelBuffer.AddColumn(SalesInvoiceReport.CalculatedFreightAmount, false, '', false, false, false, '', ExcelBuffer."cell type"::Number);
//         ExcelBuffer.AddColumn(SalesInvoiceReport.Remarks1, false, '', false, false, false, '', ExcelBuffer."cell type"::Text);
//     end;

//     Local procedure CreateExcelBook();
//     begin
//         ExcelBuffer.CreateNewBook('Sales Invoice Report Summary - MIS');
//         ExcelBuffer.WriteSheet('Sales Invoice Report Summary - MIS', CompanyName, UserId);
//         ExcelBuffer.CloseBook();
//         ExcelBuffer.SetFriendlyFilename('Sales Invoice Report Summary - MIS');
//         ExcelBuffer.OpenExcel();
//     end;
// }//IG_AS Old Report modified below at 16-07-2025

//IG_AS 16-07-2025
report 50466 "Sales Invoice Summary - MIS"
{
    ApplicationArea = All;
    Caption = 'Sales Invoice Report Summary - MIS';
    UsageCategory = ReportsAndAnalysis;
    UseRequestPage = false;
    ProcessingOnly = true;

    dataset
    {
        dataitem(Integer; "Integer")
        {
            DataItemTableView = where(Number = const(1));

            trigger OnAfterGetRecord()
            begin
                Xmlport.run(Xmlport::"Sales Invoice Summary - MIS");
            end;
        }
    }
    requestpage
    {
        layout
        {
            area(content)
            {
            }
        }
        actions
        {
            area(processing)
            {
            }
        }
    }
}
//IG_AS 16-07-2025

