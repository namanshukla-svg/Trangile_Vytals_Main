Page 50332 "Issue Slip Approval Page"
{
    // // CF001 09.01.2006 added for responsibility center
    CardPageID = "Issue Slip";
    DeleteAllowed = false;
    Editable = false;
    PageType = List;
    SourceTable = "SSD Indent Header2";
    SourceTableView = where(Approved=filter(false), Rejected=const(false));
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                Caption = 'General';

                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    Editable = true;
                }
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                    ApplicationArea = All;
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                    ApplicationArea = All;
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
                    Caption = 'Requested Receipt Date';
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Approved; Rec.Approved)
                {
                    ApplicationArea = All;
                }
                field("Sender ID"; Rec."Sender ID")
                {
                    ApplicationArea = All;
                }
                field(Rejected; Rec.Rejected)
                {
                    ApplicationArea = All;
                }
            }
        }
    }
    actions
    {
        area(processing)
        {
            group("F&unctions")
            {
                Caption = 'F&unctions';

                action(Approve)
                {
                    ApplicationArea = All;
                    Caption = 'Approve';
                    Image = Approve;
                    Promoted = true;
                    PromotedCategory = New;

                    trigger OnAction()
                    var
                        ApprovalMgt: Codeunit "Approvals Mgmt.";
                    begin
                        // UserSetup1.RESET;
                        // UserSetup1.SETRANGE("Indent Costcen Code","Shortcut Dimension 1 Code");
                        // IF UserSetup1.FINDFIRST THEN BEGIN
                        //  Rec."Approval ID" := UserSetup1."User ID";
                        //  Rec."Send for Approval" := TRUE;
                        //  Rec.MODIFY;
                        //  END;
                        CostcenCode:='*' + Rec."Shortcut Dimension 1 Code" + '*';
                        UserSetup1.Reset;
                        UserSetup1.SetRange("User ID", UserId);
                        //UserSetup1.SETFILTER("Indent Costcen Code",CostcenCode);
                        if UserSetup1.FindFirst then begin
                            CurrPage.SetSelectionFilter(IndentHeader3);
                            if IndentHeader3.FindSet then begin
                                IndentHeader3.Approved:=true;
                                IndentHeader3.Status:=IndentHeader3.Status::Released;
                                IndentHeader3.Modify;
                            end;
                        end;
                    // IF CurrPage.LOOKUPMODE THEN
                    //  IF CONFIRM('Do you want to Continue ?',FALSE) THEN
                    //
                    //    IF (Status = Status::Open) OR ("Send for Approval" = FALSE)THEN BEGIN
                    //      UserSetup.GET(USERID);
                    //      //EmailId := UserSetup."E-Mail";
                    //      //EmailId := 'rakumar@alletec.com';
                    //      EmailId := 'lmohan@zavenir.com;vchhabra@zavenir.com;gurgaon.scm@zavenir.com';
                    //      SMTPMailSetup.GET;
                    //      SMTPMailSetup.TESTFIELD("SMTP Server");
                    //      SMTPMailSetup.TESTFIELD("User ID");
                    //      SMTPMailSetup.TESTFIELD(Password);
                    //      SMTPMail.CreateMessage('Zavenir Indent Process',SMTPMailSetup."User ID",EmailId,'Indent Details','',TRUE);
                    //      SMTPMail.AppendBody('Dear Sir or Madam,<br><br>');
                    //      //SMTPMail.AppendBody('Please find the attached Indent detail.<br><br></font>');
                    //      SMTPMail.AppendBody('Indent ' +"No." + ' has been sent for further Approval');
                    //      SMTPMail.Send;
                    //    END;
                    end;
                }
                action(Reject)
                {
                    ApplicationArea = All;
                    Caption = 'Reject';
                    Image = Reject;
                    Promoted = true;
                    PromotedCategory = New;

                    trigger OnAction()
                    begin
                        CostcenCode:='*' + Rec."Shortcut Dimension 1 Code" + '*';
                        UserSetup1.Reset;
                        UserSetup1.SetRange("User ID", UserId);
                        UserSetup1.SetFilter("Indent Costcen Code", CostcenCode);
                        if UserSetup1.FindFirst then begin
                            CurrPage.SetSelectionFilter(IndentHeader3);
                            if IndentHeader3.FindSet then begin
                                IndentHeader3.Approved:=false;
                                IndentHeader3.Rejected:=true;
                                IndentHeader3.Status:=IndentHeader3.Status::Reject;
                                IndentHeader3.Modify;
                            end;
                        end;
                    end;
                }
            }
        }
    }
    trigger OnOpenPage()
    var
        UserSetup: Record "User Setup";
    begin
        UserSetup.Reset;
        Rec.SetRange("Approval ID", UserId);
    end;
    var Req: Code[10];
    Text001: label 'There is nothing to release for Indent %1';
    IndentHeader: Record "SSD Indent Header2";
    Text002: label 'You are not Authorised to Post it';
    UserSetup: Record "User Setup";
    Responsibilitycenter: Record "Responsibility Center";
    UserMgt: Codeunit "SSD User Setup Management";
    Text003: label 'Profit Center must be %1 for Indent No. %2';
    EmailId: Code[1024];
    CC: Code[1024];
    UserSetup2: Record "User Setup";
    EmailId2: Code[500];
    UserSetup1: Record "User Setup";
    IndentHeader3: Record "SSD Indent Header2";
    CostcenCode: Code[50];
}
