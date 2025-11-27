Table 50045 "SSD Document"
{
    // *** Matriks Doc Version 3 ***
    // By Tim Ahrentl¢v for Matriks A/S.
    // Visit www.matriks.com for news and updates.
    // 
    // 3.11 (2005.12.05):
    // Missing translations of document type added.
    // 
    // 3.10 (2005.06.29):
    // Bugfix: Function GetMailAdr() changed to work on "Reference No. 1" instead of "Reference No. 2"
    // 
    // 3.09 (2004.11.23):
    // FileName var's extended to 260 chars in Import() function.
    // New field GUID
    // Ext. Document Storage implemented via Document Access Management coudeunit in:
    // - OnDelete(), HasContent(), Import(), Export(), Clone(), CopyTemplate()
    // 
    // 3.08 (2004.08.25):
    // On Field Reference No. 1, Inserted as many tablerelations as system would permit, primarily to
    // "1 part primary key" tables, but on no 99000xxx Manufactoring tables.
    // 
    // 3.07 (2004.05.28):
    // New function, GetAltFileName()
    // 
    // 3.06 (2004.05.05):
    // InUse function now implements ShowDialog parameter. Also refreshed document record for better concurrency.
    // File variables/parameters set to 250 chars.
    // Special chars in Description field are replaced with _
    // 
    // 3.05 (2003.03.17):
    // Import function implement ExtractFilename truncate size parameter.
    // 
    // 3.04 (2003.12.02):
    // DrillDownForm set to DocumentForm.
    // 
    // 3.03 (2003.08.12):
    // Bugfix: "In Use By" is reset on document when cloned.
    // 
    // 3.02 (2003.07.24):
    // New Field, special, for special coded templates, added.
    // Template field logic moved to field (Table No.) from template form.
    // 
    // 3.01 (2003.07.01):
    // Function "CloneTemplate" called on TmplField in function "Clone" to ensure that template fields are cloned as well.
    Caption = 'Document';
    DataCaptionFields = Description;
    DrillDownPageID = "Auto Appove PO";
    LookupPageID = "Auto Appove PO";
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Document Type"; Option)
        {
            Caption = 'Document Type';
            OptionCaption = 'Document,Template';
            OptionMembers = Document,Template;
            DataClassification = CustomerContent;
        }
        field(2; "No."; Code[20])
        {
            Caption = 'No.';
            DataClassification = CustomerContent;
        }
        field(3; "Document No."; Code[20])
        {
            Caption = 'Document No.';
            DataClassification = CustomerContent;
        }
        field(4; "Table No."; Integer)
        {
            BlankZero = true;
            Caption = 'Table No.';
            DataClassification = CustomerContent;

            //SSD TableRelation = "Table Information"."Table No.";
            trigger OnLookup()
            var
                TmplField: Record "SSD Template Field";
            //SSDU TableListForm: Page "Document Table List";
            //SSD TableListRec: Record "Table Information";
            begin
                if "Document Type" = "document type"::Template then begin
                    SetupNew();
                    //SSDU TableListForm.LookupMode := true;
                    //SSD Comment Start
                    // if TableListForm.RunModal = Action::LookupOK then begin
                    //     TableListForm.GetRecord(TableListRec);
                    //     "Table No." := TableListRec."Table No.";
                    //     CalcFields("Table Name");
                    //     TmplField.RefreshTemplate(Rec, true);
                    // end;
                    //SSD Comment End
                end;
            end;

            trigger OnValidate()
            var
                TmplField: Record "SSD Template Field";
            begin
                if "Document Type" = "document type"::Template then begin
                    SetupNew();
                    CalcFields("Table Name");
                    TmplField.RefreshTemplate(Rec, true);
                end;
            end;
        }
        field(5; "Reference No. 1"; Code[20])
        {
            Caption = 'Reference No. 1';
            TableRelation = if ("Table No." = const(13)) "Salesperson/Purchaser".Code
            else if ("Table No." = const(15)) "G/L Account"."No."
            else if ("Table No." = const(18)) Customer."No."
            else if ("Table No." = const(23)) Vendor."No."
            else if ("Table No." = const(27)) Item."No."
            else if ("Table No." = const(156)) Resource."No."
            else if ("Table No." = const(167)) Job."No."
            else if ("Table No." = const(84)) "Acc. Schedule Name".Name
            else if ("Table No." = const(270)) "Bank Account"."No."
            else if ("Table No." = const(295)) "Reminder Header"."No."
            else if ("Table No." = const(302)) "Finance Charge Memo Header"."No."
            else if ("Table No." = const(5050)) Contact."No."
            else if ("Table No." = const(5071)) Campaign."No."
            else if ("Table No." = const(5076)) "Segment Header"."No."
            else if ("Table No." = const(5200)) Employee."No."
            else if ("Table No." = const(5600)) "Fixed Asset"."No."
            else if ("Table No." = const(5628)) Insurance."No."
            else if ("Table No." = const(5718)) "Nonstock Item"."Entry No."
            else if ("Table No." = const(5740)) "Transfer Header"."No.";
            DataClassification = CustomerContent;
        }
        field(6; "Reference No. 2"; Code[20])
        {
            Caption = 'Reference No.2';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(7; "Reference No. 3"; Code[20])
        {
            Caption = 'Reference No.3';
            DataClassification = CustomerContent;
        }
        field(10; "Table Name"; Text[30])
        {
            //SSD CalcFormula = lookup("Table Information"."Table Name" where("Table No." = field("Table No.")));
            Caption = 'Table Name';
            Editable = false;
            FieldClass = FlowField;
        }
        field(11; "Template Name"; Code[20])
        {
            Caption = 'Template Name';
            TableRelation = "SSD Document"."No." where("Document Type" = const(Template));
            DataClassification = CustomerContent;
        }
        field(12; Description; Text[50])
        {
            Caption = 'Description';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                Description := ConvertStr(Description, '!"#£@Ÿ$%&/(){[]}=?+`Ù|^~õ*:.;,\<>', '_________________________________');
            end;
        }
        field(13; Content; Blob)
        {
            Caption = 'Content';
            DataClassification = CustomerContent;
        }
        field(14; "File Extension"; Text[10])
        {
            Caption = 'File Extension';
            DataClassification = CustomerContent;
        }
        field(15; "In Use By"; Code[20])
        {
            Caption = 'In Use By';
            Editable = true;
            TableRelation = User.State;
            ValidateTableRelation = false;
            DataClassification = CustomerContent;
        }
        field(16; Special; Boolean)
        {
            Caption = 'Special';
            DataClassification = CustomerContent;

            trigger OnValidate()
            var
                TmplField: Record "SSD Template Field";
            begin
                TmplField.RefreshTemplate(Rec, true);
            end;
        }
        field(17; "Created Date"; Date)
        {
            Caption = 'Created Date';
            DataClassification = CustomerContent;
        }
        field(18; "Modified Date"; Date)
        {
            Caption = 'Modified Date';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(19; "Modified By"; Code[20])
        {
            Caption = 'Modified By';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(20; Category; Code[10])
        {
            Caption = 'Category';
            TableRelation = "SSD Document Category";
            DataClassification = CustomerContent;
        }
        field(21; Indexed; Boolean)
        {
            Caption = 'Indexed';
            DataClassification = CustomerContent;
        }
        field(22; "Guid"; Guid)
        {
            Caption = 'Guid';
            DataClassification = CustomerContent;
        }
    }
    keys
    {
        key(Key1; "Document Type", "No.")
        {
            Clustered = true;
        }
        key(Key2; "Table No.", "Reference No. 1", "Reference No. 2", "Reference No. 3")
        {
        }
        key(Key3; "Document No.", "Created Date")
        {
        }
        key(Key4; "No.")
        {
        }
    }
    fieldgroups
    {
    }
    trigger OnDelete()
    var
        TmplField: Record "SSD Template Field";
    begin
        if "Document Type" = "document type"::Template then begin
            TmplField.SetRange(TmplField."Template Name", "No.");
            TmplField.DeleteAll;
        end;
        DocAccMgt.Delete(Rec);
    end;

    trigger OnInsert()
    begin
        SetupNew;
        "Created Date" := Today;
    end;

    trigger OnModify()
    begin
        "Modified Date" := Today;
        "Modified By" := UserId;
    end;

    var
        DocumentSetup: Record "SSD Document Setup";
        I_EXPORT: label 'Export Document';
        I_IMPORT: label 'Import Document';
        E_NOCONTENT: label 'No document';
        E_NONAME: label 'No name';
        W_OVERWRITE: label 'Overwrite existing document?';
        W_ISINUSE: label 'The document is in use by %1';
        DocAccMgt: Report "Document Access Management";

    local procedure GetMailAdr(): Text[80]
    var
        CustomerRec: Record Customer;
        VendorRec: Record Vendor;
        ContactRec: Record Contact;
        EmployeeRec: Record Employee;
        BankRec: Record "Bank Account";
    begin
        if "Reference No. 1" = '' then exit('');
        case "Table No." of
            18:
                if CustomerRec.Get("Reference No. 1") then
                    exit(CustomerRec."E-Mail");
            23:
                if VendorRec.Get("Reference No. 1") then
                    exit(VendorRec."E-Mail");
            5200:
                if EmployeeRec.Get("Reference No. 1") then
                    exit(EmployeeRec."E-Mail");
            5050:
                if ContactRec.Get("Reference No. 1") then
                    exit(ContactRec."E-Mail");
            270:
                if BankRec.Get("Reference No. 1") then
                    exit(BankRec."E-Mail");
        end;
    end;

    procedure GetFileName(): Text[260]
    begin
        DocumentSetup.Get;
        exit(DocumentSetup.GetWorkPath() + UserId + '_' + "No." + '.' + "File Extension");
    end;

    procedure GetAltFileName(): Text[260]
    begin
        DocumentSetup.Get;
        exit(DocumentSetup.GetWorkPath() + UserId + '_' + "No." + '_' + 'alt' + '.' + "File Extension");
    end;

    procedure IsInUse(ShowDialog: Boolean): Boolean
    var
        OK: Boolean;
        DocumentRec: Record "SSD Document";
    begin
        OK := DocumentRec.Get("Document Type", "No.");
        if not OK then exit(false);
        OK := DocumentRec."In Use By" = '';
        if (not OK) and ShowDialog then Message(W_ISINUSE, DocumentRec."In Use By");
        exit(not OK);
    end;

    procedure HasContent(ShowDialog: Boolean): Boolean
    var
        OK: Boolean;
        DocumentRec: Record "SSD Document Setup";
    begin
        OK := false;
        if "No." <> '' then if DocumentRec.Get("Document Type", "No.") then OK := DocAccMgt.HasValue(Rec);
        if (not OK) and ShowDialog then Message(E_NOCONTENT);
        exit(OK);
    end;

    procedure SetupNew()
    var
        //IG_DS_Before  NoSerieMgnt: Codeunit NoSeriesManagement;
        NoSerieMgnt: Codeunit "No. Series";
    begin
        if ("No." = '') then
            case "Document Type" of
                "document type"::Document:
                    begin
                        DocumentSetup.Get;
                        DocumentSetup.TestField("Document Nos.");
                        //IG_DS_Before NoSerieMgnt.InitSeries(DocumentSetup."Document Nos.", '', 0D, "No.", DocumentSetup."Document Nos.");
                        //  if NoSerieMgnt.AreRelated(DocumentSetup."Document Nos.", '') then
                        //  "No. Series" := xRec."No. Series";
                        "No." := NoSerieMgnt.GetNextNo(DocumentSetup."Document Nos.");
                    end;
                "document type"::Template:
                    Error(E_NONAME);
            end;
    end;
    //SSDU Comment Start
    // procedure View(var DocMgt: Report "Document Management"): Boolean
    // var
    //     OK: Boolean;
    // begin
    //     if HasContent(true) then
    //         OK := DocMgt.View(Rec);
    //     exit(OK);
    // end;
    // procedure Edit(var DocMgt: Report "Document Management"): Boolean
    // var
    //     OK: Boolean;
    // begin
    //     if HasContent(true) then
    //         OK := DocMgt.Edit(Rec);
    //     exit(OK);
    // end;
    //SSDU Comment End
    procedure Import(FileName: Text[260]; ShowDialog: Boolean): Boolean
    var
        ImportName: Text[260];
    begin
        if IsInUse(true) then exit;
        DocumentSetup.Get;
        // Initialize ImportPath if empty
        if FileName = '' then begin
            if not ShowDialog then exit(false);
            FileName := DocumentSetup.GetImportPath();
            if ShowDialog then FileName := FileName + '*';
        end;
        // Already a document?
        if HasContent(false) then if ShowDialog then if not Dialog.Confirm(W_OVERWRITE, false) then exit(false);
        /* // BIS 1145
        // Import document
        IF ShowDialog THEN BEGIN
          FileName := CommonDlgMgt.OpenFile(I_IMPORT, FileName, 4, '*.*', 0);
          IF STRPOS(FileName, '*') > 0 THEN EXIT(FALSE); // Cancel
        END;
        
        ImportName := DocAccMgt.Import(Rec, FileName);
        */
        // Set fields in record
        if ImportName <> '' then begin
            "File Extension" := DocumentSetup.ExtractFileExt(ImportName);
            Description := DocumentSetup.ExtractFileName(ImportName, 50);
        end;
        exit(ImportName <> '');
    end;

    procedure Export(FileName: Text[260]; ShowDialog: Boolean): Boolean
    var
        ExportName: Text[260];
    begin
        DocumentSetup.Get;
        ExportName := '';
        /* // BIS 1145
            // Only if content
            IF HasContent(TRUE) THEN BEGIN
              IF FileName = '' THEN
                FileName := DocumentSetup.GetExportPath() + Description + '.' + "File Extension";

              IF ShowDialog THEN
                FileName :=
                CommonDlgMgt.OpenFile(I_EXPORT, FileName, 4, '*.*', 1);

              ExportName := DocAccMgt.Export(Rec, FileName);
            END;

            EXIT(ExportName <> '');
            */
    end;

    procedure Navigate()
    var
        NavigateForm: Page Navigate;
    begin
        NavigateForm.SetDoc(Today, "Document No.");
        NavigateForm.Run;
    end;

    procedure Clone()
    var
        DocumentRec: Record "SSD Document";
        TmplField: Record "SSD Template Field";
    begin
        //IF IsInUse(TRUE) THEN
        //  EXIT;
        if HasContent(true) then begin
            DocumentRec.Copy(Rec);
            DocumentRec."In Use By" := '';
            DocumentRec."Modified Date" := 0D;
            DocumentRec."Modified By" := '';
            if "Document Type" = "document type"::Document then begin
                DocumentRec."No." := '';
                DocumentRec.Insert(true);
            end
            else begin
                DocumentRec."No." := IncStr("No.");
                if DocumentRec."No." = '' then DocumentRec."No." := "No." + '01';
                while not DocumentRec.Insert do DocumentRec."No." := IncStr(DocumentRec."No.");
                // Clone template fields as well
                if DocumentRec."Table No." <> 0 then TmplField.CloneTemplate("No.", DocumentRec."No.");
            end;
            if not DocAccMgt.RecInDB(Rec) then DocAccMgt.Copy(Rec, DocumentRec);
        end;
    end;

    procedure Send()
    var
        FileName: Text[250];
        Mail: Codeunit Mail;
    begin
        if IsInUse(true) then exit;
        DocumentSetup.Get;
        FileName := DocumentSetup.GetWorkPath() + Description + '.' + "File Extension";
        // Export document and create mails with this attachment
        //SSD Comment Start
        // if Export(FileName, false) then begin
        //     Mail.NewMessage(GetMailAdr, '', Description, '', FileName, '', true);
        //     FILE.Erase(FileName);
        // end;
        //SSD Comment End
    end;

    procedure Print(): Boolean
    var
        OSIntf: Report "OS Interface Routines";
        Path: Text[250];
        Name: Text[250];
    begin
        if IsInUse(true) then exit;
        DocumentSetup.Get;
        Path := DocumentSetup.GetWorkPath();
        Name := Description + '.' + "File Extension";
        // Export document and create mails with this attachment
        if Export(Path + Name, false) then begin
            OSIntf.Print(Path, Name);
            //  FILE.ERASE(Path + Name);
        end;
    end;
    //SSDU Comment Start
    // procedure CopyTemplate(var DocMgt:Report "Document Management"): Boolean
    // var
    //     OK: Boolean;
    //     istream: InStream;
    //     ostream: OutStream;
    //     TemplateRec: Record "SSD Document Setup";
    // begin
    //     // IF IsInUse(TRUE) THEN
    //     //  EXIT;
    //     //
    //     // DocumentSetup.GET;
    //     //
    //     // // Already a document?
    //     // IF HasContent(FALSE) THEN
    //     //  IF NOT DIALOG.CONFIRM(W_OVERWRITE, FALSE) THEN
    //     //    EXIT(FALSE);
    //     //
    //     // // Any templatename?
    //     // TESTFIELD("Template Name");
    //     //
    //     // OK := FALSE;
    //     // // Copy template blob to document blob
    //     // IF TemplateRec.GET("Document Type"::Template,"Template Name") THEN BEGIN
    //     //
    //     //  IF TemplateRec.HasContent(TRUE) THEN BEGIN
    //     //    OK := DocAccMgt.Copy(TemplateRec, Rec);
    //     //    // Transfer necessary fields
    //     //    Description := TemplateRec.Description;
    //     //    "File Extension" := TemplateRec."File Extension";
    //     //    Special := TemplateRec.Special;
    //     //  END;
    //     // END;
    //     //
    //     // EXIT(OK);
    // end;
}
