Report 50147 "Payment Advice Mail"
{
    // --AlleZav1.11/020915-- Report Created for sending Mail.
    ProcessingOnly = true;
    ApplicationArea = all;
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem("Vendor Ledger Entry"; "Vendor Ledger Entry")
        {
            DataItemTableView = sorting("Document No.")where("Source Code"=filter('BANKPYMTV'));
            RequestFilterFields = "Source Code", "Document No.", "Posting Date";

            column(ReportForNavId_1000000000;1000000000)
            {
            }
            trigger OnAfterGetRecord()
            begin
                //"Vendor Ledger Entry".COPYFILTERS(VendorLedgerEntry);
                //Vendor := VendorLedgerEntry."Vendor No.";
                //IF a = 0 THEN
                //  ExporttoPDF(VendorLedgerEntry);
                //a += 1;
                PurchEmailId:='';
                FileName:=' # ' + "Document No."; //+"Cust. Ledger Entry"."Customer No.";
                FileName:=DelChr(FileName, '=', '/\-. ');
                //FileName1:=FileName; Alle.SP
                path:='D:/Payment Advice/';
                FileName:=path + FileName + '.PDF';
                FileName1:=FileName; // Alle.SP
                VendorLedgerEntry.Reset;
                VendorLedgerEntry.SetRange("Document No.", "Document No.");
                if VendorLedgerEntry.FindSet then //ssd gurmeet//Report.SaveAsPdf(50139,FileName,VendorLedgerEntry);
                    Clear(EmailId);
                if Vendor.Get("Vendor No.")then begin
                    if Vendor."E-Mail" <> '' then EmailId:=Vendor."E-Mail"; // +';';
                end;
                //ssd gurmeet//while (not Exists(FileName)) do begin
                //ssd gurmeet//  Sleep(100);
                //ssd gurmeet//end;
                Commit;
                if Vendor.Get("Vendor No.")then begin
                    if SalespersonPurchaser.Get(Vendor."Purchaser Code")then;
                    PurchEmailId:=SalespersonPurchaser."E-Mail";
                end;
                UserSetup.Get(UserId);
                // SMTPMailSetup.Get;
                // SMTPMailSetup.TestField("SMTP Server");
                // SMTPMailSetup.TestField("User ID");
                // SMTPMailSetup.TestField("Password Key");
                cominfo.Get;
                //IF cominfo.Name='VYTALS WELLBEING INDIA PRIVATE LIMITED' THEN
                //SMTPMail.CreateMessage('Payment Advice Mail',SMTPMailSetup."User ID",'jitin.behl@vytals.com;hyadav@zavenir.com','Blocked','',TRUE)
                //ssd gurmeet// SMTPMail.CreateMessage('Payment Advice Mail', SMTPMailSetup."User ID", EmailId, 'Payment Advice # ' + "Document No." + ' - ' + Vendor.Name, ' Dear Sir or Madam,<br><br>', true);
                if(PurchEmailId <> '') and (PurchEmailId <> 'gurgaon.scm@zavenir.com')then //ssd gurmeet//SMTPMail.AddCC(PurchEmailId);
                    //ssd gurmeet//SMTPMail.AddCC('msharma@zavenir.com;pkumar@zavenir.com;mkawatra@zavenir.com');
                    //SMTPMail.AddCC('vraj@alletec.com;lmohan@zavenir.com');
                    if UserSetup."E-Mail" <> '' then;
                //SMTPMail.AddCC(UserSetup."E-Mail");
                // SMTPMail.AppendBody('Please find the above mentioned payment advice.<br><br>');
                // SMTPMail.AppendBody('Sincerely, <br>');
                // if COMPANYNAME = 'Zavenir Kluthe India (P) Ltd.' then
                //     SMTPMail.AppendBody('Zavenir Kluthe Team <br><br>')
                // else
                //     SMTPMail.AppendBody('Zavenir Daubert Team <br><br>');
                // SMTPMail.AppendBody('This is an automated email. Replies to this message are not monitored or answered. To contact us, please visit www.zavenir.com or call us at +91 124 4981000.<br><br>');
                //SMTPMail.AddAttachment(FileName);  ALLE_UPG
                //ssd gurmeet// SMTPMail.AddAttachment(FileName, FileName1);  //ALLE_UPG
                //SMTPMail.Send();
                //SLEEP(100);
                //ssd gurmeet// if SMTPMail.TrySend then
                //ssd gurmeet// if Exists(FileName) then
                //ssd gurmeet//  Erase(FileName);
                Commit;
            end;
            trigger OnPreDataItem()
            begin
                SetRange("Posting Date", Today - 1);
            //SETRANGE("Document No.",'KBP/17-18/11/0009');
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
    trigger OnPreReport()
    begin
        a:=0;
        CompanyInfo.Get;
    end;
    var FileName: Text[250];
    // Rep: Report "Production Order Details - WO";
    VendorLedgerEntry: Record "Vendor Ledger Entry";
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
}
