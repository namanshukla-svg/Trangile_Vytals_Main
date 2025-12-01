page 50362 "SSD Post Service Receipt"
{
    Caption = 'Service PO Receipt';
    PageType = Document;
    RefreshOnActivate = true;
    DeleteAllowed = false;
    InsertAllowed = false;
    //ModifyAllowed = false;
    SourceTable = "Purchase Header";
    SourceTableView = where("Document Type" = filter(Order), Status = const(Released));
    UsageCategory = None;
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';

                field("No."; Rec."No.")
                {
                    ApplicationArea = Suite;
                    Importance = Promoted;
                    ToolTip = 'Specifies the number of the involved entry or record, according to the specified number series.';
                    Visible = DocNoVisible;
                    Editable = false;
                }
                field("Buy-from Vendor No."; Rec."Buy-from Vendor No.")
                {
                    ApplicationArea = Suite;
                    Caption = 'Vendor No.';
                    Importance = Additional;
                    NotBlank = true;
                    Editable = false;
                    ToolTip = 'Specifies the number of the vendor who delivers the products.';
                }
                field("Buy-from Vendor Name"; Rec."Buy-from Vendor Name")
                {
                    ApplicationArea = Suite;
                    Caption = 'Vendor Name';
                    Importance = Promoted;
                    ShowMandatory = true;
                    ToolTip = 'Specifies the name of the vendor who delivers the products.';
                    Editable = false;
                }
                field("Document Date"; Rec."Document Date")
                {
                    ApplicationArea = Suite;
                    Importance = Promoted;
                    ToolTip = 'Specifies the date when the related document was created.';
                    Editable = false;
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = Suite;
                    Importance = Additional;
                    ToolTip = 'Specifies the posting date of the record.';
                }
                field("Vendor Invoice No."; Rec."Vendor Invoice No.")
                {
                    ApplicationArea = Suite;
                    ShowMandatory = VendorInvoiceNoMandatory;
                    ToolTip = 'Specifies the document number of the original document you received from the vendor. You can require the document number for posting, or let it be optional. By default, it''s required, so that this document references the original. Making document numbers optional removes a step from the posting process. For example, if you attach the original invoice as a PDF, you might not need to enter the document number. To specify whether document numbers are required, in the Purchases & Payables Setup window, select or clear the Ext. Doc. No. Mandatory field.';
                }
                field("Vendor Invoice Date"; Rec."Vendor Invoice Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Vendor Invoice Date field.';
                }
                field("Invoice Amount"; Rec."Invoice Amount")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Invoice Amount field.';
                }
                field("Your Reference"; Rec."Your Reference")
                {
                    ApplicationArea = Basic, Suite;
                    Importance = Additional;
                    ToolTip = 'Specifies the vendor''s reference.';
                    Editable = false;
                }
                field("Purchaser Code"; Rec."Purchaser Code")
                {
                    ApplicationArea = Suite;
                    Importance = Additional;
                    ToolTip = 'Specifies which purchaser is assigned to the vendor.';
                    Editable = false;
                }
                field("Order Date"; Rec."Order Date")
                {
                    ApplicationArea = Suite;
                    Importance = Additional;
                    Editable = false;
                    ToolTip = 'Specifies the date the order was created. The order date is also used to determine the prices and discounts on the document.';
                }
                field("Assigned User ID"; Rec."Assigned User ID")
                {
                    ApplicationArea = Suite;
                    Importance = Promoted;
                    ToolTip = 'Specifies the ID of the user who is responsible for the document.';
                    Editable = false;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = Suite;
                    Importance = Promoted;
                    StyleExpr = StatusStyleTxt;
                    ToolTip = 'Specifies whether the record is open, waiting to be approved, invoiced for prepayment, or released to the next stage of processing.';
                }
            }
            part(PurchLines; "SSD Service Receipt Subform")
            {
                ApplicationArea = Suite;
                Editable = IsPurchaseLinesEditable;
                Enabled = IsPurchaseLinesEditable;
                SubPageLink = "Document No." = field("No.");
                UpdatePropagation = Both;
            }
        }
        area(factboxes)
        {
            part("Attached Documents"; "Document Attachment Factbox")
            {
                ApplicationArea = All;
                Caption = 'Attachments';
                SubPageLink = "Table ID" = const(Database::"SSD Purchase Attachment"), "No." = field("No."), "Document Type" = field("Document Type");
            }
        }
    }
    actions
    {
        area(processing)
        {
            group(CheckList)
            {
                Caption = 'CheckList';
                Image = CheckList;

                action(UpdateChecklist)
                {
                    ApplicationArea = All;
                    Caption = 'Checklist';
                    Ellipsis = true;
                    Image = DocumentEdit;
                    ToolTip = 'Executes the Fill Checklist action.';
                    RunObject = Page "SSD PO Checklist";
                    RunPageLink = "Document Type" = field("Document Type"), "Document No." = field("No.");
                }
            }
            // group("P&osting")
            // {
            //     Caption = 'P&osting';
            //     Image = Post;
            //     action(Post)
            //     {
            //         ApplicationArea = Suite;
            //         Caption = 'P&ost';
            //         Ellipsis = true;
            //         Image = PostOrder;
            //         //Visible = false;
            //         //ShortCutKey = 'F9';
            //         ToolTip = 'Finalize the document or journal by posting the amounts and quantities to the related accounts in your company books.';
            //         trigger OnAction()
            //         begin
            //             PostDocument(CODEUNIT::"SSD Purchase Post");
            //         end;
            //     }
            // }
        }
    }
    trigger OnAfterGetCurrRecord()
    begin
        StatusStyleTxt := Rec.GetStatusStyleText();
    end;

    trigger OnAfterGetRecord()
    begin
        ShowOverReceiptNotification();
        BuyFromContact.GetOrClear(Rec."Buy-from Contact No.");
        PayToContact.GetOrClear(Rec."Pay-to Contact No.");
    end;

    trigger OnDeleteRecord(): Boolean
    begin
        CurrPage.SaveRecord();
        exit(Rec.ConfirmDeletion());
    end;

    trigger OnInit()
    begin
        SetExtDocNoMandatoryCondition();
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    var
        LookupStateManager: Codeunit "Lookup State Manager";
    begin
        if LookupStateManager.IsRecordSaved() then LookupStateManager.ClearSavedRecord();
        Rec."Responsibility Center" := UserSetupManagement.GetPurchasesFilter();
        if (not DocNoVisible) and (Rec."No." = '') then begin
            Rec.SetBuyFromVendorFromFilter();
            Rec.SelectDefaultRemitAddress(Rec);
        end;
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        CurrPage.Update(false);
    end;

    trigger OnOpenPage()
    begin
        SetOpenPage();
        ActivateFields();
    end;

    var
        BuyFromContact: Record Contact;
        PayToContact: Record Contact;
        PurchasesPayablesSetup: Record "Purchases & Payables Setup";
        GeneralLedgerSetup: Record "General Ledger Setup";
        UserSetupManagement: Codeunit "User Setup Management";
        SSDTCManagement: Codeunit "SSD TC Management";
        StatusStyleTxt: Text;
        DocNoVisible: Boolean;
        VendorInvoiceNoMandatory: Boolean;
        IsPurchaseLinesEditable: Boolean;

    local procedure SetOpenPage()
    begin
        Rec.SetSecurityFilterOnRespCenter();
        Rec.SetRange("Date Filter", 0D, WorkDate());
    end;

    local procedure ActivateFields()
    begin
        GeneralLedgerSetup.Get();
        IsPurchaseLinesEditable := Rec.PurchaseLinesEditable();
    end;

    local procedure PostDocument(PostingCodeunitID: Integer)
    var
        LinesInstructionMgt: Codeunit "Lines Instruction Mgt.";
    begin
        LinesInstructionMgt.PurchaseCheckAllLinesHaveQuantityAssigned(Rec);
        Rec.SendToPosting(PostingCodeunitID);
        CurrPage.Update(false);
    end;

    local procedure SetExtDocNoMandatoryCondition()
    begin
        PurchasesPayablesSetup.GetRecordOnce();
        VendorInvoiceNoMandatory := PurchasesPayablesSetup."Ext. Doc. No. Mandatory";
    end;

    local procedure ShowOverReceiptNotification()
    var
        OverReceiptMgt: Codeunit "Over-Receipt Mgt.";
    begin
        OverReceiptMgt.ShowOverReceiptNotificationFromOrder(Rec."No.");
    end;
}
