Report 50245 "Delete Production Order-Batch"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Delete Production Order-Batch.rdl';
    UsageCategory = ReportsandAnalysis;
    ApplicationArea = all;

    dataset
    {
        dataitem("Production Order"; "Production Order")
        {
            RequestFilterFields = "No.";

            column(ReportForNavId_1000000000;1000000000)
            {
            }
            dataitem("Prod. Order Line"; "Prod. Order Line")
            {
                DataItemLink = Status=field(Status), "Prod. Order No."=field("No.");

                column(ReportForNavId_1000000001;1000000001)
                {
                }
                trigger OnAfterGetRecord()
                begin
                    DeleteAll;
                end;
            }
            trigger OnAfterGetRecord()
            begin
                DeleteAll;
            end;
            trigger OnPreDataItem()
            begin
                if GetFilter("Production Order"."No.") = '' then Error('Enter Production Order No.');
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
