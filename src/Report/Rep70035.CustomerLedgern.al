Report 70035 "Customer Ledger(n)"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Customer Ledger(n).rdl';
    Caption = 'Customer Ledger(n)';
    ApplicationArea = ALL;
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem(Customer; Customer)
        {
            DataItemTableView = sorting("No.")order(ascending);
            RequestFilterFields = "No.", "Date Filter";

            column(ReportForNavId_6836;6836)
            {
            }
            column(STRSUBSTNO_Text000_CustDateFilter_; StrSubstNo(Text000, CustDateFilter))
            {
            }
            column(UserId; UserId)
            {
            }
            column(CurrReport_PAGENO; CurrReport.PageNo)
            {
            }
            column(FORMAT_TODAY_0_4_; Format(Today, 0, 4))
            {
            }
            column(ResCen_Name; ResCen.Name)
            {
            }
            column(ResAdd; ResAdd)
            {
            }
            column(Customer__No__; "No.")
            {
            }
            column(Customer_Name; Name)
            {
            }
            column(Customer_Customer__Phone_No__; Customer."Phone No.")
            {
            }
            column(StartBalanceLCY; StartBalanceLCY)
            {
            AutoFormatType = 1;
            }
            column(StartBalAdjLCY; StartBalAdjLCY)
            {
            AutoFormatType = 1;
            }
            column(CustBalanceLCY; CustBalanceLCY)
            {
            AutoFormatType = 1;
            }
            column(StartBalAdjLCY_Control65; StartBalAdjLCY)
            {
            AutoFormatType = 1;
            }
            column(Cust__Ledger_Entry___Amount__LCY_____Correction___ApplicationRounding; "Cust. Ledger Entry"."Amount (LCY)" + Correction + ApplicationRounding)
            {
            AutoFormatType = 1;
            }
            column(StartBalanceLCY___StartBalAdjLCY____Cust__Ledger_Entry___Amount__LCY_____Correction___ApplicationRounding; StartBalanceLCY + StartBalAdjLCY + "Cust. Ledger Entry"."Amount (LCY)" + Correction + ApplicationRounding)
            {
            AutoFormatType = 1;
            }
            column(StartBalanceLCY___StartBalAdjLCY; StartBalanceLCY + StartBalAdjLCY)
            {
            AutoFormatType = 1;
            }
            column(StartBalanceLCY_Control69; StartBalanceLCY)
            {
            AutoFormatType = 1;
            }
            column(StartBalanceLCY_Control29; StartBalanceLCY)
            {
            AutoFormatType = 1;
            }
            column(Cust__Ledger_Entry___Amount__LCY_____Correction___ApplicationRounding_Control31; "Cust. Ledger Entry"."Amount (LCY)" + Correction + ApplicationRounding)
            {
            AutoFormatType = 1;
            }
            column(StartBalanceLCY___StartBalAdjLCY____Cust__Ledger_Entry___Amount__LCY_____Correction___ApplicationRounding_Control32; StartBalanceLCY + StartBalAdjLCY + "Cust. Ledger Entry"."Amount (LCY)" + Correction + ApplicationRounding)
            {
            AutoFormatType = 1;
            }
            column(Customer_LedgerCaption; Customer_LedgerCaptionLbl)
            {
            }
            column(PageCaption; PageCaptionLbl)
            {
            }
            column(All_amounts_are_in_LCYCaption; All_amounts_are_in_LCYCaptionLbl)
            {
            }
            column(BalanceCaption; BalanceCaptionLbl)
            {
            }
            column(Order_No__Caption; Order_No__CaptionLbl)
            {
            }
            column(Doc__No_Caption; Doc__No_CaptionLbl)
            {
            }
            column(Posting_DateCaption; Posting_DateCaptionLbl)
            {
            }
            column(DescriptionCaption; DescriptionCaptionLbl)
            {
            }
            column(Chq__No_Caption; Chq__No_CaptionLbl)
            {
            }
            column(Chq__DateCaption; Chq__DateCaptionLbl)
            {
            }
            column(Debit_AmountCaption; Debit_AmountCaptionLbl)
            {
            }
            column(Credit_AmountCaption; Credit_AmountCaptionLbl)
            {
            }
            column(BalanceCaption_Control1000000025; BalanceCaption_Control1000000025Lbl)
            {
            }
            column(Credit_AmountCaption_Control1000000034; Credit_AmountCaption_Control1000000034Lbl)
            {
            }
            column(Debit_AmountCaption_Control1000000036; Debit_AmountCaption_Control1000000036Lbl)
            {
            }
            column(Chq__DateCaption_Control1000000039; Chq__DateCaption_Control1000000039Lbl)
            {
            }
            column(DescriptionCaption_Control1000000041; DescriptionCaption_Control1000000041Lbl)
            {
            }
            column(Doc__No_Caption_Control1000000042; Doc__No_Caption_Control1000000042Lbl)
            {
            }
            column(Posting_DateCaption_Control1000000043; Posting_DateCaption_Control1000000043Lbl)
            {
            }
            column(Order_No__Caption_Control1000000044; Order_No__Caption_Control1000000044Lbl)
            {
            }
            column(Chq__No_Caption_Control1000000038; Chq__No_Caption_Control1000000038Lbl)
            {
            }
            column(Phone_NoCaption; Phone_NoCaptionLbl)
            {
            }
            column(Opening_BalanceCaption; Opening_BalanceCaptionLbl)
            {
            }
            column(Adj__of_Opening_BalanceCaption; Adj__of_Opening_BalanceCaptionLbl)
            {
            }
            column(Total__LCY_Caption; Total__LCY_CaptionLbl)
            {
            }
            column(Total_Adj__of_Opening_BalanceCaption; Total_Adj__of_Opening_BalanceCaptionLbl)
            {
            }
            column(Total__LCY__Before_PeriodCaption; Total__LCY__Before_PeriodCaptionLbl)
            {
            }
            column(Total__LCY__Before_PeriodCaption_Control26; Total__LCY__Before_PeriodCaption_Control26Lbl)
            {
            }
            column(Customer_Date_Filter; "Date Filter")
            {
            }
            column(Customer_Global_Dimension_1_Filter; "Global Dimension 1 Filter")
            {
            }
            column(Customer_Global_Dimension_2_Filter; "Global Dimension 2 Filter")
            {
            }
            dataitem("Cust. Ledger Entry"; "Cust. Ledger Entry")
            {
                DataItemLink = "Customer No."=field("No."), "Posting Date"=field("Date Filter"), "Global Dimension 1 Code"=field("Global Dimension 1 Filter"), "Global Dimension 2 Code"=field("Global Dimension 2 Filter");
                DataItemTableView = sorting("Customer No.", "Posting Date", "Currency Code")order(ascending);
                RequestFilterFields = "Document No.";

                column(ReportForNavId_8503;8503)
                {
                }
                column(TransApproxAmount; TransApproxAmount)
                {
                AutoFormatType = 1;
                }
                column(Balance; Balance)
                {
                AutoFormatType = 1;
                }
                column(Balance_Control40; Balance)
                {
                AutoFormatType = 1;
                }
                column(Cust__Ledger_Entry__Posting_Date_; "Posting Date")
                {
                }
                column(SalesInvLine__Excise_Invoice_No__; SalesInvLine."Excise Invoice No.")
                {
                }
                column(ItemCategoryName; ItemCategoryName)
                {
                }
                column(Cust__Ledger_Entry__Debit_Amount_; "Debit Amount")
                {
                }
                column(Cust__Ledger_Entry__Credit_Amount_; "Credit Amount")
                {
                }
                column(Cust__Ledger_Entry__External_Document_No__; "External Document No.")
                {
                }
                column(Cust__Ledger_Entry__Cust__Ledger_Entry___Document_No__; "Cust. Ledger Entry"."Document No.")
                {
                }
                column(ExInvNo; ExInvNo)
                {
                }
                column(Cust__Ledger_Entry__Credit_Amount__Control1000000004; "Credit Amount")
                {
                }
                column(Cust__Ledger_Entry__Debit_Amount__Control1000000005; "Debit Amount")
                {
                }
                column(ItemCategoryName_Control1000000011; ItemCategoryName)
                {
                }
                column(Cust__Ledger_Entry__Posting_Date__Control1000000013; "Posting Date")
                {
                }
                column(Cust__Ledger_Entry__External_Document_No___Control1000000009; "External Document No.")
                {
                }
                column(Balance_Control1000000001; Balance)
                {
                AutoFormatType = 1;
                }
                column(SalesInvLine__Excise_Invoice_No___Control1000000049; SalesInvLine."Excise Invoice No.")
                {
                }
                column(Cust__Ledger_Entry__Cust__Ledger_Entry___Document_No___Control1000000067; "Cust. Ledger Entry"."Document No.")
                {
                }
                column(ExInvNo_Control1000000069; ExInvNo)
                {
                }
                column(Balance_Control1000000003; Balance)
                {
                AutoFormatType = 1;
                }
                column(Balance_Control1000000022; Balance)
                {
                AutoFormatType = 1;
                }
                column(Customer_Name_Control1000000023; Customer.Name)
                {
                }
                column(Cust__Ledger_Entry__Cust__Ledger_Entry___Credit_Amount_; "Cust. Ledger Entry"."Credit Amount")
                {
                }
                column(Cust__Ledger_Entry__Cust__Ledger_Entry___Debit_Amount_; "Cust. Ledger Entry"."Debit Amount")
                {
                }
                column(ContinuedCaption; ContinuedCaptionLbl)
                {
                }
                column(EmptyStringCaption; EmptyStringCaptionLbl)
                {
                }
                column(EmptyStringCaption_Control1000000070; EmptyStringCaption_Control1000000070Lbl)
                {
                }
                column(ContinuedCaption_Control46; ContinuedCaption_Control46Lbl)
                {
                }
                column(TotalCaption; TotalCaptionLbl)
                {
                }
                column(Cust__Ledger_Entry_Entry_No_; "Entry No.")
                {
                }
                column(Cust__Ledger_Entry_Customer_No_; "Customer No.")
                {
                }
                column(Cust__Ledger_Entry_Global_Dimension_1_Code; "Global Dimension 1 Code")
                {
                }
                column(Cust__Ledger_Entry_Global_Dimension_2_Code; "Global Dimension 2 Code")
                {
                }
                dataitem("Detailed Cust. Ledg. Entry"; "Detailed Cust. Ledg. Entry")
                {
                    DataItemTableView = sorting("Document No.", "Document Type", "Posting Date")order(ascending);

                    column(ReportForNavId_6942;6942)
                    {
                    }
                    column(Cust__Ledger_Entry___Document_Type_; "Cust. Ledger Entry"."Document Type")
                    {
                    }
                    column(Cust__Ledger_Entry___Document_No__; "Cust. Ledger Entry"."Document No.")
                    {
                    }
                    column(Detailed_Cust__Ledg__Entry__Entry_Type_; "Entry Type")
                    {
                    }
                    column(Correction; Correction)
                    {
                    AutoFormatType = 1;
                    }
                    column(CustBalanceLCY_Control60; CustBalanceLCY)
                    {
                    AutoFormatType = 1;
                    }
                    column(Detailed_Cust__Ledg__Entry_Entry_No_; "Entry No.")
                    {
                    }
                    trigger OnAfterGetRecord()
                    begin
                        Correction:=Correction + "Amount (LCY)";
                        CustBalanceLCY:=CustBalanceLCY + "Amount (LCY)";
                    end;
                    trigger OnPreDataItem()
                    begin
                        SetFilter("Posting Date", CustDateFilter);
                        ItemCategoryName:='';
                        ExInvNo:='';
                    end;
                }
                dataitem("<Detailed Cust. Ledg. Entry2>"; "Detailed Cust. Ledg. Entry")
                {
                    DataItemTableView = sorting("Document No.", "Document Type", "Posting Date")order(ascending);

                    column(ReportForNavId_7703;7703)
                    {
                    }
                    column(Detailed_Cust__Ledg__Entry2___Entry_Type_; "Entry Type")
                    {
                    }
                    column(CustBalanceLCY_Control56; CustBalanceLCY)
                    {
                    AutoFormatType = 1;
                    }
                    column(ApplicationRounding; ApplicationRounding)
                    {
                    AutoFormatType = 1;
                    }
                    column(Cust__Ledger_Entry___Document_No___Control72; "Cust. Ledger Entry"."Document No.")
                    {
                    }
                    column(Cust__Ledger_Entry___Document_Type__Control73; "Cust. Ledger Entry"."Document Type")
                    {
                    }
                    column(Detailed_Cust__Ledg__Entry2__Entry_No_; "Entry No.")
                    {
                    }
                    trigger OnAfterGetRecord()
                    begin
                        ApplicationRounding:=ApplicationRounding + "Amount (LCY)";
                        CustBalanceLCY:=CustBalanceLCY + "Amount (LCY)";
                    end;
                    trigger OnPreDataItem()
                    begin
                        SetFilter("Posting Date", CustDateFilter);
                        ItemCategoryName:='';
                        ExInvNo:='';
                    end;
                }
                trigger OnAfterGetRecord()
                begin
                    ItemCategoryName:='';
                    CalcFields(Amount, "Remaining Amount", "Amount (LCY)", "Remaining Amt. (LCY)");
                    CustLedgEntryExists:=true;
                    if PrintAmountsInLCY then begin
                        CustAmount:="Amount (LCY)";
                        CustRemainAmount:="Remaining Amt. (LCY)";
                        CustCurrencyCode:='';
                    end
                    else
                    begin
                        CustAmount:=Amount;
                        CustRemainAmount:="Remaining Amount";
                        CustCurrencyCode:="Currency Code";
                    end;
                    CustBalanceLCY:=CustBalanceLCY + "Amount (LCY)";
                    Balance+="Amount (LCY)";
                    if("Document Type" = "document type"::Payment) or ("Document Type" = "document type"::Refund)then CustEntryDueDate:=0D
                    else
                        CustEntryDueDate:="Due Date";
                    CheckLedgerEntry.SetRange("Document No.", "Document No.");
                    if CheckLedgerEntry.Find('-')then begin
                        CheckNo:=CheckLedgerEntry."Check No.";
                        CheckDate:=CheckLedgerEntry."Check Date";
                    end
                    else
                    begin
                        CheckNo:='';
                        CheckDate:=0D;
                    end;
                    if "Document Type" = "document type"::Invoice then begin
                        SalesInvLine.SetRange("Document No.", "Document No.");
                        SalesInvLine.SetRange(Type, SalesInvLine.Type::Item);
                        SalesInvLine.SetFilter(Quantity, '>%1', 0);
                        if SalesInvLine.Find('-')then if ItemCategory.Get(SalesInvLine."Item Category Code")then begin
                                if ItemCategory.Description <> '' then ItemCategoryName:=ItemCategory.Description
                                else
                                    ItemCategoryName:=ItemCategory.Code;
                            end
                            else
                                ItemCategoryName:='';
                    end;
                    if "Document Type" = "document type"::"Credit Memo" then begin
                        SalesCrMemoLine.SetRange("Document No.", "Document No.");
                        SalesCrMemoLine.SetRange(Type, SalesCrMemoLine.Type::Item);
                        SalesCrMemoLine.SetFilter(Quantity, '>%1', 0);
                        if SalesCrMemoLine.Find('-')then if ItemCategory.Get(SalesCrMemoLine."Item Category Code")then begin
                                if ItemCategory.Description <> '' then ItemCategoryName:=ItemCategory.Description
                                else
                                    ItemCategoryName:=ItemCategory.Code;
                            end
                            else
                                ItemCategoryName:='';
                    end;
                    if "Document Type" = "document type"::Payment then begin
                        BankAccount.SetRange("No.", "Bal. Account No.");
                        if BankAccount.Find('-')then ItemCategoryName:=BankAccount.Name;
                    end;
                    if "Document Type" <> "document type"::Invoice then if "Document Type" <> "document type"::"Credit Memo" then if "Document Type" <> "document type"::Payment then ItemCategoryName:=Description;
                    SalesInvoiceHeader.Reset;
                    SalesInvoiceHeader.SetCurrentkey("Sell-to Customer No.", "External Document No.", "No.");
                    SalesInvoiceHeader.SetRange(SalesInvoiceHeader."Sell-to Customer No.", "Cust. Ledger Entry"."Customer No.");
                    SalesInvoiceHeader.SetRange(SalesInvoiceHeader."External Document No.", "Cust. Ledger Entry"."External Document No.");
                    SalesInvoiceHeader.SetRange(SalesInvoiceHeader."No.", "Cust. Ledger Entry"."Document No.");
                    if SalesInvoiceHeader.Find('-')then ExInvNo:=SalesInvoiceHeader."Excise Invoice No.";
                end;
                trigger OnPostDataItem()
                begin
                    //TotalCustBalanceLCY += (CustBalanceLCY + StartBalanceLCY) ;
                    TotalCustBalanceLCY+=Balance;
                end;
                trigger OnPreDataItem()
                begin
                    CustLedgEntryExists:=false;
                    a:=StartBalanceLCY;
                    CurrReport.CreateTotals(CustBalanceLCY);
                    Balance:=CustBalanceLCY;
                end;
            }
            dataitem("Integer"; "Integer")
            {
                DataItemTableView = sorting(Number)where(Number=const(1));

                column(ReportForNavId_5444;5444)
                {
                }
                column(Customer_Name_Control48; Customer.Name)
                {
                }
                column(CustBalanceLCY__StartBalanceLCY_StartBalAdjLCY; CustBalanceLCY - StartBalanceLCY - StartBalAdjLCY)
                {
                AutoFormatType = 1;
                }
                column(CustBalanceLCY_Control61; CustBalanceLCY)
                {
                AutoFormatType = 1;
                }
                column(Balance_Control1000000000; Balance)
                {
                AutoFormatType = 1;
                }
                column(Cust__Ledger_Entry___Credit_Amount_; "Cust. Ledger Entry"."Credit Amount")
                {
                }
                column(Cust__Ledger_Entry___Debit_Amount_; "Cust. Ledger Entry"."Debit Amount")
                {
                }
                column(TotalCaption_Control1000000002; TotalCaption_Control1000000002Lbl)
                {
                }
                column(Integer_Number; Number)
                {
                }
                trigger OnAfterGetRecord()
                begin
                    if not CustLedgEntryExists and ((StartBalanceLCY = 0) or ExcludeBalanceOnly)then begin
                        StartBalanceLCY:=0;
                        CurrReport.Skip;
                    end;
                end;
            }
            trigger OnAfterGetRecord()
            begin
                Balance:=0;
                TotalCustBalanceLCY:=0;
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
                    CustomerLedgerEntry.SetCurrentkey("Customer No.", "Posting Date");
                    CustomerLedgerEntry.SetRange("Customer No.", Customer."No.");
                    CustomerLedgerEntry.SetFilter("Posting Date", CustDateFilter);
                    if CustomerLedgerEntry.Find('-')then repeat CustomerLedgerEntry.SetFilter("Date Filter", CustDateFilter);
                            CustomerLedgerEntry.CalcFields("Amount (LCY)");
                            StartBalAdjLCY:=StartBalAdjLCY - CustomerLedgerEntry."Amount (LCY)";
                            "Detailed Cust. Ledg. Entry".SetCurrentkey("Cust. Ledger Entry No.", "Entry Type", "Posting Date");
                            "Detailed Cust. Ledg. Entry".SetRange("Cust. Ledger Entry No.", CustomerLedgerEntry."Entry No.");
                            "Detailed Cust. Ledg. Entry".SetFilter("Entry Type", '%1|%2', "Detailed Cust. Ledg. Entry"."entry type"::"Correction of Remaining Amount", "Detailed Cust. Ledg. Entry"."entry type"::"Appln. Rounding");
                            "Detailed Cust. Ledg. Entry".SetFilter("Posting Date", CustDateFilter);
                            if "Detailed Cust. Ledg. Entry".Find('-')then repeat StartBalAdjLCY:=StartBalAdjLCY - "Detailed Cust. Ledg. Entry"."Amount (LCY)";
                                until "Detailed Cust. Ledg. Entry".Next = 0;
                            "Detailed Cust. Ledg. Entry".Reset;
                        until CustomerLedgerEntry.Next = 0;
                end;
                // CurrReport.PrintonlyIfDetail :=  ExcludeBalanceOnly or (StartBalanceLCY = 0);
                //CustBalanceLCY := StartBalanceLCY + StartBalAdjLCY;
                CustBalanceLCY:=StartBalanceLCY;
            end;
            trigger OnPreDataItem()
            begin
                //Customer.SetRange("Responsibility Center", ResCen.Code);
                ResAdd:=ResCen.Address + ', ' + ResCen."Address 2" + ', ' + ResCen.City + '-' + ResCen."Post Code";
                CurrReport.NewPagePerRecord:=PrintOnlyOnePerPage;
                CurrReport.CreateTotals("Cust. Ledger Entry"."Amount (LCY)", StartBalanceLCY, Correction, ApplicationRounding);
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
    // ResCen.Get(UserMgt.GetRespCenterFilter);
    end;
    trigger OnPreReport()
    begin
        CustFilter:=Customer.GetFilters;
        CustDateFilter:=Customer.GetFilter("Date Filter");
        with "Cust. Ledger Entry" do if PrintAmountsInLCY then begin
                AmountCaption:=FieldCaption("Amount (LCY)");
                RemainingAmtCaption:=FieldCaption("Remaining Amt. (LCY)");
            end
            else
            begin
                AmountCaption:=FieldCaption(Amount);
                RemainingAmtCaption:=FieldCaption("Remaining Amount");
            end;
    end;
    var Text000: label 'Period: %1';
    VendorLedgerEntry: Record "Vendor Ledger Entry";
    VendFilter: Text[500];
    VendDateFilter: Text[50];
    VendAmount: Decimal;
    VendRemainAmount: Decimal;
    VendBalanceLCY: Decimal;
    VendEntryDueDate: Date;
    StartBalanceLCY: Decimal;
    StartBalAdjLCY: Decimal;
    Correction: Decimal;
    ApplicationRounding: Decimal;
    ExcludeBalanceOnly: Boolean;
    PrintAmountsInLCY: Boolean;
    PrintOnlyOnePerPage: Boolean;
    VendLedgEntryExists: Boolean;
    AmountCaption: Text[100];
    RemainingAmtCaption: Text[100];
    VendCurrencyCode: Code[100];
    "---MES": Decimal;
    CheckLedgerEntry: Record "Check Ledger Entry";
    CheckNo: Code[100];
    CheckDate: Date;
    CompanyInfo: Record "Company Information";
    PurchInvLine: Record "Purch. Inv. Line";
    ItemCategory: Record "Item Category";
    ItemCategoryName: Text[500];
    DimensionValue: Record "Dimension Value";
    ViewAppliedEntries: Boolean;
    BankAccount: Record "Bank Account";
    PurchCrMemoLine: Record "Purch. Cr. Memo Line";
    CustomerLedgerEntry: Record "Cust. Ledger Entry";
    CustFilter: Text[100];
    CustDateFilter: Text[100];
    CustAmount: Decimal;
    CustRemainAmount: Decimal;
    CustBalanceLCY: Decimal;
    CustEntryDueDate: Date;
    CustLedgEntryExists: Boolean;
    CustCurrencyCode: Code[100];
    SalesInvLine: Record "Sales Invoice Line";
    SalesCrMemoLine: Record "Sales Cr.Memo Line";
    TotalCustBalanceLCY: Decimal;
    Balance: Decimal;
    a: Decimal;
    TransApproxAmount: Decimal;
    ResCen: Record "Responsibility Center";
    UserMgt: Codeunit "User Setup Management";
    ResAdd: Text[500];
    SalesInvoiceHeader: Record "Sales Invoice Header";
    ExInvNo: Code[20];
    Customer_LedgerCaptionLbl: label 'Customer Ledger';
    PageCaptionLbl: label 'Page';
    All_amounts_are_in_LCYCaptionLbl: label 'All amounts are in LCY';
    BalanceCaptionLbl: label 'Balance';
    Order_No__CaptionLbl: label 'Order No. ';
    Doc__No_CaptionLbl: label 'Doc. No.';
    Posting_DateCaptionLbl: label 'Posting Date';
    DescriptionCaptionLbl: label 'Description';
    Chq__No_CaptionLbl: label 'Chq. No.';
    Chq__DateCaptionLbl: label 'Chq. Date';
    Debit_AmountCaptionLbl: label 'Debit Amount';
    Credit_AmountCaptionLbl: label 'Credit Amount';
    BalanceCaption_Control1000000025Lbl: label 'Balance';
    Credit_AmountCaption_Control1000000034Lbl: label 'Credit Amount';
    Debit_AmountCaption_Control1000000036Lbl: label 'Debit Amount';
    Chq__DateCaption_Control1000000039Lbl: label 'Chq. Date';
    DescriptionCaption_Control1000000041Lbl: label 'Description';
    Doc__No_Caption_Control1000000042Lbl: label 'Doc. No.';
    Posting_DateCaption_Control1000000043Lbl: label 'Posting Date';
    Order_No__Caption_Control1000000044Lbl: label 'Order No. ';
    Chq__No_Caption_Control1000000038Lbl: label 'Chq. No.';
    Phone_NoCaptionLbl: label 'Phone No';
    Opening_BalanceCaptionLbl: label 'Opening Balance';
    Adj__of_Opening_BalanceCaptionLbl: label 'Adj. of Opening Balance';
    Total__LCY_CaptionLbl: label 'Total (LCY)';
    Total_Adj__of_Opening_BalanceCaptionLbl: label 'Total Adj. of Opening Balance';
    Total__LCY__Before_PeriodCaptionLbl: label 'Total (LCY) Before Period';
    Total__LCY__Before_PeriodCaption_Control26Lbl: label 'Total (LCY) Before Period';
    ContinuedCaptionLbl: label 'Continued';
    EmptyStringCaptionLbl: label '/';
    EmptyStringCaption_Control1000000070Lbl: label '/';
    ContinuedCaption_Control46Lbl: label 'Continued';
    TotalCaptionLbl: label 'Total';
    TotalCaption_Control1000000002Lbl: label 'Total';
}
