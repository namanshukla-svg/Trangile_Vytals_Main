Report 50110 "Sales Line Modification"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Sales Line Modification.rdl';
    UsageCategory = ReportsandAnalysis;
    ApplicationArea = all;

    dataset
    {
        dataitem("Integer"; "Integer")
        {
            DataItemTableView = sorting(Number)where(Number=const(1));

            column(ReportForNavId_5444;5444)
            {
            }
            trigger OnAfterGetRecord()
            begin
                n:=0;
                SalesLine.Reset;
                SalesLine.SetCurrentkey("Document Type", Type, "No.", "Variant Code", "Drop Shipment", "Location Code", "Shipment Date", "Document Subtype");
                SalesLine.SetRange(SalesLine."Document Type", SalesLine."document type"::Order);
                SalesLine.SetRange(SalesLine."Document Type", SalesLine."document type"::Order);
                if SalesLine.FindFirst then begin
                    k:=SalesLine.Count;
                    dlg.Open('@@@@@@@@@@@@@@@@@@@@@@@1');
                    repeat SalesLine."Outstanding Qty. (Base)":=SalesLine."Outstanding Quantity";
                        SalesLine.Modify;
                        n+=1;
                        m:=(n * 100) / k;
                        m:=ROUND(m, 1, '>');
                        dlg.Update(1, m);
                    until SalesLine.Next = 0;
                end;
                dlg.Close;
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
    var SalesLine: Record "Sales Line";
    k: Decimal;
    dlg: Dialog;
    m: Decimal;
    n: Decimal;
}
