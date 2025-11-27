page 50041 "ZD IT Admin"
{
    Caption = 'ZD IT Admin';
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

            action(JobQueueEntriess)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Job Queue Entries';
                RunObject = page "Job Queue Entries";
            }
            action(UserSetup)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'User Setup';
                RunObject = page "User Setup";
            }
            action(NoSeries)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'No. Series';
                RunObject = page "No. Series";
            }
            action(ApprovalUserSetup)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Approval User Setup';
                RunObject = page "Approval User Setup";
            }
            action(ConfigTemplateList)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Data Templates List';
                RunObject = page "Config. Template List";
            }
            action(BaseCalendarList)
            {
                ApplicationArea = Basic, Suites;
                Caption = 'Base Calendar List';
                RunObject = page "Base Calendar List";
            }
            action(PostCodes)
            {
                ApplicationArea = Basic, Suites;
                Caption = 'Post Codes';
                RunObject = page "Post Codes";
            }
            action(ReasonCodes)
            {
                ApplicationArea = Basic, Suites;
                Caption = 'Reason Codes';
                RunObject = page "Reason Codes";
            }
            action(ExtendedText)
            {
                ApplicationArea = Basic, Suites;
                Caption = 'Extended Text';
                RunObject = page "Extended Text List";
            }
        }
        area(sections)
        {
            group(JobQueue)
            {
                Caption = 'Job Queue';
                ToolTip = 'Make Queue, Job Queue and view transaction history.';

                action(JobQueueEntries)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Job Queue Entries';
                    RunObject = Page "Job Queue Entries";
                }
                action(JobQueueCategoryList)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Job Queue Category List';
                    RunObject = page "Job Queue Category List";
                }
                action(JobQueueLogEntries)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Job Queue Log Entries';
                    RunObject = page "Job Queue Log Entries";
                }
            }
            group(Intrastat)
            {
                action(TariffNumbers)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Tariff Numbers';
                    RunObject = page "Tariff Numbers";
                }
                action(TransactionTypes)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Transaction Types';
                    RunObject = page "Transaction Types";
                }
                action(TransactionSpecifications)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Transaction Specifications';
                    RunObject = page "Transaction Specifications";
                }
                action(TransportMethods)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Transport Methods';
                    RunObject = page "Transport Methods";
                }
                action(EntryExitPoints)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Entry/Exit Points';
                    RunObject = page "Entry/Exit Points";
                }
                action(Areas)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Areas';
                    RunObject = page Areas;
                }
            }
            group(AnalysisView)
            {
                action(AnalysisViewListSales)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Sales Analysis View List';
                    RunObject = page "Analysis View List";
                }
                action(AnalysisViewListPurchase)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Purchase Analysis View List';
                    RunObject = page "Analysis View List Purchase";
                }
                action(AnalysisViewListInventory)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Inventory Analysis View List';
                    RunObject = page "Analysis View List Inventory";
                }
            }
            group(DateCompression)
            {
                action(DateCompressGeneralLedger)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Date Compress General Ledger';
                    RunObject = report "Date Compress General Ledger";
                }
                action(DateCompressVATEntries)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Date Compress &VAT Entries';
                    RunObject = report "Date Compress VAT Entries";
                }
                action(DateCompressBankAccLedger)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Date Compress Bank &Account Ledger Entries';
                    RunObject = report "Date Compress Bank Acc. Ledger";
                }
                action(DateComprGLBudgetEntries)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Date Compress G/L &Budget Entries';
                    RunObject = report "Date Compr. G/L Budget Entries";
                }
                action(DateCompressCustomerLedger)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Date Compress &Customer Ledger Entries';
                    RunObject = report "Date Compress Customer Ledger";
                }
                action(DateCompressVendorLedger)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Date Compress V&endor Ledger Entries';
                    RunObject = report "Date Compress Vendor Ledger";
                }
                action(DateCompressResourceLedger)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Date Compress &Resource Ledger Entries';
                    RunObject = report "Date Compress Resource Ledger";
                }
                action(DateCompressFALedger)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Date Compress &FA Ledger Entries';
                    RunObject = report "Date Compress FA Ledger";
                }
                action(DateCompressMaintLedger)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Date Compress &Maintenance Ledger Entries';
                    RunObject = report "Date Compress Maint. Ledger";
                }
                action(ModifiedDLforSOCreate)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'OLO SO Creation';
                    RunObject = report ModifiedDLforSOCreate;
                }
                action(DateCompressInsuranceLedger)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Date Compress &Insurance Ledger Entries';
                    RunObject = report "Date Compress Insurance Ledger";
                }
                action(PaymentAdvice)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Payment Advice';
                    RunObject = report "Payment Advice";
                }
                action(DateCompressWhseEntries)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Date Compress &Warehouse Entries';
                    RunObject = report "Date Compress Whse. Entries";
                }
                group(Contacts)
                {
                    action(CreateContsfromCustomers)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Create Conts. from Customers';
                        RunObject = report "Create Conts. from Customers";
                    }
                    action(CreateContsfromVendors)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Create Contacts from &Vendor';
                        RunObject = report "Create Conts. from Vendors";
                    }
                    action(CreateContsfromBankAccs)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Create Contacts from &Bank Account';
                        RunObject = report "Create Conts. from Bank Accs.";
                    }
                    action(Activity)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'To-do &Activities';
                        RunObject = page Activity;
                    }
                    action(Troubleshooting)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Service Trou&bleshooting';
                        RunObject = page Troubleshooting;
                    }
                }
            }
        }
        area(Creation)
        {
            action(PurchaseOrder)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Purchase Order';
                RunObject = page "Purchase Orders";
            }
            group(General)
            {
                action(CompanyInformation)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Company Information';
                    RunObject = page "Company Information";
                }
                // action(ManageStyleSheetsPages)
                // {
                //     ApplicationArea = Basic, Suite;
                //     Caption = '&Manage Style Sheets';
                //     RunObject = page manage stylesh Sheet Page;
                // }
                action(ConfigPackageCard)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Migration O&verview';
                    RunObject = page "Config. Package Card";
                }
                /*action(RelocateAttachments)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Relocate &Attachments';
                    RunObject = page Relocate Attachments;
                }*/
                /*action(CreateWarehouseLocation)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Create Warehouse &Location';
                    RunObject = page Create Warehouse Location;
                }*/
                action(ChangeLogSetup)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'C&hange Log Setup';
                    RunObject = page "Change Log Setup";
                }
            }
            group(ChangeSetup)
            {
                action(ConfigQuestionnaire)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Config. Questionnaire';
                    RunObject = page "Config. Questionnaire";
                }
                action(GeneralLedgerSetup)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'General Ledger Setup';
                    RunObject = page "General Ledger Setup";
                }
                action(SalesReceivablesSetup)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Sales & Re&ceivables Setup';
                    RunObject = page "Sales & Receivables Setup";
                }
                action(PurchasesPayablesSetup)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Purchase & &Payables Setup';
                    RunObject = page "Purchases & Payables Setup";
                }
                action(FixedAssetSetup)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Fixed &Asset Setup';
                    RunObject = page "Fixed Asset Setup";
                }
                action(MarketingSetup)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Mar&keting Setup';
                    RunObject = page "Marketing Setup";
                }
                action(OrderPromisingSetup)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Or&der Promising Setup';
                    RunObject = page "Order Promising Setup";
                }
                /*action(NonstockItemSetup)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Nonstock &Item Setup';
                    RunObject = page NonstockItemSetup;
                }*/
                action(InteractionTemplateSetup)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Interaction &Template Setup';
                    RunObject = page "Interaction Template Setup";
                }
                action(InventorySetup)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Inve&ntory Setup';
                    RunObject = page "Inventory Setup";
                }
                action(WarehouseSetup)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = '&Warehouse Setup';
                    RunObject = page "Warehouse Setup";
                }
                action(Miniforms)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Mini&forms';
                    RunObject = page Miniform;
                }
                action(ManufacturingSetup)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Man&ufacturing Setup';
                    RunObject = page "Manufacturing Setup";
                }
                action(ResourcesSetup)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Man&ufacturing Setup';
                    RunObject = page "Resources Setup";
                }
                action(ServiceMgtSetup)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = '&Service Setup';
                    RunObject = page "Service Mgt. Setup";
                }
                action(HumanResourcesSetup)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = '&Human Resource Setup';
                    RunObject = page "Human Resources Setup";
                }
                action(ServiceOrderStatusSetup)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = '&Service Order Status Setup';
                    RunObject = page "Service Order Status Setup";
                }
                action(RepairStatusSetup)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = '&Repair Status Setup';
                    RunObject = page "Repair Status Setup";
                }
                action(OnlineMapSetup)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = '&MapPoint Setup';
                    RunObject = page "Online Map Setup";
                }
                /*action(SMTPMailSetup)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'SMTP Mai&l Setup';
                    RunObject = page "SMTP Mail Setup";
                }*/
                /*action(JobQueues)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Job Qu&eue Setup';
                    RunObject = page jobQ;
                }*/
                action(ApprovalSetup)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Appro&val Setup';
                    RunObject = page "Approval User Setup";
                }
                action(ProfileQuestionnaireSetup)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Profile Quest&ionnaire Setup';
                    RunObject = page "Profile Questionnaire Setup";
                }
            }
            group(ReportSelection)
            {
                /*action(CheckonNegativeInventory)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Check on Ne&gative Inventory';
                    RunObject = page Check on Negative Inventory;
                }*/
                action(ReportSelectionBankAc)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Report Selection - &Bank Account';
                    RunObject = page "Report Selection - Bank Acc.";
                }
                action(ReportSelectionReminder)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Report Selection - &Reminder && Finance Charge';
                    RunObject = page "Report Selection - Reminder";
                }
                action(ReportSelectionSales)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Report Selection - &Sales';
                    RunObject = page "Report Selection - Sales";
                }
                action(ReportSelectionPurchase)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Report Selection - &Purchase';
                    RunObject = page "Report Selection - Purchase";
                }
                action(ReportSelectionInventory)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Report Selection - &Inventory';
                    RunObject = page "Report Selection - Inventory";
                }
                action(ReportSelectionProdOrder)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Report Selection - Prod. &Order';
                    RunObject = page "Report Selection - Prod. Order";
                }
                action(ReportSelectionService)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Report Selection - S&ervice';
                    RunObject = page "Report Selection - Service";
                }
                action(ReportSelectionCashFlow)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Report Selection - Cash Flow';
                    RunObject = page "Report Selection - Cash Flow";
                }
            }
            group(Import)
            {
                action(ImpIRIStoAreaSymptomCode)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Import IRIS to &Area/Symptom Code';
                    RunObject = xmlport "Imp. IRIS to Area/Symptom Code";
                }
                action(ImportIRIStoFaultCodes)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Import IRIS to &Fault Codes';
                    RunObject = xmlport "Import IRIS to Fault Codes";
                }
                action(ImportIRIStoResolCodes)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Import IRIS to &Resolution Codes';
                    RunObject = xmlport "Import IRIS to Resol. Codes";
                }
            }
            group(SalesAnalysis)
            {
                action(AnalysisLineTemplates)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Sales Analysis &Line Templates';
                    RunObject = page "Analysis Line Templates";
                }
                action(AnalysisColumnTemplates)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Sales Analysis &Column Templates';
                    RunObject = page "Analysis Column Templates";
                }
            }
            group(PurchaseAnalysis)
            {
                action(AnalysisLineTemplatess)
                {
                    ApplicationArea = Basic, Ssuite;
                    Caption = 'Purchase &Analysis Line Templates';
                    RunObject = page "Analysis Line Templates";
                }
                action(AnalysisColumnTemplatess)
                {
                    ApplicationArea = Basic, Ssuite;
                    Caption = 'Purchase Analysis &Column Templates';
                    RunObject = page "Analysis Column Templates";
                }
            }
        }
    }
}
