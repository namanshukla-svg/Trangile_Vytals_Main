Page 50073 "Document Setup"
{
    // *** Matriks Doc Ver. 3 ***
    // By Tim Ahrentl¢v for Matriks A/S.
    // Visit www.matriks.com for news and updates.
    // 
    // 3.02 (2005.08.02):
    // Prepared for online help. Help button code removed.
    // 
    // 3.01 (2003.08.22):
    // Workpath field made invisible to prevent unnecessary usage.
    Caption = 'Document Setup';
    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = List;
    SourceTable = "SSD Document Setup";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';

                field(Importpath; Rec.Importpath)
                {
                    ApplicationArea = All;
                }
                field(Exportpath; Rec.Exportpath)
                {
                    ApplicationArea = All;
                }
                field("Journal Importpath"; Rec."Journal Importpath")
                {
                    ApplicationArea = All;
                }
                field("Journal Backuppath"; Rec."Journal Backuppath")
                {
                    ApplicationArea = All;
                }
                field("Skip Size (Bytes)"; Rec."Skip Size (Bytes)")
                {
                    ApplicationArea = All;
                }
                field(Workpath; Rec.Workpath)
                {
                    ApplicationArea = All;
                    Visible = false;
                }
            }
            group(Numbering)
            {
                Caption = 'Numbering';

                field("Document Nos."; Rec."Document Nos.")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
    actions
    {
    }
    trigger OnOpenPage()
    begin
        Rec.Reset;
        if not Rec.Get then begin
            Rec.Init;
            Rec.Insert;
        end;
    end;
}
