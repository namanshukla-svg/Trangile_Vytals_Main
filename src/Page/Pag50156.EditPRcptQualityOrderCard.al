Page 50156 "Edit P.Rcpt Quality Order Card"
{
    Caption = 'Posted Quality Order Card';
    DeleteAllowed = false;
    Editable = true;
    InsertAllowed = false;
    ModifyAllowed = true;
    PageType = Document;
    SourceTable = "SSD Posted Quality Order Hdr";
    SourceTableView = sorting("Template Type")order(ascending)where("Template Type"=const(Receipt));
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
                    ApplicationArea = All;
                }
                field("Item No."; Rec."Item No.")
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field("Sampling Temp. No."; Rec."Sampling Temp. No.")
                {
                    ApplicationArea = All;
                }
                field("Kind of Sampling"; Rec."Kind of Sampling")
                {
                    ApplicationArea = All;
                }
                field("Sampling Method"; Rec."Sampling Method")
                {
                    ApplicationArea = All;
                }
                field("Percentage / Fixed Quantity"; Rec."Percentage / Fixed Quantity")
                {
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                }
                field("Is NABL Accredited"; Rec."Is NABL Accredited")
                {
                    ApplicationArea = All;
                }
                field("No of Archived Version"; Rec."No of Archived Version")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Description 2"; Rec."Description 2")
                {
                    ApplicationArea = All;
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = All;
                }
                field("Lot Size"; Rec."Lot Size")
                {
                    ApplicationArea = All;
                }
                field("Sample Size"; Rec."Sample Size")
                {
                    ApplicationArea = All;
                }
                field("Accepted Qty."; Rec."Accepted Qty.")
                {
                    ApplicationArea = All;
                }
                field("Rejected Qty."; Rec."Rejected Qty.")
                {
                    ApplicationArea = All;
                }
                field("Decision For Quality Pass"; Rec."Decision For Quality Pass")
                {
                    ApplicationArea = All;
                }
                field("Accepted Under Deviation"; Rec."Accepted Under Deviation")
                {
                    ApplicationArea = All;
                }
                field("No. Of Coil"; Rec."No. Of Coil")
                {
                    ApplicationArea = All;
                }
                field("ULR No."; Rec."ULR No.")
                {
                    ApplicationArea = All;
                }
                field("Total Qty. Sent For Inspection"; Rec."Total Qty. Sent For Inspection")
                {
                    ApplicationArea = All;
                }
                field("Minimum Value"; Rec."Minimum Value")
                {
                    ApplicationArea = All;
                }
                field("Maximum Value"; Rec."Maximum Value")
                {
                    ApplicationArea = All;
                }
                field("Inspection Value2"; Rec."Inspection Value2")
                {
                    ApplicationArea = All;
                }
            }
            part(SubForm; "Edit P. Rcpt. Q.Order Subform")
            {
                SubPageLink = "Document No."=field("No."), "Template Type"=field("Template Type");
                SubPageView = sorting("Document No.", "Line No.")order(ascending);
                ApplicationArea = All;
            }
            group(Source)
            {
                Caption = 'Source';

                field("Entry Source Type"; Rec."Entry Source Type")
                {
                    ApplicationArea = All;
                }
                field("Source Code"; Rec."Source Code")
                {
                    ApplicationArea = All;
                }
                field("Source Document No."; Rec."Source Document No.")
                {
                    ApplicationArea = All;
                }
                field("Source Doc. Line No."; Rec."Source Doc. Line No.")
                {
                    ApplicationArea = All;
                }
                field("Order No."; Rec."Order No.")
                {
                    ApplicationArea = All;
                }
                field(Remarks; Rec.Remarks)
                {
                    ApplicationArea = All;
                }
                field("External Document No."; Rec."External Document No.")
                {
                    ApplicationArea = All;
                }
                field("Location Code"; Rec."Location Code")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Bin Code"; Rec."Bin Code")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Routing No."; Rec."Routing No.")
                {
                    ApplicationArea = All;
                }
                field("Process/Operation No."; Rec."Process/Operation No.")
                {
                    ApplicationArea = All;
                }
                field("Lot No."; Rec."Lot No.")
                {
                    ApplicationArea = All;
                }
            }
            group("Other Information")
            {
                Caption = 'Other Information';

                field("Creation Date"; Rec."Creation Date")
                {
                    ApplicationArea = All;
                }
                field("Entry User"; Rec."Entry User")
                {
                    ApplicationArea = All;
                }
                field(Edition; Rec.Edition)
                {
                    ApplicationArea = All;
                }
                field(Review; Rec.Review)
                {
                    ApplicationArea = All;
                }
                field("Approved Date"; Rec."Approved Date")
                {
                    ApplicationArea = All;
                }
                field("Approved by"; Rec."Approved by")
                {
                    ApplicationArea = All;
                }
                field("Responsibility Center"; Rec."Responsibility Center")
                {
                    ApplicationArea = All;
                }
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                    ApplicationArea = All;
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                    ApplicationArea = All;
                }
                field("Defect Code"; Rec."Defect Code")
                {
                    ApplicationArea = All;
                }
                field("Concerted Quality"; Rec."Concerted Quality")
                {
                    ApplicationArea = All;
                }
                field("Vendor Claim Code"; Rec."Vendor Claim Code")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
    actions
    {
        area(navigation)
        {
            group("&Order")
            {
                Caption = '&Order';

                action(List)
                {
                    ApplicationArea = All;
                    Caption = 'List';
                    RunObject = Page "P. Quality Order for Approval";
                    RunPageView = where(Approved=const(false));
                    ShortCutKey = 'Shift+Ctrl+L';
                }
                separator(Action70)
                {
                Caption = '';
                }
                action(Comments)
                {
                    ApplicationArea = All;
                    Caption = 'Comments';
                    Image = ViewComments;

                    trigger OnAction()
                    begin
                        Rec.ShowComent;
                    end;
                }
                separator(Action1000000052)
                {
                }
                action("Sub Quality Orders")
                {
                    ApplicationArea = All;
                    Caption = 'Sub Quality Orders';
                    Visible = false;

                    trigger OnAction()
                    var
                        QualityOrderHeaderLocal: Record "SSD Posted Quality Order Hdr";
                        FrmQualityOrder: Page "Posted Quality Order List";
                    begin
                        Rec.TestField("Is Coil Type", true);
                        Rec.TestField("Template Type", Rec."template type"::Receipt);
                        QualityOrderHeaderLocal.Reset;
                        QualityOrderHeaderLocal.FilterGroup(0);
                        QualityOrderHeaderLocal.SetCurrentkey("Template Type", "Entry Source Type", "Order No.");
                        QualityOrderHeaderLocal.SetRange("Template Type", QualityOrderHeaderLocal."template type"::RcvdCoil);
                        QualityOrderHeaderLocal.SetRange("Entry Source Type", QualityOrderHeaderLocal."entry source type"::MRN);
                        QualityOrderHeaderLocal.SetRange("Order No.", Rec."No.");
                        QualityOrderHeaderLocal.FilterGroup(2);
                        Clear(FrmQualityOrder);
                        FrmQualityOrder.SetTableview(QualityOrderHeaderLocal);
                        FrmQualityOrder.RunModal;
                    end;
                }
                action("Reject Lot No. Information")
                {
                    ApplicationArea = All;
                    Caption = 'Reject Lot No. Information';
                    Visible = false;

                    trigger OnAction()
                    begin
                        Rec.RejectLotInform(Rec);
                    end;
                }
                separator(Action1000000069)
                {
                }
                action("Posted Purchase Receipts")
                {
                    ApplicationArea = All;
                    Caption = 'Posted Purchase Receipts';

                    trigger OnAction()
                    begin
                        Rec.ShowPostedPurchRcptLines(Rec);
                    end;
                }
                action("Posted Warehouse Receipts")
                {
                    ApplicationArea = All;
                    Caption = 'Posted Warehouse Receipts';

                    trigger OnAction()
                    begin
                        Rec.ShowPostedWhseRcptLines(Rec);
                    end;
                }
                action("View Component In Case of SubCon")
                {
                    ApplicationArea = All;
                    Caption = 'View Component In Case of SubCon';

                    trigger OnAction()
                    var
                        ItemLedgerEntry1: Record "Item Ledger Entry";
                        FormItemLedgerEntry1: Page "Item Ledger Entries";
                    begin
                        //<<****** ALLE[5.51]
                        ItemLedgerEntry1.Reset;
                        ItemLedgerEntry1.SetRange(ItemLedgerEntry1.Positive, false);
                        ItemLedgerEntry1.SetRange(ItemLedgerEntry1."Document No.", Rec."Order No.");
                        ItemLedgerEntry1.SetFilter(ItemLedgerEntry1."Lot No.", '<>%1', '');
                        if ItemLedgerEntry1.FindFirst then begin
                            Clear(FormItemLedgerEntry1);
                            FormItemLedgerEntry1.SetTableview(ItemLedgerEntry1);
                            FormItemLedgerEntry1.RunModal;
                        end;
                    //>>****** ALLE[5.51]
                    end;
                }
                action("Archive Quality Order")
                {
                    ApplicationArea = All;
                    Caption = 'Archive Quality Order';

                    trigger OnAction()
                    begin
                        if Confirm('Are you sure want to Archive the Quality Order', false, DlgCnfm) = true then begin
                            PostedQualityOrderHeaderAr.Reset;
                            PostedQualityOrderHeaderAr.SetRange(PostedQualityOrderHeaderAr."No.", Rec."No.");
                            if PostedQualityOrderHeaderAr.FindLast then Version:=PostedQualityOrderHeaderAr."Version No." + 1
                            else
                                Version:=1;
                            PostedQualityOrderHeaderAr.Init;
                            PostedQualityOrderHeaderAr.TransferFields(Rec);
                            PostedQualityOrderHeaderAr."Version No.":=Version;
                            PostedQualityOrderHeaderAr."Archived By":=UserId;
                            PostedQualityOrderHeaderAr."Archived Date":=Today;
                            PostedQualityOrderHeaderAr.Insert;
                            PostedQualityOrderLine.Reset;
                            PostedQualityOrderLine.SetRange(PostedQualityOrderLine."Document No.", Rec."No.");
                            if PostedQualityOrderLine.FindFirst then repeat PostedQualityOrderLineAr.Init;
                                    PostedQualityOrderLineAr.TransferFields(PostedQualityOrderLine);
                                    PostedQualityOrderLineAr."Version No.":=Version;
                                    PostedQualityOrderLineAr.Insert;
                                until PostedQualityOrderLine.Next = 0;
                            Message('Quality Order %1 has been Archived', Rec."No.");
                        end;
                    end;
                }
            }
        }
        area(processing)
        {
            action("&Print")
            {
                ApplicationArea = All;
                Caption = '&Print';
                Image = Print;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    CurrPage.SetSelectionFilter(QualityOrderHeaderLocal);
                    if QualityOrderHeaderLocal.Find('-')then Report.RunModal(Report::"Incoming Material Analysis", true, false, QualityOrderHeaderLocal);
                end;
            }
        }
    }
    trigger OnOpenPage()
    begin
        // if UserMgt.GetRespCenterFilter() <> '' then begin
        //     Rec.FilterGroup(2);
        //     Rec.SetRange("Responsibility Center", UserMgt.GetRespCenterFilter);
        //     Rec.FilterGroup(0);
        // end;
        Rec.FilterGroup(2);
        if Rec.GetFilter("Template Type") <> '' then CurrPage.Caption:=Rec.GetFilter("Template Type") + '-' + CurrPage.Caption;
        Rec.FilterGroup(0);
    end;
    trigger OnQueryClosePage(CloseAction: action): Boolean var
        bol2: Boolean;
        PostedQualityOrderLine: Record "SSD Posted Quality Order Line";
        Found: Boolean;
    begin
        Found:=false;
        PostedQualityOrderLine.Reset;
        PostedQualityOrderLine.SetRange(PostedQualityOrderLine."Document No.", Rec."No.");
        PostedQualityOrderLine.SetRange("Template Type", Rec."Template Type");
        if PostedQualityOrderLine.FindSet then repeat if PostedQualityOrderLine."Inspection Value2" < PostedQualityOrderLine."Minimum Value" then Found:=true;
                if PostedQualityOrderLine."Maximum Value" <> 0 then if PostedQualityOrderLine."Inspection Value2" > PostedQualityOrderLine."Maximum Value" then Found:=true;
            until PostedQualityOrderLine.Next = 0;
        if Found then if Confirm('Average Value is less than or greater than Min Value or Max Value.Do you want to continue', false, bol2)then exit
            else
                Error('');
    end;
    var UserMgt: Codeunit "SSD User Setup Management";
    QualityOrderHeaderLocal: Record "SSD Posted Quality Order Hdr";
    PostedQualityOrderHeaderAr: Record "SSD Posted Quality Ord Hdr Ar";
    PostedQualityOrderLine: Record "SSD Posted Quality Order Line";
    Version: Integer;
    PostedQualityOrderLineAr: Record "SSD Posted Quality OrdLine Ar";
    DlgCnfm: Boolean;
}
