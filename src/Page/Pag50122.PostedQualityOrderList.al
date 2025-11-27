Page 50122 "Posted Quality Order List"
{
    Caption = 'Posted Quality Order List';
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = "SSD Posted Quality Order Hdr";
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
                field("Posting Date"; Rec."Posting Date")
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
                field("Item No."; Rec."Item No.")
                {
                    ApplicationArea = All;
                }
                field("Source Name"; Rec."Source Name")
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
                field("Lot Size"; Rec."Lot Size")
                {
                    ApplicationArea = All;
                }
                field("Lot No."; Rec."Lot No.")
                {
                    ApplicationArea = All;
                }
                field("Qty. to Scrapping"; Rec."Qty. to Scrapping")
                {
                    ApplicationArea = All;
                }
                field("Qty. to Reclassif."; Rec."Qty. to Reclassif.")
                {
                    ApplicationArea = All;
                }
                field("Qty. to Reprocess"; Rec."Qty. to Reprocess")
                {
                    ApplicationArea = All;
                }
                field("Wrong Quantity"; Rec."Wrong Quantity")
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
            group("&Document")
            {
                Caption = '&Document';

                action(Card)
                {
                    ApplicationArea = All;
                    Caption = 'Card';
                    Image = EditLines;
                    ShortCutKey = 'Shift+F7';

                    trigger OnAction()
                    begin
                        case Rec."Template Type" of Rec."template type"::Receipt: Page.Run(Page::"Posted Rcpt Quality Order Card", Rec);
                        Rec."template type"::Manufacturing: Page.Run(Page::"Posted Man. Q.Order Card", Rec);
                        Rec."template type"::Routing: Page.Run(Page::"Posted Man. Sub Q.Order Card", Rec);
                        Rec."template type"::RcvdCoil: Page.Run(Page::"Posted Rcpt Sub Qlt Order Card", Rec);
                        end;
                    end;
                }
                action("Print &Incoming Material QLT Certificate")
                {
                    ApplicationArea = All;
                    Caption = 'Print &Incoming Material QLT Certificate';

                    trigger OnAction()
                    var
                        ReportIncomingMaterialAnalysis: Report "Incoming Material Analysis";
                    begin
                        //<<< ALLE [5.51]
                        ReportIncomingMaterialAnalysis.SetTableview(Rec);
                        ReportIncomingMaterialAnalysis.Run;
                    //>>> ALLE [5.51]
                    end;
                }
            }
        }
        area(processing)
        {
            action(Navigate)
            {
                ApplicationArea = All;
                Caption = 'Navigate';
                Image = Navigate;
                Promoted = true;
                PromotedCategory = Process;
                Visible = NavigateVisible;

                trigger OnAction()
                begin
                    Rec.Navigate;
                end;
            }
        }
    }
    trigger OnOpenPage()
    var
        UserSetup: Record "User Setup";
    begin
        // if UserMgt.GetRespCenterFilter() <> '' then begin
        //     Rec.FilterGroup(2);
        //     Rec.SetRange("Responsibility Center", UserMgt.GetRespCenterFilter);
        //     Rec.FilterGroup(0);
        // end;
        // >> ALLE NA.DP1.00
        UserSetup.Get(UserId);
        NavigateVisible:=UserSetup."Navigate Visible";
    //IF NOT UserSetup."Drilldown Permission" THEN
    //ERROR('You dont have permission to open this page');
    // << ALLE NA.DP1.00
    end;
    var UserMgt: Codeunit "SSD User Setup Management";
    NavigateVisible: Boolean;
}
