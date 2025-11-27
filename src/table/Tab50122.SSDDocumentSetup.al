Table 50122 "SSD Document Setup"
{
    // *** Matriks Doc Version 3 ***
    // By Tim Ahrentl¢v for Matriks A/S.
    // Visit www.matriks.com for news and updates.
    // 
    // 3.05 (2004.12.01):
    // New functions, ExtractFilePath() and ExtractFileNameAndExt().
    // 
    // 3.04 (2004.05.12):
    // File fields and related functions extended to 250 chars.
    // 
    // 3.03 (2004.03.17):
    // ExtractFileName extended with a truncate size parameter.
    // ExtractFileName - ToPos calculated correctly even if no file type extension.
    // StrLastDotPos calculation fixed.
    // 
    // 3.02 (2004.20.01):
    // StrLastDotPos improved to handle wierd filenames.
    // Bugfix in ExtractLastExt. (>1 instead of > 0).
    // 
    // 3.01 (2003.12.02):
    // New local function StrLastDotPos
    // ExtractFileExt and ExtractFileName improved to handle additional dots in path/filename.
    Caption = 'Document Setup';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Primary Key"; Code[10])
        {
            Caption = 'Primary Key';
            DataClassification = CustomerContent;
        }
        field(2; "Document Nos."; Code[10])
        {
            Caption = 'Document Nos.';
            TableRelation = "No. Series";
            DataClassification = CustomerContent;
        }
        field(3; Importpath; Text[250])
        {
            Caption = 'Importpath';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                SetBackSlash(Importpath)end;
        }
        field(4; Exportpath; Text[250])
        {
            Caption = 'Exportpath';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                SetBackSlash(Exportpath)end;
        }
        field(5; Workpath; Text[250])
        {
            Caption = 'Workpath';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                SetBackSlash(Workpath)end;
        }
        field(6; "Journal Importpath"; Text[250])
        {
            Caption = 'Journal Importpath';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                SetBackSlash("Journal Importpath")end;
        }
        field(7; "Journal Backuppath"; Text[250])
        {
            Caption = 'Journal Backuppath';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                SetBackSlash("Journal Backuppath")end;
        }
        field(10; "Skip Size (Bytes)"; Integer)
        {
            Caption = 'Skip Size (Bytes)';
            DataClassification = CustomerContent;
        }
    }
    keys
    {
        key(Key1; "Primary Key")
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
    }
    trigger OnInsert()
    begin
        "Skip Size (Bytes)":=60089500;
    end;
    local procedure SetBackSlash(var Value: Text[250])
    begin
        if Value <> '' then if Value[StrLen(Value)] <> '\' then Value:=Value + '\';
    end;
    procedure GetImportPath(): Text[250]begin
        if Importpath = '' then exit(GetTmpPath)
        else
            exit(Importpath);
    end;
    procedure GetExportPath(): Text[250]begin
        if Exportpath = '' then exit(GetTmpPath)
        else
            exit(Exportpath);
    end;
    procedure GetJournalImportPath(): Text[250]begin
        if "Journal Importpath" = '' then exit(GetTmpPath)
        else
            exit("Journal Importpath");
    end;
    procedure GetJournalBackupPath(): Text[250]begin
        if "Journal Backuppath" = '' then exit(GetTmpPath)
        else
            exit("Journal Backuppath");
    end;
    procedure GetWorkPath(): Text[250]begin
        if Workpath = '' then exit(GetTmpPath)
        else
            exit(Workpath);
    end;
    local procedure GetTmpPath()result: Text[250]begin
        //result := ENVIRON('TEMP'); // BIS 1145
        if result = '' then result:='c:'; // Panic
        SetBackSlash(result);
        exit(result);
    end;
    local procedure StrLastDotPos(var Filename: Text[250]): Integer var
        ToPos: Integer;
        FromPos: Integer;
        Flag: Boolean;
    begin
        Flag:=true;
        FromPos:=StrLen(Filename);
        while(FromPos > 1) and Flag do begin
            if Filename[FromPos] = '.' then Flag:=false
            else
                FromPos:=FromPos - 1;
        end;
        if FromPos = 1 then FromPos:=0;
        exit(FromPos);
    end;
    procedure ExtractFileExt(FileName: Text[250]): Text[10]var
        FromPos: Integer;
    begin
        FromPos:=StrLastDotPos(FileName);
        if FromPos > 1 then exit(CopyStr(FileName, FromPos + 1))
        else
            exit('');
    end;
    procedure ExtractFileName(AbsFileName: Text[250]; TruncSize: Integer): Text[250]var
        ToPos: Integer;
        FromPos: Integer;
        Flag: Boolean;
    begin
        Flag:=true;
        ToPos:=StrLastDotPos(AbsFileName);
        if ToPos = 0 then ToPos:=StrLen(AbsFileName) + 1;
        FromPos:=ToPos - 1;
        while(FromPos > 1) and Flag do begin
            if(AbsFileName[FromPos - 1] = '\')then Flag:=false
            else
                FromPos:=FromPos - 1;
        end;
        // Truncate if filename to long
        if((ToPos - FromPos) > TruncSize) and (TruncSize > 0)then ToPos:=FromPos + TruncSize;
        exit(CopyStr(AbsFileName, FromPos, ToPos - FromPos));
    end;
    procedure ExtractFileNameAndExt(AbsFileName: Text[250]; TruncSize: Integer): Text[250]var
        ToPos: Integer;
        FromPos: Integer;
        Flag: Boolean;
    begin
        Flag:=true;
        ToPos:=StrLen(AbsFileName) + 1;
        FromPos:=ToPos - 1;
        while(FromPos > 1) and Flag do begin
            if(AbsFileName[FromPos - 1] = '\')then Flag:=false
            else
                FromPos:=FromPos - 1;
        end;
        // Truncate if filename to long
        if((ToPos - FromPos) > TruncSize) and (TruncSize > 0)then ToPos:=FromPos + TruncSize;
        exit(CopyStr(AbsFileName, FromPos, ToPos - FromPos));
    end;
    procedure ExtractFilePath(AbsFileName: Text[250]; TruncSize: Integer): Text[250]var
        ToPos: Integer;
        FromPos: Integer;
        Flag: Boolean;
    begin
        Flag:=true;
        ToPos:=StrLen(AbsFileName);
        while(ToPos > 1) and Flag do begin
            if(AbsFileName[ToPos] = '\')then Flag:=false
            else
                ToPos:=ToPos - 1;
        end;
        // Truncate if filename to long
        if(ToPos > TruncSize) and (TruncSize > 0)then ToPos:=TruncSize;
        exit(CopyStr(AbsFileName, 1, ToPos));
    end;
    procedure SupportAtMatriks()
    var
        CompanyInfo: Record "Company Information";
        SupportUrl: Text[256];
    begin
        if CompanyInfo.Get()then begin
            SupportUrl:=UpperCase(SerialNumber + ';' + CompanyInfo.Name + ';' + CompanyInfo."Home Page" + ';' + CompanyInfo."E-Mail" + ';');
            SupportUrl:=ConvertStr(SupportUrl, '0123456789ABCDEFGHIJKLMNOPQRSTUVXYZ -@.&;', 'ZYXVUTSRQPONMLKJIHGFEDCBA9876543210,+-*!_');
            Hyperlink('http://www.matriks.com/index.html?support=' + SupportUrl);
        end;
    end;
}
