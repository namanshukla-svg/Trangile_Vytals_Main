pageextension 50017 "SSD Purchase Return Order Subf" extends "Purchase Return Order Subform"
{
    layout
    {
        //moveafter("Line Amount"; "Bin Code")
        modify("Bin Code")
        {
            Visible = true;
        }
        modify("Description 2")
        {
            Visible = true;
        }
    }
}
