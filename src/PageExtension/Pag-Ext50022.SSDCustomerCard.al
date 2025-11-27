PageExtension 50022 "SSD Customer Card" extends "Customer Card"
{
    layout
    {
        addafter("No.")
        {
            field("CRM Temp Id"; Rec."CRM Temp Id")
            {
                ApplicationArea = All;
                Editable = EditableVar;
            //
            }
        }
        addafter("Address 2")
        {
            field("Address 3"; Rec."Address 3")
            {
                ApplicationArea = All;
                Caption = 'Special Remarks';
            }
        }
        addafter("Primary Contact No.")
        {
            field("LUT Code"; Rec."LUT Code")
            {
                ApplicationArea = All;
            }
            field("LUT Date"; Rec."LUT Date")
            {
                ApplicationArea = All;
            }
            field("Our Account No."; Rec."Our Account No.")
            {
                ApplicationArea = All;
                Caption = 'Customer Assigned AC No.';
            }
        }
        addafter("Last Date Modified")
        {
            field("Freight Zone"; Rec."Freight Zone")
            {
                ApplicationArea = All;
            }
            field("SSD Sample Customer"; Rec."SSD Sample Customer")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Sample Customer field.';
            }
            field("Form Code"; Rec."Form Code")
            {
                ApplicationArea = All;
            }
            field("Print Ship to Addr. on Inv."; Rec."Print Ship to Addr. on Inv.")
            {
                ApplicationArea = All;
            }
            field("Payment Cycle 1"; Rec."Payment Cycle 1")
            {
                ApplicationArea = All;
            }
            field("Payment Cycle 2"; Rec."Payment Cycle 2")
            {
                ApplicationArea = All;
            }
            field("Payment Cycle 3"; Rec."Payment Cycle 3")
            {
                ApplicationArea = All;
            }
            field("Payment Cycle 4"; Rec."Payment Cycle 4")
            {
                ApplicationArea = All;
            }
            field("DDC as Per Invoice Date"; Rec."DDC as Per Invoice Date")
            {
                ApplicationArea = All;
            }
            group(CRM)
            {
                Caption = 'CRM';
                Editable = false;
                Enabled = false;
                Visible = false;

                field(crminsertflag; Rec.crminsertflag)
                {
                    ApplicationArea = All;
                }
                field(crmupdateflag; Rec.crmupdateflag)
                {
                    ApplicationArea = All;
                }
                field(isCRMexception; Rec.isCRMexception)
                {
                    ApplicationArea = All;
                }
                field(exceptiondetail; Rec.exceptiondetail)
                {
                    ApplicationArea = All;
                }
            }
        }
        addafter("Fax No.")
        {
            field("CTC for ST Form"; Rec."CTC for ST Form")
            {
                ApplicationArea = All;
            }
            field("Email for ST Form"; Rec."Email for ST Form")
            {
                ApplicationArea = All;
            }
            field("CTC for Payment"; Rec."CTC for Payment")
            {
                ApplicationArea = All;
            }
            field("Email for Payment"; Rec."Email for Payment")
            {
                ApplicationArea = All;
            }
            field("Delivery Resp. Name"; Rec."Delivery Resp. Name")
            {
                ApplicationArea = All;
            }
            field("Delivery Resp. Contact No."; Rec."Delivery Resp. Contact No.")
            {
                ApplicationArea = All;
            }
        }
        addafter("Document Sending Profile")
        {
            field("CTC for Technical/QC"; Rec."CTC for Technical/QC")
            {
                ApplicationArea = All;
            }
            field("E-mail ID for Technical/QC"; Rec."E-mail ID for Technical/QC")
            {
                ApplicationArea = All;
            }
        }
        addafter("Copy Sell-to Addr. to Qte From")
        {
            field("NSM Code"; Rec."NSM Code")
            {
                ApplicationArea = All;
            }
            field("NSM Name"; Rec."NSM Name")
            {
                ApplicationArea = All;
            }
        }
        addafter("Shipping Agent Code")
        {
            field("Shipping Agent Code 1"; Rec."Shipping Agent Code 1")
            {
                ApplicationArea = All;
            }
        }
        addafter("ARN No.")
        {
            field("SSD PWM EPR No. "; Rec."SSD PWM EPR No. ")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the PWM EPR No.  field.';
            }
        }
        modify("VAT Bus. Posting Group")
        {
            Visible = false;
        }
    }
    actions
    {
        addafter(CancelApprovalRequest)
        {
            action("ReOpen")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Reopen';
                Image = ReOpen;
                Promoted = true;
                PromotedCategory = Category6;
                PromotedOnly = true;

                trigger OnAction()
                begin
                    IF Confirm('Do you want to reopen the Customer')then begin
                        Rec.Validate(Blocked, Rec.Blocked::All);
                        Rec.Modify();
                    end end;
            }
        }
    }
    var UserMgt: Codeunit "SSD User Setup Management";
    var EditableVar: Boolean;
    trigger OnDeleteRecord(): Boolean var
        UserSetup: Record "User Setup";
    begin
        UserSetup.Get(UserId);
        if not UserSetup."SSD Delete Administrator" then error('You are not authorise to delete this record');
    end;
    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        EditableVar:=true;
    end;
    trigger OnOpenPage()
    begin
        EditableVar:=FALSE;
    end;
}
