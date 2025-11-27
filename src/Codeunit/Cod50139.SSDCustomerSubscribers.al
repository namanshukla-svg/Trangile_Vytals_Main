codeunit 50139 "SSD Customer Subscribers"
{
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Cust. Entry-Edit", 'OnBeforeCustLedgEntryModify', '', false, false)]
    local procedure SSDOnBeforeCustLedgEntryModify(var CustLedgEntry: Record "Cust. Ledger Entry"; FromCustLedgEntry: Record "Cust. Ledger Entry")
    begin
        CustLedgEntry.Validate(Remarks, FromCustLedgEntry.Remarks);
        CustLedgEntry.Validate("Check For Email", FromCustLedgEntry."Check For Email");
    end;
    [EventSubscriber(ObjectType::Page, Page::"Apply Customer Entries", 'OnBeforePostDirectApplication', '', false, false)]
    local procedure SSDOnBeforePostDirectApplication(var CustLedgerEntry: Record "Cust. Ledger Entry")
    var
        Customer: Record Customer;
    begin
        Customer.Get(CustLedgerEntry."Customer No.");
        Customer.CheckBlockedCustOnJnls(Customer, CustLedgerEntry."Document Type", true);
    end;
    [EventSubscriber(ObjectType::Page, Page::"Apply Customer Entries", 'OnPostDirectApplicationBeforeSetValues', '', false, false)]
    local procedure SSDOnPostDirectApplicationBeforeSetValues(var ApplicationDate: Date)
    var
        GenJnlCheckLine: Codeunit "Gen. Jnl.-Check Line";
    begin
        if GenJnlCheckLine.DateNotAllowed(ApplicationDate)then ERROR('Posting date' + ' ' + FORMAT(ApplicationDate) + ' ' + 'Not within allowed posting date');
    end;
//OnPostDirectApplicationBeforeSetValues(var ApplicationDate: Date)
}
