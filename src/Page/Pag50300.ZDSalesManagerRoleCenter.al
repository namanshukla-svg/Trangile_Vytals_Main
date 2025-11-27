page 50300 "ZD Sales Manager Role Center"
{
    Caption = 'Role Center';
    PageType = RoleCenter;
    ApplicationArea = All;

    layout
    {
        area(rolecenter)
        {
            group(Control1900724808)
            {
                // part(Control21; "Copy Profile")
                // {
                // }
                part(Control1907692008; "My Customers")
                {
                }
            }
            group(Control1900724708)
            {
                part(Control11; "Sales Performance")
                {
                }
                part(Control4; "Trailing Sales Orders Chart")
                {
                }
                part(Control1; "My Job Queue")
                {
                    Visible = false;
                }
                part(Control1902476008; "My Vendors")
                {
                    Visible = false;
                }
                part(Control6; "Report Inbox Part")
                {
                }
                systempart(Control31; MyNotes)
                {
                //                   ApplicationArea = RelationshipMgmt;
                //               }
                //               group("My User Tasks")
                //              {
                //                  Caption = 'My User Tasks';
                //                  part("User Tasks"; "User Tasks Activities")
                //                  {
                //                      ApplicationArea = RelationshipMgmt;
                //                      Caption = 'User Tasks';
                //                  }
                }
            }
        }
    }
    actions
    {
        area(reporting)
        {
            action("Customer - &Order Summary")
            {
                ApplicationArea = Basic;
                Caption = 'Customer - &Order Summary';
                Image = "Report";
                RunObject = Report "Customer - Order Summary";
                ToolTip = 'View the quantity not yet shipped for each customer in three periods of 30 days each, starting from a selected date. There are also columns with orders to be shipped before and after the three periods and a column with the total order detail for each customer. The report can be used to analyze a company''s expected sales volume.';
            }
            action("Customer - &Top 10 List")
            {
                ApplicationArea = Basic;
                Caption = 'Customer - &Top 10 List';
                Image = "Report";
                RunObject = Report "Customer - Top 10 List";
                ToolTip = 'View which customers purchase the most or owe the most in a selected period. Only customers that have either purchases during the period or a balance at the end of the period will be included.';
            }
            separator(Action17)
            {
            }
            action("S&ales Statistics")
            {
                ApplicationArea = Basic;
                Caption = 'S&ales Statistics';
                Image = "Report";
                RunObject = Report "Sales Statistics";
                ToolTip = 'View detailed information about sales to your customers.';
            }
            action("Salesperson - Sales &Statistics")
            {
                ApplicationArea = Basic;
                Caption = 'Salesperson - Sales &Statistics';
                Image = "Report";
                RunObject = Report "Salesperson - Sales Statistics";
                ToolTip = 'View amounts for sales, profit, invoice discount, and payment discount, as well as profit percentage, for each salesperson for a selected period. The report also shows the adjusted profit and adjusted profit percentage, which reflect any changes to the original costs of the items in the sales.';
            }
            action("Salesperson - &Commission")
            {
                ApplicationArea = Basic;
                Caption = 'Salesperson - &Commission';
                Image = "Report";
                RunObject = Report "Salesperson - Commission";
                ToolTip = 'View a list of invoices for each salesperson for a selected period. The following information is shown for each invoice: Customer number, sales amount, profit amount, and the commission on sales amount and profit amount. The report also shows the adjusted profit and the adjusted profit commission, which are the profit figures that reflect any changes to the original costs of the goods sold.';
            }
            separator(Action22)
            {
            }
            action("Campaign - &Details")
            {
                ApplicationArea = Basic;
                Caption = 'Campaign - &Details';
                Image = "Report";
                RunObject = Report "Campaign - Details";
            }
            separator(Action1500000)
            {
            }
            // action("Daily Stock Account")
            // {
            //     ApplicationArea = Basic;
            //     Caption = 'Daily Stock Account';
            //     Image = "Report";
            //     RunObject = Report UnknownReport13710;
            // }
            // action("Sample Register")
            // {
            //     ApplicationArea = Basic;
            //     Caption = 'Sample Register';
            //     Image = "Report";
            //     RunObject = Report UnknownReport16578;
            // }
            // action("Annexure 58")
            // {
            //     ApplicationArea = Basic;
            //     Caption = 'Annexure 58';
            //     Image = "Report";
            //     RunObject = Report UnknownReport16584;
            // }
            // action("Interunit Transfer Register")
            // {
            //     ApplicationArea = Basic;
            //     Caption = 'Interunit Transfer Register';
            //     Image = "Report";
            //     RunObject = Report UnknownReport16577;
            // }
            action("TDS Certificate Summary")
            {
                ApplicationArea = Basic;
                Caption = 'TDS Certificate Summary';
                Image = "Report";
                RunObject = Report "TDS Certificate Summary GST";
            }
            separator(Action1500006)
            {
            }
            action("TDS Certificate Receivable")
            {
                ApplicationArea = Basic;
                Caption = 'TDS Certificate Receivable';
                Image = "Report";
                RunObject = Report "TDS Certificate Receivable GST";
            }
            action(Ledgers)
            {
                ApplicationArea = Basic;
                Caption = 'Ledgers';
                Image = "Report";
                RunObject = Report "Ledger New";
            }
            action("Voucher Register")
            {
                ApplicationArea = Basic;
                Caption = 'Voucher Register';
                Image = "Report";
                RunObject = Report "Voucher Register New";
            }
            action("Day Book")
            {
                ApplicationArea = Basic;
                Caption = 'Day Book';
                Image = "Report";
                RunObject = Report "Day Book New";
            }
            action("Cash Book")
            {
                ApplicationArea = Basic;
                Caption = 'Cash Book';
                Image = "Report";
                RunObject = Report "Cash Book";
            }
            separator(Action1500012)
            {
            }
            // action("Interstate Purchases/Sales")
            // {
            //     ApplicationArea = Basic;
            //     Caption = 'Interstate Purchases/Sales';
            //     Image = "Report";
            //     RunObject = Report UnknownReport16536;
            // }
            // action("Intrastate Purchases/Sales")
            // {
            //     ApplicationArea = Basic;
            //     Caption = 'Intrastate Purchases/Sales';
            //     Image = "Report";
            //     RunObject = Report UnknownReport16537;
            // }
            action("Bank Book")
            {
                ApplicationArea = Basic;
                Caption = 'Bank Book';
                Image = "Report";
                RunObject = Report "Bank Book";
            }
            // action("Sales Book VAT")
            // {
            //     ApplicationArea = Basic;
            //     Caption = 'Sales Book VAT';
            //     Image = "Report";
            //     RunObject = Report UnknownReport16539;
            // }
            action("Job Card/Production Card2")
            {
                ApplicationArea = Basic;
                Caption = 'Job Card/Production Card2';
                Image = "Report";
                RunObject = Report "Job Card/Production Card";
            }
            // action("Transfer Shipment Order-Dup Co")
            // {
            //     ApplicationArea = Basic;
            //     Caption = 'Transfer Shipment Order-Dup Co';
            //     Image = "Report";
            //     RunObject = Report UnknownReport50252;
            // }
            action("Production Actual / Std.")
            {
                ApplicationArea = Basic;
                Caption = 'Production Actual / Std.';
                Image = "Report";
                RunObject = Report "Production Actual / Std.";
            }
            action("GP REPORT II")
            {
                ApplicationArea = Basic;
                Caption = 'GP REPORT II';
                Image = "Report";
                RunObject = Report "GP Report II";
            }
        // action("Phy. Bin Details")
        // {
        //     ApplicationArea = Basic;
        //     Caption = 'Phy. Bin Details';
        //     Image = "Report";
        //     RunObject = Report "Phy. Bin Details";
        // }
        // action("Service Tax Register")
        // {
        //     ApplicationArea = Basic;
        //     Caption = 'Service Tax Register';
        //     Image = "Report";
        //     RunObject = Report UnknownReport16473;
        // }
        }
        area(embedding)
        {
            action("Request to Approve")
            {
                ApplicationArea = Basic;
                Caption = 'Request to Approve';
                RunObject = Page "Requests to Approve";
                ToolTip = 'Request to Approve';
            }
            action("Sales Analysis Reports")
            {
                ApplicationArea = Basic;
                Caption = 'Sales Analysis Reports';
                RunObject = Page "Analysis Report Sale";
                ToolTip = 'Analyze the dynamics of your sales according to key sales performance indicators that you select, for example, sales turnover in both amounts and quantities, contribution margin, or progress of actual sales against the budget. You can also use the report to analyze your average sales prices and evaluate the sales performance of your sales force.';
            }
            action("Sales Analysis by Dimensions")
            {
                ApplicationArea = Basic;
                Caption = 'Sales Analysis by Dimensions';
                RunObject = Page "Analysis View List Sales";
                ToolTip = 'View sales amounts in G/L accounts by their dimension values and other filters that you define in an analysis view and then show in a matrix window.';
            }
            action("Sales Budgets")
            {
                ApplicationArea = Basic;
                Caption = 'Sales Budgets';
                RunObject = Page "Budget Names Sales";
                ToolTip = 'Enter item sales values of type amount, quantity, or cost for expected item sales in different time periods. You can create sales budgets by items, customers, customer groups, or other dimensions in your business. The resulting sales budgets can be reviewed here or they can be used in comparisons with actual sales data in sales analysis reports.';
            }
            action("Sales Quotes")
            {
                ApplicationArea = Basic;
                Caption = 'Sales Quotes';
                Image = Quote;
                RunObject = Page "Sales Quotes";
                ToolTip = 'Make offers to customers to sell certain products on certain delivery and payment terms. While you negotiate with a customer, you can change and resend the sales quote as much as needed. When the customer accepts the offer, you convert the sales quote to a sales invoice or a sales order in which you process the sale.';
            }
            action(SalesOrders)
            {
                ApplicationArea = Basic;
                Caption = 'Sales Orders';
                Image = "Order";
                RunObject = Page "Sales Order List";
                ToolTip = 'Record your agreements with customers to sell certain products on certain delivery and payment terms. Sales orders, unlike sales invoices, allow you to ship partially, deliver directly from your vendor to your customer, initiate warehouse handling, and print various customer-facing documents. Sales invoicing is integrated in the sales order process.';
            }
            action(SalesOrdersOpen)
            {
                ApplicationArea = Basic;
                Caption = 'Open';
                Image = Edit;
                RunObject = Page "Sales Order List";
                RunPageView = WHERE(Status=FILTER(Open));
                ShortCutKey = 'Return';
                ToolTip = 'Open the card for the selected record.';
            }
            action(PurchaseOrder)
            {
                ApplicationArea = Basic;
                Caption = 'Purchase Order';
                Image = Item;
                RunObject = Page "Purchase Order List";
                ToolTip = 'Purchase Order List';
            }
            action("Dynamics CRM Sales Orders")
            {
                ApplicationArea = Basic;
                Caption = 'Dynamics CRM Sales Orders';
                RunObject = Page "CRM Sales Order List";
                RunPageView = where(StateCode=filter(Submitted), LastBackofficeSubmit=filter(''));
            }
            action(SalesInvoices)
            {
                ApplicationArea = Basic;
                Caption = 'Sales Invoices';
                Image = Invoice;
                RunObject = Page "Sales Invoice List";
                ToolTip = 'Register your sales to customers and invite them to pay according to the delivery and payment terms by sending them a sales invoice document. Posting a sales invoice registers shipment and records an open receivable entry on the customer''s account, which will be closed when payment is received. To manage the shipment process, use sales orders, in which sales invoicing is integrated.';
            }
            action(PostedSalesInvoices)
            {
                ApplicationArea = Basic;
                Caption = 'Posted Sales Invoices';
                Image = Invoice;
                RunObject = Page "Posted Sales  Invoice List";
                ToolTip = 'Register your sales to customers and invite them to pay according to the delivery and payment terms by sending them a sales invoice document. Posting a sales invoice registers shipment and records an open receivable entry on the customer''s account, which will be closed when payment is received. To manage the shipment process, use sales orders, in which sales invoicing is integrated.';
            }
            action(SalesInvoicesOpen)
            {
                ApplicationArea = Basic;
                Caption = 'Open';
                Image = Edit;
                RunObject = Page "Sales Invoice List";
                RunPageView = WHERE(Status=FILTER(Open));
                ShortCutKey = 'Return';
                ToolTip = 'Open the card for the selected record.';
            }
            action(Items)
            {
                ApplicationArea = Basic;
                Caption = 'Items';
                Image = Item;
                RunObject = Page "Item List";
                ToolTip = 'View or edit detailed information for the products that you trade in. The item card can be of type Inventory or Service to specify if the item is a physical unit or a labor time unit. Here you also define if items in inventory or on incoming orders are automatically reserved for outbound documents and whether order tracking links are created between demand and supply to reflect planning actions.';
            }
            action(Contacts)
            {
                ApplicationArea = Basic;
                Caption = 'Contacts';
                Image = CustomerContact;
                RunObject = Page "Contact List";
                ToolTip = 'View a list of all your contacts.';
            }
            action(Customers)
            {
                ApplicationArea = Basic;
                Caption = 'Customers';
                Image = Customer;
                RunObject = Page "Customer List";
                ToolTip = 'View or edit detailed information for the customers that you trade with. From each customer card, you can open related information, such as sales statistics and ongoing orders, and you can define special prices and line discounts that you grant if certain conditions are met.';
            }
            action(Campaigns)
            {
                ApplicationArea = Basic;
                Caption = 'Campaigns';
                Image = Campaign;
                RunObject = Page "Campaign List";
                ToolTip = 'View a list of all your campaigns.';
            }
            action(Segments)
            {
                ApplicationArea = Basic;
                Caption = 'Segments';
                Image = Segment;
                RunObject = Page "Segment List";
                ToolTip = 'Create a new segment where you manage interactions with a contact.';
            }
            action("To-dos")
            {
                ApplicationArea = Basic;
                Caption = 'To-dos';
                Image = TaskList;
                RunObject = Page "Task List";
                ToolTip = 'View the list of marketing tasks that exist.';
            }
            action(Teams)
            {
                ApplicationArea = Basic;
                Caption = 'Teams';
                Image = TeamSales;
                RunObject = Page Teams;
                ToolTip = 'View the list of marketing teams that exist.';
            }
        }
        area(sections)
        {
            group("Administration Sales/Purchase")
            {
                Caption = 'Administration Sales/Purchase';
                Image = AdministrationSalesPurchases;

                action("Salespeople/Purchasers")
                {
                    ApplicationArea = Basic;
                    Caption = 'Salespeople/Purchasers';
                    RunObject = Page "Salespersons/Purchasers";
                    ToolTip = 'View a list of your sales people and your purchasers.';
                }
                action("Cust. Invoice Discounts")
                {
                    ApplicationArea = Basic;
                    Caption = 'Cust. Invoice Discounts';
                    RunObject = Page "Cust. Invoice Discounts";
                    ToolTip = 'View or edit invoice discounts that you grant to certain customers.';
                }
                action("Vend. Invoice Discounts")
                {
                    ApplicationArea = Basic;
                    Caption = 'Vend. Invoice Discounts';
                    RunObject = Page "Vend. Invoice Discounts";
                    ToolTip = 'View the invoice discounts that your vendors grant you.';
                }
                action("Item Disc. Groups")
                {
                    ApplicationArea = Basic;
                    Caption = 'Item Disc. Groups';
                    RunObject = Page "Item Disc. Groups";
                    ToolTip = 'View or edit discount group codes that you can use as criteria when you grant special discounts to customers.';
                }
            }
        }
        area(processing)
        {
            separator(Action48)
            {
            Caption = 'Tasks';
            IsHeader = true;
            }
            #if not CLEAN19
            action("Sales Price &Worksheet")
            {
                ApplicationArea = Basic;
                Caption = 'Sales Price &Worksheet';
                Image = PriceWorksheet;
                RunObject = Page "Sales Price Worksheet";
            }
            separator(Action2)
            {
            //         ObsoleteState = Pending;
            //       ObsoleteReason = 'Replaced by the new implementation (V16) of price calculation.';
            //     ObsoleteTag = '19.0';
            }
            action("Sales &Prices")
            {
                ApplicationArea = Basic;
                Caption = 'Sales &Prices';
                Image = SalesPrices;
            //         RunPageView = WHERE("Object Type" = CONST(Page), "Object ID" = CONST(7002)); // "Sales Prices"
            //          RunObject = Page "Role Center Page Dispatcher";
            //        ToolTip = 'Define how to set up sales price agreements. These sales prices can be for individual customers, for a group of customers, for all customers, or for a campaign.';
            //         ObsoleteState = Pending;
            //         ObsoleteReason = 'Replaced by the new implementation (V16) of price calculation.';
            //         ObsoleteTag = '19.0';
            }
            action("Sales Line &Discounts")
            {
                ApplicationArea = Basic;
                Caption = 'Sales Line &Discounts';
                Image = SalesLineDisc;
            // RunPageView = WHERE("Object Type" = CONST(Page), "Object ID" = CONST(7004)); // "Sales Line Discounts"
            // RunObject = Page "Role Center Page Dispatcher";
            // ToolTip = 'View or edit sales line discounts that you grant when certain conditions are met, such as customer, quantity, or ending date. The discount agreements can be for individual customers, for a group of customers, for all customers or for a campaign.';
            // ObsoleteState = Pending;
            //   ObsoleteReason = 'Replaced by the new implementation (V16) of price calculation.';
            //  ObsoleteTag = '19.0';
            }
        #else 
         //   action("Sales Price &Worksheet")
          //  {
           //     ApplicationArea = RelationshipMgmt;
             //   Caption = 'Sales Price &Worksheet';
       //         Image = PriceWorksheet;
         //       RunObject = Page "Price Worksheet";
    //     ToolTip = 'Manage sales prices for individual customers, for a group of customers, for all customers, or for a campaign.';
    //        }
      //      action("Price Lists")
  //          {
    //            ApplicationArea = Basic, Suite;
   //             Caption = '&Prices';
     //           Image = SalesPrices;
       //         RunObject = Page "Sales Price Lists";
         //       ToolTip = 'View or set up sales price lists for products that you sell to the customer. A product price is automatically granted on invoice lines when the specified criteria are met, such as customer, quantity, or ending date.';
         //   }
        #endif 
        }
    }
}
