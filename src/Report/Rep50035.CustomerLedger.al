Report 50035 "Customer Ledger"
{
    // BISeDK 090909 New Report
    // BIS 290909 : Added export to excel funtionality.
    // BIS RTO 1.34 100510 : Added date filters.
    // //BISEDK 190510 For show customer name only in case if balance amount and details available.
    // BISEAY 260510 - code added to show the customer details on excel only if its detail available after
    //                 applying Global dim 1 filter.
    // UTP03.24 BISEAY - flown the cheque Date.
    // GOLIVE-AUG-0012 100810
    //         - Added Narration filters as required.
    // 
    // //Alle-HB-16oct15-------- GL Entry Details added
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Customer Ledger.rdl';
    Caption = 'Customer - Ledger';
    UsageCategory = ReportsandAnalysis;
    ApplicationArea = all;

    dataset
    {
        dataitem(Customer; Customer)
        {
            DataItemTableView = sorting("No.");
            RequestFilterFields = "No.", "Date Filter", "Global Dimension 1 Filter", "Global Dimension 2 Filter";

            column(ReportForNavId_6836;6836)
            {
            }
            column(PrintDetail; PrintDetail)
            {
            }
            column(CustDateFilter; CustDateFilter)
            {
            }
            column(COMPANYNAME; Company.Name)
            {
            }
            column(DataItem1000000001; Company.Address + ' ' + Company."Address 2" + ' ' + Company.City + ' ' + Company."Post Code" + ', ' + UpperCase(gRecState.Description) + '  ' + Company.County)
            {
            }
            column(Today; Today)
            {
            }
            column(Time; Time)
            {
            }
            column(CurrReport_PAGENO; CurrReport.PageNo)
            {
            }
            column(Customer_TABLECAPTION___________CustFilter__________CustName_______________gDateFilt; Customer.TableCaption + ': ' + CustFilter + '  ' + CustName + '       ' + gDateFilt)
            {
            }
            column(AmountCaption; AmountCaption)
            {
            }
            column(RemainingAmtCaption; RemainingAmtCaption)
            {
            }
            column(Customer__No__; "No.")
            {
            }
            column(Customer_Name; Name)
            {
            }
            column(ABS_StartBalanceLCY_; Abs(StartBalanceLCY))
            {
            AutoFormatType = 1;
            }
            column(gIndCator; gIndCator)
            {
            }
            column(StartBalAdjLCY; StartBalAdjLCY)
            {
            AutoFormatType = 1;
            }
            column(CustBalanceLCY; CustBalanceLCY)
            {
            AutoFormatType = 1;
            }
            column(StartBalanceLCY___StartBalAdjLCY____Cust__Ledger_Entry___Amount__LCY_____Correction___ApplicationRounding; StartBalanceLCY + StartBalAdjLCY + "Cust. Ledger Entry"."Amount (LCY)" + Correction + ApplicationRounding)
            {
            AutoFormatType = 1;
            }
            column(StartBalanceLCY; StartBalanceLCY)
            {
            AutoFormatType = 1;
            }
            column(Cust__Ledger_Entry___Amount__LCY_____Correction___ApplicationRounding; "Cust. Ledger Entry"."Amount (LCY)" + Correction + ApplicationRounding)
            {
            AutoFormatType = 1;
            }
            column(StartBalAdjLCY_Control67; StartBalAdjLCY)
            {
            AutoFormatType = 1;
            }
            column(StartBalanceLCY___StartBalAdjLCY; StartBalanceLCY + StartBalAdjLCY)
            {
            AutoFormatType = 1;
            }
            column(Cust__Ledger_Entry___Amount__LCY_____Correction___ApplicationRounding_Control69; "Cust. Ledger Entry"."Amount (LCY)" + Correction + ApplicationRounding)
            {
            AutoFormatType = 1;
            }
            column(StartBalanceLCY____Cust__Ledger_Entry___Amount__LCY_____Correction___ApplicationRounding; Abs(StartBalanceLCY + "Cust. Ledger Entry"."Amount (LCY)" + Correction + ApplicationRounding))
            {
            AutoFormatType = 1;
            }
            column(StartBalanceLCY_Control71; StartBalanceLCY)
            {
            AutoFormatType = 1;
            }
            column(CustDrAmt; CustDrAmt)
            {
            }
            column(CustCrAmt; CustCrAmt)
            {
            }
            column(DateCaption; DateCaptionLbl)
            {
            }
            column(TimeCaption; TimeCaptionLbl)
            {
            }
            column(PageCaption; PageCaptionLbl)
            {
            }
            column(Customer_LedgerCaption; Customer_LedgerCaptionLbl)
            {
            }
            column(All_amounts_are_in_LCYCaption; All_amounts_are_in_LCYCaptionLbl)
            {
            }
            column(Cust__Ledger_Entry__Posting_Date_Caption; "Cust. Ledger Entry".FieldCaption("Posting Date"))
            {
            }
            column(Voucher_TypeCaption; Voucher_TypeCaptionLbl)
            {
            }
            column(Cust__Ledger_Entry__Document_No__Caption; "Cust. Ledger Entry".FieldCaption("Document No."))
            {
            }
            column(DescriptionCaption; DescriptionCaptionLbl)
            {
            }
            column(BalanceCaption; BalanceCaptionLbl)
            {
            }
            column(Cheque_No_Caption; Cheque_No_CaptionLbl)
            {
            }
            column(Customer_Order_No_Caption; Customer_Order_No_CaptionLbl)
            {
            }
            column(Debit_AmountCaption; Debit_AmountCaptionLbl)
            {
            }
            column(Credit_AmountCaption; Credit_AmountCaptionLbl)
            {
            }
            column(Cheque_DateCaption; Cheque_DateCaptionLbl)
            {
            }
            column(Opening_BalanceCaption; Opening_BalanceCaptionLbl)
            {
            }
            column(Adj__of_Opening_BalanceCaption; Adj__of_Opening_BalanceCaptionLbl)
            {
            }
            column(Total__LCY__Before_PeriodCaption; Total__LCY__Before_PeriodCaptionLbl)
            {
            }
            column(Total__LCY_Caption; Total__LCY_CaptionLbl)
            {
            }
            column(Total_Adj__of_Opening_BalanceCaption; Total_Adj__of_Opening_BalanceCaptionLbl)
            {
            }
            column(Total__LCY_Caption_Control30; Total__LCY_Caption_Control30Lbl)
            {
            }
            column(Total__LCY__Before_PeriodCaption_Control16; Total__LCY__Before_PeriodCaption_Control16Lbl)
            {
            }
            column(Customer_Global_Dimension_2_Filter; "Global Dimension 2 Filter")
            {
            }
            column(Customer_Global_Dimension_1_Filter; "Global Dimension 1 Filter")
            {
            }
            column(Customer_Date_Filter; "Date Filter")
            {
            }
            column(CLECr; CLECr)
            {
            }
            column(CLEDr; CLEDr)
            {
            }
            column(CreBal; CreBal)
            {
            }
            column(DeBal; DeBal)
            {
            }
            dataitem("Cust. Ledger Entry"; "Cust. Ledger Entry")
            {
                DataItemLink = "Customer No."=field("No."), "Global Dimension 2 Code"=field("Global Dimension 2 Filter"), "Global Dimension 1 Code"=field("Global Dimension 1 Filter"), "Date Filter"=field("Date Filter");
                DataItemTableView = sorting("Posting Date", "Document No.")order(ascending);

                column(ReportForNavId_8503;8503)
                {
                }
                column(StartBalanceLCY___StartBalAdjLCY____Amount__LCY__; StartBalanceLCY + StartBalAdjLCY + "Amount (LCY)")
                {
                AutoFormatType = 1;
                }
                column(BFCredit; BFCredit)
                {
                }
                column(BFDebit; BFDebit)
                {
                }
                column(StartBalanceLCY_Control1000000019; StartBalanceLCY)
                {
                AutoFormatType = 1;
                }
                column(Cust__Ledger_Entry__Posting_Date_; "Posting Date")
                {
                }
                column(Cust__Ledger_Entry__Document_Type_; "Document Type")
                {
                }
                column(Cust__Ledger_Entry__Document_No__; "Document No.")
                {
                }
                column(Desc; Desc)
                {
                }
                column(CustRemainAmount; CustRemainAmount)
                {
                AutoFormatExpression = CustCurrencyCode;
                AutoFormatType = 1;
                }
                column(CustCurrencyCode; CustCurrencyCode)
                {
                }
                column(ABS_gDecCustBal_; Abs(gDecCustBal))
                {
                AutoFormatType = 1;
                }
                column(ExtDocNo; ExtDocNo)
                {
                }
                column(CustDrAmt_Control1470001; CustDrAmt)
                {
                }
                column(CustCrAmt_Control1470002; CustCrAmt)
                {
                }
                column(ChequeNo; ChequeNo)
                {
                }
                column(ChequeDate; ChequeDate)
                {
                }
                column(gIndCator_Control1102152001; gIndCator)
                {
                }
                column(StartBalanceLCY___StartBalAdjLCY____Amount__LCY___Control59; StartBalanceLCY + StartBalAdjLCY + "Amount (LCY)")
                {
                AutoFormatType = 1;
                }
                column(ContinuedCaption; ContinuedCaptionLbl)
                {
                }
                column(Opening_BalanceCaption_Control1000000028; Opening_BalanceCaption_Control1000000028Lbl)
                {
                }
                column(ContinuedCaption_Control46; ContinuedCaption_Control46Lbl)
                {
                }
                column(Cust__Ledger_Entry_Entry_No_; "Entry No.")
                {
                }
                column(Cust__Ledger_Entry_Customer_No_; "Customer No.")
                {
                }
                column(Cust__Ledger_Entry_Global_Dimension_2_Code; "Global Dimension 2 Code")
                {
                }
                column(Cust__Ledger_Entry_Global_Dimension_1_Code; "Global Dimension 1 Code")
                {
                }
                column(Cust__Ledger_Entry_Date_Filter; "Date Filter")
                {
                }
                column(Cust__Ledger_Entry_Transaction_No_; "Transaction No.")
                {
                }
                dataitem("G/L Entry"; "G/L Entry")
                {
                    DataItemLink = "Document No."=field("Document No."), "Transaction No."=field("Transaction No.");

                    column(ReportForNavId_1000000018;1000000018)
                    {
                    }
                    column(GLEntry_EntryNo; "G/L Entry"."Entry No.")
                    {
                    }
                    column(AccountName; AccountName)
                    {
                    }
                    column(ABS_DetailAmt_; Abs(DetailAmt))
                    {
                    }
                    column(DrCrText; DrCrText)
                    {
                    }
                    trigger OnAfterGetRecord()
                    begin
                        DrCrText:='';
                        DetailAmt:=0;
                        DetailAmt:=Amount;
                        if DetailAmt > 0 then DrCrText:='Dr';
                        if DetailAmt < 0 then DrCrText:='Cr';
                        if "Cust. Ledger Entry"."Entry No." = "Entry No." then CurrReport.Skip;
                        if not PrintDetail then AccountName:=Text16500
                        else
                            AccountName:=Daybook.FindGLAccName("Source Type", "Entry No.", "Source No.", "G/L Account No.");
                    end;
                }
                dataitem("Detailed Cust. Ledg. Entry"; "Detailed Cust. Ledg. Entry")
                {
                    DataItemLink = "Cust. Ledger Entry No."=field("Entry No.");
                    DataItemTableView = sorting("Cust. Ledger Entry No.", "Entry Type", "Posting Date")where("Entry Type"=const("Correction of Remaining Amount"));

                    column(ReportForNavId_6942;6942)
                    {
                    }
                    column(Cust__Ledger_Entry___Document_No__; "Cust. Ledger Entry"."Document No.")
                    {
                    }
                    column(Cust__Ledger_Entry___Document_Type_; "Cust. Ledger Entry"."Document Type")
                    {
                    }
                    column(Detailed_Cust__Ledg__Entry__Entry_Type_; "Entry Type")
                    {
                    }
                    column(Correction; Correction)
                    {
                    AutoFormatType = 1;
                    }
                    column(CustBalanceLCY_Control61; CustBalanceLCY)
                    {
                    AutoFormatType = 1;
                    }
                    column(Detailed_Cust__Ledg__Entry_Entry_No_; "Entry No.")
                    {
                    }
                    column(Detailed_Cust__Ledg__Entry_Cust__Ledger_Entry_No_; "Cust. Ledger Entry No.")
                    {
                    }
                    column(ApplicationRounding; ApplicationRounding)
                    {
                    AutoFormatType = 1;
                    }
                    trigger OnAfterGetRecord()
                    begin
                        if "Entry Type" = "entry type"::"Correction of Remaining Amount" then begin
                            Correction:=Correction + "Amount (LCY)";
                            CustBalanceLCY:=CustBalanceLCY + "Amount (LCY)";
                        end
                        else if "Entry Type" = "entry type"::"Appln. Rounding" then begin
                                ApplicationRounding:=ApplicationRounding + "Amount (LCY)";
                                CustBalanceLCY:=CustBalanceLCY + "Amount (LCY)";
                                if Confirm('%1 %2', true, Text001, ApplicationRounding)then;
                            end;
                    end;
                    trigger OnPreDataItem()
                    begin
                        SetFilter("Posting Date", CustDateFilter);
                    end;
                }
                trigger OnAfterGetRecord()
                begin
                    CalcFields(Amount, "Remaining Amount", "Amount (LCY)", "Remaining Amt. (LCY)", "Debit Amount", "Credit Amount", "Credit Amount (LCY)", "Debit Amount (LCY)");
                    CustLedgEntryExists:=true;
                    if PrintAmountsInLCY then begin
                        CustAmount:="Amount (LCY)";
                        CustCrAmt:="Credit Amount (LCY)";
                        CustDrAmt:="Debit Amount (LCY)";
                        CustRemainAmount:="Remaining Amt. (LCY)";
                        CustCurrencyCode:='';
                    end
                    else
                    begin
                        CustAmount:=Amount;
                        CustCrAmt:="Credit Amount";
                        CustDrAmt:="Debit Amount";
                        CustRemainAmount:="Remaining Amount";
                        CustCurrencyCode:="Currency Code";
                    end;
                    CustBalanceLCY:=CustBalanceLCY + "Amount (LCY)";
                    if("Document Type" = "document type"::Payment) or ("Document Type" = "document type"::Refund)then CustEntryDueDate:=0D
                    else
                        CustEntryDueDate:="Due Date";
                    EmpNo:='';
                    EmpName:='';
                    GLEntry.Reset;
                    GLEntry.SetCurrentkey("Document No.");
                    GLEntry.SetRange(GLEntry."Document No.", "Document No.");
                    GLEntry.SetRange("Entry No.", "Entry No.");
                    if GLEntry.FindFirst then begin
                        GLName:='';
                        //SSDU Locationcode := GLEntry."Location Code";
                        if GLAccount.Get(GLEntry."G/L Account No.")then GLName:=GLAccount.Name;
                    end;
                    if SIHeader.Get("Document No.")then begin
                        Locationcode:='';
                        PartyName:='';
                        Locationcode:=SIHeader."Location Code";
                        PartyName:=SIHeader."Bill-to Name" + ' ' + SIHeader."Bill-to Name 2" end;
                    if SalesCrMemoHeader.Get("Document No.")then begin
                        PartyName:='';
                        Locationcode:=SalesCrMemoHeader."Location Code";
                        PartyName:=SalesCrMemoHeader."Bill-to Name";
                    end;
                    ChequeNo:='';
                    ChequeDate:=0D;
                    BankAccountledgerentry.Reset;
                    BankAccountledgerentry.SetCurrentkey("Document No.", "Posting Date");
                    BankAccountledgerentry.SetRange("Document No.", "Document No.");
                    BankAccountledgerentry.SetFilter("Cheque No.", '<>%1', '');
                    if BankAccountledgerentry.FindFirst then begin
                        ChequeNo:=BankAccountledgerentry."Cheque No.";
                        ChequeDate:=BankAccountledgerentry."Cheque Date";
                    end;
                    ExtDocNo:='';
                    if "Document Type" = "Cust. Ledger Entry"."document type"::Invoice then ExtDocNo:="Cust. Ledger Entry"."External Document No.";
                    if("Cust. Ledger Entry"."Bal. Account Type" = "Cust. Ledger Entry"."bal. account type"::"Bank Account")then begin
                        if BankAcc.Get("Cust. Ledger Entry"."Bal. Account No.")then Desc:=BankAcc.Name;
                    end
                    else
                        Desc:="Cust. Ledger Entry".Description;
                    // IF StartBalanceLCY < 0 THEN
                    //  gIndCator := 'Cr'
                    // ELSE
                    //  gIndCator := 'Dr';
                    //gDecCustBal := StartBalanceLCY;  //Ayan
                    //gDecCustBal := gDecCustBal + ABS(CustDrAmt) - ABS(CustCrAmt);  //Ayan ALLE-HB
                    gDecCustBal:=gDecCustBal + CustDrAmt - CustCrAmt; //ALLE-NM 01102019
                    if gDecCustBal < 0 then gIndCator:='Cr'
                    else
                        gIndCator:='Dr';
                end;
                trigger OnPreDataItem()
                begin
                    CustLedgEntryExists:=false;
                    CurrReport.CreateTotals(CustAmount, "Amount (LCY)", CustCrAmt, CustDrAmt, "Credit Amount (LCY)", "Debit Amount (LCY)", CustBalanceLCY);
                    if DateFilter = Datefilter::"Posting Date" then SetFilter("Posting Date", CustDateFilter)
                    else if DateFilter = Datefilter::"Document Date" then SetFilter("Document Date", CustDateFilter);
                end;
            }
            trigger OnAfterGetRecord()
            begin
                CLECr:=0; //31MAY16
                CLEDr:=0; //31MAY16
                FindDetail:=false;
                StartBalanceLCY:=0;
                StartBalAdjLCY:=0;
                if CustDateFilter <> '' then begin
                    if GetRangeMin("Date Filter") <> 0D then begin
                        SetRange("Date Filter", 0D, GetRangeMin("Date Filter") - 1);
                        CalcFields("Net Change (LCY)");
                        StartBalanceLCY:="Net Change (LCY)";
                    end;
                    SetFilter("Date Filter", CustDateFilter);
                    CalcFields("Net Change (LCY)");
                    StartBalAdjLCY:="Net Change (LCY)";
                    CustLedgEntry.SetCurrentkey("Customer No.", "Posting Date", "Document Date");
                    CustLedgEntry.SetRange("Customer No.", Customer."No.");
                    if DateFilter = Datefilter::"Posting Date" then CustLedgEntry.SetFilter("Posting Date", CustDateFilter)
                    else if DateFilter = Datefilter::"Document Date" then CustLedgEntry.SetFilter("Document Date", CustDateFilter);
                    if CustLedgEntry.Find('-')then repeat CustLedgEntry.SetFilter("Date Filter", CustDateFilter);
                            CustLedgEntry.CalcFields("Amount (LCY)");
                            StartBalAdjLCY:=StartBalAdjLCY - CustLedgEntry."Amount (LCY)";
                            "Detailed Cust. Ledg. Entry".SetCurrentkey("Cust. Ledger Entry No.", "Entry Type", "Posting Date");
                            "Detailed Cust. Ledg. Entry".SetRange("Cust. Ledger Entry No.", CustLedgEntry."Entry No.");
                            "Detailed Cust. Ledg. Entry".SetFilter("Entry Type", '%1|%2', "Detailed Cust. Ledg. Entry"."entry type"::"Correction of Remaining Amount", "Detailed Cust. Ledg. Entry"."entry type"::"Appln. Rounding");
                            "Detailed Cust. Ledg. Entry".SetFilter("Posting Date", CustDateFilter);
                            if "Detailed Cust. Ledg. Entry".Find('-')then repeat StartBalAdjLCY:=StartBalAdjLCY - "Detailed Cust. Ledg. Entry"."Amount (LCY)";
                                until "Detailed Cust. Ledg. Entry".Next = 0;
                            "Detailed Cust. Ledg. Entry".Reset;
                        until CustLedgEntry.Next = 0;
                end;
                //SSDU CurrReport.PrintonlyIfDetail := ExcludeBalanceOnly or (StartBalanceLCY = 0);
                CustBalanceLCY:=StartBalanceLCY + StartBalAdjLCY;
                CLEntry.Reset;
                CLEntry.SetRange(CLEntry."Customer No.", Customer."No.");
                if DateFilter = Datefilter::"Posting Date" then CLEntry.SetFilter("Posting Date", CustDateFilter)
                else if DateFilter = Datefilter::"Document Date" then CLEntry.SetFilter("Document Date", CustDateFilter);
                if CustGD1Filter <> '' then CLEntry.SetRange(CLEntry."Global Dimension 1 Code", CustGD1Filter); //BISEAY 260510
                if CustGD2Filter <> '' then CLEntry.SetRange(CLEntry."Global Dimension 2 Code", CustGD2Filter); //BISEAY 260510
                if CLEntry.FindFirst then begin
                    Flag:=true;
                    FindDetail:=true;
                end;
                if StartBalanceLCY < 0 then gIndCator:='Cr'
                else
                    gIndCator:='Dr';
                gDecCustBal:=StartBalanceLCY; //Ayan
                //Alle-HB-12oct15
                CLE.Reset;
                CLE.SetRange("Customer No.", "No.");
                CLE.SetRange("Posting Date", MinDate, MaxDate);
                //CLE.SETFILTER("Global Dimension 1 Code","Global Dimension 1 Filter");
                //CLE.SETFILTER("Global Dimension 2 Code","Global Dimension 2 Filter");
                CLE.SetRange("Date Filter", MinDate, MaxDate);
                if CLE.FindSet then begin
                    repeat CLE.CalcFields("Credit Amount");
                        CLE.CalcFields("Debit Amount");
                        CLE.CalcFields("Amount (LCY)");
                        CLECr+=CLE."Credit Amount";
                        CLEDr+=CLE."Debit Amount";
                        CLEBalanceLCY+=CLE."Amount (LCY)";
                        if PrintAmountsInLCY then begin
                            CustCrAmt:=CLE."Credit Amount (LCY)";
                            CustDrAmt:=CLE."Debit Amount (LCY)";
                        end
                        else
                        begin
                            CustCrAmt:=CLE."Credit Amount";
                            CustDrAmt:=CLE."Debit Amount";
                        end;
                    until CLE.Next = 0;
                end;
            //Alle-HB-12oct15
            end;
            trigger OnPreDataItem()
            begin
                CurrReport.NewPagePerRecord:=PrintOnlyOnePerPage;
                CurrReport.CreateTotals("Cust. Ledger Entry"."Amount (LCY)", StartBalanceLCY, StartBalAdjLCY, Correction, ApplicationRounding);
                CountInt:=0;
            end;
        }
    }
    requestpage
    {
        layout
        {
            area(content)
            {
                field("Date Filter"; DateFilter)
                {
                    ApplicationArea = All;
                }
                field("Show Amount in LCY"; PrintAmountsInLCY)
                {
                    ApplicationArea = All;
                }
                field("Exclude Customers That Have a Balance Only"; ExcludeBalanceOnly)
                {
                    ApplicationArea = All;
                    Caption = 'Exclude Customers That Have a Balance Only';
                }
                field("Region Code"; RegionFilter)
                {
                    ApplicationArea = All;
                    Caption = 'Region Code';
                    TableRelation = Location.Code;
                }
                field("Show Narration"; ShowNarr)
                {
                    ApplicationArea = All;
                    Caption = 'Show Narration';
                }
                field("Show Comments"; ShowComments)
                {
                    ApplicationArea = All;
                    Caption = 'Show Comments';
                }
                field(PrintDetail; PrintDetail)
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
        Company.Get;
    end;
    trigger OnPreReport()
    begin
        MinDate:=Customer.GetRangeMin("Date Filter");
        MaxDate:=Customer.GetRangemax("Date Filter");
        CustFilter:=Customer.GetFilter("No.");
        CustDateFilter:=Customer.GetFilter("Date Filter");
        CustGD1Filter:=Customer.GetFilter(Customer."Global Dimension 1 Filter");
        CustGD2Filter:=Customer.GetFilter(Customer."Global Dimension 2 Filter");
        if PrintAmountsInLCY then begin
            AmountCaption:="Cust. Ledger Entry".FieldCaption("Amount (LCY)");
            RemainingAmtCaption:="Cust. Ledger Entry".FieldCaption("Remaining Amt. (LCY)");
        end
        else
        begin
            AmountCaption:="Cust. Ledger Entry".FieldCaption(Amount);
            RemainingAmtCaption:="Cust. Ledger Entry".FieldCaption("Remaining Amount");
        end;
    end;
    var Text000: label 'Period: %1';
    CustLedgEntry: Record "Cust. Ledger Entry";
    PrintAmountsInLCY: Boolean;
    PrintOnlyOnePerPage: Boolean;
    ExcludeBalanceOnly: Boolean;
    CustFilter: Text[250];
    CustDateFilter: Text[30];
    AmountCaption: Text[30];
    RemainingAmtCaption: Text[30];
    CustAmount: Decimal;
    CustRemainAmount: Decimal;
    CustBalanceLCY: Decimal;
    CustCurrencyCode: Code[10];
    CustEntryDueDate: Date;
    StartBalanceLCY: Decimal;
    StartBalAdjLCY: Decimal;
    Correction: Decimal;
    ApplicationRounding: Decimal;
    CustLedgEntryExists: Boolean;
    Text001: label 'Appln Rounding:';
    User: Record User;
    Company: Record "Company Information";
    PostingType: Option " ", Advance, Running, Retention, "Secured Advance", "Adhoc Advance", Provisional, LD, "Mobilization Advance", "Equipment Advance";
    RegionFilter: Code[20];
    Flag: Boolean;
    CLEntry: Record "Cust. Ledger Entry";
    BFDebit: Decimal;
    BFCredit: Decimal;
    BFAmount: Decimal;
    BalanceAmt: Decimal;
    CustAcc: Record Customer;
    Compinfo: Record "Company Information";
    Locationcode: Code[20];
    CustCrAmt: Decimal;
    CustDrAmt: Decimal;
    GLName: Text[100];
    LOB: Code[10];
    SubLob: Code[10];
    EmpNo: Code[20];
    EmpName: Text[100];
    DimValue: Record "Dimension Value";
    GLEntry: Record "G/L Entry";
    GLAccount: Record "G/L Account";
    ChequeNo: Code[20];
    BankAccountledgerentry: Record "Bank Account Ledger Entry";
    SIHeader: Record "Sales Invoice Header";
    SalesCrMemoHeader: Record "Sales Cr.Memo Header";
    TempExcelBuffer: Record "Excel Buffer" temporary;
    ExportToExcel: Boolean;
    RowNo: Integer;
    Win: Dialog;
    Text50001: label 'Data';
    Text50002: label 'Customer';
    Text50003: label 'Customer No. #1#############';
    RecSIHeader: Record "Sales Invoice Header";
    PartyName: Text[100];
    ShowNarr: Boolean;
    ShowComments: Boolean;
    DateFilter: Option "Posting Date", "Document Date";
    DateFilterGLAAccount: Text[50];
    FindDetail: Boolean;
    Custledentry: Record "Cust. Ledger Entry";
    "--ALLEAY 260510--": Integer;
    CustGD1Filter: Text[30];
    CustGD2Filter: Text[30];
    ExtDocNo: Code[50];
    ChequeDate: Date;
    Desc: Text[100];
    BankAcc: Record "Bank Account";
    gDecCustBal: Decimal;
    CustName: Text[100];
    gDateFilt: Text[50];
    gIndCator: Text[2];
    gRecState: Record State;
    DateCaptionLbl: label 'Date';
    TimeCaptionLbl: label 'Time';
    PageCaptionLbl: label 'Page';
    Customer_LedgerCaptionLbl: label 'Customer Ledger';
    All_amounts_are_in_LCYCaptionLbl: label 'All amounts are in LCY';
    Voucher_TypeCaptionLbl: label 'Voucher Type';
    DescriptionCaptionLbl: label 'Description';
    BalanceCaptionLbl: label 'Balance';
    Cheque_No_CaptionLbl: label 'Cheque No.';
    Customer_Order_No_CaptionLbl: label 'Customer Order No.';
    Debit_AmountCaptionLbl: label 'Debit Amount';
    Credit_AmountCaptionLbl: label 'Credit Amount';
    Cheque_DateCaptionLbl: label 'Cheque Date';
    Opening_BalanceCaptionLbl: label 'Opening Balance';
    Adj__of_Opening_BalanceCaptionLbl: label 'Adj. of Opening Balance';
    Total__LCY__Before_PeriodCaptionLbl: label 'Total (LCY) Before Period';
    Total__LCY_CaptionLbl: label 'Total (LCY)';
    Total_Adj__of_Opening_BalanceCaptionLbl: label 'Total Adj. of Opening Balance';
    Total__LCY_Caption_Control30Lbl: label 'Total (LCY)';
    Total__LCY__Before_PeriodCaption_Control16Lbl: label 'Total (LCY) Before Period';
    ContinuedCaptionLbl: label 'Continued';
    Opening_BalanceCaption_Control1000000028Lbl: label 'Opening Balance';
    ContinuedCaption_Control46Lbl: label 'Continued';
    Total_CaptionLbl: label 'Total ';
    CountInt: Integer;
    DrCrText: Text[2];
    ControlAccountName: Text[100];
    DetailAmt: Decimal;
    PrintDetail: Boolean;
    AccountName: Text[100];
    Daybook: Report "Day Book";
    DrCrTextBalance: Text[2];
    OpeningDRBal: Decimal;
    OpeningCRBal: Decimal;
    TransDebits: Decimal;
    TransCredits: Decimal;
    Text16500: label 'As per Details';
    CLE: Record "Cust. Ledger Entry";
    CLECr: Decimal;
    CLEDr: Decimal;
    MinDate: Date;
    MaxDate: Date;
    CLEBalanceLCY: Decimal;
    CreBal: Decimal;
    DeBal: Decimal;
}
