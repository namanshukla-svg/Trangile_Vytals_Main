Page 50228 "Sales Forecast Subform"
{
    AutoSplitKey = true;
    PageType = ListPart;
    SourceTable = "SSD Sales Forecast Line";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Sales Document No."; Rec."Sales Document No.")
                {
                    ApplicationArea = All;
                }
                field("Customer Code"; Rec."Customer Code")
                {
                    ApplicationArea = All;
                }
                field("Line No."; Rec."Line No.")
                {
                    ApplicationArea = All;
                }
                field("Item Code"; Rec."Item Code")
                {
                    ApplicationArea = All;
                }
                field("Lead Time Dispatch"; Rec."Lead Time Dispatch")
                {
                    ApplicationArea = All;
                }
                field("Shipping Time"; Rec."Shipping Time")
                {
                    ApplicationArea = All;
                }
                field("Pack Size"; Rec."Pack Size")
                {
                    ApplicationArea = All;
                }
                field("Item Name"; Rec."Item Name")
                {
                    ApplicationArea = All;
                }
                field("Opening Stock Date"; Rec."Opening Stock Date")
                {
                    ApplicationArea = All;
                }
                field("Opening Stock"; Rec."Opending Stock")
                {
                    ApplicationArea = All;
                    Caption = 'Opening Stock';

                    trigger OnValidate()
                    begin
                        Rec.Validate("Opending Stock");
                    end;
                }
                field("SSR for Specific Period"; Rec."SSR for Specific Period")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        Rec.Validate("SSR for Specific Period");
                    end;
                }
                field("SP Sold Qty."; Rec."SP Sold Qty.")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        Rec.Validate("SP Sold Qty.");
                    end;
                }
                field(Stock; Rec.Stock)
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        Rec.Validate(Stock);
                    end;
                }
                field("Forecast Name"; Rec."Forecast Name")
                {
                    ApplicationArea = All;
                    Lookup = true;
                }
                field("Forecast Quantity"; Rec."Forecast Quantity")
                {
                    ApplicationArea = All;
                    Visible = true;

                    trigger OnLookup(var Text: Text): Boolean begin
                        //SSDU ProductionForecastEntries.GetData(Rec.Stock, Rec."SO Qty (Remaining)", Rec."Shipped Qty Intransit", Rec."Minimum Stock Level", Rec."Pack Size");
                        ProductionForecastEntry.Reset;
                        ProductionForecastEntry.SetRange("Production Forecast Name", Rec."Forecast Name");
                        ProductionForecastEntry.SetRange("Item No.", Rec."Item Code");
                        ProductionForecastEntry.SetRange("Component Forecast", false);
                        if ProductionForecastEntry.FindFirst then begin
                            ProductionForecastEntries.SetTableview(ProductionForecastEntry);
                            ProductionForecastEntries.Run;
                        end;
                    end;
                    trigger OnValidate()
                    begin
                        Rec.Validate("Forecast Quantity");
                    end;
                }
                field("SO Qty (Remaining)"; Rec."SO Qty (Remaining)")
                {
                    ApplicationArea = All;
                    Visible = true;

                    trigger OnValidate()
                    begin
                        Rec.Validate("SO Qty (Remaining)");
                    end;
                }
                field("Shipped Qty Intransit"; Rec."Shipped Qty Intransit")
                {
                    ApplicationArea = All;
                    Visible = true;

                    trigger OnValidate()
                    begin
                        Rec.Validate("Shipped Qty Intransit");
                    end;
                }
                field("Minimum Stock Level"; Rec."Minimum Stock Level")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        Rec.Validate("Minimum Stock Level");
                    end;
                }
                field("Cal Suggested Dealer PO Qty"; Rec."Cal Suggested Dealer PO Qty")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Act Suggested Dealer PO Qty"; Rec."Act Suggested Dealer PO Qty")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Expected Receipt Date"; Rec."Expected Receipt Date")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("PO Given by Dealer"; Rec."PO Given by Dealer")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("SO NO."; Rec."SO NO.")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("SO QTY"; Rec."SO QTY")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field(ISCRMInserted; Rec.ISCRMInserted)
                {
                    ApplicationArea = All;
                }
                field(ISUpdated; Rec.ISUpdated)
                {
                    ApplicationArea = All;
                }
                field(ISCRMException; Rec.ISCRMException)
                {
                    ApplicationArea = All;
                }
                field(ExceptionDetails; Rec.ExceptionDetails)
                {
                    ApplicationArea = All;
                }
            }
        }
    }
    actions
    {
    }
    var ProductionForecastEntries: Page "Demand Forecast Entries";
    ProductionForecastEntry: Record "Production Forecast Entry";
}
