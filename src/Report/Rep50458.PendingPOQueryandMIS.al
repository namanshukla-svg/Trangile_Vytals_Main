report 50458 "Pending PO Query and MIS"
{
    ApplicationArea = All;
    Caption = 'Pending PO Query and MIS';
    UsageCategory = ReportsAndAnalysis;
    ProcessingOnly = true;
    UseRequestPage = true;

    dataset
    {
        dataitem("Purch. Rcpt. Header"; "Purch. Rcpt. Header")
        {
            DataItemTableView = SORTING("No.");
            RequestFilterFields = "Posting Date";

            dataitem("Purch. Rcpt. Line"; "Purch. Rcpt. Line")
            {
                DataItemLinkReference = "Purch. Rcpt. Header";
                DataItemLink = "Document No."=field("No.");

                trigger OnAfterGetRecord()
                begin
                    IF PurchaseHeader.Get(PurchaseHeader."Document Type"::Order, "Purch. Rcpt. Header"."Order No.")then begin
                        PurchaseLine.Reset();
                        PurchaseLine.SetRange("Document Type", PurchaseHeader."Document Type");
                        PurchaseLine.SetRange("Document No.", PurchaseHeader."No.");
                        IF PurchaseLine.FindSet()then repeat ItemNo:=PurchaseLine."No.";
                                VarDescription:=PurchaseLine.Description;
                                VarDescription2:=PurchaseLine."Description 2";
                                RequestedReceiptDate:=PurchaseLine."Requested Receipt Date";
                                OrdQty:=PurchaseLine.Quantity;
                                UOM:=PurchaseLine."Unit of Measure Code";
                                RATE:=PurchaseLine."Direct Unit Cost";
                                OutstandingQuantity:=PurchaseLine."Outstanding Quantity";
                                PurchaseOrderNo:=PurchaseHeader."No.";
                                OrderDate:=PurchaseHeader."Order Date";
                                VendorNo:=PurchaseHeader."Pay-to Vendor No.";
                                PaytoName:=PurchaseHeader."Pay-to Name";
                                ExcelBuffer.NewRow();
                                ExcelBuffer.AddColumn(PurchaseOrderNo, false, '', false, false, false, '', ExcelBuffer."cell type"::Text);
                                ExcelBuffer.AddColumn(OrderDate, false, '', false, false, false, '', ExcelBuffer."cell type"::Text);
                                ExcelBuffer.AddColumn("Purch. Rcpt. Header"."No.", false, '', false, false, false, '', ExcelBuffer."cell type"::Text);
                                ExcelBuffer.AddColumn("Purch. Rcpt. Header"."Posting Date", false, '', false, false, false, '', ExcelBuffer."cell type"::Text);
                                ExcelBuffer.AddColumn(VendorNo, false, '', false, false, false, '', ExcelBuffer."cell type"::Text);
                                ExcelBuffer.AddColumn(PaytoName, false, '', false, false, false, '', ExcelBuffer."cell type"::Text);
                                ExcelBuffer.AddColumn(ItemNo, false, '', false, false, false, '', ExcelBuffer."cell type"::Text);
                                ExcelBuffer.AddColumn(VarDescription, false, '', false, false, false, '', ExcelBuffer."cell type"::Text);
                                ExcelBuffer.AddColumn(VarDescription2, false, '', false, false, false, '', ExcelBuffer."cell type"::Text);
                                ExcelBuffer.AddColumn(RequestedReceiptDate, false, '', false, false, false, '', ExcelBuffer."cell type"::Text);
                                ExcelBuffer.AddColumn(OrdQty, false, '', false, false, false, '', ExcelBuffer."cell type"::Text);
                                ExcelBuffer.AddColumn(UOM, false, '', false, false, false, '', ExcelBuffer."cell type"::Text);
                                ExcelBuffer.AddColumn(RATE, false, '', false, false, false, '', ExcelBuffer."cell type"::Text);
                                ExcelBuffer.AddColumn("Purch. Rcpt. Line".Quantity, false, '', false, false, false, '', ExcelBuffer."cell type"::Text);
                                ExcelBuffer.AddColumn(OutstandingQuantity, false, '', false, false, false, '', ExcelBuffer."cell type"::Text);
                            until PurchaseLine.Next() = 0;
                    end;
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
    PurchaseHeader: Record "Purchase Header";
    PurchaseLine: Record "Purchase Line";
    PurchaseOrderNo: Code[20];
    OrderDate: Date;
    VendorNo: Code[20];
    PaytoName: Text;
    ItemNo: Code[20];
    VarDescription: Text;
    VarDescription2: Text;
    RequestedReceiptDate: Date;
    OrdQty: Decimal;
    UOM: Text;
    RATE: Decimal;
    QtyRecd: Decimal;
    OutstandingQuantity: Decimal;
    procedure CreateHeading()
    begin
        ExcelBuffer.NewRow();
        ExcelBuffer.AddColumn('Purchase Order No', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
        ExcelBuffer.AddColumn('Order Date', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
        ExcelBuffer.AddColumn('Receipt No', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
        ExcelBuffer.AddColumn('GRN Date', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
        ExcelBuffer.AddColumn('Vendor No.', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
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
    end;
    Local procedure CreateExcelBook();
    begin
        ExcelBuffer.CreateNewBook('Pending PO Query and MIS');
        ExcelBuffer.WriteSheet('Pending PO Query and MIS', CompanyName, UserId);
        ExcelBuffer.CloseBook();
        ExcelBuffer.SetFriendlyFilename('Pending PO Query and MIS');
        ExcelBuffer.OpenExcel();
    end;
}
