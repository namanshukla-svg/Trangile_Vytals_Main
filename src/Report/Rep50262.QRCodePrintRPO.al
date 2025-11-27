Report 50262 "QR Code Print RPO"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/QR Code Print RPO.rdl';
    UsageCategory = ReportsandAnalysis;
    ApplicationArea = all;

    dataset
    {
        dataitem("Integer"; "Integer")
        {
            column(ReportForNavId_33027920;33027920)
            {
            }
            column(QRCode; QRCodeStr.QRCode)
            {
            }
            column(MRNNo; QRCodeStr."Document No.")
            {
            }
            column(Qty; QRCodeStr."Qty.")
            {
            }
            column(ItemNo; QRCodeStr."Item No.")
            {
            }
            column(BarcodeNo; QRCodeStr."QR Code No.")
            {
            }
            column(LOT; QRCodeStr."Lot No.")
            {
            }
            column(ExpDate; QRCodeStr."Expiration Date")
            {
            }
            trigger OnAfterGetRecord()
            begin
                if Number > 1 then QRCodeStr.Next
                else
                    QRCodeStr.FindFirst;
                QRCodeStr.CalcFields(QRCode);
            end;
            trigger OnPreDataItem()
            begin
                QRCodeStr.Reset;
                SetRange(Number, 1, QRCodeStr.Count);
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
    ItemNo_Lbl='Item No.';
    PartNo_Lbl='Part No.';
    SrNo_Lbl='Sr. No.';
    }
    var QRCodeStr: Record "SSD QR Code Str" temporary;
    procedure TransfterDate(var QCRec_vRec: Record "SSD QR Code Str" temporary)
    begin
        QRCodeStr.Copy(QCRec_vRec, true);
    end;
}
