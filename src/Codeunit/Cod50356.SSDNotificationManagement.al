codeunit 50356 "SSD Notification Management"
{
    [EventSubscriber(ObjectType::Page, Page::"Document Attachment Factbox", 'OnBeforeOnAfterGetCurrRecord', '', false, false)]
    local procedure SSDOnBeforeOnAfterGetCurrRecord(var DocumentAttachment: Record "Document Attachment")
    var
        UserSetup: Record "User Setup";
    begin
        UserSetup.Get(UserId);
        if not UserSetup."Attachment Admin" then begin
            DocumentAttachment.FilterGroup(2);
            DocumentAttachment.SetRange("Merged Attachment", false);
            DocumentAttachment.FilterGroup(0);
        end;
    end;
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Notification Entry Dispatcher", 'OnBeforeGetHTMLBodyText', '', false, false)]
    local procedure SSDOnBeforeCreateAndDispatch(var NotificationEntry: Record "Notification Entry"; var BodyTextOut: Text; var Result: Boolean; var IsHandled: Boolean)
    var
        ApprovalEntry: Record "Approval Entry";
        SSDIndentHeader: Record "SSD Indent Header";
        SSDIndentHeader2: Record "SSD Indent Header";
        PurchaseHeader: Record "Purchase Header";
        PurchaseHeader2: Record "Purchase Header";
        TempEmailItem: Record "Email Item" temporary;
        UserSetup: Record "User Setup";
        PurchasesPayableSetup: Record "Purchases & Payables Setup";
        DocumentAttachment: Record "Document Attachment";
        TempBlob: Codeunit "Temp Blob";
        TempBlob2: Codeunit "Temp Blob";
        ToMailId: Text[250];
        CCMailId: Text[250];
        BodyText: Text;
        EmailScenario: Enum "Email Scenario";
        ReportInstream: InStream;
        ReportOutstream: OutStream;
        ReportAttachmentInstream: InStream;
        ReportAttachmentOutstream: OutStream;
        SSDRecordRef: RecordRef;
        FileName: Text;
        IsEmailedSuccessfully: Boolean;
        IsAttachment: Boolean;
    begin
        if NotificationEntry."Triggered By Record".TableNo <> Database::"Approval Entry" then exit;
        IsAttachment:=false;
        PurchasesPayableSetup.Get();
        PurchasesPayableSetup.TestField("SSD SPO Alert Mail");
        if NotificationEntry.FindSet()then repeat IsEmailedSuccessfully:=false;
                Clear(TempBlob);
                Clear(TempBlob2);
                ApprovalEntry.Get(NotificationEntry."Triggered By Record");
                case ApprovalEntry."Table ID" of Database::"SSD Indent Header": begin
                    SSDIndentHeader2.Get(ApprovalEntry."Record ID to Approve");
                    SSDIndentHeader.SetRange("No.", SSDIndentHeader2."No.");
                    SSDIndentHeader.FindFirst();
                    SSDRecordRef.GetTable(SSDIndentHeader);
                    FileName:='Indent_' + SSDIndentHeader."No." + '.pdf';
                    if ApprovalEntry.Status = ApprovalEntry.Status::Open then begin
                        TempBlob.CreateOutStream(ReportOutstream);
                        Report.SaveAs(Report::"Indent Creation", '', ReportFormat::Html, ReportOutstream, SSDRecordRef);
                        TempBlob.CreateInStream(ReportInstream);
                        ReportInstream.ReadText(BodyText);
                        UserSetup.Get(ApprovalEntry."Approver ID");
                        ToMailId:=UserSetup."E-Mail";
                        if not EnvironmentInformation.IsProduction()then ToMailId:=PurchasesPayableSetup."SSD SPO Alert Mail";
                        Clear(TempBlob);
                        TempBlob.CreateOutStream(ReportAttachmentOutstream);
                        Report.SaveAs(Report::"Indent Report", '', ReportFormat::Pdf, ReportAttachmentOutstream, SSDRecordRef);
                        TempBlob.CreateInStream(ReportAttachmentInstream);
                        TempEmailItem."Send to":=ToMailId;
                        TempEmailItem.Subject:='Service Indent Approval';
                        TempEmailItem.SetBodyText(BodyText);
                        TempEmailItem.AddAttachment(ReportAttachmentInstream, FileName);
                        IsEmailedSuccessfully:=TempEmailItem.Send(true, EmailScenario::Default);
                    end;
                    if ApprovalEntry.Status = ApprovalEntry.Status::Approved then begin
                        TempBlob.CreateOutStream(ReportOutstream);
                        Report.SaveAs(Report::"Indent Approval", '', ReportFormat::Html, ReportOutstream, SSDRecordRef);
                        TempBlob.CreateInStream(ReportInstream);
                        ReportInstream.ReadText(BodyText);
                        UserSetup.Get(ApprovalEntry."Sender ID");
                        ToMailId:=UserSetup."E-Mail";
                        if not EnvironmentInformation.IsProduction()then ToMailId:=PurchasesPayableSetup."SSD SPO Alert Mail";
                        Clear(TempBlob);
                        TempBlob.CreateOutStream(ReportAttachmentOutstream);
                        Report.SaveAs(Report::"Indent Report", '', ReportFormat::Pdf, ReportAttachmentOutstream, SSDRecordRef);
                        TempBlob.CreateInStream(ReportAttachmentInstream);
                        TempEmailItem."Send to":=ToMailId;
                        TempEmailItem.Subject:='Service Indent Approved';
                        TempEmailItem.SetBodyText(BodyText);
                        TempEmailItem.AddAttachment(ReportAttachmentInstream, FileName);
                        IsEmailedSuccessfully:=TempEmailItem.Send(true, EmailScenario::Default);
                    end;
                    ProcessNotificationEntry(NotificationEntry, BodyText, IsEmailedSuccessfully);
                    IsHandled:=true;
                    Result:=false;
                end;
                Database::"Purchase Header": begin
                    PurchaseHeader.Get(ApprovalEntry."Record ID to Approve");
                    if PurchaseHeader."SSD Order Type" = PurchaseHeader."SSD Order Type"::Inventory then exit;
                    if PurchaseHeader."Document Type" <> PurchaseHeader."Document Type"::Order then exit;
                    if PurchaseHeader."SSD Order Type" <> PurchaseHeader."SSD Order Type"::Inventory then begin
                        PurchaseHeader2.SetRange("Document Type", PurchaseHeader."Document Type");
                        PurchaseHeader2.SetRange("No.", PurchaseHeader."No.");
                        PurchaseHeader2.FindFirst();
                        SSDRecordRef.GetTable(PurchaseHeader2);
                        FileName:='SPO' + PurchaseHeader2."No." + '.pdf';
                        TempBlob.CreateOutStream(ReportOutstream);
                        Report.SaveAs(Report::"SPO Creation", '', ReportFormat::Html, ReportOutstream, SSDRecordRef);
                        TempBlob.CreateInStream(ReportInstream);
                        ReportInstream.ReadText(BodyText);
                        UserSetup.Get(ApprovalEntry."Approver ID"); //SSD_170624
                        ToMailId:=UserSetup."E-Mail";
                        if not EnvironmentInformation.IsProduction()then ToMailId:=PurchasesPayableSetup."SSD SPO Alert Mail";
                        Clear(TempBlob);
                        TempEmailItem."Send to":=ToMailId;
                        TempEmailItem.Subject:='SPO Approval';
                        TempEmailItem.SetBodyText(BodyText);
                        TempBlob.CreateOutStream(ReportAttachmentOutstream);
                        Report.SaveAs(Report::"Service Order Report", '', ReportFormat::Pdf, ReportAttachmentOutstream, SSDRecordRef);
                        TempBlob.CreateInStream(ReportAttachmentInstream);
                        TempEmailItem.AddAttachment(ReportAttachmentInstream, FileName);
                        DocumentAttachment.Reset();
                        DocumentAttachment.SetRange("Table ID", Database::"Purchase Header");
                        DocumentAttachment.SetRange("Document Type", DocumentAttachment."Document Type"::Order);
                        DocumentAttachment.SetRange("No.", PurchaseHeader2."No.");
                        DocumentAttachment.SetRange("SSD Is Annexure", true);
                        //SSD2506 Alternate Code Start
                        if DocumentAttachment.FindSet()then repeat Clear(TempBlob);
                                Clear(ReportAttachmentOutstream);
                                Clear(ReportAttachmentInstream);
                                TempBlob.CreateOutStream(ReportAttachmentOutstream);
                                DocumentAttachment."Document Reference ID".ExportStream(ReportAttachmentOutstream);
                                TempBlob.CreateInStream(ReportAttachmentInstream);
                                TempEmailItem.AddAttachment(ReportAttachmentInstream, FileName);
                            until DocumentAttachment.Next() = 0;
                        // if not DocumentAttachment.FindFirst() then begin
                        //     TempBlob.CreateOutStream(ReportAttachmentOutstream);
                        //     Report.SaveAs(Report::"Service Order Report", '', ReportFormat::Pdf, ReportAttachmentOutstream, SSDRecordRef);
                        //     TempBlob.CreateInStream(ReportAttachmentInstream);
                        //     IsAttachment := true;
                        // end else begin
                        //     DocumentAttachment.Reset();
                        //     DocumentAttachment.SetRange("Table ID", Database::"Purchase Header");
                        //     DocumentAttachment.SetRange("Document Type", DocumentAttachment."Document Type"::Order);
                        //     DocumentAttachment.SetRange("No.", PurchaseHeader2."No.");
                        //     DocumentAttachment.SetRange("Merged Attachment", true);
                        //     IF DocumentAttachment.FindFirst() then begin
                        //         TempBlob.CreateOutStream(ReportAttachmentOutstream);
                        //         DocumentAttachment."Document Reference ID".ExportStream(ReportAttachmentOutstream);
                        //         TempBlob.CreateInStream(ReportAttachmentInstream);
                        //         IsAttachment := true;
                        //     end else begin
                        //         //Error('Attachmet does not exists');//Sunil_080524
                        //         ProcessNotificationEntry(NotificationEntry, BodyText, false);
                        //     end;
                        // end;
                        //if IsAttachment then
                        //TempEmailItem.AddAttachment(ReportAttachmentInstream, FileName);
                        IsEmailedSuccessfully:=TempEmailItem.Send(true, EmailScenario::Default);
                        ProcessNotificationEntry(NotificationEntry, BodyText, IsEmailedSuccessfully);
                        IsHandled:=true;
                        Result:=false;
                    end;
                end;
                end;
            until NotificationEntry.Next() = 0;
    end;
    procedure SendPurchaseOrderConsumptionMail(PurchaseHeader: Record "Purchase Header")
    var
        PurchaseHeader2: Record "Purchase Header";
        TempEmailItem: Record "Email Item" temporary;
        PurchasesPayableSetup: Record "Purchases & Payables Setup";
        Purchaser: Record "Salesperson/Purchaser";
        TempBlob: Codeunit "Temp Blob";
        TempBlob2: Codeunit "Temp Blob";
        ToMailId: Text[250];
        CCMailId: Text[250];
        BodyText: Text;
        EmailScenario: Enum "Email Scenario";
        ReportInstream: InStream;
        ReportOutstream: OutStream;
        ReportAttachmentInstream: InStream;
        ReportAttachmentOutstream: OutStream;
        SSDRecordRef: RecordRef;
        FileName: Text;
    begin
        FileName:='SPO_' + PurchaseHeader."No." + '.pdf';
        if not Purchaser.Get(PurchaseHeader."Purchaser Code")then exit;
        if Purchaser."E-Mail" = '' then exit;
        PurchaseHeader2.SetRange("Document Type", PurchaseHeader."Document Type");
        PurchaseHeader2.SetRange("No.", PurchaseHeader."No.");
        PurchaseHeader2.FindFirst();
        SSDRecordRef.GetTable(PurchaseHeader2);
        PurchasesPayableSetup.Get();
        TempBlob.CreateOutStream(ReportOutstream);
        Report.SaveAs(Report::"SPO 90% Consumption Alert", '', ReportFormat::Html, ReportOutstream, SSDRecordRef);
        TempBlob.CreateInStream(ReportInstream);
        ReportInstream.ReadText(BodyText);
        ToMailId:=Purchaser."E-Mail";
        if not EnvironmentInformation.IsProduction()then ToMailId:=PurchasesPayableSetup."SSD SPO Alert Mail";
        Clear(TempBlob);
        TempBlob.CreateOutStream(ReportAttachmentOutstream);
        Report.SaveAs(Report::"Service Order Report", '', ReportFormat::Pdf, ReportAttachmentOutstream, SSDRecordRef);
        TempBlob.CreateInStream(ReportAttachmentInstream);
        TempEmailItem."Send to":=ToMailId;
        TempEmailItem.Subject:='Service Order 90% used';
        TempEmailItem.SetBodyText(BodyText);
        TempEmailItem.AddAttachment(ReportAttachmentInstream, FileName);
        TempEmailItem.Send(true, EmailScenario::Default);
    end;
    procedure SendSPOReleaseMail(PurchaseHeader: Record "Purchase Header")
    var
        TempEmailItem: Record "Email Item" temporary;
        PurchasesPayableSetup: Record "Purchases & Payables Setup";
        DocumentAttachment: Record "Document Attachment";
        Purchaser: Record "Salesperson/Purchaser";
        PurchaseHeader2: Record "Purchase Header";
        Vendor: Record Vendor;
        TempBlob: Codeunit "Temp Blob";
        TempBlob2: Codeunit "Temp Blob";
        ToMailId: Text[250];
        CCMailId: Text[250];
        BodyText: Text;
        EmailScenario: Enum "Email Scenario";
        ReportInstream: InStream;
        ReportOutstream: OutStream;
        ReportAttachmentInstream: InStream;
        ReportAttachmentOutstream: OutStream;
        SSDRecordRef: RecordRef;
        FileName: Text;
        ToMailText: Text;
    begin
        if not Purchaser.Get(PurchaseHeader."Purchaser Code")then exit;
        if Purchaser."E-Mail" = '' then exit;
        ToMailText:='';
        FileName:='SPO_' + PurchaseHeader."No." + '.pdf';
        PurchaseHeader2.SetRange("Document Type", PurchaseHeader."Document Type");
        PurchaseHeader2.SetRange("No.", PurchaseHeader."No.");
        PurchaseHeader2.FindFirst();
        SSDRecordRef.GetTable(PurchaseHeader2);
        PurchasesPayableSetup.Get();
        TempBlob.CreateOutStream(ReportOutstream);
        Report.SaveAs(Report::"SPO to Vendor", '', ReportFormat::Html, ReportOutstream, SSDRecordRef);
        TempBlob.CreateInStream(ReportInstream);
        ReportInstream.ReadText(BodyText);
        if PurchaseHeader."PO Email" then begin
            Vendor.Get(PurchaseHeader2."Buy-from Vendor No.");
            AddEmail(ToMailId, Vendor."E-Mail");
        end;
        AddEmail(ToMailId, Purchaser."E-Mail");
        //Include All approval hierarcy person
        //Include Indent User
        if not EnvironmentInformation.IsProduction()then begin
            ToMailText:=ToMailId;
            ToMailId:=PurchasesPayableSetup."SSD SPO Alert Mail";
        end;
        Clear(TempBlob);
        DocumentAttachment.Reset();
        DocumentAttachment.SetRange("Table ID", Database::"Purchase Header");
        DocumentAttachment.SetRange("Document Type", DocumentAttachment."Document Type"::Order);
        DocumentAttachment.SetRange("No.", PurchaseHeader2."No.");
        DocumentAttachment.SetRange("SSD Is Annexure", true);
        if not DocumentAttachment.FindFirst()then begin
            TempBlob.CreateOutStream(ReportAttachmentOutstream);
            Report.SaveAs(Report::"Service Order Report", '', ReportFormat::Pdf, ReportAttachmentOutstream, SSDRecordRef);
            TempBlob.CreateInStream(ReportAttachmentInstream);
        end
        else
        begin
            DocumentAttachment.Reset();
            DocumentAttachment.SetRange("Table ID", Database::"Purchase Header");
            DocumentAttachment.SetRange("Document Type", DocumentAttachment."Document Type"::Order);
            DocumentAttachment.SetRange("No.", PurchaseHeader2."No.");
            DocumentAttachment.SetRange("Merged Attachment", true);
            IF DocumentAttachment.FindFirst()then begin
                TempBlob.CreateOutStream(ReportAttachmentOutstream);
                DocumentAttachment."Document Reference ID".ExportStream(ReportAttachmentOutstream);
                TempBlob.CreateInStream(ReportAttachmentInstream);
            end
            else
            begin
            // Error('Merged Attachmet does not exists'); //Sunil_080524
            end;
        end;
        TempEmailItem."Send to":=ToMailId;
        TempEmailItem.Subject:='Service Purchase Order' + ToMailText;
        TempEmailItem.SetBodyText(BodyText);
        TempEmailItem.AddAttachment(ReportAttachmentInstream, FileName);
        TempEmailItem.Send(true, EmailScenario::Default);
    end;
    procedure SendSRNCreationMail(PurchaseHeader: Record "Purchase Header")
    var
        TempEmailItem: Record "Email Item" temporary;
        PurchaseHeader2: Record "Purchase Header";
        PurchasesPayableSetup: Record "Purchases & Payables Setup";
        UserSetup: Record "User Setup";
        TempBlob: Codeunit "Temp Blob";
        TempBlob2: Codeunit "Temp Blob";
        ToMailId: Text[250];
        CCMailId: Text[250];
        BodyText: Text;
        EmailScenario: Enum "Email Scenario";
        ReportInstream: InStream;
        ReportOutstream: OutStream;
        ReportAttachmentInstream: InStream;
        ReportAttachmentOutstream: OutStream;
        SSDRecordRef: RecordRef;
        FileName: Text;
        EmailText: Text;
    begin
        FileName:='SRN_' + PurchaseHeader."No." + '.pdf';
        PurchaseHeader2.SetRange("Document Type", PurchaseHeader."Document Type");
        PurchaseHeader2.SetRange("No.", PurchaseHeader."No.");
        PurchaseHeader2.FindFirst();
        SSDRecordRef.GetTable(PurchaseHeader2);
        PurchasesPayableSetup.Get();
        TempBlob.CreateOutStream(ReportOutstream);
        Report.SaveAs(Report::"SRN Creation", '', ReportFormat::Html, ReportOutstream, SSDRecordRef);
        TempBlob.CreateInStream(ReportInstream);
        ReportInstream.ReadText(BodyText);
        UserSetup.Get(PurchaseHeader2."Assigned User ID");
        ToMailId:=UserSetup."E-Mail";
        if not EnvironmentInformation.IsProduction()then begin
            EmailText:=ToMailId;
            ToMailId:=PurchasesPayableSetup."SSD SPO Alert Mail";
        end;
        TempEmailItem."Send to":=ToMailId;
        TempEmailItem.Subject:='SRN Approval ' + EmailText;
        TempEmailItem.SetBodyText(BodyText);
        TempEmailItem.Send(true, EmailScenario::Default);
    end;
    procedure SendSRNPostMail(PurchaseHeader: Record "Purchase Header"; ReceiptNo: code[20])
    var
        TempEmailItem: Record "Email Item" temporary;
        PurchasesPayableSetup: Record "Purchases & Payables Setup";
        UserSetup: Record "User Setup";
        ToMailId: Text[250];
        CCMailId: Text[250];
        SubjectText: Text;
        BodyText: Text;
        EmailScenario: Enum "Email Scenario";
        EmailText: Text;
    begin
        if PurchaseHeader."SSD SRN User" = '' then exit;
        if not UserSetup.Get(PurchaseHeader."SSD SRN User")then exit;
        UserSetup.Get(PurchaseHeader."SSD SRN User");
        if UserSetup."E-Mail" = '' then exit;
        PurchasesPayableSetup.Get();
        ToMailId:=UserSetup."E-Mail";
        SubjectText:='SRN ' + ReceiptNo + ' for SPO ' + PurchaseHeader."No." + ' Posted';
        BodyText:='SRN ' + ReceiptNo + ' for SPO ' + PurchaseHeader."No." + ' has been Posted by ' + UserId;
        if not EnvironmentInformation.IsProduction()then begin
            EmailText:=ToMailId;
            ToMailId:=PurchasesPayableSetup."SSD SPO Alert Mail";
        end;
        TempEmailItem."Send to":=ToMailId;
        TempEmailItem.Subject:=SubjectText;
        TempEmailItem.SetBodyText(BodyText);
        TempEmailItem.Send(true, EmailScenario::Default);
    end;
    local procedure ProcessNotificationEntry(var NotificationEntry: Record "Notification Entry"; BodyText: Text; IsEmailedSuccessfully: Boolean)
    var
        NotificationSetup: Record "Notification Setup";
        NotificationManagement: Codeunit "Notification Management";
        MailManagement: Codeunit "Mail Management";
        ErrorMessageMgt: Codeunit "Error Message Management";
        ErrorText: Text;
        EmailFailedToSendErr: Label 'Notification (%1)''s email failed to send due to: %2', Comment = '%1 = Notification Entry ID, %2 = Error message';
        NoEmailAccountsErr: Label 'Cannot send the email. No email accounts have been added.';
    begin
        if IsEmailedSuccessfully then NotificationManagement.MoveNotificationEntryToSentNotificationEntries(NotificationEntry, BodyText, true, NotificationSetup."Notification Method"::Email.AsInteger())
        else
        begin
            ErrorText:=GetLastErrorText();
            if ErrorText = '' then if not MailManagement.IsEnabled()then ErrorText:=NoEmailAccountsErr;
            NotificationEntry."Error Message":=CopyStr(ErrorText, 1, MaxStrLen(NotificationEntry."Error Message"));
            NotificationEntry.Modify(true);
            ErrorMessageMgt.LogError(NotificationEntry, StrSubstNo(EmailFailedToSendErr, NotificationEntry.ID, ErrorText), '');
        end;
    end;
    local procedure AddEmail(var EmailId: Text[250]; NewMailId: Text[80])
    begin
        if EmailId = '' then EmailId:=NewMailId
        else
            EmailId+=';' + NewMailId;
    end;
    var EnvironmentInformation: Codeunit "Environment Information";
}
