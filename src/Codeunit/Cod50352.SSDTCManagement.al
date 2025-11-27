codeunit 50352 "SSD TC Management"
{
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post", 'OnAfterProcessPurchLines', '', false, false)]
    local procedure SSDOnAfterProcessPurchLines(var PurchHeader: Record "Purchase Header"; var PurchRcptHeader: Record "Purch. Rcpt. Header")
    var
        SSDPOCheckList: Record "SSD PO CheckList";
        SSDPostedPOCheckList: Record "SSD Posted PO CheckList";
        FromDocumentAttachment: Record "Document Attachment";
        ToDocumentAttachment: Record "Document Attachment";
        SSDPurchaseAttachment: Record "SSD Purchase Attachment";
        DocumentAttachmentMgmt: Codeunit "Document Attachment Mgmt";
        SSDRecordRef: RecordRef;
    begin
        if PurchHeader."Document Type" <> PurchHeader."Document Type"::Order then exit;
        if not PurchHeader.Receive then exit;
        if PurchRcptHeader."No." = '' then exit;
        SSDPOCheckList.SetRange("Document Type", PurchHeader."Document Type");
        SSDPOCheckList.SetRange("Document No.", PurchHeader."No.");
        if SSDPOCheckList.FindSet()then repeat SSDPostedPOCheckList.Init();
                SSDPostedPOCheckList.TransferFields(SSDPOCheckList);
                SSDPostedPOCheckList."Document No.":=PurchRcptHeader."No.";
                SSDPostedPOCheckList.Insert();
                SSDPOCheckList.Delete();
            until SSDPOCheckList.Next() = 0;
        FromDocumentAttachment.SetRange("Table ID", Database::"SSD Purchase Attachment");
        FromDocumentAttachment.SetRange("Document Type", FromDocumentAttachment."Document Type"::Order);
        FromDocumentAttachment.SetRange("No.", PurchHeader."No.");
        if FromDocumentAttachment.FindSet()then repeat Clear(ToDocumentAttachment);
                ToDocumentAttachment.Init();
                ToDocumentAttachment.TransferFields(FromDocumentAttachment);
                ToDocumentAttachment.Validate("Table ID", Database::"Purch. Rcpt. Header");
                ToDocumentAttachment.Validate("Document Type", ToDocumentAttachment."Document Type"::Quote);
                ToDocumentAttachment.Validate("No.", PurchRcptHeader."No.");
                if not ToDocumentAttachment.Insert()then;
                ToDocumentAttachment."Attached Date":=FromDocumentAttachment."Attached Date";
                ToDocumentAttachment.Modify();
            until FromDocumentAttachment.Next() = 0;
        if(PurchHeader."SSD Order Type" = PurchHeader."SSD Order Type"::Service) or (PurchHeader."SSD Order Type" = PurchHeader."SSD Order Type"::"Fixed Assets")then begin
            if SSDPurchaseAttachment.Get(PurchHeader."Document Type", PurchHeader."No.")then;
            SSDRecordRef.GetTable(SSDPurchaseAttachment);
            DocumentAttachmentMgmt.DeleteAttachedDocuments(SSDRecordRef);
        end;
    end;
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Document Attachment Mgmt", 'OnAfterSetDocumentAttachmentFiltersForRecRefInternal', '', false, false)]
    local procedure SSDOnAfterSetDocumentAttachmentFiltersForRecRefInternal(var DocumentAttachment: Record "Document Attachment"; RecordRef: RecordRef)
    var
        FieldRef: FieldRef;
        RecNo: Code[20];
    begin
        if RecordRef.Number() = Database::"SSD Purchase Attachment" then begin
            FieldRef:=RecordRef.Field(3);
            RecNo:=FieldRef.Value();
            DocumentAttachment.SetRange("No.", RecNo);
        end;
    end;
    //OnAfterSetDocumentAttachmentFiltersForRecRefInternal
    /// <summary>
    /// GenerateCheckList.
    /// </summary>
    /// <param name="PurchaseHeader">Record "Purchase Header".</param>
    procedure GenerateCheckList(PurchaseHeader: Record "Purchase Header")
    var
        SSDPOCheckList: Record "SSD PO CheckList";
    begin
        if PurchaseHeader."Document Type" <> PurchaseHeader."Document Type"::Order then Error(DocumentTypeErr);
        CheckListExits(PurchaseHeader);
        CheckExistingActivation(PurchaseHeader);
        InsertCheckList(PurchaseHeader);
        Commit();
        SSDPOCheckList.Reset();
        SSDPOCheckList.SetRange("Document Type", PurchaseHeader."Document Type");
        SSDPOCheckList.SetRange("Document No.", PurchaseHeader."No.");
        SSDPOCheckList.SetRange("TC Code", PurchaseHeader."SSD TC Code");
        Page.Run(Page::"SSD PO Checklist", SSDPOCheckList);
    end;
    local procedure CheckExistingActivation(PurchaseHeader3: Record "Purchase Header")
    var
        SSDPOCheckList: Record "SSD PO CheckList";
    begin
        SSDPOCheckList.Reset();
        SSDPOCheckList.SetRange("Document Type", PurchaseHeader3."Document Type");
        SSDPOCheckList.SetRange("Document No.", PurchaseHeader3."No.");
        SSDPOCheckList.SetRange("Check List", true);
        if SSDPOCheckList.IsEmpty then exit
        else if not Confirm(CheckListAlreadyExistMsg)then Error('')
            else
                DeleteCheckListLines(PurchaseHeader3);
    end;
    local procedure InsertCheckList(PurchaseHeader5: Record "Purchase Header")
    var
        SSDPOTerms: Record "SSD PO Terms";
        SSDPOCheckList: Record "SSD PO CheckList";
    begin
        SSDPOTerms.SetRange("Document Type", PurchaseHeader5."Document Type");
        SSDPOTerms.SetRange("Document No.", PurchaseHeader5."No.");
        SSDPOTerms.SetRange("Check List", true);
        if SSDPOTerms.FindSet()then repeat SSDPOCheckList.Init();
                SSDPOCheckList.TransferFields(SSDPOTerms);
                SSDPOCheckList.Insert(true);
            until SSDPOTerms.Next() = 0 end;
    local procedure DeleteCheckListLines(PurchaseHeader4: Record "Purchase Header")
    var
        SSDPOCheckList: Record "SSD PO CheckList";
    begin
        SSDPOCheckList.Reset();
        SSDPOCheckList.SetRange("Document Type", PurchaseHeader4."Document Type");
        SSDPOCheckList.SetRange("Document No.", PurchaseHeader4."No.");
        if SSDPOCheckList.FindSet()then SSDPOCheckList.DeleteAll();
    end;
    local procedure CheckListExits(PurchaseHeader2: Record "Purchase Header")
    var
        SSDPOTerms: Record "SSD PO Terms";
    begin
        if PurchaseHeader2."SSD TC Code" = '' then Error(CheckListExistErr);
        SSDPOTerms.SetRange("Document Type", PurchaseHeader2."Document Type");
        SSDPOTerms.SetRange("Document No.", PurchaseHeader2."No.");
        SSDPOTerms.SetRange("Check List", true);
        if SSDPOTerms.IsEmpty then Error(POCheckListExistErr);
    end;
    var CheckListAlreadyExistMsg: Label 'Check List is already activated. If you proceed, existing checklist will be deleted. Do you want to proceed?';
    DocumentTypeErr: Label 'Check List can only be generated for Service Receipts';
    CheckListExistErr: Label 'There is no checklist to activate';
    POCheckListExistErr: Label 'There is no checklist item in Purchase Order to activate';
}
