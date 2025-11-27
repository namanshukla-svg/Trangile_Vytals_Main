Report 50257 "Short Close Mail Send"
{
    ProcessingOnly = true;
    ApplicationArea = All;

    dataset
    {
        dataitem("Sales Line"; "Sales Line")
        {
            DataItemTableView = sorting("Document Type", "Document No.", "Line No.")where(Type=const(Item), "Document Type"=const(Order), "Short Close"=const(true), "Mail Send for Short Close"=const(false));

            column(ReportForNavId_1000000000;1000000000)
            {
            }
            trigger OnAfterGetRecord()
            begin
                AlleEvents.SendMailForShortClose("Sales Line");
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
    var AlleEvents: Codeunit "Alle Events";
}
