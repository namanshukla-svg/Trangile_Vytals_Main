Report 50186 "Update Qlt Order Parameter"
{
    ProcessingOnly = true;
    ApplicationArea = all;
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem(SSDPostedQualityOrderLine; "SSD Posted Quality Order Line")
        {
            DataItemTableView = sorting("Document No.", "Line No.");
            RequestFilterFields = "Document No.";

            column(ReportForNavId_7730;7730)
            {
            }
            trigger OnAfterGetRecord()
            begin
                SSDPostedQualityOrderLine."Value to be Print":=true;
                Modify;
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
