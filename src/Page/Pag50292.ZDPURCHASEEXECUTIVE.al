page 50292 "ZD PURCHASE EXECUTIVE"
{
    Caption = 'ZD PURCHASE EXECUTIVE';
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

            action(PurchaseCreditMemos)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Purchase Credit Memos';
                RunObject = page "Purchase Credit Memos";
            }
            action(PurchaseOrderList)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Purchase Order List';
                RunObject = page "Purchase Order List";
            }
            action(PurchaseReturnOrderList)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Purchase Return Order List';
                RunObject = page "Purchase Return Order List";
            }
            action(IndentList)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Indent List';
                RunObject = page "Indent List";
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
                Caption = 'Appoval Request Entries';
                RunObject = page "Approval Request Entries";
            }
            /*action(PurchaseOrderWOList)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Purchase Order WO  List';
                RunObject = page Purchase order wo;
            }*/
            action(PurchaseserviceOrderStatus)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Purchase service Order Status';
                RunObject = page "Purchase service Order Status";
            }
            action(IndentListPending)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Pending Approval List';
                RunObject = page "Indent List Pending";
            }
            action(SubcontractingOrderList)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Subcontracting Order List';
                RunObject = page "Subcontracting Order List";
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
            action(PurchaseListArchive)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Purchase List Archive';
                RunObject = page "Purchase List Archive";
            }
        }
        area(Sections)
        {
            group(History)
            {
                Caption = 'History';
                ToolTip = 'Showing History';

                action(PostedPurchaseInvoices)
                {
                    ApplicationArea = Bssic, Suite;
                    Caption = 'Posted Purchase Invoices';
                    RunObject = page "Posted Purchase Invoices";
                }
                action(PostedPurchaseCreditMemos)
                {
                    ApplicationArea = Bssic, Suite;
                    Caption = 'Posted Purchase Credit Memos';
                    RunObject = page "Posted Purchase Credit Memos";
                }
                action(PostedSalesInvoices)
                {
                    ApplicationArea = Bssic, Suite;
                    Caption = 'Posted Sales Invoices';
                    RunObject = page "Posted Sales  Invoice List";
                }
                action(StockkeepingUnitList)
                {
                    ApplicationArea = Bssic, Suite;
                    Caption = 'Stockkeeping Unit List';
                    RunObject = page "Stockkeeping Unit List";
                }
                action(PostedPurchaseReceipts)
                {
                    ApplicationArea = Bssic, Suite;
                    Caption = 'Stockkeeping Unit List';
                    RunObject = page "Posted Purchase Receipts";
                }
            }
            group(Reports)
            {
                Caption = 'Reports';
                ToolTip = 'Shwoing Reports';

                /*action(ConsumptionReport)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Consumption Report1';
                    RunObject = report Consumpti;
                }*/
                action(WhereUsedTopLevel)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Where-Used (Top Level)';
                    RunObject = report "Where-Used (Top Level)";
                }
                action(FSNReport)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'FSN Report';
                    RunObject = report "FSN Report";
                }
                action(FGvsRMRequirement)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'FG vs RM Requirement';
                    RunObject = report "FG vs RM Requirement";
                }
                action(FGvsRMRequirementFor12Mo)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'FG vs RM Requirement For 12 Mo';
                    RunObject = report "FG vs RM Requirement For 12 Mo";
                }
                action(ConsumptionReport1)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Consumption Report 1';
                    RunObject = report "Consumption Report1";
                }
            /*action(ConsumptionReport)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Consumption Report';
                    RunObject = report Consumption Report;
                }*/
            }
        }
        area(Creation)
        {
            action(PlanningWorksheet)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Planning Worksheet';
                RunObject = page "Planning Worksheet";
            }
            action(ItemBudgetForm)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Item Budget Form';
                RunObject = page "Item Budget Form";
            }
        /*action(ItemListwithBudgetCost)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Item List with Budget Cost';
                RunObject = page Item list wi;
            }*/
        }
    }
}
