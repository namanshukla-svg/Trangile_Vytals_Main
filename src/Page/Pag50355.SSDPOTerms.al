page 50355 "SSD PO Terms"
{
    ApplicationArea = All;
    Caption = 'PO Terms';
    PageType = List;
    SourceTable = "SSD PO Terms";
    InsertAllowed = false;
    DeleteAllowed = false;
    ModifyAllowed = false;
    Editable = false;
    UsageCategory = None;
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
                field("SSD Attachment Type"; Rec."SSD Attachment Type")
                {
                    ToolTip = 'Specifies the value of the Attachment Type field.';
                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            Group(Update)
            {
                action(Resequence)
                {
                    ApplicationArea = All;
                    Caption = 'Resequence';
                    Promoted = true;
                    PromotedIsBig = true;
                    PromotedCategory = Process;
                    PromotedOnly = true;

                    trigger OnAction()
                    begin
                        Rec.ResequenceLines(Rec."Document Type", Rec."Document No.", Rec."TC Code");
                    end;
                }
            }
        }
    }
}
