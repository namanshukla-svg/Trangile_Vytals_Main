Report 50258 "SO Create Mail send"
{
    ProcessingOnly = true;
    ApplicationArea = All;

    dataset
    {
        dataitem("Distributor Line"; "SSD Distributor Line")
        {
            DataItemTableView = where(Updated=filter(true), "Mail Sent"=filter(false));

            column(ReportForNavId_1000000000;1000000000)
            {
            }
            trigger OnAfterGetRecord()
            var
                SalesHeader2: Record "Sales Header";
                DistributionHeader_G: Record "SSD Distributor Header";
            begin
                //AlleEvents.SendMailOnSOCreate("Distributor Line"."SP Order No.");
                DistributionHeader_G.Get("Distributor Line"."MRP No");
                SalesHeader2.SetRange("Document Type", SalesHeader2."document type"::Order);
                SalesHeader2.SetRange("Sell-to Customer No.", DistributionHeader_G."Customer Code");
                SalesHeader2.SetRange("External Document No.", "Distributor Line"."SP Order No.");
                SalesHeader2.SetRange(CT2, false);
                if SalesHeader2.FindSet then repeat AlleEvents.SendMailOnSalesOrderCreate(SalesHeader2."No.", "Distributor Line"."SP Order No.");
                        SalesHeader2.CT2:=true;
                        SalesHeader2.Modify(true);
                    until SalesHeader2.Next = 0;
                "Distributor Line"."Mail Sent":=true;
                "Distributor Line".Modify;
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
    trigger OnPostReport()
    begin
        Message('Done');
    end;
    var AlleEvents: Codeunit "Alle Events";
    DistributorLine1: Record "SSD Distributor Line";
}
