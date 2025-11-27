report 55008 "Central Flash Query"
{
    ApplicationArea = All;
    Caption = 'Central Flash';
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/55008_CentralFlashQuery.rdl';

    dataset
    {
        dataitem(Integer; Integer)
        {
            MaxIteration = 1;

            trigger OnAfterGetRecord()
            begin
                Amount := 0;
                Billing := 0;
                Clear(PoolUpdate1);
                PoolUpdate1.SetRange(PoolUpdate1.Posting_Date, StartDate, EndDate);
                PoolUpdate1.SetRange(PoolUpdate1.Sales_Region, PoolUpdate1.Sales_Region::Central);
                PoolUpdate1.Open();
                while PoolUpdate1.Read() do begin
                    if not SSDPoolUpdateTable.Get(PoolUpdate1.Code, PoolUpdate1.Sales_Region) then begin
                        SSDPoolUpdateTable.Init();
                        SSDPoolUpdateTable.Code := PoolUpdate1.Code; //#1
                        SSDPoolUpdateTable."Sales Region" := PoolUpdate1.Sales_Region; //#2
                        SSDPoolUpdateTable."Billing(MTD)" := PoolUpdate1.Amount;
                        SSDPoolUpdateTable.Insert();
                    end
                    else begin
                        SSDPoolUpdateTable."Billing(MTD)" += PoolUpdate1.Amount;
                        SSDPoolUpdateTable.Modify();
                    end;
                end;
                Clear(PoolUpdate1);
                PoolUpdate1.SetRange(PoolUpdate1.Posting_Date, StartDate1, EndDate1);
                PoolUpdate1.SetRange(PoolUpdate1.Sales_Region, PoolUpdate1.Sales_Region::Central);
                PoolUpdate1.Open();
                while PoolUpdate1.Read() do begin
                    if not SSDPoolUpdateTable.Get(PoolUpdate1.Code, PoolUpdate1.Sales_Region) then begin
                        SSDPoolUpdateTable.Init();
                        SSDPoolUpdateTable.Code := PoolUpdate1.Code; //#1
                        SSDPoolUpdateTable."Sales Region" := PoolUpdate1.Sales_Region; //#2
                        SSDPoolUpdateTable."Billing(YTD)" := PoolUpdate1.Amount;
                        SSDPoolUpdateTable.Insert();
                    end
                    else begin
                        SSDPoolUpdateTable."Billing(YTD)" += PoolUpdate1.Amount;
                        SSDPoolUpdateTable.Modify();
                    end;
                end;
                Clear(PoolUpdate2);
                PoolUpdate2.SetRange(PoolUpdate2.Order_Date, StartDate1, EndDate);//IG_DS EndDate1);
                PoolUpdate2.SetRange(PoolUpdate2.Sales_Region, PoolUpdate2.Sales_Region::Central);
                PoolUpdate2.Open();
                while PoolUpdate2.Read() do begin
                    if not SSDPoolUpdateTable.Get(PoolUpdate2.Code, PoolUpdate2.Sales_Region) then begin
                        SSDPoolUpdateTable.Init();
                        SSDPoolUpdateTable.Code := PoolUpdate2.Code; //#1
                        SSDPoolUpdateTable."Sales Region" := PoolUpdate2.Sales_Region; //#2
                        SSDPoolUpdateTable.Pending := PoolUpdate2.Unit_Price * PoolUpdate2.Outstanding_Quantity;
                        SSDPoolUpdateTable.Insert();
                    end
                    else begin
                        SSDPoolUpdateTable.Pending += PoolUpdate2.Unit_Price * PoolUpdate2.Outstanding_Quantity;
                        SSDPoolUpdateTable.Modify();
                    end;
                end;
                //IG_DS
                Clear(PoolUpdate2A);
                // PoolUpdate2A.SetRange(PoolUpdate2A.Order_Date, StartDate1, EndDate);//IG_DS EndDate1);
                PoolUpdate2A.SetRange(PoolUpdate2A.Sales_Region, PoolUpdate2A.Sales_Region::Central);
                PoolUpdate2A.Open();
                while PoolUpdate2A.Read() do begin
                    if not SSDPoolUpdateTable.Get(PoolUpdate2A.Code, PoolUpdate2A.Sales_Region) then begin
                        SSDPoolUpdateTable.Init();
                        SSDPoolUpdateTable.Code := PoolUpdate2A.Code; //#1
                        SSDPoolUpdateTable."Sales Region" := PoolUpdate2A.Sales_Region; //#2
                        SSDPoolUpdateTable."Total Pending Pool" := PoolUpdate2A.Unit_Price * PoolUpdate2A.Outstanding_Quantity;
                        SSDPoolUpdateTable.Insert();
                    end
                    else begin
                        SSDPoolUpdateTable."Total Pending Pool" += PoolUpdate2A.Unit_Price * PoolUpdate2A.Outstanding_Quantity;
                        SSDPoolUpdateTable.Modify();
                    end;
                end;
                //IG_DS
                Clear(PoolUpdate3);
                PoolUpdate3.SetRange(PoolUpdate3.Posting_Date, StartDate, EndDate);
                PoolUpdate3.SetRange(PoolUpdate3.Sales_Region, PoolUpdate3.Sales_Region::Central);
                PoolUpdate3.Open();
                while PoolUpdate3.Read() do begin
                    if not SSDPoolUpdateTable.Get(PoolUpdate3.Code, PoolUpdate3.Sales_Region) then begin
                        SSDPoolUpdateTable.Init();
                        SSDPoolUpdateTable.Code := PoolUpdate3.Code; //#1
                        SSDPoolUpdateTable."Sales Region" := PoolUpdate3.Sales_Region; //#2
                        SSDPoolUpdateTable."Sales Return(MTD)" := PoolUpdate3.Unit_Price * PoolUpdate3.Quantity;
                        SSDPoolUpdateTable.Insert();
                    end
                    else begin
                        SSDPoolUpdateTable."Sales Return(MTD)" += PoolUpdate3.Unit_Price * PoolUpdate3.Quantity;
                        SSDPoolUpdateTable.Modify();
                    end;
                end;
                Clear(PoolUpdate3);
                PoolUpdate3.SetRange(PoolUpdate3.Posting_Date, StartDate1, EndDate1);
                PoolUpdate3.SetRange(PoolUpdate3.Sales_Region, PoolUpdate3.Sales_Region::Central);
                PoolUpdate3.Open();
                while PoolUpdate3.Read() do begin
                    if not SSDPoolUpdateTable.Get(PoolUpdate3.Code, PoolUpdate3.Sales_Region) then begin
                        SSDPoolUpdateTable.Init();
                        SSDPoolUpdateTable.Code := PoolUpdate3.Code; //#1
                        SSDPoolUpdateTable."Sales Region" := PoolUpdate3.Sales_Region; //#2
                        SSDPoolUpdateTable."Sales Return(YTD)" := PoolUpdate3.Unit_Price * PoolUpdate3.Quantity;
                        SSDPoolUpdateTable.Insert();
                    end
                    else begin
                        SSDPoolUpdateTable."Sales Return(YTD)" += PoolUpdate3.Unit_Price * PoolUpdate3.Quantity;
                        SSDPoolUpdateTable.Modify();
                    end;
                end;
            end;

            trigger OnPreDataItem()
            begin
            end;
        }
        dataitem(Integer2; Integer)
        {
            DataItemTableView = SORTING(Number) ORDER(Ascending) WHERE(Number = FILTER(1 ..));

            column(Code_PoolUpdateTable; SSDPoolUpdateTableRec.Code)
            {
            }
            column(Category_PoolUpdateTable; SSDPoolUpdateTableRec."Sales Region")
            {
            }
            column(Billing_PoolUpdateTable; Round(SSDPoolUpdateTableRec."Billing(MTD)", 0.01, '='))
            {
            }
            column(Pending_PoolUpdateTable; Round(SSDPoolUpdateTableRec.Pending, 0.01, '='))
            {
            }
            column(TotalPendingPool_PoolUpdateTable; Round(SSDPoolUpdateTableRec."Total Pending Pool", 0.01, '='))
            {
            }
            column(SSDPoolUpdateTableRec_SalesReturn; Round(SSDPoolUpdateTableRec."Sales Return(MTD)", 0.01, '='))
            {
            }
            column(SSDPoolUpdateTableRec_BillingYTD; Round(SSDPoolUpdateTableRec."Billing(YTD)", 0.01, '='))
            {
            }
            column(SSDPoolUpdateTableRec_SalesReturnYTD; Round(SSDPoolUpdateTableRec."Sales Return(YTD)", 0.01, '='))
            {
            }
            column(HeadingMonthYear; HeadingMonthYear)
            {
            }
            trigger OnAfterGetRecord()
            begin
                IF Number = 1 THEN BEGIN
                    IF NOT SSDPoolUpdateTableRec.FINDSET(FALSE) THEN CurrReport.BREAK;
                END
                ELSE IF SSDPoolUpdateTableRec.NEXT = 0 THEN CurrReport.BREAK;
            end;
        }
    }
    requestpage
    {
        layout
        {
            area(content)
            {
                group(GroupName)
                {
                    field(SELECTDATE; SELECTDATE)
                    {
                        ApplicationArea = ALL;
                    }
                }
            }
        }
        actions
        {
            area(processing)
            {
            }
        }
    }
    trigger OnPreReport()
    BEGIN
        if SELECTDATE = 0D then SELECTDATE := WorkDate();
        StartDate := CalcDate('<-CM>', SELECTDATE);
        EndDate := CalcDate('<CM>', SELECTDATE);
        AccountingPeriod.Reset();
        AccountingPeriod.SetRange("Starting Date", 0D, SELECTDATE);
        AccountingPeriod.SetRange("New Fiscal Year", true);
        if AccountingPeriod.FindLast then begin
            StartDate1 := AccountingPeriod."Starting Date";
        end
        else
            Error('Date does not lie in Accounting Period');
        EndDate1 := AccountingPeriodMgt.FindEndOfFiscalYear(SELECTDATE);
        MonthInteger := Date2DMY(SELECTDATE, 2);
        HeadingMonthYear := GetMonthName(MonthInteger) + ',' + Format(Date2DMY(SELECTDATE, 3));
        SSDPoolUpdateTable.Reset();
        if SSDPoolUpdateTable.FindSet() then SSDPoolUpdateTable.DeleteAll();
    END;

    trigger OnPostReport()
    begin
    end;

    var
        SSDPoolUpdateTable: Record SSDPoolUpdateTableN;
        SSDPoolUpdateTableRec: Record SSDPoolUpdateTableN;
        PoolUpdate1: Query PoolUpdate1N;
        PoolUpdate2: Query PoolUpdate2N;
        PoolUpdate2A: Query PoolUpdate2N;
        PoolUpdate3: Query PoolUpdate3N;
        AccountingPeriod: Record "Accounting Period";
        AccountingPeriodMgt: Codeunit "Accounting Period Mgt.";
        SELECTDATE: Date;
        StartDate: Date;
        EndDate: Date;
        StartDate1: Date;
        EndDate1: Date;
        Billing: Decimal;
        pending: Decimal;
        HeadingMonthYear: Text;
        MonthInteger: Integer;
        Amount: Decimal;

    Local procedure GetMonthName(var MonthNo: Integer) MonthName: Text[20];
    begin
        IF MonthNo = 1 THEN
            MonthName := 'January'
        ELSE IF MonthNo = 2 THEN
            MonthName := 'February'
        ELSE IF MonthNo = 3 THEN
            MonthName := 'March'
        ELSE IF MonthNo = 4 THEN
            MonthName := 'April'
        ELSE IF MonthNo = 5 THEN
            MonthName := 'May'
        ELSE IF MonthNo = 6 THEN
            MonthName := 'June'
        ELSE IF MonthNo = 7 THEN
            MonthName := 'July'
        ELSE IF MonthNo = 8 THEN
            MonthName := 'August'
        ELSE IF MonthNo = 9 THEN
            MonthName := 'September'
        ELSE IF MonthNo = 10 THEN
            MonthName := 'October'
        ELSE IF MonthNo = 11 THEN
            MonthName := 'November'
        ELSE IF MonthNo = 12 THEN MonthName := 'Decemeber';
    end;
}