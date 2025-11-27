Page 50134 "Template Vendor Lin."
{
    AutoSplitKey = true;
    Caption = 'Template Vendor Lin.';
    PageType = ListPart;
    SourceTable = "SSD Vendor Eval. Template Line";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                field("Code"; Rec.Code)
                {
                    ApplicationArea = All;
                }
                field(Concept; Rec.Concept)
                {
                    ApplicationArea = All;
                }
                field("1-3"; Rec."1-3")
                {
                    ApplicationArea = All;
                }
                field("4-7"; Rec."4-7")
                {
                    ApplicationArea = All;
                }
                field("8-10"; Rec."8-10")
                {
                    ApplicationArea = All;
                }
                field("Rating Weight"; Rec."Rating Weight")
                {
                    ApplicationArea = All;
                }
                field(Comment; Rec.Comment)
                {
                    ApplicationArea = All;
                }
            }
        }
    }
    actions
    {
        area(processing)
        {
            group("&Template")
            {
                Caption = '&Template';

                action("Line Comments")
                {
                    ApplicationArea = All;
                    Caption = 'Line Comments';

                    trigger OnAction()
                    begin
                        //This functionality was copied from page #50132. Unsupported part was commented. Please check it.
                        /*CurrPage.SubForm.PAGE.*/
                        fShowComent;
                    end;
                }
            }
        }
    }
    trigger OnOpenPage()
    begin
    // if UserMgt.GetRespCenterFilter() <> '' then begin
    //     Rec.FilterGroup(2);
    //     Rec.SetRange("Responsibility Center", UserMgt.GetRespCenterFilter);
    //     Rec.FilterGroup(0);
    // end;
    end;
    var UserMgt: Codeunit "SSD User Setup Management";
    procedure fShowComent()
    begin
        Rec.ShowComent;
    end;
}
