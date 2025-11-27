Report 50335 "BARCODE LEB. MANUFACTURING4x6N"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/BARCODE LEB. MANUFACTURING4x6N.rdl';
    PreviewMode = PrintLayout;
    UseSystemPrinter = false;
    UsageCategory = ReportsandAnalysis;
    ApplicationArea = all;

    dataset
    {
        dataitem("Reservation Entry"; "Reservation Entry")
        {
            DataItemTableView = sorting("Source ID", "Source Ref. No.", "Source Type", "Source Subtype", "Source Batch Name", "Source Prod. Order Line", "Reservation Status", "Shipment Date", "Expected Receipt Date");
            RequestFilterFields = "Source ID", "Item No.";

            column(ReportForNavId_4003;4003)
            {
            }
            column(QRCode; QRCodeStr.QRCode)
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

                column(ReportForNavId_2279;2279)
                {
                }
                column(CompanyInfo_Name; CompanyInfo.Name)
                {
                }
                column(PRODUCT_FOR_INDUSTRIAL_USE_ONLY_;'PRODUCT FOR INDUSTRIAL USE ONLY')
                {
                }
                column(Visit_us_at_www_zavenir_com_;'Visit us at www.zavenir.com')
                {
                }
                column(V000000000000000000_____;'*' + '000000000000000000' + '*')
                {
                }
                column(Consult_product_MSDS_for_safety_guidelines__;'Consult product MSDS for safety guidelines.')
                {
                }
                column(QUANTITY______________________FORMAT_Qty_______Item1__Base_Unit_of_Measure_;'QUANTITY                    ' + Format(Qty) + '  ' + Item1."Base Unit of Measure")
                {
                }
                column(MFG__DATE_____________________FORMAT__Reservation_Entry___Creation_Date__;'MFG. DATE                   ' + Format("Reservation Entry"."Creation Date"))
                {
                }
                column(NET_WT__GR__WT____________FORMAT_WT______FORMAT_GWT____KGS_;'NET WT./GR. WT.         ' + Format(WT) + '/' + Format(GWT) + ' KGS')
                {
                }
                column(V12112321_____;'*' + '12112321' + '*')
                {
                }
                column(Reservation_Entry; "Reservation Entry"."Item No." + ' - ' + Item1.Description + ' ' + Item1."Description 2")
                {
                }
                column(LOT_NO___________________________FORMAT__Reservation_Entry___Lot_No___;'LOT NO.                        ' + Format("Reservation Entry"."Lot No."))
                {
                }
                column(BEST_USED_BEFORE___FORMAT_ExpDate_;'BEST USED BEFORE ' + Format(ExpDate))
                {
                }
                column(ITEM_CODE_;'ITEM CODE')
                {
                }
                column(CompanyInfo_Picture; CompanyInfo.Picture)
                {
                }
                column(Barcode_Labelpp_SrNo; SrNo)
                {
                }
                trigger OnAfterGetRecord()
                begin
                    Clear(QRCodeMgt);
                    Clear(QRCodeStr);
                    QRCodeMgt.BarcodeForReservationEntry("Reservation Entry"."Source ID", "Reservation Entry"."Lot No.", "Reservation Entry"."Item No.", "Reservation Entry"."Location Code", "Barcode Labelpp".Quantity);
                    if QRCodeStr.FindFirst then;
                    QRCodeStr.CalcFields(QRCode);
                    Item1.Reset;
                    Qty:="Barcode Labelpp".Quantity;
                    WT:="Barcode Labelpp"."Net Weight";
                    GWT:="Barcode Labelpp"."Gross Weight";
                    if Item1.Get("Reservation Entry"."Item No.")then;
                end;
            }
            trigger OnAfterGetRecord()
            begin
                Item1.Reset;
                if Item1.Get("Reservation Entry"."Item No.")then ExpDate:=CalcDate(Item1."Expiration Calculation", "Reservation Entry"."Creation Date");
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
    trigger OnPreReport()
    begin
        CompanyInfo.Get;
        CompanyInfo.CalcFields(CompanyInfo.Picture, CompanyInfo."New Logo1", CompanyInfo."New Logo2");
    end;
    var CompanyInfo: Record "Company Information";
    Qty: Decimal;
    Item1: Record Item;
    WT: Decimal;
    GWT: Decimal;
    UOM: Code[20];
    ExpDate: Date;
    QRCodeMgt: Codeunit "QR Code Mgt.";
    QRCodeStr: Record "SSD QR Code Str";
}
