Page 50002 "SSD Freight Zone"
{
    ApplicationArea = All;
    PageType = Card;
    SourceTable = "SSD Freight Zone";
    UsageCategory = None;

    layout
    {
        area(content)
        {
            group("Freight Zone")
            {
                Caption = 'Freight Zone';

                field("Freight Zone No."; Rec."Freight Zone No.")
                {
                    ApplicationArea = All;

                    trigger OnAssistEdit()
                    begin
                        if Rec.AssistEdit(xRec)then CurrPage.Update;
                    end;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field("Creation Date"; Rec."Creation Date")
                {
                    ApplicationArea = All;
                }
                field("User ID"; Rec."User ID")
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
