Report 50349 "Detail Trial Balance New"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Detail Trial Balance.rdl';
    Caption = 'Detail Trial Balance New';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = all;

    dataset
    {
        dataitem("G/L Account"; "G/L Account")
        {
            DataItemTableView = where("Account Type"=const(Posting));
            // PrintOnlyIfDetail = true;
            RequestFilterFields = "No.", "Search Name", "Income/Balance", "Debit/Credit", "Date Filter";

            column(ReportForNavId_6710;6710)
            {
            }
            column(PeriodGLDtFilter; StrSubstNo(Text000, GLDateFilter))
            {
            }
            column(CompanyName; COMPANYNAME)
            {
            }
            column(ExcludeBalanceOnly; ExcludeBalanceOnly)
            {
            }
            column(PrintReversedEntries; PrintReversedEntries)
            {
            }
            column(PageGroupNo; PageGroupNo)
            {
            }
            column(PrintClosingEntries; PrintClosingEntries)
            {
            }
            column(PrintOnlyCorrections; PrintOnlyCorrections)
            {
            }
            column(GLAccTableCaption; TableCaption + ': ' + GLFilter)
            {
            }
            column(GLFilter; GLFilter)
            {
            }
            column(EmptyString;'')
            {
            }
            column(No_GLAcc; "No.")
            {
            }
            column(DetailTrialBalCaption; DetailTrialBalCaptionLbl)
            {
            }
            column(PageCaption; PageCaptionLbl)
            {
            }
            column(BalanceCaption; BalanceCaptionLbl)
            {
            }
            column(PeriodCaption; PeriodCaptionLbl)
            {
            }
            column(OnlyCorrectionsCaption; OnlyCorrectionsCaptionLbl)
            {
            }
            column(NetChangeCaption; NetChangeCaptionLbl)
            {
            }
            column(GLEntryDebitAmtCaption; GLEntryDebitAmtCaptionLbl)
            {
            }
            column(GLEntryCreditAmtCaption; GLEntryCreditAmtCaptionLbl)
            {
            }
            column(GLBalCaption; GLBalCaptionLbl)
            {
            }
            dataitem(PageCounter; "Integer")
            {
                DataItemTableView = sorting(Number)where(Number=const(1));

                column(ReportForNavId_8098;8098)
                {
                }
                column(Name_GLAcc; "G/L Account".Name)
                {
                }
                column(StartBalance; StartBalance)
                {
                AutoFormatType = 1;
                }
                dataitem("G/L Entry"; "G/L Entry")
                {
                    DataItemLink = "G/L Account No."=field("No."), "Posting Date"=field("Date Filter"), "Global Dimension 1 Code"=field("Global Dimension 1 Filter"), "Global Dimension 2 Code"=field("Global Dimension 2 Filter"), "Business Unit Code"=field("Business Unit Filter");
                    DataItemLinkReference = "G/L Account";
                    DataItemTableView = sorting("G/L Account No.", "Posting Date");

                    column(ReportForNavId_7069;7069)
                    {
                    }
                    column(VATAmount_GLEntry; "VAT Amount")
                    {
                    IncludeCaption = true;
                    }
                    column(DebitAmount_GLEntry; "Debit Amount")
                    {
                    }
                    column(CreditAmount_GLEntry; "Credit Amount")
                    {
                    }
                    column(PostingDate_GLEntry; "Posting Date")
                    {
                    }
                    column(DocumentNo_GLEntry; "Document No.")
                    {
                    }
                    column(Description_GLEntry; Description)
                    {
                    }
                    column(GLBalance; GLBalance)
                    {
                    AutoFormatType = 1;
                    }
                    column(EntryNo_GLEntry; "Entry No.")
                    {
                    }
                    column(ClosingEntry; ClosingEntry)
                    {
                    }
                    column(Reversed_GLEntry; Reversed)
                    {
                    }
                    trigger OnAfterGetRecord()
                    begin
                        if PrintOnlyCorrections then if not(("Debit Amount" < 0) or ("Credit Amount" < 0))then CurrReport.Skip;
                        if not PrintReversedEntries and Reversed then CurrReport.Skip;
                        GLBalance:=GLBalance + Amount;
                        if("Posting Date" = ClosingDate("Posting Date")) and not PrintClosingEntries then begin
                            "Debit Amount":=0;
                            "Credit Amount":=0;
                        end;
                        if "Posting Date" = ClosingDate("Posting Date")then ClosingEntry:=true
                        else
                            ClosingEntry:=false;
                    end;
                    trigger OnPreDataItem()
                    begin
                        GLBalance:=StartBalance;
                        CurrReport.CreateTotals(Amount, "Debit Amount", "Credit Amount", "VAT Amount");
                    end;
                }
                trigger OnAfterGetRecord()
                begin
                // CurrReport.PrintonlyIfDetail := ExcludeBalanceOnly or (StartBalance = 0);
                end;
            }
            trigger OnAfterGetRecord()
            var
                Date: Record Date;
            begin
                StartBalance:=0;
                if GLDateFilter <> '' then begin
                    Date.SetRange("Period Type", Date."period type"::Date);
                    Date.SetFilter("Period Start", GLDateFilter);
                    if Date.FindFirst then begin
                        SetRange("Date Filter", 0D, ClosingDate(Date."Period Start" - 1));
                        CalcFields("Net Change");
                        StartBalance:="Net Change";
                        SetFilter("Date Filter", GLDateFilter);
                    end;
                end;
                if PrintOnlyOnePerPage then begin
                    GLEntryPage.Reset;
                    GLEntryPage.SetRange("G/L Account No.", "No.");
                    if GLEntryPage.FindFirst then PageGroupNo:=PageGroupNo + 1;
                end;
            end;
            trigger OnPreDataItem()
            begin
                PageGroupNo:=1;
                CurrReport.NewPagePerRecord:=PrintOnlyOnePerPage;
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

                    field(NewPageperGLAcc; PrintOnlyOnePerPage)
                    {
                        ApplicationArea = Basic;
                        Caption = 'New Page per G/L Acc.';
                    }
                    field(ExcludeGLAccsHaveBalanceOnly; ExcludeBalanceOnly)
                    {
                        ApplicationArea = Basic;
                        Caption = 'Exclude G/L Accs. That Have a Balance Only';
                        MultiLine = true;
                    }
                    field(InclClosingEntriesWithinPeriod; PrintClosingEntries)
                    {
                        ApplicationArea = Basic;
                        Caption = 'Include Closing Entries Within the Period';
                        MultiLine = true;
                    }
                    field(IncludeReversedEntries; PrintReversedEntries)
                    {
                        ApplicationArea = Basic;
                        Caption = 'Include Reversed Entries';
                    }
                    field(PrintCorrectionsOnly; PrintOnlyCorrections)
                    {
                        ApplicationArea = Basic;
                        Caption = 'Print Corrections Only';
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
    PostingDateCaption='Posting Date';
    DocNoCaption='Document No.';
    DescCaption='Description';
    VATAmtCaption='VAT Amount';
    EntryNoCaption='Entry No.';
    }
    trigger OnPreReport()
    begin
        GLFilter:="G/L Account".GetFilters;
        GLDateFilter:="G/L Account".GetFilter("Date Filter");
    end;
    var Text000: label 'Period: %1';
    GLDateFilter: Text[30];
    GLFilter: Text;
    GLBalance: Decimal;
    StartBalance: Decimal;
    PrintOnlyOnePerPage: Boolean;
    ExcludeBalanceOnly: Boolean;
    PrintClosingEntries: Boolean;
    PrintOnlyCorrections: Boolean;
    PrintReversedEntries: Boolean;
    PageGroupNo: Integer;
    GLEntryPage: Record "G/L Entry";
    ClosingEntry: Boolean;
    DetailTrialBalCaptionLbl: label 'Detail Trial Balance';
    PageCaptionLbl: label 'Page';
    BalanceCaptionLbl: label 'This also includes general ledger accounts that only have a balance.';
    PeriodCaptionLbl: label 'This report also includes closing entries within the period.';
    OnlyCorrectionsCaptionLbl: label 'Only corrections are included.';
    NetChangeCaptionLbl: label 'Net Change';
    GLEntryDebitAmtCaptionLbl: label 'Debit';
    GLEntryCreditAmtCaptionLbl: label 'Credit';
    GLBalCaptionLbl: label 'Balance';
    procedure InitializeRequest(NewPrintOnlyOnePerPage: Boolean; NewExcludeBalanceOnly: Boolean; NewPrintClosingEntries: Boolean; NewPrintReversedEntries: Boolean; NewPrintOnlyCorrections: Boolean)
    begin
        PrintOnlyOnePerPage:=NewPrintOnlyOnePerPage;
        ExcludeBalanceOnly:=NewExcludeBalanceOnly;
        PrintClosingEntries:=NewPrintClosingEntries;
        PrintReversedEntries:=NewPrintReversedEntries;
        PrintOnlyCorrections:=NewPrintOnlyCorrections;
    end;
}
