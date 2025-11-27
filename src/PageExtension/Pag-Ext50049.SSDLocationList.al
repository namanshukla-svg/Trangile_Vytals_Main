PageExtension 50049 "SSD Location List" extends "Location List"
{
    layout
    {
        addafter(Name)
        {
            field("Temp JW Location"; Rec."Temp JW Location")
            {
                ApplicationArea = All;
            }
        }
    }
    //IG_DS
    trigger OnOpenPage()
    var
        myInt: Integer;
    begin
        Rec.SetRange(Blocked, false);
    end;
    //IG_DS
}
