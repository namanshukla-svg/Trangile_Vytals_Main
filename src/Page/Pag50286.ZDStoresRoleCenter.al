page 50286 "ZD Stores Role Center"
{
    Caption = 'ZD Stores Role Center';
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

            action(MaterialReceiptNoteList)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Material Receipt Note List';
                RunObject = page "Material Receipt Note List";
            }
            action(RGPoutboundList)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'RGP outbound List';
                RunObject = page "RGP outbound List";
            }
            action(NRGPoutboundList)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'NRGP outbound List';
                RunObject = page "NRGP outbound List";
            }
            action(TransferList)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Transfer List';
                RunObject = page "Transfer Orders";
            }
            action(OutBoundList)
            {
                ApplicationArea = Basic, Suite;
                Caption = '57F4 OutBound List';
                RunObject = page "57F4 OutBound List";
            }
            action(SubcontractingOrderList)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Subcontracting Order List';
                RunObject = page "Subcontracting Order List";
            }
            action(GateInList)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Gate In List';
                RunObject = page "Gate In List";
            }
            action(WarehouseShipmentList)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Warehouse Shipment List';
                RunObject = page "Warehouse Shipment List";
            }
            action(WarehouseReceipts)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Warehouse Receipts';
                RunObject = page "Warehouse Receipts";
            }
            action(ItemList)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Item List';
                RunObject = page "Item List";
            }
            action(ReleasedProductionOrders)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Released Production Orders';
                RunObject = page "Released Production Orders";
            }
            action(PurchaseOrderList)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Purchase Order List';
                RunObject = page "Purchase Order List";
            }
            action(InvoiceFrieghtAmount)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Invoice Frieght Amount';
                RunObject = page "Invoice Frieght Amount";
            }
            /*action(PurchaseInvoiceDirectList)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Purchase Invoice Direct List';
                RunObject = page Purchase invoice direc;
            }*/
            action(SalesReturnOrderList)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Sales Return Order List';
                RunObject = page "Sales Return Orders";
            }
            action(BarcodeLabel)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Barcode Label';
                RunObject = page "Barcode Label";
            }
            action(GatePassOpenList)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Gate Pass Open List';
                RunObject = page "Gate Pass Open List";
            }
            action(IndentList)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Indent List';
                RunObject = page "Indent List";
            }
            action(ItemIssueList)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Item Issue List';
                RunObject = page "Item Issue List";
            }
            action(IndentListPending)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Pending Approval List';
                RunObject = page "Indent List Pending";
            }
            action(QualityofPostedInventory)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Physical Posted Inventor';
                RunObject = page "Quality of Posted Inventory";
            }
            action(IssueSlipListForAppr)
            {
                ApplicationArea = Basic, Suite;
                Caption = '<Issue Slip List For Appr.>';
                RunObject = page "Issue Slip - Pending For Appr.";
            }
        }
        area(sections)
        {
            group(Action01)
            {
                Caption = 'History';
                ToolTip = 'Showing Transaction History.';

                action(PostedWhseReceiptList)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Posted Whse. Receipts';
                    RunObject = Page "Posted Whse. Receipt List";
                }
                action(PostedTransferShipments)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Posted Transfer Shipments';
                    RunObject = page "Posted Transfer Shipments";
                }
                action(PostedTransferReceipts)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Posted Transfer Receipts';
                    RunObject = page "Posted Transfer Receipts";
                }
                action(PostedRGPShipmentList)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Posted RGP Shipment List';
                    RunObject = page "Posted RGP Shipment List";
                }
                action(FinishedProductionOrders)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Finished Production Orders';
                    RunObject = page "Finished Production Orders";
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
                action(PurchaseInvoices)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Purchase Invoices';
                    RunObject = page "Purchase Invoices";
                }
                action(PostedSalesInvoices)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Posted Sales Invoices';
                    RunObject = page "Posted Sales Invoices";
                }
                action(TransferOrderShipped)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Transfer Order Shipped';
                    RunObject = page "Transfer Order Shipped";
                }
                action(SubconDetails)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Subcon Details';
                    RunObject = page "Subcon Details";
                }
                action(StockRegister57F4)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'StockRegister57F4';
                    RunObject = page "Stock Register 57F4";
                }
                action(GatePassPostedList)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Gate Pass Posted List';
                    RunObject = page "Gate Pass Posted List";
                }
            }
            group(Action02)
            {
                Caption = 'Reports';
                Image = FiledPosted;

                action(BARCODELEBEL1x2)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Barcode Lable';
                    Image = Report;
                    RunObject = report "BARCODE LEBEL... 1x2";
                }
                action(F4DeliveryChallan)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = '57F4-Delivery Challan';
                    Image = Report;
                    RunObject = report "Delivery Challan 57F4";
                }
                action(TransferOrderShipment)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Transfer Order (Shipment)';
                    Image = Report;
                    RunObject = report "Transfer Order (Shipment)";
                }
                action(TransferOrderReceipt)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Transfer Order (Receipt)';
                    Image = Report;
                    RunObject = report "Transfer Order (Receipt)";
                }
                /*action(SalesReturnRegister)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Sales Return Register';
                    Image = Report;
                    RunObject = report Sales return regs;
                }*/
                action(ItemDailyRegister)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Item Daily Register';
                    Image = Report;
                    RunObject = report "Item Daily Register";
                }
                action(InvoiceFreightAmount)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Invoice Freight Amount';
                    Image = Report;
                    RunObject = report "Invoice Freight Amount";
                }
                action(GatePass)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Gate Pass';
                    Image = Report;
                    RunObject = report "Gate Pass";
                }
                /*action(GateOutFormat)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Gate Out Format';
                    Image = Report;
                    RunObject = report Gate out;
                }*/
                action(PhyBinDetails)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Phy. Bin Details';
                    Image = Report;
                    RunObject = report "Phy. Bin Details";
                }
                action(ConsumptionReport1)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Consumption Report 1';
                    Image = Report;
                    RunObject = report "Consumption Report1";
                }
                action(ProductionActualStd)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Production Actual / Std.';
                    Image = Report;
                    RunObject = report "Production Actual / Std.";
                }
                action(StockRegister57F41)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Stock Register 57F4';
                    Image = Report;
                    RunObject = report "Stock Register 57F4";
                }
                action(RemoveReservationEntry)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Remove Reservation Entry';
                    Image = Report;
                    RunObject = report "Remove Reservation Entry";
                }
                action(ApprovalStatusReport)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Approval Status Report';
                    Image = Report;
                    RunObject = report "Approval Status Report";
                }
            }
        }
        Area(Creation)
        {
            action(ItemJournal)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Item Journal';
                RunObject = page "Item Journal";
            }
            action(ItemReclassJournal)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Item Reclass. Journal';
                RunObject = page "Item Reclass. Journal";
            }
            action(ConsumptionJournal)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Consumption Journal';
                RunObject = page "Consumption Journal";
            }
            action(SubcontractingWorksheet)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Subcontracting Worksheet';
                RunObject = page "Subcontracting Worksheet";
            }
            action(DeliveryChallanList)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Delivery Challan List';
                RunObject = page "Delivery Challan List";
            }
            action(RGPInboundList)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'RGP Inbound List';
                RunObject = page "RGP Inbound List";
            }
            action(SalesDespatchOrderList)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Sales Despatch Order List';
                RunObject = page "Sales Despatch Order List";
            }
            action(RequeststoApprove)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Requests to Approve';
                RunObject = page "Requests to Approve";
            }
        }
    }
}
