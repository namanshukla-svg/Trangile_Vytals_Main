PageExtension 50003 "SSD Bank Payment Voucher" extends "Bank Payment Voucher"
{
    layout
    {
        addafter("Credit Amount")
        {
            field("SSDPO No."; Rec."PO No.")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the PO No. field.';
            }
        }
        addafter("Bal. Account No.")
        {
            field("SSDTransfer Type"; Rec."Transfer Type")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Transfer Type field.';
            }
            field("SSDVendor Bank Account"; Rec."Vendor Bank Account")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Vendor Bank Account field.';
            }
            field("SSDNEFT / RTGS Code"; Rec."NEFT / RTGS Code")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the NEFT / RTGS Code field.';
            }
            field("SSDPayment Method Code"; Rec."Payment Method Code")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies how to make payment, such as with bank transfer, cash, or check.';
            }
            field("SSDVendor Creditor No."; Rec."Vendor Creditor No.")
            {
                ApplicationArea = All;
                Editable = false;
                ToolTip = 'Specifies the value of the Vendor Creditor No. field.';
            }
            field("SSDPreffered Bank Account"; Rec."Preffered Bank Account")
            {
                ApplicationArea = All;
                Editable = false;
                ToolTip = 'Specifies the value of the Preffered Bank Account field.';
            }
        }
        addbefore("Account Type")
        {
            field("Party Type"; Rec."Party Type")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the type of party that the entry on the journal line will be posted to.';
            }
            field("Party Code"; Rec."Party Code")
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
        modify("Voucher Narration")
        {
            ShortCutKey = 'Shift+Ctrl+Z';
        }
        addafter("Ledger E&ntries")
        {
            action(SSDAttachment)
            {
                ApplicationArea = All;
                Caption = 'Attachment';
                RunObject = Page Documents;
                RunPageLink = "Table No."=const(81), "Reference No. 1"=const('1'), "Reference No. 2"=field("Document No.");
                ToolTip = 'Executes the Attachment action.';
            }
        }
        addafter("SuggestVendorPayments")
        {
            action("SSDBank Payments Details")
            {
                ApplicationArea = All;
                Image = Payment;
                Promoted = true;
                PromotedCategory = "Report";
                RunObject = Report "Suggest vendor Payment Det";
                ToolTip = 'Executes the Bank Payments Details action.';
            }
        }
        addafter("Tax Payments")
        {
            action("SSDNEFT Document")
            {
                ApplicationArea = All;
                Caption = 'NEFT Document';
                ToolTip = 'Executes the NEFT Document action.';

                trigger OnAction()
                begin
                    //ALLE 2.15
                    GenJnlLine.SetRange("Document No.", Rec."Document No.");
                    Report.RunModal(Report::"NEFT Document-Pre", true, true, GenJnlLine);
                end;
            }
            action("SSDRTGS Document")
            {
                ApplicationArea = All;
                Caption = 'RTGS Document';
                ToolTip = 'Executes the RTGS Document action.';

                trigger OnAction()
                begin
                    //ALLE 2.15
                    GenJnlLine.SetRange("Document No.", Rec."Document No.");
                    Report.RunModal(Report::"RTGS Document-Pre", true, true, GenJnlLine);
                end;
            }
        }
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
    var GenJnlLine: Record "Gen. Journal Line";
}
