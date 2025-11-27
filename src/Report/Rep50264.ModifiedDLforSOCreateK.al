Report 50264 "ModifiedDLforSOCreate-K"
{
    Permissions = TableData "SSD Distributor Line"=rimd;
    ProcessingOnly = true;
    ShowPrintStatus = false;
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
                //"Distributor Line"."Create Sales Order" := TRUE;
                //"Distributor Line".MODIFY(TRUE);
                SelectLatestVersion;
                //IF COMPANYNAME = 'Zavenir Kluthe India (P) Ltd.' THEN BEGIN
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
            //END;
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
