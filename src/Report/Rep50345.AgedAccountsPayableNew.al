Report 50345 "Aged Accounts Payable New"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Aged Accounts Payable.rdl';
    Caption = 'Aged Accounts Payable New';
    ApplicationArea = all;
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem(Vendor; Vendor)
        {
            PrintOnlyIfDetail = true;
            RequestFilterFields = "No.";

            column(ReportForNavId_3182;3182)
            {
            }
            column(CompanyInfoPicture; CompanyInfoRec.Picture)
            {
            }
            column(CompanyName; COMPANYNAME)
            {
            }
            column(NewPagePerVendor; NewPagePerVendor)
            {
            }
            column(AgesAsOfEndingDate; StrSubstNo(Text006, Format(EndingDate, 0, 4)))
            {
            }
            column(SelectAgeByDuePostngDocDt; StrSubstNo(Text007, SelectStr(AgingBy + 1, Text009)))
            {
            }
            column(PrintAmountInLCY; PrintAmountInLCY)
            {
            }
            column(CaptionVendorFilter; TableCaption + ': ' + VendorFilter)
            {
            }
            column(VendorFilter; VendorFilter)
            {
            }
            column(AgingBy; AgingBy)
            {
            }
            column(SelctAgeByDuePostngDocDt1; StrSubstNo(Text004, SelectStr(AgingBy + 1, Text009)))
            {
            }
            column(HeaderText5; HeaderText[5])
            {
            }
            column(HeaderText4; HeaderText[4])
            {
            }
            column(HeaderText3; HeaderText[3])
            {
            }
            column(HeaderText2; HeaderText[2])
            {
            }
            column(HeaderText1; HeaderText[1])
            {
            }
            column(PrintDetails; PrintDetails)
            {
            }
            column(GrandTotalVLE5RemAmtLCY; GrandTotalVLERemaingAmtLCY[5])
            {
            AutoFormatType = 1;
            }
            column(GrandTotalVLE4RemAmtLCY; GrandTotalVLERemaingAmtLCY[4])
            {
            AutoFormatType = 1;
            }
            column(GrandTotalVLE3RemAmtLCY; GrandTotalVLERemaingAmtLCY[3])
            {
            AutoFormatType = 1;
            }
            column(GrandTotalVLE2RemAmtLCY; GrandTotalVLERemaingAmtLCY[2])
            {
            AutoFormatType = 1;
            }
            column(GrandTotalVLE1RemAmtLCY; GrandTotalVLERemaingAmtLCY[1])
            {
            AutoFormatType = 1;
            }
            column(GrandTotalVLE1AmtLCY; GrandTotalVLEAmtLCY)
            {
            AutoFormatType = 1;
            }
            column(PageGroupNo; PageGroupNo)
            {
            }
            column(No_Vendor; "No.")
            {
            }
            column(AgedAcctPayableCaption; AgedAcctPayableCaptionLbl)
            {
            }
            column(CurrReportPageNoCaption; CurrReportPageNoCaptionLbl)
            {
            }
            column(AllAmtsinLCYCaption; AllAmtsinLCYCaptionLbl)
            {
            }
            column(AgedOverdueAmsCaption; AgedOverdueAmsCaptionLbl)
            {
            }
            column(GrandTotalVLE5RemAmtLCYCaption; GrandTotalVLE5RemAmtLCYCaptionLbl)
            {
            }
            column(AmountLCYCaption; AmountLCYCaptionLbl)
            {
            }
            column(DueDateCaption; DueDateCaptionLbl)
            {
            }
            column(DocumentNoCaption; DocumentNoCaptionLbl)
            {
            }
            column(PostingDateCaption; PostingDateCaptionLbl)
            {
            }
            column(DocumentTypeCaption; DocumentTypeCaptionLbl)
            {
            }
            column(VendorNoCaption; FieldCaption("No."))
            {
            }
            column(VendorNameCaption; FieldCaption(Name))
            {
            }
            column(CurrencyCaption; CurrencyCaptionLbl)
            {
            }
            column(TotalLCYCaption; TotalLCYCaptionLbl)
            {
            }
            dataitem("Vendor Ledger Entry"; "Vendor Ledger Entry")
            {
                DataItemLink = "Vendor No."=field("No.");
                DataItemTableView = sorting("Vendor No.", "Posting Date", "Currency Code");
                PrintOnlyIfDetail = true;

                column(ReportForNavId_4114;4114)
                {
                }
                trigger OnAfterGetRecord()
                var
                    VendorLedgEntry: Record "Vendor Ledger Entry";
                begin
                    VendorLedgEntry.SetCurrentkey("Closed by Entry No.");
                    VendorLedgEntry.SetRange("Closed by Entry No.", "Entry No.");
                    VendorLedgEntry.SetRange("Posting Date", 0D, EndingDate);
                    if VendorLedgEntry.FindSet(false, false)then repeat InsertTemp(VendorLedgEntry);
                        until VendorLedgEntry.Next = 0;
                    if "Closed by Entry No." <> 0 then begin
                        VendorLedgEntry.SetRange("Closed by Entry No.", "Closed by Entry No.");
                        if VendorLedgEntry.FindSet(false, false)then repeat InsertTemp(VendorLedgEntry);
                            until VendorLedgEntry.Next = 0;
                    end;
                    VendorLedgEntry.Reset;
                    VendorLedgEntry.SetRange("Entry No.", "Closed by Entry No.");
                    VendorLedgEntry.SetRange("Posting Date", 0D, EndingDate);
                    if VendorLedgEntry.FindSet(false, false)then repeat InsertTemp(VendorLedgEntry);
                        until VendorLedgEntry.Next = 0;
                    CurrReport.Skip;
                end;
                trigger OnPreDataItem()
                begin
                    SetRange("Posting Date", EndingDate + 1, 99991231D);
                end;
            }
            dataitem(OpenVendorLedgEntry; "Vendor Ledger Entry")
            {
                DataItemLink = "Vendor No."=field("No.");
                DataItemTableView = sorting("Vendor No.", Open, Positive, "Due Date", "Currency Code");
                PrintOnlyIfDetail = true;

                column(ReportForNavId_7673;7673)
                {
                }
                trigger OnAfterGetRecord()
                begin
                    if AgingBy = Agingby::"Posting Date" then begin
                        CalcFields("Remaining Amt. (LCY)");
                        if "Remaining Amt. (LCY)" = 0 then CurrReport.Skip;
                    end;
                    InsertTemp(OpenVendorLedgEntry);
                    CurrReport.Skip;
                end;
                trigger OnPreDataItem()
                begin
                    if AgingBy = Agingby::"Posting Date" then begin
                        SetRange("Posting Date", 0D, EndingDate);
                        SetRange("Date Filter", 0D, EndingDate);
                    end end;
            }
            dataitem(CurrencyLoop; "Integer")
            {
                DataItemTableView = sorting(Number)where(Number=filter(1..));
                PrintOnlyIfDetail = true;

                column(ReportForNavId_6523;6523)
                {
                }
                dataitem(TempVendortLedgEntryLoop; "Integer")
                {
                    DataItemTableView = sorting(Number)where(Number=filter(1..));

                    column(ReportForNavId_4766;4766)
                    {
                    }
                    column(VendorName; Vendor.Name)
                    {
                    }
                    column(VendorNo; Vendor."No.")
                    {
                    }
                    column(VLEEndingDateRemAmtLCY; VendorLedgEntryEndingDate."Remaining Amt. (LCY)")
                    {
                    AutoFormatType = 1;
                    }
                    column(AgedVLE1RemAmtLCY; AgedVendorLedgEntry[1]."Remaining Amt. (LCY)")
                    {
                    AutoFormatType = 1;
                    }
                    column(AgedVendLedgEnt2RemAmtLCY; AgedVendorLedgEntry[2]."Remaining Amt. (LCY)")
                    {
                    AutoFormatType = 1;
                    }
                    column(AgedVendLedgEnt3RemAmtLCY; AgedVendorLedgEntry[3]."Remaining Amt. (LCY)")
                    {
                    AutoFormatType = 1;
                    }
                    column(AgedVendLedgEnt4RemAmtLCY; AgedVendorLedgEntry[4]."Remaining Amt. (LCY)")
                    {
                    AutoFormatType = 1;
                    }
                    column(AgedVendLedgEnt5RemAmtLCY; AgedVendorLedgEntry[5]."Remaining Amt. (LCY)")
                    {
                    AutoFormatType = 1;
                    }
                    column(VendLedgEntryEndDtAmtLCY; VendorLedgEntryEndingDate."Amount (LCY)")
                    {
                    AutoFormatType = 1;
                    }
                    column(VendLedgEntryEndDtDueDate; Format(VendorLedgEntryEndingDate."Due Date"))
                    {
                    }
                    column(VendLedgEntryEndDtDocNo; VendorLedgEntryEndingDate."Document No.")
                    {
                    }
                    column(OrderNo; OrderNo)
                    {
                    }
                    column(VendorLedgEntryEndingDateExternalDocumentNo; VendorLedgEntryEndingDate."External Document No.")
                    {
                    }
                    column(VendLedgEntyEndgDtDocType; Format(VendorLedgEntryEndingDate."Document Type"))
                    {
                    }
                    column(VendLedgEntryEndDtPostgDt; Format(VendorLedgEntryEndingDate."Posting Date"))
                    {
                    }
                    column(AgedVendLedgEnt5RemAmt; AgedVendorLedgEntry[5]."Remaining Amount")
                    {
                    AutoFormatExpression = CurrencyCode;
                    AutoFormatType = 1;
                    }
                    column(AgedVendLedgEnt4RemAmt; AgedVendorLedgEntry[4]."Remaining Amount")
                    {
                    AutoFormatExpression = CurrencyCode;
                    AutoFormatType = 1;
                    }
                    column(AgedVendLedgEnt3RemAmt; AgedVendorLedgEntry[3]."Remaining Amount")
                    {
                    AutoFormatExpression = CurrencyCode;
                    AutoFormatType = 1;
                    }
                    column(AgedVendLedgEnt2RemAmt; AgedVendorLedgEntry[2]."Remaining Amount")
                    {
                    AutoFormatExpression = CurrencyCode;
                    AutoFormatType = 1;
                    }
                    column(AgedVendLedgEnt1RemAmt; AgedVendorLedgEntry[1]."Remaining Amount")
                    {
                    AutoFormatExpression = CurrencyCode;
                    AutoFormatType = 1;
                    }
                    column(VLEEndingDateRemAmt; VendorLedgEntryEndingDate."Remaining Amount")
                    {
                    AutoFormatExpression = CurrencyCode;
                    AutoFormatType = 1;
                    }
                    column(VendLedgEntryEndingDtAmt; VendorLedgEntryEndingDate.Amount)
                    {
                    AutoFormatExpression = CurrencyCode;
                    AutoFormatType = 1;
                    }
                    column(TotalVendorName; StrSubstNo(Text005, Vendor.Name))
                    {
                    }
                    column(CurrCode_TempVenLedgEntryLoop; CurrencyCode)
                    {
                    AutoFormatExpression = CurrencyCode;
                    AutoFormatType = 1;
                    }
                    trigger OnAfterGetRecord()
                    var
                        PeriodIndex: Integer;
                    begin
                        if Number = 1 then begin
                            if not TempVendorLedgEntry.FindSet(false, false)then CurrReport.Break;
                        end
                        else if TempVendorLedgEntry.Next = 0 then CurrReport.Break;
                        //<<<Alle[Z]
                        OrderNo:='';
                        if PurchInvHeader.Get(TempVendorLedgEntry."Document No.")then OrderNo:=PurchInvHeader."Vendor Order No.";
                        //>>>Alle[Z]
                        VendorLedgEntryEndingDate:=TempVendorLedgEntry;
                        DetailedVendorLedgerEntry.SetRange("Vendor Ledger Entry No.", VendorLedgEntryEndingDate."Entry No.");
                        if DetailedVendorLedgerEntry.FindSet(false, false)then repeat if(DetailedVendorLedgerEntry."Entry Type" = DetailedVendorLedgerEntry."entry type"::"Initial Entry") and (VendorLedgEntryEndingDate."Posting Date" > EndingDate) and (AgingBy <> Agingby::"Posting Date")then begin
                                    if VendorLedgEntryEndingDate."Document Date" <= EndingDate then DetailedVendorLedgerEntry."Posting Date":=VendorLedgEntryEndingDate."Document Date"
                                    else if(VendorLedgEntryEndingDate."Due Date" <= EndingDate) and (AgingBy = Agingby::"Due Date")then DetailedVendorLedgerEntry."Posting Date":=VendorLedgEntryEndingDate."Due Date" end;
                                if(DetailedVendorLedgerEntry."Posting Date" <= EndingDate) or (TempVendorLedgEntry.Open and (AgingBy = Agingby::"Due Date") and (VendorLedgEntryEndingDate."Due Date" > EndingDate) and (VendorLedgEntryEndingDate."Posting Date" <= EndingDate))then begin
                                    if DetailedVendorLedgerEntry."Entry Type" in[DetailedVendorLedgerEntry."entry type"::"Initial Entry", DetailedVendorLedgerEntry."entry type"::"Unrealized Loss", DetailedVendorLedgerEntry."entry type"::"Unrealized Gain", DetailedVendorLedgerEntry."entry type"::"Realized Loss", DetailedVendorLedgerEntry."entry type"::"Realized Gain", DetailedVendorLedgerEntry."entry type"::"Payment Discount", DetailedVendorLedgerEntry."entry type"::"Payment Discount (VAT Excl.)", DetailedVendorLedgerEntry."entry type"::"Payment Discount (VAT Adjustment)", DetailedVendorLedgerEntry."entry type"::"Payment Tolerance", DetailedVendorLedgerEntry."entry type"::"Payment Discount Tolerance", DetailedVendorLedgerEntry."entry type"::"Payment Tolerance (VAT Excl.)", DetailedVendorLedgerEntry."entry type"::"Payment Tolerance (VAT Adjustment)", DetailedVendorLedgerEntry."entry type"::"Payment Discount Tolerance (VAT Excl.)", DetailedVendorLedgerEntry."entry type"::"Payment Discount Tolerance (VAT Adjustment)"]then begin
                                        VendorLedgEntryEndingDate.Amount:=VendorLedgEntryEndingDate.Amount + DetailedVendorLedgerEntry.Amount;
                                        VendorLedgEntryEndingDate."Amount (LCY)":=VendorLedgEntryEndingDate."Amount (LCY)" + DetailedVendorLedgerEntry."Amount (LCY)";
                                    end;
                                    if DetailedVendorLedgerEntry."Posting Date" <= EndingDate then begin
                                        VendorLedgEntryEndingDate."Remaining Amount":=VendorLedgEntryEndingDate."Remaining Amount" + DetailedVendorLedgerEntry.Amount;
                                        VendorLedgEntryEndingDate."Remaining Amt. (LCY)":=VendorLedgEntryEndingDate."Remaining Amt. (LCY)" + DetailedVendorLedgerEntry."Amount (LCY)";
                                    end;
                                end;
                            until DetailedVendorLedgerEntry.Next = 0;
                        if VendorLedgEntryEndingDate."Remaining Amount" = 0 then CurrReport.Skip;
                        case AgingBy of Agingby::"Due Date": PeriodIndex:=GetPeriodIndex(VendorLedgEntryEndingDate."Due Date");
                        Agingby::"Posting Date": PeriodIndex:=GetPeriodIndex(VendorLedgEntryEndingDate."Posting Date");
                        Agingby::"Document Date": begin
                            if VendorLedgEntryEndingDate."Document Date" > EndingDate then begin
                                VendorLedgEntryEndingDate."Remaining Amount":=0;
                                VendorLedgEntryEndingDate."Remaining Amt. (LCY)":=0;
                                VendorLedgEntryEndingDate."Document Date":=VendorLedgEntryEndingDate."Posting Date";
                            end;
                            PeriodIndex:=GetPeriodIndex(VendorLedgEntryEndingDate."Document Date");
                        end;
                        end;
                        Clear(AgedVendorLedgEntry);
                        AgedVendorLedgEntry[PeriodIndex]."Remaining Amount":=VendorLedgEntryEndingDate."Remaining Amount";
                        AgedVendorLedgEntry[PeriodIndex]."Remaining Amt. (LCY)":=VendorLedgEntryEndingDate."Remaining Amt. (LCY)";
                        TotalVendorLedgEntry[PeriodIndex]."Remaining Amount"+=VendorLedgEntryEndingDate."Remaining Amount";
                        TotalVendorLedgEntry[PeriodIndex]."Remaining Amt. (LCY)"+=VendorLedgEntryEndingDate."Remaining Amt. (LCY)";
                        GrandTotalVLERemaingAmtLCY[PeriodIndex]+=VendorLedgEntryEndingDate."Remaining Amt. (LCY)";
                        TotalVendorLedgEntry[1].Amount+=VendorLedgEntryEndingDate."Remaining Amount";
                        TotalVendorLedgEntry[1]."Amount (LCY)"+=VendorLedgEntryEndingDate."Remaining Amt. (LCY)";
                        GrandTotalVLEAmtLCY+=VendorLedgEntryEndingDate."Remaining Amt. (LCY)";
                    end;
                    trigger OnPostDataItem()
                    begin
                        if not PrintAmountInLCY then UpdateCurrencyTotals;
                    end;
                    trigger OnPreDataItem()
                    begin
                        if not PrintAmountInLCY then TempVendorLedgEntry.SetRange("Currency Code", TempCurrency.Code);
                    end;
                }
                trigger OnAfterGetRecord()
                begin
                    Clear(TotalVendorLedgEntry);
                    if Number = 1 then begin
                        if not TempCurrency.FindSet(false, false)then CurrReport.Break;
                    end
                    else if TempCurrency.Next = 0 then CurrReport.Break;
                    if TempCurrency.Code <> '' then CurrencyCode:=TempCurrency.Code
                    else
                        CurrencyCode:=GLSetup."LCY Code";
                    NumberOfCurrencies:=NumberOfCurrencies + 1;
                end;
                trigger OnPostDataItem()
                begin
                    if NewPagePerVendor and (NumberOfCurrencies > 0)then CurrReport.Newpage;
                end;
                trigger OnPreDataItem()
                begin
                    NumberOfCurrencies:=0;
                end;
            }
            trigger OnAfterGetRecord()
            begin
                if NewPagePerVendor then PageGroupNo:=PageGroupNo + 1;
                TempCurrency.Reset;
                TempCurrency.DeleteAll;
                TempVendorLedgEntry.Reset;
                TempVendorLedgEntry.DeleteAll;
                Clear(GrandTotalVLERemaingAmtLCY);
                GrandTotalVLEAmtLCY:=0;
            end;
            trigger OnPreDataItem()
            begin
                PageGroupNo:=1;
                CompanyInfoRec.Get;
                CompanyInfoRec.CalcFields(Picture);
            end;
        }
        dataitem(CurrencyTotals; "Integer")
        {
            DataItemTableView = sorting(Number)where(Number=filter(1..));

            column(ReportForNavId_8052;8052)
            {
            }
            column(Number_CurrencyTotals; Number)
            {
            }
            column(NewPagePerVend_CurrTotal; NewPagePerVendor)
            {
            }
            column(TempCurrency2Code; TempCurrency2.Code)
            {
            AutoFormatExpression = CurrencyCode;
            AutoFormatType = 1;
            }
            column(AgedVendLedgEnt6RemAmtLCY5; AgedVendorLedgEntry[6]."Remaining Amount")
            {
            AutoFormatExpression = CurrencyCode;
            AutoFormatType = 1;
            }
            column(AgedVendLedgEnt1RemAmtLCY1; AgedVendorLedgEntry[1]."Remaining Amount")
            {
            AutoFormatExpression = CurrencyCode;
            AutoFormatType = 1;
            }
            column(AgedVendLedgEnt2RemAmtLCY2; AgedVendorLedgEntry[2]."Remaining Amount")
            {
            AutoFormatExpression = CurrencyCode;
            AutoFormatType = 1;
            }
            column(AgedVendLedgEnt3RemAmtLCY3; AgedVendorLedgEntry[3]."Remaining Amount")
            {
            AutoFormatExpression = CurrencyCode;
            AutoFormatType = 1;
            }
            column(AgedVendLedgEnt4RemAmtLCY4; AgedVendorLedgEntry[4]."Remaining Amount")
            {
            AutoFormatExpression = CurrencyCode;
            AutoFormatType = 1;
            }
            column(AgedVendLedgEnt5RemAmtLCY5; AgedVendorLedgEntry[5]."Remaining Amount")
            {
            AutoFormatExpression = CurrencyCode;
            AutoFormatType = 1;
            }
            column(CurrencySpecificationCaption; CurrencySpecificationCaptionLbl)
            {
            }
            trigger OnAfterGetRecord()
            begin
                if Number = 1 then begin
                    if not TempCurrency2.FindSet(false, false)then CurrReport.Break;
                end
                else if TempCurrency2.Next = 0 then CurrReport.Break;
                Clear(AgedVendorLedgEntry);
                TempCurrencyAmount.SetRange("Currency Code", TempCurrency2.Code);
                if TempCurrencyAmount.FindSet(false, false)then repeat if TempCurrencyAmount.Date <> 99991231D then AgedVendorLedgEntry[GetPeriodIndex(TempCurrencyAmount.Date)]."Remaining Amount":=TempCurrencyAmount.Amount
                        else
                            AgedVendorLedgEntry[6]."Remaining Amount":=TempCurrencyAmount.Amount;
                    until TempCurrencyAmount.Next = 0;
            end;
            trigger OnPreDataItem()
            begin
                PageGroupNo:=0;
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

                    field(AgedAsOf; EndingDate)
                    {
                        ApplicationArea = Basic;
                        Caption = 'Aged As Of';
                    }
                    field(AgingBy; AgingBy)
                    {
                        ApplicationArea = Basic;
                        Caption = 'Aging by';
                        OptionCaption = 'Due Date,Posting Date,Document Date';
                    }
                    field(PeriodLength; PeriodLength)
                    {
                        ApplicationArea = Basic;
                        Caption = 'Period Length';
                    }
                    field(PrintAmountInLCY; PrintAmountInLCY)
                    {
                        ApplicationArea = Basic;
                        Caption = 'Print Amounts in LCY';
                    }
                    field(PrintDetails; PrintDetails)
                    {
                        ApplicationArea = Basic;
                        Caption = 'Print Details';
                    }
                    field(HeadingType; HeadingType)
                    {
                        ApplicationArea = Basic;
                        Caption = 'Heading Type';
                        OptionCaption = 'Date Interval,Number of Days';
                    }
                    field(NewPagePerVendor; NewPagePerVendor)
                    {
                        ApplicationArea = Basic;
                        Caption = 'New Page per Vendor';
                    }
                }
            }
        }
        actions
        {
        }
        trigger OnOpenPage()
        begin
            if EndingDate = 0D then EndingDate:=WorkDate;
        end;
    }
    labels
    {
    }
    trigger OnPreReport()
    begin
        VendorFilter:=Vendor.GetFilters;
        GLSetup.Get;
        CalcDates;
        CreateHeadings;
    end;
    var GLSetup: Record "General Ledger Setup";
    TempVendorLedgEntry: Record "Vendor Ledger Entry" temporary;
    VendorLedgEntryEndingDate: Record "Vendor Ledger Entry";
    TotalVendorLedgEntry: array[5]of Record "Vendor Ledger Entry";
    AgedVendorLedgEntry: array[6]of Record "Vendor Ledger Entry";
    TempCurrency: Record Currency temporary;
    TempCurrency2: Record Currency temporary;
    TempCurrencyAmount: Record "Currency Amount" temporary;
    DetailedVendorLedgerEntry: Record "Detailed Vendor Ledg. Entry";
    GrandTotalVLERemaingAmtLCY: array[5]of Decimal;
    GrandTotalVLEAmtLCY: Decimal;
    VendorFilter: Text;
    PrintAmountInLCY: Boolean;
    EndingDate: Date;
    AgingBy: Option "Due Date", "Posting Date", "Document Date";
    PeriodLength: DateFormula;
    PrintDetails: Boolean;
    HeadingType: Option "Date Interval", "Number of Days";
    NewPagePerVendor: Boolean;
    PeriodStartDate: array[5]of Date;
    PeriodEndDate: array[5]of Date;
    HeaderText: array[5]of Text[30];
    Text000: label 'Not Due';
    Text001: label 'Before';
    CurrencyCode: Code[10];
    Text002: label 'days';
    Text003: label 'More than';
    Text004: label 'Aged by %1';
    Text005: label 'Total for %1';
    Text006: label 'Aged as of %1';
    Text007: label 'Aged by %1';
    NumberOfCurrencies: Integer;
    Text009: label 'Due Date,Posting Date,Document Date';
    Text010: label 'The Date Formula %1 cannot be used. Try to restate it. E.g. 1M+CM instead of CM+1M.';
    PageGroupNo: Integer;
    Text011: label 'Enter a date formula in the Period Length field.';
    Text027: label '-%1', Comment = 'Negating the period length: %1 is the period length';
    AgedAcctPayableCaptionLbl: label 'Aged Accounts Payable';
    CurrReportPageNoCaptionLbl: label 'Page';
    AllAmtsinLCYCaptionLbl: label 'All Amounts in LCY';
    AgedOverdueAmsCaptionLbl: label 'Aged Overdue Amounts';
    GrandTotalVLE5RemAmtLCYCaptionLbl: label 'Balance';
    AmountLCYCaptionLbl: label 'Original Amount';
    DueDateCaptionLbl: label 'Due Date';
    DocumentNoCaptionLbl: label 'Document No.';
    PostingDateCaptionLbl: label 'Posting Date';
    DocumentTypeCaptionLbl: label 'Document Type';
    CurrencyCaptionLbl: label 'Currency Code';
    TotalLCYCaptionLbl: label 'Total (LCY)';
    CurrencySpecificationCaptionLbl: label 'Currency Specification';
    CompanyInfoRec: Record "Company Information";
    OrderNo: Text;
    PurchInvHeader: Record "Purch. Inv. Header";
    local procedure CalcDates()
    var
        i: Integer;
        PeriodLength2: DateFormula;
    begin
        if not Evaluate(PeriodLength2, StrSubstNo(Text027, PeriodLength))then Error(Text011);
        if AgingBy = Agingby::"Due Date" then begin
            PeriodEndDate[1]:=99991231D;
            PeriodStartDate[1]:=EndingDate + 1;
        end
        else
        begin
            PeriodEndDate[1]:=EndingDate;
            PeriodStartDate[1]:=CalcDate(PeriodLength2, EndingDate + 1);
        end;
        for i:=2 to ArrayLen(PeriodEndDate)do begin
            PeriodEndDate[i]:=PeriodStartDate[i - 1] - 1;
            PeriodStartDate[i]:=CalcDate(PeriodLength2, PeriodEndDate[i] + 1);
        end;
        i:=ArrayLen(PeriodEndDate);
        PeriodStartDate[i]:=0D;
        for i:=1 to ArrayLen(PeriodEndDate)do if PeriodEndDate[i] < PeriodStartDate[i]then Error(Text010, PeriodLength);
    end;
    local procedure CreateHeadings()
    var
        i: Integer;
    begin
        if AgingBy = Agingby::"Due Date" then begin
            HeaderText[1]:=Text000;
            i:=2;
        end
        else
            i:=1;
        while i < ArrayLen(PeriodEndDate)do begin
            if HeadingType = Headingtype::"Date Interval" then HeaderText[i]:=StrSubstNo('%1\..%2', PeriodStartDate[i], PeriodEndDate[i])
            else
                HeaderText[i]:=StrSubstNo('%1 - %2 %3', EndingDate - PeriodEndDate[i] + 1, EndingDate - PeriodStartDate[i] + 1, Text002);
            i:=i + 1;
        end;
        if HeadingType = Headingtype::"Date Interval" then HeaderText[i]:=StrSubstNo('%1\%2', Text001, PeriodStartDate[i - 1])
        else
            HeaderText[i]:=StrSubstNo('%1\%2 %3', Text003, EndingDate - PeriodStartDate[i - 1] + 1, Text002);
    end;
    local procedure InsertTemp(var VendorLedgEntry: Record "Vendor Ledger Entry")
    var
        Currency: Record Currency;
    begin
        with TempVendorLedgEntry do begin
            if Get(VendorLedgEntry."Entry No.")then exit;
            TempVendorLedgEntry:=VendorLedgEntry;
            Insert;
            if PrintAmountInLCY then begin
                Clear(TempCurrency);
                TempCurrency."Amount Rounding Precision":=GLSetup."Amount Rounding Precision";
                if TempCurrency.Insert then;
                exit;
            end;
            if TempCurrency.Get("Currency Code")then exit;
            if "Currency Code" <> '' then Currency.Get("Currency Code")
            else
            begin
                Clear(Currency);
                Currency."Amount Rounding Precision":=GLSetup."Amount Rounding Precision";
            end;
            TempCurrency:=Currency;
            TempCurrency.Insert;
        end;
    end;
    local procedure GetPeriodIndex(Date: Date): Integer var
        i: Integer;
    begin
        for i:=1 to ArrayLen(PeriodEndDate)do if Date in[PeriodStartDate[i] .. PeriodEndDate[i]]then exit(i);
    end;
    local procedure UpdateCurrencyTotals()
    var
        i: Integer;
    begin
        TempCurrency2.Code:=CurrencyCode;
        if TempCurrency2.Insert then;
        with TempCurrencyAmount do begin
            for i:=1 to ArrayLen(TotalVendorLedgEntry)do begin
                "Currency Code":=CurrencyCode;
                Date:=PeriodStartDate[i];
                if Find then begin
                    Amount:=Amount + TotalVendorLedgEntry[i]."Remaining Amount";
                    Modify;
                end
                else
                begin
                    "Currency Code":=CurrencyCode;
                    Date:=PeriodStartDate[i];
                    Amount:=TotalVendorLedgEntry[i]."Remaining Amount";
                    Insert;
                end;
            end;
            "Currency Code":=CurrencyCode;
            Date:=99991231D;
            if Find then begin
                Amount:=Amount + TotalVendorLedgEntry[1].Amount;
                Modify;
            end
            else
            begin
                "Currency Code":=CurrencyCode;
                Date:=99991231D;
                Amount:=TotalVendorLedgEntry[1].Amount;
                Insert;
            end;
        end;
    end;
    procedure InitializeRequest(NewEndingDate: Date; NewAgingBy: Option; NewPeriodLength: DateFormula; NewPrintAmountInLCY: Boolean; NewPrintDetails: Boolean; NewHeadingType: Option; NewNewPagePerVendor: Boolean)
    begin
        EndingDate:=NewEndingDate;
        AgingBy:=NewAgingBy;
        PeriodLength:=NewPeriodLength;
        PrintAmountInLCY:=NewPrintAmountInLCY;
        PrintDetails:=NewPrintDetails;
        HeadingType:=NewHeadingType;
        NewPagePerVendor:=NewNewPagePerVendor;
    end;
}
