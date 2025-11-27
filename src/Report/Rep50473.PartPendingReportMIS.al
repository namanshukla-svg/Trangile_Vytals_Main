report 50473 "Part Pending Report - MIS"
{
    ApplicationArea = All;
    Caption = 'Part Pending Report - MIS';
    UsageCategory = ReportsAndAnalysis;
    ProcessingOnly = true;
    UseRequestPage = true;

    dataset
    {
        dataitem(PurchRcptLine; "Purch. Rcpt. Line")
        {
            DataItemTableView = where(Type=filter(=Item));
            RequestFilterFields = "Posting Date";

            trigger OnAfterGetRecord()
            begin
                OrderNo:='';
                OrderDate:=0D;
                PaytoName:='';
                OutstandingQuantity:=0;
                RequestedReceiptDate:=0D;
                OrdQty:=0;
                Rate:=0;
                if PurchaseLineRec.Get(PurchaseLineRec."Document Type"::Order, PurchRcptLine."Order No.", PurchRcptLine."Order Line No.")then begin
                    OutstandingQuantity:=PurchaseLineRec."Outstanding Quantity";
                    IF not(OutstandingQuantity > 0)then CurrReport.Skip();
                    RequestedReceiptDate:=PurchaseLineRec."Requested Receipt Date";
                    OrdQty:=PurchaseLineRec.Quantity;
                    Rate:=PurchaseLineRec."Direct Unit Cost";
                end;
                if PurchaseHeaderRec.Get(PurchaseHeaderRec."Document Type"::Order, PurchRcptLine."Order No.")then begin
                    OrderNo:=PurchaseHeaderRec."No.";
                    OrderDate:=PurchaseHeaderRec."Order Date";
                    PaytoName:=PurchaseHeaderRec."Pay-to Name";
                end;
                ExcelBuffer.NewRow();
                ExcelBuffer.AddColumn(PurchRcptLine."Document No.", false, '', false, false, false, '', ExcelBuffer."cell type"::Text);
                ExcelBuffer.AddColumn(OrderNo, false, '', false, false, false, '', ExcelBuffer."cell type"::Text);
                ExcelBuffer.AddColumn(OrderDate, false, '', false, false, false, '', ExcelBuffer."cell type"::Date);
                ExcelBuffer.AddColumn(PurchRcptLine."Posting Date", false, '', false, false, false, '', ExcelBuffer."cell type"::Date);
                ExcelBuffer.AddColumn(PaytoName, false, '', false, false, false, '', ExcelBuffer."cell type"::Text);
                ExcelBuffer.AddColumn(PurchRcptLine."No.", false, '', false, false, false, '', ExcelBuffer."cell type"::Text);
                ExcelBuffer.AddColumn(PurchRcptLine.Description, false, '', false, false, false, '', ExcelBuffer."cell type"::Text);
                ExcelBuffer.AddColumn(PurchRcptLine."Description 2", false, '', false, false, false, '', ExcelBuffer."cell type"::Text);
                ExcelBuffer.AddColumn(RequestedReceiptDate, false, '', false, false, false, '', ExcelBuffer."cell type"::Date);
                ExcelBuffer.AddColumn(OrdQty, false, '', false, false, false, '', ExcelBuffer."cell type"::Number);
                ExcelBuffer.AddColumn(PurchRcptLine."Unit of Measure", false, '', false, false, false, '', ExcelBuffer."cell type"::Text);
                ExcelBuffer.AddColumn(Rate, false, '', false, false, false, '', ExcelBuffer."cell type"::Number);
                ExcelBuffer.AddColumn(PurchRcptLine.Quantity, false, '', false, false, false, '', ExcelBuffer."cell type"::Number);
                ExcelBuffer.AddColumn(OutstandingQuantity, false, '', false, false, false, '', ExcelBuffer."cell type"::Number);
                ExcelBuffer.AddColumn('', false, '', false, false, false, '', ExcelBuffer."cell type"::Text);
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
    PurchaseHeaderRec: Record "Purchase Header";
    PurchaseLineRec: Record "Purchase Line";
    OrderNo: code[20];
    OrderDate: Date;
    PaytoName: text;
    RequestedReceiptDate: Date;
    OrdQty: Decimal;
    Rate: Decimal;
    OutstandingQuantity: Decimal;
    procedure CreateHeading()
    begin
        ExcelBuffer.NewRow();
        ExcelBuffer.AddColumn('Goods Receipt No', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
        ExcelBuffer.AddColumn('Order No', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
        ExcelBuffer.AddColumn('Order Date', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
        ExcelBuffer.AddColumn('Posting Date', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
        ExcelBuffer.AddColumn('Pay-to Name', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
        ExcelBuffer.AddColumn('Item No', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
        ExcelBuffer.AddColumn('Description', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
        ExcelBuffer.AddColumn('Description 2', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
        ExcelBuffer.AddColumn('Requested Receipt Date', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
        ExcelBuffer.AddColumn('Ord. Qty', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
        ExcelBuffer.AddColumn('UOM', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
        ExcelBuffer.AddColumn('Rate', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
        ExcelBuffer.AddColumn('Qty Recd', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
        ExcelBuffer.AddColumn('Outstanding Quantity', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
        ExcelBuffer.AddColumn('Remarks', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
    end;
    Local procedure CreateExcelBook();
    begin
        ExcelBuffer.CreateNewBook('Part Pending Report - MIS');
        ExcelBuffer.WriteSheet('Part Pending Report - MIS', CompanyName, UserId);
        ExcelBuffer.CloseBook();
        ExcelBuffer.SetFriendlyFilename('Part Pending Report - MIS');
        ExcelBuffer.OpenExcel();
    end;
}
