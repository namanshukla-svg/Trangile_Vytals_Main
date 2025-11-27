PageExtension 50060 "SSD Posted Purchase Invoice" extends "Posted Purchase Invoice"
{
    layout
    {
        addafter("Responsibility Center")
        {
            field("Actual Posted Date"; Rec."Actual Posted Date")
            {
                ApplicationArea = All;
                Editable = false;
            }
            field("Doc. send by Store DateTime"; Rec."Doc. send by Store DateTime")
            {
                ApplicationArea = All;
                Editable = false;
            }
            field("Doc. recd by Fin DateTime"; Rec."Doc. recd by Fin DateTime")
            {
                ApplicationArea = All;
                Editable = false;
            }
            field("Created By User Id"; Rec."Created By User Id")
            {
                ApplicationArea = All;
            }
            field("Created  Date"; Rec."Created  Date")
            {
                ApplicationArea = All;
            }
            field("Hold Payment"; Rec."Hold Payment")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Hold Payment field.';
            }
        }
        addafter("Payment Method Code")
        {
            field(Insurance; Rec.Insurance)
            {
                ApplicationArea = All;
                Editable = false;
            }
        }
    }
    actions
    {
        addlast(processing)
        {
            action("Generate E-Invoice")
            {
                ApplicationArea = All;
                Caption = 'Generate E- Invoice';
                Image = Import;
                Promoted = true;
                PromotedIsBig = true;
            }
            action("UnHold Payment")
            {
                ApplicationArea = All;
                Image = Approvals;

                //Visible = UnHold_Pay;
                trigger OnAction()
                var
                    HoldPayment: Report "Hold Payment";
                begin
                    HoldPayment.UnHoldPayment(Rec);
                end;
            }
            action("HoldPayment")
            {
                ApplicationArea = All;
                Image = Approvals;

                //Visible = Hold_Pay;
                trigger OnAction()
                var
                    HoldPayment: Report "Hold Payment";
                begin
                    HoldPayment.HoldPayment(Rec);
                end;
            }
        }
    }
}
