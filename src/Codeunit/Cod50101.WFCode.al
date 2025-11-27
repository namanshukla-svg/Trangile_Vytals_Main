codeunit 50101 WFCode
{
    trigger OnRun()
    begin
    end;
    var WFMngt: Codeunit "Workflow Management";
    AppMgmt: Codeunit "Approvals Mgmt.";
    WorkflowEventHandling: Codeunit "Workflow Event Handling";
    WorkflowResponseHandling: Codeunit "Workflow Response Handling";
    //Indent Approval
    SendIndentDocumentReq: TextConst ENU = 'Approval Request for Indent Document is requested', ENG = 'Approval Request for Indent Document is requested';
    CancelIndentDocumentReq: TextConst ENU = 'Approval Request for Indent Document is Canceled', ENG = 'Approval Request for Indent Document is Canceled';
    AppReqIndentDocument: TextConst ENU = 'Approval Request for Indent Document is approved', ENG = 'Approval Request for Indent Document is approved';
    RejReqIndentDocument: TextConst ENU = 'Approval Request for Indent Document is rejected', ENG = 'Approval Request for Indent Document is rejected';
    DelReqIndentDocument: TextConst ENU = 'Approval Request for Indent Document is delegated', ENG = 'Approval Request for Indent Document is delegated';
    SendForPendAppTxt: TextConst ENU = 'Status of Indent Document changed to Pending approval', ENG = 'Status of Indent Document changed to Pending approval';
    ReleaseIndentDocumentTxt: TextConst ENU = 'Release Indent Document', ENG = 'Release Indent Document';
    ReOpenIndentDocumentTxt: TextConst ENU = 'ReOpen Indent Document', ENG = 'ReOpen Indent Document';
    CancelIndentDocumentTxt: TextConst ENU = 'Cancel Indent Document', ENG = 'Cancel Indent Document';
    //Indent Approval
    //Item issue
    // SendItemIssueDocReq: TextConst ENU = 'Approval Request for Item Issue Doc is requested', ENG = 'Approval Request for Item Issue Doc is requested';
    // CancelItemIssueDocReq: TextConst ENU = 'Approval Request for Item Issue Doc is Canceled', ENG = 'Approval Request for Item Issue Doc is Canceled';
    // AppReqItemIssueDoc: TextConst ENU = 'Approval Request for Item Issue Doc is approved', ENG = 'Approval Request for Item Issue Doc is approved';
    // RejReqItemIssueDoc: TextConst ENU = 'Approval Request for Item Issue Doc is rejected', ENG = 'Approval Request for Item Issue Doc is rejected';
    // DelReqItemIssueDoc: TextConst ENU = 'Approval Request for Item Issue Doc is delegated', ENG = 'Approval Request for Item Issue Doc is delegated';
    // SendForPendAppItemIssueDocTxt: TextConst ENU = 'Status of Item Issue Doc changed to Pending approval', ENG = 'Status of Item Issue Doc changed to Pending approval';
    // ReleaseItemIssueDocTxt: TextConst ENU = 'Release Item Issue Doc', ENG = 'Release Item Issue Doc';
    // ReOpenItemIssueDocTxt: TextConst ENU = 'ReOpen Item Issue Doc', ENG = 'ReOpen Item Issue Doc';
    // CancelItemIssueDocTxt: TextConst ENU = 'Cancel Item Issue Doc', ENG = 'Cancel Item Issue Doc';
    //Item Issue
    //Indent
    procedure RunWorkflowOnSendIndentDocumentApprovalCode(): Code[128]begin
        exit(UpperCase('RunWorkflowOnSendIndentDocumentApproval'))end;
    procedure RunWorkflowOnCancelIndentDocumentApprovalCode(): Code[128]begin
        exit(UpperCase('RunWorkflowOnCancelIndentDocumentApproval'))end;
    [EventSubscriber(ObjectType::Codeunit, Codeunit::WFCode, 'OnSendIndentDocumentforApproval', '', false, false)]
    procedure RunWorkflowOnSendIndentDocumentApproval(var SSDIndentHeader: Record "SSD Indent Header")
    begin
        WFMngt.HandleEvent(RunWorkflowOnSendIndentDocumentApprovalCode(), SSDIndentHeader);
    end;
    [EventSubscriber(ObjectType::Codeunit, Codeunit::WFCode, 'OnCancelIndentDocumentforApproval', '', false, false)]
    procedure RunWorkflowOnCancelIndentDocumentApproval(var SSDIndentHeader: Record "SSD Indent Header")
    begin
        WFMngt.HandleEvent(RunWorkflowOnCancelIndentDocumentApprovalCode(), SSDIndentHeader);
    end;
    procedure RunWorkflowOnApproveIndentDocumentApprovalCode(): Code[128]begin
        exit(UpperCase('RunWorkflowOnApproveIndentDocumentApproval'))end;
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnApproveApprovalRequest', '', false, false)]
    procedure RunWorkflowOnApproveIndentDocumentApproval(var ApprovalEntry: Record "Approval Entry")
    begin
        WFMngt.HandleEventOnKnownWorkflowInstance(RunWorkflowOnApproveIndentDocumentApprovalCode(), ApprovalEntry, ApprovalEntry."Workflow Step Instance ID");
    end;
    procedure RunWorkflowOnRejectIndentDocumentApprovalCode(): Code[128]begin
        exit(UpperCase('RunWorkflowOnRejectIndentDocumentApproval'))end;
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnRejectApprovalRequest', '', false, false)]
    procedure RunWorkflowOnRejectIndentDocumentApproval(var ApprovalEntry: Record "Approval Entry")
    begin
        WFMngt.HandleEventOnKnownWorkflowInstance(RunWorkflowOnRejectIndentDocumentApprovalCode(), ApprovalEntry, ApprovalEntry."Workflow Step Instance ID");
    end;
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnCancelApprovalRequestsForRecordOnAfterSetApprovalEntryFilters', '', false, false)]
    local procedure OnCancelApprovalRequestsForRecordOnAfterSetApprovalEntryFilters(var ApprovalEntry: Record "Approval Entry"; RecRef: RecordRef)
    begin
    end;
    procedure RunWorkflowOnDelegateIndentDocumentApprovalCode(): Code[128]begin
        exit(UpperCase('RunWorkflowOnDelegateIndentDocumentApproval'))end;
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnDelegateApprovalRequest', '', false, false)]
    procedure RunWorkflowOnDelegateIndentDocumentApproval(var ApprovalEntry: Record "Approval Entry")
    begin
        WFMngt.HandleEventOnKnownWorkflowInstance(RunWorkflowOnDelegateIndentDocumentApprovalCode(), ApprovalEntry, ApprovalEntry."Workflow Step Instance ID");
    end;
    procedure SetStatusToPendingApprovalCodeIndentDocument(): Code[128]begin
        exit(UpperCase('SetStatusToPendingApprovalIndentDocument'));
    end;
    procedure SetStatusToPendingApprovalIndentDocument(var Variant: Variant)
    var
        RecRef: RecordRef;
        SSDIndentHeader: Record "SSD Indent Header";
    begin
        RecRef.GetTable(Variant);
        case RecRef.Number()of DATABASE::"SSD Indent Header": begin
            RecRef.SetTable(SSDIndentHeader);
            SSDIndentHeader.Validate(Status, SSDIndentHeader.Status::"Pending for Approval");
            SSDIndentHeader.Modify();
            Variant:=SSDIndentHeader;
        end;
        end;
    end;
    procedure ReleaseIndentDocumentCode(): Code[128]begin
        exit(UpperCase('ReleaseIndentDocument'));
    end;
    procedure ReleaseIndentDocument(var Variant: Variant)
    var
        RecRef: RecordRef;
        TargetRecRef: RecordRef;
        ApprovalEntry: Record "Approval Entry";
        SSDIndentHeader: Record "SSD Indent Header";
    begin
        RecRef.GetTable(Variant);
        case RecRef.Number()of DATABASE::"Approval Entry": begin
            ApprovalEntry:=Variant;
            TargetRecRef.Get(ApprovalEntry."Record ID to Approve");
            Variant:=TargetRecRef;
            ReleaseIndentDocument(Variant);
        end;
        DATABASE::"SSD Indent Header": begin
            RecRef.SetTable(SSDIndentHeader);
            SSDIndentHeader.Validate(Status, SSDIndentHeader.Status::Released);
            SSDIndentHeader.Approved:=true;
            SSDIndentHeader."Approval ID":=UserId;
            SSDIndentHeader.Modify();
            Variant:=SSDIndentHeader;
        end;
        end;
    end;
    procedure ReOpenIndentDocumentCode(): Code[128]begin
        exit(UpperCase('ReOpenIndentDocument'));
    end;
    procedure ReOpenIndentDocument(var Variant: Variant)
    var
        RecRef: RecordRef;
        TargetRecRef: RecordRef;
        ApprovalEntry: Record "Approval Entry";
        SSDIndentHeader: Record "SSD Indent Header";
        SSDIndentHeader2: Record "SSD Indent Header";
    begin
        RecRef.GetTable(Variant);
        case RecRef.Number()of DATABASE::"Approval Entry": begin
            ApprovalEntry:=Variant;
            TargetRecRef.Get(ApprovalEntry."Record ID to Approve");
            Variant:=TargetRecRef;
            ReOpenIndentDocument(Variant);
        end;
        DATABASE::"SSD Indent Header": begin
            RecRef.SetTable(SSDIndentHeader);
            SSDIndentHeader2.Get(SSDIndentHeader."No.");
            SSDIndentHeader2.Validate(Status, SSDIndentHeader.Status::Open);
            SSDIndentHeader2.Modify();
            Variant:=SSDIndentHeader2;
        end;
        end;
    end;
    procedure CancelIndentDocumentCode(): Code[128]begin
        exit(UpperCase('CancelIndentDocument'));
    end;
    procedure CancelIndentDocument(var Variant: Variant)
    var
        RecRef: RecordRef;
        TargetRecRef: RecordRef;
        ApprovalEntry: Record "Approval Entry";
        SSDIndentHeader: Record "SSD Indent Header";
        SSDIndentHeader2: Record "SSD Indent Header";
    begin
        RecRef.GetTable(Variant);
        case RecRef.Number()of DATABASE::"Approval Entry": begin
            ApprovalEntry:=Variant;
            //ApprovalEntry.Status := ApprovalEntry.Status::Canceled;
            //ApprovalEntry.Modify();
            TargetRecRef.Get(ApprovalEntry."Record ID to Approve");
            Variant:=TargetRecRef;
            CancelIndentDocument(Variant);
        end;
        DATABASE::"SSD Indent Header": begin
            RecRef.SetTable(SSDIndentHeader);
            SSDIndentHeader2.Get(SSDIndentHeader."No.");
            SSDIndentHeader2.Validate(Status, SSDIndentHeader.Status::Open);
            SSDIndentHeader2.Modify();
            Variant:=SSDIndentHeader2;
        end;
        end;
    end;
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Event Handling", 'OnAddWorkflowEventsToLibrary', '', false, false)]
    procedure AddIndentDocumentEventToLibrary()
    begin
        //Indent
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnSendIndentDocumentApprovalCode(), Database::"SSD Indent Header", SendIndentDocumentReq, 0, false);
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnCancelIndentDocumentApprovalCode(), Database::"SSD Indent Header", CancelIndentDocumentReq, 0, false);
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnApproveIndentDocumentApprovalCode(), Database::"Approval Entry", AppReqIndentDocument, 0, false);
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnRejectIndentDocumentApprovalCode(), Database::"Approval Entry", RejReqIndentDocument, 0, false);
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnDelegateIndentDocumentApprovalCode(), Database::"Approval Entry", DelReqIndentDocument, 0, false);
    //Indent
    //Item Issue
    // WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnSendItemIssueDocApprovalCode(), Database::"SSD Indent Header2", SendItemIssueDocReq, 0, false);
    // WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnCancelItemIssueDocApprovalCode(), Database::"SSD Indent Header2", CancelItemIssueDocReq, 0, false);
    // WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnApproveItemIssueDocApprovalCode(), Database::"Approval Entry", AppReqItemIssueDoc, 0, false);
    // WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnRejectItemIssueDocApprovalCode(), Database::"Approval Entry", RejReqItemIssueDoc, 0, false);
    // WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnDelegateItemIssueDocApprovalCode(), Database::"Approval Entry", DelReqItemIssueDoc, 0, false);
    //Item Issue
    end;
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Response Handling", 'OnAddWorkflowResponsesToLibrary', '', false, false)]
    procedure AddIndentDocumentRespToLibrary()
    begin
        //Indent
        WorkflowResponseHandling.AddResponseToLibrary(SetStatusToPendingApprovalCodeIndentDocument(), 0, SendForPendAppTxt, 'GROUP 0');
        WorkflowResponseHandling.AddResponseToLibrary(ReleaseIndentDocumentCode(), 0, ReleaseIndentDocumentTxt, 'GROUP 0');
        WorkflowResponseHandling.AddResponseToLibrary(ReOpenIndentDocumentCode(), 0, ReOpenIndentDocumentTxt, 'GROUP 0');
        WorkflowResponseHandling.AddResponseToLibrary(CancelIndentDocumentCode(), 0, CancelIndentDocumentTxt, 'GROUP 0');
    //Indent
    //Item Issue
    // WorkflowResponseHandling.AddResponseToLibrary(SetStatusToPendingApprovalCodeItemissueDoc(), 0, SendForPendAppItemIssueDocTxt, 'GROUP 0');
    // WorkflowResponseHandling.AddResponseToLibrary(ReleaseItemissueDocCode(), 0, ReleaseItemissueDocTxt, 'GROUP 0');
    // WorkflowResponseHandling.AddResponseToLibrary(ReOpenItemissueDocCode(), 0, ReOpenItemissueDocTxt, 'GROUP 0');
    // WorkflowResponseHandling.AddResponseToLibrary(CancelItemissueDocCode(), 0, CancelItemissueDocTxt, 'GROUP 0');
    //item issue
    end;
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Response Handling", 'OnExecuteWorkflowResponse', '', false, false)]
    procedure ExeRespForIndentDocument(var ResponseExecuted: Boolean; Variant: Variant; xVariant: Variant; ResponseWorkflowStepInstance: Record "Workflow Step Instance")
    var
        WorkflowResponse: Record "Workflow Response";
    begin
        IF WorkflowResponse.GET(ResponseWorkflowStepInstance."Function Name")THEN case WorkflowResponse."Function Name" of SetStatusToPendingApprovalCodeIndentDocument(): begin
                SetStatusToPendingApprovalIndentDocument(Variant);
                ResponseExecuted:=true;
            end;
            ReleaseIndentDocumentCode(): begin
                ReleaseIndentDocument(Variant);
                ResponseExecuted:=true;
            end;
            ReOpenIndentDocumentCode(): begin
                ReOpenIndentDocument(Variant);
                ResponseExecuted:=true;
            end;
            CancelIndentDocumentCode(): begin
                CancelIndentDocument(Variant);
                ResponseExecuted:=true;
            end;
            end;
    end;
    [IntegrationEvent(false, false)]
    PROCEDURE OnSendIndentDocumentforApproval(VAR SSDIndentHeader: Record "SSD Indent Header");
    begin
    end;
    [IntegrationEvent(false, false)]
    PROCEDURE OnCancelIndentDocumentforApproval(VAR SSDIndentHeader: Record "SSD Indent Header");
    begin
    end;
    procedure IsIndentDocumentEnabled(var SSDIndentHeader: Record "SSD Indent Header"): Boolean var
        WFMngt: Codeunit "Workflow Management";
        WFCode: Codeunit WFCode;
    begin
        exit(WFMngt.CanExecuteWorkflow(SSDIndentHeader, WFCode.RunWorkflowOnSendIndentDocumentApprovalCode()))end;
    procedure CheckWorkflowEnabled(): Boolean var
        SSDIndentHeader: Record "SSD Indent Header";
        NoWorkflowEnb: TextConst ENU = 'No workflow Enabled for this Record type', ENG = 'No workflow Enabled for this Record type';
    begin
        if not IsIndentDocumentEnabled(SSDIndentHeader)then Error(NoWorkflowEnb);
    end;
    //Indent
    //ItemIssue
    // procedure RunWorkflowOnSendItemIssueDocApprovalCode(): Code[128]
    // begin
    //     exit(UpperCase('RunWorkflowOnSendItemIssueDocApproval'))
    // end;
    // procedure RunWorkflowOnCancelItemIssueDocApprovalCode(): Code[128]
    // begin
    //     exit(UpperCase('RunWorkflowOnCancelItemIssueDocApproval'))
    // end;
    // [EventSubscriber(ObjectType::Codeunit, Codeunit::WFCode, 'OnSendItemIssueDocforApproval', '', false, false)]
    // procedure RunWorkflowOnSendItemIssueDocApproval(var SSDIndentheader: Record "SSD Indent Header2")
    // begin
    //     WFMngt.HandleEvent(RunWorkflowOnSendItemIssueDocApprovalCode(), SSDIndentHeader);
    // end;
    // [EventSubscriber(ObjectType::Codeunit, Codeunit::WFCode, 'OnCancelItemIssueDocforApproval', '', false, false)]
    // procedure RunWorkflowOnCancelItemIssueDocApproval(var SSDIndentHeader: Record "SSD Indent Header2")
    // begin
    //     WFMngt.HandleEvent(RunWorkflowOnCancelItemIssueDocApprovalCode(), SSDIndentHeader);
    // end;
    // procedure RunWorkflowOnApproveItemIssueDocApprovalCode(): Code[128]
    // begin
    //     exit(UpperCase('RunWorkflowOnApproveItemIssueDocApproval'))
    // end;
    // [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnApproveApprovalRequest', '', false, false)]
    // procedure RunWorkflowOnApproveItemIssueDocApproval(var ApprovalEntry: Record "Approval Entry")
    // begin
    //     WFMngt.HandleEventOnKnownWorkflowInstance(RunWorkflowOnApproveItemIssueDocApprovalCode(), ApprovalEntry, ApprovalEntry."Workflow Step Instance ID");
    // end;
    // procedure RunWorkflowOnRejectItemIssueDocApprovalCode(): Code[128]
    // begin
    //     exit(UpperCase('RunWorkflowOnRejectItemIssueDocApproval'))
    // end;
    // [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnRejectApprovalRequest', '', false, false)]
    // procedure RunWorkflowOnRejectItemIssueDocApproval(var ApprovalEntry: Record "Approval Entry")
    // begin
    //     WFMngt.HandleEventOnKnownWorkflowInstance(RunWorkflowOnRejectItemIssueDocApprovalCode(), ApprovalEntry, ApprovalEntry."Workflow Step Instance ID");
    // end;
    // // [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnCancelApprovalRequestsForRecordOnAfterSetApprovalEntryFilters', '', false, false)]
    // // local procedure OnCancelApprovalRequestsForRecordOnAfterSetApprovalEntryFilters(var ApprovalEntry: Record "Approval Entry"; RecRef: RecordRef)
    // // begin
    // // end;
    // procedure RunWorkflowOnDelegateItemIssueDocApprovalCode(): Code[128]
    // begin
    //     exit(UpperCase('RunWorkflowOnDelegateItemIssueDocApproval'))
    // end;
    // [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnDelegateApprovalRequest', '', false, false)]
    // procedure RunWorkflowOnDelegateItemIssueDocApproval(var ApprovalEntry: Record "Approval Entry")
    // begin
    //     WFMngt.HandleEventOnKnownWorkflowInstance(RunWorkflowOnDelegateItemIssueDocApprovalCode(), ApprovalEntry, ApprovalEntry."Workflow Step Instance ID");
    // end;
    // procedure SetStatusToPendingApprovalCodeItemIssueDoc(): Code[128]
    // begin
    //     exit(UpperCase('SetStatusToPendingApprovalItemIssueDoc'));
    // end;
    // procedure SetStatusToPendingApprovalItemIssueDoc(var Variant: Variant)
    // var
    //     RecRef: RecordRef;
    //     SSDIndentHeader: Record "SSD Indent Header2";
    // begin
    //     RecRef.GetTable(Variant);
    //     case RecRef.Number() of
    //         DATABASE::"SSD Indent Header2":
    //             begin
    //                 RecRef.SetTable(SSDIndentHeader);
    //                 SSDIndentHeader.Validate(Status, SSDIndentHeader.Status::"Pending for Approval");
    //                 SSDIndentHeader.Modify();
    //                 Variant := SSDIndentHeader;
    //             end;
    //     end;
    // end;
    // procedure ReleaseItemIssueDocCode(): Code[128]
    // begin
    //     exit(UpperCase('ReleaseItemIssueDoc'));
    // end;
    // procedure ReleaseItemIssueDoc(var Variant: Variant)
    // var
    //     RecRef: RecordRef;
    //     TargetRecRef: RecordRef;
    //     ApprovalEntry: Record "Approval Entry";
    //     SSDIndentHeader: Record "SSD Indent Header2";
    // begin
    //     RecRef.GetTable(Variant);
    //     case RecRef.Number() of
    //         DATABASE::"Approval Entry":
    //             begin
    //                 ApprovalEntry := Variant;
    //                 TargetRecRef.Get(ApprovalEntry."Record ID to Approve");
    //                 Variant := TargetRecRef;
    //                 ReleaseItemIssueDoc(Variant);
    //             end;
    //         DATABASE::"SSD Indent Header2":
    //             begin
    //                 RecRef.SetTable(SSDIndentHeader);
    //                 SSDIndentHeader.Validate(Status, SSDIndentHeader.Status::Released);
    //                 SSDIndentHeader.Modify();
    //                 Variant := SSDIndentHeader;
    //             end;
    //     end;
    // end;
    // procedure ReOpenItemIssueDocCode(): Code[128]
    // begin
    //     exit(UpperCase('ReOpenItemIssueDoc'));
    // end;
    // procedure ReOpenItemIssueDoc(var Variant: Variant)
    // var
    //     RecRef: RecordRef;
    //     TargetRecRef: RecordRef;
    //     ApprovalEntry: Record "Approval Entry";
    //     SSDIndentHeader: Record "SSD Indent Header2";
    // begin
    //     RecRef.GetTable(Variant);
    //     case RecRef.Number() of
    //         DATABASE::"Approval Entry":
    //             begin
    //                 ApprovalEntry := Variant;
    //                 TargetRecRef.Get(ApprovalEntry."Record ID to Approve");
    //                 Variant := TargetRecRef;
    //                 ReOpenIndentDocument(Variant);
    //             end;
    //         DATABASE::"SSD Indent Header2":
    //             begin
    //                 RecRef.SetTable(SSDIndentHeader);
    //                 SSDIndentHeader.Validate(Status, SSDIndentHeader.Status::Open);
    //                 SSDIndentHeader.Modify();
    //                 Variant := SSDIndentHeader;
    //             end;
    //     end;
    // end;
    // procedure CancelItemIssueDocCode(): Code[128]
    // begin
    //     exit(UpperCase('CancelItemIssueDoc'));
    // end;
    // procedure CancelItemIssueDoc(var Variant: Variant)
    // var
    //     RecRef: RecordRef;
    //     TargetRecRef: RecordRef;
    //     ApprovalEntry: Record "Approval Entry";
    //     SSDIndentHeader3: Record "SSD Indent Header2";
    //     SSDIndentHeader4: Record "SSD Indent Header2";
    // begin
    //     RecRef.GetTable(Variant);
    //     case RecRef.Number() of
    //         DATABASE::"Approval Entry":
    //             begin
    //                 ApprovalEntry := Variant;
    //                 TargetRecRef.Get(ApprovalEntry."Record ID to Approve");
    //                 Variant := TargetRecRef;
    //                 CancelItemIssueDoc(Variant);
    //             end;
    //         // DATABASE::"SSD Indent Header2":
    //         //     begin
    //         //         RecRef.SetTable(SSDIndentHeader3);
    //         //         SSDIndentHeader4.Get(SSDIndentHeader3."No.");
    //         //         SSDIndentHeader4.Validate(Status, SSDIndentHeader3.Status::Open);
    //         //         SSDIndentHeader4.Modify;
    //         //         Variant := SSDIndentHeader4;
    //         //     end;
    //     end;
    // end;
    // [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Response Handling", 'OnExecuteWorkflowResponse', '', false, false)]
    // procedure ExeRespForItemIssueDoc(var ResponseExecuted: Boolean; Variant: Variant; xVariant: Variant; ResponseWorkflowStepInstance: Record "Workflow Step Instance")
    // var
    //     WorkflowResponse: Record "Workflow Response";
    // begin
    //     IF WorkflowResponse.GET(ResponseWorkflowStepInstance."Function Name") THEN
    //         case WorkflowResponse."Function Name" of
    //             SetStatusToPendingApprovalCodeItemIssueDoc():
    //                 begin
    //                     SetStatusToPendingApprovalItemIssueDoc(Variant);
    //                     ResponseExecuted := true;
    //                 end;
    //             ReleaseItemIssueDocCode():
    //                 begin
    //                     ReleaseItemIssueDoc(Variant);
    //                     ResponseExecuted := true;
    //                 end;
    //             ReOpenItemIssueDocCode():
    //                 begin
    //                     ReOpenItemIssueDoc(Variant);
    //                     ResponseExecuted := true;
    //                 end;
    //             CancelItemIssueDocCode():
    //                 begin
    //                     CancelItemIssueDoc(Variant);
    //                     ResponseExecuted := true;
    //                 end;
    //         end;
    // end;
    // [IntegrationEvent(false, false)]
    // PROCEDURE OnSendItemIssueDocforApproval(VAR SSDIndentHeader: Record "SSD Indent Header2");
    // begin
    // end;
    // [IntegrationEvent(false, false)]
    // PROCEDURE OnCancelItemIssueDocforApproval(VAR SSDIndentHeader: Record "SSD Indent Header2");
    // begin
    // end;
    // procedure IsItemIssueDocEnabled(var SSDIndentHeader: Record "SSD Indent Header2"): Boolean
    // var
    //     WFMngt: Codeunit "Workflow Management";
    //     WFCode: Codeunit WFCode;
    // begin
    //     exit(WFMngt.CanExecuteWorkflow(SSDIndentHeader, WFCode.RunWorkflowOnSendItemIssueDocApprovalCode()))
    // end;
    // //ItemIssue
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Response Handling", 'OnReleaseDocument', '', false, false)]
    local procedure OnReleaseDocument(RecRef: RecordRef; var Handled: Boolean)
    var
        VendorRec: Record Vendor;
        CustomerRec: Record Customer;
        ItemRec: Record Item;
        TargetRecRef: RecordRef;
    begin
        case RecRef.Number of DATABASE::Vendor: begin
            RecRef.SetTable(VendorRec);
            if VendorRec."MSME Registerd" then begin
                VendorRec.TestField("MSME Category");
                VendorRec.TestField("MSME Activity");
                VendorRec.TestField("MSME Classification Year");
                VendorRec.TestField("Udhyam Registration Number");
            end;
            VendorRec."First Release":=true;
            VendorRec.Validate(Blocked, VendorRec.Blocked::" ");
            VendorRec.Modify();
            Handled:=true;
        end;
        end;
        case RecRef.Number of DATABASE::Customer: begin
            RecRef.SetTable(CustomerRec);
            CustomerRec."First Release":=true;
            CustomerRec.Validate(Blocked, CustomerRec.Blocked::" ");
            CustomerRec.Modify();
            Handled:=true;
        end;
        end;
        case RecRef.Number of DATABASE::Item: begin
            RecRef.SetTable(ItemRec);
            ItemRec.Validate(Blocked, false);
            ItemRec.Modify();
            Handled:=true;
        end;
        end;
    end;
    [EventSubscriber(ObjectType::Page, Page::"Vendor Card", 'OnBeforeActionEvent', 'SendApprovalRequest', false, false)]
    procedure OnSendVendorForApproval(var Rec: Record Vendor)
    begin
        Rec.TestField("No.");
        Rec.TestField(Name);
        Rec.TestField(Address);
        Rec.TestField("Address 2");
        Rec.TestField(City);
        Rec.TestField("Phone No.");
        Rec.TestField("Vendor Posting Group");
        Rec.TestField("Payment Terms Code");
        Rec.TestField("Purchaser Code");
        Rec.TestField("Country/Region Code");
        Rec.TestField("Payment Method Code");
        Rec.TestField("Gen. Bus. Posting Group");
        Rec.TestField("Post Code");
        Rec.TestField("E-Mail");
        Rec.TestField("Location Code");
        Rec.TestField("Vendor Due Basis");
        if Rec."MSME Registerd" then begin
            Rec.TestField("MSME Category");
            Rec.TestField("MSME Activity");
            Rec.TestField("MSME Classification Year");
            Rec.TestField("Udhyam Registration Number");
        end;
    end;
    [EventSubscriber(ObjectType::Page, Page::"Vendor List", 'OnBeforeActionEvent', 'SendApprovalRequest', false, false)]
    procedure SSDOnSendVendorForApproval(var Rec: Record Vendor)
    begin
        Rec.TestField("No.");
        Rec.TestField(Name);
        Rec.TestField(Address);
        Rec.TestField("Address 2");
        Rec.TestField(City);
        Rec.TestField("Phone No.");
        Rec.TestField("Vendor Posting Group");
        Rec.TestField("Payment Terms Code");
        Rec.TestField("Purchaser Code");
        Rec.TestField("Country/Region Code");
        Rec.TestField("Payment Method Code");
        Rec.TestField("Gen. Bus. Posting Group");
        Rec.TestField("Post Code");
        Rec.TestField("E-Mail");
        Rec.TestField("Location Code");
        Rec.TestField("Vendor Due Basis");
        if Rec."MSME Registerd" then begin
            Rec.TestField("MSME Category");
            Rec.TestField("MSME Activity");
            Rec.TestField("MSME Classification Year");
            Rec.TestField("Udhyam Registration Number");
        end;
    end;
    [EventSubscriber(ObjectType::Page, Page::"Customer Card", 'OnBeforeActionEvent', 'SendApprovalRequest', false, false)]
    procedure OnSendCustomerForApproval(var Rec: Record Customer)
    begin
        Rec.TestField("No.");
        Rec.TestField(Name);
        Rec.TestField(Address);
        Rec.TestField("Address 2");
        Rec.TestField(City);
        Rec.TestField("Phone No.");
        Rec.TestField("Global Dimension 1 Code");
        Rec.TestField("Payment Terms Code");
        Rec.TestField("Salesperson Code");
        Rec.TestField("Shipment Method Code");
        Rec.TestField("Shipping Agent Code");
        Rec.TestField("Country/Region Code");
        Rec.TestField("Payment Method Code");
        Rec.TestField("Gen. Bus. Posting Group");
        Rec.TestField("Post Code");
        Rec.TestField("E-Mail");
        Rec.TestField("Freight Zone");
        Rec.TestField("Shipping Agent Code 1");
        Rec.TestField("Delivery Resp. Name");
        Rec.TestField("Delivery Resp. Contact No.");
    end;
    [EventSubscriber(ObjectType::Page, Page::"Customer List", 'OnBeforeActionEvent', 'SendApprovalRequest', false, false)]
    procedure SSDOnSendCustomerForApproval(var Rec: Record Customer)
    begin
        Rec.TestField("No.");
        Rec.TestField(Name);
        Rec.TestField(Address);
        Rec.TestField("Address 2");
        Rec.TestField(City);
        Rec.TestField("Phone No.");
        Rec.TestField("Global Dimension 1 Code");
        Rec.TestField("Payment Terms Code");
        Rec.TestField("Salesperson Code");
        Rec.TestField("Shipment Method Code");
        Rec.TestField("Shipping Agent Code");
        Rec.TestField("Country/Region Code");
        Rec.TestField("Payment Method Code");
        Rec.TestField("Gen. Bus. Posting Group");
        Rec.TestField("Post Code");
        Rec.TestField("E-Mail");
        Rec.TestField("Freight Zone");
        Rec.TestField("Shipping Agent Code 1");
        Rec.TestField("Delivery Resp. Name");
        Rec.TestField("Delivery Resp. Contact No.");
    end;
    [EventSubscriber(ObjectType::Page, Page::"Item Card", 'OnBeforeActionEvent', 'SendApprovalRequest', false, false)]
    procedure OnSendItemForApproval(var Rec: Record Item)
    begin
        rec.TestField("No.");
        rec.TestField(Description);
        rec.TestField("Description 2");
        rec.TestField("Base Unit of Measure");
        if Rec.Type <> Rec.Type::Service then begin
            rec.TestField("Inventory Posting Group");
            rec.TestField("Gross Weight");
            rec.TestField("Net Weight");
        end;
        rec.TestField("Unit Cost");
        rec.TestField("Gen. Prod. Posting Group");
    end;
    [EventSubscriber(ObjectType::Page, Page::"Item List", 'OnBeforeActionEvent', 'SendApprovalRequest', false, false)]
    procedure SSDOnSendItemForApproval(var Rec: Record Item)
    begin
        rec.TestField("No.");
        rec.TestField(Description);
        rec.TestField("Description 2");
        rec.TestField("Base Unit of Measure");
        if Rec.Type <> Rec.Type::Service then begin
            rec.TestField("Inventory Posting Group");
            rec.TestField("Gross Weight");
            rec.TestField("Net Weight");
        end;
        rec.TestField("Unit Cost");
        rec.TestField("Gen. Prod. Posting Group");
    end;
}
