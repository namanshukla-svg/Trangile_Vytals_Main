Page 50161 "Arch P.Rcpt Quality Order Card"
{
    Caption = 'Arch P.Rcpt Quality Order Card';
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = Document;
    SourceTable = "SSD Posted Quality Ord Hdr Ar";
    SourceTableView = sorting("No.", "Version No.")order(ascending)where("Template Type"=const(Receipt));
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
                field("Total Qty. Sent For Inspection"; Rec."Total Qty. Sent For Inspection")
                {
                    ApplicationArea = All;
                }
            }
            part(SubForm; "Arch P. Rcpt. Q.Order Subform")
            {
                SubPageLink = "Document No."=field("No."), "Template Type"=field("Template Type");
                SubPageView = sorting("Document No.", "Version No.", "Line No.")order(ascending);
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
                    RunObject = Page "Archived P. Quality Order";
                    RunPageLink = "Template Type"=field("Template Type");
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
                    Visible = false;

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
                separator(Action1000000069)
                {
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
                    //CurrForm.SETSELECTIONFILTER(QualityOrderHeaderLocal);
                    QualityOrderHeaderLocal.SetRange(QualityOrderHeaderLocal."No.", Rec."No.");
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
    var ItemsReclass: Record "SSD Items Reclassification";
    UserMgt: Codeunit "SSD User Setup Management";
    QualityOrderHeaderLocal: Record "SSD Posted Quality Order Hdr";
    PostedQualityOrderHeaderAr: Record "SSD Posted Quality Ord Hdr Ar";
    PostedQualityOrderLine: Record "SSD Posted Quality Order Line";
    Version: Integer;
    PostedQualityOrderLineAr: Record "SSD Posted Quality OrdLine Ar";
    DlgCnfm: Boolean;
}
