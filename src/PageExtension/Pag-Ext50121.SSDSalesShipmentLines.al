pageextension 50121 "SSD Sales Shipment Lines" extends "Sales Shipment Lines"
{
    layout
    {
        addafter("Sell-to Customer No.")
        {
            field(InvNo; InvNo)
            {
                ApplicationArea = all;
            }
        }
    }
    trigger OnAfterGetRecord()
    begin
        InvNo:='';
        TempSalesInvoiceLine.DELETEALL;
        GetSalesInvLines(TempSalesInvoiceLine);
        InvNo:=TempSalesInvoiceLine."Document No.";
    end;
    var InvNo: Code[20];
    TempSalesInvoiceLine: Record "Sales Invoice Line" temporary;
    procedure GetSalesInvLines(VAR TempSalesInvLine: Record "Sales Invoice Line" temporary)
    var
        SalesInvLine: Record "Sales Invoice Line";
        ItemLedgEntry: Record "Item Ledger Entry";
        ValueEntry: Record "Value Entry";
    begin
        TempSalesInvLine.RESET;
        TempSalesInvLine.DELETEALL;
        IF rec.Type <> Type::Item THEN EXIT;
        rec.FilterPstdDocLnItemLedgEntries(ItemLedgEntry);
        ItemLedgEntry.SETFILTER("Invoiced Quantity", '<>0');
        IF ItemLedgEntry.FINDSET THEN BEGIN
            ValueEntry.SETCURRENTKEY("Item Ledger Entry No.", "Entry Type");
            ValueEntry.SETRANGE("Entry Type", ValueEntry."Entry Type"::"Direct Cost");
            ValueEntry.SETFILTER("Invoiced Quantity", '<>0');
            REPEAT ValueEntry.SETRANGE("Item Ledger Entry No.", ItemLedgEntry."Entry No.");
                IF ValueEntry.FINDSET THEN REPEAT IF ValueEntry."Document Type" = ValueEntry."Document Type"::"Sales Invoice" THEN IF SalesInvLine.GET(ValueEntry."Document No.", ValueEntry."Document Line No.")THEN BEGIN
                                TempSalesInvLine.INIT;
                                TempSalesInvLine:=SalesInvLine;
                                IF TempSalesInvLine.INSERT THEN;
                            END;
                    UNTIL ValueEntry.NEXT = 0;
            UNTIL ItemLedgEntry.NEXT = 0;
        END;
    end;
    trigger OnOpenPage()
    begin
        CurrPage.Update(true);
    end;
}
