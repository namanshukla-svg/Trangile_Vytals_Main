page 50352 "SSD Terms List"
{
    ApplicationArea = All;
    Caption = 'Terms List';
    PageType = List;
    SourceTable = "SSD Terms";
    Editable = false;
    UsageCategory = Administration;
    CardPageId = "SSD Terms";

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
            }
        }
    }
}
