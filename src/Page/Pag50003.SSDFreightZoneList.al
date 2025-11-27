Page 50003 "SSD Freight Zone List"
{
    Caption = 'Freight Zones';
    CardPageID = "SSD Freight Zone";
    Editable = false;
    PageType = List;
    SourceTable = "SSD Freight Zone";
    ApplicationArea = All;
    UsageCategory = Administration;

    layout
    {
        area(content)
        {
            repeater(Control1000000000)
            {
                field("Freight Zone No."; Rec."Freight Zone No.")
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field("Creation Date"; Rec."Creation Date")
                {
                    ApplicationArea = All;
                }
                field("Freight Zone Rate"; Rec."Freight Zone Rate")
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
