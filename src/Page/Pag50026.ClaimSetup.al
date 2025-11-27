page 50026 "Claim Setup"
{
    ApplicationArea = All;
    Caption = 'Claim Setup';
    PageType = List;
    SourceTable = "SSD Claim Setup";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Expense Type"; Rec."Expense Type")
                {
                    ToolTip = 'Specifies the value of the Expense Type field.';
                }
                field("Expense Category"; Rec."Expense Category")
                {
                    ToolTip = 'Specifies the value of the Expense Category field.';
                }
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                    ToolTip = 'Specifies the value of the Shortcut Dimension 1 Code field.';
                }
                field("G/L Account No"; Rec."G/L Account No")
                {
                    ToolTip = 'Specifies the value of the G/L Account No field.';
                }
                field("Debit/Credit"; Rec."Debit/Credit")
                {
                    ToolTip = 'Specifies the value of the Debit/Credit field.';
                }
            }
        }
    }
}
