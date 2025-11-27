report 50041 "SSD PDI SLA"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    Caption = 'PDI SLA Report';
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/PDISLA.rdl';

    dataset
    {
        dataitem("Purch. Inv. Header"; "Purch. Inv. Header")
        {
            RequestFilterFields = "Posting Date";
            DataItemTableView = where("No. Series"=const('F-PDPI'));

            column(Inv_No; "No.")
            {
            }
            column(RepFilter; "Purch. Inv. Header".getfilters)
            {
            }
            column(BuyfromVendorNo_PurchInvHeader; "Buy-from Vendor No.")
            {
            }
            column(BuyfromVendorName_PurchInvHeader; "Buy-from Vendor Name")
            {
            }
            column(DocumentDate_PurchInvHeader; format("Document Date"))
            {
            }
            column(VendorInvoiceNo_PurchInvHeader; "Vendor Invoice No.")
            {
            }
            column(PostingDate_PurchInvHeader; Format("Posting Date"))
            {
            }
            column(SystemCreatedAt_PurchInvHeader; SystemCreatedAt)
            {
            }
            column(ReceiptSendByStoreDAteTime; "Doc. send by Store DateTime")
            {
            }
            column(ReceiptRecByFinanceDAteTime; "Doc. recd by Fin DateTime")
            {
            }
            column(FirstApprovarDays; FirstApprovarDays)
            {
            }
            column(SecondApprovarDays; SecondApprovarDays)
            {
            }
            column(ThirdapprovarDays; ThirdapprovarDays)
            {
            }
            column(DocDateToSendToFinance; DocDateToSendToFinance)
            {
            }
            column(DocRecByFinanceToSystemPIPostingDate; DocRecByFinanceToSystemPIPostingDate)
            {
            }
            column(DocDateToSystemPIPostingDate; DocDateToSystemPIPostingDate)
            {
            }
            column(DateTimeSendForApproval; DateTimeSendForApproval)
            {
            }
            column(CompanyInfo_Name; CompanyInfo.Name)
            {
            }
            column(Created__Date; "Created  Date")
            {
            }
            column(CreationDatetoDocsenttoFinance; CreationDatetoDocsenttoFinance)
            {
            }
            column(ReceiptRecvbyFintoPDISentForApproval; ReceiptRecvbyFintoPDISentForApproval)
            {
            }
            dataitem("Posted Approval Entry"; "Posted Approval Entry")
            {
                DataItemLinkReference = "Purch. Inv. Header";
                DataItemTableView = where(Status=const(Approved));
                DataItemLink = "Document No."=field("No.");

                column(Last_Date_Time_Modified; "Last Date-Time Modified")
                {
                }
                column(PIApprovalStageTxt; PIApprovalStageTxt)
                {
                }
                column(SequenceNo_PostedApprovalEntry; "Sequence No.")
                {
                }
                column(DateTimeSentforApproval_PostedApprovalEntry; "Date-Time Sent for Approval")
                {
                }
                trigger OnAfterGetRecord()
                begin
                    DateTimeSendForApproval:=DT2Date("Posted Approval Entry"."Date-Time Sent for Approval");
                    PIApprovalStageTxt:='';
                    DT1:=CreateDateTime("Purch. Inv. Header"."Document Date", 0T);
                    if("Purch. Inv. Header"."Doc. send by Store DateTime" <> 0DT) and ("Purch. Inv. Header"."Document Date" <> 0D)then begin
                        //DocDateToSendToFinance := ("Purch. Inv. Header"."Doc. send by Store DateTime") - DT1;
                        Duration1:=("Purch. Inv. Header"."Doc. send by Store DateTime") - DT1;
                        DocDateToSendToFinance:=Round(Duration1 / 86400000, 0.01, '=');
                    end;
                    if((DT2Date("Purch. Inv. Header".SystemCreatedAt)) <> 0D) and ("Purch. Inv. Header"."Doc. recd by Fin DateTime" <> 0DT)then begin
                        Duration2:=("Purch. Inv. Header".SystemCreatedAt) - ("Purch. Inv. Header"."Doc. recd by Fin DateTime");
                        DocRecByFinanceToSystemPIPostingDate:=Round(Duration2 / 86400000, 0.01, '=');
                    end;
                    if((DT2Date("Purch. Inv. Header".SystemCreatedAt)) <> 0D) and ("Purch. Inv. Header"."Document Date" <> 0D)then begin
                        Duration3:=("Purch. Inv. Header".SystemCreatedAt) - DT1;
                        DocDateToSystemPIPostingDate:=Round(Duration3 / 86400000, 0.01, '=');
                    end;
                    if("Purch. Inv. Header"."Doc. send by Store DateTime" <> 0DT) and ("Purch. Inv. Header"."Created  Date" <> 0DT)then begin
                        Duration4:=("Purch. Inv. Header"."Doc. send by Store DateTime") - ("Purch. Inv. Header"."Created  Date");
                        CreationDatetoDocsenttoFinance:=Round(Duration4 / 86400000, 0.01, '=');
                    end;
                    if(DateTimeSendForApproval <> 0D) and ("Purch. Inv. Header"."Doc. recd by Fin DateTime" <> 0DT)then begin
                        Duration5:="Posted Approval Entry"."Date-Time Sent for Approval" - "Purch. Inv. Header"."Doc. recd by Fin DateTime";
                        ReceiptRecvbyFintoPDISentForApproval:=Round(Duration5 / 86400000, 0.01, '=');
                    end;
                    if "Sequence No." = 1 then begin
                        Stage1:=("Posted Approval Entry"."Last Date-Time Modified");
                        PIApprovalStageTxt:=Stage1Lbl;
                        if(Stage1 <> 0DT)then begin
                            Duration6:=Stage1 - "Posted Approval Entry"."Date-Time Sent for Approval";
                            FirstApprovarDays:=Round(Duration6 / 86400000, 0.01, '=');
                        end;
                    end;
                    if "Sequence No." = 2 then begin
                        Stage2:=("Posted Approval Entry"."Last Date-Time Modified");
                        PIApprovalStageTxt:=Stage2Lbl;
                        if(Stage2 <> 0DT)then begin
                            Duration7:=Stage2 - Stage1;
                            SecondApprovarDays:=Round(Duration7 / 86400000, 0.01, '=');
                        end;
                    end;
                    if "Sequence No." = 3 then begin
                        Stage3:=("Posted Approval Entry"."Last Date-Time Modified");
                        PIApprovalStageTxt:=Stage3Lbl;
                        if(Stage3 <> 0DT)then begin
                            Duration8:=Stage3 - Stage2;
                            ThirdapprovarDays:=Round(Duration8 / 86400000, 0.01, '=');
                        end;
                    end;
                end;
                trigger OnPreDataItem()
                begin
                    Clear(DateTimeSendForApproval);
                    Clear(Stage1);
                    Clear(Stage2);
                    Clear(Stage3);
                    Clear(DocDateToSendToFinance);
                    Clear(DocRecByFinanceToSystemPIPostingDate);
                    Clear(DocDateToSystemPIPostingDate);
                    clear(FirstApprovarDays);
                    Clear(SecondApprovarDays);
                    Clear(ThirdapprovarDays);
                    Clear(ReceiptRecvbyFintoPDISentForApproval);
                    Clear(DT1);
                    Clear(Duration1);
                    Clear(Duration2);
                    Clear(Duration3);
                    Clear(Duration4);
                    Clear(Duration5);
                    Clear(Duration6);
                    Clear(Duration7);
                    Clear(Duration8);
                end;
            }
            trigger OnAfterGetRecord()
            begin
                CompanyInfo.Get();
            end;
        }
    }
    // requestpage
    // {
    //     AboutTitle = 'Teaching tip title';
    //     AboutText = 'Teaching tip content';
    //     layout
    //     {
    //         area(Content)
    //         {
    //             group(GroupName)
    //             {
    //                 // field(Name; SourceExpression)
    //                 // {
    //                 // }
    //             }
    //         }
    //     }
    // }
    var CompanyInfo: Record "Company Information";
    ReceiptSendByStoreDAteTime: Date; // temporary variable to store the date and time of the receipt sent by store
    ReceiptRecByFinanceDAteTime: Date; // temporary variable to store the date and time of the receipt received by finance
    DocDateToSendToFinance: Decimal;
    DocRecByFinanceToSystemPIPostingDate: Decimal;
    DocDateToSystemPIPostingDate: Decimal;
    FirstApprovarDays: Decimal;
    SecondApprovarDays: Decimal;
    ThirdapprovarDays: Decimal;
    Stage1: DateTime;
    Stage2: DateTime;
    Stage3: DateTime;
    Stage1Lbl: Label 'PI Approval Stage 1 Date';
    Stage2Lbl: Label 'PI Approval Stage 2 Date';
    Stage3Lbl: Label 'PI Approval Stage 3 Date';
    PIApprovalStageTxt: Text;
    DateTimeSendForApproval: Date;
    CreationDatetoDocsenttoFinance: Decimal;
    ReceiptRecvbyFintoPDISentForApproval: Decimal;
    DT1: DateTime;
    Duration1: Duration;
    Duration2: Duration;
    Duration3: Duration;
    Duration4: Duration;
    Duration5: Duration;
    Duration6: Duration;
    Duration7: Duration;
    Duration8: Duration;
}
