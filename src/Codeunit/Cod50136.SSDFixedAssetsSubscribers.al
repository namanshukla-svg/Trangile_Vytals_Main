codeunit 50136 "SSD Fixed Assets Subscribers"
{
    [EventSubscriber(ObjectType::Table, Database::"Fixed Asset", 'OnBeforeInitFANo', '', false, false)]
    local procedure SSDOnBeforeInitFANo(var FixedAsset: Record "Fixed Asset"; xFixedAsset: Record "Fixed Asset"; var IsHandled: Boolean)
    var
        UserSetup: Record "User Setup";
        ResponsibilityCenter: Record "Responsibility Center";
        //IG_DS_Before   NoSeriesManagement: Codeunit NoSeriesManagement;
        NoSeriesManagement: Codeunit "No. Series";
        FASetup: Record "FA Setup";
    begin
        IsHandled := true;
        FASetup.Get();
        if FixedAsset."No." = '' then
            if UserSetup.GET(USERID) then begin
                // UserSetup.TestField("Responsibility Center");
                // if ResponsibilityCenter.GET(UserSetup."Responsibility Center") then begin
                //     ResponsibilityCenter.TESTFIELD(ResponsibilityCenter."FA No. Series");
                //IG_DS_Before    NoSeriesManagement.InitSeries(FASetup."Fixed Asset Nos.", xFixedAsset."No. Series", 0D, FixedAsset."No.", FixedAsset."No. Series");
                if NoSeriesManagement.AreRelated(FASetup."Fixed Asset Nos.", xFixedAsset."No. Series") then
                    FixedAsset."No. Series" := xFixedAsset."No. Series"
                else
                    FixedAsset."No. Series" := FASetup."Fixed Asset Nos.";

                // Generate next FA No.
                FixedAsset."No." := NoSeriesManagement.GetNextNo(FixedAsset."No. Series");
            end;
        //FixedAsset."Responsibility Center" := ResponsibilityCenter.Code;
    end;
    //end;
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Make FA Ledger Entry", 'OnAfterCopyFromFAJnlLine', '', false, false)]
    local procedure SSDOnAfterCopyFromFAJnlLine(var FALedgerEntry: Record "FA Ledger Entry"; FAJournalLine: Record "FA Journal Line")
    begin
        FALedgerEntry."Responsibility Center" := FAJournalLine."Responsibility Center";
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Make FA Ledger Entry", 'OnAfterCopyFromGenJnlLine', '', false, false)]
    local procedure SSDOnAfterCopyFromGenJnlLine(var FALedgerEntry: Record "FA Ledger Entry"; GenJournalLine: Record "Gen. Journal Line")
    begin
        FALedgerEntry."Responsibility Center" := GenJournalLine."Responsibility Center";
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Make Ins. Coverage Ledg. Entry", 'OnAfterCopyFromJnlLine', '', false, false)]
    local procedure SSDOnAfterCopyFromJnlLine(var InsCoverageLedgerEntry: Record "Ins. Coverage Ledger Entry"; InsuranceJournalLine: Record "Insurance Journal Line")
    begin
        InsCoverageLedgerEntry."Responsibility Center" := InsuranceJournalLine."Responsibility Center";
    end;
    //OnAfterCopyFromJnlLine
}
