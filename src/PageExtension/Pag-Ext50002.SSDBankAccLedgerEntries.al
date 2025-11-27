PageExtension 50002 "SSD Bank Acc. Ledger Entries" extends "Bank Account Ledger Entries"
{
    actions
    {
        addafter("Ent&ry")
        {
            action("SSD HDFC Bank Detail")
            {
                ApplicationArea = All;
                Caption = 'HDFC Bank Detail';
                Image = "Report";
                Promoted = true;
                PromotedCategory = "Report";
                RunObject = Report "Export HDFC Bank";
                ToolTip = 'Executes the HDFC Bank Detail action.';
            }
            action("SSD Other Bank Detail")
            {
                ApplicationArea = All;
                Caption = 'Other Bank Detail';
                Image = "Report";
                Promoted = true;
                PromotedCategory = "Report";
                RunObject = Report "Export Bank Transection Detail";
                ToolTip = 'Executes the Other Bank Detail action.';
            }
        }
    }
}
