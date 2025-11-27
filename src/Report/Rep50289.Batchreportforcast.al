Report 50289 "Batch report forcast"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Batch report forcast.rdl';
    UsageCategory = ReportsandAnalysis;
    ApplicationArea = all;

    dataset
    {
        dataitem("Production Forecast Archive"; "SSD Prod Forecast Archive")
        {
            DataItemTableView = where("Version No."=const(8), "Production Forecast Name"=const('C0192'));

            column(ReportForNavId_1000000000;1000000000)
            {
            }
            trigger OnAfterGetRecord()
            begin
                //"Production Forecast Archive"."Version No.":=2;
                "Production Forecast Archive".Rename("Production Forecast Archive"."Production Forecast Name", "Production Forecast Archive"."Entry No.", 3);
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
}
