Report 50325 "Zavenir Consumption Report1"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Zavenir Consumption Report1.rdl';
    ApplicationArea = all;
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem("Item Category"; "Item Category")
        {
            DataItemTableView = sorting("Parent Category", Code);
            RequestFilterFields = "Parent Category";

            column(ReportForNavId_6030;6030)
            {
            }
            column(Item_GETFILTERS; Item.GetFilters)
            {
            }
            column(FORMAT_TODAY_0_4_; Format(Today, 0, 4))
            {
            }
            column(COMPANYNAME; COMPANYNAME)
            {
            }
            column(CurrReport_PAGENO; CurrReport.PageNo)
            {
            }
            column(UserId; UserId)
            {
            }
            column(GTotalAvgUnitCost; GTotalAvgUnitCost)
            {
            }
            column(GTotalPeakConsum; GTotalPeakConsum)
            {
            }
            column(Item_Consumption_ReportCaption; Item_Consumption_ReportCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(Avg__Unit_CostCaption; Avg__Unit_CostCaptionLbl)
            {
            }
            column(Peak_Consumption_ValueCaption; Peak_Consumption_ValueCaptionLbl)
            {
            }
            column(Monthly_Avg__Consumption_ValueCaption; Monthly_Avg__Consumption_ValueCaptionLbl)
            {
            }
            column(Monthly_Peak_ComsumptionCaption; Monthly_Peak_ComsumptionCaptionLbl)
            {
            }
            column(Avg__Monthly_Consumption_during_PeriodCaption; Avg__Monthly_Consumption_during_PeriodCaptionLbl)
            {
            }
            column(Lead_Time_Caption; Lead_Time_CaptionLbl)
            {
            }
            column(Description_2Caption; Description_2CaptionLbl)
            {
            }
            column(UOMCaption; UOMCaptionLbl)
            {
            }
            column(Item_CategoryCaption; Item_CategoryCaptionLbl)
            {
            }
            column(DescriptionCaption; DescriptionCaptionLbl)
            {
            }
            column(Item_CodeCaption; Item_CodeCaptionLbl)
            {
            }
            column(Prod__Group_CodeCaption; Prod__Group_CodeCaptionLbl)
            {
            }
            column(Grand_Total_Caption; Grand_Total_CaptionLbl)
            {
            }
            column(Product_Group_Item_Category_Code; code)
            {
            }
            column(Product_Group_Code; Code)
            {
            }
            dataitem(Item; Item)
            {
                DataItemLink = "Item Category Code"=field(Code);
                DataItemTableView = sorting("Item Category Code", "No.")order(ascending);
                RequestFilterFields = "No.", "Item Category Code", "Lead Time Calculation", "Replenishment System", "Date Filter", "Location Filter", "Global Dimension 1 Filter", "Global Dimension 2 Filter";

                column(ReportForNavId_8129;8129)
                {
                }
                column(Item_Item__Product_Group_Code_; "Item Category Code")
                {
                }
                column(Total_ForCaption; Total_ForCaptionLbl)
                {
                }
                column(Item_No_; "No.")
                {
                }
                column(Item_Variant_Filter; "Variant Filter")
                {
                }
                column(Item_Date_Filter; "Date Filter")
                {
                }
                column(Item_Location_Filter; "Location Filter")
                {
                }
                column(Item_Global_Dimension_1_Filter; "Global Dimension 1 Filter")
                {
                }
                column(Item_Global_Dimension_2_Filter; "Global Dimension 2 Filter")
                {
                }
                column(GTotalAvgMonthConsum; GTotalAvgMonthConsum)
                {
                }
                column(Item__Description_; Item.Description)
                {
                }
                column(Item__Base_Unit_of_Measure_; Item."Base Unit of Measure")
                {
                }
                column(Item__Item_Category_Code_; ParentCategory)
                {
                }
                column(Item__Lead_Time_Dispatch_; Item."Lead Time Dispatch")
                {
                }
                column(Item__No__; Item."No.")
                {
                }
                column(Item__Product_Group_Code_; "Item Category Code")
                {
                }
                column(Item_Ledger_Entry_Entry_No_; ItemLedEntry."Entry No.")
                {
                }
                column(Item_Ledger_Entry_Item_No_; "No.")
                {
                }
                column(Item_Ledger_Entry_Variant_Code; ItemLedEntry."Variant Code")
                {
                }
                column(Item_Ledger_Entry_Posting_Date; ItemLedEntry."Posting Date")
                {
                }
                column(Item_Ledger_Entry_Location_Code; ItemLedEntry."Location Code")
                {
                }
                column(Item_Ledger_Entry_Global_Dimension_1_Code; ItemLedEntry."Global Dimension 1 Code")
                {
                }
                column(Item_Ledger_Entry_Global_Dimension_2_Code; ItemLedEntry."Global Dimension 2 Code")
                {
                }
                column(ProductGroupCode_ItemLedgerEntry; ItemLedEntry."Item Category Code")
                {
                }
                column(Test_Value; TestValue)
                {
                }
                column(MonthAvgConsumQty; Abs(AvgMonthConsum))
                {
                }
                column(MonthPeakConsumQty; Abs(MonthPeakConsum))
                {
                }
                column(MonthAvgPeakConsumValue; Abs(MonthAVGConsum))
                {
                }
                column(MonthPeakConsumValue; PeakConsum)
                {
                }
                column(AvgUnitCost; AvgUnitCost)
                {
                }
                column(TotMonthAvgConsumQty; TotMonthlyConsmtionAmt[1])
                {
                }
                column(TotMonthPeakConsumQty; TotMonthlyConsmtionAmt[2])
                {
                }
                column(TotMonthAvgPeakConsumValue; TotMonthlyConsmtionAmt[3])
                {
                }
                column(TotMonthPeakConsumValue; TotMonthlyConsmtionAmt[4])
                {
                }
                column(TotAvgUnitCost;'')
                {
                }
                column(GTotAvgMonthConsumQty; GrandTotMonthlyConsmtionAmt[1])
                {
                }
                column(GTotMonthPeakConsumQty; GrandTotMonthlyConsmtionAmt[2])
                {
                }
                column(GTotAvgMonthPeakConsumValue; GrandTotMonthlyConsmtionAmt[3])
                {
                }
                column(GTotMonthPeakConsumValue; GrandTotMonthlyConsmtionAmt[4])
                {
                }
                column(GTotAvgUnitCost;'')
                {
                }
                column(AvgMonthConsum2; AvgMonthConsum2)
                {
                }
                column(MonthAVGConsum2; MonthAVGConsum2)
                {
                }
                column(MonthPeakConsum2; MonthPeakConsum2)
                {
                }
                column(PeakConsum2; PeakConsum2)
                {
                }
                column(TotMonthAvgConsumQty1; TotMonthlyConsmtionAmt1[1])
                {
                }
                column(TotMonthPeakConsumQty1; TotMonthlyConsmtionAmt1[2])
                {
                }
                column(TotMonthAvgPeakConsumValue1; TotMonthlyConsmtionAmt1[3])
                {
                }
                column(TotMonthPeakConsumValue1; TotMonthlyConsmtionAmt1[4])
                {
                }
                column(TotAvgUnitCost1;'')
                {
                }
                column(GTotAvgMonthConsumQty1; GrandTotMonthlyConsmtionAmt1[1])
                {
                }
                column(GTotMonthPeakConsumQty1; GrandTotMonthlyConsmtionAmt1[2])
                {
                }
                column(GTotAvgMonthPeakConsumValue1; GrandTotMonthlyConsmtionAmt1[3])
                {
                }
                column(GTotMonthPeakConsumValue1; GrandTotMonthlyConsmtionAmt1[4])
                {
                }
                trigger OnAfterGetRecord()
                begin
                    if "Item Category".Get(Item."Item Category Code")then if "Item Category"."Parent Category" <> '' then ParentCategory:="Item Category"."Parent Category"
                        else
                            ParentCategory:='';
                    Mnth:=0;
                    AvgMonthConsum:=0;
                    MonthAVGConsum:=0;
                    Clear(MonthlyConsmtionAmt);
                    SalesPeak.DeleteAll;
                    SalesPeak2.DeleteAll;
                    ItemLedEntry.Reset;
                    ItemLedEntry.SetCurrentkey("Posting Date", "Item No.", "Variant Code");
                    ItemLedEntry.SetRange("Posting Date", MinDate, MaxDate);
                    ItemLedEntry.SetRange("Item No.", "No.");
                    ItemLedEntry.SetFilter("Entry Type", '%1|%2|%3|%4', ItemLedEntry."entry type"::Sale, ItemLedEntry."entry type"::"Negative Adjmt.", ItemLedEntry."entry type"::Consumption, ItemLedEntry."entry type"::"Positive Adjmt.");
                    if ItemLedEntry.FindSet then repeat Amt:=0;
                            Qty:=0;
                            if NewMonth <> Date2dmy(ItemLedEntry."Posting Date", 2)then NewMonth:=Date2dmy(ItemLedEntry."Posting Date", 2);
                            Mnth:=Date2dmy(ItemLedEntry."Posting Date", 2);
                            if Mnth <> 0 then if NewMonth = Mnth then begin
                                    Qty+=ItemLedEntry.Quantity;
                                    ItemLedEntry.CalcFields("Cost Amount (Actual)");
                                    Amt+=ItemLedEntry."Cost Amount (Actual)";
                                    AvgMonthConsum+=(ItemLedEntry.Quantity / Cnt);
                                    MonthAVGConsum+=(ItemLedEntry."Cost Amount (Actual)" / Cnt);
                                end;
                            SalesPeak.Reset;
                            SalesPeak.SetRange("No.", "No.");
                            SalesPeak.SetRange(Month, NewMonth);
                            if not SalesPeak.FindFirst then begin
                                SalesPeak.Init;
                                SalesPeak."No.":="No.";
                                SalesPeak.Month:=Mnth;
                                SalesPeak.Qty:=(Qty);
                                SalesPeak.Amt:=(Amt);
                                SalesPeak.Insert;
                            end
                            else
                            begin
                                SalesPeak.Qty+=(Qty);
                                SalesPeak.Amt+=(Amt);
                                SalesPeak.Modify;
                            end;
                        until ItemLedEntry.Next = 0;
                    ItemNo:="No.";
                    ItemAmount.DeleteAll;
                    ItemAmount2.DeleteAll;
                    SalesPeak.Reset;
                    if SalesPeak.FindSet then repeat if SalesPeak.Qty <> 0 then begin
                                ItemAmount.Amount:=SalesPeak.Qty;
                                ItemAmount."Amount 2":=SalesPeak.Month;
                                ItemAmount."Item No.":=SalesPeak."No.";
                                ItemAmount.Insert;
                            end;
                            if SalesPeak.Amt <> 0 then begin
                                ItemAmount2.Amount:=SalesPeak.Amt;
                                ItemAmount2."Amount 2":=SalesPeak.Month;
                                ItemAmount2."Item No.":=SalesPeak."No.";
                                ItemAmount2.Insert;
                            end;
                        until SalesPeak.Next = 0;
                    ItemAmount.Reset;
                    ItemAmount.SetRange(ItemAmount."Item No.", Item."No.");
                    ItemAmount.Ascending(true);
                    if ItemAmount.FindFirst then MonthPeakConsum:=Abs(ItemAmount.Amount);
                    ItemAmount2.Reset;
                    ItemAmount2.SetRange(ItemAmount2."Item No.", Item."No.");
                    ItemAmount2.Ascending(true);
                    if ItemAmount2.FindFirst then PeakConsum:=Abs(ItemAmount2.Amount);
                    //@@@@22
                    //CLEAR(MonthlyConsmtionAmt);
                    SalesPeak3.DeleteAll;
                    Mnth2:=0;
                    MonthAVGConsum2:=0;
                    AvgMonthConsum2:=0;
                    ItemLedEntry2.Reset;
                    ItemLedEntry2.SetCurrentkey("Posting Date", "Item No.", "Variant Code");
                    ItemLedEntry2.SetRange("Posting Date", MinDate, MaxDate);
                    ItemLedEntry2.SetRange("Item No.", "No.");
                    ItemLedEntry2.SetFilter("Entry Type", '%1', ItemLedEntry2."entry type"::Consumption);
                    if ItemLedEntry2.FindSet then repeat Amt2:=0;
                            Qty2:=0;
                            if NewMonth2 <> Date2dmy(ItemLedEntry2."Posting Date", 2)then NewMonth2:=Date2dmy(ItemLedEntry2."Posting Date", 2);
                            Mnth2:=Date2dmy(ItemLedEntry2."Posting Date", 2);
                            if Mnth2 <> 0 then if NewMonth2 = Mnth2 then begin
                                    Qty2+=ItemLedEntry2.Quantity;
                                    ItemLedEntry2.CalcFields("Cost Amount (Actual)");
                                    Amt2+=ItemLedEntry2."Cost Amount (Actual)";
                                    AvgMonthConsum2+=Abs(ItemLedEntry2.Quantity / Cnt);
                                    MonthAVGConsum2+=Abs(ItemLedEntry2."Cost Amount (Actual)" / Cnt);
                                end;
                            SalesPeak3.Reset;
                            SalesPeak3.SetRange("No.", "No.");
                            SalesPeak3.SetRange(Month, NewMonth2);
                            if not SalesPeak3.FindFirst then begin
                                SalesPeak3.Init;
                                SalesPeak3."No.":="No.";
                                SalesPeak3.Month:=Mnth2;
                                SalesPeak3.Qty:=(Qty2);
                                SalesPeak3.Amt:=(Amt2);
                                SalesPeak3.Insert;
                            end
                            else
                            begin
                                SalesPeak3.Qty+=(Qty2);
                                SalesPeak3.Amt+=(Amt2);
                                SalesPeak3.Modify;
                            end;
                        until ItemLedEntry2.Next = 0;
                    ItemNo:="No.";
                    ItemAmount4.DeleteAll;
                    ItemAmount3.DeleteAll;
                    SalesPeak3.Reset;
                    if SalesPeak3.FindSet then repeat if SalesPeak3.Qty <> 0 then begin
                                ItemAmount4.Amount:=SalesPeak3.Qty;
                                ItemAmount4."Amount 2":=SalesPeak3.Month;
                                ItemAmount4."Item No.":=SalesPeak3."No.";
                                ItemAmount4.Insert;
                            end;
                            if SalesPeak3.Amt <> 0 then begin
                                ItemAmount3.Amount:=SalesPeak3.Amt;
                                ItemAmount3."Amount 2":=SalesPeak3.Month;
                                ItemAmount3."Item No.":=SalesPeak3."No.";
                                ItemAmount3.Insert;
                            end;
                        until SalesPeak3.Next = 0;
                    ItemAmount4.Reset;
                    ItemAmount4.SetRange(ItemAmount4."Item No.", Item."No.");
                    ItemAmount4.Ascending(true);
                    if ItemAmount4.FindFirst then MonthPeakConsum2:=Abs(ItemAmount4.Amount);
                    ItemAmount3.Reset;
                    ItemAmount3.SetRange(ItemAmount3."Item No.", Item."No.");
                    ItemAmount3.Ascending(true);
                    if ItemAmount3.FindFirst then PeakConsum2:=Abs(ItemAmount3.Amount);
                    if AvgMonthConsum <> 0 then AvgUnitCost:=MonthAVGConsum / AvgMonthConsum;
                    TotMonthlyConsmtionAmt[1]+=AvgMonthConsum;
                    TotMonthlyConsmtionAmt[2]+=MonthPeakConsum;
                    TotMonthlyConsmtionAmt[3]+=MonthAVGConsum;
                    TotMonthlyConsmtionAmt[4]+=PeakConsum;
                    GrandTotMonthlyConsmtionAmt[1]+=AvgMonthConsum;
                    GrandTotMonthlyConsmtionAmt[2]+=MonthPeakConsum;
                    GrandTotMonthlyConsmtionAmt[3]+=MonthAVGConsum;
                    GrandTotMonthlyConsmtionAmt[4]+=PeakConsum;
                    // IF  AvgMonthConsum2<>0 THEN
                    // AvgUnitCost:=MonthAVGConsum/ AvgMonthConsum;
                    TotMonthlyConsmtionAmt1[1]+=AvgMonthConsum2;
                    TotMonthlyConsmtionAmt1[2]+=MonthPeakConsum2;
                    TotMonthlyConsmtionAmt1[3]+=MonthAVGConsum2;
                    TotMonthlyConsmtionAmt1[4]+=PeakConsum2;
                    GrandTotMonthlyConsmtionAmt1[1]+=AvgMonthConsum2;
                    GrandTotMonthlyConsmtionAmt1[2]+=MonthPeakConsum2;
                    GrandTotMonthlyConsmtionAmt1[3]+=MonthAVGConsum2;
                    GrandTotMonthlyConsmtionAmt[4]+=PeakConsum2;
                end;
                trigger OnPostDataItem()
                begin
                /*TotMonthlyConsmtionAmt[1] += AvgMonthConsum;
                    TotMonthlyConsmtionAmt[2] += MonthPeakConsum;
                    TotMonthlyConsmtionAmt[3] += MonthAVGConsum;
                    TotMonthlyConsmtionAmt[4] += PeakConsum;
                    GrandTotMonthlyConsmtionAmt[1] += AvgMonthConsum;
                    GrandTotMonthlyConsmtionAmt[2] += MonthPeakConsum;
                    GrandTotMonthlyConsmtionAmt[3] += MonthAVGConsum;
                    GrandTotMonthlyConsmtionAmt[4] += PeakConsum;
                    */
                end;
                trigger OnPreDataItem()
                begin
                    MinDate:=Item.GetRangeMin(Item."Date Filter");
                    MaxDate:=Item.GetRangemax(Item."Date Filter");
                    if Date2dmy(MinDate, 3) = Date2dmy(MaxDate, 3)then begin
                        Cnt:=(Date2dmy(MaxDate, 2) - Date2dmy(MinDate, 2)) + 1;
                    end
                    else
                    begin
                        if Date2dmy(MaxDate, 3) - Date2dmy(MinDate, 3) = 1 then Cnt:=(12 - Date2dmy(MinDate, 2) + 1) + Date2dmy(MaxDate, 2)
                        else if Date2dmy(MaxDate, 3) - Date2dmy(MinDate, 3) = 2 then Cnt:=(24 - Date2dmy(MinDate, 2) + 1) + Date2dmy(MaxDate, 2);
                    end;
                    TextFilter:=Item.GetFilter("No.");
                //MESSAGE('%1',Cnt);
                end;
            }
            trigger OnAfterGetRecord()
            begin
                Clear(TotMonthlyConsmtionAmt);
                Clear(TotMonthlyConsmtionAmt1);
                AvgMonthConsum:=0;
                MonthAVGConsum:=0;
                AvgMonthConsum2:=0;
                MonthAVGConsum2:=0;
            end;
            trigger OnPreDataItem()
            begin
                Clear(MonthlyConsmtionAmt);
                Clear(TotMonthlyConsmtionAmt);
                Clear(GrandTotMonthlyConsmtionAmt);
                Clear(TotMonthlyConsmtionAmt1);
                Clear(GrandTotMonthlyConsmtionAmt1);
            end;
        }
    }
    requestpage
    {
        layout
        {
        }
        actions
        {
        }
    }
    labels
    {
    }
    var ParentCategory: Text;
    TotMonthlyConsmtionAmt1: array[4]of Decimal;
    GrandTotMonthlyConsmtionAmt1: array[4]of Decimal;
    NewMonth2: Decimal;
    Mnth2: Integer;
    Qty2: Decimal;
    Amt2: Decimal;
    AvgMonthConsum2: Decimal;
    LastFieldNo: Integer;
    FooterPrinted: Boolean;
    AvgMonthConsum: Decimal;
    MonthPeakConsum: Decimal;
    MonthAVGConsum: Decimal;
    PeakConsum: Decimal;
    AvgUnitCost: Decimal;
    ExportToExcel: Boolean;
    ExcelBuffer: Record "Excel Buffer";
    ILE: Record "Item Ledger Entry";
    ItemAmount: Record "Item Amount" temporary;
    Mnth: Integer;
    StartMnth: Integer;
    EndMnth: Integer;
    Date: Record Date;
    Qty: Decimal;
    Amt: Decimal;
    Cnt: Integer;
    ItemAmount2: Record "Item Amount" temporary;
    MinDate: Date;
    MaxDate: Date;
    TotalAvgMonthConsum: Decimal;
    TotalMonthPeakConsum: Decimal;
    TotalAvgUnitCost: Decimal;
    TotalMonthAVGConsum: Decimal;
    TotalPeakConsum: Decimal;
    GTotalAvgMonthConsum: Decimal;
    GTotalMonthPeakConsum: Decimal;
    GTotalAvgUnitCost: Decimal;
    GTotalMonthAVGConsum: Decimal;
    GTotalPeakConsum: Decimal;
    Item_Consumption_ReportCaptionLbl: label 'Item Consumption Report';
    CurrReport_PAGENOCaptionLbl: label 'Page';
    Avg__Unit_CostCaptionLbl: label 'Avg. Unit Cost';
    Peak_Consumption_ValueCaptionLbl: label 'Peak Consumption Value';
    Monthly_Avg__Consumption_ValueCaptionLbl: label 'Monthly Avg. Consumption Value';
    Monthly_Peak_ComsumptionCaptionLbl: label 'Monthly Peak Comsumption';
    Avg__Monthly_Consumption_during_PeriodCaptionLbl: label 'Avg. Monthly Consumption during Period';
    Lead_Time_CaptionLbl: label 'Lead Time ';
    Description_2CaptionLbl: label 'Description 2';
    UOMCaptionLbl: label 'UOM';
    Item_CategoryCaptionLbl: label 'Item Category';
    DescriptionCaptionLbl: label 'Description';
    Item_CodeCaptionLbl: label 'Item Code';
    Prod__Group_CodeCaptionLbl: label 'Prod. Group Code';
    Grand_Total_CaptionLbl: label 'Grand Total:';
    Total_ForCaptionLbl: label 'Total For';
    LocalAvgUnitCost: Decimal;
    GrecItemLedgerEntry: Record "Item Ledger Entry";
    AmountDec: Decimal;
    DateRange: Text;
    CostAmtDec: Decimal;
    QuantityDec: Decimal;
    TextFilter: Text;
    ItemNotext: Text;
    ItemAmount3: Record "Item Amount";
    PeakConsumDec: Decimal;
    MonthAVGConsumDec: Decimal;
    TotalAvgDec: Decimal;
    MonthPeakConsumDec: Decimal;
    AvgMonthConsumDec: Decimal;
    TotalAvgMonthConsumDec: Decimal;
    GTotalAvgMonthConsumDec: Decimal;
    ProductGroupCodeText: Text;
    GrecItemLedgerEntry2: Record "Item Ledger Entry";
    TestValue: Decimal;
    MonthlyConsmtionAmt: array[6]of Decimal;
    TotMonthlyConsmtionAmt: array[6]of Decimal;
    GrandTotMonthlyConsmtionAmt: array[6]of Decimal;
    ItemCode: Code[20];
    ProductGrupCode: Code[20];
    ItemNo: Code[20];
    NewMonth: Decimal;
    ItemLedEntry: Record "Item Ledger Entry";
    SalesPeak: Record "SSD Sales Peak2" temporary;
    SalesPeak2: Record "SSD Sales Peak2" temporary;
    ItemLedEntry2: Record "Item Ledger Entry";
    MonthAVGConsum2: Decimal;
    Item2: Code[20];
    SalesPeak3: Record "SSD Sales Peak2" temporary;
    MonthPeakConsum2: Decimal;
    PeakConsum2: Decimal;
    ItemAmount4: Record "Item Amount" temporary;
}
