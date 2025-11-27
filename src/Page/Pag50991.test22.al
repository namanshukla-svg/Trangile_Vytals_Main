Page 50991 test22
{
    DeleteAllowed = false;
    InsertAllowed = false;
    SourceTable = "Requisition Line";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Control1170000105)
            {
                field("Indent No."; Rec."Indent No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Indent Line No."; Rec."Indent Line No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Remaining Qty. (Base)"; Rec."Remaining Qty. (Base)")
                {
                    ApplicationArea = All;
                }
                field("Action Message"; Rec."Action Message")
                {
                    ApplicationArea = All;
                }
                field("Ending Date-Time"; Rec."Ending Date-Time")
                {
                    ApplicationArea = All;
                }
                field("Planning Level"; Rec."Planning Level")
                {
                    ApplicationArea = All;
                }
                field("Starting Date-Time"; Rec."Starting Date-Time")
                {
                    ApplicationArea = All;
                }
                field("Expected Component Cost Amt."; Rec."Expected Component Cost Amt.")
                {
                    ApplicationArea = All;
                }
                field("Planning Line Origin"; Rec."Planning Line Origin")
                {
                    ApplicationArea = All;
                }
                field("Related to Planning Line"; Rec."Related to Planning Line")
                {
                    ApplicationArea = All;
                }
                field("Cost Amount"; Rec."Cost Amount")
                {
                    ApplicationArea = All;
                }
                field("Finished Qty. (Base)"; Rec."Finished Qty. (Base)")
                {
                    ApplicationArea = All;
                }
                field("Expected Operation Cost Amt."; Rec."Expected Operation Cost Amt.")
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
