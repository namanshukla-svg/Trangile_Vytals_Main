Report 50374 "Consumption Report.3"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Consumption Report.3.rdl';
    ApplicationArea = all;
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem("Item Category"; "Item Category")
        {
            DataItemTableView = sorting("Parent Category", Code);
            PrintOnlyIfDetail = true;

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
            column(GTotalMonthAVGConsum; GTotalMonthAVGConsum)
            {
            }
            column(GTotalMonthPeakConsum; GTotalMonthPeakConsum)
            {
            }
            column(GTotalAvgMonthConsum; GTotalAvgMonthConsum)
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
            column(Product_Group_Item_Category_Code; "Parent Category")
            {
            }
            column(Product_Group_Code; Code)
            {
            }
            dataitem(Item; Item)
            {
                DataItemLink = "Item Category Code"=field(Code);
                DataItemTableView = sorting("No.");
                PrintOnlyIfDetail = true;
                RequestFilterFields = "No.", "Item Category Code", "Lead Time Calculation", "Replenishment System", "Date Filter", "Location Filter", "Global Dimension 1 Filter", "Global Dimension 2 Filter";

                column(ReportForNavId_8129;8129)
                {
                }
                column(TotalAvgUnitCost; TotalAvgUnitCost)
                {
                }
                column(TotalPeakConsum; TotalPeakConsum)
                {
                }
                column(TotalMonthAVGConsum; TotalMonthAVGConsum)
                {
                }
                column(TotalMonthPeakConsum; TotalMonthPeakConsum)
                {
                }
                column(TotalAvgMonthConsum; TotalAvgMonthConsum)
                {
                }
                column(Item_Item__Product_Group_Code_;'')
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
                dataitem("Item Ledger Entry"; "Item Ledger Entry")
                {
                    CalcFields = "Cost Amount (Actual)";
                    DataItemLink = "Item No."=field("No."), "Variant Code"=field("Variant Filter"), "Posting Date"=field("Date Filter"), "Location Code"=field("Location Filter"), "Global Dimension 1 Code"=field("Global Dimension 1 Filter"), "Global Dimension 2 Code"=field("Global Dimension 2 Filter");
                    DataItemTableView = sorting("Item No.", "Posting Date")order(ascending)where("Entry Type"=filter(Sale|"Negative Adjmt."|Consumption|"Positive Adjmt."));

                    column(ReportForNavId_7209;7209)
                    {
                    }
                    column(Item_Description; Item.Description)
                    {
                    }
                    column(Item__Description_2_; Item."Description 2")
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
                    column(AvgMonthConsum; AvgMonthConsum)
                    {
                    }
                    column(MonthPeakConsum; MonthPeakConsum)
                    {
                    }
                    column(MonthAVGConsum; MonthAVGConsum)
                    {
                    }
                    column(PeakConsum; PeakConsum)
                    {
                    }
                    column(AvgUnitCost; AvgUnitCost)
                    {
                    }
                    column(Item__Product_Group_Code_;'')
                    {
                    }
                    column(Item_Ledger_Entry_Entry_No_; "Entry No.")
                    {
                    }
                    column(Item_Ledger_Entry_Item_No_; "Item No.")
                    {
                    }
                    column(Item_Ledger_Entry_Variant_Code; "Variant Code")
                    {
                    }
                    column(Item_Ledger_Entry_Posting_Date; "Posting Date")
                    {
                    }
                    column(Item_Ledger_Entry_Location_Code; "Location Code")
                    {
                    }
                    column(Item_Ledger_Entry_Global_Dimension_1_Code; "Global Dimension 1 Code")
                    {
                    }
                    column(Item_Ledger_Entry_Global_Dimension_2_Code; "Global Dimension 2 Code")
                    {
                    }
                    column(ProductGroupCode_ItemLedgerEntry; "Item Ledger Entry"."Item Category Code")
                    {
                    }
                    trigger OnAfterGetRecord()
                    begin
                        if "Item Category".Get("Item Ledger Entry"."Item Category Code")then if "Item Category"."Parent Category" <> '' then ParentCategory:="Item Category"."Parent Category"
                            else
                                ParentCategory:='';
                        if Mnth = 0 then begin
                            Mnth:=Date2dmy("Item Ledger Entry"."Posting Date", 2);
                        //Cnt:=1;
                        end;
                        if Mnth <> 0 then if Mnth = Date2dmy("Item Ledger Entry"."Posting Date", 2)then begin
                                Qty+="Item Ledger Entry".Quantity;
                                Amt+="Item Ledger Entry"."Cost Amount (Actual)";
                            end
                            else
                            begin
                                if(Qty <> 0)then begin
                                    ItemAmount.Amount:=Abs(Qty);
                                    ItemAmount."Amount 2":=Mnth;
                                    ItemAmount."Item No.":=Item."No.";
                                    if ItemAmount.Insert then;
                                end;
                                if(Amt <> 0)then begin
                                    ItemAmount2.Amount:=Abs(Amt);
                                    ItemAmount2."Amount 2":=Mnth;
                                    ItemAmount2."Item No.":=Item."No.";
                                    if ItemAmount2.Insert then;
                                end;
                                Qty:="Item Ledger Entry".Quantity;
                                Amt:="Item Ledger Entry"."Cost Amount (Actual)";
                                //Cnt+=1;
                                Mnth:=Date2dmy("Item Ledger Entry"."Posting Date", 2);
                            end;
                        //from footer
                        if(Qty <> 0)then begin
                            ItemAmount.Amount:=Abs(Qty);
                            ItemAmount."Amount 2":=Mnth;
                            ItemAmount."Item No.":=Item."No.";
                            if ItemAmount.Insert then;
                        end;
                        if(Amt <> 0)then begin
                            ItemAmount2.Amount:=Abs(Amt);
                            ItemAmount2."Amount 2":=Mnth;
                            ItemAmount2."Item No.":=Item."No.";
                            if ItemAmount2.Insert then;
                        end;
                        //Cnt+=1;
                        AvgMonthConsum:=Abs("Item Ledger Entry".Quantity / Cnt);
                        MonthAVGConsum:=Abs("Item Ledger Entry"."Cost Amount (Actual)" / Cnt);
                        if AvgMonthConsum <> 0 then AvgUnitCost:=MonthAVGConsum / AvgMonthConsum;
                        ItemAmount.Reset;
                        ItemAmount.SetRange(ItemAmount."Item No.", Item."No.");
                        ItemAmount.Ascending(true);
                        if ItemAmount.FindLast then MonthPeakConsum:=Abs(ItemAmount.Amount);
                        ItemAmount2.Reset;
                        ItemAmount2.SetRange(ItemAmount2."Item No.", Item."No.");
                        ItemAmount2.Ascending(true);
                        if ItemAmount2.FindLast then PeakConsum:=Abs(ItemAmount2.Amount);
                        TotalAvgMonthConsum+=AvgMonthConsum;
                        TotalMonthPeakConsum+=MonthPeakConsum;
                        TotalMonthAVGConsum+=MonthAVGConsum;
                        TotalPeakConsum+=PeakConsum;
                        TotalAvgUnitCost+=AvgUnitCost;
                        GTotalAvgMonthConsum:=TotalAvgMonthConsum;
                        GTotalMonthPeakConsum:=TotalMonthPeakConsum;
                        GTotalMonthAVGConsum:=TotalMonthAVGConsum;
                        GTotalPeakConsum:=TotalPeakConsum;
                        GTotalAvgUnitCost:=TotalAvgUnitCost;
                    end;
                    trigger OnPreDataItem()
                    begin
                        CurrReport.CreateTotals(Quantity, "Cost Amount (Actual)");
                        Amt:=0;
                        Qty:=0;
                        //->Item-OnAfter
                        AvgMonthConsum:=0;
                        MonthPeakConsum:=0;
                        MonthAVGConsum:=0;
                        PeakConsum:=0;
                        AvgUnitCost:=0;
                        Mnth:=0;
                        //Cnt:=0;
                        ItemAmount2.DeleteAll;
                        ItemAmount.DeleteAll;
                    //<-
                    end;
                }
                trigger OnPreDataItem()
                begin
                    MinDate:=Item.GetRangeMin(Item."Date Filter");
                    MaxDate:=Item.GetRangemax(Item."Date Filter");
                    if Date2dmy(MinDate, 3) = Date2dmy(MaxDate, 3)then begin
                        Cnt:=(Date2dmy(MaxDate, 2) - Date2dmy(MinDate, 2)) + 1;
                    end
                    else
                    begin
                        if Date2dmy(MaxDate, 3) - Date2dmy(MinDate, 3) = 1 then begin
                            Cnt:=(12 - Date2dmy(MinDate, 2) + 1) + Date2dmy(MaxDate, 2);
                        end;
                        if Date2dmy(MaxDate, 3) - Date2dmy(MinDate, 3) = 2 then begin
                            Cnt:=(24 - Date2dmy(MinDate, 2) + 1) + Date2dmy(MaxDate, 2);
                        end;
                    end;
                end;
            }
            trigger OnAfterGetRecord()
            begin
                TotalAvgMonthConsum:=0;
                TotalMonthPeakConsum:=0;
                TotalMonthAVGConsum:=0;
                TotalPeakConsum:=0;
                TotalAvgUnitCost:=0;
            end;
            trigger OnPreDataItem()
            begin
                GTotalAvgMonthConsum:=0;
                GTotalMonthPeakConsum:=0;
                GTotalMonthAVGConsum:=0;
                GTotalPeakConsum:=0;
                GTotalAvgUnitCost:=0;
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
    trigger OnPostReport()
    begin
    // BIS 1145
    /*
        IF ExportToExcel THEN BEGIN
          ExcelBuffer.CreateBook;
          ExcelBuffer.CreateSheet('Consumption Report','Consumption Report',COMPANYNAME,USERID);
          ExcelBuffer.GiveUserControl;
        END;
        */
    // BIS 1145
    end;
    trigger OnPreReport()
    begin
        if ExportToExcel then begin
            //  Flag:=TRUE;
            ExcelBuffer.DeleteAll;
        end;
    end;
    var ParentCategory: Text;
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
}
