Report 50040 "SalesHeader-ShipDate Upd Batch"
{
    ProcessingOnly = true;
    UsageCategory = ReportsandAnalysis;
    ApplicationArea = all;

    dataset
    {
        dataitem("Sales Header"; "Sales Header")
        {
            DataItemTableView = sorting("Document Type", "No.")where("Document Type"=const(Order), Status=const(Open));

            column(ReportForNavId_6640;6640)
            {
            }
            dataitem("Sales Line"; "Sales Line")
            {
                DataItemLink = "Document No."=field("No.");
                DataItemTableView = sorting("Document Type", "Document No.", "Line No.");

                column(ReportForNavId_2844;2844)
                {
                }
                trigger OnAfterGetRecord()
                begin
                    "Sales Line"."Shipment Date":=Today + 180;
                    "Sales Line".Modify;
                end;
            }
            trigger OnAfterGetRecord()
            begin
                "Sales Header".Validate("Shipment Date", Today + 180);
                Modify;
                RecordNo+=1;
                Dlg.Update(2, RecordNo);
            end;
            trigger OnPostDataItem()
            begin
                Dlg.Close;
            end;
            trigger OnPreDataItem()
            begin
                Dlg.Open('Updating Shipment Date As...#####1#\Records Updated...          #####2#');
                Dlg.Update(1, Today + 180);
                RecordNo:=0;
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
    var Dlg: Dialog;
    RecordNo: Integer;
}
