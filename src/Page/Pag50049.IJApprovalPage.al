Page 50049 "IJ_ApprovalPage"
{
    AutoSplitKey = true;
    Caption = 'Item Journal';
    DataCaptionFields = "Journal Batch Name";
    DelayedInsert = true;
    Editable = false;
    PageType = Worksheet;
    SaveValues = true;
    SourceTable = "Item Journal Line";
    SourceTableView = where(Approval=filter(false), "Approval ID"=filter(<>''));
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = All;
                }
                field("Document Date"; Rec."Document Date")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Entry Type"; Rec."Entry Type")
                {
                    ApplicationArea = All;
                    OptionCaption = 'Purchase,Sale,Positive Adjmt.,Negative Adjmt.';
                }
                field("Document No."; Rec."Document No.")
                {
                    ApplicationArea = All;
                }
                field("External Document No."; Rec."External Document No.")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Item No."; Rec."Item No.")
                {
                    ApplicationArea = All;
                }
                field("Send for Approval"; Rec."Send for Approval")
                {
                    ApplicationArea = All;
                }
                field(Approval; Rec.Approval)
                {
                    ApplicationArea = All;
                }
                field("Sender ID"; Rec."Sender ID")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
    actions
    {
        area(processing)
        {
            group("F&unctions")
            {
                Caption = 'F&unctions';
                Image = "Action";

                action(Approve)
                {
                    ApplicationArea = All;
                    Caption = 'Approve';
                    Image = Approve;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;

                    trigger OnAction()
                    begin
                        if UserSetup.Get(UserId)then if UserSetup."IJL Approval" then begin
                                CurrPage.SetSelectionFilter(ItemJournalLine);
                                if ItemJournalLine.FindSet then ItemJournalLine.ModifyAll(Approval, true);
                            end
                            else
                                Error('You are not authorised for approval');
                        Clear(ItemJournalLine);
                    end;
                }
            }
        }
    }
    trigger OnDeleteRecord(): Boolean var
        ReserveItemJnlLine: Codeunit "Item Jnl. Line-Reserve";
    begin
    end;
    trigger OnInit()
    begin
        if UserSetup.Get(UserId)then if UserSetup."IJL Approval" then begin
                ItemJournalLine.Reset;
                ItemJournalLine.SetRange("Send for Approval", true);
                if ItemJournalLine.FindSet then ItemJournalLine.ModifyAll("Approval ID", UserSetup."User ID");
            end
            else
            begin
                ItemJournalLine.Reset;
                ItemJournalLine.SetRange("Send for Approval", true);
                if ItemJournalLine.FindSet then ItemJournalLine.ModifyAll("Approval ID", '');
            end;
    end;
    trigger OnOpenPage()
    var
        JnlSelected: Boolean;
        ItemJournalLine: Record "Item Journal Line";
    begin
    end;
    var Text000: label 'You cannot use entry type %1 in this journal.';
    ItemJnlMgt: Codeunit ItemJnlManagement;
    ReportPrint: Codeunit "Test Report-Print";
    ItemAvailFormsMgt: Codeunit "Item Availability Forms Mgt";
    CalcWhseAdjmt: Report "Calculate Whse. Adjustment";
    CurrentJnlBatchName: Code[10];
    ItemDescription: Text[50];
    ShortcutDimCode: array[8]of Code[20];
    Text001: label 'Item Journal lines have been successfully inserted from Standard Item Journal %1.';
    Text002: label 'Standard Item Journal %1 has been successfully created.';
    "Other UsageEditable": Boolean;
    "Nature of DisposalEditable": Boolean;
    UserSetup: Record "User Setup";
    ItemJournalLine: Record "Item Journal Line";
    UserCode: Code[20];
}
