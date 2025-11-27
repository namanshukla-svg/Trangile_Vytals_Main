PageExtension 50062 "SSD PostedPurchaseRcptSubform" extends "Posted Purchase Rcpt. Subform"
{
    layout
    {
        addafter(Description)
        {
            field("Currency Code"; Rec."Currency Code")
            {
                ApplicationArea = All;
            }
            field("Gate Entry no."; Rec."Gate Entry no.")
            {
                ApplicationArea = All;
            }
            field("Work Center No."; Rec."Work Center No.")
            {
                ApplicationArea = All;
            }
            field("Posted Whse. Rcpt Line No."; Rec."Posted Whse. Rcpt Line No.")
            {
                ApplicationArea = All;
            }
            field("Posted Whse. Rcpt No."; Rec."Posted Whse. Rcpt No.")
            {
                ApplicationArea = All;
            }
        }
        addafter(Correction)
        {
            field("Hold Payment"; Rec."Hold Payment")
            {
                ApplicationArea = All;
                Editable = false;
            }
        }
        modify("Description 2")
        {
            Visible = true;
        }
    }
    actions
    {
        addafter(ItemInvoiceLines)
        {
            action("Requisition Lines")
            {
                ApplicationArea = All;
                Caption = 'Requisition Lines';

                trigger OnAction()
                begin
                    ShowRequisitionLinesForm;
                end;
            }
            action("Posted Quality Order")
            {
                ApplicationArea = All;
                Caption = 'Posted Quality Order';

                trigger OnAction()
                begin
                    ShowPostedQualityOrder;
                    Rec.ShowItemPurchInvLines;
                end;
            }
        }
    }
    procedure ShowRequisitionLinesForm()
    var
        PostedReqPurchLinesLocal: Record "SSD Posted Req. Purch. Line";
    begin
        //IND St
        PostedReqPurchLinesLocal.Reset;
        PostedReqPurchLinesLocal.SetCurrentkey("Purch. Document Type", "Purch. Document No.", "Purch. Document Line No.", "Due Date");
        PostedReqPurchLinesLocal.FilterGroup(2);
        PostedReqPurchLinesLocal.SetRange("Purch. Document Type", PostedReqPurchLinesLocal."purch. document type"::Receipt);
        PostedReqPurchLinesLocal.SetRange("Purch. Document No.", Rec."Document No.");
        PostedReqPurchLinesLocal.SetRange("Purch. Document Line No.", Rec."Line No.");
        PostedReqPurchLinesLocal.FilterGroup(0);
        if PostedReqPurchLinesLocal.Find('-')then begin
            Page.RunModal(0, PostedReqPurchLinesLocal);
        end;
    //IND En
    end;
    procedure ShowPostedQualityOrder()
    var
        QualityOrdHdrLocal: Record "SSD Posted Quality Order Hdr";
        FrmQltOrderList: Page "Posted Quality Order List";
    begin
        //CF001.01 St
        if Rec."Posted Quality Order No." <> '' then begin
            QualityOrdHdrLocal.Reset;
            QualityOrdHdrLocal.FilterGroup(2);
            QualityOrdHdrLocal.SetRange("No.", Rec."Posted Quality Order No.");
            QualityOrdHdrLocal.FilterGroup(2);
            Clear(FrmQltOrderList);
            FrmQltOrderList.SetTableview(QualityOrdHdrLocal);
            FrmQltOrderList.RunModal;
        end;
    //CF001.01 En
    end;
}
