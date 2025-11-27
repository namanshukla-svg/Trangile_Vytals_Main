Page 50219 "Issue Slip"
{
    // // CF001 09.01.2006 added for responsibility center
    DeleteAllowed = false;
    PageType = Document;
    SourceTable = "SSD Indent Header2";
    SourceTableView = where("Send Approval" = filter(false));
    PromotedActionCategories = 'New,Process,Report,Approve,Request Approval';
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
                        if Rec.AssistEdit(xRec) then CurrPage.Update;
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
                    Caption = 'Requested Receipt Date';

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
                field("Send for Approval"; Rec."Send for Approval")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Approved; Rec.Approved)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
            }
            part(IndentLines; "Item Issue subform")
            {
                SubPageLink = "Document No." = field("No.");
                ApplicationArea = All;
            }
        }
    }
    actions
    {
        area(navigation)
        {
            //SSD_Sunil
            // group(Approval)
            // {
            //     Caption = 'Approval';
            //     action(Approve)
            //     {
            //         ApplicationArea = All;
            //         Caption = 'Approve';
            //         Image = Approve;
            //         Promoted = true;
            //         PromotedCategory = Category4;
            //         PromotedIsBig = true;
            //         PromotedOnly = true;
            //         ToolTip = 'Approve the requested changes.';
            //         Visible = OpenApprovalEntriesExistCurrUser;
            //         trigger OnAction()
            //         var
            //             ApprovalsMgmt: Codeunit "Approvals Mgmt.";
            //         begin
            //             ApprovalsMgmt.ApproveRecordApprovalRequest(Rec.RecordId);
            //         end;
            //     }
            //     action(Reject)
            //     {
            //         ApplicationArea = All;
            //         Caption = 'Reject';
            //         Image = Reject;
            //         Promoted = true;
            //         PromotedCategory = Category4;
            //         PromotedIsBig = true;
            //         PromotedOnly = true;
            //         ToolTip = 'Reject the approval request.';
            //         Visible = OpenApprovalEntriesExistCurrUser;
            //         trigger OnAction()
            //         var
            //             ApprovalsMgmt: Codeunit "Approvals Mgmt.";
            //         begin
            //             ApprovalsMgmt.RejectRecordApprovalRequest(Rec.RecordId);
            //         end;
            //     }
            //     action(Delegate)
            //     {
            //         ApplicationArea = All;
            //         Caption = 'Delegate';
            //         Image = Delegate;
            //         Promoted = true;
            //         PromotedCategory = Category4;
            //         PromotedOnly = true;
            //         ToolTip = 'Delegate the approval to a substitute approver.';
            //         Visible = OpenApprovalEntriesExistCurrUser;
            //         trigger OnAction()
            //         var
            //             ApprovalsMgmt: Codeunit "Approvals Mgmt.";
            //         begin
            //             ApprovalsMgmt.DelegateRecordApprovalRequest(Rec.RecordId);
            //         end;
            //     }
            //     action(Comments)
            //     {
            //         ApplicationArea = All;
            //         Caption = 'Comments';
            //         Image = ViewComments;
            //         Promoted = true;
            //         PromotedCategory = Category4;
            //         PromotedOnly = true;
            //         ToolTip = 'View or add comments for the record.';
            //         Visible = OpenApprovalEntriesExistCurrUser;
            //         trigger OnAction()
            //         var
            //             ApprovalsMgmt: Codeunit "Approvals Mgmt.";
            //         begin
            //             ApprovalsMgmt.GetApprovalComment(Rec);
            //         end;
            //     }
            // }
            // group("Request Approval")
            // {
            //     Caption = 'Request Approval';
            //     Image = SendApprovalRequest;
            //     action(SendApprovalRequest)
            //     {
            //         ApplicationArea = Basic, Suite;
            //         Caption = 'Send A&pproval Request';
            //         Enabled = NOT OpenApprovalEntriesExist AND CanRequestApprovalForFlow;
            //         Image = SendApprovalRequest;
            //         Promoted = true;
            //         PromotedCategory = Category5;
            //         PromotedIsBig = true;
            //         ToolTip = 'Request approval to change the record.';
            //         trigger OnAction()
            //         var
            //             WorkflowEvent: Codeunit WFCode;
            //         begin
            //             if not (Rec.IndentLineExist) then
            //                 Error('Indent Line does not exist for indent no %1', Rec."No.");
            //             CheckIndent;
            //             //if WorkflowEvent.CheckIndentApprovalsWorkflowEnabled(Rec) then begin
            //             //   WorkflowEvent.OnSendIndentForApproval(Rec);
            //             //if WorkflowEvent.CheckWorkflowEnabled then
            //             WorkflowEvent.OnSendItemIssueDocforApproval(Rec);
            //             // end;
            //         end;
            //     }
            //     action(CancelApprovalRequest)
            //     {
            //         ApplicationArea = Basic, Suite;
            //         Caption = 'Cancel Approval Re&quest';
            //         Enabled = CanCancelApprovalForRecord OR CanCancelApprovalForFlow;
            //         // Enabled = CancelVisible;
            //         Image = CancelApprovalRequest;
            //         Promoted = true;
            //         PromotedCategory = Category5;
            //         ToolTip = 'Cancel the approval request.';
            //         trigger OnAction()
            //         var
            //             WorkflowEvent: Codeunit WFCode;
            //         begin
            //             WorkflowEvent.OnCancelItemIssueDocforApproval(Rec);
            //         end;
            //     }
            //     action(ApprovalEntries)
            //     {
            //         AccessByPermission = TableData "Approval Entry" = R;
            //         ApplicationArea = Basic, Suite;
            //         Caption = 'Approvals';
            //         Image = Approvals;
            //         Promoted = true;
            //         PromotedCategory = Category5;
            //         ToolTip = 'View a list of the records that are waiting to be approved. For example, you can see who requested the record to be approved, when it was sent, and when it is due to be approved.';
            //         trigger OnAction()
            //         begin
            //             ApprovalsMgmt.OpenApprovalEntriesPage(Rec.RecordId);
            //         end;
            //     }
            // }
            group(Approval)
            {
                Caption = 'Approval';

                action(Approve)
                {
                    ApplicationArea = All;
                    Caption = 'Approve';
                    Image = Approve;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
                    PromotedOnly = true;
                    ToolTip = 'Approve the requested changes.';
                    Visible = OpenApprovalEntriesExistCurrUser;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        ApprovalsMgmt.ApproveRecordApprovalRequest(Rec.RecordId);
                    end;
                }
                action(Reject)
                {
                    ApplicationArea = All;
                    Caption = 'Reject';
                    Image = Reject;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
                    PromotedOnly = true;
                    ToolTip = 'Reject the approval request.';
                    Visible = OpenApprovalEntriesExistCurrUser;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        ApprovalsMgmt.RejectRecordApprovalRequest(Rec.RecordId);
                    end;
                }
                action(Delegate)
                {
                    ApplicationArea = All;
                    Caption = 'Delegate';
                    Image = Delegate;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedOnly = true;
                    ToolTip = 'Delegate the approval to a substitute approver.';
                    Visible = OpenApprovalEntriesExistCurrUser;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        ApprovalsMgmt.DelegateRecordApprovalRequest(Rec.RecordId);
                    end;
                }
                action(Comments)
                {
                    ApplicationArea = All;
                    Caption = 'Comments';
                    Image = ViewComments;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedOnly = true;
                    ToolTip = 'View or add comments for the record.';
                    Visible = OpenApprovalEntriesExistCurrUser;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        ApprovalsMgmt.GetApprovalComment(Rec);
                    end;
                }
            }
            //
            group("Request Approval")
            {
                Caption = 'Request Approval';
                Image = SendApprovalRequest;

                action(SendApprovalRequest)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Send A&pproval Request';
                    //Enabled = NOT OpenApprovalEntriesExist;
                    Image = SendApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Category5;
                    PromotedIsBig = true;
                    ToolTip = 'Request approval to change the record.';

                    trigger OnAction()
                    var
                        WorkflowEvent: Codeunit "Custom Workflow";
                    begin
                        CheckIndent();
                        if WorkflowEvent.CheckItemIssueNewApprovalsWorkflowEnabled(Rec) then WorkflowEvent.OnSendItemIssueNewForApproval(Rec);
                    end;
                }
                action(CancelApprovalRequest)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Cancel Approval Re&quest';
                    //Enabled = OpenApprovalEntriesExist;
                    Image = CancelApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Category5;
                    ToolTip = 'Cancel the approval request.';

                    trigger OnAction()
                    var
                        WorkflowEvent: Codeunit "Custom Workflow";
                    begin
                        WorkflowEvent.OnCancelItemIssueNewApprovalRequest(Rec);
                    end;
                }
                action(ApprovalEntries)
                {
                    AccessByPermission = TableData "Approval Entry" = R;
                    ApplicationArea = Basic, Suite;
                    Caption = 'Approvals';
                    Image = Approvals;
                    Promoted = true;
                    PromotedCategory = Category5;
                    ToolTip = 'View a list of the records that are waiting to be approved. For example, you can see who requested the record to be approved, when it was sent, and when it is due to be approved.';

                    trigger OnAction()
                    begin
                        ApprovalsMgmt.OpenApprovalEntriesPage(Rec.RecordId);
                    end;
                }
                //SSD Sunil
                group("&Indent")
                {
                    Caption = '&Indent';

                    action(Dimensions)
                    {
                        ApplicationArea = All;
                        Caption = 'Dimensions';
                        Image = Dimensions;
                        RunObject = Page "Dim. Allowed Values per Acc.";
                        Visible = false;
                    }
                }
                group("F&unction")
                {
                    Caption = 'F&unction';

                    action(Release)
                    {
                        ApplicationArea = All;
                        Caption = 'Re&lease';
                        Image = ReleaseDoc;
                        ShortCutKey = 'Ctrl+F9';

                        trigger OnAction()
                        begin
                            /*
                                AdditionalApprovers.RESET;
                                AdditionalApprovers.SETRANGE(AdditionalApprovers."Approval Code",'PUR-INDENT');
                                AdditionalApprovers.SETRANGE(AdditionalApprovers."Approver ID",USERID);
                                IF NOT AdditionalApprovers.FINDFIRST THEN
                                  ReleaseIndent()
                                ELSE
                                  ERROR('You cannot release this document as Additional approvers exists for Indent');
                                */
                            //SSDU_Sunil
                            /*
                                if UserSetup.Get(UserId) and (UserSetup."Indent Approval") then begin
                                    if ((UserId = 'ZDI\VCHHABRA') and (Rec."Shortcut Dimension 1 Code" = '24000')) or ((UserId = 'SGARG') and (Rec."Shortcut Dimension 1 Code" = '21000')) or
                                    ((UserId = 'SGARG') and (Rec."Shortcut Dimension 1 Code" = '22000')) or ((UserId = 'SGARG') and (Rec."Shortcut Dimension 1 Code" = '23000')) or
                                    ((UserId = 'SGARG') and (Rec."Shortcut Dimension 1 Code" = '25000')) or
                                    ((UserId = 'ZDI\JFERNANDES') and (Rec."Shortcut Dimension 1 Code" = '35900')) or
                                    ((UserId = 'ZDI\RGUPTA') and (Rec."Shortcut Dimension 1 Code" = '36900')) or
                                    ((UserId = 'BBAINS') and (Rec."Shortcut Dimension 1 Code" = '34500')) or
                                    ((UserId = 'ZDI\SSYED') and (Rec."Shortcut Dimension 1 Code" = '34400')) or
                                    ((UserId = 'NKMISHRA') and (Rec."Shortcut Dimension 1 Code" = '51000')) or
                                    ((UserId = 'LMOHAN') and (Rec."Shortcut Dimension 1 Code" = '80000')) or
                                    ((UserId = 'ZDI\RSINGH') and (Rec."Shortcut Dimension 1 Code" = '71000')) or
                                    ((UserId = 'ZDI\RSINGH') and (Rec."Shortcut Dimension 1 Code" = '72000')) then
                                        ReleaseIndent()
                                    else
                                        Error('You are not authorized');
                                end
                                else
                                    Error('You are not authorized');
                                    */
                            //SSD Sunil
                            //SSDU Comment
                            // if CurrPage.LookupMode then
                            //     if Confirm('Do you want to Continue ?', false) then
                            //         if (Rec.Status = Rec.Status::Open) or (Rec."Send Approval" = false) then begin
                            //             UserSetup.Get(UserId);
                            //             //EmailId := UserSetup."E-Mail";
                            //             //EmailId := 'rakumar@alletec.com';
                            //             EmailId := 'lmohan@zavenir.com;vchhabra@zavenir.com;gurgaon.scm@zavenir.com';
                            //             SMTPMailSetup.Get;
                            //             SMTPMailSetup.TestField("SMTP Server");
                            //             SMTPMailSetup.TestField("User ID");
                            //             SMTPMailSetup.TestField(Password);
                            //             SMTPMail.CreateMessage('Zavenir Indent Process', SMTPMailSetup."User ID", EmailId, 'Indent Details', '', true);
                            //             SMTPMail.AppendBody('Dear Sir or Madam,<br><br>');
                            //             //SMTPMail.AppendBody('Please find the attached Indent detail.<br><br></font>');
                            //             SMTPMail.AppendBody('Issue Slip ' + Rec."No." + ' has been Approved.<br><br>');
                            //             SMTPMail.AppendBody('Thanks & Regards,<br>');
                            //             SMTPMail.AppendBody('ZD Team,<br>');
                            //             SMTPMail.Send;
                            //         end;
                            //SSDU Comment End
                        end;
                    }
                    action(Reopen)
                    {
                        ApplicationArea = All;
                        Caption = 'Re&open';
                        Image = ReOpen;

                        trigger OnAction()
                        begin
                            ReopenIndent();
                        end;
                    }
                    // action("Send &Approval Request")
                    // {
                    //     ApplicationArea = All;
                    //     Caption = 'Send &Approval Request';
                    //     Image = SendApprovalRequest;
                    //     Promoted = true;
                    //     PromotedCategory = New;
                    //     trigger OnAction()
                    //     var
                    //         ApprovalMgt: Codeunit "Approvals Mgmt.";
                    //     begin
                    //         //5.51
                    //         if Rec.Status = Rec.Status::Released then
                    //             Error('Only open indent can send for Approval');
                    //         if not (Rec.IndentLineExist) then
                    //             Error('Indent Line does not exist for indent no %1', Rec."No.");
                    //         CheckIndent; // Alle
                    //         //5.51
                    //         //  IF "Indenter ID" <> USERID THEN
                    //         //   ERROR('You can not send approval request because indenter ID is different.');
                    //         //  AdditionalApprovers.RESET;
                    //         //  AdditionalApprovers.SETRANGE(AdditionalApprovers."Approval Code",'PUR-INDENT');
                    //         //  AdditionalApprovers.SETRANGE(AdditionalApprovers."Approver ID",USERID);
                    //         //  IF NOT AdditionalApprovers.FINDFIRST THEN
                    //         //   ERROR('There is no Additional approvers exists for Indent')
                    //         //  ELSE BEGIN
                    //         rec."Send Approval" := false; //SSD_Sunil Using workflow
                    //         rec.Approved := true;
                    //         rec.Status := rec.Status::Released;
                    //         rec.MODIFY;
                    //         //  END;
                    //         //SSD_Sunil_Using workflow
                    //         /*
                    //                                 CostcenCode := '*' + Rec."Shortcut Dimension 1 Code";
                    //                                 UserSetup1.Reset;
                    //                                 UserSetup1.SetRange("User ID", UserId);
                    //                                 //UserSetup1.SETFILTER("Indent Costcen Code",CostcenCode);
                    //                                 if UserSetup1.FindFirst then begin
                    //                                     UserSetup1.TestField("Issue Slip Approver Mail Id");
                    //                                     UserSetup1.TestField("Approver ID Issue Slip");
                    //                                     Rec."Approval ID" := UserSetup1."Approver ID Issue Slip"; // UserSetup1."Approver ID";
                    //                                     Rec."Send for Approval" := true;
                    //                                     Rec.Status := Rec.Status::"Pending for Approval";
                    //                                     Rec.Modify;
                    //                                 end else
                    //                                     CostcenCode := Rec."Shortcut Dimension 1 Code" + '*';
                    //                                 UserSetup1.Reset;
                    //                                 UserSetup1.SetRange("User ID", UserId);
                    //                                 if UserSetup1.FindFirst then begin
                    //                                     UserSetup1.TestField("Issue Slip Approver Mail Id");
                    //                                     UserSetup1.TestField("Approver ID Issue Slip");
                    //                                     Rec."Approval ID" := UserSetup1."Approver ID Issue Slip"; //UserSetup1."Approver ID";
                    //                                     Rec."Send for Approval" := true;
                    //                                     Rec.Status := Rec.Status::"Pending for Approval";
                    //                                     Rec.Modify;
                    //                                 end;
                    //         */
                    //         // UserSetup1.Reset;
                    //         // if UserSetup1.Get(UserId) then begin
                    //         //     Rec."Sender ID" := UserSetup1."User ID";
                    //         //     Rec.Modify;
                    //         // end;
                    //         //SSDU Comment
                    //         // if CurrPage.LookupMode then
                    //         //     if Confirm('Do you want to Continue ?', false) then
                    //         //         if (Rec.Status = Rec.Status::Open) or (Rec."Send for Approval" = false) then begin
                    //         //             UserSetup.Get(UserId);
                    //         //             //EmailId := UserSetup."E-Mail";
                    //         //             //EmailId := 'rakumar@alletec.com';
                    //         //             EmailId := UserSetup1."Issue Slip Approver Mail Id" + 'lmohan@zavenir.com;vchhabra@zavenir.com;gurgaon.scm@zavenir.com;akumar@zavenir.com';
                    //         //             SMTPMailSetup.Get;
                    //         //             SMTPMailSetup.TestField("SMTP Server");
                    //         //             SMTPMailSetup.TestField("User ID");
                    //         //             SMTPMailSetup.TestField(Password);
                    //         //             SMTPMail.CreateMessage('Zavenir Issue Slip Process', SMTPMailSetup."User ID", EmailId, 'Issue Slip Details', '', true);
                    //         //             SMTPMail.AppendBody('Dear Sir or Madam,<br><br>');
                    //         //             //SMTPMail.AppendBody('Please find the attached Indent detail.<br><br></font>');
                    //         //             SMTPMail.AppendBody('Issue Slip No.' + Rec."No." + 'has been sent for further Approval');
                    //         //             SMTPMail.Send;
                    //         //         end;
                    //         //SSDU Comment
                    //     end;
                    // }
                    // action("Cancel Approval Request")
                    // {
                    //     ApplicationArea = All;
                    //     Image = Cancel;
                    //     trigger OnAction()
                    //     begin
                    //         if Rec."Indenter ID" <> UserId then
                    //             Error('You can not cancel approval request because indenter ID is different.');
                    //         if Rec.Status = Rec.Status::"Pending for Approval" then begin
                    //             Rec."Sender ID" := '';
                    //             Rec."Approval ID" := '';
                    //             Rec."Send for Approval" := false;
                    //             Rec.Validate(Status, Rec.Status::Open);
                    //             Rec.Modify;
                    //         end else
                    //             Error('Status must be Sent for Approval');
                    //     end;
                    // }
                    // action("&View Pending for Approval Indent")
                    // {
                    //     ApplicationArea = All;
                    //     Caption = '&View Pending for Approval Indent';
                    //     Image = Indent;
                    //     trigger OnAction()
                    //     var
                    //         IndentHeader1: Record "SSD Indent Header";
                    //         FrmIndentList: Page "Indent List-Pending For Appr.";
                    //     begin
                    //         IndentHeader1.Reset;
                    //         IndentHeader1.SetRange(IndentHeader1."Send Approval", true);
                    //         FrmIndentList.SetTableview(IndentHeader1);
                    //         FrmIndentList.SetRecord(IndentHeader1);
                    //         FrmIndentList.RunModal;
                    //     end;
                    // }
                    //SSD Sunil
                    //SSD Sunil
                }
            }
        }
        area(processing)
        {
            group("P&osting")
            {
                Caption = 'P&osting';

                action(Post)
                {
                    ApplicationArea = All;
                    Caption = 'P&ost';
                    Image = Post;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ShortCutKey = 'F9';

                    trigger OnAction()
                    var
                        Post2: Report "Indent Post";
                        ItemJournalLinePost: Record "Item Journal Line";
                        IndentLineNew: Record "SSD Indent Line2";
                        IndentLineCount: Integer;
                        ItemJnlLineCount: Integer;
                    begin
                        if not Rec.Post then begin
                            if Rec.Approved then begin

                                // Count Indent Lines with Issued Qty > 0
                                IndentLineNew.Reset();
                                IndentLineNew.SetRange("Document No.", Rec."No.");
                                IndentLineNew.SetFilter("Issued Qty", '>%1', 0);
                                if IndentLineNew.FindFirst() then
                                    IndentLineCount := IndentLineNew.Count()
                                else
                                    Error('No issued quantity found for indent lines.');

                                // Check Item Journal Lines
                                ItemJournalLinePost.Reset();
                                ItemJournalLinePost.SetRange("Journal Template Name", 'ISSUE');
                                ItemJournalLinePost.SetRange("Journal Batch Name", 'ISSUESLIP');
                                ItemJournalLinePost.SetRange("Document No.", Rec."No.");
                                if not ItemJournalLinePost.FindFirst() then
                                    Error('Please insert item journal line for document no. %1', Rec."No.");

                                ItemJnlLineCount := ItemJournalLinePost.Count();

                                if IndentLineCount <> ItemJnlLineCount then
                                    Error(
                                        'Indent line count (%1) and Item Journal line count (%2) mismatch.',
                                        IndentLineCount, ItemJnlLineCount);

                                // Proceed to post
                                Post2.IndentPost2(Rec);
                                Clear(Post2);

                            end else
                                Error('Please approve the indent before posting.');

                        end else
                            Error('Issue Slip no. %1 is already posted.', Rec."No.");
                    end;
                }

                action("Assign Item Tracking")
                {
                    ApplicationArea = All;
                    Image = ItemTracing;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;

                    trigger OnAction()
                    var
                        IndentLineNew: Record "SSD Indent Line2";
                        ItemJournalLinePost: Record "Item Journal Line";
                    begin
                        if not Rec.Post then begin
                            if Rec.Approved then begin

                                // Clear existing item journal lines for the document
                                ItemJournalLinePost.Reset();
                                ItemJournalLinePost.SetRange("Journal Template Name", 'ISSUE');
                                ItemJournalLinePost.SetRange("Journal Batch Name", 'ISSUESLIP');
                                ItemJournalLinePost.SetRange("Document No.", Rec."No.");
                                if ItemJournalLinePost.FindFirst() then
                                    ItemJournalLinePost.DeleteAll();

                                // Insert new item journal lines from indent lines
                                IndentLineNew.Reset();
                                IndentLineNew.SetRange("Document No.", Rec."No.");
                                if IndentLineNew.FindFirst() then
                                    repeat
                                        if IndentLineNew."Issued Qty" > 0 then
                                            InsertNPostItemJnlLineNeg2IG(Rec, IndentLineNew);
                                    until IndentLineNew.Next() = 0;

                                // Open item journal page to review created lines
                                ItemJournalLinePost.Reset();
                                ItemJournalLinePost.SetRange("Journal Template Name", 'ISSUE');
                                ItemJournalLinePost.SetRange("Journal Batch Name", 'ISSUESLIP');
                                ItemJournalLinePost.SetRange("Document No.", Rec."No.");
                                if ItemJournalLinePost.FindFirst() then
                                    Page.Run(Page::"Item Journal", ItemJournalLinePost);

                            end else
                                Error('Please approve the indent before assigning.');

                        end else
                            Error('Issue Slip no. %1 is already posted.', Rec."No.");
                    end;
                }

            }
            action(Print)
            {
                ApplicationArea = All;
                Caption = 'P&rint';
                Image = Print;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                var
                    IndHdrLocal: Record "SSD Indent Header2";
                    IndentLine2: Record "SSD Indent Line2";
                begin
                    //TESTFIELD(Status,Status :: Released);
                    //CurrPage.SETSELECTIONFILTER(IndHdrLocal);
                    IndentLine2.SetRange("Document No.", Rec."No.");
                    IndentLine2.FindFirst;
                    Report.RunModal(50276, true, false, IndentLine2);
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
                RunPageView = sorting("Document Type", "No.", "Line No.") order(ascending) where("Document Type" = const(4));
                ToolTip = 'Comment';
                Visible = false;
            }
        }
    }
    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec."Responsibility Center" := UserMgt.GetRespCenterFilter;
    end;

    trigger OnOpenPage()
    var
        UserSetup: Record "User Setup";
    begin
        CurrPage.LookupMode := true;
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
        SetCancelVisible();
    end;

    var
        Req: Code[10];
        Text001: label 'There is nothing to release for Issue Slip No. %1';
        IndentHeader: Record "SSD Indent Header";
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
        IndentHeader3: Record "SSD Indent Header";
        CostcenCode: Code[50];
        OpenApprovalEntriesExistCurrUser: Boolean;
        OpenApprovalEntriesExist: Boolean;
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        CanCancelApprovalForRecord: Boolean;
        CanCancelApprovalForFlow: Boolean;
        CanRequestApprovalForFlow: Boolean;
        WorkflowWebhookMgt: Codeunit "Workflow Webhook Management";
        CancelVisible: Boolean;
        SendVisible: Boolean;

    trigger OnAfterGetCurrRecord()
    begin
        OpenApprovalEntriesExistCurrUser := ApprovalsMgmt.HasOpenApprovalEntriesForCurrentUser(Rec.RecordId);
        OpenApprovalEntriesExist := ApprovalsMgmt.HasApprovalEntries(Rec.RecordId);
        //CanCancelApprovalForRecord := ApprovalsMgmt.CanCancelApprovalForRecord(Rec.RecordId());
        ////WorkflowWebhookMgt.GetCanRequestAndCanCancel(Rec.RecordId(), CanRequestApprovalForFlow, CanCancelApprovalForFlow);
        //SetCancelVisible();
    end;

    local procedure InsertNPostItemJnlLineNeg2IG(var SSDIndent: Record "SSD Indent Header2"; var IndentLine: Record "SSD Indent Line2")
    var
        ItemJournalLineXrec: Record "Item Journal Line";
        ItemJournalLine: Record "Item Journal Line";
        LineNo: Integer;
    begin
        // Initialize line number
        LineNo := 10000;

        ItemJournalLineXrec.Reset();
        ItemJournalLineXrec.SetRange("Journal Template Name", 'ISSUE');
        ItemJournalLineXrec.SetRange("Journal Batch Name", 'ISSUESLIP');
        if ItemJournalLineXrec.FindLast() then
            LineNo := ItemJournalLineXrec."Line No." + 10000;

        ItemJournalLine.Init();
        ItemJournalLine.Validate("Journal Template Name", 'ISSUE');
        ItemJournalLine.Validate("Journal Batch Name", 'ISSUESLIP');
        ItemJournalLine.Validate("Line No.", LineNo);
        ItemJournalLine.Validate("Posting Date", SSDIndent."Posting Date");

        ItemJournalLine.Validate("Entry Type", ItemJournalLine."Entry Type"::"Negative Adjmt.");
        ItemJournalLine.Validate("Item No.", IndentLine."No.");
        ItemJournalLine.Validate("Description 2", IndentLine."Description 2");
        ItemJournalLine.Validate("Document No.", IndentLine."Document No.");
        ItemJournalLine.Validate("Document Line No.", IndentLine."Line No.");
        ItemJournalLine.Validate("Location Code", IndentLine."Location Code");
        ItemJournalLine.Validate("Shortcut Dimension 1 Code", IndentLine."Shortcut Dimension 1 Code");
        ItemJournalLine.Validate("Shortcut Dimension 2 Code", IndentLine."Shortcut Dimension 2 Code");
        ItemJournalLine.Validate(Quantity, IndentLine."Issued Qty");
        ItemJournalLine.Validate("Unit of Measure Code", IndentLine."Unit Of Measure Code");

        ItemJournalLine.Insert(true);
    end;

    local procedure SetCancelVisible()
    begin
        // if Rec.Status = Rec.Status::Open then begin
        //     SendVisible := true;
        //     CancelVisible := false;
        // end else
        //     if (Rec.Status = Rec.Status::"Pending for Approval") then begin
        //         SendVisible := false;
        //         CancelVisible := true;
        //     end else
        //         if (Rec.Status = Rec.Status::Released) then begin
        //             SendVisible := true;
        //             CancelVisible := false;
        //         end;
    end;

    procedure ReleaseIndent()
    var
        IndentLine: Record "SSD Indent Line";
    begin
        Rec.TestField(Status, Rec.Status::Open); // Alle;
        CheckIndent; // Alle
        Rec.Status := Rec.Status::Released;
        Rec.Modify;
    end;

    procedure ReopenIndent()
    begin
        rec.TESTFIELD(Status, rec.Status::Released); // Alle;
        Rec.Status := Rec.Status::Open;
        Rec.Modify;
    end;

    procedure UpdateLineWithShortDimcode(RecIndentHeader: Record "SSD Indent Header2")
    var
        IndentLineLocal: Record "SSD Indent Line";
    begin
        IndentLineLocal.Reset;
        IndentLineLocal.SetRange("Document No.", RecIndentHeader."No.");
        if IndentLineLocal.Find('-') then
            repeat
                IndentLineLocal."Shortcut Dimension 1 Code" := RecIndentHeader."Shortcut Dimension 1 Code";
                IndentLineLocal."Shortcut Dimension 2 Code" := RecIndentHeader."Shortcut Dimension 2 Code";
                IndentLineLocal.Modify;
            until IndentLineLocal.Next = 0;
    end;

    procedure CheckIndent()
    var
        IndentLine: Record "SSD Indent Line2";
    begin
        Rec.TestField("No.");
        Rec.TestField("Due Date");
        if Rec."Due Date" < Rec."Indent Date" then Error('Check the due Date in Header');
        Rec.TestField("Indent Date");
        Rec.TestField("Posting Date");
        Rec.TestField("Shortcut Dimension 1 Code");
        //TESTFIELD("Shortcut Dimension 2 Code");
        IndentLine.SetRange("Document No.", Rec."No.");
        if IndentLine.Find('-') then
            repeat
                if IndentLine."Due Date" < Rec."Indent Date" then Error('Check the due Date in Line No. %1', IndentLine."Line No.");
                IndentLine.TestField("No.");
                IndentLine.TestField(Quantity);
                IndentLine.TestField("Due Date");
                if IndentLine.Type = IndentLine.Type::Item then begin
                    //sandeep singla begin
                    //IndentLine.TestField(IndentLine."Product Group Code"); //SSD_Sunil
                    IndentLine.TestField(IndentLine."Gen.Prod.Posting Group");
                    //sandeep singla end
                end;
                IndentLine.TestField("Shortcut Dimension 1 Code");
                //IndentLine.TESTFIELD("Shortcut Dimension 2 Code");
                if IndentLine.Type = IndentLine.Type::Item then begin
                    IndentLine.TestField("Qty. per Unit Of Measure");
                    IndentLine.TestField("Unit Of Measure Code");
                end;
                IndentLine.TestField("Quantity (Base)");
                IndentLine.TestField("Indent Date");
            until IndentLine.Next = 0
        else
            Error(Text001, Rec."No.");
    end;
}
