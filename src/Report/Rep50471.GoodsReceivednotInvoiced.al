report 50471 "Goods Received not Invoiced"
{
    ApplicationArea = All;
    Caption = 'Goods Received But not Invoiced - MIS';
    UsageCategory = ReportsAndAnalysis;
    ProcessingOnly = true;
    UseRequestPage = true;

    dataset
    {
        dataitem(PurchRcptLine; "Purch. Rcpt. Line")
        {
            RequestFilterFields = "Posting Date";
            DataItemTableView = where("Qty. Rcd. Not Invoiced"=filter(>0));

            trigger OnAfterGetRecord()
            begin
                VendorName:='';
                if VendorRec.Get("Buy-from Vendor No.")then VendorName:=VendorRec.Name;
                ExcelBuffer.NewRow();
                ExcelBuffer.AddColumn(PurchRcptLine."Document No.", false, '', false, false, false, '', ExcelBuffer."cell type"::Text);
                ExcelBuffer.AddColumn(PurchRcptLine."Posting Date", false, '', false, false, false, '', ExcelBuffer."cell type"::Date);
                ExcelBuffer.AddColumn(PurchRcptLine.Quantity, false, '', false, false, false, '', ExcelBuffer."cell type"::Number);
                ExcelBuffer.AddColumn(PurchRcptLine."Qty. Rcd. Not Invoiced", false, '', false, false, false, '', ExcelBuffer."cell type"::Number);
                ExcelBuffer.AddColumn(PurchRcptLine."Order No.", false, '', false, false, false, '', ExcelBuffer."cell type"::Text);
                ExcelBuffer.AddColumn(PurchRcptLine."Bill No.", false, '', false, false, false, '', ExcelBuffer."cell type"::Text);
                ExcelBuffer.AddColumn(PurchRcptLine."Buy-from Vendor No.", false, '', false, false, false, '', ExcelBuffer."cell type"::Text);
                ExcelBuffer.AddColumn(VendorName, false, '', false, false, false, '', ExcelBuffer."cell type"::Text);
                ExcelBuffer.AddColumn(PurchRcptLine."No.", false, '', false, false, false, '', ExcelBuffer."cell type"::Text);
                ExcelBuffer.AddColumn(PurchRcptLine.Description, false, '', false, false, false, '', ExcelBuffer."cell type"::Text);
                ExcelBuffer.AddColumn(PurchRcptLine."Description 2", false, '', false, false, false, '', ExcelBuffer."cell type"::Text);
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
    var ExcelBuffer: Record "Excel Buffer";
    VendorRec: Record Vendor;
    VendorName: Text;
    procedure CreateHeading()
    begin
        ExcelBuffer.NewRow();
        ExcelBuffer.AddColumn('Document No_', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
        ExcelBuffer.AddColumn('Posting Date', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
        ExcelBuffer.AddColumn('Qty Received', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
        ExcelBuffer.AddColumn('Qty Recd Not Invoiced', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
        ExcelBuffer.AddColumn('Order No_', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
        ExcelBuffer.AddColumn('Vendor Document No.', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
        ExcelBuffer.AddColumn('Vendor Code', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
        ExcelBuffer.AddColumn('Name', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
        ExcelBuffer.AddColumn('Item Code', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
        ExcelBuffer.AddColumn('Description', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
        ExcelBuffer.AddColumn('Description 2', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
    end;
    Local procedure CreateExcelBook();
    begin
        ExcelBuffer.CreateNewBook('Goods Received But not Invoiced - MIS');
        ExcelBuffer.WriteSheet('Goods Received But not Invoiced - MIS', CompanyName, UserId);
        ExcelBuffer.CloseBook();
        ExcelBuffer.SetFriendlyFilename('Goods Received But not Invoiced - MIS');
        ExcelBuffer.OpenExcel();
    end;
}
