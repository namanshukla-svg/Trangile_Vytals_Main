report 50457 "Warehouse Receipt Report - MIS"
{
    ApplicationArea = All;
    Caption = 'Warehouse Receipt Report - MIS';
    UsageCategory = ReportsAndAnalysis;
    ProcessingOnly = true;
    UseRequestPage = true;

    dataset
    {
        dataitem("Posted Whse. Receipt Header"; "Posted Whse. Receipt Header")
        {
            RequestFilterFields = "Posting Date", "Location Code";
            DataItemTableView = sorting("No.");

            dataitem("Posted Whse. Receipt Line"; "Posted Whse. Receipt Line")
            {
                DataItemLinkReference = "Posted Whse. Receipt Header";
                DataItemLink = "No."=field("No.");

                trigger OnAfterGetRecord()
                begin
                    if "Posted Whse. Receipt Header"."Gate Entry Date" <> 0D then Pendingdays:=Today - "Posted Whse. Receipt Header"."Gate Entry Date"
                    else
                        Pendingdays:=0;
                    ExcelBuffer.NewRow();
                    ExcelBuffer.AddColumn("Posted Whse. Receipt Header"."Whse. Receipt No.", false, '', false, false, false, '', ExcelBuffer."cell type"::Text);
                    ExcelBuffer.AddColumn("Posted Whse. Receipt Header"."Posting Date", false, '', false, false, false, '', ExcelBuffer."cell type"::Date);
                    ExcelBuffer.AddColumn("Posted Whse. Receipt Header"."No.", false, '', false, false, false, '', ExcelBuffer."cell type"::Text);
                    ExcelBuffer.AddColumn("Posted Whse. Receipt Header"."Gate Entry Date", false, '', false, false, false, '', ExcelBuffer."cell type"::Date);
                    ExcelBuffer.AddColumn("Posted Whse. Receipt Header"."Gate Entry no.", false, '', false, false, false, '', ExcelBuffer."cell type"::Text);
                    ExcelBuffer.AddColumn("Posted Whse. Receipt Header"."Bill No.", false, '', false, false, false, '', ExcelBuffer."cell type"::Text);
                    ExcelBuffer.AddColumn("Posted Whse. Receipt Header"."Document Status", false, '', false, false, false, '', ExcelBuffer."cell type"::Text);
                    ExcelBuffer.AddColumn("Posted Whse. Receipt Line"."Item No.", false, '', false, false, false, '', ExcelBuffer."cell type"::Text);
                    ExcelBuffer.AddColumn("Posted Whse. Receipt Line".Description, false, '', false, false, false, '', ExcelBuffer."cell type"::Text);
                    ExcelBuffer.AddColumn("Posted Whse. Receipt Line"."Description 2", false, '', false, false, false, '', ExcelBuffer."cell type"::Text);
                    if "Posted Whse. Receipt Line"."Actual Qty. to Receive" <> 0 then ExcelBuffer.AddColumn("Posted Whse. Receipt Line"."Actual Qty. to Receive", false, '', false, false, false, '', ExcelBuffer."cell type"::Number)
                    else
                        ExcelBuffer.AddColumn("Posted Whse. Receipt Line".Quantity, false, '', false, false, false, '', ExcelBuffer."cell type"::Number);
                    ExcelBuffer.AddColumn("Posted Whse. Receipt Line"."Purchase Price" + "Posted Whse. Receipt Line"."Direct Unit Cost", false, '', false, false, false, '', ExcelBuffer."cell type"::Number);
                    ExcelBuffer.AddColumn("Posted Whse. Receipt Line"."Qty. On Purch. Order", false, '', false, false, false, '', ExcelBuffer."cell type"::Number);
                    ExcelBuffer.AddColumn("Posted Whse. Receipt Line"."Qty. On Invoice", false, '', false, false, false, '', ExcelBuffer."cell type"::Number);
                    ExcelBuffer.AddColumn("Posted Whse. Receipt Line"."Qty. per Unit of Measure", false, '', false, false, false, '', ExcelBuffer."cell type"::Number);
                    ExcelBuffer.AddColumn("Posted Whse. Receipt Line"."Accepted Qty.", false, '', false, false, false, '', ExcelBuffer."cell type"::Number);
                    ExcelBuffer.AddColumn("Posted Whse. Receipt Line"."Location Code", false, '', false, false, false, '', ExcelBuffer."cell type"::Text);
                    ExcelBuffer.AddColumn("Posted Whse. Receipt Line"."Line No.", false, '', false, false, false, '', ExcelBuffer."cell type"::Text);
                    ExcelBuffer.AddColumn("Posted Whse. Receipt Line"."Whse. Receipt No.", false, '', false, false, false, '', ExcelBuffer."cell type"::Text);
                    IF PurchRcptHeader.Get("Posted Whse. Receipt Line"."Posted Source No.")then begin
                        if "Posted Whse. Receipt Header"."Gate Entry Date" <> 0D then begin
                            if PurchRcptHeader."Receipt send by Store DateTime" <> 0DT then BillClearanceDaysByStore:=DT2Date(PurchRcptHeader."Receipt send by Store DateTime") - "Posted Whse. Receipt Header"."Gate Entry Date"
                            else
                                BillClearanceDaysByStore:=0;
                        end;
                        ExcelBuffer.AddColumn(PurchRcptHeader."No.", false, '', false, false, false, '', ExcelBuffer."cell type"::Text);
                        ExcelBuffer.AddColumn(PurchRcptHeader."Actual Posted Date", false, '', false, false, false, '', ExcelBuffer."cell type"::Date);
                        ExcelBuffer.AddColumn(PurchRcptHeader."Buy-from Vendor No.", false, '', false, false, false, '', ExcelBuffer."cell type"::Text);
                        ExcelBuffer.AddColumn(PurchRcptHeader."Buy-from Vendor Name", false, '', false, false, false, '', ExcelBuffer."cell type"::Text);
                        ExcelBuffer.AddColumn(PurchRcptHeader."Buy-from Vendor Name 2", false, '', false, false, false, '', ExcelBuffer."cell type"::Text);
                        ExcelBuffer.AddColumn(PurchRcptHeader."Invoice Amount", false, '', false, false, false, '', ExcelBuffer."cell type"::Number);
                        ExcelBuffer.AddColumn(PurchRcptHeader."Posting Date", false, '', false, false, false, '', ExcelBuffer."cell type"::Date);
                        ExcelBuffer.AddColumn(PurchRcptHeader."Receipt recd by Fin DateTime", false, '', false, false, false, '', ExcelBuffer."cell type"::Time);
                        ExcelBuffer.AddColumn(PurchRcptHeader."Receipt recvd  by Fin", false, '', false, false, false, '', ExcelBuffer."cell type"::Text);
                        ExcelBuffer.AddColumn(PurchRcptHeader."Receipt send by Store", false, '', false, false, false, '', ExcelBuffer."cell type"::Text);
                        ExcelBuffer.AddColumn(PurchRcptHeader."Receipt send by Store DateTime", false, '', false, false, false, '', ExcelBuffer."cell type"::Time);
                        ExcelBuffer.AddColumn(BillClearanceDaysByStore, false, '', false, false, false, '', ExcelBuffer."cell type"::Number);
                    end
                    else
                    begin
                        ExcelBuffer.AddColumn('', false, '', false, false, false, '', ExcelBuffer."cell type"::Text);
                        ExcelBuffer.AddColumn('', false, '', false, false, false, '', ExcelBuffer."cell type"::Text);
                        ExcelBuffer.AddColumn('', false, '', false, false, false, '', ExcelBuffer."cell type"::Text);
                        ExcelBuffer.AddColumn('', false, '', false, false, false, '', ExcelBuffer."cell type"::Text);
                        ExcelBuffer.AddColumn('', false, '', false, false, false, '', ExcelBuffer."cell type"::Text);
                        ExcelBuffer.AddColumn('', false, '', false, false, false, '', ExcelBuffer."cell type"::Text);
                        ExcelBuffer.AddColumn('', false, '', false, false, false, '', ExcelBuffer."cell type"::Text);
                        ExcelBuffer.AddColumn('', false, '', false, false, false, '', ExcelBuffer."cell type"::Text);
                        ExcelBuffer.AddColumn('', false, '', false, false, false, '', ExcelBuffer."cell type"::Text);
                        ExcelBuffer.AddColumn('', false, '', false, false, false, '', ExcelBuffer."cell type"::Text);
                        ExcelBuffer.AddColumn('', false, '', false, false, false, '', ExcelBuffer."cell type"::Text);
                        ExcelBuffer.AddColumn('', false, '', false, false, false, '', ExcelBuffer."cell type"::Text);
                    end;
                    ExcelBuffer.AddColumn(Pendingdays, false, '', false, false, false, '', ExcelBuffer."cell type"::Number);
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
    PurchRcptHeader: Record "Purch. Rcpt. Header";
    BillClearanceDaysByStore: Integer;
    Pendingdays: integer;
    procedure CreateHeading()
    begin
        ExcelBuffer.NewRow();
        ExcelBuffer.AddColumn('Whse Receipt No', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
        ExcelBuffer.AddColumn('Posting Date', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
        ExcelBuffer.AddColumn('No.', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
        ExcelBuffer.AddColumn('Gate Entry Date', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
        ExcelBuffer.AddColumn('Gate Entry No.', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
        ExcelBuffer.AddColumn('Bill No.', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
        ExcelBuffer.AddColumn('Document Status', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
        ExcelBuffer.AddColumn('Item No_', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
        ExcelBuffer.AddColumn('Description', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
        ExcelBuffer.AddColumn('Description 2', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
        ExcelBuffer.AddColumn('Actual Qty_ to Receive', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
        ExcelBuffer.AddColumn('Purchase Price', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
        ExcelBuffer.AddColumn('Qty_ On Purch_ Order', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
        ExcelBuffer.AddColumn('Qty_ On Invoice', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
        ExcelBuffer.AddColumn('Qty_ per Unit of Measure', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
        ExcelBuffer.AddColumn('Accepted Qty_', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
        ExcelBuffer.AddColumn('Location Code', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
        ExcelBuffer.AddColumn('Whse Receipt Line No_', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
        ExcelBuffer.AddColumn('Whse_ Receipt No_2', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
        ExcelBuffer.AddColumn('GRN No.', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
        ExcelBuffer.AddColumn('Actual Posted Date', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
        ExcelBuffer.AddColumn('Buy-from Vendor No_', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
        ExcelBuffer.AddColumn('Buy-from Vendor Name', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
        ExcelBuffer.AddColumn('Buy-from Vendor Name 2', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
        ExcelBuffer.AddColumn('Invoice Amount', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
        ExcelBuffer.AddColumn('Posting Date4', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
        ExcelBuffer.AddColumn('Receipt recd by Fin DateTime', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
        ExcelBuffer.AddColumn('Receipt recvd  by Fin', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
        ExcelBuffer.AddColumn('Receipt send by Store', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
        ExcelBuffer.AddColumn('Receipt send by Store DateTime', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
        ExcelBuffer.AddColumn('Bill Clearance Days By Store', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
        ExcelBuffer.AddColumn('Pending days', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
    end;
    Local procedure CreateExcelBook();
    begin
        ExcelBuffer.CreateNewBook('Warehouse Receipt Report');
        ExcelBuffer.WriteSheet('Warehouse Receipt Report', CompanyName, UserId);
        ExcelBuffer.CloseBook();
        ExcelBuffer.SetFriendlyFilename('Warehouse Receipt Report');
        ExcelBuffer.OpenExcel();
    end;
}
