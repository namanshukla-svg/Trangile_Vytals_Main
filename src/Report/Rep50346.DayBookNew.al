Report 50346 "Day Book New"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Day Book.rdl';
    Caption = 'Day Book New';
    ApplicationArea = all;
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem("G/L Entry"; "G/L Entry")
        {
            DataItemTableView = sorting("Posting Date", "Source Code", "Transaction No.");
            RequestFilterFields = "Posting Date", "Document No.", "Global Dimension 1 Code", "Global Dimension 2 Code";

            column(ReportForNavId_7069;7069)
            {
            }
            column(CurrReport_PAGENO; CurrReport.PageNo)
            {
            }
            column(FORMAT_TODAY_0_4_; Format(Today, 0, 4))
            {
            }
            column(Time; Time)
            {
            }
            column(Compinfo_Name; Compinfo.Name)
            {
            }
            column(UserId; UserId)
            {
            }
            column(GetFilters; GetFilters)
            {
            }
            column(G_L_Entry__Debit_Amount_; "Debit Amount")
            {
            }
            column(G_L_Entry__Credit_Amount_; "Credit Amount")
            {
            }
            column(GLAccName; GLAccName)
            {
            }
            column(DocNo; DocNo)
            {
            }
            column(FORMAT_PostingDate_; Format(PostingDate))
            {
            }
            column(SourceDesc; SourceDesc)
            {
            }
            column(G_L_Entry__Debit_Amount__Control1500021; "Debit Amount")
            {
            }
            column(G_L_Entry__Credit_Amount__Control1500022; "Credit Amount")
            {
            }
            column(Day_BookCaption; Day_BookCaptionLbl)
            {
            }
            column(Document_No_Caption; Document_No_CaptionLbl)
            {
            }
            column(Account_NameCaption; Account_NameCaptionLbl)
            {
            }
            column(Debit_AmountCaption; Debit_AmountCaptionLbl)
            {
            }
            column(Credit_AmountCaption; Credit_AmountCaptionLbl)
            {
            }
            column(Voucher_TypeCaption; Voucher_TypeCaptionLbl)
            {
            }
            column(DateCaption; DateCaptionLbl)
            {
            }
            column(TotalCaption; TotalCaptionLbl)
            {
            }
            column(G_L_Entry_Entry_No_; "Entry No.")
            {
            }
            column(G_L_Entry_Transaction_No_; "Transaction No.")
            {
            }
            dataitem(UnknownTable16548; "Posted Narration")
            {
                DataItemLink = "Entry No."=field("Entry No.");
                DataItemTableView = sorting("Entry No.", "Transaction No.", "Line No.")order(ascending);

                column(ReportForNavId_5326;5326)
                {
                }
                column(Posted_Narration_Narration; Narration)
                {
                }
                column(Posted_Narration_Entry_No_; "Entry No.")
                {
                }
                column(Posted_Narration_Transaction_No_; "Transaction No.")
                {
                }
                column(Posted_Narration_Line_No_; "Line No.")
                {
                }
                trigger OnPreDataItem()
                begin
                    if not LineNarration then CurrReport.Break;
                end;
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
                    if not VoucherNarration then CurrReport.Break;
                    GLEntry.SetCurrentkey("Posting Date", "Source Code", "Transaction No.");
                    GLEntry.SetRange("Posting Date", "G/L Entry"."Posting Date");
                    GLEntry.SetRange("Source Code", "G/L Entry"."Source Code");
                    GLEntry.SetRange("Transaction No.", "G/L Entry"."Transaction No.");
                    GLEntry.FindLast;
                    if not(GLEntry."Entry No." = "G/L Entry"."Entry No.")then CurrReport.Break;
                end;
            }
            trigger OnAfterGetRecord()
            begin
                DocNo:='';
                PostingDate:=0D;
                SourceDesc:='';
                GLAccName:=FindGLAccName("Source Type", "Entry No.", "Source No.", "G/L Account No.");
                if TransNo = 0 then begin
                    TransNo:="Transaction No.";
                    DocNo:="Document No.";
                    PostingDate:="Posting Date";
                    if "Source Code" <> '' then begin
                        SourceCode.Get("Source Code");
                        SourceDesc:=SourceCode.Description;
                    end;
                end
                else if TransNo <> "Transaction No." then begin
                        TransNo:="Transaction No.";
                        DocNo:="Document No.";
                        PostingDate:="Posting Date";
                        if "Source Code" <> '' then begin
                            SourceCode.Get("Source Code");
                            SourceDesc:=SourceCode.Description;
                        end;
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

                    field(LineNarration; LineNarration)
                    {
                        ApplicationArea = Basic;
                        Caption = 'Line Narration';
                    }
                    field(VoucherNarration; VoucherNarration)
                    {
                        ApplicationArea = Basic;
                        Caption = 'Voucher Narration';
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
        Compinfo.Get;
    end;
    var Compinfo: Record "Company Information";
    GLEntry: Record "G/L Entry";
    SourceCode: Record "Source Code";
    GLAccName: Text[50];
    SourceDesc: Text[50];
    PostingDate: Date;
    LineNarration: Boolean;
    VoucherNarration: Boolean;
    DocNo: Code[20];
    TransNo: Integer;
    Day_BookCaptionLbl: label 'Day Book';
    Document_No_CaptionLbl: label 'Document No.';
    Account_NameCaptionLbl: label 'Account Name';
    Debit_AmountCaptionLbl: label 'Debit Amount';
    Credit_AmountCaptionLbl: label 'Credit Amount';
    Voucher_TypeCaptionLbl: label 'Voucher Type';
    DateCaptionLbl: label 'Date';
    TotalCaptionLbl: label 'Total';
    procedure FindGLAccName("Source Type": Option " ", Customer, Vendor, "Bank Account", "Fixed Asset"; "Entry No.": Integer; "Source No.": Code[20]; "G/L Account No.": Code[20]): Text[50]var
        AccName: Text[50];
        VendLedgEntry: Record "Vendor Ledger Entry";
        Vend: Record Vendor;
        CustLedgEntry: Record "Cust. Ledger Entry";
        Cust: Record Customer;
        BankLedgEntry: Record "Bank Account Ledger Entry";
        Bank: Record "Bank Account";
        FALedgEntry: Record "FA Ledger Entry";
        FA: Record "Fixed Asset";
        GLAccount: Record "G/L Account";
    begin
        if "Source Type" = "source type"::Vendor then if VendLedgEntry.Get("Entry No.")then begin
                Vend.Get("Source No.");
                AccName:=Vend.Name;
            end
            else
            begin
                GLAccount.Get("G/L Account No.");
                AccName:=GLAccount.Name;
            end
        else if "Source Type" = "source type"::Customer then if CustLedgEntry.Get("Entry No.")then begin
                    Cust.Get("Source No.");
                    AccName:=Cust.Name;
                end
                else
                begin
                    GLAccount.Get("G/L Account No.");
                    AccName:=GLAccount.Name;
                end
            else if "Source Type" = "source type"::"Bank Account" then if BankLedgEntry.Get("Entry No.")then begin
                        Bank.Get("Source No.");
                        AccName:=Bank.Name;
                    end
                    else
                    begin
                        GLAccount.Get("G/L Account No.");
                        AccName:=GLAccount.Name;
                    end
                else if "Source Type" = "source type"::"Fixed Asset" then begin
                        FALedgEntry.Reset;
                        FALedgEntry.SetCurrentkey("G/L Entry No.");
                        FALedgEntry.SetRange("G/L Entry No.", "Entry No.");
                        if FALedgEntry.FindFirst then begin
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
}
