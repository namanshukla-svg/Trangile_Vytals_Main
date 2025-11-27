codeunit 55101 DocumentAttachment
{
    // [EventSubscriber(ObjectType::Page, Page::"Document Attachment Factbox", 'OnBeforeDrillDown', '', false, false)]
    // local procedure OnBeforeDrillDown(DocumentAttachment: Record "Document Attachment"; var RecRef: RecordRef);
    // var
    //     IndentHeader: Record "SSD Indent Header";
    //     PostedIndent: Record "SSD Posted Indent Header";
    // begin
    //     case DocumentAttachment."Table ID" of
    //         DATABASE::"SSD Indent Header":
    //             begin
    //                 RecRef.Open(DATABASE::"Payment Terms");
    //                 if IndentHeader.Get(DocumentAttachment."No.") then
    //                     RecRef.GetTable(IndentHeader);
    //             end;
    //         DATABASE::"SSD Posted Indent Header":
    //             begin
    //                 RecRef.Open(DATABASE::"Payment Terms");
    //                 if PostedIndent.Get(DocumentAttachment."No.") then
    //                     RecRef.GetTable(PostedIndent);
    //             end;
    //     end;
    // end;
    // ❶ Subscribe to the new page instead of the obsolete one.
    [EventSubscriber(ObjectType::Page, Page::"Doc. Attachment List Factbox", 'OnAfterGetRecRefFail', '', false, false)]
    local procedure OnAfterGetRecRefFail(DocumentAttachment: Record "Document Attachment"; var RecRef: RecordRef)
    var
        IndentHdr: Record "SSD Indent Header";
        PostedIndentHdr: Record "SSD Posted Indent Header";
    begin
        case DocumentAttachment."Table ID" of
            DATABASE::"SSD Indent Header":
                if IndentHdr.Get(DocumentAttachment."No.") then begin
                    RecRef.GetTable(IndentHdr);
                end;

            DATABASE::"SSD Posted Indent Header":
                if PostedIndentHdr.Get(DocumentAttachment."No.") then begin
                    RecRef.GetTable(PostedIndentHdr);
                end;
        end;
    end;


    [EventSubscriber(ObjectType::Page, Page::"Document Attachment Details", 'OnAfterOpenForRecRef', '', false, false)]
    local procedure OnAfterOpenForRecRef(var DocumentAttachment: Record "Document Attachment"; var RecRef: RecordRef);
    var
        FieldRef: FieldRef;
        RecNo: Code[20];
    begin
        case RecRef.Number of
            DATABASE::"SSD Indent Header":
                begin
                    FieldRef := RecRef.Field(1);
                    RecNo := FieldRef.Value;
                    DocumentAttachment.SetRange("No.", RecNo);
                end;
            DATABASE::"SSD Posted Indent Header":
                begin
                    FieldRef := RecRef.Field(1);
                    RecNo := FieldRef.Value;
                    DocumentAttachment.SetRange("No.", RecNo);
                end;
        end;
    end;

    [EventSubscriber(ObjectType::Table, Database::"Document Attachment", 'OnAfterInitFieldsFromRecRef', '', false, false)]
    local procedure OnAfterInitFieldsFromRecRef(var DocumentAttachment: Record "Document Attachment"; var RecRef: RecordRef)
    var
        FieldRef: FieldRef;
        RecNo: Code[20];
    begin
        case RecRef.Number of
            DATABASE::"SSD Indent Header":
                begin
                    FieldRef := RecRef.Field(1);
                    RecNo := FieldRef.Value;
                    DocumentAttachment.Validate("No.", RecNo);
                end;
            DATABASE::"SSD Posted Indent Header":
                begin
                    FieldRef := RecRef.Field(1);
                    RecNo := FieldRef.Value;
                    DocumentAttachment.Validate("No.", RecNo);
                end;
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Item Jnl.-Post", OnBeforeCode, '', false, false)]
    local procedure "Item Jnl.-Post_OnBeforeCode"(var ItemJournalLine: Record "Item Journal Line"; var HideDialog: Boolean; var SuppressCommit: Boolean; var IsHandled: Boolean)
    begin
        if (ItemJournalLine."Journal Template Name" = 'ISSUE') and (ItemJournalLine."Journal Batch Name" = 'ISSUESLIP') then
            HideDialog := true;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post", OnAfterPostPurchaseDoc, '', false, false)]
    local procedure "Purch.-Post_OnAfterPostPurchaseDoc"(var PurchaseHeader: Record "Purchase Header"; var GenJnlPostLine: Codeunit "Gen. Jnl.-Post Line"; PurchRcpHdrNo: Code[20]; RetShptHdrNo: Code[20]; PurchInvHdrNo: Code[20]; PurchCrMemoHdrNo: Code[20]; CommitIsSupressed: Boolean)
    var
        PurchHdr: Record "Purchase Header";
    begin
        if (PurchaseHeader."Document Type" = PurchaseHeader."Document Type"::Order) and (PurchaseHeader."SSD Order Type" <> PurchaseHeader."SSD Order Type"::Inventory) then begin
            PurchHdr.Reset();
            PurchHdr.SetRange("Document Type", PurchaseHeader."Document Type");
            PurchHdr.SetRange("No.", PurchaseHeader."No.");
            if PurchHdr.FindFirst() then begin
                PurchHdr."SRN Approval Status" := PurchHdr."SRN Approval Status"::Open; //SRN-IG-20250903-0002
                PurchHdr.Modify();
            end;
        end;
    end;

}