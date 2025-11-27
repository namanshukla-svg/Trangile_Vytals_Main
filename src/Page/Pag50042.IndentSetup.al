Page 50042 "Indent Setup"
{
    // SM_PP001 13.07.2005 Reference to the Source table changed
    ApplicationArea = All;
    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = List;
    SourceTable = "SSD AddOn Setup";
    UsageCategory = Administration;

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';

                field("Indent No. Series"; Rec."Indent No. Series")
                {
                    ApplicationArea = All;
                }
                field("Indent Template Name"; Rec."Indent Template Name")
                {
                    ApplicationArea = All;
                }
                field("Indent Batch Name"; Rec."Indent Batch Name")
                {
                    ApplicationArea = All;
                }
                field("Issue Slip No"; Rec."Issue Slip No")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
    actions
    {
    }
    trigger OnOpenPage()
    begin
        Rec.Reset;
        if not Rec.Get then begin
            Rec.Init;
            Rec.Insert;
        end;
    end;
}
