pageextension 50118 "SSD Consumption Journal" extends "Consumption Journal"
{
    layout
    {
        modify("Location Code")
        {
            Visible = true;
        }
        modify("Bin Code")
        {
            Visible = true;
        }
        moveafter("Item No."; "Location Code")
        moveafter("Location Code"; "Bin Code")
    }
}
