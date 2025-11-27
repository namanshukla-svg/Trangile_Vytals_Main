Report 50071 "Interest Charge Memo"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Interest Charge Memo.rdl';
    UsageCategory = ReportsandAnalysis;
    ApplicationArea = all;

    dataset
    {
        dataitem(Customer; Customer)
        {
            DataItemTableView = sorting("No.");
            PrintOnlyIfDetail = true;
            RequestFilterFields = "No.", "Date Filter";

            column(ReportForNavId_6836;6836)
            {
            }
            column(Customer_Customer_Name; Customer.Name)
            {
            }
            column(Customer_GETFILTER__Date_Filter__; Customer.GetFilter("Date Filter"))
            {
            }
            column(Interest_Charge_Memo_;'Interest Charge Memo')
            {
            }
            column(ResCen_Address; ResCen.Address)
            {
            }
            column(ResCen_Name; ResCen.Name)
            {
            }
            column(ResCen__Address_2_; ResCen."Address 2")
            {
            }
            column(ResCen_City_______ResCen__Post_Code_; ResCen.City + ' - ' + ResCen."Post Code")
            {
            }
            column(ResCen_State; ResCen.State)
            {
            }
            column(InterestCaption; InterestCaptionLbl)
            {
            }
            column(ProductCaption; ProductCaptionLbl)
            {
            }
            column(No_of_Days_from_Due_DateCaption; No_of_Days_from_Due_DateCaptionLbl)
            {
            }
            column(Invoice_AmountCaption; Invoice_AmountCaptionLbl)
            {
            }
            column(No__of_daysCaption; No__of_daysCaptionLbl)
            {
            }
            column(Payment_Received_OnCaption; Payment_Received_OnCaptionLbl)
            {
            }
            column(Date_of_InvoiceCaption; Date_of_InvoiceCaptionLbl)
            {
            }
            column(Invoice_No_Caption; Invoice_No_CaptionLbl)
            {
            }
            column(Due_OnCaption; Due_OnCaptionLbl)
            {
            }
            column(Customer_No_; "No.")
            {
            }
            column(Customer_Date_Filter; "Date Filter")
            {
            }
            column(TargetSub; TargetSub)
            {
            }
            column(ActualSub; ActualSub)
            {
            }
            dataitem("Cust. Ledger Entry"; "Cust. Ledger Entry")
            {
                CalcFields = Amount;
                DataItemLink = "Customer No."=field("No."), "Document Date"=field("Date Filter");
                DataItemTableView = sorting("Document Type", "Customer No.", "Posting Date", "Currency Code")where("Document Type"=const(Invoice));
                PrintOnlyIfDetail = true;

                column(ReportForNavId_8503;8503)
                {
                }
                column(Sum_Total_;'Sum Total')
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
                column(NODays; NODays)
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
                    column(DY; DY)
                    {
                    }
                    dataitem("Bank Account Ledger Entry"; "Bank Account Ledger Entry")
                    {
                        DataItemLink = "Document No."=field("Document No.");
                        DataItemTableView = sorting("Document No.", "Posting Date")where("Bal. Account Type"=const(Customer));

                        column(ReportForNavId_4920;4920)
                        {
                        }
                        column(Bank_Account_Ledger_Entry__Amount___DY1; "Bank Account Ledger Entry".Amount * DY1)
                        {
                        }
                        column(Cust__Ledger_Entry__Amount_DY; "Cust. Ledger Entry".Amount * DY)
                        {
                        }
                        column(Cust__Ledger_Entry__Amount; "Cust. Ledger Entry".Amount)
                        {
                        }
                        column(Bank_Account_Ledger_Entry___Document_Date___Cust__Ledger_Entry___Document_Date_; "Bank Account Ledger Entry"."Document Date" - "Cust. Ledger Entry"."Document Date")
                        {
                        }
                        column(Bank_Account_Ledger_Entry__Bank_Account_Ledger_Entry___Document_Date_; "Bank Account Ledger Entry"."Document Date")
                        {
                        }
                        column(Cust__Ledger_Entry___Document_Date_; "Cust. Ledger Entry"."Document Date")
                        {
                        }
                        column(Cust__Ledger_Entry___Document_No__; "Cust. Ledger Entry"."Document No.")
                        {
                        }
                        column(Cust__Ledger_Entry___Due_Date_; "Cust. Ledger Entry"."Due Date")
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
                            if "Bank Account Ledger Entry"."Document Date" > "Cust. Ledger Entry"."Due Date" then DY:="Bank Account Ledger Entry"."Document Date" - "Cust. Ledger Entry"."Due Date"
                            else
                                DY:=0;
                            TargetSub+="Cust. Ledger Entry".Amount * DY;
                            ActualSub:=(TargetSub * Interest) / 36500;
                            if "Bank Account Ledger Entry"."Document Date" > "Cust. Ledger Entry"."Document Date" then //BIS
 NODays:="Bank Account Ledger Entry"."Document Date" - "Cust. Ledger Entry"."Document Date";
                        end;
                        trigger OnPostDataItem()
                        begin
                            if CollectedAmtGrand <> 0 then TargetGrandPerf:=TagetGrand / CollectedAmtGrand;
                            if CollectedAmtGrand <> 0 then ActualGrandPerf:=ActualGrand / CollectedAmtGrand;
                        end;
                    }
                }
                trigger OnAfterGetRecord()
                begin
                    TargetSub:=0;
                    ActualSub:=0;
                    NODays:=0;
                    DY:=0;
                end;
                trigger OnPreDataItem()
                begin
                    CustDate:=GetFilter("Document Date");
                end;
            }
            trigger OnPreDataItem()
            begin
                CustDate:=Customer.GetFilter("Date Filter");
            end;
        }
    }
    requestpage
    {
        layout
        {
            area(content)
            {
                field(Interest; Interest)
                {
                    ApplicationArea = All;
                }
            }
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
        Interest:=15;
    end;
    trigger OnPreReport()
    begin
        ResCen.Get(UserMgt.GetRespCenterFilter);
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
    Interest: Decimal;
    ResCen: Record "Responsibility Center";
    UserMgt: Codeunit "SSD User Setup Management";
    InterestCaptionLbl: label 'Interest';
    ProductCaptionLbl: label 'Product';
    No_of_Days_from_Due_DateCaptionLbl: label 'No of Days from Due Date';
    Invoice_AmountCaptionLbl: label 'Invoice Amount';
    No__of_daysCaptionLbl: label 'No. of days';
    Payment_Received_OnCaptionLbl: label 'Payment Received On';
    Date_of_InvoiceCaptionLbl: label 'Date of Invoice';
    Invoice_No_CaptionLbl: label 'Invoice No.';
    Due_OnCaptionLbl: label 'Due On';
    NODays: Integer;
    CustDate: Text;
}
