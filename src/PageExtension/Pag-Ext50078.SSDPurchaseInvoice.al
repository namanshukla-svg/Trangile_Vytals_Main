PageExtension 50078 "SSD Purchase Invoice" extends "Purchase Invoice"
{
    layout
    {
        addbefore("Buy-from Vendor No.")
        {
            field("SSD Order Type"; Rec."SSD Order Type")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Order Type field.';
                Caption = 'Order Type';
            }
        }
        addafter("No.")
        {
            field(Comment; Rec.Comment)
            {
                ApplicationArea = All;
                Editable = false;
            }
        }
        addafter(Status)
        {
            field("Approval Required"; Rec."Approval Required")
            {
                ApplicationArea = all;
                Editable = ISEditable;
            }
            field(Insurance; Rec.Insurance)
            {
                ApplicationArea = All;
            }
            field("Deduction Reason"; Rec."Deduction Reason")
            {
                ApplicationArea = All;
            }
            field("Original Invoice Amount"; Rec."Original Invoice Amount")
            {
                ApplicationArea = All;
            }
            field("Local GSTIN No."; Rec."Local GSTIN No.")
            {
                ApplicationArea = All;
            }
            field("Finance Received"; Rec."Finance Received")
            {
                ApplicationArea = All;
            }
            field("Actual Posted Date"; Rec."Actual Posted Date")
            {
                ApplicationArea = All;
                Editable = false;
            }
            field("Doc. send by Store"; Rec."Doc. send by Store")
            {
                ApplicationArea = All;
            }
            field("Doc. send by Store DateTime"; Rec."Doc. send by Store DateTime")
            {
                ApplicationArea = All;
                Editable = false;
            }
            field("Doc. recvd  by Fin"; Rec."Doc. recvd  by Fin")
            {
                ApplicationArea = All;

                trigger OnValidate()
                begin
                    SetEditable();
                end;
            }
            field("Doc. recd by Fin DateTime"; Rec."Doc. recd by Fin DateTime")
            {
                ApplicationArea = All;
                Editable = FinDate;
            }
            field("Invoice Type Old"; Rec."Invoice Type Old")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Invoice Type Old field.';
            }
            //SSDU
            // field("Type of Invoice"; Rec."Type of Invoice")
            // {
            //     ApplicationArea = All;
            //     ToolTip = 'Specifies the value of the Type of Invoice field.';
            // }
            //SSDU
        }
        addafter("Shortcut Dimension 2 Code")
        {
            field("Pending Approvals"; Rec."Pending Approvals")
            {
                ApplicationArea = All;
            }
        }
        modify("VAT Reporting Date")
        {
            Visible = false;
        }
        moveafter("Remit-to Code"; "Shipment Method Code")
    }
    actions
    {
        modify(Post)
        {
            trigger OnBeforeAction()
            var
                PurchInv: Record "Purchase Header";
                StartDate: Date;
                EndDate: Date;
            begin
                StartDate := 20250401D;
                EndDate := 20260331D;
                PurchInv.Reset();
                PurchInv.SetRange("Document Type", Rec."Document Type");
                PurchInv.SetRange("No.", Rec."No.");
                PurchInv.SetRange("Posting Date", StartDate, EndDate);
                if PurchInv.FindFirst() then
                    if (Rec."Approval Required") and (Rec."Invoice Type Old" = Rec."Invoice Type Old"::"Expense Voucher") then
                        Error('Expense voucher budget is exceeded. Authorization required to Post the document.');
            end;
        }

        modify(Preview)
        {
            trigger OnBeforeAction()
            var
                PurchInv: Record "Purchase Header";
                StartDate: Date;
                EndDate: Date;
            begin
                StartDate := 20250401D;
                EndDate := 20260331D;
                PurchInv.Reset();
                PurchInv.SetRange("Document Type", Rec."Document Type");
                PurchInv.SetRange("No.", Rec."No.");
                PurchInv.SetRange("Posting Date", StartDate, EndDate);
                if PurchInv.FindFirst() then
                    if (Rec."Approval Required") and (Rec."Invoice Type Old" = Rec."Invoice Type Old"::"Expense Voucher") then
                        Error('Expense voucher budget is exceeded. Authorization required to Post the document.');
            end;
        }
        modify(PostAndPrint)
        {
            trigger OnBeforeAction()
            var
                myInt: Integer;
            begin
                if (Rec."Approval Required") and (Rec."Invoice Type Old" = Rec."Invoice Type Old"::"Expense Voucher") then
                    Error('Expense voucher budget is exceeded. Authorization required to Post the document.');
            end;
        }
        modify(TestReport)
        {
            Promoted = true;
            PromotedCategory = Process;
            PromotedIsBig = true;
        }
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
            action(ApplyEntries)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Apply Entries';
                Ellipsis = true;
                Image = ApplyEntries;
                ShortCutKey = 'Shift+F11';
                ToolTip = 'Apply open entries for the relevant account type.';

                trigger OnAction()
                begin
                    CODEUNIT.Run(CODEUNIT::"Purchase Header Apply", Rec);
                end;
            }
        }
    }
    var
        PurchHeader: Record "Purchase Header";
        POCode: Code[20];
        DocNo: RecordID;
        DocNo1: RecordRef;
        FinDate: Boolean;
        ISEditable: Boolean;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec."Invoice Type Old" := Rec."Invoice Type Old"::"Purchase Voucher";
        SetEditable();
        ApprovalEditable();
    end;

    trigger OnDeleteRecord(): Boolean
    var
        UserSetup: Record "User Setup";
    begin
        UserSetup.Get(UserId);
        if not UserSetup."SSD Delete Administrator" then Error('You are not authorise to delete this record');
    end;

    trigger OnOpenPage()
    begin
        SetEditable();
        ApprovalEditable();
    end;

    trigger OnAfterGetCurrRecord()
    begin
        SetEditable();
        ApprovalEditable();
    end;

    procedure SetEditable()
    begin
        if (rec."No. Series" = 'F-DPI') and (Rec."Doc. recvd  by Fin" = true) then
            FinDate := true
        else
            FinDate := false;
    end;

    procedure ApprovalEditable()
    var
        UserSetup: Record "User Setup";
    begin
        if UserSetup.Get(UserId) then
            if UserSetup."Approval Required" then
                ISEditable := true
            else
                ISEditable := false;
    end;
}
