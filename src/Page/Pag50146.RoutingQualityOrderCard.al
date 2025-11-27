Page 50146 "Routing Quality Order Card"
{
    Caption = 'Routing Quality Order Card';
    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = Document;
    SourceTable = "SSD Quality Order Header";
    SourceTableView = sorting("Template Type")order(ascending)where("Template Type"=const(Routing));
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
                    Editable = false;
                }
                field("Process / Operation Code"; Rec."Process / Operation Code")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Process / Operation"; Rec."Process / Operation")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Process/Operation No."; Rec."Process/Operation No.")
                {
                    ApplicationArea = All;
                    Editable = false;
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
                    Editable = false;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Source Code"; Rec."Source Code")
                {
                    ApplicationArea = All;
                    Caption = 'Work Order No.';
                    Editable = false;
                }
                field("Source Doc Date"; Rec."Source Doc Date")
                {
                    ApplicationArea = All;
                    Caption = 'Work Order Date';
                    Editable = false;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Sampling Temp. No."; Rec."Sampling Temp. No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Lot Size"; Rec."Lot Size")
                {
                    ApplicationArea = All;
                    Caption = 'Sample Size';
                    Editable = false;
                }
                field("Accepted Qty."; Rec."Accepted Qty.")
                {
                    ApplicationArea = All;
                }
                field("Rejected Qty."; Rec."Rejected Qty.")
                {
                    ApplicationArea = All;
                }
            }
            part(SubForm; "Rou. Quality Order Subform")
            {
                SubPageLink = "Document No."=field("No."), "Template Type"=field("Template Type");
                SubPageView = sorting("Document No.", "Line No.")order(ascending);
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
                field("Order No."; Rec."Order No.")
                {
                    ApplicationArea = All;
                    Caption = 'Source Quality Order No.';
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
                field("Lot No."; Rec."Lot No.")
                {
                    ApplicationArea = All;

                    trigger OnLookup(var Text: Text): Boolean var
                        LotNoInfLocal: Record "Lot No. Information";
                        LastEntryNo: Integer;
                        FrmLotNoInf: Page "Lot No. Information Card";
                    begin
                        LotNoInfLocal.Reset;
                        LotNoInfLocal.SetCurrentkey("Item No.", "Variant Code", "Source Type", "Source Subtype", "Source ID", "Source Prod. Order Line");
                        LotNoInfLocal.FilterGroup(2);
                        LotNoInfLocal.SetRange("Item No.", Rec."Item No.");
                        LotNoInfLocal.SetRange("Variant Code", Rec."Variant Code");
                        LotNoInfLocal.SetRange("Source Type", 5406);
                        LotNoInfLocal.SetRange("Source Subtype", LotNoInfLocal."source subtype"::"3");
                        LotNoInfLocal.SetRange("Source ID", Rec."Source Document No.");
                        LotNoInfLocal.SetRange("Source Prod. Order Line", Rec."Source Doc. Line No.");
                        LotNoInfLocal.FilterGroup(0);
                        if LotNoInfLocal.Find('-')then;
                        Clear(FrmLotNoInf);
                        FrmLotNoInf.SetTableview(LotNoInfLocal);
                        FrmLotNoInf.LookupMode(true);
                        FrmLotNoInf.Editable:=false;
                        if FrmLotNoInf.RunModal = Action::LookupOK then begin
                            FrmLotNoInf.GetRecord(LotNoInfLocal);
                            Rec."Lot No.":=LotNoInfLocal."Lot No.";
                        end;
                    end;
                    trigger OnValidate()
                    var
                        LotNoInfLocal: Record "Lot No. Information";
                    begin
                        if Rec."Lot No." <> '' then begin
                            LotNoInfLocal.Reset;
                            LotNoInfLocal.SetCurrentkey("Item No.", "Variant Code", "Source Type", "Source Subtype", "Source ID", "Source Prod. Order Line");
                            LotNoInfLocal.SetRange("Item No.", Rec."Item No.");
                            LotNoInfLocal.SetRange("Variant Code", Rec."Variant Code");
                            LotNoInfLocal.SetRange("Source Type", 5406);
                            LotNoInfLocal.SetRange("Source Subtype", LotNoInfLocal."source subtype"::"3");
                            LotNoInfLocal.SetRange("Source ID", Rec."Source Document No.");
                            LotNoInfLocal.SetRange("Source Prod. Order Line", Rec."Source Doc. Line No.");
                            LotNoInfLocal.SetRange("Lot No.", Rec."Lot No.");
                            if not LotNoInfLocal.Find('-')then Error(Text002, Rec."Lot No.", Rec."Source Document No.", Rec."Source Doc. Line No.");
                        end;
                    end;
                }
                field("Run Time"; Rec."Run Time")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Run Time (Base)"; Rec."Run Time (Base)")
                {
                    ApplicationArea = All;
                    Editable = false;
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
                    Editable = false;
                }
                field("Set. Time (Base)"; Rec."Set. Time (Base)")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Unit of Measure Code"; Rec."Unit of Measure Code")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Unit of Measure Code (Item)"; Rec."Unit of Measure Code (Item)")
                {
                    ApplicationArea = All;
                    Editable = false;
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
                    Editable = false;
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
                field(Customer; Rec.Customer)
                {
                    ApplicationArea = All;
                }
            }
            group("Heat Treatment")
            {
                Caption = 'Heat Treatment';

                field("Hardening Temperature"; Rec."Hardening Temperature")
                {
                    ApplicationArea = All;
                }
                field("Hardening Travel Time"; Rec."Hardening Travel Time")
                {
                    ApplicationArea = All;
                }
                field("Tempering Temperature"; Rec."Tempering Temperature")
                {
                    ApplicationArea = All;
                }
                field("Tempering Travel Time"; Rec."Tempering Travel Time")
                {
                    ApplicationArea = All;
                }
                field("C.P.1 Set"; Rec."C.P.1 Set")
                {
                    ApplicationArea = All;
                }
                field("C.P.2 Set"; Rec."C.P.2 Set")
                {
                    ApplicationArea = All;
                }
                field("Qty Kg"; Rec."Qty Kg")
                {
                    ApplicationArea = All;
                }
                field("Qty No's"; Rec."Qty No's")
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
                separator(Action1000000072)
                {
                }
                action(Released)
                {
                    ApplicationArea = All;
                    Caption = 'Released';
                    ShortCutKey = 'Ctrl+F9';

                    trigger OnAction()
                    begin
                        Rec.TestField(Finished, false);
                        if Rec."Lot Size" <= 0 then Error(Text003, Rec.FieldCaption("Lot Size"));
                        if(Rec."Accepted Qty." = 0) and (Rec."Rejected Qty." = 0)then Error(Text004);
                        Rec."Inspection Report Generated":=true;
                        Rec.Status:=Rec.Status::Released;
                        Rec.Modify;
                    end;
                }
                action(Reopen)
                {
                    ApplicationArea = All;
                    Caption = 'Reopen';
                    Image = ReOpen;

                    trigger OnAction()
                    begin
                        Rec.TestField(Finished, false);
                        if Rec."Inspection Report Generated" then Error(Text001);
                        Rec.Status:=Rec.Status::Open;
                        Rec.Modify;
                    end;
                }
            }
        }
        area(processing)
        {
            group(Print)
            {
                Caption = 'Print';

                action("Tool Room Inspection Report")
                {
                    ApplicationArea = All;
                    Caption = 'Tool Room Inspection Report';

                    trigger OnAction()
                    begin
                        QtyOrdHdr.Copy(Rec);
                        QtyOrdHdr.SetRange(QtyOrdHdr."No.", Rec."No.");
                        QtyOrdHdr.SetRange(QtyOrdHdr."Template Type", QtyOrdHdr."template type"::Routing);
                        //QtyOrdHdr.SETRANGE(QtyOrdHdr."Work Center No.",'QLT_WC');
                        Report.RunModal(50139, true, false, QtyOrdHdr);
                    end;
                }
                action("Lab Inspection Report")
                {
                    ApplicationArea = All;
                    Caption = 'Lab Inspection Report';

                    trigger OnAction()
                    begin
                        QtyOrdHdr.Copy(Rec);
                        QtyOrdHdr.SetRange(QtyOrdHdr."No.", Rec."No.");
                        QtyOrdHdr.SetRange(QtyOrdHdr."Template Type", QtyOrdHdr."template type"::Routing);
                        //QtyOrdHdr.SETRANGE(QtyOrdHdr."Work Center No.",'QLT_WC');
                        Report.RunModal(50066, true, false, QtyOrdHdr);
                    end;
                }
                action("Heat Treatment Inspection report")
                {
                    ApplicationArea = All;
                    Caption = 'Heat Treatment Inspection report';

                    trigger OnAction()
                    begin
                        QtyOrdHdr.Copy(Rec);
                        QtyOrdHdr.SetRange(QtyOrdHdr."No.", Rec."No.");
                        QtyOrdHdr.SetRange(QtyOrdHdr."Template Type", QtyOrdHdr."template type"::Routing);
                        //QtyOrdHdr.SETRANGE(QtyOrdHdr."Work Center No.",'QLT_WC');
                        Report.RunModal(50156, true, false, QtyOrdHdr);
                    end;
                }
            }
            action("&Print")
            {
                ApplicationArea = All;
                Caption = '&Print';
                Image = Print;
                Promoted = true;
                PromotedCategory = Process;
                Visible = false;

                trigger OnAction()
                var
                    QOrderHdrLocal: Record "SSD Quality Order Header";
                    QOrderSampleLineLocal: Record "SSD Quality Order Sample Line";
                begin
                    /*
                    CALCFIELDS("Type Of Inspection");
                    CurrForm.SETSELECTIONFILTER(QOrderHdrLocal);
                    IF QOrderHdrLocal.FIND('-') THEN
                      BEGIN
                        QOrderSampleLineLocal.RESET;
                        QOrderSampleLineLocal.SETCURRENTKEY("Quality Order No.");
                        QOrderSampleLineLocal.SETRANGE("Quality Order No.","No.");
                        QOrderSampleLineLocal.SETRANGE("Template Type",QOrderSampleLineLocal."Template Type"::Routing);
                        QOrderSampleLineLocal.SETRANGE("Document Type",QOrderSampleLineLocal."Document Type"::Hour);
                        IF QOrderSampleLineLocal.FIND('-') THEN
                          BEGIN
                            CASE "Type Of Inspection" OF
                              "Type Of Inspection"::LineInsp:
                                BEGIN
                                  REPORT.RUNMODAL(REPORT::"Qlt Line Inspection Report",TRUE,FALSE,QOrderSampleLineLocal);
                                END;
                              "Type Of Inspection"::FinalInsp:
                                BEGIN
                                  REPORT.RUNMODAL(REPORT::"Qlt Final Inspection Report",TRUE,FALSE,QOrderSampleLineLocal);
                                END;
                            END;
                          END;
                      END;
                    */
                    QtyOrdHdr.Copy(Rec);
                    QtyOrdHdr.SetRange(QtyOrdHdr."No.", Rec."No.");
                    QtyOrdHdr.SetRange(QtyOrdHdr."Template Type", QtyOrdHdr."template type"::Routing);
                    //QtyOrdHdr.SETRANGE(QtyOrdHdr."Work Center No.",'QLT_WC');
                    Report.RunModal(50139, true, false, QtyOrdHdr);
                end;
            }
        }
    }
    trigger OnAfterGetRecord()
    begin
        if Rec.Finished then CurrPage.Editable:=false
        else
            CurrPage.Editable:=true;
    end;
    trigger OnModifyRecord(): Boolean begin
        Rec.TestField(Finished, false);
    end;
    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec."Template Type":=Rec."template type"::Manufacturing;
        Rec."Responsibility Center":=UserMgt.GetRespCenterFilter;
    end;
    trigger OnOpenPage()
    begin
    // if UserMgt.GetRespCenterFilter() <> '' then begin
    //     Rec.FilterGroup(2);
    //     Rec.SetRange("Responsibility Center", UserMgt.GetRespCenterFilter);
    //     Rec.FilterGroup(0);
    // end;
    end;
    var ItemsReclass: Record "SSD Items Reclassification";
    UserMgt: Codeunit "SSD User Setup Management";
    Text001: label 'Already Inspection Report is generated';
    Text002: label 'Lot No. %1 not Found for Prod. Order No. %2 , Prod. Order Line No. %3';
    Text003: label '%1 must be >0';
    Text004: label 'Accepted Qty and Rejected Qty both cannot be zero';
    QtyOrdHdr: Record "SSD Quality Order Header";
}
