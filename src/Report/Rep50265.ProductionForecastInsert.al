Report 50265 "Production Forecast Insert"
{
    ProcessingOnly = true;
    ApplicationArea = All;

    dataset
    {
        dataitem("Pre. Production Forecast Entry"; "SSD Pre. Prod. Forecast Entry")
        {
            DataItemTableView = sorting("Customer No.", "Item Code")where("Forecast Qty"=filter(<>0), "Posted to Production Forecast"=const(false));
            RequestFilterFields = "Customer No.", "Item Code", "Month Date";

            column(ReportForNavId_1000000000;1000000000)
            {
            }
            trigger OnAfterGetRecord()
            begin
                if "Pre. Production Forecast Entry"."Month Date" = 0D then CurrReport.Skip;
                if CustNo <> "Pre. Production Forecast Entry"."Customer No." then begin
                    ProductionForecastEntry.Reset;
                    ProductionForecastEntry.SetRange("Production Forecast Name", "Pre. Production Forecast Entry"."Customer No.");
                    //ProductionForecastEntry.SETRANGE("Item No.","Pre. Production Forecast Entry"."Item Code");
                    ProductionForecastEntry.SetRange("Forecast Date", StartDate, 99991231D);
                    if ProductionForecastEntry.FindSet then repeat ProductionForecastEntry.Delete until ProductionForecastEntry.Next = 0;
                end;
                CustNo:="Pre. Production Forecast Entry"."Customer No.";
                // EndDate := CALCDATE('CM',"Pre. Production Forecast Entry".GETFILTER("Month Date"));
                ProductionForecastName.Reset;
                ProductionForecastName.SetRange(Name, "Pre. Production Forecast Entry"."Customer No.");
                if ProductionForecastName.FindFirst then begin
                    ProductionForecastEntry1.FindLast;
                    ProductionForecastEntry1.Init;
                    ProductionForecastEntry1."Entry No.":=ProductionForecastEntry1."Entry No." + 1;
                    ProductionForecastEntry1."Production Forecast Name":="Pre. Production Forecast Entry"."Customer No.";
                    ProductionForecastEntry1."Item No.":="Pre. Production Forecast Entry"."Item Code";
                    ProductionForecastEntry1.Description:="Pre. Production Forecast Entry"."Item Description";
                    if Item.Get("Pre. Production Forecast Entry"."Item Code")then;
                    ProductionForecastEntry1.Validate("Unit of Measure Code", Item."Base Unit of Measure");
                    ProductionForecastEntry1."Forecast Date":="Pre. Production Forecast Entry"."Month Date";
                    ProductionForecastEntry1.Validate("Forecast Quantity", "Pre. Production Forecast Entry"."Forecast Qty");
                    ProductionForecastEntry1."Customer Code":="Pre. Production Forecast Entry"."Customer No."; //Alle 12042021
                    ProductionForecastEntry1."Customer Name":="Pre. Production Forecast Entry"."Customer Name"; //Alle 12042021
                    if ProductionForecastEntry1.Insert then begin
                        "Pre. Production Forecast Entry"."Posted to Production Forecast":=true;
                        "Pre. Production Forecast Entry".Modify;
                    end;
                end
                else
                    Error('Production Forecast Does not exist for Customer No. %1', "Pre. Production Forecast Entry"."Customer No.");
            end;
            trigger OnPreDataItem()
            begin
                Clear(StartDate);
                Clear(EndDate);
                StartDate:=CalcDate('-CM', "Pre. Production Forecast Entry".GetRangeMin("Month Date"));
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
        Message('Data Inserted');
    end;
    var ProductionForecastEntry: Record "Production Forecast Entry";
    Item: Record Item;
    Window: Dialog;
    ProductionForecastName: Record "Production Forecast Name";
    ProductionForecastEntry1: Record "Production Forecast Entry";
    StartDate: Date;
    EndDate: Date;
    CustNo: Code[20];
}
