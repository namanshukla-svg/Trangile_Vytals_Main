Report 50090 "Document Access Management"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Document Access Management.rdl';
    UsageCategory = ReportsandAnalysis;
    ApplicationArea = all;

    dataset
    {
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
    var Tries: Integer;
    W_INUSE: label 'Document %1 is in use by %2';
    W_INUSE_OVRRIDE: label 'Are you sure you want to edit this document even if this can result in changes being lost?';
    E_FILELOST: label 'The document file %1 was removed externally. Document changes lost.';
    E_DOCLOST: label 'The document %1  was deleted. Document lost.';
    local procedure GetStoragePath(): Text[260]begin
        // To activate external storage of documents, fill out exit with a path like exit('x:\common\documents\');
        // Remember the terminating '\'.
        // Before activating external storage, please read the following:
        // 1. All users should have read/write access to the pathdestination
        // 2. The path must point to the same physical harddisk folder for *all* MD3 users
        // 3. You can activate external storage in a system that already has documents in the database.
        //    New documents or modifications to existing documents will then be stored outside the DB from then on.
        //    Old documents will still be avalible.
        // 4. The Database backup will *not* backup external documents, if they are stored externally
        // 5. No matriks support is given for loss of documents, if external storage is activated!!!
        exit('');
    end;
    local procedure GetFileName(var DocumentRec: Record "SSD Document"): Text[260]begin
        exit(GetStoragePath + Format(DocumentRec.Guid) + '.mdoc');
    end;
    local procedure StoreInDB(): Boolean begin
        exit(GetStoragePath = '');
    end;
    procedure RecInDB(var DocumentRec: Record "SSD Document"): Boolean var
        OK: Boolean;
    begin
        OK:=false;
        if DocumentRec.CalcFields(DocumentRec.Content)then OK:=DocumentRec.Content.Hasvalue;
        exit(OK);
    end;
    procedure HasValue(var DocumentRec: Record "SSD Document"): Boolean var
        OK: Boolean;
    begin
        OK:=false;
        // First check DB
        OK:=RecInDB(DocumentRec);
    // If fail, check external storage
    //SSD Comment Start
    //if not OK then
    //if not (IsNullGuid(DocumentRec.Guid) or StoreInDB()) then
    //OK := Exists(GetFileName(DocumentRec));
    //exit(OK);
    //SSD Comment End
    end;
    procedure Import(var DocumentRec: Record "SSD Document"; FileName: Text[260]): Text[260]var
        ImportFileName: Text[260];
    begin
        ImportFileName:='';
        if StoreInDB()then // If external storage is not turned on, store in DB.
 Message('// BIS 1145') // BIS 1145
        //ImportFileName := DocumentRec.Content.IMPORT(FileName, FALSE) // BIS 1145
        else
        begin
            Clear(DocumentRec.Content); // Clear any existing content,
            if IsNullGuid(DocumentRec.Guid)then DocumentRec.Guid:=CreateGuid();
        //SSD Comment Start
        //if Copy(FileName, GetFileName(DocumentRec)) then
        //ImportFileName := FileName;
        //SSD Comment End
        end;
        exit(ImportFileName)end;
    procedure Export(var DocumentRec: Record "SSD Document"; FileName: Text[260]): Text[260]var
        ExportFileName: Text[260];
    begin
        ExportFileName:='';
    //SSD Comment Start
    // if RecInDB(DocumentRec) then
    //     Message('// BIS 1145') // BIS 1145
    //                            //ExportFileName := DocumentRec.Content.EXPORT(FileName, FALSE) // BIS 1145
    // else
    //     if Copy(GetFileName(DocumentRec), FileName) then
    //         ExportFileName := FileName;
    // exit(ExportFileName)
    //SSD Comment End
    end;
    procedure Delete(var DocumentRec: Record "SSD Document"): Boolean begin
    //SSD Comment Start
    // if RecInDB(DocumentRec) then
    //     exit(false)
    // else
    //     exit(Erase(GetFileName(DocumentRec)));
    //SSD Comment End
    end;
    procedure Copy(var FromDocRec: Record "SSD Document"; var ToDocRec: Record "SSD Document"): Boolean var
        istream: InStream;
        ostream: OutStream;
    begin
        if RecInDB(FromDocRec)then begin
            ToDocRec.Content.CreateOutstream(ostream);
            FromDocRec.Content.CreateInstream(istream);
            // Transfer content and other info
            exit(CopyStream(ostream, istream));
        end
        else
        begin
            ToDocRec.Guid:=CreateGuid();
        //SSD exit(Copy(GetFileName(FromDocRec), GetFileName(ToDocRec)));
        end;
    end;
    procedure LockByUsr(var DocumentRec: Record "SSD Document"): Boolean begin
        if DocumentRec."In Use By" <> '' then begin
            if Tries < 2 then begin
                Message(W_INUSE, DocumentRec."No.", DocumentRec."In Use By");
                Tries:=Tries + 1;
                exit(false);
            end;
            if not Confirm(W_INUSE_OVRRIDE)then exit(false);
        end;
        // Set lock markers and modify database
        if UserId() = '' then DocumentRec."In Use By":='*'
        else
            DocumentRec."In Use By":=UserId();
        DocumentRec.Modify(true);
        exit(true);
    end;
    procedure UnlockByUsr(var DocumentRec: Record "SSD Document"): Boolean var
        OK: Boolean;
        Document: Record "SSD Document";
    begin
        OK:=false;
        // Re-Read document to absorb any changes made (external db removals?)
        if Document.Get(DocumentRec."Document Type", DocumentRec."No.")then begin
            Document."In Use By":='';
            OK:=Document.Modify(true);
        end
        else
            Message(E_DOCLOST + '(' + Format(DocumentRec."Document Type") + ' - ' + DocumentRec."No." + ')-[u]', Document."No.");
        exit(OK);
    end;
    procedure ImportAltDoc(var DocumentRec: Record "SSD Document"): Boolean var
        OK: Boolean;
        Document: Record "SSD Document";
        ImportName: Text[260];
    begin
    //SSD Comment Start
    // OK := false;
    // // Re-Read document to absorb any changes made (external file removals?)
    // if Document.Get(DocumentRec."Document Type", DocumentRec."No.") then begin
    //     if Exists(Document.GetAltFileName) then begin
    //         // Import Document into blob
    //         ImportName := Import(Document, UpperCase(Document.GetAltFileName)); // Import altered document
    //         OK := ImportName <> '';
    //         if OK then
    //             OK := Document.Modify(true);
    //     end else
    //         Message(E_FILELOST + ' (Document.GetAltFileName)', Document.GetAltFileName);
    // end else
    //     Message(E_DOCLOST + '(' + Format(DocumentRec."Document Type") + ' - ' + DocumentRec."No." + ')-[i]', Document."No.");
    // exit(OK);
    //SSD Comment Start
    end;
}
