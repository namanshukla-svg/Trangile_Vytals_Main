Page 50179 "Gate Out List"
{
    CardPageID = "Gate In";
    Editable = false;
    PageType = List;
    SourceTable = "SSD Gate Header";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
            }
        }
    }
    actions
    {
        area(navigation)
        {
            group("&Gate Entry")
            {
                action(ShowCard)
                {
                    ApplicationArea = All;
                    Caption = 'Gate Pass';
                    Image = EditLines;
                    RunObject = Page "Gate Pass";
                    ShortCutKey = 'Shift+F7';

                    trigger OnAction()
                    begin
                        Page.RunModal(Page::"Gate In", Rec);
                    end;
                }
            }
        }
    }
    trigger OnOpenPage()
    begin
    //CF001 St
    // if UserMgt.GetRespCenterFilter <> '' then begin
    //     Rec.FilterGroup(2);
    //     Rec.SetRange("Responsibility Center", UserMgt.GetRespCenterFilter);
    //     Rec.FilterGroup(0);
    // end;
    //CF001 En
    end;
    var UserMgt: Codeunit "SSD User Setup Management";
}
