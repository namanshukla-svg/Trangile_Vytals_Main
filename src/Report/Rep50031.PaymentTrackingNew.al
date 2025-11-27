report 50031 "Payment Tracking New"
{
    ApplicationArea = All;
    Caption = 'SLA Report OTIF';
    UsageCategory = ReportsAndAnalysis;
    RDLCLayout = './Layouts/SSDpaymentTrackingNew.rdl';

    dataset
    {
        dataitem(Integer; Integer)
        {
            DataItemTableView = SORTING(Number) ORDER(Ascending);
            MaxIteration = 1;

            trigger OnPreDataItem()
            begin
                if PaymentTrackingBuffer.FindSet() then PaymentTrackingBuffer.DeleteAll();
            end;

            trigger OnAfterGetRecord()
            begin
                PurchRecptHeader.Reset();
                if (StartDate <> 0D) and (EndDate <> 0D) then PurchRecptHeader.SetRange("Posting Date", StartDate, EndDate);
                if PurchRecptHeader.FindSet() then
                    repeat
                        LineNo += 10000;
                        PaymentTrackingBuffer.Init();
                        PaymentTrackingBuffer."GRN No." := PurchRecptHeader."No.";
                        PaymentTrackingBuffer."Line No." := LineNo;
                        PaymentTrackingBuffer."GRN Date" := PurchRecptHeader."Posting Date";
                        PaymentTrackingBuffer."System GRN Date" := PurchRecptHeader.SystemCreatedAt;
                        PaymentTrackingBuffer."Receipt Recd by Fin Date Time" := PurchRecptHeader."Receipt recd by Fin DateTime";
                        PaymentTrackingBuffer."Receipt Send by Store Date Time" := PurchRecptHeader."Receipt send by Store DateTime";
                        PaymentTrackingBuffer."Party Name" := PurchRecptHeader."Buy-from Vendor Name";
                        PaymentTrackingBuffer."Invoice No." := PurchRecptHeader."Vendor Shipment No.";
                        PaymentTrackingBuffer."Party No." := PurchRecptHeader."Buy-from Vendor No.";
                        PurchRcptLine.Reset();
                        PurchRcptLine.SetRange("Document No.", PurchRecptHeader."No.");
                        PurchRcptLine.SetFilter(Quantity, '<>%1', 0);
                        if PurchRcptLine.FindFirst() then begin
                            PurchRcptLine.CalcFields("Gate Entry no.");
                            PaymentTrackingBuffer."Gate Entry No." := PurchRcptLine."Gate Entry no.";
                            GateEntryListLine.Reset();
                            GateEntryListLine.SetRange("No.", PurchRcptLine."Gate Entry no.");
                            if GateEntryListLine.FindFirst() then
                                PaymentTrackingBuffer."Gate Entry Date" := GateEntryListLine."Posting Date";  //IG_DS PurchRcptLine." Gate Entry Date ";
                            if PaymentTrackingBuffer."Gate Entry No." = '' then begin
                                PostedGateEntryAttachment.SetRange("Receipt No.", PurchRcptLine."Document No.");
                                if PostedGateEntryAttachment.FindFirst() then begin
                                    PaymentTrackingBuffer."Gate Entry No." := PostedGateEntryAttachment."Gate Entry No.";
                                    if PostedGateEntryHeader.Get(PostedGateEntryAttachment."Entry Type", PostedGateEntryAttachment."Gate Entry No.") then PaymentTrackingBuffer."Gate Entry Date" := PostedGateEntryHeader."Posting Date";
                                end;
                            end;
                            if PaymentTrackingBuffer."Gate Entry Date" = 0D then begin
                                PostedGateEntryAttachment.SetRange("Receipt No.", PurchRcptLine."Document No.");
                                if PostedGateEntryAttachment.FindFirst() then begin
                                    PaymentTrackingBuffer."Gate Entry No." := PostedGateEntryAttachment."Gate Entry No.";
                                    if PostedGateEntryHeader.Get(PostedGateEntryAttachment."Entry Type", PostedGateEntryAttachment."Gate Entry No.") then PaymentTrackingBuffer."Gate Entry Date" := PostedGateEntryHeader."Posting Date";
                                end;
                            end;
                            //IG_DS   if PurchRcptLine."Document No." = 'ZDPPR2505357' then PaymentTrackingBuffer."Gate Entry Date":=20250331D;
                        end;
                        PurchInvLine.Reset();
                        PurchInvLine.SetFilter(Type, '<>%1', PurchInvLine.Type::" ");
                        PurchInvLine.SetRange("Receipt No.", PurchRecptHeader."No.");
                        if PurchInvLine.FindFirst() then begin
                            PaymentTrackingBuffer."PI No." := PurchInvLine."Document No.";
                            PaymentTrackingBuffer."PI Date" := PurchInvLine."Posting Date";
                            PaymentTrackingBuffer."System PI Date" := PurchInvLine.SystemCreatedAt;
                        end
                        else begin
                            PaymentTrackingBuffer."PI No." := '';
                            PaymentTrackingBuffer."PI Date" := 0D;
                            PaymentTrackingBuffer."System PI Date" := 0DT;
                        end;
                        if (PaymentTrackingBuffer."System PI Date" <> 0DT) and (PaymentTrackingBuffer."System GRN Date" <> 0DT) then PaymentTrackingBuffer."Total Days MRN TO PI Posting" := DT2Date(PaymentTrackingBuffer."System PI Date") - DT2Date(PaymentTrackingBuffer."System GRN Date");
                        if (PaymentTrackingBuffer."System PI Date" <> 0DT) and (PaymentTrackingBuffer."Receipt Recd by Fin Date Time" <> 0DT) then PaymentTrackingBuffer."Days taken to post PI from receipt " := DT2Date(PaymentTrackingBuffer."System PI Date") - DT2Date(PaymentTrackingBuffer."Receipt Recd by Fin Date Time");
                        if (PaymentTrackingBuffer."Gate Entry Date" <> 0D) and (PaymentTrackingBuffer."Receipt Send by Store Date Time" <> 0DT) then PaymentTrackingBuffer."Total Days MRN To Payment Posting" := DT2Date(PaymentTrackingBuffer."Receipt Send by Store Date Time") - PaymentTrackingBuffer."Gate Entry Date";
                        IF PaymentTrackingBuffer."PI No." <> '' then begin
                            PostedApprovalEntry.Reset();
                            PostedApprovalEntry.SetRange("Document No.", PaymentTrackingBuffer."PI No.");
                            PostedApprovalEntry.SetRange(Status, PostedApprovalEntry.Status::Approved);
                            if PostedApprovalEntry.FindSet() then begin
                                PaymentTrackingBuffer."PI Sent for Approval" := PostedApprovalEntry."Date-Time Sent for Approval";
                                repeat
                                    if PostedApprovalEntry."Sequence No." = 1 then
                                        PaymentTrackingBuffer."PI Approval Stage 1 Date" := PostedApprovalEntry."Last Date-Time Modified"
                                    else if PostedApprovalEntry."Sequence No." = 2 then
                                        PaymentTrackingBuffer."PI Approval Stage 2 Date" := PostedApprovalEntry."Last Date-Time Modified"
                                    else if PostedApprovalEntry."Sequence No." = 3 then PaymentTrackingBuffer."PI Approval Stage 3 Date" := PostedApprovalEntry."Last Date-Time Modified" until PostedApprovalEntry.Next() = 0;
                            end;
                        end;
                        PaymentTrackingBuffer.Insert();
                        PurchInvHdr.Reset();
                        if PurchInvHdr.Get(PaymentTrackingBuffer."PI No.") then begin
                            VendLedgEntry.Reset();
                            VendLedgEntry.SetRange("Document No.", PurchInvHdr."No.");
                            if VendLedgEntry.FindFirst() then begin
                                VendLedgEntry2.Reset();
                                VendLedgEntry2.SetRange("Entry No.", VendLedgEntry."Closed by Entry No.");
                                if VendLedgEntry2.FindSet() then
                                    repeat
                                        LineNo += 10000;
                                        PaymentTrackingBuffer.Reset();
                                        PaymentTrackingBuffer.Init();
                                        PaymentTrackingBuffer."GRN No." := PurchRecptHeader."No.";
                                        PaymentTrackingBuffer."Line No." := LineNo;
                                        PaymentTrackingBuffer."PI No." := PurchInvHdr."No.";
                                        PaymentTrackingBuffer."Payment Document No." := VendLedgEntry2."Document No.";
                                        PaymentTrackingBuffer."Payment Date" := VendLedgEntry2."Posting Date";
                                        PaymentTrackingBuffer.Insert();
                                    until VendLedgEntry2.Next() = 0;
                            end;
                            VendLedgEntry.Reset();
                            VendLedgEntry.SetRange("Document No.", PurchInvHdr."No.");
                            if VendLedgEntry.FindFirst() then begin
                                VendLedgEntry2.Reset();
                                VendLedgEntry2.SetRange("Closed by Entry No.", VendLedgEntry."Entry No.");
                                if VendLedgEntry2.FindSet() then
                                    repeat
                                        LineNo += 10000;
                                        PaymentTrackingBuffer.Reset();
                                        PaymentTrackingBuffer.Init();
                                        PaymentTrackingBuffer."GRN No." := PurchRecptHeader."No.";
                                        PaymentTrackingBuffer."Line No." := LineNo;
                                        PaymentTrackingBuffer."PI No." := PurchInvHdr."No.";
                                        PaymentTrackingBuffer."Payment Document No." := VendLedgEntry2."Document No.";
                                        PaymentTrackingBuffer."Payment Date" := VendLedgEntry2."Posting Date";
                                        PaymentTrackingBuffer.Insert();
                                    until VendLedgEntry2.Next() = 0;
                            end;
                        end;
                    until PurchRecptHeader.Next() = 0;
            end;
        }
        dataitem(IntegerLoop; Integer)
        {
            DataItemTableView = SORTING(Number) ORDER(Ascending) WHERE(Number = FILTER(1 ..));

            column(GRNDate; PaymentTrackingBuffer."GRN Date")
            {
            }
            column(CompanyName; CompanyName)
            {
            }
            column(StartDate; StartDate)
            {
            }
            column(EndDate; EndDate)
            {
            }
            column(GRNNo; PaymentTrackingBuffer."GRN No.")
            {
            }
            column(SystemGRNDate; PaymentTrackingBuffer."System GRN Date")
            {
            }
            column(SYstemPIDate; PaymentTrackingBuffer."System PI Date")
            {
            }
            column(LineNo; PaymentTrackingBuffer."Line No.")
            {
            }
            column(PINo; PaymentTrackingBuffer."PI No.")
            {
            }
            column(PIDate; PaymentTrackingBuffer."PI Date")
            {
            }
            column(PaymentDocNo; PaymentTrackingBuffer."Payment Document No.")
            {
            }
            column(PaymentDocDate; PaymentTrackingBuffer."Payment Date")
            {
            }
            column(GateEntryNo; PaymentTrackingBuffer."Gate Entry No.")
            {
            }
            column(GateEntryDate; PaymentTrackingBuffer."Gate Entry Date")
            {
            }
            column(ReceiptRecdbyFinDateTime; PaymentTrackingBuffer."Receipt Recd by Fin Date Time")
            {
            }
            column(ReceiptSendbyFinDateTime; PaymentTrackingBuffer."Receipt Send by Store Date Time")
            {
            }
            column(PIApprovalStage1Date; PaymentTrackingBuffer."PI Approval Stage 1 Date")
            {
            }
            column(PIApprovalStage2Date; PaymentTrackingBuffer."PI Approval Stage 2 Date")
            {
            }
            column(PIApprovalStage3Date; PaymentTrackingBuffer."PI Approval Stage 3 Date")
            {
            }
            column(TotalDayMRNToPaymentPosting; PaymentTrackingBuffer."Total Days MRN To Payment Posting")
            {
            }
            column(TotalDaysMRNTOPIPosting; PaymentTrackingBuffer."Total Days MRN TO PI Posting")
            {
            }
            column(DaystakentopostPIfromreceipt; PaymentTrackingBuffer."Days taken to post PI from receipt ")
            {
            }
            column(PartyName; PaymentTrackingBuffer."Party Name")
            {
            }
            column(PartyNo; PaymentTrackingBuffer."Party No.")
            {
            }
            column(PISentForApproval; PaymentTrackingBuffer."PI Sent for Approval")
            {
            }
            column(InvoiceNo; PaymentTrackingBuffer."Invoice No.")
            {
            }
            trigger OnAfterGetRecord()
            begin
                IF Number = 1 THEN BEGIN
                    IF NOT PaymentTrackingBuffer.FINDSET(FALSE, FALSE) THEN CurrReport.BREAK;
                END
                ELSE IF PaymentTrackingBuffer.NEXT = 0 THEN CurrReport.BREAK;
            end;
        }
    }
    requestpage
    {
        layout
        {
            area(Content)
            {
                group("Request Page")
                {
                    field(StartDate; StartDate)
                    {
                        ApplicationArea = all;
                    }
                    field(EndDate; EndDate)
                    {
                        ApplicationArea = all;
                    }
                }
            }
        }
        actions
        {
            area(Processing)
            {
            }
        }
    }
    var
        PurchInvLine: Record "Purch. Inv. Line";
        PurchInvLine2: Record "Purch. Inv. Line";
        PurchInvHdr: Record "Purch. Inv. Header";
        VendLedgEntry: Record "Vendor Ledger Entry";
        VendLedgEntry2: Record "Vendor Ledger Entry";
        PaymentTrackingBuffer: Record "Payment Tracking Buffer";
        PurchRecptHeader: Record "Purch. Rcpt. Header";
        PurchRcptLine: Record "Purch. Rcpt. Line";
        PostedApprovalEntry: Record "Posted Approval Entry";
        PostedGateEntryAttachment: Record "Posted Gate Entry Attachment";
        PostedGateEntryHeader: Record "Posted Gate Entry Header";
        PINo: Code[20];
        PIDate: Date;
        SYstemPIDate: DateTime;
        StartDate: Date;
        EndDate: Date;
        LineNo: Integer;
        GateEntryListLine: Record 50024;
}
