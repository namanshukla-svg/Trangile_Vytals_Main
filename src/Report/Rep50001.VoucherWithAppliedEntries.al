Report 50001 "Voucher With Applied Entries"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Voucher With Applied Entries.rdl';
    Caption = 'Print Voucher With Applied Entries';
    ApplicationArea = all;
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem("G/L Entry"; "G/L Entry")
        {
            DataItemTableView = sorting("Document No.", "Posting Date", Amount)order(descending);
            RequestFilterFields = "Posting Date", "Document No.";

            column(ReportForNavId_7069;7069)
            {
            }
            column(GLAccName1; GLAccName1)
            {
            }
            column(SourceDesc_____Voucher_; SourceDesc + ' Voucher')
            {
            }
            column(G_L_Entry__Document_No__; "Document No.")
            {
            }
            column(DocNo; DocNo)
            {
            }
            column(Date______FORMAT__Posting_Date__;'Date: ' + Format("Posting Date"))
            {
            }
            column(CompanyInformation_Address_____CompanyInformation__Address_2___________CompanyInformation_City; CompanyInformation.Address + ' ' + CompanyInformation."Address 2" + ', ' + CompanyInformation.City + '-' + CompanyInformation."Post Code" + ',' + ' India')
            {
            }
            column(CompanyInformation_Name; CompanyInformation.Name)
            {
            }
            column(G_L_Entry__Credit_Amount_; "Credit Amount")
            {
            }
            column(G_L_Entry__Debit_Amount_; "Debit Amount")
            {
            }
            column(DrText; DrText)
            {
            }
            column(GLAccName; GLAccName)
            {
            }
            column(CrText; CrText)
            {
            }
            column(DebitAmountTotal; DebitAmountTotal)
            {
            }
            column(CreditAmountTotal; CreditAmountTotal)
            {
            }
            column(Cheque_No______ChequeNo______Dated______FORMAT_ChequeDate_;'Cheque No: ' + ChequeNo + '  Dated: ' + Format(ChequeDate))
            {
            }
            column(ChequeNo; ChequeNo)
            {
            }
            column(ChequeDate; ChequeDate)
            {
            }
            column(G_L_Entry__Credit_Amount__Control1500023; "Credit Amount")
            {
            }
            column(G_L_Entry__Debit_Amount__Control1500025; "Debit Amount")
            {
            }
            column(Rs____NumberText_1_______NumberText_2_;'Rs. ' + NumberText[1] + ' ' + NumberText[2])
            {
            }
            column(Voucher_No___Caption; Voucher_No___CaptionLbl)
            {
            }
            column(Credit_AmountCaption; Credit_AmountCaptionLbl)
            {
            }
            column(Debit_AmountCaption; Debit_AmountCaptionLbl)
            {
            }
            column(ParticularsCaption; ParticularsCaptionLbl)
            {
            }
            column(Amount__in_words__Caption; Amount__in_words__CaptionLbl)
            {
            }
            column(Prepared_by_Caption; Prepared_by_CaptionLbl)
            {
            }
            column(Checked_by_Caption; Checked_by_CaptionLbl)
            {
            }
            column(Approved_by_Caption; Approved_by_CaptionLbl)
            {
            }
            column(Continued______Caption; Continued______CaptionLbl)
            {
            }
            column(G_L_Entry_Entry_No_; "Entry No.")
            {
            }
            column(G_L_Entry_Posting_Date; "Posting Date")
            {
            }
            column(G_L_Entry_Transaction_No_; "Transaction No.")
            {
            }
            column(DimCode; DimCode)
            {
            }
            column(DimValue; DimValue)
            {
            }
            dataitem("Dimension Set Entry"; "Dimension Set Entry")
            {
                DataItemLink = "Dimension Set ID"=field("Dimension Set ID");

                column(ReportForNavId_1000000000;1000000000)
                {
                }
                column(DimText; DimText)
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
                trigger OnAfterGetRecord()
                begin
                    DimSetEntry.Reset;
                    DimSetEntry.SetRange("Dimension Set ID", "Dimension Set ID");
                    if DimSetEntry.FindSet then repeat if DimText <> '' then DimText:=DimText + '; ' + DimSetEntry."Dimension Code" + ':' + DimSetEntry."Dimension Value Code"
                            else
                                DimText:=DimSetEntry."Dimension Code" + ':' + DimSetEntry."Dimension Value Code";
                        until DimSetEntry.Next = 0;
                end;
                trigger OnPreDataItem()
                begin
                    DimText:='';
                end;
            }
            dataitem(LineNarration; "Posted Narration")
            {
                DataItemLink = "Transaction No."=field("Transaction No."), "Entry No."=field("Entry No.");
                DataItemTableView = sorting("Entry No.", "Transaction No.", "Line No.");

                column(ReportForNavId_3384;3384)
                {
                }
                column(LineNarration_Narration; Narration)
                {
                }
                column(PrintLineNarration; PrintLineNarration)
                {
                }
                column(LineNarration_Entry_No_; "Entry No.")
                {
                }
                column(LineNarration_Transaction_No_; "Transaction No.")
                {
                }
                column(LineNarration_Line_No_; "Line No.")
                {
                }
                trigger OnAfterGetRecord()
                begin
                    if PrintLineNarration then begin
                        PageLoop:=PageLoop - 1;
                        LinesPrinted:=LinesPrinted + 1;
                    end;
                end;
            }
            dataitem("Integer"; "Integer")
            {
                DataItemTableView = sorting(Number);

                column(ReportForNavId_5444;5444)
                {
                }
                column(IntegerOccurcesCaption; IntegerOccurcesCaptionLbl)
                {
                }
                column(Integer_Number; Number)
                {
                }
                trigger OnAfterGetRecord()
                begin
                    PageLoop:=PageLoop - 1;
                end;
                trigger OnPreDataItem()
                begin
                    GLEntry.SetCurrentkey("Document No.", "Posting Date", Amount);
                    GLEntry.Ascending(false);
                    GLEntry.SetRange("Posting Date", "G/L Entry"."Posting Date");
                    GLEntry.SetRange("Document No.", "G/L Entry"."Document No.");
                    GLEntry.FindLast;
                    if not(GLEntry."Entry No." = "G/L Entry"."Entry No.")then CurrReport.Break;
                    SetRange(Number, 1, PageLoop)end;
            }
            dataitem(PostedNarration1; "Posted Narration")
            {
                DataItemLink = "Transaction No."=field("Transaction No.");
                DataItemTableView = sorting("Entry No.", "Transaction No.", "Line No.")where("Entry No."=filter(0));

                column(ReportForNavId_2156;2156)
                {
                }
                column(PostedNarration1_Narration; Narration)
                {
                }
                column(Narration__Caption; Narration__CaptionLbl)
                {
                }
                column(PostedNarration1_Entry_No_; "Entry No.")
                {
                }
                column(PostedNarration1_Transaction_No_; "Transaction No.")
                {
                }
                column(PostedNarration1_Line_No_; "Line No.")
                {
                }
                trigger OnPreDataItem()
                begin
                    GLEntry.SetCurrentkey("Document No.", "Posting Date", Amount);
                    GLEntry.Ascending(false);
                    GLEntry.SetRange("Posting Date", "G/L Entry"."Posting Date");
                    GLEntry.SetRange("Document No.", "G/L Entry"."Document No.");
                    GLEntry.FindLast;
                    if not(GLEntry."Entry No." = "G/L Entry"."Entry No.")then CurrReport.Break;
                end;
            }
            dataitem("Vendor Ledger Entry"; "Vendor Ledger Entry")
            {
                DataItemLink = "Entry No."=field("Entry No.");
                DataItemTableView = sorting("Document No.", "Document Type", "Vendor No.");

                column(ReportForNavId_1000000057;1000000057)
                {
                }
                column(Total_AplliedVend_; "Total-AplliedVend")
                {
                }
                column(Application_DetailsCaption; Application_DetailsCaptionLbl)
                {
                }
                column(Posting_DateCaption; Posting_DateCaptionLbl)
                {
                }
                column(Document_TypeCaption; Document_TypeCaptionLbl)
                {
                }
                column(Document_No_Caption; Document_No_CaptionLbl)
                {
                }
                column(External_Doc__No_Caption; External_Doc__No_CaptionLbl)
                {
                }
                column(AmountCaption; AmountCaptionLbl)
                {
                }
                column(Remaining_Amt_Caption; Remaining_Amt_CaptionLbl)
                {
                }
                column(Total_Caption; Total_CaptionLbl)
                {
                }
                column(Vendor_Ledger_Entry_Entry_No_; "Entry No.")
                {
                }
                dataitem("Detailed Vendor Ledg. Entry"; "Detailed Vendor Ledg. Entry")
                {
                    DataItemLink = "Applied Vend. Ledger Entry No."=field("Entry No.");
                    DataItemTableView = sorting("Vendor No.", "Initial Document Type", "Document Type", "Entry Type", "Posting Date")where("Entry Type"=filter(Application), Unapplied=const(false));

                    column(ReportForNavId_1000000046;1000000046)
                    {
                    }
                    column(Detailed_Vendor_Ledg__Entry_Entry_No_; "Entry No.")
                    {
                    }
                    column(Detailed_Vendor_Ledg__Entry_Applied_Vend__Ledger_Entry_No_; "Applied Vend. Ledger Entry No.")
                    {
                    }
                    column(Detailed_Vendor_Ledg__Entry_Vendor_Ledger_Entry_No_; "Vendor Ledger Entry No.")
                    {
                    }
                    dataitem("<Vendor Ledger Entry 2>"; "Vendor Ledger Entry")
                    {
                        DataItemLink = "Entry No."=field("Vendor Ledger Entry No.");
                        DataItemTableView = sorting("Entry No.");

                        column(ReportForNavId_1000000042;1000000042)
                        {
                        }
                        column(PostingDate_VendorLedgerEntry2; "<Vendor Ledger Entry 2>"."Posting Date")
                        {
                        }
                        column(Vendor_Ledger_Entry_2____Vendor_Ledger_Entry_2____Document_Type_; "<Vendor Ledger Entry 2>"."Document Type")
                        {
                        }
                        column(Vendor_Ledger_Entry_2____Vendor_Ledger_Entry_2____Document_No__; "<Vendor Ledger Entry 2>"."Document No.")
                        {
                        }
                        column(Detailed_Vendor_Ledg__Entry__Amount; "Detailed Vendor Ledg. Entry".Amount)
                        {
                        }
                        column(Vendor_Ledger_Entry_2____Vendor_Ledger_Entry_2____External_Document_No__; "<Vendor Ledger Entry 2>"."External Document No.")
                        {
                        }
                        column(Vendor_Ledger_Entry___Remaining_Amount_; "Vendor Ledger Entry"."Remaining Amount")
                        {
                        }
                        column(Vendor_Ledger_Entry_2___Posting_Date_; "Posting Date")
                        {
                        }
                        column(Vendor_Ledger_Entry_2__Entry_No_; "Entry No.")
                        {
                        }
                        column(PO; PO)
                        {
                        }
                        column(Date; Date)
                        {
                        }
                        column(AccNo; Vendor."Creditor No.")
                        {
                        }
                        column(BankName; VendorBankAccount.Name)
                        {
                        }
                        trigger OnAfterGetRecord()
                        var
                            PurInvLine: Record "Purch. Inv. Line";
                            PurchRcptHdr: Record "Purch. Rcpt. Header";
                        begin
                            CalcFields(Amount);
                            Date:="Due Date";
                            PO:='';
                            PurInvLine.Reset;
                            PurInvLine.SetRange("Document No.", "Document No.");
                            PurInvLine.SetFilter("No.", '<>%1', '');
                            if PurInvLine.FindFirst then if PurInvLine."No." <> '' then begin
                                    PurchRcptHdr.Reset;
                                    PurchRcptHdr.SetRange("No.", PurInvLine."Receipt No.");
                                    if PurchRcptHdr.FindFirst then begin
                                        PO:=PurchRcptHdr."Order No.";
                                        Date:=PurchRcptHdr."Due Date";
                                    end;
                                end;
                            if(PO = '') and (Date = 0D)then begin
                                PIH.Reset;
                                PIH.SetRange("No.", PurInvLine."Document No.");
                                if PIH.FindFirst then begin
                                    PO:='';
                                    Date:=PIH."Due Date";
                                end;
                            end;
                            if Vendor.Get("<Vendor Ledger Entry 2>"."Vendor No.")then;
                            if VendorBankAccount.Get(Vendor."No.", Vendor."Preferred Bank Account Code")then;
                        end;
                    }
                    trigger OnPreDataItem()
                    begin
                        SetFilter("Vendor Ledger Entry No.", '<>%1', "Vendor Ledger Entry"."Entry No.");
                    end;
                }
                trigger OnPreDataItem()
                begin
                    SetRange("Document No.", DocNo);
                end;
            }
            dataitem("Cust. Ledger Entry"; "Cust. Ledger Entry")
            {
                DataItemLink = "Entry No."=field("Entry No.");
                DataItemTableView = sorting("Document No.", "Document Type", "Customer No.");

                column(ReportForNavId_1000000034;1000000034)
                {
                }
                column(ABS__Total_AppliedCust__;-"Total-AppliedCust")
                {
                }
                column(DocumentNo_CustLedgerEntry; "Cust. Ledger Entry"."Document No.")
                {
                }
                column(Application_DetailsCaption_Control1000000019; Application_DetailsCaption_Control1000000019Lbl)
                {
                }
                column(AmountCaption_Control1000000043; AmountCaption_Control1000000043Lbl)
                {
                }
                column(Remaining_Amt_Caption_Control1000000044; Remaining_Amt_Caption_Control1000000044Lbl)
                {
                }
                column(External_Doc__No_Caption_Control1000000045; External_Doc__No_Caption_Control1000000045Lbl)
                {
                }
                column(Document_TypeCaption_Control1000000046; Document_TypeCaption_Control1000000046Lbl)
                {
                }
                column(Document_No_Caption_Control1000000047; Document_No_Caption_Control1000000047Lbl)
                {
                }
                column(Posting_DateCaption_Control1000000048; Posting_DateCaption_Control1000000048Lbl)
                {
                }
                column(Total_Caption_Control1000000036; Total_Caption_Control1000000036Lbl)
                {
                }
                column(Cust__Ledger_Entry_Entry_No_; "Entry No.")
                {
                }
                column(Cust__Ledger_Entry_Document_No_; "Document No.")
                {
                }
                dataitem("Detailed Cust. Ledg. Entry"; "Detailed Cust. Ledg. Entry")
                {
                    DataItemLink = "Applied Cust. Ledger Entry No."=field("Entry No.");
                    DataItemTableView = sorting("Customer No.", "Initial Document Type", "Document Type", "Entry Type", "Posting Date")where(Unapplied=const(false));

                    column(ReportForNavId_1000000022;1000000022)
                    {
                    }
                    column(Detailed_Cust__Ledg__Entry_Entry_No_; "Entry No.")
                    {
                    }
                    column(Detailed_Cust__Ledg__Entry_Document_No_; "Document No.")
                    {
                    }
                    column(Detailed_Cust__Ledg__Entry_Applied_Cust__Ledger_Entry_No_; "Applied Cust. Ledger Entry No.")
                    {
                    }
                    column(Detailed_Cust__Ledg__Entry_Cust__Ledger_Entry_No_; "Cust. Ledger Entry No.")
                    {
                    }
                    dataitem("<Cust. Ledger Entry2>"; "Cust. Ledger Entry")
                    {
                        DataItemLink = "Entry No."=field("Cust. Ledger Entry No.");
                        DataItemTableView = sorting("Entry No.");

                        column(ReportForNavId_1000000017;1000000017)
                        {
                        }
                        column(Cust__Ledger_Entry2___Document_Type_; "<Cust. Ledger Entry2>"."Document Type")
                        {
                        }
                        column(Cust__Ledger_Entry2___Document_No__; "<Cust. Ledger Entry2>"."Document No.")
                        {
                        }
                        column(ABS__Detailed_Cust__Ledg__Entry__Amount_;-"Detailed Cust. Ledg. Entry".Amount)
                        {
                        }
                        column(Cust__Ledger_Entry2___External_Document_No__; "<Cust. Ledger Entry2>"."External Document No.")
                        {
                        }
                        column(Cust__Ledger_Entry___Remaining_Amount_; "Cust. Ledger Entry"."Remaining Amount")
                        {
                        }
                        column(Cust__Ledger_Entry2___Posting_Date_; "Posting Date")
                        {
                        }
                        column(Cust__Ledger_Entry2__Entry_No_; "Entry No.")
                        {
                        }
                        trigger OnAfterGetRecord()
                        begin
                            CalcFields(Amount);
                        end;
                    }
                    trigger OnPreDataItem()
                    begin
                        SetFilter("Cust. Ledger Entry No.", '<>%1', "Cust. Ledger Entry"."Entry No.");
                    end;
                }
                dataitem("Detailed Cust. Ledg. Entry2"; "Detailed Cust. Ledg. Entry")
                {
                    DataItemLink = "Cust. Ledger Entry No."=field("Entry No.");
                    DataItemLinkReference = "Cust. Ledger Entry";
                    DataItemTableView = sorting("Cust. Ledger Entry No.", "Posting Date")where(Unapplied=const(false));

                    column(ReportForNavId_1000000064;1000000064)
                    {
                    }
                    dataitem("Cust. Ledger Entry3"; "Cust. Ledger Entry")
                    {
                        DataItemLink = "Entry No."=field("Applied Cust. Ledger Entry No.");
                        DataItemTableView = sorting("Entry No.");

                        column(ReportForNavId_1000000065;1000000065)
                        {
                        }
                        column(DocumentNo_CustLedgerEntry3; "Cust. Ledger Entry3"."Document No.")
                        {
                        }
                        column(Amount_CustLedgerEntry3; "Cust. Ledger Entry3".Amount)
                        {
                        }
                        column(ExternalDocumentNo_CustLedgerEntry3; "Cust. Ledger Entry3"."External Document No.")
                        {
                        }
                        column(RemainingAmount_CustLedgerEntry3; "Cust. Ledger Entry3"."Remaining Amount")
                        {
                        }
                        column(PostingDate_CustLedgerEntry3; "Cust. Ledger Entry3"."Posting Date")
                        {
                        }
                        column(EntryNo_CustLedgerEntry3; "Cust. Ledger Entry3"."Entry No.")
                        {
                        }
                        column(DocumentType_CustLedgerEntry3; "Cust. Ledger Entry3"."Document Type")
                        {
                        IncludeCaption = true;
                        }
                    }
                }
                trigger OnAfterGetRecord()
                begin
                //CALCFIELDS(Amount);////
                end;
                trigger OnPreDataItem()
                begin
                    SetRange("Document No.", DocNo);
                end;
            }
            trigger OnAfterGetRecord()
            begin
                if DocNo <> "G/L Entry"."Document No." then DocNo:="G/L Entry"."Document No.";
                CheckFlag+=1;
                GLAccName1:='';
                GLAccName:=FindGLAccName("Source Type", "Entry No.", "Source No.", "G/L Account No.");
                //ALLE
                if "Source Type" = "source type"::Vendor then begin
                    Vend1.Get("Source No.");
                    GLAccName1:='Vendor: ' + Vend1."No." + '-' + Vend1.Name;
                end;
                if "Source Type" = "source type"::Customer then begin
                    Cust1.Get("Source No.");
                    GLAccName1:='Customer :' + Cust1."No." + '-' + Cust1.Name;
                end;
                //ALLE
                if Amount < 0 then begin
                    CrText:='To';
                    DrText:='';
                end
                else
                begin
                    CrText:='';
                    DrText:='Dr';
                end;
                SourceDesc:='';
                if "Source Code" <> '' then begin
                    SourceCode.Get("Source Code");
                    SourceDesc:=SourceCode.Description;
                end;
                PageLoop:=PageLoop - 1;
                LinesPrinted:=LinesPrinted + 1;
                ChequeNo:='';
                ChequeDate:=0D;
                if("Source No." <> '') and ("Source Type" = "source type"::"Bank Account")then begin
                    if BankAccLedgEntry.Get("Entry No.")then begin
                        ChequeNo:=BankAccLedgEntry."Cheque No.";
                        ChequeDate:=BankAccLedgEntry."Cheque Date";
                    end;
                end;
                if(ChequeNo <> '') and (ChequeDate <> 0D)then begin
                    PageLoop:=PageLoop - 1;
                    LinesPrinted:=LinesPrinted + 1;
                end;
                if PostingDate <> "Posting Date" then begin
                    PostingDate:="Posting Date";
                    TotalDebitAmt:=0;
                end;
                if DocumentNo <> "Document No." then begin
                    DocumentNo:="Document No.";
                    TotalDebitAmt:=0;
                end;
                if PostingDate = "Posting Date" then begin
                    InitTextVariable;
                    TotalDebitAmt+="Debit Amount";
                    FormatNoText(NumberText, Abs(TotalDebitAmt), '');
                    PageLoop:=NUMLines;
                    LinesPrinted:=0;
                end;
                if ISSERVICETIER then begin
                    if(PrePostingDate <> "Posting Date") or (PreDocumentNo <> "Document No.")then begin
                        DebitAmountTotal:=0;
                        CreditAmountTotal:=0;
                        PrePostingDate:="Posting Date";
                        PreDocumentNo:="Document No.";
                    end;
                    DebitAmountTotal:=DebitAmountTotal + "Debit Amount";
                    CreditAmountTotal:=CreditAmountTotal + "Credit Amount";
                end;
            end;
            trigger OnPreDataItem()
            begin
                NUMLines:=13;
                PageLoop:=NUMLines;
                LinesPrinted:=0;
                DebitAmountTotal:=0;
                CreditAmountTotal:=0;
                DocNo:="G/L Entry".GetFilter("Document No.");
                CheckFlag:=0;
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

                    field(PrintLineNarration; PrintLineNarration)
                    {
                        ApplicationArea = Basic;
                        Caption = 'PrintLineNarration';
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
    trigger OnPreReport()
    begin
        CompanyInformation.Get;
    end;
    var CompanyInformation: Record "Company Information";
    SourceCode: Record "Source Code";
    GLEntry: Record "G/L Entry";
    BankAccLedgEntry: Record "Bank Account Ledger Entry";
    GLAccName: Text[100];
    SourceDesc: Text[100];
    CrText: Text[2];
    DrText: Text[2];
    NumberText: array[2]of Text[80];
    PageLoop: Integer;
    LinesPrinted: Integer;
    NUMLines: Integer;
    ChequeNo: Code[100];
    ChequeDate: Date;
    Text16526: label 'ZERO';
    Text16527: label 'HUNDRED';
    Text16528: label 'AND';
    Text16529: label '%1 results in a written number that is too long.';
    Text16532: label 'ONE';
    Text16533: label 'TWO';
    Text16534: label 'THREE';
    Text16535: label 'FOUR';
    Text16536: label 'FIVE';
    Text16537: label 'SIX';
    Text16538: label 'SEVEN';
    Text16539: label 'EIGHT';
    Text16540: label 'NINE';
    Text16541: label 'TEN';
    Text16542: label 'ELEVEN';
    Text16543: label 'TWELVE';
    Text16544: label 'THIRTEEN';
    Text16545: label 'FOURTEEN';
    Text16546: label 'FIFTEEN';
    Text16547: label 'SIXTEEN';
    Text16548: label 'SEVENTEEN';
    Text16549: label 'EIGHTEEN';
    Text16550: label 'NINETEEN';
    Text16551: label 'TWENTY';
    Text16552: label 'THIRTY';
    Text16553: label 'FORTY';
    Text16554: label 'FIFTY';
    Text16555: label 'SIXTY';
    Text16556: label 'SEVENTY';
    Text16557: label 'EIGHTY';
    Text16558: label 'NINETY';
    Text16559: label 'THOUSAND';
    Text16560: label 'MILLION';
    Text16561: label 'BILLION';
    Text16562: label 'LAKH';
    Text16563: label 'CRORE';
    OnesText: array[20]of Text[30];
    TensText: array[10]of Text[30];
    ExponentText: array[5]of Text[30];
    PrintLineNarration: Boolean;
    PostingDate: Date;
    TotalDebitAmt: Decimal;
    DocumentNo: Code[20];
    DebitAmountTotal: Decimal;
    CreditAmountTotal: Decimal;
    PrePostingDate: Date;
    PreDocumentNo: Code[100];
    DimCode: Text;
    DimValue: Text;
    DimSetEntry: Record "Dimension Set Entry";
    DimText: Text;
    DocNo: Code[20];
    DimensionValue: Record "Dimension Value";
    "Total-AplliedVend": Decimal;
    "Total-AppliedCust": Decimal;
    Voucher_No___CaptionLbl: label 'Voucher No. :';
    Credit_AmountCaptionLbl: label 'Credit Amount';
    Debit_AmountCaptionLbl: label 'Debit Amount';
    ParticularsCaptionLbl: label 'Particulars';
    Amount__in_words__CaptionLbl: label 'Amount (in words):';
    Prepared_by_CaptionLbl: label 'Prepared by:';
    Checked_by_CaptionLbl: label 'Checked by:';
    Approved_by_CaptionLbl: label 'Approved by:';
    Continued______CaptionLbl: label 'Continued......';
    IntegerOccurcesCaptionLbl: label 'IntegerOccurces';
    Narration__CaptionLbl: label 'Narration :';
    Application_DetailsCaptionLbl: label 'Application Details';
    Posting_DateCaptionLbl: label 'Posting Date';
    Document_TypeCaptionLbl: label 'Document Type';
    Document_No_CaptionLbl: label 'Document No.';
    External_Doc__No_CaptionLbl: label 'External Doc. No.';
    AmountCaptionLbl: label 'Amount';
    Remaining_Amt_CaptionLbl: label 'Remaining Amt.';
    Total_CaptionLbl: label 'Total:';
    Application_DetailsCaption_Control1000000019Lbl: label 'Application Details';
    AmountCaption_Control1000000043Lbl: label 'Amount';
    Remaining_Amt_Caption_Control1000000044Lbl: label 'Remaining Amt.';
    External_Doc__No_Caption_Control1000000045Lbl: label 'External Doc. No.';
    Document_TypeCaption_Control1000000046Lbl: label 'Document Type';
    Document_No_Caption_Control1000000047Lbl: label 'Document No.';
    Posting_DateCaption_Control1000000048Lbl: label 'Posting Date';
    Total_Caption_Control1000000036Lbl: label 'Total:';
    CheckFlag: Integer;
    PO: Code[20];
    Date: Date;
    PIH: Record "Purch. Inv. Header";
    Vendor: Record Vendor;
    VendorBankAccount: Record "Vendor Bank Account";
    GLAccName1: Text;
    AccName1: Text;
    Vend1: Record Vendor;
    Cust1: Record Customer;
    Country: Record "Country/Region";
    procedure FindGLAccName("Source Type": Option " ", Customer, Vendor, "Bank Account", "Fixed Asset"; "Entry No.": Integer; "Source No.": Code[20]; "G/L Account No.": Code[20]): Text[100]var
        AccName: Text[100];
        VendLedgerEntry: Record "Vendor Ledger Entry";
        Vend: Record Vendor;
        CustLedgerEntry: Record "Cust. Ledger Entry";
        Cust: Record Customer;
        BankLedgerEntry: Record "Bank Account Ledger Entry";
        Bank: Record "Bank Account";
        FALedgerEntry: Record "FA Ledger Entry";
        FA: Record "Fixed Asset";
        GLAccount: Record "G/L Account";
    begin
        if "Source Type" = "source type"::Vendor then if VendLedgerEntry.Get("Entry No.")then begin
                Vend.Get("Source No.");
                AccName:=Vend.Name;
                AccName1:=Vend.Name;
            end
            else
            begin
                GLAccount.Get("G/L Account No.");
                AccName:=GLAccount.Name;
            end
        else if "Source Type" = "source type"::Customer then if CustLedgerEntry.Get("Entry No.")then begin
                    Cust.Get("Source No.");
                    AccName:=Cust.Name;
                    AccName1:=Cust.Name;
                end
                else
                begin
                    GLAccount.Get("G/L Account No.");
                    AccName:=GLAccount.Name;
                end
            else if "Source Type" = "source type"::"Bank Account" then if BankLedgerEntry.Get("Entry No.")then begin
                        Bank.Get("Source No.");
                        AccName:=Bank.Name;
                    end
                    else
                    begin
                        GLAccount.Get("G/L Account No.");
                        AccName:=GLAccount.Name;
                    end
                else if "Source Type" = "source type"::"Fixed Asset" then begin
                        FALedgerEntry.Reset;
                        FALedgerEntry.SetCurrentkey("G/L Entry No.");
                        FALedgerEntry.SetRange("G/L Entry No.", "Entry No.");
                        if FALedgerEntry.FindFirst then begin
                            FA.Get("Source No.");
                            AccName:=FA.Description;
                        end
                        else
                        begin
                            GLAccount.Get("G/L Account No.");
                            AccName:=GLAccount.Name;
                        end;
                    end
                    else
                    begin
                        GLAccount.Get("G/L Account No.");
                        AccName:=GLAccount.Name;
                    end;
        if "Source Type" = "source type"::" " then begin
            GLAccount.Get("G/L Account No.");
            AccName:=GLAccount.Name;
        end;
        exit(AccName);
    end;
    procedure FormatNoText(var NoText: array[2]of Text[80]; No: Decimal; CurrencyCode: Code[10])
    var
        PrintExponent: Boolean;
        Ones: Integer;
        Tens: Integer;
        Hundreds: Integer;
        Exponent: Integer;
        NoTextIndex: Integer;
        Currency: Record Currency;
        TensDec: Integer;
        OnesDec: Integer;
    begin
        Clear(NoText);
        NoTextIndex:=1;
        NoText[1]:='';
        if No < 1 then AddToNoText(NoText, NoTextIndex, PrintExponent, Text16526)
        else
        begin
            for Exponent:=4 downto 1 do begin
                PrintExponent:=false;
                if No > 99999 then begin
                    Ones:=No DIV (Power(100, Exponent - 1) * 10);
                    Hundreds:=0;
                end
                else
                begin
                    Ones:=No DIV Power(1000, Exponent - 1);
                    Hundreds:=Ones DIV 100;
                end;
                Tens:=(Ones MOD 100) DIV 10;
                Ones:=Ones MOD 10;
                if Hundreds > 0 then begin
                    AddToNoText(NoText, NoTextIndex, PrintExponent, OnesText[Hundreds]);
                    AddToNoText(NoText, NoTextIndex, PrintExponent, Text16527);
                end;
                if Tens >= 2 then begin
                    AddToNoText(NoText, NoTextIndex, PrintExponent, TensText[Tens]);
                    if Ones > 0 then AddToNoText(NoText, NoTextIndex, PrintExponent, OnesText[Ones]);
                end
                else if(Tens * 10 + Ones) > 0 then AddToNoText(NoText, NoTextIndex, PrintExponent, OnesText[Tens * 10 + Ones]);
                if PrintExponent and (Exponent > 1)then AddToNoText(NoText, NoTextIndex, PrintExponent, ExponentText[Exponent]);
                if No > 99999 then No:=No - (Hundreds * 100 + Tens * 10 + Ones) * Power(100, Exponent - 1) * 10
                else
                    No:=No - (Hundreds * 100 + Tens * 10 + Ones) * Power(1000, Exponent - 1);
            end;
        end;
        if CurrencyCode <> '' then begin
            Currency.Get(CurrencyCode);
            // AddToNoText(NoText,NoTextIndex,PrintExponent,' ' + Currency."Currency Numeric Description");
            AddToNoText(NoText, NoTextIndex, PrintExponent, ' ' + '');
        end
        else
            AddToNoText(NoText, NoTextIndex, PrintExponent, 'RUPEES');
        AddToNoText(NoText, NoTextIndex, PrintExponent, Text16528);
        TensDec:=((No * 100) MOD 100) DIV 10;
        OnesDec:=(No * 100) MOD 10;
        if TensDec >= 2 then begin
            AddToNoText(NoText, NoTextIndex, PrintExponent, TensText[TensDec]);
            if OnesDec > 0 then AddToNoText(NoText, NoTextIndex, PrintExponent, OnesText[OnesDec]);
        end
        else if(TensDec * 10 + OnesDec) > 0 then AddToNoText(NoText, NoTextIndex, PrintExponent, OnesText[TensDec * 10 + OnesDec])
            else
                AddToNoText(NoText, NoTextIndex, PrintExponent, Text16526);
        if(CurrencyCode <> '')then // AddToNoText(NoText,NoTextIndex,PrintExponent,' ' + Currency."Currency Decimal Description" + ' ONLY')
            AddToNoText(NoText, NoTextIndex, PrintExponent, ' ' + '' + ' ONLY')
        else
            AddToNoText(NoText, NoTextIndex, PrintExponent, ' PAISA ONLY');
    end;
    local procedure AddToNoText(var NoText: array[2]of Text[80]; var NoTextIndex: Integer; var PrintExponent: Boolean; AddText: Text[30])
    begin
        PrintExponent:=true;
        while StrLen(NoText[NoTextIndex] + ' ' + AddText) > MaxStrLen(NoText[1])do begin
            NoTextIndex:=NoTextIndex + 1;
            if NoTextIndex > ArrayLen(NoText)then Error(Text16529, AddText);
        end;
        NoText[NoTextIndex]:=DelChr(NoText[NoTextIndex] + ' ' + AddText, '<');
    end;
    procedure InitTextVariable()
    begin
        OnesText[1]:=Text16532;
        OnesText[2]:=Text16533;
        OnesText[3]:=Text16534;
        OnesText[4]:=Text16535;
        OnesText[5]:=Text16536;
        OnesText[6]:=Text16537;
        OnesText[7]:=Text16538;
        OnesText[8]:=Text16539;
        OnesText[9]:=Text16540;
        OnesText[10]:=Text16541;
        OnesText[11]:=Text16542;
        OnesText[12]:=Text16543;
        OnesText[13]:=Text16544;
        OnesText[14]:=Text16545;
        OnesText[15]:=Text16546;
        OnesText[16]:=Text16547;
        OnesText[17]:=Text16548;
        OnesText[18]:=Text16549;
        OnesText[19]:=Text16550;
        TensText[1]:='';
        TensText[2]:=Text16551;
        TensText[3]:=Text16552;
        TensText[4]:=Text16553;
        TensText[5]:=Text16554;
        TensText[6]:=Text16555;
        TensText[7]:=Text16556;
        TensText[8]:=Text16557;
        TensText[9]:=Text16558;
        ExponentText[1]:='';
        ExponentText[2]:=Text16559;
        ExponentText[3]:=Text16562;
        ExponentText[4]:=Text16563;
    end;
}
