PageExtension 50033 "SSD General Ledger Entries" extends "General Ledger Entries"
{
    layout
    {
        addafter("G/L Account No.")
        {
            field(Ignored; Rec.Ignored)
            {
                ApplicationArea = all;
            }
        }

    }
    actions
    {
        addafter("Ent&ry")
        {
            //SSDU Start
            action("Print Voucher Applied Entries")
            {
                ApplicationArea = All;
                Caption = 'Print Voucher Applied Entries';

                trigger OnAction()
                var
                    GLEntry: Record "G/L Entry";
                begin
                    // //ALLE 2.14
                    GLEntry.SetCurrentkey("Document No.", "Posting Date");
                    GLEntry.SetRange("Document No.", Rec."Document No.");
                    GLEntry.SetRange("Posting Date", Rec."Posting Date");
                    if GLEntry.FindFirst then Report.RunModal(Report::"Voucher With Applied Entries", true, true, GLEntry);
                end;
            }
            //SSDU End
            action("NEFT Document")
            {
                ApplicationArea = All;
                Caption = 'NEFT Document';

                trigger OnAction()
                begin
                    //ALLE 2.15
                    GLEntry.SetCurrentkey("Document No.", "Posting Date");
                    GLEntry.SetRange("Document No.", Rec."Document No.");
                    GLEntry.SetRange("Posting Date", Rec."Posting Date");
                    if GLEntry.FindFirst then Report.RunModal(Report::"NEFT Document", true, true, GLEntry);
                end;
            }
            action("RTGS Document")
            {
                ApplicationArea = All;
                Caption = 'RTGS Document';

                trigger OnAction()
                begin
                    //ALLE 2.15
                    GLEntry.SetCurrentkey("Document No.", "Posting Date");
                    GLEntry.SetRange("Document No.", Rec."Document No.");
                    GLEntry.SetRange("Posting Date", Rec."Posting Date");
                    if GLEntry.FindFirst then Report.RunModal(Report::"RTGS Document", true, true, GLEntry);
                end;
            }
        }
    }
    var
        GLEntry: Record "G/L Entry";
}
