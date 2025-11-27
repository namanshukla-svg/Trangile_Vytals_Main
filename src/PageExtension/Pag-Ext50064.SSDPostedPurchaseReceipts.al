PageExtension 50064 "SSD Posted Purchase Receipts" extends "Posted Purchase Receipts"
{
    Editable = false;

    layout
    {
        addafter("No.")
        {
            field("Order Date"; Rec."Order Date")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Order Date field.';
            }
            field("Plant MRN No."; Rec."Plant MRN No.")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Plant MRN No. field.';
            }
            field("Vendor Order No."; Rec."Vendor Order No.")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Vendor Order No. field.';
            }
            field("Vendor Shipment No."; Rec."Vendor Shipment No.")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Vendor Shipment No. field.';
            }
            field("Vendor Invoice No."; Rec."Vendor Invoice No.")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Vendor Invoice No. field.';
            }
            field("Order No."; Rec."Order No.")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Order No. field.';
            }
            field("Qty. Pending to Invoice"; Rec."Qty. Pending to Invoice")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Qty. Pending to Invoice field.';
            }
            field("Gate Entry No."; Rec."Gate Entry No.")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Gate Entry No. field.';
            }
            field("Gate Entry Date"; Rec."Gate Entry Date")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Gate Entry Date field.';
            }
            field("SSD SRN Approver"; Rec."SSD SRN Approver")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the SRN Approver field.', Comment = '%';
                Visible = false; //SRN-IG-20250903-0002
            }
            field("SSD SRN Approval Pending"; Rec."SSD SRN Approval Pending")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the SRN Approval Pending field.', Comment = '%';
                Visible = false; //SRN-IG-20250903-0002
            }
            field("SRN Approval Pending UserID"; Rec."SRN Approval Pending UserID")
            {
                ApplicationArea = all;
                Caption = 'SRN Approver';
            }
        }
    }
    actions
    {
        addbefore("&Print")
        {
            action(Approve)
            {
                ApplicationArea = All;
                Caption = 'Approve';
                Ellipsis = true;
                Image = Approve;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ToolTip = 'Executes the Approve action.';
                Visible = false; //SRN-IG-20250903-0002

                trigger OnAction()
                var
                    PurchRcptHeader: Record "Purch. Rcpt. Header";
                begin
                    PurchRcptHeader := Rec;
                    Codeunit.Run(Codeunit::"SSD Purchase Receipt Approve", PurchRcptHeader);
                end;
            }
        }
    }
    trigger OnOpenPage()
    var
        UserSetup: Record "User Setup";
    begin
        // UserSetup.SetRange("SSD SRN Approver", UserId); //IG_DS //SRN-IG-20250903-0002
        // if UserSetup.FindFirst() then begin
        //     Rec.SetRange("SSD SRN Approval Pending", true);
        //     Rec.SetRange("SSD SRN Approver", UserId);
        // end;
    end;

    trigger OnDeleteRecord(): Boolean
    begin
        Error('');
    end;
}
