page 50295 "ZD MANUFACTURING AM"
{
    Caption = 'ZD MANUFACTURING AM';
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

            action(FinishedProductionOrders)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Finished Production Orders';
                RunObject = page "Finished Production Orders";
            }
            action(StockRegister57F4)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Stock Register 57F4-Page';
                RunObject = page "Stock Register 57F4";
            }
            action(PlannedProductionOrders)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Planned Production Orders';
                RunObject = page "Planned Production Orders";
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
            group(Manufacturing)
            {
                Caption = 'Manufacturing';

                action(ItemList)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Item List';
                    RunObject = page "Item List";
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
                action(ProductionBOMList)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Production BOM List';
                    RunObject = page "Production BOM List";
                }
                action(RoutingList)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Routing List';
                    RunObject = page "Routing List";
                }
                action(PlanningWorksheetLineList)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Planning Worksheet Line List';
                    RunObject = page "Planning Worksheet Line List";
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
                action(TransferOrderShipment)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Transfer Order (Shipment)';
                    RunObject = report "Transfer Order (Shipment)";
                }
                action(TransferOrderReceipt)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Transfer Order (Receipt)';
                    RunObject = report "Transfer Order (Receipt)";
                }
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
                /*action(ConsumptionReport)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Consumption Report';
                    RunObject = report Consumption Report;
                }*/
                action(DailyAverageInventory)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Daily Average Inventory';
                    RunObject = report "Daily Average Inventory.";
                }
                action(FGvsRMRequirement)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'FG vs RM Requirement';
                    RunObject = report "FG vs RM Requirement";
                }
                action(FSNReport)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'FSN Report';
                    RunObject = report "FSN Report";
                }
                action(PhyBinDetails)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Phy. Bin Details';
                    RunObject = report "Phy. Bin Details";
                }
                action(JobCardProductionCard2)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Job Card/Production Card2-CONT.';
                    RunObject = report "Job Card/Production Card2";
                }
                action(InventoryTrackingTagging1)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Inventory Tracking & Tagging';
                    RunObject = report "Inventory Tracking & Tagging1";
                }
                action(ProductionActualStd)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Production Actual / Std.';
                    RunObject = report "Production Actual / Std.";
                }
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
                Caption = 'Item Availability by Time';
            //RunObject = page "Item Availability by Timeline"; //SSD_Uncomment_280524
            }
            action(ConsumptionJournal)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Consumption Journal';
                RunObject = page "Consumption Journal";
            }
        }
    }
}
