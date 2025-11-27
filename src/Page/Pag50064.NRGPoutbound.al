Page 50064 "NRGP outbound"
{
    PageType = Document;
    RefreshOnActivate = true;
    SourceTable = "SSD RGP Header";
    SourceTableView = sorting(NRGP) order(ascending) where(NRGP = const(true), "Document Type" = filter("RGP Outbound"));
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

                    trigger OnAssistEdit()
                    begin
                        if Rec.AssistEdit(xRec) then CurrPage.Update;
                    end;
                }
                field("Party Type"; Rec."Party Type")
                {
                    ApplicationArea = All;
                }
                field("Party No."; Rec."Party No.")
                {
                    ApplicationArea = All;
                }
                field("Party Name"; Rec."Party Name")
                {
                    ApplicationArea = All;
                }
                field("Party Address"; Rec."Party Address")
                {
                    ApplicationArea = All;
                }
                field("Party Address 2"; Rec."Party Address 2")
                {
                    ApplicationArea = All;
                }
                field("Party PostCode"; Rec."Party PostCode")
                {
                    ApplicationArea = All;
                    Caption = 'Party PostCode / City';
                }
                field("Party City"; Rec."Party City")
                {
                    ApplicationArea = All;
                }
                field("Party State"; Rec."Party State")
                {
                    ApplicationArea = All;
                }
                field("Location Code"; Rec."Location Code")
                {
                    ApplicationArea = All;
                }
                field(Remark2; Rec.Remark2)
                {
                    ApplicationArea = All;
                    Caption = 'Note';
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = All;
                }
                field("Document Date"; Rec."Document Date")
                {
                    ApplicationArea = All;
                }
                field("Gate Out"; Rec."Gate Out")
                {
                    ApplicationArea = all;
                    LookupPageId = 18618;
                    DrillDownPageId = 18618;
                    Visible = false;
                }
                field("External Document No."; Rec."External Document No.")
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
                field("Purpose Code"; Rec."Purpose Code")
                {
                    ApplicationArea = All;
                }
                field("Purpose Description"; Rec."Purpose Description")
                {
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("NRGP Send to Approval"; Rec."NRGP Send to Approval")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("NRGP Approved"; Rec."NRGP Approved")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("NRGP Sender ID"; Rec."NRGP Sender ID")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
            }
            part(RGPLines; "NRGP outbound Subform")
            {
                SubPageLink = "Document No." = field("No.");
                ApplicationArea = all;
            }
            group(Shipment)
            {
                Caption = 'Shipment';

                field("Shipment Date"; Rec."Shipment Date")
                {
                    ApplicationArea = All;
                }
                field("Advising Employee"; Rec."Advising Employee")
                {
                    ApplicationArea = All;
                }
                field("Advising Department"; Rec."Advising Department")
                {
                    ApplicationArea = All;
                }
                field("Ship Remarks"; Rec."Ship Remarks")
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
                field("Posted RGP Inbound"; Rec."Posted RGP Inbound")
                {
                    ApplicationArea = All;
                }
                field("Delivery Mode"; Rec."Delivery Mode")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        DeliveryModeOnAfterValidate;
                    end;
                }
                field("Vehical No."; Rec."Vehical No.")
                {
                    ApplicationArea = All;
                    Editable = "Vehical No.Editable";
                }
                field("Transporter No."; Rec."Transporter No.")
                {
                    ApplicationArea = All;
                    Editable = "Transporter No.Editable";
                }
                field("Transporter Name"; Rec."Transporter Name")
                {
                    ApplicationArea = All;
                    Editable = "Transporter NameEditable";
                }
                field("LR No."; Rec."LR No.")
                {
                    ApplicationArea = All;
                    Editable = "LR No.Editable";
                }
                field("GR No."; Rec."GR No.")
                {
                    ApplicationArea = All;
                    Editable = "GR No.Editable";
                }
                field("Posted Shpmt. No Series"; Rec."Posted Shpmt. No Series")
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
            group("&RGP Outbound")
            {
                Caption = '&RGP Outbound';

                action("Ledger Entries")
                {
                    ApplicationArea = All;
                    Caption = 'Ledger Entries';
                    RunObject = Page "RGP Ledger Entries";
                    RunPageLink = "Document Type" = field("Document Type"), "RGP Document No." = field("No.");
                    RunPageView = sorting("Document Type", "RGP Document No.", "RGP Line No.") order(ascending);
                }
                action(Shipments)
                {
                    ApplicationArea = All;
                    Caption = 'Shipments';
                    RunObject = Page "Posted RGP Shipment List";
                    RunPageLink = "Pre-Assigned No." = field("No.");
                }
            }
            group("&Line")
            {
                Caption = '&Line';

                action("Ledger Entries2")
                {
                    ApplicationArea = All;
                    Caption = 'Ledger Entries';

                    trigger OnAction()
                    begin
                        ShowRGPLedger;
                    end;
                }
            }
        }
        area(processing)
        {
            group("F&unctions")
            {
                Caption = 'F&unctions';

                separator(Action1000000022)
                {
                }
                action("Re&lease")
                {
                    ApplicationArea = All;
                    Caption = 'Re&lease';
                    Image = ReleaseDoc;
                    ShortCutKey = 'Ctrl+F9';

                    trigger OnAction()
                    begin
                        //if Rec.Approved then
                        rec."NRGP Approved" := true;
                        Rec."NRGP Approval ID" := UserId;
                        Rec.Release; //SSD Sunil Using workflow
                                     // else
                                     //     Error('You can not release the document');
                    end;
                }
                action("Re&open")
                {
                    ApplicationArea = All;
                    Caption = 'Re&open';
                    Image = ReOpen;

                    trigger OnAction()
                    var
                        ReleaseSalesDoc: Codeunit "Release Sales Document";
                    begin
                        Rec.Reopen;
                    end;
                }
                // action(SendApprovalRequest)
                // {
                //     ApplicationArea = All;
                //     Image = SendApprovalRequest;
                //     Promoted = true;
                //     PromotedCategory = New;
                //     trigger OnAction()
                //     begin
                //         if Rec.Status = Rec.Status::Open then begin
                //             if UserSetup1.Get(UserId) then
                //                 if UserSetup1."NRGP Send For Approval" then begin
                //                     CurrPage.SetSelectionFilter(RGPHeader);
                //                     if RGPHeader.FindSet then begin
                //                         Rec.ModifyAll(Status, Rec.Status::"Pending for Approval");
                //                         RGPHeader.ModifyAll("NRGP Send to Approval", true);
                //                         RGPHeader.ModifyAll("NRGP Sender ID", UserId);
                //                     end;
                //                 end else
                //                     Error('You are not authorised for sending approval');
                //             Clear(RGPHeader);
                //         end else
                //             Error('Please open the document');
                //     end;
                // }
                //SSD Sunil
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
                            if WorkflowEvent.CheckRGPHeaderApprovalsWorkflowEnabled(Rec) then WorkflowEvent.OnSendRGPHeaderForApproval(Rec);
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
                }
                group("P&osting")
                {
                    Caption = 'P&osting';

                    action("P&ost")
                    {
                        ApplicationArea = All;
                        Caption = 'P&ost';
                        Ellipsis = true;
                        Image = Post;
                        Promoted = true;
                        PromotedCategory = Process;
                        PromotedIsBig = true;
                        ShortCutKey = 'F9';

                        trigger OnAction()
                        begin
                            if Rec."NRGP Approved" then begin
                                Clear(RGPShipPost);
                                RGPShipPost.PostRGP(Rec);
                            end
                            else
                                Error('Please Approve NRGP before posting');
                        end;
                    }
                }
                action(Print)
                {
                    ApplicationArea = All;
                    Caption = '&Print';
                    Ellipsis = true;
                    Image = Print;
                    Promoted = true;
                    PromotedCategory = Process;
                    Visible = false;

                    trigger OnAction()
                    begin
                        Rec.SetRecfilter;
                        //SSDU Report.Run(Report::"Non-Returnable Gate Pass", true, false, Rec);
                        //REPORT.RUN(REPORT::"G/L Test Sandeep",TRUE,FALSE,Rec);
                        Rec.Reset;
                    end;
                }
            }
        }
    }
    trigger OnAfterGetRecord()
    begin
        case Rec."Delivery Mode" of
            Rec."delivery mode"::"Own Vehical":
                begin
                    "Vehical No.Editable" := true;
                    "Transporter No.Editable" := false;
                    "Transporter NameEditable" := false;
                    "LR No.Editable" := false;
                    "GR No.Editable" := false;
                end;
            Rec."delivery mode"::Transporter:
                begin
                    "Vehical No.Editable" := false;
                    "Transporter No.Editable" := true;
                    "Transporter NameEditable" := true;
                    "LR No.Editable" := true;
                    "GR No.Editable" := true;
                end;
            Rec."delivery mode"::"By Hand Party":
                begin
                    "Vehical No.Editable" := false;
                    "Transporter No.Editable" := false;
                    "Transporter NameEditable" := false;
                    "LR No.Editable" := false;
                    "GR No.Editable" := false;
                end;
        end;
        Rec.SetRange("No.");
    end;

    trigger OnInit()
    begin
        "GR No.Editable" := true;
        "LR No.Editable" := true;
        "Transporter NameEditable" := true;
        "Transporter No.Editable" := true;
        "Vehical No.Editable" := true;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        //>>MUA01
        if UserSetup.Get(UserId) then Rec."Responsibility Center" := UserSetup."Responsibility Center";
        //<<MUA01
        Rec.NRGP := true;
    end;

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

    var
        RGPShipPost: Report "RGP Post";
        UserSetup: Record "User Setup";
        UserMgt: Codeunit "SSD User Setup Management";
        "Vehical No.Editable": Boolean;
        "Transporter No.Editable": Boolean;
        "Transporter NameEditable": Boolean;
        "LR No.Editable": Boolean;
        "GR No.Editable": Boolean;
        UserSetup1: Record "User Setup";
        RGPHeader: Record "SSD RGP Header";
        OpenApprovalEntriesExistCurrUser: Boolean;
        OpenApprovalEntriesExist: Boolean;
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";

    trigger OnAfterGetCurrRecord()
    begin
        OpenApprovalEntriesExistCurrUser := ApprovalsMgmt.HasOpenApprovalEntriesForCurrentUser(Rec.RECORDID);
        OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(Rec.RECORDID);
    end;

    procedure ShowRGPLedger()
    begin
        CurrPage.RGPLines.Page.ShowRGPLedger;
    end;

    local procedure DeliveryModeOnAfterValidate()
    begin
        case Rec."Delivery Mode" of
            Rec."delivery mode"::"Own Vehical":
                begin
                    "Vehical No.Editable" := true;
                    "Transporter No.Editable" := false;
                    "Transporter NameEditable" := false;
                    "LR No.Editable" := false;
                    "GR No.Editable" := false;
                end;
            Rec."delivery mode"::Transporter:
                begin
                    "Vehical No.Editable" := false;
                    "Transporter No.Editable" := true;
                    "Transporter NameEditable" := true;
                    "LR No.Editable" := true;
                    "GR No.Editable" := true;
                end;
            Rec."delivery mode"::"By Hand Party":
                begin
                    "Vehical No.Editable" := false;
                    "Transporter No.Editable" := false;
                    "Transporter NameEditable" := false;
                    "LR No.Editable" := false;
                    "GR No.Editable" := false;
                end;
        end;
    end;
}
