Report 50206 "Batch Update Sales H & Line II"
{
    ProcessingOnly = true;
    ApplicationArea = All;

    dataset
    {
        dataitem("Distributor Line"; "SSD Distributor Line")
        {
            DataItemTableView = sorting("MRP No", Month, "Item Code", "Sales Line No.") where(Updated = const(false), Blocked = const(false));

            column(ReportForNavId_1000000000; 1000000000)
            {
            }
            trigger OnAfterGetRecord()
            var
                Co: Integer;
                AlleEvents: Codeunit "Alle Events";
                SalesHeader2: Record "Sales Header";
            begin
                if DistributionHeader_G.Get("Distributor Line"."MRP No") then;
                if DistributionHeader_G."Error Text" <> '' then CurrReport.Skip;
                if CreateSalesOrder("Distributor Line") then begin
                    if DistributionHeader_G.Updated = true then begin
                        SalesHeader2.SetRange("Document Type", SalesHeader2."document type"::Order);
                        SalesHeader2.SetRange("Sell-to Customer No.", DistributionHeader_G."Customer Code");
                        SalesHeader2.SetRange("External Document No.", "Distributor Line"."SP Order No.");
                        SalesHeader2.SetRange(CT2, false);
                        if SalesHeader2.FindSet then
                            repeat
                                AlleEvents.SendMailOnSalesOrderCreate(SalesHeader2."No.", "Distributor Line"."SP Order No.");
                                SalesHeader2.CT2 := true;
                                SalesHeader2.Modify(true);
                            until SalesHeader2.Next = 0;
                        DistributionHeader_G."Error Text" := '';
                        DistributionHeader_G.Modify;
                    end;
                end
                else begin
                    DistributionHeader_G."Error Text" := CopyStr(GetLastErrorText, 1, MaxStrLen(DistributionHeader_G."Error Text"));
                    DistributionHeader_G.Modify;
                    Batch50197ErrorLog.Init;
                    Batch50197ErrorLog."Entry No." := CreateGuid;
                    Batch50197ErrorLog."MRP No." := DistributionHeader_G."MRP No.";
                    Batch50197ErrorLog."Customer Code" := DistributionHeader_G."Customer Code";
                    Batch50197ErrorLog."Error Date" := Today;
                    Batch50197ErrorLog."Error Time" := Time;
                    Batch50197ErrorLog."Error Text" := CopyStr(GetLastErrorText, 1, MaxStrLen(Batch50197ErrorLog."Error Text"));
                    Batch50197ErrorLog.Insert;
                end;
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
    var
        SalesHeader: Record "Sales Header";
        SalesLine: Record "Sales Line";
        LineNo: Integer;
        DistributorLine: Record "SSD Distributor Line";
        Item: Record Item;
        CountLines: Integer;
        NoSeriesManagement: Codeunit "No. Series";//IG_DS NoSeriesManagement;
        SalesReceivablesSetup: Record "Sales & Receivables Setup";
        i: Integer;
        j: Integer;
        DistributorLine2: Record "SSD Distributor Line";
        Bool: Boolean;
        SpOrderNo: Code[30];
        DistributorLine3: Record "SSD Distributor Line";
        DistributionHeader_G: Record "SSD Distributor Header";
        Batch50197ErrorLog: Record "SSD Batch 50197 Error Log";

    [TryFunction]
    local procedure CreateSalesOrder(DistributorLinePara: Record "SSD Distributor Line")
    var
        Co: Integer;
        AlleEvents: Codeunit "Alle Events";
        Item: Record Item;
    begin
        SalesReceivablesSetup.Get;
        DistributorLine3.Reset;
        DistributorLine3.SetRange("MRP No", DistributorLinePara."MRP No");
        DistributorLine3.SetRange(Updated, false);
        if not DistributorLine3.FindFirst then CurrReport.Skip;
        DistributionHeader_G.Reset;
        DistributionHeader_G.SetRange("MRP No.", "Distributor Line"."MRP No");
        if DistributionHeader_G.FindFirst then;
        SalesHeader.Init;
        SalesHeader."Document Type" := SalesHeader."document type"::Order;
        SalesHeader."Document Subtype" := SalesHeader."document subtype"::Order;
        SalesHeader."No." := NoSeriesManagement.GetNextNo(SalesReceivablesSetup."Order Nos.", WorkDate, true);
        SalesHeader."Posting Date" := WorkDate;
        SalesHeader.Validate("Sell-to Customer No.", DistributionHeader_G."Customer Code");
        SalesHeader."Serial No." := DistributionHeader_G."Serial No.";
        SalesHeader."MRP No." := DistributionHeader_G."MRP No.";
        SalesHeader.Insert(true);
        i := 1;
        DistributorLine.Reset;
        DistributorLine.SetCurrentkey("MRP No", "SP Order No.");
        DistributorLine.SetRange("MRP No", "Distributor Line"."MRP No");
        DistributorLine.SetRange(Updated, false);
        DistributorLine.SetRange(Blocked, false);
        if DistributorLine.FindSet then SpOrderNo := DistributorLine."SP Order No.";
        repeat
            Co += 1;
            Bool := true;
            if (Co > 3 * i) and (SpOrderNo = DistributorLine."SP Order No.") then begin
                SalesHeader.Init;
                SalesHeader."Document Type" := SalesHeader."document type"::Order;
                SalesHeader."Document Subtype" := SalesHeader."document subtype"::Order;
                SalesHeader."No." := NoSeriesManagement.GetNextNo(SalesReceivablesSetup."Order Nos.", WorkDate, true);
                SalesHeader."Posting Date" := WorkDate;
                SalesHeader.Validate("Sell-to Customer No.", DistributionHeader_G."Customer Code");
                SalesHeader."Serial No." := DistributionHeader_G."Serial No.";
                SalesHeader."MRP No." := DistributionHeader_G."MRP No.";
                SalesHeader.Insert(true);
                LineNo := 0;
                Bool := false;
                i += 1;
            end
            else
                i := 1;
            if (SpOrderNo <> DistributorLine."SP Order No.") then begin
                SalesHeader.Init;
                SalesHeader."Document Type" := SalesHeader."document type"::Order;
                SalesHeader."Document Subtype" := SalesHeader."document subtype"::Order;
                SalesHeader."No." := NoSeriesManagement.GetNextNo(SalesReceivablesSetup."Order Nos.", WorkDate, true);
                SalesHeader."Posting Date" := WorkDate;
                SalesHeader.Validate("Sell-to Customer No.", DistributionHeader_G."Customer Code");
                SalesHeader."Serial No." := DistributionHeader_G."Serial No.";
                SalesHeader."MRP No." := DistributionHeader_G."MRP No.";
                SalesHeader.Insert(true);
                LineNo := 0;
                Bool := false;
                i += 1;
                Co := 1;
            end;
            LineNo := LineNo + 10000;
            SalesLine.Init;
            SalesLine."Line No." := LineNo;
            SalesLine."Document Type" := SalesLine."document type"::Order;
            SalesLine."Document Subtype" := SalesLine."document subtype"::Order;
            SalesLine."Document No." := SalesHeader."No.";
            SalesLine.Type := SalesLine.Type::Item;
            SalesLine.Validate(SalesLine."No.", DistributorLine."Item Code");
            SalesLine.Validate(SalesLine.Quantity, DistributorLine.Quantity);
            SalesLine.Month := DistributorLine.Month;
            SalesLine."Forecast Name" := DistributorLine."Forecast Name";
            SalesLine."Suggested Quantity" := DistributorLine."Suggested Quantity";
            SalesLine."Required Receipt Date" := DistributorLine."Required Receipt Date";
            SalesLine."Suggested Receipt Date" := DistributorLine."Suggested Receipt Date";
            SalesLine."SP Order No." := DistributorLine."SP Order No.";
            SalesLine."SP Price" := DistributorLine."SP Price";
            SalesLine.Stock := DistributorLine.Stock;
            SalesLine."MRP No." := DistributorLine."MRP No";
            SalesLine."Sales Line No." := DistributorLine."Sales Line No.";
            SalesLine."Required Receipt Date" := DistributorLine."Required Receipt Date";
            SalesLine."Requested Delivery Date" := DistributorLine."Suggested Receipt Date";
            SalesLine."SP Remarks" := DistributorLine."SP Remarks";
            SalesLine.Insert;
            DistributorLine.Updated := true;
            DistributorLine."Create Sales Order" := true;
            DistributionHeader_G.Updated := true;
            DistributionHeader_G.Modify;
            SalesHeader."External Document No." := DistributorLine."SP Order No.";
            SalesHeader."External Doc. Date" := Today;
            SalesHeader.Modify(true);
            SpOrderNo := DistributorLine."SP Order No.";
            //AlleEvents.SendMailOnSOCreate(DistributorLine."SP Order No.");//ALLE-NM 25072019 Mail sent to Customer
            DistributorLine."Mail Sent" := true;
            DistributorLine.Modify;
        until DistributorLine.Next = 0;
    end;
}
