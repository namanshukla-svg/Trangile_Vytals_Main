Report 50244 "Email Payment Request2"
{
    ProcessingOnly = true;
    ApplicationArea = All;

    dataset
    {
        dataitem(Customer; Customer)
        {
            DataItemTableView = sorting("No.");
            PrintOnlyIfDetail = true;
            RequestFilterFields = "No.", "Gen. Bus. Posting Group", "Salesperson Code";

            column(ReportForNavId_1000000000;1000000000)
            {
            }
            dataitem("Cust. Ledger Entry"; "Cust. Ledger Entry")
            {
                DataItemTableView = sorting("Posting Date", "Document No.")where(Remarks=filter(''), Open=const(true));

                column(ReportForNavId_1000000001;1000000001)
                {
                }
                trigger OnAfterGetRecord()
                begin
                    if "Cust. Ledger Entry"."Customer No." <> PrevCustNo then begin
                        //  MESSAGE("Cust. Ledger Entry"."Customer No.");
                        /*MESSAGE('%1bill',Customer."Bill-to Customer No.");
                          IF (Customer."Bill-to Customer No." <> '') AND (Customer."Bill-to Customer No."<> Customer."No.") THEN
                            CustNo := Customer."Bill-to Customer No."
                          ELSE
                            CustNo := Customer."No.";
                        END;
                        */
                        // SMTPMailSetup.Get;
                        if Email then begin
                            //Customer.TESTFIELD("Email for Payment");
                            //IF Customer."Email for Payment" <>'' THEN BEGIN
                            FileName:='Payment Request For Customer No._' + "Cust. Ledger Entry"."Customer No.";
                            FileName:=DelChr(FileName, '=', '/\-. ');
                            path:='C:/Mail/';
                            FileName:=path + FileName + '.PDF';
                            if Cust.Get("Cust. Ledger Entry"."Customer No.")then // Cust.RESET;
                                //  Cust.SETRANGE("No.",CustNo);
                                //  IF Cust.FINDFIRST THEN
                                //ssd gurmeet//Report.SaveAsPdf(50242, FileName, Cust);
                                // MESSAGE(FileName);
                                //ssd gurmeet//while (not Exists(FileName)) do begin
                                //ssd gurmeet//Sleep(1000);
                                //ssd gurmeet//end;
                                Commit;
                            // SMTPMailSetup.Get;
                            // SMTPMailSetup.TestField("SMTP Server");
                            // SMTPMailSetup.TestField("User ID");
                            //ssd gurmeet// SMTPMailSetup.TestField(Password);
                            //ssd gurmeet// SMTPMail.CreateMessage('Notification Mail', SMTPMailSetup."User ID", 'lmohan@zavenir.com', 'Payment Request', ' Dear Sir/Madam,<br><br>', true);
                            //ssd gurmeet//if CCID <> '' then SMTPMail.AddCC(CCID);
                            //ssd gurmeet// SMTPMail.AppendBody('&nbsp;Pl find enclosed herewith a list of invoices that are due for payment.<br><br>');
                            // SMTPMail.AppendBody('Thanks & Regards, <br><br>');
                            // SMTPMail.AppendBody('From ' + CompInfo.Name);
                            //ssd gurmeet//SMTPMail.AddAttachment(FileName, FileName);
                            // SMTPMail.Send();
                            Sleep(1000);
                            //ssd gurmeet//if Exists(FileName) then
                            //ssd gurmeet//    Erase(FileName);
                            Commit;
                        // END;
                        end;
                    end;
                    PrevCustNo:="Cust. Ledger Entry"."Customer No.";
                end;
                trigger OnPreDataItem()
                begin
                    if(Customer."Bill-to Customer No." <> '') and (Customer."Bill-to Customer No." <> Customer."No.")then SetRange("Customer No.", Customer."Bill-to Customer No.")
                    else
                        SetRange("Customer No.", Customer."No.");
                end;
            }
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

                    field(Email; Email)
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
    begin
        CompInfo.Get;
        if not Email then begin
            Clear(PaymentReq);
            PaymentReq.Run;
        end;
    end;
    var PrevCustNo: Code[20];
    Cust: Record Customer;
    CompInfo: Record "Company Information";
    // SMTPMailSetup: Record "SMTP Mail Setup";
    FileName: Text[250];
    path: Text[250];
    // SMTPMail: Codeunit "SMTP Mail";
    Email: Boolean;
    PaymentReq: Report "Payment Request";
    CCID: Text[250];
    CLE: Record "Cust. Ledger Entry";
    CustNo: Code[20];
}
