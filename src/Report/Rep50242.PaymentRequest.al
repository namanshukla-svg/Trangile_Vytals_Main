Report 50242 "Payment Request"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Payment Request.rdl';
    UsageCategory = ReportsandAnalysis;
    ApplicationArea = all;

    dataset
    {
        dataitem(Customer; Customer)
        {
            DataItemTableView = sorting("No.");
            PrintOnlyIfDetail = true;
            RequestFilterFields = "No.";

            column(ReportForNavId_1000000004;1000000004)
            {
            }
            dataitem("Cust. Ledger Entry"; "Cust. Ledger Entry")
            {
                CalcFields = "Remaining Amount";
                DataItemLink = "Customer No."=field("No.");
                DataItemTableView = sorting("Customer No.")where(Open=const(true));
                RequestFilterFields = "Document No.";

                column(ReportForNavId_1000000012;1000000012)
                {
                }
                column(No_Customer; "Cust. Ledger Entry"."Customer No.")
                {
                }
                column(Name_Customer; Cust.Name)
                {
                }
                column(Contact_Customer; Cust."CTC for Payment")
                {
                }
                column(EMail_Customer; Cust."Email for Payment")
                {
                }
                column(VCode; Cust."Our Account No.")
                {
                }
                column(date; Today)
                {
                }
                column(Picture; CompInfo."New Logo1")
                {
                }
                column(PostingDate_CustLedgerEntry; "Cust. Ledger Entry"."Posting Date")
                {
                }
                column(DocumentNo_CustLedgerEntry; "Cust. Ledger Entry"."Document No.")
                {
                }
                column(ActDelDate; ActDelDate)
                {
                }
                column(DueDate; DueDate)
                {
                }
                column(RemainingAmount_CustLedgerEntry; "Cust. Ledger Entry"."Remaining Amount")
                {
                }
                column(Amount_CustLedgerEntry; "Cust. Ledger Entry".Amount)
                {
                }
                column(TotAmnt; TotAmnt)
                {
                }
                column(TotRemAmnt; TotRemAmnt)
                {
                }
                column(noofdays; Today - DueDate)
                {
                }
                column(Comp_Name; CompInfo.Name)
                {
                }
                column(ExternalDocumentNo_CustLedgerEntry; "Cust. Ledger Entry"."External Document No.")
                {
                }
                trigger OnAfterGetRecord()
                begin
                    // if ("Cust. Ledger Entry".Remarks = '') or (("Cust. Ledger Entry".Remarks <> '') and ("Cust. Ledger Entry"."Check For Email")) then begin
                    Cust.Get("Cust. Ledger Entry"."Customer No.");
                    ActDelDate:=0D;
                    SalesInvoiceHeader.Reset;
                    if SalesInvoiceHeader.Get("Document No.")then ActDelDate:=SalesInvoiceHeader."Actual Delivery Date";
                    if PaymentTerms.Get(Customer."Payment Terms Code")then;
                    /*
                    CLEAR(DueDate);
                    IF ActDelDate = 0D THEN BEGIN
                      IF "Cust. Ledger Entry"."Document Type" = "Cust. Ledger Entry"."Document Type"::Invoice THEN BEGIN
                        IF ActDelDate = 0D THEN
                          CurrReport.SKIP;
                      END ELSE
                        DueDate := "Cust. Ledger Entry"."Posting Date";
                    END ELSE BEGIN
                      IF Customer."Gen. Bus. Posting Group" = 'DIRECT' THEN
                        DueDate := CALCDATE(PaymentTerms."Due Date Calculation",ActDelDate)
                      ELSE
                        DueDate := "Cust. Ledger Entry"."Due Date";
                    END;
                    */
                    Clear(DueDate);
                    if Customer."Gen. Bus. Posting Group" = 'DIRECT' then begin
                        if ActDelDate = 0D then begin
                            if "Cust. Ledger Entry"."Document Type" = "Cust. Ledger Entry"."document type"::Invoice then begin
                                CurrReport.Skip;
                            end
                            else
                                DueDate:="Cust. Ledger Entry"."Posting Date";
                        end
                        else
                            DueDate:=CalcDate(PaymentTerms."Due Date Calculation", ActDelDate);
                    end
                    else
                        DueDate:="Cust. Ledger Entry"."Due Date";
                    if DueDate > Today then CurrReport.Skip;
                    "Cust. Ledger Entry".CalcFields("Remaining Amount");
                    TotAmnt+="Cust. Ledger Entry".Amount;
                    TotRemAmnt+="Cust. Ledger Entry"."Remaining Amount";
                // end else
                //     CurrReport.Skip;
                end;
                trigger OnPreDataItem()
                begin
                    /*IF (Customer."Bill-to Customer No." <> '') AND (Customer."Bill-to Customer No."<> Customer."No.") THEN
                      SETRANGE("Customer No.",Customer."Bill-to Customer No.")
                    ELSE
                      SETRANGE("Customer No.",Customer."No.");
                    
                    //SETRANGE("Due Date",0D,TODAY);
                    */
                    SetRange("Due Date", 0D, Today);
                end;
            }
            trigger OnAfterGetRecord()
            begin
                TotAmnt:=0;
                TotRemAmnt:=0;
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
        CompInfo.Get;
        CompInfo.CalcFields("New Logo1");
    end;
    var CompInfo: Record "Company Information";
    SalesInvoiceHeader: Record "Sales Invoice Header";
    ActDelDate: Date;
    DueDate: Date;
    PaymentTerms: Record "Payment Terms";
    Cust: Record Customer;
    TotAmnt: Decimal;
    TotRemAmnt: Decimal;
}
