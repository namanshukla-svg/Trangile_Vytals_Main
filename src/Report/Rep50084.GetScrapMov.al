Report 50084 "Get Scrap Mov."
{
    Caption = 'Get Scrap Mov.';
    ProcessingOnly = true;
    ApplicationArea = All;

    dataset
    {
        dataitem(MovProd; "Item Ledger Entry")
        {
            DataItemTableView = sorting(Open, Positive, "Location Code", "Source No.")order(ascending)where(Open=const(true), Positive=const(true));
            RequestFilterFields = "Item No.", "Variant Code", "Location Code", "Posting Date", "Source Type", "Source No.";

            column(ReportForNavId_4336;4336)
            {
            }
            trigger OnAfterGetRecord()
            begin
                QualityReturnMan.InsertJournalReturnsEntry(MovProd);
            end;
            trigger OnPreDataItem()
            begin
                SetUp.Get(UserMgt.GetRespCenterFilter);
                FilterGroup(2);
                SetFilter("Location Code", '%1', SetUp."Return Location Code");
                FilterGroup(0);
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
    var QualityReturnMan: Codeunit "Quality Return Management";
    SetUp: Record "SSD Quality Setup";
    UserMgt: Codeunit "SSD User Setup Management";
}
