page 50037 "Claims Staging"
{
    ApplicationArea = All;
    Caption = 'Claims Staging';
    PageType = List;
    SourceTable = "SSD Claims Staging";
    UsageCategory = History;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    DeleteAllowed = false;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Claim Date"; Rec."Claim Date")
                {
                    ToolTip = 'Specifies the value of the Claim Date field.';
                }
                field("Claims No."; Rec."Claims No.")
                {
                    ToolTip = 'Specifies the value of the Claims No. field.';
                }
                field("Company Name"; Rec."Company Name")
                {
                    ToolTip = 'Specifies the value of the Company Name field.';
                }
                field(Department; Rec.Department)
                {
                    ToolTip = 'Specifies the value of the Department field.';
                }
                field("Employee Code"; Rec."Employee Code")
                {
                    ToolTip = 'Specifies the value of the Employee Code field.';
                }
                field("Employee Dimension Code"; Rec."Employee Dimension Code")
                {
                    ToolTip = 'Specifies the value of the Employee Dimension Code field.';
                }
                field("Employee Name"; Rec."Employee Name")
                {
                    ToolTip = 'Specifies the value of the Employee Name field.';
                }
                field("Entry No."; Rec."Entry No.")
                {
                    ToolTip = 'Specifies the value of the Entry No. field.';
                }
                field("Expense Amount"; Rec."Expense Amount")
                {
                    ToolTip = 'Specifies the value of the Expense Amount field.';
                }
                field("Expense Category"; Rec."Expense Category")
                {
                    ToolTip = 'Specifies the value of the Expense Category field.';
                }
                field("Expense Type"; Rec."Expense Type")
                {
                    ToolTip = 'Specifies the value of the Expense Type field.';
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ToolTip = 'Specifies the value of the Posting Date field.';
                }
                field(SeqID; Rec.SeqID)
                {
                    ToolTip = 'Specifies the value of the SeqID field.';
                }
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                    ToolTip = 'Specifies the value of the Shortcut Dimension 1 Code field.';
                }
                field(Status; Rec.Status)
                {
                    ToolTip = 'Specifies the value of the Status field.';
                }
            }
        }
    }
}
