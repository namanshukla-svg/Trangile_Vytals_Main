pageextension 50128 "SSD Item Charge Asst Pur" extends "Item Charge Assignment (Purch)"
{
    trigger OnOpenPage()
    begin
        Rec.FilterGroup(2);
        Rec.SetFilter(Rec."Qty. Assigned", '%1', 0);
        Rec.FilterGroup(0);
    end;
}
