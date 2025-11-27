Report 50305 "Sales Forecast Batch"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Sales Forecast Batch.rdl';
    UsageCategory = ReportsandAnalysis;
    ApplicationArea = all;

    dataset
    {
        dataitem("Production Forecast Archive"; "SSD Prod Forecast Archive")
        {
            RequestFilterFields = "Entry No.";

            column(ReportForNavId_1170000000;1170000000)
            {
            }
            trigger OnAfterGetRecord()
            begin
                if "Production Forecast Archive"."Creation Date" = 20210402D then begin
                    "Production Forecast Archive"."Creation Date":=20210401D;
                //"Production Forecast Archive".MODIFY;
                //"Production Forecast Archive".RENAME( "Production Forecast Archive"."Production Forecast Name","Production Forecast Archive"."Entry No.",1);
                end;
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
    trigger OnPreReport()
    begin
        if "Production Forecast Archive".GetFilter("Creation Date") = '' then Error('Please enter creation date filter');
    end;
}
