page 50062 "SSD Dashboard Email"
{
    ApplicationArea = All;
    Caption = 'Dashboard Email';
    PageType = List;
    SourceTable = "SSD Dashboard Email";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Object Type to Run"; Rec."Object Type to Run")
                {
                    ToolTip = 'Specifies the value of the Object Type to Run field.';
                }
                field("Report ID"; Rec."Report ID")
                {
                    ToolTip = 'Specifies the value of the Report ID field.';
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field.';
                }
                field("To Mail"; Rec."To Mail")
                {
                    ToolTip = 'Specifies the value of the To Mail field.';
                }
                field("CC Mail"; Rec."CC Mail")
                {
                    ToolTip = 'Specifies the value of the CC Mail field.';
                }
                field("BCC Mail"; Rec."BCC Mail")
                {
                    ToolTip = 'Specifies the value of the BCC Mail field.';
                }
                field("Mail Subject"; Rec."Mail Subject")
                {
                    ToolTip = 'Specifies the value of the Mail Subject field.';
                }
                field("Mail Body"; Rec."Mail Body")
                {
                    ToolTip = 'Specifies the value of the Mail Body field.';
                }
            }
        }
    }
}
