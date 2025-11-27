Page 50071 "Gate Setup"
{
    // SM_PP001 13.07.2005 Reference to the Source table changed
    // ALLEAA CML-033 280308
    //   - Show Field
    ApplicationArea = All;
    DeleteAllowed = false;
    Editable = true;
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

                field("Gate In Nos"; Rec."Gate In Nos")
                {
                    ApplicationArea = All;
                }
                field("Gate Out Nos"; Rec."Gate Out Nos")
                {
                    ApplicationArea = All;
                }
                field("Subcon MRN Nos"; Rec."Subcon MRN Nos")
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
