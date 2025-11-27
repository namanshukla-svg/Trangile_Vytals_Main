Report 50145 "Hold Payment"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Hold Payment.rdl';
    Permissions = TableData "Vendor Ledger Entry"=rm,
        TableData "Purch. Rcpt. Header"=rm,
        TableData "Purch. Rcpt. Line"=rm,
        TableData "Purch. Inv. Header"=rm,
        TableData "Purch. Inv. Line"=rm;

    dataset
    {
    }
    requestpage
    {
        layout
        {
        }
        actions
        {
        }
    }
    labels
    {
    }
    procedure HoldPayment(var PurchInvHeader: Record "Purch. Inv. Header")
    var
        PurchRcptLine: Record "Purch. Rcpt. Line";
        UserSetup: Record "User Setup";
        PurchInvLine: Record "Purch. Inv. Line";
        PurchInvHeader2: Record "Purch. Inv. Header";
        VendLedEntry: Record "Vendor Ledger Entry";
        MSG: Label 'Invoice No. %1 has been hold.';
    begin
        UserSetup.Get(UserId);
        UserSetup.TestField("Hold Vend. Payment Permission", true);
        // PurchRcptLine.SetRange("Document No.", PurchRcptHeader."No.");
        // if PurchRcptLine.FindSet then begin
        //     repeat
        //         PurchRcptLine."Hold Payment" := true;
        //         PurchRcptLine.Modify;
        PurchInvHeader2.Get(PurchInvHeader."No.");
        PurchInvHeader2."Hold Payment":=true;
        PurchInvHeader2.Modify;
        PurchInvLine.Reset;
        PurchInvLine.SetRange("Document No.", PurchInvHeader."No.");
        if PurchInvLine.FindSet then begin
            //repeat
            PurchInvLine.ModifyAll("Hold Payment", true);
        //until PurchInvLine.Next = 0;
        end;
        VendLedEntry.SetRange("Document Type", VendLedEntry."document type"::Invoice);
        VendLedEntry.SetRange("Document No.", PurchInvHeader."No.");
        if VendLedEntry.FindFirst then begin
            VendLedEntry."Hold Payment":=true;
            VendLedEntry."On Hold":='Hol';
            VendLedEntry.Modify;
        end;
        Message(MSG, PurchInvHeader."No.");
    end;
    procedure UnHoldPayment(var PurchInvHeader: Record "Purch. Inv. Header")
    var
        PurchRcptLine: Record "Purch. Rcpt. Line";
        UserSetup: Record "User Setup";
        PurchInvLine: Record "Purch. Inv. Line";
        PurchInvHeader2: Record "Purch. Inv. Header";
        VendLedEntry: Record "Vendor Ledger Entry";
        MSG: Label 'Invoice No. %1 has been unhold.';
    begin
        UserSetup.Get(UserId);
        UserSetup.TestField("UnHold Vend Payment Permission", true);
        // PurchRcptLine.SetRange("Document No.", PurchRcptHeader."No.");
        // if PurchRcptLine.FindSet then begin
        //     repeat
        //         PurchRcptLine."Hold Payment" := false;
        //         PurchRcptLine.Modify;
        PurchInvHeader2.Get(PurchInvHeader."No.");
        PurchInvHeader2."Hold Payment":=false;
        PurchInvHeader2.Modify;
        PurchInvLine.Reset;
        PurchInvLine.SetRange("Document No.", PurchInvHeader."No.");
        if PurchInvLine.FindSet then begin
            //repeat
            PurchInvLine.ModifyAll("Hold Payment", false);
        //until PurchInvLine.Next = 0;
        end;
        VendLedEntry.SetRange("Document Type", VendLedEntry."document type"::Invoice);
        VendLedEntry.SetRange("Document No.", PurchInvHeader."No.");
        if VendLedEntry.FindFirst then begin
            VendLedEntry."Hold Payment":=false;
            VendLedEntry."On Hold":='';
            VendLedEntry.Modify;
        end;
        Message(MSG, PurchInvHeader."No.");
    end;
}
