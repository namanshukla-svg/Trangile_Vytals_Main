Report 50190 "Batch Tracking Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Batch Tracking Report.rdl';
    UsageCategory = ReportsandAnalysis;
    ApplicationArea = all;

    dataset
    {
        dataitem("Item Ledger Entry"; "Item Ledger Entry")
        {
            DataItemTableView = sorting("Lot No.")order(ascending)where("Entry Type"=const(Sale));
            RequestFilterFields = "Lot No.";

            column(ReportForNavId_1000000000;1000000000)
            {
            }
            column(Item_Code; "Item Ledger Entry"."Item No.")
            {
            }
            column(Description; Item1.Description)
            {
            }
            column(Description2; Item1."Description 2")
            {
            }
            column(Posting_Date; "Item Ledger Entry"."Posting Date")
            {
            }
            column(LotNo; "Item Ledger Entry"."Lot No.")
            {
            }
            column(CustomerName; Customer.Name)
            {
            }
            column(Invoice_No; "Item Ledger Entry"."Document No.")
            {
            }
            column(Invoice_Quantity; "Item Ledger Entry".Quantity)
            {
            }
            column(QualityOrderNo; PostedQualityOrderHeader."No.")
            {
            }
            column(Entry_Type; "Item Ledger Entry"."Entry Type")
            {
            }
            column(RemainingQuantity; RemQty)
            {
            }
            column(Batch_No_Caption; Batch_No_CaptionLbl)
            {
            }
            column(Item_Code_Caption; Item_Code_CaptionLbl)
            {
            }
            column(Item_Description_Caption; Item_Description_CaptionLbl)
            {
            }
            column(Quality_order_No_Caption; Quality_order_No_CaptionLbl)
            {
            }
            column(SourceNo_ItemLedgerEntry; "Item Ledger Entry"."Source No.")
            {
            }
            column(Remaining_Quantity; "Item Ledger Entry"."Remaining Quantity")
            {
            }
            column(Unit_of_Measure_Code; "Item Ledger Entry"."Unit of Measure Code")
            {
            }
            column(Item_Description2_Caption; Item_Description2_CaptionLbl)
            {
            }
            column(OutputQty; OutputQty)
            {
            }
            column(Invoiced_Quantity; ValueEntry."Invoiced Quantity")
            {
            }
            column(InvNo; InvNo)
            {
            }
            trigger OnAfterGetRecord()
            begin
                Item1.Get("Item Ledger Entry"."Item No.");
                Customer.Get("Item Ledger Entry"."Source No.");
                Clear(QualityOrderNo);
                PostedQualityOrderHeader.Reset;
                PostedQualityOrderHeader.SetRange("Lot No.", "Item Ledger Entry"."Lot No.");
                if PostedQualityOrderHeader.FindFirst then QualityOrderNo:=PostedQualityOrderHeader."No.";
                ILE2.Reset;
                ILE2.SetRange("Lot No.", "Lot No.");
                if ILE2.FindSet then repeat RemQty+=ILE2."Remaining Quantity";
                    until ILE2.Next = 0;
                ILE2.Reset;
                ILE2.SetRange("Entry Type", ILE2."entry type"::Output);
                ILE2.SetRange("Lot No.", "Item Ledger Entry"."Lot No.");
                if ILE2.FindFirst then begin
                    OutputQty:=ILE2.Quantity;
                end;
                ValueEntry.Reset;
                ValueEntry.SetRange("Item Ledger Entry No.", "Entry No.");
                ValueEntry.SetRange("Document Type", ValueEntry."document type"::"Sales Invoice");
                if ValueEntry.FindFirst then InvNo:=ValueEntry."Document No."
                else
                    InvNo:='';
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
    Batch_Tracking_Report='BATCH TRACKING REPORT';
    }
    var PostedQualityOrderHeader: Record "SSD Posted Quality Order Hdr";
    Item1: Record Item;
    Customer: Record Customer;
    QualityOrderNo: Code[20];
    Batch_No_CaptionLbl: label 'Batch No';
    Item_Code_CaptionLbl: label 'Item Code';
    Item_Description_CaptionLbl: label 'Item Description';
    Item_Description2_CaptionLbl: label 'Item Description 2';
    Quality_order_No_CaptionLbl: label 'Quality Order No.';
    Remaining_Quantity: Decimal;
    ILE2: Record "Item Ledger Entry";
    TotalProducedQty: Decimal;
    OutputQty: Decimal;
    "InvoicedQty.": Decimal;
    RemQty: Decimal;
    ValueEntry: Record "Value Entry";
    InvNo: Code[20];
}
