page 50006 "SSD Payroll Setup"
{
    ApplicationArea = All;
    Caption = 'SSD Payroll Setup';
    PageType = List;
    SourceTable = "SSD Payroll Setup";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Pay Element"; Rec."Pay Element")
                {
                    ToolTip = 'Specifies the value of the Pay Element field.';
                }
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                    ToolTip = 'Specifies the value of the Shortcut Dimension 1 Code field.';
                }
                field("G/L Account No"; Rec."G/L Account No")
                {
                    ToolTip = 'Specifies the value of the G/L Account No field.';
                }
                field("Type"; Rec."Type")
                {
                    ToolTip = 'Specifies the value of the Type field.';
                }
                field("Debit/Credit"; Rec."Debit/Credit")
                {
                    ToolTip = 'Specifies the value of the Debit/Credit field.';
                }
                field("Emp Location"; Rec."Emp Location")
                {
                    ToolTip = 'Specifies the value of the Emp Location field.';
                }
                field("Emp Contribution"; Rec."Emp Contribution")
                {
                    ToolTip = 'Specifies the value of the Emp Contribution field.';
                }
            }
        }
    }
}
