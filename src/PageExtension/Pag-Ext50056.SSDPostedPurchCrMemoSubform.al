PageExtension 50056 "SSD PostedPurchCrMemoSubform" extends "Posted Purch. Cr. Memo Subform"
{
    layout
    {
        addafter("Return Reason Code")
        {
            field("Location Code"; Rec."Location Code")
            {
                ApplicationArea = All;
            }
            field("Bin Code"; Rec."Bin Code")
            {
                ApplicationArea = All;
            }
        }
        modify("Description 2")
        {
            Visible = false;
        }
    }
}
