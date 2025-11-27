Page 50216 "Posted RGP line Details"
{
    Editable = false;
    PageType = List;
    SourceTable = "SSD Posted RGP Line Detail";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Control1000000000)
            {
                field("Document Type"; Rec."Document Type")
                {
                    ApplicationArea = All;
                }
                field("Document No."; Rec."Document No.")
                {
                    ApplicationArea = All;
                }
                field("Item No."; Rec."Item No.")
                {
                    ApplicationArea = All;
                }
                field("Required Quantity"; Rec."Required Quantity")
                {
                    ApplicationArea = All;
                }
                field("Required Item"; Rec."Required Item")
                {
                    ApplicationArea = All;
                }
                field("Pre Assigned No."; Rec."Pre Assigned No.")
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
