Report 50072 "TDS Report(Salary)"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/TDS Report(Salary).rdl';
    ApplicationArea = all;
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem("Dimension Value"; "Dimension Value")
        {
            DataItemTableView = sorting("Dimension Code", Code)where("Dimension Code"=const('EMPLOYEE'));
            PrintOnlyIfDetail = true;
            RequestFilterFields = "Code";

            column(ReportForNavId_1000000031;1000000031)
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
            column(Salary_;'Salary')
            {
            }
            column(ResCen__Address_2_1; ResCen."Address 2")
            {
            }
            column(ResCen_Address1; ResCen.Address)
            {
            }
            column(ResCen_Name1; ResCen.Name)
            {
            }
            column(ResCen_City_______ResCen__Post_Code_1; ResCen.City + ' - ' + ResCen."Post Code")
            {
            }
            column(ResCen_State1; ResCen.State)
            {
            }
            column(FilterText1; FilterText)
            {
            }
            column(TDS_SummaryCaption1; TDS_SummaryCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption1; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(TDS_Amt_Caption1; TDS_Amt_CaptionLbl)
            {
            }
            column(Employee_Dimension_Code___NameCaption1; Employee_Dimension_Code___NameCaptionLbl)
            {
            }
            column(DateCaption1; DateCaptionLbl)
            {
            }
            column(ERP_Voucher_No_Caption1; ERP_Voucher_No_CaptionLbl)
            {
            }
            column(Dimension_Value_Dimension_Code1; "Dimension Code")
            {
            }
            column(Dimension_Value_Code1; Code)
            {
            }
            dataitem("Dimension Set Entry"; "Dimension Set Entry")
            {
                DataItemLink = "Dimension Code"=field("Dimension Code"), "Dimension Value ID"=field("Dimension Value ID");
                DataItemTableView = sorting("Dimension Set ID", "Dimension Code");

                column(ReportForNavId_1000000012;1000000012)
                {
                }
                column(DimensionSetID_DimensionSetEntry; "Dimension Set Entry"."Dimension Set ID")
                {
                }
                column(DimensionCode_DimensionSetEntry; "Dimension Set Entry"."Dimension Code")
                {
                }
                column(DimensionValueCode_DimensionSetEntry; "Dimension Set Entry"."Dimension Value Code")
                {
                }
                column(DimensionValueID_DimensionSetEntry; "Dimension Set Entry"."Dimension Value ID")
                {
                }
                column(DimensionName_DimensionSetEntry; "Dimension Set Entry"."Dimension Name")
                {
                }
                column(DimensionValueName_DimensionSetEntry; "Dimension Set Entry"."Dimension Value Name")
                {
                }
                dataitem("G/L Entry"; "G/L Entry")
                {
                    DataItemLink = "Dimension Set ID"=field("Dimension Set ID");
                    DataItemTableView = sorting("G/L Account No.", "Posting Date")where("G/L Account No."=const('12470410'), Amount=filter(<0));
                    RequestFilterFields = "Posting Date";

                    column(ReportForNavId_1000000005;1000000005)
                    {
                    }
                    column(ABS__G_L_Entry__Amount_; Abs("G/L Entry".Amount))
                    {
                    }
                    column(G_L_Entry__Posting_Date_; "Posting Date")
                    {
                    }
                    column(G_L_Entry__Document_No__; "Document No.")
                    {
                    }
                    column(G_L_Entry_Entry_No_; "Entry No.")
                    {
                    }
                    column(DimensionSetID_GLEntry; "G/L Entry"."Dimension Set ID")
                    {
                    }
                    column(DimensionName; "Dimension Set Entry"."Dimension Value Code" + ':  ' + DimVal.Name)
                    {
                    }
                    trigger OnAfterGetRecord()
                    begin
                        AMT+="G/L Entry".Amount;
                    end;
                }
                trigger OnAfterGetRecord()
                begin
                    DimVal.Reset;
                    if DimVal.Get("Dimension Code", "Dimension Value Code")then;
                end;
            }
            trigger OnAfterGetRecord()
            begin
                AMT:=0;
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
        // ResCen.Get(UserMgt.GetRespCenterFilter);
        FilterText:="G/L Entry".GetFilters + ' ' + "Dimension Value".GetFilters;
    end;
    var BillNo: Code[20];
    PartyName: Text[50];
    VendLedEntry: Record "Vendor Ledger Entry";
    Vend: Record Vendor;
    PartyRec: Record Party;
    ResCen: Record "Responsibility Center";
    UserMgt: Codeunit "User Setup Management";
    AMT: Decimal;
    DimVal: Record "Dimension Value";
    FilterText: Text[200];
    TDS_SummaryCaptionLbl: label 'TDS Summary';
    CurrReport_PAGENOCaptionLbl: label 'Page';
    TDS_Amt_CaptionLbl: label 'TDS Amt.';
    Employee_Dimension_Code___NameCaptionLbl: label 'Employee Dimension Code & Name';
    DateCaptionLbl: label 'Date';
    ERP_Voucher_No_CaptionLbl: label 'ERP Voucher No.';
}
