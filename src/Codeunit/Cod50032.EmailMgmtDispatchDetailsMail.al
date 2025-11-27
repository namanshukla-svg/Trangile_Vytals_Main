codeunit 50032 EmailMgmtDispatchDetailsMail
{
    Permissions = tabledata "Sales Invoice Header"=m,
        tabledata "Purch. Rcpt. Line"=m,
        tabledata "Sales Invoice Line"=m,
        tabledata "Reservation Entry"=m,
        tabledata "Purch. Inv. Header"=m,
        tabledata "Purch. Rcpt. Header"=m,
        tabledata "Purch. Inv. Line"=m,
        tabledata "Cust. Ledger Entry"=m;

    trigger OnRun()
    begin
        //MailSendforCOA();
        UpdateRcptLine();
        RemoveitemTracking();
        UpdateGateEntryInPI();
    end;
    var PurchRcptLine: Record "Purch. Rcpt. Line";
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
    Suubject2: Label 'Dispatch Details Vide Way Bill# %1 - %2';
    EnvironmentInformation: Codeunit "Environment Information";
    procedure MailSendforCOA()
    var
        CompanyInfo: Record "Company Information";
        EmailId: Text;
        Customer: Record "Customer";
        SalesHeader: Record "Sales Header";
        i: Integer;
        FileName: Text;
        path: Text;
        InvNoStr: Code[20];
        Cust: Record "Customer";
        CustAss_AcNo: Text;
        SalesPerson: Record "Salesperson/Purchaser";
        SPName: Text;
        SPPhNo: Text;
        SPEmail: Text;
        j: Integer;
        SalesInvoiceLine: Record "Sales Invoice Line";
        SalesLine: Record "Sales Line";
        Cont1Email: Text;
        Cont1Mobile: Text;
        Cont1Name: Text;
        Cont2Email: Text;
        Cont2Mobile: Text;
        Cont2Name: Text;
        Customer1: Record "Customer";
        ActualTransporterContDetail: Record "SSD Actual Tpt Cont Detail";
        ShippingAgent: Record "Shipping Agent";
        TrackingSite: Text;
        Cont3Name: Text[50];
        Cont3Mobile: Text[50];
        Cont3Email: Text;
        ValueEntry: Record "Value Entry";
        ILE: Record "Item Ledger Entry";
        PostedQtyHdr: Record "SSD Posted Quality Order Hdr";
        ValueEntry1: Record "Value Entry";
        QLTCertificate: Report "Certificate of Analysis.PSI";
        IntVar: Text;
        FileName1: Text;
        TempSalesInvHeader: Record "Sales Invoice Header" temporary;
        ShipingName: Text;
        ShippingAgent1: Record "Shipping Agent";
        FileMgt: Codeunit "File Management";
        SalesInvoiceHeader: Record "Sales Invoice Header";
        DispatchMailSend: Record "SSD Dispatch Mail Send";
        MailSend: Boolean;
        TechnicalEmailid: Text;
        SalesInvoiceHeader2: Record "Sales Invoice Header";
        SubjectMSG: Label 'Dispatch Details Vide Way Bill# %1  %2';
        RecRef: RecordRef;
        CCMailList: List of[Text];
        BCCMailList: List of[Text];
        SSDEmailEntries: Record "SSD Email Entries";
        N: Integer;
        K: Integer;
    begin
        CompanyInfo.GET;
        //FOR COA Approved
        SalesInvoiceHeader2.Reset();
        SalesInvoiceHeader2.SETCURRENTKEY("Sell-to Customer No.", "LR/RR No.", "No.");
        SalesInvoiceHeader2.SetRange("Mail Send Dispatch Detail", false);
        SalesInvoiceHeader2.SetFilter("LR/RR No.", '<>%1', '');
        SalesInvoiceHeader2.SetRange("Send Mail With COA", false);
        SalesInvoiceHeader2.SetFilter("Posting Date", '>%1', 20220401D);
        SalesInvoiceHeader2.SetFilter("No.", '%1', 'ZDPSI2400170');
        if SalesInvoiceHeader2.FindSet()then repeat SalesInvoiceHeader.RESET;
                SalesInvoiceHeader.SETCURRENTKEY("Sell-to Customer No.", "LR/RR No.", "No.");
                SalesInvoiceHeader.SetRange("No.", SalesInvoiceHeader2."No.");
                SalesInvoiceHeader.SETRANGE("Sell-to Customer No.", SalesInvoiceHeader2."Sell-to Customer No.");
                SalesInvoiceHeader.SETRANGE("Mail Send Dispatch Detail", FALSE);
                SalesInvoiceHeader.SETRANGE("LR/RR No.", SalesInvoiceHeader2."LR/RR No.");
                SalesInvoiceHeader.SETRANGE("Send Mail With COA", FALSE);
                SalesInvoiceHeader.SETFILTER("Posting Date", '>%1', 20220401D);
                SalesInvoiceHeader.SetFilter("No.", '%1', 'ZDPSI2400170');
                //SalesInvoiceHeader.SetRange("No.", 'ZKPSI2301160');
                IF SalesInvoiceHeader.FINDSET THEN BEGIN
                    TempSalesInvHeader.DELETEALL;
                    CLEAR(EmailId);
                    CLEAR(TechnicalEmailid);
                    Clear(MailList);
                    Clear(CCMailList);
                    Clear(BCCMailList);
                    IF Customer.GET(SalesInvoiceHeader."Sell-to Customer No.")THEN;
                    IF SalesHeader.GET(SalesHeader."Document Type"::Order, SalesInvoiceHeader."Order/Scd. No.")THEN BEGIN
                        IF SalesHeader."Cust EMail" <> '' THEN EmailId:=SalesHeader."Cust EMail";
                        IF Customer."E-mail ID for Technical/QC" <> '' THEN TechnicalEmailid:=Customer."E-mail ID for Technical/QC";
                        MailList.AddRange(EmailId.Split(';'));
                        CCMailList.AddRange(TechnicalEmailid.Split(';'));
                        BCCMailList.Add('ykuntal@zavenir.com');
                    END;
                    // if EnvironmentInformation.IsProduction() then
                    //     EmailMessage.Create(MailList, StrSubstNo(SubjectMSG, SalesInvoiceHeader."LR/RR No.", Customer.Name), '', true, CCMailList, BCCMailList)
                    // else begin
                    //     Clear(MailList);
                    //     MailList.Add('sunil@ssdynamics.co.in');
                    //     MailList.Add('hyadav@zavenir.com');
                    //     MailList.Add('ykuntal@zavenir.com');
                    //     EmailMessage.Create(MailList, StrSubstNo(SubjectMSG, SalesInvoiceHeader."LR/RR No.", Customer.Name), '', true);
                    // end;
                    //SSD Sunil Uncomment
                    // IF TechnicalEmailid <> '' THEN
                    //     MailList.Add(TechnicalEmailid);//SSD Sunil Check Add CC
                    //SSD Sunil Uncomment
                    //SSD Comment if problem
                    EmailMessage.AppendToBody('<font face="arial" size ="4">');
                    EmailMessage.AppendToBody('<center><b>Dispatch Details Vide Way Bill # ' + SalesInvoiceHeader."LR/RR No." + '</b></center></font><br><br>');
                    EmailMessage.AppendToBody('<font face="arial" size ="2">');
                    //SSD Comment if problem
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
                    i:=0;
                    //SSD Sunil Check
                    // CLEAR(FileName);
                    // FileName := 'COA-' + FORMAT(i);
                    // path := 'C:\Mail\';
                    // FileName := path + FileName + '.PDF';
                    // IF EXISTS(FileName) THEN
                    //     ERASE(FileName);
                    // SLEEP(1000);
                    i:=0;
                    IF SalesInvoiceHeader.FINDSET THEN REPEAT CLEAR(FileName);
                            Clear(InvNoStr);
                            Clear(CustAss_AcNo);
                            InvNoStr:=COPYSTR(SalesInvoiceHeader."No.", STRLEN(SalesInvoiceHeader."No.") - 4, 5);
                            IF Cust.GET(SalesInvoiceHeader."Sell-to Customer No.")THEN CustAss_AcNo:=Cust."Our Account No.";
                            ValueEntry.RESET;
                            ValueEntry.SETRANGE("Document No.", SalesInvoiceHeader."No.");
                            ValueEntry.SETRANGE(Adjustment, FALSE);
                            IF ValueEntry.FINDFIRST THEN BEGIN
                                ILE.RESET;
                                ILE.SETRANGE("Entry No.", ValueEntry."Item Ledger Entry No.");
                                IF ILE.FINDFIRST THEN BEGIN
                                    PostedQtyHdr.RESET;
                                    PostedQtyHdr.SETRANGE("Lot No.", ILE."Lot No.");
                                    PostedQtyHdr.SETRANGE(Approved, TRUE);
                                    IF PostedQtyHdr.FINDSET THEN BEGIN
                                        SalesInvoiceHeader.CALCFIELDS(Amount);
                                        EmailMessage.AppendToBody('<tr>');
                                        EmailMessage.AppendToBody('<td widht="20"><font face="arial" size ="2">' + FORMAT(InvNoStr) + '</font></td>');
                                        EmailMessage.AppendToBody('<td widht="20"><font face="arial" size ="2">' + FORMAT(SalesInvoiceHeader."Posting Date") + '</font></td>');
                                        EmailMessage.AppendToBody('<td widht="20"><font face="arial" size ="2">' + FORMAT(SalesInvoiceHeader.Amount) + '</font></td>'); ////SSD Change Amount to Customer
                                        EmailMessage.AppendToBody('<td widht="20"><font face="arial" size ="2">' + FORMAT(SalesInvoiceHeader."External Document No.") + '</font></td>');
                                        EmailMessage.AppendToBody('<td widht="20"><font face="arial" size ="2">' + FORMAT(SalesInvoiceHeader."Order/Scd. No.") + '</font></td>');
                                        EmailMessage.AppendToBody('</tr>');
                                    END;
                                END;
                            END;
                        UNTIL SalesInvoiceHeader.NEXT = 0;
                    EmailMessage.AppendToBody('</table>');
                    EmailMessage.AppendToBody('<br><br>');
                    EmailMessage.AppendToBody('<table border="1" cellpadding="3" style="border-style: solid; border-width: 1px">');
                    EmailMessage.AppendToBody('<tr>');
                    EmailMessage.AppendToBody('<td><b><font face="arial" size ="2">Consignor with Vendor Code</font></b></td>');
                    IF CustAss_AcNo <> '' THEN EmailMessage.AppendToBody('<td>' + '<font face="arial" size ="2">' + CompanyInfo.Name + '(' + CustAss_AcNo + ')</font>' + '</td>')
                    ELSE
                        EmailMessage.AppendToBody('<td>' + '<font face="arial" size ="2">' + CompanyInfo.Name + '</font>' + '</td>');
                    EmailMessage.AppendToBody('</tr>');
                    EmailMessage.AppendToBody('<tr>');
                    EmailMessage.AppendToBody('<td><b><font face="arial" size ="2">Sell to Customer Code & Name</font></b></td>');
                    EmailMessage.AppendToBody('<td><font face="arial" size ="2">' + FORMAT(SalesInvoiceHeader."Sell-to Customer No.") + '-' + FORMAT(SalesInvoiceHeader."Sell-to Customer Name") + '</font></td>');
                    EmailMessage.AppendToBody('</tr>');
                    EmailMessage.AppendToBody('<tr>');
                    EmailMessage.AppendToBody('<td><b><font face="arial" size ="2">Bill To Customer Code & Name</font></b></td>');
                    EmailMessage.AppendToBody('<td><font face="arial" size ="2">' + FORMAT(SalesInvoiceHeader."Bill-to Customer No.") + '-' + FORMAT(SalesInvoiceHeader."Bill-to Name") + '</font></td>');
                    EmailMessage.AppendToBody('</tr>');
                    IF SalesPerson.GET(SalesInvoiceHeader."Salesperson Code")THEN BEGIN
                        SPName:=SalesPerson.Name;
                        SPPhNo:=SalesPerson."Phone No.";
                        SPEmail:=SalesPerson."E-Mail";
                    END;
                    EmailMessage.AppendToBody('<tr>');
                    EmailMessage.AppendToBody('<td><b><font face="arial" size ="2">Sales Person & Contact No.</font></b></td>');
                    EmailMessage.AppendToBody('<td><font face="arial" size ="2">' + FORMAT(SPName) + ' ; ' + FORMAT(SPPhNo) + ' ; ' + FORMAT(SPEmail) + '</font></td>');
                    EmailMessage.AppendToBody('</tr>');
                    EmailMessage.AppendToBody('<tr>');
                    EmailMessage.AppendToBody('<td><b><font face="arial" size ="2">CCare Person & Contact No.</font></b></td>');
                    EmailMessage.AppendToBody('<td><font face="arial" size ="2">' + FORMAT(SalesPerson."Resp. CCare Exe. Name") + ' ; ' + FORMAT(SalesPerson."Resp. CCare Exe. Phone No.") + ' ; ' + FORMAT(SalesPerson."Resp. CCare Exe. Email Id") + '</font></td>');
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
                    j:=1;
                    IF SalesInvoiceHeader.FINDSET THEN REPEAT ValueEntry.RESET;
                            ValueEntry.SETRANGE("Document No.", SalesInvoiceHeader."No.");
                            ValueEntry.SETRANGE(Adjustment, FALSE);
                            IF ValueEntry.FINDFIRST THEN BEGIN
                                ILE.RESET;
                                ILE.SETRANGE("Entry No.", ValueEntry."Item Ledger Entry No.");
                                IF ILE.FINDFIRST THEN BEGIN
                                    PostedQtyHdr.RESET;
                                    PostedQtyHdr.SETRANGE("Lot No.", ILE."Lot No.");
                                    PostedQtyHdr.SETRANGE(Approved, TRUE);
                                    IF PostedQtyHdr.FINDSET THEN BEGIN
                                        InvNoStr:='';
                                        InvNoStr:=COPYSTR(SalesInvoiceHeader."No.", STRLEN(SalesInvoiceHeader."No.") - 4, 5);
                                        EmailMessage.AppendToBody('<tr>');
                                        EmailMessage.AppendToBody('<td colspan="6"><b><font face="arial" size ="2">INVOICE NO.' + FORMAT(InvNoStr) + '</b></td>');
                                        EmailMessage.AppendToBody('</tr>');
                                        SalesInvoiceLine.RESET;
                                        SalesInvoiceLine.SETRANGE("Document No.", SalesInvoiceHeader."No.");
                                        SalesInvoiceLine.SETFILTER(Type, '%1', 2);
                                        IF SalesInvoiceLine.FINDSET THEN REPEAT IF SalesLine.GET(SalesLine."Document Type"::Order, SalesInvoiceLine."Order No.", SalesInvoiceLine."Order Line No.")THEN;
                                                EmailMessage.AppendToBody('<tr>');
                                                EmailMessage.AppendToBody('<td><font face="arial" size ="2">' + FORMAT(j) + '</td>');
                                                EmailMessage.AppendToBody('<td><font face="arial" size ="2">' + FORMAT(SalesInvoiceLine."No.") + '-' + FORMAT(SalesInvoiceLine.Description) + ' ' + FORMAT(SalesInvoiceLine."Description 2") + '</font></td>');
                                                EmailMessage.AppendToBody('<td><font face="arial" size ="2">' + FORMAT(SalesInvoiceLine."Item Reference No.") + '</font></td>');
                                                EmailMessage.AppendToBody('<td><font face="arial" size ="2">' + FORMAT(SalesLine.Quantity) + '</font></td>');
                                                EmailMessage.AppendToBody('<td><font face="arial" size ="2">' + FORMAT(SalesInvoiceLine.Quantity) + ' ' + FORMAT(SalesInvoiceLine."Unit of Measure Code") + '</font></td>');
                                                EmailMessage.AppendToBody('<td><font face="arial" size ="2">' + FORMAT(SalesLine."Short Close Qty.") + '</font></td>');
                                                EmailMessage.AppendToBody('<td><font face="arial" size ="2">' + FORMAT(SalesLine."Outstanding Quantity") + '</font></td>');
                                                EmailMessage.AppendToBody('</tr>');
                                                j+=1;
                                            UNTIL SalesInvoiceLine.NEXT = 0;
                                    END;
                                END;
                            END;
                        UNTIL SalesInvoiceHeader.NEXT = 0;
                    EmailMessage.AppendToBody('</table>');
                    EmailMessage.AppendToBody('</br></br>');
                    Cont1Email:='';
                    Cont1Mobile:='';
                    Cont1Name:='';
                    Cont2Email:='';
                    Cont2Mobile:='';
                    Cont2Name:='';
                    IF Customer1.GET(SalesInvoiceHeader."Sell-to Customer No.")THEN;
                    ActualTransporterContDetail.RESET;
                    ActualTransporterContDetail.SETRANGE("Shipping Agent Code", SalesInvoiceHeader."Actual Shipping Agent code");
                    ActualTransporterContDetail.SETRANGE("Post Code", Customer1."Post Code");
                    IF ActualTransporterContDetail.FINDFIRST THEN Cont1Email:=ActualTransporterContDetail."Contact1 Email";
                    Cont1Mobile:=ActualTransporterContDetail."Contact1 Mob";
                    Cont1Name:=ActualTransporterContDetail."Contact1 Name";
                    Cont2Email:=ActualTransporterContDetail."Contact2 Email";
                    Cont2Mobile:=ActualTransporterContDetail."Contact2 Mob";
                    Cont2Name:=ActualTransporterContDetail."Contact2 Name";
                    IF ShippingAgent.GET(SalesInvoiceHeader."Actual Shipping Agent code")THEN BEGIN
                        TrackingSite:=ShippingAgent."Internet Address";
                        Cont3Name:=ShippingAgent."Contact3 Name";
                        Cont3Mobile:=ShippingAgent."Contact3 Mobile";
                        Cont3Email:=ShippingAgent."Contact3 Email";
                    END;
                    CLEAR(FileName);
                    IF SalesInvoiceHeader.FINDSET THEN REPEAT ValueEntry.RESET;
                            ValueEntry.SETRANGE("Document No.", SalesInvoiceHeader."No.");
                            ValueEntry.SETRANGE(Adjustment, FALSE);
                            IF ValueEntry.FINDFIRST THEN BEGIN
                                ILE.RESET;
                                ILE.SETRANGE("Entry No.", ValueEntry."Item Ledger Entry No.");
                                IF ILE.FINDFIRST THEN BEGIN
                                    PostedQtyHdr.RESET;
                                    PostedQtyHdr.SETRANGE("Lot No.", ILE."Lot No.");
                                    PostedQtyHdr.SETRANGE(Approved, TRUE);
                                    IF PostedQtyHdr.FINDSET THEN BEGIN
                                        ValueEntry1.RESET;
                                        ValueEntry1.SETCURRENTKEY("Document No.", "Posting Date");
                                        ValueEntry1.SETRANGE(ValueEntry1."Document No.", SalesInvoiceHeader."No.");
                                        CLEAR(QLTCertificate);
                                        QLTCertificate.SETTABLEVIEW(ValueEntry1); //Uncomment
                                        QLTCertificate.SalesInvoice(SalesInvoiceHeader."No.", SalesInvoiceHeader."Posting Date", SalesInvoiceHeader."External Document No.", SalesInvoiceHeader."Bill-to Name", SalesInvoiceHeader."Ship-to Name", ABS(ValueEntry1."Item Ledger Entry Quantity"), SalesInvoiceHeader."Sell-to Customer No.");
                                        EVALUATE(IntVar, COPYSTR(SalesInvoiceHeader."No.", STRLEN(SalesInvoiceHeader."No.") - 4, 5));
                                        //SSD Check
                                        FileName:=FORMAT(IntVar);
                                        //path := 'c:\COA_Inv\';
                                        //FileName := path + FileName;
                                        //FileName1 := FileName;
                                        i:=i + 1;
                                        // QLTCertificate.SaveAsPdf(FileName1);
                                        // TempSalesInvHeader.INIT;
                                        // TempSalesInvHeader."No." := COPYSTR(FileName, 2, 20);
                                        // TempSalesInvHeader.Remarks := FileName;
                                        // TempSalesInvHeader.INSERT;
                                        // IF CheckQc(SalesInvoiceHeader."No.") THEN
                                        //     SMTPMail.AddAttachment(FileName, FileName1);
                                        Clear(TempBlob);
                                        TempBlob.CreateOutStream(OutStream);
                                        CLEAR(QLTCertificate);
                                        QLTCertificate.SETTABLEVIEW(ValueEntry1); //Uncomment
                                        QLTCertificate.SalesInvoice(SalesInvoiceHeader."No.", SalesInvoiceHeader."Posting Date", SalesInvoiceHeader."External Document No.", SalesInvoiceHeader."Bill-to Name", SalesInvoiceHeader."Ship-to Name", ABS(ValueEntry1."Item Ledger Entry Quantity"), SalesInvoiceHeader."Sell-to Customer No.");
                                        QLTCertificate.SaveAs('', ReportFormat::Pdf, OutStream);
                                        //ValueEntry1.SetRecFilter();
                                        //RecRef.GetTable(ValueEntry1);
                                        //RecRef.SetRecFilter();
                                        //if Report.SaveAs(Report::"Certificate of Analysis.PSI", '', ReportFormat::Pdf, OutStream, RecRef) then begin
                                        TempBlob.CreateInStream(InStream);
                                        Base64Txt:=Base64Convert.ToBase64(InStream, true);
                                        EmailMessage.AddAttachment(FileName + '.pdf', 'application/pdf', Base64Txt);
                                    //Email.Enqueue(EmailMessage);
                                    //end;
                                    //SSD Check
                                    END;
                                END;
                            END;
                        UNTIL SalesInvoiceHeader.NEXT = 0;
                    ShipingName:='';
                    IF ShippingAgent1.GET(SalesInvoiceHeader."Actual Shipping Agent code")THEN ShipingName:=ShippingAgent1.Name;
                    EmailMessage.AppendToBody('<table border="1" cellpadding="3" style="border-style: solid; border-width: 1px">');
                    EmailMessage.AppendToBody('<tr>');
                    EmailMessage.AppendToBody('<td><font face="arial" size ="2">Transporter Name</font></td>');
                    EmailMessage.AppendToBody('<td><font face="arial" size ="2">' + ShipingName + '</font></td>');
                    EmailMessage.AppendToBody('</tr>');
                    EmailMessage.AppendToBody('<tr>');
                    EmailMessage.AppendToBody('<td><font face="arial" size ="2">Transport Method</font></td>');
                    EmailMessage.AppendToBody('<td><font face="arial" size ="2">' + FORMAT(SalesInvoiceHeader."Transport Method") + '</font></td>');
                    EmailMessage.AppendToBody('</tr>');
                    EmailMessage.AppendToBody('<tr>');
                    EmailMessage.AppendToBody('<td><font face="arial" size ="2">Shipment Method Code</font></td>');
                    EmailMessage.AppendToBody('<td><font face="arial" size ="2">' + FORMAT(SalesInvoiceHeader."Shipment Method Code") + '</font></td>');
                    EmailMessage.AppendToBody('</tr>');
                    EmailMessage.AppendToBody('<tr>');
                    EmailMessage.AppendToBody('<td><font face="arial" size ="2">LR_RR No.</font></td>');
                    EmailMessage.AppendToBody('<td><font face="arial" size ="2">' + FORMAT(SalesInvoiceHeader."LR/RR No.") + '</font></td>');
                    EmailMessage.AppendToBody('</tr>');
                    EmailMessage.AppendToBody('<tr>');
                    EmailMessage.AppendToBody('<td><font face="arial" size ="2">E-Way Bill No.</font></td>');
                    EmailMessage.AppendToBody('<td><font face="arial" size ="2">' + FORMAT(SalesInvoiceHeader."ST38 No") + '</font></td>');
                    EmailMessage.AppendToBody('</tr>');
                    EmailMessage.AppendToBody('<tr>');
                    EmailMessage.AppendToBody('<td><font face="arial" size ="2">Expected Delivery Date</font></td>');
                    EmailMessage.AppendToBody('<td><font face="arial" size ="2">' + FORMAT(SalesInvoiceHeader."Expected Delivery Date") + '</font></td>');
                    EmailMessage.AppendToBody('</tr>');
                    EmailMessage.AppendToBody('<tr>');
                    EmailMessage.AppendToBody('<td><font face="arial" size ="2">Tracking Site</font></td>');
                    EmailMessage.AppendToBody('<td><font face="arial" size ="2">' + FORMAT(TrackingSite) + '</font></td>');
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
                    if EnvironmentInformation.IsProduction()then begin
                        IF SPEmail <> '' THEN CCMailList.AddRange(SPEmail.Split(';'));
                        IF SalesPerson."Resp. CCare Exe. Email Id" <> '' THEN CCMailList.AddRange(SalesPerson."Resp. CCare Exe. Email Id".Split(';'));
                    end;
                    //SSD Email Entries
                    //SSD Email Entries
                    EmailMessage.AppendToBody('</font>');
                    CLEAR(MailSend);
                    IF SalesInvoiceHeader.FINDSET THEN REPEAT ValueEntry.RESET;
                            ValueEntry.SETRANGE("Document No.", SalesInvoiceHeader."No.");
                            ValueEntry.SETRANGE(Adjustment, FALSE);
                            IF ValueEntry.FINDFIRST THEN BEGIN
                                ILE.RESET;
                                ILE.SETRANGE("Entry No.", ValueEntry."Item Ledger Entry No.");
                                IF ILE.FINDFIRST THEN BEGIN
                                    PostedQtyHdr.RESET;
                                    PostedQtyHdr.SETRANGE("Lot No.", ILE."Lot No.");
                                    PostedQtyHdr.SETRANGE(Approved, TRUE);
                                    IF PostedQtyHdr.FINDSET THEN BEGIN
                                        IF MailSend = FALSE THEN IF NOT SalesInvoiceHeader."Send Mail Without COA" THEN BEGIN
                                                //Email.Enqueue(EmailMessage);//SSD Check
                                                MailSend:=TRUE;
                                            END;
                                        IF SalesInvoiceHeader."Send Mail Without COA" THEN BEGIN //Add begin Alle 10122021
                                            SalesInvoiceHeader."Send Mail Again With COA":=TRUE;
                                            SalesInvoiceHeader."Send Mail Again With COA Date":=WORKDATE; //Alle 10122021
                                            SalesInvoiceHeader."Send Mail Again With COA Time":=TIME; //Alle 10122021
                                            SalesInvoiceHeader.MODIFY;
                                        END
                                        ELSE
                                        BEGIN //Add begin Alle 10122021
                                            IF CheckQc(SalesInvoiceHeader."No.")THEN BEGIN //Alle 31122021
                                                SalesInvoiceHeader."Send Mail With COA":=TRUE;
                                                SalesInvoiceHeader."Send Mail Capture Date":=WORKDATE;
                                                SalesInvoiceHeader."Send Mail Capture Time":=TIME;
                                                SalesInvoiceHeader.MODIFY;
                                            END;
                                        END;
                                        COMMIT;
                                        //as END;
                                        //ALLE 08012019
                                        IF CheckQc(SalesInvoiceHeader."No.")THEN BEGIN //Alle 31122021
                                            DispatchMailSend.RESET;
                                            DispatchMailSend.SETRANGE("No.", SalesInvoiceHeader."No.");
                                            IF NOT DispatchMailSend.FINDFIRST THEN BEGIN
                                                DispatchMailSend.INIT;
                                                DispatchMailSend."No.":=SalesInvoiceHeader."No.";
                                                DispatchMailSend.INSERT;
                                            END;
                                        END; // Alle 31122021
                                    //ALLE 08012019
                                    END;
                                END;
                            END;
                            //SSD Email Entries
                            //SSD Email Entries
                            SSDEmailEntries.Init();
                            SSDEmailEntries."Entry No.":=GetLastEntryNo();
                            SSDEmailEntries."TO Mail ID":=EmailId;
                            SSDEmailEntries."CC Mail ID":=TechnicalEmailid + ';' + SPEmail + ';' + SalesPerson."Resp. CCare Exe. Email Id";
                            SSDEmailEntries."BCC Mail ID":='ykuntal@zavenir.com';
                            SSDEmailEntries."Sales Order Email":=EmailId;
                            SSDEmailEntries."Technical Email ID":=TechnicalEmailid;
                            SSDEmailEntries."Invoice No.":=SalesInvoiceHeader."No.";
                            SSDEmailEntries."LR No":=SalesInvoiceHeader."LR/RR No.";
                            SSDEmailEntries."Customer No.":=SalesInvoiceHeader."Sell-to Customer No.";
                            SSDEmailEntries."Customer Name":=SalesInvoiceHeader."Sell-to Customer Name";
                            SSDEmailEntries.Subject:=SubjectMSG;
                            SSDEmailEntries."Sales Person Email":=SPEmail;
                            SSDEmailEntries."Resp. CCare Exe. Email Id":=SalesPerson."Resp. CCare Exe. Email Id";
                            SSDEmailEntries."Sales Order No.":=SalesInvoiceHeader."Order/Scd. No.";
                            SSDEmailEntries.Insert();
                        //SSD Email Entries
                        //SSD Email Entries
                        UNTIL SalesInvoiceHeader.NEXT = 0;
                END;
                COMMIT;
                //For COA Not Approved
                CLEAR(MailSend);
                SalesInvoiceHeader.RESET;
                SalesInvoiceHeader.SETCURRENTKEY("Sell-to Customer No.", "LR/RR No.", "No.");
                SalesInvoiceHeader.SETRANGE("Sell-to Customer No.", SalesInvoiceHeader2."Sell-to Customer No.");
                SalesInvoiceHeader.SetRange("No.", SalesInvoiceHeader2."No.");
                SalesInvoiceHeader.SETRANGE("Mail Send Dispatch Detail", FALSE);
                SalesInvoiceHeader.SETRANGE("LR/RR No.", SalesInvoiceHeader2."LR/RR No.");
                SalesInvoiceHeader.SETRANGE("Send Mail With COA", FALSE);
                SalesInvoiceHeader.SETRANGE("Send Mail Without COA", FALSE);
                SalesInvoiceHeader.SETFILTER("Posting Date", '>%1', 20220401D);
                SalesInvoiceHeader.SetFilter("No.", '%1', 'ZDPSI2400170');
                IF SalesInvoiceHeader.FINDSET THEN BEGIN
                    Clear(MailList);
                    TempSalesInvHeader.DELETEALL;
                    //SSD
                    CLEAR(EmailId);
                    Clear(CCMailList);
                    Clear(BCCMailList);
                    Clear(SPEmail);
                    IF Customer.GET(SalesInvoiceHeader."Sell-to Customer No.")THEN;
                    IF SalesHeader.GET(SalesHeader."Document Type"::Order, SalesInvoiceHeader."Order/Scd. No.")THEN BEGIN
                        IF SalesHeader."Cust EMail" <> '' THEN EmailId:=SalesHeader."Cust EMail";
                    END;
                    IF SalesPerson.GET(SalesInvoiceHeader."Salesperson Code")THEN BEGIN
                        SPName:=SalesPerson.Name;
                        SPPhNo:=SalesPerson."Phone No.";
                        SPEmail:=SalesPerson."E-Mail";
                    END;
                    if EnvironmentInformation.IsProduction()then begin
                        IF SPEmail <> '' THEN CCMailList.AddRange(SPEmail.Split(';'));
                        IF SalesPerson."Resp. CCare Exe. Email Id" <> '' THEN CCMailList.AddRange(SalesPerson."Resp. CCare Exe. Email Id".Split(';'));
                    end;
                    // if EnvironmentInformation.IsProduction() then
                    //     EmailMessage.Create(MailList, StrSubstNo(Suubject2, SalesInvoiceHeader."LR/RR No.", Customer.Name), '', true, CCMailList, BCCMailList)
                    // else begin
                    //     Clear(MailList);
                    //     MailList.Add('sunil@ssdynamics.co.in');
                    //     MailList.Add('hyadav@zavenir.com');
                    //     MailList.Add('ykuntal@zavenir.com');
                    //     EmailMessage.Create(MailList, StrSubstNo(Suubject2, SalesInvoiceHeader."LR/RR No.", Customer.Name), '', true);
                    // end;
                    //MailList.Add('hyadav@zavenir.com');//SSD Check 
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
                    i:=0;
                    //SSD Check
                    // CLEAR(FileName);
                    // FileName := 'COA-' + FORMAT(i);
                    // path := 'C:\Mail\';
                    // FileName := path + FileName + '.PDF';
                    // IF EXISTS(FileName) THEN
                    //     ERASE(FileName); 
                    //     //SSD Check
                    SLEEP(1000);
                    i:=0;
                    CLEAR(FileName);
                    IF SalesInvoiceHeader.FINDSET THEN REPEAT ValueEntry.RESET;
                            ValueEntry.SETRANGE("Document No.", SalesInvoiceHeader."No.");
                            ValueEntry.SETRANGE(Adjustment, FALSE);
                            IF ValueEntry.FINDFIRST THEN BEGIN
                                ILE.RESET;
                                ILE.SETRANGE("Entry No.", ValueEntry."Item Ledger Entry No.");
                                IF ILE.FINDFIRST THEN BEGIN
                                    PostedQtyHdr.RESET;
                                    PostedQtyHdr.SETRANGE("Lot No.", ILE."Lot No.");
                                    PostedQtyHdr.SETRANGE(Approved, TRUE);
                                    IF NOT PostedQtyHdr.FINDSET THEN BEGIN
                                        Clear(InvNoStr);
                                        Clear(CustAss_AcNo);
                                        InvNoStr:=COPYSTR(SalesInvoiceHeader."No.", STRLEN(SalesInvoiceHeader."No.") - 4, 5);
                                        IF Cust.GET(SalesInvoiceHeader."Sell-to Customer No.")THEN CustAss_AcNo:=Cust."Our Account No.";
                                        SalesInvoiceHeader.CALCFIELDS(SalesInvoiceHeader.Amount); //SSD Check Amount to customer
                                        EmailMessage.AppendToBody('<tr>');
                                        EmailMessage.AppendToBody('<td widht="20"><font face="arial" size ="2">' + FORMAT(InvNoStr) + '</font></td>');
                                        EmailMessage.AppendToBody('<td widht="20"><font face="arial" size ="2">' + FORMAT(SalesInvoiceHeader."Posting Date") + '</font></td>');
                                        EmailMessage.AppendToBody('<td widht="20"><font face="arial" size ="2">' + FORMAT(SalesInvoiceHeader.Amount) + '</font></td>'); //SSD Check Amt to Cust
                                        EmailMessage.AppendToBody('<td widht="20"><font face="arial" size ="2">' + FORMAT(SalesInvoiceHeader."External Document No.") + '</font></td>');
                                        EmailMessage.AppendToBody('<td widht="20"><font face="arial" size ="2">' + FORMAT(SalesInvoiceHeader."Order/Scd. No.") + '</font></td>');
                                        EmailMessage.AppendToBody('</tr>');
                                    END;
                                END;
                            END;
                        UNTIL SalesInvoiceHeader.NEXT = 0;
                    EmailMessage.AppendToBody('</table>');
                    EmailMessage.AppendToBody('<br><br>');
                    EmailMessage.AppendToBody('<table border="1" cellpadding="3" style="border-style: solid; border-width: 1px">');
                    EmailMessage.AppendToBody('<tr>');
                    EmailMessage.AppendToBody('<td><b><font face="arial" size ="2">Consignor with Vendor Code</font></b></td>');
                    IF CustAss_AcNo <> '' THEN EmailMessage.AppendToBody('<td>' + '<font face="arial" size ="2">' + CompanyInfo.Name + '(' + CustAss_AcNo + ')</font>' + '</td>')
                    ELSE
                        EmailMessage.AppendToBody('<td>' + '<font face="arial" size ="2">' + CompanyInfo.Name + '</font>' + '</td>');
                    EmailMessage.AppendToBody('</tr>');
                    EmailMessage.AppendToBody('<tr>');
                    EmailMessage.AppendToBody('<td><b><font face="arial" size ="2">Sell to Customer Code & Name</font></b></td>');
                    EmailMessage.AppendToBody('<td><font face="arial" size ="2">' + FORMAT(SalesInvoiceHeader."Sell-to Customer No.") + '-' + FORMAT(SalesInvoiceHeader."Sell-to Customer Name") + '</font></td>');
                    EmailMessage.AppendToBody('</tr>');
                    EmailMessage.AppendToBody('<tr>');
                    EmailMessage.AppendToBody('<td><b><font face="arial" size ="2">Bill To Customer Code & Name</font></b></td>');
                    EmailMessage.AppendToBody('<td><font face="arial" size ="2">' + FORMAT(SalesInvoiceHeader."Bill-to Customer No.") + '-' + FORMAT(SalesInvoiceHeader."Bill-to Name") + '</font></td>');
                    EmailMessage.AppendToBody('</tr>');
                    EmailMessage.AppendToBody('<tr>');
                    EmailMessage.AppendToBody('<td><b><font face="arial" size ="2">Sales Person & Contact No.</font></b></td>');
                    EmailMessage.AppendToBody('<td><font face="arial" size ="2">' + FORMAT(SPName) + ' ; ' + FORMAT(SPPhNo) + ' ; ' + FORMAT(SPEmail) + '</font></td>');
                    EmailMessage.AppendToBody('</tr>');
                    EmailMessage.AppendToBody('<tr>');
                    EmailMessage.AppendToBody('<td><b><font face="arial" size ="2">CCare Person & Contact No.</font></b></td>');
                    EmailMessage.AppendToBody('<td><font face="arial" size ="2">' + FORMAT(SalesPerson."Resp. CCare Exe. Name") + ' ; ' + FORMAT(SalesPerson."Resp. CCare Exe. Phone No.") + ' ; ' + FORMAT(SalesPerson."Resp. CCare Exe. Email Id") + '</font></td>');
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
                    j:=1;
                    IF SalesInvoiceHeader.FINDSET THEN REPEAT ValueEntry.RESET;
                            ValueEntry.SETRANGE("Document No.", SalesInvoiceHeader."No.");
                            ValueEntry.SETRANGE(Adjustment, FALSE);
                            IF ValueEntry.FINDFIRST THEN BEGIN
                                ILE.RESET;
                                ILE.SETRANGE("Entry No.", ValueEntry."Item Ledger Entry No.");
                                IF ILE.FINDFIRST THEN BEGIN
                                    PostedQtyHdr.RESET;
                                    PostedQtyHdr.SETRANGE("Lot No.", ILE."Lot No.");
                                    PostedQtyHdr.SETRANGE(Approved, TRUE);
                                    IF NOT PostedQtyHdr.FINDSET THEN BEGIN
                                        InvNoStr:='';
                                        InvNoStr:=COPYSTR(SalesInvoiceHeader."No.", STRLEN(SalesInvoiceHeader."No.") - 4, 5);
                                        EmailMessage.AppendToBody('<tr>');
                                        EmailMessage.AppendToBody('<td colspan="6"><b><font face="arial" size ="2">INVOICE NO.' + FORMAT(InvNoStr) + '</b></td>');
                                        EmailMessage.AppendToBody('</tr>');
                                        SalesInvoiceLine.RESET;
                                        SalesInvoiceLine.SETRANGE("Document No.", SalesInvoiceHeader."No.");
                                        SalesInvoiceLine.SETFILTER(Type, '%1', 2);
                                        IF SalesInvoiceLine.FINDSET THEN REPEAT IF SalesLine.GET(SalesLine."Document Type"::Order, SalesInvoiceLine."Order No.", SalesInvoiceLine."Order Line No.")THEN;
                                                EmailMessage.AppendToBody('<tr>');
                                                EmailMessage.AppendToBody('<td><font face="arial" size ="2">' + FORMAT(j) + '</td>');
                                                EmailMessage.AppendToBody('<td><font face="arial" size ="2">' + FORMAT(SalesInvoiceLine."No.") + '-' + FORMAT(SalesInvoiceLine.Description) + ' ' + FORMAT(SalesInvoiceLine."Description 2") + '</font></td>');
                                                EmailMessage.AppendToBody('<td><font face="arial" size ="2">' + FORMAT(SalesInvoiceLine."Item Reference No.") + '</font></td>');
                                                EmailMessage.AppendToBody('<td><font face="arial" size ="2">' + FORMAT(SalesLine.Quantity) + '</font></td>');
                                                EmailMessage.AppendToBody('<td><font face="arial" size ="2">' + FORMAT(SalesInvoiceLine.Quantity) + ' ' + FORMAT(SalesInvoiceLine."Unit of Measure Code") + '</font></td>');
                                                EmailMessage.AppendToBody('<td><font face="arial" size ="2">' + FORMAT(SalesLine."Short Close Qty.") + '</font></td>');
                                                EmailMessage.AppendToBody('<td><font face="arial" size ="2">' + FORMAT(SalesLine."Outstanding Quantity") + '</font></td>');
                                                EmailMessage.AppendToBody('</tr>');
                                                j+=1;
                                            UNTIL SalesInvoiceLine.NEXT = 0;
                                    END;
                                END;
                            END;
                        UNTIL SalesInvoiceHeader.NEXT = 0;
                    EmailMessage.AppendToBody('</table>');
                    EmailMessage.AppendToBody('</br></br>');
                    Cont1Email:='';
                    Cont1Mobile:='';
                    Cont1Name:='';
                    Cont2Email:='';
                    Cont2Mobile:='';
                    Cont2Name:='';
                    IF Customer1.GET(SalesInvoiceHeader."Sell-to Customer No.")THEN;
                    ActualTransporterContDetail.RESET;
                    ActualTransporterContDetail.SETRANGE("Shipping Agent Code", SalesInvoiceHeader."Actual Shipping Agent code");
                    ActualTransporterContDetail.SETRANGE("Post Code", Customer1."Post Code");
                    IF ActualTransporterContDetail.FINDFIRST THEN Cont1Email:=ActualTransporterContDetail."Contact1 Email";
                    Cont1Mobile:=ActualTransporterContDetail."Contact1 Mob";
                    Cont1Name:=ActualTransporterContDetail."Contact1 Name";
                    Cont2Email:=ActualTransporterContDetail."Contact2 Email";
                    Cont2Mobile:=ActualTransporterContDetail."Contact2 Mob";
                    Cont2Name:=ActualTransporterContDetail."Contact2 Name";
                    IF ShippingAgent.GET(SalesInvoiceHeader."Actual Shipping Agent code")THEN BEGIN
                        TrackingSite:=ShippingAgent."Internet Address";
                        Cont3Name:=ShippingAgent."Contact3 Name";
                        Cont3Mobile:=ShippingAgent."Contact3 Mobile";
                        Cont3Email:=ShippingAgent."Contact3 Email";
                    END;
                    CLEAR(FileName);
                    ShipingName:='';
                    IF ShippingAgent1.GET(SalesInvoiceHeader."Actual Shipping Agent code")THEN ShipingName:=ShippingAgent1.Name;
                    EmailMessage.AppendToBody('<table border="1" cellpadding="3" style="border-style: solid; border-width: 1px">');
                    EmailMessage.AppendToBody('<tr>');
                    EmailMessage.AppendToBody('<td><font face="arial" size ="2">Transporter Name</font></td>');
                    EmailMessage.AppendToBody('<td><font face="arial" size ="2">' + ShipingName + '</font></td>');
                    EmailMessage.AppendToBody('</tr>');
                    EmailMessage.AppendToBody('<tr>');
                    EmailMessage.AppendToBody('<td><font face="arial" size ="2">Transport Method</font></td>');
                    EmailMessage.AppendToBody('<td><font face="arial" size ="2">' + FORMAT(SalesInvoiceHeader."Transport Method") + '</font></td>');
                    EmailMessage.AppendToBody('</tr>');
                    EmailMessage.AppendToBody('<tr>');
                    EmailMessage.AppendToBody('<td><font face="arial" size ="2">Shipment Method Code</font></td>');
                    EmailMessage.AppendToBody('<td><font face="arial" size ="2">' + FORMAT(SalesInvoiceHeader."Shipment Method Code") + '</font></td>');
                    EmailMessage.AppendToBody('</tr>');
                    EmailMessage.AppendToBody('<tr>');
                    EmailMessage.AppendToBody('<td><font face="arial" size ="2">LR_RR No.</font></td>');
                    EmailMessage.AppendToBody('<td><font face="arial" size ="2">' + FORMAT(SalesInvoiceHeader."LR/RR No.") + '</font></td>');
                    EmailMessage.AppendToBody('</tr>');
                    EmailMessage.AppendToBody('<tr>');
                    EmailMessage.AppendToBody('<td><font face="arial" size ="2">E-Way Bill No.</font></td>');
                    EmailMessage.AppendToBody('<td><font face="arial" size ="2">' + FORMAT(SalesInvoiceHeader."ST38 No") + '</font></td>');
                    EmailMessage.AppendToBody('</tr>');
                    EmailMessage.AppendToBody('<tr>');
                    EmailMessage.AppendToBody('<td><font face="arial" size ="2">Expected Delivery Date</font></td>');
                    EmailMessage.AppendToBody('<td><font face="arial" size ="2">' + FORMAT(SalesInvoiceHeader."Expected Delivery Date") + '</font></td>');
                    EmailMessage.AppendToBody('</tr>');
                    EmailMessage.AppendToBody('<tr>');
                    EmailMessage.AppendToBody('<td><font face="arial" size ="2">Tracking Site</font></td>');
                    EmailMessage.AppendToBody('<td><font face="arial" size ="2">' + FORMAT(TrackingSite) + '</font></td>');
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
                    EmailMessage.AppendToBody('</font>');
                    CLEAR(MailSend);
                    IF SalesInvoiceHeader.FINDSET THEN //  REPEAT
                        ValueEntry.RESET;
                    ValueEntry.SETRANGE("Document No.", SalesInvoiceHeader."No.");
                    ValueEntry.SETRANGE(Adjustment, FALSE);
                    IF ValueEntry.FINDFIRST THEN BEGIN
                        REPEAT ILE.RESET;
                            ILE.SETRANGE("Entry No.", ValueEntry."Item Ledger Entry No.");
                            IF ILE.FINDFIRST THEN BEGIN
                                PostedQtyHdr.RESET;
                                PostedQtyHdr.SETRANGE("Lot No.", ILE."Lot No.");
                                PostedQtyHdr.SETRANGE(Approved, TRUE);
                                IF NOT PostedQtyHdr.FINDFIRST THEN BEGIN
                                    //SSD Check
                                    IF MailSend = FALSE THEN // Email.Enqueue(EmailMessage);
                                        //SMTPMail.Send();//as
                                        //SSD Check
                                        MailSend:=TRUE;
                                    SalesInvoiceHeader."Send Mail Without COA":=TRUE;
                                    SalesInvoiceHeader."Send Mail Capture Date W/O COA":=WORKDATE; //Alle 10122021
                                    SalesInvoiceHeader."Send Mail Capture Time W/O COA":=TIME; //Alle 10122021
                                    SalesInvoiceHeader.MODIFY;
                                    COMMIT;
                                //as END;
                                END;
                            END;
                        UNTIL ValueEntry.NEXT = 0;
                    END;
                // UNTIL SalesInvoiceHeader.NEXT = 0;
                END;
                //SSD Email Entries
                SSDEmailEntries.Init();
                SSDEmailEntries."Entry No.":=GetLastEntryNo();
                SSDEmailEntries."TO Mail ID":=EmailId;
                SSDEmailEntries."CC Mail ID":=TechnicalEmailid + ';' + SPEmail + ';' + SalesPerson."Resp. CCare Exe. Email Id";
                SSDEmailEntries."BCC Mail ID":='ykuntal@zavenir.com';
                SSDEmailEntries."Sales Order Email":=EmailId;
                SSDEmailEntries."Technical Email ID":=TechnicalEmailid;
                SSDEmailEntries."Invoice No.":=SalesInvoiceHeader."No.";
                SSDEmailEntries."LR No":=SalesInvoiceHeader."LR/RR No.";
                SSDEmailEntries."Customer No.":=SalesInvoiceHeader."Sell-to Customer No.";
                SSDEmailEntries."Customer Name":=SalesInvoiceHeader."Sell-to Customer Name";
                SSDEmailEntries.Subject:=Suubject2;
                SSDEmailEntries."Sales Person Email":=SPEmail;
                SSDEmailEntries."Resp. CCare Exe. Email Id":=SalesPerson."Resp. CCare Exe. Email Id";
                SSDEmailEntries.Insert();
                //SSD Email Entries
                COMMIT;
            until SalesInvoiceHeader2.Next() = 0;
    end;
    local procedure CheckQc(DocNo: Code[20])QCCheck: Boolean var
        SalesInvoiceLineQC: Record "Sales Invoice Line";
        ValueEntryQc: Record "Value Entry";
        ILEQC: Record "Item Ledger Entry";
        PostedQtyHdrQC: Record "SSD Posted Quality Order Hdr";
    begin
        ValueEntryQc.RESET;
        ValueEntryQc.SETRANGE("Document No.", DocNo);
        ValueEntryQc.SETRANGE(Adjustment, FALSE);
        IF ValueEntryQc.FINDSET THEN REPEAT ILEQC.RESET;
                ILEQC.SETRANGE("Entry No.", ValueEntryQc."Item Ledger Entry No.");
                IF ILEQC.FINDFIRST THEN BEGIN
                    PostedQtyHdrQC.RESET;
                    PostedQtyHdrQC.SETRANGE("Lot No.", ILEQC."Lot No.");
                    PostedQtyHdrQC.SETRANGE(Approved, TRUE);
                    IF PostedQtyHdrQC.FINDFIRST THEN BEGIN
                        QCCheck:=TRUE END
                    ELSE
                    BEGIN
                        QCCheck:=FALSE;
                        EXIT(QCCheck);
                    END;
                END;
            UNTIL ValueEntryQc.NEXT = 0;
    end;
    procedure GetLastEntryNo()LastEntryNo: Integer var
        SSDEmailEntries: Record "SSD Email Entries";
    begin
        if SSDEmailEntries.FindLast()then LastEntryNo:=SSDEmailEntries."Entry No." + 1
        else
            LastEntryNo:=1;
    end;
    procedure DeleteBlankLinePR()
    begin
        PurchRcptLine.Reset();
        PurchRcptLine.SetRange("Document No.", '');
        PurchRcptLine.SetRange("Line No.", 0);
        if PurchRcptLine.FindSet()then PurchRcptLine.Delete();
    end;
    procedure UpdateRcptLine()
    var
        PostedWhseReceiptLine: Record "Posted Whse. Receipt Line";
        PurchaseReceiptLine: Record "Purch. Rcpt. Line";
    begin
        // PurchRcptLine.Reset();
        // PurchRcptLine.SetRange("Document No.", '');
        // PurchRcptLine.SetRange("Line No.", 0);
        // if PurchRcptLine.FindSet() then
        //     PurchRcptLine.Delete();
        PostedWhseReceiptLine.Reset();
        PostedWhseReceiptLine.SetRange("Posting Date", 20230401D, Today);
        PostedWhseReceiptLine.SetRange("Posted Source Document", PostedWhseReceiptLine."Posted Source Document"::"Posted Receipt");
        //PostedWhseReceiptLine.SetRange("Posted Source No.", 'ZDPPR2400008');
        if PostedWhseReceiptLine.FindSet()then repeat PurchaseReceiptLine.Reset();
                PurchaseReceiptLine.SetRange("Document No.", PostedWhseReceiptLine."Posted Source No.");
                PurchaseReceiptLine.SetRange("Line No.", PostedWhseReceiptLine."Source Line No.");
                if PurchaseReceiptLine.FindFirst()then begin
                    PurchaseReceiptLine."Posted Whse. Rcpt No.":=PostedWhseReceiptLine."No.";
                    PurchaseReceiptLine."Posted Whse. Rcpt Line No.":=PostedWhseReceiptLine."Gate Line No.";
                    PurchaseReceiptLine.Modify();
                end;
            until PostedWhseReceiptLine.Next() = 0;
    end;
    procedure RemoveitemTracking()
    Var
        ReservationEntry: Record "Reservation Entry";
        SalesLine: Record "Sales Line";
        SalesHeader: Record "Sales Header";
        SalesInvLine: Record "Sales Invoice Line";
    begin
        SalesHeader.Reset();
        SalesHeader.SetRange("Posting Date", 20230401D, Today);
        if SalesHeader.FindSet()then repeat SalesLine.Reset();
                SalesLine.SetRange("Document No.", SalesHeader."No.");
                SalesLine.SetRange("Document Type", SalesLine."Document Type"::Order);
                SalesLine.SetRange("Document Subtype", SalesLine."Document Subtype"::Despatch);
                if SalesLine.FindSet()then repeat SalesInvLine.Reset();
                        SalesInvLine.SetRange("Despatch Slip No.", SalesLine."Document No.");
                        SalesInvLine.SetRange("System-Created Entry", false);
                        SalesInvLine.SetRange("Despatch Slip Line No.", SalesLine."Line No.");
                        if SalesInvLine.FindFirst()then begin
                            ReservationEntry.Reset();
                            ReservationEntry.SetRange("Source ID", SalesLine."Document No.");
                            if ReservationEntry.FindFirst()then ReservationEntry.Delete();
                        end;
                    until SalesLine.Next() = 0;
            until SalesHeader.Next() = 0;
    end;
    procedure UpdateGateEntryInPI()
    var
        PurchInvHeader: Record "Purch. Inv. Header";
        PurchInvLine: Record "Purch. Inv. Line";
        PurchRcptLine: Record "Purch. Rcpt. Line";
        PurchInvHeader2: Record "Purch. Inv. Header";
    begin
        PurchInvHeader.Reset();
        PurchInvHeader.SetRange("Posting Date", 20230401D, Today);
        PurchInvHeader.SetFilter("Gate Entry No.", '%1', '');
        if PurchInvHeader.FindSet()then repeat PurchInvLine.Reset();
                PurchInvLine.SetRange("Document No.", PurchInvHeader."No.");
                PurchInvLine.SetRange("System-Created Entry", false);
                if PurchInvLine.FindLast()then begin
                    PurchRcptLine.Reset();
                    PurchRcptLine.SetRange("Document No.", PurchInvLine."Receipt No.");
                    if PurchRcptLine.FindFirst()then begin
                        PurchInvHeader2.Reset();
                        PurchInvHeader2.SetRange("No.", PurchInvHeader."No.");
                        if PurchInvHeader2.FindFirst()then begin
                            PurchInvHeader2."Gate Entry No.":=PurchRcptLine."Gate Entry no.";
                            PurchInvHeader2."Gate Entry Date":=PurchRcptLine."Gate Entry Date";
                            PurchInvHeader2.Modify();
                        end;
                    end;
                end;
            until PurchInvHeader.Next() = 0;
    end;
    procedure UpdatePostedSale()
    var
        SalesInvHeader: Record "Sales Invoice Header";
        SalesInvLine: Record "Sales Invoice Line";
    begin
        SalesInvHeader.SetRange("No.", 'ZDPSI2313467');
        if SalesInvHeader.FindFirst()then begin
            SalesInvHeader."VAT Bus. Posting Group":='';
            SalesInvHeader.Modify();
        end;
        SalesInvLine.SetRange("Document No.", 'ZDPSI2313467');
        if SalesInvLine.FindSet()then repeat SalesInvLine."VAT Bus. Posting Group":='';
                SalesInvLine."VAT Prod. Posting Group":='';
                SalesInvLine.Modify();
            until SalesInvLine.Next() = 0;
    end;
    procedure updatePOVAT()
    var
        SalesHeader: Record "Sales Header";
        SalesLine: Record "Sales Line";
        SalesInvHeader: Record "Sales Invoice Header";
        SalesInvLine: Record "Sales Invoice Line";
        PurchaseHeader: Record "Purchase Header";
        PurchaseLine: Record "Purchase Line";
        PurchaseInvHeader: Record "Purch. Inv. Header";
        PurchaseInvLine: Record "Purch. Inv. Line";
        PurchRcptHeader: Record "Purch. Rcpt. Header";
        PurchRcptLine: Record "Purch. Rcpt. Line";
    begin
        // PurchaseHeader.Reset();
        // PurchaseHeader.SetRange("Posting Date", 20230401D, Today);
        // if PurchaseHeader.FindSet() then
        //     repeat
        //         PurchaseHeader."VAT Bus. Posting Group" := '';
        //         PurchaseHeader.Modify();
        //         PurchaseLine.Reset();
        //         PurchaseLine.SetRange("Document No.", PurchaseHeader."No.");
        //         if PurchaseLine.FindSet() then
        //             repeat
        //                 PurchaseLine."VAT Bus. Posting Group" := '';
        //                 PurchaseLine."VAT Prod. Posting Group" := '';
        //                 PurchaseLine.Modify();
        //             until PurchaseLine.Next() = 0;
        //     until PurchaseHeader.Next() = 0;
        PurchaseHeader.Reset();
        PurchaseHeader.SetRange("Posting Date", 20220401D, Today);
        if PurchaseHeader.FindSet()then begin
            PurchaseHeader.ModifyAll("VAT Bus. Posting Group", '');
        end;
        PurchaseLine.Reset();
        PurchaseLine.SetRange("Order Date", 20220401D, Today);
        if PurchaseLine.FindSet()then begin
            PurchaseLine.ModifyAll("VAT Bus. Posting Group", '');
            PurchaseLine.ModifyAll("VAT Prod. Posting Group", '');
        end;
        PurchRcptHeader.Reset();
        PurchRcptHeader.SetRange("Posting Date", 20220401D, Today);
        if PurchRcptHeader.FindSet()then PurchRcptHeader.ModifyAll("VAT Bus. Posting Group", '');
        PurchRcptLine.Reset();
        PurchRcptLine.SetRange("Posting Date", 20220401D, Today);
        if PurchRcptLine.FindSet()then begin
            PurchRcptLine.ModifyAll("VAT Bus. Posting Group", '');
            PurchRcptLine.ModifyAll("VAT Prod. Posting Group", '');
        end;
        PurchaseInvHeader.Reset();
        PurchaseInvHeader.SetRange("Posting Date", 20220401D, Today);
        if PurchaseInvHeader.FindSet()then PurchaseInvHeader.ModifyAll("VAT Bus. Posting Group", '');
        PurchaseInvLine.Reset();
        PurchaseInvLine.SetRange("Posting Date", 20220401D, Today);
        if PurchaseInvLine.FindSet()then begin
            PurchaseInvLine.ModifyAll("VAT Bus. Posting Group", '');
            PurchaseInvLine.ModifyAll("VAT Prod. Posting Group", '');
        end;
        SalesHeader.Reset();
        SalesHeader.SetRange("Posting Date", 20220401D, Today);
        if SalesHeader.FindSet()then SalesHeader.ModifyAll("VAT Bus. Posting Group", '');
        SalesLine.Reset();
        SalesLine.SetRange("Shipment Date", 20220401D, Today);
        if SalesLine.FindSet()then begin
            SalesLine.ModifyAll("VAT Bus. Posting Group", '');
            SalesLine.ModifyAll("VAT Prod. Posting Group", '');
        end;
        SalesInvHeader.Reset();
        SalesInvHeader.SetRange("Posting Date", 20220401D, Today);
        if SalesInvHeader.FindSet()then SalesInvHeader.ModifyAll("VAT Bus. Posting Group", '');
        SalesInvLine.Reset();
        SalesInvLine.SetRange("Posting Date", 20220401D, Today);
        if SalesInvLine.FindSet()then begin
            SalesInvLine.ModifyAll("VAT Bus. Posting Group", '');
            SalesInvLine.ModifyAll("VAT Prod. Posting Group", '');
        end;
    end;
    procedure RemoveVATMaster()
    var
        Item: Record Item;
        Vendor: Record Vendor;
        GLAccount: Record "G/L Account";
        Customer: Record Customer;
        FA: Record "Fixed Asset";
    begin
        if Item.FindSet()then item.ModifyAll("VAT Prod. Posting Group", '');
        if Vendor.FindSet()then Vendor.ModifyAll("VAT Bus. Posting Group", '');
        if Customer.FindSet()then Customer.ModifyAll("VAT Bus. Posting Group", '');
        if FA.FindSet()then FA.ModifyAll("VAT Product Posting Group", '');
        if GLAccount.FindSet()then begin
            GLAccount.ModifyAll("VAT Bus. Posting Group", '');
            GLAccount.ModifyAll("VAT Prod. Posting Group", '');
        end;
    end;
    procedure UpdatePOstCode()
    var
        SalesInvoiceHeader: Record "Sales Invoice Header";
    begin
        SalesInvoiceHeader.Get('ZDPSI2404205');
        SalesInvoiceHeader."Sell-to Post Code":='360005';
        SalesInvoiceHeader."Bill-to Post Code":='360005';
        SalesInvoiceHeader."Ship-to Post Code":='360005';
        SalesInvoiceHeader.Modify();
    end;
    procedure UpdateSalesInvHeader()
    var
        PostedSalesinv: Record "Sales Invoice Header";
        PostedSalesInvLine: Record "Sales Invoice Line";
    begin
        PostedSalesinv.SetFilter("No.", '%1|%2', 'ZKPSI2301244', 'ZKPSI2301243');
        if PostedSalesinv.FindSet()then repeat PostedSalesinv.crminsertflag:=false;
                PostedSalesinv.Modify();
            until PostedSalesinv.Next() = 0;
        PostedSalesInvLine.SetFilter("Document No.", '%1|%2', 'ZKPSI2301244', 'ZKPSI2301243');
        if PostedSalesInvLine.FindSet()then repeat PostedSalesInvLine.crminsertflag:=false;
                PostedSalesInvLine.Modify();
            until PostedSalesInvLine.Next() = 0;
    end;
    procedure UpdateCurrencyCode()
    var
        PostedSalesInv: Record "Sales Invoice Header";
        CustLedgerEntry: Record "Cust. Ledger Entry";
    begin
        PostedSalesInv.Reset();
        PostedSalesInv.SetRange("Currency Code", 'INR');
        if PostedSalesInv.FindSet()then PostedSalesInv.ModifyAll("Currency Code", '');
        CustLedgerEntry.Reset();
        CustLedgerEntry.SetRange("Currency Code", 'INR');
        IF CustLedgerEntry.FindSet()then CustLedgerEntry.ModifyAll("Currency Code", '');
    end;
}
