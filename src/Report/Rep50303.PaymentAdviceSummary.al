Report 50303 "Payment Advice Summary"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Payment Advice Summary.rdl';
    Caption = 'Vendor - Payment Advice';
    PreviewMode = PrintLayout;
    UsageCategory = ReportsandAnalysis;
    ApplicationArea = all;

    dataset
    {
        dataitem("Vendor Ledger Entry"; "Vendor Ledger Entry")
        {
            CalcFields = Amount, "Remaining Amount";
            DataItemTableView = sorting("Document No.")where("Document Type"=filter(Payment|Refund));
            RequestFilterFields = "Posting Date", "Document No.";

            column(ReportForNavId_4114;4114)
            {
            }
            column(PostingDate_VendorLedgerEntry; "Vendor Ledger Entry"."Posting Date")
            {
            }
            column(DocumentNo_VendorLedgerEntry; "Vendor Ledger Entry"."Document No.")
            {
            }
            column(BankAccount; BankAccount)
            {
            }
            column(Filters; Filters)
            {
            }
            column(VendBCode; VendBCode)
            {
            }
            column(BankNamefilter; BankName)
            {
            }
            dataitem(PageLoop; "Integer")
            {
                DataItemTableView = sorting(Number)where(Number=const(1));

                column(ReportForNavId_6455;6455)
                {
                }
                column(VeBankName; BankName)
                {
                }
                column(VeBankAccountNo; BankAccountNo)
                {
                }
                column(VeCheckNo; CheckNo)
                {
                }
                column(VendorCode; Vend."No.")
                {
                }
                column(VendorName; Vend.Name)
                {
                }
                column(VendAddr6; VendAddr[6])
                {
                }
                column(VendAddr7; VendAddr[7])
                {
                }
                column(VendAddr8; VendAddr[8])
                {
                }
                column(VendAddr4; VendAddr[4])
                {
                }
                column(VendAddr5; VendAddr[5])
                {
                }
                column(VendAddr3; VendAddr[3])
                {
                }
                column(VendAddr1; VendAddr[1])
                {
                }
                column(VendAddr2; VendAddr[2])
                {
                }
                column(VendNo_VendLedgEntry; "Vendor Ledger Entry"."Vendor No.")
                {
                IncludeCaption = true;
                }
                column(DocDate_VendLedgEntry; Format("Vendor Ledger Entry"."Document Date", 0, 4))
                {
                }
                column(CompanyAddr1; CompanyAddr[1])
                {
                }
                column(CompanyAddr2; CompanyAddr[2])
                {
                }
                column(CompanyAddr3; CompanyAddr[3])
                {
                }
                column(CompanyAddr4; CompanyAddr[4])
                {
                }
                column(CompanyAddr5; CompanyAddr[5])
                {
                }
                column(CompanyAddr6; CompanyAddr[6])
                {
                }
                column(PhoneNo; CompanyInfo."Phone No.")
                {
                }
                column(HomePage; CompanyInfo."Home Page")
                {
                }
                column(Email; CompanyInfo."E-Mail")
                {
                }
                column(VATRegistrationNo; CompanyInfo."VAT Registration No.")
                {
                }
                column(GiroNo; CompanyInfo."Giro No.")
                {
                }
                column(BankName; CompanyInfo."Bank Name")
                {
                }
                column(BankAccountNo; CompanyInfo."Bank Account No.")
                {
                }
                column(CompRegNo; CompanyInfo."Company Registration  No.")
                {
                }
                column(CompGstRegNo; CompanyInfo."GST Registration No.")
                {
                }
                column(ReportTitle; ReportTitle)
                {
                }
                column(DocNo_VendLedgEntry; "Vendor Ledger Entry"."Document No.")
                {
                }
                column(PymtDiscTitle; PaymentDiscountTitle)
                {
                }
                column(CompanyInfoPhoneNoCaption; CompanyInfoPhoneNoCaptionLbl)
                {
                }
                column(CompanyInfoGiroNoCaption; CompanyInfoGiroNoCaptionLbl)
                {
                }
                column(CompanyInfoBankNameCaption; CompanyInfoBankNameCaptionLbl)
                {
                }
                column(CompanyInfoBankAccNoCaption; CompanyInfoBankAccNoCaptionLbl)
                {
                }
                column(RcptNoCaption; RcptNoCaptionLbl)
                {
                }
                column(CompanyInfoVATRegNoCaption; CompanyInfoVATRegNoCaptionLbl)
                {
                }
                column(PostingDateCaption; PostingDateCaptionLbl)
                {
                }
                column(AmtCaption; AmtCaptionLbl)
                {
                }
                column(PymtAmtSpecCaption; PymtAmtSpecCaptionLbl)
                {
                }
                column(PymtTolInvCurrCaption; PymtTolInvCurrCaptionLbl)
                {
                }
                dataitem(DetailedVendorLedgEntry1; "Detailed Vendor Ledg. Entry")
                {
                    DataItemLink = "Applied Vend. Ledger Entry No."=field("Entry No.");
                    DataItemLinkReference = "Vendor Ledger Entry";
                    DataItemTableView = sorting("Applied Vend. Ledger Entry No.", "Entry Type")where(Unapplied=const(false));

                    column(ReportForNavId_5741;5741)
                    {
                    }
                    column(AppliedVLENo_DtldVendLedgEntry; "Applied Vend. Ledger Entry No.")
                    {
                    }
                    column(AppDOcNo1; DetailedVendorLedgEntry1."Document No.")
                    {
                    }
                    dataitem(VendLedgEntry1; "Vendor Ledger Entry")
                    {
                        DataItemLink = "Entry No."=field("Vendor Ledger Entry No.");
                        DataItemLinkReference = DetailedVendorLedgEntry1;
                        DataItemTableView = sorting("Entry No.");

                        column(ReportForNavId_5994;5994)
                        {
                        }
                        column(BenefiName; BenefiName)
                        {
                        }
                        column(VendBankAcc; VendBankAcc)
                        {
                        }
                        column(IFSCCode; IFSCCode)
                        {
                        }
                        column(VendBankName; VendBankName)
                        {
                        }
                        column(PostingDate_VendLedgEntry1; Format("Posting Date"))
                        {
                        }
                        column(DueDate1; Format("Due Date"))
                        {
                        }
                        column(DocType_VendLedgEntry1; "Document Type")
                        {
                        IncludeCaption = true;
                        }
                        column(DocNo_VendLedgEntry1; "Document No.")
                        {
                        IncludeCaption = true;
                        }
                        column(Description_VendLedgEntry1; Description)
                        {
                        IncludeCaption = true;
                        }
                        column(ExternalDocumentNo_VendLedgEntry1; VendLedgEntry1."External Document No.")
                        {
                        }
                        column(NegShowAmountVendLedgEntry1;-NegShowAmountVendLedgEntry1)
                        {
                        }
                        column(CurrCode_VendLedgEntry1; CurrencyCode("Currency Code"))
                        {
                        }
                        column(SameBank; SameBank)
                        {
                        }
                        column(Samecount; Samecount)
                        {
                        }
                        column(diffcount; diffcount)
                        {
                        }
                        column(DiffBankr; DiffBank)
                        {
                        }
                        column(TotalSameDiffrAmount_; TotalSameDiffrAmount)
                        {
                        }
                        column(NegPmtDiscInvCurrVendLedgEntry1;-NegPmtDiscInvCurrVendLedgEntry1)
                        {
                        }
                        column(NegPmtTolInvCurrVendLedgEntry1;-NegPmtTolInvCurrVendLedgEntry1)
                        {
                        }
                        column(PayDocNo1; PayDocNo1)
                        {
                        }
                        column(AmountToApply; AmountToApply)
                        {
                        }
                        trigger OnAfterGetRecord()
                        begin
                            if "Entry No." = "Vendor Ledger Entry"."Entry No." then CurrReport.Skip;
                            NegPmtDiscInvCurrVendLedgEntry1:=0;
                            NegPmtTolInvCurrVendLedgEntry1:=0;
                            PmtDiscPmtCurr:=0;
                            PmtTolPmtCurr:=0;
                            //AmountToApply:=VendLedgEntry1."Amount to Apply";
                            //RecBankLedEntry.RESET;
                            //RecBankLedEntry.SETRANGE("Document No.",recVLE."Document No.");
                            //RecBankLedEntry.SETRANGE("Document Type",recVLE."Document Type"::Payment);
                            //IF RecBankLedEntry.FINDFIRST THEN;
                            //NegShowAmountVendLedgEntry1:=RecBankLedEntry.Amount;
                            // AmountToApply := DetailedVendorLedgEntry1.Amount;
                            NegShowAmountVendLedgEntry1:=-DetailedVendorLedgEntry1.Amount;
                            if "Vendor Ledger Entry"."Currency Code" <> "Currency Code" then begin
                                NegPmtDiscInvCurrVendLedgEntry1:=ROUND("Pmt. Disc. Rcd.(LCY)" * "Vendor Ledger Entry"."Original Currency Factor");
                                NegPmtTolInvCurrVendLedgEntry1:=ROUND("Pmt. Tolerance (LCY)" * "Vendor Ledger Entry"."Original Currency Factor");
                                AppliedAmount:=ROUND(-DetailedVendorLedgEntry1.Amount / "Original Currency Factor" * "Vendor Ledger Entry"."Original Currency Factor", Currency."Amount Rounding Precision");
                            end
                            else
                            begin
                                NegPmtDiscInvCurrVendLedgEntry1:=ROUND("Pmt. Disc. Rcd.(LCY)" * "Vendor Ledger Entry"."Original Currency Factor");
                                NegPmtTolInvCurrVendLedgEntry1:=ROUND("Pmt. Tolerance (LCY)" * "Vendor Ledger Entry"."Original Currency Factor");
                                AppliedAmount:=-DetailedVendorLedgEntry1.Amount;
                            end;
                            PmtDiscPmtCurr:=ROUND("Pmt. Disc. Rcd.(LCY)" * "Vendor Ledger Entry"."Original Currency Factor");
                            PmtTolPmtCurr:=ROUND("Pmt. Tolerance (LCY)" * "Vendor Ledger Entry"."Original Currency Factor");
                            RemainingAmount:=(RemainingAmount - AppliedAmount) + PmtDiscPmtCurr + PmtTolPmtCurr;
                            /*
                            BankAccountNo:='';
                            BankName:='';
                            CheckNo:='';
                            recVLE.RESET;
                            recVLE.SETRANGE("Document No.",VendLedgEntry1."Document No.");
                            recVLE.SETRANGE("Bal. Account Type",recVLE."Bal. Account Type"::"Bank Account");
                              IF recVLE.FIND('-') THEN BEGIN
                                RecBankAccount.RESET;
                                RecBankAccount.SETRANGE("No.",recVLE."Bal. Account No.");
                                IF RecBankAccount.FIND('-') THEN BEGIN
                                   BankAccountNo:=RecBankAccount."Bank Account No.";
                                   BankName:=RecBankAccount.Name;
                                END;
                                RecBankLedEntry.RESET;
                                RecBankLedEntry.SETRANGE("Document No.",recVLE."Document No.");
                                RecBankLedEntry.SETRANGE("Document Type",recVLE."Document Type"::Payment);
                                RecBankLedEntry.SETRANGE("Bal. Account No.",recVLE."Bal. Account No.");
                                  IF RecBankLedEntry.FIND('-') THEN BEGIN
                                     CheckNo:=RecBankLedEntry."Cheque No.";
                                  END;
                              END;
                            */
                            PayDocNo1:='';
                            DVLE1.Reset;
                            DVLE1.SetRange("Vendor Ledger Entry No.", VendLedgEntry1."Entry No.");
                            DVLE1.SetRange("Entry Type", DVLE1."entry type"::Application);
                            //DVLE1.SETRANGE("Entry Type",DVLE1."Entry Type"::"Initial Entry");
                            if DVLE1.FindFirst then begin
                                PayDocNo1:=DVLE1."Document No." end;
                        // Allepr
                        //IF DVLE1.FINDFIRST THEN
                        //PayDocNo1:=DVLE1."Document No."
                        //ELSE
                        // RecBankLedEntry.SETRANGE("Document No.",VendLedgEntry1."Document No.");
                        // IF RecBankLedEntry.FINDFIRST THEN
                        //PayDocNo1:=RecBankLedEntry."Document No.";
                        // Allepr
                        end;
                    }
                }
                dataitem(DetailedVendorLedgEntry2; "Detailed Vendor Ledg. Entry")
                {
                    DataItemLink = "Vendor Ledger Entry No."=field("Entry No.");
                    DataItemLinkReference = "Vendor Ledger Entry";
                    DataItemTableView = sorting("Vendor Ledger Entry No.", "Entry Type", "Posting Date")where(Unapplied=const(false));

                    column(ReportForNavId_1758;1758)
                    {
                    }
                    column(VLENo_DtldVendLedgEntry; "Vendor Ledger Entry No.")
                    {
                    }
                    column(AppDocNo2; DetailedVendorLedgEntry2."Document No.")
                    {
                    }
                    dataitem(VendLedgEntry2; "Vendor Ledger Entry")
                    {
                        DataItemLink = "Entry No."=field("Applied Vend. Ledger Entry No.");
                        DataItemLinkReference = DetailedVendorLedgEntry2;
                        DataItemTableView = sorting("Entry No.");

                        column(ReportForNavId_2011;2011)
                        {
                        }
                        column(NegAppliedAmt;-AppliedAmount)
                        {
                        }
                        column(Description_VendLedgEntry2; Description)
                        {
                        }
                        column(DocNo_VendLedgEntry2; "Document No.")
                        {
                        }
                        column(DocType_VendLedgEntry2; "Document Type")
                        {
                        }
                        column(PostingDate_VendLedgEntry2; Format("Posting Date"))
                        {
                        }
                        column(DueDate2; Format("Due Date"))
                        {
                        }
                        column(CheckDueDate_; CheckDueDate)
                        {
                        }
                        column(CurrCode_VendLedgEntry2; CurrencyCode("Currency Code"))
                        {
                        }
                        column(NegPmtDiscInvCurrVendLedgEntry2;-NegPmtDiscInvCurrVendLedgEntry1)
                        {
                        }
                        column(NegPmtTolInvCurr1VendLedgEntry2;-NegPmtTolInvCurrVendLedgEntry1)
                        {
                        }
                        column(ExternalDocumentNo_VendLedgEntry2; VendLedgEntry2."External Document No.")
                        {
                        }
                        column(PayDocNo2; PayDocNo2)
                        {
                        }
                        trigger OnAfterGetRecord()
                        begin
                            if "Entry No." = "Vendor Ledger Entry"."Entry No." then CurrReport.Skip;
                            if VendLedgEntry2."Due Date" < Today then CheckDueDate:=true
                            else
                                CheckDueDate:=false;
                            NegPmtDiscInvCurrVendLedgEntry1:=0;
                            NegPmtTolInvCurrVendLedgEntry1:=0;
                            PmtDiscPmtCurr:=0;
                            PmtTolPmtCurr:=0;
                            RecBankLedEntry.Reset;
                            //AmountToApply:= VendLedgEntry2."Amount to Apply";
                            // RecBankLedEntry.SETRANGE("Document No.",recVLE."Document No.");
                            // RecBankLedEntry.SETRANGE("Document Type",recVLE."Document Type"::Payment);
                            // IF RecBankLedEntry.FINDFIRST THEN;
                            //NegShowAmountVendLedgEntry1:=RecBankLedEntry.Amount;
                            NegShowAmountVendLedgEntry1:=DetailedVendorLedgEntry2.Amount;
                            if "Vendor Ledger Entry"."Currency Code" <> "Currency Code" then begin
                                NegPmtDiscInvCurrVendLedgEntry1:=ROUND("Pmt. Disc. Rcd.(LCY)" * "Original Currency Factor");
                                NegPmtTolInvCurrVendLedgEntry1:=ROUND("Pmt. Tolerance (LCY)" * "Original Currency Factor");
                            end
                            else
                            begin
                                NegPmtDiscInvCurrVendLedgEntry1:=ROUND("Pmt. Disc. Rcd.(LCY)" * "Vendor Ledger Entry"."Original Currency Factor");
                                NegPmtTolInvCurrVendLedgEntry1:=ROUND("Pmt. Tolerance (LCY)" * "Vendor Ledger Entry"."Original Currency Factor");
                            end;
                            PmtDiscPmtCurr:=ROUND("Pmt. Disc. Rcd.(LCY)" * "Vendor Ledger Entry"."Original Currency Factor");
                            PmtTolPmtCurr:=ROUND("Pmt. Tolerance (LCY)" * "Vendor Ledger Entry"."Original Currency Factor");
                            AppliedAmount:=DetailedVendorLedgEntry2.Amount;
                            RemainingAmount:=(RemainingAmount - AppliedAmount) + PmtDiscPmtCurr + PmtTolPmtCurr;
                            /*
                            BankAccountNo:='';
                            BankName:='';
                            CheckNo:='';
                            recVLE.RESET;
                            recVLE.SETRANGE("Document No.",VendLedgEntry2."Document No.");
                            recVLE.SETRANGE("Bal. Account Type",recVLE."Bal. Account Type"::"Bank Account");
                              IF recVLE.FIND('-') THEN BEGIN
                                RecBankAccount.RESET;
                                RecBankAccount.SETRANGE("No.",recVLE."Bal. Account No.");
                                IF RecBankAccount.FIND('-') THEN BEGIN
                                   BankAccountNo:=RecBankAccount."Bank Account No.";
                                   BankName:=RecBankAccount.Name;
                                END;
                                RecBankLedEntry.RESET;
                                RecBankLedEntry.SETRANGE("Document No.",recVLE."Document No.");
                                RecBankLedEntry.SETRANGE("Document Type",recVLE."Document Type"::Payment);
                                RecBankLedEntry.SETRANGE("Bal. Account No.",recVLE."Bal. Account No.");
                                  IF RecBankLedEntry.FIND('-') THEN BEGIN
                                     CheckNo:=RecBankLedEntry."Cheque No.";
                                  END;
                              END;
                            */
                            PayDocNo2:='';
                            DVLE2.Reset;
                            DVLE2.SetRange("Applied Vend. Ledger Entry No.", VendLedgEntry2."Entry No.");
                            if DVLE2.FindFirst then begin
                                PayDocNo2:=DVLE2."Document No.";
                            end;
                        end;
                    }
                }
                dataitem(Total; "Integer")
                {
                    DataItemTableView = sorting(Number)where(Number=const(1));

                    column(ReportForNavId_3476;3476)
                    {
                    }
                    column(NegRemainingAmt;-RemainingAmount)
                    {
                    }
                    column(CurrCode_VendLedgEntry; CurrencyCode("Vendor Ledger Entry"."Currency Code"))
                    {
                    }
                    column(NegOriginalAmt_VendLedgEntry;-"Vendor Ledger Entry"."Original Amount")
                    {
                    }
                    column(ExtDocNo_VendLedgEntry; "Vendor Ledger Entry"."External Document No.")
                    {
                    }
                    column(PymtAmtNotAllocatedCaption; PymtAmtNotAllocatedCaptionLbl)
                    {
                    }
                    column(PymtAmtCaption; PymtAmtCaptionLbl)
                    {
                    }
                    column(ExternalDocNoCaption; ExternalDocNoCaptionLbl)
                    {
                    }
                }
            }
            dataitem(AdvancedAmount; "Vendor Ledger Entry")
            {
                CalcFields = Amount;
                DataItemTableView = sorting("Document Type", "Vendor No.", "Posting Date", "Currency Code")where("Document Type"=filter(Payment), "Remaining Amount"=filter(<>0), Open=filter(true));

                column(ReportForNavId_1120174003;1120174003)
                {
                }
                column(ADiffCount; ADiffCount)
                {
                }
                column(AsmCount; AsmCount)
                {
                }
                column(SameBank2; SameBank2)
                {
                }
                column(DiffBank2; DiffBank2)
                {
                }
                column(VendorNo2; AdvancedAmount."Vendor No.")
                {
                }
                column(VendorName3; Vendor3.Name)
                {
                }
                column(AdvancedPayment_ExtDocNo; AdvancedAmount."External Document No.")
                {
                }
                column(DocNo; AdvancedAmount."Document No.")
                {
                }
                column(AMT; AdvancedAmount.Amount - AdvancedAmount."Total TDS Including SHE CESS")
                {
                }
                column(RemainingAmount_2; AdvancedAmount."Remaining Amount")
                {
                }
                column(Open2; AdvancedAmount.Open)
                {
                }
                column(AdvancedAmount; AdvancedAmount.Amount)
                {
                }
                column(DueDate_3; Format(AdvancedAmount."Due Date"))
                {
                }
                column(PostingDate_3; Format(AdvancedAmount."Posting Date"))
                {
                }
                column(CheckDueDate2_; CheckDueDate2)
                {
                }
                column(VendBankCode2_; VendBankCode2)
                {
                }
                column(BenefiName2_; BenefiName2)
                {
                }
                column(VendBankAcc2_; VendBankAcc2)
                {
                }
                column(IFSCCode2_; IFSCCode2)
                {
                }
                column(VendBankName2_; VendBankName2)
                {
                }
                trigger OnAfterGetRecord()
                begin
                    if AdvancedAmount."Due Date" < Today then CheckDueDate2:=true
                    else
                        CheckDueDate2:=false;
                    if i2 <> 1 then CurrReport.Skip;
                    if AdvancedAmount.Amount <> AdvancedAmount."Remaining Amount" then CurrReport.Skip;
                    if Vendor3.Get(AdvancedAmount."Vendor No.")then BenefiName2:='';
                    VendBankAcc2:='';
                    IFSCCode2:='';
                    VendBankName2:='';
                    VendBankCode2:='';
                    recVendBank2.Reset;
                    recVendBank2.SetRange("Vendor No.", AdvancedAmount."Vendor No.");
                    recVendBank2.SetFilter(Code, '<>%1', '');
                    if recVendBank2.FindFirst then begin
                        VendBankCode2:=recVendBank2.Code;
                        BenefiName2:=recVendBank2."Beneficiary Name";
                        VendBankAcc2:=recVendBank2."Bank Account No.";
                        IFSCCode2:=recVendBank2."NEFT/RTGS Code";
                        VendBankName2:=recVendBank2.Name;
                    end;
                    if BankAccount2 <> '' then AdvancedAmount.SetRange("Bal. Account No.", BankAccount);
                    BankCode2:='';
                    RecBankAccount.Reset;
                    RecBankAccount.SetRange("No.", AdvancedAmount."Bal. Account No.");
                    if RecBankAccount.FindFirst then begin
                        BankAccountNo2:=RecBankAccount."Bank Account No.";
                        BankName2:=RecBankAccount.Name;
                        BankCode2:=RecBankAccount."SSD Bank Code";
                    end;
                    if VendBankCode2 <> BankCode2 then begin
                        // MESSAGE(VendBankCode2+BankCode2);
                        AdvancedAmount.CalcFields("Amount (LCY)");
                        DiffBank2+=(AdvancedAmount."Amount (LCY)" - AdvancedAmount."Total TDS Including SHE CESS");
                        // MESSAGE(FORMAT(AdvancedAmount."Amount (LCY)"-AdvancedAmount."Total TDS Including SHE CESS"));
                        ADiffCount+=1;
                    // MESSAGE('Diff'+FORMAT(ADiffCount)+'Amt'+FORMAT(DiffBank2));
                    end
                    else
                    begin
                        AdvancedAmount.CalcFields("Amount (LCY)");
                        SameBank2+=(AdvancedAmount."Amount (LCY)" - AdvancedAmount."Total TDS Including SHE CESS");
                        // MESSAGE(FORMAT(AdvancedAmount."Amount (LCY)"-AdvancedAmount."Total TDS Including SHE CESS"));
                        AsmCount+=1;
                    //  MESSAGE('Same'+FORMAT(AsmCount)+'Amt'+FORMAT(SameBank2));
                    end;
                // MESSAGE('VBC %1|BC %2|VN %3',VendBankCode2,BankCode2,AdvancedAmount."Vendor No.");
                // MESSAGE('d%1|s%2|dc%3|sc%4|%5',DiffBank,SameBank,diffcount,Samecount,AdvancedAmount."Amount (LCY)");
                end;
                trigger OnPreDataItem()
                begin
                    AdvancedAmount.CopyFilters("Vendor Ledger Entry");
                    i2+=1;
                    AsmCount:=0;
                    ADiffCount:=0; //AsmCount:=Samecount;
                    //ADiffCount:=diffcount;
                    SameBank2:=0;
                    DiffBank2:=0;
                end;
            }
            trigger OnAfterGetRecord()
            begin
                if "Vendor Ledger Entry".Amount = "Vendor Ledger Entry"."Remaining Amount" then CurrReport.Skip;
                if BankAccount <> '' then "Vendor Ledger Entry".SetRange("Bal. Account No.", BankAccount);
                BankCode:='';
                RecBankAccount.Reset;
                RecBankAccount.SetRange("No.", "Vendor Ledger Entry"."Bal. Account No.");
                if RecBankAccount.Find('-')then begin
                    BankAccountNo:=RecBankAccount."Bank Account No.";
                    BankName:=RecBankAccount.Name;
                    BankCode:=RecBankAccount."SSD Bank Code";
                end;
                RecBank.Reset;
                RecBank.SetRange("No.", BankAccount);
                if RecBank.FindFirst then begin
                    VendBCode:=RecBank."SSD Bank Code";
                end;
                Vend.Get("Vendor No.");
                FormatAddr.Vendor(VendAddr, Vend);
                if not Currency.Get("Currency Code")then Currency.InitRoundingPrecision;
                if "Document Type" = "document type"::Payment then begin
                    ReportTitle:=Text004;
                    PaymentDiscountTitle:=Text007;
                end
                else
                begin
                    ReportTitle:=Text003;
                    PaymentDiscountTitle:=Text006;
                end;
                CalcFields("Original Amount");
                RemainingAmount:=-"Original Amount";
                BankAccountNo:='';
                BankName:='';
                CheckNo:='';
                recVLE.Reset;
                recVLE.SetRange("Document No.", "Vendor Ledger Entry"."Document No.");
                recVLE.SetRange("Bal. Account Type", recVLE."bal. account type"::"Bank Account");
                if recVLE.Find('-')then begin
                    RecBankAccount.Reset;
                    RecBankAccount.SetRange("No.", recVLE."Bal. Account No.");
                    if RecBankAccount.Find('-')then begin
                        BankAccountNo:=RecBankAccount."Bank Account No.";
                        BankName:=RecBankAccount.Name;
                    end;
                    RecBankLedEntry.Reset;
                    RecBankLedEntry.SetRange("Document No.", recVLE."Document No.");
                    RecBankLedEntry.SetRange("Document Type", recVLE."document type"::Payment);
                    if RecBankLedEntry.Find('-')then begin
                        CheckNo:=RecBankLedEntry."Cheque No.";
                        if CheckNo = '' then begin
                        /* RecGlE.RESET;
                             RecGlE.SETRANGE("Document No.",recVLE."Document No.");
                             RecGlE.SETRANGE("Document Type",recVLE."Document Type"::Payment);
                             RecGlE.SETFILTER("UTR No.",'<>%1','');
                             IF RecGlE.FIND('-') THEN
                                CheckNo:=RecGlE."UTR No.";*/
                        end;
                    end;
                end;
                BenefiName:='';
                VendBankAcc:='';
                IFSCCode:='';
                VendBankName:='';
                VendBankCode:='';
                recVendBank.Reset;
                recVendBank.SetRange("Vendor No.", "Vendor Ledger Entry"."Vendor No.");
                recVendBank.SetFilter(Code, '<>%1', '');
                if recVendBank.FindFirst then begin
                    VendBankCode:=recVendBank.Code;
                    BenefiName:=recVendBank."Beneficiary Name";
                    VendBankAcc:=recVendBank."Bank Account No.";
                    IFSCCode:=recVendBank."NEFT/RTGS Code";
                    VendBankName:=recVendBank.Name;
                end;
                if VendBankCode <> BankCode then begin
                    "Vendor Ledger Entry".CalcFields("Amount (LCY)");
                    DiffBank+=("Vendor Ledger Entry"."Amount (LCY)" - "Vendor Ledger Entry"."Total TDS Including SHE CESS");
                    // IF VendBankAcc<>'' THEN
                    diffcount+=1;
                end
                else
                begin
                    "Vendor Ledger Entry".CalcFields("Amount (LCY)");
                    //AdvancedAmount.Amount-AdvancedAmount."Total TDS Including SHE CESS"
                    SameBank+=("Vendor Ledger Entry"."Amount (LCY)" - "Vendor Ledger Entry"."Total TDS Including SHE CESS");
                    //IF VendBankAcc<>'' THEN
                    Samecount+=1;
                end;
            //TotalSameDiffrAmount := (SameBank+DiffBank);
            //MESSAGE('VBC %1|BC %2|VN %3',VendBankCode,BankCode,"Vendor Ledger Entry"."Vendor No.");
            //MESSAGE('VN %1|Am. %2|smbk %3|diffbank %4|DC %5|SC%6',"Vendor Ledger Entry"."Vendor No.","Vendor Ledger Entry"."Amount (LCY)",SameBank,DiffBank,diffcount,Samecount);
            //MESSAGE('%1|%2',"Vendor Ledger Entry".Amount,"Vendor Ledger Entry"."Vendor No.");
            end;
            trigger OnPostDataItem()
            begin
                TotalSameDiffrAmount:=(SameBank + DiffBank);
            //MESSAGE('%1',TotalSameDiffrAmount);
            end;
            trigger OnPreDataItem()
            begin
                i2:=0;
                CompanyInfo.Get;
                FormatAddr.Company(CompanyAddr, CompanyInfo);
                GLSetup.Get;
                Filters:="Vendor Ledger Entry".GetFilters;
                Samecount:=0;
                diffcount:=0;
                SameBank:=0;
                DiffBank:=0;
                if DocumentNo2 <> '' then "Vendor Ledger Entry".SetRange("Document No.", DocumentNo2);
            end;
        }
    }
    requestpage
    {
        layout
        {
            area(content)
            {
                field("Bank Account"; BankAccount)
                {
                    ApplicationArea = All;
                    TableRelation = "Bank Account";
                }
                field(DocumentNo2; DocumentNo2)
                {
                    ApplicationArea = All;
                    Caption = 'Document No.';

                    trigger OnLookup(var Text: Text): Boolean var
                        VendorLedgerEntry: Record "Vendor Ledger Entry";
                    begin
                        VendorLedgerEntry.Reset;
                        if VendorLedgerEntry.FindSet then begin
                            //VendorLedgerEntry.SETRANGE("Document No.",TRUE);
                            if Page.RunModal(Page::"Vendor Ledger Entries", VendorLedgerEntry) = Action::LookupOK then DocumentNo2:=VendorLedgerEntry."Document No.";
                        end;
                    end;
                }
            }
        }
        actions
        {
        }
    }
    labels
    {
    CurrencyCodeCaption='Currency Code';
    PageCaption='Page';
    DocDateCaption='Document Date';
    EmailCaption='E-Mail';
    HomePageCaption='Home Page';
    }
    var CompanyInfo: Record "Company Information";
    GLSetup: Record "General Ledger Setup";
    Vend: Record Vendor;
    Currency: Record Currency;
    FormatAddr: Codeunit "Format Address";
    ReportTitle: Text[30];
    PaymentDiscountTitle: Text[30];
    CompanyAddr: array[8]of Text[50];
    VendAddr: array[8]of Text[50];
    RemainingAmount: Decimal;
    AppliedAmount: Decimal;
    NegPmtDiscInvCurrVendLedgEntry1: Decimal;
    NegPmtTolInvCurrVendLedgEntry1: Decimal;
    PmtDiscPmtCurr: Decimal;
    Text003: label 'Payment Receipt';
    Text004: label 'Payment Voucher';
    Text006: label 'Payment Discount Given';
    Text007: label 'Payment Discount Received';
    PmtTolPmtCurr: Decimal;
    NegShowAmountVendLedgEntry1: Decimal;
    CompanyInfoPhoneNoCaptionLbl: label 'Phone No.';
    CompanyInfoGiroNoCaptionLbl: label 'Giro No.';
    CompanyInfoBankNameCaptionLbl: label 'Bank';
    CompanyInfoBankAccNoCaptionLbl: label 'Account No.';
    RcptNoCaptionLbl: label 'Receipt No.';
    CompanyInfoVATRegNoCaptionLbl: label 'GST Registration No.';
    PostingDateCaptionLbl: label 'Posting Date';
    AmtCaptionLbl: label 'Amount';
    PymtAmtSpecCaptionLbl: label 'Payment Amount Specification';
    PymtTolInvCurrCaptionLbl: label 'Payment Tolerance';
    PymtAmtNotAllocatedCaptionLbl: label 'Payment Amount Not Allocated';
    PymtAmtCaptionLbl: label 'Payment Amount';
    ExternalDocNoCaptionLbl: label 'External Document No.';
    RecBankLedEntry: Record "Bank Account Ledger Entry";
    RecBankAccount: Record "Bank Account";
    BankName: Text;
    BankAccountNo: Code[20];
    CheckNo: Text;
    recVLE: Record "Vendor Ledger Entry";
    RecGlE: Record "G/L Entry";
    recVendBank: Record "Vendor Bank Account";
    BenefiName: Text;
    VendBankAcc: Code[20];
    IFSCCode: Code[20];
    VendBankName: Text;
    PayDocNo1: Code[20];
    PayDocNo2: Code[20];
    DVLE1: Record "Detailed Vendor Ledg. Entry";
    DVLE2: Record "Detailed Vendor Ledg. Entry";
    BankAccount: Code[20];
    Filters: Text[250];
    SameBank: Decimal;
    DiffBank: Decimal;
    RecBank: Record "Bank Account";
    BankCode: Code[20];
    VendBankCode: Code[20];
    Samecount: Integer;
    diffcount: Integer;
    TotalRows: Integer;
    VendBCode: Code[20];
    AmountToApply: Decimal;
    Vendor3: Record Vendor;
    i2: Integer;
    VendBankCode2: Code[20];
    BenefiName2: Text;
    VendBankAcc2: Code[20];
    IFSCCode2: Code[20];
    RecBankLedEntry2: Record "Bank Account Ledger Entry";
    RecBankAccount2: Record "Bank Account";
    VendBankName2: Text[40];
    recVendBank2: Record "Vendor Bank Account";
    BankAccount2: Code[20];
    BankCode2: Code[20];
    BankName2: Text[40];
    BankAccountNo2: Code[20];
    TotalSameDiffrAmount: Decimal;
    TotalSameDiffrCount: Integer;
    Samecount2: Integer;
    diffcount2: Integer;
    SameBank2: Decimal;
    DiffBank2: Decimal;
    AsmCount: Decimal;
    ADiffCount: Decimal;
    DocumentNo2: Code[20];
    CheckDueDate: Boolean;
    CheckDueDate2: Boolean;
    local procedure CurrencyCode(SrcCurrCode: Code[10]): Code[10]begin
        if SrcCurrCode = '' then exit(GLSetup."LCY Code");
        exit(SrcCurrCode);
    end;
}
