page 50291 "ZD DISPATCH"
{
    Caption = 'ZD Dispatch';
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
        area(embedding)
        {
            ToolTip = 'Manage Administrator Processes.';

            action(SalesOrderList)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Rcpt. Quality Order List';
                RunObject = page "Sales Order List";
            }
            action(SalesReturnOrderList)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Sales Return Order List';
                RunObject = page "Sales Return Order List";
            }
            action(SalesInvoice)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Sales Invoice';
                RunObject = page "Sales Invoice List";
            }
            action(SalesCreditMemos)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Sales Credit Memos';
                RunObject = page "Sales Credit Memos";
            }
            action(PurchaseCreditMemos)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Purchase Credit Memos';
                RunObject = page "Purchase Credit Memos";
            }
            action(MaterialReceiptNoteList)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Material Receipt Note List';
                RunObject = page "Material Receipt Note List";
            }
            action(GateInList)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Gate In List';
                RunObject = page "Gate In List";
            }
            action(PurchaseOrderList)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Purchase Order List';
                RunObject = page "Purchase Orders";
            }
            action(PurchaseReturnOrderList)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Purchase Return Order List';
                RunObject = page "Purchase Return Order List";
            }
            action(SalesDespatchOrderList)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Sales Despatch Order List';
                RunObject = page "Sales Despatch Order List";
            }
            action(IndentList)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Indent List';
                RunObject = page "Indent List";
            }
            action(IndentListPending)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Pending Approval List';
                RunObject = page "Indent List Pending";
            }
            action(ShippingAgents)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Shipping Agents';
                RunObject = page "Shipping Agents";
            }
            action(ActualTransporterDetail)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Shipping Agents Delivery';
                RunObject = page "Actual Transporter Detail";
            }
            action(GenerateEWayBillInvoice)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Generate E Way Bill Invoice';
                RunObject = page "Generate E Way Bill Invoice";
            }
            action(GenerateEWayBillSalesRe)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Generate EWay Bill Sales R';
                RunObject = page "Generate EWay Bill Sales Re";
            }
            action(GenerateEWayBillSubcon)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Generate E Way Bill Subcon';
                RunObject = page "Generate E Way Bill Subcon";
            }
            action(GenerateEWayBillTransfer)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Generate E Way Bill Transf';
                RunObject = page "Generate E Way Bill Transfer";
            }
            action(GenerateEWayBillRGP)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Generate E Way Bill RGP';
                RunObject = page "Generate E Way Bill RGP";
            }
            action(GatePassPostedList)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Gate Pass Posted List';
                RunObject = page "Gate Pass Posted List";
            }
            action(ItemIssueList)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Issue Lists';
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
            group(History)
            {
                Caption = 'History';
                ToolTip = 'Showing History Documents';

                action(PostedSalesInvoices)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Posted Sales Invoices';
                    RunObject = page "Posted Sales Invoices";
                }
                action(PostedPurchaseCreditMemos)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Posted Purchase Credit Memos';
                    RunObject = page "Posted Purchase Credit Memos";
                }
                action(PostedWhseReceiptList)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Posted Whse. Receipt List';
                    RunObject = page "Posted Whse. Receipt List";
                }
                /*action(PurchaseInvoiceDirectList)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Purchase Invoice Direct List';
                    RunObject = page Purchase invoice d;
                }*/
                action(PostedPurchaseReceipts)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Posted Purchase Receipts';
                    RunObject = page "Posted Purchase Receipts";
                }
                action(PostedSalesCreditMemos)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Posted Sales Credit Memos';
                    RunObject = page "Posted Sales Credit Memos";
                }
            }
            group(Reports)
            {
                Caption = 'Reports';
                ToolTip = 'Showing Reports';

                action(SalesHeaderShipDateUpdBatch)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'SalesHeader-ShipDate Upd Batch';
                    RunObject = report "SalesHeader-ShipDate Upd Batch";
                }
                action(ExpirationDatechanging)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Expiration Date changing';
                    RunObject = report "Expiration Date changing";
                }
                action(SalesInvoiceExport)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Sales Invoice Export';
                    RunObject = report "Sales Invoice Export";
                }
                action(SalesInvoicenewwithoutQR)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Sales Invoice newwithout QR';
                    RunObject = report "Sales Invoice newwithout QR";
                }
                action(PhyBinDetails)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Phy. Bin Details';
                    RunObject = report "Phy. Bin Details";
                }
                action(CertificateofAnalysisPSI)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Certificate of Analysis.PSI';
                    RunObject = report "Certificate of Analysis.PSI";
                }
                action(SalesInvoiceCommercialNew)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Sales Invoice Commercial New';
                    RunObject = report "Sales Invoice-Commercial1";
                }
            }
        }
    }
}
