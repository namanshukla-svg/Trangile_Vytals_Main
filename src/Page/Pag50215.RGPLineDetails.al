Page 50215 "RGP Line Details"
{
    PageType = List;
    SourceTable = "SSD RGP Line Detail";
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
                    Editable = false;
                }
                field("Item No."; Rec."Item No.")
                {
                    ApplicationArea = All;
                }
                field("Line No."; Rec."Line No.")
                {
                    ApplicationArea = All;
                }
                field("Required Item"; Rec."Required Item")
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
        Rec."Document Type":=RecDocType;
        Rec."Document No.":=RecDocNo;
        Rec."Item No.":=RecItemNo;
        Rec."Line No.":=RecLineNo;
    end;
    var RecDocType: Option "RGP Inbound", "RGP Outbound";
    RecDocNo: Code[20];
    RecItemNo: Code[20];
    RecLineNo: Integer;
    procedure InitialValues(DocType: Option "RGP Inbound", "RGP Outbound"; "DocNo.": Code[20]; "ItemNo.": Code[20]; "LineNo.": Integer)
    begin
        RecDocType:=DocType;
        RecDocNo:="DocNo.";
        RecItemNo:="ItemNo.";
        RecLineNo:="LineNo.";
    end;
}
