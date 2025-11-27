Report 50177 "update sample"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/update sample.rdl';
    ApplicationArea = All;

    dataset
    {
        dataitem("Sampling Test Line"; "SSD Sampling Test Line")
        {
            column(ReportForNavId_1000000000;1000000000)
            {
            }
            trigger OnAfterGetRecord()
            begin
                if QualityMeasurement.Get("Sampling Test Line"."Meas. Code")then begin
                    "Sampling Test Line".Description:=QualityMeasurement.Description;
                    //"Sampling Test Line"."Meas. Tool Descr." := QualityMeasurement."Measurement Tool Descr.";
                    "Sampling Test Line".Modify;
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
    var QualityMeasurement: Record "SSD Quality Measurements";
}
