Page 50325 "Sales order-AG"
{
    PageType = List;
    SourceTable = "Sales Header";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Control1000000001)
            {
                field("Document Type"; Rec."Document Type")
                {
                    ApplicationArea = All;
                }
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                }
                field("Sell-to Customer No."; Rec."Sell-to Customer No.")
                {
                    ApplicationArea = All;
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = All;
                }
                field("Order Date"; Rec."Order Date")
                {
                    ApplicationArea = All;
                }
                field("Created Date Time"; Rec."Created Date Time")
                {
                    ApplicationArea = All;
                }
                field(CT2; Rec.CT2)
                {
                    ApplicationArea = All;
                }
                field("Customer Order Date"; Rec."Customer Order Date")
                {
                    ApplicationArea = All;
                }
                field("External Document No."; Rec."External Document No.")
                {
                    ApplicationArea = All;
                }
                field("External Doc. Date"; Rec."External Doc. Date")
                {
                    ApplicationArea = All;
                }
                field("Gen. Bus. Posting Group"; Rec."Gen. Bus. Posting Group")
                {
                    ApplicationArea = All;
                }
                field("MRP No."; Rec."MRP No.")
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
