Report 50356 "Budget New"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Budget.rdl';
    Caption = 'Budget New';
    ApplicationArea = all;
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem("G/L Account"; "G/L Account")
        {
            DataItemTableView = sorting("No.");
            RequestFilterFields = "No.", "Account Type", "Budget Filter", "Global Dimension 1 Filter", "Global Dimension 2 Filter";

            column(ReportForNavId_6710;6710)
            {
            }
            column(CompanyName; COMPANYNAME)
            {
            }
            column(GLBudgetFilter; GLBudgetFilter)
            {
            }
            column(NoOfBlankLines_GLAcc; "No. of Blank Lines")
            {
            }
            column(AmtsInThousands; InThousands)
            {
            }
            column(GLFilterTableCaption_GLAcc; TableCaption + ': ' + GLFilter)
            {
            }
            column(GLFilter; GLFilter)
            {
            }
            column(Type_GLAcc; "Account Type")
            {
            }
            column(AccountTypePosting; GLAccountTypePosting)
            {
            }
            column(PeriodStartDate1; Format(PeriodStartDate[1]))
            {
            }
            column(PeriodStartDate2; Format(PeriodStartDate[2]))
            {
            }
            column(PeriodStartDate3; Format(PeriodStartDate[3]))
            {
            }
            column(PeriodStartDate4; Format(PeriodStartDate[4]))
            {
            }
            column(PeriodStartDate5; Format(PeriodStartDate[5]))
            {
            }
            column(PeriodStartDate6; Format(PeriodStartDate[6]))
            {
            }
            column(PeriodStartDate21; Format(PeriodStartDate[2] - 1))
            {
            }
            column(PeriodStartDate31; Format(PeriodStartDate[3] - 1))
            {
            }
            column(PeriodStartDate41; Format(PeriodStartDate[4] - 1))
            {
            }
            column(PeriodStartDate51; Format(PeriodStartDate[5] - 1))
            {
            }
            column(PeriodStartDate61; Format(PeriodStartDate[6] - 1))
            {
            }
            column(PeriodStartDate71; Format(PeriodStartDate[7] - 1))
            {
            }
            column(No_GLAcc; "No.")
            {
            IncludeCaption = true;
            }
            column(BudgetCaption; BudgetCaptionLbl)
            {
            }
            column(PageCaption; PageCaptionLbl)
            {
            }
            column(BudgetFilterCaption; BudgetFilterCaptionLbl)
            {
            }
            column(AmtsAreInwhole1000sCaptn; AmtsAreInwhole1000sCaptnLbl)
            {
            }
            column(GLAccNameCaption; GLAccNameCaptionLbl)
            {
            }
            dataitem(BlankLineCounter; "Integer")
            {
                DataItemTableView = sorting(Number);

                column(ReportForNavId_8412;8412)
                {
                }
                trigger OnPreDataItem()
                begin
                    SetRange(Number, 1, "G/L Account"."No. of Blank Lines");
                end;
            }
            dataitem("Integer"; "Integer")
            {
                DataItemTableView = sorting(Number)where(Number=const(1));

                column(ReportForNavId_5444;5444)
                {
                }
                column(GLAccNo_BlankLineCounter; "G/L Account"."No.")
                {
                IncludeCaption = true;
                }
                column(PADSTRIndentName_GLAcc; PadStr('', "G/L Account".Indentation * 2) + "G/L Account".Name)
                {
                }
                column(GLBudgetedAmount1; GLBudgetedAmount[1])
                {
                DecimalPlaces = 0: 0;
                }
                column(GLBudgetedAmount2; GLBudgetedAmount[2])
                {
                DecimalPlaces = 0: 0;
                }
                column(GLBudgetedAmount3; GLBudgetedAmount[3])
                {
                DecimalPlaces = 0: 0;
                }
                column(GLBudgetedAmount4; GLBudgetedAmount[4])
                {
                DecimalPlaces = 0: 0;
                }
                column(GLBudgetedAmount5; GLBudgetedAmount[5])
                {
                DecimalPlaces = 0: 0;
                }
                column(GLBudgetedAmount6; GLBudgetedAmount[6])
                {
                DecimalPlaces = 0: 0;
                }
            }
            trigger OnAfterGetRecord()
            begin
                for i:=1 to 6 do begin
                    SetRange("Date Filter", PeriodStartDate[i], PeriodStartDate[i + 1] - 1);
                    CalcFields("Budgeted Amount");
                    if InThousands then "Budgeted Amount":="Budgeted Amount" / 1000;
                    GLBudgetedAmount[i]:=ROUND("Budgeted Amount", 1);
                end;
                SetRange("Date Filter", PeriodStartDate[1], PeriodStartDate[7] - 1);
                GLAccountTypePosting:="Account Type" = "account type"::Posting;
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

                    field(StartingDate; PeriodStartDate[1])
                    {
                        ApplicationArea = Basic;
                        Caption = 'Starting Date';
                    }
                    field(PeriodLength; PeriodLength)
                    {
                        ApplicationArea = Basic;
                        Caption = 'Period Length';
                    }
                    field(InThousands; InThousands)
                    {
                        ApplicationArea = Basic;
                        Caption = 'Amounts in whole 1000s';
                    }
                }
            }
        }
        actions
        {
        }
        trigger OnOpenPage()
        begin
            if PeriodStartDate[1] = 0D then PeriodStartDate[1]:=WorkDate;
            if Format(PeriodLength) = '' then Evaluate(PeriodLength, '<1M>');
        end;
    }
    labels
    {
    }
    trigger OnPreReport()
    begin
        GLFilter:="G/L Account".GetFilters;
        GLBudgetFilter:="G/L Account".GetFilter("Budget Filter");
        for i:=2 to 7 do PeriodStartDate[i]:=CalcDate(PeriodLength, PeriodStartDate[i - 1]);
    end;
    var InThousands: Boolean;
    GLFilter: Text;
    GLBudgetFilter: Text[250];
    PeriodLength: DateFormula;
    GLBudgetedAmount: array[6]of Decimal;
    PeriodStartDate: array[7]of Date;
    i: Integer;
    BudgetCaptionLbl: label 'Budget';
    PageCaptionLbl: label 'Page';
    BudgetFilterCaptionLbl: label 'Budget Filter';
    AmtsAreInwhole1000sCaptnLbl: label 'Amounts are in whole 1000s.';
    GLAccNameCaptionLbl: label 'Name';
    GLAccountTypePosting: Boolean;
    procedure InitializeRequest(NewPeriodStartDate: Date; NewPeriodLength: Text[30]; NewInThousands: Boolean)
    begin
        PeriodStartDate[1]:=NewPeriodStartDate;
        Evaluate(PeriodLength, NewPeriodLength);
        InThousands:=NewInThousands;
    end;
}
