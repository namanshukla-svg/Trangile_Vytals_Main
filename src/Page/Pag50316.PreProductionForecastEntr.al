Page 50316 "Pre. Production Forecast Entr"
{
    PageType = List;
    RefreshOnActivate = true;
    SourceTable = "SSD Pre. Prod. Forecast Entry";
    SourceTableTemporary = true;
    SourceTableView = sorting("Month Date", "Item Code")order(ascending);
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Customer No."; Rec."Customer No.")
                {
                    ApplicationArea = All;
                }
                field("Item Code"; Rec."Item Code")
                {
                    ApplicationArea = All;
                }
                field("Minimum Stock Level"; Rec."Minimum Stock Level")
                {
                    ApplicationArea = All;
                }
                field("Item Description"; Rec."Item Description")
                {
                    ApplicationArea = All;
                }
                field("Item Description 2"; Rec."Item Description 2")
                {
                    ApplicationArea = All;
                }
                field("Item Description 3"; Rec."Item Description 3")
                {
                    ApplicationArea = All;
                }
                field("Customer Name"; Rec."Customer Name")
                {
                    ApplicationArea = All;
                }
                field("Month Date"; Rec."Month Date")
                {
                    ApplicationArea = All;
                }
                field("Forecast Qty"; Rec."Forecast Qty")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
    actions
    {
    }
    trigger OnOpenPage()
    begin
        PreProdForeEntr.Reset;
        PreProdForeEntr.SetCurrentkey("Month Date", "Item Code");
        if PreProdForeEntr.FindSet then repeat PreProdForeEntr2.Reset;
                PreProdForeEntr2.SetRange("Item Code", PreProdForeEntr."Item Code");
                PreProdForeEntr2.SetRange("Month Date", PreProdForeEntr."Month Date");
                if PreProdForeEntr2.FindSet then if(Month <> PreProdForeEntr."Month Date") or (Item <> PreProdForeEntr."Item Code")then begin
                        Co3:=PreProdForeEntr2.Count;
                        Co:=0;
                        Forecastqty:=0;
                    end;
                if Co = 0 then begin
                    Month:=PreProdForeEntr."Month Date";
                    Item:=PreProdForeEntr."Item Code";
                end;
                if(Month = PreProdForeEntr."Month Date") and (Item = PreProdForeEntr."Item Code")then begin
                    Forecastqty+=PreProdForeEntr."Forecast Qty";
                end;
                Co+=1;
                if Co3 = Co then begin
                    Rec.Init;
                    Rec."Customer No.":=PreProdForeEntr."Customer No.";
                    Rec."Item Code":=PreProdForeEntr."Item Code";
                    Rec."Minimum Stock Level":=PreProdForeEntr."Minimum Stock Level";
                    Rec."Item Description":=PreProdForeEntr."Item Description";
                    Rec."Item Description 2":=PreProdForeEntr."Item Description 2";
                    Rec."Item Description 3":=PreProdForeEntr."Item Description 3";
                    Rec."Month Date":=PreProdForeEntr."Month Date";
                    Rec."Forecast Qty":=Forecastqty;
                    Rec.Insert;
                end;
                Month:=PreProdForeEntr."Month Date";
                Item:=PreProdForeEntr."Item Code";
            until PreProdForeEntr.Next = 0;
    end;
    var Month: Date;
    Item: Code[20];
    Forecastqty: Decimal;
    Co: Integer;
    Forecastqty2: Decimal;
    PreProdForeEntr: Record "SSD Pre. Prod. Forecast Entry";
    Co2: Integer;
    Co3: Integer;
    PreProdForeEntr2: Record "SSD Pre. Prod. Forecast Entry";
}
