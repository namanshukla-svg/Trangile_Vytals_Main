Page 50226 "Sales Forecast List"
{
    ApplicationArea = All;
    CardPageID = "Sales Forecast";
    PageType = List;
    SourceTable = "SSD Sales Forecast Header";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Sales Planning No."; Rec."Sales Planning No.")
                {
                    ApplicationArea = All;
                }
                field("Customer No."; Rec."Customer No.")
                {
                    ApplicationArea = All;
                }
                field(Date; Rec.Date)
                {
                    ApplicationArea = All;
                }
                field("User Id"; Rec."User Id")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
    actions
    {
        area(creation)
        {
            action("Calculate Sales MRP")
            {
                ApplicationArea = All;
                Caption = 'Calculate Sales MRP';

                trigger OnAction()
                var
                    ProductionForecastEntry_L: Record "Production Forecast Entry";
                    Date2: Date;
                    Item: Record Item;
                    SalesForecastLineProces2: Boolean;
                begin
                    SalesForecastLine_G2.Reset;
                    SalesForecastLine_G2.SetRange("Sales Document No.", Rec."Sales Planning No.");
                    SalesForecastLine_G2.SetRange(ISUpdated, true);
                    if not SalesForecastLine_G2.FindFirst then begin
                        SalesForecastLine_G.Reset;
                        SalesForecastLine_G.SetRange("Sales Document No.", Rec."Sales Planning No.");
                        if SalesForecastLine_G.FindSet then repeat ProductionForecastEntry.Reset;
                                ProductionForecastEntry.SetCurrentkey("Forecast Date"); //ALLE-NM
                                ProductionForecastEntry.SetRange("Production Forecast Name", SalesForecastLine_G."Forecast Name");
                                ProductionForecastEntry.SetRange("Item No.", SalesForecastLine_G."Item Code");
                                ProductionForecastEntry.SetRange("Component Forecast", false);
                                ProductionForecastEntry.SetRange("Forecast Date", CalcDate('-CM', Today), 99991225D);
                                Cont:=0;
                                if ProductionForecastEntry.FindSet then begin
                                    ProductionForecastEntry."Suggested Dealers PO Qty":=ProductionForecastEntry."Forecast Quantity" - SalesForecastLine_G.Stock - SalesForecastLine_G."SO Qty (Remaining)" - SalesForecastLine_G."Shipped Qty Intransit" + SalesForecastLine_G."Minimum Stock Level";
                                    //MESSAGE('%1',ProductionForecastEntry."Suggested Dealers PO Qty");
                                    repeat Date2:=0D;
                                        Cont+=1;
                                        if Cont <> 1 then ProductionForecastEntry."Suggested Dealers PO Qty":=CalculatedSuggesteDealersPOQty + ProductionForecastEntry."Forecast Quantity" - ActualSuggestedDealersPOQty;
                                        Item.Get(SalesForecastLine_G."Item Code");
                                        if Item."Base Unit of Measure" = 'KG' then ActualSuggestedDealersPOQty:=ProductionForecastEntry."Suggested Dealers PO Qty"
                                        else
                                            ActualSuggestedDealersPOQty:=CalculateActualPOQty(ProductionForecastEntry."Suggested Dealers PO Qty", SalesForecastLine_G."Pack Size");
                                        //ALLE-NM
                                        if ActualSuggestedDealersPOQty < 0 then ActualSuggestedDealersPOQty:=0;
                                        //ALLE-NM
                                        //ActualSuggestedDealersPOQty:= ActualData(ProductionForecastEntry."Suggested Dealers PO Qty",SalesForecastLine_G."Pack Size");
                                        CalculatedSuggesteDealersPOQty:=ProductionForecastEntry."Suggested Dealers PO Qty";
                                        ProductionForecastEntry."Actual Dealers PO Qty":=ActualSuggestedDealersPOQty;
                                        ProductionForecastEntry."Sales MRP":=true;
                                        Date2:=CalcDate(SalesForecastLine_G."Shipping Time", ProductionForecastEntry."Forecast Date");
                                        ProductionForecastEntry."Expected Receipt Date":=ProductionForecastEntry."Forecast Date";
                                        DateForm1:='-' + Format(SalesForecastLine_G."Lead Time Dispatch");
                                        DateForm2:='-' + Format(SalesForecastLine_G."Shipping Time");
                                        NewDate:=CalcDate(DateForm1, ProductionForecastEntry."Forecast Date");
                                        NewDate1:=CalcDate(DateForm2, NewDate);
                                        ProductionForecastEntry."Suggested Order Date":=NewDate1;
                                        ProductionForecastEntry.ISUpdated:=false;
                                        ProductionForecastEntry.ISCRMInserted:=false;
                                        ProductionForecastEntry.Modify;
                                    until ProductionForecastEntry.Next = 0;
                                end;
                                if SalesForecastLine_G.ISCRMInserted = true then SalesForecastLine_G.ISCRMInserted:=true
                                else
                                    SalesForecastLine_G.ISCRMInserted:=false;
                                SalesForecastLine_G.ISUpdated:=true;
                                SalesForecastLine_G.Modify;
                                SalesForecastLineProces2:=true;
                            until SalesForecastLine_G.Next = 0;
                        if SalesForecastLineProces2 then Message('MRP Update Successfully');
                    end
                    else
                        Error('you must remove Sales Mrp on production forcast');
                end;
            }
            action("Refresh Values")
            {
                ApplicationArea = All;
                Caption = 'Refresh Values';

                trigger OnAction()
                var
                    SalesForecastLineProcess: Boolean;
                begin
                    SalesForecastLine_G2.Reset;
                    SalesForecastLine_G2.SetRange("Sales Document No.", Rec."Sales Planning No.");
                    if SalesForecastLine_G2.FindSet then repeat SalesForecastLine_G2.TestField("Opening Stock Date");
                            SalesForecastLine_G2."SO Qty (Remaining)":=0;
                            SalesForecastLine_G2.Modify;
                            SalesHeader.Reset;
                            SalesHeader.SetRange("Document Type", SalesHeader."document type"::Order);
                            SalesHeader.SetRange("Sell-to Customer No.", SalesForecastLine_G2."Customer Code");
                            //SalesHeader.SETFILTER("Actual Delivery Date",'<>%1',0D);
                            SalesHeader.SetFilter("Posting Date", '>=%1', SalesForecastLine_G2."Opening Stock Date");
                            if SalesHeader.FindSet then repeat SalesLine.Reset;
                                    SalesLine.SetRange("Document No.", SalesHeader."No.");
                                    SalesLine.SetRange("Document Type", SalesHeader."Document Type");
                                    SalesLine.SetFilter("Outstanding Quantity", '<>%1', 0);
                                    SalesLine.SetRange("No.", SalesForecastLine_G2."Item Code");
                                    if SalesLine.FindSet then begin
                                        //SalesLine.CALCSUMS("Qty. to Ship");
                                        SalesForecastLine_G2."SO Qty (Remaining)"+=SalesLine."Outstanding Quantity";
                                    end;
                                until SalesHeader.Next = 0;
                            Clear(SalesForecastLine_G2."SP Sold Qty.");
                            SIH.Reset;
                            SIH.SetRange("Sell-to Customer No.", SalesForecastLine_G2."Customer Code");
                            SIH.SetFilter("Actual Delivery Date", '<>%1', 0D);
                            SIH.SetFilter("Posting Date", '>=%1', SalesForecastLine_G2."Opening Stock Date");
                            if SIH.FindSet then repeat SalesInvoiceLine.Reset;
                                    SalesInvoiceLine.SetRange("Document No.", SIH."No.");
                                    SalesInvoiceLine.SetRange("No.", SalesForecastLine_G2."Item Code");
                                    SalesInvoiceLine.SetRange(Type, SalesInvoiceLine.Type::Item);
                                    if SalesInvoiceLine.FindSet then begin
                                        SalesInvoiceLine.CalcSums(Quantity);
                                        SalesForecastLine_G2."SP Sold Qty."+=SalesInvoiceLine.Quantity;
                                    end;
                                until SIH.Next = 0;
                            SalesForecastLine_G2.Validate(SalesForecastLine_G2.Stock);
                            SalesForecastLine_G2.Validate(SalesForecastLine_G2."Forecast Quantity");
                            SalesForecastLine_G2.Validate(SalesForecastLine_G2."SO Qty (Remaining)");
                            SalesForecastLine_G2.Validate(SalesForecastLine_G2."Shipped Qty Intransit");
                            SalesForecastLine_G2.Validate(SalesForecastLine_G2."Minimum Stock Level");
                            //SalesForecastLine_G2.ISCRMInserted := TRUE;
                            SalesForecastLine_G2.ISUpdated:=false;
                            SalesForecastLine_G2.ISCRMException:=false;
                            SalesForecastLine_G2.Modify;
                            ProductionForecastEntry.Reset;
                            ProductionForecastEntry.SetRange("Production Forecast Name", SalesForecastLine_G2."Forecast Name");
                            ProductionForecastEntry.SetRange("Item No.", SalesForecastLine_G2."Item Code");
                            ProductionForecastEntry.SetRange("Component Forecast", false);
                            ProductionForecastEntry.SetRange("Forecast Date", CalcDate('-CM', Today), 99991225D);
                            if ProductionForecastEntry.FindSet then repeat ProductionForecastEntry.ISUpdated:=false;
                                    ProductionForecastEntry.ISCRMInserted:=false;
                                    ProductionForecastEntry.ISCRMException:=false;
                                    ProductionForecastEntry."Sales MRP":=false;
                                    ProductionForecastEntry."Suggested Dealers PO Qty":=0;
                                    ProductionForecastEntry."Actual Dealers PO Qty":=0;
                                    ProductionForecastEntry.Modify;
                                until ProductionForecastEntry.Next = 0;
                            SalesForecastLineProcess:=true;
                        until SalesForecastLine_G2.Next = 0;
                    if SalesForecastLineProcess then Message('Value Refresh Successfully');
                end;
            }
        }
    }
    var SalesForecastLine: Record "SSD Sales Forecast Line";
    stock2: Decimal;
    SoQty2: Decimal;
    ShippedIntransit2: Decimal;
    MSL2: Decimal;
    CalculatedSuggesteDealersPOQty: Decimal;
    Cont: Integer;
    ActualSuggestedDealersPOQty: Decimal;
    I: Integer;
    SalesForecastLine_G: Record "SSD Sales Forecast Line";
    ProductionForecastEntry: Record "Production Forecast Entry";
    SalesForecastLine_G2: Record "SSD Sales Forecast Line";
    NewDate: Date;
    NewDate1: Date;
    DateForm1: Text;
    DateForm2: Text;
    SalesHeader: Record "Sales Header";
    SalesLine: Record "Sales Line";
    SIH: Record "Sales Invoice Header";
    SalesInvoiceLine: Record "Sales Invoice Line";
    procedure GetData(stock: Decimal; SoQty: Decimal; ShippedIntransit: Decimal; MSL: Decimal)
    begin
        stock2:=stock;
        SoQty2:=SoQty;
        ShippedIntransit2:=ShippedIntransit;
        MSL2:=MSL;
    end;
    local procedure ActualData(calc_delear: Decimal; PackSize: Decimal): Decimal var
        Cont1: Integer;
        Cont2: Text;
        Str: Integer;
        Cont3: Integer;
    begin
        // IF calc_delear < 0 THEN BEGIN
        //  EXIT(0)
        // END ELSE BEGIN
        //  IF calc_delear  < 200 THEN
        //    EXIT(200)
        //  ELSE
        //    I :=200;
        //  FOR I := I TO calc_delear+200 DO BEGIN
        //    Cont1 += 1;
        //    IF ((calc_delear>=I) AND (calc_delear<=I+200)) THEN BEGIN
        //      Cont1 := STRLEN(FORMAT(I));
        //      Cont2 := COPYSTR(FORMAT(I),Cont1-1,Cont1);
        //      EVALUATE(Str,Cont2);
        //       EXIT(I+200-Str);
        //      END;
        //    I :=I+200;
        //  END;
        //
        //  END;
        calc_delear:=ROUND(calc_delear, 1); //ALLE-NM
        if calc_delear < 0 then begin
            exit(0)end
        else
        begin
            if calc_delear < PackSize then exit(PackSize)
            else
                Cont3:=ROUND(calc_delear, 1) MOD PackSize;
            if Cont3 = 0 then exit(calc_delear)
            else
                for I:=PackSize to calc_delear + PackSize do begin
                    if(calc_delear >= I) and (calc_delear <= I + PackSize)then begin
                        Cont1:=I + PackSize;
                        // MESSAGE('%1',Cont1);
                        Cont1:=Cont1 - Cont3 + PackSize;
                        // MESSAGE('%1jjj',Cont1);
                        exit(Cont1);
                    end;
                end;
            I+=PackSize;
        //            J := DispatchPlanning.Weight MOD 20;
        //        FOR I := 20 TO DispatchPlanning.Weight+20 DO BEGIN
        //          IF (DispatchPlanning.Weight >= I) AND (DispatchPlanning.Weight <= I+20) THEN BEGIN
        //            Weight := I+20;
        //            Weight := Weight - J;
        //          END;
        //        END;
        //         I += 20;
        //    Cont3 := calc_delear MOD PackSize;
        //  EXIT(Cont3+calc_delear);
        //    I :=PackSize;
        //  FOR I := I TO calc_delear+ PackSize DO BEGIN
        //    Cont1 += 1;
        //    IF ((calc_delear>=I) AND (calc_delear<=I+ PackSize)) THEN BEGIN
        //      Cont1 := STRLEN(FORMAT(I));
        //      Cont2 := COPYSTR(FORMAT(I),Cont1-1,Cont1);
        //      EVALUATE(Str,Cont2);
        //      Cont3 := (I+PackSize) MOD PackSize;
        //       EXIT(I+PackSize-Cont3);
        //      END;
        //    I :=I+PackSize;
        //  END;
        end;
    end;
    local procedure CalculateActualPOQty(SuggestedQty: Decimal; PackSize: Decimal): Decimal var
        Multiplier: Decimal;
    begin
        Clear(Multiplier);
        if PackSize <> 0 then begin
            Multiplier:=ROUND(SuggestedQty / PackSize, 1, '>');
            exit(Multiplier * PackSize);
        end;
    end;
}
