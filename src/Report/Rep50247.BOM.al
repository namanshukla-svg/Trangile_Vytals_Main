Report 50247 BOM
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/BOM.rdl';
    UsageCategory = ReportsandAnalysis;
    ApplicationArea = all;

    dataset
    {
        dataitem(Item; Item)
        {
            DataItemTableView = sorting("No.")order(ascending)where("Production BOM No."=filter(<>''));

            column(ReportForNavId_1000000000;1000000000)
            {
            }
            trigger OnAfterGetRecord()
            begin
                WhereUsedLine.Reset;
                WhereUsedLine.SetRange(WhereUsedLine."Item No.", Item."No.");
                if WhereUsedLine.FindFirst then WhereUsedLine."Item No.":=Item."No.";
                WhereUsedLine.Description:=Item.Description;
                WhereUsedLine.Insert;
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
    var WhereuedProdBOM: Code[30];
    WhereUsedLine: Record "Where-Used Line";
}
