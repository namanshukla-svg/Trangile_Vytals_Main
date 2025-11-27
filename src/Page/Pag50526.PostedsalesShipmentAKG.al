Page 50526 "Posted sales Shipment-AKG"
{
    PageType = List;
    Permissions = TableData "Sales Shipment Line"=rimd;
    SourceTable = "Sales Shipment Line";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Control1170000001)
            {
                field("Document No."; Rec."Document No.")
                {
                    ApplicationArea = All;
                }
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                }
                field("Shipment Date"; Rec."Shipment Date")
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field("Description 2"; Rec."Description 2")
                {
                    ApplicationArea = All;
                }
                field("Unit of Measure"; Rec."Unit of Measure")
                {
                    ApplicationArea = All;
                }
                field(Quantity; Rec.Quantity)
                {
                    ApplicationArea = All;
                }
                field("Unit Price"; Rec."Unit Price")
                {
                    ApplicationArea = All;
                }
                field("Unit Cost (LCY)"; Rec."Unit Cost (LCY)")
                {
                    ApplicationArea = All;
                }
                field("Location Code"; Rec."Location Code")
                {
                    ApplicationArea = All;
                }
                field("Item Shpt. Entry No."; Rec."Item Shpt. Entry No.")
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
