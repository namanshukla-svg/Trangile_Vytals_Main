Page 50068 "Gate Pass Sub form"
{
    PageType = ListPart;
    SourceTable = "SSD Gate Pass Line";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Invoice No."; Rec."Invoice No.")
                {
                    ApplicationArea = All;
                }
                field("Invoice Date"; Rec."Invoice Date")
                {
                    ApplicationArea = All;
                }
                field("Customer Name"; Rec."Customer Name")
                {
                    ApplicationArea = All;
                }
                field("Net Wt."; Rec."Net Wt.")
                {
                    ApplicationArea = All;
                }
                field("Gross Wt."; Rec."Gross Wt.")
                {
                    ApplicationArea = All;
                }
                field("No. Of Cartons"; Rec."No. Of Cartons")
                {
                    ApplicationArea = All;
                    Caption = 'No. Of Packages';
                }
                field("Invoice Amount"; Rec."Invoice Amount")
                {
                    ApplicationArea = All;
                }
                field(Remark; Rec.Remark)
                {
                    ApplicationArea = All;
                }
                field("LR/RR No."; Rec."LR/RR No.")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
    actions
    {
    }
    trigger OnDeleteRecord(): Boolean begin
        if GatePassHeader.Get(Rec."No.")then GatePassHeader.TestField(Posted, false);
    end;
    trigger OnModifyRecord(): Boolean begin
        if GatePassHeader.Get(Rec."No.")then GatePassHeader.TestField(Posted, false);
    end;
    var GatePassHeader: Record "SSD Gate Pass Header";
}
