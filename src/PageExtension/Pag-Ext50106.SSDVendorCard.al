PageExtension 50106 "SSD Vendor Card" extends "Vendor Card"
{
    layout
    {
        modify(Contact)
        {
            Caption = 'Contact Person';
        }
        modify("Creditor No.")
        {
            Caption = '<Creditor A/C No.>';
        }
        modify("VAT Bus. Posting Group")
        {
            Visible = false;
        }
        addafter("Address 2")
        {
            field("Special Remarks"; Rec."Special Remarks")
            {
                ApplicationArea = All;
            }
        }
        addafter(Transporter)
        {
            field("Vendor Due Basis"; Rec."Vendor Due Basis")
            {
                ApplicationArea = All;
            }
            field("Exclude from Suggest Report"; Rec."Exclude from Suggest Report")
            {
                ApplicationArea = All;
            }
            field("SSD Skip Mail"; Rec."SSD Skip Mail")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Skip PO Mail field.';
            }
            field("SSD Exclude Mail"; Rec."SSD Exclude Mail")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Exclude from Mail Alert field.';
            }
            field("MSME Registerd"; Rec."MSME Registerd")
            {
                ApplicationArea = All;

                trigger OnValidate()
                var
                begin
                    IF not Confirm('Do You want to change value?', false)then exit;
                    if Rec."MSME Registerd" = false then begin
                        Rec.Validate("MSME Category", Rec."MSME Category"::" ");
                        Rec.Validate("MSME Activity", Rec."MSME Activity"::" ");
                        Rec.Modify();
                    end;
                end;
            }
            field("MSME Category"; Rec."MSME Category")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the MSME Category field.', Comment = '%';
            }
            field("MSME Activity"; Rec."MSME Activity")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the MSME Activity field.', Comment = '%';
            }
            field("Udhyam Registration Number"; Rec."Udhyam Registration Number")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Udhyam Registration Number field.', Comment = '%';
            }
            field("MSME Classification Year"; Rec."MSME Classification Year")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the MSME Classification Year field.', Comment = '%';
            }
            field("SSD Exclude SPO Confirmation"; Rec."SSD Exclude SPO Confirmation")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Exclude SPO Confirmation field.';
            }
        }
        addafter("IC Partner Code")
        {
            field("Email For PO Sending"; Rec."Email For PO Sending")
            {
                ApplicationArea = All;
            }
        }
        addafter("Prepayment %")
        {
            field("Form Code"; Rec."Form Code")
            {
                ApplicationArea = All;
            }
            field("C Form"; Rec."C Form")
            {
                ApplicationArea = All;
            }
        }
        addafter("Partner Type")
        {
            field("Fin. Charge Terms Code"; Rec."Fin. Charge Terms Code")
            {
                ApplicationArea = All;
            }
        }
        addafter("Tax Information")
        {
            field("PWM Registered"; Rec."PWM Registered")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the PWR Registered field.';
                Caption = 'PWM Registered';
            }
            field("REACH/ROHS Declaration"; Rec."REACH/ROHS Declaration")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the REACH/ROHS Declaration field.';
            }
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
                PromotedCategory = Category5;
                PromotedOnly = true;

                trigger OnAction()
                begin
                    IF Confirm('Do you want to reopen the Vendor')then begin
                        Rec.Validate(Blocked, Rec.Blocked::All);
                        Rec.Modify();
                    end end;
            }
        }
    }
    var RecVendBank: Record "Vendor Bank Account";
    IsAlreadyTrue: Boolean;
    trigger OnDeleteRecord(): Boolean begin
        ERROR('You are not authorise to delete this record');
    end;
    trigger OnOpenPage()
    begin
        IsAlreadyTrue:=Rec."MSME Registerd";
    end;
    trigger OnQueryClosePage(CloseAction: Action): Boolean begin
        Rec.TESTFIELD("Gen. Bus. Posting Group");
        //SSDVG
        if IsAlreadyTrue then //begin
 // if IsAlreadyTrue <> Rec."MSME Registerd" then
            //     Error('You Can not modify the field %1', Rec.FieldCaption("MSME Registerd"))
            // else
            exit;
        //end;
        if Rec."MSME Registerd" then begin
            Rec.TestField("MSME Activity");
            Rec.TestField("MSME Category");
            rec.TestField("MSME Classification Year");
            Rec.TestField("Udhyam Registration Number");
        end;
        //SSDVG
        if Rec."Udhyam Registration Number" <> '' then Rec.TestField("MSME Classification Year");
    end;
}
