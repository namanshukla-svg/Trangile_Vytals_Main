Codeunit 50005 "Alle Events"
{
    Permissions = TableData "Sales Invoice Header" = rm;

    trigger OnRun()
    begin
    end;

    var
        ActualTransporterContDetail: Record "SSD Actual Tpt Cont Detail";
        NoSeries: Record "No. Series";
        NoSeriesLine: Record "No. Series Line";
        NoSeriesManagement: Codeunit "No. Series - Batch";
        EnvironmentInformation: Codeunit "Environment Information";

    //IG_AS Validating Insrance Policy in Sales Order
    [EventSubscriber(ObjectType::Table, Database::"Sales Header", OnAfterOnInsert, '', false, false)]
    local procedure "Sales Header_OnAfterOnInsert"(var SalesHeader: Record "Sales Header")
    Var
        InsuranceRec: Record "SSD Insurance Setup";
    begin
        if SalesHeader."Document Type" = SalesHeader."Document Type"::Order then begin
            InsuranceRec.Reset;
            InsuranceRec.SetCurrentkey("Policy Status", "Insurance Starting Date", "Insurance Expiry Date");
            InsuranceRec.SetRange("Policy Status", InsuranceRec."policy status"::Active);
            InsuranceRec.SetFilter(InsuranceRec."Insurance Starting Date", '<=%1', SalesHeader."Posting Date");
            InsuranceRec.SetFilter(InsuranceRec."Insurance Expiry Date", '>=%1', SalesHeader."Posting Date");
            if InsuranceRec.FindFirst then begin
                SalesHeader.Validate("Applied to Insurance Policy", InsuranceRec."Insurance Policy No.");
                SalesHeader.Validate("Type of Invoice", SalesHeader."Type of Invoice"::Normal);
            end;
        end;
    end;
    //IG_AS Validating Insrance Policy in Sales Order

    [EventSubscriber(Objecttype::Page, 50067, 'TestFields', '', false, false)]
    local procedure TestFieldOnGatePass(GatePassHeader: Record "SSD Gate Pass Header")
    begin
        GatePassHeader.TestField(Date);
        GatePassHeader.TestField("Vehicle No.");
        GatePassHeader.TestField("Driver Name");
        GatePassHeader.TestField("Transporter Code");
        GatePassHeader.TestField("Bilty No.");
    end;

    [EventSubscriber(ObjectType::Table, Database::Customer, 'OnAfterModifyEvent', '', false, false)]
    local procedure OnModifyCustomer(var Rec: Record Customer; var xRec: Record Customer; RunTrigger: Boolean)
    var
        UserSetupL: Record "User Setup";
        TextLocal50001: label 'You don''t have editing permission to modify this. Contact System Administrator.';
    begin
        //<<<<Alle[Z]
        if RunTrigger then begin
            if UserSetupL.Get(UserId) then if not UserSetupL."Master Editing Permission" then Error(TextLocal50001);
            Rec."Last Modified User ID" := UserId;
            Rec.Modify;
        end;
        //>>>>Alle[Z]
    end;

    [EventSubscriber(ObjectType::Table, Database::Vendor, 'OnAfterModifyEvent', '', false, false)]
    local procedure OnModifyVendor(var Rec: Record Vendor; var xRec: Record Vendor; RunTrigger: Boolean)
    var
        UserSetupL: Record "User Setup";
        TextLocal50001: label 'You don''t have editing permission to modify this. Contact System Administrator.';
    begin
        //<<<<Alle[Z]
        if RunTrigger then begin
            if UserSetupL.Get(UserId) then if not UserSetupL."Master Editing Permission" then Error(TextLocal50001);
        end;
        //>>>>Alle[Z]
    end;

    [EventSubscriber(ObjectType::Table, Database::"SSD Indent Header", 'OnAfterDeleteEvent', '', false, false)]
    local procedure OnDeleteIndentHeader(var Rec: Record "SSD Indent Header"; RunTrigger: Boolean)
    var
        IndentLine: Record "SSD Indent Line";
        InvtComnt: Record "Inventory Comment Line";
    begin
        if RunTrigger then begin
            IndentLine.SetRange("Document No.", Rec."No.");
            if IndentLine.Find('-') then IndentLine.DeleteAll;
        end;
    end;

    [EventSubscriber(ObjectType::Table, Database::"SSD Posted Indent Header", 'OnAfterDeleteEvent', '', false, false)]
    local procedure OnDeletePostedIndentHeader(var Rec: Record "SSD Posted Indent Header"; RunTrigger: Boolean)
    var
        PostedIndentLine: Record "SSD Posted Indent Line";
        InvtComnt: Record "Inventory Comment Line";
    begin
        if RunTrigger then begin
            PostedIndentLine.SetRange("Document No.", Rec."No.");
            if PostedIndentLine.Find('-') then PostedIndentLine.DeleteAll;
        end;
    end;

    [EventSubscriber(ObjectType::Table, Database::"SSD RGP Header", 'OnAfterDeleteEvent', '', false, false)]
    local procedure OnDeleteRGPHeader(var Rec: Record "SSD RGP Header"; RunTrigger: Boolean)
    var
        RGPLine: Record "SSD RGP Line";
    begin
        if RunTrigger then
            if Rec.RGPLineExist then begin
                RGPLine.SetRange("Document Type", Rec."Document Type");
                RGPLine.SetRange("Document No.", Rec."No.");
                RGPLine.DeleteAll(); //ALLE Opt
                                     //   IF RGPLine.FIND('-') THEN BEGIN
                                     //    REPEAT
                                     //     RGPLine.DELETE;
                                     //    UNTIL RGPLine.NEXT=0;
                                     //   END;
            end;
    end;

    [EventSubscriber(ObjectType::Table, Database::"SSD Sampling Test Line", 'OnAfterDeleteEvent', '', false, false)]
    local procedure OnDeleteSamplngTestLine(var Rec: Record "SSD Sampling Test Line"; RunTrigger: Boolean)
    var
        rQualityComent: Record "SSD Quality Comments";
    begin
        if RunTrigger then begin
            rQualityComent.Reset;
            rQualityComent.SetRange(rQualityComent.TableId, Database::"SSD Sampling Test Line");
            rQualityComent.SetRange(rQualityComent."Doc. No.", Rec."Test Code");
            rQualityComent.SetRange(rQualityComent."Line No.", Rec."Line No.");
            if rQualityComent.Find('-') then rQualityComent.DeleteAll;
        end;
    end;

    [EventSubscriber(ObjectType::Table, Database::"SSD Sampling Test Header", 'OnAfterDeleteEvent', '', false, false)]
    local procedure OnDeleteSamplngTestHeader(var Rec: Record "SSD Sampling Test Header"; RunTrigger: Boolean)
    var
        rQualityComent: Record "SSD Quality Comments";
    begin
        if RunTrigger then begin
            rQualityComent.Reset;
            rQualityComent.SetRange(rQualityComent.TableId, Database::"SSD Sampling Test Header");
            rQualityComent.SetRange(rQualityComent."Doc. No.", Rec."No.");
            rQualityComent.SetRange(rQualityComent."Line No.", 0);
            if rQualityComent.Find('-') then rQualityComent.DeleteAll;
        end;
    end;

    [EventSubscriber(ObjectType::Table, Database::"SSD Vendor Eval. Template", 'OnAfterDeleteEvent', '', false, false)]
    local procedure OnDeleteVendorEvalTemp(var Rec: Record "SSD Vendor Eval. Template"; RunTrigger: Boolean)
    var
        rQualityComent: Record "SSD Quality Comments";
        txt00001: label '%1 can not be as %2';
    begin
        if RunTrigger then begin
            if Rec.Status = Rec.Status::Certified then Error(txt00001, Rec.FieldCaption(Status), Format(Rec.Status));
            rQualityComent.Reset;
            rQualityComent.SetRange(rQualityComent.TableId, Database::"SSD Vendor Eval. Template");
            rQualityComent.SetRange(rQualityComent."Doc. No.", Rec."No.");
            rQualityComent.SetRange(rQualityComent."Line No.", 0);
            if rQualityComent.Find('-') then rQualityComent.DeleteAll;
        end;
    end;

    [EventSubscriber(ObjectType::Table, Database::"SSD Vendor Eval. Template Line", 'OnAfterDeleteEvent', '', false, false)]
    local procedure OnDeleteVendorEvalTempLine(var Rec: Record "SSD Vendor Eval. Template Line"; RunTrigger: Boolean)
    var
        rQualityComent: Record "SSD Quality Comments";
    begin
        if RunTrigger then begin
            rQualityComent.Reset;
            rQualityComent.SetRange(rQualityComent.TableId, Database::"SSD Vendor Eval. Template Line");
            rQualityComent.SetRange(rQualityComent."Doc. No.", Rec."Eval. Template No.");
            rQualityComent.SetRange(rQualityComent."Line No.", Rec."Line No.");
            if rQualityComent.Find('-') then rQualityComent.DeleteAll;
        end;
    end;

    [EventSubscriber(ObjectType::Table, Database::"SSD Vendor Eval. Header", 'OnAfterDeleteEvent', '', false, false)]
    local procedure OnDeleteVendorEvalHeader(var Rec: Record "SSD Vendor Eval. Header"; RunTrigger: Boolean)
    var
        rQualityComent: Record "SSD Quality Comments";
        Txt00001: label '%1 must be %2 in order to delete %3';
    begin
        if RunTrigger then begin
            if Rec.Status = Rec.Status::Blanked then Error(Txt00001, Rec.FieldCaption(Status), Format(Rec.Status), Rec.TableCaption);
            rQualityComent.Reset;
            rQualityComent.SetRange(rQualityComent.TableId, Database::"SSD Vendor Eval. Header");
            rQualityComent.SetRange(rQualityComent."Doc. No.", Rec."No.");
            rQualityComent.SetRange(rQualityComent."Line No.", 0);
            if rQualityComent.Find('-') then rQualityComent.DeleteAll;
        end;
    end;

    [EventSubscriber(ObjectType::Table, Database::"SSD Vendor Eval. Line", 'OnAfterDeleteEvent', '', false, false)]
    local procedure OnDeleteVendorEvalLine(var Rec: Record "SSD Vendor Eval. Line"; RunTrigger: Boolean)
    var
        rQualityComent: Record "SSD Quality Comments";
    begin
        if RunTrigger then begin
            rQualityComent.Reset;
            rQualityComent.SetRange(rQualityComent.TableId, Database::"SSD Vendor Eval. Line");
            rQualityComent.SetRange(rQualityComent."Doc. No.", Rec."Document No.");
            rQualityComent.SetRange(rQualityComent."Line No.", Rec."Line No.");
            if rQualityComent.Find('-') then rQualityComent.DeleteAll;
        end
    end;

    [EventSubscriber(ObjectType::Table, Database::"SSD Sampling Temp. Header", 'OnAfterDeleteEvent', '', false, false)]
    local procedure OnDeleteSamplingTempHeader(var Rec: Record "SSD Sampling Temp. Header"; RunTrigger: Boolean)
    var
        SamplingTempLineLocal: Record "SSD Sampling Temp. Line";
        rQualityComent: Record "SSD Quality Comments";
    begin
        if RunTrigger then begin
            SamplingTempLineLocal.Reset;
            SamplingTempLineLocal.SetRange("Document No.", Rec."No.");
            if SamplingTempLineLocal.Find('-') then SamplingTempLineLocal.DeleteAll(true);
            rQualityComent.Reset;
            rQualityComent.SetRange(rQualityComent.TableId, Database::"SSD Sampling Temp. Header");
            rQualityComent.SetRange(rQualityComent."Doc. No.", Rec."No.");
            rQualityComent.SetRange(rQualityComent."Line No.", 0);
            if rQualityComent.Find('-') then rQualityComent.DeleteAll;
        end;
    end;

    [EventSubscriber(ObjectType::Table, Database::"SSD Quality Order Header", 'OnAfterDeleteEvent', '', false, false)]
    local procedure OnDeleteQualityOrderHeader(var Rec: Record "SSD Quality Order Header"; RunTrigger: Boolean)
    var
        QualityOrderLineLocal: Record "SSD Quality Order Line";
        rQualityComent: Record "SSD Quality Comments";
    begin
        if RunTrigger then begin
            Rec.TestField(Status, Rec.Status::Open);
            Rec.TestField(Finished, false);
            QualityOrderLineLocal.Reset;
            QualityOrderLineLocal.SetRange("Document No.", Rec."No.");
            if QualityOrderLineLocal.Find('-') then QualityOrderLineLocal.DeleteAll(true);
            rQualityComent.Reset;
            rQualityComent.SetRange(rQualityComent.TableId, Database::"SSD Quality Order Header");
            rQualityComent.SetRange(rQualityComent."Doc. No.", Rec."No.");
            rQualityComent.SetRange(rQualityComent."Line No.", 0);
            if rQualityComent.Find('-') then rQualityComent.DeleteAll;
        end;
    end;

    [EventSubscriber(ObjectType::Table, Database::"SSD Requision Slip Header", 'OnAfterDeleteEvent', '', false, false)]
    local procedure OnDeleteRequisitionSlipHeader(var Rec: Record "SSD Requision Slip Header"; RunTrigger: Boolean)
    var
        ReqLineRec: Record "SSD Requision Slip Line";
    begin
        if RunTrigger then begin
            ReqLineRec.Reset;
            ReqLineRec.SetRange(ReqLineRec."Req. Slip Document No.", Rec."Req. Slip No.");
            ReqLineRec.DeleteAll();
            // IF ReqLineRec.FINDFIRST THEN
            // REPEAT
            //  ReqLineRec.DELETE;
            // UNTIL ReqLineRec.NEXT=0;
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Line", 'OnBeforeInsertGLEntryBuffer', '', false, false)]
    local procedure DocumentInsertAfterPosting(var TempGLEntryBuf: Record "G/L Entry" temporary; var GenJournalLine: Record "Gen. Journal Line")
    var
        Document: Record "SSD Document";
        DocumentREC: Record "SSD Document";
        DocAccMgt: Report "Document Access Management";
    begin
        //ALLE 1.07 >>
        //DocumentSetUp.GET;
        Document.Reset;
        Document.SetCurrentkey("Table No.", "Reference No. 1", "Reference No. 2", "Reference No. 3");
        Document.SetRange("Table No.", Database::"Gen. Journal Line");
        Document.SetRange("Reference No. 2", GenJournalLine."Document No.");
        if Document.FindFirst then
            repeat
                if Document.HasContent(true) then begin
                    DocumentREC.Copy(Document);
                    DocumentREC."In Use By" := '';
                    DocumentREC."Modified Date" := 0D;
                    DocumentREC."Modified By" := '';
                    if Document."Document Type" = Document."document type"::Document then begin
                        DocumentREC."No." := '';
                        DocumentREC."Table No." := Database::"G/L Entry";
                        DocumentREC."Reference No. 2" := TempGLEntryBuf."Document No.";
                        DocumentREC.Insert(true);
                    end
                    else begin
                        DocumentREC."No." := IncStr(Document."No.");
                        if DocumentREC."No." = '' then DocumentREC."No." := Document."No." + '01';
                        while not DocumentREC.Insert do DocumentREC."No." := IncStr(DocumentREC."No.");
                        // Clone template fields as well
                        //IF DocumentRec."Table No." <> 0 THEN
                        //  TmplField.CloneTemplate("No.",DocumentRec."No.");
                    end;
                    if not DocAccMgt.RecInDB(Document) then DocAccMgt.Copy(Document, DocumentREC);
                end;
            until Document.Next = 0;
        //ALLE 1.07 <<
    end;

    [EventSubscriber(ObjectType::Table, Database::"SSD Quality Order Header", 'OnAfterValidateEvent', 'Is NABL Accredited', false, false)]
    local procedure QualityOrderParameterType(var Rec: Record "SSD Quality Order Header"; var xRec: Record "SSD Quality Order Header"; CurrFieldNo: Integer)
    begin
        //Alle_290818
        if Rec."Is NABL Accredited" then begin
            Rec."ULR No." := NoSeriesManagement.GetNextNo('Q-MONFP', WorkDate, true);
            Rec.Modify;
        end;
        //Alle_290818
    end;

    [EventSubscriber(ObjectType::Table, Database::"Sales Invoice Header", 'OnAfterValidateEvent', 'Actual Delivery Date', false, false)]
    local procedure ActualCaptureDeliveryDateOnvalidate(var Rec: Record "Sales Invoice Header"; var xRec: Record "Sales Invoice Header"; CurrFieldNo: Integer)
    begin
        Rec."Actual Delivery Capture Date" := WorkDate;
        Rec."Capture Time" := Time;
    end;

    [EventSubscriber(ObjectType::Table, Database::"Sales Invoice Header", 'OnAfterValidateEvent', 'LR/RR Date', false, false)]
    local procedure LRDateOnValidate(var Rec: Record "Sales Invoice Header"; var xRec: Record "Sales Invoice Header"; CurrFieldNo: Integer)
    var
        UserSetup: Record "User Setup";
    begin
        UserSetup.Get(UserId);
        UserSetup.TestField("ALLow LR No.");
        Rec."LR/RR No. Capture Date" := WorkDate;
        Rec."LR/RR No. Capture Time" := Time;
    end;

    [EventSubscriber(Objecttype::Page, 21, 'OnModifyRecordEvent', '', false, false)]
    procedure SendMailForCustomer(var Rec: Record Customer; var xRec: Record Customer; var AllowModify: Boolean)
    var
    //     //SSDU SMTPMailSetup: Record "SMTP Mail Setup";
    //     //SSDU SMTPMail: Codeunit "SMTP Mail";
    //     Customer: Record Customer;
    //     Name: Text;
    //     BlockDate: DateTime;
    //     BliockTime: Time;
    //     CustNo: Code[10];
    //     Text50010: label ' <br/> ';
    //     Text59999: label '<html>';
    //     Text60000: label '<Table>';
    //     Text60001: label '<TR Border=4>';
    //     Text60002: label '<TD  width=200 Align=Left>';
    //     Text60003: label '</TD>';
    //     Text60004: label '</TR>';
    //     Text60005: label '</Table>';
    //     Text60006: label '</html>';
    //     Text60007: label '<TD  width=500 Align=Left>';
    //     Text60008: label '<TD  width=100 Align=Center>';
    //     Text60009: label '<TD Align=Left>';
    //     Text60010: label '<TD  width=800 Align=right>';
    //     Text60011: label '<BR>';
    //     Text60012: label '<B>';
    //     Text60013: label '</B>';
    //     Text60014: label '<TD  width=850 Align=right>';
    //     Text60015: label '<font size="3"> ';
    //     Text60016: label '</font>';
    //     Text50022: label 'Mail Sent Successfully !!!!';
    //     Text50023: label 'This is to advice that the following shipment is being despatched from our factory as follows.';
    //     Text50024: label '<TD  width=1000 Align=Left>';
    //     Text50026: label '<TR>';
    //     Text50027: label '<table border="1" width="70%">';
    //     Text50028: label '<TH>';
    //     Text50029: label '</TH>';
    //     Text50030: label '<td width="20%">';
    //     Text50031: label '<td width="50%">';
    //     Text50032: label '<FONT SIZE=6 FACE="Sans Serif">';
    //     Text50041: label '<TD  width=.5 Align=Center>';
    //     Text50042: label 'Thank for your valuable order';
    //     Text50043: label ' (';
    //     Text50044: label ')';
    //     SalespersonPurchaser: Record "Salesperson/Purchaser";
    //     NSM: Text;
    //     RSM: Text;
    //     EMail: Text;
    //     CCare: Text;
    //     TempBlob: Codeunit "Temp Blob";
    //     EmailC: Codeunit Email;
    //     EmailMessage: Codeunit "Email Message";
    //     Base64Convert: Codeunit "Base64 Convert";
    //     DocNo: Code[20];
    //     InStream: InStream;
    //     OutStream: OutStream;
    //     InStream2: InStream;
    //     OutStream2: OutStream;
    //     Base64Txt: Text;
    //     Base64Txt2: Text;
    //     MailList: List of [Text];
    //     CCList: List of [Text];
    //     BCCList: List of [Text];
    //     SubjectMSG: Label 'blocked';
    //     BodyMsg: Label 'Dear Sir or Madam,<br><br>';
    //     EnvironmentInformation: Codeunit "Environment Information";
    //     ToMailID: Text;
    begin
        //     Clear(MailList);
        //     Clear(CCList);
        //     Clear(BCCList);
        //     Clear(EmailMessage);
        //     Clear(ToMailID);
        //     Rec."Last Date Modified" := Today;
        if Rec.Blocked = xRec.Blocked then Rec.Blocked := Rec.Blocked::All;
        //     //<<Alle 100221
        //     if SalespersonPurchaser.Get(Rec."Salesperson Code") then begin
        //         NSM := SalespersonPurchaser."NSM Email ID";
        //         RSM := SalespersonPurchaser."RSM Email ID";
        //         EMail := SalespersonPurchaser."E-Mail";
        //         CCare := SalespersonPurchaser."Resp. CCare Exe. Email Id";
        //     end;
        //     //Alle 100221>>
        //     //Alle_050219
        //     //SSDU Commented
        //     if Rec.Blocked = Rec.Blocked::All then begin
        //         //SMTPMail.CreateMessage('Zavenir Daubert India Private Limited', SMTPMailSetup."User ID", '', 'Blocked', '', true);
        //         //SMTPMail.AddCC('lmohan@zavenir.com;agupta@zavenir.com;ccare.north@zavenir.com;ccare.west@zavenir.com;ccare.south@zavenir.com;gurgaon.dispatch@zavenir.com;tbhardwaj@zavenir.com');
        //         If Rec."Gen. Bus. Posting Group" = 'SP' then begin
        //             ToMailID := Rec."E-Mail";
        //             MailList.AddRange(Rec."E-Mail".Split(';'));
        //         end;
        //         CCList.Add('lmohan@zavenir.com');
        //         CCList.Add('admin@zavenir.com');
        //         CCList.Add('gurgaon.dispatch@zavenir.com');
        //         CCList.Add('ccare@zavenir.com');
        //         if RSM <> '' then
        //             CCList.AddRange(RSM.Split(';'));
        //         if NSM <> '' then
        //             CCList.AddRange(NSM.Split(';'));
        //         if EMail <> '' then
        //             CCList.AddRange(EMail.Split(';'));
        //         if CCare <> '' then
        //             CCList.AddRange(CCare.Split(';'));
        //         if EnvironmentInformation.IsProduction() then begin
        //             EmailMessage.Create(MailList, SubjectMSG, '', true, CCList, BCCList)
        //         end else begin
        //             Clear(MailList);
        //             Clear(CCList);
        //             //MailList.Add('sunil@ssdynamics.co.in');
        //             //MailList.Add('hyadav@zavenir.com');
        //             MailList.Add('ykuntal@zavenir.com');
        //             EmailMessage.Create(MailList, SubjectMSG, '', true);
        //         end;
        //         EmailMessage.AppendToBody('Dear Sir,');
        //         EmailMessage.AppendToBody('<br><br>');
        //         If Rec."Gen. Bus. Posting Group" <> 'SP' then begin
        //             if (Rec.Blocked = Rec.Blocked::Ship) then
        //                 EmailMessage.AppendToBody('This Customer Is Blocked For Ship')
        //             else
        //                 if
        //               (Rec.Blocked = Rec.Blocked::Invoice) then
        //                     EmailMessage.AppendToBody('This Customer Is Blocked For Invoice')
        //                 else
        //                     EmailMessage.AppendToBody('This Customer Is Blocked For All');
        //         end else begin
        //             if (Rec.Blocked = Rec.Blocked::Ship) then
        //                 EmailMessage.AppendToBody('This Customer Is Blocked For Ship. You are requested to please reach out to your Sales Account Manager / Customer Care Representative')
        //             else
        //                 if
        //               (Rec.Blocked = Rec.Blocked::Invoice) then
        //                     EmailMessage.AppendToBody('This Customer Is Blocked For Invoice. You are requested to please reach out to your Sales Account Manager / Customer Care Representative')
        //                 else
        //                     EmailMessage.AppendToBody('This Customer Is Blocked For All. You are requested to please reach out to your Sales Account Manager / Customer Care Representative');
        //         end;
        //         EmailMessage.AppendToBody('<br><br>');
        //         EmailMessage.AppendToBody(Text60004);
        //         EmailMessage.AppendToBody(Text60005);
        //         EmailMessage.AppendToBody(Text60006);
        //         EmailMessage.AppendToBody(Text60011);
        //         EmailMessage.AppendToBody(Text59999);
        //         EmailMessage.AppendToBody(Text60001);
        //         EmailMessage.AppendToBody(Text60004);
        //         EmailMessage.AppendToBody(Text60005);
        //         EmailMessage.AppendToBody(Text60006);
        //         EmailMessage.AppendToBody(Text60004);
        //         EmailMessage.AppendToBody(Text60005);
        //         EmailMessage.AppendToBody(Text60006);
        //         EmailMessage.AppendToBody(Text60011);
        //         EmailMessage.AppendToBody(Text50027 + Text50026 + Text50030 + Text60012 + 'Customer No.' + Text60013 + Text60003);
        //         EmailMessage.AppendToBody(Text50030 + Text60012 + 'Customer Name' + Text60013 + Text60003);
        //         EmailMessage.AppendToBody(Text50030 + Text60012 + 'Date And Time' + Text60013 + Text60003);
        //         EmailMessage.AppendToBody(Text60004);
        //         if Customer.Get(Rec."No.") then begin
        //             EmailMessage.AppendToBody(Text50026 + Text50030 + Format(Customer."No.") + Text60003);
        //             EmailMessage.AppendToBody(Text50030 + Format(Customer.Name) + Text60003);
        //             EmailMessage.AppendToBody(Text50030 + Format(CurrentDatetime) + Text60003);
        //             EmailMessage.AppendToBody(Text60004);
        //         end;
        //         EmailMessage.AppendToBody(Text60004);
        //         EmailMessage.AppendToBody(Text60005);
        //         EmailMessage.AppendToBody(Text60006);
        //         EmailMessage.AppendToBody(Text60011);
        //         EmailMessage.AppendToBody(Text60004);
        //         EmailMessage.AppendToBody(Text60005);
        //         EmailMessage.AppendToBody(Text60006);
        //         EmailMessage.AppendToBody(Text60011);
        //         EmailMessage.AppendToBody(Text60004);
        //         EmailMessage.AppendToBody(Text60005);
        //         EmailMessage.AppendToBody(Text60006);
        //         EmailMessage.AppendToBody(Text60011);
        //         EmailMessage.AppendToBody(Text59999);
        //         EmailMessage.AppendToBody(Text60000);
        //         EmailMessage.AppendToBody(Text60001);
        //         EmailMessage.AppendToBody(Text60004);
        //         EmailMessage.AppendToBody(Text60005);
        //         EmailMessage.AppendToBody(Text60006);
        //         EmailMessage.AppendToBody(Text60011);
        //         EmailMessage.AppendToBody('<br><br>');
        //         EmailMessage.AppendToBody('Regards,');
        //         EmailMessage.AppendToBody('<br>');
        //         EmailMessage.AppendToBody('Zavenir Daubert India Private Limited');
        //         EmailMessage.AppendToBody('<br><br>');
        //         //EmailMessage.AppendToBody(ToMailID);//Remove Before live
        //         EMailc.Enqueue(EmailMessage);
        //     end;
        //     if Rec.Blocked = Rec.Blocked::" " then begin
        //         //SMTPMail.CreateMessage('Zavenir Daubert India Private Limited', SMTPMailSetup."User ID", '', 'Unblocked', '', true);
        //         //SMTPMail.AddCC('lmohan@zavenir.com;agupta@zavenir.com;ccare.north@zavenir.com;ccare.west@zavenir.com;ccare.south@zavenir.com;gurgaon.dispatch@zavenir.com;tbhardwaj@zavenir.com');
        //         // SMTPMail.AddCC('lmohan@zavenir.com;agupta@zavenir.com;gurgaon.dispatch@zavenir.com;ccare@zavenir.com');
        //         Clear(MailList);
        //         Clear(CCList);
        //         Clear(BCCList);
        //         CCList.Add('lmohan@zavenir.com');
        //         CCList.Add('admin@zavenir.com');
        //         CCList.Add('gurgaon.dispatch@zavenir.com');
        //         CCList.Add('ccare@zavenir.com');
        //         If Rec."Gen. Bus. Posting Group" = 'SP' then begin
        //             MailList.AddRange(Rec."E-Mail".Split(';'));
        //             ToMailID := Rec."E-Mail";
        //         end;
        //         if RSM <> '' then
        //             CCList.AddRange(RSM.Split(';'));
        //         if NSM <> '' then
        //             CCList.AddRange(NSM.Split(';'));
        //         if EMail <> '' then
        //             CCList.AddRange(EMail.Split(';'));
        //         if CCare <> '' then
        //             CCList.AddRange(CCare.Split(';'));
        //         if EnvironmentInformation.IsProduction() then begin
        //             EmailMessage.Create(MailList, 'Unblocked', '', true, CCList, BCCList)
        //         end else begin
        //             Clear(MailList);
        //             Clear(CCList);
        //             //MailList.AddRange(CCare.Split(';'));
        //             //MailList.Add('hyadav@zavenir.com');
        //             MailList.Add('ykuntal@zavenir.com');
        //             MailList.Add('sunil@ssdynamics.co.in');
        //             EmailMessage.Create(MailList, 'Unblocked', '', true);
        //         end;
        //         EmailMessage.AppendToBody('Dear Sir,');
        //         EmailMessage.AppendToBody('<br><br>');
        //         EmailMessage.AppendToBody('This Customer Is Unblocked.');
        //         EmailMessage.AppendToBody('<br><br>');
        //         EmailMessage.AppendToBody(Text60004);
        //         EmailMessage.AppendToBody(Text60005);
        //         EmailMessage.AppendToBody(Text60006);
        //         EmailMessage.AppendToBody(Text60011);
        //         EmailMessage.AppendToBody(Text59999);
        //         EmailMessage.AppendToBody(Text60001);
        //         EmailMessage.AppendToBody(Text60004);
        //         EmailMessage.AppendToBody(Text60005);
        //         EmailMessage.AppendToBody(Text60006);
        //         EmailMessage.AppendToBody(Text60004);
        //         EmailMessage.AppendToBody(Text60005);
        //         EmailMessage.AppendToBody(Text60006);
        //         EmailMessage.AppendToBody(Text60011);
        //         EmailMessage.AppendToBody(Text50027 + Text50026 + Text50030 + Text60012 + 'Customer No.' + Text60013 + Text60003);
        //         EmailMessage.AppendToBody(Text50030 + Text60012 + 'Customer Name' + Text60013 + Text60003);
        //         EmailMessage.AppendToBody(Text50030 + Text60012 + 'Date And Time' + Text60013 + Text60003);
        //         EmailMessage.AppendToBody(Text60004);
        //         if Customer.Get(Rec."No.") then begin
        //             EmailMessage.AppendToBody(Text50026 + Text50030 + Format(Customer."No.") + Text60003);
        //             EmailMessage.AppendToBody(Text50030 + Format(Customer.Name) + Text60003);
        //             EmailMessage.AppendToBody(Text50030 + Format(CurrentDatetime) + Text60003);
        //             EmailMessage.AppendToBody(Text60004);
        //         end;
        //         EmailMessage.AppendToBody(Text60004);
        //         EmailMessage.AppendToBody(Text60005);
        //         EmailMessage.AppendToBody(Text60006);
        //         EmailMessage.AppendToBody(Text60011);
        //         EmailMessage.AppendToBody(Text60004);
        //         EmailMessage.AppendToBody(Text60005);
        //         EmailMessage.AppendToBody(Text60006);
        //         EmailMessage.AppendToBody(Text60011);
        //         EmailMessage.AppendToBody(Text60004);
        //         EmailMessage.AppendToBody(Text60005);
        //         EmailMessage.AppendToBody(Text60006);
        //         EmailMessage.AppendToBody(Text60011);
        //         EmailMessage.AppendToBody(Text59999);
        //         EmailMessage.AppendToBody(Text60000);
        //         EmailMessage.AppendToBody(Text60001);
        //         EmailMessage.AppendToBody(Text60004);
        //         EmailMessage.AppendToBody(Text60005);
        //         EmailMessage.AppendToBody(Text60006);
        //         EmailMessage.AppendToBody(Text60011);
        //         EmailMessage.AppendToBody('<br><br>');
        //         EmailMessage.AppendToBody('Regards,');
        //         EmailMessage.AppendToBody('<br>');
        //         EmailMessage.AppendToBody('Zavenir Daubert India Private Limited');
        //         // EmailMessage.AppendToBody(ToMailID);//Remove Before live
        //         EmailMessage.AppendToBody('<br><br>');
        //         EmailC.Enqueue(EmailMessage);
        //     end;
        //     //SSDU Commented
        //     //Alle_050219
    end;

    [EventSubscriber(Objecttype::Page, 26, 'OnModifyRecordEvent', '', false, false)]
    procedure SendMailForvendor(var Rec: Record Vendor; var xRec: Record Vendor; var AllowModify: Boolean)
    var
        //SSDU SMTPMailSetup: Record "SMTP Mail Setup";
        //SSDU SMTPMail: Codeunit "SMTP Mail";
        Text50010: label ' <br/> ';
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
        Vendor: Record Vendor;
        Name: Text;
        BlockDate: DateTime;
        BliockTime: Time;
        CustNo: Code[10];
        RecPurhcode: Record "Salesperson/Purchaser";
        cominfo: Record "Company Information";
        TempBlob: Codeunit "Temp Blob";
        EmailC: Codeunit Email;
        EmailMessage: Codeunit "Email Message";
        Base64Convert: Codeunit "Base64 Convert";
        DocNo: Code[20];
        InStream: InStream;
        OutStream: OutStream;
        InStream2: InStream;
        OutStream2: OutStream;
        Base64Txt: Text;
        Base64Txt2: Text;
        MailList: List of [Text];
        CCList: List of [Text];
        BCCList: List of [Text];
        SubjectMSG: Label 'Blocked';
        BodyMsg: Label 'Dear Sir or Madam,<br><br>';
        EnvironmentInformation: Codeunit "Environment Information";
    begin
        Rec."Last Date Modified" := Today;
        //Alle-021120 >>
        //IF Rec.Blocked=xRec.Blocked THEN
        if not (Rec.Blocked = Rec.Blocked::All) and (not Rec."Exclude from Suggest Report" <> xRec."Exclude from Suggest Report") and (not (Rec.Blocked <> xRec.Blocked)) then Rec.Blocked := Rec.Blocked::All;
        //Alle-021120 <<
        //SSDU Commented
        //Alle_050219
        // SMTPMailSetup.Get;
        // if Rec.Blocked = Rec.Blocked::All then begin
        //     cominfo.Get;
        //     if cominfo.Name = 'VYTALS WELLBEING INDIA PRIVATE LIMITED' then
        //         SMTPMail.CreateMessage('Vytals Wellbeing India Private Limited', SMTPMailSetup."User ID", 'jitin.behl@vytals.com;hyadav@zavenir.com', 'Blocked', '', true)
        //     else
        //         SMTPMail.CreateMessage('Zavenir Daubert India Private Limited', SMTPMailSetup."User ID", 'mkawatra@zavenir.com;sgarg@zavenir.com;lmohan@zavenir.com;agupta@zavenir.com', 'Blocked', '', true);
        //     //SMTPMail.AddCC('mkawatra@zavenir.com;sgarg@zavenir.com;lmohan@zavenir.com;agupta@zavenir.com');
        //     EmailMessage.AppendToBody('Dear Sir,');
        //     EmailMessage.AppendToBody('<br><br>');
        //     if (Rec.Blocked = Rec.Blocked::Payment) then
        //         EmailMessage.AppendToBody('This Vendor Is Blocked For Payment')
        //     else
        //         EmailMessage.AppendToBody('This Vendor Is Blocked For All');
        //     EmailMessage.AppendToBody('<br><br>');
        //     EmailMessage.AppendToBody(Text60004);
        //     EmailMessage.AppendToBody(Text60005);
        //     EmailMessage.AppendToBody(Text60006);
        //     EmailMessage.AppendToBody(Text60011);
        //     EmailMessage.AppendToBody(Text59999);
        //     EmailMessage.AppendToBody(Text60001);
        //     EmailMessage.AppendToBody(Text60004);
        //     EmailMessage.AppendToBody(Text60005);
        //     EmailMessage.AppendToBody(Text60006);
        //     EmailMessage.AppendToBody(Text60004);
        //     EmailMessage.AppendToBody(Text60005);
        //     EmailMessage.AppendToBody(Text60006);
        //     EmailMessage.AppendToBody(Text60011);
        //     EmailMessage.AppendToBody(Text50027 + Text50026 + Text50030 + Text60012 + 'Vendor No.' + Text60013 + Text60003);
        //     EmailMessage.AppendToBody(Text50030 + Text60012 + 'Vendor Name' + Text60013 + Text60003);
        //     EmailMessage.AppendToBody(Text50030 + Text60012 + 'Date And Time' + Text60013 + Text60003);
        //     EmailMessage.AppendToBody(Text60004);
        //     if Vendor.Get(Rec."No.") then begin
        //         EmailMessage.AppendToBody(Text50026 + Text50030 + Format(Vendor."No.") + Text60003);
        //         EmailMessage.AppendToBody(Text50030 + Format(Vendor.Name) + Text60003);
        //         EmailMessage.AppendToBody(Text50030 + Format(CurrentDatetime) + Text60003);
        //         EmailMessage.AppendToBody(Text60004);
        //     end;
        //     EmailMessage.AppendToBody(Text60004);
        //     EmailMessage.AppendToBody(Text60005);
        //     EmailMessage.AppendToBody(Text60006);
        //     EmailMessage.AppendToBody(Text60011);
        //     EmailMessage.AppendToBody(Text60004);
        //     EmailMessage.AppendToBody(Text60005);
        //     EmailMessage.AppendToBody(Text60006);
        //     EmailMessage.AppendToBody(Text60011);
        //     EmailMessage.AppendToBody(Text60004);
        //     EmailMessage.AppendToBody(Text60005);
        //     EmailMessage.AppendToBody(Text60006);
        //     EmailMessage.AppendToBody(Text60011);
        //     EmailMessage.AppendToBody(Text59999);
        //     EmailMessage.AppendToBody(Text60000);
        //     EmailMessage.AppendToBody(Text60001);
        //     EmailMessage.AppendToBody(Text60004);
        //     EmailMessage.AppendToBody(Text60005);
        //     EmailMessage.AppendToBody(Text60006);
        //     EmailMessage.AppendToBody(Text60011);
        //     EmailMessage.AppendToBody('<br><br>');
        //     EmailMessage.AppendToBody('Regards,');
        //     EmailMessage.AppendToBody('<br>');
        //     EmailMessage.AppendToBody(cominfo.Name);
        //     EmailMessage.AppendToBody('<br><br>');
        //     SMTPMail.Send;
        // end;
        // if Rec.Blocked = Rec.Blocked::" " then begin
        //     // SMTPMail.CreateMessage('Zavenir Daubert India Private Limited',SMTPMailSetup."User ID",'','Unblocked','',TRUE);
        //     cominfo.Get;
        //     if cominfo.Name = 'VYTALS WELLBEING INDIA PRIVATE LIMITED' then
        //         SMTPMail.CreateMessage('Vytals Wellbeing India Private Limited', SMTPMailSetup."User ID", 'jitin.behl@vytals.com;hyadav@zavenir.com', 'Unblocked', '', true)
        //     else
        //         SMTPMail.CreateMessage('Zavenir Daubert India Private Limited', SMTPMailSetup."User ID", 'mkawatra@zavenir.com;sgarg@zavenir.com;lmohan@zavenir.com;agupta@zavenir.com', 'Unblocked', '', true);
        //     // SMTPMail.AddCC('mkawatra@zavenir.com;sgarg@zavenir.com;lmohan@zavenir.com;agupta@zavenir.com');
        //     EmailMessage.AppendToBody('Dear Sir,');
        //     EmailMessage.AppendToBody('<br><br>');
        //     EmailMessage.AppendToBody('This Vendor Is Unblocked.');
        //     EmailMessage.AppendToBody('<br><br>');
        //     EmailMessage.AppendToBody(Text60004);
        //     EmailMessage.AppendToBody(Text60005);
        //     EmailMessage.AppendToBody(Text60006);
        //     EmailMessage.AppendToBody(Text60011);
        //     EmailMessage.AppendToBody(Text59999);
        //     EmailMessage.AppendToBody(Text60001);
        //     EmailMessage.AppendToBody(Text60004);
        //     EmailMessage.AppendToBody(Text60005);
        //     EmailMessage.AppendToBody(Text60006);
        //     EmailMessage.AppendToBody(Text60004);
        //     EmailMessage.AppendToBody(Text60005);
        //     EmailMessage.AppendToBody(Text60006);
        //     EmailMessage.AppendToBody(Text60011);
        //     EmailMessage.AppendToBody(Text50027 + Text50026 + Text50030 + Text60012 + 'Vendor No.' + Text60013 + Text60003);
        //     EmailMessage.AppendToBody(Text50030 + Text60012 + 'Vendor Name' + Text60013 + Text60003);
        //     EmailMessage.AppendToBody(Text50030 + Text60012 + 'Date And Time' + Text60013 + Text60003);
        //     EmailMessage.AppendToBody(Text60004);
        //     if Vendor.Get(Rec."No.") then begin
        //         EmailMessage.AppendToBody(Text50026 + Text50030 + Format(Vendor."No.") + Text60003);
        //         EmailMessage.AppendToBody(Text50030 + Format(Vendor.Name) + Text60003);
        //         EmailMessage.AppendToBody(Text50030 + Format(CurrentDatetime) + Text60003);
        //         EmailMessage.AppendToBody(Text60004);
        //     end;
        //     EmailMessage.AppendToBody(Text60004);
        //     EmailMessage.AppendToBody(Text60005);
        //     EmailMessage.AppendToBody(Text60006);
        //     EmailMessage.AppendToBody(Text60011);
        //     EmailMessage.AppendToBody(Text60004);
        //     EmailMessage.AppendToBody(Text60005);
        //     EmailMessage.AppendToBody(Text60006);
        //     EmailMessage.AppendToBody(Text60011);
        //     EmailMessage.AppendToBody(Text60004);
        //     EmailMessage.AppendToBody(Text60005);
        //     EmailMessage.AppendToBody(Text60006);
        //     EmailMessage.AppendToBody(Text60011);
        //     EmailMessage.AppendToBody(Text59999);
        //     EmailMessage.AppendToBody(Text60000);
        //     EmailMessage.AppendToBody(Text60001);
        //     EmailMessage.AppendToBody(Text60004);
        //     EmailMessage.AppendToBody(Text60005);
        //     EmailMessage.AppendToBody(Text60006);
        //     EmailMessage.AppendToBody(Text60011);
        //     EmailMessage.AppendToBody('<br><br>');
        //     EmailMessage.AppendToBody('Regards,');
        //     EmailMessage.AppendToBody('<br>');
        //     EmailMessage.AppendToBody(cominfo.Name);
        //     EmailMessage.AppendToBody('<br><br>');
        //     SMTPMail.Send;
        // end;
        // //Alle_050219
        //SSDU Commented
    end;

    procedure SendMailForShortClose(Rec: Record "Sales Line")
    var
        //SSDU SMTPMailSetup: Record "SMTP Mail Setup";
        //SSDU SMTPMail: Codeunit "SMTP Mail";
        Customer: Record Customer;
        BCCEmailID: Text;
        SalespersonPurchaser: Record "Salesperson/Purchaser";
        SalesLine: Record "Sales Line";
        SalesHeader: Record "Sales Header";
        Text50010: label ' <br/> ';
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
        Text50023: label 'Your subject order has been short closed in our ERP system, details of which mentioned below:';
        Text50024: label '<TD  width=1000 Align=Left>';
        Text50026: label '<TR>';
        Text50027: label '<table border="1" width="70%">';
        Text50028: label '<TH>';
        Text50029: label '</TH>';
        Text50030: label '<td width="17%" Align=center>';
        Text50031: label '<td width="50%">';
        Text50032: label '<FONT SIZE=6 FACE="Sans Serif">';
        Text50042: label 'Thank for your valuable order';
        Text50046: label 'Actual Order Quantity:';
        Text50047: label 'Short Closed Quantity :';
        Text50048: label 'Balance Quantity :';
        Text50049: label 'UOM:';
        Text50050: label 'Zavenir’s Remark:';
        Text50051: label 'Please let us know for any further clarification.';
        Text50052: label 'Regards';
        Text50053: label 'ZD Team';
        Text50054: label 'Dear Sir/Madam,';
        Text50055: label 'Sales Partner Order#';
        Text50056: label '<table border="1" width="70%">';
        Text50041: label '<TD  width=5 Align=Center>';
        Text50043: label '<td width=400 align=center>';
        Text50044: label '<td width=150 align=center>';
        Text50045: label '<td width=450 align=center>';
        Text50057: label '<td width="15%" Align=center>';
        Text50058: label 'Please let us know for any further clarification.';
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
        MailList: List of [Text];
        CCMailList: List of [Text];
        BCCMailList: List of [Text];
        Suubject2: Label 'Short Closure of %1 Order %2 dated %3';
        ActualID: Label 'Atual Mail - TO Mail - %1, CC Mail - %2, BCC Mail %3';
        ActualTO: Text;
        ActualCC: Text;
        ActualBCC: Text;
    begin
        //SSDU Commented
        //ALLE-NM 26062019
        Clear(CCMailList);
        Clear(BCCEmailID);
        Clear(MailList);
        Clear(BCCMailList);
        Clear(Email);
        Clear(EmailMessage);
        Clear(ActualTO);
        Clear(ActualCC);
        Clear(ActualBCC);
        SalesLine.Get(Rec."Document Type", Rec."Document No.", Rec."Line No.");
        CCMailList.add('Ccare@zavenir.com');
        CCMailList.Add('pdas@zavenir.com');
        BCCMailList.add('ithelpdesk@zavenir.com');
        BCCMailList.add('mkumar@zavenir.com');
        BCCMailList.add('ptomar@zavenir.com');
        //ActualBCC := 'pkumar2@zavenir.com;Ccare@zavenir.com;admin@zavenir.com;mkumar@zavenir.com;ptomar@zavenir.com';
        SalesHeader.Reset();
        SalesHeader.Get(Rec."Document Type", Rec."Document No.");
        Customer.Reset();
        if Customer.Get(SalesHeader."Bill-to Customer No.") then;
        if Customer."E-Mail" <> '' then begin
            if SalespersonPurchaser.Get(SalesHeader."Salesperson Code") then;
            if SalespersonPurchaser."E-Mail" <> '' then CCMailList.AddRange(SalespersonPurchaser."E-Mail".Split(';'));
            MailList.AddRange(Customer."E-Mail".Split(';'));
            // ActualTO := Customer."E-Mail";
            // ActualCC := SalespersonPurchaser."E-Mail";
            //SMTPMailSetup.Get;
            // SMTPMail.CreateMessage('Zavenir Daubert India Private Limited', SMTPMailSetup."User ID", Customer."E-Mail", 'Short Closure of ' +
            //  Customer.Name + ' Order ' + Rec."Document No." + ' dated ' + Format(SalesHeader."Order Date"), '', true);
            if EnvironmentInformation.IsProduction() then
                EmailMessage.Create(MailList, StrSubstNo(Suubject2, Customer.Name, Rec."Document No.", Format(SalesHeader."Order Date")), '', true, CCMailList, BCCMailList)
            else begin
                Clear(MailList);
                // MailList.Add('sunil@ssdynamics.co.in');
                //MailList.Add('hyadav@zavenir.com');
                MailList.Add('ykuntal@zavenir.com');
                EmailMessage.Create(MailList, StrSubstNo(Suubject2, Customer.Name, Rec."Document No.", Format(SalesHeader."Order Date")), '', true);
            end;
            EmailMessage.AppendToBody(Text50054);
            EmailMessage.AppendToBody(Text60011);
            EmailMessage.AppendToBody(Text60011);
            EmailMessage.AppendToBody(Text50023);
            EmailMessage.AppendToBody(Text60011);
            EmailMessage.AppendToBody(Text60011);
            EmailMessage.AppendToBody(Text60004);
            EmailMessage.AppendToBody(Text60005);
            EmailMessage.AppendToBody(Text60006);
            EmailMessage.AppendToBody(Text60011);
            EmailMessage.AppendToBody(Text50027 + Text50026 + Text50057 + Text60012 + 'Customer Order No.' + Text60013 + Text60003);
            EmailMessage.AppendToBody(Text50030 + Text60012 + 'Description' + Text60013 + Text60003);
            EmailMessage.AppendToBody(Text50030 + Text60012 + 'Description1' + Text60013 + Text60003);
            EmailMessage.AppendToBody(Text50041 + Text60012 + 'Actual Order Quantity' + Text60013 + Text60003);
            EmailMessage.AppendToBody(Text50041 + Text60012 + 'Short Closed Quantity' + Text60013 + Text60003);
            EmailMessage.AppendToBody(Text50041 + Text60012 + 'Shipped Quantity' + Text60013 + Text60003);
            EmailMessage.AppendToBody(Text50041 + Text60012 + 'Balance Quantity' + Text60013 + Text60003);
            EmailMessage.AppendToBody(Text50041 + Text60012 + 'UOM' + Text60013 + Text60003);
            EmailMessage.AppendToBody(Text50030 + Text60012 + 'Zavenir’s Remark' + Text60013 + Text60003);
            EmailMessage.AppendToBody(Text60004);
            EmailMessage.AppendToBody(Text50026 + Text50057 + Format(SalesHeader."External Document No.") + Text60003);
            EmailMessage.AppendToBody(Text50030 + Rec.Description + Text60003);
            EmailMessage.AppendToBody(Text50030 + Rec."Description 2" + Text60003);
            EmailMessage.AppendToBody(Text50041 + Format(SalesLine.Quantity) + Text60003);
            EmailMessage.AppendToBody(Text50041 + Format(SalesLine."Short Close Qty.") + Text60003);
            EmailMessage.AppendToBody(Text50041 + Format(SalesLine."Quantity Shipped") + Text60003);
            EmailMessage.AppendToBody(Text50041 + '0' + Text60003);
            EmailMessage.AppendToBody(Text50041 + Rec."Unit of Measure Code" + Text60003);
            EmailMessage.AppendToBody(Text50030 + Rec.Remarks + Text60003);
            EmailMessage.AppendToBody(Text60005);
            EmailMessage.AppendToBody(Text60006);
            EmailMessage.AppendToBody(Text60004);
            EmailMessage.AppendToBody(Text60011);
            EmailMessage.AppendToBody(Text50058);
            EmailMessage.AppendToBody(Text60011);
            EmailMessage.AppendToBody(Text60011);
            EmailMessage.AppendToBody(Text50052);
            EmailMessage.AppendToBody(Text60011);
            EmailMessage.AppendToBody(Text50053);
            EmailMessage.AppendToBody(Text60011);
            EmailMessage.AppendToBody(Text60011);
            //SSD_Remove
            // EmailMessage.AppendToBody(StrSubstNo(ActualID, ActualTO, ActualCC, ActualBCC));
            //SSD_Remove
            Email.Enqueue(EmailMessage);
            SalesLine."Mail Send for Short Close" := true;
            SalesLine.Modify;
        end;
        //ALLE-NM 26062019
        //SSDU Commented
    end;

    procedure SendMailOnSOCreate(SPOrder: Code[30])
    var
        //SSDU SMTPMail: Codeunit "SMTP Mail";
        RecCust: Record Customer;
        //SSDU SMTPMailSetup: Record "SMTP Mail Setup";
        DistributorLineRec: Record "SSD Distributor Line";
        DistributorHeader: Record "SSD Distributor Header";
        BCCEmail: Text;
        Item: Record Item;
        SrNo: Integer;
        DistributorLine: Record "SSD Distributor Line";
        SalespersonPurchaser: Record "Salesperson/Purchaser";
        Text50000: label 'Dear      ';
        Text50001: label 'Sales Order Alert';
        Text50002: label ' Against the order placed for below customer. <br/> <br/> ';
        Text50003: label 'This is for your records. Kindly acknowledge the receipt.<br/> <br/> ';
        Text50010: label ' <br/> ';
        Text50011: label 'Customer Code :-  ';
        Text50012: label 'Customer Name :-  ';
        Text50013: label 'Amount to Customer :-  ';
        Text50014: label 'Invoice Date :-  ';
        Text50015: label 'Invoice No :-  ';
        Text50016: label 'Quantity in Carton :-  ';
        Text50017: label 'Transporter Name.:-  ';
        Text50018: label 'Truck No :-  ';
        Text50019: label 'Order Date :-  ';
        Text50020: label 'Order No. :-  ';
        Text50021: label 'System have not PCH e-Mail ID, So Informaiton can not sent to PCH Head';
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
        Text50025: label 'You will receive an Order Acknowledgement mail once Sales Order is accepted in our ERP system. This is an interim notification only.';
        Text50026: label '<TR>';
        Text50027: label '<table border="1" width="70%">';
        Text50028: label '<TH>';
        Text50029: label '</TH>';
        Text50030: label '<td width=250 Align=center>';
        Text50031: label '<td width="50%">';
        Text50032: label '<FONT SIZE=6 FACE="Sans Serif">';
        Text50033: label 'Dear Sir/Madam,';
        Text50034: label 'We''ve received an online order with thanks, details of which mentioned below:';
        Text50035: label ' Branch vide Stock Transfer Note No. ';
        Text50036: label ' Dated ';
        Text50037: label 'Customer No: ';
        Text50038: label 'Name: ';
        Text50039: label 'Regards,';
        Text50040: label 'ZD CRM';
        Text50041: label '<TD  width=5 Align=Center>';
        Text50042: label 'Thank for your valuable order';
        Text50043: label '<td width=400 align=center>';
        Text50044: label '<td width=150 align=center>';
        Text50045: label '<td width=450 align=center>';
    begin
        //SSDU Commented
        // //ALLE-NM 25072019
        // SelectLatestVersion;
        // DistributorLine.Reset;
        // DistributorLine.SetRange("SP Order No.", SPOrder);
        // DistributorLine.SetRange("Mail Sent", false);
        // if DistributorLine.FindFirst then begin
        //     DistributorHeader.Get(DistributorLine."MRP No");
        //     RecCust.Get(DistributorHeader."Customer Code");
        //     BCCEmail := 'agupta@zavenir.com;ccare@zavenir.com;marketing@zavenir.com';
        //     if RecCust."E-Mail" <> '' then begin
        //         SMTPMailSetup.Get;
        //         SMTPMailSetup.TestField("User ID");
        //         SrNo := 1;
        //         Clear(SMTPMail);
        //         SMTPMail.CreateMessage('Zavenir Email Alerts', SMTPMailSetup."User ID", RecCust."E-Mail", 'Online Order Submitted by ' + RecCust.Name + ' PO# ' +
        //             DistributorLine."SP Order No." + ' dated ' + Format(Today), '', true);
        //         if SalespersonPurchaser.Get(RecCust."Salesperson Code") then
        //             SMTPMail.AddCC(SalespersonPurchaser."E-Mail");
        //         SMTPMail.AddCC(SalespersonPurchaser."Resp. CCare Exe. Email Id");    //Alle 22/07/20
        //         SMTPMail.AddCC(SalespersonPurchaser."RSM Email ID");
        //         SMTPMail.AddBCC(BCCEmail);
        //         EmailMessage.AppendToBody(Text50024 + Text50033);
        //         EmailMessage.AppendToBody(Text60011);
        //         EmailMessage.AppendToBody(Text50034);
        //         EmailMessage.AppendToBody(Text60004);
        //         EmailMessage.AppendToBody(Text60005);
        //         EmailMessage.AppendToBody(Text60006);
        //         EmailMessage.AppendToBody(Text60011);
        //         EmailMessage.AppendToBody(Text50027 + Text50026 + Text50044 + Text60012 + 'Product Code' + Text60013 + Text60003);
        //         EmailMessage.AppendToBody(Text50030 + Text60012 + 'Description' + Text60013 + Text60003);
        //         EmailMessage.AppendToBody(Text50030 + Text60012 + 'Description1' + Text60013 + Text60003);
        //         EmailMessage.AppendToBody(Text50041 + Text60012 + 'Quantity' + Text60013 + Text60003);
        //         EmailMessage.AppendToBody(Text50041 + Text60012 + 'UOM' + Text60013 + Text60003);
        //         EmailMessage.AppendToBody(Text50030 + Text60012 + 'Order Value' + Text60013 + Text60003);
        //         EmailMessage.AppendToBody(Text50043 + Text60012 + 'Required Receipt Date' + Text60013 + Text60003);
        //         EmailMessage.AppendToBody(Text50043 + Text60012 + 'Expected Receipt date' + Text60013 + Text60003);
        //         EmailMessage.AppendToBody(Text50043 + Text60012 + 'Sales Partner Remarks' + Text60013 + Text60003);
        //         EmailMessage.AppendToBody(Text60004);
        //         DistributorLineRec.Reset;
        //         DistributorLineRec.SetCurrentkey("SP Order No.");
        //         DistributorLineRec.SetRange("SP Order No.", DistributorLine."SP Order No.");
        //         DistributorLineRec.SetRange("Mail Sent", false);
        //         if DistributorLineRec.FindSet then begin
        //             repeat
        //                 EmailMessage.AppendToBody(Text50026 + Text50044 + Format(DistributorLineRec."Item Code") + Text60003);
        //                 if Item.Get(DistributorLineRec."Item Code") then
        //                     EmailMessage.AppendToBody(Text50041 + Item.Description + Text60003);
        //                 EmailMessage.AppendToBody(Text50030 + Item."Description 2" + Text60003);
        //                 EmailMessage.AppendToBody(Text50041 + Format(DistributorLineRec.Quantity) + Text60003);
        //                 EmailMessage.AppendToBody(Text50041 + Format(Item."Base Unit of Measure") + Text60003);
        //                 EmailMessage.AppendToBody(Text50030 + Format(ROUND(DistributorLineRec.Quantity * DistributorLineRec."SP Price", 1)) + Text60003);
        //                 EmailMessage.AppendToBody(Text50043 + Format(DistributorLineRec."Required Receipt Date") + Text60003);
        //                 EmailMessage.AppendToBody(Text50043 + Format(DistributorLineRec."Suggested Receipt Date") + Text60003);
        //                 EmailMessage.AppendToBody(Text50043 + Format(DistributorLineRec."SP Remarks") + Text60003);
        //                 EmailMessage.AppendToBody(Text60004);
        //                 SrNo += 1;
        //             until DistributorLineRec.Next = 0;
        //         end;
        //         EmailMessage.AppendToBody(Text60004);
        //         EmailMessage.AppendToBody(Text60005);
        //         EmailMessage.AppendToBody(Text60006);
        //         EmailMessage.AppendToBody(Text60011);
        //         EmailMessage.AppendToBody(Text50025);
        //         EmailMessage.AppendToBody(Text60004);
        //         EmailMessage.AppendToBody(Text60005);
        //         EmailMessage.AppendToBody(Text60006);
        //         EmailMessage.AppendToBody(Text60011);
        //         EmailMessage.AppendToBody(Text50024 + Text50039 + Text60003);
        //         EmailMessage.AppendToBody(Text60011);
        //         EmailMessage.AppendToBody(Text50024 + Text50040 + Text60003);
        //         SMTPMail.Send;
        //         DistributorLine.ModifyAll("Mail Sent", true);
        //     end;
        // end;
        // //ALLE-NM 25072019
        //SSDU Commented
    end;

    [EventSubscriber(ObjectType::Table, Database::"Sales Line", 'OnAfterValidateEvent', 'No.', false, false)]
    local procedure CheckItemCategoryForSalesPerson(var Rec: Record "Sales Line"; var xRec: Record "Sales Line"; CurrFieldNo: Integer)
    var
        SalesHeader: Record "Sales Header";
    begin
        if COMPANYNAME = 'Zavenir Kluthe India (P) Ltd.' then begin
            SalesHeader.Get(Rec."Document Type", Rec."Document No.");
            if (Rec.Type = Rec.Type::Item) and (SalesHeader."Salesperson Code" = 'PSM-BD1') and not (Rec."Item Category Code" in ['CONTROX', 'ISOGOL', 'HC360', 'NIKUTEX']) then begin
                Error('You do not have permission to select %1 category item', Rec."Item Category Code");
            end;
        end;
    end;

    procedure SendMailOnSalesOrderCreate(SalesOrderNo: Code[20]; SPOrderNo: Code[30])
    var
        //SSDU SMTPMail: Codeunit "SMTP Mail";
        RecCust: Record Customer;
        //SSDU SMTPMailSetup: Record "SMTP Mail Setup";
        BCCEmail: Text;
        Item: Record Item;
        SrNo: Integer;
        DistributorLine: Record "SSD Distributor Line";
        SalespersonPurchaser: Record "Salesperson/Purchaser";
        Text50000: label 'Dear      ';
        Text50001: label 'Sales Order Alert';
        Text50002: label ' Against the order placed for below customer. <br/> <br/> ';
        Text50003: label 'This is for your records. Kindly acknowledge the receipt.<br/> <br/> ';
        Text50010: label ' <br/> ';
        Text50011: label 'Customer Code :-  ';
        Text50012: label 'Customer Name :-  ';
        Text50013: label 'Amount to Customer :-  ';
        Text50014: label 'Invoice Date :-  ';
        Text50015: label 'Invoice No :-  ';
        Text50016: label 'Quantity in Carton :-  ';
        Text50017: label 'Transporter Name.:-  ';
        Text50018: label 'Truck No :-  ';
        Text50019: label 'Order Date :-  ';
        Text50020: label 'Order No. :-  ';
        Text50021: label 'System have not PCH e-Mail ID, So Informaiton can not sent to PCH Head';
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
        Text50025: label 'You will receive an Order Acknowledgement mail once Sales Order is accepted in our ERP system. This is an interim notification only.';
        Text50026: label '<TR>';
        Text50027: label '<table border="1" width="70%">';
        Text50028: label '<TH>';
        Text50029: label '</TH>';
        Text50030: label '<td width=250 Align=center>';
        Text50031: label '<td width="50%">';
        Text50032: label '<FONT SIZE=6 FACE="Sans Serif">';
        Text50033: label 'Dear Sir/Madam,';
        Text50034: label 'We''ve received an online order with thanks, details of which mentioned below:';
        Text50035: label ' Branch vide Stock Transfer Note No. ';
        Text50036: label ' Dated ';
        Text50037: label 'Customer No: ';
        Text50038: label 'Name: ';
        Text50039: label 'Regards,';
        Text50040: label 'ZD CRM';
        Text50041: label '<TD  width=5 Align=Center>';
        Text50042: label 'Thank for your valuable order';
        Text50043: label '<td width=400 align=center>';
        Text50044: label '<td width=150 align=center>';
        Text50045: label '<td width=450 align=center>';
        SalesHeader: Record "Sales Header";
        SalesLine: Record "Sales Line";
        //SSD
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
        MailList: List of [Text];
        CCMailList: List of [Text];
        BCCMailList: List of [Text];
        Suubject2: Label 'Online Order Submitted by %1 PO# %2 dated %3';
        PaymentAdvice: Report "Payment Advice";
        RecRef: RecordRef;
        EnvironmentInformation: Codeunit "Environment Information";
        ActualID: Label 'Atual Mail - TO Mail - %1, CC Mail - %2';
        ActualTO: Text;
        ActualCC: Text;
        ActualBCC: Text;
    //SSD
    //SSDU DisHead: Record "Distribution Header";
    begin
        Clear(CCMailList);
        Clear(ToEmail);
        Clear(MailList);
        Clear(BCCMailList);
        Clear(Email);
        Clear(EmailMessage);
        Clear(BCCEmail);
        Clear(SrNo);
        Clear(ActualTO);
        Clear(ActualCC);
        Clear(ActualBCC);
        SelectLatestVersion;
        SalesHeader.Reset;
        SalesHeader.SetRange("No.", SalesOrderNo);
        //SalesHeader.SETRANGE("Mail Sent",FALSE);
        if SalesHeader.FindFirst then begin
            RecCust.Reset();
            RecCust.Get(SalesHeader."Sell-to Customer No.");
            BCCEmail := 'ithelpdesk@zavenir.com;ccare@zavenir.com;marketing@zavenir.com';
            //SSD_Remove
            ActualBCC := BCCEmail;
            //SSD_Remove
            if RecCust."E-Mail" <> '' then begin
                //SMTPMailSetup.Get;
                //SMTPMailSetup.TestField("User ID");
                SrNo := 1;
                //Clear(SMTPMail);
                //SMTPMail.CreateMessage('Zavenir Email Alerts', SMTPMailSetup."User ID", RecCust."E-Mail", 'Online Order Submitted by ' + RecCust.Name + ' PO# ' +
                //    SPOrderNo + ' dated ' + Format(Today), '', true);
                MailList.AddRange(RecCust."E-Mail".Split(';'));
                //SSD_Remove
                ActualTO := RecCust."E-Mail";
                //SSD_Remove
                SalespersonPurchaser.Reset();
                if SalespersonPurchaser.Get(RecCust."Salesperson Code") then CCMailList.AddRange(SalespersonPurchaser."E-Mail".Split(';'));
                ActualCC := SalespersonPurchaser."E-Mail";
                BCCMailList.AddRange(BCCEmail.Split(';'));
                if EnvironmentInformation.IsProduction() then
                    EmailMessage.Create(MailList, StrSubstNo(Suubject2, RecCust.Name, SPOrderNo, Format(Today)), '', true, CCMailList, BCCMailList)
                else begin
                    Clear(MailList);
                    clear(CCMailList);
                    Clear(BCCMailList);
                    //MailList.Add('soni.sunil70@gmail.com');
                    //MailList.Add('hyadav@zavenir.com');
                    MailList.Add('ykuntal@zavenir.com');
                    EmailMessage.Create(MailList, StrSubstNo(Suubject2, RecCust.Name, SPOrderNo, Format(Today)), '', true)
                end;
                EmailMessage.AppendToBody(Text50024 + Text50033);
                EmailMessage.AppendToBody(Text60011);
                EmailMessage.AppendToBody(Text50034);
                EmailMessage.AppendToBody(Text60004);
                EmailMessage.AppendToBody(Text60005);
                EmailMessage.AppendToBody(Text60006);
                EmailMessage.AppendToBody(Text60011);
                EmailMessage.AppendToBody(Text50027 + Text50026 + Text50044 + Text60012 + 'Product Code' + Text60013 + Text60003);
                EmailMessage.AppendToBody(Text50030 + Text60012 + 'Description' + Text60013 + Text60003);
                EmailMessage.AppendToBody(Text50030 + Text60012 + 'Description1' + Text60013 + Text60003);
                EmailMessage.AppendToBody(Text50041 + Text60012 + 'Quantity' + Text60013 + Text60003);
                EmailMessage.AppendToBody(Text50041 + Text60012 + 'UOM' + Text60013 + Text60003);
                EmailMessage.AppendToBody(Text50030 + Text60012 + 'Order Value' + Text60013 + Text60003);
                EmailMessage.AppendToBody(Text50043 + Text60012 + 'Required Receipt Date' + Text60013 + Text60003);
                EmailMessage.AppendToBody(Text50043 + Text60012 + 'Expected Receipt date' + Text60013 + Text60003);
                EmailMessage.AppendToBody(Text50043 + Text60012 + 'Sales Partner Remarks' + Text60013 + Text60003);
                EmailMessage.AppendToBody(Text60004);
                SalesLine.Reset;
                SalesLine.SetRange("Document No.", SalesHeader."No.");
                //SalesLine.SETRANGE("Mail Sent",FALSE);
                if SalesLine.FindSet then begin
                    repeat
                        EmailMessage.AppendToBody(Text50026 + Text50044 + Format(SalesLine."No.") + Text60003);
                        if Item.Get(SalesLine."No.") then EmailMessage.AppendToBody(Text50041 + Item.Description + Text60003);
                        EmailMessage.AppendToBody(Text50030 + Item."Description 2" + Text60003);
                        EmailMessage.AppendToBody(Text50041 + Format(SalesLine.Quantity) + Text60003);
                        EmailMessage.AppendToBody(Text50041 + Format(Item."Base Unit of Measure") + Text60003);
                        EmailMessage.AppendToBody(Text50030 + Format(ROUND(SalesLine.Quantity * SalesLine."SP Price", 1)) + Text60003);
                        EmailMessage.AppendToBody(Text50043 + Format(SalesLine."Required Receipt Date") + Text60003);
                        EmailMessage.AppendToBody(Text50043 + Format(SalesLine."Suggested Receipt Date") + Text60003);
                        EmailMessage.AppendToBody(Text50043 + Format(SalesLine."SP Remarks") + Text60003);
                        EmailMessage.AppendToBody(Text60004);
                        SrNo += 1;
                    until SalesLine.Next = 0;
                end;
                EmailMessage.AppendToBody(Text60004);
                EmailMessage.AppendToBody(Text60005);
                EmailMessage.AppendToBody(Text60006);
                EmailMessage.AppendToBody(Text60011);
                EmailMessage.AppendToBody(Text50025);
                EmailMessage.AppendToBody(Text60004);
                EmailMessage.AppendToBody(Text60005);
                EmailMessage.AppendToBody(Text60006);
                EmailMessage.AppendToBody(Text60011);
                EmailMessage.AppendToBody(Text50024 + Text50039 + Text60003);
                EmailMessage.AppendToBody(Text60011);
                EmailMessage.AppendToBody(Text50024 + Text50040 + Text60003);
                EmailMessage.AppendToBody(Text60011); // AKASH
                EmailMessage.AppendToBody(Text60011); //AKASH
                EmailMessage.AppendToBody(Text60011); //AKASH
                //SMTPMail.Send;
                //DistributorLine.MODIFYALL("Mail Sent",TRUE);
                //SSD_Remove
                // EmailMessage.AppendToBody(StrSubstNo(ActualID, ActualTO, ActualCC));
                //SSD_Remove
                Email.Enqueue(EmailMessage);
            end;
        end;
        // //ALLE-NM 25072019
        //SSDU Commented
    end;

    [EventSubscriber(ObjectType::Table, Database::Customer, 'OnAfterValidateEvent', 'Blocked', false, false)]
    local procedure OnValidateCustomerBlock(var Rec: Record Customer; var xRec: Record Customer; CurrFieldNo: Integer)
    var
        DistributionHeader: Record "SSD Distributor Header";
    begin
        if (xRec.Blocked = xRec.Blocked::All) and (Rec.Blocked <> Rec.Blocked::All) then begin
            DistributionHeader.SetRange("Customer Code", Rec."No.");
            DistributionHeader.SetFilter("Error Text", '<>%1', '');
            DistributionHeader.ModifyAll("Error Text", '');
        end;
    end;

    [EventSubscriber(Objecttype::Page, 50125, 'OnAfterActionEvent', 'Post', false, false)]
    local procedure OnAfterQualityPOst(var Rec: Record "SSD Quality Order Header")
    var
        WarehouseReceiptHeader: Record "Warehouse Receipt Header";
    begin
        WarehouseReceiptHeader.Reset;
        WarehouseReceiptHeader.SetRange("No.", Rec."Source Document No.");
        if WarehouseReceiptHeader.FindFirst then begin
            WarehouseReceiptHeader."Quality Post date Time" := CurrentDatetime;
            WarehouseReceiptHeader.Modify;
        end;
    end;
    //SSDU Commented
    // [EventSubscriber(Objecttype::Page, 50006, 'OnAfterActionEvent', 'Action68', false, false)]
    // local procedure OnAfterPostPurchaseInvoiceDirect(var Rec: Record "Purchase Header")
    // begin
    //     Rec."Actual Posted Date" := CurrentDatetime;
    //     Rec.Modify
    // end;
    //SSDU Commented
    [EventSubscriber(Objecttype::Page, 50319, 'OnAfterGetRecordEvent', '', false, false)]
    local procedure ValidateChallanRelatedFieldsOnTransferOder(var Rec: Record "Transfer Shipment Line")
    var
        StockReg: Record "SSD Stock Register 57F4";
    begin
        //ALLE-201020 >>
        StockReg.Reset();
        StockReg.SetRange("Challan No.", Rec."Document No.");
        StockReg.SetRange("Item No.", Rec."Item No.");
        StockReg.SetFilter("Line Closed Date", '<>%1', 0D);
        //StockReg.SETFILTER("Challan Closed Date",'<>%1',0D);
        StockReg.SetFilter("Challan Age", '<>%1', 0);
        if StockReg.FindFirst then begin
            Rec."Challan Age" := StockReg."Challan Age";
            Rec."Challan Closed Date" := StockReg."Challan Closed Date";
            Rec."Line Closed Date" := StockReg."Line Closed Date";
            Rec.Modify();
        end;
        //ALLE-201020 >>
    end;

    [EventSubscriber(Objecttype::Page, 30, 'OnModifyRecordEvent', '', false, false)]
    procedure ModifyItemCard(var Rec: Record Item; var xRec: Record Item; var AllowModify: Boolean)
    var
        //SSDU SMTPMailSetup: Record "SMTP Mail Setup";
        //SSDU SMTPMail: Codeunit "SMTP Mail";
        Customer: Record Customer;
        Name: Text;
        BlockDate: DateTime;
        BliockTime: Time;
        CustNo: Code[10];
        Text50010: label ' <br/> ';
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
    begin
        //ALLE-201020 >>
        Rec."Last Date Modified" := Today;
        if (xRec.Blocked = false) and (not (Rec."Procurement Category" <> xRec."Procurement Category")) and (not (Rec."Procurement Type" <> xRec."Procurement Type")) and (not (Rec."Procurement Category 1" <> xRec."Procurement Category 1")) and (not (Rec."Pack Size" <> xRec."Pack Size")) then Rec.Blocked := true //ALLE-201020 <<
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Release Purchase Document", 'OnAfterReopenPurchaseDoc', '', false, false)]
    local procedure OnAfterReopenPurchOrder(var PurchaseHeader: Record "Purchase Header")
    begin
        //ALLE-AT >>
        PurchaseHeader."PO Mail Send" := false;
        PurchaseHeader.Modify();
        //ALLE-AT <<
    end;

    procedure SendMailForCustomerBlk(var Rec: Record Customer)
    var
        Customer: Record Customer;
        Name: Text;
        BlockDate: DateTime;
        BliockTime: Time;
        CustNo: Code[10];
        Text50010: label ' <br/> ';
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
        SalespersonPurchaser: Record "Salesperson/Purchaser";
        NSM: Text;
        RSM: Text;
        EMail: Text;
        CCare: Text;
        TempBlob: Codeunit "Temp Blob";
        EmailC: Codeunit Email;
        EmailMessage: Codeunit "Email Message";
        Base64Convert: Codeunit "Base64 Convert";
        DocNo: Code[20];
        InStream: InStream;
        OutStream: OutStream;
        InStream2: InStream;
        OutStream2: OutStream;
        Base64Txt: Text;
        Base64Txt2: Text;
        MailList: List of [Text];
        CCList: List of [Text];
        BCCList: List of [Text];
        SubjectMSG: Label 'blocked';
        BodyMsg: Label 'Dear Sir or Madam,<br><br>';
        EnvironmentInformation: Codeunit "Environment Information";
        ToMailID: Text;
    begin
        Clear(MailList);
        Clear(CCList);
        Clear(BCCList);
        Clear(EmailMessage);
        Clear(ToMailID);
        Rec."Last Date Modified" := Today;
        if SalespersonPurchaser.Get(Rec."Salesperson Code") then begin
            NSM := SalespersonPurchaser."NSM Email ID";
            RSM := SalespersonPurchaser."RSM Email ID";
            EMail := SalespersonPurchaser."E-Mail";
            CCare := SalespersonPurchaser."Resp. CCare Exe. Email Id";
        end;
        if Rec.Blocked = Rec.Blocked::All then begin
            If Rec."Gen. Bus. Posting Group" = 'SP' then begin
                ToMailID := Rec."E-Mail";
                MailList.AddRange(Rec."E-Mail".Split(';'));
            end;
            CCList.Add('lmohan@zavenir.com');
            CCList.Add('admin@zavenir.com');
            CCList.Add('gurgaon.dispatch@zavenir.com');
            CCList.Add('ccare@zavenir.com');
            if RSM <> '' then CCList.AddRange(RSM.Split(';'));
            if NSM <> '' then CCList.AddRange(NSM.Split(';'));
            if EMail <> '' then CCList.AddRange(EMail.Split(';'));
            if CCare <> '' then CCList.AddRange(CCare.Split(';'));
            if EnvironmentInformation.IsProduction() then begin
                EmailMessage.Create(MailList, SubjectMSG, '', true, CCList, BCCList)
            end
            else begin
                Clear(MailList);
                Clear(CCList);
                MailList.Add('ykuntal@zavenir.com');
                EmailMessage.Create(MailList, SubjectMSG, '', true);
            end;
            EmailMessage.AppendToBody('Dear Sir,');
            EmailMessage.AppendToBody('<br><br>');
            If Rec."Gen. Bus. Posting Group" <> 'SP' then begin
                if (Rec.Blocked = Rec.Blocked::Ship) then
                    EmailMessage.AppendToBody('This Customer Is Blocked For Ship')
                else if (Rec.Blocked = Rec.Blocked::Invoice) then
                    EmailMessage.AppendToBody('This Customer Is Blocked For Invoice')
                else
                    EmailMessage.AppendToBody('This Customer Is Blocked For All');
            end
            else begin
                if (Rec.Blocked = Rec.Blocked::Ship) then
                    EmailMessage.AppendToBody('This Customer Is Blocked For Ship. You are requested to please reach out to your Sales Account Manager / Customer Care Representative')
                else if (Rec.Blocked = Rec.Blocked::Invoice) then
                    EmailMessage.AppendToBody('This Customer Is Blocked For Invoice. You are requested to please reach out to your Sales Account Manager / Customer Care Representative')
                else
                    EmailMessage.AppendToBody('This Customer Is Blocked For All. You are requested to please reach out to your Sales Account Manager / Customer Care Representative');
            end;
            EmailMessage.AppendToBody('<br><br>');
            EmailMessage.AppendToBody(Text60004);
            EmailMessage.AppendToBody(Text60005);
            EmailMessage.AppendToBody(Text60006);
            EmailMessage.AppendToBody(Text60011);
            EmailMessage.AppendToBody(Text59999);
            EmailMessage.AppendToBody(Text60001);
            EmailMessage.AppendToBody(Text60004);
            EmailMessage.AppendToBody(Text60005);
            EmailMessage.AppendToBody(Text60006);
            EmailMessage.AppendToBody(Text60004);
            EmailMessage.AppendToBody(Text60005);
            EmailMessage.AppendToBody(Text60006);
            EmailMessage.AppendToBody(Text60011);
            EmailMessage.AppendToBody(Text50027 + Text50026 + Text50030 + Text60012 + 'Customer No.' + Text60013 + Text60003);
            EmailMessage.AppendToBody(Text50030 + Text60012 + 'Customer Name' + Text60013 + Text60003);
            EmailMessage.AppendToBody(Text50030 + Text60012 + 'Date And Time' + Text60013 + Text60003);
            EmailMessage.AppendToBody(Text60004);
            if Customer.Get(Rec."No.") then begin
                EmailMessage.AppendToBody(Text50026 + Text50030 + Format(Customer."No.") + Text60003);
                EmailMessage.AppendToBody(Text50030 + Format(Customer.Name) + Text60003);
                EmailMessage.AppendToBody(Text50030 + Format(CurrentDatetime) + Text60003);
                EmailMessage.AppendToBody(Text60004);
            end;
            EmailMessage.AppendToBody(Text60004);
            EmailMessage.AppendToBody(Text60005);
            EmailMessage.AppendToBody(Text60006);
            EmailMessage.AppendToBody(Text60011);
            EmailMessage.AppendToBody(Text60004);
            EmailMessage.AppendToBody(Text60005);
            EmailMessage.AppendToBody(Text60006);
            EmailMessage.AppendToBody(Text60011);
            EmailMessage.AppendToBody(Text60004);
            EmailMessage.AppendToBody(Text60005);
            EmailMessage.AppendToBody(Text60006);
            EmailMessage.AppendToBody(Text60011);
            EmailMessage.AppendToBody(Text59999);
            EmailMessage.AppendToBody(Text60000);
            EmailMessage.AppendToBody(Text60001);
            EmailMessage.AppendToBody(Text60004);
            EmailMessage.AppendToBody(Text60005);
            EmailMessage.AppendToBody(Text60006);
            EmailMessage.AppendToBody(Text60011);
            EmailMessage.AppendToBody('<br><br>');
            EmailMessage.AppendToBody('Regards,');
            EmailMessage.AppendToBody('<br>');
            EmailMessage.AppendToBody('Zavenir Daubert India Private Limited');
            EmailMessage.AppendToBody('<br><br>');
            //EmailMessage.AppendToBody(ToMailID);//Remove Before live
            EMailc.Enqueue(EmailMessage);
        end;
        if Rec.Blocked = Rec.Blocked::" " then begin
            //SMTPMail.CreateMessage('Zavenir Daubert India Private Limited', SMTPMailSetup."User ID", '', 'Unblocked', '', true);
            //SMTPMail.AddCC('lmohan@zavenir.com;agupta@zavenir.com;ccare.north@zavenir.com;ccare.west@zavenir.com;ccare.south@zavenir.com;gurgaon.dispatch@zavenir.com;tbhardwaj@zavenir.com');
            // SMTPMail.AddCC('lmohan@zavenir.com;agupta@zavenir.com;gurgaon.dispatch@zavenir.com;ccare@zavenir.com');
            Clear(MailList);
            Clear(CCList);
            Clear(BCCList);
            CCList.Add('lmohan@zavenir.com');
            CCList.Add('admin@zavenir.com');
            CCList.Add('gurgaon.dispatch@zavenir.com');
            CCList.Add('ccare@zavenir.com');
            If Rec."Gen. Bus. Posting Group" = 'SP' then begin
                MailList.AddRange(Rec."E-Mail".Split(';'));
                ToMailID := Rec."E-Mail";
            end;
            if RSM <> '' then CCList.AddRange(RSM.Split(';'));
            if NSM <> '' then CCList.AddRange(NSM.Split(';'));
            if EMail <> '' then CCList.AddRange(EMail.Split(';'));
            if CCare <> '' then CCList.AddRange(CCare.Split(';'));
            if EnvironmentInformation.IsProduction() then begin
                EmailMessage.Create(MailList, 'Unblocked', '', true, CCList, BCCList)
            end
            else begin
                Clear(MailList);
                Clear(CCList);
                //MailList.AddRange(CCare.Split(';'));
                //MailList.Add('hyadav@zavenir.com');
                MailList.Add('ykuntal@zavenir.com');
                MailList.Add('sunil@ssdynamics.co.in');
                EmailMessage.Create(MailList, 'Unblocked', '', true);
            end;
            EmailMessage.AppendToBody('Dear Sir,');
            EmailMessage.AppendToBody('<br><br>');
            EmailMessage.AppendToBody('This Customer Is Unblocked.');
            EmailMessage.AppendToBody('<br><br>');
            EmailMessage.AppendToBody(Text60004);
            EmailMessage.AppendToBody(Text60005);
            EmailMessage.AppendToBody(Text60006);
            EmailMessage.AppendToBody(Text60011);
            EmailMessage.AppendToBody(Text59999);
            EmailMessage.AppendToBody(Text60001);
            EmailMessage.AppendToBody(Text60004);
            EmailMessage.AppendToBody(Text60005);
            EmailMessage.AppendToBody(Text60006);
            EmailMessage.AppendToBody(Text60004);
            EmailMessage.AppendToBody(Text60005);
            EmailMessage.AppendToBody(Text60006);
            EmailMessage.AppendToBody(Text60011);
            EmailMessage.AppendToBody(Text50027 + Text50026 + Text50030 + Text60012 + 'Customer No.' + Text60013 + Text60003);
            EmailMessage.AppendToBody(Text50030 + Text60012 + 'Customer Name' + Text60013 + Text60003);
            EmailMessage.AppendToBody(Text50030 + Text60012 + 'Date And Time' + Text60013 + Text60003);
            EmailMessage.AppendToBody(Text60004);
            if Customer.Get(Rec."No.") then begin
                EmailMessage.AppendToBody(Text50026 + Text50030 + Format(Customer."No.") + Text60003);
                EmailMessage.AppendToBody(Text50030 + Format(Customer.Name) + Text60003);
                EmailMessage.AppendToBody(Text50030 + Format(CurrentDatetime) + Text60003);
                EmailMessage.AppendToBody(Text60004);
            end;
            EmailMessage.AppendToBody(Text60004);
            EmailMessage.AppendToBody(Text60005);
            EmailMessage.AppendToBody(Text60006);
            EmailMessage.AppendToBody(Text60011);
            EmailMessage.AppendToBody(Text60004);
            EmailMessage.AppendToBody(Text60005);
            EmailMessage.AppendToBody(Text60006);
            EmailMessage.AppendToBody(Text60011);
            EmailMessage.AppendToBody(Text60004);
            EmailMessage.AppendToBody(Text60005);
            EmailMessage.AppendToBody(Text60006);
            EmailMessage.AppendToBody(Text60011);
            EmailMessage.AppendToBody(Text59999);
            EmailMessage.AppendToBody(Text60000);
            EmailMessage.AppendToBody(Text60001);
            EmailMessage.AppendToBody(Text60004);
            EmailMessage.AppendToBody(Text60005);
            EmailMessage.AppendToBody(Text60006);
            EmailMessage.AppendToBody(Text60011);
            EmailMessage.AppendToBody('<br><br>');
            EmailMessage.AppendToBody('Regards,');
            EmailMessage.AppendToBody('<br>');
            EmailMessage.AppendToBody('Zavenir Daubert India Private Limited');
            // EmailMessage.AppendToBody(ToMailID);//Remove Before live
            EmailMessage.AppendToBody('<br><br>');
            EmailC.Enqueue(EmailMessage);
        end;
        //SSDU Commented
        //Alle_050219
    end;
}
