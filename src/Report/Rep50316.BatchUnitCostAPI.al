Report 50316 "Batch Unit Cost API"
{
    ProcessingOnly = true;
    ApplicationArea = All;

    dataset
    {
        dataitem(Item; Item)
        {
            DataItemTableView = sorting("No.")order(ascending)where("Replenishment System"=filter(Purchase));

            column(ReportForNavId_1170000000;1170000000)
            {
            }
            trigger OnAfterGetRecord()
            var
                ILE: Record "Item Ledger Entry";
                PurchaseLine: Record "Purchase Line";
                UnitCostAPI: Record "SSD Unit Cost API";
                UnitCostAPI2: Record "SSD Unit Cost API";
                PRL: Record "Purch. Rcpt. Line";
            begin
                ILE.Reset;
                ILE.SetRange("Entry Type", ILE."entry type"::Purchase);
                ILE.SetRange("Item No.", Item."No.");
                if not ILE.FindFirst then CurrReport.Skip;
                UnitCostAPI.Init;
                UnitCostAPI."Item No.":=Item."No.";
                UnitCostAPI."Creation Date":=Today;
                UnitCostAPI.Insert;
                ILE.Reset;
                ILE.SetCurrentkey("Entry No.");
                ILE.SetAscending("Entry No.", false);
                ILE.SetRange("Item No.", Item."No.");
                if ILE.FindFirst then begin
                    UnitCostAPI2.Reset;
                    UnitCostAPI2.SetRange("Item No.", Item."No.");
                    UnitCostAPI2.SetRange("Creation Date", Today);
                    if UnitCostAPI2.FindFirst then begin
                        UnitCostAPI2."ILE Date":=ILE."Posting Date";
                        ILE.CalcFields("Cost Amount (Actual)", "Cost Amount (Expected)");
                        UnitCostAPI2."Landed Cost":=(ILE."Cost Amount (Actual)" + ILE."Cost Amount (Expected)") / ILE.Quantity;
                        UnitCostAPI2.Modify;
                    end;
                end;
                I:=0;
                if I < 3 then begin
                    ILE.Reset;
                    ILE.SetAscending("Entry No.", false);
                    ILE.SetRange("Item No.", Item."No.");
                    ILE.SetRange("Entry Type", ILE."entry type"::Purchase);
                    if ILE.FindSet then repeat UnitCostAPI2.Reset;
                            UnitCostAPI2.SetRange("Item No.", Item."No.");
                            UnitCostAPI2.SetRange("Creation Date", Today);
                            if UnitCostAPI2.FindFirst then begin
                                PRL.SetRange("Document No.", ILE."Document No.");
                                PRL.SetRange("No.", Item."No.");
                                if PRL.FindFirst then begin
                                    if I = 0 then UnitCostAPI2."First PO Price":=PRL."Unit Cost (LCY)";
                                    if I = 1 then UnitCostAPI2."Second PO Price":=PRL."Unit Cost (LCY)";
                                    if I = 2 then UnitCostAPI2."Third PO Price":=PRL."Unit Cost (LCY)";
                                    UnitCostAPI2."Unit Cost":=Item."Unit Cost";
                                    UnitCostAPI2.Modify;
                                end;
                            end;
                            I+=1;
                        until ILE.Next = 0;
                end;
                currentmonth:=CalcDate('<-CM>', Today);
                Itembudgetentry.Reset;
                Itembudgetentry.SetRange("Analysis Area", Itembudgetentry."analysis area"::Purchase);
                Itembudgetentry.SetRange("Item No.", Item."No.");
                Itembudgetentry.SetRange(Date, currentmonth);
                if Itembudgetentry.FindFirst then begin
                    UnitCostAPI2.Reset;
                    UnitCostAPI2.SetRange("Item No.", Itembudgetentry."Item No.");
                    UnitCostAPI2.SetRange("Creation Date", Today);
                    if UnitCostAPI2.FindFirst then begin
                        UnitCostAPI2."Budgeted Cost":=Itembudgetentry."Cost Amount" / Itembudgetentry.Quantity;
                        UnitCostAPI2.Modify;
                    end;
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
    var I: Integer;
    Itembudgetentry: Record "Item Budget Entry";
    currentmonth: Date;
}
