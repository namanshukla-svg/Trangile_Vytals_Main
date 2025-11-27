page 50293 "ZD FINANCE"
{
    Caption = 'ZD FINANCE';
    PageType = RoleCenter;
    ApplicationArea = All;

    layout
    {
        area(RoleCenter)
        {
            part(Control100; "Headline RC Administrator")
            {
                ApplicationArea = Basic, Suite;
            }
        }
    }
    actions
    {
        area(Embedding)
        {
            ToolTip = 'Manage Administrator Processes.';

            action(ChartofAccounts)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Chart of Accounts';
                RunObject = page "Chart of Accounts";
            }
            action(AnalysisViewList)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Analysis View List';
                RunObject = page "Analysis View List";
            }
            action(GeneralJournalTemplateList)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'General Journal Template List';
                RunObject = page "General Journal Template List";
            }
            /*action(TaxJournalTemplateList)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Tax Journal Template List';
                RunObject = page Tax journal template list;
            }*/
            action(GLBudgetNames)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'G/L Budget Names';
                RunObject = page "G/L Budget Names";
            }
            action(AccountScheduleNames)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Account Schedule Names';
                RunObject = page "Account Schedule Names";
            }
            action(ItemIssueList)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Issue List';
                RunObject = page "Item Issue List";
            }
            action(IssueSlipListForAppr)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Issue Slip List For Appr.';
                RunObject = page "Requests to Approve";
            }
        }
        area(Sections)
        {
            group(CashManagement)
            {
                Caption = 'Cash Management';

                action(BankAccountList)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Bank Account List';
                    RunObject = page "Bank Account List";
                }
                action(BankAccReconciliationList)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Bank Account Reconciliations';
                    RunObject = page "Bank Acc. Reconciliation List";
                }
            }
            group(History)
            {
                Caption = 'History';

                action(BankAccountLedgerEntries)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Bank Account Ledger Entries';
                    RunObject = page "Bank Account Ledger Entries";
                }
                action(CheckLedgerEntries)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Check Ledger Entries';
                    RunObject = page "Check Ledger Entries";
                }
                action(GLRegisters)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'G/L Registers';
                    RunObject = page "G/L Registers";
                }
                action(PostedSalesInvoices)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Posted Sales Invoices';
                    RunObject = page "Posted Sales  Invoice List";
                }
                action(PostedSalesCreditMemos)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Posted Sales Credit Memos';
                    RunObject = page "Posted Sales Credit Memos";
                }
                action(PostedPurchaseReceipts)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Posted Purchase Receipts';
                    RunObject = page "Posted Purchase Receipts";
                }
                action(PostedPurchaseInvoices)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Posted Purchase Invoice';
                    RunObject = page "Posted Purchase Invoices";
                }
            }
            group(Payable)
            {
                Caption = 'Payable';

                /*action(PurchaseInvoiceDirectList)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Purchase Invoice Direct List';
                    RunObject = page Purchase Invoice Direct List;
                }*/
                action(PurchaseInvoices)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Purchase Invoices';
                    RunObject = page "Purchase Invoices";
                }
                action(PurchaseCreditMemos)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Purchase Credit Memos';
                    RunObject = page "Purchase Credit Memos";
                }
                action(VendorList)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Vendor List';
                    RunObject = page "Vendor List";
                }
                action(ItemList)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Item List';
                    RunObject = page "Item List";
                }
                action(ApprovalRequestEntries)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Approval Request Entries';
                    RunObject = page "Approval Request Entries";
                }
                action(ApprovalEntries)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Approval Entries';
                    RunObject = page "Approval Entries";
                }
                action(IndentListPending)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Pending Approval List';
                    RunObject = page "Indent List Pending";
                }
            }
            group(Receivables)
            {
                action(CustomerList)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Customer List';
                    RunObject = Page "Customer List";
                }
                action(SalesCreditMemos)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Sales Credit Memos';
                    RunObject = Page "Sales Credit Memos";
                }
            /*action(SalesInvoiceCommericalList)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Sales Invoice Commerical';
                    RunObject = Page Sales invoice commerical List;
                }*/
            }
            group(CreateRG23II)
            {
            /*action(CreateRGEntriesList)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Create RG Entries List'
                    RunObject = page Create RG Entries List
                }*/
            }
            group(FixedAssets)
            {
                action(FixedAssetList)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Fixed Asset List';
                    RunObject = page "Fixed Asset List";
                }
            }
            group(FinanceSetup)
            {
                action(Dimensions)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Dimensions';
                    RunObject = page "Dimension List";
                }
                action(Currencies)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Currencies';
                    RunObject = page Currencies;
                }
            }
            group(Report)
            {
                action(DayBook)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Day Book New';
                    RunObject = report "Day Book New";
                }
                action(BankReconciliationZav)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Bank Reconciliation Zav';
                    RunObject = report "Bank Reconciliation Zav";
                }
                action(AgedAccountsReceivable2)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Aged Accounts Receivable New';
                    RunObject = report "Aged Accounts Receivable2";
                }
                action(AgedAccountsPayable)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Aged Accounts Payable New';
                    RunObject = report "Aged Accounts Payable New";
                }
                action(InventoryValuationNew)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Inventory Valuation New';
                    RunObject = report "Inventory Valuation>01042020";
                }
                action(DailyaverageInventory)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Daily average Inventory';
                    RunObject = report "Daily Average Inventory.";
                }
                /*action(RG1)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'RG1';
                    RunObject = report rg1;
                }*/
                /*action(RG1Summary)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'RG-1 Summary';
                    RunObject = report RG1-Summary;
                }*/
                action(AgewiseInventory)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Agewise Inventory';
                    RunObject = report "Agewise Inventory";
                }
                /*action(NewPurchaseRegister)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'New Purchase Register';
                    RunObject = report New purchase;
                }*/
                action(PurchaseReturnRegister)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Purchase Return Register';
                    RunObject = report "Purchase Return Register";
                }
                /*action(PLAZavenir)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'PLA';
                    RunObject = report PLa ;
                }*/
                action(NewSalesRegister)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'New Sales Register';
                    RunObject = report "New Sales Register";
                }
                // action(NewSalesRegister2)
                // {
                //     ApplicationArea = Basic, Suite;
                //     Caption = 'New Sales Register';
                //     RunObject = report ;
                // }
                action(SalesReturnRegister)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Sales Return Register';
                    RunObject = report "Sales Return Register";
                }
                action(ItemInventorySummary)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Item Inventory Summary';
                    RunObject = report "Item Inventory Summary";
                }
                action(PaymentPerformance)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Payment Performance';
                    RunObject = report "Payment Performance";
                }
                action(TDSReport)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'TDS Report';
                    RunObject = report "TDS Report";
                }
                action(TDSReportSalary)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'TDS Report(Salary)';
                    RunObject = report "TDS Report(Salary)";
                }
                action(TCSReport)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'TCS Report';
                    RunObject = report "TCS Report";
                }
                /*action(ServiceTaxInputReg)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Service Tax Input Reg';
                    RunObject = report serv tax;
                }*/
                action(LedgerNew)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Ledger New';
                    RunObject = report "Ledger New";
                }
                action(PaymentAdviceMail)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Payment Advice Mail';
                    RunObject = report "Payment Advice Mail";
                }
                action(PaymentPerformanceVendor)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Payment Performance Vendor';
                    RunObject = report "Payment Performance(Vendor)";
                }
                action(VoucherRegisterNew)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Voucher Register New';
                    RunObject = report "Voucher Register New";
                }
                action(VoucherRegister1)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Voucher Register 1';
                    RunObject = report "Voucher Register 1";
                }
                action(PaymentAdvice)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Payment Advice';
                    RunObject = report "Payment Advice";
                }
                action(PostedVoucherNew)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Posted Voucher New';
                    RunObject = report "Posted Voucher New";
                }
                /*action(PaymentAdviceMail)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Payment Advice Mail';
                    RunObject = report Pament advi;
                }*/
                action(VendorLedger)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Vendor Ledger';
                    RunObject = report "Vendor Ledger";
                }
                action(CustomerLedger)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Customer Ledger';
                    RunObject = report "Customer Ledger";
                }
                /*action(GateOutFormat)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Gate Out Report';
                    RunObject = report Gate Out;
                }*/
                action(TrialBalanceNew)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Trial Balance New';
                    RunObject = report "Trial Balance New";
                }
                action(DetailTrialBalanceNew)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Detail Trial Balance New';
                    RunObject = report "Detail Trial Balance New";
                }
                action(PaymentPerformanceCustDel)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Payment Performance Cust. Del.';
                    RunObject = report "Payment Performance Cust. Del.";
                }
                action(SubconTransaction)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Subcon Transaction';
                    RunObject = report "Subcon Transaction";
                }
                action(GPReportNew)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'GP Report New';
                    RunObject = report "GP Report New";
                }
                action(DeliveryChallan57F4)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Delivery Challan 57F4';
                    RunObject = report "Delivery Challan 57F4";
                }
                action(TrialBalanceBudgetNew)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Trial Balance/Budget New';
                    RunObject = report "Trial Balance/Budget New";
                }
                action(TransferOrderShipment)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Transfer Order (Shipment)';
                    RunObject = report "Transfer Order (Shipment)";
                }
                action(ItemDailyRegister)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Item Daily Register';
                    RunObject = report "Item Daily Register";
                }
                action(StockRegister57F4)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Stock Register 57F4';
                    RunObject = report "Stock Register 57F4";
                }
                action(NewSalesRegister2)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'New Sales Register 2';
                    RunObject = report "New Sales Register2";
                }
                action(SalesStatistics)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Sales Statistics';
                    RunObject = report "Sales Statistics";
                }
            }
            group(ASPGSTReports)
            {
                action(GSTExcelDataExport)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'GST Excel Data Export';
                    RunObject = report "GST Excel Data Export";
                }
                action(GSTR1FileFormat)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'GSTR-1 File Format';
                    RunObject = report "GSTR-1 File Format";
                }
                action(GSTR2FileFormat)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'GSTR-2 File Format';
                    RunObject = report "GSTR_2 File Format";
                }
                action(GSTR3B)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'GSTR-3B';
                    RunObject = report "GSTR-3B";
                }
            /*action(UpdateDetGSTEntryGSTR2)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Update Det. GST Entry GSTR2';
                    RunObject = report Update d;
                }*/
            /*action(UpdatePurchaseInvoiceType)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Update Purchase Invoice Type';
                    RunObject = report Update pur;
                }*/
            /*action(UpdateSalesInvoiceType)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Update Sales Invoice Type';
                    RunObject = report update sale;
                }*/
            /*action(UpdateDetGSTEntryGSTR1)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Update Det.GST Entry GSTR1';
                    RunObject = report Update Det;
                }*/
            /*action(UpdateDetGSTEntryGSTR1)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Update Det.GST Entry GSTR1';
                    RunObject = report update d;

                }*/
            }
        }
        area(Creation)
        {
            action(JournalVoucher)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Journal Voucher';
                RunObject = page "Journal Voucher";
            }
            action(GeneralJournal)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'General Journal';
                RunObject = page "General Journal";
            }
            action(RecurringGeneralJournal)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Recurring General Journal';
                RunObject = page "Recurring General Journal";
            }
            action(CashReceiptVoucher)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Cash Receipt Voucher';
                RunObject = page "Cash Receipt Voucher";
            }
            action(CashPaymentVoucher)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Cash Payment Voucher';
                RunObject = page "Cash Payment Voucher";
            }
            action(CashReceiptJournal)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Cash Receipt Journal';
                RunObject = page "Cash Receipt Journal";
            }
            /*action(TaxJournal)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Tax Journal';
                RunObject = page Tax Journal;
            }*/
            action(ContraVoucher)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Contra Voucher';
                RunObject = page "Contra Voucher";
            }
            action(BankReceiptVoucher)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Bank Receipt Voucher';
                RunObject = page "Bank Receipt Voucher";
            }
            action(BankPaymentVoucher)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Bank Payment Voucher';
                RunObject = page "Bank Payment Voucher";
            }
            action(PurchaseJournal)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Purchase Journal';
                RunObject = page "Purchase Journal";
            }
            action(PaymentJournal)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Payment Journal';
                RunObject = page "Payment Journal";
            }
            action(BankAccountStatement)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Bank Account Statement';
                RunObject = page "Bank Account Statement";
            }
            action(ReceivablesPayables)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Receivables-Payables';
                RunObject = page "Receivables-Payables";
            }
            action(GSTCreditAdjustment)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'GST Credit Adjustment';
                RunObject = page "GST Credit Adjustment";
            }
            /*action(UpdateInvoiceDetails)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Update Invoice Details';
                RunObject = page Update invoice details;
            }*/
            action(GSTReconcilationList)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'GST Reconcilation List';
                RunObject = page "GST Reconcilation List";
            }
            /*action(GSTPayment)
            {
                ApplicationArea = Basic, Suite;
                Caption = '<GST Settelment>';
                RunObject = page GST pa;
            }*/
            action(PurchaseInvoicess)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Purchase Invoices';
                RunObject = page "Purchase Invoices";
            }
            action(SalesInvoiceList)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Sales Invoice List';
                RunObject = page "Sales Invoice List";
            }
            action(GeneralLedgerEntries)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'General Ledger Entries';
                RunObject = page "General Ledger Entries";
            }
            action(UploadAmazonStaging)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Upload Amazon Staging';
                RunObject = xmlport "Upload Amazon Staging";
            }
            action(CreateAmazonSalesInvoice)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Create Amazon Sales Invoice';
                RunObject = codeunit "CreateAmazon Sales Invoice";
            }
            /*action(SalesInvoiceCommericalList)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Sales Invoice Commerical List';
                RunObject = page sales invoice commericallist ;
            }*/
            /*action(PurchaseOrderWOList)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Purchase Order WO  List';
                RunObject = page Purchase order WO List;
            }*/
            action(InterestChargeMemo)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Interest Charge Memo';
                RunObject = Report "Interest Charge Memo";
            }
            /*action(CapacityLedgerEntries)
            {
                ApplicationArea =  Basic, Suite;
                Caption = 'Capacity Ledger Entries';
                RunObject = Report Capaity;
            }*/
            action(PaymentAdviceSummary)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Payment Summary Report';
                RunObject = Report "Payment Advice Summary";
            }
            action(InventoryValuationBase)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Inventory Valuation Base';
                RunObject = Report "Inventory Valuation New";
            }
            action(Label21)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Label - 2 * 1';
                RunObject = Report "Label - 2 * 1";
            }
        }
    }
}
