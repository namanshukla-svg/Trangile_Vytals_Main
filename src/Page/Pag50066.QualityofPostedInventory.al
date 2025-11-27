Page 50066 "Quality of Posted Inventory"
{
    ApplicationArea = All;
    Editable = false;
    PageType = List;
    SourceTable = "Item Ledger Entry";
    SourceTableView = sorting("Document No.", "Posting Date", "Item No.")where(Quantity=filter(>0), "Lot No."=filter(<>''), "Posted Quality Order No."=filter(''));
    UsageCategory = Tasks;

    layout
    {
        area(content)
        {
            repeater(Control1000000000)
            {
                field("Document No."; Rec."Document No.")
                {
                    ApplicationArea = All;
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = All;
                }
                field("Item No."; Rec."Item No.")
                {
                    ApplicationArea = All;
                }
                field("Location Code"; Rec."Location Code")
                {
                    ApplicationArea = All;
                }
                field(Quantity; Rec.Quantity)
                {
                    ApplicationArea = All;
                }
                field("Lot No."; Rec."Lot No.")
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
            group("Function")
            {
                action("Create Quality")
                {
                    ApplicationArea = All;
                    Caption = 'Create Quality';

                    trigger OnAction()
                    var
                        MRNQOHDR: Record "SSD Quality Order Header";
                        ItemSamplingTemp1: Record "Item Sampling Template";
                        ItemLedgerEntry1: Record "Item Ledger Entry";
                        PostedQltOderHdr: Record "SSD Posted Quality Order Hdr";
                        QualityorderHeader1: Record "SSD Quality Order Header";
                        SamplingTempLineLocal: Record "SSD Sampling Temp. Line";
                        QualityOrderLineLocal: Record "SSD Quality Order Line";
                        RecItem: Record Item;
                        ItemRouting: Record "Routing Line";
                    begin
                        //<<<< ALLE[5.51]
                        OptionValue:=StrMenu(Text001);
                        if OptionValue = 0 then exit;
                        K:=1;
                        ItemLedgerEntry1.Reset;
                        CurrPage.SetSelectionFilter(ItemLedgerEntry1);
                        if ItemLedgerEntry1.FindFirst then repeat if ItemLedgerEntry1."Lot No." <> '' then begin
                                    //***** Checking for existing posted quality *******//
                                    PostedQltOderHdr.Reset;
                                    PostedQltOderHdr.SetRange(PostedQltOderHdr."Lot No.", ItemLedgerEntry1."Lot No.");
                                    if PostedQltOderHdr.FindFirst then begin
                                        Error('Quality order already exit for this entry');
                                    end;
                                    //***** Checking for existing unposted posted quality *******//
                                    QualityorderHeader1.Reset;
                                    QualityorderHeader1.SetRange(QualityorderHeader1."Lot No.", ItemLedgerEntry1."Lot No.");
                                    if QualityorderHeader1.FindFirst then begin
                                        Error('Quality order already exit for this entry');
                                    end;
                                    MRNQOHDR.Init;
                                    if OptionValue = 1 then MRNQOHDR."Template Type":=MRNQOHDR."template type"::Receipt;
                                    if OptionValue = 2 then MRNQOHDR."Template Type":=MRNQOHDR."template type"::Manufacturing;
                                    if OptionValue = 1 then MRNQOHDR."Entry Source Type":=MRNQOHDR."entry source type"::MRN;
                                    if OptionValue = 2 then MRNQOHDR."Entry Source Type":=MRNQOHDR."entry source type"::"Manufac.";
                                    if OptionValue = 2 then begin
                                        if RecItem.Get(Rec."Item No.")then begin
                                            MRNQOHDR."Routing No.":=RecItem."Routing No.";
                                            if ItemRouting.Get(RecItem."Routing No.")then MRNQOHDR."W.C. / M.C. No.":=ItemRouting."Work Center No.";
                                            MRNQOHDR."Source Code":=Rec."Document No.";
                                            MRNQOHDR."Source Doc Date":=Rec."Posting Date";
                                        end;
                                    end;
                                    MRNQOHDR."Source Document No.":=Rec."Document No.";
                                    MRNQOHDR."Creation Date":=WorkDate;
                                    MRNQOHDR."Source Doc. Line No.":=Rec."Entry No.";
                                    MRNQOHDR."Order No.":=Rec."Document No.";
                                    MRNQOHDR."Sampling Method":=MRNQOHDR."sampling method"::"Complete Quantity";
                                    MRNQOHDR."Item No.":=Rec."Item No.";
                                    MRNQOHDR."Unit of Measure Code":=Rec."Unit of Measure Code";
                                    MRNQOHDR."Qty. per Unit of Measure":=Rec."Qty. per Unit of Measure";
                                    MRNQOHDR."Variant Code":=Rec."Variant Code";
                                    MRNQOHDR."Location Code":=Rec."Location Code";
                                    MRNQOHDR."Bin Code":=Rec."Bin Code";
                                    MRNQOHDR."Lot Size":=Rec.Quantity;
                                    MRNQOHDR."Lot No.":=Rec."Lot No.";
                                    ItemSamplingTemp1.Reset;
                                    ItemSamplingTemp1.SetRange(ItemSamplingTemp1."Item Code", Rec."Item No.");
                                    ItemSamplingTemp1.SetRange(ItemSamplingTemp1.Active, true);
                                    if ItemSamplingTemp1.FindFirst then MRNQOHDR."Sampling Temp. No.":=ItemSamplingTemp1."Sampling Temp. No.";
                                    MRNQOHDR."No. Series":=MRNQOHDR.GetNoSeries(true);
                                    MRNQOHDR."No.":='';
                                    MRNQOHDR."Entry User":=UserId;
                                    MRNQOHDR."Posting Date":=WorkDate;
                                    MRNQOHDR.Insert(true);
                                    //****
                                    if OptionValue = 2 then begin
                                        LineNo:=10000;
                                        SamplingTempLineLocal.Reset;
                                        SamplingTempLineLocal.SetRange("Document No.", Rec."Item No.");
                                        if SamplingTempLineLocal.FindFirst then repeat QualityOrderLineLocal.TransferFields(SamplingTempLineLocal);
                                                QualityOrderLineLocal."Document No.":=MRNQOHDR."No.";
                                                QualityOrderLineLocal."Sampling Template No.":=SamplingTempLineLocal."Document No.";
                                                QualityOrderLineLocal."Template Type":=QualityOrderLineLocal."template type"::Manufacturing;
                                                QualityOrderLineLocal."Line No.":=LineNo;
                                                LineNo:=LineNo + 10000;
                                                QualityOrderLineLocal.Insert;
                                            until SamplingTempLineLocal.Next = 0;
                                    end;
                                    //****
                                    K+=1;
                                end;
                            until ItemLedgerEntry1.Next = 0;
                        if K > 1 then Message('%1 Quality Order has been created', ItemLedgerEntry1.Count);
                        Rec.Reset;
                        Rec.Copy(ItemLedgerEntry1);
                    //>>>> ALLE[5.51]
                    end;
                }
                action("View & Post Quality Order")
                {
                    ApplicationArea = All;
                    Caption = 'View & Post Quality Order';

                    trigger OnAction()
                    var
                        QualityOrdHdrLocal: Record "SSD Quality Order Header";
                        FrmQltOrderList: Page "Quality Order List";
                    begin
                        //<<< ALLE[5.51]
                        QualityOrdHdrLocal.Reset;
                        //QualityOrdHdrLocal.FILTERGROUP(2);
                        if OptionValue = 1 then QualityOrdHdrLocal.SetRange("Template Type", QualityOrdHdrLocal."template type"::Receipt)
                        else
                            QualityOrdHdrLocal.SetRange("Template Type", QualityOrdHdrLocal."template type"::Manufacturing);
                        if OptionValue = 1 then QualityOrdHdrLocal.SetRange("Entry Source Type", QualityOrdHdrLocal."entry source type"::MRN)
                        else
                            QualityOrdHdrLocal.SetRange("Entry Source Type", QualityOrdHdrLocal."entry source type"::"Manufac.");
                        QualityOrdHdrLocal.SetRange(QualityOrdHdrLocal."Lot No.", Rec."Lot No.");
                        QualityOrdHdrLocal.SetRange("Source Doc. Line No.", Rec."Entry No.");
                        QualityOrdHdrLocal.FilterGroup(2);
                        if QualityOrdHdrLocal.Find('-')then begin
                            Clear(FrmQltOrderList);
                            FrmQltOrderList.SetTableview(QualityOrdHdrLocal);
                            FrmQltOrderList.RunModal;
                        end;
                    /*
                       CASE "Template Type" OF
                         "Template Type"::Receipt:
                           PAGE.RUN( PAGE::"Rcpt. Quality Order Card", Rec);
                         "Template Type"::Manufacturing :
                           PAGE.RUN( PAGE::"Man. Quality Order Card", Rec);
                       end; */
                    //>>> ALLE[5.51]
                    end;
                }
            }
        }
    }
    var Text001: label 'Receipt,Manufacturing';
    OptionValue: Integer;
    K: Integer;
    LineNo: Integer;
}
