report 50467 "Sales Return Order Report-MIS"
{
    ApplicationArea = All;
    Caption = 'Sales Return Order Report-MIS';
    UsageCategory = ReportsAndAnalysis;
    ProcessingOnly = true;
    UseRequestPage = true;

    dataset
    {
        dataitem("Sales Header"; "Sales Header")
        {
            DataItemTableView = SORTING("Document Type", "No.")WHERE("Document Type"=filter("Return Order"), "Document Subtype"=filter(order|" "));
            RequestFilterFields = "Posting Date";

            dataitem("Sales Line"; "Sales Line")
            {
                DataItemLinkReference = "Sales Header";
                DataItemLink = "Document No."=field("No.");
                DataItemTableView = sorting("Document Type", "Document No.", "Line No.")WHERE("Document Type"=filter("Return Order"), "Document Subtype"=filter(order|" "), Type=filter(=item));

                trigger OnAfterGetRecord()
                begin
                    ExcelBuffer.NewRow();
                    ExcelBuffer.AddColumn("Sales Header"."External Document No.", false, '', false, false, false, '', ExcelBuffer."cell type"::Text);
                    ExcelBuffer.AddColumn("Sales Header"."External Doc. Date", false, '', false, false, false, '', ExcelBuffer."cell type"::Date);
                    ExcelBuffer.AddColumn("Sales Header"."No.", false, '', false, false, false, '', ExcelBuffer."cell type"::Text);
                    ExcelBuffer.AddColumn("Sales Header"."Document Date", false, '', false, false, false, '', ExcelBuffer."cell type"::Date);
                    ExcelBuffer.AddColumn("Sales Header".Status, false, '', false, false, false, '', ExcelBuffer."cell type"::Text);
                    ExcelBuffer.AddColumn("Sales Header"."Sell-to Customer No.", false, '', false, false, false, '', ExcelBuffer."cell type"::Text);
                    ExcelBuffer.AddColumn("Sales Header"."Sell-to Customer Name", false, '', false, false, false, '', ExcelBuffer."cell type"::Text);
                    ExcelBuffer.AddColumn("Sales Header"."Salesperson Code", false, '', false, false, false, '', ExcelBuffer."cell type"::Text);
                    ExcelBuffer.AddColumn("Sales Line"."No.", false, '', false, false, false, '', ExcelBuffer."cell type"::Text);
                    ExcelBuffer.AddColumn("Sales Line".Description, false, '', false, false, false, '', ExcelBuffer."cell type"::Text);
                    ExcelBuffer.AddColumn("Sales Line"."Description 2", false, '', false, false, false, '', ExcelBuffer."cell type"::Text);
                    ExcelBuffer.AddColumn("Sales Line".Quantity, false, '', false, false, false, '', ExcelBuffer."cell type"::Number);
                    ExcelBuffer.AddColumn("Sales Line"."Unit Price", false, '', false, false, false, '', ExcelBuffer."cell type"::Number);
                    ExcelBuffer.AddColumn("Sales Line"."Line Amount", false, '', false, false, false, '', ExcelBuffer."cell type"::Number);
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
    procedure CreateHeading()
    begin
        ExcelBuffer.NewRow();
        ExcelBuffer.AddColumn('Linked Invoice#', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
        ExcelBuffer.AddColumn('Linked Invoice Date', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
        ExcelBuffer.AddColumn('Sales Return#', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
        ExcelBuffer.AddColumn('Document Date', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
        ExcelBuffer.AddColumn('Status', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
        ExcelBuffer.AddColumn('Sell-to Customer Code', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
        ExcelBuffer.AddColumn('Sell-to Customer Name', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
        ExcelBuffer.AddColumn('Salesperson Code', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
        ExcelBuffer.AddColumn('FG Code', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
        ExcelBuffer.AddColumn('Description', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
        ExcelBuffer.AddColumn('Description 2', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
        ExcelBuffer.AddColumn('Quantity', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
        ExcelBuffer.AddColumn('Unit Price', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
        ExcelBuffer.AddColumn('Line Amount', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
    end;
    Local procedure CreateExcelBook();
    begin
        ExcelBuffer.CreateNewBook('Sales Return Order Report-MIS');
        ExcelBuffer.WriteSheet('Sales Return Order Report-MIS', CompanyName, UserId);
        ExcelBuffer.CloseBook();
        ExcelBuffer.SetFriendlyFilename('Sales Return Order Report-MIS');
        ExcelBuffer.OpenExcel();
    end;
}
