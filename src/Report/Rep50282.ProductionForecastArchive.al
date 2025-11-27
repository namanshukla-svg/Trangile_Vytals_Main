Report 50282 "Production Forecast Archive"
{
    ProcessingOnly = true;
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem("Production Forecast Entry"; "Production Forecast Entry")
        {
            column(ReportForNavId_1000000000;1000000000)
            {
            }
            trigger OnAfterGetRecord()
            var
                VerNo: Integer;
                VNo: Integer;
            begin
                if I = 1 then LastAchNo:=LastVersionnumber;
                I:=I + 1;
                ProductionForecastArchive.Init;
                ProductionForecastArchive."Production Forecast Name":="Production Forecast Entry"."Production Forecast Name";
                ProductionForecastArchive."Entry No.":="Production Forecast Entry"."Entry No.";
                ProductionForecastArchive."Item No.":="Production Forecast Entry"."Item No.";
                ProductionForecastArchive."Forecast Date":="Production Forecast Entry"."Forecast Date";
                ProductionForecastArchive."Forecast Quantity":="Production Forecast Entry"."Forecast Quantity";
                ProductionForecastArchive."Unit of Measure Code":="Production Forecast Entry"."Unit of Measure Code";
                ProductionForecastArchive."Qty. per Unit of Measure":="Production Forecast Entry"."Qty. per Unit of Measure";
                ProductionForecastArchive."Forecast Quantity (Base)":="Production Forecast Entry"."Forecast Quantity (Base)";
                ProductionForecastArchive."Location Code":="Production Forecast Entry"."Location Code";
                ProductionForecastArchive."Component Forecast":="Production Forecast Entry"."Component Forecast";
                ProductionForecastArchive.Description:="Production Forecast Entry".Description;
                ProductionForecastArchive."Customer Code":="Production Forecast Entry"."Customer Code";
                ProductionForecastArchive."Customer Name":="Production Forecast Entry"."Customer Name";
                ProductionForecastArchive."Version No.":=LastAchNo;
                ProductionForecastArchive."Creation Date":=CalcDate('-1M', WORKDATE);
                ProductionForecastArchive.Insert;
            end;
            trigger OnPostDataItem()
            begin
                Message('%1', I);
            end;
            trigger OnPreDataItem()
            begin
                // FirstDate := CALCDATE('-CM',WORKDATE);
                // LastDate := CALCDATE('4M-1D',FirstDate);
                SetRange("Forecast Date", FirstDate, LastDate);
                I:=1;
            end;
        }
    }
    requestpage
    {
        layout
        {
            area(content)
            {
                field(FirstDate; FirstDate)
                {
                    ApplicationArea = All;
                    Caption = 'First Date';
                }
                field(LastDate; LastDate)
                {
                    ApplicationArea = All;
                    Caption = 'Last Date';
                }
            }
        }
        actions
        {
        }
    }
    labels
    {
    }
    var //Workdate: Date;
    FirstDate: Date;
    LastDate: Date;
    ProductionForecastArchive: Record "SSD Prod Forecast Archive";
    ProductionForecastArchive2: Record "SSD Prod Forecast Archive";
    LastAchNo: Integer;
    I: Integer;
    local procedure LastVersionnumber(): Integer var
        ProductionForecastArchive2: Record "SSD Prod Forecast Archive";
    begin
        ProductionForecastArchive2.Reset;
        ProductionForecastArchive2.SetCurrentkey("Production Forecast Name", "Version No.");
        ProductionForecastArchive2.SetRange("Production Forecast Name", "Production Forecast Entry"."Production Forecast Name");
        ProductionForecastArchive2.SetRange("Item No.", "Production Forecast Entry"."Item No.");
        ProductionForecastArchive2.SetRange("Customer Code", "Production Forecast Entry"."Customer Code");
        //ProductionForecastArchive2.SETRANGE("Forecast Date",CALCDATE('-CM',LastDate),LastDate);
        ProductionForecastArchive2.SetRange("Forecast Date", FirstDate, LastDate);
        //ProductionForecastArchive2.SETFILTER("Creation Date",'<>%1',0D);
        //ERROR('%1    %2 ',CALCDATE('-CM',LastDate),LastDate);
        if ProductionForecastArchive2.FindLast then if ProductionForecastArchive2."Version No." < 4 then exit(ProductionForecastArchive2."Version No." + 1);
        exit(1);
    end;
}
