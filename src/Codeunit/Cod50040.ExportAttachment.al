Codeunit 50040 "Export Attachment"
{
    trigger OnRun()
    begin
        TempDocumentExport.Reset;
        if TempDocumentExport.FindSet then repeat IncomingDocument.Reset;
                IncomingDocument.SetRange(Posted, true);
                IncomingDocument.SetRange("Document No.", TempDocumentExport."Document No.");
                if IncomingDocument.FindSet then repeat IncomingDocumentAttachment.Reset;
                        IncomingDocumentAttachment.SetRange("Incoming Document Entry No.", IncomingDocument."Entry No.");
                        // IncomingDocumentAttachment.SetRange("Document No.", IncomingDocument."Document No.");
                        if IncomingDocumentAttachment.FindSet then repeat ProcessRecord:=false;
                                IncomingDocumentAttachment.CalcFields(Content);
                                if IncomingDocumentAttachment.Content.Hasvalue then ProcessRecord:=true;
                                if ProcessRecord then begin
                                    // TempBlob.Reset;
                                    // TempBlob.Blob := IncomingDocumentAttachment.Content;
                                    // TempBlob.Blob.CreateInstream(NAVInStream);
                                    // FileName := FileManagement.ServerTempFileName(IncomingDocumentAttachment."File Extension");
                                    // TempFile.Create(FileName);
                                    // TempFile.CreateOutstream(NAVOutStream);
                                    // CopyStream(NAVOutStream, NAVInStream);
                                    // TempFile.Close;
                                    ToFile:='D:\FileExport\SET' + Format(TempDocumentExport."S. No.") + '_' + GetDocumentNo(IncomingDocument."Document No.") + '_' + Format(IncomingDocumentAttachment."Line No." / 10000) + '_' + IncomingDocumentAttachment.Name + '.' + IncomingDocumentAttachment."File Extension";
                                    // FileManagement.DownloadToFile(FileName, ToFile);
                                    // FileManagement.DeleteServerFile(FileName);
                                    // gurmeet
                                    Clear(TempBlob);
                                    TempBlob.CreateOutStream(OutStr);
                                    IncomingDocumentAttachment.Content.CreateInStream(InStr);
                                    CopyStream(OutStr, InStr);
                                    RecRef.GetTable(IncomingDocumentAttachment);
                                    TempBlob.CreateInStream(InStr2);
                                    FileManagement.BLOBExport(TempBlob, ToFile, TRUE);
                                // gurmeet
                                end;
                            until IncomingDocumentAttachment.Next = 0;
                    until IncomingDocument.Next = 0;
            until TempDocumentExport.Next = 0;
    end;
    var TempDocumentExport: Record "SSD Temp Document Export";
    IncomingDocument: Record "Incoming Document";
    IncomingDocumentAttachment: Record "Incoming Document Attachment";
    ProcessRecord: Boolean;
    TempBlob: Codeunit "Temp Blob";
    NAVInStream: InStream;
    NAVOutStream: OutStream;
    FileManagement: Codeunit "File Management";
    TempFile: File;
    FileName: Text;
    ToFile: Text;
    // gurmeet
    OutStr: OutStream;
    InStr: InStream;
    InStr2: InStream;
    RecRef: RecordRef;
    TempFile2: File;
    // gurmeet
    local procedure GetDocumentNo(InDocNo: Code[20])OutDocNo: Code[20]begin
        if InDocNo <> '' then OutDocNo:=DelChr(InDocNo, '=', '!|@|#|$|%/\');
    end;
}
