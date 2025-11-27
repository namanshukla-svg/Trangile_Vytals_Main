pageextension 50133 "SSD Fixed Assets G/L Journal" extends "Fixed Asset G/L Journal"
{
    layout
    {
        addlast(Control1)
        {
            field("Incoming Document Entry No."; Rec."Incoming Document Entry No.")
            {
                ApplicationArea = Basic, Suite;
                ToolTip = 'Specifies the number of the incoming document that this Bank Payment Voucher line is created for.';
                Visible = false;

                trigger OnAssistEdit()
                begin
                    if Rec."Incoming Document Entry No." > 0 then Hyperlink(Rec.GetIncomingDocumentURL());
                end;
            }
        }
        addafter(JournalLineDetails)
        {
            part(IncomingDocAttachFactBox; "Incoming Doc. Attach. FactBox")
            {
                ApplicationArea = All;
                ShowFilter = false;
            }
        }
    }
    actions
    {
        addlast(processing)
        {
            group(IncomingDocument)
            {
                Caption = 'Incoming Document';
                Image = Documents;

                action(IncomingDocCard)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'View Incoming Document';
                    Enabled = HasIncomingDocument;
                    Image = ViewOrder;
                    ToolTip = 'View any incoming document records and file attachments that exist for the entry or document.';

                    trigger OnAction()
                    var
                        IncomingDocument: Record "Incoming Document";
                    begin
                        IncomingDocument.ShowCardFromEntryNo(Rec."Incoming Document Entry No.");
                    end;
                }
                action(SelectIncomingDoc)
                {
                    AccessByPermission = TableData "Incoming Document"=R;
                    ApplicationArea = Basic, Suite;
                    Caption = 'Select Incoming Document';
                    Image = SelectLineToApply;
                    ToolTip = 'Select an incoming document record and file attachment that you want to link to the entry or document.';

                    trigger OnAction()
                    var
                        IncomingDocument: Record "Incoming Document";
                    begin
                        Rec.Validate("Incoming Document Entry No.", IncomingDocument.SelectIncomingDocument(Rec."Incoming Document Entry No.", Rec.RecordId()));
                    end;
                }
                action(IncomingDocAttachFile)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Create Incoming Document from File';
                    Ellipsis = true;
                    Enabled = not HasIncomingDocument;
                    Image = Attach;
                    ToolTip = 'Create an incoming document record by selecting a file to attach, and then link the incoming document record to the entry or document.';

                    trigger OnAction()
                    var
                        IncomingDocumentAttachment: Record "Incoming Document Attachment";
                    begin
                        IncomingDocumentAttachment.NewAttachmentFromGenJnlLine(Rec);
                    end;
                }
                action(RemoveIncomingDoc)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Remove Incoming Document';
                    Enabled = HasIncomingDocument;
                    Image = RemoveLine;
                    ToolTip = 'Remove any incoming document records and file attachments.';

                    trigger OnAction()
                    var
                        IncomingDocument: Record "Incoming Document";
                    begin
                        if IncomingDocument.Get(Rec."Incoming Document Entry No.")then IncomingDocument.RemoveLinkToRelatedRecord();
                        Rec."Incoming Document Entry No.":=0;
                        Rec.Modify(true);
                    end;
                }
            }
        }
    }
    trigger OnAfterGetRecord()
    begin
        HasIncomingDocument:=Rec."Incoming Document Entry No." <> 0;
        CurrPage.IncomingDocAttachFactBox.Page.SetCurrentRecordID(Rec.RecordId());
    end;
    trigger OnAfterGetCurrRecord()
    begin
        CurrPage.IncomingDocAttachFactBox.Page.LoadDataFromRecord(Rec);
    end;
    trigger OnInsertRecord(BelowxRec: Boolean): Boolean begin
        CurrPage.IncomingDocAttachFactBox.Page.SetCurrentRecordID(Rec.RecordId());
    end;
    var HasIncomingDocument: Boolean;
}
