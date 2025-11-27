Page 50225 "Posted Requision Slip SubForm"
{
    AutoSplitKey = true;
    DelayedInsert = true;
    Editable = false;
    MultipleNewLines = true;
    PageType = ListPart;
    SourceTable = "SSD Posted Requision Slip Line";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Control1000000000)
            {
                field("Document No."; Rec."Document No.")
                {
                    ApplicationArea = All;
                }
                field("Req. Slip Document No."; Rec."Req. Slip Document No.")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Prod. Order No."; Rec."Prod. Order No.")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Prod. Order Line No."; Rec."Prod. Order Line No.")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Item No."; Rec."Item No.")
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field("Unit of Measure Code"; Rec."Unit of Measure Code")
                {
                    ApplicationArea = All;
                }
                field(Quantity; Rec.Quantity)
                {
                    ApplicationArea = All;
                }
                field("Issued Qty"; Rec."Issued Qty")
                {
                    ApplicationArea = All;
                }
                field("Routing Link Code"; Rec."Routing Link Code")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Due Date-Time"; Rec."Due Date-Time")
                {
                    ApplicationArea = All;
                }
                field("Location Code"; Rec."Location Code")
                {
                    ApplicationArea = All;
                }
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
            }
        }
    }
    actions
    {
        area(processing)
        {
            group("&Print")
            {
                Caption = '&Print';

                action("Requistion Slip - MWH")
                {
                    ApplicationArea = All;
                    Caption = 'Requistion Slip - MWH';
                    Visible = false;

                    trigger OnAction()
                    var
                        RecPRSLP: Record "SSD Posted Requision Slip Line";
                    begin
                        RecPRSLP.SetRange(RecPRSLP."Req. Slip Document No.", Rec."Req. Slip Document No.");
                        Report.RunModal(71007, true, false, RecPRSLP);
                    end;
                }
                action("Requisiotn Slip")
                {
                    ApplicationArea = All;
                    Caption = 'Requisiotn Slip';

                    trigger OnAction()
                    var
                        RecPRSLP: Record "SSD Posted Requision Slip Line";
                    begin
                        RecPRSLP.SetRange(RecPRSLP."Req. Slip Document No.", Rec."Req. Slip Document No.");
                        Report.RunModal(50136, true, false, RecPRSLP);
                    end;
                }
            }
        }
    }
}
