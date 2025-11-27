Page 50018 "Indent List"
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
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                }
                field("Approval ID"; Rec."Approval ID")
                {
                    ApplicationArea = All;
                }
                field(Rejected; Rec.Rejected)
                {
                    ApplicationArea = All;
                }
                field("Send Approval"; Rec."Send Approval")
                {
                    ApplicationArea = All;
                }
                field("Send for Approval"; Rec."Send for Approval")
                {
                    ApplicationArea = All;
                }
                field(Approved; Rec.Approved)
                {
                    ApplicationArea = All;
                }
                field("Issue Slip No."; Rec."Issue Slip No.")
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
        Rec.SetFilter("Indent Date", '>%1', 20160331D); //ALLE
        CostCenterValue:='';
        //ALLE
        MapUserDimension.Reset;
        MapUserDimension.SetRange(MapUserDimension."User Id", UserId);
        MapUserDimension.SetRange(MapUserDimension."Dimension Code", 'COSTCEN');
        if MapUserDimension.FindSet then begin
            repeat if CostCenterValue = '' then CostCenterValue:=MapUserDimension."Dimension Value"
                else
                    CostCenterValue+='|' + MapUserDimension."Dimension Value";
            until MapUserDimension.Next = 0;
        end;
        //ALLE
        //CF001 St
        if UserMgt.GetRespCenterFilter() <> '' then begin
            Rec.FilterGroup(2);
            //Rec.SetRange("Responsibility Center", UserMgt.GetRespCenterFilter);
            //ALLE
            if CostCenterValue <> '' then begin
                //SETRANGE("Indenter ID",USERID);   ALLE_UPG
                Rec.SetFilter("Shortcut Dimension 1 Code", CostCenterValue);
            end;
            //ALLE
            //SETRANGE("Indenter ID",USERID);//ALLE
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
}
