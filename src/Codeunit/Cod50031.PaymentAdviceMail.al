codeunit 50031 "Payment Advice Mail"
{
    trigger OnRun()
    begin
        PaymentAdvice();
    end;
    procedure PaymentAdvice()
    var
        TempBlob: Codeunit "Temp Blob";
        Email: Codeunit Email;
        EmailMessage: Codeunit "Email Message";
        Base64Convert: Codeunit "Base64 Convert";
        DocNo: Code[20];
        InStream: InStream;
        OutStream: OutStream;
        InStream2: InStream;
        OutStream2: OutStream;
        Base64Txt: Text;
        Base64Txt2: Text;
        MailList: List of[Text];
        CCMailList: List of[Text];
        BCCMailList: List of[Text];
        Suubject2: Label 'Payment Advice # %1 - %2';
        PaymentAdvice: Report "Payment Advice";
        RecRef: RecordRef;
        ActualID: Label 'Atual Mail - TO Mail - %1, CC Mail - %2';
        CCtestmail: Text;
    begin
        VendorLedgerEntry2.Reset();
        VendorLedgerEntry2.SetRange("Posting Date", CalcDate('-1D', Today));
        //SSD Remove
        //VendorLedgerEntry2.SetRange("Document No.", 'ZDBP24060285');
        //VendorLedgerEntry2.SetRange("Posting Date", 20230630D);
        //SSD Remove
        VendorLedgerEntry2.SetRange("Source Code", 'BANKPYMTV');
        if VendorLedgerEntry2.FindSet()then repeat Clear(MailList);
                Clear(CCMailList);
                Clear(BCCMailList);
                Clear(EmailId);
                Clear(PurchEmailId);
                Clear(FileName);
                Clear(CCtestmail);
                FileName:=' # ' + VendorLedgerEntry2."Document No.";
                FileName:=DELCHR(FileName, '=', '/\-. ');
                CLEAR(EmailId);
                IF Vendor.GET(VendorLedgerEntry2."Vendor No.")THEN BEGIN
                    IF Vendor."E-Mail" <> '' THEN EmailId:=Vendor."E-Mail";
                    IF SalespersonPurchaser.GET(Vendor."Purchaser Code")THEN PurchEmailId:=SalespersonPurchaser."E-Mail";
                END;
                MailList.AddRange(EmailId.Split(';'));
                UserSetup.GET(USERID);
                cominfo.GET;
                IF(PurchEmailId <> '') AND (PurchEmailId <> 'gurgaon.scm@zavenir.com')THEN CCMailList.AddRange(PurchEmailId.Split(';'));
                CCMailList.Add('msharma1@zavenir.com');
                CCMailList.Add('pkumar@zavenir.com');
                CCMailList.Add('ithelpdesk@zavenir.com');
                //CCtestmail += PurchEmailId + ';';
                //CCtestmail += 'msharma1@zavenir.com;pkumar@zavenir.com;hyadav@zavenir.com';
                IF UserSetup."E-Mail" <> '' THEN;
                if EnvironmentInformation.IsProduction()then EmailMessage.Create(MailList, StrSubstNo(Suubject2, VendorLedgerEntry2."Document No.", Vendor.Name), '', true, CCMailList, BCCMailList)
                else
                begin
                    clear(MailList);
                    Clear(CCMailList);
                    //MailList.Add('soni.sunil70@gmail.com');
                    //MailList.Add('hyadav@zavenir.com');
                    MailList.Add('ykuntal@zavenir.com');
                    EmailMessage.Create(MailList, StrSubstNo(Suubject2, VendorLedgerEntry2."Document No.", Vendor.Name), '', true);
                end;
                EmailMessage.AppendToBody('Dear Sir or Madam,<br><br>');
                EmailMessage.AppendToBody('Please find the above mentioned payment advice.<br><br>');
                EmailMessage.AppendToBody('Sincerely, <br>');
                IF COMPANYNAME = 'Zavenir Kluthe India (P) Ltd.' THEN EmailMessage.AppendToBody('Zavenir Metalworking Team <br><br>')
                ELSE if CompanyName = 'Zavenir Daubert India (P) Ltd.' then EmailMessage.AppendToBody('Zavenir Daubert Team <br><br>')
                    else if CompanyName = 'Vytals Wellbeing India (P) Ltd' then EmailMessage.AppendToBody('Vytals Wellbeing Team <br><br>');
                EmailMessage.AppendToBody('This is an automated email. Replies to this message are not monitored or answered. To contact us, please visit www.zavenir.com or call us at +91 124 4981000.<br><br>');
                //SSD Sunil Will remove after testing
                // EmailMessage.AppendToBody(StrSubstNo(ActualID, EmailId, CCtestmail));
                //SSD Sunil Will remove after testing
                Clear(TempBlob);
                Clear(Base64Txt);
                VendorLedgerEntry.RESET;
                VendorLedgerEntry.SETRANGE("Document No.", VendorLedgerEntry2."Document No.");
                IF VendorLedgerEntry.FINDSET THEN begin
                    TempBlob.CreateOutStream(OutStream);
                    VendorLedgerEntry.SetRecFilter();
                    RecRef.GetTable(VendorLedgerEntry);
                    RecRef.SetRecFilter();
                    if Report.SaveAs(Report::"Payment Advice", '', ReportFormat::Pdf, OutStream, RecRef)then begin
                        TempBlob.CreateInStream(InStream);
                        Base64Txt:=Base64Convert.ToBase64(InStream, true);
                        EmailMessage.AddAttachment(FileName + '.pdf', 'application/pdf', Base64Txt);
                    end;
                end;
                Email.Enqueue(EmailMessage);
                COMMIT;
            until VendorLedgerEntry2.Next() = 0;
    end;
    var FileName: Text[250];
    // Rep: Report "Production Order Details - WO";
    VendorLedgerEntry: Record "Vendor Ledger Entry";
    VendorLedgerEntry2: Record "Vendor Ledger Entry";
    a: Integer;
    path: Text[250];
    EmailId: Text[100];
    Vendor: Record Vendor;
    // SMTPMailSetup: Record "SMTP Mail Setup";
    // SMTPMail: Codeunit "SMTP Mail";
    CompanyInfo: Record "Company Information";
    SalespersonPurchaser: Record "Salesperson/Purchaser";
    PurchEmailId: Text[100];
    UserSetup: Record "User Setup";
    FileName1: Text;
    cominfo: Record "Company Information";
    EnvironmentInformation: Codeunit "Environment Information";
}
