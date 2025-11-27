Page 50100 "Inspection Type"
{
    PageType = List;
    PopulateAllFields = true;
    SourceTable = "SSD Inspection Type";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                field("Kind of Sampling"; Rec."Kind of Sampling")
                {
                    ApplicationArea = All;
                }
                field("Code"; Rec.Code)
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
        area(navigation)
        {
            group("&Type")
            {
                Caption = '&Type';

                action("Sampling Level")
                {
                    ApplicationArea = All;
                    Caption = 'Sampling Level';
                    RunObject = Page "E-Invoice Integration Setup";
                    RunPageLink = "Primary Key"=field(Code), "Client ID"=field("Kind of Sampling");
                }
            }
        }
    }
    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec."Responsibility Center":=UserMgt.GetRespCenterFilter end;
    trigger OnOpenPage()
    begin
    // if UserMgt.GetRespCenterFilter() <> '' then begin
    //     Rec.FilterGroup(2);
    //     Rec.SetRange("Responsibility Center", UserMgt.GetRespCenterFilter);
    //     Rec.FilterGroup(0);
    // end;
    end;
    var UserMgt: Codeunit "SSD User Setup Management";
}
