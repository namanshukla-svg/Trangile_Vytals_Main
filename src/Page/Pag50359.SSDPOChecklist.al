page 50359 "SSD PO Checklist"
{
    ApplicationArea = All;
    Caption = 'SSD PO Checklist';
    PageType = List;
    SourceTable = "SSD PO CheckList";
    InsertAllowed = false;
    DeleteAllowed = false;
    UsageCategory = None;

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
                field(Completed; Rec.Completed)
                {
                    ToolTip = 'Specifies the value of the Completed field.';
                }
            }
        }
    }
}
