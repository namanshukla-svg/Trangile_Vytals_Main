PageExtension 50101 "SSD Transfer Order" extends "Transfer Order"
{
    layout
    {
        addafter("Shortcut Dimension 2 Code")
        {
            field("Applied to Insurance Policy"; Rec."Applied to Insurance Policy")
            {
                ApplicationArea = All;
            }
        }
        addafter("Assigned User ID")
        {
            field("Gate In"; Rec."Gate In")
            {
                ApplicationArea = All;
            }
        }
        addafter(Status)
        {
            field("Order Created from MRP"; Rec."Order Created from MRP")
            {
                ApplicationArea = All;
                Editable = false;
            }
            field("Prod. Order No."; Rec."Prod. Order No.")
            {
                ApplicationArea = All;
            }
        }
    }
    trigger OnDeleteRecord(): Boolean var
        UserSetup: Record "User Setup";
    begin
        UserSetup.Get(UserId);
        if not UserSetup."SSD Delete Administrator" then Error('You are not authorise to delete this record');
    end;
}
