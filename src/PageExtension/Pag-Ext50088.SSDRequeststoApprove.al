PageExtension 50088 "SSD Requests to Approve" extends "Requests to Approve"
{
    actions
    {
        modify("Record")
        {
            ShortCutKey = 'Ctrl+q';
        }
        addafter(Delegate)
        {
            action("Approve Item Journal")
            {
                ApplicationArea = All;
                Image = Approval;
                Promoted = true;
                PromotedCategory = New;
                RunObject = Page IJ_ApprovalPage;
            }
            action("Approve RGP")
            {
                ApplicationArea = All;
                Image = Approval;
                Promoted = true;
                PromotedCategory = New;
                RunObject = Page "RGP ApprovalPage";
            }
            action("Approve NRGP")
            {
                ApplicationArea = All;
                Image = Approval;
                Promoted = true;
                PromotedCategory = New;
                RunObject = Page "NRGP Approval Page";
            }
            action("Approve Indent")
            {
                ApplicationArea = All;
                Image = Approval;
                Promoted = true;
                PromotedCategory = New;
                RunObject = Page "Indent Approval Page";
            }
            action("Approve Issue Slip")
            {
                ApplicationArea = All;
                Image = Approval;
                Promoted = true;
                RunObject = Page "Issue Slip Approval Page";
            }
        }
    }
    var PurchaseHeader: Record "Purchase Header";
    PurchaseOrder: Page "Purchase Order";
}
