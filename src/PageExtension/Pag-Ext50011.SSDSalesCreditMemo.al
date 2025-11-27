pageextension 50011 "SSD Sales Credit Memo" extends "Sales Credit Memo"
{
    layout
    {
        addbefore(Status)
        {
            field("Type of Invoice"; Rec."Type of Invoice")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Type of Invoice field.';
            }
            field("Applied to Insurance Policy"; Rec."Applied to Insurance Policy")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Applied to Insurance Policy field.';
            }
        }
        modify("Currency Code")
        {
            Editable = false;
        }
        movebefore("Type of Invoice"; "Reason Code")
        modify("Reason Code")
        {
            Visible = true;
        }
        modify("VAT Reporting Date")
        {
            Visible = false;
        }
    }
    trigger OnDeleteRecord(): Boolean var
        UserSetup: Record "User Setup";
    begin
        UserSetup.Get(UserId);
        if not UserSetup."SSD Delete Administrator" then Error('You are not authorise to delete this record');
    end;
}
