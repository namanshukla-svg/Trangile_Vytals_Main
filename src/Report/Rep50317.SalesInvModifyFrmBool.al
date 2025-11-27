Report 50317 SalesInvModifyFrmBool
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/SalesInvModifyFrmBool.rdl';
    Permissions = TableData "Sales Invoice Header"=rm;
    UsageCategory = ReportsandAnalysis;
    ApplicationArea = all;

    dataset
    {
        dataitem(ModifySalesInvFrm; "SSD ModifySalesInvFrm")
        {
            column(ReportForNavId_1170000000;1170000000)
            {
            }
            trigger OnAfterGetRecord()
            var
                SalesInvHead: Record "Sales Invoice Header";
            begin
                if SalesInvHead.Get("Sales Inv. No.")then if ModifySalesInvFrm.Firm then begin
                        SalesInvHead."Firm Freight":=true;
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
