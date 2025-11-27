Report 50267 "Stock Register 57F4"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Stock Register 57F4.rdl';
    PreviewMode = PrintLayout;
    ApplicationArea = ALL;
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem("SSD Stock Register 57F4"; "SSD Stock Register 57F4")
        {
            DataItemTableView = sorting("Entry No.");
            RequestFilterFields = "Challan No.";

            column(ReportForNavId_1000000000;1000000000)
            {
            }
            column(ChallanNo_StockRegister57F4; "Challan No.")
            {
            }
            column(ChallanDate_StockRegister57F4; "Challan Date")
            {
            }
            column(ItemNo_StockRegister57F4; "Item No.")
            {
            }
            column(ItemDescription1_StockRegister57F4; "Item Description 1")
            {
            }
            column(ItemDescription2_StockRegister57F4; "Item Description 2")
            {
            }
            column(UnitofMeasureCode_StockRegister57F4; "Unit of Measure Code")
            {
            }
            column(GSTGroupCode_StockRegister57F4; "GST Group Code")
            {
            }
            column(HSNCode_StockRegister57F4; "HSN Code")
            {
            }
            column(VendorNo_StockRegister57F4; "Vendor No.")
            {
            }
            column(VendorName_StockRegister57F4; "Vendor Name")
            {
            }
            column(VendorDocumentNo_StockRegister57F4; "Vendor Document No.")
            {
            }
            column(QuantityShipped_StockRegister57F4; "Quantity Shipped")
            {
            }
            column(QuantityReceived_StockRegister57F4; "Quantity Received")
            {
            }
            column(WastageQuantity_StockRegister57F4; "Wastage Quantity")
            {
            }
            column(BalanceQuantity_StockRegister57F4; "Balance Quantity")
            {
            }
            column(LineClosedDate_StockRegister57F4; "Line Closed Date")
            {
            }
            column(ChallanAge_StockRegister57F4; "Challan Age")
            {
            }
            column(Remarks_StockRegister57F4; "Received by")
            {
            }
            column(NatureofJobworker_StockRegister57F4; "Nature of Jobworker")
            {
            }
            column(V57F4ReceivedCopy_StockRegister57F4; "57 F4 Received Copy")
            {
            }
            column(V57F4ReceivedDate_StockRegister57F4; "57 F4 Received Date")
            {
            }
            column(UnitCost_StockRegister57F4; "Unit Cost")
            {
            }
            column(VendorDocumentDate_StockRegister57F4; "Vendor Document Date")
            {
            }
            column(ShippedValue_StockRegister57F4; "Shipped Value")
            {
            }
            column(ReceivedValue_StockRegister57F4; "Received Value")
            {
            }
            column(ChallanType_StockRegister57F4; "Challan Type")
            {
            }
            column(VendorGSTRegistrationNo_StockRegister57F4; "Vendor GST Registration No.")
            {
            }
            column(ChallanClosedDate_StockRegister57F4; "Challan Closed Date")
            {
            }
            // column(GSTPer; GSTSetup."GST Component %")
            // {
            // }
            column(Per_CGST; Per_CGST)
            {
            }
            column(Per_SGST; Per_SGST)
            {
            }
            column(Per_IGST; Per_IGST)
            {
            }
            column(CGST_Amt; CGST_Amt)
            {
            }
            column(IGST_Amt; IGST_Amt)
            {
            }
            column(SGST_Amt; SGST_Amt)
            {
            }
            trigger OnAfterGetRecord()
            begin
                // Clear(GSTSetup);
                // GSTSetup.Reset;
                // GSTSetup.SetRange("GST Group Code", "Stock Register 57F4"."GST Group Code");
                // GSTSetup.SetFilter("GST Component Code", 'IGST');
                // if GSTSetup.FindFirst then;Per_CGST := 0;
                CGST_Amt:=0;
                Per_SGST:=0;
                SGST_Amt:=0;
                Per_IGST:=0;
                IGST_Amt:=0;
                DetailedGSTLedgerEntry1.Reset();
                DetailedGSTLedgerEntry1.SetRange("Transaction Type", DetailedGSTLedgerEntry1."Transaction Type"::Transfer);
                // DetailedGSTLedgerEntry1.SetRange("Document Line No.", "Line No.");
                // DetailedGSTLedgerEntry1.SetFilter(DetailedGSTLedgerEntry1."Payment Type", '<>%1', DetailedGSTLedgerEntry1."Payment Type"::Advance);
                if DetailedGSTLedgerEntry1.FindSet()then repeat if DetailedGSTLedgerEntry1."GST Component Code" = 'IGST' then begin
                            Per_IGST:=DetailedGSTLedgerEntry1."GST %";
                            IGST_Amt+=Abs(DetailedGSTLedgerEntry1."GST Amount");
                        end;
                        if DetailedGSTLedgerEntry1."GST Component Code" = 'CGST' then begin
                            Per_CGST:=DetailedGSTLedgerEntry1."GST %";
                            CGST_Amt+=abs(DetailedGSTLedgerEntry1."GST Amount");
                        end;
                        if DetailedGSTLedgerEntry1."GST Component Code" = 'SGST' then begin
                            Per_SGST:=DetailedGSTLedgerEntry1."GST %";
                            SGST_Amt+=abs(DetailedGSTLedgerEntry1."GST Amount");
                        end;
                    until DetailedGSTLedgerEntry1.Next() = 0;
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
    var SGST_Amt: Decimal;
    IGST_Amt: Decimal;
    CGST_Amt: Decimal;
    Per_IGST: Decimal;
    Per_CGST: Decimal;
    Per_SGST: Decimal;
    GSTSetup: Record "GST Setup";
    DetailedGSTLedgerEntry1: Record "Detailed GST Ledger Entry";
}
