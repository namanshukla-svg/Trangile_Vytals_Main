PageExtension 50067 "SSD Posted Sales Invoices" extends "Posted Sales Invoices"
{
    Editable = true;

    layout
    {
        addafter("Sell-to Customer Name")
        {
            field("Actual Delivery Date"; Rec."Actual Delivery Date")
            {
                ApplicationArea = All;
            }
        }
    }
    actions
    {
        addafter("Print")
        {
            action("&Print Sales Invoice GST")
            {
                ApplicationArea = All;
                Caption = 'Print Sales Invoice GST';
                Ellipsis = true;
                Image = Print;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                var
                    SalesInvHeader: Record "Sales Invoice Header";
                begin
                    CurrPage.SetSelectionFilter(SalesInvHeader);
                    //SalesInvHeader.PrintRecords(TRUE);
                    SalesInvHeader.Reset;
                    SalesInvHeader.SetRange("No.", Rec."No.");
                    Report.RunModal(Report::"Sales Invoice new_", true, true, SalesInvHeader);
                end;
            }
            action("&Print Sales Invoice new_ Copy")
            {
                ApplicationArea = All;
                Caption = 'Print Sales Invoice new_ Copy';
                Ellipsis = true;
                Image = Print;
                Promoted = true;
                PromotedCategory = Process;

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
                Caption = 'Post Export Commercial Invoice';
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    SalesInvHeader.Reset;
                    SalesInvHeader.SetRange("No.", Rec."No.");
                    Report.RunModal(Report::"Post Export Commercial Invoice", true, true, SalesInvHeader);
                end;
            }
            action(TestQuery)
            {
                ApplicationArea = All;
                Caption = 'Test Query';
                Promoted = true;
                RunObject = query SalesInvoiceReportTest;

                trigger OnAction()
                var
                begin
                end;
            }
        // action("Export Sales Invoice")
        // {
        //     ApplicationArea = All;
        //     Image = "Report";
        //     Promoted = true;
        //     PromotedIsBig = true;
        //     trigger OnAction()
        //     var
        //         //PostExportCommercialInvoice: Report "Post Export Commercial Invoice";
        //         SalesHeader: Record "Sales Invoice Header";
        //     begin
        //         SalesHeader.Reset;
        //         SalesHeader.SetRange("No.", Rec."No.");
        //         if SalesHeader.FindFirst then begin
        //             //SSDU PostExportCommercialInvoice.SetTableview(SalesHeader);
        //             //SSDU PostExportCommercialInvoice.Run;
        //         end;
        //     end;
        // }
        }
    }
    var SalesInvHeader: Record "Sales Invoice Header";
}
