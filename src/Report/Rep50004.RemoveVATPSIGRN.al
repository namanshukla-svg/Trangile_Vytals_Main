report 50004 "Remove VAT PSI/GRN"
{
    ApplicationArea = All;
    Caption = 'Remove VAT PSI/GRN';
    UsageCategory = ReportsAndAnalysis;
    ProcessingOnly = true;
    UseRequestPage = true;
    Permissions = tabledata "Sales Invoice Header"=m,
        tabledata "Sales Invoice Line"=m,
        tabledata "Purch. Rcpt. Header"=m,
        tabledata "Purch. Rcpt. Line"=m;

    dataset
    {
        dataitem("Sales Invoice Header"; "Sales Invoice Header")
        {
            RequestFilterFields = "No.";

            trigger OnAfterGetRecord()
            var
                SalesInvHeader: Record "Sales Invoice Header";
                SalesInvLine: Record "Sales Invoice Line";
            begin
                if "Sales Invoice Header".GetFilter("No.") <> '' then SalesInvHeader.SetRange("No.", "Sales Invoice Header".GetFilter("No."));
                SalesInvHeader.SetRange("Posting Date", StartDate, EndDate);
                if SalesInvHeader.FindSet()then repeat SalesInvHeader."VAT Bus. Posting Group":='';
                        SalesInvHeader.Modify();
                    until SalesInvHeader.Next() = 0;
                if "Sales Invoice Header".GetFilter("No.") <> '' then SalesInvLine.SetRange("Document No.", "Sales Invoice Header".GetFilter("No."));
                SalesInvLine.SetRange("Posting Date", StartDate, EndDate);
                if SalesInvLine.FindSet()then repeat SalesInvLine."VAT Bus. Posting Group":='';
                        SalesInvLine."VAT Prod. Posting Group":='';
                        SalesInvLine.Modify();
                    until SalesInvLine.Next() = 0;
            end;
        }
        dataitem("Purch. Rcpt. Header"; "Purch. Rcpt. Header")
        {
            RequestFilterFields = "No.";

            trigger OnAfterGetRecord()
            var
                PurchRcptHeader: Record "Purch. Rcpt. Header";
                PurchRcptLine: Record "Purch. Rcpt. Line";
            begin
                if "Purch. Rcpt. Header".GetFilter("No.") <> '' then PurchRcptHeader.SetRange("No.", "Purch. Rcpt. Header".GetFilter("No."));
                PurchRcptHeader.SetRange("Posting Date", StartDate, EndDate);
                if PurchRcptHeader.FindSet()then repeat PurchRcptHeader."VAT Bus. Posting Group":='';
                        PurchRcptHeader.Modify();
                    until PurchRcptHeader.Next() = 0;
                if "Purch. Rcpt. Header".GetFilter("No.") <> '' then PurchRcptLine.SetRange("Document No.", "Purch. Rcpt. Header".GetFilter("No."));
                PurchRcptLine.SetRange("Posting Date", StartDate, EndDate);
                if PurchRcptLine.FindSet()then repeat PurchRcptLine."VAT Bus. Posting Group":='';
                        PurchRcptLine."VAT Prod. Posting Group":='';
                        PurchRcptLine.Modify();
                    until PurchRcptLine.Next() = 0;
            end;
        }
        dataitem("Purchase Header"; "Purchase Header")
        {
            RequestFilterFields = "No.";

            trigger OnAfterGetRecord()
            var
                PurchaseHeader: Record "Purchase Header";
                PurchaseLine: Record "Purchase Line";
            begin
                if "Purchase Header".GetFilter("No.") <> '' then PurchaseHeader.SetRange("No.", "Purchase Header".GetFilter("No."));
                PurchaseHeader.SetRange("Posting Date", StartDate, EndDate);
                if PurchaseHeader.FindSet()then repeat PurchaseHeader."VAT Bus. Posting Group":='';
                        PurchaseHeader.Modify();
                        PurchaseLine.SetRange("Document No.", PurchaseHeader."No.");
                        if PurchaseLine.FindSet()then repeat PurchaseLine."VAT Bus. Posting Group":='';
                                PurchaseLine."VAT Prod. Posting Group":='';
                                PurchaseLine.Modify();
                            until PurchaseLine.Next() = 0;
                    until PurchaseHeader.Next() = 0;
            end;
        }
        dataitem("Sales Header"; "Sales Header")
        {
            RequestFilterFields = "No.";

            trigger OnAfterGetRecord()
            var
                SalesHeader: Record "Sales Header";
                SalesLine: Record "Sales Line";
            begin
                if "Sales Header".GetFilter("No.") <> '' then SalesHeader.SetRange("No.", "Sales Header".GetFilter("No."));
                SalesHeader.SetRange("Posting Date", StartDate, EndDate);
                if SalesHeader.FindSet()then repeat SalesHeader."VAT Bus. Posting Group":='';
                        SalesHeader.Modify();
                        SalesLine.SetRange("Document No.", SalesHeader."No.");
                        if SalesLine.FindSet()then repeat SalesLine."VAT Bus. Posting Group":='';
                                SalesLine."VAT Prod. Posting Group":='';
                                SalesLine.Modify();
                            until SalesLine.Next() = 0;
                    until SalesHeader.Next() = 0;
            end;
        }
    }
    requestpage
    {
        layout
        {
            area(content)
            {
                group("Date Filter")
                {
                    field(StartDate; StartDate)
                    {
                        ApplicationArea = all;
                    }
                    field(EndDate; EndDate)
                    {
                        ApplicationArea = all;
                    }
                }
            }
        }
        actions
        {
            area(processing)
            {
            }
        }
    }
    var StartDate: Date;
    EndDate: Date;
}
