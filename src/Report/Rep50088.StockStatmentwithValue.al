Report 50088 "Stock Statment with Value"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Stock Statment with Value.rdl';
    Caption = 'Inventory - Trans Detail 2';
    UsageCategory = ReportsandAnalysis;
    ApplicationArea = all;

    dataset
    {
        dataitem(Item; Item)
        {
            DataItemTableView = sorting("No.")order(ascending);
            PrintOnlyIfDetail = true;
            RequestFilterFields = "No.", "Item Category Code", "Date Filter", "Location Filter";

            column(ReportForNavId_8129;8129)
            {
            }
            column(ItemDateFilter; ItemDateFilter)
            {
            }
            column(DataItem1000000000; LocationName)
            {
            }
            column(CompInfo_Name; CompInfo.Name)
            {
            }
            column(CompInfo_Picture; CompInfo.Picture)
            {
            }
            column(GrandItemOnHand; GrandItemOnHand)
            {
            DecimalPlaces = 0: 5;
            }
            column(GrandStartOnHand; GrandStartOnHand)
            {
            DecimalPlaces = 0: 5;
            }
            column(IncreaseQty; IncreaseQty)
            {
            DecimalPlaces = 0: 5;
            }
            column(DecreaseQty; DecreaseQty)
            {
            }
            column(GrandTotOpening; GrandTotOpening)
            {
            DecimalPlaces = 0: 5;
            }
            column(GrandTotIncresed; GrandTotIncresed)
            {
            DecimalPlaces = 0: 5;
            }
            column(GrandTotDecresed; GrandTotDecresed)
            {
            }
            column(GrandTotClosing; GrandTotClosing)
            {
            DecimalPlaces = 0: 5;
            }
            column(Stock_StatementCaption; Stock_StatementCaptionLbl)
            {
            }
            column(For_the_PeriodCaption; For_the_PeriodCaptionLbl)
            {
            }
            column(Opening_Qty_Caption; Opening_Qty_CaptionLbl)
            {
            }
            column(Item_DescriptionCaption; Item_DescriptionCaptionLbl)
            {
            }
            column(Item_No_Caption; Item_No_CaptionLbl)
            {
            }
            column(Increase_QtyCaption; Increase_QtyCaptionLbl)
            {
            }
            column(Decrease_QtyCaption; Decrease_QtyCaptionLbl)
            {
            }
            column(Closing_Qty_Caption; Closing_Qty_CaptionLbl)
            {
            }
            column(Item_CostCaption; Item_CostCaptionLbl)
            {
            }
            column(Opening_Val_Caption; Opening_Val_CaptionLbl)
            {
            }
            column(Increase_Val_Caption; Increase_Val_CaptionLbl)
            {
            }
            column(Decrease_ValCaption; Decrease_ValCaptionLbl)
            {
            }
            column(Closing_ValCaption; Closing_ValCaptionLbl)
            {
            }
            column(Grand_Total_Caption; Grand_Total_CaptionLbl)
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
            dataitem(PageCounter; "Integer")
            {
                DataItemTableView = sorting(Number)where(Number=const(1));

                column(ReportForNavId_8098;8098)
                {
                }
                dataitem("Item Ledger Entry"; "Item Ledger Entry")
                {
                    DataItemLink = "Item No."=field("No."), "Variant Code"=field("Variant Filter"), "Posting Date"=field("Date Filter"), "Location Code"=field("Location Filter"), "Global Dimension 1 Code"=field("Global Dimension 1 Filter"), "Global Dimension 2 Code"=field("Global Dimension 2 Filter");
                    DataItemLinkReference = Item;
                    DataItemTableView = sorting("Posting Date", "Item No.")order(ascending);

                    column(ReportForNavId_7209;7209)
                    {
                    }
                    column(GetFilters; GetFilters)
                    {
                    }
                    column(ItemOnHand___Item__Unit_Cost_; ItemOnHand * Item."Unit Cost")
                    {
                    DecimalPlaces = 0: 5;
                    }
                    column(StartOnHand; StartOnHand)
                    {
                    DecimalPlaces = 0: 5;
                    }
                    column(IncreaseQty_Control1000000020; IncreaseQty)
                    {
                    DecimalPlaces = 0: 5;
                    }
                    column(DecreaseQty_Control1000000021; DecreaseQty)
                    {
                    }
                    column(Item_Description_________Item__Description_2_; Item.Description + ' ' + Item."Description 2")
                    {
                    }
                    column(Item__No__; Item."No.")
                    {
                    }
                    column(ItemOnHand; ItemOnHand)
                    {
                    DecimalPlaces = 0: 5;
                    }
                    column(DecreaseQty___Item__Unit_Cost_; DecreaseQty * Item."Unit Cost")
                    {
                    }
                    column(Item__Unit_Cost_; Item."Unit Cost")
                    {
                    DecimalPlaces = 0: 5;
                    }
                    column(StartOnHand___Item__Unit_Cost_; StartOnHand * Item."Unit Cost")
                    {
                    DecimalPlaces = 0: 5;
                    }
                    column(IncreaseQty___Item__Unit_Cost_; IncreaseQty * Item."Unit Cost")
                    {
                    DecimalPlaces = 0: 5;
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
                    trigger OnAfterGetRecord()
                    begin
                        PurchaseQty:=0;
                        PurchaseValue:=0;
                        PositiveQty:=0;
                        PositiveValue:=0;
                        OutputQty:=0;
                        OutputValue:=0;
                        TransferIncreaseQty:=0;
                        TransferIncreaseValue:=0;
                        SaleQty:=0;
                        SaleValue:=0;
                        NegativeQty:=0;
                        NegativeValue:=0;
                        CunsumptionQty:=0;
                        CunsumptionValue:=0;
                        TransferdecreaseQty:=0;
                        TransferdecreaseValue:=0;
                        ItemOnHand:=ItemOnHand + Quantity;
                        if Quantity > 0 then begin
                            if("Item Ledger Entry"."Entry Type" = "Item Ledger Entry"."entry type"::Purchase)then PurchaseQty:=Quantity;
                            if("Item Ledger Entry"."Entry Type" = "Item Ledger Entry"."entry type"::Output)then OutputQty:=Quantity;
                            if("Item Ledger Entry"."Entry Type" = "Item Ledger Entry"."entry type"::"Positive Adjmt.")then PositiveQty:=Quantity;
                            if("Item Ledger Entry"."Entry Type" = "Item Ledger Entry"."entry type"::Transfer)then TransferIncreaseQty:=Quantity;
                            if("Item Ledger Entry"."Entry Type" = "Item Ledger Entry"."entry type"::Sale)then SaleQty:=Quantity;
                            //*******************For Increase Value
                            IncreaseQTYValue();
                            TransferQTYValue();
                        //*****************For Transfer*********************
                        end
                        else
                        begin
                            if("Item Ledger Entry"."Entry Type" = "Item Ledger Entry"."entry type"::Sale)then SaleQty:=Abs(Quantity);
                            if("Item Ledger Entry"."Entry Type" = "Item Ledger Entry"."entry type"::Purchase)then PurchaseQty:=Abs(Quantity);
                            if("Item Ledger Entry"."Entry Type" = "Item Ledger Entry"."entry type"::Consumption)then CunsumptionQty:=Abs(Quantity);
                            if("Item Ledger Entry"."Entry Type" = "Item Ledger Entry"."entry type"::"Negative Adjmt.")then NegativeQty:=Abs(Quantity);
                            if("Item Ledger Entry"."Entry Type" = "Item Ledger Entry"."entry type"::Transfer)then TransferdecreaseQty:=Abs(Quantity);
                            //****************For Decrease**********************
                            DecreaseQTYValue();
                            TransferQTYValue();
                        //*****************For Transfer*********************
                        end;
                        ItemValue:=ItemValue + PurchaseValue + PositiveValue + OutputValue + TransferIncreaseValue - CunsumptionValue - NegativeValue - SaleValue - TransferdecreaseValue;
                    end;
                    trigger OnPreDataItem()
                    begin
                        CurrReport.CreateTotals(IncreaseQty, DecreaseQty);
                    end;
                }
            }
            trigger OnAfterGetRecord()
            begin
                if Location.Get("Location Filter")then begin
                    if STATES1.Get(Location."State Code")then StateName2:=STATES1.Description
                    else
                        StateName2:='';
                    LocationName:=Location.Address + ',' + Location."Address 2" + ',' + Location.City + '-' + Location."Post Code" + ',' + StateName2 + 'TEL No. ' + Location."Phone No." + ' FAX No. ' + Location."Fax No." end;
                FirstItem:=true;
                StartSecond:=false;
                StartOnHand:=0;
                StartOnValue:=0;
                /*IF ItemDateFilter <> '' THEN
                   IF GETRANGEMIN("Date Filter") > 00000101D THEN BEGIN
                      SETRANGE("Date Filter",0D,GETRANGEMIN("Date Filter") - 1);
                      CALCFIELDS("Net Change");
                      StartOnHand := "Net Change";
                      SETFILTER("Date Filter",ItemDateFilter);
                   END;*/
                if ItemDateFilter <> '' then if GetRangeMin("Date Filter") > 00000101D then begin
                        ILE.Reset;
                        ILE.SetCurrentkey("Item No.", "Posting Date", "Location Code");
                        ILE.SetRange("Posting Date", 0D, GetRangeMin("Date Filter") - 1);
                        ILE.SetRange("Item No.", "No.");
                        if LocationFilter <> '' then ILE.SetRange("Location Code", LocationFilter);
                        ILE.CalcSums(Quantity);
                        StartOnHand:=ILE.Quantity;
                    end;
                ItemOnHand:=StartOnHand;
                ItemOpeningQty:=StartOnHand;
                OpeningValue();
                TotalSaleQty:=0;
                TotalSaleValue:=0;
                TotalOutputQty:=0;
                TotalOutputValue:=0;
                TotalPositiveQty:=0;
                TotalPositiveValue:=0;
                TotalNegativeQty:=0;
                TotalNegativeValue:=0;
                TotalTransferIncreaseQty:=0;
                TotalTransferIncreaseValue:=0;
                TotalTransferdecreaseQty:=0;
                TotalTransferdecreaseValue:=0;
                TotalPurchaseQty:=0;
                TotalPurchaseValue:=0;
                TotalCunsumptionQty:=0;
                TotalCunsumptionValue:=0;
                ItemOpeningQty:=0;
            end;
            trigger OnPreDataItem()
            begin
                //CurrReport.NEWPAGEPERRECORD := PrintOnlyOnePerPage;
                GrandTotOpening:=0;
                GrandTotIncresed:=0;
                GrandTotIncresed:=0;
                GrandTotClosing:=0;
            end;
        }
    }
    requestpage
    {
        layout
        {
            area(content)
            {
            }
        }
        actions
        {
        }
    }
    labels
    {
    }
    trigger OnInitReport()
    begin
        PrintSummary:=true;
        PrintToExcel:=true;
    end;
    trigger OnPostReport()
    begin
        //MLAlle.begin
        if PrintToExcel then CreateExcelbook;
    //MLAlle.end
    end;
    trigger OnPreReport()
    begin
        ItemFilter:=Item.GetFilters;
        ItemDateFilter:=Item.GetFilter("Date Filter");
        LocationFilter:=Item.GetFilter("Location Filter");
        GlobalDim1.Get();
        // respcent.Get(UserMgt.GetRespCenterFilter);
        CompInfo.Get();
        CompInfo.CalcFields(Picture);
    // ResponsibilityCenter.Get(UserMgt.GetRespCenterFilter);
    end;
    var STATES1: Record State;
    Location: Record Location;
    LocationName: Text;
    StateName2: Text[50];
    Text000: label 'Period:';
    respcent: Record "Responsibility Center";
    ItemFilter: Text[250];
    ItemDateFilter: Text[30];
    ItemOnHand: Decimal;
    StartOnHand: Decimal;
    PurchaseQty: Decimal;
    CunsumptionQty: Decimal;
    PrintOnlyOnePerPage: Boolean;
    Mes: Integer;
    Reference: Text[100];
    Vendor: Record Vendor;
    DimValue: Record "Dimension Value";
    GlobalDim1: Record "General Ledger Setup";
    ILE: Record "Item Ledger Entry";
    PrintNewPage: Boolean;
    PurchRcptHeader: Record "Purch. Rcpt. Header";
    remarks1: Text[80];
    CompInfo: Record "Company Information";
    ResponsibilityCenter: Record "Responsibility Center";
    UserMgt: Codeunit "SSD User Setup Management";
    ResAdd: Text[250];
    ClosingQty: Decimal;
    IleCost: Decimal;
    TestEntyr: Option;
    ValueEntry: Record "Value Entry";
    PurchaseValue: Decimal;
    CunsumptionValue: Decimal;
    IncludeExpectedCost: Boolean;
    StartOnValue: Decimal;
    ItemValue: Decimal;
    TestEntrytype: Integer;
    TotalClosingQty: Decimal;
    TotalClosingQtyValue: Decimal;
    SaleQty: Decimal;
    SaleValue: Decimal;
    OutputQty: Decimal;
    OutputValue: Decimal;
    PositiveQty: Decimal;
    PositiveValue: Decimal;
    NegativeQty: Decimal;
    NegativeValue: Decimal;
    TransferIncreaseQty: Decimal;
    TransferIncreaseValue: Decimal;
    TransferdecreaseQty: Decimal;
    TransferdecreaseValue: Decimal;
    TotalSaleQty: Decimal;
    TotalSaleValue: Decimal;
    TotalOutputQty: Decimal;
    TotalOutputValue: Decimal;
    TotalPositiveQty: Decimal;
    TotalPositiveValue: Decimal;
    TotalNegativeQty: Decimal;
    TotalNegativeValue: Decimal;
    TotalTransferIncreaseQty: Decimal;
    TotalTransferIncreaseValue: Decimal;
    TotalTransferdecreaseQty: Decimal;
    TotalTransferdecreaseValue: Decimal;
    TotalPurchaseQty: Decimal;
    TotalPurchaseValue: Decimal;
    TotalCunsumptionQty: Decimal;
    TotalCunsumptionValue: Decimal;
    ItemOpeningQty: Decimal;
    ItemOpeningValue: Decimal;
    GrandTotalPurchaseQty: Decimal;
    GrandTotalCunsumptionQty: Decimal;
    GrandTotalPurchaseValue: Decimal;
    GrandTotalCunsumptionValue: Decimal;
    GrandTotalPositiveQty: Decimal;
    GrandTotalPositiveValue: Decimal;
    GrandTotalOutputQty: Decimal;
    GrandTotalOutputValue: Decimal;
    GrandTotalTransferIncreaseValu: Decimal;
    GrandTotalTransferIncreaseQty: Decimal;
    GrandTotalSaleQty: Decimal;
    GrandTotalSaleValue: Decimal;
    GrandTotalNegativeQty: Decimal;
    GrandTotalNegativeValue: Decimal;
    GrandTotalTransferdecreaseQty: Decimal;
    GrandTotalTransferdecreaseValu: Decimal;
    GrandItemOnHand: Decimal;
    GrandItemValue: Decimal;
    GrandStartOnHand: Decimal;
    GrandStartOnValue: Decimal;
    FirstItem: Boolean;
    StartSecond: Boolean;
    IncreaseQty: Decimal;
    DecreaseQty: Decimal;
    LocationFilter: Text[30];
    PrintSummary: Boolean;
    PrintToExcel: Boolean;
    ExcelBuf: Record "Excel Buffer" temporary;
    GrandTotOpening: Decimal;
    GrandTotIncresed: Decimal;
    GrandTotDecresed: Decimal;
    GrandTotClosing: Decimal;
    Stock_StatementCaptionLbl: label 'Stock Statement';
    For_the_PeriodCaptionLbl: label 'For the Period';
    Opening_Qty_CaptionLbl: label 'Opening Qty.';
    Item_DescriptionCaptionLbl: label 'Item Description';
    Item_No_CaptionLbl: label 'Item No.';
    Increase_QtyCaptionLbl: label 'Increase Qty';
    Decrease_QtyCaptionLbl: label 'Decrease Qty';
    Closing_Qty_CaptionLbl: label 'Closing Qty.';
    Item_CostCaptionLbl: label 'Item Cost';
    Opening_Val_CaptionLbl: label 'Opening Val.';
    Increase_Val_CaptionLbl: label 'Increase Val.';
    Decrease_ValCaptionLbl: label 'Decrease Val';
    Closing_ValCaptionLbl: label 'Closing Val';
    Grand_Total_CaptionLbl: label 'Grand Total:';
    procedure IncreaseQTYValue()
    begin
        ValueEntry.Reset;
        ValueEntry.SetCurrentkey("Item Ledger Entry Type", "Item Ledger Entry No.");
        ValueEntry.SetRange(ValueEntry."Item Ledger Entry Type", "Item Ledger Entry"."Entry Type");
        ValueEntry.SetRange(ValueEntry."Item Ledger Entry No.", "Item Ledger Entry"."Entry No.");
        if ValueEntry.Find('-')then begin
            repeat if IncludeExpectedCost = false then begin
                    IleCost:=IleCost + ValueEntry."Cost Amount (Actual)" end
                else
                    IleCost:=IleCost + ValueEntry."Cost Amount (Actual)" + ValueEntry."Cost Amount (Expected)";
            until ValueEntry.Next = 0;
        end;
        if("Item Ledger Entry"."Entry Type" = "Item Ledger Entry"."entry type"::Purchase)then PurchaseValue:=IleCost;
        if("Item Ledger Entry"."Entry Type" = "Item Ledger Entry"."entry type"::Output)then OutputValue:=IleCost;
        if("Item Ledger Entry"."Entry Type" = "Item Ledger Entry"."entry type"::"Positive Adjmt.")then PositiveValue:=IleCost;
    end;
    procedure DecreaseQTYValue()
    begin
        ValueEntry.Reset;
        ValueEntry.SetCurrentkey("Item Ledger Entry Type", "Item Ledger Entry No.");
        ValueEntry.SetRange(ValueEntry."Item Ledger Entry Type", "Item Ledger Entry"."Entry Type");
        ValueEntry.SetRange(ValueEntry."Item Ledger Entry No.", "Item Ledger Entry"."Entry No.");
        if ValueEntry.Find('-')then begin
            repeat if IncludeExpectedCost = false then begin
                    IleCost:=IleCost + ValueEntry."Cost Amount (Actual)" end
                else
                    IleCost:=IleCost + ValueEntry."Cost Amount (Actual)" + ValueEntry."Cost Amount (Expected)";
            until ValueEntry.Next = 0;
        end;
        if("Item Ledger Entry"."Entry Type" = "Item Ledger Entry"."entry type"::Sale)then SaleValue:=Abs(IleCost);
        if("Item Ledger Entry"."Entry Type" = "Item Ledger Entry"."entry type"::Consumption)then CunsumptionValue:=Abs(IleCost);
        if("Item Ledger Entry"."Entry Type" = "Item Ledger Entry"."entry type"::"Negative Adjmt.")then NegativeValue:=Abs(IleCost);
    end;
    procedure TransferQTYValue()
    begin
        if "Item Ledger Entry"."Entry Type" = "Item Ledger Entry"."entry type"::Transfer then begin
            ValueEntry.Reset;
            ValueEntry.SetCurrentkey("Item Ledger Entry Type", "Item Ledger Entry No.");
            ValueEntry.SetRange(ValueEntry."Item Ledger Entry Type", "Item Ledger Entry"."Entry Type");
            ValueEntry.SetRange(ValueEntry."Item Ledger Entry No.", "Item Ledger Entry"."Entry No.");
            if ValueEntry.Find('-')then begin
                repeat if IncludeExpectedCost = false then begin
                        IleCost:=IleCost + ValueEntry."Cost Amount (Actual)";
                    end
                    else
                        IleCost:=IleCost + ValueEntry."Cost Amount (Actual)" + ValueEntry."Cost Amount (Expected)";
                    if IleCost > 0 then TransferIncreaseValue:=IleCost
                    else
                        TransferdecreaseValue:=Abs(IleCost);
                until ValueEntry.Next = 0;
            end;
        end;
    end;
    procedure OpeningValue()
    begin
        ValueEntry.Reset;
        ValueEntry.SetCurrentkey("Item No.", "Posting Date");
        ValueEntry.SetRange(ValueEntry."Item No.", Item."No.");
        ValueEntry.SetRange(ValueEntry."Posting Date", 0D, Item.GetRangeMin("Date Filter") - 1);
        if ValueEntry.Find('-')then repeat if IncludeExpectedCost = false then begin
                    StartOnValue:=StartOnValue + ValueEntry."Cost Amount (Actual)";
                end
                else
                    StartOnValue:=StartOnValue + ValueEntry."Cost Amount (Actual)" + ValueEntry."Cost Amount (Expected)";
            until ValueEntry.Next = 0;
        ItemValue:=StartOnValue;
        ItemOpeningValue:=StartOnValue;
    end;
    local procedure MakeExcelDataHeader()
    begin
        //
        // BIS 1145
        ExcelBuf.AddColumn('Stock Statement', false, '', true, false, false, '', ExcelBuf."cell type"::Text);
        ExcelBuf.NewRow;
        ExcelBuf.AddColumn(CompInfo.Name, false, '', true, false, false, '', ExcelBuf."cell type"::Text);
        ExcelBuf.NewRow;
        ExcelBuf.AddColumn(respcent.Address + ',' + respcent."Address 2" + ',' + respcent.City + '-' + respcent."Post Code" + ',' + respcent.State + 'TEL No. ' + respcent."Phone No." + ' FAX No. ' + respcent."Fax No.", false, '', true, false, false, '', ExcelBuf."cell type"::Text);
        ExcelBuf.NewRow;
        ExcelBuf.AddColumn('For the Period ' + Format(ItemDateFilter), false, '', true, false, false, '', ExcelBuf."cell type"::Text);
        ExcelBuf.NewRow;
        ExcelBuf.AddColumn('Item No.', false, '', true, false, false, '', ExcelBuf."cell type"::Text);
        ExcelBuf.AddColumn('Description', false, '', true, false, false, '', ExcelBuf."cell type"::Text);
        ExcelBuf.AddColumn('Item Cost', false, '', true, false, false, '', ExcelBuf."cell type"::Number);
        ExcelBuf.AddColumn('Opening Qty', false, '', true, false, false, '', ExcelBuf."cell type"::Number);
        ExcelBuf.AddColumn('Opening Value', false, '', true, false, false, '', ExcelBuf."cell type"::Number);
        ExcelBuf.AddColumn('Increased Qty', false, '', true, false, false, '', ExcelBuf."cell type"::Number);
        ExcelBuf.AddColumn('Increased Value', false, '', true, false, false, '', ExcelBuf."cell type"::Number);
        ExcelBuf.AddColumn('Decreased Qty', false, '', true, false, false, '', ExcelBuf."cell type"::Number);
        ExcelBuf.AddColumn('Decreased Value', false, '', true, false, false, '', ExcelBuf."cell type"::Number);
        ExcelBuf.AddColumn('Closing Qty', false, '', true, false, false, '', ExcelBuf."cell type"::Number);
        ExcelBuf.AddColumn('Closing Value', false, '', true, false, false, '', ExcelBuf."cell type"::Number);
    // BIS 1145
    //
    end;
    procedure MakeExcelDataHeader2()
    begin
        //
        // BIS 1145
        ExcelBuf.NewRow;
        ExcelBuf.AddColumn("Item Ledger Entry".GetFilters, false, '', true, false, false, '', ExcelBuf."cell type"::Text);
    // BIS 1145
    //
    end;
    procedure MakeExcelDataBody(FirstLine: Boolean)
    begin
        //
        // BIS 1145
        ExcelBuf.NewRow;
        if FirstLine then begin
            ExcelBuf.AddColumn(Item."No.", false, '', false, false, false, '', ExcelBuf."cell type"::Text);
            ExcelBuf.AddColumn(Item.Description + ' ' + Item."Description 2", false, '', false, false, false, '', ExcelBuf."cell type"::Text);
        end
        else
        begin
            ExcelBuf.AddColumn('', false, '', false, false, false, '', ExcelBuf."cell type"::Text);
            ExcelBuf.AddColumn('', false, '', false, false, false, '', ExcelBuf."cell type"::Text);
        end;
        ExcelBuf.AddColumn("Item Ledger Entry"."Posting Date", false, '', false, false, false, '', ExcelBuf."cell type"::Date);
        ExcelBuf.AddColumn(Format("Item Ledger Entry"."Entry Type"), false, '', false, false, false, '', ExcelBuf."cell type"::Text);
        ExcelBuf.AddColumn("Item Ledger Entry"."Document No.", false, '', false, false, false, '', ExcelBuf."cell type"::Text);
        ExcelBuf.AddColumn(StartOnHand, false, '', false, false, false, '', ExcelBuf."cell type"::Number);
        ExcelBuf.AddColumn(IncreaseQty, false, '', false, false, false, '', ExcelBuf."cell type"::Number);
        ExcelBuf.AddColumn(DecreaseQty, false, '', false, false, false, '', ExcelBuf."cell type"::Number);
        ExcelBuf.AddColumn(ItemOnHand, false, '', false, false, false, '', ExcelBuf."cell type"::Number);
    // BIS 1145
    //
    end;
    procedure MakeExcelDataFooter(PrintGrandTotal: Boolean)
    begin
        //
        // BIS 1145
        ExcelBuf.NewRow;
        if not PrintGrandTotal then begin
            ExcelBuf.AddColumn(Item."No.", false, '', false, false, false, '', ExcelBuf."cell type"::Text);
            ExcelBuf.AddColumn(Item.Description + ' ' + Item."Description 2", false, '', false, false, false, '', ExcelBuf."cell type"::Text);
            ExcelBuf.AddColumn(Item."Unit Cost", false, '', false, false, false, '', ExcelBuf."cell type"::Number);
            ExcelBuf.AddColumn(StartOnHand, false, '', false, false, false, '', ExcelBuf."cell type"::Number);
            ExcelBuf.AddColumn(StartOnHand * Item."Unit Cost", false, '', false, false, false, '', ExcelBuf."cell type"::Number);
            ExcelBuf.AddColumn(IncreaseQty, false, '', false, false, false, '', ExcelBuf."cell type"::Number);
            ExcelBuf.AddColumn(IncreaseQty * Item."Unit Cost", false, '', false, false, false, '', ExcelBuf."cell type"::Number);
            ExcelBuf.AddColumn(DecreaseQty, false, '', false, false, false, '', ExcelBuf."cell type"::Number);
            ExcelBuf.AddColumn(DecreaseQty * Item."Unit Cost", false, '', false, false, false, '', ExcelBuf."cell type"::Number);
            ExcelBuf.AddColumn(ItemOnHand, false, '', false, false, false, '', ExcelBuf."cell type"::Number);
            ExcelBuf.AddColumn(ItemOnHand * Item."Unit Cost", false, '', false, false, false, '', ExcelBuf."cell type"::Number);
        end
        else
        begin
            ExcelBuf.AddColumn('Grand Total :', false, '', false, false, false, '', ExcelBuf."cell type"::Text);
            ExcelBuf.AddColumn('', false, '', false, false, false, '', ExcelBuf."cell type"::Text);
            ExcelBuf.AddColumn('', false, '', false, false, false, '', ExcelBuf."cell type"::Text);
            ExcelBuf.AddColumn(GrandStartOnHand, false, '', false, false, false, '', ExcelBuf."cell type"::Number);
            ExcelBuf.AddColumn(GrandTotOpening, false, '', false, false, false, '', ExcelBuf."cell type"::Number);
            ExcelBuf.AddColumn(IncreaseQty, false, '', false, false, false, '', ExcelBuf."cell type"::Number);
            ExcelBuf.AddColumn(GrandTotIncresed, false, '', false, false, false, '', ExcelBuf."cell type"::Number);
            ExcelBuf.AddColumn(DecreaseQty, false, '', false, false, false, '', ExcelBuf."cell type"::Number);
            ExcelBuf.AddColumn(GrandTotDecresed, false, '', false, false, false, '', ExcelBuf."cell type"::Number);
            ExcelBuf.AddColumn(GrandItemOnHand, false, '', false, false, false, '', ExcelBuf."cell type"::Number);
            ExcelBuf.AddColumn(GrandTotClosing, false, '', false, false, false, '', ExcelBuf."cell type"::Number);
        end;
    // BIS 1145
    //
    end;
    procedure CreateExcelbook()
    begin
    //
    // BIS 1145
    //SSDU ExcelBuf.CreateBookAndOpenExcel('Stock Statement Summary', 'Stock', '', '', UserId);
    // ExcelBuf.CreateBook('Stock Statement Summary','');
    // ExcelBuf.CreateSheet('Stock Statement Summary','Stock',COMPANYNAME,USERID);
    // ExcelBuf.GiveUserControl;
    // BIS 1145
    //
    end;
}
