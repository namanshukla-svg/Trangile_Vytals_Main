Report 50116 "Multiple Lot No error"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Multiple Lot No error.rdl';
    Permissions = TableData "Item Ledger Entry"=rimd;
    ProcessingOnly = false;
    UsageCategory = ReportsandAnalysis;
    ApplicationArea = all;

    dataset
    {
        dataitem("Item Ledger Entry"; "Item Ledger Entry")
        {
            RequestFilterFields = "Lot No.";

            column(ReportForNavId_7209;7209)
            {
            }
            trigger OnAfterGetRecord()
            begin
                k+=1;
                if k > 1 then begin
                    if ExpDt = 0D then ExpDt:=Today + 30;
                    "Item Ledger Entry"."Expiration Date":=ExpDt;
                    ExpDt:="Item Ledger Entry"."Expiration Date";
                    "Item Ledger Entry".Modify;
                end
                else
                begin
                    ExpDt:="Item Ledger Entry"."Expiration Date";
                    if "Item Ledger Entry"."Expiration Date" = 0D then begin
                        "Item Ledger Entry"."Expiration Date":=Today + 30;
                        "Item Ledger Entry".Modify;
                    end;
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
    trigger OnInitReport()
    begin
        k:=0;
    end;
    var k: Integer;
    ExpDt: Date;
}
