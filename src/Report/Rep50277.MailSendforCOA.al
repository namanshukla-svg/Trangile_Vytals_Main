Report 50277 "Mail Send for COA"
{
    Permissions = TableData "Sales Invoice Header" = rm;
    ProcessingOnly = true;

    dataset
    {
        dataitem("Sales Invoice Header"; "Sales Invoice Header")
        {
            DataItemTableView = where("Mail Send Dispatch Detail" = filter(false), "LR/RR No." = filter(<> ''), "Send Mail With COA" = const(false));

            column(ReportForNavId_1000000000; 1000000000)
            {
            }
            trigger OnPreDataItem()
            begin
                SalesReceivablesSetup.Get();
                SetRange("Mail Send Dispatch Detail", false);
                SetFilter("LR/RR No.", '<>%1', '');
                SetRange("Send Mail With COA", false);
                if SalesReceivablesSetup."COA Start Date" = 0D then
                    SetFilter("Posting Date", '>%1', 20230825D)
                else
                    SetFilter("Posting Date", '>%1', SalesReceivablesSetup."COA Start Date");
                //Check before Production
                //SetRange("Posting Date", 20230701D, 20230727D);
            end;

            trigger OnAfterGetRecord()
            var
                Base64Txt: Text;
            begin
                //FOR COA Approved
                Clear(SalesInvoiceHeader);
                SalesInvoiceHeader.Reset;
                SalesInvoiceHeader.SetCurrentkey("Sell-to Customer No.", "LR/RR No.", "No.");
                SalesInvoiceHeader.SetRange("Sell-to Customer No.", "Sales Invoice Header"."Sell-to Customer No.");
                SalesInvoiceHeader.SetRange("Mail Send Dispatch Detail", false);
                SalesInvoiceHeader.SetRange("LR/RR No.", "LR/RR No.");
                SalesInvoiceHeader.SetRange("Send Mail With COA", false);
                if SalesReceivablesSetup."COA Start Date" = 0D then
                    SalesInvoiceHeader.SetFilter("Posting Date", '>%1', 20230825D)
                else
                    SalesInvoiceHeader.SetFilter("Posting Date", '>%1', SalesReceivablesSetup."COA Start Date"); //Check before production
                //SalesInvoiceHeader.SetRange("Posting Date", 20230701D, 20230727D);
                if SalesInvoiceHeader.FindSet then begin
                    TempSalesInvHeader.DeleteAll;
                    Clear(EmailId);
                    Clear(TechnicalEmailid);
                    Clear(MailList);
                    Clear(CCMailList);
                    Clear(BCCMailList);
                    Clear(Email);
                    Clear(EmailMessage);
                    Clear(ActualTO);
                    Clear(ActualCC);
                    Clear(SPName);
                    Clear(SPPhNo);
                    Clear(SPEmail);
                    if Customer.Get("Sell-to Customer No.") then;
                    if SalesHeader.Get(SalesHeader."document type"::Order, SalesInvoiceHeader."Order/Scd. No.") then begin
                        if SalesHeader."Cust EMail" <> '' then EmailId := SalesHeader."Cust EMail";
                        if Customer."E-mail ID for Technical/QC" <> '' then TechnicalEmailid := Customer."E-mail ID for Technical/QC";
                    end;
                    //SMTPMail.CreateMessage('Zavenir Dispatch Information', SMTPMailSetup."User ID", EmailId, 'Dispatch Details Vide Way Bill# ' + SalesInvoiceHeader."LR/RR No." + ' - ' + Customer.Name, '<br>', true);
                    if TechnicalEmailid <> '' then CCMailList.AddRange(TechnicalEmailid.Split(';'));
                    MailList.AddRange(EmailId.Split(';'));
                    BCCMailList.Add('ykuntal@zavenir.com');
                    SalesPerson.Reset();
                    if SalesPerson.Get(SalesInvoiceHeader."Salesperson Code") then begin
                        SPName := SalesPerson.Name;
                        SPPhNo := SalesPerson."Phone No.";
                        SPEmail := SalesPerson."E-Mail";
                    end;
                    if SPEmail <> '' then CCMailList.AddRange(SPEmail.Split(';'));
                    if SalesPerson."Resp. CCare Exe. Email Id" <> '' then CCMailList.AddRange(SalesPerson."Resp. CCare Exe. Email Id".Split(';'));
                    //SSD_Remove
                    //ActualTO := EmailId;
                    //ActualCC := TechnicalEmailid;
                    //SSD_Remove
                    if EnvironmentInformation.IsProduction() then
                        EmailMessage.Create(MailList, StrSubstNo(SubjectMSG, SalesInvoiceHeader."LR/RR No.", Customer.Name), '', true, CCMailList, BCCMailList)
                    else begin
                        Clear(MailList);
                        Clear(CCMailList);
                        Clear(BCCMailList);
                        //MailList.Add('sunil@ssdynamics.co.in');
                        //MailList.Add('hyadav@zavenir.com');
                        MailList.Add('ykuntal@zavenir.com');
                        EmailMessage.Create(MailList, StrSubstNo(SubjectMSG, SalesInvoiceHeader."LR/RR No.", Customer.Name), '', true);
                    end;
                    EmailMessage.AppendToBody('<font face="arial" size ="4">');
                    EmailMessage.AppendToBody('<center><b>Dispatch Details Vide Way Bill # ' + SalesInvoiceHeader."LR/RR No." + '</b></center></font><br><br>');
                    EmailMessage.AppendToBody('<font face="arial" size ="2">');
                    EmailMessage.AppendToBody('Dear Sir or Madam,<br><br>');
                    EmailMessage.AppendToBody('Please find below the dispatch details and related COAs attached for your kind reference:<br><br></font>');
                    EmailMessage.AppendToBody('<table border="1" cellpadding="3" style="border-style: solid; border-width: 1px">');
                    EmailMessage.AppendToBody('<tr>');
                    EmailMessage.AppendToBody('<td><b><font face="arial" size ="2">Sales Invoice No.</font></b></td>');
                    EmailMessage.AppendToBody('<td><b><font face="arial" size ="2">Invoice Date</font></b></td>');
                    EmailMessage.AppendToBody('<td><b><font face="arial" size ="2">Invoice Amount</font></b></td>');
                    EmailMessage.AppendToBody('<td><b><font face="arial" size ="2">Customer PO No.</font></b></td>');
                    EmailMessage.AppendToBody('<td><b><font face="arial" size ="2">Sales Order No.</font></b></td>');
                    EmailMessage.AppendToBody('</tr>');
                    i := 0;
                    Clear(FileName);
                    FileName := 'COA-' + Format(i);
                    // path := 'C:\Mail\';
                    // FileName := path + FileName + '.PDF';
                    // if Exists(FileName) then
                    //     Erase(FileName);
                    // Sleep(1000);
                    i := 0;
                    if SalesInvoiceHeader.FindSet then
                        repeat
                            Clear(FileName);
                            Clear(InvNoStr); //SSD
                            Clear(CustAss_AcNo); //SSD
                            InvNoStr := CopyStr(SalesInvoiceHeader."No.", StrLen(SalesInvoiceHeader."No.") - 4, 5);
                            if Cust.Get("Sell-to Customer No.") then CustAss_AcNo := Cust."Our Account No.";
                            ValueEntry.Reset;
                            ValueEntry.SetRange("Document No.", SalesInvoiceHeader."No.");
                            ValueEntry.SetRange(Adjustment, false);
                            if ValueEntry.FindFirst then begin
                                ILE.Reset;
                                ILE.SetRange("Entry No.", ValueEntry."Item Ledger Entry No.");
                                if ILE.FindFirst then begin
                                    PostedQtyHdr.Reset;
                                    PostedQtyHdr.SetRange("Lot No.", ILE."Lot No.");
                                    PostedQtyHdr.SetRange(Approved, true);
                                    if PostedQtyHdr.FindSet then begin
                                        //SSD_DetailedGST
                                        Clear(GSTAmt);
                                        DetailedGSTLedgerEntry.Reset();
                                        DetailedGSTLedgerEntry.SetCurrentKey("Document No.");
                                        DetailedGSTLedgerEntry.SetRange("Document No.", SalesInvoiceHeader."No.");
                                        if DetailedGSTLedgerEntry.FindSet() then begin
                                            DetailedGSTLedgerEntry.CalcSums("GST Amount");
                                            GSTAmt := DetailedGSTLedgerEntry."GST Amount";
                                        end;
                                        //SSD_DetailedGST
                                        SalesInvoiceHeader.CalcFields(Amount); //SSD_Amount to Customer
                                        EmailMessage.AppendToBody('<tr>');
                                        EmailMessage.AppendToBody('<td widht="20"><font face="arial" size ="2">' + Format(InvNoStr) + '</font></td>');
                                        EmailMessage.AppendToBody('<td widht="20"><font face="arial" size ="2">' + Format(SalesInvoiceHeader."Posting Date") + '</font></td>');
                                        EmailMessage.AppendToBody('<td widht="20"><font face="arial" size ="2">' + Format(SalesInvoiceHeader.Amount - GSTAmt) + '</font></td>'); //SSD_Amount to Customer
                                        EmailMessage.AppendToBody('<td widht="20"><font face="arial" size ="2">' + Format(SalesInvoiceHeader."External Document No.") + '</font></td>');
                                        EmailMessage.AppendToBody('<td widht="20"><font face="arial" size ="2">' + Format(SalesInvoiceHeader."Order/Scd. No.") + '</font></td>');
                                        EmailMessage.AppendToBody('</tr>');
                                    end;
                                end;
                            end;
                        until SalesInvoiceHeader.Next = 0;
                    EmailMessage.AppendToBody('</table>');
                    EmailMessage.AppendToBody('<br><br>');
                    EmailMessage.AppendToBody('<table border="1" cellpadding="3" style="border-style: solid; border-width: 1px">');
                    EmailMessage.AppendToBody('<tr>');
                    EmailMessage.AppendToBody('<td><b><font face="arial" size ="2">Consignor with Vendor Code</font></b></td>');
                    if CustAss_AcNo <> '' then
                        EmailMessage.AppendToBody('<td>' + '<font face="arial" size ="2">' + CompanyInfo.Name + '(' + CustAss_AcNo + ')</font>' + '</td>')
                    else
                        EmailMessage.AppendToBody('<td>' + '<font face="arial" size ="2">' + CompanyInfo.Name + '</font>' + '</td>');
                    EmailMessage.AppendToBody('</tr>');
                    EmailMessage.AppendToBody('<tr>');
                    EmailMessage.AppendToBody('<td><b><font face="arial" size ="2">Sell to Customer Code & Name</font></b></td>');
                    EmailMessage.AppendToBody('<td><font face="arial" size ="2">' + Format(SalesInvoiceHeader."Sell-to Customer No.") + '-' + Format(SalesInvoiceHeader."Sell-to Customer Name") + '</font></td>');
                    EmailMessage.AppendToBody('</tr>');
                    EmailMessage.AppendToBody('<tr>');
                    EmailMessage.AppendToBody('<td><b><font face="arial" size ="2">Bill To Customer Code & Name</font></b></td>');
                    EmailMessage.AppendToBody('<td><font face="arial" size ="2">' + Format(SalesInvoiceHeader."Bill-to Customer No.") + '-' + Format(SalesInvoiceHeader."Bill-to Name") + '</font></td>');
                    EmailMessage.AppendToBody('</tr>');
                    EmailMessage.AppendToBody('<tr>');
                    EmailMessage.AppendToBody('<td><b><font face="arial" size ="2">Sales Person & Contact No.</font></b></td>');
                    EmailMessage.AppendToBody('<td><font face="arial" size ="2">' + Format(SPName) + ' ; ' + Format(SPPhNo) + ' ; ' + Format(SPEmail) + '</font></td>');
                    EmailMessage.AppendToBody('</tr>');
                    EmailMessage.AppendToBody('<tr>');
                    EmailMessage.AppendToBody('<td><b><font face="arial" size ="2">CCare Person & Contact No.</font></b></td>');
                    EmailMessage.AppendToBody('<td><font face="arial" size ="2">' + Format(SalesPerson."Resp. CCare Exe. Name") + ' ; ' + Format(SalesPerson."Resp. CCare Exe. Phone No.") + ' ; ' + Format(SalesPerson."Resp. CCare Exe. Email Id") + '</font></td>');
                    EmailMessage.AppendToBody('</tr>');
                    EmailMessage.AppendToBody('</table>');
                    EmailMessage.AppendToBody('<br><br>');
                    EmailMessage.AppendToBody('<table border="1" cellpadding="3" style="border-style: solid; border-width: 1px">');
                    EmailMessage.AppendToBody('<tr>');
                    EmailMessage.AppendToBody('<td><b><font face="arial" size ="2">Sr. No.</font></td>');
                    EmailMessage.AppendToBody('<td><b><font face="arial" size ="2">Description of Goods</font></b></td>');
                    EmailMessage.AppendToBody('<td><b><font face="arial" size ="2">Customer Item Code</font></b></td>');
                    EmailMessage.AppendToBody('<td><b><font face="arial" size ="2">SO Quantity</font></b></td>');
                    EmailMessage.AppendToBody('<td><b><font face="arial" size ="2">Qty. Dispatched</font></b></td>');
                    EmailMessage.AppendToBody('<td><b><font face="arial" size ="2">Short Closed Qty.</font></b></td>');
                    EmailMessage.AppendToBody('<td><b>Outstanding Qty.</b></td>');
                    EmailMessage.AppendToBody('</tr>');
                    j := 1;
                    if SalesInvoiceHeader.FindSet then
                        repeat
                            ValueEntry.Reset;
                            ValueEntry.SetRange("Document No.", SalesInvoiceHeader."No.");
                            ValueEntry.SetRange(Adjustment, false);
                            if ValueEntry.FindFirst then begin
                                ILE.Reset;
                                ILE.SetRange("Entry No.", ValueEntry."Item Ledger Entry No.");
                                if ILE.FindFirst then begin
                                    PostedQtyHdr.Reset;
                                    PostedQtyHdr.SetRange("Lot No.", ILE."Lot No.");
                                    PostedQtyHdr.SetRange(Approved, true);
                                    if PostedQtyHdr.FindSet then begin
                                        InvNoStr := '';
                                        InvNoStr := CopyStr(SalesInvoiceHeader."No.", StrLen(SalesInvoiceHeader."No.") - 4, 5);
                                        EmailMessage.AppendToBody('<tr>');
                                        EmailMessage.AppendToBody('<td colspan="6"><b><font face="arial" size ="2">INVOICE NO.' + Format(InvNoStr) + '</b></td>');
                                        EmailMessage.AppendToBody('</tr>');
                                        SalesInvoiceLine.Reset;
                                        SalesInvoiceLine.SetRange("Document No.", SalesInvoiceHeader."No.");
                                        SalesInvoiceLine.SetFilter(Type, '%1', 2);
                                        if SalesInvoiceLine.FindSet then
                                            repeat
                                                if SalesLine.Get(SalesLine."document type"::Order, SalesInvoiceLine."SSD Order No.", SalesInvoiceLine."SSD Order Line No.") then;
                                                EmailMessage.AppendToBody('<tr>');
                                                EmailMessage.AppendToBody('<td><font face="arial" size ="2">' + Format(j) + '</td>');
                                                EmailMessage.AppendToBody('<td><font face="arial" size ="2">' + Format(SalesInvoiceLine."No.") + '-' + Format(SalesInvoiceLine.Description) + ' ' + Format(SalesInvoiceLine."Description 2") + '</font></td>');
                                                EmailMessage.AppendToBody('<td><font face="arial" size ="2">' + Format(SalesInvoiceLine."Item Reference No.") + '</font></td>');
                                                EmailMessage.AppendToBody('<td><font face="arial" size ="2">' + Format(SalesLine.Quantity) + '</font></td>');
                                                EmailMessage.AppendToBody('<td><font face="arial" size ="2">' + Format(SalesInvoiceLine.Quantity) + ' ' + Format(SalesInvoiceLine."Unit of Measure Code") + '</font></td>');
                                                EmailMessage.AppendToBody('<td><font face="arial" size ="2">' + Format(SalesLine."Short Close Qty.") + '</font></td>');
                                                EmailMessage.AppendToBody('<td><font face="arial" size ="2">' + Format(SalesLine."Outstanding Quantity") + '</font></td>');
                                                EmailMessage.AppendToBody('</tr>');
                                                j += 1;
                                            until SalesInvoiceLine.Next = 0;
                                    end;
                                end;
                            end;
                        until SalesInvoiceHeader.Next = 0;
                    EmailMessage.AppendToBody('</table>');
                    EmailMessage.AppendToBody('</br></br>');
                    Cont1Email := '';
                    Cont1Mobile := '';
                    Cont1Name := '';
                    Cont2Email := '';
                    Cont2Mobile := '';
                    Cont2Name := '';
                    if Customer1.Get("Sell-to Customer No.") then;
                    ActualTransporterContDetail.Reset;
                    ActualTransporterContDetail.SetRange("Shipping Agent Code", SalesInvoiceHeader."Actual Shipping Agent code");
                    ActualTransporterContDetail.SetRange("Post Code", Customer1."Post Code");
                    if ActualTransporterContDetail.FindFirst then Cont1Email := ActualTransporterContDetail."Contact1 Email";
                    Cont1Mobile := ActualTransporterContDetail."Contact1 Mob";
                    Cont1Name := ActualTransporterContDetail."Contact1 Name";
                    Cont2Email := ActualTransporterContDetail."Contact2 Email";
                    Cont2Mobile := ActualTransporterContDetail."Contact2 Mob";
                    Cont2Name := ActualTransporterContDetail."Contact2 Name";
                    if ShippingAgent.Get(SalesInvoiceHeader."Actual Shipping Agent code") then begin
                        TrackingSite := ShippingAgent."Internet Address";
                        Cont3Name := ShippingAgent."Contact3 Name";
                        Cont3Mobile := ShippingAgent."Contact3 Mobile";
                        Cont3Email := ShippingAgent."Contact3 Email";
                    end;
                    Clear(FileName);
                    if SalesInvoiceHeader.FindSet then
                        repeat
                            ValueEntry.Reset;
                            ValueEntry.SetRange("Document No.", SalesInvoiceHeader."No.");
                            ValueEntry.SetRange(Adjustment, false);
                            if ValueEntry.FindFirst then begin
                                ILE.Reset;
                                ILE.SetRange("Entry No.", ValueEntry."Item Ledger Entry No.");
                                if ILE.FindFirst then begin
                                    PostedQtyHdr.Reset;
                                    PostedQtyHdr.SetRange("Lot No.", ILE."Lot No.");
                                    PostedQtyHdr.SetRange(Approved, true);
                                    if PostedQtyHdr.FindSet then begin
                                        ValueEntry1.Reset;
                                        ValueEntry1.SetCurrentkey("Document No.", "Posting Date");
                                        ValueEntry1.SetRange(ValueEntry1."Document No.", SalesInvoiceHeader."No.");
                                        Clear(QLTCertificate);
                                        QLTCertificate.SetTableview(ValueEntry1);
                                        QLTCertificate.SalesInvoice(SalesInvoiceHeader."No.", SalesInvoiceHeader."Posting Date", SalesInvoiceHeader."External Document No.", SalesInvoiceHeader."Bill-to Name", SalesInvoiceHeader."Ship-to Name", Abs(ValueEntry1."Item Ledger Entry Quantity"), SalesInvoiceHeader."Sell-to Customer No.");
                                        Evaluate(IntVar, CopyStr(SalesInvoiceHeader."No.", StrLen(SalesInvoiceHeader."No.") - 4, 5));
                                        FileName := Format(IntVar);
                                        //path := 'c:\COA_Inv\';
                                        //FileName := path + FileName + '.PDF';
                                        //FileName1 := FileName;
                                        i := i + 1;
                                        // QLTCertificate.SaveAsPdf(FileName);
                                        // TempSalesInvHeader.Init;
                                        // TempSalesInvHeader."No." := CopyStr(FileName, 2, 20);
                                        // TempSalesInvHeader.Remarks := FileName;
                                        // TempSalesInvHeader.Insert;
                                        // if CheckQc(SalesInvoiceHeader."No.") then
                                        //     SMTPMail.AddAttachment(FileName, FileName1);
                                        Clear(TempBlob);
                                        Clear(Base64Txt);
                                        TempBlob.CreateOutStream(OutStream);
                                        CLEAR(QLTCertificate);
                                        QLTCertificate.SETTABLEVIEW(ValueEntry1); //Uncomment
                                        QLTCertificate.SalesInvoice(SalesInvoiceHeader."No.", SalesInvoiceHeader."Posting Date", SalesInvoiceHeader."External Document No.", SalesInvoiceHeader."Bill-to Name", SalesInvoiceHeader."Ship-to Name", ABS(ValueEntry1."Item Ledger Entry Quantity"), SalesInvoiceHeader."Sell-to Customer No.");
                                        QLTCertificate.SaveAs('', ReportFormat::Pdf, OutStream);
                                        TempBlob.CreateInStream(InStream);
                                        Base64Txt := Base64Convert.ToBase64(InStream, true);
                                        EmailMessage.AddAttachment(FileName + '.pdf', 'application/pdf', Base64Txt);
                                    end;
                                end;
                            end;
                        until SalesInvoiceHeader.Next = 0;
                    ShipingName := '';
                    if ShippingAgent1.Get("Actual Shipping Agent code") then ShipingName := ShippingAgent1.Name;
                    EmailMessage.AppendToBody('<table border="1" cellpadding="3" style="border-style: solid; border-width: 1px">');
                    EmailMessage.AppendToBody('<tr>');
                    EmailMessage.AppendToBody('<td><font face="arial" size ="2">Transporter Name</font></td>');
                    EmailMessage.AppendToBody('<td><font face="arial" size ="2">' + ShipingName + '</font></td>');
                    EmailMessage.AppendToBody('</tr>');
                    EmailMessage.AppendToBody('<tr>');
                    EmailMessage.AppendToBody('<td><font face="arial" size ="2">Transport Method</font></td>');
                    EmailMessage.AppendToBody('<td><font face="arial" size ="2">' + Format(SalesInvoiceHeader."Transport Method") + '</font></td>');
                    EmailMessage.AppendToBody('</tr>');
                    EmailMessage.AppendToBody('<tr>');
                    EmailMessage.AppendToBody('<td><font face="arial" size ="2">Shipment Method Code</font></td>');
                    EmailMessage.AppendToBody('<td><font face="arial" size ="2">' + Format(SalesInvoiceHeader."Shipment Method Code") + '</font></td>');
                    EmailMessage.AppendToBody('</tr>');
                    EmailMessage.AppendToBody('<tr>');
                    EmailMessage.AppendToBody('<td><font face="arial" size ="2">LR_RR No.</font></td>');
                    EmailMessage.AppendToBody('<td><font face="arial" size ="2">' + Format(SalesInvoiceHeader."LR/RR No.") + '</font></td>');
                    EmailMessage.AppendToBody('</tr>');
                    EmailMessage.AppendToBody('<tr>');
                    EmailMessage.AppendToBody('<td><font face="arial" size ="2">E-Way Bill No.</font></td>');
                    EmailMessage.AppendToBody('<td><font face="arial" size ="2">' + Format(SalesInvoiceHeader."ST38 No") + '</font></td>');
                    EmailMessage.AppendToBody('</tr>');
                    EmailMessage.AppendToBody('<tr>');
                    EmailMessage.AppendToBody('<td><font face="arial" size ="2">Expected Delivery Date</font></td>');
                    EmailMessage.AppendToBody('<td><font face="arial" size ="2">' + Format(SalesInvoiceHeader."Expected Delivery Date") + '</font></td>');
                    EmailMessage.AppendToBody('</tr>');
                    EmailMessage.AppendToBody('<tr>');
                    EmailMessage.AppendToBody('<td><font face="arial" size ="2">Tracking Site</font></td>');
                    EmailMessage.AppendToBody('<td><font face="arial" size ="2">' + Format(TrackingSite) + '</font></td>');
                    EmailMessage.AppendToBody('</tr>');
                    EmailMessage.AppendToBody('</table>');
                    EmailMessage.AppendToBody('</br></br>');
                    EmailMessage.AppendToBody('<table border="1" cellpadding="3" style="border-style: solid; border-width: 1px">');
                    EmailMessage.AppendToBody('<tr style="background-color:grey;color:black;">');
                    EmailMessage.AppendToBody('<td colspan="3"><center><b><font face="arial" size ="2">Transporter Contact Details</font></b></center></td>');
                    EmailMessage.AppendToBody('</tr>');
                    EmailMessage.AppendToBody('<tr style="background-color:grey;color:black;">');
                    EmailMessage.AppendToBody('<td><b><font face="arial" size ="2">Contact details at Delivery Godown</font></b></td>');
                    EmailMessage.AppendToBody('<td><b><font face="arial" size ="2">Manager Contact at Delivery Point</font></b></td>');
                    EmailMessage.AppendToBody('<td><b><font face="arial" size ="2">Contact details at Booking Godown</font></b></td>');
                    EmailMessage.AppendToBody('</tr>');
                    EmailMessage.AppendToBody('<tr>');
                    EmailMessage.AppendToBody('<td><font face="arial" size ="2">Name: ' + Cont1Name + '</font></td>');
                    EmailMessage.AppendToBody('<td><font face="arial" size ="2">Name: ' + Cont2Name + '</font></td>');
                    EmailMessage.AppendToBody('<td><font face="arial" size ="2">Name: ' + Cont3Name + '</font></td>');
                    EmailMessage.AppendToBody('</tr>');
                    EmailMessage.AppendToBody('<tr>');
                    EmailMessage.AppendToBody('<td><font face="arial" size ="2">Mobile: ' + Cont1Mobile + '</font></td>');
                    EmailMessage.AppendToBody('<td><font face="arial" size ="2">Mobile: ' + Cont2Mobile + '</font></td>');
                    EmailMessage.AppendToBody('<td><font face="arial" size ="2">Mobile: ' + Cont3Mobile + '</font></td>');
                    EmailMessage.AppendToBody('</tr>');
                    EmailMessage.AppendToBody('<tr>');
                    EmailMessage.AppendToBody('<td><font face="arial" size ="2">Email: ' + Cont1Email + '</font></td>');
                    EmailMessage.AppendToBody('<td><font face="arial" size ="2">Email: ' + Cont2Email + '</font></td>');
                    EmailMessage.AppendToBody('<td><font face="arial" size ="2">Email: ' + Cont3Email + '</font></td>');
                    EmailMessage.AppendToBody('</tr>');
                    EmailMessage.AppendToBody('</table>');
                    EmailMessage.AppendToBody('</br></br></br><br>');
                    EmailMessage.AppendToBody('<font face="arial" size ="2">Sincerely,</font><br><br>');
                    EmailMessage.AppendToBody('<font face="arial" size ="2">Customer Care Team</font><br><br>');
                    EmailMessage.AppendToBody('<font face="arial" size ="2">This is an automated email. Replies to this message are not monitored or answered.</font><br><br>');
                    EmailMessage.AppendToBody('<center><font face="arial" size ="2">' + CompanyInfo.Name + '</font></center>');
                    EmailMessage.AppendToBody('<center><font face="arial" size ="2">Regus Rectangle, Level 4,Rectangle 1,D-4, Saket District Centre, New Delhi</font><center>');
                    //SSD_Remove
                    //ActualCC += SPEmail + ';' + SalesPerson."Resp. CCare Exe. Email Id";
                    //EmailMessage.AppendToBody(StrSubstNo(ActualID, ActualTO, ActualCC));
                    //SSD_Remove
                    EmailMessage.AppendToBody('</font>');
                    Clear(MailSend);
                    if SalesInvoiceHeader.FindSet then
                        repeat
                            ValueEntry.Reset;
                            ValueEntry.SetRange("Document No.", SalesInvoiceHeader."No.");
                            ValueEntry.SetRange(Adjustment, false);
                            if ValueEntry.FindFirst then begin
                                ILE.Reset;
                                ILE.SetRange("Entry No.", ValueEntry."Item Ledger Entry No.");
                                if ILE.FindFirst then begin
                                    PostedQtyHdr.Reset;
                                    PostedQtyHdr.SetRange("Lot No.", ILE."Lot No.");
                                    PostedQtyHdr.SetRange(Approved, true);
                                    if PostedQtyHdr.FindSet then begin
                                        if MailSend = false then
                                            if not SalesInvoiceHeader."Send Mail Without COA" then begin
                                                // SMTPMail.Send();//as
                                                Clear(Base64Txt);
                                                OnBeforSendCOAMail(Base64Txt, SalesInvoiceHeader);
                                                if Base64Txt <> '' then EmailMessage.AddAttachment(SalesInvoiceHeader."No." + '.pdf', 'application/pdf', Base64Txt);
                                                Email.Enqueue(EmailMessage); //SSD_Uncomment
                                                MailSend := true;
                                            end;
                                        if SalesInvoiceHeader."Send Mail Without COA" then begin //Add begin Alle 10122021
                                            SalesInvoiceHeader2.Get(SalesInvoiceHeader."No.");
                                            SalesInvoiceHeader2."Send Mail Again With COA" := true;
                                            SalesInvoiceHeader2."Send Mail Again With COA Date" := WorkDate; //Alle 10122021
                                            SalesInvoiceHeader2."Send Mail Again With COA Time" := Time; //Alle 10122021
                                            SalesInvoiceHeader2.Modify;
                                        end
                                        else begin //Add begin Alle 10122021
                                            if CheckQc(SalesInvoiceHeader."No.") then begin //Alle 31122021
                                                SalesInvoiceHeader2.Get(SalesInvoiceHeader."No.");
                                                SalesInvoiceHeader2."Send Mail With COA" := true;
                                                SalesInvoiceHeader2."Send Mail Capture Date" := WorkDate;
                                                SalesInvoiceHeader2."Send Mail Capture Time" := Time;
                                                SalesInvoiceHeader2.Modify;
                                            end;
                                        end;
                                        Commit;
                                        //as END;
                                        //ALLE 08012019
                                        if CheckQc(SalesInvoiceHeader."No.") then begin //Alle 31122021
                                            DispatchMailSend.Reset;
                                            DispatchMailSend.SetRange("No.", "No.");
                                            if not DispatchMailSend.FindFirst then begin
                                                DispatchMailSend.Init;
                                                DispatchMailSend."No." := "No.";
                                                DispatchMailSend.Insert;
                                            end;
                                        end; // Alle 31122021
                                             //ALLE 08012019
                                    end;
                                end;
                            end;
                        until SalesInvoiceHeader.Next = 0;
                end;
                Commit;
                //For COA Not Approved
                Clear(MailSend);
                SalesInvoiceHeader.Reset;
                SalesInvoiceHeader.SetCurrentkey("Sell-to Customer No.", "LR/RR No.", "No.");
                SalesInvoiceHeader.SetRange("Sell-to Customer No.", "Sales Invoice Header"."Sell-to Customer No.");
                SalesInvoiceHeader.SetRange("Mail Send Dispatch Detail", false);
                SalesInvoiceHeader.SetRange("LR/RR No.", "LR/RR No.");
                SalesInvoiceHeader.SetRange("Send Mail With COA", false);
                SalesInvoiceHeader.SetRange("Send Mail Without COA", false);
                SalesInvoiceHeader.SetFilter("Posting Date", '>%1', 20230825D);
                //SalesInvoiceHeader.SetRange("Posting Date", 20230701D, 20230727D);
                if SalesInvoiceHeader.FindSet then begin
                    TempSalesInvHeader.DeleteAll;
                    Clear(EmailId);
                    Clear(MailList);
                    Clear(CCMailList);
                    Clear(BCCMailList);
                    Clear(Email);
                    Clear(EmailMessage);
                    Clear(ActualTO);
                    Clear(ActualCC);
                    Clear(SPName);
                    Clear(SPPhNo);
                    Clear(SPEmail);
                    if Customer.Get("Sell-to Customer No.") then;
                    if SalesHeader.Get(SalesHeader."document type"::Order, SalesInvoiceHeader."Order/Scd. No.") then begin
                        if SalesHeader."Cust EMail" <> '' then EmailId := SalesHeader."Cust EMail";
                    end;
                    MailList.AddRange(EmailId.Split(';'));
                    SalesPerson.Reset();
                    if SalesPerson.Get(SalesInvoiceHeader."Salesperson Code") then begin
                        SPName := SalesPerson.Name;
                        SPPhNo := SalesPerson."Phone No.";
                        SPEmail := SalesPerson."E-Mail";
                    end;
                    if SPEmail <> '' then CCMailList.AddRange(SPEmail.Split(';'));
                    if SalesPerson."Resp. CCare Exe. Email Id" <> '' then CCMailList.AddRange(SalesPerson."Resp. CCare Exe. Email Id".Split(';'));
                    //SSD_Remove
                    //ActualTO := EmailId;
                    //SSD_Remove
                    if EnvironmentInformation.IsProduction() then
                        EmailMessage.Create(MailList, StrSubstNo(Suubject2, SalesInvoiceHeader."LR/RR No.", Customer.Name), '', true, CCMailList, BCCMailList)
                    else begin
                        Clear(MailList);
                        Clear(CCMailList);
                        Clear(BCCMailList);
                        //MailList.Add('sunil@ssdynamics.co.in');
                        //MailList.Add('hyadav@zavenir.com');
                        MailList.Add('ykuntal@zavenir.com');
                        EmailMessage.Create(MailList, StrSubstNo(Suubject2, SalesInvoiceHeader."LR/RR No.", Customer.Name), '', true); //SSD_Uncomment
                    end;
                    // SMTPMailSetup.Get;
                    // SMTPMailSetup.TestField("SMTP Server");
                    // SMTPMailSetup.TestField("User ID");
                    // SMTPMailSetup.TestField(Password);
                    //SMTPMail.CreateMessage('Zavenir Dispatch Information', SMTPMailSetup."User ID", EmailId, 'Dispatch Details Vide Way Bill# ' + SalesInvoiceHeader."LR/RR No." + ' - ' + Customer.Name, '<br>', true);
                    //SMTPMail.AddBCC('agupta@zavenir.com');
                    EmailMessage.AppendToBody('<font face="arial" size ="4">');
                    EmailMessage.AppendToBody('<center><b>Dispatch Details Vide Way Bill # ' + SalesInvoiceHeader."LR/RR No." + '</b></center></font><br><br>');
                    EmailMessage.AppendToBody('<font face="arial" size ="2">');
                    EmailMessage.AppendToBody('Dear Sir or Madam,<br><br>');
                    EmailMessage.AppendToBody('Please find below the dispatch details for kind reference:<br><br></font>');
                    EmailMessage.AppendToBody('<table border="1" cellpadding="3" style="border-style: solid; border-width: 1px">');
                    EmailMessage.AppendToBody('<tr>');
                    EmailMessage.AppendToBody('<td><b><font face="arial" size ="2">Sales Invoice No.</font></b></td>');
                    EmailMessage.AppendToBody('<td><b><font face="arial" size ="2">Invoice Date</font></b></td>');
                    EmailMessage.AppendToBody('<td><b><font face="arial" size ="2">Invoice Amount</font></b></td>');
                    EmailMessage.AppendToBody('<td><b><font face="arial" size ="2">Customer PO No.</font></b></td>');
                    EmailMessage.AppendToBody('<td><b><font face="arial" size ="2">Sales Order No.</font></b></td>');
                    EmailMessage.AppendToBody('</tr>');
                    i := 0;
                    Clear(FileName);
                    FileName := 'COA-' + Format(i);
                    // path := 'C:\Mail\';
                    // FileName := path + FileName + '.PDF';
                    // if Exists(FileName) then
                    //     Erase(FileName);
                    // Sleep(1000);
                    i := 0;
                    Clear(FileName);
                    if SalesInvoiceHeader.FindSet then
                        repeat
                            ValueEntry.Reset;
                            ValueEntry.SetRange("Document No.", SalesInvoiceHeader."No.");
                            ValueEntry.SetRange(Adjustment, false);
                            if ValueEntry.FindFirst then begin
                                ILE.Reset;
                                ILE.SetRange("Entry No.", ValueEntry."Item Ledger Entry No.");
                                if ILE.FindFirst then begin
                                    PostedQtyHdr.Reset;
                                    PostedQtyHdr.SetRange("Lot No.", ILE."Lot No.");
                                    PostedQtyHdr.SetRange(Approved, true);
                                    if not PostedQtyHdr.FindSet then begin
                                        InvNoStr := CopyStr(SalesInvoiceHeader."No.", StrLen(SalesInvoiceHeader."No.") - 4, 5);
                                        if Cust.Get("Sell-to Customer No.") then CustAss_AcNo := Cust."Our Account No.";
                                        //SSD_DetailedGST
                                        Clear(GSTAmt);
                                        DetailedGSTLedgerEntry.Reset();
                                        DetailedGSTLedgerEntry.SetCurrentKey("Document No.");
                                        DetailedGSTLedgerEntry.SetRange("Document No.", SalesInvoiceHeader."No.");
                                        if DetailedGSTLedgerEntry.FindSet() then begin
                                            DetailedGSTLedgerEntry.CalcSums("GST Amount");
                                            GSTAmt := DetailedGSTLedgerEntry."GST Amount";
                                        end;
                                        //SSD_DetailedGST
                                        SalesInvoiceHeader.CalcFields(Amount); //SSD_Amount to Customer
                                        EmailMessage.AppendToBody('<tr>');
                                        EmailMessage.AppendToBody('<td widht="20"><font face="arial" size ="2">' + Format(InvNoStr) + '</font></td>');
                                        EmailMessage.AppendToBody('<td widht="20"><font face="arial" size ="2">' + Format(SalesInvoiceHeader."Posting Date") + '</font></td>');
                                        EmailMessage.AppendToBody('<td widht="20"><font face="arial" size ="2">' + Format(SalesInvoiceHeader.Amount - GSTAmt) + '</font></td>'); //SSD_Amount to Customer
                                        EmailMessage.AppendToBody('<td widht="20"><font face="arial" size ="2">' + Format(SalesInvoiceHeader."External Document No.") + '</font></td>');
                                        EmailMessage.AppendToBody('<td widht="20"><font face="arial" size ="2">' + Format(SalesInvoiceHeader."Order/Scd. No.") + '</font></td>');
                                        EmailMessage.AppendToBody('</tr>');
                                    end;
                                end;
                            end;
                        until SalesInvoiceHeader.Next = 0;
                    EmailMessage.AppendToBody('</table>');
                    EmailMessage.AppendToBody('<br><br>');
                    EmailMessage.AppendToBody('<table border="1" cellpadding="3" style="border-style: solid; border-width: 1px">');
                    EmailMessage.AppendToBody('<tr>');
                    EmailMessage.AppendToBody('<td><b><font face="arial" size ="2">Consignor with Vendor Code</font></b></td>');
                    if CustAss_AcNo <> '' then
                        EmailMessage.AppendToBody('<td>' + '<font face="arial" size ="2">' + CompanyInfo.Name + '(' + CustAss_AcNo + ')</font>' + '</td>')
                    else
                        EmailMessage.AppendToBody('<td>' + '<font face="arial" size ="2">' + CompanyInfo.Name + '</font>' + '</td>');
                    EmailMessage.AppendToBody('</tr>');
                    EmailMessage.AppendToBody('<tr>');
                    EmailMessage.AppendToBody('<td><b><font face="arial" size ="2">Sell to Customer Code & Name</font></b></td>');
                    EmailMessage.AppendToBody('<td><font face="arial" size ="2">' + Format(SalesInvoiceHeader."Sell-to Customer No.") + '-' + Format(SalesInvoiceHeader."Sell-to Customer Name") + '</font></td>');
                    EmailMessage.AppendToBody('</tr>');
                    EmailMessage.AppendToBody('<tr>');
                    EmailMessage.AppendToBody('<td><b><font face="arial" size ="2">Bill To Customer Code & Name</font></b></td>');
                    EmailMessage.AppendToBody('<td><font face="arial" size ="2">' + Format(SalesInvoiceHeader."Bill-to Customer No.") + '-' + Format(SalesInvoiceHeader."Bill-to Name") + '</font></td>');
                    EmailMessage.AppendToBody('</tr>');
                    if SalesPerson.Get(SalesInvoiceHeader."Salesperson Code") then begin
                        SPName := SalesPerson.Name;
                        SPPhNo := SalesPerson."Phone No.";
                        SPEmail := SalesPerson."E-Mail";
                    end;
                    EmailMessage.AppendToBody('<tr>');
                    EmailMessage.AppendToBody('<td><b><font face="arial" size ="2">Sales Person & Contact No.</font></b></td>');
                    EmailMessage.AppendToBody('<td><font face="arial" size ="2">' + Format(SPName) + ' ; ' + Format(SPPhNo) + ' ; ' + Format(SPEmail) + '</font></td>');
                    EmailMessage.AppendToBody('</tr>');
                    EmailMessage.AppendToBody('<tr>');
                    EmailMessage.AppendToBody('<td><b><font face="arial" size ="2">CCare Person & Contact No.</font></b></td>');
                    EmailMessage.AppendToBody('<td><font face="arial" size ="2">' + Format(SalesPerson."Resp. CCare Exe. Name") + ' ; ' + Format(SalesPerson."Resp. CCare Exe. Phone No.") + ' ; ' + Format(SalesPerson."Resp. CCare Exe. Email Id") + '</font></td>');
                    EmailMessage.AppendToBody('</tr>');
                    EmailMessage.AppendToBody('</table>');
                    EmailMessage.AppendToBody('<br><br>');
                    EmailMessage.AppendToBody('<table border="1" cellpadding="3" style="border-style: solid; border-width: 1px">');
                    EmailMessage.AppendToBody('<tr>');
                    EmailMessage.AppendToBody('<td><b><font face="arial" size ="2">Sr. No.</font></td>');
                    EmailMessage.AppendToBody('<td><b><font face="arial" size ="2">Description of Goods</font></b></td>');
                    EmailMessage.AppendToBody('<td><b><font face="arial" size ="2">Customer Item Code</font></b></td>');
                    EmailMessage.AppendToBody('<td><b><font face="arial" size ="2">SO Quantity</font></b></td>');
                    EmailMessage.AppendToBody('<td><b><font face="arial" size ="2">Qty. Dispatched</font></b></td>');
                    EmailMessage.AppendToBody('<td><b><font face="arial" size ="2">Short Closed Qty.</font></b></td>');
                    EmailMessage.AppendToBody('<td><b>Outstanding Qty.</b></td>');
                    EmailMessage.AppendToBody('</tr>');
                    j := 1;
                    if SalesInvoiceHeader.FindSet then
                        repeat
                            ValueEntry.Reset;
                            ValueEntry.SetRange("Document No.", SalesInvoiceHeader."No.");
                            ValueEntry.SetRange(Adjustment, false);
                            if ValueEntry.FindFirst then begin
                                ILE.Reset;
                                ILE.SetRange("Entry No.", ValueEntry."Item Ledger Entry No.");
                                if ILE.FindFirst then begin
                                    PostedQtyHdr.Reset;
                                    PostedQtyHdr.SetRange("Lot No.", ILE."Lot No.");
                                    PostedQtyHdr.SetRange(Approved, true);
                                    if not PostedQtyHdr.FindSet then begin
                                        InvNoStr := '';
                                        InvNoStr := CopyStr(SalesInvoiceHeader."No.", StrLen(SalesInvoiceHeader."No.") - 4, 5);
                                        EmailMessage.AppendToBody('<tr>');
                                        EmailMessage.AppendToBody('<td colspan="6"><b><font face="arial" size ="2">INVOICE NO.' + Format(InvNoStr) + '</b></td>');
                                        EmailMessage.AppendToBody('</tr>');
                                        SalesInvoiceLine.Reset;
                                        SalesInvoiceLine.SetRange("Document No.", SalesInvoiceHeader."No.");
                                        SalesInvoiceLine.SetFilter(Type, '%1', 2);
                                        if SalesInvoiceLine.FindSet then
                                            repeat
                                                if SalesLine.Get(SalesLine."document type"::Order, SalesInvoiceLine."SSD Order No.", SalesInvoiceLine."SSD Order Line No.") then;
                                                EmailMessage.AppendToBody('<tr>');
                                                EmailMessage.AppendToBody('<td><font face="arial" size ="2">' + Format(j) + '</td>');
                                                EmailMessage.AppendToBody('<td><font face="arial" size ="2">' + Format(SalesInvoiceLine."No.") + '-' + Format(SalesInvoiceLine.Description) + ' ' + Format(SalesInvoiceLine."Description 2") + '</font></td>');
                                                EmailMessage.AppendToBody('<td><font face="arial" size ="2">' + Format(SalesInvoiceLine."Item Reference No.") + '</font></td>');
                                                EmailMessage.AppendToBody('<td><font face="arial" size ="2">' + Format(SalesLine.Quantity) + '</font></td>');
                                                EmailMessage.AppendToBody('<td><font face="arial" size ="2">' + Format(SalesInvoiceLine.Quantity) + ' ' + Format(SalesInvoiceLine."Unit of Measure Code") + '</font></td>');
                                                EmailMessage.AppendToBody('<td><font face="arial" size ="2">' + Format(SalesLine."Short Close Qty.") + '</font></td>');
                                                EmailMessage.AppendToBody('<td><font face="arial" size ="2">' + Format(SalesLine."Outstanding Quantity") + '</font></td>');
                                                EmailMessage.AppendToBody('</tr>');
                                                j += 1;
                                            until SalesInvoiceLine.Next = 0;
                                    end;
                                end;
                            end;
                        until SalesInvoiceHeader.Next = 0;
                    EmailMessage.AppendToBody('</table>');
                    EmailMessage.AppendToBody('</br></br>');
                    Cont1Email := '';
                    Cont1Mobile := '';
                    Cont1Name := '';
                    Cont2Email := '';
                    Cont2Mobile := '';
                    Cont2Name := '';
                    if Customer1.Get("Sell-to Customer No.") then;
                    ActualTransporterContDetail.Reset;
                    ActualTransporterContDetail.SetRange("Shipping Agent Code", SalesInvoiceHeader."Actual Shipping Agent code");
                    ActualTransporterContDetail.SetRange("Post Code", Customer1."Post Code");
                    if ActualTransporterContDetail.FindFirst then Cont1Email := ActualTransporterContDetail."Contact1 Email";
                    Cont1Mobile := ActualTransporterContDetail."Contact1 Mob";
                    Cont1Name := ActualTransporterContDetail."Contact1 Name";
                    Cont2Email := ActualTransporterContDetail."Contact2 Email";
                    Cont2Mobile := ActualTransporterContDetail."Contact2 Mob";
                    Cont2Name := ActualTransporterContDetail."Contact2 Name";
                    if ShippingAgent.Get(SalesInvoiceHeader."Actual Shipping Agent code") then begin
                        TrackingSite := ShippingAgent."Internet Address";
                        Cont3Name := ShippingAgent."Contact3 Name";
                        Cont3Mobile := ShippingAgent."Contact3 Mobile";
                        Cont3Email := ShippingAgent."Contact3 Email";
                    end;
                    Clear(FileName);
                    ShipingName := '';
                    if ShippingAgent1.Get("Actual Shipping Agent code") then ShipingName := ShippingAgent1.Name;
                    EmailMessage.AppendToBody('<table border="1" cellpadding="3" style="border-style: solid; border-width: 1px">');
                    EmailMessage.AppendToBody('<tr>');
                    EmailMessage.AppendToBody('<td><font face="arial" size ="2">Transporter Name</font></td>');
                    EmailMessage.AppendToBody('<td><font face="arial" size ="2">' + ShipingName + '</font></td>');
                    EmailMessage.AppendToBody('</tr>');
                    EmailMessage.AppendToBody('<tr>');
                    EmailMessage.AppendToBody('<td><font face="arial" size ="2">Transport Method</font></td>');
                    EmailMessage.AppendToBody('<td><font face="arial" size ="2">' + Format(SalesInvoiceHeader."Transport Method") + '</font></td>');
                    EmailMessage.AppendToBody('</tr>');
                    EmailMessage.AppendToBody('<tr>');
                    EmailMessage.AppendToBody('<td><font face="arial" size ="2">Shipment Method Code</font></td>');
                    EmailMessage.AppendToBody('<td><font face="arial" size ="2">' + Format(SalesInvoiceHeader."Shipment Method Code") + '</font></td>');
                    EmailMessage.AppendToBody('</tr>');
                    EmailMessage.AppendToBody('<tr>');
                    EmailMessage.AppendToBody('<td><font face="arial" size ="2">LR_RR No.</font></td>');
                    EmailMessage.AppendToBody('<td><font face="arial" size ="2">' + Format(SalesInvoiceHeader."LR/RR No.") + '</font></td>');
                    EmailMessage.AppendToBody('</tr>');
                    EmailMessage.AppendToBody('<tr>');
                    EmailMessage.AppendToBody('<td><font face="arial" size ="2">E-Way Bill No.</font></td>');
                    EmailMessage.AppendToBody('<td><font face="arial" size ="2">' + Format(SalesInvoiceHeader."ST38 No") + '</font></td>');
                    EmailMessage.AppendToBody('</tr>');
                    EmailMessage.AppendToBody('<tr>');
                    EmailMessage.AppendToBody('<td><font face="arial" size ="2">Expected Delivery Date</font></td>');
                    EmailMessage.AppendToBody('<td><font face="arial" size ="2">' + Format(SalesInvoiceHeader."Expected Delivery Date") + '</font></td>');
                    EmailMessage.AppendToBody('</tr>');
                    EmailMessage.AppendToBody('<tr>');
                    EmailMessage.AppendToBody('<td><font face="arial" size ="2">Tracking Site</font></td>');
                    EmailMessage.AppendToBody('<td><font face="arial" size ="2">' + Format(TrackingSite) + '</font></td>');
                    EmailMessage.AppendToBody('</tr>');
                    EmailMessage.AppendToBody('</table>');
                    EmailMessage.AppendToBody('</br></br>');
                    EmailMessage.AppendToBody('<table border="1" cellpadding="3" style="border-style: solid; border-width: 1px">');
                    EmailMessage.AppendToBody('<tr style="background-color:grey;color:black;">');
                    EmailMessage.AppendToBody('<td colspan="3"><center><b><font face="arial" size ="2">Transporter Contact Details</font></b></center></td>');
                    EmailMessage.AppendToBody('</tr>');
                    EmailMessage.AppendToBody('<tr style="background-color:grey;color:black;">');
                    EmailMessage.AppendToBody('<td><b><font face="arial" size ="2">Contact details at Delivery Godown</font></b></td>');
                    EmailMessage.AppendToBody('<td><b><font face="arial" size ="2">Manager Contact at Delivery Point</font></b></td>');
                    EmailMessage.AppendToBody('<td><b><font face="arial" size ="2">Contact details at Booking Godown</font></b></td>');
                    EmailMessage.AppendToBody('</tr>');
                    EmailMessage.AppendToBody('<tr>');
                    EmailMessage.AppendToBody('<td><font face="arial" size ="2">Name: ' + Cont1Name + '</font></td>');
                    EmailMessage.AppendToBody('<td><font face="arial" size ="2">Name: ' + Cont2Name + '</font></td>');
                    EmailMessage.AppendToBody('<td><font face="arial" size ="2">Name: ' + Cont3Name + '</font></td>');
                    EmailMessage.AppendToBody('</tr>');
                    EmailMessage.AppendToBody('<tr>');
                    EmailMessage.AppendToBody('<td><font face="arial" size ="2">Mobile: ' + Cont1Mobile + '</font></td>');
                    EmailMessage.AppendToBody('<td><font face="arial" size ="2">Mobile: ' + Cont2Mobile + '</font></td>');
                    EmailMessage.AppendToBody('<td><font face="arial" size ="2">Mobile: ' + Cont3Mobile + '</font></td>');
                    EmailMessage.AppendToBody('</tr>');
                    EmailMessage.AppendToBody('<tr>');
                    EmailMessage.AppendToBody('<td><font face="arial" size ="2">Email: ' + Cont1Email + '</font></td>');
                    EmailMessage.AppendToBody('<td><font face="arial" size ="2">Email: ' + Cont2Email + '</font></td>');
                    EmailMessage.AppendToBody('<td><font face="arial" size ="2">Email: ' + Cont3Email + '</font></td>');
                    EmailMessage.AppendToBody('</tr>');
                    EmailMessage.AppendToBody('</table>');
                    EmailMessage.AppendToBody('</br></br></br><br>');
                    EmailMessage.AppendToBody('<font face="arial" size ="2">Note : CoA will be shared shortly.</font><br><br>');
                    EmailMessage.AppendToBody('<font face="arial" size ="2">Sincerely,</font><br><br>');
                    EmailMessage.AppendToBody('<font face="arial" size ="2">Customer Care Team</font><br><br>');
                    EmailMessage.AppendToBody('<font face="arial" size ="2">This is an automated email. Replies to this message are not monitored or answered.</font><br><br>');
                    EmailMessage.AppendToBody('<center><font face="arial" size ="2">' + CompanyInfo.Name + '</font></center>');
                    EmailMessage.AppendToBody('<center><font face="arial" size ="2">Regus Rectangle, Level 4,Rectangle 1,D-4, Saket District Centre, New Delhi</font><center>');
                    //if SPEmail <> '' then
                    //   CCMailList.AddRange(SPEmail.Split(';'));
                    //  if SalesPerson."Resp. CCare Exe. Email Id" <> '' then
                    //   CCMailList.AddRange(SalesPerson."Resp. CCare Exe. Email Id".Split(';'));
                    //SSD_Remove
                    // ActualCC := SPEmail + ';' + SalesPerson."Resp. CCare Exe. Email Id";
                    // EmailMessage.AppendToBody(StrSubstNo(ActualID, ActualTO, ActualCC));
                    //SSD_Remove
                    EmailMessage.AppendToBody('</font>');
                    Clear(MailSend);
                    if SalesInvoiceHeader.FindSet then //  REPEAT
                        ValueEntry.Reset;
                    ValueEntry.SetRange("Document No.", SalesInvoiceHeader."No.");
                    ValueEntry.SetRange(Adjustment, false);
                    if ValueEntry.FindFirst then begin
                        repeat
                            ILE.Reset;
                            ILE.SetRange("Entry No.", ValueEntry."Item Ledger Entry No.");
                            if ILE.FindFirst then begin
                                PostedQtyHdr.Reset;
                                PostedQtyHdr.SetRange("Lot No.", ILE."Lot No.");
                                PostedQtyHdr.SetRange(Approved, true);
                                if not PostedQtyHdr.FindFirst then begin
                                    if MailSend = false then begin
                                        Clear(Base64Txt);
                                        OnBeforSendCOAMail(Base64Txt, SalesInvoiceHeader);
                                        if Base64Txt <> '' then EmailMessage.AddAttachment(SalesInvoiceHeader."No." + '.pdf', 'application/pdf', Base64Txt);
                                        Email.Enqueue(EmailMessage);
                                    end;
                                    MailSend := true;
                                    SalesInvoiceHeader2.Get(SalesInvoiceHeader."No.");
                                    SalesInvoiceHeader2."Send Mail Without COA" := true;
                                    SalesInvoiceHeader2."Send Mail Capture Date W/O COA" := WorkDate; //Alle 10122021
                                    SalesInvoiceHeader2."Send Mail Capture Time W/O COA" := Time; //Alle 10122021
                                    SalesInvoiceHeader2.Modify;
                                    Commit;
                                    //as END;
                                end;
                            end;
                        until ValueEntry.Next = 0;
                    end;
                    // UNTIL SalesInvoiceHeader.NEXT = 0;
                end;
                Commit;
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
        CompanyInfo.Get;
    end;

    var
        CompanyInfo: Record "Company Information";
        Cust: Record Customer;
        Customer: Record Customer;
        Customer1: Record Customer;
        DetailedGSTLedgerEntry: Record "Detailed GST Ledger Entry";
        ILE: Record "Item Ledger Entry";
        SalesHeader: Record "Sales Header";
        SalesInvoiceHeader: Record "Sales Invoice Header";
        SalesInvoiceHeader2: Record "Sales Invoice Header";
        TempSalesInvHeader: Record "Sales Invoice Header" temporary;
        SalesInvoiceLine: Record "Sales Invoice Line";
        SalesLine: Record "Sales Line";
        SalesPerson: Record "Salesperson/Purchaser";
        ShippingAgent: Record "Shipping Agent";
        ShippingAgent1: Record "Shipping Agent";
        ActualTransporterContDetail: Record "SSD Actual Tpt Cont Detail";
        DispatchMailSend: Record "SSD Dispatch Mail Send";
        PostedQtyHdr: Record "SSD Posted Quality Order Hdr";
        ValueEntry: Record "Value Entry";
        ValueEntry1: Record "Value Entry";
        SalesReceivablesSetup: Record "Sales & Receivables Setup";
        QLTCertificate: Report 50044;//IG_DS "Certificate of Analysis.PSI";
        Base64Convert: Codeunit "Base64 Convert";
        Email: Codeunit Email;
        EmailMessage: Codeunit "Email Message";
        EnvironmentInformation: Codeunit "Environment Information";
        FileMgt: Codeunit "File Management";
        TempBlob: Codeunit "Temp Blob";
        RecRef: RecordRef;
        MailSend: Boolean;
        InvNoStr: Code[20];
        GSTAmt: Decimal;
        InStream: InStream;
        InStream2: InStream;
        // SMTPMailSetup: Record "SMTP Mail Setup";
        // SMTPMail: Codeunit UnknownCodeunit400;
        i: Integer;
        j: Integer;
        ActualID: Label 'Atual Mail - TO Mail - %1, CC Mail - %2';
        SubjectMSG: Label 'Dispatch Details Vide Way Bill# %1  %2';
        Suubject2: Label 'Dispatch Details Vide Way Bill# %1 - %2';
        BCCMailList: List of [Text];
        CCMailList: List of [Text];
        MailList: List of [Text];
        OutStream: OutStream;
        OutStream2: OutStream;
        ActualCC: Text;
        ActualTO: Text;
        Base64Txt: Text;
        Base64Txt2: Text;
        Cont1Email: Text;
        Cont1Mobile: Text;
        Cont1Name: Text;
        Cont2Email: Text;
        Cont2Mobile: Text;
        Cont2Name: Text;
        Cont3Email: Text;
        Cont3Mobile: Text;
        Cont3Name: Text;
        CustAss_AcNo: Text;
        EmailId: Text;
        FileName: Text;
        FileName1: Text;
        IntVar: Text;
        path: Text;
        ShipingName: Text;
        SPEmail: Text;
        SPName: Text;
        SPPhNo: Text;
        TrackingSite: Text;
        TechnicalEmailid: Text[250];

    local procedure CheckQc(DocNo: Code[20]) QCCheck: Boolean
    var
        ILEQC: Record "Item Ledger Entry";
        SalesInvoiceLineQC: Record "Sales Invoice Line";
        PostedQtyHdrQC: Record "SSD Posted Quality Order Hdr";
        ValueEntryQc: Record "Value Entry";
    begin
        ValueEntryQc.Reset;
        ValueEntryQc.SetRange("Document No.", DocNo);
        ValueEntryQc.SetRange(Adjustment, false);
        if ValueEntryQc.FindSet then
            repeat
                ILEQC.Reset;
                ILEQC.SetRange("Entry No.", ValueEntryQc."Item Ledger Entry No.");
                if ILEQC.FindFirst then begin
                    PostedQtyHdrQC.Reset;
                    PostedQtyHdrQC.SetRange("Lot No.", ILEQC."Lot No.");
                    PostedQtyHdrQC.SetRange(Approved, true);
                    if PostedQtyHdrQC.FindFirst then begin
                        QCCheck := true
                    end
                    else begin
                        QCCheck := false;
                        exit(QCCheck);
                    end;
                end;
            until ValueEntryQc.Next = 0;
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforSendCOAMail(var Base64Txt: Text; SalesInvoiceHeader: Record "Sales Invoice Header")
    begin
    end;
}
