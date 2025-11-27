report 50150 "SSD Dashboard Mail Pool"
{
    ApplicationArea = All;
    Caption = 'Dashboard Mail Pool';
    UsageCategory = ReportsAndAnalysis;
    ProcessingOnly = true;
    UseRequestPage = false;

    dataset
    {
        dataitem(SSDDashboardEmail; "SSD Dashboard Email")
        {
            trigger OnAfterGetRecord()
            begin
                Clear(MailList);
                Clear(CCMailList);
                Clear(CCMailList);
                Clear(TempBlob);
                Clear(Email);
                Clear(EmailMessage);
                if SSDDashboardEmail."Report ID" = 50483 then begin
                    MailList.AddRange(SSDDashboardEmail."To Mail".Split(';'));
                    CCMailList.AddRange(SSDDashboardEmail."CC Mail".Split(';'));
                    BCCMailList.AddRange(SSDDashboardEmail."BCC Mail".Split(';'));
                    if EnvironmentInformation.IsProduction()then begin
                        EmailMessage.Create(MailList, SSDDashboardEmail."Mail Subject", '', true, CCMailList, BCCMailList);
                    end
                    else
                    begin
                        Clear(MailList);
                        Clear(CCMailList);
                        Clear(CCMailList);
                        //MailList.Add('sunil@ssdynamics.co.in');
                        //MailList.Add('hyadav@zavenir.com');
                        MailList.Add('ykuntal@zavenir.com');
                        EmailMessage.Create(MailList, SSDDashboardEmail."Mail Subject", '', true);
                    end;
                    EmailMessage.AppendToBody('Dear Sir/Madam,<br><br>');
                    EmailMessage.AppendToBody(SSDDashboardEmail."Mail Body");
                    EmailMessage.AppendToBody('<br><br>');
                    EmailMessage.AppendToBody('With Best Regards, <br><br>' + ' <b>Zavenir Team</b> <br><br>');
                    EmailMessage.AppendToBody('This is an automated email. Replies to this message are not monitored or answered.</b> <br><br>');
                    //Pool Update
                    FileName:='Pool Update Report';
                    Clear(TempBlob);
                    CLEAR(PoolUpdate);
                    TempBlob.CreateOutStream(OutStream);
                    PoolUpdate.SaveAs('', ReportFormat::Excel, OutStream);
                    TempBlob.CreateInStream(InStream);
                    Base64Txt:=Base64Convert.ToBase64(InStream, true);
                    EmailMessage.AddAttachment(FileName + '.xlsx', 'application/xls', Base64Txt);
                    //Key Report
                    FileNameKey:='Key Flash Report';
                    Clear(TempBlob);
                    CLEAR(KeyFlash);
                    TempBlob.CreateOutStream(OutStream2);
                    KeyFlash.SaveAs('', ReportFormat::Excel, OutStream2);
                    TempBlob.CreateInStream(InStream2);
                    Base64Txt2:=Base64Convert.ToBase64(InStream2, true);
                    EmailMessage.AddAttachment(FileNameKey + '.xlsx', 'application/xls', Base64Txt2);
                    //Channel
                    FileNameChannel:='Channel Flash Report';
                    Clear(TempBlob);
                    CLEAR(ChannelFlash);
                    TempBlob.CreateOutStream(OutStream3);
                    ChannelFlash.SaveAs('', ReportFormat::Excel, OutStream3);
                    TempBlob.CreateInStream(InStream3);
                    Base64Txt3:=Base64Convert.ToBase64(InStream3, true);
                    EmailMessage.AddAttachment(FileNameChannel + '.xlsx', 'application/xls', Base64Txt3);
                    Email.Enqueue(EmailMessage);
                end;
            end;
        }
    }
    requestpage
    {
        layout
        {
            area(content)
            {
                group(GroupName)
                {
                }
            }
        }
        actions
        {
            area(processing)
            {
            }
        }
    }
    var RecRef: RecordRef;
    TempBlob: Codeunit "Temp Blob";
    Email: Codeunit Email;
    EmailMessage: Codeunit "Email Message";
    Base64Convert: Codeunit "Base64 Convert";
    InStream: InStream;
    InStream2: InStream;
    InStream3: InStream;
    OutStream: OutStream;
    OutStream2: OutStream;
    OutStream3: OutStream;
    Base64Txt: Text;
    Base64Txt2: Text;
    Base64Txt3: Text;
    MailList: List of[Text];
    CCMailList: List of[Text];
    BCCMailList: List of[Text];
    InvDashboardReport: report "Inv. Dashboard Query Report";
    PoolUpdate: Report "Pool Update Query";
    KeyFlash: report "Key Flash Query";
    ChannelFlash: report "Channel- Sales Flash Query";
    SubjectMsg: Label 'Inventory Dashboard Report';
    SubjectMsgPool: Label 'Pool Update Report';
    EnvironmentInformation: Codeunit "Environment Information";
    FileName: Text[1024];
    FileNameKey: Text[1024];
    FileNameChannel: Text[1024];
    Lay: Record "Report Layout List";
}
