codeunit 50038 "SSD Purchase Receipt Approve"
{
    TableNo = "Purch. Rcpt. Header";
    Permissions = tabledata "Purch. Rcpt. Header"=m,
        tabledata "Purch. Rcpt. Line"=m;

    trigger OnRun()
    var
        PurchRcptLine: Record "Purch. Rcpt. Line";
        UserErr: Label 'You are not authourized to approve this Service Receipt';
        DocApprove: Label 'Service Receipt %1 has been approved', Comment = '%1 = Service Receipt';
    begin
        if not Rec."SSD SRN Approval Pending" then exit;
        if Rec."SSD SRN Approver" <> UserId then Error(UserErr);
        PurchRcptLine.SetRange("Document No.", Rec."No.");
        if PurchRcptLine.FindSet()then PurchRcptLine.ModifyAll("SSD SRN Approval Pending", false);
        Rec."SSD SRN Approval Pending":=false;
        Rec.Modify(false);
        Message(DocApprove, Rec."No.");
    end;
}
