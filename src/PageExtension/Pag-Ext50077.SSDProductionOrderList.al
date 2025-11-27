PageExtension 50077 "SSD ProductionOrderList" extends "Production Order List"
{
    layout
    {
        addafter(Description)
        {
            // field("Description 2"; Rec."Description 2") //IG_DS_Before
            // {
            //     ApplicationArea = All;
            // }
            field("Description2"; Rec."Description 2")
            {
                ApplicationArea = All;
                Caption = 'Description 2';
            }
            field("Creation Date"; Rec."Creation Date")
            {
                ApplicationArea = All;
            }
        }
        addafter(Quantity)
        {
            field("Finished Qty."; Rec."Finished Qty.")
            {
                ApplicationArea = All;
            }
        }
    }
    trigger OnDeleteRecord(): Boolean
    var
        UserSetup: Record "User Setup";
    begin
        UserSetup.Get(UserId);
        if not UserSetup."SSD Delete Administrator" then Error('You are not authorise to delete this record');
    end;
}
