Report 50290 "FG vs RM Requirement For 12 Mo"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/FG vs RM Requirement For 12 Mo.rdl';
    Caption = 'FG vs RM Requirement';
    UsageCategory = ReportsandAnalysis;
    ApplicationArea = all;

    dataset
    {
        dataitem(Item; Item)
        {
            DataItemTableView = sorting("No.");
            RequestFilterFields = "No.", "Search Description", "Inventory Posting Group";

            column(ReportForNavId_8129;8129)
            {
            }
            column(AsOfCalcDate; Text000 + Format(CalculateDate))
            {
            }
            column(CompanyName; COMPANYNAME)
            {
            }
            column(TodayFormatted; Format(Today, 0, 4))
            {
            }
            column(ItemTableCaptionFilter; TableCaption + ': ' + ItemFilter)
            {
            }
            column(ItemFilter; ItemFilter)
            {
            }
            column(QtyExplosionofBOMCapt; QtyExplosionofBOMCaptLbl)
            {
            }
            column(CurrReportPageNoCapt; CurrReportPageNoCaptLbl)
            {
            }
            column(Detail; Detail)
            {
            }
            column(Cummulative; Cummulative)
            {
            }
            dataitem(BOMLoop; "Integer")
            {
                DataItemTableView = sorting(Number);

                column(ReportForNavId_8778;8778)
                {
                }
                dataitem("Integer"; "Integer")
                {
                    DataItemTableView = sorting(Number);
                    MaxIteration = 1;

                    column(ReportForNavId_5444;5444)
                    {
                    }
                    trigger OnAfterGetRecord()
                    var
                        DateRec: Record Date;
                        ProductionForecastEntry: Record "Production Forecast Entry";
                        I: Integer;
                    begin
                        BOMQty:=Quantity[Level] * QtyPerUnitOfMeasure * BomComponent[Level].Quantity;
                        FGBomQuantityPer.Init;
                        FGBomQuantityPer.Code:=CreateGuid;
                        FGBomQuantityPer.Description:=UserId;
                        FGBomQuantityPer."Parent Item No.":=Item."No.";
                        FGBomQuantityPer."Parent Description":=Item.Description;
                        FGBomQuantityPer."Item Category Code":=Item."Item Category Code";
                        FGBomQuantityPer."Raw Material Item No.":=BomComponent[Level]."No.";
                        FGBomQuantityPer."Quantity Per":=BOMQty;
                        FGBomQuantityPer."Raw Material Description":=BomComponent[Level].Description;
                        FGBomQuantityPer."Unit of Measure":=BomComponent[Level]."Unit of Measure Code";
                        I:=1;
                        DateRec.SetRange("Period Type", DateRec."period type"::Month);
                        DateRec.SetRange("Period Start", "Start Date", "End Date");
                        if DateRec.FindSet then repeat if I = 1 then begin
                                    Clear(TotalQTYM1);
                                    FGBomQuantityPer."PF M1 Name":=DateRec."Period Name";
                                    ProductionForecastEntry.Reset;
                                    ProductionForecastEntry.SetRange("Production Forecast Name", 'KEYPROFO12');
                                    ProductionForecastEntry.SetRange("Forecast Date", DateRec."Period Start", DateRec."Period End");
                                    ProductionForecastEntry.SetRange("Item No.", Item."No.");
                                    if ProductionForecastEntry.FindFirst then FGBomQuantityPer."Prod. Forecast M1":=ProductionForecastEntry."Forecast Quantity";
                                end;
                                if I = 2 then begin
                                    Clear(TotalQTYM2);
                                    FGBomQuantityPer."PF M2 Name":=DateRec."Period Name";
                                    ProductionForecastEntry.Reset;
                                    ProductionForecastEntry.SetRange("Production Forecast Name", 'KEYPROFO12');
                                    ProductionForecastEntry.SetRange("Forecast Date", DateRec."Period Start", DateRec."Period End");
                                    ProductionForecastEntry.SetRange("Item No.", Item."No.");
                                    if ProductionForecastEntry.FindFirst then FGBomQuantityPer."Prod. Forecast M2":=ProductionForecastEntry."Forecast Quantity";
                                end;
                                if I = 3 then begin
                                    Clear(TotalQTYM3);
                                    FGBomQuantityPer."PF M3 Name":=DateRec."Period Name";
                                    ProductionForecastEntry.Reset;
                                    ProductionForecastEntry.SetRange("Production Forecast Name", 'KEYPROFO12');
                                    ProductionForecastEntry.SetRange("Forecast Date", DateRec."Period Start", DateRec."Period End");
                                    ProductionForecastEntry.SetRange("Item No.", Item."No.");
                                    if ProductionForecastEntry.FindFirst then FGBomQuantityPer."Prod. Forecast M3":=ProductionForecastEntry."Forecast Quantity";
                                end;
                                if I = 4 then begin
                                    Clear(TotalQTYM4);
                                    FGBomQuantityPer."PF M4 Name":=DateRec."Period Name";
                                    ProductionForecastEntry.Reset;
                                    ProductionForecastEntry.SetRange("Production Forecast Name", 'KEYPROFO12');
                                    ProductionForecastEntry.SetRange("Forecast Date", DateRec."Period Start", DateRec."Period End");
                                    ProductionForecastEntry.SetRange("Item No.", Item."No.");
                                    if ProductionForecastEntry.FindFirst then FGBomQuantityPer."Prod. Forecast M4":=ProductionForecastEntry."Forecast Quantity";
                                end;
                                if I = 5 then begin
                                    Clear(TotalQTYM5);
                                    FGBomQuantityPer."PF M5 Name":=DateRec."Period Name";
                                    ProductionForecastEntry.Reset;
                                    ProductionForecastEntry.SetRange("Production Forecast Name", 'KEYPROFO12');
                                    ProductionForecastEntry.SetRange("Forecast Date", DateRec."Period Start", DateRec."Period End");
                                    ProductionForecastEntry.SetRange("Item No.", Item."No.");
                                    if ProductionForecastEntry.FindFirst then FGBomQuantityPer."Prod. Forecast M5":=ProductionForecastEntry."Forecast Quantity";
                                end;
                                if I = 6 then begin
                                    Clear(TotalQTYM6);
                                    FGBomQuantityPer."PF M6 Name":=DateRec."Period Name";
                                    ProductionForecastEntry.Reset;
                                    ProductionForecastEntry.SetRange("Production Forecast Name", 'KEYPROFO12');
                                    ProductionForecastEntry.SetRange("Forecast Date", DateRec."Period Start", DateRec."Period End");
                                    ProductionForecastEntry.SetRange("Item No.", Item."No.");
                                    if ProductionForecastEntry.FindFirst then FGBomQuantityPer."Prod. Forecast M6":=ProductionForecastEntry."Forecast Quantity";
                                end;
                                if I = 7 then begin
                                    Clear(TotalQTYM7);
                                    FGBomQuantityPer."PF M7 Name":=DateRec."Period Name";
                                    ProductionForecastEntry.Reset;
                                    ProductionForecastEntry.SetRange("Production Forecast Name", 'KEYPROFO12');
                                    ProductionForecastEntry.SetRange("Forecast Date", DateRec."Period Start", DateRec."Period End");
                                    ProductionForecastEntry.SetRange("Item No.", Item."No.");
                                    if ProductionForecastEntry.FindFirst then FGBomQuantityPer."Prod. Forecast M7":=ProductionForecastEntry."Forecast Quantity";
                                end;
                                if I = 8 then begin
                                    Clear(TotalQTYM8);
                                    FGBomQuantityPer."PF M8 Name":=DateRec."Period Name";
                                    ProductionForecastEntry.Reset;
                                    ProductionForecastEntry.SetRange("Production Forecast Name", 'KEYPROFO12');
                                    ProductionForecastEntry.SetRange("Forecast Date", DateRec."Period Start", DateRec."Period End");
                                    ProductionForecastEntry.SetRange("Item No.", Item."No.");
                                    if ProductionForecastEntry.FindFirst then FGBomQuantityPer."Prod. Forecast M8":=ProductionForecastEntry."Forecast Quantity";
                                end;
                                if I = 9 then begin
                                    Clear(TotalQTYM9);
                                    FGBomQuantityPer."PF M9 Name":=DateRec."Period Name";
                                    ProductionForecastEntry.Reset;
                                    ProductionForecastEntry.SetRange("Production Forecast Name", 'KEYPROFO12');
                                    ProductionForecastEntry.SetRange("Forecast Date", DateRec."Period Start", DateRec."Period End");
                                    ProductionForecastEntry.SetRange("Item No.", Item."No.");
                                    if ProductionForecastEntry.FindFirst then FGBomQuantityPer."Prod. Forecast M9":=ProductionForecastEntry."Forecast Quantity";
                                end;
                                if I = 10 then begin
                                    Clear(TotalQTYM10);
                                    FGBomQuantityPer."PF M10 Name":=DateRec."Period Name";
                                    ProductionForecastEntry.Reset;
                                    ProductionForecastEntry.SetRange("Production Forecast Name", 'KEYPROFO12');
                                    ProductionForecastEntry.SetRange("Forecast Date", DateRec."Period Start", DateRec."Period End");
                                    ProductionForecastEntry.SetRange("Item No.", Item."No.");
                                    if ProductionForecastEntry.FindFirst then FGBomQuantityPer."Prod. Forecast M10":=ProductionForecastEntry."Forecast Quantity";
                                end;
                                if I = 11 then begin
                                    Clear(TotalQTYM11);
                                    FGBomQuantityPer."PF M11 Name":=DateRec."Period Name";
                                    ProductionForecastEntry.Reset;
                                    ProductionForecastEntry.SetRange("Production Forecast Name", 'KEYPROFO12');
                                    ProductionForecastEntry.SetRange("Forecast Date", DateRec."Period Start", DateRec."Period End");
                                    ProductionForecastEntry.SetRange("Item No.", Item."No.");
                                    if ProductionForecastEntry.FindFirst then FGBomQuantityPer."Prod. Forecast M11":=ProductionForecastEntry."Forecast Quantity";
                                end;
                                if I = 12 then begin
                                    Clear(TotalQTYM12);
                                    FGBomQuantityPer."PF M12 Name":=DateRec."Period Name";
                                    ProductionForecastEntry.Reset;
                                    ProductionForecastEntry.SetRange("Production Forecast Name", 'KEYPROFO12');
                                    ProductionForecastEntry.SetRange("Forecast Date", DateRec."Period Start", DateRec."Period End");
                                    ProductionForecastEntry.SetRange("Item No.", Item."No.");
                                    if ProductionForecastEntry.FindFirst then FGBomQuantityPer."Prod. Forecast M12":=ProductionForecastEntry."Forecast Quantity";
                                end;
                                I+=1;
                            until DateRec.Next = 0;
                        FGBomQuantityPer.Insert;
                    end;
                    trigger OnPostDataItem()
                    begin
                        Level:=NextLevel;
                    end;
                }
                trigger OnAfterGetRecord()
                var
                    BomItem: Record Item;
                begin
                    while BomComponent[Level].Next = 0 do begin
                        Level:=Level - 1;
                        if Level < 1 then CurrReport.Break;
                    end;
                    NextLevel:=Level;
                    Clear(CompItem);
                    QtyPerUnitOfMeasure:=1;
                    case BomComponent[Level].Type of BomComponent[Level].Type::Item: begin
                        CompItem.Get(BomComponent[Level]."No.");
                        if CompItem."Production BOM No." <> '' then begin
                            ProdBOM.Get(CompItem."Production BOM No.");
                            if ProdBOM.Status = ProdBOM.Status::Closed then CurrReport.Skip;
                            NextLevel:=Level + 1;
                            if Level > 1 then if(NextLevel > 50) or (BomComponent[Level]."No." = NoList[Level - 1])then Error(ProdBomErr, 50, Item."No.", NoList[Level], Level);
                            Clear(BomComponent[NextLevel]);
                            NoListType[NextLevel]:=NoListType[NextLevel]::Item;
                            NoList[NextLevel]:=CompItem."No.";
                            VersionCode[NextLevel]:=VersionMgt.GetBOMVersion(CompItem."Production BOM No.", CalculateDate, true);
                            BomComponent[NextLevel].SetRange("Production BOM No.", CompItem."Production BOM No.");
                            BomComponent[NextLevel].SetRange("Version Code", VersionCode[NextLevel]);
                            BomComponent[NextLevel].SetFilter("Starting Date", '%1|..%2', 0D, CalculateDate);
                            BomComponent[NextLevel].SetFilter("Ending Date", '%1|%2..', 0D, CalculateDate);
                        end;
                        if Level > 1 then if BomComponent[Level - 1].Type = BomComponent[Level - 1].Type::Item then if BomItem.Get(BomComponent[Level - 1]."No.")then QtyPerUnitOfMeasure:=UOMMgt.GetQtyPerUnitOfMeasure(BomItem, BomComponent[Level - 1]."Unit of Measure Code") / UOMMgt.GetQtyPerUnitOfMeasure(BomItem, VersionMgt.GetBOMUnitOfMeasure(BomItem."Production BOM No.", VersionCode[Level]));
                    end;
                    BomComponent[Level].Type::"Production BOM": begin
                        ProdBOM.Get(BomComponent[Level]."No.");
                        if ProdBOM.Status = ProdBOM.Status::Closed then CurrReport.Skip;
                        NextLevel:=Level + 1;
                        if Level > 1 then if(NextLevel > 50) or (BomComponent[Level]."No." = NoList[Level - 1])then Error(ProdBomErr, 50, Item."No.", NoList[Level], Level);
                        Clear(BomComponent[NextLevel]);
                        NoListType[NextLevel]:=NoListType[NextLevel]::"Production BOM";
                        NoList[NextLevel]:=ProdBOM."No.";
                        VersionCode[NextLevel]:=VersionMgt.GetBOMVersion(ProdBOM."No.", CalculateDate, true);
                        BomComponent[NextLevel].SetRange("Production BOM No.", NoList[NextLevel]);
                        BomComponent[NextLevel].SetRange("Version Code", VersionCode[NextLevel]);
                        BomComponent[NextLevel].SetFilter("Starting Date", '%1|..%2', 0D, CalculateDate);
                        BomComponent[NextLevel].SetFilter("Ending Date", '%1|%2..', 0D, CalculateDate);
                    end;
                    end;
                    if NextLevel <> Level then Quantity[NextLevel]:=BomComponent[NextLevel - 1].Quantity * QtyPerUnitOfMeasure * Quantity[Level];
                end;
                trigger OnPreDataItem()
                begin
                    Level:=1;
                    ProdBOM.Get(Item."Production BOM No.");
                    VersionCode[Level]:=VersionMgt.GetBOMVersion(Item."Production BOM No.", CalculateDate, true);
                    Clear(BomComponent);
                    BomComponent[Level]."Production BOM No.":=Item."Production BOM No.";
                    BomComponent[Level].SetRange("Production BOM No.", Item."Production BOM No.");
                    BomComponent[Level].SetRange("Version Code", VersionCode[Level]);
                    BomComponent[Level].SetFilter("Starting Date", '%1|..%2', 0D, CalculateDate);
                    BomComponent[Level].SetFilter("Ending Date", '%1|%2..', 0D, CalculateDate);
                    NoListType[Level]:=NoListType[Level]::Item;
                    NoList[Level]:=Item."No.";
                    Quantity[Level]:=UOMMgt.GetQtyPerUnitOfMeasure(Item, Item."Base Unit of Measure") / UOMMgt.GetQtyPerUnitOfMeasure(Item, VersionMgt.GetBOMUnitOfMeasure(Item."Production BOM No.", VersionCode[Level]));
                end;
            }
            trigger OnPreDataItem()
            var
                FGBomQuantityPer2: Record "SSD FG Bom Quantity Per";
            begin
                ItemFilter:=GetFilters;
                SetFilter("Production BOM No.", '<>%1', '');
                "Start Date":=CalcDate('-CM', CalculateDate);
                "End Date":=CalcDate('12M', "Start Date");
                FGBomQuantityPer2.Reset;
                FGBomQuantityPer2.SetRange(Description, UserId);
                FGBomQuantityPer2.DeleteAll;
            end;
        }
        dataitem("FG Bom Quantity Per"; "SSD FG Bom Quantity Per")
        {
            column(ReportForNavId_1000000001;1000000001)
            {
            }
            column(PFM1Name_FGBomQuantityPer; CopyStr("PF M1 Name", 1, 3) + '-' + Format(Date2dmy(CalculateDate, 3)))
            {
            }
            column(PFM2Name_FGBomQuantityPer; CopyStr("PF M2 Name", 1, 3) + '-' + Format(Date2dmy(CalculateDate, 3)))
            {
            }
            column(PFM3Name_FGBomQuantityPer; CopyStr("PF M3 Name", 1, 3) + '-' + Format(Date2dmy(CalculateDate, 3)))
            {
            }
            column(PFM4Name_FGBomQuantityPer; CopyStr("PF M4 Name", 1, 3) + '-' + Format(Date2dmy(CalculateDate, 3)))
            {
            }
            column(PFM5Name_FGBomQuantityPer; CopyStr("PF M5 Name", 1, 3) + '-' + Format(Date2dmy(CalculateDate, 3)))
            {
            }
            column(PFM6Name_FGBomQuantityPer; CopyStr("PF M6 Name", 1, 3) + '-' + Format(Date2dmy(CalculateDate, 3)))
            {
            }
            column(PFM7Name_FGBomQuantityPer; CopyStr("PF M7 Name", 1, 3) + '-' + Format(Date2dmy(CalculateDate, 3)))
            {
            }
            column(PFM8Name_FGBomQuantityPer; CopyStr("PF M8 Name", 1, 3) + '-' + Format(Date2dmy(CalculateDate, 3)))
            {
            }
            column(PFM9Name_FGBomQuantityPer; CopyStr("PF M9 Name", 1, 3) + '-' + Format(Date2dmy(CalculateDate, 3)))
            {
            }
            column(PFM10Name_FGBomQuantityPer; CopyStr("PF M10 Name", 1, 3) + '-' + Format(Date2dmy(CalculateDate, 3)))
            {
            }
            column(PFM11Name_FGBomQuantityPer; CopyStr("PF M11 Name", 1, 3) + '-' + Format(Date2dmy(CalculateDate, 3)))
            {
            }
            column(PFM12Name_FGBomQuantityPer; CopyStr("PF M12 Name", 1, 3) + '-' + Format(Date2dmy(CalculateDate, 3)))
            {
            }
            column(ParentDescription_FGBomQuantityPer; "Parent Description")
            {
            }
            column(ItemCategoryCode_FGBomQuantityPer; "Item Category Code")
            {
            }
            column(ProdForecastM1_FGBomQuantityPer; "Prod. Forecast M1")
            {
            }
            column(ProdForecastM2_FGBomQuantityPer; "Prod. Forecast M2")
            {
            }
            column(ProdForecastM3_FGBomQuantityPer; "Prod. Forecast M3")
            {
            }
            column(ProdForecastM4_FGBomQuantityPer; "Prod. Forecast M4")
            {
            }
            column(ProdForecastM5_FGBomQuantityPer; "FG Bom Quantity Per"."Prod. Forecast M5")
            {
            }
            column(ProdForecastM6_FGBomQuantityPer; "FG Bom Quantity Per"."Prod. Forecast M6")
            {
            }
            column(ProdForecastM7_FGBomQuantityPer; "FG Bom Quantity Per"."Prod. Forecast M7")
            {
            }
            column(ProdForecastM8_FGBomQuantityPer; "FG Bom Quantity Per"."Prod. Forecast M8")
            {
            }
            column(ProdForecastM9_FGBomQuantityPer; "FG Bom Quantity Per"."Prod. Forecast M9")
            {
            }
            column(ProdForecastM10_FGBomQuantityPer; "FG Bom Quantity Per"."Prod. Forecast M10")
            {
            }
            column(ProdForecastM11_FGBomQuantityPer; "FG Bom Quantity Per"."Prod. Forecast M11")
            {
            }
            column(ProdForecastM12_FGBomQuantityPer; "FG Bom Quantity Per"."Prod. Forecast M12")
            {
            }
            column(RawMaterialDescription_FGBomQuantityPer; "Raw Material Description")
            {
            }
            column(UnitofMeasure_FGBomQuantityPer; "Unit of Measure")
            {
            }
            column(QuantityPer_FGBomQuantityPer; "Quantity Per")
            {
            }
            column(RawMaterialItemNo_FGBomQuantityPer; "Raw Material Item No.")
            {
            }
            column(ParentItemNo_FGBomQuantityPer; "Parent Item No.")
            {
            }
            column(TotalQTYM1; "Prod. Forecast M1" * "Quantity Per")
            {
            }
            column(TotalQTYM2; "Prod. Forecast M2" * "Quantity Per")
            {
            }
            column(TotalQTYM3; "Prod. Forecast M3" * "Quantity Per")
            {
            }
            column(TotalQTYM4; "Prod. Forecast M4" * "Quantity Per")
            {
            }
            column(TotalQTYM5; "Prod. Forecast M5" * "Quantity Per")
            {
            }
            column(TotalQTYM6; "Prod. Forecast M6" * "Quantity Per")
            {
            }
            column(TotalQTYM7; "Prod. Forecast M7" * "Quantity Per")
            {
            }
            column(TotalQTYM8; "Prod. Forecast M8" * "Quantity Per")
            {
            }
            column(TotalQTYM9; "Prod. Forecast M9" * "Quantity Per")
            {
            }
            column(TotalQTYM10; "Prod. Forecast M10" * "Quantity Per")
            {
            }
            column(TotalQTYM11; "Prod. Forecast M11" * "Quantity Per")
            {
            }
            column(TotalQTYM12; "Prod. Forecast M12" * "Quantity Per")
            {
            }
            trigger OnAfterGetRecord()
            var
                DateRec: Record Date;
                ProductionForecastEntry: Record "Production Forecast Entry";
                I: Integer;
            begin
            end;
            trigger OnPreDataItem()
            begin
                "FG Bom Quantity Per".SetRange(Description, UserId);
            end;
        }
    }
    requestpage
    {
        layout
        {
            area(content)
            {
                group(Options)
                {
                    Caption = 'Options';

                    field(CalculateDate; CalculateDate)
                    {
                        ApplicationArea = All;
                        Caption = 'Calculation Date';
                    }
                    field(Detail; Detail)
                    {
                        ApplicationArea = All;
                        Caption = 'Detail';
                    }
                    field(Cummulative; Cummulative)
                    {
                        ApplicationArea = All;
                        Caption = 'Cummulative';
                    }
                }
            }
        }
        actions
        {
        }
        trigger OnInit()
        begin
            CalculateDate:=WorkDate;
        end;
    }
    labels
    {
    }
    var Text000: label 'As of ';
    ProdBOM: Record "Production BOM Header";
    BomComponent: array[99]of Record "Production BOM Line";
    CompItem: Record Item;
    UOMMgt: Codeunit "Unit of Measure Management";
    VersionMgt: Codeunit VersionManagement;
    ItemFilter: Text;
    CalculateDate: Date;
    NoList: array[99]of Code[20];
    VersionCode: array[99]of Code[20];
    Quantity: array[99]of Decimal;
    QtyPerUnitOfMeasure: Decimal;
    Level: Integer;
    NextLevel: Integer;
    BOMQty: Decimal;
    QtyExplosionofBOMCaptLbl: label 'FG vs RM Requirement';
    CurrReportPageNoCaptLbl: label 'Page';
    BOMQtyCaptionLbl: label 'Total Quantity';
    BomCompLevelQtyCaptLbl: label 'BOM Quantity';
    BomCompLevelDescCaptLbl: label 'Description';
    BomCompLevelNoCaptLbl: label 'No.';
    LevelCaptLbl: label 'Level';
    BomCompLevelUOMCodeCaptLbl: label 'Unit of Measure Code';
    NoListType: array[99]of Option " ", Item, "Production BOM";
    ProdBomErr: label 'The maximum number of BOM levels, %1, was exceeded. The process stopped at item number %2, BOM header number %3, BOM level %4.';
    FGBomQuantityPer: Record "SSD FG Bom Quantity Per";
    RequestDate: Date;
    "Start Date": Date;
    "End Date": Date;
    TotalQTYM1: Decimal;
    TotalQTYM2: Decimal;
    TotalQTYM3: Decimal;
    TotalQTYM4: Decimal;
    Detail: Boolean;
    Cummulative: Boolean;
    TotalQTYM5: Decimal;
    TotalQTYM6: Decimal;
    TotalQTYM7: Decimal;
    TotalQTYM8: Decimal;
    TotalQTYM9: Decimal;
    TotalQTYM10: Decimal;
    TotalQTYM11: Decimal;
    TotalQTYM12: Decimal;
}
