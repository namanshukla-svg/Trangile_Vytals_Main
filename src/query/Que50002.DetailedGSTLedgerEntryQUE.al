query 50002 DetailedGSTLedgerEntryQUE
{
    QueryType = Normal;

    elements
    {
    dataitem(Detailed_GST_Ledger_Entry;
    "Detailed GST Ledger Entry")
    {
    DataItemTableFilter = "GST Component Code"=filter(='CGST'|'IGST'|'SGST');

    filter(Document_Type;
    "Document Type")
    {
    ColumnFilter = Document_Type=filter(='Invoice');
    }
    filter(Entry_Type;
    "Entry Type")
    {
    ColumnFilter = Entry_Type=filter(="Initial Entry");
    }
    filter(Location__Reg__No_;
    "Location  Reg. No.")
    {
    }
    filter(Transaction_Type;
    "Transaction Type")
    {
    ColumnFilter = Transaction_Type=const(Sales);
    }
    filter(Posting_Date;
    "Posting Date")
    {
    }
    column(GST__;
    "GST %")
    {
    Method = Sum;
    }
    // GURMEET
    column(Document_No_;
    "Document No.")
    {
    }
    column(Document_Line_No_;
    "Document Line No.")
    {
    }
    column(GST_Amount;
    "GST Amount")
    {
    Method = Sum;
    }
    // GURMEET
    }
    }
}
