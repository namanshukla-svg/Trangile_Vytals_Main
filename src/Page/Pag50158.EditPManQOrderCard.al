Page 50158 "Edit P. Man. Q.Order Card"
{
    Caption = 'Edit P. Man. Q.Order Card';
    DeleteAllowed = false;
    Editable = true;
    InsertAllowed = false;
    ModifyAllowed = true;
    PageType = Document;
    SourceTable = "SSD Posted Quality Order Hdr";
    SourceTableView = sorting("Template Type")order(ascending)where("Template Type"=const(Manufacturing));
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
                field("ULR No."; Rec."ULR No.")
                {
                    ApplicationArea = All;
                }
                field("Process / Operation Code"; Rec."Process / Operation Code")
                {
                    ApplicationArea = All;
                    Caption = '<Process / Operation >';
                }
                field("Lot No."; Rec."Lot No.")
                {
                    ApplicationArea = All;
                }
                field(Remarks; Rec.Remarks)
                {
                    ApplicationArea = All;
                }
                field("Is Coil Type"; Rec."Is Coil Type")
                {
                    ApplicationArea = All;
                    Caption = 'Conforms to Manufacturing Specification';
                    Editable = true;
                }
                field("Inspection Report Generated"; Rec."Inspection Report Generated")
                {
                    ApplicationArea = All;
                    Caption = 'Pass through Deviation';
                    Editable = true;
                }
                field("Item No."; Rec."Item No.")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        //Alle_012119
                        Item.Get(Rec."No.");
                        Rec."Description 3":=Item."Description 3";
                    //Alle_012119
                    end;
                }
                field("Is NABL Accredited"; Rec."Is NABL Accredited")
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
                field("Description 3"; Rec."Description 3")
                {
                    ApplicationArea = All;
                }
                field("No of Archived Version"; Rec."No of Archived Version")
                {
                    ApplicationArea = All;
                    Editable = false;
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
                field("Lot Size"; Rec."Lot Size")
                {
                    ApplicationArea = All;
                }
                field("Parameter Type"; Rec."Parameter Type")
                {
                    ApplicationArea = All;
                }
            }
            part(SubForm; "Edit P.Man. Q.Order Subform")
            {
                SubPageLink = "Document No."=field("No."), "Template Type"=field("Template Type");
                SubPageView = sorting("Document No.", "Line No.")order(ascending);
                ApplicationArea = All;
            }
            group(Source)
            {
                Caption = 'Source';

                field("Source Document No."; Rec."Source Document No.")
                {
                    ApplicationArea = All;
                }
                field("Source Doc. Line No."; Rec."Source Doc. Line No.")
                {
                    ApplicationArea = All;
                }
                field("Routing No."; Rec."Routing No.")
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
                field("Run Time"; Rec."Run Time")
                {
                    ApplicationArea = All;
                }
                field("Run Time (Base)"; Rec."Run Time (Base)")
                {
                    ApplicationArea = All;
                }
                field("Starting Time"; Rec."Starting Time")
                {
                    ApplicationArea = All;
                }
                field("Ending Time"; Rec."Ending Time")
                {
                    ApplicationArea = All;
                }
                field("Setup Time"; Rec."Setup Time")
                {
                    ApplicationArea = All;
                }
                field("Set. Time (Base)"; Rec."Set. Time (Base)")
                {
                    ApplicationArea = All;
                }
                field("Unit of Measure Code"; Rec."Unit of Measure Code")
                {
                    ApplicationArea = All;
                }
                field("Unit of Measure Code (Item)"; Rec."Unit of Measure Code (Item)")
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
                separator(Action1000000051)
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
    PostedQualityOrderHeaderAr: Record "SSD Posted Quality Ord Hdr Ar";
    PostedQualityOrderLine: Record "SSD Posted Quality Order Line";
    Version: Integer;
    PostedQualityOrderLineAr: Record "SSD Posted Quality OrdLine Ar";
    DlgCnfm: Boolean;
    Item: Record Item;
    procedure SubformRefresh()
    begin
        CurrPage.SubForm.Page.RefreshForm;
    end;
}
