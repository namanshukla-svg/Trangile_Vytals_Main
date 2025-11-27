Report 50086 "Quality Menu"
{
    ProcessingOnly = true;
    ShowPrintStatus = false;
    UseRequestPage = false;
    ApplicationArea = All;

    dataset
    {
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
    trigger OnPostReport()
    begin
        nOption:=StrMenu(Text001);
        if nOption = 0 then exit;
        SamplingDocHeader.Reset;
        SamplingDocHeader.FilterGroup(2);
        SamplingDocHeader.SetCurrentkey("Template Type");
        SamplingDocHeader.SetRange("Template Type", nOption - 1);
        SamplingDocHeader.SetFilter("Entry Source Type", '<>%1', SamplingDocHeader."entry source type"::Routing);
        SamplingDocHeader.FilterGroup(0);
        case nOption - 1 of SamplingDocHeader."template type"::Receipt: begin
            Clear(QualityOrderCard);
            QualityOrderCard.SetTableview(SamplingDocHeader);
            QualityOrderCard.RunModal;
        end;
        SamplingDocHeader."template type"::Manufacturing: begin
            Clear(ManQOrderCard);
            ManQOrderCard.SetTableview(SamplingDocHeader);
            ManQOrderCard.RunModal;
        end;
        end;
    end;
    var nOption: Integer;
    QualityOrderCard: Page "Rcpt. Quality Order Card";
    SamplingDocHeader: Record "SSD Quality Order Header";
    Text001: label 'Receipt,Manufacturing';
    ManQOrderCard: Page "Man. Quality Order Card";
}
