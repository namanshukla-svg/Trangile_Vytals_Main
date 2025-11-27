PageExtension 50029 "SSD Firm Planned Prod. Order" extends "Firm Planned Prod. Order"
{
    layout
    {
        addafter("Last Date Modified")
        {
            field("No. of Archived Version"; Rec."No. of Archived Version")
            {
                ApplicationArea = All;
                Editable = false;
            }
        }
    }
}
