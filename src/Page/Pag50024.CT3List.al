Page 50024 "CT3 List"
{
    Editable = false;
    PageType = List;
    SourceTable = "SSD CT3 Header";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Control1000000000)
            {
                field("CT3 No."; Rec."CT3 No.")
                {
                    ApplicationArea = All;
                }
                field("CT3 Date"; Rec."CT3 Date")
                {
                    ApplicationArea = All;
                }
                field("Customer No."; Rec."Customer No.")
                {
                    ApplicationArea = All;
                }
                field("Customer PO No."; Rec."Customer PO No.")
                {
                    ApplicationArea = All;
                }
                field("Customer PO Date"; Rec."Customer PO Date")
                {
                    ApplicationArea = All;
                }
                field("CT3 Validate Date"; Rec."CT3 Validate Date")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
    actions
    {
    }
    var SheaderRec: Record "Sales Header";
    procedure SetDefault(SalesHeader: Record "Sales Header")
    begin
        SheaderRec:=SalesHeader;
    end;
}
