Page 50117 "Quality: Measurements"
{
    ApplicationArea = All;
    PageType = List;
    SourceTable = "SSD Quality Measurements";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Control1000000000)
            {
                field("Code"; Rec.Code)
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field(Protocol; Rec.Protocol)
                {
                    ApplicationArea = All;
                }
                field("Measurement Tool Code"; Rec."Measurement Tool Code")
                {
                    ApplicationArea = All;
                }
                field("Measurement Tool Descr."; Rec."Measurement Tool Descr.")
                {
                    ApplicationArea = All;
                }
                field("Unit of Measure Code"; Rec."Unit of Measure Code")
                {
                    ApplicationArea = All;
                }
                field(Observations; Rec.Observations)
                {
                    ApplicationArea = All;
                }
                field("Measure Value Type"; Rec."Measure Value Type")
                {
                    ApplicationArea = All;
                }
                field("0D Para"; Rec."0D Para")
                {
                    ApplicationArea = All;
                    Caption = '0 Digit Decimal Places';
                }
                field("1D Para"; Rec."1D Para")
                {
                    ApplicationArea = All;
                    Caption = '1 Digit Decimal Places';
                }
                field("2D Para"; Rec."2D Para")
                {
                    ApplicationArea = All;
                    Caption = '2 Digit Decimal Places';
                }
                field("3D Para"; Rec."3D Para")
                {
                    ApplicationArea = All;
                    Caption = '3 Digit Decimal Places';
                }
                field(Discipline; Rec.Discipline)
                {
                    ApplicationArea = All;
                }
                field(Group; Rec.Group)
                {
                    ApplicationArea = All;
                    OptionCaption = ' ,Plastic+,Paper+,Lubricants,Petroleum,Misc.,Plastic & Paper+';
                }
                field("Under NABL Scope"; Rec."Under NABL Scope")
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
