Page 50181 "Actual Transporter Detail"
{
    ApplicationArea = All;
    Editable = true;
    PageType = List;
    SourceTable = "SSD Actual Tpt Cont Detail";
    UsageCategory = Administration;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Shipping Agent Code"; Rec."Shipping Agent Code")
                {
                    ApplicationArea = All;
                }
                field("Contact1 Name"; Rec."Contact1 Name")
                {
                    ApplicationArea = All;
                }
                field("Contact1 Mob"; Rec."Contact1 Mob")
                {
                    ApplicationArea = All;
                }
                field("Contact1 Email"; Rec."Contact1 Email")
                {
                    ApplicationArea = All;
                }
                field("Contact2 Name"; Rec."Contact2 Name")
                {
                    ApplicationArea = All;
                }
                field("Contact2 Mob"; Rec."Contact2 Mob")
                {
                    ApplicationArea = All;
                }
                field("Contact2 Email"; Rec."Contact2 Email")
                {
                    ApplicationArea = All;
                }
                field(State; Rec.State)
                {
                    ApplicationArea = All;
                }
                field(City; Rec.City)
                {
                    ApplicationArea = All;
                }
                field("Post Code"; Rec."Post Code")
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
