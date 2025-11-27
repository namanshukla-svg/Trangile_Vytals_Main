Page 50236 "Distributor Subform"
{
    CardPageID = "Distributor Header";
    DelayedInsert = false;
    DeleteAllowed = false;
    InsertAllowed = false;
    LinksAllowed = false;
    PageType = ListPart;
    SourceTable = "SSD Distributor Line";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("MRP No"; Rec."MRP No")
                {
                    ApplicationArea = All;
                }
                field("Forecast Name"; Rec."Forecast Name")
                {
                    ApplicationArea = All;
                }
                field("SP Order No."; Rec."SP Order No.")
                {
                    ApplicationArea = All;
                }
                field("Suggested Quantity"; Rec."Suggested Quantity")
                {
                    ApplicationArea = All;
                }
                field(Quantity; Rec.Quantity)
                {
                    ApplicationArea = All;
                }
                field(Month; Rec.Month)
                {
                    ApplicationArea = All;
                }
                field("Item Code"; Rec."Item Code")
                {
                    ApplicationArea = All;
                }
                field("Required Receipt Date"; Rec."Required Receipt Date")
                {
                    ApplicationArea = All;
                }
                field("Suggested Receipt Date"; Rec."Suggested Receipt Date")
                {
                    ApplicationArea = All;
                }
                field("SP Price"; Rec."SP Price")
                {
                    ApplicationArea = All;
                }
                field(Stock; Rec.Stock)
                {
                    ApplicationArea = All;
                }
                field(Updated; Rec.Updated)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Create Sales Order"; Rec."Create Sales Order")
                {
                    ApplicationArea = All;
                }
                field("SP Remarks"; Rec."SP Remarks")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
    actions
    {
    }
}
