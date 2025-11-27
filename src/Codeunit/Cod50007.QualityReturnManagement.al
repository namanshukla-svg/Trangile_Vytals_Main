Codeunit 50007 "Quality Return Management"
{
    // //GestDiarioDevoluciones==>Quality Return Management
    Permissions = TableData "Item Ledger Entry"=rm;

    trigger OnRun()
    begin
    end;
    var Txt00001: label 'Get outstanding returns?';
    ReadSetup: Boolean;
    SetupQuality: Record "SSD Quality Setup";
    UserMgt: Codeunit "SSD User Setup Management";
    procedure CreateQualityReturnsEntry()
    var
        ItemLdgrEntryLocal: Record "Item Ledger Entry";
    begin
        //////**************ProponerLineasDevolucion**************************
        if not Confirm(Txt00001)then exit;
        SetupQuality.Get(UserMgt.GetRespCenterFilter);
        SetupQuality.TestField("Return Location Code");
        ItemLdgrEntryLocal.Reset;
        ItemLdgrEntryLocal.SetCurrentkey(Open, Positive, "Location Code", "Source No.");
        ItemLdgrEntryLocal.SetRange(Open, true);
        ItemLdgrEntryLocal.SetRange(Positive, true);
        ItemLdgrEntryLocal.SetRange("Location Code", SetupQuality."Return Location Code");
        ItemLdgrEntryLocal.SetRange(Returning, false);
        if ItemLdgrEntryLocal.Find('-')then repeat InsertJournalReturnsEntry(ItemLdgrEntryLocal);
            until ItemLdgrEntryLocal.Next = 0;
    end;
    procedure ModifyItemLdgrEntryForReturn(var RecJournalReturnsLin: Record "SSD Journal Returns Line")
    var
        ItemLdgrEntryLocal: Record "Item Ledger Entry";
    begin
        ///*************BorraLinDevolucion****************************
        ItemLdgrEntryLocal.Get(RecJournalReturnsLin."Item Entry No.");
        ItemLdgrEntryLocal.Returning:=false;
        ItemLdgrEntryLocal."Quality Status":=ItemLdgrEntryLocal."quality status"::" ";
        ItemLdgrEntryLocal.Modify;
    end;
    procedure InsertJournalReturnsEntry(var RecItemLdgrEntry: Record "Item Ledger Entry")
    var
        JournalReturnsLinLocal: Record "SSD Journal Returns Line";
        ItemLdgrEntryLocal: Record "Item Ledger Entry";
        ItemLocal: Record Item;
    begin
        ///**************TraeLin***************************
        if not ReadSetup then begin
            SetupQuality.Get(UserMgt.GetRespCenterFilter);
            ReadSetup:=true;
        end;
        if not RecItemLdgrEntry.Open then exit;
        if not RecItemLdgrEntry.Positive then exit;
        if RecItemLdgrEntry.Returning then exit;
        ItemLocal.Get(RecItemLdgrEntry."Item No.");
        JournalReturnsLinLocal.Init;
        JournalReturnsLinLocal."Item Entry No.":=RecItemLdgrEntry."Entry No.";
        JournalReturnsLinLocal."Posting Date":=RecItemLdgrEntry."Posting Date";
        if RecItemLdgrEntry."Order No." = '' then JournalReturnsLinLocal."Type of Return":=JournalReturnsLinLocal."type of return"::Purchase
        else
            JournalReturnsLinLocal."Type of Return":=JournalReturnsLinLocal."type of return"::Subcontracting;
        JournalReturnsLinLocal."Document No.":=RecItemLdgrEntry."Document No.";
        JournalReturnsLinLocal."Item No.":=RecItemLdgrEntry."Item No.";
        JournalReturnsLinLocal.Description:=ItemLocal.Description;
        JournalReturnsLinLocal."Return Location Code":=RecItemLdgrEntry."Location Code";
        JournalReturnsLinLocal.Quantity:=RecItemLdgrEntry."Remaining Quantity";
        JournalReturnsLinLocal."Unit of Measure Code":=ItemLocal."Base Unit of Measure";
        JournalReturnsLinLocal."Lot No.":=RecItemLdgrEntry."Lot No.";
        ///JournalReturnsLinLocal."Line No." := RecItemLdgrEntry."Source Line No.";
         //JournalReturnsLinLocal."Primary Order No." := RecItemLdgrEntry."Order No.";
        JournalReturnsLinLocal."Vendor Receipt No.":=RecItemLdgrEntry."External Document No.";
        JournalReturnsLinLocal.Validate("Qty. to Return", RecItemLdgrEntry."Remaining Quantity");
        if RecItemLdgrEntry."Source Type" = RecItemLdgrEntry."source type"::Vendor then JournalReturnsLinLocal."Vendor No.":=RecItemLdgrEntry."Source No.";
        JournalReturnsLinLocal."Carry Out Action Message":=true;
        JournalReturnsLinLocal."Reclass. Location":=SetupQuality."Reclass. Location Code";
        JournalReturnsLinLocal.Validate("Reclassif. Code", ItemLocal."Reclassif. Code");
        if not JournalReturnsLinLocal.Insert then;
        ItemLdgrEntryLocal:=RecItemLdgrEntry;
        ItemLdgrEntryLocal.Returning:=true;
        ItemLdgrEntryLocal."Quality Order Status":=ItemLdgrEntryLocal."Quality Status";
        ItemLdgrEntryLocal."Quality Status":=ItemLdgrEntryLocal."quality status"::Scrap;
        ItemLdgrEntryLocal.Modify;
    end;
}
