Page 50155 "P. Quality Order for Approval"
{
    ApplicationArea = All;
    Caption = 'Quality Order List for Approval';
    Editable = false;
    PageType = List;
    SourceTable = "SSD Posted Quality Order Hdr";
    SourceTableView = where(Approved=const(false));
    UsageCategory = Lists;

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
                field("Description 2"; Rec."Description 2")
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
                field("ULR No."; Rec."ULR No.")
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
                        case Rec."Template Type" of Rec."template type"::Receipt: Page.Run(Page::"Edit P.Rcpt Quality Order Card", Rec);
                        Rec."template type"::Manufacturing: Page.Run(Page::"Edit P. Man. Q.Order Card", Rec);
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
                action(Approve)
                {
                    ApplicationArea = All;
                    Caption = 'Approve';
                    Image = Approve;

                    trigger OnAction()
                    var
                        PostedQualityOrdeLine: Record "SSD Posted Quality Order Line";
                    begin
                        //ALLE SS
                        PostedQualityOrdeLine.Reset;
                        PostedQualityOrdeLine.SetRange("Document No.", Rec."No.");
                        if PostedQualityOrdeLine.FindSet then repeat if(PostedQualityOrdeLine."Inspection Value2" - PostedQualityOrdeLine."Actual Test Results Data") > 0 then begin
                                    if PostedQualityOrdeLine."Approved By" = '' then Error('Mandatory Remark can not be blank');
                                end;
                            until PostedQualityOrdeLine.Next = 0;
                        //ALLE SS
                        if Confirm('Are you sure want to Approve selected Quality Order', false, Confm) = true then begin
                            UserSetup.Reset;
                            UserSetup.Get(UserId);
                            UserSetup.TestField(UserSetup."Quality Approval Permission");
                            Rec.Approved:=true;
                            Rec."Approved by":=UserId;
                            Rec."Approved Date":=Today;
                            Rec.Modify;
                            Message('Document has been Approved');
                        end;
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
    UserSetup: Record "User Setup";
}
