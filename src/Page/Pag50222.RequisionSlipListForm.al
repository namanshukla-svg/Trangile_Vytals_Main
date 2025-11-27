Page 50222 "Requision Slip List Form"
{
    Editable = false;
    PageType = List;
    SourceTable = "SSD Requision Slip Header";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Control1000000000)
            {
                field("Req. Slip No."; Rec."Req. Slip No.")
                {
                    ApplicationArea = All;
                }
                field("Req. Date"; Rec."Req. Date")
                {
                    ApplicationArea = All;
                }
                field("Req. Time"; Rec."Req. Time")
                {
                    ApplicationArea = All;
                }
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                    ApplicationArea = All;
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                    ApplicationArea = All;
                }
                field("Responsibility Center"; Rec."Responsibility Center")
                {
                    ApplicationArea = All;
                }
                field("Transfer-To Location"; Rec."Transfer-To Location")
                {
                    ApplicationArea = All;
                }
                field("Transfer-From Location"; Rec."Transfer-From Location")
                {
                    ApplicationArea = All;
                }
                field("User ID"; Rec."User ID")
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
