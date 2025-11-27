Report 50221 "FSN Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/FSN Report.rdl';
    UsageCategory = ReportsandAnalysis;
    ApplicationArea = all;

    dataset
    {
        dataitem(Item; Item)
        {
            CalcFields = Inventory, "Net Change";
            RequestFilterFields = "No.", "Date Filter", "Location Filter", "Gen. Prod. Posting Group", "Item Category Code", "Replenishment System";

            column(ReportForNavId_1000000000;1000000000)
            {
            }
            column(No_Item; Item."No.")
            {
            }
            column(Description_Item; Item.Description)
            {
            }
            column(Description2_Item; Item."Description 2")
            {
            }
            column(ReplenishmentSystem_Item; Item."Replenishment System")
            {
            }
            column(UnitCost_Item; ROUND(Item."Unit Cost"))
            {
            }
            column(ItemCategoryCode_Item; Item."Item Category Code")
            {
            }
            column(GenProdPostingGroup_Item; Item."Procurement Type")
            {
            }
            column(BaseUnitofMeasure_Item; Item."Base Unit of Measure")
            {
            }
            column(SafetyStockQuantity_Item; Item."Safety Stock Quantity")
            {
            }
            column(NetChange_Item; NetChangeItemInv)
            {
            }
            column(TotalConsumption; ROUND(TotalConsumption))
            {
            }
            column(AvgTotalConsumption; AvgTotalConsumption)
            {
            }
            column(ItemGETFILTERS; Item.GetFilters)
            {
            }
            column(NoOfDay; NoOfDay)
            {
            }
            column(InventoryTurnoverDays; InventoryTurnoverDays)
            {
            }
            column(InventoryTurnoverRateAnnual; InventoryTurnoverRateAnnual)
            {
            }
            column(FSNCategory; FSNCategory)
            {
            }
            column(ItemLeadTimeCalculation; Item."Lead Time Calculation")
            {
            }
            trigger OnAfterGetRecord()
            var
                ILE2: Record "Item Ledger Entry";
                ItemMas: Record Item;
            begin
                NetChangeItemInv:=0;
                TotalConsumption:=0;
                AvgTotalConsumption:=0;
                InventoryTurnoverDays:=0;
                InventoryTurnoverRateAnnual:=0;
                TotAvgQty:=0;
                TotNoOfDay:=0;
                FSNCategory:='';
                DailyAvgInv(OpnQty, OpnVal, CloQty, CloVal, AvgQty, AvgVal, Item, TotAvgQty, TotNoOfDay, LocationFilter, GlobalDim1);
                //NetChangeItemInv := ROUND(AvgQty);
                //MESSAGE('%1  %2',TotAvgQty,TotNoOfDay);
                NetChangeItemInv:=ROUND(TotAvgQty / TotNoOfDay);
                ILE2.SetCurrentkey("Entry Type", "Location Code", "External Document No.", "Item No.", "Subcon Order No.");
                ILE2.SetFilter("Entry Type", '%1|%2', ILE2."entry type"::Consumption, ILE2."entry type"::Sale);
                ILE2.SetRange("Posting Date", StartDate, EndDate);
                if Item.GetFilter("Location Filter") <> '' then ILE2.SetRange("Location Code", Item.GetFilter("Location Filter"));
                ILE2.SetRange("Item No.", "No.");
                if ILE2.FindSet then begin
                    // REPEAT
                    ILE2.CalcSums(Quantity);
                    TotalConsumption:=Abs(ILE2.Quantity);
                end;
                //UNTIL ILE2.NEXT = 0;
                if TotalConsumption <> 0 then AvgTotalConsumption:=ROUND(TotalConsumption / NoOfDay);
                if AvgTotalConsumption <> 0 then InventoryTurnoverDays:=ROUND(NetChangeItemInv / AvgTotalConsumption);
                if InventoryTurnoverDays <> 0 then InventoryTurnoverRateAnnual:=ROUND(365 / InventoryTurnoverDays);
                if(InventoryTurnoverDays < 30)then FSNCategory:='F';
                if(InventoryTurnoverDays > 30) and (InventoryTurnoverDays < 90)then FSNCategory:='S';
                if(InventoryTurnoverDays > 90)then FSNCategory:='N';
            end;
            trigger OnPreDataItem()
            begin
                StartDate:=Item.GetRangeMin("Date Filter");
                EndDate:=Item.GetRangemax("Date Filter");
                LocationFilter:=Item.GetFilter("Location Filter");
                GlobalDim1:=Item.GetFilter("Global Dimension 1 Filter");
                NoOfDay:=EndDate - StartDate;
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
    ReportName='FSN CATEGORISATION - DATA SIX MONTH';
    }
    var AvgDailyInvDSP: Decimal;
    TotalConsumption: Decimal;
    StartDate: Date;
    EndDate: Date;
    NoOfDay: Decimal;
    NetChangeItemInv: Decimal;
    AvgTotalConsumption: Decimal;
    InventoryTurnoverDays: Decimal;
    InventoryTurnoverRateAnnual: Decimal;
    FSNCategory: Text;
    OpnQty: Decimal;
    OpnVal: Decimal;
    CloQty: Decimal;
    CloVal: Decimal;
    AvgQty: Decimal;
    AvgVal: Decimal;
    TotAvgQty: Decimal;
    TotNoOfDay: Decimal;
    LocationFilter: Code[20];
    GlobalDim1: Code[20];
    procedure DailyAvgInv(var OpnQty: Decimal; var OpnVal: Decimal; var CloQty: Decimal; var CloVal: Decimal; var AvgQty: Decimal; var AvgVal: Decimal; ItemMaster: Record Item; var TAvgQty: Decimal; var TNoOfDay: Decimal; LocationFilter2: Code[20]; GlobalDim1Code: Code[20])
    var
        ILE: Record "Item Ledger Entry";
        DateMas: Record Date;
        PrevOpnQty: Decimal;
        PrevOpnVal: Decimal;
        UnitCost: Decimal;
        XitemNo: Code[20];
    begin
        TNoOfDay:=EndDate - StartDate + 1;
        DateMas.Reset;
        DateMas.SetCurrentkey("Period Type", "Period Start");
        DateMas.SetRange("Period Type", DateMas."period type"::Date);
        DateMas.SetRange("Period Start", StartDate, EndDate);
        if DateMas.FindSet then repeat OpnQty:=0;
                OpnVal:=0;
                CloQty:=0;
                CloVal:=0;
                AvgQty:=0;
                AvgVal:=0;
                ILE.Reset;
                ILE.SetCurrentkey("Item No.", "Posting Date");
                ILE.SetRange(ILE."Item No.", ItemMaster."No.");
                ILE.SetRange(ILE."Posting Date", 0D, DateMas."Period Start" - 1);
                ILE.SetRange(ILE."Item Category Code", ItemMaster."Item Category Code");
                if GlobalDim1Code <> '' then ILE.SetFilter(ILE."Global Dimension 1 Code", GlobalDim1Code);
                if LocationFilter2 <> '' then ILE.SetFilter(ILE."Location Code", LocationFilter2);
                if ILE.FindFirst then repeat ILE.CalcFields(ILE."Cost Amount (Actual)");
                        ILE.CalcSums(Quantity);
                        OpnQty:=ILE.Quantity;
                        OpnVal+=ILE."Cost Amount (Actual)";
                    until ILE.Next = 0;
                if OpnQty = 0 then OpnQty:=PrevOpnQty;
                if OpnVal = 0 then OpnVal:=PrevOpnVal;
                //PrevOpnQty:=OpnQty;
                //PrevOpnVal:=OpnVal;
                ILE.Reset;
                ILE.SetCurrentkey("Item No.", "Posting Date");
                ILE.SetRange(ILE."Item No.", ItemMaster."No.");
                ILE.SetRange(ILE."Posting Date", DateMas."Period Start");
                ILE.SetRange(ILE."Item Category Code", ItemMaster."Item Category Code");
                if GlobalDim1Code <> '' then ILE.SetFilter(ILE."Global Dimension 1 Code", GlobalDim1Code);
                if LocationFilter2 <> '' then ILE.SetFilter(ILE."Location Code", LocationFilter2);
                if ILE.FindFirst then repeat ILE.CalcFields(ILE."Cost Amount (Actual)");
                        ILE.CalcSums(Quantity);
                        CloQty:=ILE.Quantity;
                        CloVal+=ILE."Cost Amount (Actual)";
                    until ILE.Next = 0;
                CloQty+=OpnQty;
                CloVal+=OpnVal;
                if CloQty <> 0 then UnitCost:=CloVal / CloQty;
                AvgQty:=(OpnQty + CloQty) / 2;
                AvgVal:=(OpnVal + CloVal) / 2;
                if AvgQty <> 0 then TAvgQty+=AvgQty;
                if XitemNo <> ItemMaster."No." then begin
                    PrevOpnQty:=0;
                    PrevOpnVal:=0;
                    OpnQty:=0;
                    OpnVal:=0;
                    CloQty:=0;
                    CloVal:=0;
                    AvgQty:=0;
                    AvgVal:=0;
                end;
                XitemNo:=ItemMaster."No.";
            until DateMas.Next = 0;
    end;
}
