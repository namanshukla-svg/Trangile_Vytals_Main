page 50098 "Center Change Log List"
{
    PageType = List;
    SourceTable = "Center Change Log";
    ApplicationArea = All;
    Caption = 'Machine Center/Work Center Change Log List';
    InsertAllowed = false;
    ModifyAllowed = false;
    DeleteAllowed = false;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Center Type"; Rec."Center Type")
                {
                    ApplicationArea = ALl;
                }
                field("Center No."; Rec."Center No.")
                {
                    ApplicationArea = ALl;
                }
                field("Center Name"; Rec."Center Name")
                {
                    ApplicationArea = ALl;
                }
                field(Action; Rec.Action)
                {
                    ApplicationArea = ALl;
                }
                field("Effective Date-Time"; Rec."Effective Date-Time")
                {
                    ApplicationArea = ALl;
                }
                field("Changed By"; Rec."Changed By")
                {
                    ApplicationArea = ALl;
                }
            }
        }
    }
}
