codeunit 50144 "SSD GenJnl Subscribers"
{
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Check Line", 'OnAfterCheckGenJnlLine', '', false, false)]
    local procedure SSDOnAfterCheckGenJnlLine(var GenJournalLine: Record "Gen. Journal Line")
    var
        IncomingDocument: Record "Incoming Document Attachment";
        GenJnlTemplate: Record "Gen. Journal Template";
        ManError: Label 'Attachment Mandatory for Document No. %1 Line No. %2';
        TempAttachment: Record "Temp Attachment" temporary;
        GenJournalLine2: Record "Gen. Journal Line";
    begin
        if GenJournalLine."Transfer Type" <> GenJournalLine."Transfer Type"::" " then begin
            GenJournalLine.TestField("Vendor Bank Account");
            GenJournalLine.TestField("NEFT / RTGS Code");
        end;
        TempAttachment.Reset();
        if TempAttachment.FindSet()then TempAttachment.DeleteAll();
        if not TempAttachment.Get(GenJournalLine."Journal Template Name", GenJournalLine."Journal Batch Name", GenJournalLine."Document No.")then begin
            TempAttachment.Init();
            TempAttachment."Journal Template Name":=GenJournalLine."Journal Template Name";
            TempAttachment."Journal Batch Name":=GenJournalLine."Journal Batch Name";
            TempAttachment."Document No.":=GenJournalLine."Document No.";
            TempAttachment.Insert();
        end;
        if GenJnlTemplate.Get(GenJournalLine."Journal Template Name")then begin
            if GenJnlTemplate."Attachment Mandatory" then begin
                GenJournalLine2.SetRange("Journal Template Name", TempAttachment."Journal Template Name");
                GenJournalLine2.SetRange("Journal Batch Name", TempAttachment."Journal Batch Name");
                GenJournalLine2.SetRange("Document No.", TempAttachment."Document No.");
                GenJournalLine2.SetFilter("Incoming Document Entry No.", '<>%1', 0);
                if not GenJournalLine2.FindFirst()then // IncomingDocument.SetRange("Incoming Document Entry No.", GenJournalLine."Incoming Document Entry No.");
                    // if not IncomingDocument.FindFirst() then
                    Error(ManError, GenJournalLine."Document No.", GenJournalLine."Line No.");
            end;
        end;
    end;
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Check Line", 'OnBeforeErrorIfPositiveAmt', '', false, false)]
    local procedure SSDOnBeforeErrorIfPositiveAmt(var RaiseError: Boolean)
    begin
        RaiseError:=false;
    end;
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Line", 'OnPostBankAccOnBeforeBankAccLedgEntryInsert', '', false, false)]
    local procedure SSDOnPostBankAccOnBeforeBankAccLedgEntryInsert(var BankAccountLedgerEntry: Record "Bank Account Ledger Entry"; var GenJournalLine: Record "Gen. Journal Line")
    begin
        BankAccountLedgerEntry."SSD Responsibility Center":=GenJournalLine."Responsibility Center";
        BankAccountLedgerEntry."SSD Vendor Bank Account":=GenJournalLine."Vendor Bank Account";
    end;
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Line", 'OnAfterInsertDtldCustLedgEntry', '', false, false)]
    local procedure SSDOnAfterInsertDtldCustLedgEntry(var DtldCustLedgEntry: Record "Detailed Cust. Ledg. Entry"; GenJournalLine: Record "Gen. Journal Line")
    begin
        DtldCustLedgEntry."Responsibility Center":=GenJournalLine."Responsibility Center";
    end;
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Line", 'OnAfterInsertDtldVendLedgEntry', '', false, false)]
    local procedure SSDOnAfterInsertDtldVendLedgEntry(var DtldVendLedgEntry: Record "Detailed Vendor Ledg. Entry"; GenJournalLine: Record "Gen. Journal Line")
    begin
        DtldVendLedgEntry."PO No.":=GenJournalLine."PO No.";
        DtldVendLedgEntry."Responsibility Center":=GenJournalLine."Responsibility Center";
    end;
}
