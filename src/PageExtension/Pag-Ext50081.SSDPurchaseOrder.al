PageExtension 50081 "SSD Purchase Order" extends "Purchase Order"
{
    layout
    {
        modify("VAT Reporting Date")
        {
            Visible = false;
        }
        modify("No.")
        {
            Visible = true;
        }
        modify("Vendor Invoice No.")
        {
            Visible = false;
        }
        modify("Invoice Received Date")
        {
            Visible = false;
        }
        modify("Vendor Shipment No.")
        {
            Visible = false;
        }
        modify("Payment Terms Code")
        {
            Editable = false;
        }
        modify("Prepmt. Payment Terms Code")
        {
            Editable = false;
        }
        addafter("No.")
        {
            field("SSD Order Type"; Rec."SSD Order Type")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Order Type field.';
            }
        }
        addafter("Posting Date")
        {
            field("Valid From"; Rec."Valid From")
            {
                ApplicationArea = All;
                ShowMandatory = true;
                ToolTip = 'Specifies the value of the Valid From field.';
            }
            field("Valid To"; Rec."Valid To")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Valid To field.';
            }
            field(Insurance; Rec.Insurance)
            {
                ApplicationArea = All;
            }
        }
        addbefore(Status)
        {
            field("SSD TC Code"; Rec."SSD TC Code")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the TC Code field.';
            }
            field("Price Match/Mismatch"; Rec."Price Match/Mismatch")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Price Match/Mismatch field.';
                Editable = false;
            }
        }
        addafter(Status)
        {
            field("Date Sent"; Rec."Date Sent")
            {
                ApplicationArea = All;
                Visible = false;
            }
            field("Order Created from MRP"; Rec."Order Created from MRP")
            {
                ApplicationArea = All;
                Editable = false;
            }
            field("Order Created from Indent"; Rec."Order Created from Indent")
            {
                ApplicationArea = All;
            }
            field("PO Mail Send"; Rec."PO Mail Send")
            {
                ApplicationArea = All;
                Editable = false;
            }
            // field("Type of Invoice"; Rec."Type of Invoice") //ANI::251125
            // {
            //     ApplicationArea = All;
            //     ToolTip = 'Specifies the value of the Type of Invoice field.';
            // }
            field("SSD SPO Subject"; Rec."SSD SPO Subject")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the SPO Subject field.';
            }
            field("PO Email"; Rec."PO Email")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the PO Email field.';
            }
            field("SSD Exclude Mail"; Rec."SSD Exclude Mail")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Exclude from Mail Alert field.';
            }
            field("SSD Exclude SPO Confirmation"; Rec."SSD Exclude SPO Confirmation")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Exclude SPO Confirmation field.';
            }
            field("Confirmation Pending"; Rec."Confirmation Pending")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Confirmation Pending field.';
            }
        }
        addlast(Prepayment)
        {
            usercontrol(pdf; PDF)
            {
                ApplicationArea = all;

                trigger DownloadPDF(pdfToNav: text)
                var
                    DocumentAttachment: Record "Document Attachment";
                    PurchHeader: Record "Purchase Header";
                    TempBlob: Codeunit "Temp Blob";
                    Convert64: Codeunit "Base64 Convert";
                    FileManagement: Codeunit "File Management";
                    Ins: InStream;
                    Outs: OutStream;
                    Filename: Text;
                    SSDRecordRef: RecordRef;
                    FileNameTxt: Label 'SPO_%1_Annexure.pdf';
                begin
                    if pdfToNav <> '' then begin
                        Filename := StrSubstNo(FileNameTxt, Rec."No.");
                        TempBlob.CreateInStream(Ins);
                        TempBlob.CreateOutStream(Outs);
                        Convert64.FromBase64(pdfToNav, Outs);
                        DocumentAttachment.Init;
                        DocumentAttachment.Validate("Document Type", DocumentAttachment."Document Type"::Order);
                        DocumentAttachment.Validate("No.", Rec."No.");
                        DocumentAttachment.Validate("Table ID", Database::"Purchase Header");
                        DocumentAttachment.Validate("File Extension", FileManagement.GetExtension(FileName));
                        DocumentAttachment.Validate("File Name", CopyStr(FileManagement.GetFileNameWithoutExtension(FileName), 1, MaxStrLen(DocumentAttachment."File Name")));
                        DocumentAttachment."Document Reference ID".ImportStream(Ins, Filename);
                        DocumentAttachment."Merged Attachment" := true;
                        if DocumentAttachment.Insert(true) then
                            Message('Merged File inserted in Attachment')
                        else
                            Message('No Attach');
                    end;
                end;
            }
        }
        addafter("Area")
        {
            field("Invoice Value(Import)"; Rec."Invoice Value(Import)")
            {
                ApplicationArea = All;

                trigger OnValidate()
                begin
                    InvoiceValueImportOnAfterValid;
                end;
            }
            field("Insurance Value(Import)"; Rec."Insurance Value(Import)")
            {
                ApplicationArea = All;

                trigger OnValidate()
                begin
                    InsuranceValueImportOnAfterVal;
                end;
            }
            field("Insurance Value(Import) Type"; Rec."Insurance Value(Import) Type")
            {
                ApplicationArea = All;

                trigger OnValidate()
                begin
                    InsuranceValueImportTypeOnAfte;
                end;
            }
            field("Freight Value(Import)"; Rec."Freight Value(Import)")
            {
                ApplicationArea = All;

                trigger OnValidate()
                begin
                    FreightValueImportOnAfterValid;
                end;
            }
            field("Misc Charges(Import)"; Rec."Misc Charges(Import)")
            {
                ApplicationArea = All;

                trigger OnValidate()
                begin
                    MiscChargesImportOnAfterValida;
                end;
            }
            field("Landing Charges(Import)"; Rec."Landing Charges(Import)")
            {
                ApplicationArea = All;

                trigger OnValidate()
                begin
                    LandingChargesImportOnAfterVal;
                end;
            }
        }
        addafter("Vendor Cr. Memo No.")
        {
            field("Advance Payment Amount"; Rec."Advance Payment Amount")
            {
                ApplicationArea = All;
            }
        }
        addlast("Invoice Details")
        {
            field("SSD Service Grace Period"; Rec."SSD Service Grace Period")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Service Grace Period field.';
            }
        }
        modify("Transport Method")
        {
            Visible = true;
        }
        moveafter("Remit-to Code"; "Shipment Method Code")
        moveafter("Shipment Method Code"; "Transport Method")
        movebefore("Buy-from Vendor No."; "No.")

    }
    actions
    {
        //SSDU
        modify(Post)
        {
            Visible = false;
        }
        modify("Post &Batch")
        {
            Visible = false;
        }
        modify("Post and &Print")
        {
            Visible = false;
        }
        // modify("Post &Batch_Promoted")
        // {
        //     Visible = false;
        // }
        // modify("Post and &Print_Promoted")
        // {
        //     Visible = false;
        // }
        modify("Post and Print Prepmt. Cr. Mem&o")
        {
            Visible = false;
        }
        modify("Post and Print Prepmt. Invoic&e")
        {
            Visible = false;
        }
        // modify(Post_Promoted)
        // {
        //     Visible = false;
        // }
        modify(PostAndNew)
        {
            Visible = false;
        }
        // modify(PostAndNew_Promoted)
        // {
        //     Visible = false;
        // }
        //SSDU
        addafter("&Print")
        {
            action(PrintSPO)
            {
                ApplicationArea = All;
                Caption = 'Print Service Order';
                Image = PrintDocument;
                Ellipsis = true;

                trigger OnAction()
                var
                    PurchaseHeader: Record "Purchase Header";
                begin
                    PurchaseHeader := Rec;
                    CurrPage.SetSelectionFilter(PurchaseHeader);
                    Report.Run(Report::"Service Order Report", true, false, PurchaseHeader);
                end;
            }
        }
        addafter("Speci&al Order")
        {
            group("&Line")
            {
                Caption = '&Line';

                separator(Action192)
                {
                }
                action("Short Close")
                {
                    ApplicationArea = All;
                    Caption = 'Short Close';
                    Visible = false;
                    Promoted = true;
                    PromotedIsBig = true;
                    PromotedCategory = Process;

                    trigger OnAction()
                    begin
                        if Confirm('Are you sure, you want to short close the selected Purchase Line?') then begin
                            CurrPage.PurchLines.Page.ShortClose;
                            Message('Selected Purchase Line has been short closed successfully');
                        end;
                    end;
                }
                separator(Action1102152005)
                {
                }
                action("Indent Lines")
                {
                    ApplicationArea = All;
                    Caption = 'Requisition Lines';
                    Promoted = true;
                    PromotedIsBig = true;
                    PromotedCategory = Process;

                    trigger OnAction()
                    var
                        FrmPostedIndPurchLines: Page "Posted Req. Purch. Lines";
                    begin
                        CurrPage.PurchLines.Page.ShowRequisitionLinesForm;
                    end;
                }
                //SSDU
                action("Copy From Requisition Line")
                {
                    ApplicationArea = All;
                    Caption = 'Copy From Requisition Line';
                    Promoted = true;
                    PromotedIsBig = true;
                    PromotedCategory = Process;

                    trigger OnAction()
                    var
                        FrmPostedIndPurchLines: Page "Posted Req. Purch. Lines";
                        FrmPostedReqLines: page "Posted Req. Lines Pending PO-F";
                    begin
                        FrmPostedReqLines.LOOKUPMODE(TRUE);
                        FrmPostedReqLines.SetPurchaseHeader(Rec);
                        FrmPostedReqLines.RUNMODAL;

                        CopyIndentAttachments();
                    end;
                }
                //SSDU
                action("Close PO")
                {
                    ApplicationArea = All;
                    Promoted = true;
                    PromotedIsBig = true;
                    PromotedCategory = Process;
                    Caption = 'Close PO';

                    trigger OnAction()
                    begin
                        if Rec."Close PO" then Error('PO has been Already Closed');
                        if UserSetup.Get(UserId) and (UserSetup."Close PO") then begin
                            POcancel := false;
                            PurchaseHeader.Reset;
                            PurchaseHeader.SetRange("No.", Rec."No.");
                            PurchaseHeader.SetRange(Status, Rec.Status::Open);
                            if PurchaseHeader.FindFirst then begin
                                PurchaseLine.Reset;
                                PurchaseLine.SetRange("Document No.", PurchaseHeader."No.");
                                if PurchaseLine.FindFirst then begin
                                    repeat
                                        if (PurchaseLine."Quantity Received" = 0) then
                                            POcancel := true
                                        else
                                            POcancel := false;
                                    until PurchaseLine.Next = 0;
                                end
                                else begin
                                    POcancel := true
                                end;
                                if POcancel then begin
                                    PurchaseHeader.Validate("Close PO", true);
                                    PurchaseHeader.Modify();
                                    Message('PO %1 has been Closed', PurchaseHeader."No.");
                                end
                                else begin
                                    Error('You Cannot close this PO as GRN has been done against this PO. You can only Short close this PO.');
                                end;
                            end;
                        end;
                    end;
                }
                // action(ActionName)
                // {
                //     ApplicationArea = All;
                //     Caption = 'Approval Request Entries';
                //     Promoted = true;
                //     PromotedCategory = Process;
                //     PromotedIsBig = true;
                //     Image = Image;
                //     trigger OnAction()
                //     var
                //         ApprovalEntry: Record "Approval Entry";
                //         ApprovalEntries: page 50111;
                //     begin
                //         ApprovalEntry.RESET;
                //         ApprovalEntry.SETRANGE("Document Type", rec."Document Type");
                //         ApprovalEntry.SETRANGE("Document No.", rec."No.");
                //         IF ApprovalEntry.FINDSET THEN BEGIN
                //             ApprovalEntries.SETTABLEVIEW(ApprovalEntry);
                //             ApprovalEntries.LOOKUPMODE := TRUE;
                //             IF ApprovalEntries.RUNMODAL <> ACTION::Cancel THEN;
                //         END;
                //     end;
                // }
                action(MergePDF)
                {
                    ApplicationArea = All;
                    Caption = 'MergePDF';
                    Promoted = true;
                    PromotedIsBig = true;
                    PromotedCategory = Process;
                    Image = MakeAgreement;

                    trigger OnAction()
                    begin
                        SSDMergePDF();
                    end;
                }
            }
        }
        addafter(Receipts)
        {
            action(TC)
            {
                Caption = 'Terms & Conditions';
                ApplicationArea = All;
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Process;
                Image = Action;
                RunObject = Page "SSD PO Terms";
                RunPageLink = "Document Type" = field("Document Type"), "Document No." = field("No."), "TC Code" = field("SSD TC Code");
                ToolTip = 'Executes the Terms & Conditions action.';
            }
        }
    }
    var
        UserSetup: Record "User Setup";
        PurchaseHeader: Record "Purchase Header";
        PurchaseLine: Record "Purchase Line";
        DocumentAttachment: Record "Document Attachment";
        SSDTempBlob: Codeunit "Temp Blob";
        PDFMerge: Codeunit "SSD PDF Merge";
        POcancel: Boolean;
        SSDJsonArray: JsonArray;
        Base64Convert: Codeunit "Base64 Convert";
        SSDOutStream: OutStream;
        SSDInstream: InStream;
        SSDBase64String: Text;

    trigger OnDeleteRecord(): Boolean
    begin
        UserSetup.Get(UserId);
        if not UserSetup."SSD Delete Administrator" then Error('You are not authorise to delete this record');
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec."Document Subtype" := Rec."Document Subtype"::Order;
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        Rec."Document Subtype" := Rec."Document Subtype"::Order;
    end;

    local procedure InvoiceValueImportOnAfterValid()
    begin
        CurrPage.Update;
    end;

    local procedure FreightValueImportOnAfterValid()
    begin
        CurrPage.Update;
    end;

    local procedure InsuranceValueImportOnAfterVal()
    begin
        CurrPage.Update;
    end;

    local procedure MiscChargesImportOnAfterValida()
    begin
        CurrPage.Update;
    end;

    local procedure LandingChargesImportOnAfterVal()
    begin
        CurrPage.Update;
    end;

    local procedure InsuranceValueImportTypeOnAfte()
    begin
        CurrPage.Update;
    end;
    /// <summary>
    /// SSDMergePDF.
    /// </summary>
    procedure SSDMergePDF()
    var
        PurchHeader: Record "Purchase Header";
        SSDRecordRef: RecordRef;
    begin
        DocumentAttachment.Reset();
        DocumentAttachment.SetRange("Table ID", Database::"Purchase Header");
        DocumentAttachment.SetRange("Document Type", Rec."Document Type");
        DocumentAttachment.SetRange("No.", Rec."No.");
        DocumentAttachment.SetRange("Merged Attachment", true);
        DocumentAttachment.SetRange("File Type", DocumentAttachment."File Type"::PDF);
        if DocumentAttachment.FindFirst() then DocumentAttachment.Delete();
        clear(PDFMerge);
        DocumentAttachment.Reset();
        DocumentAttachment.SetRange("Table ID", Database::"Purchase Header");
        DocumentAttachment.SetRange("Document Type", Rec."Document Type");
        DocumentAttachment.SetRange("No.", Rec."No.");
        DocumentAttachment.SetRange("SSD Is Annexure", true);
        DocumentAttachment.SetRange("File Type", DocumentAttachment."File Type"::PDF);
        if DocumentAttachment.FindSet() then begin
            PurchHeader.SetRange("Document Type", Rec."Document Type");
            PurchHeader.SetRange("No.", Rec."No.");
            if PurchHeader.FindFirst() then PurchHeader.Status := PurchaseHeader.Status::Released;
            SSDRecordRef.GetTable(PurchHeader);
            PDFMerge.AddReportToMerge(Report::"Service Order Attachment", SSDRecordRef);
            repeat
                Clear(SSDTempBlob);
                Clear(SSDBase64String);
                Clear(SSDInstream);
                Clear(SSDOutStream);
                Clear(SSDJsonArray);
                SSDTempBlob.CreateOutStream(SSDOutStream);
                DocumentAttachment."Document Reference ID".ExportStream(SSDOutStream);
                SSDTempBlob.CreateInStream(SSDInstream);
                SSDBase64String := Base64Convert.ToBase64(SSDInstream);
                PDFMerge.AddBase64pdf(SSDBase64String);
            until DocumentAttachment.Next() = 0;
        end
        else
            error('PDF File does not exists to merge');
        SSDJsonArray := PDFMerge.GetJArray();
        CurrPage.pdf.MergePDF(Format(SSDJsonArray));
    end;

    local procedure CopyIndentAttachments();
    var
        FromDocumentAttachment: Record "Document Attachment";
        ToDocumentAttachment: Record "Document Attachment";
        PostedIndentHeader: Record "SSD Posted Indent Header";
        PurchaseLine: Record "Purchase Line";
    begin
        FromDocumentAttachment.SetRange("Table ID", Database::"SSD Posted Indent Header");
        if FromDocumentAttachment.IsEmpty() then
            exit;

        PurchaseLine.Reset();
        PurchaseLine.SetRange("Document Type", Rec."Document Type");
        PurchaseLine.SetRange("Document No.", Rec."No.");
        PurchaseLine.SetFilter("Indent No.", '<>%1', '');
        if PurchaseLine.FindFirst() then begin
            PostedIndentHeader.Reset();
            PostedIndentHeader.SetRange("No.", PurchaseLine."Posted Indent No.");
            if PostedIndentHeader.FindFirst() then begin
                FromDocumentAttachment.SetRange("No.", PostedIndentHeader."No.");
                if FromDocumentAttachment.FindSet() then
                    repeat
                        Clear(ToDocumentAttachment);
                        ToDocumentAttachment.Init();
                        ToDocumentAttachment.TransferFields(FromDocumentAttachment);
                        ToDocumentAttachment.Validate("Table ID", Database::"Purchase Header");
                        ToDocumentAttachment.Validate("No.", Rec."No.");
                        ToDocumentAttachment.Validate("Document Type", Enum::"Attachment Document Type"::Order);
                        if not ToDocumentAttachment.Insert(true) then;
                        ToDocumentAttachment."Attached Date" := FromDocumentAttachment."Attached Date";
                        ToDocumentAttachment.Modify();
                    until FromDocumentAttachment.Next() = 0;
            end;
        end;
    end;

}
