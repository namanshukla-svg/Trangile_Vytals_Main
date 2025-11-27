Report 50300 ItemSamplingTemplDesc
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/ItemSamplingTemplDesc.rdl';
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
            trigger OnPreDataItem()
            begin
                SamplingTempHeader.Reset;
                if SamplingTempHeader.FindFirst then repeat begin
                        Item.Reset;
                        if Item.Get(SamplingTempHeader."No.")then SamplingTempHeader.Description:=Item.Description;
                        SamplingTempHeader."Description 2":=Item."Description 2";
                        SamplingTempHeader.Modify;
                    end;
                    until SamplingTempHeader.Next = 0;
                SamplingtestLine.Reset;
                if SamplingtestLine.FindFirst then repeat SamplingtestLine.Validate(SamplingtestLine."Meas. Code");
                        SamplingtestLine.Modify;
                    until SamplingtestLine.Next = 0;
                Samplingtempline.Reset;
                if Samplingtempline.FindFirst then repeat Samplingtempline.Validate(Samplingtempline."Meas. Code");
                        Samplingtempline.Modify;
                    until Samplingtempline.Next = 0;
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
    var SamplingTempHeader: Record "SSD Sampling Temp. Header";
    Item: Record Item;
    Samplingtempline: Record "SSD Sampling Temp. Line";
    SamplingtestLine: Record "SSD Sampling Test Line";
}
