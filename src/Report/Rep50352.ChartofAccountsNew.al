Report 50352 "Chart of Accounts New"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Chart of Accounts.rdl';
    Caption = 'Chart of Accounts New';
    ApplicationArea = all;
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem("G/L Account"; "G/L Account")
        {
            DataItemTableView = sorting("No.");
            RequestFilterFields = "No.", "Account Type";

            column(ReportForNavId_6710;6710)
            {
            }
            column(COMPANYNAME; COMPANYNAME)
            {
            }
            column(CurrReport_PAGENO; CurrReport.PageNo)
            {
            }
            column(G_L_Account__TABLECAPTION__________GLFilter; TableCaption + ': ' + GLFilter)
            {
            }
            column(GLFilter; GLFilter)
            {
            }
            column(Chart_of_AccountsCaption; Chart_of_AccountsCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(G_L_Account___No__Caption; FieldCaption("No."))
            {
            }
            column(PADSTR_____G_L_Account__Indentation___2___G_L_Account__NameCaption; PADSTR_____G_L_Account__Indentation___2___G_L_Account__NameCaptionLbl)
            {
            }
            column(G_L_Account___Income_Balance_Caption; G_L_Account___Income_Balance_CaptionLbl)
            {
            }
            column(G_L_Account___Account_Type_Caption; G_L_Account___Account_Type_CaptionLbl)
            {
            }
            column(G_L_Account__TotalingCaption; G_L_Account__TotalingCaptionLbl)
            {
            }
            column(G_L_Account___Gen__Posting_Type_Caption; G_L_Account___Gen__Posting_Type_CaptionLbl)
            {
            }
            column(G_L_Account___Gen__Bus__Posting_Group_Caption; G_L_Account___Gen__Bus__Posting_Group_CaptionLbl)
            {
            }
            column(G_L_Account___Gen__Prod__Posting_Group_Caption; G_L_Account___Gen__Prod__Posting_Group_CaptionLbl)
            {
            }
            column(G_L_Account___Direct_Posting_Caption; G_L_Account___Direct_Posting_CaptionLbl)
            {
            }
            column(G_L_Account___Consol__Translation_Method_Caption; G_L_Account___Consol__Translation_Method_CaptionLbl)
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
                column(G_L_Account___No__; "G/L Account"."No.")
                {
                }
                column(PADSTR_____G_L_Account__Indentation___2___G_L_Account__Name; PadStr('', "G/L Account".Indentation * 2) + "G/L Account".Name)
                {
                }
                column(G_L_Account___Income_Balance_; "G/L Account"."Income/Balance")
                {
                }
                column(G_L_Account___Account_Type_; "G/L Account"."Account Type")
                {
                }
                column(G_L_Account__Totaling; "G/L Account".Totaling)
                {
                }
                column(G_L_Account___Gen__Posting_Type_; "G/L Account"."Gen. Posting Type")
                {
                }
                column(G_L_Account___Gen__Bus__Posting_Group_; "G/L Account"."Gen. Bus. Posting Group")
                {
                }
                column(G_L_Account___Gen__Prod__Posting_Group_; "G/L Account"."Gen. Prod. Posting Group")
                {
                }
                column(G_L_Account___Direct_Posting_; "G/L Account"."Direct Posting")
                {
                }
                column(G_L_Account___Consol__Translation_Method_; "G/L Account"."Consol. Translation Method")
                {
                }
                column(G_L_Account___No__of_Blank_Lines_; "G/L Account"."No. of Blank Lines")
                {
                }
                column(PageGroupNo; PageGroupNo)
                {
                }
                column(DirectPostingTxt; DirectPostingTxt)
                {
                }
                column(CheckAccType; CheckAccType)
                {
                }
                column(AccountType; AccountType)
                {
                }
                column(ConsTransMethod; ConsTransMethod)
                {
                }
                column(IncomeBalance; IncomeBalance)
                {
                }
                column(GenPostingType; GenPostingType)
                {
                }
            }
            trigger OnAfterGetRecord()
            begin
                PageGroupNo:=NextPageGroupNo;
                if "New Page" then NextPageGroupNo:=PageGroupNo + 1;
                DirectPostingTxt:=Format("Direct Posting");
                AccountType:=Format("Account Type");
                ConsTransMethod:=Format("Consol. Translation Method");
                CheckAccType:="Account Type" = "account type"::Posting;
                IncomeBalance:=Format("Income/Balance");
                GenPostingType:=Format("Gen. Posting Type");
            end;
            trigger OnPreDataItem()
            begin
                PageGroupNo:=1;
                NextPageGroupNo:=1;
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
    trigger OnPreReport()
    begin
        GLFilter:="G/L Account".GetFilters;
    end;
    var GLFilter: Text;
    PageGroupNo: Integer;
    NextPageGroupNo: Integer;
    DirectPostingTxt: Text[30];
    CheckAccType: Boolean;
    AccountType: Text[30];
    ConsTransMethod: Text[30];
    IncomeBalance: Text[30];
    GenPostingType: Text[30];
    Chart_of_AccountsCaptionLbl: label 'Chart of Accounts';
    CurrReport_PAGENOCaptionLbl: label 'Page';
    PADSTR_____G_L_Account__Indentation___2___G_L_Account__NameCaptionLbl: label 'Name';
    G_L_Account___Income_Balance_CaptionLbl: label 'Income/Balance';
    G_L_Account___Account_Type_CaptionLbl: label 'Account Type';
    G_L_Account__TotalingCaptionLbl: label 'Totaling';
    G_L_Account___Gen__Posting_Type_CaptionLbl: label 'Gen. Posting Type';
    G_L_Account___Gen__Bus__Posting_Group_CaptionLbl: label 'Gen. Bus. Posting Group';
    G_L_Account___Gen__Prod__Posting_Group_CaptionLbl: label 'Gen. Prod. Posting Group';
    G_L_Account___Direct_Posting_CaptionLbl: label 'Direct Posting';
    G_L_Account___Consol__Translation_Method_CaptionLbl: label 'Consol. Translation Method';
}
