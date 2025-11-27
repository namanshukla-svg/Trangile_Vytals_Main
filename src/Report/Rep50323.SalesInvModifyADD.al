Report 50323 SalesInvModifyADD
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/SalesInvModifyADD.rdl';
    Permissions = TableData "Sales Invoice Header"=rm;
    UsageCategory = ReportsandAnalysis;
    ApplicationArea = all;

    dataset
    {
        dataitem(ModifySalesInvADD; "SSD ModifySalesInvADD")
        {
            column(ReportForNavId_1170000000;1170000000)
            {
            }
            trigger OnAfterGetRecord()
            var
                SalesInvHead: Record "Sales Invoice Header";
            begin
                if SalesInvHead.Get(ModifySalesInvADD."Sales Inv. No.")then begin
                    SalesInvHead."Actual Delivery Date":=ModifySalesInvADD."Actual Delivery Date";
                    SalesInvHead.Modify;
                end;
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
}
