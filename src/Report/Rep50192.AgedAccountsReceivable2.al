Report 50192 "Aged Accounts Receivable2"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Aged Accounts Receivable2.rdl';
    Caption = 'Aged Accounts Receivable New';
    UsageCategory = ReportsandAnalysis;
    ApplicationArea = all;

    dataset
    {
        dataitem(Customer; Customer)
        {
            RequestFilterFields = "No.";

            column(ReportForNavId_6836;6836)
            {
            }
            column(PaymentCycle1_Customer; Customer."Payment Cycle 1")
            {
            }
            column(PaymentCycle2_Customer; Customer."Payment Cycle 2")
            {
            }
            column(PaymentCycle3_Customer; Customer."Payment Cycle 3")
            {
            }
            column(PaymentCycle4_Customer; Customer."Payment Cycle 4")
            {
            }
            column(DDD; DDD)
            {
            }
            column(DDC; DDC)
            {
            }
            column(CompanyInfoPict; CompanyInfoRec.Picture)
            {
            }
            column(TodayFormatted; Format(Today, 0, 4))
            {
            }
            column(CompanyName; COMPANYNAME)
            {
            }
            column(FormatEndingDate; StrSubstNo(Text006, Format(EndingDate, 0, 4)))
            {
            }
            column(PostingDate; StrSubstNo(Text007, SelectStr(AgingBy + 1, Text009)))
            {
            }
            column(PrintAmountInLCY; PrintAmountInLCY)
            {
            }
            column(TableCaptnCustFilter; TableCaption + ': ' + CustFilter)
            {
            }
            column(CustFilter; CustFilter)
            {
            }
            column(AgingByDueDate; AgingBy = Agingby::"Due Date")
            {
            }
            column(AgedbyDocumnetDate; StrSubstNo(Text004, SelectStr(AgingBy + 1, Text009)))
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
            column(GrandTotalCLE5RemAmt; GrandTotalCustLedgEntry[5]."Remaining Amt. (LCY)")
            {
            AutoFormatType = 1;
            }
            column(GrandTotalCLE4RemAmt; GrandTotalCustLedgEntry[4]."Remaining Amt. (LCY)")
            {
            AutoFormatType = 1;
            }
            column(GrandTotalCLE3RemAmt; GrandTotalCustLedgEntry[3]."Remaining Amt. (LCY)")
            {
            AutoFormatType = 1;
            }
            column(GrandTotalCLE2RemAmt; GrandTotalCustLedgEntry[2]."Remaining Amt. (LCY)")
            {
            AutoFormatType = 1;
            }
            column(GrandTotalCLE1RemAmt; GrandTotalCustLedgEntry[1]."Remaining Amt. (LCY)")
            {
            AutoFormatType = 1;
            }
            column(GrandTotalCLEAmtLCY; GrandTotalCustLedgEntry[1]."Amount (LCY)")
            {
            AutoFormatType = 1;
            }
            column(GrandTotalCLE1CustRemAmtLCY; Pct(GrandTotalCustLedgEntry[1]."Remaining Amt. (LCY)", GrandTotalCustLedgEntry[1]."Amount (LCY)"))
            {
            }
            column(GrandTotalCLE2CustRemAmtLCY; Pct(GrandTotalCustLedgEntry[2]."Remaining Amt. (LCY)", GrandTotalCustLedgEntry[1]."Amount (LCY)"))
            {
            }
            column(GrandTotalCLE3CustRemAmtLCY; Pct(GrandTotalCustLedgEntry[3]."Remaining Amt. (LCY)", GrandTotalCustLedgEntry[1]."Amount (LCY)"))
            {
            }
            column(GrandTotalCLE4CustRemAmtLCY; Pct(GrandTotalCustLedgEntry[4]."Remaining Amt. (LCY)", GrandTotalCustLedgEntry[1]."Amount (LCY)"))
            {
            }
            column(GrandTotalCLE5CustRemAmtLCY; Pct(GrandTotalCustLedgEntry[5]."Remaining Amt. (LCY)", GrandTotalCustLedgEntry[1]."Amount (LCY)"))
            {
            }
            column(AgedAccReceivableCptn; AgedAccReceivableCptnLbl)
            {
            }
            column(CurrReportPageNoCptn; CurrReportPageNoCptnLbl)
            {
            }
            column(AllAmtinLCYCptn; AllAmtinLCYCptnLbl)
            {
            }
            column(AgedOverdueAmtCptn; AgedOverdueAmtCptnLbl)
            {
            }
            column(CLEEndDateAmtLCYCptn; CLEEndDateAmtLCYCptnLbl)
            {
            }
            column(CLEEndDateDueDateCptn; CLEEndDateDueDateCptnLbl)
            {
            }
            column(CLEEndDateDocNoCptn; CLEEndDateDocNoCptnLbl)
            {
            }
            column(CLEEndDatePstngDateCptn; CLEEndDatePstngDateCptnLbl)
            {
            }
            column(CLEEndDateDocTypeCptn; CLEEndDateDocTypeCptnLbl)
            {
            }
            column(OriginalAmtCptn; OriginalAmtCptnLbl)
            {
            }
            column(TotalLCYCptn; TotalLCYCptnLbl)
            {
            }
            column(NewPagePercustomer; NewPagePercustomer)
            {
            }
            column(PageGroupNo; PageGroupNo)
            {
            }
            column(SalespersonCode_Customer; Customer."Salesperson Code")
            {
            }
            dataitem("Cust. Ledger Entry"; "Cust. Ledger Entry")
            {
                DataItemLink = "Customer No."=field("No.");
                DataItemTableView = sorting("Customer No.", "Posting Date", "Currency Code");
                RequestFilterFields = "Document No.";

                column(ReportForNavId_8503;8503)
                {
                }
                trigger OnAfterGetRecord()
                var
                    CustLedgEntry: Record "Cust. Ledger Entry";
                begin
                    CustLedgEntry.SetCurrentkey("Closed by Entry No.");
                    CustLedgEntry.SetRange("Closed by Entry No.", "Entry No.");
                    CustLedgEntry.SetRange("Posting Date", 0D, EndingDate);
                    if CustLedgEntry.FindSet(false, false)then repeat InsertTemp(CustLedgEntry);
                        until CustLedgEntry.Next = 0;
                    if "Closed by Entry No." <> 0 then begin
                        CustLedgEntry.SetRange("Closed by Entry No.", "Closed by Entry No.");
                        if CustLedgEntry.FindSet(false, false)then repeat InsertTemp(CustLedgEntry);
                            until CustLedgEntry.Next = 0;
                    end;
                    CustLedgEntry.Reset;
                    CustLedgEntry.SetRange("Entry No.", "Closed by Entry No.");
                    CustLedgEntry.SetRange("Posting Date", 0D, EndingDate);
                    if CustLedgEntry.FindSet(false, false)then repeat InsertTemp(CustLedgEntry);
                        until CustLedgEntry.Next = 0;
                    CurrReport.Skip;
                end;
                trigger OnPreDataItem()
                begin
                    SetRange("Posting Date", EndingDate + 1, 99991231D);
                end;
            }
            dataitem(OpenCustLedgEntry; "Cust. Ledger Entry")
            {
                DataItemLink = "Customer No."=field("No.");
                DataItemTableView = sorting("Customer No.", Open, Positive, "Due Date", "Currency Code");

                column(ReportForNavId_1473;1473)
                {
                }
                trigger OnAfterGetRecord()
                begin
                    if AgingBy = Agingby::"Posting Date" then begin
                        CalcFields("Remaining Amt. (LCY)");
                        if "Remaining Amt. (LCY)" = 0 then CurrReport.Skip;
                    end;
                    InsertTemp(OpenCustLedgEntry);
                    CurrReport.Skip;
                end;
                trigger OnPreDataItem()
                begin
                    if AgingBy = Agingby::"Posting Date" then begin
                        SetRange("Posting Date", 0D, EndingDate);
                        SetRange("Date Filter", 0D, EndingDate);
                    end;
                end;
            }
            dataitem(CurrencyLoop; "Integer")
            {
                DataItemTableView = sorting(Number)where(Number=filter(1..));
                PrintOnlyIfDetail = true;

                column(ReportForNavId_6523;6523)
                {
                }
                dataitem(TempCustLedgEntryLoop; "Integer")
                {
                    DataItemTableView = sorting(Number)where(Number=filter(1..));

                    column(ReportForNavId_7725;7725)
                    {
                    }
                    column(Remarks; CustLedgEntryEndingDate.Remarks)
                    {
                    }
                    column(LRNo_; LRNo)
                    {
                    }
                    column(ActDelDate; ActDelDate)
                    {
                    }
                    column(Name1_Cust; Customer.Name)
                    {
                    IncludeCaption = true;
                    }
                    column(No_Cust; Customer."No.")
                    {
                    IncludeCaption = true;
                    }
                    column(VendorCodeNo_; Customer."Our Account No.")
                    {
                    }
                    column(PONO; CustLedgEntryEndingDate."External Document No.")
                    {
                    }
                    column(CLEEndDateRemAmtLCY; CustLedgEntryEndingDate."Remaining Amt. (LCY)")
                    {
                    AutoFormatType = 1;
                    }
                    column(OrginalAmount; CustLedgEntryEndingDate."Original Amount")
                    {
                    }
                    column(AgedCLE1RemAmtLCY; AgedCustLedgEntry[1]."Remaining Amt. (LCY)")
                    {
                    AutoFormatType = 1;
                    }
                    column(AgedCLE2RemAmtLCY; AgedCustLedgEntry[2]."Remaining Amt. (LCY)")
                    {
                    AutoFormatType = 1;
                    }
                    column(AgedCLE3RemAmtLCY; AgedCustLedgEntry[3]."Remaining Amt. (LCY)")
                    {
                    AutoFormatType = 1;
                    }
                    column(AgedCLE4RemAmtLCY; AgedCustLedgEntry[4]."Remaining Amt. (LCY)")
                    {
                    AutoFormatType = 1;
                    }
                    column(AgedCLE5RemAmtLCY; AgedCustLedgEntry[5]."Remaining Amt. (LCY)")
                    {
                    AutoFormatType = 1;
                    }
                    column(CLEEndDateAmtLCY; CustLedgEntryEndingDate."Amount (LCY)")
                    {
                    AutoFormatType = 1;
                    }
                    column(CLEEndDueDate; Format(CustLedgEntryEndingDate."Due Date"))
                    {
                    }
                    column(CLEEndDateDocNo; CustLedgEntryEndingDate."Document No.")
                    {
                    }
                    column(CLEDocType; Format(CustLedgEntryEndingDate."Document Type"))
                    {
                    }
                    column(CLEPostingDate; Format(CustLedgEntryEndingDate."Posting Date"))
                    {
                    }
                    column(AgedCLE5TempRemAmt; AgedCustLedgEntry[5]."Remaining Amount")
                    {
                    AutoFormatExpression = CurrencyCode;
                    AutoFormatType = 1;
                    }
                    column(AgedCLE4TempRemAmt; AgedCustLedgEntry[4]."Remaining Amount")
                    {
                    AutoFormatExpression = CurrencyCode;
                    AutoFormatType = 1;
                    }
                    column(AgedCLE3TempRemAmt; AgedCustLedgEntry[3]."Remaining Amount")
                    {
                    AutoFormatExpression = CurrencyCode;
                    AutoFormatType = 1;
                    }
                    column(AgedCLE2TempRemAmt; AgedCustLedgEntry[2]."Remaining Amount")
                    {
                    AutoFormatExpression = CurrencyCode;
                    AutoFormatType = 1;
                    }
                    column(AgedCLE1TempRemAmt; AgedCustLedgEntry[1]."Remaining Amount")
                    {
                    AutoFormatExpression = CurrencyCode;
                    AutoFormatType = 1;
                    }
                    column(RemAmt_CLEEndDate; CustLedgEntryEndingDate."Remaining Amount")
                    {
                    AutoFormatExpression = CurrencyCode;
                    AutoFormatType = 1;
                    }
                    column(CLEEndDate; CustLedgEntryEndingDate.Amount)
                    {
                    AutoFormatExpression = CurrencyCode;
                    AutoFormatType = 1;
                    }
                    column(Name_Cust; StrSubstNo(Text005, Customer.Name))
                    {
                    }
                    column(TotalCLE1AmtLCY; TotalCustLedgEntry[1]."Amount (LCY)")
                    {
                    AutoFormatType = 1;
                    }
                    column(TotalCLE1RemAmtLCY; TotalCustLedgEntry[1]."Remaining Amt. (LCY)")
                    {
                    AutoFormatType = 1;
                    }
                    column(TotalCLE2RemAmtLCY; TotalCustLedgEntry[2]."Remaining Amt. (LCY)")
                    {
                    AutoFormatType = 1;
                    }
                    column(TotalCLE3RemAmtLCY; TotalCustLedgEntry[3]."Remaining Amt. (LCY)")
                    {
                    AutoFormatType = 1;
                    }
                    column(TotalCLE4RemAmtLCY; TotalCustLedgEntry[4]."Remaining Amt. (LCY)")
                    {
                    AutoFormatType = 1;
                    }
                    column(TotalCLE5RemAmtLCY; TotalCustLedgEntry[5]."Remaining Amt. (LCY)")
                    {
                    AutoFormatType = 1;
                    }
                    column(CurrrencyCode; CurrencyCode)
                    {
                    AutoFormatExpression = CurrencyCode;
                    AutoFormatType = 1;
                    }
                    column(TotalCLE5RemAmt; TotalCustLedgEntry[5]."Remaining Amount")
                    {
                    AutoFormatType = 1;
                    }
                    column(TotalCLE4RemAmt; TotalCustLedgEntry[4]."Remaining Amount")
                    {
                    AutoFormatType = 1;
                    }
                    column(TotalCLE3RemAmt; TotalCustLedgEntry[3]."Remaining Amount")
                    {
                    AutoFormatType = 1;
                    }
                    column(TotalCLE2RemAmt; TotalCustLedgEntry[2]."Remaining Amount")
                    {
                    AutoFormatType = 1;
                    }
                    column(TotalCLE1RemAmt; TotalCustLedgEntry[1]."Remaining Amount")
                    {
                    AutoFormatType = 1;
                    }
                    column(TotalCLE1Amt; TotalCustLedgEntry[1].Amount)
                    {
                    AutoFormatType = 1;
                    }
                    column(TotalCheck; CustFilterCheck)
                    {
                    }
                    column(GrandTotalCLE1AmtLCY; GrandTotalCustLedgEntry[1]."Amount (LCY)")
                    {
                    AutoFormatType = 1;
                    }
                    column(GrandTotalCLE5PctRemAmtLCY; Pct(GrandTotalCustLedgEntry[5]."Remaining Amt. (LCY)", GrandTotalCustLedgEntry[1]."Amount (LCY)"))
                    {
                    }
                    column(GrandTotalCLE3PctRemAmtLCY; Pct(GrandTotalCustLedgEntry[3]."Remaining Amt. (LCY)", GrandTotalCustLedgEntry[1]."Amount (LCY)"))
                    {
                    }
                    column(GrandTotalCLE2PctRemAmtLCY; Pct(GrandTotalCustLedgEntry[2]."Remaining Amt. (LCY)", GrandTotalCustLedgEntry[1]."Amount (LCY)"))
                    {
                    }
                    column(GrandTotalCLE1PctRemAmtLCY; Pct(GrandTotalCustLedgEntry[1]."Remaining Amt. (LCY)", GrandTotalCustLedgEntry[1]."Amount (LCY)"))
                    {
                    }
                    column(GrandTotalCLE5RemAmtLCY; GrandTotalCustLedgEntry[5]."Remaining Amt. (LCY)")
                    {
                    AutoFormatType = 1;
                    }
                    column(GrandTotalCLE4RemAmtLCY; GrandTotalCustLedgEntry[4]."Remaining Amt. (LCY)")
                    {
                    AutoFormatType = 1;
                    }
                    column(GrandTotalCLE3RemAmtLCY; GrandTotalCustLedgEntry[3]."Remaining Amt. (LCY)")
                    {
                    AutoFormatType = 1;
                    }
                    column(GrandTotalCLE2RemAmtLCY; GrandTotalCustLedgEntry[2]."Remaining Amt. (LCY)")
                    {
                    AutoFormatType = 1;
                    }
                    column(GrandTotalCLE1RemAmtLCY; GrandTotalCustLedgEntry[1]."Remaining Amt. (LCY)")
                    {
                    AutoFormatType = 1;
                    }
                    column(PaymentTermsCode_Customer; PaymentTerms."Due Date Calculation")
                    {
                    }
                    trigger OnAfterGetRecord()
                    var
                        PeriodIndex: Integer;
                        Year3: Decimal;
                    begin
                        if Number = 1 then begin
                            if not TempCustLedgEntry.FindSet(false, false)then CurrReport.Break;
                        end
                        else if TempCustLedgEntry.Next = 0 then CurrReport.Break;
                        CustLedgEntryEndingDate.CalcFields("Original Amount");
                        CustLedgEntryEndingDate:=TempCustLedgEntry;
                        DetailedCustomerLedgerEntry.SetRange("Cust. Ledger Entry No.", CustLedgEntryEndingDate."Entry No.");
                        if DetailedCustomerLedgerEntry.FindSet(false, false)then repeat if(DetailedCustomerLedgerEntry."Entry Type" = DetailedCustomerLedgerEntry."entry type"::"Initial Entry") and (CustLedgEntryEndingDate."Posting Date" > EndingDate) and (AgingBy <> Agingby::"Posting Date")then begin
                                    if CustLedgEntryEndingDate."Document Date" <= EndingDate then DetailedCustomerLedgerEntry."Posting Date":=CustLedgEntryEndingDate."Document Date"
                                    else if(CustLedgEntryEndingDate."Due Date" <= EndingDate) and (AgingBy = Agingby::"Due Date")then DetailedCustomerLedgerEntry."Posting Date":=CustLedgEntryEndingDate."Due Date" end;
                                if(DetailedCustomerLedgerEntry."Posting Date" <= EndingDate) or (TempCustLedgEntry.Open and (AgingBy = Agingby::"Due Date") and (CustLedgEntryEndingDate."Due Date" > EndingDate) and (CustLedgEntryEndingDate."Posting Date" <= EndingDate))then begin
                                    if DetailedCustomerLedgerEntry."Entry Type" in[DetailedCustomerLedgerEntry."entry type"::"Initial Entry", DetailedCustomerLedgerEntry."entry type"::"Unrealized Loss", DetailedCustomerLedgerEntry."entry type"::"Unrealized Gain", DetailedCustomerLedgerEntry."entry type"::"Realized Loss", DetailedCustomerLedgerEntry."entry type"::"Realized Gain", DetailedCustomerLedgerEntry."entry type"::"Payment Discount", DetailedCustomerLedgerEntry."entry type"::"Payment Discount (VAT Excl.)", DetailedCustomerLedgerEntry."entry type"::"Payment Discount (VAT Adjustment)", DetailedCustomerLedgerEntry."entry type"::"Payment Tolerance", DetailedCustomerLedgerEntry."entry type"::"Payment Discount Tolerance", DetailedCustomerLedgerEntry."entry type"::"Payment Tolerance (VAT Excl.)", DetailedCustomerLedgerEntry."entry type"::"Payment Tolerance (VAT Adjustment)", DetailedCustomerLedgerEntry."entry type"::"Payment Discount Tolerance (VAT Excl.)", DetailedCustomerLedgerEntry."entry type"::"Payment Discount Tolerance (VAT Adjustment)"]then begin
                                        CustLedgEntryEndingDate.Amount:=CustLedgEntryEndingDate.Amount + DetailedCustomerLedgerEntry.Amount;
                                        CustLedgEntryEndingDate."Amount (LCY)":=CustLedgEntryEndingDate."Amount (LCY)" + DetailedCustomerLedgerEntry."Amount (LCY)";
                                    end;
                                    if DetailedCustomerLedgerEntry."Posting Date" <= EndingDate then begin
                                        CustLedgEntryEndingDate."Remaining Amount":=CustLedgEntryEndingDate."Remaining Amount" + DetailedCustomerLedgerEntry.Amount;
                                        CustLedgEntryEndingDate."Remaining Amt. (LCY)":=CustLedgEntryEndingDate."Remaining Amt. (LCY)" + DetailedCustomerLedgerEntry."Amount (LCY)";
                                    end;
                                end;
                            until DetailedCustomerLedgerEntry.Next = 0;
                        if CustLedgEntryEndingDate."Remaining Amount" = 0 then CurrReport.Skip;
                        case AgingBy of Agingby::"Due Date": PeriodIndex:=GetPeriodIndex(CustLedgEntryEndingDate."Due Date");
                        Agingby::"Posting Date": PeriodIndex:=GetPeriodIndex(CustLedgEntryEndingDate."Posting Date");
                        Agingby::"Document Date": begin
                            if CustLedgEntryEndingDate."Document Date" > EndingDate then begin
                                CustLedgEntryEndingDate."Remaining Amount":=0;
                                CustLedgEntryEndingDate."Remaining Amt. (LCY)":=0;
                                CustLedgEntryEndingDate."Document Date":=CustLedgEntryEndingDate."Posting Date";
                            end;
                            PeriodIndex:=GetPeriodIndex(CustLedgEntryEndingDate."Document Date");
                        end;
                        end;
                        Clear(AgedCustLedgEntry);
                        AgedCustLedgEntry[PeriodIndex]."Remaining Amount":=CustLedgEntryEndingDate."Remaining Amount";
                        AgedCustLedgEntry[PeriodIndex]."Remaining Amt. (LCY)":=CustLedgEntryEndingDate."Remaining Amt. (LCY)";
                        TotalCustLedgEntry[PeriodIndex]."Remaining Amount"+=CustLedgEntryEndingDate."Remaining Amount";
                        TotalCustLedgEntry[PeriodIndex]."Remaining Amt. (LCY)"+=CustLedgEntryEndingDate."Remaining Amt. (LCY)";
                        GrandTotalCustLedgEntry[PeriodIndex]."Remaining Amt. (LCY)"+=CustLedgEntryEndingDate."Remaining Amt. (LCY)";
                        TotalCustLedgEntry[1].Amount+=CustLedgEntryEndingDate."Remaining Amount";
                        TotalCustLedgEntry[1]."Amount (LCY)"+=CustLedgEntryEndingDate."Remaining Amt. (LCY)";
                        GrandTotalCustLedgEntry[1]."Amount (LCY)"+=CustLedgEntryEndingDate."Remaining Amt. (LCY)";
                        if PrintToExcel then MakeExcelDataBody;
                        // BIS Start
                        LRNo:='';
                        if SalesInvoiceHeader.Get(CustLedgEntryEndingDate."Document No.")then LRNo:=SalesInvoiceHeader."LR/RR No.";
                        ActDelDate:=0D;
                        SalesInvoiceHeader.Reset;
                        if SalesInvoiceHeader.Get(TempCustLedgEntry."Document No.")then ActDelDate:=SalesInvoiceHeader."Actual Delivery Date";
                        //BIS End;
                        DDD:=0D;
                        DDC:=0D;
                        N:=0;
                        Month2:=false;
                        //Alle_201218
                        PaymentTerms.Get(Customer."Payment Terms Code");
                        DDD:=0D;
                        DDC:=0D;
                        if(Customer."Customer Posting Group" = 'SP') or (Customer."DDC as Per Invoice Date")then begin
                            DDD:=CustLedgEntryEndingDate."Due Date";
                            DDC:=CustLedgEntryEndingDate."Due Date";
                        end
                        else if ActDelDate <> 0D then begin
                                DDD:=CalcDate(PaymentTerms."Due Date Calculation", ActDelDate);
                                Bool:=true;
                            end
                            else
                                Bool:=false;
                        if(CustLedgEntryEndingDate."Source Code" = 'BANKRCPTV') or (CustLedgEntryEndingDate."Source Code" = 'JOURNALV')then begin
                            DDD:=CustLedgEntryEndingDate."Due Date";
                            DDC:=CustLedgEntryEndingDate."Due Date";
                        end;
                        if Bool = true then begin
                            I:=Date2dmy(DDD, 1);
                            M:=Date2dmy(DDD, 2);
                            Y:=Date2dmy(DDD, 3);
                            B[1]:=Customer."Payment Cycle 1";
                            B[2]:=Customer."Payment Cycle 2";
                            B[3]:=Customer."Payment Cycle 3";
                            B[4]:=Customer."Payment Cycle 4";
                            C[1]:=0;
                            C[2]:=0;
                            C[3]:=0;
                            C[4]:=0;
                            if((B[1] <> 0) or (B[2] <> 0) or (B[3] <> 0) or (B[4] <> 0))then begin
                                D:=0;
                                E:=0;
                                for J:=1 to 4 do begin
                                    if B[J] <> 0 then begin
                                        C[D + 1]:=B[J];
                                        D+=1;
                                        E+=1;
                                        if B[J] > I then D2:=1;
                                    end; //ELSE
                                //  J:=J-1;
                                //EXIT;
                                end;
                                for J:=1 to 4 do begin
                                    if(C[J] <> 0) and (J < 4)then begin
                                        if D = 1 then begin
                                            if(I >= C[J])then begin
                                                if C[J + 1] <> 0 then N:=C[J + 1]
                                                else
                                                    N:=C[J]end end
                                        else if(I >= C[J]) and (I <= C[J + 1])then //IF C[J+1] <> 0 THEN
                                                if(C[J + 1] <> 0) and (I <> C[J + 1])then //Alle 25052021
 N:=C[J + 1]
                                                else
                                                    N:=C[J]end
                                    else
                                    begin
                                        if N = 0 then begin
                                            N:=B[1];
                                        end;
                                        if I > N then begin
                                            DDC:=CalcDate('<1M>', DDD);
                                            M1:=Date2dmy(DDC, 2);
                                            Y1:=Date2dmy(DDC, 3);
                                            DDC:=Dmy2date(N, M1, Y1);
                                            //DDC := CALCDATE('<1M',DDC);
                                            Bool:=false;
                                        //  ELSE
                                        //   DDC := CALCDATE('<1M>', DDD)
                                        end;
                                    end;
                                    //ERROR('');
                                    if N <> 0 then if(Bool = true)then begin
                                            if(M = 2) and (DDC <> 0D)then begin
                                                if(Y MOD 4) = 0 then begin
                                                    if N > 29 then N:=29 end
                                                else
                                                begin
                                                    if N > 28 then N:=28;
                                                    DDC:=Dmy2date(N, M, Y);
                                                end;
                                            end;
                                            if(M = 2) and (DDC = 0D) and (N > 29)then begin
                                                if(Y MOD 4) = 0 then begin
                                                    if N > 29 then N:=29 end
                                                else
                                                begin
                                                    if N > 28 then N:=28;
                                                    DDC:=Dmy2date(N, M, Y);
                                                    Month2:=true;
                                                end;
                                            end;
                                            //   N2 := N + D; //Alle
                                            if M = 2 then begin //Alle
                                                if(N = 28) and Month2 then DDC:=Dmy2date(2, M + 1, Y)
                                                else if(N = 29) and Month2 then DDC:=Dmy2date(1, M + 1, Y)
                                                    else // Alle
                                                        DDC:=Dmy2date(N, M, Y);
                                            end
                                            else
                                            begin //Add begin 25052021 <<--
                                                // DDC :=  DMY2DATE(N,M,Y)
                                                if I > N then DDC:=Dmy2date(N, M, Y)
                                                else if I < N then // DDC := (DMY2DATE(N,M+1,Y));
                                                        DDC:=(Dmy2date(N, M, Y));
                                            end; //-->> 25032021
                                        end;
                                end;
                            end;
                            if((B[1] = 0) and (B[2] = 0) and (B[3] = 0) and (B[4] = 0))then DDC:=DDD;
                        end;
                        if(DDC = 0D) and (ActDelDate <> 0D)then begin
                            DDD1:=CalcDate('<CM+1D>', DDD);
                            Nextmonth:=Date2dmy(DDD1, 2);
                            Year:=Date2dmy(DDD1, 3);
                            DDC:=Dmy2date(Customer."Payment Cycle 1", Nextmonth, Year);
                        end;
                        ComercialDocNo:=CopyStr(CustLedgEntryEndingDate."Document No.", 1, 4);
                        if ComercialDocNo = 'BPCI' then begin
                            DDD:=CustLedgEntryEndingDate."Due Date";
                        end;
                        if(ComercialDocNo = 'BPCI') and (DDC = 0D)then begin
                            DDD2:=CalcDate('<CM+1D>', DDD);
                            Nextmonth2:=Date2dmy(DDD2, 2);
                            Year2:=Date2dmy(DDD2, 3);
                            DDC:=Dmy2date(Customer."Payment Cycle 1", Nextmonth2, Year2);
                        end;
                    // IF (ComercialDocNo = 'BPCI') AND (DDC=0D) AND (ActDelDate = 0D) AND (Customer."Payment Cycle 2" <> 0) THEN BEGIN
                    //  Nextmonth4 :=  DATE2DMY(DDD,2);
                    //  Year4 := DATE2DMY(DDD,3);
                    //  DDC := DMY2DATE(Customer."Payment Cycle 2",Nextmonth4,Year4);
                    // END;
                    // IF (ActDelDate=0D) AND (Customer."Payment Cycle 3" <> 0) THEN BEGIN
                    //  DDD := CustLedgEntryEndingDate."Due Date";
                    //  Nextmonth3 := DATE2DMY(DDD,2);
                    //  Year3 := DATE2DMY(DDD,3);
                    //  DDC := DMY2DATE(Customer."Payment Cycle 3",Nextmonth3,Year3);
                    // END;
                    //IF CustLedgEntryEndingDate."Source Code" IN ['BANKRCPTV,JOURNALV'] THEN BEGIN
                    /*
                         FOR J:=1 TO 4 DO BEGIN
                          BufferAgedAcountReport.INIT;
                          BufferAgedAcountReport."Cust No." :=Customer."No.";
                          BufferAgedAcountReport.DDC := DDD;
                          BufferAgedAcountReport.Num := A[J];
                          BufferAgedAcountReport."Payment cycle" := B[J];
                          BufferAgedAcountReport.INSERT;
                         END;*/
                    //END;
                    //Custno := Customer."No.";
                    // IF Bool = TRUE THEN
                    // BufferAgedAcountReport2.RESET;
                    // BufferAgedAcountReport2.SETRANGE("Cust No.",Customer."No.");
                    // BufferAgedAcountReport2.SETRANGE(DDC,CustLedgEntryEndingDate."Due Date");
                    // BufferAgedAcountReport2.ASCENDING(TRUE);
                    // IF BufferAgedAcountReport2.FINDFIRST THEN BEGIN
                    //  EVALUATE(DDC1,FORMAT(BufferAgedAcountReport2."Payment cycle") +'D');
                    //  DDC := CALCDATE(DDC1,DDD);
                    // END;
                    //Alle_201218
                    end;
                    trigger OnPostDataItem()
                    begin
                        if not PrintAmountInLCY then UpdateCurrencyTotals;
                    end;
                    trigger OnPreDataItem()
                    begin
                        if not PrintAmountInLCY then TempCustLedgEntry.SetRange("Currency Code", TempCurrency.Code);
                        PageGroupNo:=NextPageGroupNo;
                        if NewPagePercustomer and (NumberOfCurrencies > 0)then NextPageGroupNo:=PageGroupNo + 1;
                        DDD:=0D;
                        DDC:=0D;
                        N:=0;
                    end;
                }
                trigger OnAfterGetRecord()
                begin
                    Clear(TotalCustLedgEntry);
                    if Number = 1 then begin
                        if not TempCurrency.FindSet(false, false)then CurrReport.Break;
                    end
                    else if TempCurrency.Next = 0 then CurrReport.Break;
                    if TempCurrency.Code <> '' then CurrencyCode:=TempCurrency.Code
                    else
                        CurrencyCode:=GLSetup."LCY Code";
                    NumberOfCurrencies:=NumberOfCurrencies + 1;
                end;
                trigger OnPreDataItem()
                begin
                    NumberOfCurrencies:=0;
                end;
            }
            trigger OnAfterGetRecord()
            begin
                if NewPagePercustomer then PageGroupNo+=1;
                TempCurrency.Reset;
                TempCurrency.DeleteAll;
                TempCustLedgEntry.Reset;
                TempCustLedgEntry.DeleteAll;
            end;
            trigger OnPreDataItem()
            begin
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
            column(CurrNo; Number = 1)
            {
            }
            column(TempCurrCode; TempCurrency2.Code)
            {
            AutoFormatExpression = CurrencyCode;
            AutoFormatType = 1;
            }
            column(AgedCLE6RemAmt; AgedCustLedgEntry[6]."Remaining Amount")
            {
            AutoFormatExpression = CurrencyCode;
            AutoFormatType = 1;
            }
            column(AgedCLE1RemAmt; AgedCustLedgEntry[1]."Remaining Amount")
            {
            AutoFormatExpression = CurrencyCode;
            AutoFormatType = 1;
            }
            column(AgedCLE2RemAmt; AgedCustLedgEntry[2]."Remaining Amount")
            {
            AutoFormatExpression = CurrencyCode;
            AutoFormatType = 1;
            }
            column(AgedCLE3RemAmt; AgedCustLedgEntry[3]."Remaining Amount")
            {
            AutoFormatExpression = CurrencyCode;
            AutoFormatType = 1;
            }
            column(AgedCLE4RemAmt; AgedCustLedgEntry[4]."Remaining Amount")
            {
            AutoFormatExpression = CurrencyCode;
            AutoFormatType = 1;
            }
            column(AgedCLE5RemAmt; AgedCustLedgEntry[5]."Remaining Amount")
            {
            AutoFormatExpression = CurrencyCode;
            AutoFormatType = 1;
            }
            column(CurrSpecificationCptn; CurrSpecificationCptnLbl)
            {
            }
            trigger OnAfterGetRecord()
            begin
                if Number = 1 then begin
                    if not TempCurrency2.FindSet(false, false)then CurrReport.Break;
                end
                else if TempCurrency2.Next = 0 then CurrReport.Break;
                Clear(AgedCustLedgEntry);
                TempCurrencyAmount.SetRange("Currency Code", TempCurrency2.Code);
                if TempCurrencyAmount.FindSet(false, false)then repeat if TempCurrencyAmount.Date <> 99991231D then AgedCustLedgEntry[GetPeriodIndex(TempCurrencyAmount.Date)]."Remaining Amount":=TempCurrencyAmount.Amount
                        else
                            AgedCustLedgEntry[6]."Remaining Amount":=TempCurrencyAmount.Amount;
                    until TempCurrencyAmount.Next = 0;
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
                        ApplicationArea = All;
                        Caption = 'Aged As Of';
                    }
                    field(Agingby; AgingBy)
                    {
                        ApplicationArea = All;
                        Caption = 'Aging by';
                        OptionCaption = 'Due Date,Posting Date,Document Date';
                    }
                    field(PeriodLength; PeriodLength)
                    {
                        ApplicationArea = All;
                        Caption = 'Period Length';
                    }
                    field(AmountsinLCY; PrintAmountInLCY)
                    {
                        ApplicationArea = All;
                        Caption = 'Print Amounts in LCY';
                    }
                    field(PrintDetails; PrintDetails)
                    {
                        ApplicationArea = All;
                        Caption = 'Print Details';
                    }
                    field(HeadingType; HeadingType)
                    {
                        ApplicationArea = All;
                        Caption = 'Heading Type';
                        OptionCaption = 'Date Interval,Number of Days';
                    }
                    field(perCustomer; NewPagePercustomer)
                    {
                        ApplicationArea = All;
                        Caption = 'New Page per Customer';
                    }
                    field(PrintToExcel; PrintToExcel)
                    {
                        ApplicationArea = All;
                        Caption = 'Print to Excel';
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
            PrintToExcel:=false;
        end;
    }
    labels
    {
    BalanceCaption='Balance';
    }
    trigger OnPostReport()
    begin
        if PrintToExcel then CreateExcelbook;
    end;
    trigger OnPreReport()
    begin
        CustFilter:=Customer.GetFilters;
        GLSetup.Get;
        CalcDates;
        CreateHeadings;
        if PrintToExcel then MakeExcelInfo;
        PageGroupNo:=1;
        NextPageGroupNo:=1;
        CustFilterCheck:=(CustFilter <> 'No.');
    end;
    var FileManagement: Codeunit "File Management";
    PaymentTerms: Record "Payment Terms";
    GLSetup: Record "General Ledger Setup";
    TempCustLedgEntry: Record "Cust. Ledger Entry" temporary;
    CustLedgEntryEndingDate: Record "Cust. Ledger Entry";
    TotalCustLedgEntry: array[5]of Record "Cust. Ledger Entry";
    GrandTotalCustLedgEntry: array[5]of Record "Cust. Ledger Entry";
    AgedCustLedgEntry: array[6]of Record "Cust. Ledger Entry";
    TempCurrency: Record Currency temporary;
    TempCurrency2: Record Currency temporary;
    TempCurrencyAmount: Record "Currency Amount" temporary;
    ExcelBuf: Record "Excel Buffer" temporary;
    DetailedCustomerLedgerEntry: Record "Detailed Cust. Ledg. Entry";
    CustFilter: Text;
    PrintAmountInLCY: Boolean;
    EndingDate: Date;
    AgingBy: Option "Due Date", "Posting Date", "Document Date";
    PeriodLength: DateFormula;
    PrintDetails: Boolean;
    HeadingType: Option "Date Interval", "Number of Days";
    NewPagePercustomer: Boolean;
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
    Text008: label 'All Amounts in LCY';
    NumberOfCurrencies: Integer;
    Text009: label 'Due Date,Posting Date,Document Date';
    Text010: label 'The Date Formula %1 cannot be used. Try to restate it. E.g. 1M+CM instead of CM+1M.';
    PageGroupNo: Integer;
    NextPageGroupNo: Integer;
    PrintToExcel: Boolean;
    Text011: label 'Data';
    Text012: label 'Aged Accounts Receivable';
    Text013: label 'Company Name';
    Text014: label 'Report No.';
    Text015: label 'Report Name';
    Text016: label 'User ID';
    Text017: label 'Date';
    Text018: label 'Customer Filters';
    Text019: label 'Cust. Ledger Entry Filters';
    CustFilterCheck: Boolean;
    Text032: label '-%1', Comment = 'Negating the period length: %1 is the period length';
    AgedAccReceivableCptnLbl: label 'Aged Accounts Receivable';
    CurrReportPageNoCptnLbl: label 'Page';
    AllAmtinLCYCptnLbl: label 'All Amounts in LCY';
    AgedOverdueAmtCptnLbl: label 'Aged Overdue Amounts';
    CLEEndDateAmtLCYCptnLbl: label 'Original Amount ';
    CLEEndDateDueDateCptnLbl: label 'Due Date';
    CLEEndDateDocNoCptnLbl: label 'Document No.';
    CLEEndDatePstngDateCptnLbl: label 'Posting Date';
    CLEEndDateDocTypeCptnLbl: label 'Document Type';
    OriginalAmtCptnLbl: label 'Currency Code';
    TotalLCYCptnLbl: label 'Total (LCY)';
    CurrSpecificationCptnLbl: label 'Currency Specification';
    CompanyInfoRec: Record "Company Information";
    SalesInvoiceHeader: Record "Sales Invoice Header";
    LRNo: Code[20];
    HeaderPrinted: Boolean;
    ActDelDate: Date;
    DDD: Date;
    DDC: Date;
    DDD1: Date;
    DDC1: DateFormula;
    I: Integer;
    M: Integer;
    Y: Integer;
    J: Integer;
    K: array[4]of Integer;
    N: Integer;
    Custno: Code[20];
    Bool: Boolean;
    B: array[4]of Integer;
    A: array[4]of Decimal;
    C: array[4]of Integer;
    M1: Integer;
    Y1: Integer;
    D: Integer;
    E: Integer;
    N2: Integer;
    D2: Integer;
    Month2: Boolean;
    ComercialDocNo: Code[10];
    Nextmonth: Integer;
    Year: Integer;
    Nextmonth2: Integer;
    Year2: Integer;
    DDD2: Date;
    Nextmonth3: Integer;
    Year3: Integer;
    Nextmonth4: Integer;
    Year4: Integer;
    local procedure CalcDates()
    var
        i: Integer;
        PeriodLength2: DateFormula;
    begin
        Evaluate(PeriodLength2, StrSubstNo(Text032, PeriodLength));
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
        if HeadingType = Headingtype::"Date Interval" then HeaderText[i]:=StrSubstNo('%1 %2', Text001, PeriodStartDate[i - 1])
        else
            HeaderText[i]:=StrSubstNo('%1 \%2 %3', Text003, EndingDate - PeriodStartDate[i - 1] + 1, Text002);
    end;
    local procedure InsertTemp(var CustLedgEntry: Record "Cust. Ledger Entry")
    var
        Currency: Record Currency;
    begin
        if TempCustLedgEntry.Get(CustLedgEntry."Entry No.")then exit;
        TempCustLedgEntry:=CustLedgEntry;
        TempCustLedgEntry.Insert;
        if PrintAmountInLCY then begin
            Clear(TempCurrency);
            TempCurrency."Amount Rounding Precision":=GLSetup."Amount Rounding Precision";
            if TempCurrency.Insert then;
            exit;
        end;
        if TempCurrency.Get(TempCustLedgEntry."Currency Code")then exit;
        if TempCustLedgEntry."Currency Code" <> '' then Currency.Get(TempCustLedgEntry."Currency Code")
        else
        begin
            Clear(Currency);
            Currency."Amount Rounding Precision":=GLSetup."Amount Rounding Precision";
        end;
        TempCurrency:=Currency;
        TempCurrency.Insert;
    end;
    local procedure GetPeriodIndex(Date: Date): Integer var
        i: Integer;
    begin
        for i:=1 to ArrayLen(PeriodEndDate)do if Date in[PeriodStartDate[i] .. PeriodEndDate[i]]then exit(i);
    end;
    local procedure Pct(a: Decimal; b: Decimal): Text[30]begin
        if b <> 0 then exit(Format(ROUND(100 * a / b, 0.1), 0, '<Sign><Integer><Decimals,2>') + '%');
    end;
    local procedure UpdateCurrencyTotals()
    var
        i: Integer;
    begin
        TempCurrency2.Code:=CurrencyCode;
        if TempCurrency2.Insert then;
        for i:=1 to ArrayLen(TotalCustLedgEntry)do begin
            TempCurrencyAmount."Currency Code":=CurrencyCode;
            TempCurrencyAmount.Date:=PeriodStartDate[i];
            if TempCurrencyAmount.Find then begin
                TempCurrencyAmount.Amount:=TempCurrencyAmount.Amount + TotalCustLedgEntry[i]."Remaining Amount";
                TempCurrencyAmount.Modify;
            end
            else
            begin
                TempCurrencyAmount."Currency Code":=CurrencyCode;
                TempCurrencyAmount.Date:=PeriodStartDate[i];
                TempCurrencyAmount.Amount:=TotalCustLedgEntry[i]."Remaining Amount";
                TempCurrencyAmount.Insert;
            end;
        end;
        TempCurrencyAmount."Currency Code":=CurrencyCode;
        TempCurrencyAmount.Date:=99991231D;
        if TempCurrencyAmount.Find then begin
            TempCurrencyAmount.Amount:=TempCurrencyAmount.Amount + TotalCustLedgEntry[1].Amount;
            TempCurrencyAmount.Modify;
        end
        else
        begin
            TempCurrencyAmount."Currency Code":=CurrencyCode;
            TempCurrencyAmount.Date:=99991231D;
            TempCurrencyAmount.Amount:=TotalCustLedgEntry[1].Amount;
            TempCurrencyAmount.Insert;
        end;
    end;
    procedure MakeExcelInfo()
    begin
        ExcelBuf.SetUseInfoSheet;
        //SSDU Comment Start
        // ExcelBuf.AddInfoColumn(Format(Text013), false, '', true, false, false, '', ExcelBuf."cell type"::Text); 
        // ExcelBuf.AddInfoColumn(COMPANYNAME, false, '', false, false, false, '', ExcelBuf."cell type"::Text);
        // ExcelBuf.NewRow;
        // ExcelBuf.AddInfoColumn(Format(Text015), false, '', true, false, false, '', ExcelBuf."cell type"::Text);
        // ExcelBuf.AddInfoColumn(Format(Text012), false, '', false, false, false, '', ExcelBuf."cell type"::Text);
        // ExcelBuf.NewRow;
        // ExcelBuf.AddInfoColumn(Format(Text014), false, '', true, false, false, '', ExcelBuf."cell type"::Text);
        // ExcelBuf.AddInfoColumn(Report::"Aged Accounts Receivable", false, '', false, false, false, '', ExcelBuf."cell type"::Number);
        // ExcelBuf.NewRow;
        // ExcelBuf.AddInfoColumn(Format(Text016), false, '', true, false, false, '', ExcelBuf."cell type"::Text);
        // ExcelBuf.AddInfoColumn(UserId, false, '', false, false, false, '', ExcelBuf."cell type"::Text);
        // ExcelBuf.NewRow;
        // ExcelBuf.AddInfoColumn(Format(Text017), false, '', true, false, false, '', ExcelBuf."cell type"::Text);
        // ExcelBuf.AddInfoColumn(Today, false, '', false, false, false, '', ExcelBuf."cell type"::Date);
        // ExcelBuf.NewRow;
        // ExcelBuf.AddInfoColumn(Format(Text018), false, '', true, false, false, '', ExcelBuf."cell type"::Text);
        // ExcelBuf.AddInfoColumn(Customer.GetFilters, false, '', false, false, false, '', ExcelBuf."cell type"::Text);
        // ExcelBuf.NewRow;
        // ExcelBuf.AddInfoColumn(Format(Text019), false, '', true, false, false, '', ExcelBuf."cell type"::Text);
        // ExcelBuf.AddInfoColumn("Cust. Ledger Entry".GetFilters, false, '', false, false, false, '', ExcelBuf."cell type"::Text);
        // if PrintAmountInLCY then begin
        //     ExcelBuf.NewRow;
        //     ExcelBuf.AddInfoColumn(Format(Text008), false, '', true, false, false, '', ExcelBuf."cell type"::Text);
        //     ExcelBuf.AddInfoColumn(PrintAmountInLCY, false, '', false, false, false, '', ExcelBuf."cell type"::Text);
        // end;
        // ExcelBuf.NewRow;
        // ExcelBuf.AddInfoColumn(Format(CopyStr(Text004, 1, 7)), false, '', true, false, false, '', ExcelBuf."cell type"::Text);
        // ExcelBuf.AddInfoColumn(Format(SelectStr(AgingBy + 1, Text009)), false, '', false, false, false, '', ExcelBuf."cell type"::Text);
        // ExcelBuf.ClearNewRow;
        //SSDU Comment End
        MakeExcelDataHeader;
    end;
    local procedure MakeExcelDataHeader()
    begin
        ExcelBuf.NewRow;
        ExcelBuf.AddColumn(Customer.FieldCaption("No."), false, '', true, false, true, '', ExcelBuf."cell type"::Text);
        ExcelBuf.AddColumn(Customer.FieldCaption(Name), false, '', true, false, true, '', ExcelBuf."cell type"::Text);
        ExcelBuf.AddColumn(TempCustLedgEntry.FieldCaption("Posting Date"), false, '', true, false, true, '', ExcelBuf."cell type"::Text);
        ExcelBuf.AddColumn(TempCustLedgEntry.FieldCaption("Document Type"), false, '', true, false, true, '', ExcelBuf."cell type"::Text);
        ExcelBuf.AddColumn(TempCustLedgEntry.FieldCaption("Document No."), false, '', true, false, true, '', ExcelBuf."cell type"::Text);
        ExcelBuf.AddColumn(TempCustLedgEntry.FieldCaption("Due Date"), false, '', true, false, true, '', ExcelBuf."cell type"::Text);
        if not PrintAmountInLCY then begin
            ExcelBuf.AddColumn(TempCustLedgEntry.FieldCaption("Currency Code"), false, '', true, false, true, '', ExcelBuf."cell type"::Text);
            ExcelBuf.AddColumn(TempCustLedgEntry.FieldCaption("Original Amount"), false, '', true, false, true, '', ExcelBuf."cell type"::Text);
            ExcelBuf.AddColumn(TempCustLedgEntry.FieldCaption("Remaining Amount"), false, '', true, false, true, '', ExcelBuf."cell type"::Text);
        end
        else
        begin
            ExcelBuf.AddColumn(TempCustLedgEntry.FieldCaption("Original Amt. (LCY)"), false, '', true, false, true, '', ExcelBuf."cell type"::Text);
            ExcelBuf.AddColumn(TempCustLedgEntry.FieldCaption("Remaining Amt. (LCY)"), false, '', true, false, true, '', ExcelBuf."cell type"::Text);
        end;
    end;
    procedure MakeExcelDataBody()
    begin
        ExcelBuf.NewRow;
        ExcelBuf.AddColumn(Customer."No.", false, '', false, false, false, '', ExcelBuf."cell type"::Text);
        ExcelBuf.AddColumn(Customer.Name, false, '', false, false, false, '', ExcelBuf."cell type"::Text);
        ExcelBuf.AddColumn(TempCustLedgEntry."Posting Date", false, '', false, false, false, '', ExcelBuf."cell type"::Date);
        ExcelBuf.AddColumn(Format(TempCustLedgEntry."Document Type"), false, '', false, false, false, '', ExcelBuf."cell type"::Text);
        ExcelBuf.AddColumn(TempCustLedgEntry."Document No.", false, '', false, false, false, '', ExcelBuf."cell type"::Text);
        ExcelBuf.AddColumn(TempCustLedgEntry."Due Date", false, '', false, false, false, '', ExcelBuf."cell type"::Date);
        if PrintAmountInLCY then begin
            ExcelBuf.AddColumn(CustLedgEntryEndingDate."Amount (LCY)", false, '', false, false, false, '#,##0.00', ExcelBuf."cell type"::Number);
            ExcelBuf.AddColumn(CustLedgEntryEndingDate."Remaining Amt. (LCY)", false, '', false, false, false, '#,##0.00', ExcelBuf."cell type"::Number);
        end
        else
        begin
            ExcelBuf.AddColumn(CurrencyCode, false, '', false, false, false, '', ExcelBuf."cell type"::Text);
            ExcelBuf.AddColumn(CustLedgEntryEndingDate.Amount, false, '', false, false, false, '#,##0.00', ExcelBuf."cell type"::Number);
            ExcelBuf.AddColumn(CustLedgEntryEndingDate."Remaining Amount", false, '', false, false, false, '#,##0.00', ExcelBuf."cell type"::Number);
        end;
    end;
    procedure CreateExcelbook()
    begin
    //SSDU ExcelBuf.CreateBookAndOpenExcel(FileManagement.ServerTempFileName('xlsx'), Text011, Text012, COMPANYNAME, UserId); 
    //ERROR('');
    end;
    procedure InitializeRequest(NewEndingDate: Date; NewAgingBy: Option; NewPeriodLength: DateFormula; NewPrintAmountInLCY: Boolean; NewPrintDetails: Boolean; NewHeadingType: Option; NewPagePercust: Boolean; NewPrintToExcel: Boolean)
    begin
        EndingDate:=NewEndingDate;
        AgingBy:=NewAgingBy;
        PeriodLength:=NewPeriodLength;
        PrintAmountInLCY:=NewPrintAmountInLCY;
        PrintDetails:=NewPrintDetails;
        HeadingType:=NewHeadingType;
        NewPagePercustomer:=NewPagePercust;
        PrintToExcel:=NewPrintToExcel;
    end;
    local procedure DDCFeb()
    begin
    // FOR J:=1 TO 4 DO BEGIN
    // IF (C[J] <> 0) AND (J< 4) THEN BEGIN
    //  IF D = 1 THEN BEGIN
    //    IF (I >= C[J] ) THEN BEGIN
    //      IF C[J+1] <> 0 THEN
    //       N := C[J+1]
    //      ELSE
    //       N := C[J]
    //    END
    //  END
    //  ELSE
    // IF (I >= C[J] ) AND (I <=C[J+1]) THEN
    //   IF C[J+1] <> 0 THEN
    //     N := C[J+1]
    //   ELSE
    //     N := C[J]
    //
    // END ELSE BEGIN
    // IF N = 0 THEN BEGIN
    //   N := B[1];
    // END;
    //  IF I > N THEN BEGIN
    //   DDC := CALCDATE('<1M>', DDD);
    //    M1 := DATE2DMY(DDC,2);
    //    Y1 := DATE2DMY(DDC,3);
    //   DDC := DMY2DATE(N,M1,Y1);
    //   //DDC := CALCDATE('<1M',DDC);
    //   Bool :=FALSE;
    // //  ELSE
    // //   DDC := CALCDATE('<1M>', DDD)
    //  END;
    // END;
    end;
}
