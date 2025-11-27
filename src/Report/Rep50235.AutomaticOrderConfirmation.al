Report 50235 "Automatic Order Confirmation"
{
    // OC1.0 To send Order Confirmation Mail through Job Queue.
    ProcessingOnly = true;
    UseRequestPage = false;
    //UsageCategory = ReportsandAnalysis;
    ApplicationArea = all;

    dataset
    {
        dataitem("Sales Header"; "Sales Header")
        {
            DataItemTableView = where(Status=filter(Released), "Order Confirmation Mail Send"=filter(false), "Document Type"=filter(Order), "Document Subtype"=filter(Order));
            RequestFilterFields = "No.";

            column(ReportForNavId_1000000000;1000000000)
            {
            }
            trigger OnAfterGetRecord()
            begin
                MailSend("Sales Header");
            end;
            trigger OnPreDataItem()
            begin
                SetFilter("Posting Date", '>=%1', 20230712D);
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
    var Text50010: label ' <br/> ';
    Text59999: label '<html>';
    Text60000: label '<Table>';
    Text60001: label '<TR Border=4>';
    Text60002: label '<TD  width=200 Align=Left>';
    Text60003: label '</TD>';
    Text60004: label '</TR>';
    Text60005: label '</Table>';
    Text60006: label '</html>';
    Text60007: label '<TD  width=500 Align=Left>';
    Text60008: label '<TD  width=100 Align=Center>';
    Text60009: label '<TD Align=Left>';
    Text60010: label '<TD  width=800 Align=right>';
    Text60011: label '<BR>';
    Text60012: label '<B>';
    Text60013: label '</B>';
    Text60014: label '<TD  width=850 Align=right>';
    Text60015: label '<font size="3"> ';
    Text60016: label '</font>';
    Text50022: label 'Mail Sent Successfully !!!!';
    Text50023: label 'This is to advice that the following shipment is being despatched from our factory as follows.';
    Text50024: label '<TD  width=1000 Align=Left>';
    Text50026: label '<TR>';
    Text50027: label '<table border="1" width="70%">';
    Text50028: label '<TH>';
    Text50029: label '</TH>';
    Text50030: label '<td width="20%">';
    Text50031: label '<td width="50%">';
    Text50032: label '<FONT SIZE=6 FACE="Sans Serif">';
    Text50041: label '<TD  width=.5 Align=Center>';
    Text50042: label 'Thank for your valuable order';
    Text50043: label ' (';
    Text50044: label ')';
    SalesLine: Record "Sales Line";
    procedure MailSend(SalesHeader: Record "Sales Header")
    var
        //SSDU SMTPMailSetup: Record "SMTP Mail Setup";
        //SSDU SMTPMail: Codeunit "SMTP Mail";
        UserSetup: Record "User Setup";
        FileName: Text[1024];
        PrevCustNo: Code[20];
        EmailId: Text[100];
        Customer: Record Customer;
        path: Text[1024];
        CompanyInfo: Record "Company Information";
        UserEmail: Text[100];
        RecSalesPerson: Record "Salesperson/Purchaser";
        SalesPersonEmail: Text[100];
        SPName: Text;
        SPPhNo: Code[21];
        SPEmail: Text;
        SHArchive: Record "Sales Header Archive";
        RevisionNo: Text;
        AddCC: Text;
    begin
        FileName:='Order Acknowledgement';
        FileName:=DelChr(FileName, '=', '/\-. ');
        path:='D:\Mail\';
        FileName:=path + FileName + '.PDF';
        SalesHeader.SetRange(SalesHeader."Document Type", SalesHeader."Document Type");
        SalesHeader.SetRange("No.", SalesHeader."No.");
        //SSDU Report.SaveAsPdf(205, FileName, SalesHeader);
        Clear(EmailId);
        Clear(UserEmail);
        //SalesHeader.TESTFIELD("Cust EMail");
        if SalesHeader."Cust EMail" <> '' then EmailId:=SalesHeader."Cust EMail";
        //EmailId := '@zavenir.com;';   //commented for testing
        //SSDU Comment Start
        // while (not Exists(FileName)) do begin
        //     Sleep(100);
        // end;
        //SSDU Comment Start
        Commit;
        UserSetup.Get(UserId);
        UserEmail:=UserSetup."E-Mail";
        if RecSalesPerson.Get(SalesHeader."Salesperson Code")then SalesPersonEmail:=RecSalesPerson."E-Mail";
        SPName:=RecSalesPerson.Name;
        SPPhNo:=RecSalesPerson."Phone No.";
        SPEmail:=RecSalesPerson."E-Mail";
        if(RecSalesPerson."Resp. CCare Exe. Email Id" <> '')then //Alle 22/07/20
 AddCC:=RecSalesPerson."Resp. CCare Exe. Email Id";
        SHArchive.Reset;
        SHArchive.SetRange("Document Type", SalesHeader."Document Type");
        SHArchive.SetRange("No.", SalesHeader."No.");
        if SHArchive.FindLast then begin
            RevisionNo:=' (Rev No.  ' + Format(SHArchive."Version No.") + ')';
        end;
    //SSDU Comment Start
    // SMTPMailSetup.Get; 
    // SMTPMailSetup.TestField("SMTP Server");
    // SMTPMailSetup.TestField("User ID");
    // SMTPMailSetup.TestField(Password);
    // SMTPMail.CreateMessage('Zavenir Order Acknowledgement', SMTPMailSetup."User ID", EmailId, 'Order Acknowledgement Details ' + SalesHeader."No." + RevisionNo
    // + ' Customer PO No. ' + SalesHeader."External Document No.", 'Dear Sir or Madam,<br><br>', true);
    // SMTPMail.AddCC(AddCC);   //Alle 22/07/20
    // //IF UserEmail <> '' THEN
    // //  SMTPMail.AddCC(UserEmail);
    // if SalesPersonEmail <> '' then
    //     SMTPMail.AddCC(SalesPersonEmail);
    // SMTPMail.AddCC('ccare@zavenir.com');
    // SMTPMail.AppendBody('Please find the attached PDF for Order Acknowledgement.<br><br>');
    // SMTPMail.AppendBody(Text60004);
    // SMTPMail.AppendBody(Text60005);
    // SMTPMail.AppendBody(Text60006);
    // SMTPMail.AppendBody(Text60011);
    // SMTPMail.AppendBody(Text59999);
    // SMTPMail.AppendBody(Text60001);
    // SMTPMail.AppendBody(Text60004);
    // SMTPMail.AppendBody(Text60005);
    // SMTPMail.AppendBody(Text60006);
    // SMTPMail.AppendBody(Text60004);
    // SMTPMail.AppendBody(Text60005);
    // SMTPMail.AppendBody(Text60006);
    // SMTPMail.AppendBody(Text60011);
    // SMTPMail.AppendBody(Text50027 + Text50026 + Text50030 + Text60012 + 'Sales Order No.' + Text60013 + Text60003);
    // SMTPMail.AppendBody(Text50030 + Text60012 + 'Customer Name' + Text60013 + Text60003);
    // SMTPMail.AppendBody(Text50030 + Text60012 + 'Description' + Text60013 + Text60003);
    // SMTPMail.AppendBody(Text50030 + Text60012 + 'Description 2' + Text60013 + Text60003);
    // SMTPMail.AppendBody(Text50041 + Text60012 + 'Quantity' + Text60013 + Text60003);
    // SMTPMail.AppendBody(Text60004);
    // SalesLine.Reset;
    // SalesLine.SetRange("Document No.", SalesHeader."No.");
    // if SalesLine.FindFirst then begin
    //     repeat
    //         SMTPMail.AppendBody(Text50026 + Text50030 + Format(SalesHeader."No.") + Text60003);
    //         SMTPMail.AppendBody(Text50030 + Format(SalesHeader."Sell-to Customer Name") + Text60003);
    //         SMTPMail.AppendBody(Text50030 + Format(SalesLine.Description) + Text60003);
    //         SMTPMail.AppendBody(Text50030 + Format(SalesLine."Description 2") + Text60003);
    //         SMTPMail.AppendBody(Text50041 + Format(SalesLine.Quantity) + Text60003);
    //         SMTPMail.AppendBody(Text60004);
    //     until SalesLine.Next = 0;
    // end;
    // SMTPMail.AppendBody(Text60004);
    // SMTPMail.AppendBody(Text60005);
    // SMTPMail.AppendBody(Text60006);
    // SMTPMail.AppendBody(Text60011);
    // SMTPMail.AppendBody(Text60004);
    // SMTPMail.AppendBody(Text60005);
    // SMTPMail.AppendBody(Text60006);
    // SMTPMail.AppendBody(Text60011);
    // SMTPMail.AppendBody(Text60004);
    // SMTPMail.AppendBody(Text60005);
    // SMTPMail.AppendBody(Text60006);
    // SMTPMail.AppendBody(Text60011);
    // SMTPMail.AppendBody(Text59999);
    // SMTPMail.AppendBody(Text60000);
    // SMTPMail.AppendBody(Text60001);
    // SMTPMail.AppendBody(Text60004);
    // SMTPMail.AppendBody(Text60005);
    // SMTPMail.AppendBody(Text60006);
    // SMTPMail.AppendBody(Text60011);
    // SMTPMail.AppendBody('If you need any assistance, please contact : <br><br>');
    // SMTPMail.AppendBody('<table border="1" cellpadding="3" style="border-style: solid; border-width: 1px">');
    // SMTPMail.AppendBody('<tr>');
    // SMTPMail.AppendBody('<td><b><font face="arial" size ="2">Sales Person & Contact No.</font></b></td>');
    // SMTPMail.AppendBody('<td><font face="arial" size ="2">' + Format(SPName) + ' ; ' + Format(SPPhNo) + ' ; ' + Format(SPEmail) + '</font></td>');
    // SMTPMail.AppendBody('</tr>');
    // SMTPMail.AppendBody('<tr>');
    // SMTPMail.AppendBody('<td><b><font face="arial" size ="2">CCare Person & Contact No.</font></b></td>');
    // SMTPMail.AppendBody('<td><font face="arial" size ="2">' + Format(RecSalesPerson."Resp. CCare Exe. Name") + ' ; ' + Format(RecSalesPerson."Resp. CCare Exe. Phone No.") + ' ; ' + Format(RecSalesPerson."Resp. CCare Exe. Email Id") + '</font></td>');
    // SMTPMail.AppendBody('</tr>');
    // SMTPMail.AppendBody('</table>');
    // SMTPMail.AppendBody('Thank you for your business. <br><br>');
    // SMTPMail.AppendBody('With Best Regards, <br><br>' + ' <b>Customer Care Team</b> <br><br>');
    // SMTPMail.AppendBody('This is an automated email. Replies to this message are not monitored or answered.</b> <br><br>');
    // SMTPMail.AddAttachment(FileName, FileName);
    // if SMTPMail.TrySend then begin
    //     //SMTPMail.Send();
    //     SalesHeader."Order Confirmation Mail Send" := true;
    //     SalesHeader.Modify;
    //     Sleep(200);
    //     Commit;
    //end;
    //SSDU Comment End 
    end;
}
