PageExtension 50050 "SSD No. Series" extends "No. Series"
{
    layout
    {
        addafter("Date Order")
        {
            field(NRGP; Rec.NRGP)
            {
                ApplicationArea = All;
            }
        }
    }
}
