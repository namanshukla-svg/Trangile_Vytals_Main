PageExtension 50051 "SSD Order Planning" extends "Order Planning"
{
    layout
    {
        addafter(StatusText)
        {
            field("Remaining Qty. (Base)"; Rec."Remaining Qty. (Base)")
            {
                ApplicationArea = All;
            }
        }
        addafter(Description)
        {
            field("Description 2"; Rec."Description 2")
            {
                ApplicationArea = All;
            }
        }
    }
}
