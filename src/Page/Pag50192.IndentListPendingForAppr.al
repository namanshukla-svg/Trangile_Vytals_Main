Page 50192 "Indent List-Pending For Appr."
{
    ApplicationArea = All;
    CardPageID = "Indent- Pending For Appr.";
    Editable = false;
    PageType = List;
    SourceTable = "SSD Indent Header";
    SourceTableView = sorting("No.")where("Send Approval"=const(true));
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
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                }
                field("Send Approval"; Rec."Send Approval")
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

                action("&Approve")
                {
                    ApplicationArea = All;
                    Caption = '&Approve';
                    Image = Approve;

                    trigger OnAction()
                    begin
                    //SSDU Commented 
                    // AdditionalApprovers.Reset;
                    // AdditionalApprovers.SetRange(AdditionalApprovers."Approval Code", 'PUR-INDENT'); 
                    // AdditionalApprovers.SetRange(AdditionalApprovers."Approver ID", UserId);
                    // if AdditionalApprovers.FindFirst then begin
                    //     Rec.Status := Rec.Status::Released;
                    //     Rec."Send Approval" := false;
                    //     Rec.Modify;
                    // end else begin
                    //     Error('You are not authorised to approve');
                    // end;
                    // //ALLE_UPG
                    // if CurrPage.LookupMode then
                    //     if Confirm('Do you want to Continue ?', false) then
                    //         if (Rec.Status = Rec.Status::Open) or (Rec."Send Approval" = true) then begin
                    //             UserSetup.Get(UserId);
                    //             //EmailId := UserSetup."E-Mail";
                    //             EmailId := 'rakumar@alletec.com';
                    //             //EmailId := 'lmohan@zavenir.com;pdas@zavenir.com;gurgaon.scm@zavenir.com';
                    //             //SSDU Commented 
                    //             // SMTPMailSetup.Get;
                    //             // SMTPMailSetup.TestField("SMTP Server");
                    //             // SMTPMailSetup.TestField("User ID");
                    //             // SMTPMailSetup.TestField(Password);
                    //             // SMTPMail.CreateMessage('Zavenir Daubert Indent Process', SMTPMailSetup."User ID", EmailId, 'Indent Details', '', true);
                    //             // SMTPMail.AppendBody('Dear Sir or Madam,<br><br>');
                    //             // //SMTPMail.AppendBody('Please find the attached Indent detail.<br><br></font>');
                    //             // SMTPMail.AppendBody('Indent ' + Rec."No." + ' has been not Approved');
                    //             // SMTPMail.Send;
                    //             //SSDU Commented 
                    //         end;
                    //SSDU Commented 
                    end;
                }
                action("&Cancel Approval")
                {
                    ApplicationArea = All;
                    Caption = '&Cancel Approval';
                    Image = Cancel;

                    trigger OnAction()
                    begin
                    //SSDU Commented 
                    // AdditionalApprovers.Reset;
                    // AdditionalApprovers.SetRange(AdditionalApprovers."Approval Code", 'PUR-INDENT'); 
                    // AdditionalApprovers.SetRange(AdditionalApprovers."Approver ID", UserId);
                    // if AdditionalApprovers.FindFirst then begin
                    //     //Status:=Status::released;
                    //     Rec."Send Approval" := false;
                    //     Rec.Modify;
                    // end else begin
                    //     Error('You are not authorised to approve');
                    // end;
                    //ALLE_UPG
                    //SSDU Commented 
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
        //ALLE
        MapUserDimension.Reset;
        MapUserDimension.SetRange(MapUserDimension."User Id", UserId);
        MapUserDimension.SetRange(MapUserDimension."Dimension Code", 'COSTCEN');
        if MapUserDimension.FindSet then repeat if CostCenterValue = '' then CostCenterValue:=MapUserDimension."Dimension Value"
                else
                    CostCenterValue+='|' + MapUserDimension."Dimension Value";
            until MapUserDimension.Next = 0;
    //ALLE
    //CF001 St
    // if UserMgt.GetRespCenterFilter() <> '' then begin
    //     Rec.FilterGroup(2);
    //     Rec.SetRange("Responsibility Center", UserMgt.GetRespCenterFilter);
    //     //ALLE
    //     /* IF CostCenterValue <> '' THEN BEGIN
    //        SETRANGE("Indenter ID",USERID);
    //        SETFILTER("Shortcut Dimension 1 Code",CostCenterValue);
    //      END;  */
    //     //ALLE
    //     Rec.FilterGroup(0);
    // end;
    //CF001 En
    //SETRANGE("Indenter ID",USERID);//ALLE
    end;
    var UserMgt: Codeunit "SSD User Setup Management";
    IndentLine: Record "SSD Indent Line";
    frmindentsubform: Page "Indent Subform";
    FunctionVisible: Boolean;
    //SSDU SMTPMailSetup: Record "SMTP Mail Setup"; 
    //SSDU SMTPMail: Codeunit "SMTP Mail";
    EmailId: Code[1024];
    UserSetup: Record "User Setup";
    IndentHeader: Record "SSD Indent Header";
    MapUserDimension: Record "SSD Map User Dimension";
    CostCenterValue: Text[200];
//SSDU AdditionalApprovers: Record "Additional Approvers";
}
