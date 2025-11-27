Page 50255 "Rcpt. Sub Quality Order Card L"
{
    Caption = 'Rcpt. Sub Quality Order Card L';
    CardPageID = "Rcpt. Sub Quality Order Card";
    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = List;
    SourceTable = "SSD Quality Order Header";
    SourceTableView = sorting("Template Type")order(ascending)where("Template Type"=const(RcvdCoil));
    ApplicationArea = All;

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
                    Editable = false;

                    trigger OnLookup(var Text: Text): Boolean var
                        FrmItemSamplingTemp: Page "Item Sampling Templates";
                        ItemSamplingTempocal: Record "Item Sampling Template";
                    begin
                    /*
                        CLEAR(FrmItemSamplingTemp);
                        ItemSamplingTempocal.RESET;
                        ItemSamplingTempocal.FILTERGROUP(2);
                        ItemSamplingTempocal.SETCURRENTKEY("Item Code","Template Type",Active);
                        ItemSamplingTempocal.SETRANGE("Item Code","Item No.");
                        ItemSamplingTempocal.SETRANGE("Template Type","Template Type");
                        ItemSamplingTempocal.SETRANGE(Active,TRUE);
                        ItemSamplingTempocal.FILTERGROUP(0);
                        IF ItemSamplingTempocal.FIND('-')THEN
                          BEGIN
                            FrmItemSamplingTemp.SETTABLEVIEW(ItemSamplingTempocal);
                            FrmItemSamplingTemp.LOOKUPMODE(TRUE);
                            FrmItemSamplingTemp.EDITABLE(FALSE);
                            IF FrmItemSamplingTemp.RUNMODAL =ACTION::LookupOK THEN
                              BEGIN
                                FrmItemSamplingTemp.GETRECORD(ItemSamplingTempocal);
                                VALIDATE("Sampling Temp. No.",ItemSamplingTempocal."Sampling Temp. No.");
                                CurrPage.SubForm.PAGE.CreateQualityOrderLine(Rec);
                              END;
                          END;
                          */
                    end;
                }
                field("Kind of Sampling"; Rec."Kind of Sampling")
                {
                    ApplicationArea = All;
                }
                field("Sampling Method"; Rec."Sampling Method")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        SamplingMethodOnAfterValidate;
                    end;
                }
                field("Percentage / Fixed Quantity"; Rec."Percentage / Fixed Quantity")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        SubformRefresh();
                    end;
                }
                field(Status; Rec.Status)
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
                    Editable = false;

                    trigger OnValidate()
                    begin
                        if Rec."Is Coil Type" then begin
                            Rec.CalcFields("Total Qty. Sent For Inspection");
                            if Rec."Sample Size" > (Rec."Lot Size" - Rec."Total Qty. Sent For Inspection")then Error(Txt0002, Rec.FieldCaption("Sample Size"), Format((Rec."Lot Size" - Rec."Total Qty. Sent For Inspection")));
                        end
                        else
                            SubformRefresh();
                    end;
                }
                field("Accepted Qty."; Rec."Accepted Qty.")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        SubformRefresh();
                    end;
                }
                field("Rejected Qty."; Rec."Rejected Qty.")
                {
                    ApplicationArea = All;
                }
                field("Decision For Quality Pass"; Rec."Decision For Quality Pass")
                {
                    ApplicationArea = All;
                    Editable = DecisionForQualityPassEditable;

                    trigger OnValidate()
                    begin
                        SubformRefresh();
                    end;
                }
                field("Inspection Report Generated"; Rec."Inspection Report Generated")
                {
                    ApplicationArea = All;
                }
                field(Finished; Rec.Finished)
                {
                    ApplicationArea = All;
                }
                field("Accepted Under Deviation"; Rec."Accepted Under Deviation")
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
                separator(Action1000000042)
                {
                }
                action("Lot Information for Reject qty")
                {
                    ApplicationArea = All;
                    Caption = 'Lot Information for Reject qty';

                    trigger OnAction()
                    begin
                        Rec.RejectLotInform(Rec);
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
                    begin
                        Rec.TestField(Finished, false);
                        if Rec."Inspection Report Generated" then Error(Text005);
                        Rec.Status:=Rec.Status::Open;
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
                        if Rec."Lot Size" <= 0 then Error(Text003, Rec.FieldCaption("Lot Size"));
                        if(Rec."Accepted Qty." = 0) and (Rec."Rejected Qty." = 0)then Error(Text004);
                        Rec.CheckingOfQualityOrder(Rec);
                        Rec.Status:=Rec.Status::Released;
                        Rec.Modify;
                    end;
                }
            }
            group(Reports)
            {
                Caption = 'Reports';

                action("RM Inspetion Report")
                {
                    ApplicationArea = All;
                    Caption = 'RM Inspetion Report';

                    trigger OnAction()
                    begin
                        /*
                        "QtyOrdHdr.".COPY(Rec);
                        "QtyOrdHdr.".SETRANGE("QtyOrdHdr."."No.","No.");
                        "QtyOrdHdr.".SETRANGE("QtyOrdHdr."."Template Type","QtyOrdHdr."."Template Type"::Manufacturing);
                        //"QtyOrdHdr.".SETRANGE("QtyOrdHdr."."Work Center No.",'QLT_WC');
                        REPORT.RUNMODAL(50138,TRUE,FALSE,"QtyOrdHdr.");
                        */
                        QltyOrdHdr.Copy(Rec);
                        QltyOrdHdr.SetRange(QltyOrdHdr."No.", Rec."No.");
                        QltyOrdHdr.SetRange(QltyOrdHdr."Template Type", QltyOrdHdr."template type"::RcvdCoil);
                        if QltyOrdHdr.Find('-')then Report.RunModal(50028, true, false, QltyOrdHdr)end;
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
                    QualityOrderHeaderLocal: Record "SSD Quality Order Header";
                begin
                    CurrPage.SetSelectionFilter(QualityOrderHeaderLocal);
                    if QualityOrderHeaderLocal.Find('-')then Report.RunModal(Report::"Incoming Material Analysis-Pre", true, false, QualityOrderHeaderLocal);
                end;
            }
            group("P&osting")
            {
                Caption = 'P&osting';

                action(Post)
                {
                    ApplicationArea = All;
                    Caption = 'P&ost';
                    Image = Post;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ShortCutKey = 'F9';

                    trigger OnAction()
                    var
                        QualityOrderPostLine: Codeunit "Quality Order -Post Line";
                    begin
                        Rec.TestField(Finished, false);
                        Rec.TestField(Status, Rec.Status::Released);
                        QualityOrderPostLine.Run(Rec);
                        CurrPage.Update(false);
                    end;
                }
            }
        }
    }
    trigger OnAfterGetRecord()
    begin
        SettingOfForms;
        if Rec.Finished then CurrPage.Editable:=false
        else
            CurrPage.Editable:=true;
    end;
    trigger OnInit()
    begin
        "Vendor Claim CodeEditable":=true;
        DecisionForQualityPassEditable:=true;
    end;
    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec."Template Type":=Rec."template type"::RcvdCoil;
        Rec."Responsibility Center":=UserMgt.GetRespCenterFilter;
    end;
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
        OnActivateForm;
    end;
    var ItemsReclass: Record "SSD Items Reclassification";
    UserMgt: Codeunit "SSD User Setup Management";
    QualityOrderPostLine: Codeunit "Quality Order -Post Line";
    Text001: label '%1 must be > zero';
    Txt0002: label '%1 cannot be more than %2';
    Text003: label '%1 must be >0';
    Text004: label 'Accepted Qty and Rejected Qty both cannot be zero';
    Text005: label 'Already Inspection report is generated';
    Text006: label 'Lot No. %1 not Found for Order No. %2 , Order Line No. %3';
    QltyOrdHdr: Record "SSD Quality Order Header";
    DecisionForQualityPassEditable: Boolean;
    "Vendor Claim CodeEditable": Boolean;
    procedure SubformRefresh()
    begin
    //CurrPage.SubForm.PAGE.RefreshForm;
    end;
    procedure SettingOfForms()
    begin
        case Rec."Sampling Method" of Rec."sampling method"::"Complete Quantity": begin
            DecisionForQualityPassEditable:=false;
        end;
        Rec."sampling method"::Percentage: begin
            DecisionForQualityPassEditable:=true;
        end;
        Rec."sampling method"::"Fixed Quantity": begin
            DecisionForQualityPassEditable:=true;
        end;
        end;
        if Rec."Concerted Quality" then "Vendor Claim CodeEditable":=true
        else
        begin
            Rec."Vendor Claim Code":='';
            "Vendor Claim CodeEditable":=false;
        end;
    end;
    local procedure SamplingMethodOnAfterValidate()
    begin
        SettingOfForms;
        SubformRefresh();
    end;
    local procedure OnActivateForm()
    begin
        SettingOfForms;
    end;
}
