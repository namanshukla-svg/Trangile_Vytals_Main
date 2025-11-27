Page 50125 "Rcpt. Quality Order Card"
{
    Caption = 'Quality Order Card';
    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = Document;
    SourceTable = "SSD Quality Order Header";
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

                    trigger OnValidate()
                    begin
                        //Alle_012119
                        Item.Get(Rec."No.");
                        Rec."Description 3":=Item."Description 3";
                    //Alle_012119
                    end;
                }
                field("No.2"; Rec."No.2")
                {
                    ApplicationArea = All;
                    Editable = false;
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
                field("Vendor Item Description"; Rec."Vendor Item Description")
                {
                    ToolTip = 'Specifies the value of the Vendor Item Description field.';
                }
                field("Supplier Batch No."; Rec."Supplier Batch No.")
                {
                    ApplicationArea = All;
                }
                field("Sampling Temp. No."; Rec."Sampling Temp. No.")
                {
                    ApplicationArea = All;

                    trigger OnLookup(var Text: Text): Boolean var
                        FrmItemSamplingTemp: Page "Item Sampling Templates";
                        ItemSamplingTempocal: Record "Item Sampling Template";
                    begin
                        Clear(FrmItemSamplingTemp);
                        ItemSamplingTempocal.Reset;
                        ItemSamplingTempocal.FilterGroup(2);
                        ItemSamplingTempocal.SetCurrentkey("Item Code", "Template Type", Active);
                        ItemSamplingTempocal.SetRange("Item Code", Rec."Item No.");
                        ItemSamplingTempocal.SetRange("Template Type", Rec."Template Type");
                        ItemSamplingTempocal.SetRange(Active, true);
                        ItemSamplingTempocal.FilterGroup(0);
                        if ItemSamplingTempocal.Find('-')then begin
                            FrmItemSamplingTemp.SetTableview(ItemSamplingTempocal);
                            FrmItemSamplingTemp.LookupMode(true);
                            FrmItemSamplingTemp.Editable(false);
                            if FrmItemSamplingTemp.RunModal = Action::LookupOK then begin
                                FrmItemSamplingTemp.GetRecord(ItemSamplingTempocal);
                                Rec.Validate("Sampling Temp. No.", ItemSamplingTempocal."Sampling Temp. No.");
                                CurrPage.SubForm.Page.CreateQualityOrderLine(Rec);
                            end;
                        end;
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
                field("Is NABL Accredited"; Rec."Is NABL Accredited")
                {
                    ApplicationArea = All;
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
                field("Source Code"; Rec."Source Code")
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
                    Editable = "Sample SizeEditable";

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
                    Editable = true;
                }
                field("Is Coil Type"; Rec."Is Coil Type")
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
                field("Total Qty. Sent For Inspet(K)"; Rec."Total Qty. Sent For Inspet(K)")
                {
                    ApplicationArea = All;
                }
                field("Accepted Under Deviation"; Rec."Accepted Under Deviation")
                {
                    ApplicationArea = All;
                }
                field("PPC Dev. Req. Ref. No."; Rec."PPC Dev. Req. Ref. No.")
                {
                    ApplicationArea = All;
                }
                field("Source Document No."; Rec."Source Document No.")
                {
                    ApplicationArea = All;
                }
                field("ULR No."; Rec."ULR No.")
                {
                    ApplicationArea = All;
                }
                field("Manufacturing Date As Label"; Rec."Manufacturing Date As Label")
                {
                    ApplicationArea = All;
                }
            }
            part(SubForm; "Rcpt. Quality Order Subform")
            {
                ApplicationArea = all;
                SubPageLink = "Document No."=field("No."), "Template Type"=field("Template Type");
                SubPageView = sorting("Document No.", "Line No.")order(ascending);
            }
            group(Source)
            {
                Caption = 'Source';

                field("Entry Source Type"; Rec."Entry Source Type")
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
                field("Defect Code"; Rec."Defect Code")
                {
                    ApplicationArea = All;
                }
                field("Vendor Claim Code"; Rec."Vendor Claim Code")
                {
                    ApplicationArea = All;
                    Editable = "Vendor Claim CodeEditable";
                }
                field("Rejected Coil Nos."; Rec."Rejected Coil Nos.")
                {
                    ApplicationArea = All;
                }
                field("Lot No."; Rec."Lot No.")
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
                field("Concerted Quality"; Rec."Concerted Quality")
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
                separator(Action1000000069)
                {
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
                        Rec.CheckingOfQualityOrder(Rec);
                        Rec.Status:=Rec.Status::Released;
                        Rec.Modify;
                    end;
                }
                separator(Action1000000059)
                {
                }
                action("Create Sub Quality Order")
                {
                    ApplicationArea = All;
                    Caption = 'Create Sub Quality Order';

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
        if Rec."Manufacturing Date As Label" = 0D then Rec."Manufacturing Date As Label":=Rec."Posting Date";
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
        // if UserMgt.GetRespCenterFilter() <> '' then begin
        //     Rec.FilterGroup(2);
        //     Rec.SetRange("Responsibility Center", UserMgt.GetRespCenterFilter);
        //     Rec.FilterGroup(0);
        // end;
        Rec.FilterGroup(2);
        if Rec.GetFilter("Template Type") <> '' then CurrPage.Caption:=Rec.GetFilter("Template Type") + '-' + CurrPage.Caption;
        Rec.FilterGroup(0);
        //5.51 to automate qaulity line
        QualityOrderLine1.Reset;
        QualityOrderLine1.SetRange(QualityOrderLine1."Document No.", Rec."No.");
        if not(QualityOrderLine1.FindFirst)then if Rec."Sampling Temp. No." <> '' then begin
                CurrPage.SubForm.Page.CreateQualityOrderLine(Rec);
                Rec."Sample Size":=Rec."Lot Size";
                Rec."Accepted Qty.":=Rec."Lot Size";
                Rec.Modify;
            end;
        //5.51
        OnActivateForm;
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
    Item: Record Item;
    procedure SubformRefresh()
    begin
        CurrPage.SubForm.Page.RefreshForm;
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
}
