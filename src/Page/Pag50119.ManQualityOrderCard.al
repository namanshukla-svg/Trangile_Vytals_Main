Page 50119 "Man. Quality Order Card"
{
    Caption = 'Manufacturing Quality Order';
    InsertAllowed = false;
    PageType = Document;
    SourceTable = "SSD Quality Order Header";
    SourceTableView = sorting("Template Type") order(ascending) where("Template Type" = const(Manufacturing));
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
                field("Process / Operation Code"; Rec."Process / Operation Code")
                {
                    ApplicationArea = All;
                    Caption = 'Process / Operation ';
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

                    trigger OnValidate()
                    begin
                        //Alle_012119
                        Item.Get(Rec."No.");
                        Rec."Description 3" := Item."Description 3";
                        //Alle_012119
                    end;
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
                field("Lot No."; Rec."Lot No.")
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
                field("Manufacturing Date As Label"; Rec."Manufacturing Date As Label")
                {
                    ApplicationArea = All;
                }
                field("Sampling Temp. No."; Rec."Sampling Temp. No.")
                {
                    ApplicationArea = All;
                    Editable = true;
                }
                field("Is NABL Accredited"; Rec."Is NABL Accredited")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        //Alle_290818
                        if (xRec."Is NABL Accredited") or (Rec."Is NABL Accredited" = false) then Error('You can not Authorised');
                        //Alle_290818
                    end;
                }
                field("Lot Size"; Rec."Lot Size")
                {
                    ApplicationArea = All;
                    Caption = 'Prod. Order Qty.';
                }
                field("Accepted Qty."; Rec."Accepted Qty.")
                {
                    ApplicationArea = All;
                }
                field("Rejected Qty."; Rec."Rejected Qty.")
                {
                    ApplicationArea = All;
                }
                field("Sample Size"; Rec."Sample Size")
                {
                    ApplicationArea = All;
                    Caption = 'Batch Size';

                    trigger OnValidate()
                    begin
                        Rec.CalcFields("Total Qty. Sent For Inspection");
                        if Rec."Sample Size" > (Rec."Lot Size" - Rec."Total Qty. Sent For Inspection") then Error(Txt00001, Rec.FieldCaption("Sample Size"), Format((Rec."Lot Size" - Rec."Total Qty. Sent For Inspection")));
                    end;
                }
                field("Qty. Sent For Inspection"; Rec."Qty. Sent For Inspection")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("ULR No."; Rec."ULR No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Is Coil Type"; Rec."Is Coil Type")
                {
                    ApplicationArea = All;
                }
            }
            part(SubForm; "Man. Quality Order Subform")
            {
                ApplicationArea = All;
                SubPageLink = "Document No." = field("No."), "Template Type" = field("Template Type");
                SubPageView = sorting("Document No.", "Line No.") order(ascending);
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
                field("Unit of Measure Code"; Rec."Unit of Measure Code")
                {
                    ApplicationArea = All;
                }
                field("Unit of Measure Code (Item)"; Rec."Unit of Measure Code (Item)")
                {
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                }
                field(Remarks; Rec.Remarks)
                {
                    ApplicationArea = All;
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
                field("LIR No."; Rec."LIR No.")
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
                field("Manufacturing Spacification"; Rec."Is Coil Type")
                {
                    ApplicationArea = All;
                    Caption = 'Conforms to Manufacturing Specification';

                    trigger OnValidate()
                    begin
                        IsCoilTypeOnPush;
                    end;
                }
                field("Under Deviation"; Rec."Inspection Report Generated")
                {
                    ApplicationArea = All;
                    Caption = 'Pass through Deviation';

                    trigger OnValidate()
                    begin
                        InspectionReportGenerateOnPush;
                    end;
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
                field("FIR No"; Rec."FIR No")
                {
                    ApplicationArea = All;
                }
                field("FIR Date"; Rec."FIR Date")
                {
                    ApplicationArea = All;
                }
                field("Drg. Rev No."; Rec."Drg. Rev No.")
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
                action("Sub Quality Orders")
                {
                    ApplicationArea = All;
                    Caption = 'Sub Quality Orders';

                    trigger OnAction()
                    var
                        QualityOrderHeaderLocal: Record "SSD Quality Order Header";
                        FrmQualityOrder: Page "Quality Order List";
                    begin
                        QualityOrderHeaderLocal.Reset;
                        QualityOrderHeaderLocal.FilterGroup(0);
                        QualityOrderHeaderLocal.SetCurrentkey("Template Type", "Entry Source Type", "Order No.");
                        QualityOrderHeaderLocal.SetRange("Template Type", QualityOrderHeaderLocal."template type"::Routing);
                        QualityOrderHeaderLocal.SetRange("Entry Source Type", QualityOrderHeaderLocal."entry source type"::"Manufac.");
                        QualityOrderHeaderLocal.SetRange("Order No.", Rec."No.");
                        QualityOrderHeaderLocal.FilterGroup(2);
                        Clear(FrmQualityOrder);
                        FrmQualityOrder.SettingControls;
                        FrmQualityOrder.SetTableview(QualityOrderHeaderLocal);
                        FrmQualityOrder.RunModal;
                    end;
                }
                action("Refresh-Sampling Template")
                {
                    ApplicationArea = All;
                    Caption = 'Refresh-Sampling Template';

                    trigger OnAction()
                    var
                        SamplingTempLineLocal: Record "SSD Sampling Temp. Line";
                        QualityOrderLineLocal: Record "SSD Quality Order Line";
                        Lineno: Integer;
                    begin
                        //<<< ALLE[5.51]
                        Lineno := 10000;
                        SamplingTempLineLocal.Reset;
                        SamplingTempLineLocal.SetRange("Document No.", Rec."Sampling Temp. No.");
                        if SamplingTempLineLocal.FindFirst then
                            repeat
                                QualityOrderLineLocal.TransferFields(SamplingTempLineLocal);
                                QualityOrderLineLocal."Document No." := Rec."No.";
                                QualityOrderLineLocal."Sampling Template No." := Rec."Sampling Temp. No.";
                                QualityOrderLineLocal."Template Type" := Rec."Template Type";
                                QualityOrderLineLocal."Line No." := Lineno;
                                Lineno := Lineno + 10000;
                                QualityOrderLineLocal.Insert;
                            until SamplingTempLineLocal.Next = 0;
                        //>>> ALLE[5.51]
                    end;
                }
            }
            group("&Function")
            {
                Caption = '&Function';

                action(Open)
                {
                    ApplicationArea = All;
                    Caption = 'Open';
                    ShortCutKey = 'Return';

                    trigger OnAction()
                    var
                        QualityOrderHeaderLocal: Record "SSD Quality Order Header";
                    begin
                        Rec.CalcFields("Total Qty. Sent For Inspection");
                        if Rec."Total Qty. Sent For Inspection" = Rec."Lot Size" then begin
                            QualityOrderHeaderLocal.Reset;
                            QualityOrderHeaderLocal.SetCurrentkey("Template Type", "Entry Source Type", "Order No.");
                            QualityOrderHeaderLocal.SetRange("Template Type", QualityOrderHeaderLocal."template type"::Routing);
                            QualityOrderHeaderLocal.SetRange("Entry Source Type", QualityOrderHeaderLocal."entry source type"::"Manufac.");
                            QualityOrderHeaderLocal.SetRange("Order No.", Rec."No.");
                            if QualityOrderHeaderLocal.Find('-') then Error(Txt0002, Rec."No.");
                        end;
                        Rec.TestField(Finished, false);
                        Rec.Status := Rec.Status::Open;
                        Rec.Modify;
                    end;
                }
                action(Released)
                {
                    ApplicationArea = All;
                    Caption = 'Released';
                    ShortCutKey = 'Ctrl+F9';

                    trigger OnAction()
                    begin
                        Rec.TestField(Finished, false);
                        //ALLE SB_22122022 +
                        QualityOrderLineGRec.Reset;
                        QualityOrderLineGRec.SetRange("Document No.", Rec."No.");
                        if QualityOrderLineGRec.FindSet then
                            repeat
                                if QualityOrderLineGRec."Meas. Value Type" = QualityOrderLineGRec."meas. value type"::Flag then if not QualityOrderLineGRec."Quality Pass" then Error('For Quality order no %1 parameter is not passed for %2.', Rec."No.", QualityOrderLineGRec."Test No.");
                            until QualityOrderLineGRec.Next = 0;
                        //ALLE SB_22122022 -
                        Rec.Status := Rec.Status::Released;
                        Rec.Modify;
                    end;
                }
                separator(Action1000000050)
                {
                }
                action("View QLT Certificate of RM")
                {
                    ApplicationArea = All;
                    Caption = 'View QLT Certificate of RM';

                    trigger OnAction()
                    var
                        ReservationEntry: Record "Reservation Entry";
                        IncommingQLTCertificate: Report "Incoming Material Analysis";
                        PostedQltOrderHdr: Record "SSD Posted Quality Order Hdr";
                    begin
                        ReservationEntry.Reset;
                        ReservationEntry.SetRange(ReservationEntry.Positive, false);
                        ReservationEntry.SetRange(ReservationEntry."Source ID", Rec."Source Code");
                        if ReservationEntry.FindFirst then
                            repeat
                                Clear(IncommingQLTCertificate);
                                PostedQltOrderHdr.Reset;
                                PostedQltOrderHdr.SetRange(PostedQltOrderHdr."Lot No.", ReservationEntry."Lot No.");
                                IncommingQLTCertificate.SetTableview(PostedQltOrderHdr);
                                IncommingQLTCertificate.RunModal;
                            until ReservationEntry.Next = 0;
                    end;
                }
                action("View Component")
                {
                    ApplicationArea = All;
                    Caption = 'View Component';

                    trigger OnAction()
                    var
                        FrmProdComponent: Page "Prod. Order Components";
                        ProdOrderComponents: Record "Prod. Order Component";
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
                action("View Quality Card Of Component")
                {
                    ApplicationArea = All;
                    Caption = 'View Quality Card Of Component';

                    trigger OnAction()
                    var
                        ReservationEntry1: Record "Reservation Entry";
                        FormReservationEntry1: Page "Reservation Entries";
                    begin
                        //<<****** ALLE[5.51]
                        ReservationEntry1.Reset;
                        ReservationEntry1.SetRange(ReservationEntry1.Positive, false);
                        ReservationEntry1.SetRange(ReservationEntry1."Source ID", Rec."Source Document No.");
                        if ReservationEntry1.FindFirst then begin
                            Clear(FormReservationEntry1);
                            FormReservationEntry1.SetTableview(ReservationEntry1);
                            FormReservationEntry1.RunModal;
                        end;
                        //>>****** ALLE[5.51]
                    end;
                }
            }
        }
        area(processing)
        {
            action(Post)
            {
                ApplicationArea = All;
                Caption = 'Post';
                Image = Post;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    //ALLE SB_22122022 +
                    QualityOrderLineGRec.Reset;
                    QualityOrderLineGRec.SetRange("Document No.", Rec."No.");
                    if QualityOrderLineGRec.FindSet then
                        repeat
                            if QualityOrderLineGRec."Meas. Value Type" = QualityOrderLineGRec."meas. value type"::Flag then if not QualityOrderLineGRec."Quality Pass" then Error('For Quality order no %1 parameter is not passed for %2.', Rec."No.", QualityOrderLineGRec."Test No.");
                        until QualityOrderLineGRec.Next = 0;
                    //ALLE SB_22122022 -
                    //ALLE[5.51]
                    if not Rec."Inspection Report Generated" then Rec.TestField("Is Coil Type");
                    if not Rec."Is Coil Type" then Rec.TestField("Inspection Report Generated");
                    //ALLE[5.51]
                    Rec.TestField(Status, Rec.Status::Released);
                    QualityOrderPostLine.Run(Rec);
                end;
            }
            group("&Print")
            {
                Caption = '&Print';

                action("Qlt Inspection Report before Posting")
                {
                    ApplicationArea = All;
                    Caption = 'Qlt Inspection Report before Posting';

                    trigger OnAction()
                    var
                        ProdMaterialAnalysis: Report "Prod. Material Analysis-Pre";
                        QualityOrderHeaderLocal: Record "SSD Quality Order Header";
                    begin
                        //ALLE[5.5]
                        CurrPage.SetSelectionFilter(QualityOrderHeaderLocal);
                        if QualityOrderHeaderLocal.Find('-') then Report.RunModal(Report::"Prod. Material Analysis-Pre", true, false, QualityOrderHeaderLocal);
                        //ALLE[5.51]
                    end;
                }
                action("Refresh Sampling")
                {
                    ApplicationArea = All;
                    Ellipsis = true;
                    Image = Refresh;
                    Promoted = true;
                    PromotedCategory = New;
                    PromotedIsBig = true;

                    trigger OnAction()
                    var
                        ItemTemplate: Record "Item Sampling Template";
                        ItemTemplateLine: Record "SSD Quality Order Line";
                        ItemTemplateList: Record "SSD Sampling Temp. Line";
                        LineNO: Integer;
                    begin
                        // BIS 1145
                        ItemTemplate.Reset;
                        ItemTemplate.SetRange(ItemTemplate."Item Code", Rec."Item No.");
                        ItemTemplate.SetRange(ItemTemplate.Active, true);
                        if ItemTemplate.FindFirst then begin
                            Rec."Sampling Temp. No." := ItemTemplate."Sampling Temp. No.";
                            //MESSAGE('For Item NO. %1 the sampling template is modified.',"Item No.");
                        end;
                        ItemTemplateLine.Reset;
                        ItemTemplateLine.SetRange(ItemTemplateLine."Document No.", Rec."No.");
                        //ItemTemplateLine.SETRANGE();
                        if ItemTemplateLine.FindSet then ItemTemplateLine.DeleteAll;
                        ItemTemplateList.Reset;
                        ItemTemplateList.SetRange(ItemTemplateList."Document No.", ItemTemplate."Sampling Temp. No.");
                        if ItemTemplateList.FindSet then
                            repeat
                                ItemTemplateLine.Init;
                                LineNO += 10000;
                                ItemTemplateLine.TransferFields(ItemTemplateList);
                                ItemTemplateLine."Document No." := Rec."No.";
                                ItemTemplateLine."Line No." := LineNO;
                                ItemTemplateLine.Insert;
                            until ItemTemplateList.Next = 0;
                        // BIS 1145
                    end;
                }
            }
        }
    }
    trigger OnAfterGetRecord()
    begin
        if Rec."Manufacturing Date As Label" = 0D then Rec."Manufacturing Date As Label" := Rec."Source Doc Date";
        //  editable := true; //Alle_290818 //IG_DS_before
        IsEditable := true; //IG_DS_after
    end;

    trigger OnDeleteRecord(): Boolean
    var
        QualityOrderLineLocal: Record "SSD Quality Order Line";
    begin
        QualityOrderLineLocal.Reset;
        QualityOrderLineLocal.SetRange("Document No.", Rec."No.");
        if QualityOrderLineLocal.Find('-') then
            repeat
                CurrPage.SubForm.Page.DeleteQualitySubLines(QualityOrderLineLocal);
            until QualityOrderLineLocal.Next = 0;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec."Template Type" := Rec."template type"::Manufacturing;
        Rec."Responsibility Center" := UserMgt.GetRespCenterFilter;
    end;

    trigger OnOpenPage()
    begin
        // if UserMgt.GetRespCenterFilter() <> '' then begin
        //     Rec.FilterGroup(0);
        //     Rec.SetRange("Responsibility Center", UserMgt.GetRespCenterFilter);
        //     Rec.FilterGroup(2);
        // end;
        //   editable := true; //Alle_290818 //IG_DS_before
        IsEditable := true; //IG_DS_after
    end;

    var
        UserMgt: Codeunit "SSD User Setup Management";
        Txt00001: label '%1 cannot be more than %2';
        Txt0002: label 'One or more Inspection Report is generated against Order No %1';
        "QtyOrdHdr.": Record "SSD Quality Order Header";
        QualityOrderPostLine: Codeunit "Quality Order -Post Line";
        // editable: Boolean; //IG_DS_before
        IsEditable: Boolean; //IG_DS_after
        Item: Record Item;
        QualityOrderLineGRec: Record "SSD Quality Order Line";

    procedure SubformRefresh()
    begin
        CurrPage.SubForm.Page.RefreshForm;
    end;

    local procedure IsCoilTypeOnPush()
    begin
        Rec."Inspection Report Generated" := false;
        CurrPage.SaveRecord;
    end;

    local procedure InspectionReportGenerateOnPush()
    begin
        Rec."Is Coil Type" := false;
        CurrPage.SaveRecord;
    end;
}
