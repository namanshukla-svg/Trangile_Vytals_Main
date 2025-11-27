Report 50357 "Closing Trial Balance New"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Closing Trial Balance.rdl';
    Caption = 'Closing Trial Balance New';
    ApplicationArea = all;
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem("G/L Account"; "G/L Account")
        {
            DataItemTableView = sorting("No.");
            RequestFilterFields = "No.", "Account Type", "Global Dimension 1 Filter", "Global Dimension 2 Filter";

            column(ReportForNavId_6710;6710)
            {
            }
            column(PeriodText; StrSubstNo(Text001, PeriodText))
            {
            }
            column(CompanyName; COMPANYNAME)
            {
            }
            column(GLAccGLFilter; TableCaption + ': ' + GLFilter)
            {
            }
            column(GLFilter; GLFilter)
            {
            }
            column(UseAmtsInAddCurr; UseAmtsInAddCurr)
            {
            }
            column(AllAmountsIn; AllAmountsInLbl)
            {
            }
            column(LCYcode; GLSetup."LCY Code")
            {
            }
            column(AddreportingCurrency; GLSetup."Additional Reporting Currency")
            {
            }
            dataitem("Integer"; "Integer")
            {
                DataItemTableView = sorting(Number)where(Number=const(1));

                column(ReportForNavId_5444;5444)
                {
                }
                column(No_GLAccount; "G/L Account"."No.")
                {
                IncludeCaption = true;
                }
                column(GLAccName; PadStr('', "G/L Account".Indentation * 2) + "G/L Account".Name)
                {
                }
                column(FiscalYearBalance; FiscalYearBalance)
                {
                AutoFormatExpression = GetCurrency;
                AutoFormatType = 1;
                }
                column(NegFiscalYearBalance;-FiscalYearBalance)
                {
                AutoFormatExpression = GetCurrency;
                AutoFormatType = 1;
                }
                column(LastYearBalance; LastYearBalance)
                {
                AutoFormatExpression = GetCurrency;
                AutoFormatType = 1;
                }
                column(NegLastYearBalance;-LastYearBalance)
                {
                AutoFormatExpression = GetCurrency;
                AutoFormatType = 1;
                }
                column(NoBlankLines_GLAccount; "G/L Account"."No. of Blank Lines")
                {
                }
                column(AccountType_GLAccount; "G/L Account"."Account Type")
                {
                }
                column(AccountTypePosting; GLAccountTypePosting)
                {
                }
                column(PageGroupNo; PageGroupNo)
                {
                }
            }
            trigger OnAfterGetRecord()
            begin
                PageGroupNo:=NextPageGroupNo;
                if "New Page" then NextPageGroupNo:=PageGroupNo + 1;
                if "Income/Balance" = "income/balance"::"Income Statement" then SetRange("Date Filter", FiscalYearStartDate, FiscalYearEndDate)
                else
                    SetRange("Date Filter", 0D, ClosingDate(FiscalYearEndDate));
                CalcFields("Net Change", "Additional-Currency Net Change");
                if UseAmtsInAddCurr then FiscalYearBalance:="Additional-Currency Net Change"
                else
                    FiscalYearBalance:="Net Change";
                if "Income/Balance" = "income/balance"::"Income Statement" then SetRange("Date Filter", 0D, FiscalYearStartDate - 1)
                else
                    SetRange("Date Filter", 0D, ClosingDate(FiscalYearStartDate - 1));
                CalcFields("Net Change", "Additional-Currency Net Change");
                if UseAmtsInAddCurr then LastYearBalance:="Additional-Currency Net Change"
                else
                    LastYearBalance:="Net Change";
                GLAccountTypePosting:="Account Type" = "account type"::Posting;
            end;
            trigger OnPreDataItem()
            begin
                PageGroupNo:=1;
                NextPageGroupNo:=1;
                GLSetup.Get;
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
                group(Options)
                {
                    Caption = 'Options';

                    field(StartingDate; FiscalYearStartDate)
                    {
                        ApplicationArea = Basic;
                        Caption = 'Fiscal Year Starting Date';
                    }
                    field(AmtsInAddCurr; UseAmtsInAddCurr)
                    {
                        ApplicationArea = Basic;
                        Caption = 'Show Amounts in Add. Reporting Currency';
                        MultiLine = true;
                    }
                }
            }
        }
        actions
        {
        }
    }
    labels
    {
    ClosingTrialBalanceCaption='Closing Trial Balance';
    PageNoCaption='Page';
    ThisYearCaption='This Year';
    LastYearCaption='Last Year';
    NameCaption='Name';
    DebitCaption='Debit';
    CreditCaption='Credit';
    }
    trigger OnPreReport()
    begin
        GLFilter:="G/L Account".GetFilters;
        if FiscalYearStartDate = 0D then Error(Text000);
        AccountingPeriod.SetRange("New Fiscal Year", true);
        AccountingPeriod."Starting Date":=FiscalYearStartDate;
        AccountingPeriod.Find;
        AccountingPeriod.Next(1);
        FiscalYearEndDate:=AccountingPeriod."Starting Date" - 1;
        "G/L Account".SetRange("Date Filter", FiscalYearStartDate, FiscalYearEndDate);
        PeriodText:="G/L Account".GetFilter("Date Filter");
    end;
    var Text000: label 'Enter the starting date for the fiscal year.';
    Text001: label 'Period: %1';
    AccountingPeriod: Record "Accounting Period";
    GLSetup: Record "General Ledger Setup";
    FiscalYearStartDate: Date;
    FiscalYearEndDate: Date;
    PeriodText: Text[30];
    GLFilter: Text;
    FiscalYearBalance: Decimal;
    LastYearBalance: Decimal;
    UseAmtsInAddCurr: Boolean;
    PageGroupNo: Integer;
    NextPageGroupNo: Integer;
    AllAmountsInLbl: label 'All amounts are in';
    GLAccountTypePosting: Boolean;
    local procedure GetCurrency(): Code[10]begin
        if UseAmtsInAddCurr then exit(GLSetup."Additional Reporting Currency");
        exit('');
    end;
    procedure InitializeRequest(NewFiscalYearStartDate: Date; NewUseAmtsInAddCurr: Boolean)
    begin
        FiscalYearStartDate:=NewFiscalYearStartDate;
        UseAmtsInAddCurr:=NewUseAmtsInAddCurr;
    end;
}
