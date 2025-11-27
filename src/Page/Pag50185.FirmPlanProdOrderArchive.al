Page 50185 "Firm Plan. Prod. Order Archive"
{
    Caption = 'Planned Production Order';
    Editable = false;
    PageType = Document;
    RefreshOnActivate = true;
    SourceTable = "SSD Production Order Archive";
    SourceTableView = where(Status=const("Firm Planned"));
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';

                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    Importance = Promoted;
                    Lookup = false;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    Importance = Promoted;
                }
                field("Description 2"; Rec."Description 2")
                {
                    ApplicationArea = All;
                }
                field("Source Type"; Rec."Source Type")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        if xRec."Source Type" <> Rec."Source Type" then Rec."Source No.":='';
                    end;
                }
                field("Source No."; Rec."Source No.")
                {
                    ApplicationArea = All;
                }
                field("Search Description"; Rec."Search Description")
                {
                    ApplicationArea = All;
                }
                field(Quantity; Rec.Quantity)
                {
                    ApplicationArea = All;
                    Importance = Promoted;
                }
                field("Due Date"; Rec."Due Date")
                {
                    ApplicationArea = All;
                }
                field("Assigned User ID"; Rec."Assigned User ID")
                {
                    ApplicationArea = All;
                }
                field("Last Date Modified"; Rec."Last Date Modified")
                {
                    ApplicationArea = All;
                }
            }
            group(Schedule)
            {
                Caption = 'Schedule';

                field("Starting Time"; Rec."Starting Time")
                {
                    ApplicationArea = All;
                    Importance = Promoted;
                }
                field("Starting Date"; Rec."Starting Date")
                {
                    ApplicationArea = All;
                    Importance = Promoted;
                }
                field("Ending Time"; Rec."Ending Time")
                {
                    ApplicationArea = All;
                    Importance = Promoted;
                }
                field("Ending Date"; Rec."Ending Date")
                {
                    ApplicationArea = All;
                    Importance = Promoted;
                }
            }
            group(Posting)
            {
                Caption = 'Posting';

                field("Inventory Posting Group"; Rec."Inventory Posting Group")
                {
                    ApplicationArea = All;
                    Importance = Promoted;
                }
                field("Gen. Prod. Posting Group"; Rec."Gen. Prod. Posting Group")
                {
                    ApplicationArea = All;
                }
                field("Gen. Bus. Posting Group"; Rec."Gen. Bus. Posting Group")
                {
                    ApplicationArea = All;
                }
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        ShortcutDimension1CodeOnAfterV;
                    end;
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        ShortcutDimension2CodeOnAfterV;
                    end;
                }
                field("Location Code"; Rec."Location Code")
                {
                    ApplicationArea = All;
                    Importance = Promoted;
                }
                field("Bin Code"; Rec."Bin Code")
                {
                    ApplicationArea = All;
                    Importance = Promoted;
                }
            }
        }
    }
    actions
    {
        area(navigation)
        {
            group("O&rder")
            {
                Caption = 'O&rder';
                Image = "Order";

                action("Co&mments")
                {
                    ApplicationArea = All;
                    Caption = 'Co&mments';
                    Image = ViewComments;
                    RunObject = Page "Prod. Order Comment Sheet";
                    RunPageLink = Status=field(Status), "Prod. Order No."=field("No.");
                }
                action(Dimensions)
                {
                    ApplicationArea = All;
                    Caption = 'Dimensions';
                    Image = Dimensions;
                    ShortCutKey = 'Shift+Ctrl+D';
                }
                separator(Action53)
                {
                }
                action(Statistics)
                {
                    ApplicationArea = All;
                    Caption = 'Statistics';
                    Image = Statistics;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Production Order Statistics";
                    RunPageLink = Status=field(Status), "No."=field("No."), "Date Filter"=field("Date Filter");
                    ShortCutKey = 'F7';
                }
                separator(Action65)
                {
                }
                action("Plannin&g")
                {
                    ApplicationArea = All;
                    Caption = 'Plannin&g';
                    Image = Planning;

                    trigger OnAction()
                    var
                        OrderPlanning: Page "Order Planning";
                    begin
                    end;
                }
            }
        }
        area(processing)
        {
            group("F&unctions")
            {
                Caption = 'F&unctions';
                Image = "Action";

                action("Re&fresh Production Order")
                {
                    ApplicationArea = All;
                    Caption = 'Re&fresh Production Order';
                    Ellipsis = true;
                    Image = Refresh;
                    Promoted = true;
                    PromotedCategory = Process;

                    trigger OnAction()
                    var
                        ProdOrder: Record "Production Order";
                    begin
                    end;
                }
                action("Re&plan")
                {
                    ApplicationArea = All;
                    Caption = 'Re&plan';
                    Ellipsis = true;
                    Image = Replan;
                    Promoted = true;
                    PromotedCategory = Process;

                    trigger OnAction()
                    var
                        ProdOrder: Record "Production Order";
                    begin
                    end;
                }
                separator(Action59)
                {
                }
                action("Change &Status")
                {
                    ApplicationArea = All;
                    Caption = 'Change &Status';
                    Ellipsis = true;
                    Image = ChangeStatus;
                    Promoted = true;
                    PromotedCategory = Process;

                    trigger OnAction()
                    var
                        ProdOrderStatusMgt: Codeunit "Prod. Order Status Management";
                    begin
                    end;
                }
                action("&Update Unit Cost")
                {
                    ApplicationArea = All;
                    Caption = '&Update Unit Cost';
                    Ellipsis = true;
                    Image = UpdateUnitCost;

                    trigger OnAction()
                    var
                        ProdOrder: Record "Production Order";
                    begin
                    end;
                }
                separator(Action62)
                {
                }
                action("C&opy Prod. Order Document")
                {
                    ApplicationArea = All;
                    Caption = 'C&opy Prod. Order Document';
                    Ellipsis = true;
                    Image = CopyDocument;
                    Promoted = true;
                    PromotedCategory = Process;
                }
            }
        }
        area(reporting)
        {
            action("Subcontractor - Dispatch List")
            {
                ApplicationArea = All;
                Caption = 'Subcontractor - Dispatch List';
                Image = "Report";
                Promoted = true;
                PromotedCategory = "Report";
                RunObject = Report "Subcontractor - Dispatch List";
            }
        }
    }
    var CopyProdOrderDoc: Report "Copy Production Order Document";
    local procedure ShortcutDimension1CodeOnAfterV()
    begin
    end;
    local procedure ShortcutDimension2CodeOnAfterV()
    begin
    end;
}
