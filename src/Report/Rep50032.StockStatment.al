Report 50032 "Stock Statment"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Stock Statment.rdl';
    Caption = 'Inventory - Trans Detail';
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
            column(ItemOpeningQty; ItemOpeningQty)
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
            column(Posting_DateCaption; Posting_DateCaptionLbl)
            {
            }
            column(Entry_TypeCaption; Entry_TypeCaptionLbl)
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
            column(Item_Ledger_Entry__Document_No__Caption; "Item Ledger Entry".FieldCaption("Document No."))
            {
            }
            column(Closing_Qty_Caption; Closing_Qty_CaptionLbl)
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
                    column(StartOnHand___Quantity; StartOnHand + Quantity)
                    {
                    DecimalPlaces = 0: 5;
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
                    column(DecreaseQty_Control1000000004; DecreaseQty)
                    {
                    }
                    column(IncreaseQty_Control1000000003; IncreaseQty)
                    {
                    DecimalPlaces = 0: 5;
                    }
                    column(StartOnHand; StartOnHand)
                    {
                    DecimalPlaces = 0: 5;
                    }
                    column(Item_Ledger_Entry__Document_No__; "Document No.")
                    {
                    }
                    column(Item_Ledger_Entry__Entry_Type_; "Entry Type")
                    {
                    }
                    column(Item_Ledger_Entry__Posting_Date_; "Posting Date")
                    {
                    }
                    column(ItemOnHand_Control1000000096; ItemOnHand)
                    {
                    DecimalPlaces = 0: 5;
                    }
                    column(Item_Ledger_Entry__Posting_Date__Control1000000061; "Posting Date")
                    {
                    }
                    column(Item_Ledger_Entry__Entry_Type__Control1000000062; "Entry Type")
                    {
                    }
                    column(Item_Ledger_Entry__Document_No___Control1000000088; "Document No.")
                    {
                    }
                    column(IncreaseQty_Control1000000010; IncreaseQty)
                    {
                    DecimalPlaces = 0: 5;
                    }
                    column(DecreaseQty_Control1000000011; DecreaseQty)
                    {
                    }
                    column(StartOnHand__ItemOnHand; StartOnHand + ItemOnHand)
                    {
                    DecimalPlaces = 0: 5;
                    }
                    column(ItemOnHand_Control1000000057; ItemOnHand)
                    {
                    DecimalPlaces = 0: 5;
                    }
                    column(StartOnHand_Control1000000059; StartOnHand)
                    {
                    DecimalPlaces = 0: 5;
                    }
                    column(IncreaseQty_Control1000000005; IncreaseQty)
                    {
                    DecimalPlaces = 0: 5;
                    }
                    column(DecreaseQty_Control1000000006; DecreaseQty)
                    {
                    }
                    column(TOTAL_FOR__________FORMAT_Item__No___;'TOTAL FOR :-' + ' ' + Format(Item."No."))
                    {
                    }
                    column(ItemOnHand_Control1000000018; ItemOnHand)
                    {
                    DecimalPlaces = 0: 5;
                    }
                    column(StartOnHand_Control1000000019; StartOnHand)
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
                    column(Item_Description_________Item__Description_2__Control1000000025; Item.Description + ' ' + Item."Description 2")
                    {
                    }
                    column(Item__No___Control1000000026; Item."No.")
                    {
                    }
                    column(ContinuedCaption; ContinuedCaptionLbl)
                    {
                    }
                    column(ContinuedCaption_Control30; ContinuedCaption_Control30Lbl)
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
                        if Location.Get("Location Code")then begin
                            if STATES1.Get(Location."State Code")then StateName2:=STATES1.Description
                            else
                                StateName2:='';
                            LocationName:=Location.Address + ',' + Location."Address 2" + ',' + Location.City + '-' + Location."Post Code" + ',' + StateName2 + 'TEL No. ' + Location."Phone No." + ' FAX No. ' + Location."Fax No." end;
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
                        if OpeningBoolean then begin
                            ItemOnHand:=StartOnHand;
                            OpeningBoolean:=false;
                        end;
                        // IF ItemOnHand <> 0 THEN
                        //  StartOnHand := ItemOnHand
                        // ELSE
                        //  ItemOnHand := StartOnHand;
                        ItemOnHand:=ItemOnHand + Quantity;
                        if Quantity > 0 then IncreaseQty+=Quantity
                        else
                            DecreaseQty+=Abs(Quantity);
                    end;
                    trigger OnPreDataItem()
                    begin
                        CurrReport.CreateTotals(IncreaseQty, DecreaseQty);
                    end;
                }
            }
            trigger OnAfterGetRecord()
            begin
                FirstItem:=true;
                StartSecond:=false;
                StartOnHand:=0;
                StartOnValue:=0;
                ItemOpeningQty:=0;
                ItemOnHand:=0;
                if ItemDateFilter <> '' then if GetRangeMin("Date Filter") > 00000101D then begin
                        ILE.Reset;
                        ILE.SetCurrentkey("Item No.", "Posting Date", "Location Code");
                        ILE.SetRange("Posting Date", 0D, GetRangeMin("Date Filter") - 1);
                        ILE.SetRange("Item No.", "No.");
                        if LocationFilter <> '' then ILE.SetRange("Location Code", LocationFilter);
                        ILE.CalcSums(Quantity);
                        StartOnHand:=ILE.Quantity;
                    end;
                ItemOpeningQty:=StartOnHand;
                OpeningBoolean:=true;
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
        //MLAlle.begin
        if PrintToExcel then CreateExcelbook;
    //MLAlle.end
    end;
    trigger OnPreReport()
    begin
        ItemFilter:=Item.GetFilters;
        ItemDateFilter:=Item.GetFilter("Date Filter");
        LocationFilter:=Item.GetFilter("Location Filter");
        GlobalDim1.Get;
    // respcent.Get(UserMgt.GetRespCenterFilter);
    // ResponsibilityCenter.Get(UserMgt.GetRespCenterFilter);
    end;
    var STATES1: Record State;
    Location: Record Location;
    LocationName: Text;
    StateName2: Text[50];
    Text000: label 'Period: %1';
    respcent: Record "Responsibility Center";
    ItemFilter: Text[750];
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
    Stock_StatementCaptionLbl: label 'Stock Statement';
    For_the_PeriodCaptionLbl: label 'For the Period';
    Opening_Qty_CaptionLbl: label 'Opening Qty.';
    Item_DescriptionCaptionLbl: label 'Item Description';
    Posting_DateCaptionLbl: label 'Posting Date';
    Entry_TypeCaptionLbl: label 'Entry Type';
    Item_No_CaptionLbl: label 'Item No.';
    Increase_QtyCaptionLbl: label 'Increase Qty';
    Decrease_QtyCaptionLbl: label 'Decrease Qty';
    Closing_Qty_CaptionLbl: label 'Closing Qty.';
    Grand_Total_CaptionLbl: label 'Grand Total:';
    ContinuedCaptionLbl: label 'Continued';
    ContinuedCaption_Control30Lbl: label 'Continued';
    OpeningBoolean: Boolean;
    local procedure MakeExcelDataHeader()
    begin
    /* // BIS 1145
        ExcelBuf.AddColumn('Stock Statement',FALSE,'',TRUE,FALSE,FALSE,'');
        ExcelBuf.NewRow;
        ExcelBuf.AddColumn(CompInfo.Name,FALSE,'',TRUE,FALSE,FALSE,'');
        ExcelBuf.NewRow;
        ExcelBuf.AddColumn(respcent.Address + ',' + respcent."Address 2" + ',' + respcent.City + '-' + respcent."Post Code" +
          ',' + respcent.State + 'TEL No. ' + respcent."Phone No." + ' FAX No. ' + respcent."Fax No.",FALSE,'',TRUE,FALSE,FALSE,'');
        ExcelBuf.NewRow;
        ExcelBuf.AddColumn('For the Period ' + FORMAT(ItemDateFilter),FALSE,'',TRUE,FALSE,FALSE,'');
        ExcelBuf.NewRow;
        ExcelBuf.AddColumn('Item No.',FALSE,'',TRUE,FALSE,FALSE,'');
        ExcelBuf.AddColumn('Description',FALSE,'',TRUE,FALSE,FALSE,'');
        ExcelBuf.AddColumn('Posting Date',FALSE,'',TRUE,FALSE,FALSE,'');
        ExcelBuf.AddColumn('Entry Type',FALSE,'',TRUE,FALSE,FALSE,'');
        ExcelBuf.AddColumn('Document No.',FALSE,'',TRUE,FALSE,FALSE,'');
        ExcelBuf.AddColumn('Opening Qty',FALSE,'',TRUE,FALSE,FALSE,'');
        ExcelBuf.AddColumn('Increased Qty',FALSE,'',TRUE,FALSE,FALSE,'');
        ExcelBuf.AddColumn('Decreased Qty',FALSE,'',TRUE,FALSE,FALSE,'');
        ExcelBuf.AddColumn('Closing',FALSE,'',TRUE,FALSE,FALSE,'');
        */
    // BIS 1145
    end;
    procedure MakeExcelDataHeader2()
    begin
    /* // BIS 1145
        ExcelBuf.NewRow;
        ExcelBuf.AddColumn("Item Ledger Entry".GETFILTERS,FALSE,'',TRUE,FALSE,FALSE,'');
        */
    // BIS 1145
    end;
    procedure MakeExcelDataBody(FirstLine: Boolean)
    begin
    /* // BIS 1145
        ExcelBuf.NewRow;
        IF FirstLine THEN BEGIN
          ExcelBuf.AddColumn(Item."No.",FALSE,'',FALSE,FALSE,FALSE,'');
          ExcelBuf.AddColumn(Item.Description + ' ' + Item."Description 2",FALSE,'',FALSE,FALSE,FALSE,'');
        END ELSE BEGIN
          ExcelBuf.AddColumn('',FALSE,'',FALSE,FALSE,FALSE,'');
          ExcelBuf.AddColumn('',FALSE,'',FALSE,FALSE,FALSE,'');
        END;
        ExcelBuf.AddColumn("Item Ledger Entry"."Posting Date",FALSE,'',FALSE,FALSE,FALSE,'');
        ExcelBuf.AddColumn(FORMAT("Item Ledger Entry"."Entry Type"),FALSE,'',FALSE,FALSE,FALSE,'');
        ExcelBuf.AddColumn("Item Ledger Entry"."Document No.",FALSE,'',FALSE,FALSE,FALSE,'');
        ExcelBuf.AddColumn(StartOnHand,FALSE,'',FALSE,FALSE,FALSE,'');
        ExcelBuf.AddColumn(IncreaseQty,FALSE,'',FALSE,FALSE,FALSE,'');
        ExcelBuf.AddColumn(DecreaseQty,FALSE,'',FALSE,FALSE,FALSE,'');
        ExcelBuf.AddColumn(ItemOnHand,FALSE,'',FALSE,FALSE,FALSE,'');
        */
    // BIS 1145
    end;
    procedure MakeExcelDataFooter(PrintGrandTotal: Boolean)
    begin
    /* // BIS 1145
        ExcelBuf.NewRow;
        IF NOT PrintGrandTotal THEN BEGIN
          IF NOT PrintSummary THEN BEGIN
            ExcelBuf.AddColumn('TOTAL FOR :-'+' ' +FORMAT(Item."No."),FALSE,'',FALSE,FALSE,FALSE,'');
            ExcelBuf.AddColumn('',FALSE,'',FALSE,FALSE,FALSE,'');
          END ELSE BEGIN
            ExcelBuf.AddColumn(Item."No.",FALSE,'',FALSE,FALSE,FALSE,'');
            ExcelBuf.AddColumn(Item.Description + ' ' + Item."Description 2",FALSE,'',FALSE,FALSE,FALSE,'');
          END;
          ExcelBuf.AddColumn('',FALSE,'',FALSE,FALSE,FALSE,'');
          ExcelBuf.AddColumn('',FALSE,'',FALSE,FALSE,FALSE,'');
          ExcelBuf.AddColumn('',FALSE,'',FALSE,FALSE,FALSE,'');
          ExcelBuf.AddColumn(StartOnHand,FALSE,'',FALSE,FALSE,FALSE,'');
          ExcelBuf.AddColumn(IncreaseQty,FALSE,'',FALSE,FALSE,FALSE,'');
          ExcelBuf.AddColumn(DecreaseQty,FALSE,'',FALSE,FALSE,FALSE,'');
          ExcelBuf.AddColumn(ItemOnHand,FALSE,'',FALSE,FALSE,FALSE,'');
        END ELSE BEGIN
          ExcelBuf.AddColumn('Grand Total :',FALSE,'',FALSE,FALSE,FALSE,'');
          ExcelBuf.AddColumn('',FALSE,'',FALSE,FALSE,FALSE,'');
          ExcelBuf.AddColumn('',FALSE,'',FALSE,FALSE,FALSE,'');
          ExcelBuf.AddColumn('',FALSE,'',FALSE,FALSE,FALSE,'');
          ExcelBuf.AddColumn('',FALSE,'',FALSE,FALSE,FALSE,'');
          ExcelBuf.AddColumn(GrandStartOnHand,FALSE,'',FALSE,FALSE,FALSE,'');
          ExcelBuf.AddColumn(IncreaseQty,FALSE,'',FALSE,FALSE,FALSE,'');
          ExcelBuf.AddColumn(DecreaseQty,FALSE,'',FALSE,FALSE,FALSE,'');
          ExcelBuf.AddColumn(GrandItemOnHand,FALSE,'',FALSE,FALSE,FALSE,'');
        END;
        */
    // BIS 1145
    end;
    procedure CreateExcelbook()
    begin
    /* // BIS 1145
        ExcelBuf.CreateBook;
        ExcelBuf.CreateSheet('Stock Statement Details','Stock',COMPANYNAME,USERID);
        ExcelBuf.GiveUserControl;
        */
    // BIS 1145
    end;
}
