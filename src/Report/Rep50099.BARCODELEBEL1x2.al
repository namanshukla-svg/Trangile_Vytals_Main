Report 50099 "BARCODE LEBEL... 1x2"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/BARCODE LEBEL... 1x2.rdl';
    UsageCategory = ReportsandAnalysis;
    ApplicationArea = all;

    dataset
    {
        dataitem("Reservation Entry"; "Reservation Entry")
        {
            DataItemTableView = sorting("Source ID", "Source Ref. No.", "Source Type", "Source Subtype", "Source Batch Name", "Source Prod. Order Line", "Reservation Status", "Shipment Date", "Expected Receipt Date");
            RequestFilterFields = "Item No.", "Source ID";

            column(ReportForNavId_1000000015;1000000015)
            {
            }
            column(Reservation_Entry_Entry_No_; "Entry No.")
            {
            }
            column(Reservation_Entry_Positive; Positive)
            {
            }
            dataitem("Barcode Labelpp"; "SSD Barcode Labelpp")
            {
                DataItemTableView = sorting(SrNo);

                column(ReportForNavId_1000000012;1000000012)
                {
                }
                column(Item1_Description_____Item1__Description_2_; Item1.Description + ' ' + Item1."Description 2")
                {
                }
                column(Lot_No_________FORMAT__Reservation_Entry___Lot_No___;'Lot No       ' + Format("Reservation Entry"."Lot No."))
                {
                }
                column(DOM____________FORMAT__Reservation_Entry___Creation_Date__;'DOM          ' + Format("Reservation Entry"."Creation Date"))
                {
                }
                column(Item_Code_____Reservation_Entry___Item_No__;'Item Code ' + "Reservation Entry"."Item No.")
                {
                }
                column(Quantity______FORMAT_Qty_________Item1__Base_Unit_of_Measure_;'Quantity    ' + Format(Qty) + ' /  ' + Item1."Base Unit of Measure")
                {
                }
                column(Item1_Description_____Item1__Description_2__Control1000000000; Item1.Description + ' ' + Item1."Description 2")
                {
                }
                column(Item_Code_____Reservation_Entry___Item_No___Control1000000001;'Item Code ' + "Reservation Entry"."Item No.")
                {
                }
                column(Quantity______FORMAT_Qty_________Item1__Base_Unit_of_Measure__Control1000000002;'Quantity    ' + Format(Qty) + ' /  ' + Item1."Base Unit of Measure")
                {
                }
                column(Lot_No_________FORMAT__Reservation_Entry___Lot_No____Control1000000003;'Lot No       ' + Format("Reservation Entry"."Lot No."))
                {
                }
                column(DOM____________FORMAT__Reservation_Entry___Creation_Date___Control1000000004;'DOM          ' + Format("Reservation Entry"."Creation Date"))
                {
                }
                column(Barcode_Labelpp_SrNo; SrNo)
                {
                }
                column(LotNo;'Lot No ' + Format("Reservation Entry"."Lot No."))
                {
                }
                trigger OnAfterGetRecord()
                begin
                    Item1.Reset;
                    if Item1.Get("Reservation Entry"."Item No.")then;
                    Qty:="Barcode Labelpp".Quantity;
                    WT:="Barcode Labelpp"."Net Weight";
                    GWT:="Barcode Labelpp"."Gross Weight";
                end;
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
    var CompanyInfo: Record "Company Information";
    Qty: Decimal;
    Item1: Record Item;
    WT: Decimal;
    GWT: Decimal;
    UOM: Code[20];
}
