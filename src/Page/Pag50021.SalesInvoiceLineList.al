Page 50021 "Sales Invoice Line List"
{
    // ALLE 3.15...ARE3
    Editable = false;
    PageType = List;
    SourceTable = "Sales Invoice Line";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Control1000000000)
            {
                field("Document No."; Rec."Document No.")
                {
                    ApplicationArea = All;
                }
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field(Quantity; Rec.Quantity)
                {
                    ApplicationArea = All;
                }
                field("Unit of Measure Code"; Rec."Unit of Measure Code")
                {
                    ApplicationArea = All;
                }
                field("CT2 Form"; Rec."CT2 Form")
                {
                    ApplicationArea = All;
                }
                field("CT2 Form Line No."; Rec."CT2 Form Line No.")
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
