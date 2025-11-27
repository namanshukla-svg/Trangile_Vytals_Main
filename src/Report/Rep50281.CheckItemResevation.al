Report 50281 "Check Item Resevation"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Check Item Resevation.rdl';
    UsageCategory = ReportsandAnalysis;
    ApplicationArea = all;

    dataset
    {
        dataitem(Item; Item)
        {
            DataItemTableView = sorting("No.")order(ascending);

            column(ReportForNavId_1000000000;1000000000)
            {
            }
            dataitem("Reservation Entry"; "Reservation Entry")
            {
                DataItemLink = "Item No."=field("No.");

                column(ReportForNavId_1000000001;1000000001)
                {
                }
                column(CreationDate_ReservationEntry; "Reservation Entry"."Creation Date")
                {
                }
                column(QuantityBase_ReservationEntry; "Reservation Entry"."Quantity (Base)")
                {
                }
                column(ReservationStatus_ReservationEntry; "Reservation Entry"."Reservation Status")
                {
                }
                column(Description_ReservationEntry; "Reservation Entry".Description)
                {
                }
                column(ItemNo_ReservationEntry; "Reservation Entry"."Item No.")
                {
                }
                column(LocationCode_ReservationEntry; "Reservation Entry"."Location Code")
                {
                }
            }
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
