codeunit 50353 "SSD SPO Alert Management"
{
    trigger OnRun()
    begin
        PurchasesPayablesSetup.Get();
        PurchasesPayablesSetup.TestField("SSD SPO Alert Mail");
        SSDPurchaseOrderBuffer.Reset();
        SSDPurchaseOrderBuffer.DeleteAll();
        GenerateSPOAlertMails0Days();
        GenerateSPOAlertMails15Days();
        GenerateSPOAlertMails30Days();
    end;
    local procedure GenerateSPOAlertMails0Days()
    var
        PurchaseHeader: Record "Purchase Header";
        OrderNo: Code[20];
    begin
        if Purchaser.FindSet()then repeat PurchaseHeader.SetRange("Document Type", PurchaseHeader."Document Type"::Order);
                PurchaseHeader.SetFilter("SSD Order Type", '%1|%2', PurchaseHeader."SSD Order Type"::Service, PurchaseHeader."SSD Order Type"::"Fixed Assets");
                PurchaseHeader.SetRange("Purchaser Code", Purchaser.Code);
                PurchaseHeader.SetRange("Valid To", 0D, CalcDate('-1D', Today));
                PurchaseHeader.SetRange(Status, PurchaseHeader.Status::Released);
                PurchaseHeader.SetRange("SSD Exclude Mail", false);
                if PurchaseHeader.FindSet()then repeat if ProcessPOCheck(PurchaseHeader."No.")then ProcessPO(Purchaser.Code, PurchaseHeader."No.", 30);
                    until PurchaseHeader.Next() = 0;
            until Purchaser.Next() = 0;
    end;
    local procedure GenerateSPOAlertMails15Days()
    var
        PurchaseHeader: Record "Purchase Header";
        OrderNo: Code[20];
    begin
        if Purchaser.FindSet()then repeat PurchaseHeader.SetRange("Document Type", PurchaseHeader."Document Type"::Order);
                PurchaseHeader.SetFilter("SSD Order Type", '%1|%2', PurchaseHeader."SSD Order Type"::Service, PurchaseHeader."SSD Order Type"::"Fixed Assets");
                PurchaseHeader.SetRange("Purchaser Code", Purchaser.Code);
                PurchaseHeader.SetRange("Valid To", Today, CalcDate('15D', Today));
                PurchaseHeader.SetRange(Status, PurchaseHeader.Status::Released);
                PurchaseHeader.SetRange("SSD Exclude Mail", false);
                if PurchaseHeader.FindSet()then repeat if ProcessPOCheck(PurchaseHeader."No.")then ProcessPO(Purchaser.Code, PurchaseHeader."No.", 30);
                    until PurchaseHeader.Next() = 0;
            until Purchaser.Next() = 0;
    end;
    local procedure GenerateSPOAlertMails30Days()
    var
        PurchaseHeader: Record "Purchase Header";
    begin
        if Purchaser.FindSet()then repeat PurchaseHeader.SetRange("Document Type", PurchaseHeader."Document Type"::Order);
                PurchaseHeader.SetFilter("SSD Order Type", '%1|%2', PurchaseHeader."SSD Order Type"::Service, PurchaseHeader."SSD Order Type"::"Fixed Assets");
                PurchaseHeader.SetRange("Purchaser Code", Purchaser.Code);
                PurchaseHeader.SetRange("Valid To", Today, CalcDate('30D', Today));
                PurchaseHeader.SetRange("SSD Exclude Mail", false);
                PurchaseHeader.SetRange(Status, PurchaseHeader.Status::Released);
                if PurchaseHeader.FindSet()then repeat if ProcessPOCheck(PurchaseHeader."No.")then ProcessPO(Purchaser.Code, PurchaseHeader."No.", 30);
                    until PurchaseHeader.Next() = 0;
            until Purchaser.Next() = 0;
    end;
    local procedure ProcessPO(PurchaserCode: Code[20]; OrderNo: Code[20]; NoOfDays: Integer)
    var
        TempEmailItem: Record "Email Item" temporary;
        Purchaser2: Record "Salesperson/Purchaser";
        TempBlob: Codeunit "Temp Blob";
        PurchaserRecordRef: RecordRef;
        ReportInstream: InStream;
        ReportOutstream: OutStream;
        ToMailId: Text[250];
        CCMailId: Text[250];
        BodyText: Text;
        EmailScenario: Enum "Email Scenario";
        SPOAlert: Report "SSD SPO Alert";
        ReportParameters: Text;
    begin
        Clear(EmailMessage);
        Clear(MailList);
        Purchaser2.SetRange(Code, PurchaserCode);
        Purchaser2.FindFirst();
        PurchaserRecordRef.GetTable(Purchaser2);
        ReportParameters:=GetReportParameters(OrderNo, 30, PurchaserCode);
        TempBlob.CreateOutStream(ReportOutstream);
        Report.SaveAs(Report::"SSD SPO Alert", ReportParameters, ReportFormat::Html, ReportOutstream, PurchaserRecordRef);
        TempBlob.CreateInStream(ReportInstream);
        ReportInstream.ReadText(BodyText);
        GetApprovalMailIds(OrderNo, ToMailId, CCMailId);
        TempEmailItem."Send to":=ToMailId;
        TempEmailItem."Send CC":=CCMailId;
        TempEmailItem.Subject:='Expiring Service Order Alert';
        TempEmailItem.SetBodyText(BodyText);
        TempEmailItem.Send(true, EmailScenario::Default);
    end;
    local procedure ProcessPOCheck(OrderNo: Code[20]): Boolean begin
        if SSDPurchaseOrderBuffer.Get(OrderNo)then exit(false)
        else
        begin
            SSDPurchaseOrderBuffer.Init();
            SSDPurchaseOrderBuffer."Order No.":=OrderNo;
            SSDPurchaseOrderBuffer.Insert();
        end;
        exit(true);
    end;
    local procedure GetApprovalMailIds(OrderNo: Code[20]; var ToMailTxt: Text[250]; var CCMailTxt: Text[250])
    var
        ApprovalEntries: Record "Approval Entry";
        UserSetup: Record "User Setup";
    begin
        ToMailTxt:='';
        CCMailTxt:='';
        ApprovalEntries.SetRange("Table ID", Database::"Sales Header");
        ApprovalEntries.SetRange("Document Type", ApprovalEntries."Document Type"::Order);
        ApprovalEntries.SetRange("Document No.", OrderNo);
        ApprovalEntries.SetRange(Status, ApprovalEntries.Status::Approved);
        ApprovalEntries.SetRange("Sequence No.", 1);
        if ApprovalEntries.FindLast()then begin
            if UserSetup.Get(ApprovalEntries."Approver ID")then ToMailTxt:=UserSetup."E-Mail";
        end;
        ApprovalEntries.SetRange("Sequence No.", 2);
        if ApprovalEntries.FindLast()then begin
            if UserSetup.Get(ApprovalEntries."Approver ID")then CCMailTxt:=UserSetup."E-Mail";
        end;
        if not EnvironmentInformation.IsProduction()then begin
            ToMailTxt:='';
            CCMailTxt:='';
        end;
        if ToMailTxt = '' then ToMailTxt:=PurchasesPayablesSetup."SSD SPO Alert Mail";
        if CCMailTxt = '' then ToMailTxt:=PurchasesPayablesSetup."SSD SPO Alert Mail";
    end;
    local procedure GetReportParameters(OrderNo: Code[20]; NoOfDays: Integer; Purchaser: Code[20])ParameterText: Text var
        RepParameters: Label '<?xml version="1.0" standalone="yes"?><ReportParameters name="SSD SPO Alert" id="50650"><Options><Field name="OrderNo">%1</Field><Field name="NoOfDays">%2</Field></Options><DataItems><DataItem name="Salesperson/Purchaser">VERSION(1) SORTING(Field1) WHERE(Field1=1(%3))</DataItem><DataItem name="PurchaseHeader">VERSION(1) SORTING(Field1,Field3)</DataItem></DataItems></ReportParameters>';
    begin
        ParameterText:=StrSubstNo(RepParameters, OrderNo, NoOfDays, Purchaser);
    end;
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Notification Management", 'OnGetDocumentTypeAndNumber', '', false, false)]
    local procedure SSDOnGetDocumentTypeAndNumber(var RecRef: RecordRef; var DocumentType: Text; var DocumentNo: Text; var IsHandled: Boolean)
    var
        FieldRef: FieldRef;
    begin
        if RecRef.Number = Database::"SSD Indent Header" then begin
            DocumentType:=RecRef.Caption;
            FieldRef:=RecRef.Field(1);
            DocumentNo:=format(FieldRef.Value);
            IsHandled:=true;
        end;
    end;
    //OnBeforeDispatchNotificationTypeForUser
    var Purchaser: Record "Salesperson/Purchaser";
    PurchasesPayablesSetup: Record "Purchases & Payables Setup";
    SSDPurchaseOrderBuffer: Record "SSD Purchase Order Buffer" temporary;
    EmailMessage: Codeunit "Email Message";
    EnvironmentInformation: Codeunit "Environment Information";
    MailList: List of[Text];
}
