Report 50139 "Payment Advice"
{
    // --AlleZav1.11/020915--Payment Advice Report
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Payment Advice.rdl';
    ApplicationArea = ALL;
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem("Vendor Ledger Entry"; "Vendor Ledger Entry")
        {
            CalcFields = Amount;
            DataItemTableView = sorting("Document No.");
            RequestFilterFields = "Document No.", "Vendor No.", "Posting Date";

            column(ReportForNavId_1000000000;1000000000)
            {
            }
            column(Logo; CompanyInformation."New Logo1")
            {
            }
            column(Voucher_No; "Vendor Ledger Entry"."Document No.")
            {
            }
            column(Voucher_Date; "Vendor Ledger Entry"."Posting Date")
            {
            }
            column(Vendor_Code; "Vendor Ledger Entry"."Vendor No.")
            {
            }
            column(Vendor_Name; Vendor.Name)
            {
            }
            column(Vendor_Email; Vendor."E-Mail")
            {
            }
            column(Vendor_Contact; Vendor.Contact)
            {
            }
            column(Text001; Text001)
            {
            }
            column(Text002; Text002)
            {
            }
            column(Credit_Acc_No; Vendor."Creditor No.")
            {
            }
            column(Bank_Acc; VendorBankAccount.Name)
            {
            }
            column(VendorPaymentMethodCode; "Payment Method Code")
            {
            }
            column(AMT; "Vendor Ledger Entry".Amount - "Vendor Ledger Entry"."Total TDS Including SHE CESS")
            {
            }
            column(AmtInText; AmtInText1[1] + AmtInText[2])
            {
            }
            column(Currency; CurrCode)
            {
            }
            column(DocumentNo_; "Document No.")
            {
            }
            column(Responsibility_Name; CompanyInformation.Name)
            {
            }
            dataitem("Detailed Vendor Ledg. Entry"; "Detailed Vendor Ledg. Entry")
            {
                DataItemLink = "Applied Vend. Ledger Entry No."=field("Entry No.");
                DataItemTableView = sorting("Vendor No.", "Initial Document Type", "Document Type", "Entry Type", "Posting Date")where("Entry Type"=filter(Application), Unapplied=const(false));

                column(ReportForNavId_1000000032;1000000032)
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
                dataitem(Details; "Vendor Ledger Entry")
                {
                    CalcFields = Amount;
                    DataItemLink = "Entry No."=field("Vendor Ledger Entry No.");
                    DataItemTableView = sorting("Entry No.");

                    column(ReportForNavId_1000000001;1000000001)
                    {
                    }
                    column(Invoice_No; Details."External Document No.")
                    {
                    }
                    column(Date; Details."Document Date")
                    {
                    }
                    column(Amount; "Detailed Vendor Ledg. Entry".Amount)
                    {
                    }
                    column(TDS; Details."Total TDS Including SHE CESS")
                    {
                    }
                    column(Invoice_Amount; PurchaseInvoiceHeader."Original Invoice Amount")
                    {
                    }
                    column(Disc; Disc)
                    {
                    }
                    column(Per; Per)
                    {
                    }
                    column(Reason; PurchaseInvoiceHeader."Deduction Reason")
                    {
                    }
                    column(Curr; "Currency Code")
                    {
                    }
                    column(SourceCode_Details; Details."Source Code")
                    {
                    }
                    column(Total; Total)
                    {
                    }
                    dataitem(detail; "Bank Account Ledger Entry")
                    {
                        DataItemLink = "Document No."=field("Document No.");
                        DataItemTableView = sorting("Entry No.")order(ascending);

                        column(ReportForNavId_1000000002;1000000002)
                        {
                        }
                        column(Cheque_No; detail."Cheque No.")
                        {
                        }
                        column(Cheque_Date; detail."Cheque Date")
                        {
                        }
                    }
                    trigger OnAfterGetRecord()
                    begin
                        Total:=0;
                        PurchaseInvoiceHeader.Reset;
                        PurchaseInvoiceHeader.SetRange("No.", "Document No.");
                        if PurchaseInvoiceHeader.FindFirst then PurchaseInvoiceHeader.CalcFields(Amount);
                        Details.CalcFields(Amount);
                        //Disc := (ABS("Original Pmt. Disc. Possible")*100)/ABS(Amount);
                        Disc:=Abs("Original Pmt. Disc. Possible");
                        Curr:='';
                        if Details."Currency Code" = '' then Curr:='Rs.';
                        if Details."Source Code" = 'JOURNALV' then Total:=-Details.Amount end;
                    trigger OnPreDataItem()
                    begin
                        Disc:=0;
                    end;
                }
                trigger OnPreDataItem()
                begin
                    SetFilter("Vendor Ledger Entry No.", '<>%1', "Vendor Ledger Entry"."Entry No.");
                end;
            }
            trigger OnAfterGetRecord()
            begin
                if Vendor.Get("Vendor No.")then;
                if VendorBankAccount.Get("Vendor No.", Vendor."Preferred Bank Account Code")then;
                Check.InitTextVariable;
                Clear(AmtInText);
                "Vendor Ledger Entry".CalcFields(Amount);
                Check.FormatNoText(AmtInText, ROUND(Abs(Amount - "Total TDS Including SHE CESS"), 0.01, '='), "Currency Code");
                //AmtInText1[1] := DELCHR(AmtInText[1],'*','=');
                AmtInText1[1]:=DelChr(AmtInText[1], '=', '*');
                //Message('%1',AmtInText1[1]);
                if "Currency Code" <> '' then CurrCode:="Currency Code"
                else
                    CurrCode:='INR';
            end;
            trigger OnPostDataItem()
            begin
            //Filter := "Vendor Ledger Entry".GETFILTERS;
            end;
            trigger OnPreDataItem()
            begin
            //SETFILTER("Posting Date",'%1..%2',20150109D,20153009D);
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
        CompanyInformation.Get;
        CompanyInformation.CalcFields("New Logo1");
    end;
    var CompanyInformation: Record "Company Information";
    Vendor: Record Vendor;
    Text001: label 'Dear Sir/Madam,';
    Text002: label 'We have credited your Account No. %1 With Currency %2 %3 on %4 in settlement of your below invoices:';
    PurchaseInvoiceHeader: Record "Purch. Inv. Header";
    FileName1: Text[1024];
    "Filter": Text[1024];
    DocNo: Text;
    Check: Report "Check Report";
    AmtInText: array[2]of Text[1024];
    Disc: Decimal;
    Per: Text[5];
    Curr: Text[10];
    AmtInText1: array[2]of Text[1024];
    VendorBankAccount: Record "Vendor Bank Account";
    CurrCode: Code[20];
    Total: Decimal;
}
