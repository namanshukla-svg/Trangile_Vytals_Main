Report 50124 "Payment Performance"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Payment Performance.rdl';
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
            column(Payment_Performance_Report_;'Payment Performance Report')
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
            column(ResCen_City_______ResCen__Post_Code_; ResCen.City + ' - ' + ResCen."Post Code")
            {
            }
            column(ResCen_State; ResCen.State)
            {
            }
            column(Salesperson_Purchaser_Name; Name)
            {
            }
            column(SrNo; SrNo)
            {
            }
            column(Sales_Person__Caption; Sales_Person__CaptionLbl)
            {
            }
            column(Salesperson_Purchaser_Code; Code)
            {
            }
            dataitem(Customer; Customer)
            {
                DataItemLink = "Salesperson Code"=field(Code);
                DataItemTableView = sorting("No.");
                PrintOnlyIfDetail = true;
                RequestFilterFields = "No.", "Date Filter";

                column(ReportForNavId_6836;6836)
                {
                }
                column(No_Customer; Customer."No.")
                {
                }
                column(Customer_Customer_Name; Customer.Name)
                {
                }
                column(FilterText; FilterText)
                {
                }
                column(CollectedAmtGrand; CollectedAmtGrand)
                {
                }
                column(Sum_Total____Salesperson_Purchaser__Name;'Sum Total ' + "Salesperson/Purchaser".Name)
                {
                }
                column(ActualGrandPerf; ActualGrandPerf)
                {
                }
                column(TargetGrandPerf; TargetGrandPerf)
                {
                }
                column(ActualGrand; ActualGrand)
                {
                }
                column(TagetGrand; TagetGrand)
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
                column(Bank_Account_Ledger_Entry__Bank_Account_Ledger_Entry___Document_Date_Caption; Bank_Account_Ledger_Entry__Bank_Account_Ledger_Entry___Document_Date_CaptionLbl)
                {
                }
                column(Due_DaysCaption; Due_DaysCaptionLbl)
                {
                }
                column(Date_of_BillCaption; Date_of_BillCaptionLbl)
                {
                }
                column(Invoice_No_Caption; Invoice_No_CaptionLbl)
                {
                }
                column(Customer_No_; "No.")
                {
                }
                column(Customer_Salesperson_Code; "Salesperson Code")
                {
                }
                column(Customer_Date_Filter; "Date Filter")
                {
                }
                dataitem("Cust. Ledger Entry"; "Cust. Ledger Entry")
                {
                    DataItemLink = "Customer No."=field("No."), "Document Date"=field("Date Filter");
                    DataItemTableView = sorting("Document Type", "Customer No.", "Posting Date", "Currency Code")where("Document Type"=const(Invoice));
                    PrintOnlyIfDetail = true;

                    column(ReportForNavId_8503;8503)
                    {
                    }
                    column(CollectedAmtSub; CollectedAmtSub)
                    {
                    }
                    column(Sum_Total_;'Sum Total')
                    {
                    }
                    column(TargetSub; TargetSub)
                    {
                    }
                    column(TargetSubPerf; TargetSubPerf)
                    {
                    }
                    column(ActualSub; ActualSub)
                    {
                    }
                    column(ActualSubPerf; ActualSubPerf)
                    {
                    }
                    column(Cust__Ledger_Entry_Entry_No_; "Entry No.")
                    {
                    }
                    column(Cust__Ledger_Entry_Customer_No_; "Customer No.")
                    {
                    }
                    column(Cust__Ledger_Entry_Document_Date; "Document Date")
                    {
                    }
                    column(Cust__Ledger_Entry_Closed_by_Entry_No_; "Closed by Entry No.")
                    {
                    }
                    dataitem("Cust. Ledger Entry1"; "Cust. Ledger Entry")
                    {
                        DataItemLink = "Entry No."=field("Closed by Entry No.");
                        DataItemTableView = sorting("Entry No.");
                        PrintOnlyIfDetail = true;
                        RequestFilterFields = "Document Date";

                        column(ReportForNavId_3118;3118)
                        {
                        }
                        column(Cust__Ledger_Entry1_Entry_No_; "Entry No.")
                        {
                        }
                        column(Cust__Ledger_Entry1_Document_No_; "Document No.")
                        {
                        }
                        dataitem("Bank Account Ledger Entry"; "Bank Account Ledger Entry")
                        {
                            DataItemLink = "Document No."=field("Document No."), "Transaction No."=field("Transaction No.");
                            DataItemTableView = sorting("Document No.", "Posting Date")where("Bal. Account Type"=const(Customer));

                            column(ReportForNavId_4920;4920)
                            {
                            }
                            column(Cust__Ledger_Entry___Closed_by_Amount____DY1; "Cust. Ledger Entry"."Closed by Amount" * DY1)
                            {
                            }
                            column(EmptyString;'')
                            {
                            }
                            column(EmptyString_Control1000000000;'')
                            {
                            }
                            column(Cust__Ledger_Entry___Closed_by_Amount____DY; "Cust. Ledger Entry"."Closed by Amount" * DY)
                            {
                            }
                            column(Cust__Ledger_Entry___Closed_by_Amount_; "Cust. Ledger Entry"."Closed by Amount")
                            {
                            }
                            column(Bank_Account_Ledger_Entry___Document_Date___Cust__Ledger_Entry___Document_Date_; "Bank Account Ledger Entry"."Document Date" - "Cust. Ledger Entry"."Document Date")
                            {
                            }
                            column(Bank_Account_Ledger_Entry__Bank_Account_Ledger_Entry___Document_Date_; "Bank Account Ledger Entry"."Document Date")
                            {
                            }
                            column(Cust__Ledger_Entry___Due_Date___Cust__Ledger_Entry___Document_Date_; "Cust. Ledger Entry"."Due Date" - "Cust. Ledger Entry"."Document Date")
                            {
                            }
                            column(Cust__Ledger_Entry___Document_Date_; "Cust. Ledger Entry"."Document Date")
                            {
                            }
                            column(Cust__Ledger_Entry___Document_No__; "Cust. Ledger Entry"."Document No.")
                            {
                            }
                            column(Bank_Account_Ledger_Entry_Entry_No_; "Entry No.")
                            {
                            }
                            column(Bank_Account_Ledger_Entry_Document_No_; "Document No.")
                            {
                            }
                            column(Bank_Account_Ledger_Entry_Document_Date_; "Bank Account Ledger Entry"."Document Date")
                            {
                            }
                            trigger OnAfterGetRecord()
                            begin
                                DY:="Cust. Ledger Entry"."Due Date" - "Cust. Ledger Entry"."Document Date";
                                DY1:="Bank Account Ledger Entry"."Document Date" - "Cust. Ledger Entry"."Document Date";
                                TargetSub+="Cust. Ledger Entry"."Closed by Amount" * DY;
                                TagetGrand+="Cust. Ledger Entry"."Closed by Amount" * DY;
                                ActualSub+="Cust. Ledger Entry"."Closed by Amount" * DY1;
                                ActualGrand+="Cust. Ledger Entry"."Closed by Amount" * DY1;
                                CollectedAmtSub+="Cust. Ledger Entry"."Closed by Amount";
                                CollectedAmtGrand+="Cust. Ledger Entry"."Closed by Amount";
                                //TagetGrand+=TargetSub;
                                //ActualGrand+=ActualSub;
                                if CollectedAmtSub <> 0 then TargetSubPerf:=TargetSub / CollectedAmtSub;
                                if CollectedAmtSub <> 0 then ActualSubPerf:=ActualSub / CollectedAmtSub;
                                //CollectedAmtGrand+=CollectedAmtSub;
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
    trigger OnInitReport()
    begin
        SrNo:=0;
    end;
    trigger OnPreReport()
    begin
        ResCen.Get(UserMgt.GetRespCenterFilter);
        FilterText:="Cust. Ledger Entry1".GetFilter("Document Date") + ' ' + Customer.GetFilters;
    end;
    var Customer1: Record Customer;
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
    Sales_Person__CaptionLbl: label '''Sales Person ''';
    Perf__DaysCaptionLbl: label 'Perf. Days';
    Actual_ProductCaptionLbl: label 'Actual Product';
    Target_Perf__DaysCaptionLbl: label 'Target Perf. Days';
    Target_ProductCaptionLbl: label 'Target Product';
    Amount_CollectedCaptionLbl: label 'Amount Collected';
    No__of_daysCaptionLbl: label 'No. of days';
    Bank_Account_Ledger_Entry__Bank_Account_Ledger_Entry___Document_Date_CaptionLbl: label 'Cleared on';
    Due_DaysCaptionLbl: label 'Due Days';
    Date_of_BillCaptionLbl: label 'Date of Bill';
    Invoice_No_CaptionLbl: label 'Invoice No.';
}
