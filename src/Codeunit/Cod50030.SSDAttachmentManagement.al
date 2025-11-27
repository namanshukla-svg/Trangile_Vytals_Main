codeunit 50030 "SSD Attachment Management"
{
    // [EventSubscriber(ObjectType::Table, Database::"Document Attachment", 'OnBeforeSaveAttachment', '', false, false)]
    // local procedure SSDBeforeSaveAttachment(var DocumentAttachment: Record "Document Attachment"; var RecRef: RecordRef; FileName: Text; var TempBlob: Codeunit "Temp Blob")
    // var
    //     ItemVendor: Record "Item Vendor";
    // begin
    //     if DocumentAttachment."Table ID" = Database::"Item Vendor" then begin
    //         Clear(RecRef);
    //         RecRef.Open(DATABASE::"Item Vendor");
    //         if ItemVendor.Get(DocumentAttachment."No.", DocumentAttachment."Item No.", DocumentAttachment."Variant No.") then
    //             RecRef.GetTable(ItemVendor);
    //     end;
    // end;
    // [EventSubscriber(ObjectType::Table, Database::"Document Attachment", 'OnBeforeInsertAttachment', '', false, false)]
    // local procedure SSDBeforeInsertAttachment(var DocumentAttachment: Record "Document Attachment"; var RecRef: RecordRef)
    // var
    //     FieldRef: FieldRef;
    //     RecNo: Code[20];
    //     LineNo: Integer;
    // begin
    //     case RecRef.Number of
    //         Database::"Item Vendor":
    //             begin
    //                 FieldRef := RecRef.Field(2);
    //                 RecNo := FieldRef.Value;
    //                 DocumentAttachment.Validate("No.", RecNo);
    //                 //
    //                 Clear(FieldRef);
    //                 Clear(RecNo);
    //                 FieldRef := RecRef.Field(1);
    //                 RecNo := FieldRef.Value;
    //                 DocumentAttachment.Validate("Item No.", RecNo);
    //                 //
    //                 Clear(FieldRef);
    //                 Clear(RecNo);
    //                 FieldRef := RecRef.Field(5700);
    //                 RecNo := FieldRef.Value;
    //                 DocumentAttachment.Validate("Variant No.", RecNo);
    //             end;
    //     end;
    // end;
    // [EventSubscriber(ObjectType::Page, Page::"Document Attachment Factbox", 'OnBeforeDrillDown', '', false, false)]
    // local procedure BMSOnBeforeDrillDown(DocumentAttachment: Record "Document Attachment"; var RecRef: RecordRef)
    // var
    //     ItemVendor: Record "Item Vendor";
    // begin
    //     case DocumentAttachment."Table ID" of
    //         DATABASE::"Item Vendor":
    //             begin
    //                 RecRef.Open(DATABASE::"Item Vendor");
    //                 if ItemVendor.Get(DocumentAttachment."No.", DocumentAttachment."Item No.", DocumentAttachment."Variant No.") then
    //                     RecRef.GetTable(ItemVendor);
    //             end;
    //     end;
    // end;
    // [EventSubscriber(ObjectType::Page, Page::"Document Attachment Details", 'OnAfterOpenForRecRef', '', false, false)]
    // local procedure SSDOnAfterOpenForRecRef(var DocumentAttachment: Record "Document Attachment"; var RecRef: RecordRef; var FlowFieldsEditable: Boolean)
    // var
    //     FieldRef: FieldRef;
    //     RecNo: Code[20];
    //     LineNo: Integer;
    // begin
    //     case RecRef.Number of
    //         DATABASE::"Item Vendor":
    //             begin
    //                 FieldRef := RecRef.Field(2);
    //                 RecNo := FieldRef.Value;
    //                 DocumentAttachment.SetRange("No.", RecNo);
    //                 //
    //                 Clear(FieldRef);
    //                 Clear(RecNo);
    //                 FieldRef := RecRef.Field(1);
    //                 RecNo := FieldRef.Value;
    //                 DocumentAttachment.Validate("Item No.", RecNo);
    //                 //
    //                 Clear(FieldRef);
    //                 Clear(RecNo);
    //                 FieldRef := RecRef.Field(5700);
    //                 RecNo := FieldRef.Value;
    //                 DocumentAttachment.Validate("Variant No.", RecNo);
    //             end;
    //     end;
    // end;
    [EventSubscriber(ObjectType::Table, Database::"Document Attachment", 'OnBeforeSaveAttachment', '', false, false)]
    local procedure SSDOnBeforeSaveAttachment(var DocumentAttachment: Record "Document Attachment"; var RecRef: RecordRef; FileName: Text; var TempBlob: Codeunit "Temp Blob")
    var
        PurchRecptHeader: Record "Purch. Rcpt. Header";
        SSDPurchaseAttachment: Record "SSD Purchase Attachment";
    begin
        if DocumentAttachment."Table ID" = Database::"Purch. Rcpt. Header" then begin
            CLEAR(RecRef);
            RecRef.Open(DATABASE::"Purch. Rcpt. Header");
            if PurchRecptHeader.Get(DocumentAttachment."No.")then RecRef.GetTable(PurchRecptHeader);
        end;
        if DocumentAttachment."Table ID" = Database::"SSD Purchase Attachment" then begin
            Clear(RecRef);
            RecRef.Open(Database::"SSD Purchase Attachment");
            if SSDPurchaseAttachment.Get(DocumentAttachment."Document Type", DocumentAttachment."No.")then RecRef.GetTable(SSDPurchaseAttachment);
        end;
    end;
    [EventSubscriber(ObjectType::Table, Database::"Document Attachment", 'OnBeforeInsertAttachment', '', false, false)]
    local procedure SSDOnBeforeInsertAttachment(var DocumentAttachment: Record "Document Attachment"; var RecRef: RecordRef)
    var
        FieldRef: FieldRef;
        DocType: Option Quote, "Order", Invoice, "Credit Memo", "Blanket Order", "Return Order";
        RecNo: Code[20];
    begin
        case RecRef.Number of Database::"Purch. Rcpt. Header": begin
            FieldRef:=RecRef.Field(3);
            RecNo:=FieldRef.Value;
            DocumentAttachment.Validate("No.", RecNo);
        end;
        Database::"SSD Purchase Attachment": begin
            FieldRef:=RecRef.Field(1);
            DocType:=FieldRef.Value;
            DocumentAttachment.Validate("Document Type", DocType);
            FieldRef:=RecRef.Field(3);
            RecNo:=FieldRef.Value;
            DocumentAttachment.Validate("No.", RecNo);
        end;
        end;
    end;
    [EventSubscriber(ObjectType::Page, Page::"Document Attachment Factbox", 'OnBeforeDrillDown', '', false, false)]
    local procedure OnBeforeDrillDown(DocumentAttachment: Record "Document Attachment"; var RecRef: RecordRef);
    var
        VendorBankAccount: Record "Item Vendor";
        PurchRcptHeader: Record "Purch. Rcpt. Header";
        SSDPurchaseAttachment: Record "SSD Purchase Attachment";
    begin
        case DocumentAttachment."Table ID" of DATABASE::"Vendor Bank Account": begin
            RecRef.Open(DATABASE::"Item Vendor");
            if VendorBankAccount.Get(DocumentAttachment."No.", DocumentAttachment."Item No.", DocumentAttachment."Variant No.")then RecRef.GetTable(VendorBankAccount);
        end;
        Database::"Purch. Rcpt. Header": begin
            RecRef.Open(Database::"Purch. Rcpt. Header");
            if PurchRcptHeader.Get(DocumentAttachment."No.")then RecRef.GetTable(PurchRcptHeader);
        end;
        Database::"SSD Purchase Attachment": begin
            RecRef.Open(Database::"SSD Purchase Attachment");
            if SSDPurchaseAttachment.Get(DocumentAttachment."Document Type", DocumentAttachment."No.")then RecRef.GetTable(SSDPurchaseAttachment);
        end;
        end;
    end;
    [EventSubscriber(ObjectType::Page, Page::"Document Attachment Details", 'OnAfterOpenForRecRef', '', false, false)]
    local procedure OnAfterOpenForRecRef(var DocumentAttachment: Record "Document Attachment"; var RecRef: RecordRef; var FlowFieldsEditable: Boolean);
    var
        FieldRef: FieldRef;
        RecNo: Code[20];
        VendorBankCode: Code[20];
        VariantCode: Code[20];
        DocType: Option Quote, "Order", Invoice, "Credit Memo", "Blanket Order", "Return Order";
    begin
        case RecRef.Number of DATABASE::"Item Vendor": begin
            FieldRef:=RecRef.Field(2);
            RecNo:=FieldRef.Value;
            DocumentAttachment.SetRange("No.", RecNo);
            FieldRef:=RecRef.Field(1);
            VendorBankCode:=FieldRef.Value;
            DocumentAttachment.SetRange("Item No.", VendorBankCode);
            FieldRef:=RecRef.Field(5700);
            VendorBankCode:=FieldRef.Value;
            DocumentAttachment.SetRange("Variant No.", VariantCode);
            FlowFieldsEditable:=false;
        end;
        DATABASE::"Purch. Rcpt. Header": begin
            FieldRef:=RecRef.Field(3);
            RecNo:=FieldRef.Value;
            DocumentAttachment.SetRange("No.", RecNo);
        end;
        Database::"SSD Purchase Attachment": begin
            FieldRef:=RecRef.Field(1);
            DocType:=FieldRef.Value;
            DocumentAttachment.SetRange("Document Type", DocType);
            FieldRef:=RecRef.Field(3);
            RecNo:=FieldRef.Value;
            DocumentAttachment.SetRange("No.", RecNo);
        end;
        end;
    end;
    [EventSubscriber(ObjectType::Table, Database::"Document Attachment", 'OnAfterInitFieldsFromRecRef', '', false, false)]
    local procedure OnAfterInitFieldsFromRecRef(var DocumentAttachment: Record "Document Attachment"; var RecRef: RecordRef)
    var
        FieldRef: FieldRef;
        RecNo: Code[20];
        VendorBankCode: Code[20];
        VariantCode: Code[20];
    begin
        case RecRef.Number of DATABASE::"Item Vendor": begin
            FieldRef:=RecRef.Field(2);
            RecNo:=FieldRef.Value;
            DocumentAttachment.Validate("No.", RecNo);
            FieldRef:=RecRef.Field(1);
            VendorBankCode:=FieldRef.Value;
            DocumentAttachment.Validate("Item No.", VendorBankCode);
            FieldRef:=RecRef.Field(5700);
            VendorBankCode:=FieldRef.Value;
            DocumentAttachment.Validate("Variant No.", VariantCode);
        end;
        end;
    end;
    [EventSubscriber(ObjectType::Table, Database::"Incoming Document", 'OnBeforeCanReplaceMainAttachment', '', false, false)]
    local procedure SSDOnBeforeCanReplaceMainAttachment(var CanReplaceMainAttachment: Boolean; IncomingDocument: Record "Incoming Document"; var IsHandled: Boolean)
    var
        UserSetup: Record "User Setup";
    begin
        if IncomingDocument.Status <> IncomingDocument.Status::Posted then exit;
        UserSetup.Get(UserId);
        if not UserSetup."SSD Incoming Admin" then begin
            CanReplaceMainAttachment:=false;
            IsHandled:=true;
        end;
    end;
    procedure CheckDocumentAttachment(DocumentAttachment: Record "Document Attachment")
    var
        DocumentAttachment2: Record "Document Attachment";
    begin
        DocumentAttachment2.SetRange("Table ID", DocumentAttachment."Table ID");
        DocumentAttachment2.SetRange("Document Type", DocumentAttachment."Document Type");
        DocumentAttachment2.SetRange("No.", DocumentAttachment."No.");
        if DocumentAttachment2.FindSet()then repeat DocumentAttachment2.TestField("SSD Attachment Type");
            until DocumentAttachment2.Next() = 0;
    end;
}
