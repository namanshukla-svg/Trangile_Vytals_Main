PageExtension 50059 "SSD PostedPurchaseCreditMemos" extends "Posted Purchase Credit Memos"
{
    actions
    {
        addafter("&Print")
        {
            action("&PrintGST")
            {
                ApplicationArea = All;
                Caption = '&PrintGST';
                Ellipsis = true;
                Image = Print;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                var
                    PurchCrMemoHdr: Record "Purch. Cr. Memo Hdr.";
                begin
                    CurrPage.SetSelectionFilter(PurchCrMemoHdr);
                    PurchCrMemoHdr.Reset;
                    PurchCrMemoHdr.SetRange("No.", Rec."No.");
                //SSDU Report.RunModal(Report::"Purch. Cr.as Sales Invoice New", true, true, PurchCrMemoHdr);
                end;
            }
        }
    }
}
