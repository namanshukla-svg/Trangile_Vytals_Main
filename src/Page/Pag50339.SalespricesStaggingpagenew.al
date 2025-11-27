Page 50339 "Sales prices Stagging page new"
{
    PageType = List;
    SourceTable = "SSD Sales Price Stagging";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Item No."; Rec."Item No.")
                {
                    ApplicationArea = All;
                }
                field("Sales Code"; Rec."Sales Code")
                {
                    ApplicationArea = All;
                }
                field("Currency Code"; Rec."Currency Code")
                {
                    ApplicationArea = All;
                }
                field("Starting Date"; Rec."Starting Date")
                {
                    ApplicationArea = All;
                }
                field("Unit Price"; Rec."Unit Price")
                {
                    ApplicationArea = All;
                }
                field("Price Includes VAT"; Rec."Price Includes VAT")
                {
                    ApplicationArea = All;
                }
                field("Allow Invoice Disc."; Rec."Allow Invoice Disc.")
                {
                    ApplicationArea = All;
                }
                field("VAT Bus. Posting Gr. (Price)"; Rec."VAT Bus. Posting Gr. (Price)")
                {
                    ApplicationArea = All;
                }
                field("Sales Type"; Rec."Sales Type")
                {
                    ApplicationArea = All;
                }
                field("Minimum Quantity"; Rec."Minimum Quantity")
                {
                    ApplicationArea = All;
                }
                field("Ending Date"; Rec."Ending Date")
                {
                    ApplicationArea = All;
                }
                field("Unit of Measure Code"; Rec."Unit of Measure Code")
                {
                    ApplicationArea = All;
                }
                field("Variant Code"; Rec."Variant Code")
                {
                    ApplicationArea = All;
                }
                field("Allow Line Disc."; Rec."Allow Line Disc.")
                {
                    ApplicationArea = All;
                }
                field("MRP Price"; Rec."MRP Price")
                {
                    ApplicationArea = All;
                }
                field(MRP; Rec.MRP)
                {
                    ApplicationArea = All;
                }
                field("Abatement %"; Rec."Abatement %")
                {
                    ApplicationArea = All;
                }
                field("PIT Structure"; Rec."PIT Structure")
                {
                    ApplicationArea = All;
                }
                field("Price Inclusive of Tax"; Rec."Price Inclusive of Tax")
                {
                    ApplicationArea = All;
                }
                field(Remarks; Rec.Remarks)
                {
                    ApplicationArea = All;
                }
                field("Credit Note"; Rec."Credit Note")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
    actions
    {
    }
    trigger OnOpenPage()
    begin
        // <<<< Alle 23/10/2018
        UserSetup.Get(UserId);
        if not UserSetup."Sales Price Approval" then Error('You are not authorized person,contact IT person');
    // >>>> Alle 23/10/2018
    end;
    var UserSetup: Record "User Setup";
}
