page 50240 "ZD Indent Role Centre"
{
    Caption = 'ZD  Indent Role Centre';
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
            ToolTip = 'Manage Indent Processes.';

            action(ItemIssueList)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Issue List';
                RunObject = page "Item Issue List";
            }
            action(IndentList)
            {
                ApplicationArea = Basic, Suites;
                Caption = 'Indent List';
                RunObject = page "Indent List";
            }
            action(IndentListPendingForAppr)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Indent List-Pending For Appr.';
                RunObject = page "Indent List-Pending For Appr.";
            }
            action(PostedReqLinesPendingPOF)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Posted Req. Lines Pending PO-F';
                RunObject = page "Posted Req. Lines Pending PO-F";
            }
            action(PurchaseOrderList)
            {
                ApplicationArea = Basic, Suites;
                Caption = 'Purchase Order List';
                RunObject = page "Purchase Order List";
            }
            action(PostedReqPurchLines)
            {
                ApplicationArea = Basic, Suites;
                Caption = 'Posted Req. Purch. Lines';
                RunObject = page "Posted Req. Purch. Lines";
            }
            action(PostedIndentList)
            {
                ApplicationArea = Basic, Suites;
                Caption = 'Posted Indent List';
                RunObject = page "Posted Indent List";
            }
            action(IndentListPending)
            {
                ApplicationArea = Basic, Suites;
                Caption = 'Indent List Pending';
                RunObject = page "Indent List Pending";
            }
            action(RequeststoApprove)
            {
                ApplicationArea = Basic, Suites;
                Caption = 'Requests to Approve';
                RunObject = page "Requests to Approve";
            }
            action(IssueSlipListForAppr)
            {
                ApplicationArea = Basic, Suites;
                Caption = 'Issue Slip List For Appr.';
                RunObject = page "Requests to Approve";
            }
            action(IssueSlipApproval)
            {
                ApplicationArea = Basic, Suites;
                Caption = 'Issue Slip Approval';
                RunObject = page "Issue Slip Approval Page";
            }
        }
    }
}
