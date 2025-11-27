Page 50261 "Posted Man. Q.Order List"
{
    ApplicationArea = All;
    Caption = 'Posted Manufacturing Q.Order Card';
    CardPageID = "Posted Man. Q.Order Card";
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = "SSD Posted Quality Order Hdr";
    SourceTableView = sorting("Template Type")order(ascending)where("Template Type"=const(Manufacturing));
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                Caption = 'General';

                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                }
                field("Process / Operation Code"; Rec."Process / Operation Code")
                {
                    ApplicationArea = All;
                    Caption = '<Process / Operation >';
                }
                field("Process / Operation"; Rec."Process / Operation")
                {
                    ApplicationArea = All;
                }
                field("Process/Operation No."; Rec."Process/Operation No.")
                {
                    ApplicationArea = All;
                }
                field("W.C. / M.C. No."; Rec."W.C. / M.C. No.")
                {
                    ApplicationArea = All;
                    Caption = 'Machine/Equipment';
                    Editable = false;
                }
                field("Item No."; Rec."Item No.")
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field("Description 2"; Rec."Description 2")
                {
                    ApplicationArea = All;
                }
                field("Source Code"; Rec."Source Code")
                {
                    ApplicationArea = All;
                    Caption = 'Work Order No.';
                }
                field("Source Doc Date"; Rec."Source Doc Date")
                {
                    ApplicationArea = All;
                    Caption = 'Work Order Date';
                    Editable = false;
                }
                field("Sampling Temp. No."; Rec."Sampling Temp. No.")
                {
                    ApplicationArea = All;
                }
                field("Lot No."; Rec."Lot No.")
                {
                    ApplicationArea = All;
                }
                field("Lot Size"; Rec."Lot Size")
                {
                    ApplicationArea = All;
                }
                field("Total Qty. Sent For Inspection"; Rec."Total Qty. Sent For Inspection")
                {
                    ApplicationArea = All;
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = All;
                }
                field("Time of Creation"; Rec."Time of Creation")
                {
                    ApplicationArea = All;
                }
                field("Time Of Posting"; Rec."Time Of Posting")
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
                field("ULR No."; Rec."ULR No.")
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
                separator(Action1000000051)
                {
                }
                action("Sub Quality Orders")
                {
                    ApplicationArea = All;
                    Caption = 'Sub Quality Orders';

                    trigger OnAction()
                    var
                        QualityOrderHeaderLocal: Record "SSD Posted Quality Order Hdr";
                        FrmQualityOrder: Page "Posted Quality Order List";
                    begin
                        QualityOrderHeaderLocal.Reset;
                        QualityOrderHeaderLocal.FilterGroup(0);
                        QualityOrderHeaderLocal.SetCurrentkey("Template Type", "Entry Source Type", "Order No.");
                        QualityOrderHeaderLocal.SetRange("Template Type", QualityOrderHeaderLocal."template type"::Routing);
                        QualityOrderHeaderLocal.SetRange("Entry Source Type", QualityOrderHeaderLocal."entry source type"::"Manufac.");
                        QualityOrderHeaderLocal.SetRange("Order No.", Rec."No.");
                        QualityOrderHeaderLocal.FilterGroup(2);
                        Clear(FrmQualityOrder);
                        FrmQualityOrder.SetTableview(QualityOrderHeaderLocal);
                        FrmQualityOrder.RunModal;
                    end;
                }
                action("View QLT Certificate of RM")
                {
                    ApplicationArea = All;
                    Caption = 'View QLT Certificate of RM';

                    trigger OnAction()
                    var
                        ItemLedgerEntry1: Record "Item Ledger Entry";
                        IncommingQLTCertificate: Report "Incoming Material Analysis";
                        PostedQltOrderHdr: Record "SSD Posted Quality Order Hdr";
                    begin
                        ItemLedgerEntry1.Reset;
                        ItemLedgerEntry1.SetCurrentkey("Document No.", "Document Type", "Document Line No.");
                        ItemLedgerEntry1.SetRange(ItemLedgerEntry1."Entry Type", ItemLedgerEntry1."entry type"::Consumption);
                        ItemLedgerEntry1.SetRange(ItemLedgerEntry1."Document No.", Rec."Source Code");
                        ItemLedgerEntry1.SetFilter(ItemLedgerEntry1."Lot No.", '<>%1', '');
                        if ItemLedgerEntry1.FindFirst then repeat Clear(IncommingQLTCertificate);
                                PostedQltOrderHdr.Reset;
                                PostedQltOrderHdr.SetRange(PostedQltOrderHdr."Lot No.", ItemLedgerEntry1."Lot No.");
                                IncommingQLTCertificate.SetTableview(PostedQltOrderHdr);
                                IncommingQLTCertificate.RunModal;
                            until ItemLedgerEntry1.Next = 0;
                    end;
                }
                action("View Component")
                {
                    ApplicationArea = All;
                    Caption = 'View Component';

                    trigger OnAction()
                    var
                        ProdOrderComponents: Record "Prod. Order Component";
                        FrmProdComponent: Page "Prod. Order Components";
                    begin
                        //<<<< ALLE[5.51]
                        Clear(ProdOrderComponents);
                        ProdOrderComponents.Reset;
                        ProdOrderComponents.SetRange(ProdOrderComponents."Prod. Order No.", Rec."Source Code");
                        //FrmProdComponent.MakeNonEditable(TRUE); // BIS 1145
                        FrmProdComponent.SetTableview(ProdOrderComponents);
                        FrmProdComponent.RunModal;
                    //>>> ALLE[5.51]
                    end;
                }
                action("View Posted Quality Order Card of Component")
                {
                    ApplicationArea = All;
                    Caption = 'View Posted Quality Order Card of Component';

                    trigger OnAction()
                    var
                        ItemLedgerEntry1: Record "Item Ledger Entry";
                        FormItemLedgerEntry1: Page "Item Ledger Entries";
                    begin
                        //<<****** ALLE[5.51]
                        ItemLedgerEntry1.Reset;
                        ItemLedgerEntry1.SetRange(ItemLedgerEntry1.Positive, false);
                        ItemLedgerEntry1.SetRange(ItemLedgerEntry1."Document No.", Rec."Source Document No.");
                        ItemLedgerEntry1.SetFilter(ItemLedgerEntry1."Lot No.", '<>%1', '');
                        if ItemLedgerEntry1.FindFirst then begin
                            Clear(FormItemLedgerEntry1);
                            FormItemLedgerEntry1.SetTableview(ItemLedgerEntry1);
                            FormItemLedgerEntry1.RunModal;
                        end;
                    //>>****** ALLE[5.51]
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
                var
                    PQualityOrderHeaderLocal: Record "SSD Posted Quality Order Hdr";
                begin
                    CurrPage.SetSelectionFilter(PQualityOrderHeaderLocal);
                    if PQualityOrderHeaderLocal.Find('-')then Report.RunModal(Report::"Production Material Analysis", true, false, PQualityOrderHeaderLocal);
                end;
            }
        }
    }
    trigger OnOpenPage()
    begin
    // if UserMgt.GetRespCenterFilter() <> '' then begin
    //     Rec.FilterGroup(0);
    //     Rec.SetRange("Responsibility Center", UserMgt.GetRespCenterFilter);
    //     Rec.FilterGroup(2);
    // end;
    end;
    var ItemsReclass: Record "SSD Items Reclassification";
    UserMgt: Codeunit "SSD User Setup Management";
    procedure SubformRefresh()
    begin
    //CurrPage.SubForm.PAGE.RefreshForm;
    end;
}
