pageextension 50112 "SSD Journal Voucher" extends "Journal Voucher"
{
    layout
    {
        modify("Debit Amount")
        {
            Visible = true;
        }
        modify("Credit Amount")
        {
            Visible = true;
        }
        modify("External Document No.")
        {
            Visible = true;
        }
        modify("Party Type")
        {
            Visible = true;
        }
        modify("Party Code")
        {
            Visible = true;
        }
        movebefore(Amount; "Debit Amount")
        moveafter("Debit Amount"; "Credit Amount")
        moveafter("Document Date"; "External Document No.")
        addafter("Posting Date")
        {
            field("Due Date"; Rec."Due Date")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the due date on the entry.';
            }
        }
    }
    actions
    {
        modify("Test Report")
        {
            Promoted = true;
            PromotedCategory = Process;
            PromotedIsBig = true;
        }
        modify(IncomingDocAttachFile)
        {
            Promoted = true;
            PromotedCategory = Process;
            PromotedIsBig = true;
        }
        modify(IncomingDocCard)
        {
            Promoted = true;
            PromotedCategory = Process;
            PromotedIsBig = true;
        }
    }
}
