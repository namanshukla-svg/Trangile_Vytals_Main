report 50469 "Posted PI PDI Status Report"
{
    ApplicationArea = All;
    Caption = 'Posted PI PDI Status Report - MIS';
    UsageCategory = ReportsAndAnalysis;
    ProcessingOnly = true;
    UseRequestPage = true;

    dataset
    {
        dataitem(PurchInvHeader; "Purch. Inv. Header")
        {
            RequestFilterFields = "Posting Date";

            trigger OnAfterGetRecord()
            begin
                Dayssubmittofn:=0;
                if DT2Date("Doc. send by Store DateTime") <> 0D then IF "Document Date" <> 0D then Dayssubmittofn:=DT2Date("Doc. send by Store DateTime") - "Document Date";
                ExcelBuffer.NewRow();
                ExcelBuffer.AddColumn(PurchInvHeader."Posting Date", false, '', false, false, false, '', ExcelBuffer."cell type"::Date);
                ExcelBuffer.AddColumn(PurchInvHeader."No.", false, '', false, false, false, '', ExcelBuffer."cell type"::Text);
                ExcelBuffer.AddColumn(PurchInvHeader."Actual Posted Date", false, '', false, false, false, '', ExcelBuffer."cell type"::Date);
                ExcelBuffer.AddColumn(PurchInvHeader."Pre-Assigned No.", false, '', false, false, false, '', ExcelBuffer."cell type"::Text);
                ExcelBuffer.AddColumn(PurchInvHeader."Doc. recvd  by Fin", false, '', false, false, false, '', ExcelBuffer."cell type"::Text);
                ExcelBuffer.AddColumn(format(PurchInvHeader."Doc. recd by Fin DateTime"), false, '', false, false, false, '', ExcelBuffer."cell type"::Text);
                ExcelBuffer.AddColumn(PurchInvHeader."Doc. send by Store", false, '', false, false, false, '', ExcelBuffer."cell type"::Text);
                ExcelBuffer.AddColumn(PurchInvHeader."Vendor Invoice No.", false, '', false, false, false, '', ExcelBuffer."cell type"::Text);
                ExcelBuffer.AddColumn(PurchInvHeader."Buy-from Vendor No.", false, '', false, false, false, '', ExcelBuffer."cell type"::Text);
                ExcelBuffer.AddColumn(PurchInvHeader."Buy-from Vendor Name", false, '', false, false, false, '', ExcelBuffer."cell type"::Text);
                ExcelBuffer.AddColumn(PurchInvHeader."Document Date", false, '', false, false, false, '', ExcelBuffer."cell type"::Date);
                ExcelBuffer.AddColumn(PurchInvHeader."Gate Entry No.", false, '', false, false, false, '', ExcelBuffer."cell type"::Text);
                ExcelBuffer.AddColumn(PurchInvHeader."Gate Entry Date", false, '', false, false, false, '', ExcelBuffer."cell type"::Date);
                ExcelBuffer.AddColumn(PurchInvHeader."Original Invoice Amount", false, '', false, false, false, '', ExcelBuffer."cell type"::Number);
                ExcelBuffer.AddColumn(Format(PurchInvHeader."Doc. send by Store DateTime"), false, '', false, false, false, '', ExcelBuffer."cell type"::Text);
                ExcelBuffer.AddColumn(PurchInvHeader."Created  Date", false, '', false, false, false, '', ExcelBuffer."cell type"::Date);
                ExcelBuffer.AddColumn(PurchInvHeader."Created By User Id", false, '', false, false, false, '', ExcelBuffer."cell type"::Text);
                ExcelBuffer.AddColumn(Dayssubmittofn, false, '', false, false, false, '', ExcelBuffer."cell type"::Number);
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
    Dayssubmittofn: Integer;
    procedure CreateHeading()
    begin
        ExcelBuffer.NewRow();
        ExcelBuffer.AddColumn('Posting Date', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
        ExcelBuffer.AddColumn('No_', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
        ExcelBuffer.AddColumn('Actual Posted Date', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
        ExcelBuffer.AddColumn('Pre-Assigned No_', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
        ExcelBuffer.AddColumn('Doc_ recvd  by Fin', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
        ExcelBuffer.AddColumn('Doc_ recd by Fin DateTime', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
        ExcelBuffer.AddColumn('Doc_ send by Store', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
        ExcelBuffer.AddColumn('Vendor Invoice No_', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
        ExcelBuffer.AddColumn('Buy-from Vendor No_', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
        ExcelBuffer.AddColumn('Buy-from Vendor Name', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
        ExcelBuffer.AddColumn('Document Date', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
        ExcelBuffer.AddColumn('Gate Entry No_', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
        ExcelBuffer.AddColumn('Gate Entry Date', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
        ExcelBuffer.AddColumn('Original Invoice Amount', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
        ExcelBuffer.AddColumn('Doc_ send by Store DateTime', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
        ExcelBuffer.AddColumn('Created Date', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
        ExcelBuffer.AddColumn('Created By User Id', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
        ExcelBuffer.AddColumn('Days submit to fn', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
    end;
    Local procedure CreateExcelBook();
    begin
        ExcelBuffer.CreateNewBook('Posted PI PDI Status Report - MIS');
        ExcelBuffer.WriteSheet('Posted PI PDI Status Report - MIS', CompanyName, UserId);
        ExcelBuffer.CloseBook();
        ExcelBuffer.SetFriendlyFilename('Posted PI PDI Status Report - MIS');
        ExcelBuffer.OpenExcel();
    end;
}
