Report 50270 "Remove Reservation Dispatch"
{
    ProcessingOnly = true;
    ApplicationArea = All;

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
                ReservationEntry.SetRange("Source ID", ResSourceID);
                if ReservationEntry.FindFirst then begin
                    ReservationEntry.Delete;
                    Message('Done');
                end
                else
                    Message('Item tracking Does not exist. Source ID %1', ResSourceID);
            end;
            trigger OnPreDataItem()
            begin
                if ResSourceID = '' then Error('Please insert Invoice No.');
            end;
        }
    }
    requestpage
    {
        layout
        {
            area(content)
            {
                field("Invoice No."; ResSourceID)
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
    ResSourceID: Code[20];
}
