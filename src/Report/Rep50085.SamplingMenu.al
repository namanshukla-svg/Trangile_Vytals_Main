Report 50085 "Sampling Menu"
{
    ProcessingOnly = true;
    ShowPrintStatus = false;
    //UsageCategory = Lists;
    UseRequestPage = false;
    ApplicationArea = all;
    RDLCLayout = './Layouts/SamplingMenu.rdl';
    UsageCategory = ReportsAndAnalysis;

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
        SamplingHeader.Reset;
        SamplingHeader.FilterGroup(2);
        SamplingHeader.SetCurrentkey("Template Type");
        SamplingHeader.SetRange("Template Type", nOption - 1);
        SamplingHeader.FilterGroup(0);
        Clear(SamplingCardForm);
        SamplingCardForm.SetTableview(SamplingHeader);
        SamplingCardForm.RunModal;
    end;
    var nOption: Integer;
    SamplingCardForm: Page "Sampling Template List";
    SamplingHeader: Record "SSD Sampling Temp. Header";
    Text001: label 'Receipt,Manufacturing';
}
