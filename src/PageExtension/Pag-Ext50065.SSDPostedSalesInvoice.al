PageExtension 50065 "SSD Posted Sales Invoice" extends "Posted Sales Invoice"
{
    layout
    {
        modify("e-Commerce Customer")
        {
            Visible = false;
        }
        addafter("Ship-to Contact")
        {
            field("E-Way Bill Date"; Rec."E-Way Bill Date")
            {
                ApplicationArea = All;
            }
            field("Customer Road Permit No."; Rec."Customer Road Permit No.")
            {
                ApplicationArea = All;
                Editable = false;
            }
        }
        addafter("Dispute Status")
        {
            field(Remarks1; Rec.Remarks1)
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Remarks field.';
            }
        }
        addfirst("Tax Info")
        {
            field("Expected Delivery Date"; Rec."Expected Delivery Date")
            {
                ApplicationArea = All;
                Editable = false;
            }
            field("Actual Delivery Date"; Rec."Actual Delivery Date")
            {
                ApplicationArea = All;
                Editable = true;
            }
            field("ADD Remark"; Rec."ADD Remark")
            {
                ApplicationArea = All;
            }
            field("Effective Date"; Rec."Effective Date")
            {
                ApplicationArea = All;
                Caption = 'Last Node Date';
            }
            field("SRV No."; Rec."SRV No.")
            {
                ApplicationArea = All;
                Caption = 'GRN/SRV No.';
            }
            field("Firm Freight"; Rec."Firm Freight")
            {
                ApplicationArea = All;

                trigger OnValidate()
                var
                    UserSetupL: Record "User Setup";
                begin
                    UserSetupL.Get(UserId); //Alle[Z]
                    UserSetupL.TestField(UserSetupL."Firm Freight Permission"); //Alle[Z]
                    FreightEditable:=false;
                    if not Rec."Firm Freight" then FreightEditable:=true end;
            }
            field("Freight Amount"; Rec."Freight Amount")
            {
                ApplicationArea = All;
                Editable = FreightEditable;
            }
            field("Calculated Freight Amount"; Rec."Calculated Freight Amount")
            {
                ApplicationArea = All;
                Editable = FreightEditable;
            }
            field("Actual Shipping Agent code"; Rec."Actual Shipping Agent code")
            {
                ApplicationArea = All;
                Caption = 'Amended Shipping Agent code';
            }
            field("Actual Delivery Capture Date"; Rec."Actual Delivery Capture Date")
            {
                ApplicationArea = All;
            }
            field("Capture Time"; Rec."Capture Time")
            {
                ApplicationArea = All;
            }
            field("LR/RR No. Capture Date"; Rec."LR/RR No. Capture Date")
            {
                ApplicationArea = All;
                Editable = true;
            }
            field("LR/RR No. Capture Time"; Rec."LR/RR No. Capture Time")
            {
                ApplicationArea = All;
            }
            group(GST)
            {
                Caption = 'GST';
            }
        }
    }
    actions
    {
        addlast(processing)
        {
            action("Print Sales Invoice")
            {
                ApplicationArea = All;
                Caption = 'Print Sales Invoice';

                trigger OnAction()
                begin
                //MSI.SI
                // SalesInvHeader.Reset;
                // SalesInvHeader.SetRange("No.", Rec."No.");
                // //Report.RunModal(Report::"Sales - Invoice IN GST", true, true, SalesInvHeader);
                // //SSD_Sunil
                // //Rec.SetRecFilter();
                // if SalesInvHeader."Type of Invoice" = SalesInvHeader."Type of Invoice"::Normal then
                //     Report.Run(Report::"Sales - Invoice IN GST", true, false, SalesInvHeader)
                // else
                //     if SalesInvHeader."Type of Invoice" = SalesInvHeader."Type of Invoice"::Supplementary then
                //         Report.Run(Report::"Supplementary GST Invoice", true, false, SalesInvHeader)
                //     else
                //         if SalesInvHeader."Type of Invoice" = SalesInvHeader."Type of Invoice"::Commercial then
                //             Report.Run(Report::"Sales Invoice-Commercial1", true, false, SalesInvHeader);
                //SSD_Sunil
                end;
            }
            action("Print Sales Invoice GST")
            {
                ApplicationArea = All;
                Caption = 'Print Sales Invoice GST';

                trigger OnAction()
                begin
                    //MSI.SI
                    SalesInvHeader.Reset;
                    SalesInvHeader.SetRange("No.", Rec."No.");
                    Report.RunModal(Report::"Sales Invoice new_", true, true, SalesInvHeader);
                end;
            }
            action(WithQrImage)
            {
                ApplicationArea = All;
                Caption = 'Sales Invoice New Without QR';

                trigger OnAction()
                begin
                    SalesInvHeader.Reset;
                    SalesInvHeader.SetRange("No.", Rec."No.");
                    Report.RunModal(Report::"Sales Invoice newwithout QR", true, true, SalesInvHeader);
                end;
            }
            action("Quality Certificate")
            {
                ApplicationArea = All;
                Caption = 'Certificate of Analysis.PSI';

                trigger OnAction()
                var
                    QLTCertificate: Report "Certificate of Analysis.PSI";
                    ValueEntry1: Record "Value Entry";
                begin
                    //<<<<< ALLE[5.51]
                    ValueEntry1.Reset;
                    ValueEntry1.SetCurrentkey("Document No.", "Posting Date");
                    ValueEntry1.SetRange(ValueEntry1."Document No.", Rec."No.");
                    QLTCertificate.SetTableview(ValueEntry1);
                    QLTCertificate.SalesInvoice(Rec."No.", Rec."Posting Date", Rec."External Document No.", Rec."Bill-to Name", Rec."Ship-to Name", Abs(ValueEntry1."Item Ledger Entry Quantity"), Rec."Sell-to Customer No.");
                    QLTCertificate.Run;
                //>>>>> ALLE[5.51]
                end;
            }
            action("Quality Certificate New")
            {
                ApplicationArea = All;
                Caption = 'Certificate of Analysis Automation.PSI';

                trigger OnAction()
                var
                    QLTCertificate: Report "Certificate of AnalysisA.PSI";
                    ValueEntry1: Record "Value Entry";
                begin
                    //<<<<< ALLE[5.51]
                    ValueEntry1.Reset;
                    ValueEntry1.SetCurrentkey("Document No.", "Posting Date");
                    ValueEntry1.SetRange(ValueEntry1."Document No.", Rec."No.");
                    QLTCertificate.SetTableview(ValueEntry1);
                    QLTCertificate.SalesInvoice(Rec."No.", Rec."Posting Date", Rec."External Document No.", Rec."Bill-to Name", Rec."Ship-to Name", Abs(ValueEntry1."Item Ledger Entry Quantity"), Rec."Sell-to Customer No.");
                    QLTCertificate.Run;
                //>>>>> ALLE[5.51]
                end;
            }
            action("&Print Sales Invoice new_ Copy")
            {
                ApplicationArea = All;
                Caption = 'Print Sales Invoice GST TVS';

                trigger OnAction()
                var
                    SalesInvHeader: Record "Sales Invoice Header";
                begin
                    CurrPage.SetSelectionFilter(SalesInvHeader);
                    //SalesInvHeader.PrintRecords(TRUE);
                    SalesInvHeader.Reset;
                    SalesInvHeader.SetRange("No.", Rec."No.");
                    Report.RunModal(Report::"Sales Invoice new_ Copy", true, true, SalesInvHeader);
                end;
            }
            action("Supplementary GST Invoice")
            {
                ApplicationArea = All;
                Caption = 'Supplementary GST Invoice';

                trigger OnAction()
                begin
                    SalesInvHeader.Reset;
                    SalesInvHeader.SetRange("No.", Rec."No.");
                    Report.RunModal(Report::"Supplementary GST Invoice", true, true, SalesInvHeader);
                end;
            }
            action("&Commercial Invoice GST")
            {
                ApplicationArea = All;
                Caption = 'Sales Invoice-Commercial New';

                trigger OnAction()
                begin
                    //<<<< ALLE[551]
                    SalesInvHeader.Reset;
                    SalesInvHeader.SetRange("No.", Rec."No.");
                    Report.RunModal(Report::"Sales Invoice-Commercial1", true, true, SalesInvHeader);
                //>>>> ALLE[551]
                end;
            }
            action("Export Invoice")
            {
                ApplicationArea = All;
                Caption = 'Sales Invoice Export';

                trigger OnAction()
                begin
                    SalesInvHeader.Reset;
                    SalesInvHeader.SetRange("No.", Rec."No.");
                    Report.RunModal(Report::"Sales Invoice Export", true, true, SalesInvHeader);
                end;
            }
            action("Debit Note Report")
            {
                ApplicationArea = All;
                Caption = 'Debit Note Report';

                trigger OnAction()
                begin
                    SalesInvHeader.Reset;
                    SalesInvHeader.SetRange("No.", Rec."No.");
                    Report.RunModal(Report::"Debit Note Report", true, true, SalesInvHeader);
                end;
            }
            group("GST Integration")
            {
                action("Generate EInvoice")
                {
                    Caption = 'Generate E-Invoice';
                    ApplicationArea = ALL;

                    trigger OnAction();
                    var
                        SalesInvHeader: Record "Sales Invoice Header";
                        //EinvSSD: Codeunit SSDEinvGenerateEinvoice;
                        GeneralLedgerSetup: Record "General Ledger Setup";
                        EInvoiceMgt: Codeunit "SSD EInvoice Management";
                    begin
                        SalesInvHeader.RESET;
                        SalesInvHeader.SETRANGE("No.", Rec."No.");
                        IF SalesInvHeader.FINDFIRST THEN BEGIN
                            CLEAR(EInvoiceMgt);
                            SalesInvHeader.MARK(TRUE);
                            GeneralLedgerSetup.Get();
                            // if not GeneralLedgerSetup."Test Instance" then // SSD-29-03-23
                            EInvoiceMgt.GenerateSalesInvoice(SalesInvHeader)// else
                        //EinvSSD.GenerateSalesInvoiceTest(SalesInvHeader);
                        END;
                    end;
                }
                action("Generate EWB")
                {
                    Caption = 'Generate EWB';
                    ApplicationArea = ALL;

                    trigger OnAction();
                    var
                        SalesInvHeader: Record "Sales Invoice Header";
                        //EWBSSD: Codeunit "Generate EWB";
                        EInvoiceMgt: Codeunit "SSD EInvoice Management";
                        GeneralLedgerSetup: Record "General Ledger Setup";
                    begin
                        IF Rec."E-Way Bill No." = '' THEN BEGIN
                            SalesInvHeader.RESET;
                            SalesInvHeader.SETRANGE("No.", rec."No.");
                            IF SalesInvHeader.FINDFIRST THEN BEGIN
                                CLEAR(EInvoiceMgt);
                                SalesInvHeader.MARK(TRUE);
                                GeneralLedgerSetup.Get();
                                //if not GeneralLedgerSetup."Test Instance" then
                                EInvoiceMgt.GenerateSalesInvoiceEWB(SalesInvHeader)// else
                            //     EWBSSD.GenerateSalesInvoiceTest(SalesInvHeader);
                            END;
                        END
                        else
                            Error('E-Way Bill Already generated');
                    end;
                }
            }
        }
        addafter(ActivityLog)
        {
            action("E-Invoice Details")
            {
                ApplicationArea = All;
                Caption = 'E-Invoice Details';
                Image = Info;
                Promoted = true;
                PromotedIsBig = true;
                RunObject = Page "E-Invoice Requests";
                RunPageLink = "Document No."=field("No.");
                RunPageView = sorting("Document Type", "Document No.", "E-Invoice Generated");
            }
        }
    }
    var FreightEditable: Boolean;
    SalesInvHeader: Record "Sales Invoice Header";
    trigger OnOpenPage()
    begin
        if not Rec."Firm Freight" then FreightEditable:=true;
    end;
}
