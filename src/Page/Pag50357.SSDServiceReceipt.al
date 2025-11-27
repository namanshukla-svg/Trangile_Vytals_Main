page 50357 "SSD Service Receipt"
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
                field("Confirmation Pending"; Rec."Confirmation Pending")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Confirmation Pending field.';
                }
                field("SRN Approval Status"; Rec."SRN Approval Status")
                {
                    ApplicationArea = all;
                    Visible = true; //SRN-IG-20250903-0002
                }
                field("SRN Approval Pending UserID"; Rec."SRN Approval Pending UserID")
                {
                    ApplicationArea = all;
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

                action(Generate)
                {
                    ApplicationArea = All;
                    Caption = 'Generate CheckList';
                    Ellipsis = true;
                    Image = GetEntries;
                    ToolTip = 'Executes the Generate CheckList action.';

                    trigger OnAction()
                    begin
                        SSDTCManagement.GenerateCheckList(Rec);
                    end;
                }
                action(UpdateChecklist)
                {
                    ApplicationArea = All;
                    Caption = 'Fill Checklist';
                    Ellipsis = true;
                    Image = DocumentEdit;
                    ToolTip = 'Executes the Fill Checklist action.';
                    RunObject = Page "SSD PO Checklist";
                    RunPageLink = "Document Type" = field("Document Type"), "Document No." = field("No.");
                }
            }
            group(Approval)
            {
                Caption = 'Approval';
                Image = Approval;
                Visible = true; //SRN-IG-20250903-0002
                action(SendForApproval)
                {
                    ApplicationArea = All;
                    Caption = 'Send for Approval';
                    Image = SendApprovalRequest;
                    trigger OnAction()
                    var
                        SSDPurchaseSubscribers: Codeunit "SSD Purchase Subscribers";
                        UserSetup: Record "User Setup";
                        DimFilter: Text;
                    begin
                        //IG_DS SSDPurchaseSubscribers.SendSRNApproval(Rec);
                        if not Confirm('Do you want to send approval for document %1?', false, Rec."No.") then
                            exit;
                        Rec.TestField("SRN Approval Status", Rec."SRN Approval Status"::Open);
                        Rec.TestField("Vendor Invoice No.");
                        Rec.TestField("Vendor Invoice Date");
                        Rec.TestField("Invoice Amount");
                        Rec.TestField("Posting Date");
                        Rec.TestField("Shortcut Dimension 1 Code");
                        if Rec."SRN Approval Status" = Rec."SRN Approval Status"::Open then begin
                            Rec."SRN Approval Status" := Rec."SRN Approval Status"::"Pending For Approval";
                            //IG_DS_Before   if UserSetup.get(UserId) then
                            //     Rec."SRN Approval Pending UserID" := UserSetup."SSD SRN Approver";
                            // Rec.Modify(true);
                            SetApproverFromUserSetup();
                            Message('SRN sent for approval');
                        end;

                    end;
                }
                action(Reopen)
                {
                    ApplicationArea = All;
                    Caption = 'Reopen';
                    Image = ReOpen;
                    trigger OnAction()
                    var
                        SSDPurchaseSubscribers: Codeunit "SSD Purchase Subscribers";
                    begin
                        //IG_DS SSDPurchaseSubscribers.SendSRNApproval(Rec);
                        if not Confirm('Do you want to reopen document %1?', false, Rec."No.") then
                            exit;

                        if (Rec."SRN Approval Status" = Rec."SRN Approval Status"::Open) then
                            Message('Document %1 is already open.', Rec."No.");

                        if (Rec."SRN Approval Status" = Rec."SRN Approval Status"::"Pending For Approval") or ((Rec."SRN Approval Status" = Rec."SRN Approval Status"::Released)) then begin
                            Rec."SRN Approval Status" := Rec."SRN Approval Status"::Open;
                            Rec."SRN Approval Pending UserID" := '';
                            Rec.Modify(true);
                            CurrPage.Update();
                            Message('Document %1 has been reopened successfully.', Rec."No.");
                        end;

                    end;
                }
            }
            group("P&osting")
            {
                Caption = 'P&osting';
                Image = Post;

                action(Post)
                {
                    ApplicationArea = Suite;
                    Caption = 'P&ost';
                    Ellipsis = true;
                    Image = PostOrder;
                    //Visible = false;
                    //ShortCutKey = 'F9';
                    ToolTip = 'Finalize the document or journal by posting the amounts and quantities to the related accounts in your company books.';

                    trigger OnAction()
                    begin
                        if not Confirm('Do you want to post document %1?', false, Rec."No.") then  //SRN-IG-20250903-0002            
                            exit;
                        Rec.TestField("SRN Approval Status", Rec."SRN Approval Status"::Released);
                        PostDocument(CODEUNIT::"SSD Purchase Post");
                        //IG_DS Code moved to 55101 codeunit               // Rec."SRN Approval Status" := Rec."SRN Approval Status"::Open; //SRN-IG-20250903-0002  
                        // Rec.Modify();
                    end;
                }
            }
        }
        area(Promoted)
        {
            group(Category_Process)
            {
                Caption = 'Process', Comment = 'Generated from the PromotedActionCategories property index 1.';

                group(Category_Category6)
                {
                    Caption = 'Post', Comment = 'Generated from the PromotedActionCategories property index 5.';
                    ShowAs = SplitButton;

                    actionref(Post_Promoted; Post)
                    {
                    }
                }
            }
        }
    }

    procedure SetApproverFromUserSetup()
    var
        UserSetup: Record "User Setup";
        IndentValues: List of [Text];
        SingleValue: Text;
        FoundMatch: Boolean;
    begin
        FoundMatch := false;

        UserSetup.Reset();
        UserSetup.SetFilter("SSD SRN Approver", '<>%1', '');   // SRN Approver must not be blank

        if UserSetup.FindSet() then
            repeat
                // Split Indent Cost Center Code (EX: 24000|26000|22000)
                IndentValues := SplitText(UserSetup."Indent Costcen Code", '|');

                foreach SingleValue in IndentValues do begin
                    if Format(Rec."Shortcut Dimension 1 Code") = SingleValue then begin
                        Rec."SRN Approval Pending UserID" := UserSetup."SSD SRN Approver";
                        FoundMatch := true;
                        exit; // Stop loop when found
                    end;
                end;

            until UserSetup.Next() = 0;

        if not FoundMatch then
            Error(
                'No matching approver found for Shortcut Dimension 1 Code %1.',
                Rec."Shortcut Dimension 1 Code"
            );

        Rec.Modify();
    end;

    procedure SplitText(InputText: Text; Delimiter: Text): List of [Text]
    var
        Result: List of [Text];
        StartPos: Integer;
        DelPos: Integer;
        Part: Text;
    begin
        StartPos := 1;

        repeat
            DelPos := StrPos(CopyStr(InputText, StartPos), Delimiter);

            if DelPos > 0 then begin
                Part := CopyStr(InputText, StartPos, DelPos - 1);
                Result.Add(Part);

                StartPos := StartPos + DelPos;  // Move next
            end else begin
                // Last value
                Part := CopyStr(InputText, StartPos);
                if Part <> '' then
                    Result.Add(Part);
                exit(Result);
            end;

        until false;

        exit(Result);
    end;

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
