report 50464 "Sales Cum Logistics Report"
{
    ApplicationArea = All;
    Caption = 'Sales Cum Logistics Report';
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
                DataItemTableView = where(Type = filter(Item));

                trigger OnAfterGetRecord()
                var
                    ItemRec: Record Item;
                    SalesOrderArch: Record "Sales Header Archive";
                    SalesLineArch: Record "Sales Line Archive";
                    ApprovalEntry: Record "Approval Entry";
                begin
                    PlannedShipmentDate := 0D;
                    Clear(LeadTime);
                    Clear(SalesOrderReleasedDate);
                    SalesOrderDate := 0D;
                    ApprovalEntry.Reset();
                    ApprovalEntry.SetRange("Document Type", ApprovalEntry."Document Type"::Order);
                    ApprovalEntry.SetRange("Document No.", "Sales Invoice Header"."Order/Scd. No.");
                    ApprovalEntry.SetRange(Status, ApprovalEntry.Status::Approved);
                    if ApprovalEntry.FindFirst() then
                        SalesOrderReleasedDate := ApprovalEntry."Last Date-Time Modified";
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
                    if SalespersonPurchaser.Get("Sales Invoice Header"."Salesperson Code") then
                        SalespersonPurchaserName := SalespersonPurchaser.Name
                    else
                        SalespersonPurchaserName := '';
                    if SalesHeader.Get(SalesHeader."Document Type"::Order, "Sales Invoice Header"."Order/Scd. No.") then begin
                        SalesHeaderDocumentDate := SalesHeader."Document Date";
                        FreightZone := SalesHeader."Freight Zone";
                        SalesOrderDate := SalesHeader."Order Date";

                        SalesLine.Reset();
                        SalesLine.SetRange("Document Type", SalesLine."Document Type"::Order);
                        SalesLine.SetRange("Document No.", "Sales Invoice Header"."Order/Scd. No.");
                        SalesLine.SetRange(Type, SalesLine.Type::Item);
                        SalesLine.SetRange("Line No.", "Sales Invoice Line"."Line No.");
                        if SalesLine.FindFirst() then begin
                            Remarks := SalesLine.Remarks;
                            PlannedShipmentDate := SalesLine."Shipment Date";
                        end;
                    end
                    else begin
                        SalesHeaderDocumentDate := 0D;
                        FreightZone := '';
                        Remarks := '';
                        SalesOrderArch.Reset();
                        SalesOrderArch.SetRange("Document Type", SalesOrderArch."Document Type"::Order);
                        SalesOrderArch.SetRange("No.", "Sales Invoice Header"."Order/Scd. No.");
                        if SalesOrderArch.FindFirst() then
                            SalesOrderDate := SalesOrderArch."Order Date";
                    end;
                    GatePassLine.Reset();
                    GatePassLine.SetRange("Invoice No.", "Sales Invoice Header"."No.");
                    if GatePassLine.FindFirst() then begin
                        if GatePassHeader.Get(GatePassLine."No.") then GatePassHeaderDate := GatePassHeader.Date;
                    end;
                    ExcelBuffer.NewRow();
                    ExcelBuffer.AddColumn("Sales Invoice Header"."Order/Scd. No.", false, '', false, false, false, '', ExcelBuffer."cell type"::Text);
                    ExcelBuffer.AddColumn(SalesHeaderDocumentDate, false, '', false, false, false, '', ExcelBuffer."cell type"::Date);
                    ExcelBuffer.AddColumn("Sales Invoice Header"."Type of Invoice", false, '', false, false, false, '', ExcelBuffer."cell type"::Text);
                    ExcelBuffer.AddColumn("Sales Invoice Header"."No.", false, '', false, false, false, '', ExcelBuffer."cell type"::Text);
                    if ItemRec.Get("Sales Invoice Line"."No.") then
                        LeadTime := ItemRec."Lead Time Dispatch";
                    ExcelBuffer.AddColumn(LeadTime, false, '', false, false, false, '', ExcelBuffer."cell type"::Text);
                    ExcelBuffer.AddColumn(SalesOrderDate, false, '', false, false, false, '', ExcelBuffer."cell type"::Date);
                    ExcelBuffer.AddColumn(SalesOrderReleasedDate, false, '', false, false, false, '', ExcelBuffer."cell type"::Date);
                    ExcelBuffer.AddColumn("Sales Invoice Header"."Posting Date", false, '', false, false, false, '', ExcelBuffer."cell type"::Date);
                    ExcelBuffer.AddColumn("Sales Invoice Header"."Due Date", false, '', false, false, false, '', ExcelBuffer."cell type"::Date);
                    ExcelBuffer.AddColumn("Sales Invoice Header"."Sell-to Customer Name", false, '', false, false, false, '', ExcelBuffer."cell type"::Text);
                    ExcelBuffer.AddColumn(SalesAreaCode, false, '', false, false, false, '', ExcelBuffer."cell type"::Text);
                    ExcelBuffer.AddColumn(SalesAreaName, false, '', false, false, false, '', ExcelBuffer."cell type"::Text);
                    ExcelBuffer.AddColumn("Sales Invoice Header"."Salesperson Code", false, '', false, false, false, '', ExcelBuffer."cell type"::Text);
                    ExcelBuffer.AddColumn(SalespersonPurchaserName, false, '', false, false, false, '', ExcelBuffer."cell type"::Text);
                    ExcelBuffer.AddColumn("Sales Invoice Header"."Bill-to Name", false, '', false, false, false, '', ExcelBuffer."cell type"::Text);
                    ExcelBuffer.AddColumn("Sales Invoice Line"."Item Category Code", false, '', false, false, false, '', ExcelBuffer."cell type"::Number);
                    ExcelBuffer.AddColumn("Sales Invoice Line"."No.", false, '', false, false, false, '', ExcelBuffer."cell type"::Text);
                    ExcelBuffer.AddColumn("Sales Invoice Line".Description, false, '', false, false, false, '', ExcelBuffer."cell type"::Text);
                    ExcelBuffer.AddColumn("Sales Invoice Line"."Description 2", false, '', false, false, false, '', ExcelBuffer."cell type"::Number);
                    ExcelBuffer.AddColumn('', false, '', false, false, false, '', ExcelBuffer."cell type"::Number);
                    ExcelBuffer.AddColumn("Sales Invoice Line"."Unit of Measure Code", false, '', false, false, false, '', ExcelBuffer."cell type"::Text);
                    ExcelBuffer.AddColumn("Sales Invoice Line".Quantity, false, '', false, false, false, '', ExcelBuffer."cell type"::Number);
                    if "Sales Invoice Header"."Currency Code" <> '' then begin
                        ExcelBuffer.AddColumn("Sales Invoice Line"."Unit Price" / "Sales Invoice Header"."Currency Factor", false, '', false, false, false, '', ExcelBuffer."cell type"::Number);
                        ExcelBuffer.AddColumn(("Sales Invoice Line".Quantity * "Sales Invoice Line"."Unit Price") / "Sales Invoice Header"."Currency Factor", false, '', false, false, false, '', ExcelBuffer."cell type"::Number);
                    end
                    else begin
                        ExcelBuffer.AddColumn("Sales Invoice Line"."Unit Price", false, '', false, false, false, '', ExcelBuffer."cell type"::Number);
                        ExcelBuffer.AddColumn(("Sales Invoice Line".Quantity * "Sales Invoice Line"."Unit Price"), false, '', false, false, false, '', ExcelBuffer."cell type"::Number);
                    end;
                    if ShippingAgent.Get("Sales Invoice Header"."Actual Shipping Agent code") then
                        ActualShippingAgentcodeName := ShippingAgent.Name
                    else
                        ActualShippingAgentcodeName := '';
                    if customer.Get("Sales Invoice Header"."Sell-to Customer No.") then begin
                        if ShippingAgent.Get(customer."Shipping Agent Code") then
                            ShippingAgentCodeName := ShippingAgent.Name
                        else
                            ShippingAgentCodeName := '';
                        if ShippingAgent.Get(customer."Shipping Agent Code 1") then
                            ShippingAgentCode1Name := ShippingAgent.Name
                        else
                            ShippingAgentCode1Name := '';
                    end
                    else begin
                        ShippingAgentCodeName := '';
                        ShippingAgentCode1Name := '';
                    end;
                    ExcelBuffer.AddColumn(ActualShippingAgentcodeName, false, '', false, false, false, '', ExcelBuffer."cell type"::Text);
                    ExcelBuffer.AddColumn(ShippingAgentCodeName, false, '', false, false, false, '', ExcelBuffer."cell type"::Text);
                    ExcelBuffer.AddColumn(ShippingAgentCode1Name, false, '', false, false, false, '', ExcelBuffer."cell type"::Text);
                    ExcelBuffer.AddColumn("Sales Invoice Header"."Mode of Transport", false, '', false, false, false, '', ExcelBuffer."cell type"::Text);
                    ExcelBuffer.AddColumn("Sales Invoice Header"."Shipment Method Code", false, '', false, false, false, '', ExcelBuffer."cell type"::Text);
                    ExcelBuffer.AddColumn("Sales Invoice Header"."LR/RR No.", false, '', false, false, false, '', ExcelBuffer."cell type"::Text);
                    ExcelBuffer.AddColumn("Sales Invoice Header"."LR/RR Date", false, '', false, false, false, '', ExcelBuffer."cell type"::Date);
                    if "Sales Invoice Header"."Currency Code" <> '' then
                        ExcelBuffer.AddColumn("Sales Invoice Header"."Calculated Freight Amount" / "Sales Invoice Header"."Currency Factor", false, '', false, false, false, '', ExcelBuffer."cell type"::Number)
                    else
                        ExcelBuffer.AddColumn("Sales Invoice Header"."Calculated Freight Amount", false, '', false, false, false, '', ExcelBuffer."cell type"::Number);
                    ExcelBuffer.AddColumn("Sales Invoice Header"."Firm Freight", false, '', false, false, false, '', ExcelBuffer."cell type"::Text);
                    ExcelBuffer.AddColumn("Sales Invoice Header"."Actual Shipping Agent code", false, '', false, false, false, '', ExcelBuffer."cell type"::Text); //Name
                    ExcelBuffer.AddColumn("Sales Invoice Line"."Shipment Date", false, '', false, false, false, '', ExcelBuffer."cell type"::Date);
                    ExcelBuffer.AddColumn("Sales Invoice Line"."Planned Delivery DT", false, '', false, false, false, '', ExcelBuffer."cell type"::Date);
                    ExcelBuffer.AddColumn('', false, '', false, false, false, '', ExcelBuffer."cell type"::Text);
                    ExcelBuffer.AddColumn(PlannedShipmentDate, false, '', false, false, false, '', ExcelBuffer."cell type"::Text);
                    ExcelBuffer.AddColumn('', false, '', false, false, false, '', ExcelBuffer."cell type"::Text);
                    ExcelBuffer.AddColumn('', false, '', false, false, false, '', ExcelBuffer."cell type"::Text);
                    ExcelBuffer.AddColumn("Sales Invoice Header"."Actual Delivery Date", false, '', false, false, false, '', ExcelBuffer."cell type"::Date);
                    ExcelBuffer.AddColumn('', false, '', false, false, false, '', ExcelBuffer."cell type"::Date);
                    ExcelBuffer.AddColumn('', false, '', false, false, false, '', ExcelBuffer."cell type"::Date);
                    ExcelBuffer.AddColumn(FreightZone, false, '', false, false, false, '', ExcelBuffer."cell type"::Text);
                    ExcelBuffer.AddColumn(Remarks, false, '', false, false, false, '', ExcelBuffer."cell type"::Text);
                    ExcelBuffer.AddColumn(GatePassHeaderDate, false, '', false, false, false, '', ExcelBuffer."cell type"::Date);
                    ExcelBuffer.AddColumn("Sales Invoice Line"."Net Weight", false, '', false, false, false, '', ExcelBuffer."cell type"::Number);
                    ExcelBuffer.AddColumn("Sales Invoice Line"."Gross Wt", false, '', false, false, false, '', ExcelBuffer."cell type"::Number);
                    ExcelBuffer.AddColumn('', false, '', false, false, false, '', ExcelBuffer."cell type"::Number);
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

    procedure CreateHeading()
    begin
        ExcelBuffer.NewRow();
        ExcelBuffer.AddColumn('SO No.', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
        ExcelBuffer.AddColumn('Document Date', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
        ExcelBuffer.AddColumn('Type of Invoice', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
        ExcelBuffer.AddColumn('ZD Inv No', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
        //IG_DS
        ExcelBuffer.AddColumn('Lead Time', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
        ExcelBuffer.AddColumn('SO Order Date', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
        ExcelBuffer.AddColumn('SO Released Date', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
        //IG_DS
        ExcelBuffer.AddColumn('Inv Date', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
        ExcelBuffer.AddColumn('Due Date', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
        ExcelBuffer.AddColumn('Sell to Name', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
        ExcelBuffer.AddColumn('Sales Area', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
        ExcelBuffer.AddColumn('Sales Area Name', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
        ExcelBuffer.AddColumn('Salesperson Code', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
        ExcelBuffer.AddColumn('Sales Person Name', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
        ExcelBuffer.AddColumn('Bill to Name', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
        ExcelBuffer.AddColumn('Item Category Code', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
        ExcelBuffer.AddColumn('Item Code', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
        ExcelBuffer.AddColumn('Description', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
        ExcelBuffer.AddColumn('Description 2', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
        ExcelBuffer.AddColumn('Description 3', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
        ExcelBuffer.AddColumn('Unit of Measure Code', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
        ExcelBuffer.AddColumn('Quantity', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
        ExcelBuffer.AddColumn('Unit Price', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
        ExcelBuffer.AddColumn('Line Amount', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
        ExcelBuffer.AddColumn('Transporter Name', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
        ExcelBuffer.AddColumn('Mapped Transporter', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
        ExcelBuffer.AddColumn('Mapped Transporter1', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
        ExcelBuffer.AddColumn('Transport Method', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
        ExcelBuffer.AddColumn('Shipment Method', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
        ExcelBuffer.AddColumn('LR_RR No_', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
        ExcelBuffer.AddColumn('LR_RR Date', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
        ExcelBuffer.AddColumn('Calculated Freight', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
        ExcelBuffer.AddColumn('Firm Freight', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
        ExcelBuffer.AddColumn('Actual Shipping Agent code', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
        ExcelBuffer.AddColumn('Shipment Date', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
        ExcelBuffer.AddColumn('Planned Del DT', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
        ExcelBuffer.AddColumn('Lead time', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
        ExcelBuffer.AddColumn('Planned Shipment Date', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
        ExcelBuffer.AddColumn('PPD', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
        ExcelBuffer.AddColumn('Expected Delivery Date', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
        ExcelBuffer.AddColumn('Actual Delivery Date', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
        ExcelBuffer.AddColumn('Expected DOD', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
        ExcelBuffer.AddColumn('Actual DOD', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
        ExcelBuffer.AddColumn('Zone', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
        ExcelBuffer.AddColumn('Remarks', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
        ExcelBuffer.AddColumn('Gate out Date', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
        ExcelBuffer.AddColumn('Net Wt.', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
        ExcelBuffer.AddColumn('Gross Wt.', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
        ExcelBuffer.AddColumn('SPD', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
    end;

    Local procedure CreateExcelBook();
    begin
        ExcelBuffer.CreateNewBook('Sales Cum Logistics Report');
        ExcelBuffer.WriteSheet('Sales Cum Logistics Report', CompanyName, UserId);
        ExcelBuffer.CloseBook();
        ExcelBuffer.SetFriendlyFilename('Sales Cum Logistics Report');
        ExcelBuffer.OpenExcel();
    end;
}
