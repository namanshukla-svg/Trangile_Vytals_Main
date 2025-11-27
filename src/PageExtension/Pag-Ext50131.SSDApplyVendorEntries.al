pageextension 50131 "SSD Apply Vendor Entries" extends "Apply Vendor Entries"
{
    trigger OnOpenPage()
    begin
        Rec.SetFilter("On Hold", '%1', '');
    end;
}
