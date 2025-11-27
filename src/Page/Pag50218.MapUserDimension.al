Page 50218 "Map User Dimension"
{
    ApplicationArea = All;
    PageType = List;
    SourceTable = "SSD Map User Dimension";
    UsageCategory = Tasks;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("User Id"; Rec."User Id")
                {
                    ApplicationArea = All;
                }
                field("Dimension Code"; Rec."Dimension Code")
                {
                    ApplicationArea = All;
                }
                field("Dimension Value"; Rec."Dimension Value")
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
