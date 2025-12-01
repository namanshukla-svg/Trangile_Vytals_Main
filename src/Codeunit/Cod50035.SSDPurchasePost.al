Codeunit 50035 "SSD Purchase Post"
{
    EventSubscriberInstance = Manual;
    TableNo = "Purchase Header";

    trigger OnRun()
    var
        PurchaseHeader: Record "Purchase Header";
        MsgTxt: Text;
    begin
        UserSetup.Get(UserId);
        if not UserSetup."Service Receipts" then Error(PostingErr);
        //Rec.TestField("Assigned User ID");
        //if UserSetup."User ID" <> Rec."Assigned User ID" then
        //Error(AssignedUserFifferentErr, Rec."No.", Rec."Assigned User ID");
        if not Rec.Find() then Error(DocumentErrorsMgt.GetNothingToPostErrorMsg());
        if Rec."Document Type" <> Rec."Document Type"::Order then Error('Only Purchase Orders can be posted using this option');
        CheckTCValidations(Rec);
        PurchaseHeader.Copy(Rec);
        //Atul::01122025
        if PurchaseHeader."Posting Date" <> WorkDate then begin
            MsgTxt :=
               'Posting Date (%1) is not equal to Work Date (%2). Do you want to continue Posting?';

            if not Confirm(StrSubstNo(MsgTxt, PurchaseHeader."Posting Date", WorkDate), false) then begin
                Error('Posting cancelled by user.');
            end;
        end;
        //Atul::01122025
        Code(PurchaseHeader);
        Rec := PurchaseHeader;
        Message('SRN Posted');
    end;

    local procedure "Code"(var PurchaseHeader: Record "Purchase Header")
    var
        PurchSetup: Record "Purchases & Payables Setup";
        PurchPostViaJobQueue: Codeunit "Purchase Post via Job Queue";
        ConfirmMsg: Label 'Do you want to post receipt';
    begin
        if not Confirm(ConfirmMsg) then error('');
        PurchaseHeader.Receive := true;
        PurchSetup.Get();
        if PurchSetup."Post with Job Queue" then
            PurchPostViaJobQueue.EnqueuePurchDoc(PurchaseHeader)
        else begin
            CODEUNIT.Run(CODEUNIT::"Purch.-Post", PurchaseHeader);
        end;
    end;

    procedure CheckTCValidations(PurchaseHeader2: Record "Purchase Header")
    var
        PurchaseLine: Record "Purchase Line";
    begin
        PurchaseLine.SetRange("Document Type", PurchaseHeader2."Document Type");
        PurchaseLine.SetRange("Document No.", PurchaseHeader2."No.");
        PurchaseLine.SetFilter("Qty. to Receive", '<>%1', 0);
        PurchaseLine.SetRange("System-Created Entry", false);
        if PurchaseLine.FindSet() then
            repeat
                PurchaseLine.TestField("SSD Receipt Remarks");
            until PurchaseLine.Next() = 0;
        if PurchaseHeader2."SSD TC Code" = '' then exit;
        CheckReceiptAttachments(PurchaseHeader2);
    end;

    procedure CheckReceiptAttachments(PurchaseHeader4: Record "Purchase Header")
    var
        SSDPOTerms: Record "SSD PO Terms";
        SSDPOCheckList: Record "SSD PO CheckList";
    begin
        SSDPOTerms.SetRange("Document Type", PurchaseHeader4."Document Type");
        SSDPOTerms.SetRange("Document No.", PurchaseHeader4."No.");
        SSDPOTerms.SetRange("Check List", true);
        SSDPOTerms.SetRange("Attachment Required", true);
        if SSDPOTerms.FindSet() then
            repeat
                if not AttachmentExists(PurchaseHeader4, SSDPOTerms."SSD Attachment Type") then error(AttachmentNotExistErr, SSDPOTerms."SSD Attachment Type");
            until SSDPOTerms.Next() = 0;
        SSDPOTerms.SetRange("Attachment Required");
        if not SSDPOTerms.IsEmpty then begin
            SSDPOCheckList.Reset();
            SSDPOCheckList.SetRange("Document Type", PurchaseHeader4."Document Type");
            SSDPOCheckList.SetRange("Document No.", PurchaseHeader4."No.");
            SSDPOCheckList.SetRange("TC Code", PurchaseHeader4."SSD TC Code");
            if SSDPOCheckList.IsEmpty then Error(CheckListNotGeneratedErr);
            if SSDPOCheckList.FindSet() then
                repeat
                    SSDPOCheckList.TestField(Completed);
                until SSDPOCheckList.Next() = 0;
        end;
    end;

    local procedure AttachmentExists(PurchaseHeader3: Record "Purchase Header"; AttachmentType: Code[20]): Boolean
    var
        DocumentAttachment: Record "Document Attachment";
    begin
        DocumentAttachment.Reset();
        DocumentAttachment.SetRange("Table ID", Database::"SSD Purchase Attachment");
        DocumentAttachment.SetRange("Document Type", PurchaseHeader3."Document Type");
        DocumentAttachment.SetRange("No.", PurchaseHeader3."No.");
        DocumentAttachment.SetRange("SSD Attachment Type", AttachmentType);
        if DocumentAttachment.IsEmpty then
            exit(false)
        else
            exit(true);
    end;

    var
        UserSetup: Record "User Setup";
        DocumentErrorsMgt: Codeunit "Document Errors Mgt.";
        PostingErr: Label 'You are not authourized to post Service Receipts';
        AttachmentNotExistErr: Label 'Attachment for type %1 is not available', Comment = '%1 Attachment Type';
        CheckListNotGeneratedErr: Label 'Receipt Checklist has not been generated.';
        AssignedUserFifferentErr: Label 'Service Receipt for Purchase Order %1 can only be posted by %2', Comment = '%1 Purchase Order %2 Assigned User';
}
