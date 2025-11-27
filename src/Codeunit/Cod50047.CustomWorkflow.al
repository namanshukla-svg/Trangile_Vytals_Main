codeunit 50047 "Custom Workflow"
{
    SingleInstance = true;

    //EventSubscriberInstance = Manual;
    trigger OnRun()
    begin
    end;
    //RGP Header
    [IntegrationEvent(false, false)]
    procedure OnSendRGPHeaderForApproval(var SSDRGPHeader: Record "SSD RGP Header");
    begin
    end;
    [IntegrationEvent(false, false)]
    procedure OnCancelRGPHeaderApprovalRequest(var SSDRGPHeader: Record "SSD RGP Header")
    begin
    end;
    procedure CheckRGPHeaderApprovalsWorkflowEnabled(var SSDRGPHeader: Record "SSD RGP Header"): Boolean begin
        IF NOT WorkflowManagement.CanExecuteWorkflow(SSDRGPHeader, RunWorkflowOnSendRGPHeaderForApprovalCode())THEN ERROR(NoWorkflowEnabledErr);
        EXIT(TRUE);
    end;
    procedure RunWorkflowOnSendRGPHeaderForApprovalCode(): Code[128]begin
        EXIT(UPPERCASE('RunWorkflowOnSendRGPHeaderForApproval'));
    end;
    procedure RunWorkflowOnCancelRGPHeaderApprovalRequestCode(): Code[128]begin
        EXIT(UPPERCASE('RunWorkflowOnCancelRGPHeaderApprovalRequest'));
    end;
    [EventSubscriber(ObjectType::Codeunit, codeunit::"Custom Workflow", 'OnSendRGPHeaderForApproval', '', false, false)]
    procedure RunWorkflowOnSendRGPHeaderForApproval(VAR SSDRGPHeader: Record "SSD RGP Header")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnSendRGPHeaderForApprovalCode, SSDRGPHeader);
    end;
    [EventSubscriber(ObjectType::Codeunit, codeunit::"Custom Workflow", 'OnCancelRGPHeaderApprovalRequest', '', false, false)]
    procedure RunWorkflowOnCancelRGPHeaderApprovalRequest(VAR SSDRGPHeader: Record "SSD RGP Header");
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnCancelRGPHeaderApprovalRequestCode, SSDRGPHeader);
    end;
    //RGP Header
    //Item Issue
    [IntegrationEvent(false, false)]
    procedure OnSendItemIssueNewForApproval(var SSDIndentHeader2: Record "SSD Indent Header2");
    begin
    end;
    [IntegrationEvent(false, false)]
    procedure OnCancelItemIssueNewApprovalRequest(var SSDIndentHeader2: Record "SSD Indent Header2")
    begin
    end;
    procedure CheckItemIssueNewApprovalsWorkflowEnabled(var SSDIndentHeader2: Record "SSD Indent Header2"): Boolean begin
        IF NOT WorkflowManagement.CanExecuteWorkflow(SSDIndentHeader2, RunWorkflowOnSendItemIssueNewForApprovalCode())THEN ERROR(NoWorkflowEnabledErr);
        EXIT(TRUE);
    end;
    procedure RunWorkflowOnSendItemIssueNewForApprovalCode(): Code[128]begin
        EXIT(UPPERCASE('RunWorkflowOnSendItemIssueNewForApproval'));
    end;
    procedure RunWorkflowOnCancelItemIssueNewApprovalRequestCode(): Code[128]begin
        EXIT(UPPERCASE('RunWorkflowOnCancelItemIssueNewApprovalRequest'));
    end;
    [EventSubscriber(ObjectType::Codeunit, codeunit::"Custom Workflow", 'OnSendItemIssueNewForApproval', '', false, false)]
    procedure RunWorkflowOnSendItemIssueNewForApproval(VAR SSDIndentHeader2: Record "SSD Indent Header2")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnSendItemIssueNewForApprovalCode, SSDIndentHeader2);
    end;
    [EventSubscriber(ObjectType::Codeunit, codeunit::"Custom Workflow", 'OnCancelItemIssueNewApprovalRequest', '', false, false)]
    procedure RunWorkflowOnCancelItemIssueNewApprovalRequest(VAR SSDIndentHeader2: Record "SSD Indent Header2");
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnCancelItemIssueNewApprovalRequestCode, SSDIndentHeader2);
    end;
    //Item Issue
    [EventSubscriber(ObjectType::Codeunit, codeunit::"Approvals Mgmt.", 'OnSetStatusToPendingApproval', '', false, false)]
    procedure SetStatusToPendingApproval(var Variant: Variant; var IsHandled: Boolean);
    var
        SSDRGPHeader: Record "SSD RGP Header";
        SSDIndentHeader2: Record "SSD Indent Header2";
        RecRef: RecordRef;
    begin
        RecRef.GetTable(Variant);
        case RecRef.Number of //RGP Header
        DATABASE::"SSD RGP Header": BEGIN
            RecRef.SETTABLE(SSDRGPHeader);
            SSDRGPHeader.Status:=SSDRGPHeader.Status::"Pending for Approval";
            if SSDRGPHeader.NRGP then begin
                SSDRGPHeader."NRGP Send to Approval":=true;
                SSDRGPHeader."NRGP Sender ID":=UserId;
            end;
            SSDRGPHeader.MODIFY();
            Variant:=SSDRGPHeader;
            IsHandled:=true;
        END;
        //RGP Header
        //Item Issue
        DATABASE::"SSD Indent Header2": BEGIN
            RecRef.SETTABLE(SSDIndentHeader2);
            SSDIndentHeader2.Status:=SSDIndentHeader2.Status::"Pending for Approval";
            SSDIndentHeader2.MODIFY();
            Variant:=SSDIndentHeader2;
            IsHandled:=true;
        END;
        //Item Issue
        end end;
    //Item isssue
    [EventSubscriber(ObjectType::Codeunit, 1520, 'OnAddWorkflowEventsToLibrary', '', false, false)]
    procedure CreateEventsLibrary();
    begin
        //RGP Header
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnSendRGPHeaderForApprovalCode, DATABASE::"SSD RGP Header", RGPHeaderSendForApprovalEventDescTxt, 0, FALSE);
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnCancelRGPHeaderApprovalRequestCode, DATABASE::"SSD RGP Header", RGPHeaderApprovalRequestCancelEventDescTxt, 0, FALSE);
        //RGP Header
        //Item Issue
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnSendItemIssueNewForApprovalCode, DATABASE::"SSD Indent Header2", ItemIssueNewSendForApprovalEventDescTxt, 0, FALSE);
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnCancelItemIssueNewApprovalRequestCode, DATABASE::"SSD Indent Header2", ItemIssueNewApprovalRequestCancelEventDescTxt, 0, FALSE);
    //Item Issue
    end;
    //WorkFlow Response Handing 1521
    [EventSubscriber(ObjectType::Codeunit, codeunit::"Workflow Response Handling", 'OnAddWorkflowResponsePredecessorsToLibrary', '', false, false)]
    Local procedure AddResponsePredecessors(ResponseFunctionName: Code[128]);
    begin
        CASE ResponseFunctionName OF WorkFlowResponseHanding.CreateApprovalRequestsCode(): begin
            WorkFlowResponseHanding.AddResponsePredecessor(WorkFlowResponseHanding.CreateApprovalRequestsCode, RunWorkflowOnSendRGPHeaderForApprovalCode);
            WorkFlowResponseHanding.AddResponsePredecessor(WorkFlowResponseHanding.CreateApprovalRequestsCode, RunWorkflowOnSendItemIssueNewForApprovalCode);
        end;
        WorkFlowResponseHanding.SendApprovalRequestForApprovalCode(): begin
            WorkFlowResponseHanding.AddResponsePredecessor(WorkFlowResponseHanding.SendApprovalRequestForApprovalCode, RunWorkflowOnSendRGPHeaderForApprovalCode);
            WorkFlowResponseHanding.AddResponsePredecessor(WorkFlowResponseHanding.SendApprovalRequestForApprovalCode, RunWorkflowOnSendItemIssueNewForApprovalCode);
        end;
        WorkFlowResponseHanding.OpenDocumentCode(): begin
            WorkFlowResponseHanding.AddResponsePredecessor(WorkFlowResponseHanding.OpenDocumentCode, RunWorkflowOnCancelRGPHeaderApprovalRequestCode);
            WorkFlowResponseHanding.AddResponsePredecessor(WorkFlowResponseHanding.OpenDocumentCode, RunWorkflowOnCancelItemIssueNewApprovalRequestCode);
        end;
        WorkFlowResponseHanding.CancelAllApprovalRequestsCode(): begin
            WorkFlowResponseHanding.AddResponsePredecessor(WorkFlowResponseHanding.CancelAllApprovalRequestsCode, RunWorkflowOnCancelRGPHeaderApprovalRequestCode);
            WorkFlowResponseHanding.AddResponsePredecessor(WorkFlowResponseHanding.CancelAllApprovalRequestsCode, RunWorkflowOnCancelItemIssueNewApprovalRequestCode);
        end;
        end;
    end;
    [EventSubscriber(ObjectType::Codeunit, codeunit::"Workflow Response Handling", 'OnBeforeReleaseDocument', '', false, false)]
    local procedure ReleaseDocument(var Variant: Variant);
    var
        SSDRGPHeader: Record "SSD RGP Header";
        SSDRGPHeader2: Record "SSD RGP Header";
        SSDIndentHeader2: Record "SSD Indent Header2";
        SSDIndentHeader22: Record "SSD Indent Header2";
        RecRef: RecordRef;
    begin
        RecRef.GetTable(Variant);
        case RecRef.Number of DATABASE::"SSD RGP Header": BEGIN
            RecRef.SETTABLE(SSDRGPHeader);
            SSDRGPHeader:=Variant;
            SSDRGPHeader2.Get(SSDRGPHeader."Document Type", SSDRGPHeader."No.");
            SSDRGPHeader2.Status:=SSDRGPHeader.Status::Released;
            SSDRGPHeader2."Approval ID":=UserId;
            SSDRGPHeader2.Approved:=true;
            if SSDRGPHeader2.NRGP then SSDRGPHeader2."NRGP Approved":=true;
            SSDRGPHeader2.MODIFY;
        END;
        DATABASE::"SSD Indent Header2": BEGIN
            RecRef.SETTABLE(SSDIndentHeader2);
            SSDIndentHeader2:=Variant;
            SSDIndentHeader22.Get(SSDIndentHeader2."No.");
            SSDIndentHeader22.Status:=SSDIndentHeader2.Status::Released;
            SSDIndentHeader22."Approval ID":=UserId;
            SSDIndentHeader22.Approved:=true;
            SSDIndentHeader22.MODIFY;
        END;
        end end;
    [EventSubscriber(ObjectType::Codeunit, codeunit::"Workflow Response Handling", 'OnReleaseDocument', '', false, false)]
    procedure OnReleaseDocument(RecRef: RecordRef; Var Handled: Boolean);
    begin
        case RecRef.Number of DATABASE::"SSD RGP Header": Handled:=true;
        DATABASE::"SSD Indent Header2": Handled:=true;
        end;
    end;
    [EventSubscriber(ObjectType::Codeunit, codeunit::"Workflow Response Handling", 'OnOpenDocument', '', false, false)]
    procedure OnOpenDocument(RecRef: RecordRef; Var Handled: Boolean);
    var
        SSDRGPHeader: Record "SSD RGP Header";
        SSDRGPHeader2: Record "SSD RGP Header";
        SSDIndentHeader2: Record "SSD Indent Header2";
        SSDIndentHeader22: Record "SSD Indent Header2";
    begin
        case RecRef.Number of DATABASE::"SSD RGP Header": BEGIN
            RecRef.SETTABLE(SSDRGPHeader);
            SSDRGPHeader2.Get(SSDRGPHeader."Document Type", SSDRGPHeader."No.");
            SSDRGPHeader2.Status:=SSDRGPHeader.Status::Open;
            SSDRGPHeader2.MODIFY();
            Handled:=true;
        END;
        DATABASE::"SSD Indent Header2": BEGIN
            RecRef.SETTABLE(SSDIndentHeader2);
            SSDIndentHeader22.Get(SSDIndentHeader2."No.");
            SSDIndentHeader22.Status:=SSDIndentHeader2.Status::Open;
            SSDIndentHeader22.MODIFY();
            Handled:=true;
        END;
        end end;
    var WorkflowManagement: Codeunit "Workflow Management";
    WorkflowEventHandling: Codeunit "Workflow Event Handling";
    WorkFlowResponseHanding: Codeunit "Workflow Response Handling";
    NoWorkflowEnabledErr: Label 'No approvals workflow for this record type is enabled.';
    RGPHeaderSendForApprovalEventDescTxt: Label 'Approval of a RGP Header is requested.';
    RGPHeaderApprovalRequestCancelEventDescTxt: Label 'An approval request for a RGP Header is canceled.';
    ItemIssueNewSendForApprovalEventDescTxt: Label 'Approval of a Item Issue New is requested.';
    ItemIssueNewApprovalRequestCancelEventDescTxt: Label 'An approval request for a Item Issue New is canceled.';
}
