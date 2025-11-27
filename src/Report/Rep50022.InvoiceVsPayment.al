report 50022 "Invoice Vs Payment"
{
    ApplicationArea = All;
    Caption = 'Invoice Vs Payment';
    UsageCategory = ReportsAndAnalysis;
    RDLCLayout = './Layouts/InvoiceVspaymentTracking.rdl';

    dataset
    {
        dataitem(VendorLedgerEntry; "Vendor Ledger Entry")
        {
            DataItemTableView = where("Document Type"=filter('Invoice'));

            //RequestFilterFields = "Document No.", "Vendor No.";
            column(PostingDate_VendorLedgerEntry; Format("Posting Date"))
            {
            }
            column(ReportFilter; ReportFilter)
            {
            }
            column(DocumentType_VendorLedgerEntry; "Document Type")
            {
            }
            column(DocumentDate_VendorLedgerEntry; Format("Document Date"))
            {
            }
            column(DocumentNo_VendorLedgerEntry; "Document No.")
            {
            }
            column(Amount_VendorLedgerEntry; Amount)
            {
            }
            column(AmountLCY_VendorLedgerEntry; "Amount (LCY)")
            {
            }
            column(RemainingAmount_VendorLedgerEntry; "Remaining Amount")
            {
            }
            column(RemainingAmtLCY_VendorLedgerEntry; "Remaining Amt. (LCY)")
            {
            }
            column(ExternalDocumentNo_VendorLedgerEntry; "External Document No.")
            {
            }
            column(OriginalAmount_VendorLedgerEntry; "Original Amount")
            {
            }
            column(VendorNo_VendorLedgerEntry; "Vendor No.")
            {
            }
            column(VendorName_VendorLedgerEntry; VendorName)
            {
            }
            column(TDSSectionCode_VendorLedgerEntry; "TDS Section Code")
            {
            }
            column(ClosedbyAmount_VendorLedgerEntry; "Closed by Amount")
            {
            }
            column(ClosedbyAmountLCY_VendorLedgerEntry; "Closed by Amount (LCY)")
            {
            }
            dataitem(VendorLedgerEntry2; "Vendor Ledger Entry")
            {
                DataItemTableView = sorting("Entry No.")where("Document Type"=filter('<>Invoice'));
                DataItemLinkReference = VendorLedgerEntry;
                DataItemLink = "Closed by Entry No."=field("Entry No.");

                column(DocumentNo_VendorLedgerEntry2; "Document No.")
                {
                }
                column(DocumentDate_VendorLedgerEntry2; Format("Document Date"))
                {
                }
                column(DocumentType_VendorLedgerEntry2; "Document Type")
                {
                }
                column(ExternalDocumentNo_VendorLedgerEntry2; "External Document No.")
                {
                }
                column(PostingDate_VendorLedgerEntry2; Format("Posting Date"))
                {
                }
                column(Amount_VendorLedgerEntry2; Amount)
                {
                }
                column(AmountLCY_VendorLedgerEntry2; "Amount (LCY)")
                {
                }
                column(RemainingAmount_VendorLedgerEntry2; "Remaining Amount")
                {
                }
                column(RemainingAmtLCY_VendorLedgerEntry2; "Remaining Amt. (LCY)")
                {
                }
                column(OriginalAmount_VendorLedgerEntry2; "Original Amount")
                {
                }
                column(VendorNo_VendorLedgerEntry2; "Vendor No.")
                {
                }
                column(VendorName_VendorLedgerEntry2; VendorName)
                {
                }
                column(TDSSectionCode_VendorLedgerEntry2; "TDS Section Code")
                {
                }
                column(ClosedbyAmount_VendorLedgerEntry2; "Closed by Amount")
                {
                }
                column(ClosedbyAmountLCY_VendorLedgerEntry2; "Closed by Amount (LCY)")
                {
                }
                trigger OnPreDataItem()
                begin
                    SetRange("Posting Date", StartDate, EndDate);
                end;
            }
            dataitem(VendorLedgerEntry3; "Vendor Ledger Entry")
            {
                DataItemTableView = sorting("Entry No.")where("Document Type"=filter('<>Invoice'));
                DataItemLinkReference = VendorLedgerEntry;
                DataItemLink = "Entry No."=field("Closed by Entry No.");

                column(DocumentNo_VendorLedgerEntry3; "Document No.")
                {
                }
                column(DocumentDate_VendorLedgerEntry3; Format("Document Date"))
                {
                }
                column(DocumentType_VendorLedgerEntry3; "Document Type")
                {
                }
                column(ExternalDocumentNo_VendorLedgerEntry3; "External Document No.")
                {
                }
                column(PostingDate_VendorLedgerEntry3; Format("Posting Date"))
                {
                }
                column(Amount_VendorLedgerEntry3; Amount)
                {
                }
                column(AmountLCY_VendorLedgerEntry3; "Amount (LCY)")
                {
                }
                column(RemainingAmount_VendorLedgerEntry3; "Remaining Amount")
                {
                }
                column(RemainingAmtLCY_VendorLedgerEntry3; "Remaining Amt. (LCY)")
                {
                }
                column(OriginalAmount_VendorLedgerEntry3; "Original Amount")
                {
                }
                column(VendorNo_VendorLedgerEntry3; "Vendor No.")
                {
                }
                column(VendorName_VendorLedgerEntry3; VendorName)
                {
                }
                column(TDSSectionCode_VendorLedgerEntry3; "TDS Section Code")
                {
                }
                column(ClosedbyAmount_VendorLedgerEntry3; "Closed by Amount")
                {
                }
                column(ClosedbyAmountLCY_VendorLedgerEntry3; "Closed by Amount (LCY)")
                {
                }
                trigger OnPreDataItem()
                begin
                    SetRange("Posting Date", StartDate, EndDate);
                end;
            }
            trigger OnPreDataItem()
            begin
                if(StartDate <> 0D) and (EndDate <> 0D)then begin
                    VendorLedgerEntry.SetRange("Posting Date", StartDate, EndDate);
                    VendorLedgerEntry.SetRange("Date Filter", StartDate, EndDate);
                    ReportFilter:='Date Filter: ' + Format(StartDate) + '-' + Format(EndDate);
                end;
            end;
            trigger OnAfterGetRecord()
            begin
                if Vendor.Get(VendorLedgerEntry."Vendor No.")then VendorName:=Vendor.Name
                else
                    VendorName:='';
            end;
        }
    }
    requestpage
    {
        layout
        {
            area(Content)
            {
                group("Request Page")
                {
                    field(StartDate; StartDate)
                    {
                        ApplicationArea = all;
                        Caption = 'Start Date';
                    }
                    field(EndDate; EndDate)
                    {
                        ApplicationArea = all;
                        Caption = 'End Date';
                    }
                }
            }
        }
        actions
        {
            area(Processing)
            {
            }
        }
    }
    var Vendor: Record Vendor;
    ReportFilter: Text;
    StartDate: Date;
    EndDate: Date;
    VendorName: Text;
}
