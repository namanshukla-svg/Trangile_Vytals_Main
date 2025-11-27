Page 50254 "Rcpt. Quality Order Card List"
{
    Caption = 'Quality Order Card';
    CardPageID = "Rcpt. Quality Order Card";
    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = List;
    SourceTable = "SSD Quality Order Header";
    SourceTableView = sorting("Template Type")order(ascending)where("Template Type"=const(Receipt));
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
                    ToolTip = 'Specifies the value of the No. field.';
                }
                field("Item No."; Rec."Item No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Item No. field.';
                }
                field("No.2"; Rec."No.2")
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Specifies the value of the No.2 field.';
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Description field.';
                }
                field("Description 2"; Rec."Description 2")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Description 2 field.';
                }
                field("Sampling Temp. No."; Rec."Sampling Temp. No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Sampling Template No. field.';

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
                    ToolTip = 'Specifies the value of the Kind of Sampling field.';
                }
                field("Sampling Method"; Rec."Sampling Method")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Sampling Method field.';

                    trigger OnValidate()
                    begin
                        SamplingMethodOnAfterValidate;
                    end;
                }
                field("Percentage / Fixed Quantity"; Rec."Percentage / Fixed Quantity")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Percentage / Fixed Quantity field.';

                    trigger OnValidate()
                    begin
                        SubformRefresh();
                    end;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Status field.';
                }
                field("Source Code"; Rec."Source Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Source Code field.';
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Posting Date field.';
                }
                field("Lot Size"; Rec."Lot Size")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Lot Size field.';
                }
                field("Sample Size"; Rec."Sample Size")
                {
                    ApplicationArea = All;
                    Editable = "Sample SizeEditable";
                    ToolTip = 'Specifies the value of the Sample Size field.';

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
                    Editable = "Accepted Qty.Editable";
                    ToolTip = 'Specifies the value of the Accepted Qty. field.';

                    trigger OnValidate()
                    begin
                        SubformRefresh();
                    end;
                }
                field("Rejected Qty."; Rec."Rejected Qty.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Rejected Qty. field.';
                }
                field("Decision For Quality Pass"; Rec."Decision For Quality Pass")
                {
                    ApplicationArea = All;
                    Editable = DecisionForQualityPassEditable;
                    ToolTip = 'Specifies the value of the Decision For Quality Pass field.';
                }
                field("No. Of Coil"; Rec."No. Of Coil")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the No. Of Coil field.';
                }
                field("Total Qty. Sent For Inspection"; Rec."Total Qty. Sent For Inspection")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Total Qty. Sent For Inspection field.';
                }
                field("Accepted Under Deviation"; Rec."Accepted Under Deviation")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Accepted Under Deviation field.';
                }
                field("PPC Dev. Req. Ref. No."; Rec."PPC Dev. Req. Ref. No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the PPC Dev. Req. Ref. No. field.';
                }
                field("Source Document No."; Rec."Source Document No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Source Document No. field.';
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
                    ToolTip = 'Executes the Comments action.';

                    trigger OnAction()
                    begin
                        Rec.ShowComent;
                    end;
                }
                separator(Action1000000069)
                {
                }
                action("Sub Quality Orders")
                {
                    ApplicationArea = All;
                    Caption = 'Sub Quality Orders';
                    ToolTip = 'Executes the Sub Quality Orders action.';

                    trigger OnAction()
                    var
                        QualityOrderHeaderLocal: Record "SSD Quality Order Header";
                        FrmQualityOrder: Page "Quality Order List";
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
                        FrmQualityOrder.SettingControls;
                        FrmQualityOrder.SetTableview(QualityOrderHeaderLocal);
                        FrmQualityOrder.RunModal;
                    end;
                }
                action("Lot Information for Reject qty")
                {
                    ApplicationArea = All;
                    Caption = 'Lot Information for Reject qty';
                    ToolTip = 'Executes the Lot Information for Reject qty action.';

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
                    ToolTip = 'Executes the Open action.';

                    trigger OnAction()
                    begin
                        Rec.TestField(Finished, false);
                        Rec.Status:=Rec.Status::Open;
                        Rec.Modify;
                    end;
                }
                action(Released)
                {
                    ApplicationArea = All;
                    Caption = 'Released';
                    ShortCutKey = 'Ctrl+F9';
                    ToolTip = 'Executes the Released action.';

                    trigger OnAction()
                    begin
                        Rec.TestField(Finished, false);
                        Rec.CheckingOfQualityOrder(Rec);
                        Rec.Status:=Rec.Status::Released;
                        Rec.Modify;
                    end;
                }
                action(Delete)
                {
                    ApplicationArea = All;
                    Caption = 'Delete';
                    Image = Delete;
                    ToolTip = 'Executes the Delete action.';

                    trigger OnAction()
                    begin
                        DeleteQualityOrder();
                    end;
                }
                action("Create Sub Quality Order")
                {
                    ApplicationArea = All;
                    Caption = 'Create Sub Quality Order';
                    ToolTip = 'Executes the Create Sub Quality Order action.';

                    trigger OnAction()
                    var
                        QualityManagement: Codeunit "Quality Management";
                    begin
                        Rec.TestField(Finished, false);
                        Rec.TestField("Is Coil Type", true);
                        Rec.TestField("Template Type", Rec."template type"::Receipt);
                        Rec.TestField("Sampling Temp. No.");
                        if Rec."Sample Size" <= 0 then Error(Text001, Rec.FieldCaption("Sample Size"));
                        if(Rec."Sampling Temp. No." <> '') and (Rec."Sample Size" > 0)then QualityManagement.CreateQOrdForRcvdCoil(Rec);
                    end;
                }
                action("View Component In Case of SubCon")
                {
                    ApplicationArea = All;
                    Caption = 'View Component In Case of SubCon';
                    ToolTip = 'Executes the View Component In Case of SubCon action.';

                    trigger OnAction()
                    var
                        ItemLedgerEntry1: Record "Item Ledger Entry";
                        FormItemLedgerEntry1: Page "Item Ledger Entries";
                    begin
                        //<<****** ALLE[5.51]
                        ItemLedgerEntry1.Reset;
                        ItemLedgerEntry1.SetCurrentkey(ItemLedgerEntry1."Document No.", ItemLedgerEntry1."Posting Date");
                        //ItemLedgerEntry1.SETRANGE(ItemLedgerEntry1.Positive,FALSE);
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
            }
        }
        area(processing)
        {
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
                    ToolTip = 'Executes the P&ost action.';

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
            action("&Print")
            {
                ApplicationArea = All;
                Caption = '&Print';
                Image = Print;
                Promoted = true;
                PromotedCategory = Process;
                ToolTip = 'Executes the &Print action.';

                trigger OnAction()
                var
                    QualityOrderHeaderLocal: Record "SSD Quality Order Header";
                begin
                    CurrPage.SetSelectionFilter(QualityOrderHeaderLocal);
                    if QualityOrderHeaderLocal.Find('-')then Report.RunModal(Report::"Incoming Material Analysis-Pre", true, false, QualityOrderHeaderLocal);
                end;
            }
        }
    }
    trigger OnAfterGetRecord()
    begin
        SettingOfForms;
    end;
    trigger OnInit()
    begin
        "Vendor Claim CodeEditable":=true;
        "Accepted Qty.Editable":=true;
        "Sample SizeEditable":=true;
        DecisionForQualityPassEditable:=true;
    end;
    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec."Template Type":=Rec."template type"::Receipt;
        Rec."Responsibility Center":=UserMgt.GetRespCenterFilter;
    end;
    trigger OnOpenPage()
    begin
    /*
        IF UserMgt.GetRespCenterFilter() <> '' THEN BEGIN
          FILTERGROUP(2);
          SETRANGE("Responsibility Center",UserMgt.GetRespCenterFilter);
          FILTERGROUP(0);
        END;
        FILTERGROUP(2);
        IF GETFILTER("Template Type") <>'' THEN
          CurrPage.CAPTION :=GETFILTER("Template Type")+ '-' + CurrPage.CAPTION  ;
        FILTERGROUP(0);
        //5.51 to automate qaulity line
        QualityOrderLine1.RESET;
        QualityOrderLine1.SETRANGE(QualityOrderLine1."Document No.","No.");
        IF NOT(QualityOrderLine1.FINDFIRST) THEN
        IF "Sampling Temp. No."<>'' THEN  BEGIN
        CurrPage.SubForm.PAGE.CreateQualityOrderLine(Rec);
        "Sample Size":="Lot Size";
        "Accepted Qty.":="Lot Size";
        MODIFY;
        END;
        //5.51
          OnActivateForm;
         */
    end;
    var ItemsReclass: Record "SSD Items Reclassification";
    UserMgt: Codeunit "SSD User Setup Management";
    QualityOrderPostLine: Codeunit "Quality Order -Post Line";
    Text001: label '%1 must be > zero';
    Txt0002: label '%1 cannot be more than %2';
    WarehouseHeader: Record "Warehouse Receipt Header";
    QualityOrderLine1: Record "SSD Quality Order Line";
    DecisionForQualityPassEditable: Boolean;
    "Sample SizeEditable": Boolean;
    "Accepted Qty.Editable": Boolean;
    "Vendor Claim CodeEditable": Boolean;
    procedure SubformRefresh()
    begin
    //CurrPage.SubForm.PAGE.RefreshForm;
    end;
    procedure SettingOfForms()
    begin
        case Rec."Sampling Method" of Rec."sampling method"::"Complete Quantity": begin
            DecisionForQualityPassEditable:=false;
            if Rec."Is Coil Type" then begin
                "Sample SizeEditable":=true;
                "Accepted Qty.Editable":=false;
            end
            else
            begin
                "Sample SizeEditable":=false;
                "Accepted Qty.Editable":=true;
            end;
        end;
        Rec."sampling method"::Percentage: begin
            DecisionForQualityPassEditable:=true;
            "Sample SizeEditable":=true;
            if Rec."Is Coil Type" then begin
                "Accepted Qty.Editable":=false;
            end
            else
            begin
                "Accepted Qty.Editable":=true;
            end;
        end;
        Rec."sampling method"::"Fixed Quantity": begin
            DecisionForQualityPassEditable:=true;
            "Sample SizeEditable":=true;
            if Rec."Is Coil Type" then begin
                "Accepted Qty.Editable":=false;
            end
            else
            begin
                "Accepted Qty.Editable":=true;
            end;
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
        CurrPage.Update(false);
    end;
    local procedure DeleteQualityOrder()
    var
        UserSetup: Record "User Setup";
        QualityOrderLines: Record "SSD Quality Order Line";
    begin
        UserSetup.Get(UserId);
        if not UserSetup."HRMS Permission" then exit;
        if not Confirm('Do you want to delete quality order?', false)then exit;
        QualityOrderLines.Reset();
        QualityOrderLines.SetRange("Document No.", Rec."No.");
        if QualityOrderLines.FindSet()then QualityOrderLines.DeleteAll();
        Rec.Delete();
    end;
}
