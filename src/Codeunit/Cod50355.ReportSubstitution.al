codeunit 50355 "Report Substitution"
{
    trigger OnRun()
    begin
    end;
    var myInt: Integer;
    [EventSubscriber(ObjectType::Codeunit, Codeunit::ReportManagement, 'OnAfterSubstituteReport', '', false, false)]
    local procedure OnSubstituteReport(ReportId: Integer; RunMode: Option Normal, ParametersOnly, Execute, Print, SaveAs, RunModal; RequestPageXml: Text; RecordRef: RecordRef; var NewReportId: Integer)
    var
        PurchaseHeader: Record "Purchase Header";
        PurchaseHeader2: Record "Purchase Header";
        PurchRcptHeader: Record "Purch. Rcpt. Header";
        PurchRcptHeader2: Record "Purch. Rcpt. Header";
        CompanyInformation: Record "Company Information";
    begin
        CompanyInformation.Get();
        case RecordRef.Number of DATABASE::"Purchase Header": begin
            if ReportId <> Report::"PO Print" then begin
                NewReportId:=ReportId;
                exit;
            end;
            RecordRef.SETTABLE(PurchaseHeader);
            if PurchaseHeader2.Get(PurchaseHeader."Document Type", PurchaseHeader."No.")then begin
                case PurchaseHeader2."SSD Order Type" of PurchaseHeader2."SSD Order Type"::Inventory: begin
                    if CompanyInformation.Name = 'VYTALS WELLBEING INDIA PRIVATE LIMITED' then NewReportId:=Report::"Vytals PO Print"
                    else
                        NewReportId:=Report::"PO Print" end;
                PurchaseHeader2."SSD Order Type"::"Fixed Assets": begin
                    NewReportId:=Report::"Service Order Report" end;
                PurchaseHeader2."SSD Order Type"::Service: begin
                    NewReportId:=Report::"Service Order Report" end;
                end;
            end;
        end;
        DATABASE::"Purch. Rcpt. Header": begin
            RecordRef.SETTABLE(PurchRcptHeader);
            if PurchRcptHeader2.Get(PurchRcptHeader."No.")then begin
                case PurchRcptHeader2."SSD Order Type" of PurchRcptHeader2."SSD Order Type"::Inventory: begin
                    NewReportId:=Report::"Purchase - Receipt New" end;
                PurchRcptHeader2."SSD Order Type"::"Fixed Assets": begin
                    NewReportId:=Report::"Service Receipt Report" end;
                PurchRcptHeader2."SSD Order Type"::Service: begin
                    NewReportId:=Report::"Service Receipt Report" end;
                end;
            end;
        end;
        end;
    end;
}
