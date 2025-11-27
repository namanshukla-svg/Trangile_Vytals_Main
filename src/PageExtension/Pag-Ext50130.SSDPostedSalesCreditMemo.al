pageextension 50130 "SSD Posted Sales Credit Memo" extends "Posted Sales Credit Memo"
{
    actions
    {
        addlast(processing)
        {
            group("GST Integration")
            {
                action("Generate EInvoice")
                {
                    Caption = 'Generate E-Invoice';
                    ApplicationArea = ALL;

                    trigger OnAction();
                    var
                        SalesCrMemoHeader: Record "Sales Cr.Memo Header";
                        //EinvSSD: Codeunit SSDEinvGenerateEinvoice;
                        EInvoiceMgt: Codeunit "SSD EInvoice Management";
                        GeneralLedgerSetup: Record "General Ledger Setup";
                    begin
                        SalesCrMemoHeader.RESET;
                        SalesCrMemoHeader.SETRANGE("No.", Rec."No.");
                        IF SalesCrMemoHeader.FINDFIRST THEN BEGIN
                            CLEAR(EInvoiceMgt);
                            SalesCrMemoHeader.MARK(TRUE);
                            GeneralLedgerSetup.Get();
                            //if not GeneralLedgerSetup."Test Instance" then
                            EInvoiceMgt.GenerateSalesCrMemo(SalesCrMemoHeader)// else
                        //     EinvSSD.GenerateSalesCrMemoTest(SalesCrMemoHeader);
                        END;
                    end;
                }
                action("Generate EWB")
                {
                    Caption = 'Generate EWB';
                    ApplicationArea = ALL;

                    trigger OnAction();
                    var
                        SalesCrMemoHeader: Record "Sales Cr.Memo Header";
                        //EWBSSD: Codeunit "Generate EWB";
                        GeneralLedgerSetup: Record "General Ledger Setup";
                        EInvoiceMgt: Codeunit "SSD EInvoice Management";
                    begin
                        IF Rec."E-Way Bill No." = '' THEN BEGIN
                            SalesCrMemoHeader.RESET;
                            SalesCrMemoHeader.SETRANGE("No.", Rec."No.");
                            IF SalesCrMemoHeader.FINDFIRST THEN BEGIN
                                CLEAR(EInvoiceMgt);
                                SalesCrMemoHeader.MARK(TRUE);
                                GeneralLedgerSetup.Get();
                                //if not GeneralLedgerSetup."Test Instance" then
                                EInvoiceMgt.GenerateSalesCrMemoEWB(SalesCrMemoHeader)// else
                            //     EWBSSD.GenerateSalesInvoiceTest(SalesInvHeader);
                            END;
                        END
                        else
                            Error('E-Way Bill Already generated');
                    end;
                }
            }
        }
    }
}
