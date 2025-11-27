Report 50083 "Session Variables"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Session Variables.rdl';
    UsageCategory = ReportsandAnalysis;
    ApplicationArea = all;

    dataset
    {
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
    var OfficeVersion: Integer;
    procedure GetOfficeVersion(): Integer var
        OSIntf: Report "OS Interface Routines";
    begin
        if OfficeVersion = 0 then OfficeVersion:=OSIntf.OfficeVersion;
        exit(OfficeVersion);
    end;
    procedure OnRun()
    begin
        GetOfficeVersion();
    end;
}
