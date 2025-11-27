Report 50269 "Remove Reservation Entry"
{
    ProcessingOnly = true;
    ApplicationArea = all;
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem("Integer"; "Integer")
        {
            DataItemTableView = sorting(Number);
            MaxIteration = 1;

            column(ReportForNavId_1000000000;1000000000)
            {
            }
            trigger OnAfterGetRecord()
            begin
                ReservationEntry.Reset;
                ReservationEntry.SetRange("Entry No.", ResEntryNo);
                if ReservationEntry.FindFirst then begin
                    ReservationEntry.Delete;
                    Message('Done');
                end
                else
                    Message('Item tracking Does not exist, Entry No. %1', ResEntryNo);
            end;
            trigger OnPreDataItem()
            begin
                if ResEntryNo = 0 then Error('Please insert Entry No.');
            end;
        }
    }
    requestpage
    {
        layout
        {
            area(content)
            {
                field("Entry No"; ResEntryNo)
                {
                    ApplicationArea = All;
                }
            }
        }
        actions
        {
        }
    }
    labels
    {
    }
    var ReservationEntry: Record "Reservation Entry";
    ResEntryNo: Integer;
}
