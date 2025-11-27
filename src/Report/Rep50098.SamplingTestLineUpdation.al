Report 50098 "Sampling Test Line Updation"
{
    ProcessingOnly = true;
    ApplicationArea = All;

    dataset
    {
        dataitem("Integer"; "Integer")
        {
            DataItemTableView = where(Number=const(1));

            column(ReportForNavId_5444;5444)
            {
            }
            trigger OnAfterGetRecord()
            var
                RoutingHeader: Record "Routing Header";
                ITMCODE: Code[20];
                RoutingLine: Record "Routing Line";
            begin
                if "Updation Type" = "updation type"::"Sampling Test Line Validation" then begin
                    SamplingTestLine.Reset;
                    if SamplingTestLine.FindFirst then repeat SamplingTestLine.Validate(SamplingTestLine."Meas. Code");
                            SamplingTestLine.Modify;
                        until SamplingTestLine.Next = 0;
                end;
                if "Updation Type" = "updation type"::"Sampling Temp header Certified" then begin
                    SamplingTempHeader.Reset;
                    if SamplingTempHeader.FindFirst then repeat SamplingTempHeader.Status:=SamplingTempHeader.Status::Certified;
                            SamplingTempHeader.Modify;
                        until SamplingTempHeader.Next = 0;
                end;
                if "Updation Type" = "updation type"::"Item Sampling Attachment" then begin
                    ItemSamplingTemp.Reset;
                    ItemSamplingTemp.DeleteAll;
                    Item.Reset;
                    if Item.FindFirst then repeat /*
                            IF COPYSTR(Item."No.",1,2)<>'CN' THEN
                            IF COPYSTR(Item."No.",1,2)<>'FG' THEN
                            IF COPYSTR(Item."No.",1,2)<>'FA' THEN*/
                            SamplingTempHeader.Reset;
                            SamplingTempHeader.SetRange(SamplingTempHeader."No.", Item."No.");
                            SamplingTempHeader.SetRange(SamplingTempHeader."Template Type", SamplingTempHeader."template type"::Receipt);
                            if SamplingTempHeader.FindFirst then begin
                                ItemSamplingTemp.Init;
                                ItemSamplingTemp."Item Code":=Item."No.";
                                ItemSamplingTemp.Validate(ItemSamplingTemp."Sampling Temp. No.", Item."No.");
                                ItemSamplingTemp."Responsibility Center":=UserMgt.GetRespCenterFilter;
                                ItemSamplingTemp.Insert(true);
                            end;
                        until Item.Next = 0;
                end;
                if "Updation Type" = "updation type"::ItemPSUOM then begin
                    Item.Reset;
                    Item.SetRange(Item."Replenishment System", Item."replenishment system"::"Prod. Order");
                    Item.SetRange(Item."Purch. Unit of Measure", '');
                    if Item.FindFirst then repeat begin
                            Item."Purch. Unit of Measure":=Item."Base Unit of Measure";
                            //Item."Sales Unit of Measure":=Item."Base Unit of Measure";
                            Item.Modify;
                        end;
                        until Item.Next = 0;
                end;
                if "Updation Type" = "updation type"::ItemRoutingUpdate then begin
                    RoutingHeader.Reset;
                    if RoutingHeader.FindFirst then repeat begin
                            ITMCODE:=CopyStr(RoutingHeader."No.", 3);
                            Item.Reset;
                            if Item.Get(ITMCODE)then begin
                                Item."Routing No.":=RoutingHeader."No.";
                                Item.Modify;
                            end;
                            RoutingLine.Reset;
                            RoutingLine.SetRange(RoutingLine."Routing No.", RoutingHeader."No.");
                            if RoutingLine.FindFirst then repeat begin
                                    RoutingLine.Validate(RoutingLine."No.");
                                    RoutingLine.Modify;
                                end;
                                until RoutingLine.Next = 0;
                            RoutingHeader.Status:=RoutingHeader.Status::Certified;
                            RoutingHeader.Modify(true);
                        end;
                        until RoutingHeader.Next = 0;
                end;
                if "Updation Type" = "updation type"::RoutinglineReclc then begin
                    RoutingLine.Reset;
                    RoutingLine.SetRange(RoutingLine.Recalculate, true);
                    if RoutingLine.FindFirst then repeat RoutingLine.Recalculate:=false;
                            RoutingLine.Modify;
                        until RoutingLine.Next = 0;
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
    var SamplingTestLine: Record "SSD Sampling Test Line";
    "Updation Type": Option " ", "Sampling Test Line Validation", "Sampling Temp header Certified", "Item Sampling Attachment", ItemPSUOM, ItemRoutingUpdate, RoutinglineReclc;
    SamplingTempHeader: Record "SSD Sampling Temp. Header";
    ItemSamplingTemp: Record "Item Sampling Template";
    Item: Record Item;
    UserMgt: Codeunit "SSD User Setup Management";
}
