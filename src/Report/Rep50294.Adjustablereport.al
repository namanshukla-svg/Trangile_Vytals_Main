Report 50294 "Adjustable report"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Adjustable report.rdl';
    UsageCategory = ReportsandAnalysis;
    ApplicationArea = all;

    dataset
    {
        dataitem("Cust. Ledger Entry"; "Cust. Ledger Entry")
        {
            CalcFields = "Remaining Amount";
            DataItemTableView = where(Open=filter(true));
            RequestFilterFields = "Customer No.", "Posting Date", "Remaining Amount";

            column(ReportForNavId_1170000000;1170000000)
            {
            }
            column(OriginalAmount_CustLedgerEntry; "Cust. Ledger Entry"."Original Amount")
            {
            }
            column(RemainingAmount_CustLedgerEntry; "Cust. Ledger Entry"."Remaining Amount")
            {
            }
            column(Description_CustLedgerEntry; "Cust. Ledger Entry".Description)
            {
            }
            column(DocumentNo_CustLedgerEntry; "Cust. Ledger Entry"."Document No.")
            {
            }
            column(DocumentType_CustLedgerEntry; "Cust. Ledger Entry"."Document Type")
            {
            }
            column(CustomerDetail; CustomerDetail)
            {
            }
            column(CustomerNo_CustLedgerEntry; "Cust. Ledger Entry"."Customer No.")
            {
            }
            column(PostingDate_CustLedgerEntry; "Cust. Ledger Entry"."Posting Date")
            {
            }
            trigger OnAfterGetRecord()
            begin
                CustOrigionalAmt:=0;
                CustRemAmount:=0;
                "Cust. Ledger Entry".CalcFields("Cust. Ledger Entry"."Original Amount");
                "Cust. Ledger Entry".CalcFields("Cust. Ledger Entry"."Remaining Amount");
                CustOrigionalAmt:="Cust. Ledger Entry"."Original Amount";
                CustRemAmount:="Cust. Ledger Entry"."Remaining Amount";
                if CustOrigionalAmt = CustRemAmount then CurrReport.Skip;
            end;
            trigger OnPreDataItem()
            begin
                if CustomerDetail = false then CurrReport.Skip;
            end;
        }
        dataitem("Vendor Ledger Entry"; "Vendor Ledger Entry")
        {
            CalcFields = "Remaining Amount";
            DataItemTableView = where(Open=filter(true));
            RequestFilterFields = "Vendor No.", "Posting Date", "Remaining Amount";

            column(ReportForNavId_1170000007;1170000007)
            {
            }
            column(OriginalAmount_VendorLedgerEntry; "Vendor Ledger Entry"."Original Amount")
            {
            }
            column(RemainingAmount_VendorLedgerEntry; "Vendor Ledger Entry"."Remaining Amount")
            {
            }
            column(Description_VendorLedgerEntry; "Vendor Ledger Entry".Description)
            {
            }
            column(DocumentNo_VendorLedgerEntry; "Vendor Ledger Entry"."Document No.")
            {
            }
            column(DocumentType_VendorLedgerEntry; "Vendor Ledger Entry"."Document Type")
            {
            }
            column(PostingDate_VendorLedgerEntry; "Vendor Ledger Entry"."Posting Date")
            {
            }
            column(VendorNo_VendorLedgerEntry; "Vendor Ledger Entry"."Vendor No.")
            {
            }
            column(VendorDetail; VendorDetail)
            {
            }
            trigger OnAfterGetRecord()
            begin
                VendOrigionalAmt:=0;
                VendRemAmount:=0;
                "Vendor Ledger Entry".CalcFields("Vendor Ledger Entry"."Original Amount");
                "Vendor Ledger Entry".CalcFields("Vendor Ledger Entry"."Remaining Amount");
                VendOrigionalAmt:="Vendor Ledger Entry"."Original Amount";
                VendRemAmount:="Vendor Ledger Entry"."Remaining Amount";
                if VendOrigionalAmt = VendRemAmount then CurrReport.Skip;
            end;
            trigger OnPreDataItem()
            begin
                if VendorDetail = false then CurrReport.Skip;
            end;
        }
    }
    requestpage
    {
        layout
        {
            area(content)
            {
                field(VendorDetail; VendorDetail)
                {
                    ApplicationArea = All;
                }
                field(CustomerDetail; CustomerDetail)
                {
                    ApplicationArea = All;
                }
            }
        }
        actions
        {
        }
    }
    labels
    {
    }
    var VendorDetail: Boolean;
    CustomerDetail: Boolean;
    CustOrigionalAmt: Decimal;
    CustRemAmount: Decimal;
    VendOrigionalAmt: Decimal;
    VendRemAmount: Decimal;
}
