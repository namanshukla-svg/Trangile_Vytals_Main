report 55016 "OTIF SO Report"
{
    ApplicationArea = All;
    Caption = 'OTIF SO Report';
    UsageCategory = ReportsAndAnalysis;
    ProcessingOnly = true;
    UseRequestPage = true;

    dataset
    {
        dataitem(SalesInvoiceHeader; "Sales Invoice Header")
        {
            DataItemTableView = SORTING("No.");
            RequestFilterFields = "Posting Date";

            dataitem(SalesInvoiceLine; "Sales Invoice Line")
            {
                DataItemLinkReference = SalesInvoiceHeader;
                DataItemLink = "Document No." = field("No.");
                DataItemTableView = where(Type = filter(Item));

                trigger OnAfterGetRecord()
                var
                    SalesOrderArch: Record "Sales Header Archive";
                    SalesLineArch: Record "Sales Line Archive";
                    SalesLineArch1: Record "Sales Line Archive";
                begin

                    SalesOrderDate := 0D;
                    PlannedShipmentDate := 0D;
                    OutputDate := 0D;
                    SOQuantity := 0;
                    DayDifference := 0;

                    if SalesHeader.Get(SalesHeader."Document Type"::Order, SalesInvoiceHeader."Order/Scd. No.") then begin
                        SalesOrderDate := SalesHeader."Order Date";
                        SalesLine.Reset();
                        SalesLine.SetRange("Document Type", SalesLine."Document Type"::Order);
                        SalesLine.SetRange("Document No.", SalesInvoiceHeader."Order/Scd. No.");
                        SalesLine.SetRange(Type, SalesLine.Type::Item);
                        SalesLine.SetRange("Line No.", SalesInvoiceLine."Line No.");
                        if SalesLine.FindFirst() then begin
                            OutputDate := SalesLine."Output Date";
                            SOQuantity := SalesLine.Quantity;
                        end;

                    end else begin
                        SalesOrderArch.Reset();
                        SalesOrderArch.SetRange("Document Type", SalesOrderArch."Document Type"::Order);
                        SalesOrderArch.SetRange("No.", SalesInvoiceHeader."Order/Scd. No.");
                        if SalesOrderArch.FindFirst() then
                            SalesOrderDate := SalesOrderArch."Order Date";

                        SalesLineArch.Reset();
                        SalesLineArch.SetRange("Document Type", SalesLineArch."Document Type"::Order);
                        SalesLineArch.SetRange("Document No.", SalesInvoiceHeader."Order/Scd. No.");
                        SalesLineArch.SetRange(Type, SalesLineArch.Type::Item);
                        SalesLineArch.SetRange("No.", SalesInvoiceLine."No.");
                        SalesLineArch.SetRange("Line No.", SalesInvoiceLine."Line No.");
                        if SalesLineArch.FindFirst() then                                                           // PlannedShipmentDate := SalesLineArch."Shipment Date";
                            SOQuantity := SalesLineArch.Quantity;

                    end;

                    SalesLineArch1.Reset();
                    SalesLineArch1.SetRange("Document Type", SalesLineArch1."Document Type"::Order);
                    SalesLineArch1.SetRange("Document No.", SalesInvoiceHeader."Order/Scd. No.");
                    SalesLineArch1.SetRange(Type, SalesLineArch1.Type::Item);
                    SalesLineArch1.SetRange("No.", SalesInvoiceLine."No.");
                    SalesLineArch1.SetRange("Line No.", SalesInvoiceLine."Line No.");
                    if SalesLineArch1.FindFirst() then
                        PlannedShipmentDate := SalesLineArch1."Shipment Date"
                    else begin
                        SalesLine1.Reset();
                        SalesLine1.SetRange("Document Type", SalesLine1."Document Type"::Order);
                        SalesLine1.SetRange("Document No.", SalesInvoiceHeader."Order/Scd. No.");
                        SalesLine1.SetRange(Type, SalesLine1.Type::Item);
                        SalesLine1.SetRange("Line No.", SalesInvoiceLine."Line No.");
                        if SalesLine1.FindFirst() then
                            PlannedShipmentDate := SalesLine1."Shipment Date";
                    end;
                    if (PlannedShipmentDate <> 0D) and (OutputDate <> 0D) then
                        DayDifference := PlannedShipmentDate - OutputDate;

                    ExcelBuffer.NewRow();
                    ExcelBuffer.AddColumn(SalesInvoiceHeader."Order/Scd. No.", false, '', false, false, false, '', ExcelBuffer."cell type"::Text);
                    ExcelBuffer.AddColumn(SalesOrderDate, false, '', false, false, false, '', ExcelBuffer."cell type"::Date);
                    ExcelBuffer.AddColumn(SalesInvoiceHeader."No.", false, '', false, false, false, '', ExcelBuffer."cell type"::Text);
                    ExcelBuffer.AddColumn(SalesInvoiceHeader."Posting Date", false, '', false, false, false, '', ExcelBuffer."cell type"::Date);
                    ExcelBuffer.AddColumn(SalesInvoiceLine."No.", false, '', false, false, false, '', ExcelBuffer."cell type"::Text);
                    ExcelBuffer.AddColumn(SalesInvoiceLine.Description, false, '', false, false, false, '', ExcelBuffer."cell type"::Text);
                    ExcelBuffer.AddColumn(SalesInvoiceLine."Description 2", false, '', false, false, false, '', ExcelBuffer."cell type"::Number);
                    ExcelBuffer.AddColumn(SalesInvoiceLine."Unit of Measure Code", false, '', false, false, false, '', ExcelBuffer."cell type"::Text);
                    ExcelBuffer.AddColumn(SOQuantity, false, '', false, false, false, '', ExcelBuffer."cell type"::Number);
                    ExcelBuffer.AddColumn(SalesInvoiceLine.Quantity, false, '', false, false, false, '', ExcelBuffer."cell type"::Number);
                    ExcelBuffer.AddColumn(PlannedShipmentDate, false, '', false, false, false, '', ExcelBuffer."cell type"::Text);
                    ExcelBuffer.AddColumn(OutputDate, false, '', false, false, false, '', ExcelBuffer."cell type"::Text);
                    ExcelBuffer.AddColumn(DayDifference, false, '', false, false, false, '', ExcelBuffer."cell type"::Number);
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
        ShippingAgent: Record "Shipping Agent";
        customer: Record Customer;
        ShippingAgentCodeName: Text;
        ShippingAgentCode1Name: Text;
        ActualShippingAgentcodeName: Text;
        SalesHeader: Record "Sales Header";
        SalesLine: Record "Sales Line";
        SalesLine1: Record "Sales Line";
        SalesHeaderDocumentDate: Date;
        GatePassHeader: Record "SSD Gate Pass Header";
        GatePassLine: Record "SSD Gate Pass Line";
        GatePassHeaderDate: Date;
        FreightZone: Text;
        Remarks: Text;
        PlannedShipmentDate: Date;
        SalesOrderDate: Date;
        SalesOrderReleasedDate: DateTime;
        LeadTime: DateFormula;
        OutputDate: Date;
        DayDifference: Integer;
        SOQuantity: Decimal;

    procedure CreateHeading()
    begin
        ExcelBuffer.NewRow();
        ExcelBuffer.AddColumn('SO No.', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
        ExcelBuffer.AddColumn('SO Date', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
        ExcelBuffer.AddColumn('Invoice No.', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
        ExcelBuffer.AddColumn('Invoice Date', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
        ExcelBuffer.AddColumn('Item Code', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
        ExcelBuffer.AddColumn('Description', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
        ExcelBuffer.AddColumn('Description 2', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
        ExcelBuffer.AddColumn('UOM', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
        ExcelBuffer.AddColumn('SO Qty.', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
        ExcelBuffer.AddColumn('Invoice Qty.', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
        ExcelBuffer.AddColumn('Shipment Date', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
        ExcelBuffer.AddColumn('Material Readiness Date and Time', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
        ExcelBuffer.AddColumn('Variance (Shipment Date - Material Readiness Date)', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
    end;

    Local procedure CreateExcelBook();
    begin
        ExcelBuffer.CreateNewBook('OTIF SO Report');
        ExcelBuffer.WriteSheet('OTIF Report', CompanyName, UserId);
        ExcelBuffer.CloseBook();
        ExcelBuffer.SetFriendlyFilename('OTIF Report');
        ExcelBuffer.OpenExcel();
    end;
}
