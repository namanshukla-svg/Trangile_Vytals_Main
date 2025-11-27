pageextension 50114 "SSD Bank Receipt Voucher" extends "Bank Receipt Voucher"
{
    layout
    {
        addbefore("Account Type")
        {
            field("SSD Party Type"; Rec."Party Type")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the type of party that the entry on the journal line will be posted to.';
            }
            field("SSD Party Code"; Rec."Party Code")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the party number that the entry on the journal line will be posted to.';
            }
        }
        modify("Debit Amount")
        {
            Visible = true;
        }
        modify("Credit Amount")
        {
            Visible = true;
        }
        movebefore(Amount; "Debit Amount")
        moveafter("Debit Amount"; "Credit Amount")
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
