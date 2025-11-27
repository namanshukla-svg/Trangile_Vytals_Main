page 50354 "SSD Terms Line"
{
    ApplicationArea = All;
    Caption = 'Terms Line';
    PageType = ListPart;
    SourceTable = "SSD Terms Line";
    AutoSplitKey = true;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Sequence No."; Rec."Sequence No.")
                {
                    ToolTip = 'Specifies the value of the Sequence No. field.';
                }
                field("Sub Sequence No."; Rec."Sub Sequence No.")
                {
                    ToolTip = 'Specifies the value of the Sub Sequence No. field.';
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field.';
                }
                field("Is Header"; Rec."Is Header")
                {
                    ToolTip = 'Specifies the value of the Is Header field.';
                }
                field("Print on PO"; Rec."Print on PO")
                {
                    ToolTip = 'Specifies the value of the Print on PO field.';
                }
                field("Check List"; Rec."Check List")
                {
                    ToolTip = 'Specifies the value of the Check List field.';
                }
                field("Attachment Required"; Rec."Attachment Required")
                {
                    ToolTip = 'Specifies the value of the Attachment Required field.';
                }
                field("SSD Attachment Type"; Rec."SSD Attachment Type")
                {
                    ToolTip = 'Specifies the value of the Attachment Type field.';
                }
            }
        }
    }
}
