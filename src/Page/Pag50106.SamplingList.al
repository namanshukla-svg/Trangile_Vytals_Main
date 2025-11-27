Page 50106 "Sampling List"
{
    Caption = 'Sampling List';
    Editable = false;
    PageType = List;
    SourceTable = "SSD Sampling Temp. Header";
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
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field("Description 2"; Rec."Description 2")
                {
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
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
            group("&Sampling")
            {
                Caption = '&Sampling';

                action(Card)
                {
                    ApplicationArea = All;
                    Caption = 'Card';
                    Image = EditLines;
                    RunObject = Page "Sampling Template Card";
                    RunPageLink = "No."=field("No.");
                    RunPageView = sorting("No.")order(ascending);
                    ShortCutKey = 'Shift+F7';
                }
            }
        }
    }
    trigger OnOpenPage()
    begin
        xDoc.Copy(Rec);
        xDoc.FilterGroup(3);
        if xDoc.GetFilter(xDoc."Template Type") <> '' then CurrPage.Caption:=CurrPage.Caption + ' ' + xDoc.GetFilter(xDoc."Template Type");
    // if UserMgt.GetRespCenterFilter() <> '' then begin
    //     Rec.FilterGroup(2);
    //     Rec.SetRange("Responsibility Center", UserMgt.GetRespCenterFilter);
    //     Rec.FilterGroup(0);
    // end;
    end;
    var xDoc: Record "SSD Sampling Temp. Header";
    UserMgt: Codeunit "SSD User Setup Management";
}
