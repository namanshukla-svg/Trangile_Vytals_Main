codeunit 50143 "SSD FA Subscribers"
{
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"FA Reclass. Transfer Line", 'OnBeforeFAJnlLineInsert', '', false, false)]
    local procedure SSDOnBeforeFAJnlLineInsert(var FAJournalLine: Record "FA Journal Line"; var FAReclassJournalLine: Record "FA Reclass. Journal Line"; Sign: Integer)
    begin
        FAJournalLine."Responsibility Center":=FAReclassJournalLine."Responsibility Center";
    end;
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"FA Reclass. Transfer Line", 'OnBeforeGenJnlLineInsert', '', false, false)]
    local procedure SSDOnBeforeGenJnlLineInsert(var GenJournalLine: Record "Gen. Journal Line"; var FAReclassJournalLine: Record "FA Reclass. Journal Line"; Sign: Integer)
    begin
        GenJournalLine."Responsibility Center":=FAReclassJournalLine."Responsibility Center";
    end;
}
