Page 50128 "Item Sampling Templates"
{
    PageType = List;
    SourceTable = "Item Sampling Template";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Control1000000000)
            {
                field("Item Code"; Rec."Item Code")
                {
                    ApplicationArea = All;
                }
                field("Sampling Temp. No."; Rec."Sampling Temp. No.")
                {
                    ApplicationArea = All;
                }
                field("Template Type"; Rec."Template Type")
                {
                    ApplicationArea = All;
                }
                field("Responsibility Center"; Rec."Responsibility Center")
                {
                    ApplicationArea = All;
                }
                field(Active; Rec.Active)
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
                    RunPageLink = "No."=field("Sampling Temp. No.");
                    RunPageView = sorting("No.")order(ascending);
                    ShortCutKey = 'Shift+F7';
                }
            }
        }
    }
    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec."Responsibility Center":=UserMgt.GetRespCenterFilter;
        Rec."Template Type":=GTemplateType;
    end;
    trigger OnOpenPage()
    begin
        if UserMgt.GetRespCenterFilter() <> '' then begin
            Rec.FilterGroup(2);
            //Rec.SetRange("Responsibility Center", UserMgt.GetRespCenterFilter);
            Rec.SetRange("Template Type", GTemplateType);
            Rec.FilterGroup(0);
        end;
    end;
    var UserMgt: Codeunit "SSD User Setup Management";
    GTemplateType: Option Receipt, Manufacturing, Location, Shipping;
    procedure SetTemplateType(RecTempType: Option Receipt, Manufacturing, Location, Shipping)
    begin
        GTemplateType:=RecTempType;
    end;
}
