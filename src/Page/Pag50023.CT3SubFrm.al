Page 50023 "CT3 SubFrm"
{
    AutoSplitKey = true;
    DelayedInsert = true;
    MultipleNewLines = true;
    PageType = ListPart;
    SourceTable = "SSD CT3 Line";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Control1000000000)
            {
                field("Item No."; Rec."Item No.")
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Description 2"; Rec."Description 2")
                {
                    ApplicationArea = All;
                }
                field(Quantity; Rec.Quantity)
                {
                    ApplicationArea = All;
                }
                field("Applied Qty"; Rec."Applied Qty")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(UOM; Rec.UOM)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Invoice Qty"; Rec."Invoice Qty")
                {
                    ApplicationArea = All;
                }
                field("Order Qty"; Rec."Order Qty")
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
