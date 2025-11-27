page 50047 "SSD Email Entries"
{
    ApplicationArea = All;
    Caption = 'SSD Email Entries';
    PageType = List;
    SourceTable = "SSD Email Entries";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Entry No."; Rec."Entry No.")
                {
                    ToolTip = 'Specifies the value of the Entry No. field.';
                }
                field("Customer No."; Rec."Customer No.")
                {
                    ToolTip = 'Specifies the value of the Customer No. field.';
                }
                field("Customer Name"; Rec."Customer Name")
                {
                    ToolTip = 'Specifies the value of the Customer Name field.';
                }
                field("Invoice No."; Rec."Invoice No.")
                {
                    ToolTip = 'Specifies the value of the Invoice No. field.';
                }
                field("LR No"; Rec."LR No")
                {
                    ToolTip = 'Specifies the value of the LR No field.';
                }
                field("Sales Order No."; Rec."Sales Order No.")
                {
                    ToolTip = 'Specifies the value of the Sales Order No. field.';
                }
                field(Subject; Rec.Subject)
                {
                    ToolTip = 'Specifies the value of the Subject field.';
                }
                field("TO Mail ID"; Rec."TO Mail ID")
                {
                    ToolTip = 'Specifies the value of the TO Mail ID field.';
                }
                field("CC Mail ID"; Rec."CC Mail ID")
                {
                    ToolTip = 'Specifies the value of the CC Mail ID field.';
                }
                field("BCC Mail ID"; Rec."BCC Mail ID")
                {
                    ToolTip = 'Specifies the value of the BCC Mail ID field.';
                }
                field("Technical Email ID"; Rec."Technical Email ID")
                {
                    ToolTip = 'Specifies the value of the Technical Email ID field.';
                }
                field("Resp. CCare Exe. Email Id"; Rec."Resp. CCare Exe. Email Id")
                {
                    ToolTip = 'Specifies the value of the Resp. CCare Exe. Email Id field.';
                }
                field("Sales Order Email"; Rec."Sales Order Email")
                {
                    ToolTip = 'Specifies the value of the Sales Order Email field.';
                }
                field("Sales Person Email"; Rec."Sales Person Email")
                {
                    ToolTip = 'Specifies the value of the Sales Person Email field.';
                }
            }
        }
    }
}
