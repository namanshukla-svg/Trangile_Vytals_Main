Report 50348 "Trial Balance New"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Trial Balance.rdl';
    Caption = 'Trial Balance New';
    ApplicationArea = all;
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem("G/L Account"; "G/L Account")
        {
            CalcFields = "Net Change", "Balance at Date";
            DataItemTableView = sorting("No.");
            RequestFilterFields = "No.", "Account Type", "Date Filter", "Global Dimension 1 Filter", "Global Dimension 2 Filter";

            column(ReportForNavId_6710;6710)
            {
            }
            column(FORMAT_TODAY_0_4_; Format(Today, 0, 4))
            {
            }
            column(STRSUBSTNO_Text000_PeriodText_; StrSubstNo(Text000, PeriodText))
            {
            }
            column(CurrReport_PAGENO; CurrReport.PageNo)
            {
            }
            column(COMPANYNAME; COMPANYNAME)
            {
            }
            column(UserId; UserId)
            {
            }
            column(G_L_Account__TABLECAPTION__________GLFilter; TableCaption + ': ' + GLFilter)
            {
            }
            column(GLFilter; GLFilter)
            {
            }
            column(PrintToExcel; PrintToExcel)
            {
            }
            column(EmptyString;'')
            {
            }
            column(EmptyString_Control12;'')
            {
            }
            column(TotalDebitNetChange; TotalDebitNetChange)
            {
            }
            column(TotalCreditNetChange; TotalCreditNetChange)
            {
            }
            column(TotalDebitBalanceAtDate; TotalDebitBalanceAtDate)
            {
            }
            column(TotalCreditBalanceAtDate; TotalCreditBalanceAtDate)
            {
            }
            column(G_L_Account_No_; "No.")
            {
            }
            column(Trial_BalanceCaption; Trial_BalanceCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(Net_ChangeCaption; Net_ChangeCaptionLbl)
            {
            }
            column(BalanceCaption; BalanceCaptionLbl)
            {
            }
            column(G_L_Account___No__Caption; FieldCaption("No."))
            {
            }
            column(PADSTR_____G_L_Account__Indentation___2___G_L_Account__NameCaption; PADSTR_____G_L_Account__Indentation___2___G_L_Account__NameCaptionLbl)
            {
            }
            column(G_L_Account___Net_Change_Caption; G_L_Account___Net_Change_CaptionLbl)
            {
            }
            column(G_L_Account___Net_Change__Control22Caption; G_L_Account___Net_Change__Control22CaptionLbl)
            {
            }
            column(G_L_Account___Balance_at_Date_Caption; G_L_Account___Balance_at_Date_CaptionLbl)
            {
            }
            column(G_L_Account___Balance_at_Date__Control24Caption; G_L_Account___Balance_at_Date__Control24CaptionLbl)
            {
            }
            column(TOTALSCaption; TOTALSCaptionLbl)
            {
            }
            dataitem("Integer"; "Integer")
            {
                DataItemTableView = sorting(Number)where(Number=const(1));

                column(ReportForNavId_5444;5444)
                {
                }
                column(G_L_Account___No__; "G/L Account"."No.")
                {
                }
                column(PADSTR_____G_L_Account__Indentation___2___G_L_Account__Name; PadStr('', "G/L Account".Indentation * 2) + "G/L Account".Name)
                {
                }
                column(G_L_Account___Net_Change_; "G/L Account"."Net Change")
                {
                }
                column(G_L_Account___Net_Change__Control22;-"G/L Account"."Net Change")
                {
                AutoFormatType = 1;
                }
                column(G_L_Account___Balance_at_Date_; "G/L Account"."Balance at Date")
                {
                }
                column(G_L_Account___Balance_at_Date__Control24;-"G/L Account"."Balance at Date")
                {
                AutoFormatType = 1;
                }
                column(G_L_Account___No___Control25; "G/L Account"."No.")
                {
                }
                column(PADSTR_____G_L_Account__Indentation___2_____G_L_Account__Name; PadStr('', "G/L Account".Indentation * 2) + "G/L Account".Name)
                {
                }
                column(G_L_Account___Net_Change__Control27; "G/L Account"."Net Change")
                {
                }
                column(G_L_Account___Net_Change__Control28;-"G/L Account"."Net Change")
                {
                AutoFormatType = 1;
                }
                column(G_L_Account___Balance_at_Date__Control29; "G/L Account"."Balance at Date")
                {
                }
                column(G_L_Account___Balance_at_Date__Control30;-"G/L Account"."Balance at Date")
                {
                AutoFormatType = 1;
                }
                column(G_L_Account___Account_Type_; Format("G/L Account"."Account Type", 0, 2))
                {
                }
                column(No__of_Blank_Lines; "G/L Account"."No. of Blank Lines")
                {
                }
                column(GroupNum; GroupNum)
                {
                }
                column(Integer_Number; Number)
                {
                }
                dataitem(BlankLineRepeater; "Integer")
                {
                    DataItemTableView = sorting(Number);

                    column(ReportForNavId_7;7)
                    {
                    }
                    column(BlankLineNo; BlankLineNo)
                    {
                    }
                    trigger OnAfterGetRecord()
                    begin
                        if BlankLineNo = 0 then CurrReport.Break;
                        BlankLineNo-=1;
                    end;
                }
                trigger OnAfterGetRecord()
                begin
                    BlankLineNo:="G/L Account"."No. of Blank Lines" + 1;
                end;
            }
            trigger OnAfterGetRecord()
            begin
                CalcFields("Net Change", "Balance at Date");
                if PrintToExcel then MakeExcelDataBody;
                if("G/L Account"."Account Type" = "G/L Account"."account type"::Posting)then begin
                    if "Balance at Date" > 0 then TotalDebitBalanceAtDate:=TotalDebitBalanceAtDate + "G/L Account"."Balance at Date"
                    else
                        TotalCreditBalanceAtDate:=TotalCreditBalanceAtDate - "G/L Account"."Balance at Date";
                    if "Net Change" > 0 then TotalDebitNetChange:=TotalDebitNetChange + "G/L Account"."Net Change"
                    else
                        TotalCreditNetChange:=TotalCreditNetChange - "G/L Account"."Net Change";
                end;
                if not PrintToExcel then begin
                    if LastNewPage then GroupNum:=GroupNum + 1;
                    LastNewPage:="New Page";
                end;
            end;
            trigger OnPostDataItem()
            begin
                if PrintToExcel then begin
                    ExcelBuf.NewRow;
                    ExcelBuf.AddColumn('TOTALS', false, '', true, false, false, '', ExcelBuf."cell type"::Text);
                    ExcelBuf.AddColumn('', false, '', true, false, false, '', ExcelBuf."cell type"::Text);
                    ExcelBuf.AddColumn(TotalDebitNetChange, false, '', true, false, false, '', ExcelBuf."cell type"::Number);
                    ExcelBuf.AddColumn(TotalCreditNetChange, false, '', true, false, false, '', ExcelBuf."cell type"::Number);
                    ExcelBuf.AddColumn(TotalDebitBalanceAtDate, false, '', true, false, false, '', ExcelBuf."cell type"::Number);
                    ExcelBuf.AddColumn(TotalCreditBalanceAtDate, false, '', true, false, false, '', ExcelBuf."cell type"::Number);
                end;
            end;
        }
    }
    requestpage
    {
        layout
        {
            area(content)
            {
                group(Options)
                {
                    Caption = 'Options';

                    field(PrintToExcel; PrintToExcel)
                    {
                        ApplicationArea = Basic;
                        Caption = 'Print to Excel';
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
    }
    trigger OnPostReport()
    begin
    // if PrintToExcel then
    //     CreateExcelbook;
    end;
    trigger OnPreReport()
    begin
        GLFilter:="G/L Account".GetFilters;
        PeriodText:="G/L Account".GetFilter("Date Filter");
        if PrintToExcel then MakeExcelInfo;
    end;
    var Text000: label 'Period: %1';
    ExcelBuf: Record "Excel Buffer" temporary;
    GLFilter: Text;
    PeriodText: Text[30];
    PrintToExcel: Boolean;
    Text001: label 'Trial Balance';
    Text003: label 'Debit';
    Text004: label 'Credit';
    Text005: label 'Company Name';
    Text006: label 'Report No.';
    Text007: label 'Report Name';
    Text008: label 'User ID';
    Text009: label 'Date';
    Text010: label 'G/L Filter';
    Text011: label 'Period Filter';
    TotalDebitNetChange: Decimal;
    TotalCreditNetChange: Decimal;
    TotalDebitBalanceAtDate: Decimal;
    TotalCreditBalanceAtDate: Decimal;
    NewTotalDebitNetChange: Decimal;
    NewTotalCreditNetChange: Decimal;
    NewTotalDebitBalanceAtDate: Decimal;
    NewTotalCreditBalanceAtDate: Decimal;
    GroupNum: Integer;
    LastNewPage: Boolean;
    Trial_BalanceCaptionLbl: label 'Trial Balance';
    CurrReport_PAGENOCaptionLbl: label 'Page';
    Net_ChangeCaptionLbl: label 'Net Change';
    BalanceCaptionLbl: label 'Balance';
    PADSTR_____G_L_Account__Indentation___2___G_L_Account__NameCaptionLbl: label 'Name';
    G_L_Account___Net_Change_CaptionLbl: label 'Debit';
    G_L_Account___Net_Change__Control22CaptionLbl: label 'Credit';
    G_L_Account___Balance_at_Date_CaptionLbl: label 'Debit';
    G_L_Account___Balance_at_Date__Control24CaptionLbl: label 'Credit';
    TOTALSCaptionLbl: label 'TOTALS';
    BlankLineNo: Integer;
    procedure MakeExcelInfo()
    begin
        ExcelBuf.SetUseInfoSheet;
        ExcelBuf.AddInfoColumn(Format(Text005), false, true, false, false, '', ExcelBuf."cell type"::Text);
        ExcelBuf.AddInfoColumn(COMPANYNAME, false, false, false, false, '', ExcelBuf."cell type"::Text);
        ExcelBuf.NewRow;
        ExcelBuf.AddInfoColumn(Format(Text007), false, true, false, false, '', ExcelBuf."cell type"::Text);
        ExcelBuf.AddInfoColumn(Format(Text001), false, false, false, false, '', ExcelBuf."cell type"::Text);
        ExcelBuf.NewRow;
        ExcelBuf.AddInfoColumn(Format(Text006), false, true, false, false, '', ExcelBuf."cell type"::Text);
        ExcelBuf.AddInfoColumn(Report::"Trial Balance", false, false, false, false, '', ExcelBuf."cell type"::Number);
        ExcelBuf.NewRow;
        ExcelBuf.AddInfoColumn(Format(Text008), false, true, false, false, '', ExcelBuf."cell type"::Text);
        ExcelBuf.AddInfoColumn(UserId, false, false, false, false, '', ExcelBuf."cell type"::Text);
        ExcelBuf.NewRow;
        ExcelBuf.AddInfoColumn(Format(Text009), false, true, false, false, '', ExcelBuf."cell type"::Text);
        ExcelBuf.AddInfoColumn(Today, false, false, false, false, '', ExcelBuf."cell type"::Date);
        ExcelBuf.NewRow;
        ExcelBuf.AddInfoColumn(Format(Text010), false, true, false, false, '', ExcelBuf."cell type"::Text);
        ExcelBuf.AddInfoColumn("G/L Account".GetFilter("No."), false, false, false, false, '', ExcelBuf."cell type"::Text);
        ExcelBuf.NewRow;
        ExcelBuf.AddInfoColumn(Format(Text011), false, true, false, false, '', ExcelBuf."cell type"::Text);
        ExcelBuf.AddInfoColumn("G/L Account".GetFilter("Date Filter"), false, false, false, false, '', ExcelBuf."cell type"::Text);
        ExcelBuf.ClearNewRow;
        MakeExcelDataHeader;
    end;
    local procedure MakeExcelDataHeader()
    begin
        ExcelBuf.AddColumn("G/L Account".FieldCaption("No."), false, '', true, false, true, '', ExcelBuf."cell type"::Text);
        ExcelBuf.AddColumn("G/L Account".FieldCaption(Name), false, '', true, false, true, '', ExcelBuf."cell type"::Text);
        ExcelBuf.AddColumn(Format("G/L Account".FieldCaption("Net Change") + ' - ' + Text003), false, '', true, false, true, '', ExcelBuf."cell type"::Text);
        ExcelBuf.AddColumn(Format("G/L Account".FieldCaption("Net Change") + ' - ' + Text004), false, '', true, false, true, '', ExcelBuf."cell type"::Text);
        ExcelBuf.AddColumn(Format("G/L Account".FieldCaption("Balance at Date") + ' - ' + Text003), false, '', true, false, true, '', ExcelBuf."cell type"::Text);
        ExcelBuf.AddColumn(Format("G/L Account".FieldCaption("Balance at Date") + ' - ' + Text004), false, '', true, false, true, '', ExcelBuf."cell type"::Text);
    end;
    procedure MakeExcelDataBody()
    var
        BlankFiller: Text[250];
    begin
        BlankFiller:=PadStr(' ', MaxStrLen(BlankFiller), ' ');
        ExcelBuf.NewRow;
        ExcelBuf.AddColumn("G/L Account"."No.", false, '', "G/L Account"."Account Type" <> "G/L Account"."account type"::Posting, false, false, '', ExcelBuf."cell type"::Text);
        if "G/L Account".Indentation = 0 then ExcelBuf.AddColumn("G/L Account".Name, false, '', "G/L Account"."Account Type" <> "G/L Account"."account type"::Posting, false, false, '', ExcelBuf."cell type"::Text)
        else
            ExcelBuf.AddColumn(CopyStr(BlankFiller, 1, 2 * "G/L Account".Indentation) + "G/L Account".Name, false, '', "G/L Account"."Account Type" <> "G/L Account"."account type"::Posting, false, false, '', ExcelBuf."cell type"::Text);
        case true of "G/L Account"."Net Change" = 0: begin
            ExcelBuf.AddColumn('', false, '', "G/L Account"."Account Type" <> "G/L Account"."account type"::Posting, false, false, '', ExcelBuf."cell type"::Text);
            ExcelBuf.AddColumn('', false, '', "G/L Account"."Account Type" <> "G/L Account"."account type"::Posting, false, false, '', ExcelBuf."cell type"::Text);
        end;
        "G/L Account"."Net Change" > 0: begin
            ExcelBuf.AddColumn("G/L Account"."Net Change", false, '', "G/L Account"."Account Type" <> "G/L Account"."account type"::Posting, false, false, '#,##0.00', ExcelBuf."cell type"::Number);
            ExcelBuf.AddColumn('', false, '', "G/L Account"."Account Type" <> "G/L Account"."account type"::Posting, false, false, '', ExcelBuf."cell type"::Text);
        end;
        "G/L Account"."Net Change" < 0: begin
            ExcelBuf.AddColumn('', false, '', "G/L Account"."Account Type" <> "G/L Account"."account type"::Posting, false, false, '', ExcelBuf."cell type"::Text);
            ExcelBuf.AddColumn(-"G/L Account"."Net Change", false, '', "G/L Account"."Account Type" <> "G/L Account"."account type"::Posting, false, false, '#,##0.00', ExcelBuf."cell type"::Number);
        end;
        end;
        case true of "G/L Account"."Balance at Date" = 0: begin
            ExcelBuf.AddColumn('', false, '', "G/L Account"."Account Type" <> "G/L Account"."account type"::Posting, false, false, '', ExcelBuf."cell type"::Text);
            ExcelBuf.AddColumn('', false, '', "G/L Account"."Account Type" <> "G/L Account"."account type"::Posting, false, false, '', ExcelBuf."cell type"::Text);
        end;
        "G/L Account"."Balance at Date" > 0: begin
            ExcelBuf.AddColumn("G/L Account"."Balance at Date", false, '', "G/L Account"."Account Type" <> "G/L Account"."account type"::Posting, false, false, '#,##0.00', ExcelBuf."cell type"::Number);
            ExcelBuf.AddColumn('', false, '', "G/L Account"."Account Type" <> "G/L Account"."account type"::Posting, false, false, '', ExcelBuf."cell type"::Text);
        end;
        "G/L Account"."Balance at Date" < 0: begin
            ExcelBuf.AddColumn('', false, '', "G/L Account"."Account Type" <> "G/L Account"."account type"::Posting, false, false, '', ExcelBuf."cell type"::Text);
            ExcelBuf.AddColumn(-"G/L Account"."Balance at Date", false, '', "G/L Account"."Account Type" <> "G/L Account"."account type"::Posting, false, false, '#,##0.00', ExcelBuf."cell type"::Number);
        end;
        end;
    end;
// procedure CreateExcelbook()
// begin
//     ExcelBuf.CreateBookAndOpenExcel('', Text001, '', COMPANYNAME, UserId);
//     Error('');
// end;
}
