Report 50246 "Suggest vendor Payment Det"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Suggest vendor Payment Det.rdl';
    UsageCategory = ReportsandAnalysis;
    ApplicationArea = all;

    dataset
    {
        dataitem("Gen. Journal Line"; "Gen. Journal Line")
        {
            DataItemTableView = sorting("Journal Template Name", "Journal Batch Name", "Line No.")order(ascending)where("Document Type"=filter(Payment), "Account Type"=filter(Vendor));

            column(ReportForNavId_1170000000;1170000000)
            {
            }
            column(PaymentDocNo; "Gen. Journal Line"."Document No.")
            {
            }
            column(PaymntPostingDate; "Gen. Journal Line"."Posting Date")
            {
            }
            dataitem("Vendor Ledger Entry"; "Vendor Ledger Entry")
            {
                DataItemLink = "Vendor No."=field("Account No.");
                DataItemTableView = where(Open=const(true), "Document Type"=const(Invoice));

                column(ReportForNavId_1170000006;1170000006)
                {
                }
                column(VendorCode; "Vendor Ledger Entry"."Vendor No.")
                {
                }
                column(VendorName; VendorName)
                {
                }
                column(Vendorbankaccountdetail; Vendorbankaccountdetail)
                {
                }
                column(Vendorsubtotal; Vendorsubtotal)
                {
                }
                column(Applicationdetail; "Vendor Ledger Entry"."Document No.")
                {
                }
                column(Applicationvalue; Abs("Vendor Ledger Entry"."Amount to Apply"))
                {
                }
                column(Invoicedate; "Vendor Ledger Entry"."Posting Date")
                {
                }
                column(NoOfPayments; SINo)
                {
                }
                column(DueDate; "Vendor Ledger Entry"."Due Date")
                {
                }
                trigger OnAfterGetRecord()
                begin
                    if(PrevVendorNo <> '') and (PrevVendorNo <> "Gen. Journal Line"."Account No.")then IsFirst:=false;
                    if(not IsFirst) and (PrevVendorNo <> "Gen. Journal Line"."Account No.")then SINo:=0;
                    if(("Gen. Journal Line"."Account No." <> PrevVendorNo) and (PrevVendorNo <> '')) or (not IsFirst)then SINo+=1;
                    if(IsFirst)then SINo+=1;
                    // IF (IsFirst)  THEN
                    //  SINo +=1;
                    PrevVendorNo:="Gen. Journal Line"."Account No.";
                    VendorName:='';
                    if RecVendor.Get()then VendorName:=RecVendor.Name;
                    VendorBankAccount.Reset;
                    //VendorBankAccount.SETRANGE("Vendor No.","Vendor Ledger Entry"."Vendor No.");
                    if VendorBankAccount.FindFirst then Vendorbankaccountdetail:=VendorBankAccount.Name;
                    NoOfPayments:=0;
                    GenJournalLine.Reset;
                    //GenJournalLine.SETRANGE("Account No.","Vendor Ledger Entry"."Vendor No.");
                    if GenJournalLine.FindSet then NoOfPayments:=GenJournalLine.Count;
                // VendorLedgerEntry.RESET;
                // VendorLedgerEntry.SETRANGE("Posting Date","Vendor Ledger Entry"."Posting Date");
                // VendorLedgerEntry.SETRANGE("Document Type","Vendor Ledger Entry"."Document Type");
                // VendorLedgerEntry.SETRANGE("Vendor No.","Vendor Ledger Entry"."Vendor No.");
                // VendorLedgerEntry.SETRANGE("Document No.","Vendor Ledger Entry"."Document No.");
                // IF VendorLedgerEntry.FINDFIRST THEN
                //  Invoicenumber := VendorLedgerEntry."Document No.";
                //  Invoiceamount:= VendorLedgerEntry.Amount;
                //  Invoicedate := VendorLedgerEntry."Posting Date";
                end;
            }
            trigger OnPreDataItem()
            begin
                IsFirst:=true;
                SINo:=0;
            end;
        }
    }
    requestpage
    {
        layout
        {
        }
        actions
        {
        }
    }
    labels
    {
    }
    var GenJournalLine: Record "Gen. Journal Line";
    Vendorbankaccountdetail: Text[50];
    Vendorsubtotal: Decimal;
    NoOfPayments: Integer;
    VendorLedgerEntry: Record "Vendor Ledger Entry";
    Invoicenumber: Code[20];
    Invoiceamount: Decimal;
    Invoicedate: Date;
    VendorBankAccount: Record "Vendor Bank Account";
    RecVendor: Record Vendor;
    VendorName: Text;
    SINo: Integer;
    PrevVendorNo: Code[20];
    IsFirst: Boolean;
}
