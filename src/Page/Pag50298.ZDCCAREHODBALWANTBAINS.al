page 50298 "ZD CCARE HOD BALWANT BAINS"
{
    Caption = 'ZD CCARE HOD BALWANT BAINS';
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
            action(CustomerList)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Customer List';
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
            action(PQualityOrderforApproval)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'P. Quality Order for Approval';
                RunObject = page "P. Quality Order for Approval";
            }
            action(RcptQualityOrderList)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Rcpt. Quality Order List';
                RunObject = page "Rcpt. Quality Order List";
            }
            action(ManQualityOrderCardList)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Man. Quality Order Card List';
                RunObject = page "Man. Quality Order Card List";
            }
            action(MaterialReceiptNoteList)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Material Receipt Note List';
                RunObject = page "Material Receipt Note List";
            }
            action(SubcontractingOrderList)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Subcontracting Order List';
                RunObject = page "Subcontracting Order List";
            }
            action(QualityofPostedInventory)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Quality of Posted Inventory';
                RunObject = page "Quality of Posted Inventory";
            }
            action(ProductionBOMListViewOnly)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Production BOM List View Only';
                RunObject = page "Production BOM List View Only";
            }
            action(IndentList)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Production BOM List View Only';
                RunObject = page "Production BOM List View Only";
            }
            action(RequeststoApprove)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Pending Approval List';
                RunObject = page "Requests to Approve";
            }
            action(RequeststoApproves)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Requests to Approve';
                RunObject = page "Requests to Approve";
            }
            action(BarcodeLabel)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Barcode Label';
                RunObject = page "Barcode Label";
            }
            action(QRPrintingItemInfo)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'QR Printing Item Info.';
                RunObject = page "QR Printing Item Info.";
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
            group(History)
            {
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
                action(PostedManQOrderList)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Posted Man. Q.Order List';
                    RunObject = page "Posted Man. Q.Order List";
                }
                action(PostedRcptQualityOrderList)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Posted Rcpt Quality Order List';
                    RunObject = page "Posted Rcpt Quality Order List";
                }
            }
            group(Setup)
            {
                action(MeasurementTools)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Measurement Tools';
                    RunObject = page "Measurement Tools";
                }
                action(QualityMeasurements)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Quality: Measurements';
                    RunObject = page "Quality: Measurements";
                }
                action(KindofSampling)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Kind of Sampling';
                    RunObject = page "Kind of Sampling";
                }
                action(SamplingTestList)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Sampling Test List';
                    RunObject = page "Sampling Test List";
                }
            }
            group(Reports)
            {
                action(GPReportNew)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'GP Report New';
                    RunObject = report "GP Report New";
                }
                action(IncomingMaterialAnalysis)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Incoming Material Analysis';
                    RunObject = report "Incoming Material Analysis";
                }
                action(ProductSpecification)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Product Specification';
                    RunObject = report "Product Specification";
                }
                action(ProductionMaterialAnalysis)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Production Material Analysis';
                    RunObject = report "Production Material Analysis";
                }
                action(CertificateofAnalysis)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Certificate of Analysis';
                    RunObject = report "Certificate of Analysis";
                }
                action(QualityParameterDetails)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Quality Parameter Details';
                    RunObject = report "Quality Parameter Details";
                }
                /*action(UpdateQltOrderParameter)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Update Qlt Order Parameter';
                    RunObject = report Updat Qlt Order parameter;
                }*/
                action(SamplingMenu)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Sampling Template';
                    RunObject = report "Sampling Menu";
                }
                action(ItemBlock)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Item Block 90 Day self-life';
                    RunObject = report "Item Block";
                }
                action(ItemUnblock)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Item Unblock 90 Day self-life';
                    RunObject = report "Item Unblock";
                }
                action(PaymentPerformance)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Payment Performance';
                    RunObject = report "Payment Performance";
                }
                action(InterestChargeMemo)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Interest Charge Memo';
                    RunObject = report "Interest Charge Memo";
                }
                action(AgedAccountsReceivable)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Aged Accounts Receivable';
                    RunObject = report "Aged Accounts Receivable";
                }
                action(AgedAccountsReceivable2)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'New Aged Accounts Receivable';
                    RunObject = report "Aged Accounts Payable";
                }
                action(CustomerTrialBalance)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Customer - Trial Balance';
                    RunObject = report "Customer - Trial Balance";
                }
                action(BatchTrackingReport)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Tracking Report';
                    RunObject = report "Batch Tracking Report";
                }
            }
        }
        area(Creation)
        {
            action(ItemReclassJournal)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Item Reclass. Journal';
                RunObject = page "Item Reclass. Journal";
            }
            action(QRPrinting)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'QR Printing';
                RunObject = page "QR Printing";
            }
        }
    }
}
