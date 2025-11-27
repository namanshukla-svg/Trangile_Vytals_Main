codeunit 50027 "SSD Email Management"
{
    procedure IndentRelease(var IndentHeader: Record "SSD Indent Header")
    var
        TempBlob: Codeunit "Temp Blob";
        Email: Codeunit Email;
        EmailMessage: Codeunit "Email Message";
        Base64Convert: Codeunit "Base64 Convert";
        DocNo: Code[20];
        InStream: InStream;
        OutStream: OutStream;
        Base64Txt: Text;
        Base64Txt2: Text;
        MailList: List of[Text];
        ReportSelection: Record "Report Selections";
        Usage: Enum "Report Selection Usage";
        IndentReleaseSubjectMsg: Label 'Indent Details';
        IndentReleaseBodyMsg: Label 'Dear Sir or Madam,<br><br>Indent %1 has been approved><br><br>Thanks';
    begin
        MailList.Add('lmohan@zavenir.com');
        MailList.Add('vchhabra@zavenir.com');
        MailList.Add('gurgaon.scm@zavenir.com');
        if EnvironmentInformation.IsProduction()then EmailMessage.Create(MailList, IndentReleaseSubjectMsg, StrSubstNo(IndentReleaseBodyMsg, IndentHeader."No."), true)
        else
        begin
            Clear(MailList);
            MailList.Add('sunil@ssdynamics.co.in');
            //MailList.Add('hyadav@zavenir.com');
            MailList.Add('ykuntal@zavenir.com');
            EmailMessage.Create(MailList, IndentReleaseSubjectMsg, StrSubstNo(IndentReleaseBodyMsg, IndentHeader."No."), true)end;
        Email.Enqueue(EmailMessage);
    end;
    procedure IndentSendForApproval(var IndentHeader: Record "SSD Indent Header")
    var
        TempBlob: Codeunit "Temp Blob";
        Email: Codeunit Email;
        EmailMessage: Codeunit "Email Message";
        Base64Convert: Codeunit "Base64 Convert";
        DocNo: Code[20];
        InStream: InStream;
        OutStream: OutStream;
        Base64Txt: Text;
        Base64Txt2: Text;
        MailList: List of[Text];
        ReportSelection: Record "Report Selections";
        Usage: Enum "Report Selection Usage";
        IndentSendSubjectMsg: Label 'Indent Details';
        IndentSendBodyMsg: Label 'Dear Sir or Madam,<br><br>Indent %1 has been sent for further Approval.<br><br>Thanks';
    begin
        MailList.Add('lmohan@zavenir.com');
        MailList.Add('vchhabra@zavenir.com');
        MailList.Add('gurgaon.scm@zavenir.com');
        if EnvironmentInformation.IsProduction()then EmailMessage.Create(MailList, IndentSendSubjectMsg, StrSubstNo(IndentSendBodyMsg, IndentHeader."No."), true)
        else
        begin
            clear(MailList);
            //MailList.Add('sunil@ssdynamics.co.in');
            //MailList.Add('hyadav@zavenir.com');
            MailList.Add('ykuntal@zavenir.com');
            EmailMessage.Create(MailList, IndentSendSubjectMsg, StrSubstNo(IndentSendBodyMsg, IndentHeader."No."), true);
        end;
        Email.Enqueue(EmailMessage);
    end;
    procedure MailSendPO(VAR PurchaseHeader2: Record "Purchase Header")
    var
        TempBlob: Codeunit "Temp Blob";
        Email: Codeunit Email;
        EmailMessage: Codeunit "Email Message";
        Base64Convert: Codeunit "Base64 Convert";
        DocNo: Code[20];
        InStream: InStream;
        OutStream: OutStream;
        Base64Txt: Text;
        Base64Txt2: Text;
        MailList: List of[Text];
        CCMailList: List of[Text];
        BCCMailList: List of[Text];
        ReportSelection: Record "Report Selections";
        Usage: Enum "Report Selection Usage";
        SubjectMSG: Label 'Zavenir Purchase Order %1_%2_%3';
        SubjectMSG1: Label 'Vytals Purchase Order %1_%2_%3';
        UserSetup: Record "User Setup";
        FileName: Text;
        PrevVendNo: Code[20];
        EmailId: Text[100];
        Vendor: Record Vendor;
        CompanyInfo: Record "Company Information";
        UserEmail: Text;
        RecPurchPerson: Record "Salesperson/Purchaser";
        PurchasePersonEmail: Text;
        PPName: Text;
        PPPhNo: Code[21];
        PPEmail: Text;
        PHArchive: Record "Purchase Header Archive";
        RevisionNo: Text;
        PurchaseHeader: Record "Purchase Header";
        RecRef: RecordRef;
        VendorEmail: Text;
        VendorRec: Record Vendor;
    begin
        // Start Alle SANK 200218
        FileName:='Purchse Order';
        FileName:=DELCHR(FileName, '=', '/\-. ');
        //path := 'C:\';
        //FileName := path + FileName + '.PDF';
        //FileName:=FileName+'.PDF';
        WITH PurchaseHeader2 DO BEGIN
            PurchaseHeader.SETRANGE("Document Type", PurchaseHeader."Document Type"::Order);
            PurchaseHeader.SETRANGE("No.", "No.");
            IF PurchaseHeader.FINDFIRST THEN BEGIN
                // REPORT.SAVEASPDF(50005, FileName, PurchaseHeader); 
                CLEAR(EmailId);
                CLEAR(UserEmail);
                Clear(MailList);
                Clear(CCMailList);
                Clear(BCCMailList);
                Clear(PurchasePersonEmail);
                Clear(VendorEmail);
                UserSetup.GET(USERID);
                UserEmail:=UserSetup."E-Mail";
                if PurchaseHeader."PO Email" then begin
                    VendorRec.Reset();
                    VendorRec.Get(PurchaseHeader."Buy-from Vendor No.");
                    VendorEmail:=VendorRec."E-Mail";
                end;
                IF RecPurchPerson.GET(PurchaseHeader."Purchaser Code")THEN PurchasePersonEmail:=RecPurchPerson."E-Mail";
                PPName:=RecPurchPerson.Name;
                PPPhNo:=RecPurchPerson."Phone No.";
                PPEmail:=RecPurchPerson."E-Mail";
                PHArchive.RESET;
                PHArchive.SETRANGE("Document Type", "Document Type");
                PHArchive.SETRANGE("No.", "No.");
                IF PHArchive.FINDLAST THEN BEGIN
                    RevisionNo:=' (Rev No.  ' + FORMAT(PHArchive."Version No.") + ')';
                END;
                if EnvironmentInformation.IsProduction()then begin
                    if CompanyInfo.Name = 'VYTALS WELLBEING INDIA PRIVATE LIMITED' THEN begin
                        MailList.AddRange(VendorEmail.Split(';'));
                        MailList.Add('jitin.behl@vytals.com');
                        CCMailList.Add('ykuntal@zavenir.com');
                        CCMailList.AddRange(PurchasePersonEmail.Split(';'));
                        EmailMessage.Create(MailList, StrSubstNo(SubjectMSG1, PurchaseHeader."No.", PurchaseHeader."Buy-from Vendor No.", PurchaseHeader."Buy-from Vendor Name"), '', true, CCMailList, BCCMailList)end
                    else
                    begin
                        Clear(MailList);
                        Clear(CCMailList);
                        MailList.AddRange(VendorEmail.Split(';'));
                        MailList.Add('mkawatra@zavenir.com');
                        MailList.Add('gurgaon.scm@zavenir.com');
                        CCMailList.Add('ykuntal@zavenir.com');
                        CCMailList.AddRange(PurchasePersonEmail.Split(';'));
                        EmailMessage.Create(MailList, StrSubstNo(SubjectMSG, PurchaseHeader."No.", PurchaseHeader."Buy-from Vendor No.", PurchaseHeader."Buy-from Vendor Name"), '', true, CCMailList, BCCMailList);
                    end;
                end
                else
                begin
                    Clear(MailList);
                    Clear(CCMailList);
                    //MailList.Add('sunil@ssdynamics.co.in');
                    //MailList.Add('hyadav@zavenir.com');
                    MailList.Add('ykuntal@zavenir.com');
                    if CompanyInfo.Name = 'VYTALS WELLBEING INDIA PRIVATE LIMITED' THEN EmailMessage.Create(MailList, StrSubstNo(SubjectMSG1, PurchaseHeader."No.", PurchaseHeader."Buy-from Vendor No.", PurchaseHeader."Buy-from Vendor Name"), '', true)
                    else
                        EmailMessage.Create(MailList, StrSubstNo(SubjectMSG, PurchaseHeader."No.", PurchaseHeader."Buy-from Vendor No.", PurchaseHeader."Buy-from Vendor Name"), '', true)end;
                EmailMessage.AppendToBody('Please find the attached PDF for Purchase Order.<br><br>');
                EmailMessage.AppendToBody('Do send the Order Acknowledgement and ensure to share the firm date of readiness in the same.<br><br>');
                EmailMessage.AppendToBody('If you need any assistance, please contact your concerned buyer : <br><br>');
                EmailMessage.AppendToBody('<table border="1" cellpadding="3" style="border-style: solid; border-width: 1px">');
                EmailMessage.AppendToBody('<tr>');
                EmailMessage.AppendToBody('<td><b><font face="arial" size ="2">Purchase Person & Contact No.</font></b></td>');
                EmailMessage.AppendToBody('<td><font face="arial" size ="2">' + FORMAT(PPName) + ' ; ' + FORMAT(PPPhNo) + ' ; ' + FORMAT(PPEmail) + '</font></td>');
                EmailMessage.AppendToBody('</tr>');
                EmailMessage.AppendToBody('</table>');
                EmailMessage.AppendToBody('With Best Regards, <br><br>' + ' <b>SCM Team</b> <br><br>');
                EmailMessage.AppendToBody('This is an automated email. Replies to this message are not monitored or answered.</b> <br><br>');
                // SMTPMail.AddAttachment(FileName, FileName);
                // IF SMTPMail.TrySend THEN BEGIN
                //SMTPMail.Send();
                TempBlob.CreateOutStream(OutStream);
                PurchaseHeader.SetRecFilter();
                RecRef.GetTable(PurchaseHeader);
                RecRef.SetRecFilter();
                if CompanyInfo.Name = 'VYTALS WELLBEING INDIA PRIVATE LIMITED' THEN begin
                    if Report.SaveAs(Report::"Vytals PO Print", '', ReportFormat::Pdf, OutStream, RecRef)then begin
                        //OrderConfirmReport.SaveAs('', ReportFormat::Pdf, OutStream);
                        TempBlob.CreateInStream(InStream);
                        Base64Txt:=Base64Convert.ToBase64(InStream, true);
                        EmailMessage.AddAttachment(FileName + '.pdf', 'application/pdf', Base64Txt);
                        Email.Enqueue(EmailMessage);
                        PurchaseHeader."PO Mail Send":=TRUE;
                        PurchaseHeader.MODIFY;
                        SLEEP(200);
                    END;
                end
                else
                begin
                    if Report.SaveAs(Report::"PO Print", '', ReportFormat::Pdf, OutStream, RecRef)then begin
                        //OrderConfirmReport.SaveAs('', ReportFormat::Pdf, OutStream);
                        TempBlob.CreateInStream(InStream);
                        Base64Txt:=Base64Convert.ToBase64(InStream, true);
                        EmailMessage.AddAttachment(FileName + '.pdf', 'application/pdf', Base64Txt);
                        Email.Enqueue(EmailMessage);
                        PurchaseHeader."PO Mail Send":=TRUE;
                        PurchaseHeader.MODIFY;
                        SLEEP(200);
                    end;
                end;
            end;
        end;
    end;
    var EnvironmentInformation: Codeunit "Environment Information";
}
