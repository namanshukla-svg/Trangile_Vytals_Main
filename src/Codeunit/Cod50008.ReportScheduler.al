Codeunit 50008 "Report Scheduler"
{
    TableNo = "Job Queue Entry";

    trigger OnRun()
    begin
        if(StrPos(Rec."Parameter String", ';')) > 0 then begin
            Param:=CopyStr(Rec."Parameter String", 1, StrPos(Rec."Parameter String", ';') - 1);
            case Param of 'AdjustCostItemEntries': AdjustCostItemEntries;
            'FSNReport': FSNReport;
            'MRPReport': MRPReport;
            'ItemBlock90daysselflife': ItemBlock90daysselflife;
            'SalesHeaderShipDateUpdBatch': SalesHeaderShipDateUpdBatch;
            'ConsumptionReport': ConsumptionReport;
            'ItemInventorySummary': ItemInventorySummary;
            'AgedAccountPayable': AgedAccountPayable;
            'InventoryValuation': InventoryValuation;
            'PaymentPerformance_Vendor': PaymentPerformance_Vendor;
            'Agedaccountreceivable': Agedaccountreceivable;
            'PaymentPerformance_Cust': PaymentPerformance_Cust;
            'GSTExcelDataExport': GSTExcelDataExport;
            end;
        end end;
    var Param: Text;
    Year: Integer;
    StartDate: Date;
    local procedure AdjustCostItemEntries()
    begin
        Report.Run(795);
    end;
    local procedure FSNReport()
    var
        Item: Record Item;
    begin
        Item.Reset;
        Item.SetRange("Date Filter", CalcDate('-6M', Today), Today);
        Report.Run(50221, false, false, Item);
    end;
    local procedure MRPReport()
    begin
        Report.Run(99001017);
    end;
    local procedure ItemBlock90daysselflife()
    var
        ILE: Record "Item Ledger Entry";
    begin
        Report.Run(50000);
    end;
    local procedure SalesHeaderShipDateUpdBatch()
    begin
        Report.Run(50040);
    end;
    local procedure ConsumptionReport()
    var
        Item: Record Item;
    begin
        Item.Reset;
        Item.SetRange("Date Filter", CalcDate('-1Y', Today), Today);
        Report.Run(50140, false, false, Item);
    end;
    local procedure ItemInventorySummary()
    var
        Item: Record Item;
    begin
        Item.Reset;
        Item.SetRange("Date Filter", CalcDate('-1Y', Today), Today);
        Report.Run(50112, false, false, Item);
    end;
    local procedure AgedAccountPayable()
    var
        //AgedAccountsPayable: Report "Aged Accounts Payable";
        EndingDate: Date;
        AgingBy: Option "Due Date", "Posting Date", "Document Date";
        PeriodLength: DateFormula;
        HeadingType: Option "Date Interval", "Number of Days";
        Filename: Text;
    begin
        Filename:='D:\Aged Accounts Receivable\AgedAccountsPayable' + Format(WorkDate) + '.pdf';
        Evaluate(PeriodLength, '<30D>');
    //SSD Clear(AgedAccountsPayable);
    //SSD AgedAccountsPayable.InitializeRequest(
    //SSD WorkDate, Agingby::"Posting Date", PeriodLength, false, false, Headingtype::"Date Interval", false);
    //SSD AgedAccountsPayable.SaveAsPdf(Filename);
    //SSD AgedAccountsPayable.Run;
    end;
    local procedure InventoryValuation()
    var
        Item: Record Item;
    begin
        Item.Reset;
        Item.SetRange("Date Filter", CalcDate('-1Y', Today), Today);
        Report.Run(1001, false, false, Item);
    end;
    local procedure PaymentPerformance_Vendor()
    var
        Vendor: Record Vendor;
    begin
        Year:=Date2dmy(Today, 3);
        StartDate:=Dmy2date(1, 4, Year);
        Vendor.Reset;
        Vendor.SetRange("Date Filter", StartDate, Today);
        Report.Run(50138, false, false, Vendor);
    end;
    local procedure Agedaccountreceivable()
    var
        //SSD AgedAccountsReceivable: Report "Aged Accounts Receivable";
        EndingDate: Date;
        AgingBy: Option "Due Date", "Posting Date", "Document Date";
        PeriodLength: DateFormula;
        HeadingType: Option "Date Interval", "Number of Days";
        Filename: Text;
    begin
        Filename:='D:\Aged Accounts Receivable\AgedAccountsReceivable' + Format(WorkDate) + '.pdf';
        Evaluate(PeriodLength, '<30D>');
    //SSD Clear(AgedAccountsReceivable);
    //SSD AgedAccountsReceivable.InitializeRequest(
    //SSD WorkDate, Agingby::"Posting Date", PeriodLength, false, false, Headingtype::"Date Interval", false, false);
    //SSD AgedAccountsReceivable.SaveAsPdf(Filename);
    //SSD AgedAccountsReceivable.Run;
    end;
    local procedure PaymentPerformance_Cust()
    var
        Customer: Record Customer;
    begin
        Year:=Date2dmy(Today, 3);
        StartDate:=Dmy2date(1, 4, Year);
        Customer.Reset;
        Customer.SetRange("Date Filter", StartDate, Today);
        Report.Run(50138, false, false, Customer);
    end;
    local procedure GSTExcelDataExport()
    var
        SalesInvHead: Record "Sales Invoice Header";
    begin
        SalesInvHead.Reset;
        SalesInvHead.SetRange("Posting Date", CalcDate('-1M', Today), Today);
        Report.Run(50231, false, false, SalesInvHead);
    end;
}
