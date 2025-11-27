page 50285 "ZD PRODUCTION PLANNER"
{
    Caption = 'ZD PRODUCTION PLANNER';
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

            action(FinishedProductionOrders)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Finished Production Orders';
                RunObject = page "Finished Production Orders";
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
            group(PPC)
            {
                Caption = 'PPC';
                ToolTip = 'Showing Transaction History.';

                action(Items)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Item List';
                    RunObject = page "Item List";
                }
                action(ItemLedgerEntriesM)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Item Ledger Entries-M';
                    RunObject = page "Item Ledger Entries-M";
                }
                action(StockkeepingUnitList)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Stockkeeping Unit List';
                    RunObject = page "Stockkeeping Unit List";
                }
                /*action(TransferList)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Transfer List';
                    RunObject = page Transf;
                }*/
                action(PostedSalesInvoices)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Posted Sales Invoices';
                    RunObject = page "Posted Sales Invoices";
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
                    Caption = 'Indent List Pending';
                    RunObject = page "Indent List Pending";
                }
                action(PlannedProductionOrders)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Planned Production Orders';
                    RunObject = page "Planned Production Orders";
                }
                action(SalesOrderList)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Sales Order List';
                    RunObject = page "Sales Order List";
                }
                action(ReleasedProductionOrders)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Released Production Orders';
                    RunObject = page "Released Production Orders";
                }
                action(SubcontractingOrderList)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Subcontracting Order List';
                    RunObject = page "Subcontracting Order List";
                }
                action(PlannedProductionOrder)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Planned Production Orders';
                    RunObject = page "Planned Production Orders";
                }
            }
            group(Reports)
            {
                action(JobCardProductionCard)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Job Card/Production Card';
                    RunObject = report "Job Card/Production Card";
                }
                action(IncomingMaterialAnalysis)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Incoming Material Analys';
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
                action(F4DelivceryChallan)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = '57F4-Delivcery Challan';
                    RunObject = report "Delivery Challan 57F4";
                }
                action(TransferOrderShipment)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Transfer Order (Shipment)';
                    RunObject = report "Transfer Order (Shipment)";
                }
                action(TransferOrdeReceipt)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Transfer Order (Receipt)';
                    RunObject = report "Transfer Order (Receipt)";
                }
                /*action(RG1)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'RG1';
                    RunObject = report RG1;
                }*/
                /*action(RG1Summary)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'RG1 Summary';
                    RunObject = report RG1 Summary;
                }*/
                action(AgewiseInventory)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Agewise Inventory';
                    RunObject = report "Agewise Inventory";
                }
                action(ItemInventorySummary)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Item Inventory Summary';
                    RunObject = report "Item Inventory Summary";
                }
                action(OTIFIncomingShipments)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'OTIF-Incoming Shipments';
                    RunObject = report "OTIF-Incoming Shipments";
                }
                action(OTIFOutgoingShipments)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'OTIF-Outgoing Shipments';
                    RunObject = report "OTIF-Outgoing Shipments";
                }
                /*action(ConsumptionReport)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Consumption Report';
                    RunObject = report Consumpt;
                }*/
                action(PhyBinDetails)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Phy. Bin Details';
                    RunObject = report "Phy. Bin Details";
                }
                action(DailyAverageInventory)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Daily Average Inventory';
                    RunObject = report "Daily Average Inventory.";
                }
                action(InventoryTrackingTagging1)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Inventory Tracking & Tagging';
                    RunObject = report "Inventory Tracking & Tagging1";
                }
                action(JobCardProductionCard2)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Job Card/Production Card2';
                    RunObject = report "Job Card/Production Card2";
                }
                action(ProductionActualStd)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Production Actual / Std.';
                    RunObject = report "Production Actual / Std.";
                }
                action(FSNReport)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'FSN Report';
                    RunObject = report "FSN Report";
                }
            }
        }
        area(Creation)
        {
            action(SubcontractingWorksheet)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Subcontracting Worksheet';
                RunObject = page "Subcontracting Worksheet";
            }
            action(RecurringReqWorksheet)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Recurring Req. Worksheet';
                RunObject = page "Recurring Req. Worksheet";
            }
            action(ItemAvailabilitybyTimeline)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Item Availability by Timel';
            //RunObject = Page "Item Availability by Timeline"; //SSD_UnComment_280524
            }
            action(ConsumptionJournal)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Consumption Journal';
                RunObject = Page "Consumption Journal";
            }
            action(PlanningWorksheet)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Planning Worksheet';
                RunObject = Page "Planning Worksheet";
            }
            action(BarcodeLabel)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Barcode Label';
                RunObject = Page "Barcode Label";
            }
            action(ItemJournalTemplateList)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Item Journal Template List';
                RunObject = Page "Item Journal Template List";
            }
            action(ItemReclassJournal)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Item Reclass. Journal';
                RunObject = Page "Item Reclass. Journal";
            }
        }
    }
}
