Report 50082 "Vendor Eval. Creation"
{
    Caption = 'Vendor Eval. Creation';
    ProcessingOnly = true;
    ApplicationArea = All;

    dataset
    {
        dataitem(LinDiario; "SSD Vendor Eval. Journal")
        {
            RequestFilterHeading = 'Vendor Eval. Journal';

            column(ReportForNavId_6736;6736)
            {
            }
            trigger OnAfterGetRecord()
            begin
                Window.Update;
                LinDiario.CalcFields(LinDiario."Eval. Template Status");
                if LinDiario."Eval. Template Status" <> LinDiario."eval. template status"::Certified then CurrReport.Skip;
                if CreaEvalProv.Run(LinDiario)then nRegistrosOk:=nRegistrosOk + 1;
            end;
            trigger OnPreDataItem()
            begin
                Window.Open(txt00001, LinDiario."Entry No.");
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
    var CreaEvalProv: Codeunit "Vendor Eval. -Post Line";
    Window: Dialog;
    txt00001: label 'Procesando #1##########';
    nRegistrosOk: Integer;
}
