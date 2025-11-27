Codeunit 50002 "Vendor Eval. -Post Line"
{
    // //////Crea Eval Proveedores==>Vendor Eval. -Post Line
    TableNo = "SSD Vendor Eval. Journal";

    trigger OnRun()
    begin
        VendorEvalJournal.Copy(Rec);
        VendorEvalHeader.Init;
        VendorEvalHeader."No.":='';
        VendorEvalHeader.Validate("Vendor No.", Rec."Vendor No.");
        VendorEvalHeader.Insert(true);
        VendorEvalHeader.Validate("Eval. Template No.", Rec."Eval. Template  No.");
        VendorEvalHeader.Status:=VendorEvalHeader.Status::Blanked;
        VendorEvalHeader.Modify;
        VendorEvalJournal.Delete;
    end;
    var VendorEvalJournal: Record "SSD Vendor Eval. Journal";
    VendorEvalHeader: Record "SSD Vendor Eval. Header";
}
