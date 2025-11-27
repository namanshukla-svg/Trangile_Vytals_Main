Page 50320 "Posted Pur.Credit Memo-AG"
{
    PageType = List;
    Permissions = TableData "Purch. Cr. Memo Hdr."=rimd;
    SourceTable = "Purch. Cr. Memo Hdr.";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Control1170000001)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                }
                field("Buy-from Vendor No."; Rec."Buy-from Vendor No.")
                {
                    ApplicationArea = All;
                }
                field("Vendor Cr. Memo No."; Rec."Vendor Cr. Memo No.")
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
