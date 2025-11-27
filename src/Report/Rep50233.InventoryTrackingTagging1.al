Report 50233 "Inventory Tracking & Tagging1"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Inventory Tracking & Tagging1.rdl';
    UsageCategory = ReportsandAnalysis;
    ApplicationArea = all;

    dataset
    {
        dataitem("Item Ledger Entry"; "Item Ledger Entry")
        {
            DataItemTableView = sorting("Posting Date", "Item No.", "Variant Code")order(ascending)where("Entry Type"=filter(Output|Purchase), Open=filter(true));
            RequestFilterFields = "Posting Date", "Item No.";

            column(ReportForNavId_1000000000;1000000000)
            {
            }
            column(LotNo_ItemLedgerEntry; "Item Ledger Entry"."Lot No.")
            {
            }
            column(ItemNo_ItemLedgerEntry; "Item Ledger Entry"."Item No.")
            {
            }
            column(Description_ItemLedgerEntry; Item.Description)
            {
            }
            column(ItemCategoryCode_ItemLedgerEntry; "Item Ledger Entry"."Item Category Code")
            {
            }
            column(DocumentNo_ItemLedgerEntry; "Item Ledger Entry"."Document No.")
            {
            }
            column(PostingDate_ItemLedgerEntry; "Item Ledger Entry"."Posting Date")
            {
            }
            column(EntryType_ItemLedgerEntry; "Item Ledger Entry"."Entry Type")
            {
            }
            column(CostAmountActual_ItemLedgerEntry; "Item Ledger Entry"."Cost Amount (Actual)")
            {
            }
            column(RemainingQuantity_ItemLedgerEntry; "Item Ledger Entry"."Remaining Quantity")
            {
            }
            column(LocationCode_ItemLedgerEntry; "Item Ledger Entry"."Location Code")
            {
            }
            column(Open_ItemLedgerEntry; "Item Ledger Entry".Open)
            {
            }
            column(SalesPersonCode; Salesperson)
            {
            }
            column(CustCode; CustCode)
            {
            }
            column(CustName; CustName)
            {
            }
            column(OrderNo; OrderNo)
            {
            }
            column(ItemDesc2; Item."Description 2")
            {
            }
            trigger OnAfterGetRecord()
            begin
                Clear(CustName);
                Clear(Salesperson);
                Clear(OrderNo);
                Clear(CustCode);
                if "Entry Type" = "entry type"::Output then begin
                    CalcFields("Item Ledger Entry"."Cost Amount (Actual)");
                    ProductionOrder.Reset;
                    ProductionOrder.SetRange("No.", "Document No.");
                    if ProductionOrder.FindFirst then begin
                        SalesHeader.Reset;
                        SalesHeader.SetRange("No.", ProductionOrder."Sales Order No.");
                        if SalesHeader.FindFirst then begin
                            CustCode:=SalesHeader."Sell-to Customer No.";
                            Salesperson:=SalesHeader."Salesperson Code";
                            CustName:=SalesHeader."Sell-to Customer Name";
                            OrderNo:=SalesHeader."No.";
                        end;
                    end;
                end;
                Item.Get("Item No.");
                if "Entry Type" = "entry type"::Purchase then begin
                    PurchRcptLine.Reset;
                    PurchRcptLine.SetRange("Document No.", "Document No.");
                    if PurchRcptLine.FindFirst then begin
                        CustCode:=PurchRcptLine."Customer No.";
                        Salesperson:=PurchRcptLine."SalesPerson Code";
                        OrderNo:=PurchRcptLine."Prod. Order No.";
                        if Customer.Get(CustCode)then CustName:=Customer.Name;
                    end;
                    if PurchRcptHeader.Get(PurchRcptLine."Document No.")then OrderNo:=PurchRcptHeader."Order No.";
                end;
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
    var SalesHeader: Record "Sales Header";
    ProductionOrder: Record "Production Order";
    Item: Record Item;
    PurchRcptLine: Record "Purch. Rcpt. Line";
    CustCode: Code[20];
    CustName: Text[50];
    Salesperson: Code[20];
    Customer: Record Customer;
    OrderNo: Code[20];
    PurchRcptHeader: Record "Purch. Rcpt. Header";
}
