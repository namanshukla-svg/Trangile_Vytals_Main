pageextension 50012 "SSD Purchase Credit Memo" extends "Purchase Credit Memo"
{
    layout
    {
        addbefore(Status)
        {
            // field("Type of Invoice"; Rec."Type of Invoice")
            // {
            //     ApplicationArea = All;
            //     ToolTip = 'Specifies the value of the Type of Invoice field.';
            // }
            field("Invoice Type Old"; Rec."Invoice Type Old")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Invoice Type Old field.';
            }
        }
        modify("Reason Code")
        {
            Visible = true;
        }
        modify("VAT Reporting Date")
        {
            Visible = false;
        }
    }
    actions
    {
        addlast(navigation)
        {
            action("SSD Voucher Narration")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Voucher Narration';
                Image = LineDescription;
                Promoted = true;
                PromotedCategory = Process;
                ToolTip = 'Select this option to enter narration for the voucher.';

                trigger OnAction()
                var
                    GenNarration: Record "Gen. Journal Narration";
                    VoucherNarration: Page "Voucher Narration";
                begin
                    GenNarration.Reset();
                    GenNarration.SetRange("Journal Template Name", '');
                    GenNarration.SetRange("Journal Batch Name", '');
                    GenNarration.SetRange("Document No.", Rec."No.");
                    GenNarration.SetFilter("Gen. Journal Line No.", '%1', 0);
                    VoucherNarration.SetTableView(GenNarration);
                    VoucherNarration.RunModal();
                end;
            }
        }
    }
    trigger OnDeleteRecord(): Boolean var
        UserSetup: Record "User Setup";
    begin
        UserSetup.Get(UserId);
        if not UserSetup."SSD Delete Administrator" then Error('You are not authorise to delete this record');
    end;
}
