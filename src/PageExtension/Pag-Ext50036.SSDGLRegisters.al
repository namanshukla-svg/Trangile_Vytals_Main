PageExtension 50036 "SSD G/L Registers" extends "G/L Registers"
{
    layout
    {
        addafter("No.")
        {
            field("Document No."; Rec."Document No.")
            {
                ApplicationArea = All;
                Editable = false;
            }
        }
    }
    actions
    {
        addafter("Detail Trial Balance")
        {
            action("Posted Voucher")
            {
                ApplicationArea = All;
                Caption = 'Posted Voucher', comment = 'NLB="YourLanguageCaption"';
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Image = Report;
                RunObject = report "Voucher With Applied Entries";
            }
        }
    }
    var GLEntry: Record "G/L Entry";
}
