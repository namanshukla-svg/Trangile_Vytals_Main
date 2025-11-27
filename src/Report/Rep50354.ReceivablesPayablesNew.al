Report 50354 "Receivables-Payables New"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Receivables-Payables.rdl';
    Caption = 'Receivables-Payables New';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = all;

    dataset
    {
        dataitem("General Ledger Setup"; "General Ledger Setup")
        {
            DataItemTableView = sorting("Primary Key")where("Primary Key"=const(''));

            column(ReportForNavId_4908;4908)
            {
            }
            column(CompanyName; COMPANYNAME)
            {
            }
            column(GLSetupCustBalancesDue; GLSetup."Cust. Balances Due")
            {
            AutoFormatType = 1;
            }
            column(GLSetupVenBalancesDue; GLSetup."Vendor Balances Due")
            {
            AutoFormatType = 1;
            }
            column(NetBalancesDueLCY; NetBalancesDueLCY)
            {
            AutoFormatType = 1;
            }
            column(GLSetupCustVenBalancesDue; GLSetup."Cust. Balances Due" - GLSetup."Vendor Balances Due")
            {
            AutoFormatType = 1;
            }
            column(BeforeCustBalanceLCY; beforeCustBalanceLCY)
            {
            }
            column(BeforeVendorBalanceLCY; beforeVendorBalanceLCY)
            {
            }
            column(VenBalancesDue_GLSetup; "Vendor Balances Due")
            {
            }
            column(CustBalancesDue_GLSetup; "Cust. Balances Due")
            {
            }
            column(CustVenBalancesDue_GLSetup; "Cust. Balances Due" - "Vendor Balances Due")
            {
            AutoFormatType = 1;
            }
            column(PrimaryKey_GLSetup; "Primary Key")
            {
            }
            column(ReceivablesPayablesCaption; ReceivablesPayablesCaptionLbl)
            {
            }
            column(PageCaption; PageCaptionLbl)
            {
            }
            column(DueDateCaption; DueDateCaptionLbl)
            {
            }
            column(CustBalDueCaption; CustBalDueCaptionLbl)
            {
            }
            column(VendBalDueCaption; VendBalDueCaptionLbl)
            {
            }
            column(BalDateLCYCaption; BalDateLCYCaptionLbl)
            {
            }
            column(NetChangeLCYCaption; NetChangeLCYCaptionLbl)
            {
            }
            column(BeforeCaption; BeforeCaptionLbl)
            {
            }
            column(AfterCaption; AfterCaptionLbl)
            {
            }
            column(TotalCaption; TotalCaptionLbl)
            {
            }
            dataitem(PeriodLoop; "Integer")
            {
                DataItemTableView = sorting(Number);

                column(ReportForNavId_8904;8904)
                {
                }
                column(GLSetupDateFilter; GLSetup.GetFilter("Date Filter"))
                {
                }
                trigger OnAfterGetRecord()
                begin
                    StartDate:=EndDate + 1;
                    EndDate:=CalcDate(PeriodLength, StartDate) - 1;
                    MultiplyAmounts;
                end;
                trigger OnPreDataItem()
                begin
                    if StartDate <> 0D then begin
                        EndDate:=StartDate - 1;
                        StartDate:=0D;
                        MultiplyAmounts;
                        beforeCustBalanceLCY:=GLSetup."Cust. Balances Due";
                        beforeVendorBalanceLCY:=GLSetup."Vendor Balances Due";
                    end;
                    SetRange(Number, 1, NoOfPeriods);
                end;
            }
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

                    field(StartDate; StartDate)
                    {
                        ApplicationArea = Basic;
                        Caption = 'Starting Date';
                        NotBlank = true;
                    }
                    field(NoOfPeriods; NoOfPeriods)
                    {
                        ApplicationArea = Basic;
                        Caption = 'No. of Periods';
                    }
                    field(PeriodLength; PeriodLength)
                    {
                        ApplicationArea = Basic;
                        Caption = 'Period Length';
                    }
                }
            }
        }
        actions
        {
        }
        trigger OnOpenPage()
        begin
            if StartDate = 0D then StartDate:=WorkDate;
            if NoOfPeriods = 0 then NoOfPeriods:=1;
            if Format(PeriodLength) = '' then Evaluate(PeriodLength, '<1M>');
        end;
    }
    labels
    {
    }
    trigger OnInitReport()
    begin
        StartDate:=WorkDate;
        NoOfPeriods:=1;
        Evaluate(PeriodLength, '<1M>');
    end;
    var GLSetup: Record "General Ledger Setup";
    StartDate: Date;
    EndDate: Date;
    NoOfPeriods: Integer;
    PeriodLength: DateFormula;
    NetBalancesDueLCY: Decimal;
    beforeCustBalanceLCY: Decimal;
    beforeVendorBalanceLCY: Decimal;
    ReceivablesPayablesCaptionLbl: label 'Receivables-Payables';
    PageCaptionLbl: label 'Page';
    DueDateCaptionLbl: label 'Due Date';
    CustBalDueCaptionLbl: label 'Cust. Balances Due (LCY)';
    VendBalDueCaptionLbl: label 'Vendor Balances Due (LCY)';
    BalDateLCYCaptionLbl: label 'Balance at Date (LCY)';
    NetChangeLCYCaptionLbl: label 'Net Change (LCY)';
    BeforeCaptionLbl: label '...Before';
    AfterCaptionLbl: label 'After...';
    TotalCaptionLbl: label 'Total';
    local procedure MultiplyAmounts()
    begin
        with GLSetup do begin
            SetRange("Date Filter", StartDate, EndDate);
            CalcFields("Cust. Balances Due", "Vendor Balances Due");
            NetBalancesDueLCY:=NetBalancesDueLCY + "Cust. Balances Due" - "Vendor Balances Due";
        end;
    end;
    procedure InitializeRequest(NewStartDate: Date; NewNoOfPeriods: Integer; NewPeriodLength: DateFormula)
    begin
        StartDate:=NewStartDate;
        NoOfPeriods:=NewNoOfPeriods;
        PeriodLength:=NewPeriodLength;
    end;
}
