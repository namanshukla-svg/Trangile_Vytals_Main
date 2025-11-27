Page 50193 "Indent- Pending For Appr."
{
    // // CF001 09.01.2006 added for responsibility center
    DeleteAllowed = false;
    Editable = false;
    PageType = Document;
    SourceTable = "SSD Indent Header";
    SourceTableView = where("Send Approval"=filter(true));
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
                    Editable = true;

                    trigger OnAssistEdit()
                    begin
                        if Rec.AssistEdit(xRec)then CurrPage.Update;
                    end;
                }
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        UpdateLineWithShortDimcode(Rec);
                    end;
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        UpdateLineWithShortDimcode(Rec);
                    end;
                }
                field("Indenter ID"; Rec."Indenter ID")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Enabled = true;
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
                    Editable = false;
                }
                field("Due Date"; Rec."Due Date")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        if Rec."Due Date" < Rec."Indent Date" then Error('Due Date Date should be greater than your Indent Date');
                    end;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
            }
            part(IndentLines; "Indent Subform")
            {
                SubPageLink = "Document No."=field("No.");
                ApplicationArea = All;
            }
        }
    }
    actions
    {
        area(navigation)
        {
            group("Function")
            {
                Caption = '&Function';

                action("&Approve")
                {
                    ApplicationArea = All;
                    Caption = '&Approve';
                    Image = Approve;

                    trigger OnAction()
                    begin
                    // AdditionalApprovers.RESET;
                    // AdditionalApprovers.SETRANGE(AdditionalApprovers."Approval Code",'PUR-INDENT');
                    // AdditionalApprovers.SETRANGE(AdditionalApprovers."Approver ID",USERID);
                    // IF AdditionalApprovers.FINDFIRST THEN BEGIN
                    //  Status:=Status::Released;
                    //  "Send Approval":=FALSE;
                    //  MODIFY;
                    // END ELSE BEGIN
                    //  ERROR('You are not authorised to approve');
                    // END;
                    //ALLE_UPG
                    end;
                }
                action("&Cancel Approval")
                {
                    ApplicationArea = All;
                    Caption = '&Cancel Approval';
                    Image = Cancel;

                    trigger OnAction()
                    begin
                    // AdditionalApprovers.RESET;
                    // AdditionalApprovers.SETRANGE(AdditionalApprovers."Approval Code",'PUR-INDENT');
                    // AdditionalApprovers.SETRANGE(AdditionalApprovers."Approver ID",USERID);
                    // IF AdditionalApprovers.FINDFIRST THEN BEGIN
                    // //Status:=Status::released;
                    // "Send Approval":=FALSE;
                    // MODIFY;
                    // END ELSE BEGIN
                    // ERROR('You are not authorised to Reject');
                    // END;
                    //ALLE_UPG
                    end;
                }
                action("&Show Document Lines")
                {
                    ApplicationArea = All;
                    Caption = '&Show Document Lines';
                    Image = ShowSelected;

                    trigger OnAction()
                    begin
                        Clear(frmindentsubform);
                        IndentLine.Reset;
                        IndentLine.SetRange(IndentLine."Document No.", Rec."No.");
                        frmindentsubform.SetTableview(IndentLine);
                        frmindentsubform.SetRecord(IndentLine);
                        frmindentsubform.RunModal;
                    end;
                }
                action(Comment)
                {
                    ApplicationArea = All;
                    Caption = 'Comment';
                    Image = Comment;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Inventory Comment Sheet";
                    RunPageLink = "No."=field("No.");
                    RunPageView = sorting("Document Type", "No.", "Line No.")order(ascending)where("Document Type"=const(4));
                    ToolTip = 'Comment';
                }
            }
        }
    }
    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec."Responsibility Center":=UserMgt.GetRespCenterFilter;
    end;
    trigger OnOpenPage()
    var
        UserSetup: Record "User Setup";
    begin
    //sandeep
    /*IF USERID <>'' THEN
          BEGIN
            UserSetup.GET(USERID);
            IF UserSetup."Indent Access"=UserSetup."Indent Access"::Limited THEN
              BEGIN
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
    var Req: Code[10];
    Text001: label 'There is nothing to release for Indent %1';
    IndentHeader: Record "SSD Indent Header";
    Text002: label 'You are not Authorised to Post it';
    UserSetup: Record "User Setup";
    Responsibilitycenter: Record "Responsibility Center";
    UserMgt: Codeunit "SSD User Setup Management";
    Text003: label 'Profit Center must be %1 for Indent No. %2';
    IndentLine: Record "SSD Indent Line";
    frmindentsubform: Page "Indent Subform";
    procedure ReleaseIndent()
    var
        IndentLine: Record "SSD Indent Line";
    begin
        Rec.TestField("No.");
        Rec.TestField("Due Date");
        if Rec."Due Date" < Rec."Indent Date" then Error('Check the due Date in Header');
        /*
        //Specific for Caparo St
        IF "Shortcut Dimension 1 Code"<> THEN
          ERROR(Text003,"Responsibility Center","No.");
        //En
        */
        Rec.TestField("Indent Date");
        Rec.TestField("Posting Date");
        IndentLine.SetRange("Document No.", Rec."No.");
        if IndentLine.Find('-')then repeat if IndentLine."Due Date" < Rec."Indent Date" then Error('Check the due Date in Line No. %1', IndentLine."Line No.");
                IndentLine.TestField(Type, IndentLine.Type::"Fixed Asset");
                IndentLine.TestField("No.");
                IndentLine.TestField(Quantity);
                IndentLine.TestField("Due Date");
                //sandeep singla begin
                IndentLine.TestField(IndentLine."Product Group Code");
                IndentLine.TestField(IndentLine."Gen.Prod.Posting Group");
                //sandeep singla end
                IndentLine.TestField("Shortcut Dimension 1 Code");
                IndentLine.TestField("Qty. per Unit Of Measure");
                IndentLine.TestField("Unit Of Measure Code");
                IndentLine.TestField("Quantity (Base)");
                IndentLine.TestField("Indent Date");
            until IndentLine.Next = 0
        else
            Error(Text001, Rec."No.");
        Rec.Status:=Rec.Status::Released;
        Rec.Modify;
    end;
    procedure ReopenIndent()
    begin
        Rec.Status:=Rec.Status::Open;
        Rec.Modify;
    end;
    procedure UpdateLineWithShortDimcode(RecIndentHeader: Record "SSD Indent Header")
    var
        IndentLineLocal: Record "SSD Indent Line";
    begin
        IndentLineLocal.Reset;
        IndentLineLocal.SetRange("Document No.", RecIndentHeader."No.");
        if IndentLineLocal.Find('-')then repeat IndentLineLocal."Shortcut Dimension 1 Code":=RecIndentHeader."Shortcut Dimension 1 Code";
                IndentLineLocal."Shortcut Dimension 2 Code":=RecIndentHeader."Shortcut Dimension 2 Code";
                IndentLineLocal.Modify;
            until IndentLineLocal.Next = 0;
    end;
}
