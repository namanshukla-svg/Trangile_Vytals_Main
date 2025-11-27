Page 50074 Documents
{
    // *** Matriks Doc Ver. 3 ***
    // By Tim Ahrentl¢v for Matriks A/S.
    // Visit www.matriks.com for news and updates.
    // 
    // 3.06 (2005.12.08)
    // Form height set to 6710
    // 
    // 3.05 (2005.08.02):
    // Prepared for online help. Help button code removed.
    // 
    // 3.04 (2004.05.28):
    // OnTimer trigger call to DocMgt.Finish every 5 seconds to unlock document if possible. (Better concurrency).
    // New DocMgt.Finish Parameter used.
    // 
    // 3.03 (2004.05.14):
    // Improved concurrency modus by adding a CurrRecUpdate in TemplateName-OnValidate/OnLookUp and new code in OnAfterGetCurrRecord()
    // Shortcut on Document button.
    // 
    // 3.02 (2003.08.05):
    // Bugfix: OnValidate for Template Name, used "No." instead of "Template Name" for Get of TemplateRec.
    // 
    // 3.01 (2003.07.21):
    // BugFix: Doucment button's HorzGlue & VertGlue set to Right and Bottom.
    Caption = 'Documents';
    DelayedInsert = true;
    PageType = List;
    PopulateAllFields = true;
    SourceTable = "SSD Document";
    SourceTableView = sorting("Document Type", "No.")order(ascending)where("Document Type"=const(Document));
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field("File Extension"; Rec."File Extension")
                {
                    ApplicationArea = All;
                }
                field(Category; Rec.Category)
                {
                    ApplicationArea = All;
                }
                field("Created Date"; Rec."Created Date")
                {
                    ApplicationArea = All;
                }
                field("Modified Date"; Rec."Modified Date")
                {
                    ApplicationArea = All;
                    Visible = true;
                }
                field("Modified By"; Rec."Modified By")
                {
                    ApplicationArea = All;
                    Visible = true;
                }
                field("In Use By"; Rec."In Use By")
                {
                    ApplicationArea = All;
                    Visible = true;
                }
            }
        }
    }
    actions
    {
        area(navigation)
        {
            group("&Document")
            {
                Caption = '&Document';

                action(View)
                {
                    ApplicationArea = All;
                    Caption = 'View';
                    ShortCutKey = 'Shift+Ctrl+V';
                //SSDU Commented
                // trigger OnAction()
                // begin
                //     Rec.View(DocMgt);
                // end;
                //SSDU Commented
                }
                action(Edit)
                {
                    ApplicationArea = All;
                    Caption = 'Edit';
                    ShortCutKey = 'Shift+Ctrl+E';
                //SSDU Commented
                // trigger OnAction()
                // begin
                //     Rec.Edit(DocMgt);
                // end;
                //SSDU Commented
                }
            }
            group("Fu&nction")
            {
                Caption = 'Fu&nction';

                action(Import)
                {
                    ApplicationArea = All;
                    Caption = 'Import';
                    Ellipsis = true;

                    trigger OnAction()
                    var
                        OK: Boolean;
                    begin
                        Rec.Import('', true);
                        CurrPage.Update(true);
                    end;
                }
                action(Export)
                {
                    ApplicationArea = All;
                    Caption = 'Export';
                    Ellipsis = true;

                    trigger OnAction()
                    var
                        OK: Boolean;
                    begin
                        Rec.Export('', true);
                    end;
                }
                action(Copy)
                {
                    ApplicationArea = All;
                    Caption = 'Copy';
                    Image = Copy;

                    trigger OnAction()
                    begin
                        Rec.Clone();
                        CurrPage.Update(true);
                    end;
                }
                separator(Action26)
                {
                }
                action(Send)
                {
                    ApplicationArea = All;
                    Caption = 'Send';
                    Ellipsis = true;

                    trigger OnAction()
                    begin
                        Rec.Send();
                    end;
                }
                action(Print)
                {
                    ApplicationArea = All;
                    Caption = 'Print';
                    Ellipsis = true;
                    Image = Print;

                    trigger OnAction()
                    begin
                        Rec.Print();
                    end;
                }
            }
        }
    }
    trigger OnAfterGetRecord()
    begin
        OnAfterGetCurrRecord;
    end;
    trigger OnDeleteRecord(): Boolean begin
        exit(not Rec.IsInUse(true));
    end;
    trigger OnModifyRecord(): Boolean begin
        exit(not Rec.IsInUse(true));
    end;
    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        OnAfterGetCurrRecord;
    end;
    trigger OnQueryClosePage(CloseAction: action): Boolean begin
    //SSDU exit(DocMgt.Finish(false));
    end;
    var //SSDU DocMgt: Report "Document Management"; 
    DocAccMgt: Report "Document Access Management";
    local procedure OnAfterGetCurrRecord()
    begin
        xRec:=Rec;
        CurrPage.Editable:=Rec."In Use By" = '';
    end;
    local procedure OnTimer()
    begin
    //SSDU Commented
    // if DocMgt.Finish(true) then
    //     DocMgt.Finish(false);
    //SSDU Commented
    end;
}
