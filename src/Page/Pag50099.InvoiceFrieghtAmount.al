Page 50099 "Invoice Frieght Amount"
{
    ApplicationArea = All;
    PageType = List;
    Permissions = TableData "Sales Invoice Header"=rm;
    SourceTable = "SSD Invoice Frieght Amount";
    SourceTableView = sorting("Invoice No.")order(ascending)where("Freight Amount Volume Mark"=filter(false));
    UsageCategory = Tasks;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Invoice No."; Rec."Invoice No.")
                {
                    ApplicationArea = All;
                }
                field("Frieght Amount"; Rec."Frieght Amount")
                {
                    ApplicationArea = All;
                    Caption = 'Freight Amount';
                }
                field("Calculated Freight Amount"; Rec."Calculated Freight Amount")
                {
                    ApplicationArea = All;
                }
                field("Freight Amount Volume Mark"; Rec."Freight Amount Volume Mark")
                {
                    ApplicationArea = All;
                }
                field(Validate; Rec.Validate)
                {
                    ApplicationArea = All;
                }
            }
        }
    }
    actions
    {
    }
    trigger OnOpenPage()
    begin
        SalesInvoiceHeader.Reset;
        SalesInvoiceHeader.Reset;
        SalesInvoiceHeader.SetCurrentkey("Posting Date");
        SalesInvoiceHeader.SetFilter("Posting Date", '>=%1', 20150601D);
        SalesInvoiceHeader.SetRange("Freight Amount Volume Mark", false);
        if SalesInvoiceHeader.FindSet then repeat if not Rec.Get(SalesInvoiceHeader."No.")then begin
                    Rec."Invoice No.":=SalesInvoiceHeader."No.";
                    Rec."Frieght Amount":=SalesInvoiceHeader."Freight Amount";
                    Rec."Calculated Freight Amount":=SalesInvoiceHeader."Calculated Freight Amount";
                    Rec."Freight Amount Volume Mark":=false;
                    Rec.Validate:=false;
                    Rec.Insert;
                end;
            until SalesInvoiceHeader.Next = 0;
    end;
    var SalesInvoiceHeader: Record "Sales Invoice Header";
    SalesInvoiceHeader1: Record "Sales Invoice Header";
}
