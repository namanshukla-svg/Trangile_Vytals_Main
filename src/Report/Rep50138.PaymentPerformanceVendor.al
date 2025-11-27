Report 50138 "Payment Performance(Vendor)"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Payment Performance(Vendor).rdl';
    UsageCategory = ReportsandAnalysis;
    ApplicationArea = all;

    dataset
    {
        dataitem("Salesperson/Purchaser"; "Salesperson/Purchaser")
        {
            DataItemTableView = sorting(Code);
            PrintOnlyIfDetail = true;
            RequestFilterFields = "Code";

            column(ReportForNavId_3065;3065)
            {
            }
            column(ResCen_City_______ResCen__Post_Code_; ResCen.City + ' - ' + ResCen."Post Code")
            {
            }
            column(ResCen__Address_2_; ResCen."Address 2")
            {
            }
            column(ResCen_Address; ResCen.Address)
            {
            }
            column(ResCen_Name; ResCen.Name)
            {
            }
            column(ResCen_State; ResCen.State)
            {
            }
            column(Payment_Performance_Report_;'Payment Performance Report')
            {
            }
            column(Salesperson_Purchaser_Name; Name)
            {
            }
            column(SrNo; SrNo)
            {
            }
            column(Purchaser_Caption; Purchaser_CaptionLbl)
            {
            }
            column(Salesperson_Purchaser_Code; Code)
            {
            }
            dataitem(Vendor; Vendor)
            {
                DataItemLink = "Purchaser Code"=field(Code);
                DataItemTableView = sorting("No.");
                PrintOnlyIfDetail = true;
                RequestFilterFields = "No.", "Date Filter";

                column(ReportForNavId_3182;3182)
                {
                }
                column(FilterText; FilterText)
                {
                }
                column(Vendor_Vendor_Name; Vendor.Name)
                {
                }
                column(ABS_CollectedAmtGrand_; Abs(CollectedAmtGrand))
                {
                }
                column(Sum_Total____Salesperson_Purchaser__Name;'Sum Total ' + "Salesperson/Purchaser".Name)
                {
                }
                column(ABS_ActualGrandPerf_; Abs(ActualGrandPerf))
                {
                }
                column(ABS_TargetGrandPerf_; Abs(TargetGrandPerf))
                {
                }
                column(ABS_ActualGrand_; Abs(ActualGrand))
                {
                }
                column(ABS_TagetGrand_; Abs(TagetGrand))
                {
                }
                column(Perf__DaysCaption; Perf__DaysCaptionLbl)
                {
                }
                column(Actual_ProductCaption; Actual_ProductCaptionLbl)
                {
                }
                column(Target_Perf__DaysCaption; Target_Perf__DaysCaptionLbl)
                {
                }
                column(Target_ProductCaption; Target_ProductCaptionLbl)
                {
                }
                column(Amount_CollectedCaption; Amount_CollectedCaptionLbl)
                {
                }
                column(No__of_daysCaption; No__of_daysCaptionLbl)
                {
                }
                column(Cleared_OnCaption; Cleared_OnCaptionLbl)
                {
                }
                column(Due_DaysCaption; Due_DaysCaptionLbl)
                {
                }
                column(Date_from_DueCaption; Date_from_DueCaptionLbl)
                {
                }
                column(Invoice_No_Caption; Invoice_No_CaptionLbl)
                {
                }
                column(Vendor_No_; "No.")
                {
                }
                column(Vendor_Purchaser_Code; "Purchaser Code")
                {
                }
                column(Vendor_Date_Filter; "Date Filter")
                {
                }
                dataitem("Vendor Ledger Entry"; "Vendor Ledger Entry")
                {
                    DataItemLink = "Vendor No."=field("No."), "Document Date"=field("Date Filter");
                    DataItemTableView = sorting("Document Type", "Vendor No.", "Posting Date", "Currency Code")where("Document Type"=const(Invoice));
                    PrintOnlyIfDetail = true;

                    column(ReportForNavId_4114;4114)
                    {
                    }
                    column(ABS_CollectedAmtSub_; Abs(CollectedAmtSub))
                    {
                    }
                    column(Sum_Total_;'Sum Total')
                    {
                    }
                    column(ABS_TargetSub_; Abs(TargetSub))
                    {
                    }
                    column(ABS_TargetSubPerf_; Abs(TargetSubPerf))
                    {
                    }
                    column(ABS_ActualSub_; Abs(ActualSub))
                    {
                    }
                    column(ABS_ActualSubPerf_; Abs(ActualSubPerf))
                    {
                    }
                    column(Vendor_Ledger_Entry_Entry_No_; "Entry No.")
                    {
                    }
                    column(Vendor_Ledger_Entry_Vendor_No_; "Vendor No.")
                    {
                    }
                    column(Vendor_Ledger_Entry_Document_Date; "Document Date")
                    {
                    }
                    column(Vendor_Ledger_Entry_Closed_by_Entry_No_; "Closed by Entry No.")
                    {
                    }
                    column(ClosedbyAmount_VendorLedgerEntry; Abs("Vendor Ledger Entry"."Closed by Amount (LCY)"))
                    {
                    }
                    column(ExternalDocumentNo_VendorLedgerEntry; "Vendor Ledger Entry"."External Document No.")
                    {
                    }
                    dataitem("Vendor Ledger Entry2"; "Vendor Ledger Entry")
                    {
                        DataItemLink = "Entry No."=field("Closed by Entry No.");
                        DataItemTableView = sorting("Entry No.");
                        PrintOnlyIfDetail = true;
                        RequestFilterFields = "Document Date";

                        column(ReportForNavId_8838;8838)
                        {
                        }
                        column(Vendor_Ledger_Entry2_Entry_No_; "Entry No.")
                        {
                        }
                        column(Vendor_Ledger_Entry2_Document_No_; "Document No.")
                        {
                        }
                        dataitem("Bank Account Ledger Entry"; "Bank Account Ledger Entry")
                        {
                            DataItemLink = "Document No."=field("Document No.");
                            DataItemTableView = sorting("Document No.", "Posting Date")where("Bal. Account Type"=const(Vendor));

                            column(ReportForNavId_4920;4920)
                            {
                            }
                            column(ABS__Vendor_Ledger_Entry___Closed_by_Amount____DY1_; Abs("Vendor Ledger Entry"."Closed by Amount (LCY)" * DY1))
                            {
                            }
                            column(EmptyString;'')
                            {
                            }
                            column(EmptyString_Control1000000035;'')
                            {
                            }
                            column(ABS__Vendor_Ledger_Entry___Closed_by_Amount____DY_; Abs("Vendor Ledger Entry"."Closed by Amount (LCY)" * DY))
                            {
                            }
                            column(ABS__Vendor_Ledger_Entry___Closed_by_Amount___; Abs("Vendor Ledger Entry"."Closed by Amount (LCY)"))
                            {
                            }
                            column(Bank_Account_Ledger_Entry___Document_Date__Dtt; "Bank Account Ledger Entry"."Document Date" - Dtt)
                            {
                            }
                            column(Bank_Account_Ledger_Entry__Bank_Account_Ledger_Entry___Document_Date_; "Bank Account Ledger Entry"."Document Date")
                            {
                            }
                            column(Vendor_Ledger_Entry___Due_Date__Dtt; "Vendor Ledger Entry"."Due Date" - Dtt)
                            {
                            }
                            column(Vendor_Ledger_Entry___Pmt__Discount_Date_; "Vendor Ledger Entry"."Pmt. Discount Date")
                            {
                            }
                            column(Vendor_Ledger_Entry___Document_No__; "Vendor Ledger Entry"."Document No.")
                            {
                            }
                            column(Bank_Account_Ledger_Entry_Entry_No_; "Entry No.")
                            {
                            }
                            column(Bank_Account_Ledger_Entry_Document_No_; "Document No.")
                            {
                            }
                            column(DocumentDate_BankAccountLedgerEntry; "Bank Account Ledger Entry"."Document Date")
                            {
                            }
                            trigger OnAfterGetRecord()
                            begin
                                if "Vendor Ledger Entry"."Pmt. Discount Date" <> 0D then begin
                                    Dtt:="Vendor Ledger Entry"."Pmt. Discount Date";
                                    DY:="Vendor Ledger Entry"."Due Date" - "Vendor Ledger Entry"."Pmt. Discount Date";
                                    DY1:="Bank Account Ledger Entry"."Document Date" - "Vendor Ledger Entry"."Pmt. Discount Date";
                                end
                                else
                                begin
                                    DY:="Vendor Ledger Entry"."Due Date" - "Vendor Ledger Entry"."Document Date";
                                    DY1:="Bank Account Ledger Entry"."Document Date" - "Vendor Ledger Entry"."Document Date";
                                    Dtt:="Vendor Ledger Entry"."Document Date";
                                end;
                                TargetSub+="Vendor Ledger Entry"."Closed by Amount (LCY)" * DY;
                                TagetGrand+="Vendor Ledger Entry"."Closed by Amount (LCY)" * DY;
                                ActualSub+="Vendor Ledger Entry"."Closed by Amount (LCY)" * DY1;
                                ActualGrand+="Vendor Ledger Entry"."Closed by Amount (LCY)" * DY1;
                                CollectedAmtSub+="Vendor Ledger Entry"."Closed by Amount (LCY)";
                                CollectedAmtGrand+="Vendor Ledger Entry"."Closed by Amount (LCY)";
                                //TagetGrand += TargetSub;
                                //ActualGrand += ActualSub;
                                if CollectedAmtSub <> 0 then TargetSubPerf:=TargetSub / CollectedAmtSub;
                                if CollectedAmtSub <> 0 then ActualSubPerf:=ActualSub / CollectedAmtSub;
                                //CollectedAmtGrand +=  CollectedAmtSub;
                                if CollectedAmtGrand <> 0 then TargetGrandPerf:=TagetGrand / CollectedAmtGrand;
                                if CollectedAmtGrand <> 0 then ActualGrandPerf:=ActualGrand / CollectedAmtGrand;
                            end;
                        }
                    }
                }
                trigger OnAfterGetRecord()
                begin
                    TargetSub:=0;
                    ActualSub:=0;
                    CollectedAmtSub:=0;
                end;
            }
            trigger OnAfterGetRecord()
            begin
                SrNo+=1;
                TagetGrand:=0;
                ActualGrand:=0;
                CollectedAmtGrand:=0;
            end;
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
    trigger OnPostReport()
    begin
        FilterText:="Vendor Ledger Entry2".GetFilter("Document Date") + ' ' + Vendor.GetFilters;
    end;
    trigger OnPreReport()
    begin
        SrNo:=0;
        ResCen.Get(UserMgt.GetRespCenterFilter);
    end;
    var Vendor1: Record Vendor;
    SrNo: Integer;
    DY: Integer;
    DY1: Integer;
    TargetSub: Decimal;
    TagetGrand: Decimal;
    ActualSub: Decimal;
    ActualGrand: Decimal;
    TargetSubPerf: Decimal;
    TargetGrandPerf: Decimal;
    ActualSubPerf: Decimal;
    ActualGrandPerf: Decimal;
    CollectedAmtSub: Decimal;
    CollectedAmtGrand: Decimal;
    ResCen: Record "Responsibility Center";
    UserMgt: Codeunit "SSD User Setup Management";
    FilterText: Text[200];
    Dtt: Date;
    Purchaser_CaptionLbl: label '''Purchaser''';
    Perf__DaysCaptionLbl: label 'Perf. Days';
    Actual_ProductCaptionLbl: label 'Actual Product';
    Target_Perf__DaysCaptionLbl: label 'Target Perf. Days';
    Target_ProductCaptionLbl: label 'Target Product';
    Amount_CollectedCaptionLbl: label 'Amount Collected';
    No__of_daysCaptionLbl: label 'No. of days';
    Cleared_OnCaptionLbl: label 'Cleared On';
    Due_DaysCaptionLbl: label 'Due Days';
    Date_from_DueCaptionLbl: label 'Date from Due';
    Invoice_No_CaptionLbl: label 'Invoice No.';
}
