pageextension 50117 "SSD Cash Receipt Voucher" extends "Cash Receipt Voucher"
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
