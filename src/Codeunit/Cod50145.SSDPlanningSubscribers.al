codeunit 50145 "SSD Planning Subscribers"
{
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Get Unplanned Demand", 'OnBeforeGetUnplannedSalesLine', '', false, false)]
    local procedure SSDOnBeforeGetUnplannedSalesLine(var UnplannedDemand: Record "Unplanned Demand"; var SalesLine: Record "Sales Line")
    begin
        SalesLine.SETFILTER("Document Subtype", '%1', SalesLine."Document Subtype"::Order);
    end;
}
