Page 50127 "Quality Order List"
{
    Caption = 'Quality Order List';
    Editable = false;
    PageType = List;
    SourceTable = "SSD Quality Order Header";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                }
                field("Entry Source Type"; Rec."Entry Source Type")
                {
                    ApplicationArea = All;
                }
                field("Source Code"; Rec."Source Code")
                {
                    ApplicationArea = All;
                }
                field("Order No."; Rec."Order No.")
                {
                    ApplicationArea = All;
                }
                field("Item No."; Rec."Item No.")
                {
                    ApplicationArea = All;
                }
                field("Lot Size"; Rec."Lot Size")
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field("Sampling Temp. No."; Rec."Sampling Temp. No.")
                {
                    ApplicationArea = All;
                }
                field("Creation Date"; Rec."Creation Date")
                {
                    ApplicationArea = All;
                }
                field("Accepted Qty."; Rec."Accepted Qty.")
                {
                    ApplicationArea = All;
                }
                field("Rejected Qty."; Rec."Rejected Qty.")
                {
                    ApplicationArea = All;
                }
                field("Source Document No."; Rec."Source Document No.")
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
            group("&Order")
            {
                Caption = '&Order';

                action(Card)
                {
                    ApplicationArea = All;
                    Caption = 'Card';
                    Image = EditLines;
                    ShortCutKey = 'Shift+F7';

                    trigger OnAction()
                    begin
                        case Rec."Template Type" of Rec."template type"::Receipt: Page.Run(Page::"Rcpt. Quality Order Card", Rec);
                        Rec."template type"::Manufacturing: Page.Run(Page::"Man. Quality Order Card", Rec);
                        Rec."template type"::Routing: Page.Run(Page::"Routing Quality Order Card", Rec);
                        Rec."template type"::RcvdCoil: Page.Run(Page::"Rcpt. Sub Quality Order Card", Rec);
                        end;
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
    procedure SettingControls()
    begin
    //CurrForm."Process / Operation".VISIBLE:=TRUE;
    //CurrForm."Process/Operation No.".VISIBLE:=TRUE;
    //CurrForm."Work Shift Code".VISIBLE:=TRUE;
    end;
}
