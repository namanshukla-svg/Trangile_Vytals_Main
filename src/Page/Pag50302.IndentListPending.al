Page 50302 "Indent List Pending"
{
    ApplicationArea = All;
    CardPageID = Indent;
    Editable = false;
    PageType = List;
    SourceTable = "SSD Indent Header";
    UsageCategory = Tasks;

    layout
    {
        area(content)
        {
            repeater(Control1000000000)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                }
                field("Due Date"; Rec."Due Date")
                {
                    ApplicationArea = All;
                }
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                    ApplicationArea = All;
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                    ApplicationArea = All;
                }
                field("Indent Date"; Rec."Indent Date")
                {
                    ApplicationArea = All;
                }
                field("Indenter ID"; Rec."Indenter ID")
                {
                    ApplicationArea = All;
                }
                field(Remarks; Rec.Remarks)
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
            group("Function")
            {
                Caption = '&Function';
                Visible = FunctionVisible;

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
                    // Status:=Status::Released;
                    // "Send Approval":=FALSE;
                    // MODIFY;
                    // END ELSE BEGIN
                    // ERROR('You are not authorised to approve');
                    // END;
                    //ALLE_UPG
                    end;
                }
                action("&Cancel Approval")
                {
                    ApplicationArea = All;
                    Caption = '&Cancel Approval';

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
                    // ERROR('You are not authorised to approve');
                    // END;
                    //ALLE_UPG
                    end;
                }
                action("&Show Document Lines")
                {
                    ApplicationArea = All;
                    Caption = '&Show Document Lines';

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
            }
        }
    }
    trigger OnAfterGetRecord()
    begin
        //5.51
        if Rec."Send Approval" then FunctionVisible:=true
        else
            FunctionVisible:=false;
    //5.51
    end;
    trigger OnOpenPage()
    begin
        UserSetup.Get(UserId);
        if not(UserSetup."Indent Approval")then Error('You are not authorise to view Pending Approval');
        //CF001 St
        if UserMgt.GetRespCenterFilter() <> '' then begin
            Rec.FilterGroup(2);
            //Rec.SetRange("Responsibility Center", UserMgt.GetRespCenterFilter);
            //ALLE
            Rec.SetFilter("Indent Date", '>%1', 20160331D); //ALLE
            if(UserId = 'PDAS')then Rec.SetRange("Shortcut Dimension 1 Code", '24000');
            if(UserId = 'SGARG')then Rec.SetFilter("Shortcut Dimension 1 Code", '21000|22000|23000|25000');
            if(UserId = 'ZDI\JFERNANDES')then Rec.SetRange("Shortcut Dimension 1 Code", '35900');
            if(UserId = 'ZDI\RGUPTA')then Rec.SetRange("Shortcut Dimension 1 Code", '36900');
            if(UserId = 'BBAINS')then Rec.SetRange("Shortcut Dimension 1 Code", '34500');
            if(UserId = 'ZDI\SSYED')then Rec.SetRange("Shortcut Dimension 1 Code", '34400');
            if(UserId = 'NKMISHRA')then Rec.SetRange("Shortcut Dimension 1 Code", '51000');
            if(UserId = 'LMOHAN')then Rec.SetRange("Shortcut Dimension 1 Code", '80000');
            if(UserId = 'ZDI\RSINGH')then Rec.SetFilter("Shortcut Dimension 1 Code", '71000|72000');
            //ALLE
            Rec.FilterGroup(0);
        end;
    //CF001 En
    //setfilter("Indent Date",'>=%1','01022017')
    end;
    var UserMgt: Codeunit "SSD User Setup Management";
    IndentLine: Record "SSD Indent Line";
    frmindentsubform: Page "Indent Subform";
    FunctionVisible: Boolean;
    MapUserDimension: Record "SSD Map User Dimension";
    CostCenterValue: Text;
    UserSetup: Record "User Setup";
}
