Page 50004 "CT2 List"
{
    Editable = false;
    PageType = List;
    SourceTable = "SSD CT2 Header";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Control1000000000)
            {
                field("CT2 No."; Rec."CT2 No.")
                {
                    ApplicationArea = All;
                }
                field("CT2 Date"; Rec."CT2 Date")
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
                field("CT2 Validate Date"; Rec."CT2 Validate Date")
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
