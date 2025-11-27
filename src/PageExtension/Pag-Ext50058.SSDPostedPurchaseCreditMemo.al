PageExtension 50058 "SSD PostedPurchaseCreditMemo" extends "Posted Purchase Credit Memo"
{
    actions
    {
        addlast(processing)
        {
            action("Generate E-Invoice")
            {
                ApplicationArea = All;
                Caption = 'Generate E- Invoice';
                Image = Import;
                Promoted = true;
                PromotedIsBig = true;
            }
        }
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
                begin
                    CurrPage.SetSelectionFilter(PurchCrMemoHeader);
                    PurchCrMemoHeader.Reset;
                    PurchCrMemoHeader.SetRange("No.", Rec."No.");
                //SSDU Report.RunModal(Report::"Purch. Cr.as Sales Invoice New", true, true, PurchCrMemoHeader);
                end;
            }
        }
    }
    var PurchCrMemoHeader: Record "Purch. Cr. Memo Hdr.";
}
