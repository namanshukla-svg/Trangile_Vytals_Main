Report 50122 "Item Inventory Summary"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Item Inventory Summary.rdl';
    UsageCategory = ReportsandAnalysis;
    ApplicationArea = all;

    dataset
    {
        dataitem(Item; Item)
        {
            DataItemTableView = sorting("No.")order(ascending);
            RequestFilterFields = "Date Filter", "Item Category Code", "Location Filter";

            column(ReportForNavId_8129;8129)
            {
            }
            column(Item_GETFILTERS; Item.GetFilters)
            {
            }
            column(UserId; UserId)
            {
            }
            column(CurrReport_PAGENO; CurrReport.PageNo)
            {
            }
            column(FORMAT_TODAY_0_4_; Format(Today, 0, 4))
            {
            }
            column(ResCen_Address; ResCen.Address)
            {
            }
            column(ResCen__Address_2_; ResCen."Address 2")
            {
            }
            column(ResCen_Name; ResCen.Name)
            {
            }
            column(ResCen_City_______ResCen__Post_Code_; ResCen.City + ' - ' + ResCen."Post Code")
            {
            }
            column(ResCen_State; ResCen.State)
            {
            }
            column(Item__No__; "No.")
            {
            }
            column(Description_______Description_2_; Description + '  ' + "Description 2")
            {
            }
            column(Item__Item_Category_Code_; "Item Category Code")
            {
            }
            column(Item__Base_Unit_of_Measure_; "Base Unit of Measure")
            {
            }
            column(Item__Net_Weight_; "Net Weight")
            {
            }
            column(OpenBal; OpenBal)
            {
            }
            column(PurchQty; PurchQty)
            {
            }
            column(ConsuptQty; ConsuptQty)
            {
            }
            column(OutputQty; OutputQty)
            {
            }
            column(SaleQty; SaleQty)
            {
            }
            column(OtherQty; OtherQty)
            {
            }
            column(CosingBal; CosingBal)
            {
            }
            column(OpenBal_Control1000000027; OpenBal)
            {
            }
            column(PurchQty_Control1000000037; PurchQty)
            {
            }
            column(ConsuptQty_Control1000000038; ConsuptQty)
            {
            }
            column(OutputQty_Control1000000044; OutputQty)
            {
            }
            column(SaleQty_Control1000000058; SaleQty)
            {
            }
            column(OtherQty_Control1000000059; OtherQty)
            {
            }
            column(CosingBal_Control1000000060; CosingBal)
            {
            }
            column(Item_Inventory_SummaryCaption; Item_Inventory_SummaryCaptionLbl)
            {
            }
            column(Item_CodeCaption; Item_CodeCaptionLbl)
            {
            }
            column(Description_1___2Caption; Description_1___2CaptionLbl)
            {
            }
            column(Item__Item_Category_Code_Caption; FieldCaption("Item Category Code"))
            {
            }
            column(UOMCaption; UOMCaptionLbl)
            {
            }
            column(Item__Net_Weight_Caption; FieldCaption("Net Weight"))
            {
            }
            column(Opening_BalanceCaption; Opening_BalanceCaptionLbl)
            {
            }
            column(PurchaseCaption; PurchaseCaptionLbl)
            {
            }
            column(ConsumptionCaption; ConsumptionCaptionLbl)
            {
            }
            column(OutputCaption; OutputCaptionLbl)
            {
            }
            column(SaleCaption; SaleCaptionLbl)
            {
            }
            column(OthersCaption; OthersCaptionLbl)
            {
            }
            column(Closing_BalanceCaption; Closing_BalanceCaptionLbl)
            {
            }
            column(TotalCaption; TotalCaptionLbl)
            {
            }
            trigger OnAfterGetRecord()
            begin
                OpenBal:=0;
                PurchQty:=0;
                ConsuptQty:=0;
                OutputQty:=0;
                SaleQty:=0;
                OtherQty:=0;
                CosingBal:=0;
                ItemLedgEntry.Reset;
                ItemLedgEntry.SetCurrentkey("Item No.", "Entry Type", "Variant Code", "Drop Shipment", "Location Code", "Posting Date");
                if Item.GetFilter("Location Filter") <> '' then ItemLedgEntry.SetRange(ItemLedgEntry."Location Code", Item.GetFilter("Location Filter"));
                ItemLedgEntry.SetRange(ItemLedgEntry."Item No.", "No.");
                ItemLedgEntry.SetFilter(ItemLedgEntry."Posting Date", '%1..%2', 0D, EndDate - 1);
                if ItemLedgEntry.CalcSums(ItemLedgEntry.Quantity)then OpenBal:=ItemLedgEntry.Quantity;
                ItemLedgEntry.Reset;
                ItemLedgEntry.SetCurrentkey("Item No.", "Entry Type", "Variant Code", "Drop Shipment", "Location Code", "Posting Date");
                if Item.GetFilter("Location Filter") <> '' then ItemLedgEntry.SetRange(ItemLedgEntry."Location Code", Item.GetFilter("Location Filter"));
                ItemLedgEntry.SetRange(ItemLedgEntry."Item No.", "No.");
                ItemLedgEntry.SetFilter(ItemLedgEntry."Posting Date", Item.GetFilter("Date Filter"));
                ItemLedgEntry.SetFilter(ItemLedgEntry."Entry Type", 'Purchase');
                if ItemLedgEntry.CalcSums(ItemLedgEntry.Quantity)then PurchQty:=ItemLedgEntry.Quantity;
                ;
                ItemLedgEntry.Reset;
                ItemLedgEntry.SetCurrentkey("Item No.", "Entry Type", "Variant Code", "Drop Shipment", "Location Code", "Posting Date");
                if Item.GetFilter("Location Filter") <> '' then ItemLedgEntry.SetRange(ItemLedgEntry."Location Code", Item.GetFilter("Location Filter"));
                ItemLedgEntry.SetRange(ItemLedgEntry."Item No.", "No.");
                ItemLedgEntry.SetFilter(ItemLedgEntry."Posting Date", Item.GetFilter("Date Filter"));
                ItemLedgEntry.SetFilter(ItemLedgEntry."Entry Type", 'Consumption');
                if ItemLedgEntry.CalcSums(ItemLedgEntry.Quantity)then ConsuptQty:=Abs(ItemLedgEntry.Quantity);
                ItemLedgEntry.Reset;
                ItemLedgEntry.SetCurrentkey("Item No.", "Entry Type", "Variant Code", "Drop Shipment", "Location Code", "Posting Date");
                if Item.GetFilter("Location Filter") <> '' then ItemLedgEntry.SetRange(ItemLedgEntry."Location Code", Item.GetFilter("Location Filter"));
                ItemLedgEntry.SetRange(ItemLedgEntry."Item No.", "No.");
                ItemLedgEntry.SetFilter(ItemLedgEntry."Posting Date", Item.GetFilter("Date Filter"));
                ItemLedgEntry.SetFilter(ItemLedgEntry."Entry Type", 'Output');
                if ItemLedgEntry.CalcSums(ItemLedgEntry.Quantity)then OutputQty:=ItemLedgEntry.Quantity;
                ItemLedgEntry.Reset;
                ItemLedgEntry.SetCurrentkey("Item No.", "Entry Type", "Variant Code", "Drop Shipment", "Location Code", "Posting Date");
                if Item.GetFilter("Location Filter") <> '' then ItemLedgEntry.SetRange(ItemLedgEntry."Location Code", Item.GetFilter("Location Filter"));
                ItemLedgEntry.SetRange(ItemLedgEntry."Item No.", "No.");
                ItemLedgEntry.SetFilter(ItemLedgEntry."Posting Date", Item.GetFilter("Date Filter"));
                ItemLedgEntry.SetFilter(ItemLedgEntry."Entry Type", 'Sale');
                if ItemLedgEntry.CalcSums(ItemLedgEntry.Quantity)then SaleQty:=Abs(ItemLedgEntry.Quantity);
                ItemLedgEntry.Reset;
                ItemLedgEntry.SetCurrentkey("Item No.", "Entry Type", "Variant Code", "Drop Shipment", "Location Code", "Posting Date");
                if Item.GetFilter("Location Filter") <> '' then ItemLedgEntry.SetRange(ItemLedgEntry."Location Code", Item.GetFilter("Location Filter"));
                ItemLedgEntry.SetRange(ItemLedgEntry."Item No.", "No.");
                ItemLedgEntry.SetFilter(ItemLedgEntry."Entry Type", '<>Sale&<>Purchase&<>Consumption&<>Output');
                ItemLedgEntry.SetFilter(ItemLedgEntry."Posting Date", Item.GetFilter("Date Filter"));
                if ItemLedgEntry.CalcSums(ItemLedgEntry.Quantity)then OtherQty:=ItemLedgEntry.Quantity;
                CosingBal:=OpenBal + PurchQty - ConsuptQty + OutputQty - SaleQty + OtherQty;
            end;
            trigger OnPreDataItem()
            begin
                if Item.GetFilter("Date Filter") = '' then Error('You have to add Date Filter')
                else
                    EndDate:=Item.GetRangeMin("Date Filter");
                CurrReport.CreateTotals(OpenBal, PurchQty, ConsuptQty, OutputQty, SaleQty, OtherQty, CosingBal);
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
    /* // BIS 1145
        IF ExportToExcel THEN BEGIN
          ExcelBuf.CreateBook;
          ExcelBuf.CreateSheet('Item Inventory Summary', '', COMPANYNAME, USERID);
          ExcelBuf.GiveUserControl;
        END;
        */
    // BIS 1145
    end;
    trigger OnPreReport()
    begin
        ExcelBuf.DeleteAll;
        Clear(ExcelBuf);
        ResCen.Get(UserMgt.GetRespCenterFilter);
    end;
    var Desc1: Text[30];
    Desc2: Text[30];
    Uom: Code[10];
    PostQualiOrdHead: Record "SSD Posted Quality Order Hdr";
    QualityOrder: Code[20];
    ItemLedgEntry: Record "Item Ledger Entry";
    ItemRec: Record Item;
    OpenBal: Decimal;
    PurchQty: Decimal;
    ConsuptQty: Decimal;
    OutputQty: Decimal;
    SaleQty: Decimal;
    OtherQty: Decimal;
    CosingBal: Decimal;
    EndDate: Date;
    ExcelBuf: Record "Excel Buffer" temporary;
    ExportToExcel: Boolean;
    Countt: Integer;
    RowNo: Integer;
    ResCen: Record "Responsibility Center";
    UserMgt: Codeunit "SSD User Setup Management";
    Item_Inventory_SummaryCaptionLbl: label 'Item Inventory Summary';
    Item_CodeCaptionLbl: label 'Item Code';
    Description_1___2CaptionLbl: label 'Description 1 & 2';
    UOMCaptionLbl: label 'UOM';
    Opening_BalanceCaptionLbl: label 'Opening Balance';
    PurchaseCaptionLbl: label 'Purchase';
    ConsumptionCaptionLbl: label 'Consumption';
    OutputCaptionLbl: label 'Output';
    SaleCaptionLbl: label 'Sale';
    OthersCaptionLbl: label 'Others';
    Closing_BalanceCaptionLbl: label 'Closing Balance';
    TotalCaptionLbl: label 'Total';
    procedure EnterCell(RowNo: Integer; ColumnNo: Integer; CellValue: Text[250]; Bold: Boolean; UnderLine: Boolean)
    begin
        ExcelBuf.Init;
        ExcelBuf.Validate("Row No.", RowNo);
        ExcelBuf.Validate("Column No.", ColumnNo);
        ExcelBuf."Cell Value as Text":=CellValue;
        ExcelBuf.Formula:='';
        ExcelBuf.Bold:=Bold;
        ExcelBuf.Underline:=UnderLine;
        ExcelBuf.Insert;
    end;
    procedure EmptyBuffer()
    var
        ExcelBuffer: Record "Excel Buffer";
    begin
        if ExcelBuffer.Find('-')then ExcelBuffer.DeleteAll;
    end;
}
