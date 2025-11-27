page 50287 "ZD CCare"
{
    Caption = 'ZD CCare';
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

            action(Customer)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Customer';
                RunObject = page "Customer List";
            }
            action(SalesOrderList)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Sales Order List';
                RunObject = page "Sales Order List";
            }
            action(SalesReturnOrderList)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Sales Return Order List';
                RunObject = page "Sales Return Order List";
            }
            action(ApprovalEntries)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Approval Entries';
                RunObject = page "Approval Entries";
            }
            action(Items)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Items';
                RunObject = page "Item List";
            }
            action(IndentListPending)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Indent List Pending';
                RunObject = page "Indent List Pending";
            }
            action(ARE1Details)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'ARE1 Details';
                RunObject = page "ARE1 Details";
            }
            action(IndentList)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Indent List';
                RunObject = page "Indent List";
            }
            /*action(SalesInvoiceCommericalList)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Sales Invoice Commerical List';
                RunObject = page Sales invoice came;
            }*/
            action(ItemIssueList)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Item Issue List';
                RunObject = page "Item Issue List";
            }
            action(IssueSlipListForAppr)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Issue Slip List For Appr.';
                RunObject = page "Issue Slip - Pending For Appr.";
            }
        }
        area(sections)
        {
            group(Action01)
            {
                Caption = 'History';
                ToolTip = 'Showing Transaction History.';

                action(PostedSalesInvoices)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Posted Sales Invoices';
                    RunObject = page "Posted Sales Invoices";
                }
                action(GLRegisters)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'G/L Registers';
                    RunObject = page "G/L Registers";
                }
                group(Action02)
                {
                    Caption = 'Reports';

                    //Image = FiledPosted;
                    action(PaymentPerformance)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Payment Performance';
                        Image = Report;
                        RunObject = report "Payment Performance";
                    }
                    action(InterestChargeMemo)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Interest Charge Memo';
                        Image = Report;
                        RunObject = report "Interest Charge Memo";
                    }
                    action(AgedAccountsReceivable)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Aged Accounts Receivable';
                        Image = Report;
                        RunObject = report "Aged Accounts Receivable";
                    }
                    action(AgedAccountReceivable2)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Aged Accounts Receivable2';
                        Image = Report;
                        RunObject = report "Aged Accounts Receivable2";
                    }
                    action(CustomerTrialBalance)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Customer - Trial Balance';
                        Image = Report;
                        RunObject = report "Customer - Trial Balance";
                    }
                    action(CustomerLedger)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Customer Ledger';
                        Image = Report;
                        RunObject = report "Customer Ledger";
                    }
                    action(DispatchDetails)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Dispatch Details';
                        Image = Report;
                        RunObject = report "Dispatch Details";
                    }
                    action(SalesLRDateTime)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Sales LR Date & Time';
                        Image = Report;
                        RunObject = report "Sales LR Date & Time";
                    }
                    action(WhereUsedTopLevel)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Where-Used (Top Level)';
                        Image = Report;
                        RunObject = report "Where-Used (Top Level)";
                    }
                    /*action(SalesReportExport)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Warehouse Report';
                        Image = Report;
                        RunObject = report Sales ReportExport;
                    }*/
                    action(ModifiedDLforSOCreate)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'OLO SO Creation';
                        Image = Report;
                        RunObject = report ModifiedDLforSOCreate;
                    }
                    /*action(STForm)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'ST Form';
                        Image = Report;
                        RunObject = report ST form;
                    }*/
                    /*action(EmailSTForm)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Email ST Form';
                        Image = Report;
                        RunObject = report Email st;
                    }*/
                    action(PaymentRequest)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Payment Request';
                        Image = Report;
                        RunObject = report "Payment Request";
                    }
                /*action(EmailPaymentRequest)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Email Payment Request.';
                        Image = Report;
                        RunObject = report Email paymen;
                    }*/
                }
            }
        }
        Area(Creation)
        {
            action(CT2Form)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'CT2 Form';
                RunObject = page "CT2 Form";
            }
            action(CT3Form)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'CT3 Form';
                RunObject = page "CT3 Form";
            }
            /*action(ElectronicDataInterchange)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Electronic Data Interchange';
                RunObject = xmlport Electronic;
            }*/
            /*action(MailSend)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Mail Send';
                RunObject = page mail send;
            }*/
            action(ApprovalRequestEntries2)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Approval Request Entries2';
                RunObject = page "Approval Request Entries";
            }
            /*action(SupplementarySalesInvoice)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Supplementary Sales Invoice';
                RunObject = page Supplement;
            }*/
            action(PurchaseInvoices)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Purchase Invoices';
                RunObject = page "Purchase Invoices";
            }
            action(PostedPurchaseInvoices)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Posted Purchase Invoices';
                RunObject = page "Posted Purchase Invoices";
            }
            action(VendorList)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Vendor List';
                RunObject = page "Vendor List";
            }
            action(GLRegister)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'G/L Registers';
                RunObject = page "G/L Registers";
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
                Caption = 'CreateAmazon Sales Invoice';
                RunObject = codeunit "CreateAmazon Sales Invoice";
            }
        }
    }
}
