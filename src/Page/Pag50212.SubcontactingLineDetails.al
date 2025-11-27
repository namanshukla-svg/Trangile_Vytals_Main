Page 50212 "Subcontacting Line Details"
{
    PageType = List;
    SourceTable = "SSD Subcontacting Line Detail";
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
                field("Item No."; Rec."Item No.")
                {
                    ApplicationArea = All;
                }
                field("Line No."; Rec."Line No.")
                {
                    ApplicationArea = All;
                }
                field("Subcontracting Item No."; Rec."Subcontracting Item No.")
                {
                    ApplicationArea = All;
                }
                field("Required Quantity"; Rec."Required Quantity")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
    actions
    {
    }
    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec."Document No.":=DocumentNo;
        Rec."Item No.":=ItemNo;
        Rec."Line No.":=LineNo;
    end;
    var DocumentNo: Code[20];
    ItemNo: Code[20];
    LineNo: Integer;
    procedure InitialValues(RecDocumentNo: Code[20]; RecItemNo: Code[20]; RecLineNo: Integer)
    begin
        DocumentNo:=RecDocumentNo;
        ItemNo:=RecItemNo;
        LineNo:=RecLineNo;
    end;
}
