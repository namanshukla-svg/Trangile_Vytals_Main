Report 50142 "Expiration Date changing"
{
    Permissions = TableData "Item Ledger Entry"=rimd;
    ProcessingOnly = true;
    UsageCategory = ReportsandAnalysis;
    ApplicationArea = All;

    dataset
    {
        dataitem("Item Ledger Entry"; "Item Ledger Entry")
        {
            RequestFilterFields = "Lot No.";

            column(ReportForNavId_7209;7209)
            {
            }
            column(EntryNo_ItemLedgerEntry; "Item Ledger Entry"."Entry No.")
            {
            }
            column(ItemNo_ItemLedgerEntry; "Item Ledger Entry"."Item No.")
            {
            }
            column(PostingDate_ItemLedgerEntry; "Item Ledger Entry"."Posting Date")
            {
            }
            trigger OnAfterGetRecord()
            begin
                ItemC.Reset;
                if ItemC.Get("Item Ledger Entry"."Item No.")then begin
                    if Format(ItemC."Expiration Calculation") <> '' then ExpDt:=CalcDate(ItemC."Expiration Calculation", "Item Ledger Entry"."Posting Date");
                    if ExpDt <> 0D then begin
                        "Item Ledger Entry"."Expiration Date":=ExpDt;
                        "Item Ledger Entry".Modify;
                        k+=1;
                    end;
                end;
            end;
            trigger OnPostDataItem()
            begin
                Message('%1 Record has been updated', k);
            end;
            trigger OnPreDataItem()
            begin
                if "Item Ledger Entry".GetFilter("Item Ledger Entry"."Lot No.") = '' then Error('Select LOT No to change expiry date');
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
    trigger OnInitReport()
    begin
        k:=0;
    end;
    var k: Integer;
    ExpDt: Date;
    ItemC: Record Item;
}
