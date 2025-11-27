Page 50151 "Quality Defect Codes"
{
    Editable = false;
    PageType = List;
    SourceTable = "SSD Quality Defects";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Control1000000000)
            {
                field("Defect Code"; Rec."Defect Code")
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
            }
        }
    }
    actions
    {
    }
}
