page 50351 "SSD Attachment Type"
{
    ApplicationArea = All;
    Caption = 'Attachment Type';
    PageType = List;
    SourceTable = "SSD Attachment Type";
    UsageCategory = Administration;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Code"; Rec."Code")
                {
                    ToolTip = 'Specifies the value of the Code field.';
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field.';
                }
                field("Is Annexure"; Rec."Is Annexure")
                {
                    ToolTip = 'Specifies the value of the Annexure field.';
                }
                field("Is Vendor Confirmation"; Rec."Is Vendor Confirmation")
                {
                    ToolTip = 'Specifies the value of the Vendor Confirmation field.';
                }
            }
        }
    }
}
