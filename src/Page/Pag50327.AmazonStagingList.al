Page 50327 "Amazon Staging List"
{
    ApplicationArea = All;
    Editable = true;
    PageType = List;
    SourceTable = "SSD Amazon Staging";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Entry No."; Rec."Entry No.")
                {
                    ApplicationArea = All;
                }
                field("Amazon OrderId"; Rec."Amazon OrderId")
                {
                    ApplicationArea = All;
                }
                field("Amazon Posted Invoice No."; Rec."Amazon Posted Invoice No.")
                {
                    ApplicationArea = All;
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = All;
                }
                field("ZD Customer Code"; Rec."ZD Customer Code")
                {
                    ApplicationArea = All;
                }
                field("End Customer Name"; Rec."End Customer Name")
                {
                    ApplicationArea = All;
                }
                field("End Customer Name Address"; Rec."End Customer Name Address")
                {
                    ApplicationArea = All;
                }
                field("ZD FG Code"; Rec."ZD FG Code")
                {
                    ApplicationArea = All;
                }
                field(SKU; Rec.SKU)
                {
                    ApplicationArea = All;
                }
                field("Quantity Shipped"; Rec."Quantity Shipped")
                {
                    ApplicationArea = All;
                }
                field("Item Price"; Rec."Item Price")
                {
                    ApplicationArea = All;
                }
                field("Shipping Price"; Rec."Shipping Price")
                {
                    ApplicationArea = All;
                }
                field("Ship Promotion Discount"; Rec."Ship Promotion Discount")
                {
                    ApplicationArea = All;
                }
                field("Customer Ship-to-Code"; Rec."Customer Ship-to-Code")
                {
                    ApplicationArea = All;
                }
                field("Entry Type"; Rec."Entry Type")
                {
                    ApplicationArea = All;
                }
                field("Original Invoice No."; Rec."Original Invoice No.")
                {
                    ApplicationArea = All;
                }
                field("Invoice/Credit Memo Created"; Rec."Invoice/Credit Memo Created")
                {
                    ApplicationArea = All;
                }
                field("Invoice Created DateTime"; Rec."Invoice Created DateTime")
                {
                    ApplicationArea = All;
                }
                field("NAV SI Created No."; Rec."NAV SI Created No.")
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
