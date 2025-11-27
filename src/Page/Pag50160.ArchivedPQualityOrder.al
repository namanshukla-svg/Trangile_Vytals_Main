Page 50160 "Archived P. Quality Order"
{
    Caption = 'Archived P. Quality Order';
    Editable = false;
    PageType = List;
    SourceTable = "SSD Posted Quality Ord Hdr Ar";
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
                        case Rec."Template Type" of Rec."template type"::Receipt: Page.Run(Page::"Arch P.Rcpt Quality Order Card", Rec);
                        Rec."template type"::Manufacturing: Page.Run(Page::"Arch P. Man. Q.Order Card", Rec);
                        end;
                    end;
                }
                action("Print &Incoming Material QLT Certificate")
                {
                    ApplicationArea = All;
                    Caption = 'Print &Incoming Material QLT Certificate';
                    Visible = false;

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

                trigger OnAction()
                begin
                    Rec.Navigate;
                end;
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
    Confm: Boolean;
}
