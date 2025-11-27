Report 50340 "Gate Pass Details"
{
    ProcessingOnly = true;
    ApplicationArea = All;

    dataset
    {
        dataitem("Gate Pass Header"; "SSD Gate Pass Header")
        {
            column(ReportForNavId_1000000000;1000000000)
            {
            }
            dataitem("Gate Pass Line"; "SSD Gate Pass Line")
            {
                DataItemLink = "No."=field("No.");

                column(ReportForNavId_1000000001;1000000001)
                {
                }
                trigger OnAfterGetRecord()
                var
                    Item: Record Item;
                begin
                    SalesInvoiceLine.Reset;
                    SalesInvoiceLine.SetRange("Document No.", "Gate Pass Line"."Invoice No.");
                    SalesInvoiceLine.SetRange(Type, SalesInvoiceLine.Type::Item);
                    if SalesInvoiceLine.FindFirst then begin
                        repeat ExcelBuffer.NewRow();
                            ExcelBuffer.AddColumn("Gate Pass Header"."No.", false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
                            ExcelBuffer.AddColumn("Gate Pass Header".Date, false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
                            ExcelBuffer.AddColumn("Gate Pass Header"."Vehicle No.", false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
                            ExcelBuffer.AddColumn("Gate Pass Header"."Driver Name", false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
                            ExcelBuffer.AddColumn("Gate Pass Header"."Transporter Code", false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
                            ExcelBuffer.AddColumn("Gate Pass Header"."Transporter Name", false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
                            ExcelBuffer.AddColumn("Gate Pass Header"."Bilty No.", false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
                            ExcelBuffer.AddColumn("Gate Pass Header".Posted, false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
                            ExcelBuffer.AddColumn("Gate Pass Header"."No. Series", false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
                            ExcelBuffer.AddColumn("Gate Pass Header"."Responsibility Center", false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
                            ExcelBuffer.AddColumn("Gate Pass Header"."Mobile No.", false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
                            ExcelBuffer.AddColumn("Gate Pass Header"."Gate Pass Time", false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
                            ExcelBuffer.AddColumn("Gate Pass Header"."Document Type", false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
                            ExcelBuffer.AddColumn("Gate Pass Header"."User Details", false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
                            ExcelBuffer.AddColumn("Gate Pass Line"."Line No.", false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
                            ExcelBuffer.AddColumn("Gate Pass Line"."Invoice No.", false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
                            ExcelBuffer.AddColumn("Gate Pass Line"."Invoice Date", false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
                            ExcelBuffer.AddColumn("Gate Pass Line"."Customer No.", false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
                            ExcelBuffer.AddColumn("Gate Pass Line"."Customer Name", false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
                            ExcelBuffer.AddColumn("Gate Pass Line"."Invoice Amount", false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
                            ExcelBuffer.AddColumn("Gate Pass Line"."Net Wt.", false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
                            ExcelBuffer.AddColumn("Gate Pass Line"."Gross Wt.", false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
                            ExcelBuffer.AddColumn("Gate Pass Line"."No. Of Cartons", false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
                            ExcelBuffer.AddColumn("Gate Pass Line".Remark, false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
                            ExcelBuffer.AddColumn("Gate Pass Line"."ILE Lot Scanned", false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
                            ExcelBuffer.AddColumn("Gate Pass Line"."LR/RR No.", false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
                            ExcelBuffer.AddColumn("Gate Pass Line"."LR/RR Date", false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
                            ExcelBuffer.AddColumn(SalesInvoiceLine."No.", false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
                            if Item.Get(SalesInvoiceLine."No.")then begin
                                ExcelBuffer.AddColumn(Item.Description, false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
                                ExcelBuffer.AddColumn(SalesInvoiceLine.Quantity, false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
                            end;
                        until SalesInvoiceLine.Next = 0;
                    end;
                end;
            }
            trigger OnPreDataItem()
            begin
                MakeDataExcelHeader;
            end;
        }
    }
    requestpage
    {
        layout
        {
        }
        actions
        {
        }
    }
    labels
    {
    }
    trigger OnPostReport()
    begin
        CreateExcelBook;
    end;
    trigger OnPreReport()
    begin
        ExcelBuffer.DeleteAll;
    end;
    var ExcelBuffer: Record "Excel Buffer";
    SalesInvoiceLine: Record "Sales Invoice Line";
    local procedure CreateExcelBook()
    begin
    //SSD ExcelBuffer.CreateBookAndOpenExcel('', 'Gate Pass Details', 'Gate Pass Details', '', '');
    end;
    local procedure MakeDataExcelHeader()
    begin
        ExcelBuffer.AddColumn('No.', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
        ExcelBuffer.AddColumn('Date', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
        ExcelBuffer.AddColumn('Vehicle No.', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
        ExcelBuffer.AddColumn('Driver Name', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
        ExcelBuffer.AddColumn('Transporter Code', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
        ExcelBuffer.AddColumn('Transporter Name', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
        ExcelBuffer.AddColumn('Bilty No.', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
        ExcelBuffer.AddColumn('Posted', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
        ExcelBuffer.AddColumn('No. Series', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
        ExcelBuffer.AddColumn('Responsibility Center', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
        ExcelBuffer.AddColumn('Mobile No.', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
        ExcelBuffer.AddColumn('Gate Pass Time', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
        ExcelBuffer.AddColumn('Document Type', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
        ExcelBuffer.AddColumn('User Details', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
        ExcelBuffer.AddColumn('Line No.', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
        ExcelBuffer.AddColumn('Invoice No.', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
        ExcelBuffer.AddColumn('Invoice Date', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
        ExcelBuffer.AddColumn('Customer No.', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
        ExcelBuffer.AddColumn('Customer Name', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
        ExcelBuffer.AddColumn('Invoice Amount', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
        ExcelBuffer.AddColumn('Net Wt.', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
        ExcelBuffer.AddColumn('Gross Wt.', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
        ExcelBuffer.AddColumn('No. Of Cartons', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
        ExcelBuffer.AddColumn('Remark', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
        ExcelBuffer.AddColumn('ILE Lot Scanned', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
        ExcelBuffer.AddColumn('LR/RR No.', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
        ExcelBuffer.AddColumn('LR/RR Date', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
        ExcelBuffer.AddColumn('Item No.', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
        ExcelBuffer.AddColumn('Item Description', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
        ExcelBuffer.AddColumn('Quantity', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
    end;
    local procedure MakeDataExcelBody()
    begin
    end;
}
