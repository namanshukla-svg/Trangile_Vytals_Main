Report 50274 IssueSlip
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/IssueSlip.rdl';
    UsageCategory = ReportsandAnalysis;
    ApplicationArea = all;

    dataset
    {
        dataitem("Requisition Line"; "Requisition Line")
        {
            RequestFilterFields = "Indent No.";

            column(ReportForNavId_1170000000;1170000000)
            {
            }
            column(ItemNo; "Requisition Line"."No.")
            {
            }
            column(Qty; "Requisition Line".Quantity)
            {
            }
            column(LocCode; "Requisition Line"."Location Code")
            {
            }
            column(UOM; "Requisition Line"."Unit of Measure Code")
            {
            }
            column(Comp_Name; CompanyInformation.Name)
            {
            }
            column(Comp_Address; CompanyInformation.Address)
            {
            }
            column(Comp_City; CompanyInformation.City)
            {
            }
            column(IndentNo; "Requisition Line"."Indent No.")
            {
            }
            column(SINo; SINo)
            {
            }
            column(ItemName; Item.Description)
            {
            }
            column(OrderDate; "Requisition Line"."Order Date")
            {
            }
            column(Remarks; "Requisition Line".Remarks)
            {
            }
            trigger OnAfterGetRecord()
            begin
                SINo+=1;
                CompanyInformation.Get();
                if Item.Get("Requisition Line"."No.")then;
            end;
            trigger OnPreDataItem()
            begin
                SINo:=0;
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
    var CompanyInformation: Record "Company Information";
    Item: Record Item;
    SINo: Integer;
}
