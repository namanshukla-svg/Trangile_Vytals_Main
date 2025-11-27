PageExtension 50030 "SSD Firm Planned Prod. Orders" extends "Firm Planned Prod. Orders"
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
        }
    }
}
