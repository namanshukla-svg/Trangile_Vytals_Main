PageExtension 50063 "SSD Posted Purchase Receipt" extends "Posted Purchase Receipt"
{
    layout
    {
        addlast(General)
        {
            field("Hold Payment"; Rec."Hold Payment")
            {
                ApplicationArea = All;
            }
            field("Invoice Received by Finance"; Rec."Invoice Received by Finance")
            {
                ApplicationArea = All;
            }
            field("Actual Posted Date"; Rec."Actual Posted Date")
            {
                ApplicationArea = All;
                Editable = false;
            }
            field("Receipt send by Store"; Rec."Receipt send by Store")
            {
                ApplicationArea = All;
            }
            field("Receipt send by Store DateTime"; Rec."Receipt send by Store DateTime")
            {
                ApplicationArea = All;
                Editable = false;
            }
            field("Receipt recvd  by Fin"; Rec."Receipt recvd  by Fin")
            {
                ApplicationArea = All;
            }
            field("Receipt recd by Fin DateTime"; Rec."Receipt recd by Fin DateTime")
            {
                ApplicationArea = All;
                Editable = false;
            }
        }
        addafter("Shortcut Dimension 2 Code")
        {
            field(Insurance; Rec.Insurance)
            {
                ApplicationArea = All;
                Editable = false;
            }
            field("Qty. Pending to Invoice"; Rec."Qty. Pending to Invoice")
            {
                ApplicationArea = All;
                BlankZero = true;
            }
        }
        addafter(Control1905767507)
        {
            part("Attached Documents"; "Document Attachment Factbox")
            {
                ApplicationArea = All;
                Caption = 'Attachments';
                SubPageLink = "Table ID"=const(Database::"Purch. Rcpt. Header"), "No."=field("No.");
            }
        }
    }
    actions
    {
        addafter("&Print")
        {
            action(PrintService)
            {
                Caption = 'Print Service Receipt';
                ApplicationArea = All;
                Ellipsis = true;
                Promoted = true;
                PromotedCategory = Report;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    PurchRcptHeader: Record "Purch. Rcpt. Header";
                begin
                    PurchRcptHeader:=Rec;
                    CurrPage.SetSelectionFilter(PurchRcptHeader);
                    Report.Run(report::"Service Receipt Report", true, false, PurchRcptHeader);
                end;
            }
            action("SSD Posted PO CheckList")
            {
                Caption = 'Posted PO CheckList';
                ApplicationArea = All;
                Ellipsis = true;
                Promoted = true;
                PromotedCategory = Report;
                PromotedIsBig = true;
                RunObject = page "SSD Posted PO CheckList";
                RunPageLink = "Document No."=field("No.");
            }
        }
        addafter(Dimensions)
        {
            // action("HoldPayment")
            // {
            //     ApplicationArea = All;
            //     Image = Approvals;
            //     Visible = Hold_Pay;
            //     trigger OnAction()
            //     var
            //         HoldPayment: Report "Hold Payment";
            //     begin
            //         HoldPayment.HoldPayment(Rec);
            //     end;
            // }
            // action("UnHold Payment")
            // {
            //     ApplicationArea = All;
            //     Image = Approvals;
            //     Visible = UnHold_Pay;
            //     trigger OnAction()
            //     var
            //         HoldPayment: Report "Hold Payment";
            //     begin
            //         HoldPayment.UnHoldPayment(Rec);
            //     end;
            // }
            action("Update Stock Register")
            {
                ApplicationArea = All;
                Caption = 'Update Stock Register';
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Image = UpdateDescription;

                trigger OnAction()
                var
                    PurchaseSubscribers: Codeunit "SSD Purchase Subscribers";
                begin
                    PurchaseSubscribers.InsertReceiptChallan(Rec);
                end;
            }
        }
    }
    var UserMgt: Codeunit "SSD User Setup Management";
    PurchRcptLine: Record "Purch. Rcpt. Line";
    UserSetup: Record "User Setup";
    Hold_Pay: Boolean;
    UnHold_Pay: Boolean;
    trigger OnDeleteRecord(): Boolean begin
        ERROR('You are not authorise to delete this record');
    end;
    trigger OnOpenPage()
    begin
        UserSetup.GET(USERID);
        Hold_Pay:=UserSetup."Hold Vend. Payment Permission";
        UnHold_Pay:=UserSetup."UnHold Vend Payment Permission";
    end;
}
