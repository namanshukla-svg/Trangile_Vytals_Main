Report 50196 "Approval Status Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Approval Status Report.rdl';
    UsageCategory = ReportsandAnalysis;
    ApplicationArea = all;

    dataset
    {
        dataitem("Purchase Header"; "Purchase Header")
        {
            RequestFilterFields = "Posting Date", "Created By User Id", "Created  Date";

            column(ReportForNavId_1000000000;1000000000)
            {
            }
            column(BuyfromVendorNo_PurchaseHeader; "Purchase Header"."Buy-from Vendor No.")
            {
            }
            column(No_PurchaseHeader; "Purchase Header"."No.")
            {
            }
            column(DocumentDate_PurchaseHeader; "Purchase Header"."Document Date")
            {
            }
            column(PostingDate_PurchaseHeader; "Purchase Header"."Posting Date")
            {
            }
            column(BuyfromVendorName_PurchaseHeader; "Purchase Header"."Buy-from Vendor Name")
            {
            }
            column(BuyfromAddress_PurchaseHeader; "Purchase Header"."Buy-from Address")
            {
            }
            column(BuyfromAddress2_PurchaseHeader; "Purchase Header"."Buy-from Address 2")
            {
            }
            column(BuyfromCity_PurchaseHeader; "Purchase Header"."Buy-from City")
            {
            }
            column(PaytoPostCode_PurchaseHeader; "Purchase Header"."Buy-from Post Code")
            {
            }
            column(VendorInvoiceNo_PurchaseHeader; "Purchase Header"."Vendor Invoice No.")
            {
            }
            column(PurchaserCode_PurchaseHeader; "Purchase Header"."Purchaser Code")
            {
            }
            column(Status_PurchaseHeader; "Purchase Header".Status)
            {
            }
            column(OriginalInvoiceAmount_PurchaseHeader; "Purchase Header"."Original Invoice Amount")
            {
            }
            column(CreatedByUserId_PurchaseHeader; "Purchase Header"."Created By User Id")
            {
            }
            column(CreatedDate_PurchaseHeader; Format("Purchase Header"."Created  Date"))
            {
            }
            column(FinanceReceivedDateTime_PurchaseHeader; "Purchase Header"."Finance Received Date Time")
            {
            }
            dataitem("Approval Entry"; "Approval Entry")
            {
                DataItemLink = "Document No."=field("No.");
                DataItemTableView = where("Sequence No."=filter(1));
                MaxIteration = 1;

                column(ReportForNavId_1000000014;1000000014)
                {
                }
                column(LastModifiedByUserID_ApprovalEntry; "Approval Entry"."Last Modified By User ID")
                {
                }
                column(DateTimeSentforApproval_ApprovalEntry; "Approval Entry"."Date-Time Sent for Approval")
                {
                }
                column(LastDateTimeModified_ApprovalEntry; "Approval Entry"."Last Date-Time Modified")
                {
                }
                column(SenderID_ApprovalEntry; "Approval Entry"."Sender ID")
                {
                }
                column(ApproverID_ApprovalEntry; "Approval Entry"."Approver ID")
                {
                }
                column(Status_ApprovalEntry; "Approval Entry".Status)
                {
                }
                column(SequenceNo_ApprovalEntry; "Approval Entry"."Sequence No.")
                {
                }
                column(DocumentNo_ApprovalEntry; "Approval Entry"."Document No.")
                {
                }
                column(DateTimeSentforApproval_AE2; DT2)
                {
                }
                column(DateTimeSentforApproval_AE3; DT3)
                {
                }
                column(DateTimeSentforApproval_AE4; DT4)
                {
                }
                column(DateTimeSentforApproval_AE5; DT5)
                {
                }
                trigger OnAfterGetRecord()
                begin
                    Clear(DT2);
                    Clear(DT3);
                    Clear(DT4);
                    Clear(DT5);
                    ApprovalEntry.Reset;
                    ApprovalEntry.SetRange("Document No.", "Approval Entry"."Document No.");
                    ApprovalEntry.SetRange("Sequence No.", 2);
                    if ApprovalEntry.FindFirst then DT2:=ApprovalEntry."Date-Time Sent for Approval";
                    ApprovalEntry.SetRange("Sequence No.");
                    ApprovalEntry.SetRange("Sequence No.", 3);
                    if ApprovalEntry.FindFirst then DT3:=ApprovalEntry."Date-Time Sent for Approval";
                    ApprovalEntry.SetRange("Sequence No.");
                    ApprovalEntry.SetRange("Sequence No.", 4);
                    if ApprovalEntry.FindFirst then DT4:=ApprovalEntry."Date-Time Sent for Approval";
                    ApprovalEntry.SetRange("Sequence No.");
                    ApprovalEntry.SetRange("Sequence No.", 5);
                    if ApprovalEntry.FindFirst then DT5:=ApprovalEntry."Date-Time Sent for Approval";
                end;
            }
        }
    }
    requestpage
    {
        layout
        {
        }
        actions
        {
        }
    }
    labels
    {
    }
    var ApprovalEntry: Record "Approval Entry";
    DT2: DateTime;
    DT3: DateTime;
    DT4: DateTime;
    DT5: DateTime;
}
