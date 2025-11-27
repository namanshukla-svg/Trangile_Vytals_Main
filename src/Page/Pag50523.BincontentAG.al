Page 50523 "Bin content-AG"
{
    PageType = List;
    Permissions = TableData "Bin Content"=rimd;
    SourceTable = "Bin Content";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Control1170000001)
            {
                field("Location Code"; Rec."Location Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the location code of the bin.';
                }
                field("Zone Code"; Rec."Zone Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the zone code of the bin.';
                }
                field("Bin Code"; Rec."Bin Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the bin where the items are picked or put away.';
                }
                field("Item No."; Rec."Item No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the number of the item that will be stored in the bin.';
                }
                field("Bin Type Code"; Rec."Bin Type Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the code of the bin type that was selected for this bin.';
                }
                field("Warehouse Class Code"; Rec."Warehouse Class Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the warehouse class code. Only items with the same warehouse class can be stored in this bin.';
                }
                field("Block Movement"; Rec."Block Movement")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies how the movement of a particular item, or bin content, into or out of this bin, is blocked.';
                }
                field("Min. Qty."; Rec."Min. Qty.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the minimum number of units of the item that you want to have in the bin at all times.';
                }
                field("Max. Qty."; Rec."Max. Qty.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the maximum number of units of the item that you want to have in the bin.';
                }
                field("Bin Ranking"; Rec."Bin Ranking")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the bin ranking.';
                }
                field(Quantity; Rec.Quantity)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Quantity field.';
                }
                field("Pick Qty."; Rec."Pick Qty.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Pick Qty. field.';
                }
                field("Neg. Adjmt. Qty."; Rec."Neg. Adjmt. Qty.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Neg. Adjmt. Qty. field.';
                }
                field("Put-away Qty."; Rec."Put-away Qty.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Put-away Qty. field.';
                }
                field("Pos. Adjmt. Qty."; Rec."Pos. Adjmt. Qty.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Pos. Adjmt. Qty. field.';
                }
                field("Fixed"; Rec.Fixed)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies that the item (bin content) has been associated with this bin, and that the bin should normally contain the item.';
                }
                field("Cross-Dock Bin"; Rec."Cross-Dock Bin")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies if the bin content is in a cross-dock bin.';
                }
                field(Default; Rec.Default)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies if the bin is the default bin for the associated item.';
                }
                field("Quantity (Base)"; Rec."Quantity (Base)")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies how many units of the item, in the base unit of measure, are stored in the bin.';
                }
                field("Pick Quantity (Base)"; Rec."Pick Quantity (Base)")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies how many units of the item, in the base unit of measure, will be picked from the bin.';
                }
                field("Negative Adjmt. Qty. (Base)"; Rec."Negative Adjmt. Qty. (Base)")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies how many item units, in the base unit of measure, will be posted on journal lines as negative quantities.';
                }
                field("Put-away Quantity (Base)"; Rec."Put-away Quantity (Base)")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies how many units of the item, in the base unit of measure, will be put away in the bin.';
                }
                field("Positive Adjmt. Qty. (Base)"; Rec."Positive Adjmt. Qty. (Base)")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies how many item units, in the base unit of measure, will be posted on journal lines as positive quantities.';
                }
                field("ATO Components Pick Qty."; Rec."ATO Components Pick Qty.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the ATO Components Pick Qty. field.';
                }
                field("ATO Components Pick Qty (Base)"; Rec."ATO Components Pick Qty (Base)")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies how many assemble-to-order units are picked for assembly.';
                }
                field("Variant Code"; Rec."Variant Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the variant of the item on the line.';
                }
                field("Qty. per Unit of Measure"; Rec."Qty. per Unit of Measure")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the number of base units of measure that are in the unit of measure specified for the item in the bin.';
                }
                field("Unit of Measure Code"; Rec."Unit of Measure Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies how each unit of the item or resource is measured, such as in pieces or hours. By default, the value in the Base Unit of Measure field on the item or resource card is inserted.';
                }
                field(Dedicated; Rec.Dedicated)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies if the bin is used as a dedicated bin, which means that its bin content is available only to certain resources.';
                }
            }
        }
    }
    actions
    {
    }
}
