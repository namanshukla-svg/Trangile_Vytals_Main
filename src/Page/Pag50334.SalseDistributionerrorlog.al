Page 50334 "Salse Distribution error log"
{
    Editable = false;
    PageType = List;
    SourceTable = "SSD Batch 50197 Error Log";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Entry No."; Rec."Entry No.")
                {
                    ApplicationArea = All;
                }
                field("MRP No."; Rec."MRP No.")
                {
                    ApplicationArea = All;
                }
                field("Customer Code"; Rec."Customer Code")
                {
                    ApplicationArea = All;
                }
                field("Error Date"; Rec."Error Date")
                {
                    ApplicationArea = All;
                }
                field("Error Time"; Rec."Error Time")
                {
                    ApplicationArea = All;
                }
                field("Error Text"; Rec."Error Text")
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
