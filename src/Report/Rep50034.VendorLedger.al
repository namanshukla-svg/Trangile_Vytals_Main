Report 50034 "Vendor Ledger"
{
    // //Alle-HB-16oct15-------- GL Entry Details added
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Vendor Ledger.rdl';
    Caption = 'Vendor Ledger';
    ApplicationArea = all;
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem(Vendor; Vendor)
        {
            DataItemTableView = sorting("No.");
            PrintOnlyIfDetail = true;
            RequestFilterFields = "No.", "Search Name", "Vendor Posting Group", "Date Filter";

            column(ReportForNavId_3182;3182)
            {
            }
            column(PrintDetail; PrintDetail)
            {
            }
            column(PrintNarration; PrintNarration)
            {
            }
            column(OpeCreBalTxt; OpeCreBal)
            {
            }
            column(OpeDeBalTxt; OpeDeBal)
            {
            }
            column(ViewAppliedEntries; ViewAppliedEntries)
            {
            }
            column(FORMAT_TODAY_0_4_; Format(Today, 0, 4))
            {
            }
            column(STRSUBSTNO_Text000_VendDateFilter_; StrSubstNo(Text000, VendDateFilter))
            {
            }
            column(CurrReport_PAGENO; CurrReport.PageNo)
            {
            }
            column(UserId; UserId)
            {
            }
            column(ResCen__Country_Region_Code_; CompanyInformationRec."Country/Region Code")
            {
            }
            column(ResCen_City; CompanyInformationRec.City)
            {
            }
            column(ResCen__Post_Code_; CompanyInformationRec."Post Code")
            {
            }
            column(ResCen_State; StateName)
            {
            }
            column(ResCen__Address_2_; CompanyInformationRec."Address 2")
            {
            }
            column(ResCen_Address; CompanyInformationRec.Address)
            {
            }
            column(ResCen_Name; CompanyInformationRec.Name)
            {
            }
            column(Vendor__No__; "No.")
            {
            }
            column(Vendor_Name; Name)
            {
            }
            column(Vendor__Phone_No__; "Phone No.")
            {
            }
            column(StartBalanceLCY; StartBalanceLCY)
            {
            AutoFormatType = 1;
            }
            column(DeBal; DeBal)
            {
            AutoFormatType = 1;
            }
            column(CreBal; CreBal)
            {
            AutoFormatType = 1;
            }
            column(StartBalAdjLCY; StartBalAdjLCY)
            {
            AutoFormatType = 1;
            }
            column(VendBalanceLCY; VendBalanceLCY)
            {
            AutoFormatType = 1;
            }
            column(DeBal_Control1000000064; DeBal)
            {
            AutoFormatType = 1;
            }
            column(CreBal_Control1000000065; CreBal)
            {
            AutoFormatType = 1;
            }
            column(StartBalAdjLCY_Control65; StartBalAdjLCY)
            {
            AutoFormatType = 1;
            }
            column(Vendor_Ledger_Entry___Amount__LCY_____Correction___ApplicationRounding; "Vendor Ledger Entry"."Amount (LCY)" + Correction + ApplicationRounding)
            {
            AutoFormatType = 1;
            }
            column(DeBal_Control1000000086; DeBal)
            {
            AutoFormatType = 1;
            }
            column(CreBal_Control1000000087; CreBal)
            {
            AutoFormatType = 1;
            }
            column(DeBal1; DeBal1)
            {
            AutoFormatType = 1;
            }
            column(CreBal1; CreBal1)
            {
            AutoFormatType = 1;
            }
            column(DeBal2; DeBal2)
            {
            AutoFormatType = 1;
            }
            column(CreBal2; CreBal2)
            {
            AutoFormatType = 1;
            }
            column(Vendor_Ledger_Entry___Amount__LCY_____Correction___ApplicationRounding_Control31; "Vendor Ledger Entry"."Amount (LCY)" + Correction + ApplicationRounding)
            {
            AutoFormatType = 1;
            }
            column(StartBalanceLCY___StartBalAdjLCY____Vendor_Ledger_Entry___Amount__LCY_____Correction___ApplicationRounding; StartBalanceLCY + StartBalAdjLCY + "Vendor Ledger Entry"."Amount (LCY)" + Correction + ApplicationRounding)
            {
            AutoFormatType = 1;
            }
            column(DeBal_Control1000000092; DeBal)
            {
            AutoFormatType = 1;
            }
            column(CreBal_Control1000000093; CreBal)
            {
            AutoFormatType = 1;
            }
            column(DeBal_Control1000000094; DeBal)
            {
            AutoFormatType = 1;
            }
            column(CreBal_Control1000000095; CreBal)
            {
            AutoFormatType = 1;
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(Vendor_LedgerCaption; Vendor_LedgerCaptionLbl)
            {
            }
            column(All_amounts_are_in_LCYCaption; All_amounts_are_in_LCYCaptionLbl)
            {
            }
            column(BalanceCaption; BalanceCaptionLbl)
            {
            }
            column(Vendor_Ledger_Entry__Credit_Amount_Caption; "Vendor Ledger Entry".FieldCaption("Credit Amount"))
            {
            }
            column(Vendor_Ledger_Entry__Debit_Amount_Caption; "Vendor Ledger Entry".FieldCaption("Debit Amount"))
            {
            }
            column(CheckDateCaption; CheckDateCaptionLbl)
            {
            }
            column(CheckNoCaption; CheckNoCaptionLbl)
            {
            }
            column(Invoice_No_Caption; Invoice_No_CaptionLbl)
            {
            }
            column(NarrationCaption; NarrationCaptionLbl)
            {
            }
            column(Doc__No_Caption; Doc__No_CaptionLbl)
            {
            }
            column(Vendor_Ledger_Entry__Posting_Date_Caption; "Vendor Ledger Entry".FieldCaption("Posting Date"))
            {
            }
            column(Invoice_DateCaption; Invoice_DateCaptionLbl)
            {
            }
            column(Debit_Bal_Caption; Debit_Bal_CaptionLbl)
            {
            }
            column(Credit_Bal_Caption; Credit_Bal_CaptionLbl)
            {
            }
            column(TDS_AmountCaption; TDS_AmountCaptionLbl)
            {
            }
            column(Pre_AsgNoCaption; Pre_AsgNoCaptionLbl)
            {
            }
            column(BalanceCaption_Control1000000025; BalanceCaption_Control1000000025Lbl)
            {
            }
            column(Credit_AmountCaption; Credit_AmountCaptionLbl)
            {
            }
            column(Debit_AmountCaption; Debit_AmountCaptionLbl)
            {
            }
            column(Chq__DateCaption; Chq__DateCaptionLbl)
            {
            }
            column(NarrationCaption_Control1000000041; NarrationCaption_Control1000000041Lbl)
            {
            }
            column(Doc__No_Caption_Control1000000042; Doc__No_Caption_Control1000000042Lbl)
            {
            }
            column(Posting_DateCaption; Posting_DateCaptionLbl)
            {
            }
            column(Invoice_No_Caption_Control1000000044; Invoice_No_Caption_Control1000000044Lbl)
            {
            }
            column(Chq__No_Caption; Chq__No_CaptionLbl)
            {
            }
            column(Invoice_DateCaption_Control1000000052; Invoice_DateCaption_Control1000000052Lbl)
            {
            }
            column(Credit_Bal_Caption_Control1000000056; Credit_Bal_Caption_Control1000000056Lbl)
            {
            }
            column(Debit_Bal_Caption_Control1000000057; Debit_Bal_Caption_Control1000000057Lbl)
            {
            }
            column(TDS_AmountCaption_Control1000000097; TDS_AmountCaption_Control1000000097Lbl)
            {
            }
            column(Pre_AsgNoCaption_Control1000000071; Pre_AsgNoCaption_Control1000000071Lbl)
            {
            }
            column(Vendor__Phone_No__Caption; FieldCaption("Phone No."))
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
            column(Vendor_Date_Filter; "Date Filter")
            {
            }
            column(Vendor_Global_Dimension_1_Filter; "Global Dimension 1 Filter")
            {
            }
            column(Vendor_Global_Dimension_2_Filter; "Global Dimension 2 Filter")
            {
            }
            column(VLECr; VLECr)
            {
            }
            column(VLEDr; VLEDr)
            {
            }
            dataitem("Vendor Ledger Entry"; "Vendor Ledger Entry")
            {
                DataItemLink = "Vendor No."=field("No."), "Posting Date"=field("Date Filter"), "Global Dimension 1 Code"=field("Global Dimension 1 Filter"), "Global Dimension 2 Code"=field("Global Dimension 2 Filter"), "Date Filter"=field("Date Filter");
                DataItemTableView = sorting("Vendor No.", "Posting Date");
                RequestFilterFields = Amount;

                column(ReportForNavId_4114;4114)
                {
                }
                column(StartBalanceLCY___StartBalAdjLCY____Amount__LCY__; StartBalanceLCY + StartBalAdjLCY + "Amount (LCY)")
                {
                AutoFormatType = 1;
                }
                column(DeBal_Control1000000068; DeBal)
                {
                AutoFormatType = 1;
                }
                column(CreBal_Control1000000069; CreBal)
                {
                AutoFormatType = 1;
                }
                column(Vendor_Ledger_Entry__Posting_Date_; "Posting Date")
                {
                }
                column(Vendor_Ledger_Entry__Document_No__; "Document No.")
                {
                }
                column(ItemCategoryName; ItemCategoryName)
                {
                }
                column(Vendor_Ledger_Entry__External_Document_No__; "External Document No.")
                {
                }
                column(CheckNo; CheckNo)
                {
                }
                column(CheckDate; CheckDate)
                {
                }
                column(Vendor_Ledger_Entry__Debit_Amount_; "Debit Amount")
                {
                }
                column(Vendor_Ledger_Entry__Credit_Amount_; "Credit Amount")
                {
                }
                column(DocDate; DocDate)
                {
                }
                column(DeBal_Control1000000072; DeBal)
                {
                AutoFormatType = 1;
                }
                column(CreBal_Control1000000073; CreBal)
                {
                AutoFormatType = 1;
                }
                column(Vendor_Ledger_Entry__Total_TDS_Including_SHE_CESS_; "Total TDS Including SHE CESS")
                {
                }
                column(PreAssNo; PreAssNo)
                {
                AutoFormatType = 1;
                }
                column(Vendor_Ledger_Entry__Credit_Amount__Control1000000004; "Credit Amount")
                {
                }
                column(Vendor_Ledger_Entry__Debit_Amount__Control1000000005; "Debit Amount")
                {
                }
                column(CheckDate_Control1000000006; CheckDate)
                {
                }
                column(CheckNo_Control1000000007; CheckNo)
                {
                }
                column(Vendor_Ledger_Entry__External_Document_No___Control1000000009; "External Document No.")
                {
                }
                column(ItemCategoryName_Control1000000011; ItemCategoryName)
                {
                }
                column(Vendor_Ledger_Entry__Document_No___Control1000000012; "Document No.")
                {
                }
                column(Vendor_Ledger_Entry__Posting_Date__Control1000000013; "Posting Date")
                {
                }
                column(DocDate_Control1000000054; DocDate)
                {
                }
                column(DeBal_Control1000000074; DeBal)
                {
                AutoFormatType = 1;
                }
                column(CreBal_Control1000000075; CreBal)
                {
                AutoFormatType = 1;
                }
                column(Vendor_Ledger_Entry__Total_TDS_Including_SHE_CESS__Control1000000098; "Total TDS Including SHE CESS")
                {
                }
                column(PreAssNo_Control1000000101; PreAssNo)
                {
                AutoFormatType = 1;
                }
                column(DeBal_Control1000000080; DeBal)
                {
                AutoFormatType = 1;
                }
                column(CreBal_Control1000000081; CreBal)
                {
                AutoFormatType = 1;
                }
                column(ContinuedCaption; ContinuedCaptionLbl)
                {
                }
                column(ContinuedCaption_Control46; ContinuedCaption_Control46Lbl)
                {
                }
                column(Vendor_Ledger_Entry_Entry_No_; "Entry No.")
                {
                }
                column(Vendor_Ledger_Entry_Vendor_No_; "Vendor No.")
                {
                }
                column(Vendor_Ledger_Entry_Global_Dimension_1_Code; "Global Dimension 1 Code")
                {
                }
                column(Vendor_Ledger_Entry_Global_Dimension_2_Code; "Global Dimension 2 Code")
                {
                }
                column(Vendor_Ledger_Entry_Date_Filter; "Date Filter")
                {
                }
                column(TotCrAmt; TotCrAmt)
                {
                }
                column(TotDrAmt; TotDrAmt)
                {
                }
                dataitem(UnknownTable16548; "Posted Narration")
                {
                    DataItemLink = "Transaction No."=field("Transaction No.");
                    DataItemTableView = sorting("Entry No.", "Transaction No.", "Line No.")order(ascending)where("Entry No."=const(0));

                    column(ReportForNavId_1000000105;1000000105)
                    {
                    }
                    column(PostedNarrationNarration; UnknownTable16548.Narration)
                    {
                    }
                }
                dataitem("G/L Entry"; "G/L Entry")
                {
                    DataItemLink = "Document No."=field("Document No."), "Transaction No."=field("Transaction No.");

                    column(ReportForNavId_1000000037;1000000037)
                    {
                    }
                    column(GLEntry_EntryNo; "G/L Entry"."Entry No.")
                    {
                    }
                    column(AccountName; AccountName)
                    {
                    }
                    column(ABS_DetailAmt_; Abs(DetailAmt))
                    {
                    }
                    column(DrCrText; DrCrText)
                    {
                    }
                    trigger OnAfterGetRecord()
                    begin
                        DrCrText:='';
                        DetailAmt:=0;
                        DetailAmt:=Amount;
                        if DetailAmt > 0 then DrCrText:='Dr';
                        if DetailAmt < 0 then DrCrText:='Cr';
                        if "Vendor Ledger Entry"."Entry No." = "Entry No." then CurrReport.Skip;
                        if not PrintDetail then AccountName:=Text16500
                        else
                            AccountName:=Daybook.FindGLAccName("Source Type", "Entry No.", "Source No.", "G/L Account No.");
                        TotDrAmt+="Vendor Ledger Entry"."Debit Amount";
                        TotCrAmt+="Vendor Ledger Entry"."Credit Amount";
                    end;
                }
                dataitem("Detailed Vendor Ledg. Entry"; "Detailed Vendor Ledg. Entry")
                {
                    DataItemLink = "Vendor Ledger Entry No."=field("Entry No.");
                    DataItemTableView = sorting("Vendor Ledger Entry No.", "Entry Type", "Posting Date")where("Entry Type"=const("Correction of Remaining Amount"));

                    column(ReportForNavId_2149;2149)
                    {
                    }
                    column(Vendor_Ledger_Entry___Document_Type_; "Vendor Ledger Entry"."Document Type")
                    {
                    }
                    column(Vendor_Ledger_Entry___Document_No__; "Vendor Ledger Entry"."Document No.")
                    {
                    }
                    column(Detailed_Vendor_Ledg__Entry__Entry_Type_; "Entry Type")
                    {
                    }
                    column(Correction; Correction)
                    {
                    AutoFormatType = 1;
                    }
                    column(DeBal_Control1000000076; DeBal)
                    {
                    AutoFormatType = 1;
                    }
                    column(CreBal_Control1000000077; CreBal)
                    {
                    AutoFormatType = 1;
                    }
                    column(Detailed_Vendor_Ledg__Entry_Entry_No_; "Entry No.")
                    {
                    }
                    column(Detailed_Vendor_Ledg__Entry_Vendor_Ledger_Entry_No_; "Vendor Ledger Entry No.")
                    {
                    }
                    trigger OnAfterGetRecord()
                    begin
                        Correction:=Correction + "Amount (LCY)";
                        VendBalanceLCY:=VendBalanceLCY + "Amount (LCY)";
                    end;
                    trigger OnPreDataItem()
                    begin
                        SetFilter("Posting Date", VendDateFilter);
                    //  ItemCategoryName:='';
                    end;
                }
                trigger OnAfterGetRecord()
                begin
                    CreBal:=0;
                    DeBal:=0;
                    CalcFields(Amount, "Remaining Amount", "Amount (LCY)", "Remaining Amt. (LCY)");
                    VendLedgEntryExists:=true;
                    if PrintAmountsInLCY then begin
                        VendAmount:="Amount (LCY)";
                        VendRemainAmount:="Remaining Amt. (LCY)";
                        VendCurrencyCode:='';
                    end
                    else
                    begin
                        VendAmount:=Amount;
                        VendRemainAmount:="Remaining Amount";
                        VendCurrencyCode:="Currency Code";
                    end;
                    VendBalanceLCY:=VendBalanceLCY + "Amount (LCY)";
                    if("Document Type" = "document type"::Payment) or ("Document Type" = "document type"::Refund)then VendEntryDueDate:=0D
                    else
                        VendEntryDueDate:="Due Date";
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
                        PurchInvLine.SetRange("Document No.", "Document No.");
                        PurchInvLine.SetRange(Type, PurchInvLine.Type::Item);
                        PurchInvLine.SetFilter(Quantity, '>%1', 0);
                        if PurchInvLine.Find('-')then begin
                            if ItemCategory.Get(PurchInvLine."Item Category Code")then begin
                                if ItemCategory.Description <> '' then begin
                                    ItemCategoryName:=ItemCategory.Description;
                                    DocDate:="Vendor Ledger Entry"."Document Date";
                                end
                                else
                                begin
                                    ItemCategoryName:=ItemCategory.Code;
                                    DocDate:="Vendor Ledger Entry"."Document Date";
                                end;
                            end
                            else
                                ItemCategoryName:='';
                        end
                        else
                            ItemCategoryName:="Vendor Ledger Entry".Description;
                    end;
                    if "Document Type" = "document type"::"Credit Memo" then begin
                        PurchCrMemoLine.SetRange("Document No.", "Document No.");
                        PurchCrMemoLine.SetRange(Type, PurchCrMemoLine.Type::Item);
                        PurchCrMemoLine.SetFilter(Quantity, '>%1', 0);
                        if PurchCrMemoLine.Find('-')then begin
                            if ItemCategory.Get(PurchCrMemoLine."Item Category Code")then begin
                                if ItemCategory.Description <> '' then begin
                                    ItemCategoryName:=ItemCategory.Description;
                                    DocDate:="Vendor Ledger Entry"."Document Date";
                                end
                                else
                                begin
                                    ItemCategoryName:=ItemCategory.Code;
                                    DocDate:="Vendor Ledger Entry"."Document Date";
                                end;
                            end
                            else
                                ItemCategoryName:='';
                        end
                        else
                            ItemCategoryName:="Vendor Ledger Entry".Description;
                    end;
                    if "Document Type" <> "document type"::Invoice then if "Document Type" <> "document type"::"Credit Memo" then if "Document Type" <> "document type"::Payment then ItemCategoryName:=Description;
                    PurchInvHEader.Reset;
                    PurchInvHEader.SetRange("No.", "Vendor Ledger Entry"."Document No.");
                    if PurchInvHEader.Find('-')then PreAssNo:=PurchInvHEader."Pre-Assigned No.";
                    if("Document Type" = "document type"::Payment) or (("Document Type" = "document type"::" ") or (Amount > 0))then begin
                        BankAccount.SetRange("No.", "Bal. Account No.");
                        if BankAccount.Find('-')then begin
                            ItemCategoryName:=BankAccount.Name;
                            DocDate:=0D;
                        end;
                    end;
                    if VendBalanceLCY < 0 then CreBal:=Abs(VendBalanceLCY)
                    else
                        DeBal:=Abs(VendBalanceLCY);
                //TotDrAmt+="Vendor Ledger Entry"."Debit Amount";
                //TotCrAmt+="Vendor Ledger Entry"."Credit Amount";
                //MESSAGE('%1..%2DR',"Debit Amount",TotDrAmt);
                //MESSAGE('%1..%2CR',"Credit Amount",TotCrAmt);
                end;
                trigger OnPreDataItem()
                begin
                    VendLedgEntryExists:=false;
                    CurrReport.CreateTotals(VendAmount, "Amount (LCY)");
                //SETRANGE("Global Dimension 1 Code",RespCnt.Code);
                end;
            }
            dataitem("Integer"; "Integer")
            {
                DataItemTableView = sorting(Number)where(Number=const(1));

                column(ReportForNavId_5444;5444)
                {
                }
                column(Vendor_Name_Control27; Vendor.Name)
                {
                }
                column(DeBal_Control1000000082; DeBal)
                {
                AutoFormatType = 1;
                }
                column(CreBal_Control1000000083; CreBal)
                {
                AutoFormatType = 1;
                }
                column(Vendor_Ledger_Entry___Debit_Amount_; "Vendor Ledger Entry"."Debit Amount")
                {
                }
                column(Vendor_Ledger_Entry___Credit_Amount_; "Vendor Ledger Entry"."Credit Amount")
                {
                }
                column(Vendor_Name_Control1000000046; Vendor.Name)
                {
                }
                column(DeBal_Control1000000084; DeBal)
                {
                AutoFormatType = 1;
                }
                column(CreBal_Control1000000085; CreBal)
                {
                AutoFormatType = 1;
                }
                column(Vendor_Ledger_Entry___Debit_Amount__Control1000000003; "Vendor Ledger Entry"."Debit Amount")
                {
                }
                column(Vendor_Ledger_Entry___Credit_Amount__Control1000000048; "Vendor Ledger Entry"."Credit Amount")
                {
                }
                column(Closing_BalanceCaption; Closing_BalanceCaptionLbl)
                {
                }
                column(Closing_BalanceCaption_Control1000000047; Closing_BalanceCaption_Control1000000047Lbl)
                {
                }
                column(Integer_Number; Number)
                {
                }
                trigger OnAfterGetRecord()
                begin
                    if not VendLedgEntryExists and ((StartBalanceLCY = 0) or ExcludeBalanceOnly)then begin
                        StartBalanceLCY:=0;
                        CurrReport.Skip;
                    end;
                end;
                trigger OnPreDataItem()
                begin
                //ItemCategoryName:='';
                end;
            }
            trigger OnAfterGetRecord()
            begin
                TotDrAmt:=0;
                TotCrAmt:=0;
                OpeCreBal:=0;
                OpeDeBal:=0;
                StartBalanceLCY:=0;
                StartBalAdjLCY:=0;
                if VendDateFilter <> '' then begin
                    if GetRangeMin("Date Filter") <> 0D then begin
                        SetRange("Date Filter", 0D, GetRangeMin("Date Filter") - 1);
                        CalcFields("Net Change (LCY)");
                        StartBalanceLCY:=-"Net Change (LCY)";
                    end;
                    SetFilter("Date Filter", VendDateFilter);
                    CalcFields("Net Change (LCY)");
                    StartBalAdjLCY:=-"Net Change (LCY)";
                    VendorLedgerEntry.SetCurrentkey("Vendor No.", "Posting Date");
                    VendorLedgerEntry.SetRange("Vendor No.", Vendor."No.");
                    VendorLedgerEntry.SetFilter("Posting Date", VendDateFilter);
                    if VendorLedgerEntry.Find('-')then repeat VendorLedgerEntry.SetFilter("Date Filter", VendDateFilter);
                            VendorLedgerEntry.CalcFields("Amount (LCY)");
                            StartBalAdjLCY:=StartBalAdjLCY - VendorLedgerEntry."Amount (LCY)";
                            "Detailed Vendor Ledg. Entry".SetCurrentkey("Vendor Ledger Entry No.", "Entry Type", "Posting Date");
                            "Detailed Vendor Ledg. Entry".SetRange("Vendor Ledger Entry No.", VendorLedgerEntry."Entry No.");
                            "Detailed Vendor Ledg. Entry".SetFilter("Entry Type", '%1|%2', "Detailed Vendor Ledg. Entry"."entry type"::"Correction of Remaining Amount", "Detailed Vendor Ledg. Entry"."entry type"::"Appln. Rounding");
                            "Detailed Vendor Ledg. Entry".SetFilter("Posting Date", VendDateFilter);
                            if "Detailed Vendor Ledg. Entry".Find('-')then repeat StartBalAdjLCY:=StartBalAdjLCY - "Detailed Vendor Ledg. Entry"."Amount (LCY)";
                                until "Detailed Vendor Ledg. Entry".Next = 0;
                            "Detailed Vendor Ledg. Entry".Reset;
                        until VendorLedgerEntry.Next = 0;
                end;
                // CurrReport.PrintonlyIfDetail := ExcludeBalanceOnly or (StartBalanceLCY = 0);
                VendBalanceLCY:=StartBalanceLCY + StartBalAdjLCY;
                CreBal:=0;
                DeBal:=0;
                if StartBalanceLCY < 0 then CreBal:=Abs(StartBalanceLCY)
                else
                    DeBal:=Abs(StartBalanceLCY);
                if StartBalanceLCY < 0 then OpeCreBal:=Abs(StartBalanceLCY)
                else
                    OpeDeBal:=Abs(StartBalanceLCY);
                VLECr:=0;
                VLEDr:=0;
                //Alle-HB-12oct15
                VLE.Reset;
                VLE.SetRange("Vendor No.", "No.");
                VLE.SetRange("Posting Date", MinDate, MaxDate);
                VLE.SetFilter("Global Dimension 1 Code", "Global Dimension 1 Filter");
                VLE.SetFilter("Global Dimension 2 Code", "Global Dimension 2 Filter");
                VLE.SetRange("Date Filter", MinDate, MaxDate);
                if VLE.FindSet then begin
                    repeat VLE.CalcFields("Credit Amount");
                        VLE.CalcFields("Debit Amount");
                        VLE.CalcFields("Amount (LCY)");
                        VLECr+=VLE."Credit Amount";
                        VLEDr+=VLE."Debit Amount";
                        VLEBalanceLCY+=VLE."Amount (LCY)";
                    until VLE.Next = 0;
                    if VLEBalanceLCY < 0 then CreBal:=Abs(VLEBalanceLCY)
                    else
                        DeBal:=Abs(VLEBalanceLCY);
                end;
            //Alle-HB-12oct15
            end;
            trigger OnPreDataItem()
            begin
                //Vendor.SetRange("Responsibility Center", ResCen.Code);
                CurrReport.NewPagePerRecord:=PrintOnlyOnePerPage;
                CurrReport.CreateTotals("Vendor Ledger Entry"."Amount (LCY)", StartBalanceLCY, Correction, ApplicationRounding);
                if RespCnt.Get(RespCnt.Code)then gCompaddress:=RespCnt.Address + ', ' + RespCnt."Address 2" + ', ' + RespCnt.City + ' - ' + RespCnt."Post Code";
                ResAdd:=ResCen.Address + ',' + ResCen."Address 2" + ',' + ResCen.City + '-' + ResCen."Post Code";
            end;
        }
    }
    requestpage
    {
        layout
        {
            area(content)
            {
                field("View Applied Entries"; ViewAppliedEntries)
                {
                    ApplicationArea = Basic;
                }
                field("Skow Amount in LCY"; PrintAmountsInLCY)
                {
                    ApplicationArea = Basic;
                }
                field("Exclude Vendors That Have A Balance Only"; ExcludeBalanceOnly)
                {
                    ApplicationArea = Basic;
                    Caption = 'Exclude Vendors That Have A Balance Only';
                }
                field(PrintDetail; PrintDetail)
                {
                    ApplicationArea = Basic;
                }
                field("Print Narration"; PrintNarration)
                {
                    ApplicationArea = Basic;
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
    trigger OnInitReport()
    begin
        m:=1;
    end;
    trigger OnPostReport()
    begin
        if ExporttoExcel = true then begin
        //ExcelBUff.CreateBook; // BIS 1145
        //ExcelBUff.CreateSheet('Vender Ledger','Vender Ledger',COMPANYNAME,USERID);// BIS 1145
        //ExcelBUff.GiveUserControl;// BIS 1145
        end;
    end;
    trigger OnPreReport()
    begin
        // ResCen.Get(UserMgt.GetRespCenterFilter);
        CompanyInformationRec.get();
        CompanyInformationRec.CalcFields(Picture);
        if StateRec.Get(CompanyInformationRec."State Code")then StateName:=StateRec.Description;
        VendFilter:=Vendor.GetFilters;
        VendDateFilter:=Vendor.GetFilter("Date Filter");
        MinDate:=Vendor.GetRangeMin("Date Filter");
        MaxDate:=Vendor.GetRangemax("Date Filter");
        with "Vendor Ledger Entry" do if PrintAmountsInLCY then begin
                AmountCaption:=FieldCaption("Amount (LCY)");
                RemainingAmtCaption:=FieldCaption("Remaining Amt. (LCY)");
            end
            else
            begin
                AmountCaption:=FieldCaption(Amount);
                RemainingAmtCaption:=FieldCaption("Remaining Amount");
            end;
    end;
    var CompanyInformationRec: Record "Company Information";
    StateRec: Record state;
    StateName: Text[50];
    Location: Record Location;
    Text000: label 'Period: %1';
    VendorLedgerEntry: Record "Vendor Ledger Entry";
    VendFilter: Text[250];
    VendDateFilter: Text[30];
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
    AmountCaption: Text[30];
    RemainingAmtCaption: Text[30];
    VendCurrencyCode: Code[10];
    "---MES": Integer;
    CheckLedgerEntry: Record "Check Ledger Entry";
    CheckNo: Code[20];
    CheckDate: Date;
    CompanyInfo: Record "Company Information";
    PurchInvLine: Record "Purch. Inv. Line";
    ItemCategory: Record "Item Category";
    ItemCategoryName: Text[200];
    DimensionValue: Record "Dimension Value";
    ViewAppliedEntries: Boolean;
    BankAccount: Record "Bank Account";
    PurchCrMemoLine: Record "Purch. Cr. Memo Line";
    RespCnt: Record "Responsibility Center";
    gCompaddress: Text[150];
    DocDate: Date;
    ResCen: Record "Responsibility Center";
    UserMgt: Codeunit "User Setup Management";
    ResAdd: Code[150];
    CreBal: Decimal;
    DeBal: Decimal;
    CreBal1: Decimal;
    DeBal1: Decimal;
    CreBal2: Decimal;
    DeBal2: Decimal;
    SumDebit: Decimal;
    SumCredit: Decimal;
    SumDebit1: Decimal;
    SumCredit1: Decimal;
    PurchInvHEader: Record "Purch. Inv. Header";
    PreAssNo: Code[20];
    ExporttoExcel: Boolean;
    ExcelBUff: Record "Excel Buffer" temporary;
    NotDecimalValues: Boolean;
    m: Integer;
    CurrReport_PAGENOCaptionLbl: label 'Page';
    Vendor_LedgerCaptionLbl: label 'Vendor Ledger';
    All_amounts_are_in_LCYCaptionLbl: label 'All amounts are in LCY';
    BalanceCaptionLbl: label 'Balance';
    CheckDateCaptionLbl: label 'Chq. Date';
    CheckNoCaptionLbl: label 'Chq. No';
    Invoice_No_CaptionLbl: label 'Invoice No.';
    NarrationCaptionLbl: label 'Narration';
    Doc__No_CaptionLbl: label 'Doc. No.';
    Invoice_DateCaptionLbl: label 'Invoice Date';
    Debit_Bal_CaptionLbl: label 'Debit Bal.';
    Credit_Bal_CaptionLbl: label 'Credit Bal.';
    TDS_AmountCaptionLbl: label 'TDS Amount';
    Pre_AsgNoCaptionLbl: label 'Pre.AsgNo';
    BalanceCaption_Control1000000025Lbl: label 'Balance';
    Credit_AmountCaptionLbl: label 'Credit Amount';
    Debit_AmountCaptionLbl: label 'Debit Amount';
    Chq__DateCaptionLbl: label 'Chq. Date';
    NarrationCaption_Control1000000041Lbl: label 'Narration';
    Doc__No_Caption_Control1000000042Lbl: label 'Doc. No.';
    Posting_DateCaptionLbl: label 'Posting Date';
    Invoice_No_Caption_Control1000000044Lbl: label 'Invoice No.';
    Chq__No_CaptionLbl: label 'Chq. No.';
    Invoice_DateCaption_Control1000000052Lbl: label 'Invoice Date';
    Credit_Bal_Caption_Control1000000056Lbl: label 'Credit Bal.';
    Debit_Bal_Caption_Control1000000057Lbl: label 'Debit Bal.';
    TDS_AmountCaption_Control1000000097Lbl: label 'TDS Amount';
    Pre_AsgNoCaption_Control1000000071Lbl: label 'Pre.AsgNo';
    Opening_BalanceCaptionLbl: label 'Opening Balance';
    Adj__of_Opening_BalanceCaptionLbl: label 'Adj. of Opening Balance';
    Total__LCY_CaptionLbl: label 'Total (LCY)';
    Total_Adj__of_Opening_BalanceCaptionLbl: label 'Total Adj. of Opening Balance';
    Total__LCY__Before_PeriodCaptionLbl: label 'Total (LCY) Before Period';
    Total__LCY__Before_PeriodCaption_Control26Lbl: label 'Total (LCY) Before Period';
    ContinuedCaptionLbl: label 'Continued';
    ContinuedCaption_Control46Lbl: label 'Continued';
    Closing_BalanceCaptionLbl: label 'Closing Balance';
    Closing_BalanceCaption_Control1000000047Lbl: label 'Closing Balance';
    OpeCreBal: Decimal;
    OpeDeBal: Decimal;
    GLEntry: Record "G/L Entry";
    FirstRecord: Boolean;
    DrCrText: Text[2];
    ControlAccountName: Text[100];
    DetailAmt: Decimal;
    PrintDetail: Boolean;
    AccountName: Text[100];
    Text16500: label 'As per Details';
    Daybook: Report "Day Book";
    DrCrTextBalance: Text[2];
    OpeningDRBal: Decimal;
    OpeningCRBal: Decimal;
    TransDebits: Decimal;
    TransCredits: Decimal;
    TotCrAmt: Decimal;
    TotDrAmt: Decimal;
    VLE: Record "Vendor Ledger Entry";
    VLECr: Decimal;
    VLEDr: Decimal;
    MinDate: Date;
    MaxDate: Date;
    VLEBalanceLCY: Decimal;
    PrintNarration: Boolean;
}
