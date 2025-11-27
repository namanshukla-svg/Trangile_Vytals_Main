Page 50014 "Posted Indent"
{
    // // CF001 09.01.2006 added for responsibility center
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = Document;
    SourceTable = "SSD Posted Indent Header";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                Editable = false;

                field("No."; Rec."No.")
                {
                    ApplicationArea = All;

                    trigger OnAssistEdit()
                    begin
                        //IF AssistEdit(xRec) THEN
                        CurrPage.Update;
                    end;
                }
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                    ApplicationArea = All;
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                    ApplicationArea = All;
                }
                field("Indent Order Type"; Rec."Indent Order Type")
                {
                    ApplicationArea = All;
                }
                field("User ID"; Rec."User ID")
                {
                    ApplicationArea = All;
                }
                field(Remarks; Rec.Remarks)
                {
                    ApplicationArea = All;
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = All;
                }
                field("Indent Date"; Rec."Indent Date")
                {
                    ApplicationArea = All;
                }
                field("Due Date"; Rec."Due Date")
                {
                    ApplicationArea = All;
                }
            }
            part(IndentLines; "Posted Indent Subform")
            {
                Editable = false;
                SubPageLink = "Document No." = field("No.");
                ApplicationArea = All;
            }
        }
        area(factboxes)
        {
            part("Attached Documents"; "Doc. Attachment List Factbox")
            {
                ApplicationArea = All;
                Caption = 'Documents List';
                UpdatePropagation = Both;
                SubPageLink = "Table ID" = const(Database::"SSD Posted Indent Header"),
                              "No." = field("No.");
            }
        }
    }
    actions
    {
        area(navigation)
        {
            group("&Indent")
            {
                Caption = '&Indent';

                separator(Action1000000021)
                {
                }
                action("Pending PO (Quotation) List")
                {
                    ApplicationArea = All;
                    Caption = 'Pending PO (Quotation) List';
                    Visible = false;

                    trigger OnAction()
                    var
                        PostedIndentHdrLocal: Record "SSD Posted Indent Header";
                        PostedIndentLineLocal: Record "SSD Posted Indent Line";
                    begin
                        PostedIndentHdrLocal.Reset;
                        PostedIndentHdrLocal.FilterGroup(2);
                        PostedIndentLineLocal.Reset;
                        PostedIndentLineLocal.SetCurrentkey("Replenishment System", "Action Message", "Created Doc. SubType", "Pending PO");
                        PostedIndentLineLocal.SetRange("Replenishment System", PostedIndentLineLocal."replenishment system"::Purchase);
                        PostedIndentLineLocal.SetRange("Action Message", PostedIndentLineLocal."action message"::New);
                        PostedIndentLineLocal.SetRange("Created Doc. SubType", PostedIndentLineLocal."created doc. subtype"::"P.Quote");
                        PostedIndentLineLocal.SetRange("Pending PO", true);
                        if PostedIndentLineLocal.Find('-') then
                            repeat
                                PostedIndentHdrLocal.Get(PostedIndentLineLocal."Document No.");
                                PostedIndentHdrLocal.Mark(true);
                            until PostedIndentLineLocal.Next = 0;
                        PostedIndentHdrLocal.MarkedOnly(true);
                        PostedIndentHdrLocal.FilterGroup(0);
                        Page.RunModal(0, PostedIndentHdrLocal);
                    end;
                }
                action("Pending PO (Order) List")
                {
                    ApplicationArea = All;
                    Caption = 'Pending PO (Order) List';
                    Visible = false;

                    trigger OnAction()
                    var
                        PostedIndentHdrLocal: Record "SSD Posted Indent Header";
                        PostedIndentLineLocal: Record "SSD Posted Indent Line";
                    begin
                        PostedIndentHdrLocal.Reset;
                        PostedIndentHdrLocal.FilterGroup(2);
                        PostedIndentLineLocal.Reset;
                        PostedIndentLineLocal.SetCurrentkey("Replenishment System", "Action Message", "Created Doc. SubType", "Pending PO");
                        PostedIndentLineLocal.SetRange("Replenishment System", PostedIndentLineLocal."replenishment system"::Purchase);
                        PostedIndentLineLocal.SetRange("Action Message", PostedIndentLineLocal."action message"::New);
                        PostedIndentLineLocal.SetRange("Created Doc. SubType", PostedIndentLineLocal."created doc. subtype"::"P.Order");
                        PostedIndentLineLocal.SetRange("Pending PO", true);
                        if PostedIndentLineLocal.Find('-') then
                            repeat
                                PostedIndentHdrLocal.Get(PostedIndentLineLocal."Document No.");
                                PostedIndentHdrLocal.Mark(true);
                            until PostedIndentLineLocal.Next = 0;
                        PostedIndentHdrLocal.MarkedOnly(true);
                        PostedIndentHdrLocal.FilterGroup(0);
                        Page.RunModal(0, PostedIndentHdrLocal);
                    end;
                }
                action("Pending PO (Rate Contract) List")
                {
                    ApplicationArea = All;
                    Caption = 'Pending PO (Rate Contract) List';
                    Visible = false;

                    trigger OnAction()
                    var
                        PostedIndentHdrLocal: Record "SSD Posted Indent Header";
                        PostedIndentLineLocal: Record "SSD Posted Indent Line";
                    begin
                        PostedIndentHdrLocal.Reset;
                        PostedIndentHdrLocal.FilterGroup(2);
                        PostedIndentLineLocal.Reset;
                        PostedIndentLineLocal.SetCurrentkey("Replenishment System", "Action Message", "Created Doc. SubType", "Pending PO");
                        PostedIndentLineLocal.SetRange("Replenishment System", PostedIndentLineLocal."replenishment system"::Purchase);
                        PostedIndentLineLocal.SetRange("Action Message", PostedIndentLineLocal."action message"::New);
                        PostedIndentLineLocal.SetRange("Created Doc. SubType", PostedIndentLineLocal."created doc. subtype"::"P.SchOrder");
                        PostedIndentLineLocal.SetRange("Pending PO", true);
                        if PostedIndentLineLocal.Find('-') then
                            repeat
                                PostedIndentHdrLocal.Get(PostedIndentLineLocal."Document No.");
                                PostedIndentHdrLocal.Mark(true);
                            until PostedIndentLineLocal.Next = 0;
                        PostedIndentHdrLocal.MarkedOnly(true);
                        PostedIndentHdrLocal.FilterGroup(0);
                        Page.RunModal(0, PostedIndentHdrLocal);
                    end;
                }
            }
        }
        area(processing)
        {
            action(Push)
            {
                ApplicationArea = All;
                Caption = 'P&rint';
                Image = Print;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                var
                    PostedIndHdrLocal: Record "SSD Posted Indent Header";
                begin
                    CurrPage.SetSelectionFilter(PostedIndHdrLocal);
                    Report.Run(Report::"Posted Indent Report", true, false, PostedIndHdrLocal);
                end;
            }
            action(Comment)
            {
                ApplicationArea = All;
                Caption = 'Comment';
                Promoted = true;
                PromotedCategory = Process;
                RunObject = Page "Inventory Comment Sheet";
                RunPageLink = "No." = field("No.");
                RunPageView = sorting("Document Type", "No.", "Line No.") order(ascending) where("Document Type" = const("Inventory Shipment"));
                ToolTip = 'Comment';
                Visible = false;
            }
        }
    }
    trigger OnOpenPage()
    var
        Usersetup: Record "User Setup";
    begin
        //sandeep
        /*
            IF USERID <>'' THEN BEGIN
             Usersetup.GET(USERID);
             IF Usersetup."Indent Access"=Usersetup."Indent Access"::Limited THEN BEGIN
              FILTERGROUP(2);
              SETRANGE("User ID",USERID);
              FILTERGROUP(0);
              END;
            END;
            */
        //sandeep
        //CF001 St
        // if UserMgt.GetRespCenterFilter() <> '' then begin
        //     Rec.FilterGroup(2);
        //     Rec.SetRange("Responsibility Center", UserMgt.GetRespCenterFilter);
        //     Rec.FilterGroup(0);
        // end;
        //CF001 En
    end;

    var
        Req: Code[10];
        PostedIndentHeader: Record "SSD Posted Indent Header";
        UserMgt: Codeunit "SSD User Setup Management";
}
