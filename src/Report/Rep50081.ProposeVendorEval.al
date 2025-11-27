Report 50081 "Propose Vendor Eval."
{
    Caption = 'Propose Vendor Eval.';
    ProcessingOnly = true;
    UsageCategory = ReportsandAnalysis;
    ApplicationArea = all;

    dataset
    {
        dataitem(Vendor; Vendor)
        {
            RequestFilterFields = "No.", Blocked, "Vendor Posting Group";

            column(ReportForNavId_3182;3182)
            {
            }
            trigger OnAfterGetRecord()
            begin
                Window.Update;
                if OnlyNew then begin
                    rDiarioTest.SetRange(rDiarioTest."Vendor No.", Vendor."No.");
                    if rDiarioTest.Find('-')then CurrReport.Skip;
                end;
                NextEntryNo:=NextEntryNo + 1000;
                rDiario.Init;
                rDiario."Entry No.":=NextEntryNo;
                rDiario.Validate(rDiario."Vendor No.", Vendor."No.");
                rDiario.Insert;
            end;
            trigger OnPreDataItem()
            begin
                rDiario.Reset;
                if rDiario.Find('+')then NextEntryNo:=rDiario."Entry No.";
                Window.Open(Txt00001, Vendor."No.");
                rDiarioTest.Reset;
                rDiarioTest.SetCurrentkey(rDiarioTest."Vendor No.");
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
    var rDiario: Record "SSD Vendor Eval. Journal";
    rDiarioTest: Record "SSD Vendor Eval. Journal";
    NextEntryNo: Integer;
    Window: Dialog;
    Txt00001: label 'Procesando #1#############';
    OnlyNew: Boolean;
}
