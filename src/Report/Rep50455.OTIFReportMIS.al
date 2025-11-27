report 50455 "OTIF Report - MIS"
{
    ApplicationArea = All;
    Caption = 'OTIF Report - MIS';
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
                DataItemLink = "Document No."=field("No.");

                trigger OnAfterGetRecord()
                begin
                    if SalesLine.Get(SalesLine."Document Type"::Order, "Sales Invoice Header"."Order/Scd. No.", "Sales Invoice Line"."Line No.")then ShipmentDateWO:=SalesLine."Shipment Date"
                    else
                        ShipmentDateWO:=0D;
                    if ItemCategory.Get("Sales Invoice Line"."Item Category Code")then if ItemCategory."Parent Category" <> '' then ItemCategoryCode:=ItemCategory."Parent Category"
                        else
                            ItemCategoryCode:=''
                    else
                        ItemCategoryCode:='';
                    IF "Sales Invoice Line"."Shipment Date" <> 0D then ShipmentDate2:="Sales Invoice Line"."Shipment Date" + 2
                    ELSE
                        ShipmentDate2:=0D;
                    ExcelBuffer.NewRow();
                    ExcelBuffer.AddColumn("Sales Invoice Header"."No.", false, '', false, false, false, '', ExcelBuffer."cell type"::Text);
                    ExcelBuffer.AddColumn("Sales Invoice Header"."Document Date", false, '', false, false, false, '', ExcelBuffer."cell type"::Date);
                    ExcelBuffer.AddColumn("Sales Invoice Header"."Bill-to Customer No.", false, '', false, false, false, '', ExcelBuffer."cell type"::Text);
                    ExcelBuffer.AddColumn("Sales Invoice Header"."Bill-to Name", false, '', false, false, false, '', ExcelBuffer."cell type"::Text);
                    ExcelBuffer.AddColumn("Sales Invoice Line"."No. 2", false, '', false, false, false, '', ExcelBuffer."cell type"::Text);
                    ExcelBuffer.AddColumn("Sales Invoice Line".Description, false, '', false, false, false, '', ExcelBuffer."cell type"::Text);
                    ExcelBuffer.AddColumn("Sales Invoice Line"."Description 2", false, '', false, false, false, '', ExcelBuffer."cell type"::Number);
                    ExcelBuffer.AddColumn(ItemCategoryCode, false, '', false, false, false, '', ExcelBuffer."cell type"::Number);
                    ExcelBuffer.AddColumn("Sales Invoice Line"."Item Category Code", false, '', false, false, false, '', ExcelBuffer."cell type"::Number);
                    ExcelBuffer.AddColumn("Sales Invoice Line".Quantity, false, '', false, false, false, '', ExcelBuffer."cell type"::Number);
                    ExcelBuffer.AddColumn("Sales Invoice Line"."Unit of Measure Code", false, '', false, false, false, '', ExcelBuffer."cell type"::Text);
                    ExcelBuffer.AddColumn("Sales Invoice Line"."Unit Price", false, '', false, false, false, '', ExcelBuffer."cell type"::Number);
                    ExcelBuffer.AddColumn("Sales Invoice Line"."Line Amount", false, '', false, false, false, '', ExcelBuffer."cell type"::Number);
                    ExcelBuffer.AddColumn("Sales Invoice Line"."Shipment Date", false, '', false, false, false, '', ExcelBuffer."cell type"::Date);
                    ExcelBuffer.AddColumn("Sales Invoice Header"."Shipment Date", false, '', false, false, false, '', ExcelBuffer."cell type"::Date);
                    ExcelBuffer.AddColumn(ShipmentDateWO, false, '', false, false, false, '', ExcelBuffer."cell type"::Date);
                    ExcelBuffer.AddColumn(ShipmentDate2, false, '', false, false, false, '', ExcelBuffer."cell type"::Date);
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
    var ShipmentDateWO: Date;
    SalesLine: Record "Sales Line";
    ExcelBuffer: Record "Excel Buffer";
    ItemCategoryCode: Code[20];
    ItemCategory: Record "Item Category";
    ShipmentDate2: Date;
    procedure CreateHeading()
    begin
        ExcelBuffer.NewRow();
        ExcelBuffer.AddColumn('Sales Invoice No.', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
        ExcelBuffer.AddColumn('Document Date', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
        ExcelBuffer.AddColumn('Bill-to Customer No_', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
        ExcelBuffer.AddColumn('Bill-to Name', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
        ExcelBuffer.AddColumn('No_2', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
        ExcelBuffer.AddColumn('Description', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
        ExcelBuffer.AddColumn('Description 2', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
        ExcelBuffer.AddColumn('Item Category Code', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
        ExcelBuffer.AddColumn('Product Group Code', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
        ExcelBuffer.AddColumn('Quantity', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
        ExcelBuffer.AddColumn('Unit of Measure Code', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
        ExcelBuffer.AddColumn('Unit Price', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
        ExcelBuffer.AddColumn('Line Amount', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
        ExcelBuffer.AddColumn('Shipment Date', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
        ExcelBuffer.AddColumn('Shipment Date Header', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
        ExcelBuffer.AddColumn('Shipment Date (WO)', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
        ExcelBuffer.AddColumn('Shipment date 2', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
    end;
    Local procedure CreateExcelBook();
    begin
        ExcelBuffer.CreateNewBook('OTIF Report - MIS');
        ExcelBuffer.WriteSheet('OTIF Report - MIS', CompanyName, UserId);
        ExcelBuffer.CloseBook();
        ExcelBuffer.SetFriendlyFilename('OTIF Report - MIS');
        ExcelBuffer.OpenExcel();
    end;
}
