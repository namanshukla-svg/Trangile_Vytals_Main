Page 50059 "RGP List"
{
    Editable = false;
    PageType = List;
    SourceTable = "SSD RGP Header";
    ApplicationArea = All;

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
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = All;
                }
                field("Receipt Date"; Rec."Receipt Date")
                {
                    ApplicationArea = All;
                }
                field("Advising Department"; Rec."Advising Department")
                {
                    ApplicationArea = All;
                }
                field("Advising Employee"; Rec."Advising Employee")
                {
                    ApplicationArea = All;
                }
                field("Party Name"; Rec."Party Name")
                {
                    ApplicationArea = All;
                }
                field("Party Type"; Rec."Party Type")
                {
                    ApplicationArea = All;
                }
                field("Party No."; Rec."Party No.")
                {
                    ApplicationArea = All;
                }
                field("Delivery Mode"; Rec."Delivery Mode")
                {
                    ApplicationArea = All;
                }
                field("Vehical No."; Rec."Vehical No.")
                {
                    ApplicationArea = All;
                }
                field("Transporter No."; Rec."Transporter No.")
                {
                    ApplicationArea = All;
                }
                field("Bearer Name"; Rec."Bearer Name")
                {
                    ApplicationArea = All;
                }
                field("Bearer Department"; Rec."Bearer Department")
                {
                    ApplicationArea = All;
                }
                field("Purpose Code"; Rec."Purpose Code")
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
                field("Document Type"; Rec."Document Type")
                {
                    ApplicationArea = All;
                }
                field("External Document No."; Rec."External Document No.")
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
            group(RGP)
            {
                Caption = '&RGP';

                action(Card)
                {
                    ApplicationArea = All;
                    Caption = 'Card';
                    Image = EditLines;
                    ShortCutKey = 'Shift+F7';

                    trigger OnAction()
                    begin
                        case Rec."Document Type" of Rec."document type"::"RGP Outbound": begin
                            if Rec.NRGP then Page.Run(Page::"NRGP outbound", Rec)
                            else
                                Page.Run(Page::"RGP outbound", Rec);
                        end;
                        Rec."document type"::"RGP Inbound": begin
                            begin
                                if Rec.NRGP then Page.Run(Page::"RGP Inbound", Rec)
                                else
                                    Page.Run(Page::"RGP Inbound", Rec);
                            end;
                        end;
                        end;
                    end;
                }
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
                    action(Comment)
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
                        Enabled = NOT OpenApprovalEntriesExist;
                        Image = SendApprovalRequest;
                        Promoted = true;
                        PromotedCategory = Category5;
                        PromotedIsBig = true;
                        ToolTip = 'Request approval to change the record.';

                        trigger OnAction()
                        var
                            WorkflowEvent: Codeunit "Custom Workflow";
                        begin
                            if WorkflowEvent.CheckRGPHeaderApprovalsWorkflowEnabled(Rec)then WorkflowEvent.OnSendRGPHeaderForApproval(Rec);
                        end;
                    }
                    action(CancelApprovalRequest)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Cancel Approval Re&quest';
                        Enabled = OpenApprovalEntriesExist;
                        Image = CancelApprovalRequest;
                        Promoted = true;
                        PromotedCategory = Category5;
                        ToolTip = 'Cancel the approval request.';

                        trigger OnAction()
                        var
                            WorkflowEvent: Codeunit "Custom Workflow";
                        begin
                            WorkflowEvent.OnCancelRGPHeaderApprovalRequest(Rec);
                        end;
                    }
                    action(ApprovalEntries)
                    {
                        AccessByPermission = TableData "Approval Entry"=R;
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
                }
            }
        }
    }
    trigger OnOpenPage()
    begin
    //CF001 St
    // if UserMgt.GetRespCenterFilter <> '' then begin
    //     Rec.FilterGroup(2);
    //     Rec.SetRange("Responsibility Center", UserMgt.GetRespCenterFilter);
    //     Rec.FilterGroup(0);
    // end;
    //CF001 En
    end;
    trigger OnAfterGetCurrRecord()
    begin
        OpenApprovalEntriesExistCurrUser:=ApprovalsMgmt.HasOpenApprovalEntriesForCurrentUser(Rec.RECORDID);
        OpenApprovalEntriesExist:=ApprovalsMgmt.HasOpenApprovalEntries(Rec.RECORDID);
    end;
    var UserMgt: Codeunit "SSD User Setup Management";
    OpenApprovalEntriesExistCurrUser: Boolean;
    OpenApprovalEntriesExist: Boolean;
    ApprovalsMgmt: Codeunit "Approvals Mgmt.";
}
