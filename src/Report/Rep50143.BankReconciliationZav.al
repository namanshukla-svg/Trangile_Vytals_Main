Report 50143 "Bank Reconciliation Zav"
{
    // // Alle RD 110506 - Totals
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Bank Reconciliation Zav.rdl';
    UsageCategory = ReportsandAnalysis;
    ApplicationArea = all;

    dataset
    {
        dataitem("Bank Account"; "Bank Account")
        {
            DataItemTableView = sorting("No.");
            RequestFilterFields = "No.";

            column(ReportForNavId_4558;4558)
            {
            }
            column(Company_Information__Name; CompInfo.Name)
            {
            }
            column(Company_Information__Address; CompInfo.Address)
            {
            }
            column(Company_Information___Address_2_; CompInfo."Address 2" + ',' + CompInfo.City + '-' + CompInfo."Post Code" + ',' + ' India')
            {
            }
            column(Company_Information___Phone_No__; CompInfo."Phone No.")
            {
            }
            column(DateFrom; DateFrom)
            {
            }
            column(DateTo; DateTo)
            {
            }
            column(Bank_Account__No__; "No.")
            {
            }
            column(Bank_Account_Name; Name)
            {
            }
            column(SNo; SNo)
            {
            }
            column(BookTotal; BookTotal)
            {
            }
            column(ADD_Crdt_diff; ADD_Crdt_diff)
            {
            }
            column(ADD_Debit_diff; ADD_Debit_diff)
            {
            }
            column(BANK_RECONCILIATION_STATEMENT_FROM__Caption; BANK_RECONCILIATION_STATEMENT_FROM__CaptionLbl)
            {
            }
            column(TOCaption; TOCaptionLbl)
            {
            }
            column(Bank_Account__No__Caption; FieldCaption("No."))
            {
            }
            column(Bank__Caption; Bank__CaptionLbl)
            {
            }
            column(BANK_RECONCILIATION_No___Caption; BANK_RECONCILIATION_No___CaptionLbl)
            {
            }
            column(Less_Cheque_Deposited_But_Not_Cleared__Caption; Less_Cheque_Deposited_But_Not_Cleared__CaptionLbl)
            {
            }
            column(Add_Cheque_Issued_But_Not_Cleared__Caption; Add_Cheque_Issued_But_Not_Cleared__CaptionLbl)
            {
            }
            column(Total__Caption; Total__CaptionLbl)
            {
            }
            column(Closing_Balance_as_per_Bank___Caption; Closing_Balance_as_per_Bank___CaptionLbl)
            {
            }
            column(Closing_Balance_As_per_Book__Caption; Closing_Balance_As_per_Book__CaptionLbl)
            {
            }
            column(Less_Amount_Debit_to_Bank__Caption; Less_Amount_Debit_to_Bank__CaptionLbl)
            {
            }
            column(Add_Amount_Credit_to_Bank__Caption; Add_Amount_Credit_to_Bank__CaptionLbl)
            {
            }
            column(disp_cleared; disp_cleared)
            {
            }
            column(disp_diffC; disp_diff)
            {
            }
            dataitem("Bank Ledger Entry Debit"; "Bank Account Ledger Entry")
            {
                DataItemLink = "Bank Account No."=field("No.");
                DataItemTableView = sorting("Entry No.");
                RequestFilterHeading = '''''';

                column(ReportForNavId_2489;2489)
                {
                }
                column(Bank_Ledger_Entry_Debit__Posting_Date_; "Posting Date")
                {
                }
                column(Bank_Ledger_Entry_Debit__Cheque_No__; "Cheque No.")
                {
                }
                column(Bank_Ledger_Entry_Debit_Description; Description)
                {
                }
                column(Bank_Ledger_Entry_Debit__Debit_Amount_; "Debit Amount")
                {
                }
                column(Bank_Ledger_Entry_Debit__Document_No__; "Document No.")
                {
                }
                column(TotalD; TotalD)
                {
                }
                column(Bank_Ledger_Entry_Debit__Posting_Date_Caption; FieldCaption("Posting Date"))
                {
                }
                column(Bank_Ledger_Entry_Debit__Document_No__Caption; FieldCaption("Document No."))
                {
                }
                column(Bank_Ledger_Entry_Debit_DescriptionCaption; FieldCaption(Description))
                {
                }
                column(Bank_Ledger_Entry_Debit__Cheque_No__Caption; FieldCaption("Cheque No."))
                {
                }
                column(AmountCaption; AmountCaptionLbl)
                {
                }
                column(Cheque_Deposited_But_Not_ClearedCaption; Cheque_Deposited_But_Not_ClearedCaptionLbl)
                {
                }
                column(TotalCaption; TotalCaptionLbl)
                {
                }
                column(Bank_Ledger_Entry_Debit_Entry_No_; "Entry No.")
                {
                }
                column(Bank_Ledger_Entry_Debit_Bank_Account_No_; "Bank Account No.")
                {
                }
                column(B_repass; B_repass)
                {
                }
                trigger OnAfterGetRecord()
                begin
                    B_repass:=false;
                    if "Bank Ledger Entry Debit".Open = true then begin
                        B_repass:=true;
                    end
                    else
                    begin
                        bankaccstatementline.Reset;
                        bankaccstatementline.SetFilter("Bank Account No.", "Bank Ledger Entry Debit"."Bank Account No.");
                        bankaccstatementline.SetFilter(bankaccstatementline."Statement No.", "Bank Ledger Entry Debit"."Statement No.");
                        bankaccstatementline.SetFilter(bankaccstatementline."Statement Line No.", '=%1', "Bank Ledger Entry Debit"."Statement Line No.");
                        if bankaccstatementline.Find('-')then begin
                            //  IF bankaccstatementline."Value Date" > DateTo THEN
                            B_repass:=false;
                        end;
                    end;
                    if B_repass = true then begin
                        Total_amt_cr:=Total_amt_cr + "Bank Ledger Entry Debit"."Credit Amount";
                        Total_amt_dr:=Total_amt_dr + "Bank Ledger Entry Debit"."Debit Amount";
                        Total_bal_amt:=Total_bal_amt + "Bank Ledger Entry Debit"."Debit Amount" - "Bank Ledger Entry Debit"."Credit Amount";
                    end;
                    if "Bank Ledger Entry Debit"."Debit Amount" = 0 then B_repass:=false;
                    if B_repass then TotalD+="Debit Amount"
                    else
                        CurrReport.Skip;
                end;
                trigger OnPreDataItem()
                begin
                    TotalD:=0;
                    BAL_LAST_STATEMENT:=0;
                    "Bank Account Statement".Reset;
                    "Bank Account Statement".SetFilter("Bank Account Statement"."Bank Account No.", "Bank Account"."No.");
                    if "Bank Account Statement".Find('-')then BAL_LAST_STATEMENT:="Bank Account Statement"."Balance Last Statement";
                    "bank reconciliation line rec".Reset;
                    "bank reconciliation line rec".SetFilter("bank reconciliation line rec"."Value Date", '>=%1&<=%2', 0D, DateTo);
                    "bank reconciliation line rec".SetFilter("bank reconciliation line rec"."Bank Account No.", "Bank Account"."No.");
                    if "bank reconciliation line rec".Find('-')then begin
                        repeat BAL_LAST_STATEMENT:=BAL_LAST_STATEMENT + "bank reconciliation line rec"."Statement Amount";
                        until "bank reconciliation line rec".Next = 0;
                    end;
                    ADD_Crdt_diff:=0;
                    ADD_Debit_diff:=0;
                    "bank reconciliation line rec".Reset;
                    "bank reconciliation line rec".SetFilter("bank reconciliation line rec"."Value Date", '>=%1&<=%2', 0D, DateTo);
                    "bank reconciliation line rec".SetFilter("bank reconciliation line rec"."Bank Account No.", "Bank Account"."No.");
                    "bank reconciliation line rec".SetFilter("bank reconciliation line rec".Type, '=%1', "bank reconciliation line rec".Type::Difference);
                    if "bank reconciliation line rec".Find('-')then begin
                        repeat if "bank reconciliation line rec"."Statement Amount" < 0 then ADD_Crdt_diff:=ADD_Crdt_diff + Abs("bank reconciliation line rec"."Statement Amount");
                            if "bank reconciliation line rec"."Statement Amount" >= 0 then ADD_Debit_diff:=ADD_Debit_diff + Abs("bank reconciliation line rec"."Statement Amount");
                        until "bank reconciliation line rec".Next = 0;
                    end;
                    BookTotal:=0;
                    "BAL As Per Ledger":=0;
                    "Bank Ledger Entry Debit".Reset;
                    "Bank Ledger Entry Debit".SetCurrentkey("Bank Ledger Entry Debit"."Posting Date");
                    if DateFrom = 0D then DateFrom:=0D;
                    if DateTo = 0D then Error(text2);
                    "Bank Ledger Entry Debit".SetRange("Bank Ledger Entry Debit"."Posting Date", 0D, DateTo);
                    "Bank Ledger Entry Debit".SetFilter("Bank Ledger Entry Debit"."Bank Account No.", "Bank Account"."No.");
                    if "Bank Ledger Entry Debit".Find('-')then repeat "BAL As Per Ledger"+="Bank Ledger Entry Debit".Amount;
                        until "Bank Ledger Entry Debit".Next = 0;
                    BookTotal:="BAL As Per Ledger";
                    BankAccs.Reset;
                    BankAccs.SetFilter("Bank Account No.", "Bank Account"."No.");
                    BankAccs.SetFilter("Statement No.", SNo);
                    BankAccs.SetRange(BankAccs."Statement Date", 0D, stdate);
                    if BankAccs.Find('-')then begin
                        BalBook:=BankAccs."Statement Ending Balance";
                    end;
                    "Bank Ledger Entry Debit".Reset;
                    "Bank Ledger Entry Debit".SetCurrentkey("Bank Ledger Entry Debit"."Posting Date");
                    "Bank Ledger Entry Debit".SetFilter("Bank Ledger Entry Debit"."Bank Account No.", "Bank Account"."No.");
                    if DateFrom = 0D then DateFrom:=0D;
                    if DateTo = 0D then Error(text2);
                    "Bank Ledger Entry Debit".SetFilter("Bank Ledger Entry Debit"."Bank Account No.", "Bank Account"."No.");
                    "Bank Ledger Entry Debit".SetRange("Bank Ledger Entry Debit"."Posting Date", DateFrom, DateTo);
                    Total_bal_amt:=BAL_LAST_STATEMENT;
                    if "BAL As Per Ledger" < 0 then begin
                        "BAL As Per Ledger":=(-1 * "BAL As Per Ledger");
                        CBAL_DC2:='Cr.';
                    end
                    else
                        CBAL_DC2:='Dr.';
                    if BAL_LAST_STATEMENT < 0 then begin
                        BAL_LAST_STATEMENT:=Abs(BAL_LAST_STATEMENT);
                        CBAL_DC1:='Cr.';
                    end
                    else
                        CBAL_DC1:='Dr.';
                end;
            }
            dataitem("Bank Ledger Entry Credit"; "Bank Account Ledger Entry")
            {
                DataItemLink = "Bank Account No."=field("No.");
                DataItemTableView = sorting("Entry No.");
                RequestFilterHeading = '''''';

                column(ReportForNavId_3852;3852)
                {
                }
                column(Bank_Ledger_Entry_Credit__Posting_Date_; "Posting Date")
                {
                }
                column(Bank_Ledger_Entry_Credit__Credit_Amount_; "Credit Amount")
                {
                }
                column(Bank_Ledger_Entry_Credit__Document_No__; "Document No.")
                {
                }
                column(Bank_Ledger_Entry_Credit_Description; Description)
                {
                }
                column(Bank_Ledger_Entry_Credit__Cheque_No__; "Cheque No.")
                {
                }
                column(TotalC; TotalC)
                {
                }
                column(Posting_DateCaption; Posting_DateCaptionLbl)
                {
                }
                column(Cheque_No_Caption; Cheque_No_CaptionLbl)
                {
                }
                column(DescriptionCaption; DescriptionCaptionLbl)
                {
                }
                column(AmountCaption_Control1000000051; AmountCaption_Control1000000051Lbl)
                {
                }
                column(Document_No_Caption; Document_No_CaptionLbl)
                {
                }
                column(Cheque_Issued_But_Not_ClearedCaption; Cheque_Issued_But_Not_ClearedCaptionLbl)
                {
                }
                column(TotalCaption_Control1000000036; TotalCaption_Control1000000036Lbl)
                {
                }
                column(Bank_Ledger_Entry_Credit_Entry_No_; "Entry No.")
                {
                }
                column(Bank_Ledger_Entry_Credit_Bank_Account_No_; "Bank Account No.")
                {
                }
                column(B_repassC; B_repass)
                {
                }
                trigger OnAfterGetRecord()
                begin
                    B_repass:=false;
                    if "Bank Ledger Entry Credit".Open = true then begin
                        B_repass:=true;
                    end
                    else
                    begin
                        bankaccstatementline.Reset;
                        bankaccstatementline.SetFilter("Bank Account No.", "Bank Ledger Entry Debit"."Bank Account No.");
                        bankaccstatementline.SetFilter(bankaccstatementline."Statement No.", "Bank Ledger Entry Credit"."Statement No.");
                        bankaccstatementline.SetFilter(bankaccstatementline."Statement Line No.", '=%1', "Bank Ledger Entry Credit"."Statement Line No.");
                        if bankaccstatementline.Find('-')then begin
                            //  IF bankaccstatementline."Value Date" > DateTo THEN
                            B_repass:=false;
                        end;
                    end;
                    if "Bank Ledger Entry Credit"."Credit Amount" = 0 then B_repass:=false;
                    // Alle RD 110506 >>
                    if B_repass = true then TotalC+="Credit Amount"
                    else
                        CurrReport.Skip;
                // Alle RD 110506 >>
                end;
                trigger OnPreDataItem()
                begin
                    "Bank Ledger Entry Credit".Reset;
                    "Bank Ledger Entry Credit".SetCurrentkey("Bank Ledger Entry Credit"."Posting Date");
                    "Bank Ledger Entry Credit".SetFilter("Bank Ledger Entry Credit"."Bank Account No.", "Bank Account"."No.");
                    if DateFrom = 0D then DateFrom:=0D;
                    if DateTo = 0D then Error(text2);
                    "Bank Ledger Entry Credit".SetFilter("Bank Ledger Entry Credit"."Bank Account No.", "Bank Account"."No.");
                    "Bank Ledger Entry Credit".SetRange("Bank Ledger Entry Credit"."Posting Date", DateFrom, DateTo);
                end;
            }
            dataitem("Bank Account Statement Line"; "Bank Account Statement Line")
            {
                DataItemLink = "Bank Account No."=field("No.");
                DataItemTableView = sorting("Bank Account No.", "Statement No.", "Statement Line No.");
                RequestFilterHeading = '''''';

                column(ReportForNavId_3919;3919)
                {
                }
                column(Bank_Account_Statement_Line__Transaction_Date_; "Transaction Date")
                {
                }
                column(Bank_Account_Statement_Line__Document_No__; "Document No.")
                {
                }
                column(Bank_Account_Statement_Line_Description; Description)
                {
                }
                column(Bank_Account_Statement_Line__Statement_Amount_; "Statement Amount")
                {
                }
                column(Bank_Account_Statement_Line__Value_Date_; "Value Date")
                {
                }
                column(Bank_Account_Statement_Line__Check_No__; "Check No.")
                {
                }
                column(TotalIC; TotalIC)
                {
                }
                column(AmountCaption_Control1000000080; AmountCaption_Control1000000080Lbl)
                {
                }
                column(Cheque_No_Caption_Control1000000082; Cheque_No_Caption_Control1000000082Lbl)
                {
                }
                column(DescriptionCaption_Control1000000083; DescriptionCaption_Control1000000083Lbl)
                {
                }
                column(Document_No_Caption_Control1000000084; Document_No_Caption_Control1000000084Lbl)
                {
                }
                column(Posting_DateCaption_Control1000000086; Posting_DateCaption_Control1000000086Lbl)
                {
                }
                column(Value_DateCaption; Value_DateCaptionLbl)
                {
                }
                column(Cheque_Issued_And_ClearedCaption; Cheque_Issued_And_ClearedCaptionLbl)
                {
                }
                column(TotalCaption_Control1000000067; TotalCaption_Control1000000067Lbl)
                {
                }
                column(Bank_Account_Statement_Line_Bank_Account_No_; "Bank Account No.")
                {
                }
                column(Bank_Account_Statement_Line_Statement_No_; "Statement No.")
                {
                }
                column(Bank_Account_Statement_Line_Statement_Line_No_; "Statement Line No.")
                {
                }
                trigger OnAfterGetRecord()
                begin
                    BNKaccLedEnt.Reset;
                    BNKaccLedEnt.SetFilter(BNKaccLedEnt."Statement No.", "Bank Account Statement Line"."Statement No.");
                    BNKaccLedEnt.SetRange(BNKaccLedEnt."Statement Line No.", "Bank Account Statement Line"."Statement Line No.");
                    if BNKaccLedEnt.Find('-')then begin
                        pd1:=BNKaccLedEnt."Posting Date";
                        if disp_cleared then TotalIC+="Statement Amount";
                    end
                    else
                        CurrReport.Skip;
                // Alle RD 110506 >>
                //IF BNKaccLedEnt.FIND('-') AND (disp_cleared = TRUE) THEN
                // Alle RD 110506 <<
                end;
                trigger OnPreDataItem()
                begin
                    "Bank Account Statement Line".Reset;
                    "Bank Account Statement Line".SetFilter("Bank Account Statement Line"."Value Date", '>=%1&<=%2', 0D, DateTo);
                    "Bank Account Statement Line".SetFilter("Bank Account Statement Line"."Bank Account No.", "Bank Account"."No.");
                    "Bank Account Statement Line".SetFilter("Bank Account Statement Line"."Statement Amount", '<0');
                end;
            }
            dataitem("Bank Account Statement Line0"; "Bank Account Statement Line")
            {
                DataItemLink = "Bank Account No."=field("No.");
                DataItemTableView = sorting("Bank Account No.", "Statement No.", "Statement Line No.");
                RequestFilterHeading = '''''';

                column(ReportForNavId_3420;3420)
                {
                }
                column(Bank_Account_Statement_Line0__Transaction_Date_; "Transaction Date")
                {
                }
                column(Bank_Account_Statement_Line0__Document_No__; "Document No.")
                {
                }
                column(Bank_Account_Statement_Line0_Description; Description)
                {
                }
                column(Bank_Account_Statement_Line0__Statement_Amount_; "Statement Amount")
                {
                }
                column(Bank_Account_Statement_Line0__Value_Date_; "Value Date")
                {
                }
                column(Bank_Account_Statement_Line0__Check_No__; "Check No.")
                {
                }
                column(TotalDC; TotalDC)
                {
                }
                column(AmountCaption_Control1000000088; AmountCaption_Control1000000088Lbl)
                {
                }
                column(Cheque_No_Caption_Control1000000090; Cheque_No_Caption_Control1000000090Lbl)
                {
                }
                column(DescriptionCaption_Control1000000091; DescriptionCaption_Control1000000091Lbl)
                {
                }
                column(Document_No_Caption_Control1000000092; Document_No_Caption_Control1000000092Lbl)
                {
                }
                column(Posting_DateCaption_Control1000000094; Posting_DateCaption_Control1000000094Lbl)
                {
                }
                column(Value_DateCaption_Control1000000111; Value_DateCaption_Control1000000111Lbl)
                {
                }
                column(Cheque_Deposit_And_ClearedCaption; Cheque_Deposit_And_ClearedCaptionLbl)
                {
                }
                column(TotalCaption_Control1000000061; TotalCaption_Control1000000061Lbl)
                {
                }
                column(Bank_Account_Statement_Line0_Bank_Account_No_; "Bank Account No.")
                {
                }
                column(Bank_Account_Statement_Line0_Statement_No_; "Statement No.")
                {
                }
                column(Bank_Account_Statement_Line0_Statement_Line_No_; "Statement Line No.")
                {
                }
                trigger OnAfterGetRecord()
                begin
                    BNKaccLedEnt.Reset;
                    BNKaccLedEnt.SetFilter(BNKaccLedEnt."Statement No.", "Bank Account Statement Line"."Statement No.");
                    BNKaccLedEnt.SetRange(BNKaccLedEnt."Statement Line No.", "Bank Account Statement Line"."Statement Line No.");
                    if not BNKaccLedEnt.Find('-') and (disp_cleared = false)then begin
                        CurrReport.Skip;
                    end
                    else
                    begin
                        TotalDC+="Statement Amount";
                        pd2:=BNKaccLedEnt."Posting Date";
                    end;
                end;
                trigger OnPreDataItem()
                begin
                    "Bank Account Statement Line0".Reset;
                    "Bank Account Statement Line0".SetFilter("Bank Account Statement Line0"."Value Date", '>=%1&<=%2', 0D, DateTo);
                    "Bank Account Statement Line0".SetFilter("Bank Account Statement Line0"."Bank Account No.", "Bank Account"."No.");
                    "Bank Account Statement Line0".SetFilter("Bank Account Statement Line0"."Statement Amount", '>=0');
                end;
            }
            dataitem("Bank Account Statement Line1"; "Bank Account Statement Line")
            {
                DataItemLink = "Bank Account No."=field("No.");
                DataItemTableView = sorting("Bank Account No.", "Statement No.", "Statement Line No.");
                RequestFilterHeading = '''''';

                column(ReportForNavId_2468;2468)
                {
                }
                column(Bank_Account_Statement_Line1__Document_No__; "Document No.")
                {
                }
                column(Bank_Account_Statement_Line1__Transaction_Date_; "Transaction Date")
                {
                }
                column(Bank_Account_Statement_Line1_Description; Description)
                {
                }
                column(Bank_Account_Statement_Line1__Statement_Amount_; "Statement Amount")
                {
                }
                column(Bank_Account_Statement_Line1__Value_Date_; "Value Date")
                {
                }
                column(Bank_Account_Statement_Line1__Check_No__; "Check No.")
                {
                }
                column(AmountCaption_Control1000000096; AmountCaption_Control1000000096Lbl)
                {
                }
                column(Cheque_No_Caption_Control1000000098; Cheque_No_Caption_Control1000000098Lbl)
                {
                }
                column(DescriptionCaption_Control1000000099; DescriptionCaption_Control1000000099Lbl)
                {
                }
                column(Subhead_NameCaption; Subhead_NameCaptionLbl)
                {
                }
                column(Credit_DifferenceCaption; Credit_DifferenceCaptionLbl)
                {
                }
                column(Posting_DateCaption_Control1000000102; Posting_DateCaption_Control1000000102Lbl)
                {
                }
                column(Value_DateCaption_Control1000000078; Value_DateCaption_Control1000000078Lbl)
                {
                }
                column(Bank_Account_Statement_Line1_Bank_Account_No_; "Bank Account No.")
                {
                }
                column(Bank_Account_Statement_Line1_Statement_No_; "Statement No.")
                {
                }
                column(Bank_Account_Statement_Line1_Statement_Line_No_; "Statement Line No.")
                {
                }
                trigger OnAfterGetRecord()
                begin
                    if not disp_diff then CurrReport.Skip;
                end;
                trigger OnPreDataItem()
                begin
                    "Bank Account Statement Line1".Reset;
                    "Bank Account Statement Line1".SetFilter("Bank Account Statement Line1"."Value Date", '>=%1&<=%2', 0D, DateTo);
                    "Bank Account Statement Line1".SetFilter("Bank Account Statement Line1"."Bank Account No.", "Bank Account"."No.");
                    "Bank Account Statement Line1".SetFilter("Bank Account Statement Line1"."Statement Amount", '<0');
                    "Bank Account Statement Line1".SetFilter("Bank Account Statement Line1".Type, '=%1', "Bank Account Statement Line1".Type::Difference);
                end;
            }
            dataitem("Bank Account Statement Line2"; "Bank Account Statement Line")
            {
                DataItemLink = "Bank Account No."=field("No.");
                DataItemTableView = sorting("Bank Account No.", "Statement No.", "Statement Line No.");
                RequestFilterHeading = '''''';

                column(ReportForNavId_7377;7377)
                {
                }
                column(Bank_Account_Statement_Line2__Transaction_Date_; "Transaction Date")
                {
                }
                column(Bank_Account_Statement_Line2_Description; Description)
                {
                }
                column(Bank_Account_Statement_Line2__Document_No__; "Document No.")
                {
                }
                column(Bank_Account_Statement_Line2__Check_No__; "Check No.")
                {
                }
                column(Bank_Account_Statement_Line2__Statement_Amount_; "Statement Amount")
                {
                }
                column(Bank_Account_Statement_Line2__Value_Date_; "Value Date")
                {
                }
                column(AmountCaption_Control1000000104; AmountCaption_Control1000000104Lbl)
                {
                }
                column(Cheque_No_Caption_Control1000000106; Cheque_No_Caption_Control1000000106Lbl)
                {
                }
                column(DescriptionCaption_Control1000000107; DescriptionCaption_Control1000000107Lbl)
                {
                }
                column(Subhead_NameCaption_Control1000000108; Subhead_NameCaption_Control1000000108Lbl)
                {
                }
                column(Debit_DifferenceCaption; Debit_DifferenceCaptionLbl)
                {
                }
                column(Posting_DateCaption_Control1000000110; Posting_DateCaption_Control1000000110Lbl)
                {
                }
                column(Value_DateCaption_Control1000000077; Value_DateCaption_Control1000000077Lbl)
                {
                }
                column(Bank_Account_Statement_Line2_Bank_Account_No_; "Bank Account No.")
                {
                }
                column(Bank_Account_Statement_Line2_Statement_No_; "Statement No.")
                {
                }
                column(Bank_Account_Statement_Line2_Statement_Line_No_; "Statement Line No.")
                {
                }
                trigger OnAfterGetRecord()
                begin
                    if not disp_diff then CurrReport.Skip;
                end;
                trigger OnPreDataItem()
                begin
                    "Bank Account Statement Line2".Reset;
                    "Bank Account Statement Line2".SetFilter("Bank Account Statement Line2"."Value Date", '>=%1&<=%2', 0D, DateTo);
                    "Bank Account Statement Line2".SetFilter("Bank Account Statement Line2"."Bank Account No.", "Bank Account"."No.");
                    "Bank Account Statement Line2".SetFilter("Bank Account Statement Line2"."Statement Amount", '>=0');
                    "Bank Account Statement Line2".SetFilter("Bank Account Statement Line2".Type, '=%1', "Bank Account Statement Line2".Type::Difference);
                end;
            }
            dataitem(BankAccountFooter; "Integer")
            {
                DataItemTableView = sorting(Number)where(Number=filter(1));

                column(ReportForNavId_1000000042;1000000042)
                {
                }
                column(BankAcc_FooterFields; FooterFields)
                {
                }
                column(Total_amt_dr; Total_amt_dr)
                {
                }
                column(Gtotal; Gtotal)
                {
                }
                column(Total_amt_cr; Total_amt_cr)
                {
                }
                column(BalBook; BalBook)
                {
                }
                trigger OnAfterGetRecord()
                begin
                    BAL_AMT_PRT:=Total_amt_dr - Total_amt_cr;
                    BAL_AMT_PRT:="BAL As Per Ledger" - BAL_AMT_PRT;
                    if BAL_AMT_PRT < 0 then begin
                        CBAL_DC:='Cr.';
                        BAL_AMT_PRT:=Abs(BAL_AMT_PRT);
                    end
                    else
                        CBAL_DC:='Dr.';
                    Total_amt_dr:=Total_amt_dr - ADD_Debit_diff;
                    Total_amt_cr:=Total_amt_cr - ADD_Crdt_diff;
                    Gtotal:=BookTotal - Total_amt_dr + Total_amt_cr + ADD_Crdt_diff - ADD_Debit_diff;
                end;
            }
            trigger OnAfterGetRecord()
            begin
                Total_amt_cr:=0;
                Total_amt_dr:=0;
                Total_bal_amt:=0;
                BAL_AMT_PRT:=0;
                BalBook:=0;
            end;
            trigger OnPreDataItem()
            begin
                CompInfo.Get;
            end;
        }
    }
    requestpage
    {
        SaveValues = true;

        layout
        {
            area(content)
            {
                field(DateFrom; DateFrom)
                {
                    ApplicationArea = All;
                    Caption = 'Date From';
                }
                field(DateTo; DateTo)
                {
                    ApplicationArea = All;
                    Caption = 'Date To';
                }
                field(SNo; SNo)
                {
                    ApplicationArea = All;
                    Caption = 'Statement No.';
                    Lookup = true;

                    trigger OnLookup(var Text: Text): Boolean begin
                        BankAccs1.Reset;
                        if Page.RunModal(389, BankAccs1) = Action::LookupOK then begin
                            SNo:=BankAccs1."Statement No.";
                            stdate:=BankAccs1."Statement Date";
                        end;
                    end;
                }
                field(stdate; stdate)
                {
                    ApplicationArea = All;
                    Caption = 'Statement Date';
                }
                field(disp_cleared; disp_cleared)
                {
                    ApplicationArea = All;
                    Caption = 'Display Clearing';
                }
                field(disp_diff; disp_diff)
                {
                    ApplicationArea = All;
                    Caption = 'Display Diff.';
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
    var DateFrom: Date;
    DateTo: Date;
    chk_open: Boolean;
    Total_amt_cr: Decimal;
    Total_amt_dr: Decimal;
    Total_bal_amt: Decimal;
    CBAL_DC: Text[4];
    BAL_LAST_STATEMENT: Decimal;
    BAL_AMT_PRT: Decimal;
    text1: label 'From Date is not proper';
    text2: label 'To Date is not proper';
    "bank reconciliation line rec": Record "Bank Account Statement Line";
    "Bank Account Statement": Record "Bank Account Statement";
    "min account statement date": Date;
    "BAL As Per Ledger": Decimal;
    CBAL_DC1: Text[4];
    CBAL_DC2: Text[4];
    bankaccstatementline: Record "Bank Account Statement Line";
    B_repass: Boolean;
    ADD_Crdt_diff: Decimal;
    ADD_Debit_diff: Decimal;
    BNKaccLedEnt: Record "Bank Account Ledger Entry";
    pd1: Date;
    pd2: Date;
    sh1: Text[50];
    sh2: Text[50];
    disp_diff: Boolean;
    disp_cleared: Boolean;
    BookTotal: Decimal;
    Gtotal: Decimal;
    TotalD: Decimal;
    TotalC: Decimal;
    TotalIC: Decimal;
    TotalDC: Decimal;
    BankAccs: Record "Bank Account Statement";
    BalBook: Decimal;
    stdate: Date;
    SNo: Code[20];
    BankAccs1: Record "Bank Account Statement";
    BankAccountStatement: Record "Bank Account Statement";
    BANK_RECONCILIATION_STATEMENT_FROM__CaptionLbl: label 'BANK RECONCILIATION STATEMENT FROM :';
    TOCaptionLbl: label 'TO';
    Bank__CaptionLbl: label 'Bank :';
    BANK_RECONCILIATION_No___CaptionLbl: label 'BANK RECONCILIATION No. :';
    Less_Cheque_Deposited_But_Not_Cleared__CaptionLbl: label 'Less Cheque Deposited But Not Cleared :';
    Add_Cheque_Issued_But_Not_Cleared__CaptionLbl: label 'Add Cheque Issued But Not Cleared :';
    Total__CaptionLbl: label 'Total :';
    Closing_Balance_as_per_Bank___CaptionLbl: label 'Closing Balance as per Bank : ';
    Closing_Balance_As_per_Book__CaptionLbl: label 'Closing Balance As per Book :';
    Less_Amount_Debit_to_Bank__CaptionLbl: label 'Less Amount Debit to Bank :';
    Add_Amount_Credit_to_Bank__CaptionLbl: label 'Add Amount Credit to Bank :';
    AmountCaptionLbl: label 'Amount';
    Cheque_Deposited_But_Not_ClearedCaptionLbl: label 'Cheque Deposited But Not Cleared';
    TotalCaptionLbl: label 'Total';
    Posting_DateCaptionLbl: label 'Posting Date';
    Cheque_No_CaptionLbl: label 'Cheque No.';
    DescriptionCaptionLbl: label 'Description';
    AmountCaption_Control1000000051Lbl: label 'Amount';
    Document_No_CaptionLbl: label 'Document No.';
    Cheque_Issued_But_Not_ClearedCaptionLbl: label 'Cheque Issued But Not Cleared';
    TotalCaption_Control1000000036Lbl: label 'Total';
    AmountCaption_Control1000000080Lbl: label 'Amount';
    Cheque_No_Caption_Control1000000082Lbl: label 'Cheque No.';
    DescriptionCaption_Control1000000083Lbl: label 'Description';
    Document_No_Caption_Control1000000084Lbl: label 'Document No.';
    Posting_DateCaption_Control1000000086Lbl: label 'Posting Date';
    Value_DateCaptionLbl: label 'Value Date';
    Cheque_Issued_And_ClearedCaptionLbl: label 'Cheque Issued And Cleared';
    TotalCaption_Control1000000067Lbl: label 'Total';
    AmountCaption_Control1000000088Lbl: label 'Amount';
    Cheque_No_Caption_Control1000000090Lbl: label 'Cheque No.';
    DescriptionCaption_Control1000000091Lbl: label 'Description';
    Document_No_Caption_Control1000000092Lbl: label 'Document No.';
    Posting_DateCaption_Control1000000094Lbl: label 'Posting Date';
    Value_DateCaption_Control1000000111Lbl: label 'Value Date';
    Cheque_Deposit_And_ClearedCaptionLbl: label 'Cheque Deposit And Cleared';
    TotalCaption_Control1000000061Lbl: label 'Total';
    AmountCaption_Control1000000096Lbl: label 'Amount';
    Cheque_No_Caption_Control1000000098Lbl: label 'Cheque No.';
    DescriptionCaption_Control1000000099Lbl: label 'Description';
    Subhead_NameCaptionLbl: label 'Subhead Name';
    Credit_DifferenceCaptionLbl: label 'Credit Difference';
    Posting_DateCaption_Control1000000102Lbl: label 'Posting Date';
    Value_DateCaption_Control1000000078Lbl: label 'Value Date';
    AmountCaption_Control1000000104Lbl: label 'Amount';
    Cheque_No_Caption_Control1000000106Lbl: label 'Cheque No.';
    DescriptionCaption_Control1000000107Lbl: label 'Description';
    Subhead_NameCaption_Control1000000108Lbl: label 'Subhead Name';
    Debit_DifferenceCaptionLbl: label 'Debit Difference';
    Posting_DateCaption_Control1000000110Lbl: label 'Posting Date';
    Value_DateCaption_Control1000000077Lbl: label 'Value Date';
    FooterFields: label 'BankAcc_FooterFields';
    CompInfo: Record "Company Information";
}
