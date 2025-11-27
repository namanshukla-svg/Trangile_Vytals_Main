Report 50243 "Email Payment Request."
{
    ProcessingOnly = true;
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;
    Caption = 'Customer Payment Email Request';

    dataset
    {
        dataitem(Customer; Customer)
        {
            DataItemTableView = sorting("No."); //where("No." = filter('C0357|C0179|C0218|C0102|C0679|C0659|C0576')); //SSD_Remove
            RequestFilterFields = "No.", "Gen. Bus. Posting Group", "Salesperson Code";

            column(ReportForNavId_1000000000;1000000000)
            {
            }
            trigger OnAfterGetRecord()
            begin
                if not Email1 then begin
                    TotAmnt:=0;
                    TotRemAmnt:=0;
                    CLE.Reset;
                    //SSD_Uncomment
                    CLE.SetRange("Customer No.", Customer."No.");
                    //SSD_Uncomment
                    //SSD_Remove
                    //CLE.SetFilter("Customer No.", '%1|%2|%3|%4', 'C0357', 'C0179', 'C0218', 'C0102');
                    //SSD_Remove
                    CLE.SetRange(Open, true);
                    CLE.SetRange("Due Date", 0D, Today);
                    //SSD_Remove
                    // CLE.SetFilter("Document No.", '%1|%2', 'ZDPSI2402511', 'ZDPSI2402496');
                    //SSD_Remove
                    if not CLE.FindFirst then CurrReport.Skip
                    else
                    begin
                        if(CLE.Remarks = '') or ((CLE.Remarks <> '') and (CLE."Check For Email"))then begin
                            Clear(MailList);
                            Clear(CCMailList);
                            Clear(BCCMailList);
                            Clear(ToEmail);
                            Clear(OtherCC);
                            Clear(SalesPersonEmail);
                            Clear(TotAmnt);
                            Clear(TotRemAmnt);
                            Clear(ActualTO);
                            Clear(ActualCC);
                            Cust2.Reset();
                            Cust2.Get(CLE."Customer No.");
                            if Cust2."Email for Payment" <> '' then ToEmail:=Cust2."Email for Payment"
                            else
                                ToEmail:='lmohan@zavenir.com';
                            MailList.AddRange(ToEmail.Split(';'));
                            //SSD_Remove
                            //ActualTO := ToEmail;
                            //SSD_Remove
                            //ssd gurmeet//SMTPMail.CreateMessage('Zavenir Payment Request', SMTPMailSetup."User ID", ToEmail, 'Payment Request-' + Customer.Name, '<br>', true);
                            // SMTPMail.CreateMessage('Zavenir Payment Request',SMTPMailSetup."User ID",'Payment Request-'+Customer.Name,'<br>',TRUE);
                            RecSalesPerson.Reset();
                            if RecSalesPerson.Get("Salesperson Code")then begin
                                OtherCC:=RecSalesPerson."Resp. CCare Exe. Email Id";
                                SalesPersonEmail:=RecSalesPerson."E-Mail";
                            end;
                            if OtherCC <> '' then CCMailList.AddRange(OtherCC.Split(';'));
                            if SalesPersonEmail <> '' then CCMailList.AddRange(SalesPersonEmail.Split(';'));
                            //    IF CCID <> '' THEN
                            //    SMTPMail.AddCC(CCID);
                            CCMailList.Add('lmohan@zavenir.com');
                            CCMailList.Add('ccare@zavenir.com');
                            CCMailList.Add('ithelpdesk@zavenir.com');
                            //SSD_Remove
                            //ActualCC := OtherCC + ';' + SalesPersonEmail + ';' + 'lmohan@zavenir.com' + 'ccare@zavenir.com';
                            //SSD_Remove
                            if EnvironmentInformation.IsProduction()then EmailMessage.Create(MailList, StrSubstNo(Suubject2, Customer.Name), '', true, CCMailList, BCCMailList)
                            else
                            begin
                                Clear(MailList);
                                clear(CCMailList);
                                // MailList.Add('sunil@ssdynamics.co.in');
                                //MailList.Add('hyadav@zavenir.com');
                                MailList.Add('ykuntal@zavenir.com');
                                EmailMessage.Create(MailList, StrSubstNo(Suubject2, Customer.Name), '', true)end;
                            EmailMessage.AppendToBody('<table border="0" cellpadding="1" style="border-style: none; border-width: 0px">');
                            EmailMessage.AppendToBody('<tr>');
                            EmailMessage.AppendToBody('<td><b><font face="arial" size ="2">Date ' + Format(Today) + '</font></b></td>');
                            EmailMessage.AppendToBody('<td><b><font face="arial" size ="4">' + ' ' + '</font></b></td>');
                            EmailMessage.AppendToBody('<td><b><font face="arial" size ="4">' + ' ' + '</font></b></td>');
                            EmailMessage.AppendToBody('<td><b><font face="arial" size ="4">' + ' ' + '</font></b></td>');
                            EmailMessage.AppendToBody('<td><b><font face="arial" size ="4">' + ' ' + '</font></b></td>');
                            EmailMessage.AppendToBody('<td><b><font face="arial" size ="4">' + ' ' + '</font></b></td>');
                            EmailMessage.AppendToBody('<td><b><font face="arial" size ="4">' + ' ' + '</font></b></td>');
                            EmailMessage.AppendToBody('</tr>');
                            EmailMessage.AppendToBody('<tr>');
                            EmailMessage.AppendToBody('</tr>');
                            EmailMessage.AppendToBody('<tr>');
                            EmailMessage.AppendToBody('</tr>');
                            EmailMessage.AppendToBody('<tr>');
                            EmailMessage.AppendToBody('</tr>');
                            EmailMessage.AppendToBody('<tr>');
                            EmailMessage.AppendToBody('<td><b><font face="arial" size ="2">Customer Code</font></b></td>');
                            EmailMessage.AppendToBody('<td><font face="arial" size ="2">' + '&nbsp;' + ':' + '&nbsp;&nbsp;&nbsp;&nbsp;' + Format(Cust2."No.") + '</font></td>');
                            EmailMessage.AppendToBody('<td><b><font face="arial" size ="4">' + ' ' + '</font></b></td>');
                            EmailMessage.AppendToBody('<td><b><font face="arial" size ="4">' + ' ' + '</font></b></td>');
                            EmailMessage.AppendToBody('<td><b><font face="arial" size ="4">' + ' ' + '</font></b></td>');
                            EmailMessage.AppendToBody('<td><b><font face="arial" size ="4">' + ' ' + '</font></b></td>');
                            EmailMessage.AppendToBody('<td><b><font face="arial" size ="4">' + ' ' + '</font></b></td>');
                            EmailMessage.AppendToBody('</tr>');
                            EmailMessage.AppendToBody('<tr>');
                            EmailMessage.AppendToBody('<td><b><font face="arial" size ="2">Customer Name</font></b></td>');
                            EmailMessage.AppendToBody('<td><font face="arial" size ="2">' + '&nbsp;' + ':' + '&nbsp;&nbsp;&nbsp;&nbsp;' + Format(Cust2.Name) + '</font></td>');
                            EmailMessage.AppendToBody('<td><b><font face="arial" size ="4">' + ' ' + '</font></b></td>');
                            EmailMessage.AppendToBody('<td><b><font face="arial" size ="4">' + ' ' + '</font></b></td>');
                            EmailMessage.AppendToBody('<td><b><font face="arial" size ="4">' + ' ' + '</font></b></td>');
                            EmailMessage.AppendToBody('<td><b><font face="arial" size ="4">' + ' ' + '</font></b></td>');
                            EmailMessage.AppendToBody('<td><b><font face="arial" size ="4">' + ' ' + '</font></b></td>');
                            EmailMessage.AppendToBody('</tr>');
                            EmailMessage.AppendToBody('<tr>');
                            EmailMessage.AppendToBody('<td><b><font face="arial" size ="2">Customer Assigned Vendor Code</font></b></td>');
                            EmailMessage.AppendToBody('<td><font face="arial" size ="2">' + '&nbsp;' + ':' + '&nbsp;&nbsp;&nbsp;&nbsp;' + Format(Cust2."Our Account No.") + '</font></td>');
                            EmailMessage.AppendToBody('<td><b><font face="arial" size ="4">' + ' ' + '</font></b></td>');
                            EmailMessage.AppendToBody('<td><b><font face="arial" size ="4">' + ' ' + '</font></b></td>');
                            EmailMessage.AppendToBody('<td><b><font face="arial" size ="4">' + ' ' + '</font></b></td>');
                            EmailMessage.AppendToBody('<td><b><font face="arial" size ="4">' + ' ' + '</font></b></td>');
                            EmailMessage.AppendToBody('<td><b><font face="arial" size ="4">' + ' ' + '</font></b></td>');
                            EmailMessage.AppendToBody('</tr>');
                            EmailMessage.AppendToBody('<tr>');
                            EmailMessage.AppendToBody('<td><b><font face="arial" size ="2">Email</font></b></td>');
                            EmailMessage.AppendToBody('<td><font face="arial" size ="2">' + '&nbsp;' + ':' + '&nbsp;&nbsp;&nbsp;&nbsp;' + Format(Cust2."Email for Payment") + '</font></td>');
                            EmailMessage.AppendToBody('<td><b><font face="arial" size ="4">' + ' ' + '</font></b></td>');
                            EmailMessage.AppendToBody('<td><b><font face="arial" size ="4">' + ' ' + '</font></b></td>');
                            EmailMessage.AppendToBody('<td><b><font face="arial" size ="4">' + ' ' + '</font></b></td>');
                            EmailMessage.AppendToBody('<td><b><font face="arial" size ="4">' + ' ' + '</font></b></td>');
                            EmailMessage.AppendToBody('<td><b><font face="arial" size ="4">' + ' ' + '</font></b></td>');
                            EmailMessage.AppendToBody('</tr>');
                            EmailMessage.AppendToBody('<tr>');
                            EmailMessage.AppendToBody('<td><b><font face="arial" size ="2">Contact Person</font></b></td>');
                            EmailMessage.AppendToBody('<td><font face="arial" size ="2">' + '&nbsp;' + ':' + '&nbsp;&nbsp;&nbsp;&nbsp;' + Format(Cust2."CTC for Payment") + '</font></td>');
                            EmailMessage.AppendToBody('<td><b><font face="arial" size ="4">' + ' ' + '</font></b></td>');
                            EmailMessage.AppendToBody('<td><b><font face="arial" size ="4">' + ' ' + '</font></b></td>');
                            EmailMessage.AppendToBody('<td><b><font face="arial" size ="4">' + ' ' + '</font></b></td>');
                            EmailMessage.AppendToBody('<td><b><font face="arial" size ="4">' + ' ' + '</font></b></td>');
                            EmailMessage.AppendToBody('<td><b><font face="arial" size ="4">' + ' ' + '</font></b></td>');
                            EmailMessage.AppendToBody('</tr>');
                            EmailMessage.AppendToBody('</table>');
                            EmailMessage.AppendToBody('<br>');
                            EmailMessage.AppendToBody('<font face="arial" size ="2">&nbsp;Dear Sir or Madam, </font><br><br>');
                            EmailMessage.AppendToBody('<font face="arial" size ="2">&nbsp;Below is the details of our dues for which payments were not received by us. </font><br><br>');
                            EmailMessage.AppendToBody('<font face="arial" size ="2">&nbsp;We request you to take an immediate action to release the same and oblige.</font><br><br>');
                            //EmailMessage.AppendToBody('<br><br>');
                            EmailMessage.AppendToBody('<table border="1" cellpadding="3" style="border-style: solid; border-width: 1px">');
                            EmailMessage.AppendToBody('<tr style = "background-color:Black;color:White;">');
                            EmailMessage.AppendToBody('<td><b><font face="arial" size ="2">Invoice No.</font></b></td>');
                            EmailMessage.AppendToBody('<td><b><font face="arial" size ="2">Invoice Date</font></b></td>');
                            EmailMessage.AppendToBody('<td><b><font face="arial" size ="2">Delivery Date</font></b></td>');
                            EmailMessage.AppendToBody('<td><b><font face="arial" size ="2">Due Date</font></b></td>');
                            EmailMessage.AppendToBody('<td><b><font face="arial" size ="2">Invoice Amount</font></b></td>');
                            EmailMessage.AppendToBody('<td><b><font face="arial" size ="2">Due Amount</font></b></td>');
                            EmailMessage.AppendToBody('<td><b><font face="arial" size ="2">No. of Days Overdue Amt.</font></b></td>');
                            EmailMessage.AppendToBody('<td><b><font face="arial" size ="2">PO No.</font></b></td>');
                            EmailMessage.AppendToBody('</tr>');
                            repeat ActDelDate:=0D;
                                SalesInvoiceHeader.Reset;
                                if SalesInvoiceHeader.Get(CLE."Document No.")then ActDelDate:=SalesInvoiceHeader."Actual Delivery Date";
                                PaymentTerms.Reset();
                                if PaymentTerms.Get(Customer."Payment Terms Code")then;
                                Clear(DueDate);
                                if Customer."Gen. Bus. Posting Group" = 'DIRECT' then begin
                                    if ActDelDate = 0D then begin
                                        if CLE."Document Type" = CLE."document type"::Invoice then begin
                                            CurrReport.Skip;
                                        end
                                        else
                                            DueDate:=CLE."Posting Date";
                                    end
                                    else
                                        DueDate:=CalcDate(PaymentTerms."Due Date Calculation", ActDelDate);
                                end
                                else
                                    DueDate:=CLE."Due Date";
                                if DueDate > Today then CurrReport.Skip;
                                EmailMessage.AppendToBody('<tr>');
                                EmailMessage.AppendToBody('<td align="right"><font face="arial" size ="2">' + Format(CLE."Document No.") + '</td>');
                                EmailMessage.AppendToBody('<td align="right"><font face="arial" size ="2">' + Format(CLE."Posting Date") + '</font></td>');
                                EmailMessage.AppendToBody('<td align="right"><font face="arial" size ="2">' + Format(ActDelDate) + '</font></td>');
                                EmailMessage.AppendToBody('<td align="right"><font face="arial" size ="2">' + Format(DueDate) + '</font></td>');
                                CLE.CalcFields(Amount);
                                EmailMessage.AppendToBody('<td align="right"><font face="arial" size ="2">' + Format(CLE.Amount) + '</font></td>');
                                CLE.CalcFields("Remaining Amount");
                                EmailMessage.AppendToBody('<td align="right"><font face="arial" size ="2">' + Format(CLE."Remaining Amount") + '</font></td>');
                                EmailMessage.AppendToBody('<td align="center";style = "background-color:White;color:Red;"><font face="arial" size ="2">' + Format(Today - DueDate) + '</font></td>');
                                EmailMessage.AppendToBody('<td align="right"><font face="arial" size ="2">' + Format(CLE."External Document No.") + '</td>');
                                EmailMessage.AppendToBody('</tr>');
                                // END;
                                // *****************
                                CLE.CalcFields("Remaining Amount");
                                TotAmnt+=CLE.Amount;
                                TotRemAmnt+=CLE."Remaining Amount";
                            // *****************
                            until CLE.Next = 0;
                            EmailMessage.AppendToBody('<tr>');
                            EmailMessage.AppendToBody('<td><b><font face="arial" size ="2">' + ' ' + '</b></td>');
                            EmailMessage.AppendToBody('<td><b><font face="arial" size ="2">Total</font></b></td>');
                            EmailMessage.AppendToBody('<td><b><font face="arial" size ="2">' + ' ' + '</font></b></td>');
                            EmailMessage.AppendToBody('<td><b><font face="arial" size ="2">' + ' ' + '</font></b></td>');
                            EmailMessage.AppendToBody('<td align="right"><b><font face="arial" size ="2">' + Format(TotAmnt) + '</font></b></td>');
                            EmailMessage.AppendToBody('<td align="right"><b><font face="arial" size ="2">' + Format(TotRemAmnt) + '</font></b></td>');
                            EmailMessage.AppendToBody('<td><b><font face="arial" size ="2">' + ' ' + '</font></b></td>');
                            EmailMessage.AppendToBody('</tr>');
                            EmailMessage.AppendToBody('<tr>');
                            EmailMessage.AppendToBody('</tr>');
                            EmailMessage.AppendToBody('</table>');
                            EmailMessage.AppendToBody('</br></br></br></br>');
                            EmailMessage.AppendToBody('<font face="arial" size ="4">');
                            EmailMessage.AppendToBody('NOTE: Due amount showing with negative mark (-) may be unadjusted Credit Note issued by us or Advance Payment received from you. Please adjust these amounts in your next payment.</b><br><br>');
                            EmailMessage.AppendToBody('<b>Thank you for your attention!!</b></font><br><br>');
                            EmailMessage.AppendToBody('</br></br>');
                            EmailMessage.AppendToBody('</br></br>');
                            EmailMessage.AppendToBody('</br></br>');
                            EmailMessage.AppendToBody('<font face="arial" size ="2">');
                            EmailMessage.AppendToBody('This document is system generated by ' + CompInfo.Name + ' and is valid without a signature. for any queries regarding the same. please contact us.</b><br><br>');
                            EmailMessage.AppendToBody('Web www.zavenir.com </b> <br><br>');
                            //SSD_Remove
                            // EmailMessage.AppendToBody(StrSubstNo(ActualID, ActualTO, ActualCC));
                            //SSD_Remove
                            Clear(CustNo);
                            Clear(FileName);
                            CustNo:=Customer."No.";
                            FileName:='Payment Request_' + CustNo + '_' + Customer.Name;
                            FileName:=DelChr(FileName, '=', '/\-. ');
                            //path := 'C:/Mail/';
                            //FileName := path + FileName + '.PDF';
                            Clear(TempBlob);
                            Clear(Base64Txt);
                            Clear(RecRef);
                            Cust.Reset;
                            Cust.SetRange("No.", CustNo);
                            if Cust.FindFirst then begin
                                //Report.SaveAsPdf(50242, FileName, Cust);
                                TempBlob.CreateOutStream(OutStream);
                                Cust.SetRecFilter();
                                RecRef.GetTable(Cust);
                                RecRef.SetRecFilter();
                                if Report.SaveAs(Report::"Payment Request", '', ReportFormat::Pdf, OutStream, RecRef)then begin
                                    TempBlob.CreateInStream(InStream);
                                    Base64Txt:=Base64Convert.ToBase64(InStream, true);
                                    EmailMessage.AddAttachment(FileName + '.pdf', 'application/pdf', Base64Txt);
                                    Email.Enqueue(EmailMessage);
                                end;
                            end;
                            // Commit();
                            Customer."Payment Advise Mail Sent":=true;
                            Customer.Modify;
                            Sleep(200);
                        end;
                    end;
                end;
                Commit;
                Sleep(500);
            end;
        }
    }
    requestpage
    {
        layout
        {
            area(content)
            {
                group(Options)
                {
                    Caption = 'Options';

                    field(Email; Email1)
                    {
                        ApplicationArea = Basic;
                        Caption = 'Send Mail';
                    }
                    field(CCID; CCID)
                    {
                        ApplicationArea = Basic;
                        Caption = 'CC Email ID''s';
                    }
                }
            }
        }
        actions
        {
        }
    }
    labels
    {
    }
    trigger OnPreReport()
    var
        Cust: Record Customer;
    begin
        CompInfo.Get;
        if Email1 then begin
            Clear(PaymentReq);
            PaymentReq.Run;
        end;
        if not Email1 then begin
            Cust.SetRange("Payment Advise Mail Sent", true);
            Cust.ModifyAll("Payment Advise Mail Sent", false);
        end;
    end;
    var PrevCustNo: Code[20];
    Cust: Record Customer;
    CompInfo: Record "Company Information";
    // SMTPMailSetup: Record "SMTP Mail Setup";
    FileName: Text[250];
    path: Text[250];
    // SMTPMail: Codeunit "SMTP Mail";
    Email1: Boolean;
    PaymentReq: Report "Payment Request";
    CCID: Text[250];
    CLE: Record "Cust. Ledger Entry";
    CustNo: Code[20];
    RecSalesPerson: Record "Salesperson/Purchaser";
    SalesPersonEmail: Text[150];
    OtherCC: Text[150];
    SalesInvoiceHeader: Record "Sales Invoice Header";
    ActDelDate: Date;
    DueDate: Date;
    PaymentTerms: Record "Payment Terms";
    TotAmnt: Decimal;
    TotRemAmnt: Decimal;
    Cust2: Record Customer;
    ToEmail: Text[250];
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
    Suubject2: Label 'Payment Request- %1';
    PaymentAdvice: Report "Payment Advice";
    RecRef: RecordRef;
    EnvironmentInformation: Codeunit "Environment Information";
    ActualID: Label 'Atual Mail - TO Mail - %1, CC Mail - %2';
    ActualTO: Text;
    ActualCC: Text;
}
