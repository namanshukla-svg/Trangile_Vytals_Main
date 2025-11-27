Report 50255 ModifiedDLforSOCreate
{
    Permissions = TableData "SSD Distributor Line"=rimd;
    ProcessingOnly = true;
    ApplicationArea = All;

    dataset
    {
        dataitem("Distributor Line"; "SSD Distributor Line")
        {
            column(ReportForNavId_1000000000;1000000000)
            {
            }
            trigger OnAfterGetRecord()
            begin
                // "Create Sales Order" := TRUE;
                // MODIFY;
                SelectLatestVersion;
                DistributorLine.Reset;
                DistributorLine.SetRange("MRP No", "MRP No");
                DistributorLine.SetRange(Month, Month);
                DistributorLine.SetRange("Item Code", "Item Code");
                DistributorLine.SetRange("Sales Line No.", "Sales Line No.");
                DistributorLine.SetRange("Create Sales Order", false);
                if DistributorLine.FindFirst then begin
                    DistributorLine."Create Sales Order":=true;
                    DistributorLine.Modify;
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
    var DistributorLine: Record "SSD Distributor Line";
}
