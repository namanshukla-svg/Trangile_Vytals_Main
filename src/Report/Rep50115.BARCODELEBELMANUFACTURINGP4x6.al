Report 50115 BARCODELEBELMANUFACTURINGP4x6
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/BARCODELEBELMANUFACTURINGP4x6.rdl';
    PreviewMode = PrintLayout;
    UsageCategory = ReportsandAnalysis;
    ApplicationArea = all;
    UseSystemPrinter = false;

    dataset
    {
        dataitem("Item Ledger Entry"; "Item Ledger Entry")
        {
            DataItemTableView = sorting("Document No.", "Posting Date", "Item No.")where("Entry Type"=const(Output));
            RequestFilterFields = "Document No.", "Posting Date", "Item No.";

            column(ReportForNavId_7209;7209)
            {
            }
            column(Item_Ledger_Entry_Entry_No_; "Entry No.")
            {
            }
            column(QRCode; QRCodeStr.QRCode)
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
                column(MFG__DATE_____________________FORMAT__Item_Ledger_Entry___Posting_Date__;'MFG. DATE                   ' + Format("Item Ledger Entry"."Posting Date"))
                {
                }
                column(NET_WT__GR__WT____________FORMAT_WT______FORMAT_GWT____KGS_;'NET WT./GR. WT.         ' + Format(WT) + '/' + Format(GWT) + ' KGS')
                {
                }
                column(CompanyInfo__New_Logo2_; CompanyInfo."New Logo2")
                {
                }
                column(V12112321_____;'*' + '12112321' + '*')
                {
                }
                column(LOT_NO___________________________FORMAT__Item_Ledger_Entry___Lot_No___;'LOT NO.                        ' + Format("Item Ledger Entry"."Lot No."))
                {
                }
                column(BEST_USED_BEFORE___FORMAT__Item_Ledger_Entry___Expiration_Date__;'BEST USED BEFORE ' + Format("Item Ledger Entry"."Expiration Date"))
                {
                }
                column(ITEM_CODE_;'ITEM CODE')
                {
                }
                column(Item_Ledger; "Item Ledger Entry"."Item No." + ' - ' + Item1.Description + ' ' + Item1."Description 2")
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
                    QRCodeMgt.BarcodeForReservationEntry("Item Ledger Entry"."Document No.", "Item Ledger Entry"."Lot No.", "Item Ledger Entry"."Item No.", "Item Ledger Entry"."Location Code", "Barcode Labelpp".Quantity);
                    if QRCodeStr.FindFirst then;
                    QRCodeStr.CalcFields(QRCode);
                    Item1.Reset;
                    if Item1.Get("Item Ledger Entry"."Item No.")then;
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
    QRCodeStr: Record "SSD QR Code Str";
    QRCodeMgt: Codeunit "QR Code Mgt.";
}
