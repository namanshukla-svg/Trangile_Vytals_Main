page 50297 "ZD PURCHASE HOD"
{
    Caption = 'ZD PURCHASE HOD';
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

            action(ItemList)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Item List';
                RunObject = page "Item List";
            }
            action(PurchaseOrderList)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Purchase order List';
                RunObject = page "Purchase Order List";
            }
            action(VendorList)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Vendor List';
                RunObject = page "Vendor List";
            }
            action(ApprovalRequestEntries)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Approval Request Entries';
                RunObject = page "Approval Request Entries";
            }
            action(PurchaseReturnOrderList)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Purchase Return Order';
                RunObject = page "Purchase Return Order List";
            }
            action(PurchaseCreditMemos)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Purchase Credit Memos';
                RunObject = page "Purchase Credit Memos";
            }
            action(CustomerList)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Customer List';
                RunObject = page "Customer List";
            }
            action(DimensionValueList)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Dimension Value List-(View)';
                RunObject = page "Dimension Value List";
            }
            action(PaymentTerms)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Payment Terms-(View)';
                RunObject = page "Payment Terms";
            }
            action(IndentList)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Indent List';
                RunObject = page "Indent List";
            }
            action(RequeststoApprove)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Requests to  Approval';
                RunObject = page "Requests to Approve";
            }
            /*action(PurchaseOrderWOList)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Purchase Order WO  List';
                RunObject = page purchase order wo list;
            }*/
            action(PurchaseserviceOrderStatus)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Purchase service Order Status';
                RunObject = page "Purchase service Order Status";
            }
            action(ProductionBOMListViewOnly)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Production BOM List View Only';
                RunObject = page "Production BOM List View Only";
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
            group(Purchase)
            {
                action(PurchaseOrderLists)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Purchase Order List';
                    RunObject = page "Purchase Order List";
                }
                action(PurchaseReturnOrderLists)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Purchase Return Order List';
                    RunObject = page "Purchase Return Order List";
                }
                action(PurchaseCrediteMemos)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Purchase Credit Memos';
                    RunObject = page "Purchase Credit Memos";
                }
            }
            group(History)
            {
                action(PostedPurchaseInvoices)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Posted Purchase Invoices';
                    RunObject = page "Posted Purchase Invoices";
                }
                action(PostedWhseReceiptList)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Posted Whse. Receipts';
                    RunObject = page "Posted Whse. Receipt List";
                }
                action(PostedGateInList)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Posted Gate In List';
                    RunObject = page "Posted Gate In List";
                }
                action(PostedPurchaseReceipts)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Posted Purchase Receipts';
                    RunObject = page "Posted Purchase Receipts";
                }
                action(PostedPurchaseCreditMemos)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Posted Purchase Credit Memos';
                    RunObject = page "Posted Purchase Credit Memos";
                }
                action(ReleasedProductionOrders)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Released Production Orders';
                    RunObject = page "Released Production Orders";
                }
                action(FinishedProductionOrders)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Finished Production Orders';
                    RunObject = page "Finished Production Orders";
                }
            }
            group(Reports)
            {
                /*action(ConsumptionReport)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Consumption Report';
                    RunObject = report = consumptions;
                }*/
                action(PaymentPerformanceVendor)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Payment Performance(Vendor)';
                    RunObject = report "Payment Performance(Vendor)";
                }
                action(ProductSpecification)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Product Specification';
                    RunObject = report "Product Specification";
                }
                action(AgedAccountsPayable)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Aged Accounts Payable';
                    RunObject = report "Aged Accounts Payable";
                }
                action(PaymentPerformance)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Payment Performance';
                    RunObject = report "Payment Performance";
                }
                action(ConsumptionReport1)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Consumption Report 1';
                    RunObject = report "Consumption Report1";
                }
            /*action(BudgetNamesPurchase)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Budget Names Purchase';
                    RunObject = report Budget newm;
                }*/
            /*action(AnalysisReportPurchase)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Budget Names Purchase';
                    RunObject = report Analysis report pu;
                }*/
            }
        }
        area(Creation)
        {
            action(ItemBudgetForm)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Item Budget Form';
                RunObject = page "Item Budget Form";
            }
            action(ApprovalRequestEntries2)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Approval Request Entries2';
                RunObject = page "Approval Request Entries";
            }
            action(approvalentry)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Approval Entry';
                RunObject = page "Approval Entries";
            }
        }
    }
}
